Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC9AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY9-0008O5-9S; Wed, 24 Apr 2024 20:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXi-0008Cr-Tr
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXf-0006Fn-89
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e8f68f8e0dso2724715ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003245; x=1714608045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sBoMtRpNUhZyyUE2ok4zpDnqVYPF1BDMLN5qK7vk7BM=;
 b=MI+GrggG0FEWCi5hRH95Se/GYnpgmLRb0JWkBleae7nr5pKsR3Jf+efrpHpt/7C3o5
 08HVtHtQLM3ElEbXr+HxEpeB07E4IBdkGFapr4whcPFfmFuNY/QGrXl5egHdvPc8jJSb
 Sa60xREBgywn7/XiHbwiTclwNRCn3TThITvwSkS9K8YG5QJwMddbYMHhQJ8n7Ha/lJV+
 /Ytdo/aq1VqbDvKwIICdjWPBirOrGG/ND6jHgzwfMzMYtqvAKRMb1TdzbQPIzP7kv3ih
 Dg1CH20LOVXVlgmld1gZRgQUDogMljcPJk0Vd8ec/q2dsaHr5HyQ0YdyufYtGCI9LSkG
 Va8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003245; x=1714608045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBoMtRpNUhZyyUE2ok4zpDnqVYPF1BDMLN5qK7vk7BM=;
 b=olUFlvg7Oe5yU+XkKhz0/UrlHOIsEhKGP0ffWTKAoul+Q2t1MlxfYHMT1S+wvUZmT8
 7FgfF74dlK08vyXKnOYbshqPqTOQ7z5aLiWzv8nKxKZAtWJQ7ug666Wadb5XUm5Q5RJ+
 vFPm2wWYdUcDmgi9MIC+eiBDm0DAFzCL4Bdmn1Q7tUUn6ztgmcXioeWj9L0n9nC0Lft7
 RY/i9IXrWV8ql71YdJPWyMXkqAcM1rBIt4NyL8gI+oQGc/EWUjmIbWBupuEHsRqhs12v
 ZOV+0x9JA06/6ZPxuEnRVfcgo0VcPLXDab1kfe+/6HKFa6yO+athLnUlGR1I4h+3tbA4
 g15Q==
X-Gm-Message-State: AOJu0YzUizrMNqvb1DOw3YslH9mJf744890Dhp5BAx5JQGY4NA7iANK/
 9vWQMAD1a1CvAtJHuYFFBi0R+mIKc6E9zj9lDgp6b7J4lYCa2Psl9bGdYv26mlRR52XptGGUlkn
 T
X-Google-Smtp-Source: AGHT+IH9kySejIxStLO8Fg2NjWFnOHlHDgOyvBXp88YSjbrcK6d+4ZaFKaBhv11BZA+6opMqTCIZFg==
X-Received: by 2002:a17:903:2a8b:b0:1e4:cb0e:2988 with SMTP id
 lv11-20020a1709032a8b00b001e4cb0e2988mr5316445plb.2.1714003245139; 
 Wed, 24 Apr 2024 17:00:45 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/45] target/hppa: Use TCG_COND_TST* in do_cond
Date: Wed, 24 Apr 2024 16:59:58 -0700
Message-Id: <20240425000023.1002026-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 64 ++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a1132c884f..85941f191f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -774,28 +774,36 @@ static bool cond_need_cb(int c)
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
@@ -803,21 +811,15 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
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
@@ -825,23 +827,13 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
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


