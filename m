Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34611CD11DB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 03:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roadw-0001P0-KC; Sun, 24 Mar 2024 23:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roadu-0001OG-IM
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:04:58 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roads-0001tK-Cd
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:04:58 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3c3ca3c3bbaso526243b6e.0
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 20:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711335895; x=1711940695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ygd2hohHyz1hjnK91t3c4RKZU1JwhP7r3ax20czZi4=;
 b=Hol11W7rJ89O9dYn62GedeZr5zUhvcr8Acaqq3waWETGcwMfACSnxhtkXDPqDuMwaj
 wSt735RPEbLHYUxLwNvTWHYPhqoRPODPFHFTnqXl4L2HtlOVK5QBPz09iUj4nlmjPXUG
 zMAII4CrJLyncVBk4zSSl0A1i8hhuuYL01Gwsb2QM41uctq9YVa/+C3ZoGUvP2oC2Qzz
 lbtqxfTPMpZuus7iwRAg+RnhXHEayAm24YBxt4Xxt3THhFI5439z3fJayfcQi0YozF5M
 x98g2ys0BIdDW31rYkYgFW5DwP8kim4QOJKlYlPrEdM+jG3Ccvt0gFKiPT2Zr1pxPV8V
 C8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711335895; x=1711940695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ygd2hohHyz1hjnK91t3c4RKZU1JwhP7r3ax20czZi4=;
 b=KCPkg2qkaFhKVE87ATHMejVtZAkArITSRHWVtt4aqSWiXTjA8Y6cw63dSMKnCLgi3/
 kUJP7BB9X0i2YkNz1wI5LoL4ksbwFcHCAs/+x6I5hyBJFEULDiPrqASsdxKwAFsw8CFs
 a9ThNOIwz4yY1ZtmVuwPcp/Fbii0Tt2z2V4SUavoBGG8SU878uA0jAQkmaZrY9+AxDhZ
 4OjH+rvhbL+IvOWVs6Jf95P72wZyqHrcqI3WlnXehvfFq714SqUO3EtzWWJO/+hQLEnd
 BpstC+hBqZT3slUbHIG6FPdRqeqyN7zA5/jba1FuvETdEaHeDN4nzRTClce+UwWthK74
 es3Q==
X-Gm-Message-State: AOJu0Yxqqc2Nw8stAW/fqZrXuE0ShDOSbQVxGsFYUWHA17fZcJp7JhRN
 HbH/xqdSgsS27QGAe6Fyf8/JFSfREMpwFzSKifuzmk4xQlPSFFfKn5bqFuEQLx3alBlyAU4xG+N
 8
X-Google-Smtp-Source: AGHT+IEzX4aaHjG+RXOI50+mZHfEpvki7dhRcCABnjset9koMEvlrgIMVWX2I49z1c1iEI5HT2ocyw==
X-Received: by 2002:a05:6808:613:b0:3c3:8308:85d2 with SMTP id
 y19-20020a056808061300b003c3830885d2mr6288690oih.34.1711335894898; 
 Sun, 24 Mar 2024 20:04:54 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q12-20020aa7982c000000b006e6b4c637b6sm3291880pfl.116.2024.03.24.20.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 20:04:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 3/3] target/hppa: Fix unit carry conditions
Date: Sun, 24 Mar 2024 17:04:48 -1000
Message-Id: <20240325030448.52110-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325030448.52110-1-richard.henderson@linaro.org>
References: <20240325030448.52110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

Split do_unit_cond to do_unit_zero_cond to only handle
conditions versus zero.  These are the only ones that
are legal for UXOR.  Simplify trans_uxor accordingly.

Rename do_unit to do_unit_addsub, since xor has been split.
Properly compute carry-out bits for add and subtract,
mirroring the code in do_add and do_sub.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 214 ++++++++++++++++++++--------------------
 1 file changed, 109 insertions(+), 105 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3fc3e7754c..2bf213c938 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -936,98 +936,44 @@ static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, bool d,
     return do_log_cond(ctx, c * 2 + f, d, res);
 }
 
-/* Similar, but for unit conditions.  */
-
-static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
-                              TCGv_i64 in1, TCGv_i64 in2)
+/* Similar, but for unit zero conditions.  */
+static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
 {
-    DisasCond cond;
-    TCGv_i64 tmp, cb = NULL;
+    TCGv_i64 tmp;
     uint64_t d_repl = d ? 0x0000000100000001ull : 1;
-
-    if (cf & 8) {
-        /* Since we want to test lots of carry-out bits all at once, do not
-         * do our normal thing and compute carry-in of bit B+1 since that
-         * leaves us with carry bits spread across two words.
-         */
-        cb = tcg_temp_new_i64();
-        tmp = tcg_temp_new_i64();
-        tcg_gen_or_i64(cb, in1, in2);
-        tcg_gen_and_i64(tmp, in1, in2);
-        tcg_gen_andc_i64(cb, cb, res);
-        tcg_gen_or_i64(cb, cb, tmp);
-    }
+    uint64_t ones = 0, sgns = 0;
 
     switch (cf >> 1) {
-    case 0: /* never / TR */
-        cond = cond_make_f();
-        break;
-
     case 1: /* SBW / NBW */
         if (d) {
-            tmp = tcg_temp_new_i64();
-            tcg_gen_subi_i64(tmp, res, d_repl * 0x00000001u);
-            tcg_gen_andc_i64(tmp, tmp, res);
-            tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80000000u);
-            cond = cond_make_0(TCG_COND_NE, tmp);
-        } else {
-            /* undefined */
-            cond = cond_make_f();
+            ones = d_repl;
+            sgns = d_repl << 31;
         }
         break;
-
     case 2: /* SBZ / NBZ */
-        /* See hasless(v,1) from
-         * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
-         */
-        tmp = tcg_temp_new_i64();
-        tcg_gen_subi_i64(tmp, res, d_repl * 0x01010101u);
-        tcg_gen_andc_i64(tmp, tmp, res);
-        tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80808080u);
-        cond = cond_make_0(TCG_COND_NE, tmp);
+        ones = d_repl * 0x01010101u;
+        sgns = ones << 7;
         break;
-
     case 3: /* SHZ / NHZ */
-        tmp = tcg_temp_new_i64();
-        tcg_gen_subi_i64(tmp, res, d_repl * 0x00010001u);
-        tcg_gen_andc_i64(tmp, tmp, res);
-        tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80008000u);
-        cond = cond_make_0(TCG_COND_NE, tmp);
+        ones = d_repl * 0x00010001u;
+        sgns = ones << 15;
         break;
-
-    case 4: /* SDC / NDC */
-        tcg_gen_andi_i64(cb, cb, d_repl * 0x88888888u);
-        cond = cond_make_0(TCG_COND_NE, cb);
-        break;
-
-    case 5: /* SWC / NWC */
-        if (d) {
-            tcg_gen_andi_i64(cb, cb, d_repl * 0x80000000u);
-            cond = cond_make_0(TCG_COND_NE, cb);
-        } else {
-            /* undefined */
-            cond = cond_make_f();
-        }
-        break;
-
-    case 6: /* SBC / NBC */
-        tcg_gen_andi_i64(cb, cb, d_repl * 0x80808080u);
-        cond = cond_make_0(TCG_COND_NE, cb);
-        break;
-
-    case 7: /* SHC / NHC */
-        tcg_gen_andi_i64(cb, cb, d_repl * 0x80008000u);
-        cond = cond_make_0(TCG_COND_NE, cb);
-        break;
-
-    default:
-        g_assert_not_reached();
     }
-    if (cf & 1) {
-        cond.c = tcg_invert_cond(cond.c);
+    if (ones == 0) {
+        /* Undefined, or 0/1 (never/always). */
+        return cf & 1 ? cond_make_t() : cond_make_f();
     }
 
-    return cond;
+    /*
+     * See hasless(v,1) from
+     * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
+     */
+    tmp = tcg_temp_new_i64();
+    tcg_gen_subi_i64(tmp, res, ones);
+    tcg_gen_andc_i64(tmp, tmp, res);
+
+    return cond_make_tmp(cf & 1 ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                         tmp, tcg_constant_i64(sgns));
 }
 
 static TCGv_i64 get_carry(DisasContext *ctx, bool d,
@@ -1330,34 +1276,82 @@ static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
     return nullify_end(ctx);
 }
 
-static void do_unit(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
-                    TCGv_i64 in2, unsigned cf, bool d, bool is_tc,
-                    void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
+static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
+                           TCGv_i64 in2, unsigned cf, bool d,
+                           bool is_tc, bool is_add)
 {
-    TCGv_i64 dest;
+    TCGv_i64 dest, cb = NULL;
+    uint64_t test_cb = 0;
     DisasCond cond;
 
-    if (cf == 0) {
-        dest = dest_gpr(ctx, rt);
-        fn(dest, in1, in2);
-        save_gpr(ctx, rt, dest);
-        cond_free(&ctx->null_cond);
-    } else {
-        dest = tcg_temp_new_i64();
-        fn(dest, in1, in2);
-
-        cond = do_unit_cond(cf, d, dest, in1, in2);
-
-        if (is_tc) {
-            TCGv_i64 tmp = tcg_temp_new_i64();
-            tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-            gen_helper_tcond(tcg_env, tmp);
+    /* Select which carry-out bits to test. */
+    switch (cf >> 1) {
+    case 4: /* NDC / SDC -- 4-bit carries */
+        test_cb = 0x8888888888888888ull;
+        break;
+    case 5: /* NWC / SWC -- 32-bit carries */
+        if (d) {
+            test_cb = 0x8000000080000000ull;
+        } else {
+            cf &= 1; /* undefined -- map to never/always */
         }
-        save_gpr(ctx, rt, dest);
-
-        cond_free(&ctx->null_cond);
-        ctx->null_cond = cond;
+        break;
+    case 6: /* NBC / SBC -- 8-bit carries */
+        test_cb = 0x8080808080808080ull;
+        break;
+    case 7: /* NHC / SHC -- 16-bit carries */
+        test_cb = 0x8000800080008000ull;
+        break;
     }
+
+    dest = tcg_temp_new_i64();
+    if (test_cb) {
+        cb = tcg_temp_new_i64();
+        if (d) {
+            TCGv_i64 cb_msb = tcg_temp_new_i64();
+            if (is_add) {
+                tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx->zero);
+                tcg_gen_xor_i64(cb, in1, in2);
+            } else {
+                /* See do_sub, !is_b. */
+                TCGv_i64 one = tcg_constant_i64(1);
+                tcg_gen_sub2_i64(dest, cb_msb, in1, one, in2, ctx->zero);
+                tcg_gen_eqv_i64(cb, in1, in2);
+            }
+            tcg_gen_xor_i64(cb, cb, dest);
+            /* For 64-bit tests, put all carry-out bits back in one word. */
+            tcg_gen_extract2_i64(cb, cb, cb_msb, 1);
+        } else {
+            if (is_add) {
+                tcg_gen_add_i64(dest, in1, in2);
+                tcg_gen_xor_i64(cb, in1, in2);
+            } else {
+                tcg_gen_sub_i64(dest, in1, in2);
+                tcg_gen_eqv_i64(cb, in1, in2);
+            }
+            /* For 32-bit tests, test carry-in instead of carry-out. */
+            test_cb = (uint64_t)(uint32_t)test_cb << 1;
+        }
+        cond = cond_make_tmp(cf & 1 ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                             cb, tcg_constant_i64(test_cb));
+    } else {
+        if (is_add) {
+            tcg_gen_add_i64(dest, in1, in2);
+        } else {
+            tcg_gen_sub_i64(dest, in1, in2);
+        }
+        cond = do_unit_zero_cond(cf, d, dest);
+    }
+
+    if (is_tc) {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
+        gen_helper_tcond(tcg_env, tmp);
+    }
+    save_gpr(ctx, rt, dest);
+
+    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -2748,14 +2742,24 @@ static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf_d *a)
 
 static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
 {
-    TCGv_i64 tcg_r1, tcg_r2;
+    TCGv_i64 tcg_r1, tcg_r2, dest;
 
     if (a->cf) {
         nullify_over(ctx);
     }
+
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_unit(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d, false, tcg_gen_xor_i64);
+    dest = dest_gpr(ctx, a->t);
+
+    tcg_gen_xor_i64(dest, tcg_r1, tcg_r2);
+    save_gpr(ctx, a->t, dest);
+
+    cond_free(&ctx->null_cond);
+    if (a->cf) {
+        ctx->null_cond = do_unit_zero_cond(a->cf, a->d, dest);
+    }
+
     return nullify_end(ctx);
 }
 
@@ -2790,7 +2794,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
     tcg_r2 = load_gpr(ctx, a->r2);
     tmp = tcg_temp_new_i64();
     tcg_gen_not_i64(tmp, tcg_r2);
-    do_unit(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, tcg_gen_add_i64);
+    do_unit_addsub(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, true);
     return nullify_end(ctx);
 }
 
@@ -2817,8 +2821,8 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf_d *a, bool is_i)
     }
     tcg_gen_andi_i64(tmp, tmp, (uint64_t)0x1111111111111111ull);
     tcg_gen_muli_i64(tmp, tmp, 6);
-    do_unit(ctx, a->t, load_gpr(ctx, a->r), tmp, a->cf, a->d, false,
-            is_i ? tcg_gen_add_i64 : tcg_gen_sub_i64);
+    do_unit_addsub(ctx, a->t, load_gpr(ctx, a->r), tmp,
+                   a->cf, a->d, false, is_i);
     return nullify_end(ctx);
 }
 
-- 
2.34.1


