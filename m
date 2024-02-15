Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9A5C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rae26-0006xY-UY; Thu, 15 Feb 2024 10:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rae24-0006x5-Bk
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:52:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rae21-0007MH-Os
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:52:16 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKGy2B5tz6K8bw;
 Thu, 15 Feb 2024 23:48:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 28CB1140B55;
 Thu, 15 Feb 2024 23:52:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:52:09 +0000
To: <qemu-devel@nongnu.org>, Fan Ni <nifan.cxl@gmail.com>, Michael Tsirkin
 <mst@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH qemu] hw/pci-bridge/pxb-cxl: Drop RAS capability from host
 bridge.
Date: Thu, 15 Feb 2024 15:52:06 +0000
Message-ID: <20240215155206.2736-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This CXL component isn't allowed to have a RAS capability.
Whilst this should be harmless as software is not expected to look
here, good to clean it up.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 I've been carrying this on my tree for quite a while.
 This wasn't in previous fixes set because it's low priority and
 rebasing it across cleanup series that followed those fixes was
 too fiddly to bother.
 
 include/hw/cxl/cxl_component.h      |  1 +
 hw/cxl/cxl-component-utils.c        | 21 +++++++++++++++++----
 hw/pci-bridge/pci_expander_bridge.c |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 0e5d35c263..5012fab6f7 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -25,6 +25,7 @@ enum reg_type {
     CXL2_TYPE3_DEVICE,
     CXL2_LOGICAL_DEVICE,
     CXL2_ROOT_PORT,
+    CXL2_RC,
     CXL2_UPSTREAM_PORT,
     CXL2_DOWNSTREAM_PORT,
     CXL3_SWITCH_MAILBOX_CCI,
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 84ab503325..cd116c0401 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -297,6 +297,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         caps = 3;
         break;
     case CXL2_ROOT_PORT:
+    case CXL2_RC:
         /* + Extended Security, + Snoop */
         caps = 5;
         break;
@@ -326,8 +327,19 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
+    switch (type) {
+    case CXL2_DEVICE:
+    case CXL2_TYPE3_DEVICE:
+    case CXL2_LOGICAL_DEVICE:
+    case CXL2_ROOT_PORT:
+    case CXL2_UPSTREAM_PORT:
+    case CXL2_DOWNSTREAM_PORT:
     init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
-    ras_init_common(reg_state, write_msk);
+        ras_init_common(reg_state, write_msk);
+        break;
+    default:
+        break;
+    }
 
     init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
 
@@ -335,9 +347,10 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         return;
     }
 
-    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
-    hdm_init_common(reg_state, write_msk, type);
-
+    if (type != CXL2_ROOT_PORT) {
+        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
+        hdm_init_common(reg_state, write_msk, type);
+    }
     if (caps < 5) {
         return;
     }
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 535889f7c2..0411ad31ea 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -290,7 +290,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
     uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
     int dsp_count = 0;
 
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
     /*
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
-- 
2.39.2


