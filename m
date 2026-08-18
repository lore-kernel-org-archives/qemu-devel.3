Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE75C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCb-0007S3-UH; Tue, 18 Aug 2026 13:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCa-0007RF-3m
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:16 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCY-0004ip-52
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:15 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso181952b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072533; x=1787677333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sZpPOKytJxm4lwxbTGWqFKnd4UF37njKhCHk600PrmQ=;
 b=acYOuWdD2tma/CLQzvPM6PVBljqD9OLofTkHVEpgVWdPJk8buZmP1IY16OzKBB8zvg
 GVhQJ9nFiqEvf+RZ50VEbkgATTknf+FRCQJaHdC7XxgueIwzBoGAi87Sr0n6vByp8ZVo
 WLNHQyAkFRp2tTFY07ryGgEJ1SNM9wpPb8nPRnXmWEgFoxtYNqmjK2uyNX745jouw4Gr
 ta7kCz48UesCvLa+XCqOXfLm7FyckZekCOj7wKeO5PfQY5HaHquuWjxXDAA9aVHAgSiT
 u/zZbqQ1iRNd1sbW9/CBz5l1Yo2jgOQBZ7Hgo3ef/0Ejzo+gsM/wDmT0qTDal9IX2J89
 LGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072533; x=1787677333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sZpPOKytJxm4lwxbTGWqFKnd4UF37njKhCHk600PrmQ=;
 b=Aj8CVFS5wKyilqh2YHakPi4j6VbVlQlcucAK3vR9pKHjoBwLbQ9O23jylSPo91r8m1
 7tDilSXsqrnkKrjm8UK1d+icfeO/CZgEiWZy+16P3C5pM8cXLECKtkXVFK0urWgn6Ow7
 EMwJEZ4x6P4CaZWAHdUQgNB5ilI+B7v+hd0GYyiFA16jhfnoR3WcCEVrQQqtpGi5tm/E
 sUrMBIF3rQhAKBieGpn0SIu9E9UqxuPPo9mMhBoAyQxdqObgXaK3zYTYprJuTBy2AuPA
 +r/zqW53DUmvYJTlNk1744kO2/QaNAoqygW8KFDfykCEdS1m2F0psQuyXCTAL+UMAYAn
 t6cw==
X-Gm-Message-State: AOJu0Yyf2d4VroyUdo6oQJUME+caoFx/oY+BA+Loi9k5/+wYCwAl6kLw
 Cyif1m0FGrMAkDG3wjwpg9yESij/ZvZUOX/vYWf254wxBGk/374xKUEW6RTPDsoWe9XCnZZQLdV
 dRhpavwg=
X-Gm-Gg: AR+sD11q/a55ZZwm8U/PRdV0MeIuAzBZM7EezZLHCyp7lON7we9B5Ia/QfPYnyEi1zS
 C4wypeVxVstW8BGsnJdsNmGJ4vcSKwN04kjfcw9Io8rehkz0sS84KAh9porYxD/UN6csg4i1Yqo
 1kCEOy1t/zW+4vBFHRHAWoRVo4F6cPSkFgVWDnFuptzSpzLfcb8PYTe+POwp96V+XooiUkMA8Jq
 VWjVOunBAmeSnkUmv77dPaxdLJkI9IBmYoC7IE9pOhT5rrcMW0QWq5knlLpC9NsVcrhHf6JHT5C
 OdfskfShP/swy2z4IP3YJexfmAOK6nFFkU1VuzYMupKUIyz/wGnOrkb2kfq7VGtlHsbpdNmILA0
 bSrQaeOBUbpoD4tL+378MxsXekJZwdX5/Sv1iwGAEg4aXlRsdqF3mdHlq2DMstMA0H73QXAZEEM
 NAuIgGd2aw3alSzFGAmHAKXx02gCkSTshn5ZiVqVG9ExZXXvhWy6ZkRGI69/wdFeTpWQhfv653+
 7LN0y16NlN89+OKaHx9p5xKSePFOioa+yxo
X-Received: by 2002:a05:6a00:2e85:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-84fddfa8508mr34565966b3a.7.1787072532481; 
 Tue, 18 Aug 2026 10:02:12 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 12/38] target/mips: Expand octeon reflections inline
Date: Tue, 18 Aug 2026 10:01:29 -0700
Message-ID: <20260818170155.1907006-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Use tcg_gen_revbit64_i64 instead of out-of-line helpers.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/helper.h               |  7 -----
 target/mips/tcg/octeon_crypto.c    | 35 ---------------------
 target/mips/tcg/octeon_translate.c | 49 ++++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 786117813a..779b87101d 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,10 +27,6 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
-DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect0, i64, env)
-DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
-DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
-DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect1, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_polynomial_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
@@ -43,9 +39,6 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
-DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect0, void, env, i64)
-DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect1, void, env, i64)
-DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 DEF_HELPER_1(octeon_cp2_mt_sha3_startop, void, env)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index fbf80be2a5..118397e632 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -2127,41 +2127,6 @@ uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
 
-uint64_t helper_octeon_cp2_mf_gfm_mul_reflect0(CPUMIPSState *env)
-{
-    return revbit64(env->octeon_crypto.gfm_mul[0]);
-}
-
-uint64_t helper_octeon_cp2_mf_gfm_mul_reflect1(CPUMIPSState *env)
-{
-    return revbit64(env->octeon_crypto.gfm_mul[1]);
-}
-
-uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect0(CPUMIPSState *env)
-{
-    return revbit64(env->octeon_crypto.gfm_resinp[0]);
-}
-
-uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect1(CPUMIPSState *env)
-{
-    return revbit64(env->octeon_crypto.gfm_resinp[1]);
-}
-
-void helper_octeon_cp2_mt_gfm_mul_reflect0(CPUMIPSState *env, uint64_t value)
-{
-    env->octeon_crypto.gfm_mul[0] = revbit64(value);
-}
-
-void helper_octeon_cp2_mt_gfm_mul_reflect1(CPUMIPSState *env, uint64_t value)
-{
-    env->octeon_crypto.gfm_mul[1] = revbit64(value);
-}
-
-void helper_octeon_cp2_mt_gfm_xor0_reflect(CPUMIPSState *env, uint64_t value)
-{
-    env->octeon_crypto.gfm_resinp[0] ^= revbit64(value);
-}
-
 static void octeon_gfm_xormul1_common(MIPSOcteonCryptoState *crypto,
                                       uint64_t value)
 {
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index a0db6630c7..b689adb46b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -28,6 +28,8 @@
     TRANS(NAME, trans_octeon_cp2_mf_hsh_pair, \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MF_REFLECT(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_reflect, OCTEON_CRYPTO_OFFSET(FIELD))
 #define CP2_MF_HELPER(NAME, SUFFIX) \
     TRANS(NAME, trans_octeon_cp2_mf_helper, \
           gen_helper_octeon_cp2_mf_ ## SUFFIX)
@@ -44,6 +46,8 @@
     TRANS(NAME, trans_octeon_cp2_mt_hsh_pair, \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MT_REFLECT(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_reflect, OCTEON_CRYPTO_OFFSET(FIELD))
 #define CP2_MT_HELPER(NAME, SUFFIX) \
     TRANS(NAME, trans_octeon_cp2_mt_helper, \
           gen_helper_octeon_cp2_mt_ ## SUFFIX)
@@ -110,6 +114,17 @@ static bool trans_octeon_cp2_mf_hsh_pair(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mf_reflect(DisasContext *ctx, arg_cp2 *a,
+                                        int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(value, tcg_env, offset);
+    tcg_gen_revbit64_i64(value, value);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
 static bool trans_octeon_cp2_mf_helper(DisasContext *ctx, arg_cp2 *a,
                                        void (*gen_helper)(TCGv_i64, TCGv_env))
 {
@@ -183,6 +198,17 @@ static bool trans_octeon_cp2_mt_xor_i64(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mt_reflect(DisasContext *ctx, arg_cp2 *a,
+                                        int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_revbit64_i64(value, value);
+    tcg_gen_st_i64(value, tcg_env, offset);
+    return true;
+}
+
 static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
                                        void (*gen_helper)(TCGv_env, TCGv_i64))
 {
@@ -200,6 +226,17 @@ static bool trans_octeon_cp2_mt_helper_env(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static void gen_helper_octeon_cp2_mt_gfm_xor0_reflect(TCGv_env t_env,
+                                                      TCGv_i64 value)
+{
+    TCGv_i64 resinp = tcg_temp_new_i64();
+
+    tcg_gen_revbit64_i64(value, value);
+    tcg_gen_ld_i64(resinp, t_env, OCTEON_CRYPTO_OFFSET(gfm_resinp[0]));
+    tcg_gen_xor_i64(resinp, resinp, value);
+    tcg_gen_st_i64(resinp, t_env, OCTEON_CRYPTO_OFFSET(gfm_resinp[0]));
+}
+
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT0, hsh_dat, 0);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT1, hsh_dat, 1);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT2, hsh_dat, 2);
@@ -241,10 +278,10 @@ CP2_MF_I64(CVM_MF_LLM_DATA1, llm_data[1]);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
 CP2_MF_I64(CVM_MF_SHA3_DAT24, sha3_dat24);
-CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT0, gfm_mul_reflect0);
-CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT1, gfm_mul_reflect1);
-CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp_reflect0);
-CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp_reflect1);
+CP2_MF_REFLECT(CVM_MF_GFM_MUL_REFLECT0, gfm_mul[0])
+CP2_MF_REFLECT(CVM_MF_GFM_MUL_REFLECT1, gfm_mul[1])
+CP2_MF_REFLECT(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp[0])
+CP2_MF_REFLECT(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp[1])
 CP2_MF_I64(CVM_MF_HSH_DATW0, hsh_dat[0]);
 CP2_MF_I64(CVM_MF_HSH_DATW1, hsh_dat[1]);
 CP2_MF_I64(CVM_MF_HSH_DATW2, hsh_dat[2]);
@@ -281,8 +318,8 @@ CP2_MT_HSH_PAIR(CVM_MT_HSH_IV0, hsh_iv, 0);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV1, hsh_iv, 1);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV2, hsh_iv, 2);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV3, hsh_iv, 3);
-CP2_MT_HELPER(CVM_MT_GFM_MUL_REFLECT0, gfm_mul_reflect0);
-CP2_MT_HELPER(CVM_MT_GFM_MUL_REFLECT1, gfm_mul_reflect1);
+CP2_MT_REFLECT(CVM_MT_GFM_MUL_REFLECT0, gfm_mul[0]);
+CP2_MT_REFLECT(CVM_MT_GFM_MUL_REFLECT1, gfm_mul[1]);
 CP2_MT_HELPER(CVM_MT_GFM_XOR0_REFLECT, gfm_xor0_reflect);
 CP2_MT_I64(CVM_MT_3DES_KEY0, des3_key[0]);
 CP2_MT_I64(CVM_MT_3DES_KEY1, des3_key[1]);
-- 
2.43.0


