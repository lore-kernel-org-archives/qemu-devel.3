Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2683C61DE3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk4j-0003Fd-Gi; Sat, 21 Feb 2026 05:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4V-0002zR-66; Sat, 21 Feb 2026 05:18:48 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4T-0002n9-7G; Sat, 21 Feb 2026 05:18:46 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHXdCChplp0R9zAA--.3197S2;
 Sat, 21 Feb 2026 18:18:42 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDnP+1+hplpfU4cAA--.34781S3;
 Sat, 21 Feb 2026 18:18:38 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 25/31] hw/arm/smmuv3: Implement SMMU_S_INIT register
Date: Sat, 21 Feb 2026 18:18:36 +0800
Message-Id: <20260221101836.2996599-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDnP+1+hplpfU4cAA--.34781S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUARwAAsV
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF1UCw47Cr17uw47Wr43trb_yoWrWr1fpr
 WDWr15Kw48A3WS9FnIkw4vyF15ua97Kry7CrZxGa4S9a4qyryqqF4DKrW7uFWDWr15Cay7
 G3ySgFsrur1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=165.227.154.27;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmty1ljiyny4xntqumjca.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement read/write handlers for the SMMU_S_INIT secure-only register.

Writing INV_ALL provides a mechanism for software to perform a global
invalidation of ALL caches within the SMMU, including IOTLBs and
configuration caches across all security states.

The MMIO dispatcher decodes the target register bank from the high bits
of the offset and then switches on the 4KB page-local offset
(offset & 0xfff), since registers that share the same function across
banks use the same relative layout. S_INIT is a secure-only register and
its A_S_INIT constant is currently defined as an absolute secure-window
offset (0x803c), so it has no NS twin to reuse as a shared low-12-bit
macro. As a one-off special case, the handler matches it via
(A_S_INIT & 0xfff) to fit the relative-offset decode.

This feature is critical for secure hypervisors like Hafnium, which use
it as a final step in their SMMU initialization sequence to ensure a
clean cache state before enabling translations.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c     | 37 +++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events |  1 +
 2 files changed, 38 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index d81485a6a46..6fd664a000f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -373,6 +373,21 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
 }
 
+static void smmuv3_invalidate_all_caches(SMMUv3State *s)
+{
+    SMMUState *bs = &s->smmu_state;
+    trace_smmuv3_invalidate_all_caches();
+
+    /* Clear all cached configs including STE and CD */
+    if (bs->configs) {
+        g_hash_table_remove_all(bs->configs);
+    }
+
+    /* Invalidate all SMMU IOTLB entries */
+    smmu_inv_notifiers_all(&s->smmu_state);
+    smmu_iotlb_inv_all(bs, SMMU_SEC_SID_NUM);
+}
+
 static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                                                  SMMUTransCfg *cfg,
                                                  SMMUEventInfo *event,
@@ -2077,6 +2092,25 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
 
         bank->eventq_irq_cfg2 = data;
         break;
+    /* S_INIT is Secure-only. So match it as a one-off via & 0xfff. */
+    case (A_S_INIT & 0xfff):
+        if (data & R_S_INIT_INV_ALL_MASK) {
+            /*
+             * If SMMU_ROOT_CR0.GPCEN == 0, a write of 1 to INV_ALL when any
+             * SMMU_(*_)CR0.SMMUEN == 1, .... , is CONSTRAINED UNPREDICTABLE
+             * according to (IHI 0070G.b) 6.3.62 SMMU_S_INIT, Page 465.
+             */
+            if (!smmuv3_smmu_disabled_stable(s, SMMU_SEC_SID_NS) ||
+                !smmuv3_smmu_disabled_stable(s, SMMU_SEC_SID_S)) {
+                /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
+                qemu_log_mask(LOG_GUEST_ERROR, "S_INIT write ignored: "
+                              "(S_)CR0.SMMUEN or (S_)CR0ACK.SMMUEN is set\n");
+                return MEMTX_OK;
+            }
+            smmuv3_invalidate_all_caches(s);
+        }
+        /* Synchronous emulation: invalidation completed instantly. */
+        break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
@@ -2277,6 +2311,9 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
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
index 64f308a8d35..26f19f18cb7 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -64,6 +64,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
+smmuv3_invalidate_all_caches(void) "Invalidate all SMMU caches and TLBs"
 smmu_reset_exit(void) ""
 
 #smmuv3-accel.c
-- 
2.34.1


