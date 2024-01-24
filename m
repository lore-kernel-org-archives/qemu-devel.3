Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADA5C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rScZK-0000Zr-Hm; Wed, 24 Jan 2024 07:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rScZD-0000UG-4H
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:41:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rScZ5-0007Eh-V7
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:41:16 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKk5Y2j2cz6K6F8;
 Wed, 24 Jan 2024 20:38:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 7BCED140390;
 Wed, 24 Jan 2024 20:40:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:40:59 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Huai-Cheng Kuo
 <hchkuo@avery-design.com.tw>, Dave Jiang <dave.jiang@intel.com>, Peter
 Maydell <peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/12 qemu] CXL emulation fixes and minor cleanup.
Date: Wed, 24 Jan 2024 12:40:48 +0000
Message-ID: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

This set includes the majority of fixes I currently have queued
up for the CXL emulation. Most have been posted and reviewed
before so this is just rebases of those.

I've included the _STA fix as that's fairly trivial
and didn't seem worth a separate posting. Also included
dropping some pointless g_malloc0() failure handling that
came up in review of Ira's "cxl/cdat: Handle cdat table build errors".

Note the [... qemu] marking above is because we currently use the
linux-cxl@vger.kernel.org list to ensure CXL people notice the
patches and difficulty of distinguishing QEMU vs Kernel patches
was causing some grief for tracking in patchwork.
Hopefully this is unobtrusive enough to not annoy QEMU reviewers!

Davidlohr Bueso (1):
  hw/cxl/mbox: Remove dead code

Hyeonggon Yoo (1):
  hw/cxl/device: read from register values in mdev_reg_read()

Ira Weiny (2):
  cxl/cdat: Handle cdat table build errors
  cxl/cdat: Fix header sum value in CDAT checksum

Jonathan Cameron (6):
  hw/mem/cxl_type3: Drop handling of failure of g_malloc0()
  hw/pci-bridge/cxl_upstream: Drop g_malloc0() failure handling
  hw/mem/cxl_type3: Fix potential divide by zero reported by coverity
  tests/acpi: Allow update of DSDT.cxl
  hw/i386: Fix _STA return value for ACPI0017
  tests/acpi: Update DSDT.cxl to reflect change _STA return value.

Li Zhijian (2):
  hw/cxl: Pass CXLComponentState to cache_mem_ops
  hw/cxl: Pass NULL for a NULL MemoryRegionOps

 include/hw/cxl/cxl_device.h  |   9 ++++--
 hw/cxl/cxl-cdat.c            |  11 +++++--
 hw/cxl/cxl-component-utils.c |   4 +--
 hw/cxl/cxl-device-utils.c    |  17 ++++++----
 hw/cxl/cxl-mailbox-utils.c   |  43 +++++++++----------------
 hw/i386/acpi-build.c         |   2 +-
 hw/mem/cxl_type3.c           |  60 ++++++++---------------------------
 hw/pci-bridge/cxl_upstream.c |   6 ----
 tests/data/acpi/q35/DSDT.cxl | Bin 9713 -> 9714 bytes
 9 files changed, 57 insertions(+), 95 deletions(-)

-- 
2.39.2


