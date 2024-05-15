Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6C0C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8d-00005Q-Hs; Wed, 15 May 2024 05:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8H-0006Mi-7w
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:09 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8F-0001gg-A6
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:08 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34da04e44a2so5201469f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766064; x=1716370864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksMOhWi1ebKYWPT6NIQhKVjBPhPkqbNasmSW3ehCB8s=;
 b=YyCKh2Q/gVK6WelkKnqpWw11eEc5ncE9633JWKON0TnuwSjzuEL/E0EOa5vYgk/ZXn
 C6j53Mlsq04iw+Uqebclpoks44s/TlYy9u91hUe1vq0OoOsgS+nMX1bvWDT/PwtXBvZU
 DVhQLXaI1y0G6QqiD3sYMfEmXG5fCenrGaUVtejnom525nGEKE5w7G6e0+/UBEPyb5mS
 TUe9f0IRM5iqiJKqhZV8O7KVK/0k7bzKRdchLRka5a4D+QMWSSTKO7Gx961jtkU9f63Q
 HgBS4qHsvtgK8KOk4NkWwxGilagYHxItxshc5/7/UhEjf3eMN0nSkYojH8RgA8msAcoX
 BHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766064; x=1716370864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksMOhWi1ebKYWPT6NIQhKVjBPhPkqbNasmSW3ehCB8s=;
 b=V+acVExaECY9OceNjzH5ddQbgCPu/wheSnLx4oy8umJB/0usbLTO4auoA4XBE1dj3B
 HBHdUKPWzH+7r4fZgP5qYKK/DwClbfUk/SNtSBvzj4haKLdhpuNEfDKFamqy7tNHmV1T
 DZ50Gi/IdhGUrXZeDh7imMJPzmoqhY/g4fNk+YB5hP7GV8X4NJ6Yt731ghQPy+UORwoM
 iLVv+uVeWLNZ8sU9l/+FYkO0VQnABaO9oTGnKg5+X1TLZtn+O/ANNle72zrrZwlXsOQp
 oxWipHMot0jobylFzMCU86c92igZeiiWOCnbojjy52SrtzenHyb4JJpvMXPHkUqPiMIz
 1Qxw==
X-Gm-Message-State: AOJu0YyAmSDBQhYFx1m7ydzGAO+fAVdlWtFCobWv4eU4MOMAfMQXdeW8
 JjELZ0Ayq4VWX0+UIenBJRekQCuTu2ed05winJogtwvr6LHbooHJUGT/NIpKs2PdfKjRopX9YOO
 BKxU=
X-Google-Smtp-Source: AGHT+IEkcS7D4qGF9HaqadN2Kgxh9K4f/si18LJo7uJKeiPd1kOXzv2ebTRNaeSo2zbHAehmSLCakw==
X-Received: by 2002:a5d:628c:0:b0:34c:9e4a:e72c with SMTP id
 ffacd0b85a97d-3504a62271fmr11079986f8f.11.1715766063996; 
 Wed, 15 May 2024 02:41:03 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/43] target/hppa: Use TCG_COND_TST* in trans_ftest
Date: Wed, 15 May 2024 11:40:26 +0200
Message-Id: <20240515094043.82850-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index efd4398437..11d74bb2aa 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4311,6 +4311,8 @@ static bool trans_fcmp_d(DisasContext *ctx, arg_fclass2 *a)
 
 static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 {
+    TCGCond tc = TCG_COND_TSTNE;
+    uint32_t mask;
     TCGv_i64 t;
 
     nullify_over(ctx);
@@ -4319,21 +4321,18 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
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
@@ -4351,21 +4350,12 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
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


