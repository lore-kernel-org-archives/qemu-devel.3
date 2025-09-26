Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9299CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 03:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1yq4-0006Su-Dd; Thu, 25 Sep 2025 23:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1yq1-0006Pl-5u; Thu, 25 Sep 2025 23:09:37 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1ypr-0003ir-AR; Thu, 25 Sep 2025 23:09:35 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBX7mHPA9Zomkp8Bw--.7124S2;
 Fri, 26 Sep 2025 11:09:03 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXu+jKA9Zoee4gAA--.9761S3;
 Fri, 26 Sep 2025 11:08:58 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 12/14] hw/arm/smmuv3: Use iommu_index to represent the
 security context
Date: Fri, 26 Sep 2025 11:08:29 +0800
Message-Id: <20250926030831.1067440-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXu+jKA9Zoee4gAA--.9761S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIH0QAGsm
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCr4Utr47Jw4fAw1DCr4kZwb_yoW5KF1fpF
 4kGFZ5Kw4fJF13Ar1fJa1kZF4a93ykGFW7XFZxKws5Ar1kZr97XryvkFyYgryUCFWUCw42
 qa10krWDW3WqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Resending patches 12–14/14 that were missing due to a send issue. Sorry
for the noise.

The Arm SMMUv3 architecture uses a SEC_SID (Secure StreamID) to select
the programming interface. To support future extensions like RME, which
defines four security states (Non-secure, Secure, Realm, and Root), the
QEMU model must cleanly separate these contexts for all operations.

This commit leverages the generic iommu_index to represent this
security context. The core IOMMU layer now uses the SMMU's .attrs_to_index
callback to map a transaction's ARMSecuritySpace attribute to the
corresponding iommu_index.

This index is then passed down to smmuv3_translate and used throughout
the model to select the correct register bank and processing logic. This
makes the iommu_index the clear QEMU equivalent of the architectural
SEC_SID, cleanly separating the contexts for all subsequent lookups.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index eec36d5fd2..c92cc0f06a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1099,6 +1099,38 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
     }
 }

+static SMMUSecurityIndex smmuv3_attrs_to_security_index(MemTxAttrs attrs)
+{
+    switch (attrs.space) {
+    case ARMSS_Secure:
+        return SMMU_SEC_IDX_S;
+    case ARMSS_NonSecure:
+    default:
+        return SMMU_SEC_IDX_NS;
+    }
+}
+
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
+    return smmuv3_attrs_to_security_index(attrs);
+}
+
+static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
+{
+    /* Support 2 IOMMU indexes for now: NS/S */
+    return SMMU_SEC_IDX_NUM;
+}
+
 /* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
@@ -1111,7 +1143,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                            .inval_ste_allowed = false};
     SMMUTranslationStatus status;
     SMMUTransCfg *cfg = NULL;
-    SMMUSecurityIndex sec_idx = SMMU_SEC_IDX_NS;
+    SMMUSecurityIndex sec_idx = iommu_idx;
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
         .iova = addr,
@@ -1155,6 +1187,7 @@ epilogue:
         entry.perm = cached_entry->entry.perm;
         entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
         entry.addr_mask = cached_entry->entry.addr_mask;
+        entry.target_as = cached_entry->entry.target_as;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm,
                                        cfg->stage);
@@ -2534,6 +2567,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,

     imrc->translate = smmuv3_translate;
     imrc->notify_flag_changed = smmuv3_notify_flag_changed;
+    imrc->attrs_to_index = smmuv3_attrs_to_index;
+    imrc->num_indexes = smmuv3_num_indexes;
 }

 static const TypeInfo smmuv3_type_info = {
--
2.34.1


