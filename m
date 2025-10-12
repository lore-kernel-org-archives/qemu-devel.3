Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCAACCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xn0-0003Mf-Kt; Sun, 12 Oct 2025 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xmz-0003HH-3Q; Sun, 12 Oct 2025 11:15:13 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xmw-0002kc-IE; Sun, 12 Oct 2025 11:15:12 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHjZn5xetotligAA--.81S2;
 Sun, 12 Oct 2025 23:15:05 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3Wef4xetoZnhMAA--.2267S3;
 Sun, 12 Oct 2025 23:15:04 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 19/21] hw/arm/smmuv3: Use iommu_index to represent the
 security context
Date: Sun, 12 Oct 2025 23:15:01 +0800
Message-Id: <20251012151501.4131026-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3Wef4xetoZnhMAA--.2267S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBdgAAsH
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZF1xWryxXr4fAFy3Aw4Utwb_yoW5CFWxpr
 4UGa93Kws8GF1fZF1fJa1UZF4a9397GF43XrZ3Kan5Aw18Awn7XFZ2kFyYgryDAFWUAw42
 vay0ka9rWa1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 hw/arm/smmuv3.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c9c742c80b..b44859540f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1080,6 +1080,38 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
     }
 }
 
+static SMMUSecSID smmuv3_attrs_to_sec_sid(MemTxAttrs attrs)
+{
+    switch (attrs.space) {
+    case ARMSS_Secure:
+        return SMMU_SEC_SID_S;
+    case ARMSS_NonSecure:
+    default:
+        return SMMU_SEC_SID_NS;
+    }
+}
+
+/*
+ * ARM IOMMU index mapping (implements SEC_SID from ARM SMMU):
+ * iommu_idx = 0: Non-secure transactions
+ * iommu_idx = 1: Secure transactions
+ *
+ * The iommu_idx parameter effectively implements the SEC_SID
+ * (Security Stream ID) attribute from the ARM SMMU architecture specification,
+ * which allows the SMMU to differentiate between different security state
+ * transactions at the hardware level.
+ */
+static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
+{
+    return (int)smmuv3_attrs_to_sec_sid(attrs);
+}
+
+static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
+{
+    /* Support 2 IOMMU indexes for now: NS/S */
+    return SMMU_SEC_SID_NUM;
+}
+
 /* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
@@ -1087,7 +1119,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
     uint32_t sid = smmu_get_sid(sdev);
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUSecSID sec_sid = iommu_idx;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
@@ -2540,6 +2572,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = smmuv3_translate;
     imrc->notify_flag_changed = smmuv3_notify_flag_changed;
+    imrc->attrs_to_index = smmuv3_attrs_to_index;
+    imrc->num_indexes = smmuv3_num_indexes;
 }
 
 static const TypeInfo smmuv3_type_info = {
-- 
2.34.1


