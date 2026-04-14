Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5FBF9D0D8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 21:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wClM4-0000Ok-6V; Tue, 14 Apr 2026 17:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wClM2-0000OZ-Cw
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 17:31:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wClM0-0003I3-C5
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 17:31:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso73880235e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776202286; x=1776807086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CRMRZ6KwHmBSM4nIFrY3AvrZBRDI1zoFU0Uy2HkTeQ=;
 b=C0fCKSmxLHxOi/SBGiM5IFC4o6KDB4KWC/T8z2HyhUoNXEyKi8Xr8OiwPF7K1lWTct
 x36h1fHvCe5h4I83ZiqseFMtbaZHBHuAFlcrGJiGWJORN9qOGS+U9KQ5JUF3OUPD5+e3
 4N9vFT7BM6pd9wZtKTFVrXRHBIxYT1I2rjefPFTqQMCqBo1r3R681fAMmSImzkG/L9EK
 KW+Aid4xidouj9zL0WYvuhLpKKGA0G4Ni/cxLWDS6k/4R6+NhmMlrLQbPcCVepz7Sx/B
 S7nBCK2FPQW5CGiF+Tv/Z9jUiJtKtwncDfBAsOSieMYPcVLwOA3L6AJgDS/vHSoLBR4T
 lTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776202286; x=1776807086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5CRMRZ6KwHmBSM4nIFrY3AvrZBRDI1zoFU0Uy2HkTeQ=;
 b=srEuvKUwd2NJD86C7uObTsEed1utdkgjDTvq4LWhaKBx/iIfZ86tLgrDvPzJEK/uSS
 EgQ9Hm7JXFR9pTwdu+aQZYxfP+tsoCKDKzse1A0m+TN47GoGK+9YxzxIQ1HjIl3oLT+8
 QCkoNFH5/6zS7FZ+4qk/neMvE1iJfSlVmqDT4UOR9rLSoyB9S3QWrTHgyPoozfPBzx4f
 zKRoG7SuBbl3LzZDywWq+vIgxEacXpPanTdraxeWXDilfIIpTbTlUKXDY52FUMMy+Q4X
 cBVcE0i4j3qgzWLSBQYDdJkzQ7TmRPYg5J5SrJjV2wL8fx+fuZ8+vDCLeRCIbt1tvFKI
 hfyA==
X-Gm-Message-State: AOJu0YzBEnPzCdNEeVcfzked48yq3BxaZ3go5WXXQtLmp3sLO6YK6J/T
 Lv1Ug1S0JdB9sbCV/dpzY+ArO2vlzDtaNEej/vfr2mdOdoLY+IHDc0tq1FHn7j27SSqtt3P0T8X
 p1W2CA3k=
X-Gm-Gg: AeBDiesnDWMFPA9wQtudWhkzxpF7jV6k+/1e/BwubZzVEN5tMdKOoAd8vmDyPuxaYNl
 Yr0YvRZLf4u8W1qukJMYeJ/f42yeSNEm0yXleR8i4KAR0lpYIdSaZY6K/eZA2Srckw4n+ISEuuG
 60DE58M9eIipzXk/sXqY2nwkgcuYKsA9Gyyd8NYPQcwj4RO3Wf5YJS4iUiEW8XJi6oNwuBvsiTX
 cQ8Dbc9j6MswU85PGS9lkzCW1AXBVOGMrENOifb5apwVNQREHCBpjje65VL2/FFBGJTi0V58iX/
 KEV46kp32Lab/dun2yRL4OKslJp4/lMelaSfTgxvr2kM0XxtIkXDGRIsOrl8rpsaC5xtSxqRoKG
 4Mtajg+aR5sgXNNJ/Nz743h9QAS7Ln+qI7SPaDy10ydETqR9Nhi0wKpo3JlTMWOJvjJyrBCpRl1
 YlDB//JES6bQs8V9UfWCFIh9PyrKY40AsJyTxxNzsqDjjfWCL6wW0v8md1k7muM1PKsB7j8d/b
X-Received: by 2002:a05:600c:5303:b0:488:b196:d249 with SMTP id
 5b1f17b1804b1-488d67bf74fmr259156725e9.5.1776202285580; 
 Tue, 14 Apr 2026 14:31:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede25a12sm69216495e9.9.2026.04.14.14.31.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Apr 2026 14:31:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v4 2/2] target/mips: Translate MSA vector store opcode
 (ST.df)
Date: Tue, 14 Apr 2026 23:31:08 +0200
Message-ID: <20260414213108.66786-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414213108.66786-1-philmd@linaro.org>
References: <20260414213108.66786-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Replace helpers by translation.

Remove legacy cpu_st*_data_ra() calls, replacing by
tcg_gen_qemu_st() which allow to respect atomicity.

Remove the ensure_writable_pages() hack and the bswap
NxM helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.h.inc |   8 ---
 target/mips/tcg/msa_helper.c     | 104 -------------------------------
 target/mips/tcg/msa_translate.c  |  54 ++++++++++++----
 3 files changed, 42 insertions(+), 124 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index 7ede16f327a..e994353056f 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -432,11 +432,3 @@ DEF_HELPER_4(msa_ftint_s_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ftint_u_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ffint_s_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
-
-#define MSALDST_PROTO(type)                         \
-DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(b)
-MSALDST_PROTO(h)
-MSALDST_PROTO(w)
-MSALDST_PROTO(d)
-#undef MSALDST_PROTO
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 3a0ba420b9d..28148ea9c8b 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8205,107 +8205,3 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
     msa_move_v(pwd, pwx);
 }
-
-/* Data format min and max values */
-#define DF_BITS(df) (1 << ((df) + 3))
-
-/* Element-by-element access macros */
-#define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
-
-static inline uint64_t bswap16x4(uint64_t x)
-{
-    uint64_t m = 0x00ff00ff00ff00ffull;
-    return ((x & m) << 8) | ((x >> 8) & m);
-}
-
-static inline uint64_t bswap32x2(uint64_t x)
-{
-    return ror64(bswap64(x), 32);
-}
-
-#define MSA_PAGESPAN(x) \
-        ((((x) & ~TARGET_PAGE_MASK) + MSA_WRLEN / 8 - 1) >= TARGET_PAGE_SIZE)
-
-static inline void ensure_writable_pages(CPUMIPSState *env,
-                                         target_ulong addr,
-                                         int mmu_idx,
-                                         uintptr_t retaddr)
-{
-    /* FIXME: Probe the actual accesses (pass and use a size) */
-    if (unlikely(MSA_PAGESPAN(addr))) {
-        /* first page */
-        probe_write(env, addr, 0, mmu_idx, retaddr);
-        /* second page */
-        addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-        probe_write(env, addr, 0, mmu_idx, retaddr);
-    }
-}
-
-void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-
-    ensure_writable_pages(env, addr, mmu_idx, ra);
-
-    /* Store 8 bytes at a time.  Vector element ordering makes this LE.  */
-    cpu_stq_le_data_ra(env, addr + 0, pwd->d[0], ra);
-    cpu_stq_le_data_ra(env, addr + 8, pwd->d[1], ra);
-}
-
-void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    ensure_writable_pages(env, addr, mmu_idx, ra);
-
-    /* Store 8 bytes at a time.  See helper_msa_ld_h. */
-    d0 = pwd->d[0];
-    d1 = pwd->d[1];
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap16x4(d0);
-        d1 = bswap16x4(d1);
-    }
-    cpu_stq_le_data_ra(env, addr + 0, d0, ra);
-    cpu_stq_le_data_ra(env, addr + 8, d1, ra);
-}
-
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
-void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-
-    ensure_writable_pages(env, addr, mmu_idx, GETPC());
-
-    cpu_stq_data_ra(env, addr + 0, pwd->d[0], ra);
-    cpu_stq_data_ra(env, addr + 8, pwd->d[1], ra);
-}
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 0ad8c2c0dc9..c48e5108fe9 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -164,7 +164,6 @@ static inline bool check_msa_enabled(DisasContext *ctx)
     return true;
 }
 
-typedef void gen_helper_piv(TCGv_ptr, TCGv_i32, TCGv);
 typedef void gen_helper_pii(TCGv_ptr, TCGv_i32, TCGv_i32);
 typedef void gen_helper_piii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
 typedef void gen_helper_piiii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
@@ -175,9 +174,6 @@ typedef void gen_helper_piiii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
     }; \
     TRANS(NAME, trans_func, NAME##_tab[a->df])
 
-#define TRANS_DF_iv(NAME, trans_func, gen_func) \
-    TRANS_DF_x(iv, NAME, trans_func, gen_func)
-
 #define TRANS_DF_ii(NAME, trans_func, gen_func) \
     TRANS_DF_x(ii, NAME, trans_func, gen_func)
 
@@ -801,25 +797,59 @@ static bool trans_LD(DisasContext *ctx, arg_msa_i *a)
     return true;
 }
 
-static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a,
-                           gen_helper_piv *gen_msa_ldst)
+static bool trans_ST(DisasContext *ctx, arg_msa_i *a)
 {
-    TCGv taddr;
+    TCGv_va addr;
+    TCGv_i128 d16;
+    MemOp mop;
+    int d0 = a->wd << 1;
+    int d1 = d0 + 1;
 
     if (!check_msa_enabled(ctx)) {
         return true;
     }
 
-    taddr = tcg_temp_new();
+    addr = tcgv_va_temp_new();
+    gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
 
-    gen_base_offset_addr(ctx, taddr, a->ws, a->sa << a->df);
-    gen_msa_ldst(tcg_env, tcg_constant_i32(a->wd), taddr);
+    mop = MO_128 | MO_LE;
+    if (a->df == 0) {
+        mop |= MO_ATOM_NONE;
+    } else if (a->df == 3) {
+        mop |= MO_ATOM_IFALIGN_PAIR;
+    } else {
+        mop |= MO_ATOM_SUBALIGN; /* slightly stronger than required */
+    }
+    mop |= a->df << MO_ASHIFT; /* MO_ALIGN */
+
+    d16 = tcg_temp_new_i128();
+
+    if (mo_endian(ctx) != MO_LE) {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+
+        if (a->df == 1) {
+            tcg_gen_hswap_i64(t0, msa_wr_d[d0]);
+            tcg_gen_hswap_i64(t1, msa_wr_d[d1]);
+            tcg_gen_concat_i64_i128(d16, t0, t1);
+        } else if (a->df == 2) {
+            tcg_gen_wswap_i64(t0, msa_wr_d[d0]);
+            tcg_gen_wswap_i64(t1, msa_wr_d[d1]);
+            tcg_gen_concat_i64_i128(d16, t0, t1);
+        } else {
+            tcg_gen_ld_i128(d16, tcg_env,
+                            offsetof(CPUMIPSState, active_fpu.fpr[d0]));
+        }
+    } else {
+        tcg_gen_ld_i128(d16, tcg_env,
+                        offsetof(CPUMIPSState, active_fpu.fpr[d0]));
+    }
+
+    tcg_gen_qemu_st_i128(d16, addr, ctx->mem_idx, mop);
 
     return true;
 }
 
-TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
-
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
     return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
-- 
2.53.0


