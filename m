Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F8606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGU8-00014M-1o; Sat, 14 Nov 2026 11:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTn-0000Yj-To; Sat, 14 Nov 2026 11:20:02 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTl-00078r-L2; Sat, 14 Nov 2026 11:19:51 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwBHndwiivhq4xoGAg--.53576S2; 
 Sun, 15 Nov 2026 00:19:46 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwfXMhivhq+tv6AA--.39223S3;
 Sun, 15 Nov 2026 00:19:45 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 28/35] hw/arm/smmuv3: Implement SMMU_S_INIT register
Date: Sun, 15 Nov 2026 00:19:44 +0800
Message-Id: <20261114161944.3648321-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwfXMhivhq+tv6AA--.39223S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBkgAAs3
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF4UXr43Kw1rtF4UXF1fZwb_yoW5Kr4Upr
 WkG3s8K3yFy3WSqFsIkaykZ3Zxu3ykGFy7CrZxG34F93Wqy34qv3WDKr1akrZ8CF15Gay7
 Wws3uF4DWr15X3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement read/write handlers for the SMMU_S_INIT Secure-only register.

Writing INV_ALL provides a mechanism for software to perform a global
invalidation of ALL caches within the SMMU, including IOTLBs and
configuration caches across all security states.

The MMIO dispatcher decodes the target register bank from the offset and
normalizes Secure-window offsets by subtracting SMMU_SECURE_REG_START
before switching on the bank-local offset. S_INIT is a Secure-only
register and its A_S_INIT constant is an absolute Secure-window offset,
so the handler matches it using A_S_INIT - SMMU_SECURE_REG_START and
rejects accesses through Non-secure banks.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/arm/smmuv3.c     | 37 +++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events |  1 +
 2 files changed, 38 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 97a8663349e..5c3d8b4bd98 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -402,6 +402,23 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
 }
 
+static void smmuv3_invalidate_all_caches(SMMUv3State *s)
+{
+    SMMUState *bs = &s->smmu_state;
+    QEMU_LOCK_GUARD(&s->mutex);
+
+    trace_smmuv3_invalidate_all_caches();
+
+    /* Clear all cached configs including STE and CD */
+    if (bs->configs) {
+        g_hash_table_remove_all(bs->configs);
+    }
+
+    /* Invalidate all SMMU IOTLB entries */
+    smmu_inv_notifiers_all(&s->smmu_state);
+    smmu_iotlb_inv_all(bs);
+}
+
 static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                                                  SMMUTransCfg *cfg,
                                                  SMMUEventInfo *event,
@@ -2005,7 +2022,21 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
     case A_EVENTQ_IRQ_CFG1:
     case A_EVENTQ_IRQ_CFG2:
         return MEMTX_OK;
+    case A_S_INIT - SMMU_SECURE_REG_START:
+        if (reg_sec_sid != SMMU_SEC_SID_S) {
+            goto unhandled;
+        }
+        if (data & R_S_INIT_INV_ALL_MASK) {
+            /*
+             * Complete synchronously, including when SMMUEN is set. Root
+             * and GPC are not implemented; GPCEN must gate this operation
+             * when that support is added.
+             */
+            smmuv3_invalidate_all_caches(s);
+        }
+        break;
     default:
+    unhandled:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
                       __func__, offset);
@@ -2186,6 +2217,12 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
     case A_EVENTQ_IRQ_CFG2:
         *data = 0;
         return MEMTX_OK;
+    case A_S_INIT - SMMU_SECURE_REG_START:
+        if (reg_sec_sid != SMMU_SEC_SID_S) {
+            goto unhandled;
+        }
+        *data = 0;
+        return MEMTX_OK;
     default:
     unhandled:
         *data = 0;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 4130d16fad5..143f91a03e2 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -67,6 +67,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
+smmuv3_invalidate_all_caches(void) "Invalidate all SMMU caches and TLBs"
 smmu_reset_exit(void) ""
 
 #smmuv3-accel.c
-- 
2.34.1


