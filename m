Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ECAC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYGt-0004Oj-Od; Thu, 13 Aug 2026 12:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGe-00044D-Ej; Thu, 13 Aug 2026 12:27:00 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGc-0001NA-VY; Thu, 13 Aug 2026 12:26:56 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwCnpq428H1qIVLmAA--.5092S2;
 Fri, 14 Aug 2026 00:26:30 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwBXQw8H1q7SwjAA--.59184S7;
 Fri, 14 Aug 2026 00:26:29 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 26/28] hw/arm/smmuv3: Initialize the secure register bank
Date: Fri, 14 Aug 2026 00:26:24 +0800
Message-Id: <20260813162624.2809349-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBXQw8H1q7SwjAA--.59184S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HtAABsi
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF15GFWfArW7ur4UuFyDZFb_yoW5Ww18pF
 ZrAr15Kw13KFn3X3y3A3y8AF13Wr4xtw1DCr9xWF1rC345KrWUJr4DGFyFvrZFvr1rua12
 qFySg3y5Wr45A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Initialize the secure register bank (SMMU_SEC_SID_S) with sane default
values during the SMMU's reset sequence.

This change ensures that key fields, such as the secure ID registers,
GBPA reset value, and queue entry sizes, are set to a known-good state.
The SECURE_IMPL attribute of the S_IDR1 register will be introduced
later via device properties.

This is a necessary step to prevent undefined behavior when secure SMMU
features are subsequently enabled and used by software.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2375b7a17a0..7e7376c65e2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -293,6 +293,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 static void smmuv3_init_id_regs(SMMUv3State *s)
 {
     SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+    SMMUv3RegBank *sbank = smmuv3_bank(s, SMMU_SEC_SID_S);
 
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
@@ -339,7 +340,14 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN4K, 1);
     bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN16K, 1);
     bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN64K, 1);
-    s->aidr = 0x1;
+
+    /* Initialize Secure bank */
+    memset(sbank->idr, 0, sizeof(sbank->idr));
+    /* No stall */
+    sbank->idr[0] = FIELD_DP32(sbank->idr[0], S_IDR0, STALL_MODEL, 1);
+
+    sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, S_SIDSIZE,
+                               SMMU_IDR1_SIDSIZE);
     smmuv3_accel_idr_override(s);
 }
 
@@ -352,6 +360,7 @@ bool smmuv3_ats_enabled(SMMUv3State *s)
 static void smmuv3_reset(SMMUv3State *s)
 {
     SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+    SMMUv3RegBank *sbank = smmuv3_bank(s, SMMU_SEC_SID_S);
 
     bank->cmdq.base = deposit64(bank->cmdq.base, 0, 5, SMMU_CMDQS);
     bank->cmdq.prod = 0;
@@ -371,6 +380,24 @@ static void smmuv3_reset(SMMUv3State *s)
     bank->gerrorn = 0;
     bank->gbpa = SMMU_GBPA_RESET_VAL;
 
+    sbank->cmdq.base = deposit64(sbank->cmdq.base, 0, 5, SMMU_CMDQS);
+    sbank->cmdq.prod = 0;
+    sbank->cmdq.cons = 0;
+    sbank->cmdq.entry_size = sizeof(struct Cmd);
+    sbank->eventq.base = deposit64(sbank->eventq.base, 0, 5, SMMU_EVENTQS);
+    sbank->eventq.prod = 0;
+    sbank->eventq.cons = 0;
+    sbank->eventq.entry_size = sizeof(struct Evt);
+
+    sbank->features = 0;
+    sbank->sid_split = 0;
+    sbank->cr[0] = 0;
+    sbank->cr0ack = 0;
+    sbank->irq_ctrl = 0;
+    sbank->gerror = 0;
+    sbank->gerrorn = 0;
+    sbank->gbpa = SMMU_GBPA_RESET_VAL;
+
     s->aidr = 0x1;
     s->statusr = 0;
 }
-- 
2.34.1


