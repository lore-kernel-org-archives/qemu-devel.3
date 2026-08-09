Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EEEC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC8A-0001H0-2d; Sun, 09 Aug 2026 18:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC87-00019o-Vb
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC86-0007Uo-5N
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d032846c95so15778595ad.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314989; x=1786919789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0BY9TIRrsUSJx50LoiD28uvbBs5FTX1e/Ge2Ja87Ilc=;
 b=Ga3bTE36iOJmekOLDYguOsKFhOM310JS54Unhe9yf2JkzxucgKxvkR/Ad3h7KcBNvR
 eloB3tVch7vmtYczd7MuFgZtETDodlz3Rgoj8ijo8tdNcsmPKxPL8h7I5LhRUoQDeDgu
 hrRsGrLcpkArUtBvtg58OiFBWmuush/k+iA4BQIbnyVt++/STQ10/jhU5UxpGj3ADeov
 YwS7tVLyjxOPnsIh1h/7HMEDDmLo0G6pc0GiZLMiaBx0NfhD2Tk6b3IAuATEVlCCy80Y
 /GqHvqa5HtrDVa/hw599IMrf7eBvhqrBTnfQJGMvDYYZ0Zho0yexriKeLVJTXbs7sd+5
 Ucpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314989; x=1786919789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0BY9TIRrsUSJx50LoiD28uvbBs5FTX1e/Ge2Ja87Ilc=;
 b=Bro4ypkSlONz+XGnfdMsqjErXSsBuEwMF9DJSlvUT/bs5MPcJMzDuJUt/fG2mZWwTi
 wNw564EqLyUQWim/edAzJOujduNzVTMPtlrZO+DX/kdrlodAahtMexNKs/qTFfszYu0w
 z/XOx4kpfOqLZXwFgJKJPR0ZBnhl9yoBeEzqg//jzwS/87Uwb83sDvnB/Rg9un6LPnY8
 YHUgM3SZ031jyyJ/DSi+u2fmWQ9Oj2ML1Nt+G53QQfoUIrW8CkxOfdMgJGcjI/QxN73H
 dI+KrDaT2D9Nr+MxH38ZXyvXLiCBEE1icSn5a0fFjrsjA39AB1BvWJxLveAwzMaJ/W3Y
 /HXg==
X-Gm-Message-State: AOJu0Yzt+JexGOt9gsSsrBhxGcbkuYJKfUzag/ZVmamSdegVkRKRRJ/K
 ioaI3mxx66x54R98gPUIs/KOnV21J32LElo/YzBYfILDktiwsTSoRRUXgTYmZljBLOFzYKccRKb
 DHSZi
X-Gm-Gg: AR+sD10EayUAQxGFcv8/F5n3ymjc6Ky1nu1Oy8r2nGPUQLKZRJDiW15yjxhkp97y5CU
 33S9i0nPZ3OEphTqsgM1T66zqEcPiqzlxqCE1oY0U0DiTx4X40guKGMQ940QoWBtlP/N4kCLi16
 hl80f3+8xDuygOCi+6iZPVn3N5rzYH1UbYoRfpNo3wd3Af2raLqQ/bLtrQGY1zVEzhKKoM8nd3j
 8/ch5vOVhspgV2v+qTgub1qtGhZ4/Q5EF7ilF1UiC1Px9HNAwcC06jIGN9WL4MDKSfHzuHej+h0
 o+J6rtgxUIJfllx3R+GJVjQRMsPmvH6dIPt8Gt1N/eot0HhdmIfLlyJ2fwHIU6q0RxSYta5Z0fX
 G0iZyt8ntyFVnGYpCa9/pbZIx+/e38j7wrRd/L3yf2p0noADqljOcCcLctLxTTQS7gVLYeDS+a8
 GH0+1MRPhhymT+IKr9pmPOMik7gpajY+G3sTugFiDocabGUVhDSPYR90Q6E3hccd+xA/66Oct6E
 vY82sLllm/fG5gsqBxr
X-Received: by 2002:a05:6a21:6013:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3cb85df2790mr48743228637.13.1786314988637; 
 Sun, 09 Aug 2026 15:36:28 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 34/56] disas/riscv: Tidy rv_comp_data terminators
Date: Sun,  9 Aug 2026 15:35:23 -0700
Message-ID: <20260809223545.730664-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use { } instead of two zeros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 9904b4db03..bb4779614b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1072,123 +1072,123 @@ static const rvc_constraint rvcc_true[] = { rvc_end };
 static const rv_comp_data rvcp_jal[] = {
     { rv_op_j, rvcc_j },
     { rv_op_jal_ra, rvcc_jal_ra },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_jalr[] = {
     { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
     { rv_op_jalr_ra, rvcc_jalr_ra },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_beq[] = {
     { rv_op_beqz, rvcc_beqz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_bne[] = {
     { rv_op_bnez, rvcc_bnez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_blt[] = {
     { rv_op_bltz, rvcc_bltz },
     { rv_op_bgtz, rvcc_bgtz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_bge[] = {
     { rv_op_blez, rvcc_blez },
     { rv_op_bgez, rvcc_bgez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_addi[] = {
     { rv_op_nop, rvcc_nop },
     { rv_op_mv, rvcc_mv },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sltiu[] = {
     { rv_op_seqz, rvcc_seqz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_xori[] = {
     { rv_op_not, rvcc_not },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sub[] = {
     { rv_op_neg, rvcc_neg },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_slt[] = {
     { rv_op_sltz, rvcc_sltz },
     { rv_op_sgtz, rvcc_sgtz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sltu[] = {
     { rv_op_snez, rvcc_snez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_addiw[] = {
     { rv_op_sext_w, rvcc_sext_w },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_subw[] = {
     { rv_op_negw, rvcc_negw },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_s[] = {
     { rv_op_fmv_s, rvcc_fmv_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_s[] = {
     { rv_op_fneg_s, rvcc_fneg_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_s[] = {
     { rv_op_fabs_s, rvcc_fabs_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_d[] = {
     { rv_op_fmv_d, rvcc_fmv_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_d[] = {
     { rv_op_fneg_d, rvcc_fneg_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_d[] = {
     { rv_op_fabs_d, rvcc_fabs_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_q[] = {
     { rv_op_fmv_q, rvcc_fmv_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_q[] = {
     { rv_op_fneg_q, rvcc_fneg_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_q[] = {
     { rv_op_fabs_q, rvcc_fabs_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 /* Convert compressed insns into normal insns via pseudo expansion. */
-- 
2.43.0


