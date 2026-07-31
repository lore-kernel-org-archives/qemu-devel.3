Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCACC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpakd-0001nx-Qh; Thu, 30 Jul 2026 20:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakW-0001jB-ID
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:16 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakR-0001LS-FT
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:16 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso227012a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456310; x=1786061110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x2x1tHQ9kIpJilZT8/tLtEUfAeCBYPruxXp7vNHzIQU=;
 b=I6B7UY4bj+41Yo7Zv+eoTBcC0TJ8NpgD3MEPNrLw3mR6OZirL6bqeDsi97QUy7LgPX
 6wtC6fBYU56+gvwtqC8hUPoRIONalSGMEG5r5nn8opqdYMNfA3RsXvKGkpGyZ8/l9+5S
 E4PMVHqym7cS5KGt0NoVyRU30r/NH8UPrssEzgl4MV6wuHa9+MVAIkG+ocYXZoePTdfo
 vx5RAyitFA4ZqjWyb6rH3xNuIYyw2r/+kUc9cf7pN8BOtTMOHUT2tO48bKJdqm3Btkxp
 ZvqHQ6HwOZsREIcD5VbGUI1XWK58TyXqAuPWzeio9PJvmzNd3UPu7Ta47WNQm4+Ew/3+
 Yy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456310; x=1786061110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x2x1tHQ9kIpJilZT8/tLtEUfAeCBYPruxXp7vNHzIQU=;
 b=e1GWMHBEySks1Rk/YVa5XMARLzyIi+Q1mh74xJxDSgCCAPc4x4Qd6C2VySNESUdkVK
 A1WTm+Ruhle2mUVBFmWUToQC7O5d71sbrWY4SS2ebDnW5/SCdc3G+afnmBV/+8edq58L
 H8XxsWO9DxT3VFvMR1WA2/lkaU9DsFa/Ny7lHkLBOMk/vYWTR6EOJTGt2zjuOPZnhAM3
 kvqqrFoTOa2ZftWKZahHR/e0eQ4GBypb7MAP87O6nXXcGR73zFWhP+O/NRQh87EJAAqm
 rxX9mtBWESoF7TdEpdjH1mUvrlIbixoOQIdStj+6rjpEsKEFTgsIMS1MaYZ4xESJx5/l
 9pQw==
X-Gm-Message-State: AOJu0YxW30s9jbY9vRCsp5lbPsttQU3+80Y/W09lmixHcFfglft7RUUK
 M52Djctlc9hD4+762je7DN1l0BsaeLk8afOFxnOWwhvpHL/CDwnralDqYhlnlYedGFW5gVF0WPh
 cZ7r9
X-Gm-Gg: AR+sD11L9+LWHIiN4B49AuU22FXgL5V7JycIZ+yH3HuSxGLIY0mbG0Rzdm1DxPd2MZ7
 w/nPmZPS5hvsDgy9FrIpUP8pYu+4H4woXWIY6N8LKdO5NADyBTu2TXXMsndX7gLwY3tVDmQH/jh
 ogxR5NcNwhf/Km0qAkBsF33QGQLzFG3m35UHsQ97bRY3xu8jc7MdiWHQQEy4ZWoQL0NKtJCOH+e
 VgOfoGxnEUWjAb5GoVvXbEhvjPxyCKsS28w1vPZ/FnKla3TNxGw6/j/ClJ5Jf/fVLXuDxUn56xx
 xJbG7dJOSr5w4WLt18Yy+BMkOBhRKiJPY+UO3acEpa0RQzbqXg4mJeVt59hI+1PDEikaxdYar2L
 qsWNvME9dQD7iXKrASLPUGXuqg59X7EbAr5Lsfz2hFaMsXRSicCfYWv0xhCTmKiaiua+uKKctDV
 dAar/Oxprn41KfmWjLEn/CFu4w2kfA8kwl/ZdwoozV2A/KUpDl/T0MCKnf+BMmFqPH2yAjVerz8
 8RF8a6se4ZGgGLSrX6Q
X-Received: by 2002:a05:6a20:7f8b:b0:3bf:a0e5:99a0 with SMTP id
 adf61e73a8af0-3c90d5cedb1mr2288298637.47.1785456310062; 
 Thu, 30 Jul 2026 17:05:10 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 06/11] target/mips: Expand octeon reflections inline
Date: Thu, 30 Jul 2026 17:04:58 -0700
Message-ID: <20260731000503.170446-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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


