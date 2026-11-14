Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8729606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGU8-000193-D9; Sat, 14 Nov 2026 11:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTY-0000Py-Fn; Sat, 14 Nov 2026 11:19:44 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTW-0006Di-KG; Sat, 14 Nov 2026 11:19:36 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwBHvN0UivhqwBoGAg--.54721S2; 
 Sun, 15 Nov 2026 00:19:32 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwnnQSivhq9tv6AA--.36130S3;
 Sun, 15 Nov 2026 00:19:31 +0800 (CST)
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
Subject: [PATCH v6 23/35] hw/arm/smmuv3: Guard stream table register writes
Date: Sun, 15 Nov 2026 00:19:30 +0800
Message-Id: <20261114161930.3647973-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwnnQSivhq9tv6AA--.36130S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBigAAsv
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr4UKw1rCryUJw4xAr4Dtwb_yoW5WF4kpr
 Z7GwnI93y3t3WSqasxAa1Yyws8u3ykKF1UtFy7GF92vw4UJrW5XF4fXFWIqwnYqFyDtw4k
 Gw4ak3yfury8tFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

STRTAB_BASE and STRTAB_BASE_CFG can currently be modified while the SMMU
is enabled. Ignore their writes until SMMUEN is clear. The model updates
CR0ACK synchronously with CR0, so no separate transition check is needed.

Mask reserved bits in STRTAB_BASE for both 64-bit writes and writes to
its 32-bit halves. Shift the mask when handling the high half.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index bd680375b1b..127be4ac8e9 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1421,6 +1421,12 @@ smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
     return true;
 }
 
+/* Check if STRTAB_BASE register is writable */
+static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
+{
+    return !smmu_enabled(s, sec_sid);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1746,7 +1752,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
     case A_GERROR_IRQ_CFG0:
         return MEMTX_OK;
     case A_STRTAB_BASE:
-        bank->strtab_base = data;
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        /* Clear reserved bits according to spec */
+        bank->strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
         return MEMTX_OK;
     case A_CMDQ_BASE:
         bank->cmdq.base = data;
@@ -1830,12 +1843,32 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         }
         break;
     case A_STRTAB_BASE: /* 64b */
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_STRTAB_BASE_RESERVED;
         bank->strtab_base = deposit64(bank->strtab_base, 0, 32, data);
         break;
     case A_STRTAB_BASE + 4:
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE + 4 write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
+        data &= SMMU_STRTAB_BASE_RESERVED >> 32;
         bank->strtab_base = deposit64(bank->strtab_base, 32, 32, data);
         break;
     case A_STRTAB_BASE_CFG:
+        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "STRTAB_BASE_CFG write ignored: register is RO\n");
+            return MEMTX_OK;
+        }
+
         bank->strtab_base_cfg = data;
         if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
             bank->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
-- 
2.34.1


