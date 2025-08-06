Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF13C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgeE-0006nm-0a; Wed, 06 Aug 2025 12:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfqW-0002Mn-Ot; Wed, 06 Aug 2025 11:14:28 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfqU-0006Ly-U1; Wed, 06 Aug 2025 11:14:28 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB3DWFQcZNoSlVLBA--.45959S2;
 Wed, 06 Aug 2025 23:14:24 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3QgpOcZNo6PoJAA--.18473S3;
 Wed, 06 Aug 2025 23:14:22 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 11/11] hw/arm/smmuv3: Use iommu_index to represent SEC_SID
Date: Wed,  6 Aug 2025 23:14:20 +0800
Message-Id: <20250806151420.368359-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3QgpOcZNo6PoJAA--.18473S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HMgAAsm
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXry7Ary8Gw4UCFyDAFW8JFb_yoW5urW5pr
 4DWr4rKw4xGF13AF4fJa1kuF4Yg397WFW7Ja9rKan5AF18Awn7Zr9akFy5KryDtFW8Za17
 Xa1j9rZrW3WjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:14 -0400
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

The Arm SMMUv3 architecture uses a SEC_SID (Secure StreamID) flag to
select between two distinct programming interfaces: Secure and
Non-secure. The QEMU model must reflect this fundamental hardware
separation for all memory operations, including TLB lookups.

This commit leverages the generic iommu_index to represent this
security context. The core IOMMU layer now uses the SMMU's .attrs_to_index
callback to map a transaction's secure attribute to an index (1 for
secure, 0 for non-secure).

This index is then passed down to smmuv3_translate. Inside the
translate function, the local is_secure flag is now derived directly
from the iommu_index. This makes the iommu_index the clear QEMU
equivalent of the architectural SEC_SID, cleanly separating the
contexts for all subsequent lookups.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 972cbc872f..1a2e795985 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1137,6 +1137,33 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
     }
 }
 
+/*
+ * ARM SMMU IOMMU index mapping (implements SEC_SID from ARM SMMU):
+ * iommu_idx = 0: Non-secure transactions
+ * iommu_idx = 1: Secure transactions
+ *
+ * The iommu_idx parameter effectively implements the SEC_SID
+ * (Security Stream ID) attribute from the ARM SMMU architecture
+ * specification, which allows the SMMU to differentiate between
+ * secure and non-secure transactions at the hardware level.
+ */
+static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
+{
+    /*
+     * Map transaction attributes to IOMMU index:
+     * - Secure transactions (attrs.secure = 1) -> iommu_idx = 1
+     * - Non-secure transactions (attrs.secure = 0) -> iommu_idx = 0
+     * - Unspecified attributes are treated as non-secure for compat
+     */
+    return attrs.secure ? 1 : 0;
+}
+
+static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
+{
+    /* ARM SMMU supports 2 IOMMU indexes: non-secure (0) and secure (1) */
+    return 2;
+}
+
 /* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
@@ -1149,16 +1176,15 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                            .inval_ste_allowed = false};
     SMMUTranslationStatus status;
     SMMUTransCfg *cfg = NULL;
+    bool is_secure = (iommu_idx == 1);
     IOMMUTLBEntry entry = {
-        .target_as = smmu_get_address_space(false),
+        .target_as = smmu_get_address_space(is_secure),
         .iova = addr,
         .translated_addr = addr,
         .addr_mask = ~(hwaddr)0,
         .perm = IOMMU_NONE,
     };
     SMMUTLBEntry *cached_entry = NULL;
-    /* We don't support secure translation for now */
-    bool is_secure = false;
 
     qemu_mutex_lock(&s->mutex);
 
@@ -2639,6 +2665,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = smmuv3_translate;
     imrc->notify_flag_changed = smmuv3_notify_flag_changed;
+    imrc->attrs_to_index = smmuv3_attrs_to_index;
+    imrc->num_indexes = smmuv3_num_indexes;
 }
 
 static const TypeInfo smmuv3_type_info = {
-- 
2.34.1


