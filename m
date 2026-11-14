Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F91606A882
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGUK-00027p-70; Sat, 14 Nov 2026 11:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGUA-0001GQ-Qo; Sat, 14 Nov 2026 11:20:15 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGU8-0000MS-Nc; Sat, 14 Nov 2026 11:20:14 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAHXdw6ivhqCRsGAg--.41853S2; 
 Sun, 15 Nov 2026 00:20:10 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dw03I2ivhq_tv6AA--.29919S3;
 Sun, 15 Nov 2026 00:20:06 +0800 (CST)
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
Subject: [PATCH v6 33/35] hw/arm/smmuv3: Initialize the Secure register bank
Date: Sun, 15 Nov 2026 00:20:06 +0800
Message-Id: <20261114162006.3648858-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw03I2ivhq_tv6AA--.29919S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBmAAAs9
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF15Gw15Kw1UCw13uw4DJwb_yoW5Ar13pF
 ZrAr15Kw13KFn3XwsxAay8AF43Wr4xtwn8Cr9xWF1rC345GrWUJr4DGF1Fqr9Fqr1rua12
 qFySk3y5Wr45A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Initialize the Secure register bank (SMMU_SEC_SID_S) with sane default
values during the SMMU's reset sequence.

This change ensures that key fields, such as the Secure ID registers,
GBPA reset value, and queue entry sizes, are set to a known-good state.
The SECURE_IMPL attribute of the S_IDR1 register will be introduced
later via device properties.

This is a necessary step to prevent undefined behavior when Secure SMMU
features are subsequently enabled and used by software.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/arm/smmuv3.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9ca52a10a37..b37b388c75e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -297,6 +297,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 static void smmuv3_init_id_regs(SMMUv3State *s)
 {
     SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+    SMMUv3RegBank *sbank = smmuv3_bank(s, SMMU_SEC_SID_S);
 
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
@@ -343,7 +344,16 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN4K, 1);
     bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN16K, 1);
     bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN64K, 1);
+
     s->aidr = 0x1;
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
 
@@ -356,6 +366,7 @@ bool smmuv3_ats_enabled(SMMUv3State *s)
 static void smmuv3_reset(SMMUv3State *s)
 {
     SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
+    SMMUv3RegBank *sbank = smmuv3_bank(s, SMMU_SEC_SID_S);
 
     bank->cmdq.base = deposit64(bank->cmdq.base, 0, 5, SMMU_CMDQS);
     bank->cmdq.prod = 0;
@@ -375,6 +386,24 @@ static void smmuv3_reset(SMMUv3State *s)
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
     s->statusr = 0;
 }
 
-- 
2.34.1


