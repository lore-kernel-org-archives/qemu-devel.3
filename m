Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E9606A323
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGUE-0001YA-Hr; Sat, 14 Nov 2026 11:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTi-0000XT-AM; Sat, 14 Nov 2026 11:19:54 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTe-0006h5-FE; Sat, 14 Nov 2026 11:19:45 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDHzlobivhq0BoGAg--.43029S2; 
 Sun, 15 Nov 2026 00:19:39 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwBnMZivhq+Nv6AA--.26417S3;
 Sun, 15 Nov 2026 00:19:38 +0800 (CST)
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
Subject: [PATCH v6 25/35] hw/arm/smmuv3: Guard event queue register writes
Date: Sun, 15 Nov 2026 00:19:37 +0800
Message-Id: <20261114161937.3648060-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBnMZivhq+Nv6AA--.26417S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBjgAAsr
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr48ArW5KrW3WFWUAFy5urg_yoWrWryxpr
 ZxJFy5Ka12yw4Sg3Z3Aw1DAan8Cwn7Jry7Kr9xW34UWw18urWUZa1UWFWfKFyrJF1UJw4D
 GrZI93Zrur15K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

EVENTQ_BASE and EVENTQ_PROD can currently be modified while the event
queue is enabled. Ignore these writes while EVENTQEN is set, using the
model's synchronous enable and acknowledgement state.

Mask reserved EVENTQ_BASE bits and update the queue size when writing
its low half. Use the high-half mask for writes to EVENTQ_BASE + 4.

The model does not advertise MSI support. Make EVENTQ_IRQ_CFG0/1/2 read
as zero and ignore writes, including accesses to both halves of CFG0.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e5f057113e1..138ca178a1a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1775,14 +1775,19 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     case A_EVENTQ_BASE:
-        bank->eventq.base = data;
+        if (smmuv3_eventq_enabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        bank->eventq.base = data & SMMU_QUEUE_BASE_RESERVED;
         bank->eventq.log2size = extract64(bank->eventq.base, 0, 5);
         if (bank->eventq.log2size > SMMU_EVENTQS) {
             bank->eventq.log2size = SMMU_EVENTQS;
         }
         return MEMTX_OK;
     case A_EVENTQ_IRQ_CFG0:
-        bank->eventq_irq_cfg0 = data;
         return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
@@ -1927,6 +1932,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         bank->cmdq.cons = data;
         break;
     case A_EVENTQ_BASE: /* 64b */
+        if (smmuv3_eventq_enabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         bank->eventq.base = deposit64(bank->eventq.base, 0, 32, data);
         bank->eventq.log2size = extract64(bank->eventq.base, 0, 5);
         if (bank->eventq.log2size > SMMU_EVENTQS) {
@@ -1934,26 +1946,32 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         break;
     case A_EVENTQ_BASE + 4:
+        if (smmuv3_eventq_enabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED >> 32;
         bank->eventq.base = deposit64(bank->eventq.base, 32, 32, data);
         break;
     case A_EVENTQ_PROD:
+        if (smmuv3_eventq_enabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "EVENTQ_PROD write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->eventq.prod = data;
         break;
     case A_EVENTQ_CONS:
         bank->eventq.cons = data;
         break;
-    case A_EVENTQ_IRQ_CFG0: /* 64b */
-        bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 0, 32, data);
-        break;
+    case A_EVENTQ_IRQ_CFG0:
     case A_EVENTQ_IRQ_CFG0 + 4:
-        bank->eventq_irq_cfg0 = deposit64(bank->eventq_irq_cfg0, 32, 32, data);
-        break;
     case A_EVENTQ_IRQ_CFG1:
-        bank->eventq_irq_cfg1 = data;
-        break;
     case A_EVENTQ_IRQ_CFG2:
-        bank->eventq_irq_cfg2 = data;
-        break;
+        return MEMTX_OK;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
@@ -2012,6 +2030,9 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
     case A_EVENTQ_BASE:
         *data = bank->eventq.base;
         return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG0:
+        *data = 0;
+        return MEMTX_OK;
     default:
         *data = 0;
         qemu_log_mask(LOG_UNIMP,
@@ -2107,6 +2128,12 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
     case A_EVENTQ_CONS:
         *data = bank->eventq.cons;
         return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG0:
+    case A_EVENTQ_IRQ_CFG0 + 4:
+    case A_EVENTQ_IRQ_CFG1:
+    case A_EVENTQ_IRQ_CFG2:
+        *data = 0;
+        return MEMTX_OK;
     default:
         *data = 0;
         qemu_log_mask(LOG_UNIMP,
-- 
2.34.1


