Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0B3C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8F-0006D2-BR; Wed, 15 May 2024 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8C-0005u9-8A
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B89-0001fY-EF
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34d7a32bdd3so3915388f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766060; x=1716370860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoUJ/XePo7kWT/3zZI4lYWlaHp1tQqpPfuSuynDreWc=;
 b=oDwp6RQCwT3fT2LCGSSGQNJ4igVLJ0EmvPBZK6KGqGC/C2xAV88Ds9pj78gKTA8QAr
 xvgv8Nx6wXBt2bi1izZ8/zDU9IIZ0OM6vcCwtQ8peXTe+c85zYNdtlqmV2Ioh5ioJx0e
 /+p69M+1za3aFyQeGW8RZEaTMWES4OLKCHMQzNE62FGYMUGH+uBQbdEhuOhVc9Y3pvyd
 5czDbXaLMwJmZk/mCrjTt2++LWL0WbvG02EglKQb0OYQVGETydJN1vsZuNtk3h14YP2e
 NQOpl9RcADyfkLNC7OTJ1K/Ovc98SGB26VvXzR+hZztEBcJdp4wIlHYEkifqgpMZ97kh
 rfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766060; x=1716370860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoUJ/XePo7kWT/3zZI4lYWlaHp1tQqpPfuSuynDreWc=;
 b=k+q7f3VqcVGGonm/pkcTgFQCMzTtP+HMc/2S53EDB4YWrw6z9910DC+F4btCQ4vZpN
 IiWTXsvSxdfSpv8gCGNnWajk6MI32G1fEZAEJWrY/nzTT564CA6ZTtSizdGzJAHIVgnB
 hN3Qn6XjtVLkhZl7RzOmeXzovpHi8IaQqh9INZlLcZEqQNvbsTuhgT/HvxYxrh65krBM
 oQbN0VfakB3+8Y4pU8/pq39alXQYavwGPzuVonntim2mShf2/8ry79n40Ve+rnW5Hi56
 udXjJcWdf9r4DQEfa43xIlvfyqV8qLIf4hoIjEtLeCgqj3lhDTqxErrnHTmsomOOjS0u
 pCxA==
X-Gm-Message-State: AOJu0YwZwnaaS+Iqy4BjfpfCQSNjlHYBmsrL4QqMExfdI70ne1n9yWZd
 2jtxPCh5YMhEC3JpzwlbYoSYjRKOKosjDzXy+Rnh3VU7Nz6jDHshyVqzwYAX7158QP9aqZ5W4Qo
 7wUc=
X-Google-Smtp-Source: AGHT+IEC+EE6EQnni4cAUTYSr6qJbe1TmpI6u7Ecg804cSEOuKMo0653W8B4S/i34oc2q68wZRjHxA==
X-Received: by 2002:a05:6000:1105:b0:34d:8dee:923d with SMTP id
 ffacd0b85a97d-3504a6364e7mr9797113f8f.25.1715766059984; 
 Wed, 15 May 2024 02:40:59 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 20/43] target/hppa: Use TCG_COND_TST* in do_cond
Date: Wed, 15 May 2024 11:40:20 +0200
Message-Id: <20240515094043.82850-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

We can directly test bits of a 32-bit comparison without
zero or sign-extending an intermediate result.
We can directly test bit 0 for odd/even.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 64 ++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 07ba35001b..813f1571e9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -776,28 +776,36 @@ static bool cond_need_cb(int c)
 static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
                          TCGv_i64 res, TCGv_i64 uv, TCGv_i64 sv)
 {
+    TCGCond sign_cond, zero_cond;
+    uint64_t sign_imm, zero_imm;
     DisasCond cond;
     TCGv_i64 tmp;
 
+    if (d) {
+        /* 64-bit condition. */
+        sign_imm = 0;
+        sign_cond = TCG_COND_LT;
+        zero_imm = 0;
+        zero_cond = TCG_COND_EQ;
+    } else {
+        /* 32-bit condition. */
+        sign_imm = 1ull << 31;
+        sign_cond = TCG_COND_TSTNE;
+        zero_imm = UINT32_MAX;
+        zero_cond = TCG_COND_TSTEQ;
+    }
+
     switch (cf >> 1) {
     case 0: /* Never / TR    (0 / 1) */
         cond = cond_make_f();
         break;
     case 1: /* = / <>        (Z / !Z) */
-        if (!d) {
-            tmp = tcg_temp_new_i64();
-            tcg_gen_ext32u_i64(tmp, res);
-            res = tmp;
-        }
-        cond = cond_make_vi(TCG_COND_EQ, res, 0);
+        cond = cond_make_vi(zero_cond, res, zero_imm);
         break;
     case 2: /* < / >=        (N ^ V / !(N ^ V) */
         tmp = tcg_temp_new_i64();
         tcg_gen_xor_i64(tmp, res, sv);
-        if (!d) {
-            tcg_gen_ext32s_i64(tmp, tmp);
-        }
-        cond = cond_make_ti(TCG_COND_LT, tmp, 0);
+        cond = cond_make_ti(sign_cond, tmp, sign_imm);
         break;
     case 3: /* <= / >        (N ^ V) | Z / !((N ^ V) | Z) */
         /*
@@ -805,21 +813,15 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
          *   (N ^ V) | Z
          *   ((res < 0) ^ (sv < 0)) | !res
          *   ((res ^ sv) < 0) | !res
-         *   (~(res ^ sv) >= 0) | !res
-         *   !(~(res ^ sv) >> 31) | !res
-         *   !(~(res ^ sv) >> 31 & res)
+         *   ((res ^ sv) < 0 ? 1 : !res)
+         *   !((res ^ sv) < 0 ? 0 : res)
          */
         tmp = tcg_temp_new_i64();
-        tcg_gen_eqv_i64(tmp, res, sv);
-        if (!d) {
-            tcg_gen_sextract_i64(tmp, tmp, 31, 1);
-            tcg_gen_and_i64(tmp, tmp, res);
-            tcg_gen_ext32u_i64(tmp, tmp);
-        } else {
-            tcg_gen_sari_i64(tmp, tmp, 63);
-            tcg_gen_and_i64(tmp, tmp, res);
-        }
-        cond = cond_make_ti(TCG_COND_EQ, tmp, 0);
+        tcg_gen_xor_i64(tmp, res, sv);
+        tcg_gen_movcond_i64(sign_cond, tmp,
+                            tmp, tcg_constant_i64(sign_imm),
+                            ctx->zero, res);
+        cond = cond_make_ti(zero_cond, tmp, zero_imm);
         break;
     case 4: /* NUV / UV      (!UV / UV) */
         cond = cond_make_vi(TCG_COND_EQ, uv, 0);
@@ -827,23 +829,13 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
     case 5: /* ZNV / VNZ     (!UV | Z / UV & !Z) */
         tmp = tcg_temp_new_i64();
         tcg_gen_movcond_i64(TCG_COND_EQ, tmp, uv, ctx->zero, ctx->zero, res);
-        if (!d) {
-            tcg_gen_ext32u_i64(tmp, tmp);
-        }
-        cond = cond_make_ti(TCG_COND_EQ, tmp, 0);
+        cond = cond_make_ti(zero_cond, tmp, zero_imm);
         break;
     case 6: /* SV / NSV      (V / !V) */
-        if (!d) {
-            tmp = tcg_temp_new_i64();
-            tcg_gen_ext32s_i64(tmp, sv);
-            sv = tmp;
-        }
-        cond = cond_make_ti(TCG_COND_LT, sv, 0);
+        cond = cond_make_vi(sign_cond, sv, sign_imm);
         break;
     case 7: /* OD / EV */
-        tmp = tcg_temp_new_i64();
-        tcg_gen_andi_i64(tmp, res, 1);
-        cond = cond_make_ti(TCG_COND_NE, tmp, 0);
+        cond = cond_make_vi(TCG_COND_TSTNE, res, 1);
         break;
     default:
         g_assert_not_reached();
-- 
2.34.1


