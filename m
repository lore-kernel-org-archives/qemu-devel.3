Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ED7E9538F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbkB-0005T1-TM; Wed, 04 Feb 2026 07:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vnbk9-0005SL-Ro
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:12:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vnbk6-00076G-Lk
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:12:25 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5fMp4nfSzHnHM9;
 Wed,  4 Feb 2026 20:11:18 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id EBCE040584;
 Wed,  4 Feb 2026 20:12:19 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 12:12:17 +0000
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
 <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
 <venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v6 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit mode)
Date: Wed, 4 Feb 2026 12:12:08 +0000
Message-ID: <20260204121215.68897-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v6:
- Initialize a variable that causing a false warning with some versions of gcc.
- Rebase.
- Tag from Davidlohr for the ACPI change.

Based on - due to fuzz + context changes.

1. [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
https://lore.kernel.org/qemu-devel/20260119111542.788389-1-Jonathan.Cameron@huawei.com/

2. [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
https://lore.kernel.org/qemu-devel/20250917143330.294698-1-Jonathan.Cameron@huawei.com/

3. [PATCH qemu 0/2] hw/cxl: Two media operations related fixes.
https://lore.kernel.org/qemu-devel/20260102154731.474859-1-Jonathan.Cameron@huawei.com/
(most likely will apply fine with out this one)

v5 changes:
- Rebase much earlier in the CXL queue as Davidlohr had it beind some stuff
  I was carrying that is not ready for upstream just yet.
- Update the CFMWS flags directly as the patch doing restriction control needs
  some more thought.
- Bios tables test data updates.
- Don't provide flit mode control for gen_pcie_root_port as we don't need it
  for the rest of the series which is all about CXL.

The following allows support for component basic back invalidation discovery
and config, by exposing the BI routing table and decoder registers. Instead
of going the type2[0] route, this series proposes adding support for type3
hdm-db, which allows a more direct way of supporting BI in qemu.

As BI is a dependent on the larger flits introduced in PCIe (and CXL 3.0)
add support for enabling that for CXL components. Negotiation is handled
via an equivalent of what we do for link speed.

Davidlohr Bueso (3):
  hw/pcie: Support enabling flit mode
  hw/cxl: Support type3 HDM-DB
  hw/cxl: Remove register special_ops->read()

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

Jonathan Cameron (3):
  tests/bios-tables-test: Excluded CEDT.cxl for BI restriction
    relaxation.
  hw/cxl: Update CXL Fixed Memory Window ACPI description to include
    Back Invalidate support.
  tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS

 docs/system/devices/cxl.rst               |  23 +++
 include/hw/cxl/cxl_component.h            |  87 +++++++--
 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |   2 +-
 include/hw/pci/pcie_port.h                |   1 +
 hw/acpi/cxl.c                             |   2 +-
 hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
 hw/mem/cxl_type3.c                        |  15 +-
 hw/pci-bridge/cxl_downstream.c            |  10 +-
 hw/pci-bridge/cxl_root_port.c             |  11 +-
 hw/pci-bridge/cxl_upstream.c              |  18 +-
 hw/pci-bridge/pci_expander_bridge.c       |   2 +-
 hw/pci/pcie.c                             |  23 ++-
 tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
 15 files changed, 313 insertions(+), 97 deletions(-)

-- 
2.51.0


