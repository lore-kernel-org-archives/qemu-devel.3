Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84354C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkJb-0003iv-8B; Thu, 12 Jun 2025 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkJV-0003f6-7I
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:58:03 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkJS-0003KU-S0
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:58:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ6cC28sTz6M4sT;
 Thu, 12 Jun 2025 23:57:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 475E41402F1;
 Thu, 12 Jun 2025 23:57:57 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 17:57:56 +0200
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <fan.ni@samsung.com>,
 <qemu-devel@nongnu.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Bowman Terry <terry.bowman@amd.com>
CC: <linuxarm@huawei.com>, <rientjes@google.com>, <dave@stgolabs.net>,
 <joshua.hahnjy@gmail.com>, <rkodsara@amd.com>, <sj@kernel.org>,
 <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <ziy@nvidia.com>,
 <weixugc@google.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v2 QEMU 1/4] hw/cxl: Switch to using an array for
 CXLRegisterLocator base addresses.
Date: Thu, 12 Jun 2025 16:57:21 +0100
Message-ID: <20250612155724.1887266-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
References: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

Allows for easier looping over entries when adding CHMU and CPMU instances.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
CHMU RFC v2: New patch to simplify a few code paths.
---
 include/hw/cxl/cxl_pci.h       | 17 ++++++++++-------
 hw/cxl/switch-mailbox-cci.c    |  4 ++--
 hw/mem/cxl_type3.c             | 12 ++++++++----
 hw/pci-bridge/cxl_downstream.c |  4 ++--
 hw/pci-bridge/cxl_root_port.c  |  4 ++--
 hw/pci-bridge/cxl_upstream.c   |  4 ++--
 6 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index d0855ed78b..00a0335d55 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -161,6 +161,12 @@ typedef struct CXLDVSECPortFlexBus {
 } CXLDVSECPortFlexBus;
 QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortFlexBus) != 0x20);
 
+/* Only applies to the type 3 device emulation */
+enum register_locator_indicies {
+    REG_LOC_IDX_COMPONENT,
+    REG_LOC_IDX_DEVICE,
+    NR_REG_LOC_IDX
+};
 /*
  * CXL r3.1 Section 8.1.9: Register Locator DVSEC
  * DVSEC ID: 8, Revision 0
@@ -168,14 +174,11 @@ QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortFlexBus) != 0x20);
 typedef struct CXLDVSECRegisterLocator {
     DVSECHeader hdr;
     uint16_t rsvd;
-    uint32_t reg0_base_lo;
-    uint32_t reg0_base_hi;
-    uint32_t reg1_base_lo;
-    uint32_t reg1_base_hi;
-    uint32_t reg2_base_lo;
-    uint32_t reg2_base_hi;
+    struct {
+            uint32_t lo;
+            uint32_t hi;
+    } reg_base[NR_REG_LOC_IDX];
 } CXLDVSECRegisterLocator;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECRegisterLocator) != 0x24);
 
 /* BAR Equivalence Indicator */
 #define BEI_BAR_10H 0
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 223f220433..af91525445 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -50,8 +50,8 @@ static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
                      &cxl_dstate->device_registers);
     regloc_dvsec = &(CXLDVSECRegisterLocator) {
         .rsvd         = 0,
-        .reg0_base_lo = RBI_CXL_DEVICE_REG | 0,
-        .reg0_base_hi = 0,
+        .reg_base[0].lo = RBI_CXL_DEVICE_REG | 0,
+        .reg_base[0].hi = 0,
     };
     cxl_component_create_dvsec(cxl_cstate, CXL3_SWITCH_MAILBOX_CCI,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ca9fe89e4f..dcefd41088 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -386,10 +386,14 @@ static void build_dvsecs(CXLType3Dev *ct3d)
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
-        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
-        .reg0_base_hi = 0,
-        .reg1_base_lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
-        .reg1_base_hi = 0,
+        .reg_base[REG_LOC_IDX_COMPONENT] = {
+            .lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+            .hi = 0,
+        },
+        .reg_base[REG_LOC_IDX_DEVICE] = {
+            .lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
+            .hi = 0,
+        },
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 1065245a8b..387cebbb98 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -126,8 +126,8 @@ static void build_dvsecs(CXLComponentState *cxl)
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
-        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
-        .reg0_base_hi = 0,
+        .reg_base[0].lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg_base[0].hi = 0,
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index e6a4035d26..d955f3bcc5 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -136,8 +136,8 @@ static void build_dvsecs(CXLComponentState *cxl)
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
-        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
-        .reg0_base_hi = 0,
+        .reg_base[0].lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg_base[0].hi = 0,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 208e0c6172..28f7542814 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -129,8 +129,8 @@ static void build_dvsecs(CXLComponentState *cxl)
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
-        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
-        .reg0_base_hi = 0,
+        .reg_base[0].lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg_base[0].hi = 0,
     };
     cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
-- 
2.48.1


