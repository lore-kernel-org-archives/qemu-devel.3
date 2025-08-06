Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F05C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgUk-0008IU-Sd; Wed, 06 Aug 2025 11:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpI-0000jc-S9; Wed, 06 Aug 2025 11:13:13 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpG-0006CR-Ms; Wed, 06 Aug 2025 11:13:12 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnbtoBcZNorUtLBA--.28700S2;
 Wed, 06 Aug 2025 23:13:05 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S6;
 Wed, 06 Aug 2025 23:13:04 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 03/11] hw/arm/smmuv3: Implement S_INIT for secure initialization
Date: Wed,  6 Aug 2025 23:11:26 +0800
Message-Id: <20250806151134.365755-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HIgAAs2
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxArWDJF1UKFWxJw4fJry3CFg_yoW5uF18pF
 WkGr98K3y5A3WfWFnxC3yxAF15X397Gry7CrZxG3say3WvyryDZF1DKa43urZ8CF15Jay7
 W3yS9F4xur1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:13 -0400
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

This patch implements the S_INIT register, a secure-only register
with no non-secure counterpart. It provides a simple mechanism for
secure software to perform a global invalidation of all SMMU
configuration and translation caches.

This is typically the final step in a SMMU's probe sequence, marking
the end of initialization for the SMMU's secure interface.

With this and the previous change, a guest that is aware of the SMMUv3
secure extensions can probe the device's capabilities and perform basic
configuration of the secure interface, as is done by secure partition
managers like Hafnium in its smmuv3_driver_init function.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c     | 29 +++++++++++++++++++++++++++++
 hw/arm/trace-events |  1 +
 2 files changed, 30 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 619180d204..0ea9d897af 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -920,6 +920,21 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     g_hash_table_remove(bc->configs, sdev);
 }
 
+static void smmuv3_invalidate_all_caches(SMMUv3State *s)
+{
+    trace_smmuv3_invalidate_all_caches();
+    SMMUState *bs = &s->smmu_state;
+
+    /* Clear all cached configs including STE and CD*/
+    if (bs->configs) {
+        g_hash_table_remove_all(bs->configs);
+    }
+
+    /* Invalidate all SMMU IOTLB entries */
+    smmu_inv_notifiers_all(&s->smmu_state);
+    smmu_iotlb_inv_all(bs);
+}
+
 /* Do translation with TLB lookup. */
 static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                                                  SMMUTransCfg *cfg,
@@ -1921,6 +1936,16 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG2");
         s->secure_eventq_irq_cfg2 = data;
         return MEMTX_OK;
+    case A_S_INIT:
+        SMMU_CHECK_SECURE_WRITE("S_INIT");
+        if (data & R_S_INIT_INV_ALL_MASK) {
+            /* write S_INIT and poll*/
+            s->secure_init = data & R_S_INIT_INV_ALL_MASK;
+            smmuv3_invalidate_all_caches(s);
+        }
+        /* initialization is completed and set to 0 to terminate the polling */
+        s->secure_init = 0;
+        return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
@@ -2249,6 +2274,10 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
         }
         *data = s->secure_eventq.cons;
         return MEMTX_OK;
+    case A_S_INIT:
+        SMMU_CHECK_SECURE_READ("S_INIT");
+        *data = s->secure_init;
+        return MEMTX_OK;
     default:
         *data = 0;
         qemu_log_mask(LOG_UNIMP,
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f3386bd7ae..019129ea43 100644
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


