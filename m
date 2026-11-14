Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562A606A323
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGUO-0002YL-IM; Sat, 14 Nov 2026 11:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTc-0000RL-LZ; Sat, 14 Nov 2026 11:19:47 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTb-0006Q3-2u; Sat, 14 Nov 2026 11:19:40 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDnBN4YivhqyRoGAg--.42231S2; 
 Sun, 15 Nov 2026 00:19:36 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwnnQWivhq99v6AA--.36131S3;
 Sun, 15 Nov 2026 00:19:34 +0800 (CST)
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
Subject: [PATCH v6 24/35] hw/arm/smmuv3: Guard command queue register writes
Date: Sun, 15 Nov 2026 00:19:34 +0800
Message-Id: <20261114161934.3648016-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwnnQWivhq99v6AA--.36131S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBjAAAsp
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr4UKw1rAw48XFWfJFy8Grg_yoW5Xr43p3
 97GrZ0grW2yrs3GF9xAay8Cr45uwn3Kry2vry7WFyrXw1UG3yYgF48Xa4fXF93XF9rAws5
 trsI9a4Dur48trJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

CMDQ_BASE and CMDQ_CONS can currently be modified while the command
queue is enabled. Ignore these writes while CMDQEN is set, using the
model's synchronous enable and acknowledgement state.

Mask reserved CMDQ_BASE bits and update the queue size when writing its
low half. Use the high-half mask for writes to CMDQ_BASE + 4.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 127be4ac8e9..e5f057113e1 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1762,7 +1762,13 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
         bank->strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
         return MEMTX_OK;
     case A_CMDQ_BASE:
-        bank->cmdq.base = data;
+        if (smmuv3_cmdq_enabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        bank->cmdq.base = data & SMMU_QUEUE_BASE_RESERVED;
         bank->cmdq.log2size = extract64(bank->cmdq.base, 0, 5);
         if (bank->cmdq.log2size > SMMU_CMDQS) {
             bank->cmdq.log2size = SMMU_CMDQS;
@@ -1884,6 +1890,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         break;
     case A_CMDQ_BASE: /* 64b */
+        if (smmuv3_cmdq_enabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED;
         bank->cmdq.base = deposit64(bank->cmdq.base, 0, 32, data);
         bank->cmdq.log2size = extract64(bank->cmdq.base, 0, 5);
         if (bank->cmdq.log2size > SMMU_CMDQS) {
@@ -1891,6 +1904,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         break;
     case A_CMDQ_BASE + 4: /* 64b */
+        if (smmuv3_cmdq_enabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_QUEUE_BASE_RESERVED >> 32;
         bank->cmdq.base = deposit64(bank->cmdq.base, 32, 32, data);
         break;
     case A_CMDQ_PROD:
@@ -1898,6 +1918,12 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
         break;
     case A_CMDQ_CONS:
+        if (smmuv3_cmdq_enabled(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMDQ_CONS write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->cmdq.cons = data;
         break;
     case A_EVENTQ_BASE: /* 64b */
-- 
2.34.1


