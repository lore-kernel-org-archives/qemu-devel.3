Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9755BC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QQ6-0003l8-Uw; Mon, 13 May 2024 03:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPS-0002uW-7D
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:46 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPH-0001NN-Kd
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:45 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51f0b6b682fso4225651e87.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586453; x=1716191253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytQjG6Gl1mpHlQJot6xkpWtqvAkw0tueQGjZp7W5mw4=;
 b=l0cNlrTBcqe4hSF4R5C70MVvDl+7d8ZenfkqzLkLCoTG3qKBmUvHWUPtBvQZBNyChA
 VlWgdJ5jsOaMNJV0wmEnHBlI1zUx+6Rk9RYC5fEnzq11eZREm4LNcHb0HkXd6T/93cLa
 brztfHzedZZWWTFqiQKlHLrJeQzVqlZxS4/b5V/5Yrbd684/m7h+3/T+p6DfjKqTYNoc
 k3HKGhgPpSSSwdmwHo5A67fp7IwXNMPPhl8FpanH8GYjbQQduVikFPIWxEeHjLLaGMWg
 U/Ld4APZB0umr1bftY8j2IWjY1kxmzSVdHFN6q7oujuLhM1AW5qbaHQubV8+ZP9rtqYD
 N+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586453; x=1716191253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytQjG6Gl1mpHlQJot6xkpWtqvAkw0tueQGjZp7W5mw4=;
 b=FZyPyzvtP7x8RxRLsilcWlqiFDknALcwrqS9LNsMX82fM5su27mhxptetGS8ay/n9A
 vswaEGRVVPgfnAIV9XKPXxHyZ1Ifnt84pn9OU6M4UqEJU+xBPbPARE+ycCinwDEHPtDT
 p1XQNvh6hnMKtjzGDXrG82djYlvgCztdZgeJSA5LrwHyb/NXtduI28oNDmNkZGZ+u3d+
 U8TaNvHsmGHl1iV5eBV6kB83bfdhsSysR5QsleX1jauucS24SHKhN/eLnplik5al4XPs
 mR9j1PHfeSwB8Za/FxQy/hawB65loq1kzeuvNhybdwqjc9jhOCX8Zxk06xt+oWf4NhH+
 8+yQ==
X-Gm-Message-State: AOJu0YzpyPsnJstqC0OzHqs2VVvwG/QhdpD07E7nqHZpki2l4lKKSG4L
 bqZByjO8dL9u0dqRSxO8E7rRDP0KGRa6kJSOYT9kterCE6b08Re0acb/+6AoA3g0YbtXIiVjyT5
 eOH0=
X-Google-Smtp-Source: AGHT+IGjP/C9p/dykiyAYCYmu1H2h8b9AKPb9O1TetmGeTafyVqcVJWNYEoZb0WCE4iR+n62Iwb8Jw==
X-Received: by 2002:a05:6512:32ba:b0:521:43b2:3194 with SMTP id
 2adb3069b0e04-5220fd7bf83mr8637146e87.41.1715586453445; 
 Mon, 13 May 2024 00:47:33 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 20/45] target/hppa: Use TCG_COND_TST* in do_cond
Date: Mon, 13 May 2024 09:46:52 +0200
Message-Id: <20240513074717.130949-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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
index 5e32d985c9..421b0df9d4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -775,28 +775,36 @@ static bool cond_need_cb(int c)
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
@@ -804,21 +812,15 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
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
@@ -826,23 +828,13 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
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


