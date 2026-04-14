Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40EBF9D0D8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 21:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wClLz-0000O4-HA; Tue, 14 Apr 2026 17:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wClLu-0000NH-K9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 17:31:22 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wClLs-0003G4-Lv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 17:31:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so3778949f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776202278; x=1776807078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LE3VYdOYbKH0q08XzJYCU8QcyOKkKUY9kY9CRanYTyY=;
 b=EVmb7ByrORc6uVK2jiT9Qi2Ro90P3fS5GBxD7m5Ov3uxdHy4PQt8NxctDir2VX3+Ra
 yeXKOUTl6nhqUyHnFPD8zX44orinFELMsUKad1T2o3tkvKbMQuuw8iCImt/8xwjCzbQd
 9CMSQlxSySmBA//7MXKseK2mvubP7DOJNspzTHTYkEansUMnAZMZ+ckoFdn6zwgBerID
 rx8KpdEITqt0sgLjl4CsVXiU5BwD+tPkEr83guynClEtWFTvliuBwW1pP4ck7bJ7cMol
 6EXjjXfuP1+X3GO7M0/xuVu+VDtfbHruwLhW6E8fUgzpQhFyk2+Q8ioIEb6v601FZD0U
 n7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776202278; x=1776807078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LE3VYdOYbKH0q08XzJYCU8QcyOKkKUY9kY9CRanYTyY=;
 b=llJjQs3jQubrwAfP6qUal7FRtoLQFSgRcowXpbXAl/ZeP+m1mWCrJMa5u9NXgw+b5i
 HO8pyJBzQCjj52eCyJxz5yQxrDoPgb2Ygg3qlwaPY0s3YcbWbMQId2DcYLw7xc1C18UN
 7WLvvspWG3XdSkXQyDqYMAaOGQMh8LRyubPGzlsQ3W3qZM2e9o+36PvYnt6zH0KzyECJ
 x3Kz2twG1Mgrew7PAzzJsrKsEjjftpxCd8nal4dyk9ZEjTpJdEmy76tMFuvhLSrn0i2k
 koibv6G0UsNba2XBhPqg/L2dy9/zae8LnjuSBJLrjp6nX4xf83thGdkSIzyIM3lb62hw
 OPjg==
X-Gm-Message-State: AOJu0YzJkfBJUuCr/mKGngr6HhRV57fpi2K830QTi1hMXj0RJFTYmdBS
 /Md1Xo0YpkueC7lwHjGLbxjDt8tLsgDKFe2Jw5EOusMtikuAsYqDnwK/nNWhO4ISV4cWwZvrysJ
 ojTONrlw=
X-Gm-Gg: AeBDiesqxkZ/D/cH9YbWP95FMqY0dsmdS0jE23CnnY7NCwTTR71PMP3WczuO3NMkl0d
 FpCwxbbe4RbbmuTKsFq4bZEDl4pNfHsLTfk5rC+5/NkNYnfhpOQvxe0y+4dAm6D0+XZGcE94lGi
 krM7EaZK1KdvwQqCvv95qKXdzBj4aG5RFxZHY8eLx3WRpn//c2J3hcL2ADyv2ISVk1mhTEQEicg
 dq+O1GY7jSjbaAVNvoxnK4Z0Ma174kcg4mYZJCIZZe0MTi4QxpYmaLkvnHYslOe0NUi6MKcFgoX
 fsxGxdO/14h9fs5eJJF/4ASFxakZmBIWY+K+qxw+o3Ubyc0XIOW9mZ1JzN68RrTpMnMNzn6Rq0o
 6mY0CyS5v7AasNzPe67egyf7uoGHxMqr22hjewJRC1TpQaE7U+8jQD/mDg3I4EXkIrrjmgdWja5
 QQ2VQMX4nBcZvHutTjPskf4lQMoYeBlaBIlND9lEeyaj2966Bi5OT/6IBCaBzTTaMJktML6wX1D
 8jredAxsIk=
X-Received: by 2002:a05:6000:1379:b0:43d:6787:9934 with SMTP id
 ffacd0b85a97d-43d67879a5emr18138837f8f.9.1776202278274; 
 Tue, 14 Apr 2026 14:31:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5c981sm45430513f8f.33.2026.04.14.14.31.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Apr 2026 14:31:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v4 1/2] target/mips: Translate MSA vector load opcode
 (LD.df)
Date: Tue, 14 Apr 2026 23:31:07 +0200
Message-ID: <20260414213108.66786-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414213108.66786-1-philmd@linaro.org>
References: <20260414213108.66786-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Remove legacy cpu_ld*_data_ra() calls, replacing by
tcg_gen_qemu_ld() which allow to respect atomicity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.h.inc |  1 -
 target/mips/tcg/msa_helper.c     | 69 --------------------------------
 target/mips/tcg/msa_translate.c  | 44 +++++++++++++++++++-
 3 files changed, 43 insertions(+), 71 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index 4963d1553a0..7ede16f327a 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -434,7 +434,6 @@ DEF_HELPER_4(msa_ffint_s_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
 
 #define MSALDST_PROTO(type)                         \
-DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
 DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
 MSALDST_PROTO(b)
 MSALDST_PROTO(h)
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index f554b3d10ee..3a0ba420b9d 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8223,75 +8223,6 @@ static inline uint64_t bswap32x2(uint64_t x)
     return ror64(bswap64(x), 32);
 }
 
-void helper_msa_ld_b(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    /* Load 8 bytes at a time.  Vector element ordering makes this LE.  */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
-void helper_msa_ld_h(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    /*
-     * Load 8 bytes at a time.  Use little-endian load, then for
-     * big-endian target, we must then swap the four halfwords.
-     */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    if (mips_env_is_bigendian(env)) {
-        d0 = bswap16x4(d0);
-        d1 = bswap16x4(d1);
-    }
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
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
-void helper_msa_ld_d(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    d0 = cpu_ldq_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_data_ra(env, addr + 8, ra);
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
 #define MSA_PAGESPAN(x) \
         ((((x) & ~TARGET_PAGE_MASK) + MSA_WRLEN / 8 - 1) >= TARGET_PAGE_SIZE)
 
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 82b149922fa..0ad8c2c0dc9 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -758,6 +758,49 @@ TRANS(FTINT_U,  trans_msa_2rf, gen_helper_msa_ftint_u_df);
 TRANS(FFINT_S,  trans_msa_2rf, gen_helper_msa_ffint_s_df);
 TRANS(FFINT_U,  trans_msa_2rf, gen_helper_msa_ffint_u_df);
 
+static bool trans_LD(DisasContext *ctx, arg_msa_i *a)
+{
+    TCGv_va addr;
+    TCGv_i128 d16;
+    MemOp mop;
+    int d0 = a->wd << 1;
+    int d1 = d0 + 1;
+
+    if (!check_msa_enabled(ctx)) {
+        return true;
+    }
+
+    addr = tcgv_va_temp_new();
+    gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
+
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
+    tcg_gen_qemu_ld_i128(d16, addr, ctx->mem_idx, mop);
+
+    tcg_gen_st_i128(d16, tcg_env, offsetof(CPUMIPSState, active_fpu.fpr[d0]));
+
+    if (mo_endian(ctx) != MO_LE) {
+        if (a->df == 1) {
+            tcg_gen_hswap_i64(msa_wr_d[d0], msa_wr_d[d0]);
+            tcg_gen_hswap_i64(msa_wr_d[d1], msa_wr_d[d1]);
+        } else if (a->df == 2) {
+            tcg_gen_wswap_i64(msa_wr_d[d0], msa_wr_d[d0]);
+            tcg_gen_wswap_i64(msa_wr_d[d1], msa_wr_d[d1]);
+        }
+    }
+
+    return true;
+}
+
 static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a,
                            gen_helper_piv *gen_msa_ldst)
 {
@@ -775,7 +818,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a,
     return true;
 }
 
-TRANS_DF_iv(LD, trans_msa_ldst, gen_helper_msa_ld);
 TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
-- 
2.53.0


