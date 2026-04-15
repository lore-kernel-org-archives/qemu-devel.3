Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B7EF428E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6jX-0005mQ-VI; Wed, 15 Apr 2026 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jT-0005lL-6l
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jQ-00021R-N9
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:06 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d572f7437so4601536f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284461; x=1776889261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQxFJPSgxiSAygD5mi5SczIQoWbnt2abBGmh2Uo80nw=;
 b=ebaE+wpLRLagnJ+a3VUSd52Fp+asjEnp03czH2kmqZbRvAzEo2DufZdEPFjHzy657P
 eHQ53kXYvZAQU9aWECGMf9QxVz2EyQ64S4AMMfXs0wvV9eQcGaPt+SS/e7W2WdqGhu38
 oP42a7qYrKPwUx2BzxfMWdkmg5GPM0Cy/bS5oHuAyYw7FoenXJDg8TonzljBFxhKWbMm
 DLfisc/Rqp7n2tnW83n8C/OcshEeoVBzsLwmJT6DEOk/ScUTLTWZBEGZHyVcMLXKpnh7
 rFaM14Y7UsGg2mrxcZMQ9Kz3NE7vwkCm3+v/aOZPxH2zbXLXOuPIdNu3PBsyVcltR25T
 M2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284461; x=1776889261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQxFJPSgxiSAygD5mi5SczIQoWbnt2abBGmh2Uo80nw=;
 b=dWLgSLwz+G13NvC92Gk2lOptUKHmxN+hZqIBkFLFgy2UKti8l1giE7TWj/LQmYwE5O
 kJsXQzcR2fsqvIIR+wt6iCC+mn/Bnnvp8PxhZuvi3tR8tW6xPSkguRDR+S6oJY8v1tR6
 GsORNNrmyzS4JRQ+0rzJ/VnShYNYjF00Sf26fj36KUUY3wkub632z/HJo7NzywC+MLLS
 EBdxzF2S+VC2JlyK5ON7YqrujE60kHo7TRB3/Y5DuIbkzidZxsHXO7k2T8QvY8FKWDkH
 FTK6VFePmYOhfR5WFXZu64yngwE1VgmfXWuSCU3bV492zB00DVZrxi3RiqvrATl0KwN8
 L4Pg==
X-Gm-Message-State: AOJu0YyuJiZ0R8q15RY6b5kpAoTtL+oLfZCIhjpFxXGQ2UCSvSwU7C5W
 DQewdSlTqc+11nJhBjQMnZmkruNtG3xZsvQX+1pwo3fP9niL2gX/7rpinbUa8l/CZ0pAzwcDS4t
 ELb2Qo1E=
X-Gm-Gg: AeBDietjQha63ZyGA2LiJFHzYqCG+S3Ale7ERztbuU6RFWg77bPB/A1c02WcT6Fh9RN
 M9By++DInIodbTUg/maIa5U6HyMenXjl0FIw4NSHQ227huQQV6m049daobj1EDdNV5xHCqgVn++
 uEB2tZ7rKlTyCA22IoeUnTyIfx+2Y9Dc8/U/OSYfvu4hL0Zyefcnf7Q3aJTiGMOwrDsFFolck1c
 UlvhmuV9ahZw92stSQQPzRoMD1WlxO1IzU4QR2ckkBS11NQK/YjZbaWFPE0eaDUlCSA7QDMshdb
 L7eOHN+FBuZuJgFnPXxzXCT40bN8MiJSSjAt0yqNEe1PPUqgHCXXWV8Ge70Xhi7GYa29GPJoRYC
 VtBWLJTgHAJ7mReVpaCQKvVZcCILWrPurfFMGUk01oAL1Nc7UWL6cfJWAt7JkMzhWzx6GhpGAh9
 nBuiTjUDewg8NRTqKHrnyDLNjaPTLzTvDNRopTmQlaIlaWKiJgqahjEZrysT4wez5l83Jwrsu3
X-Received: by 2002:a05:6000:250f:b0:43d:1c7a:8b5b with SMTP id
 ffacd0b85a97d-43d642d1d00mr35230807f8f.40.1776284461492; 
 Wed, 15 Apr 2026 13:21:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3ebaaasm7486042f8f.32.2026.04.15.13.20.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 13:21:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [RFC PATCH v5 4/6] target/mips: Convert MSA LD/ST.W (Word Vector)
Date: Wed, 15 Apr 2026 22:20:24 +0200
Message-ID: <20260415202027.83008-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415202027.83008-1-philmd@linaro.org>
References: <20260415202027.83008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Replace runtime helpers by translation.

Replace the legacy cpu_ld/st*_data_ra() calls by
tcg_gen_qemu_ld/st() which allow to respect atomicity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.h.inc |  1 -
 target/mips/tcg/msa_helper.c     | 47 --------------------------------
 target/mips/tcg/msa_translate.c  | 20 ++++++++++----
 3 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index 86a79bf804c..f0d31ceef29 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -436,6 +436,5 @@ DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
 #define MSALDST_PROTO(type)                         \
 DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
 DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(w)
 MSALDST_PROTO(d)
 #undef MSALDST_PROTO
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 5489d8830dd..c93c0cddebc 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8212,32 +8212,6 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
-static inline uint64_t bswap32x2(uint64_t x)
-{
-    return ror64(bswap64(x), 32);
-}
-
-void helper_msa_ld_w(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    /*
-     * Load 8 bytes at a time.  Use little-endian load, then for
-     * big-endian target, we must then bswap the two words.
-     */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap32x2(d0);
-        d1 = bswap32x2(d1);
-    }
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
 void helper_msa_ld_d(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
@@ -8269,27 +8243,6 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
     }
 }
 
-void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    ensure_writable_pages(env, addr, mmu_idx, ra);
-
-    /* Store 8 bytes at a time.  See helper_msa_ld_w. */
-    d0 = pwd->d[0];
-    d1 = pwd->d[1];
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap32x2(d0);
-        d1 = bswap32x2(d1);
-    }
-    cpu_stq_le_data_ra(env, addr + 0, d0, ra);
-    cpu_stq_le_data_ra(env, addr + 8, d1, ra);
-}
-
 void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 111d9eedd11..8486508f5ba 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -770,11 +770,21 @@ static void gen_bswap16x4_i64(TCGv_i64 dst, TCGv_i64 src)
     tcg_gen_or_i64(dst, t0, t1);        /* dst = badcfebg */
 }
 
+/*
+ * Byte pattern: abcd.efgh -> dcba.hgfe
+ */
+static void gen_bswap32x2_i64(TCGv_i64 dst, TCGv_i64 src)
+{
+    tcg_gen_bswap64_i64(dst, src);
+    tcg_gen_rotri_i64(dst, dst, 32);
+}
+
 static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 {
     static const MemOp mo_atom_df[4] = {
         MO_ATOM_NONE,
         MO_ATOM_SUBALIGN, /* Slightly stronger than required */
+        MO_ATOM_SUBALIGN, /* Slightly stronger than required */
     };
     TCGv_i32 wd;
     TCGv_i128 t16;
@@ -795,18 +805,12 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 
     if (is_load) {
         switch (a->df) {
-        case 2:
-            gen_helper_msa_ld_w(tcg_env, wd, addr);
-            return true;
         case 3:
             gen_helper_msa_ld_d(tcg_env, wd, addr);
             return true;
         }
     } else {
         switch (a->df) {
-        case 2:
-            gen_helper_msa_st_w(tcg_env, wd, addr);
-            return true;
         case 3:
             gen_helper_msa_st_d(tcg_env, wd, addr);
             return true;
@@ -830,6 +834,10 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
             gen_bswap16x4_i64(d0, d0);
             gen_bswap16x4_i64(d1, d1);
             break;
+        case 2:
+            gen_bswap32x2_i64(d0, d0);
+            gen_bswap32x2_i64(d1, d1);
+            break;
         }
     }
 
-- 
2.53.0


