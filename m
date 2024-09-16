Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2119CC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFdL-0007Wj-Qp; Mon, 16 Sep 2024 13:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFdJ-0007Vd-8b
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:35:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFdH-0003Mr-7c
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:35:29 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sQQ14Ktz6K9FF;
 Tue, 17 Sep 2024 01:31:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 51BF2140D1A;
 Tue, 17 Sep 2024 01:35:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:35:19 +0200
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
 <fan.ni@samsung.com>
Subject: [PATCH qemu 0/6] hw/cxl: Link speed and width control
Date: Mon, 16 Sep 2024 18:35:12 +0100
Message-ID: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Changes since RFC:
- rebase

Question:
- I could enable this for all PCIe device (including ports).
  Does that makes sense, or is it better to limit this to my cases?
  It is quite easy to build broken setups (downstream device reports
  faster link than the port etc) because QEMU 'link' training' is
  simplistic.  I'm not sure it is worth making it more clever.

The Generic Ports support added the ability to describe the bandwidth and
Latency within a host to a CXL host bridge.  To be able to test the of the
discovery path used by Linux [1] we also need to be able to create
bottlenecks at difference places in the topology. There are two parts to
this
* CXL link characteristics as described by PCI Express Capability Link
  status etc.
* Bandwidth and latency across CXL Switches (via CDAT data from the switch
  USP)
* Bandwidth and latency from the CXL type 3 device port to the actual
  memory (Via CDAT data from the EP).

Currently we have fixed values for the CXL CDAT tables, and to test this
I recommend changing those as per the patch at the end of this cover letter
(so they aren't always the bottleneck). Making those configurable will be
handled in a future patch set.

RFC has a set of examples but those were to help testing the kernel code
rather than providing much info for QEMU review so I haven't repeated
them ehre.

https://lore.kernel.org/qemu-devel/20240712122414.1448284-1-Jonathan.Cameron@huawei.com/

Jonathan Cameron (6):
  hw/pci-bridge/cxl_root_port: Provide x-speed and x-width properties.
  hw/pci-bridge/cxl_upstream: Provide x-speed and x-width properties.
  hw/pcie: Factor out PCI Express link register filling common to EP.
  hw/pcie: Provide a utility function for control of EP / SW USP link
  hw/mem/cxl-type3: Add properties to control link speed and width
  hw/pci-bridge/cxl-upstream: Add properties to control link speed and
    width

 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   4 +
 include/hw/pci/pcie.h                     |   2 +
 hw/mem/cxl_type3.c                        |   6 ++
 hw/pci-bridge/cxl_downstream.c            |  23 +++--
 hw/pci-bridge/cxl_root_port.c             |   5 ++
 hw/pci-bridge/cxl_upstream.c              |   6 ++
 hw/pci/pcie.c                             | 105 ++++++++++++++--------
 8 files changed, 103 insertions(+), 52 deletions(-)

-- 
2.43.0


