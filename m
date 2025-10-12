Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DD4CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xlt-0001Rp-Hz; Sun, 12 Oct 2025 11:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xlr-0001RA-SZ; Sun, 12 Oct 2025 11:14:03 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xlp-0002WE-Ma; Sun, 12 Oct 2025 11:14:03 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3Ppq1xetoT1egAA--.31S2;
 Sun, 12 Oct 2025 23:13:57 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB32+izxetoVXhMAA--.3235S3;
 Sun, 12 Oct 2025 23:13:56 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 16/21] hw/arm/smmuv3: Implement SMMU_S_INIT register
Date: Sun, 12 Oct 2025 23:13:51 +0800
Message-Id: <20251012151351.4130239-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB32+izxetoVXhMAA--.3235S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBcAAAsB
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJF13XFWDXw4rZr17uFy7GFg_yoW5uF4kpF
 WkGr98Kr4UZ3Wa9FsIkw4xAFn5u34vgr17CrZxGr9av3Wvy3yDZa1DtrW3CFZ8Wr1UG3y7
 Gw4SgFsxWr1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Implement read/write handlers for the SMMU_S_INIT secure-only
register.

Writing to this register provides a mechanism for software to perform a
global invalidation of ALL caches within the SMMU. This includes the
IOTLBs and Configuration Caches across all security states.

This feature is critical for secure hypervisors like Hafnium, which
use it as a final step in their SMMU initialization sequence. It
provides a reliable, architecturally defined method to ensure a clean
and known-good cache state before enabling translations.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c     | 33 +++++++++++++++++++++++++++++++++
 hw/arm/trace-events |  1 +
 2 files changed, 34 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 100caeeb35..432de88610 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -354,6 +354,21 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
 }
 
+static void smmuv3_invalidate_all_caches(SMMUv3State *s)
+{
+    trace_smmuv3_invalidate_all_caches();
+    SMMUState *bs = &s->smmu_state;
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
@@ -1969,6 +1984,21 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
 
         bank->eventq_irq_cfg2 = data;
         return MEMTX_OK;
+    case (A_S_INIT & 0xfff):
+        if (data & R_S_INIT_INV_ALL_MASK) {
+            int cr0_smmuen = smmu_enabled(s, reg_sec_sid);
+            int s_cr0_smmuen = smmuv3_get_cr0ack_smmuen(s, reg_sec_sid);
+            if (cr0_smmuen || s_cr0_smmuen) {
+                /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
+                qemu_log_mask(LOG_GUEST_ERROR, "S_INIT write ignored: "
+                              "CR0.SMMUEN=%d or S_CR0.SMMUEN=%d is set\n",
+                              cr0_smmuen, s_cr0_smmuen);
+                return MEMTX_OK;
+            }
+            smmuv3_invalidate_all_caches(s);
+        }
+        /* Synchronous emulation: invalidation completed instantly. */
+        return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
@@ -2172,6 +2202,9 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
     case A_EVENTQ_CONS:
         *data = bank->eventq.cons;
         return MEMTX_OK;
+    case (A_S_INIT & 0xfff):
+        *data = 0;
+        return MEMTX_OK;
     default:
         *data = 0;
         qemu_log_mask(LOG_UNIMP,
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 434d6abfc2..0e7ad8fee3 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -64,6 +64,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
+smmuv3_invalidate_all_caches(void) "Invalidate all SMMU caches and TLBs"
 smmu_reset_exit(void) ""
 
 # strongarm.c
-- 
2.34.1


