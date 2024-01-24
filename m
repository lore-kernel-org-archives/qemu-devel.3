Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D76C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSdc4-000295-Fh; Wed, 24 Jan 2024 08:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSdc2-00028l-Oz
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:48:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSdc0-0004Ae-26
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:48:18 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKlZh1Z4Vz6K7GB;
 Wed, 24 Jan 2024 21:45:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E1FC0140684;
 Wed, 24 Jan 2024 21:48:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:48:12 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and
 reference r3.1
Date: Wed, 24 Jan 2024 13:48:09 +0000
Message-ID: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Last year a reviewer requested that the versioning and references in the CXL
code pointed out at a specific available specification revision (Sorry I can't
remember who!)  That drew my attention to the complete mess of versioning
with many comments not calling out which version of CXL they were refering
to (these date back to when we only cared about CXL r2.0)

Unfortunately without being a CXL consortium member only one version of
the specification is easily obtained (via a click through for 'evaluation'
purposes) from https://www.computeexpresslink.org/download-the-specification .
Whilst I hope that will change, given we need to clean this up anyway
it make sense to standardize on CXL r3.1 which is the currently available
version.  Note that I have no intentioning of doing this again for
CXL rNext when it appears - this is intended to be a onetime thing.

Some structures have been updated between when we introduced the emulation
of a particular feature and today, but this has been done in a backwards
compatible way. So to bring everything up to CXL revision 3.1, I've added
definitions etc for new fields and registers, but set the capability bits
to say we don't support anything they tell us about and write masks should
leave the control bits reserved (e.g. not writeable)

This will result in a small amount of register placement changing but
it's all discoverable and the CXL emulation doesn't currently allow
sensible migration anyway, we shouldn't have any backwards compatibility
problems.

For those kind enough to review, given this involves some tedious spec
diving, feel free to do a subset and state what you covered so that
others can avoid duplication.

Based-on: [PATCH 00/12 qemu] CXL emulation fixes and minor cleanup.

Based-on: Message-ID: 20240124124100.8218-1-Jonathan.Cameron@huawei.com

Jonathan Cameron (5):
  hw/cxl: Update HDM Decoder capability to version 3
  hw/cxl: Update link register definitions.
  hw/cxl: Update RAS Capability Definitions for version 3.
  hw/cxl: Update mailbox status registers.
  hw/cxl: Standardize all references on CXL r3.1 and minor updates

 docs/system/devices/cxl.rst    |  3 +-
 include/hw/cxl/cxl_cdat.h      | 10 ++---
 include/hw/cxl/cxl_component.h | 51 +++++++++++++++-------
 include/hw/cxl/cxl_device.h    | 77 +++++++++++++++++++++++-----------
 include/hw/cxl/cxl_events.h    | 18 ++++----
 include/hw/cxl/cxl_pci.h       | 67 ++++++++++++++++++++---------
 hw/cxl/cxl-component-utils.c   | 29 ++++++++-----
 hw/cxl/cxl-device-utils.c      | 14 +++++--
 hw/cxl/cxl-events.c            |  2 +-
 hw/cxl/cxl-mailbox-utils.c     | 49 ++++++++++++----------
 hw/mem/cxl_type3.c             |  6 +--
 hw/pci-bridge/cxl_downstream.c |  4 +-
 hw/pci-bridge/cxl_root_port.c  |  4 +-
 hw/pci-bridge/cxl_upstream.c   |  4 +-
 14 files changed, 219 insertions(+), 119 deletions(-)

-- 
2.39.2


