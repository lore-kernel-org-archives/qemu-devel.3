Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02DCC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QR1-0004m1-Iy; Mon, 13 May 2024 03:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPM-0002sB-QJ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPL-0001Ob-45
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41ff5e3d86aso18015185e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586458; x=1716191258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kyk3Oth1w710DgibqvngAchg1UuHlBEgrDks+71JwQE=;
 b=RK9plY/nM/kWhP/m0z5VbueYFDbUrmHPR7CGQo+ZJTUh8bYM03qcEbEAFOf52bIlX9
 hjyFtaQ3dgljDxyYf1kxqEu9ITVlAcU32W4ckC7HOCHF4SIBRTH4jar1fdjGVYDvDXlK
 uW+mL4uCX96Z5PoNVbbUCw9GyZ4BLptaXFtQr2VtnnLzHNcCzFoyJWxaF6NZtJZpQ2ah
 8RPcnqvzfhH0/9xs9f9yNu6I87eIcT1C9koV9jWsXx5kFICXeoYMuDdwLXHD+r5ea4qh
 VDivRCd1VxwYbH2oC2jqBdLunO0WuWi+eSPSW6VcmFTUWyLssnTkBY3EbYaCIbu626se
 aNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586458; x=1716191258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kyk3Oth1w710DgibqvngAchg1UuHlBEgrDks+71JwQE=;
 b=llU/Lv+31bUFzCC24/F8fN/xkv+1b9nXYB/0QKkfFrL31Mv6i/g5kZaTS9azEA70r7
 +Wsfxwfh48WwaQAze53nt3bFppGwLv7WyJ0FSnsxJ2vsiodeQJX9lR+Ueb1Z2jG7ON1W
 wPozjoTCcJr/egQ+6ZVPjBr/pjSaJ/C1z4iXMrJt5ePTWxpjCo0vJg18ovKuHlizI3ts
 a0AHD3QRBrDcudaV8esVbssZc0xEXnCoXBC/rgJSws3ErdadsCqrOMuwimxlLGMBz82q
 TyuTFNeZo2RvWAx3PTDdWvc73Q8YlMthySAdvpp0/0KAUFgoS323M1FdMz4EqieRcZb1
 LcgA==
X-Gm-Message-State: AOJu0YwaxTPtRRqkAtSv0hL6WPue4jg3yzymcApHrur4wYQU+wYuq+0D
 mWeBFThBx/4eGQn8nIs7b2S8VTrOPdSjN/cHpQOwsDL7rs4hGbiNNOscqzcymq23UVaAjEnEV7f
 NxwE=
X-Google-Smtp-Source: AGHT+IERuaOk0AToTADZAKMaQrqV+MokRo8n69cD+2syQeiVrBEgj0ShSUAOCsrVvhoHJOhhwekHwQ==
X-Received: by 2002:a05:600c:3508:b0:41b:f2ca:19cc with SMTP id
 5b1f17b1804b1-41fead61b26mr68652765e9.34.1715586457858; 
 Mon, 13 May 2024 00:47:37 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 26/45] target/hppa: Use TCG_COND_TST* in trans_ftest
Date: Mon, 13 May 2024 09:46:58 +0200
Message-Id: <20240513074717.130949-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6d76599ea0..ef62cd7e94 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4310,6 +4310,8 @@ static bool trans_fcmp_d(DisasContext *ctx, arg_fclass2 *a)
 
 static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 {
+    TCGCond tc = TCG_COND_TSTNE;
+    uint32_t mask;
     TCGv_i64 t;
 
     nullify_over(ctx);
@@ -4318,21 +4320,18 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
     tcg_gen_ld32u_i64(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
 
     if (a->y == 1) {
-        int mask;
-        bool inv = false;
-
         switch (a->c) {
         case 0: /* simple */
             mask = R_FPSR_C_MASK;
             break;
         case 2: /* rej */
-            inv = true;
+            tc = TCG_COND_TSTEQ;
             /* fallthru */
         case 1: /* acc */
             mask = R_FPSR_C_MASK | R_FPSR_CQ_MASK;
             break;
         case 6: /* rej8 */
-            inv = true;
+            tc = TCG_COND_TSTEQ;
             /* fallthru */
         case 5: /* acc8 */
             mask = R_FPSR_C_MASK | R_FPSR_CQ0_6_MASK;
@@ -4350,21 +4349,12 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
             gen_illegal(ctx);
             return true;
         }
-        if (inv) {
-            TCGv_i64 c = tcg_constant_i64(mask);
-            tcg_gen_or_i64(t, t, c);
-            ctx->null_cond = cond_make_tt(TCG_COND_EQ, t, c);
-        } else {
-            tcg_gen_andi_i64(t, t, mask);
-            ctx->null_cond = cond_make_ti(TCG_COND_EQ, t, 0);
-        }
     } else {
         unsigned cbit = (a->y ^ 1) - 1;
-
-        tcg_gen_extract_i64(t, t, R_FPSR_CA0_SHIFT - cbit, 1);
-        ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
+        mask = R_FPSR_CA0_MASK >> cbit;
     }
 
+    ctx->null_cond = cond_make_ti(tc, t, mask);
     return nullify_end(ctx);
 }
 
-- 
2.34.1


