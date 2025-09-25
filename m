Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B128BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1op0-0007Du-HU; Thu, 25 Sep 2025 12:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1oo6-0006S5-Nj; Thu, 25 Sep 2025 12:27:00 -0400
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1onl-0004l9-Q5; Thu, 25 Sep 2025 12:26:58 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3PVE1bdVooDN6Bw--.49908S2;
 Fri, 26 Sep 2025 00:26:29 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHLestbdVoW_MeAA--.7120S9;
 Fri, 26 Sep 2025 00:26:28 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 06/14] hw/arm/smmuv3: Add separate address space for secure
 SMMU accesses
Date: Fri, 26 Sep 2025 00:26:10 +0800
Message-Id: <20250925162618.191242-7-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHLestbdVoW_MeAA--.7120S9
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIHuQAAsI
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWr43Jw47Jw1rCw48XF1kKrg_yoW5ZrW5pF
 Z3AFZxt3yjk3W7ZrZ7XrnruFy8Wa95WF4UGr47Cwn5ZF13tr1ayw4qk3W5KFyDCr45Ja17
 ZF17Zr4xXF4jqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=159.65.134.6;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: 41
X-Spam_score: 4.1
X-Spam_bar: ++++
X-Spam_report: (4.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_PBL=3.335, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the Arm architecture, SMMU-originated memory accesses,
such as fetching commands or writing events for a secure stream, must
target the Secure Physical Address (PA) space. The existing model sends
all DMA to the global address_space_memory.

This patch introduces the infrastructure to differentiate between secure
and non-secure memory accesses. A weak global symbol,
arm_secure_address_space, is added, which can be provided by the
machine model to represent the Secure PA space.

A new helper, smmu_get_address_space(), selects the target address
space based on the is_secure context. All internal DMA calls
(dma_memory_read/write) are updated to use this helper. Additionally,
the attrs.secure bit is set on transactions targeting the secure
address space.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         |  8 ++++++++
 hw/arm/virt.c                |  5 +++++
 include/hw/arm/smmu-common.h | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 62a7612184..24db448683 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -30,6 +30,14 @@
 #include "hw/arm/smmu-common.h"
 #include "smmu-internal.h"
 
+/* Global state for secure address space availability */
+bool arm_secure_as_available;
+
+void smmu_enable_secure_address_space(void)
+{
+    arm_secure_as_available = true;
+}
+
 /* IOTLB Management */
 
 static guint smmu_iotlb_key_hash(gconstpointer v)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02209fadcf..805d9aadb7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -92,6 +92,8 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
+AddressSpace arm_secure_address_space;
+
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -2243,6 +2245,9 @@ static void machvirt_init(MachineState *machine)
         memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
+        address_space_init(&arm_secure_address_space, secure_sysmem,
+                           "secure-memory-space");
+        smmu_enable_secure_address_space();
     }
 
     firmware_loaded = virt_firmware_init(vms, sysmem,
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 3df82b83eb..cd61c5e126 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -53,6 +53,26 @@ typedef enum SMMUSecurityIndex {
     SMMU_SEC_IDX_NUM,
 } SMMUSecurityIndex;
 
+extern AddressSpace __attribute__((weak)) arm_secure_address_space;
+extern bool arm_secure_as_available;
+void smmu_enable_secure_address_space(void);
+
+static inline AddressSpace *smmu_get_address_space(SMMUSecurityIndex sec_sid)
+{
+    switch (sec_sid) {
+    case SMMU_SEC_IDX_S:
+    {
+        if (arm_secure_as_available) {
+            return &arm_secure_address_space;
+        }
+    }
+    QEMU_FALLTHROUGH;
+    case SMMU_SEC_IDX_NS:
+    default:
+        return &address_space_memory;
+    }
+}
+
 /*
  * Page table walk error types
  */
-- 
2.34.1


