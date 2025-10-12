Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECA8CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xfU-0001fo-4V; Sun, 12 Oct 2025 11:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfN-0001aw-Qy; Sun, 12 Oct 2025 11:07:21 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfK-0001d8-MT; Sun, 12 Oct 2025 11:07:21 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB3WCUexOtobicrAA--.7763S2;
 Sun, 12 Oct 2025 23:07:10 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXPOoXxOto33dMAA--.3068S11;
 Sun, 12 Oct 2025 23:07:09 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 08/21] hw/arm/smmuv3: Add separate address space for secure
 SMMU accesses
Date: Sun, 12 Oct 2025 23:06:48 +0800
Message-Id: <20251012150701.4127034-9-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXPOoXxOto33dMAA--.3068S11
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBYAABsQ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWr4xXrykCw1DCr43Xw4UCFg_yoW5KFW7pa
 9rArZxt390k3W2yrZ3Xrnrua4rWa95WF4UKrsFk3s5uF13Kr13Ar4qk3WUGF9rCr45Ja12
 vF17Zr4fWF1jqrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
all DMA to the global non-secure address_space_memory.

This patch introduces the infrastructure to differentiate between secure
and non-secure memory accesses. Firstly, SMMU_SEC_SID_S is added in
SMMUSecSID enum to represent the secure context. Then a weak global
symbol, arm_secure_address_space, is added, which can be provided by the
machine model to represent the Secure PA space.

A new helper, smmu_get_address_space(), selects the target address
space based on SEC_SID. All internal DMA calls
(dma_memory_read/write) will be updated to use this helper in follow-up
patches.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         |  8 ++++++++
 hw/arm/virt.c                |  5 +++++
 include/hw/arm/smmu-common.h | 27 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

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
index 175023897a..83dc62a095 100644
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
@@ -2257,6 +2259,9 @@ static void machvirt_init(MachineState *machine)
         memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
+        address_space_init(&arm_secure_address_space, secure_sysmem,
+                           "secure-memory-space");
+        smmu_enable_secure_address_space();
     }
 
     firmware_loaded = virt_firmware_init(vms, sysmem,
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b0dae18a62..d54558f94b 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -43,9 +43,36 @@
 /* StreamID Security state */
 typedef enum SMMUSecSID {
     SMMU_SEC_SID_NS = 0,
+    SMMU_SEC_SID_S,
     SMMU_SEC_SID_NUM,
 } SMMUSecSID;
 
+extern AddressSpace __attribute__((weak)) arm_secure_address_space;
+extern bool arm_secure_as_available;
+void smmu_enable_secure_address_space(void);
+
+/*
+ * Return the address space corresponding to the SEC_SID.
+ * If SEC_SID is Secure, but secure address space is not available,
+ * return NULL and print a warning message.
+ */
+static inline AddressSpace *smmu_get_address_space(SMMUSecSID sec_sid)
+{
+    switch (sec_sid) {
+    case SMMU_SEC_SID_NS:
+        return &address_space_memory;
+    case SMMU_SEC_SID_S:
+        if (!arm_secure_as_available || arm_secure_address_space.root == NULL) {
+            printf("Secure address space requested but not available");
+            return NULL;
+        }
+        return &arm_secure_address_space;
+    default:
+        printf("Unknown SEC_SID value %d", sec_sid);
+        return NULL;
+    }
+}
+
 /*
  * Page table walk error types
  */
-- 
2.34.1


