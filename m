Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187EED7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdTe-0003Zp-IH; Fri, 19 Dec 2025 11:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTc-0003ZT-HA
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:12 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTY-0000PG-F5
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so1046406f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162227; x=1766767027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pPXI/RNd4YhskZ4GDGLaQPSNUsmTt2IQzm/8dEFuWw=;
 b=Ds2trsHKtOB139NpIustwiw2abp1P+gO7ppMjWLZ/5txUyJOoCbild7r+uiU9JZhli
 ITA4LX8eNk/FG1LhfIa0O5y8JT6pFKhuGBqUO6ca42lYi/YhvkOCwxQO/VjmmbV4Z/g8
 77ZaTHDAWUjS7ei71jt2xy7Yzz6e0gzF8UEkxqMsu5rGMomhP9kns92AndGK8sxJtjnq
 +S1B/QPYZXMa0+JRyaxiASvzyOinWfHLjOxVsupJRJyawo9GxkhNPkU2D2odOHuZmcbb
 ZXY3i/BrxzRymptQc9WFUKcX60CSfoFMX5EvZJQ4CM68wapTLeuG6m6aXt1eSESQmgcH
 yVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162227; x=1766767027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pPXI/RNd4YhskZ4GDGLaQPSNUsmTt2IQzm/8dEFuWw=;
 b=O7ua+5QZtU3JSLePKqVUK9+KNmYD6bMJTl7Kc0HUEN8LwnjfVK+f9yBwa6ZQMGQHGV
 I/jGwquk86ZTvB4iDtnqOn40DMaujKDvX1qdgdOfu2+qlUjbZS6+QYd0OrlQqAymaH0b
 FSbSy7TNZJo5gUayTG0pkyQzs1MeNtrSuxNqAt0DiGT707/7E34j0493eVt4pcuU1uCz
 /7X7nL+IOryIlV/8CuF/cnEq6Ogrhx3/cwzpQ/zn/W83odHf5P21IpfK0Xkd6EEWozG5
 CNxyD4iW5PbKkK46JC0ThrVNrbG+T6z+j8JmR09cp+MlPRuhoytVhvlBnPkhuQouvGCB
 ud3w==
X-Gm-Message-State: AOJu0YxZB1xtFUcXsNz+Q5I2xiKg8rnTER9oyTtq68ULquLVmEnqch1I
 oU5oHDWCqv4d92Mbn0MbeFVeuDXj3xzvHKo1WNETLAFob//WxT5F/rR2QuFgD3NG+OEJzn8LcCK
 vd8SI5qo=
X-Gm-Gg: AY/fxX7dddIkKkeLyED8fWVU01LsFqTz/fkA3zr+aeHwUpFqwpLH2rSES41uVTkKP3N
 LY4IlQ0yppY4s5NUBkzmOdIFEWyRPdQYDDxTjZRx204xxc2fCcFWneA+IAa5GZLAsYZnEojz2tU
 WJv8RFUG33FfosW50I9xAxsYy31Kf9I1b6PEvwpK2HEfed/bvLuY4Ea+nXbFQuH6/ovUMUYfnkl
 kLKVZ9IONgHxqrdIRJt791BjLBJthR3c6sh8wITZWZh3xq+wdnrng/jsnq6+9OeOcNQ9P9KF1W5
 Cg5rvN/8gcw0pEjJHpyRLppO6Di61fvRNc9/BuYjJZvTucvgenqVyMwjGP6oyTjYMxNtWrQHfH7
 I+hzkxhP1kGAxv3ZWPUw26cWahgN7qvmLmG/XqxAe9F4BfpMKVqNAVEdGO1aS0VjXa984C9jg9q
 iNgZH3vJTVVMbypaNQikVWfnxFKKzS/KmzaVbu1u7J/z8jzCTChYqHeCcQhxDa
X-Google-Smtp-Source: AGHT+IG7Toirw4C2eKFF8gBoWapWKoDH4p3CXC20xRGBgUu1amTW+wnUSpU3KeuRQe9/r33fo/flDQ==
X-Received: by 2002:a05:6000:430a:b0:42f:9f18:8f59 with SMTP id
 ffacd0b85a97d-4324e50b471mr4002697f8f.42.1766162226489; 
 Fri, 19 Dec 2025 08:37:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227e0sm6047164f8f.17.2025.12.19.08.37.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:37:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/9] target/sparc: Replace MO_TE -> MO_BE
Date: Fri, 19 Dec 2025 17:36:42 +0100
Message-ID: <20251219163650.74303-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219163650.74303-1-philmd@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
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

We only build the SPARC targets using big endianness order,
therefore the MO_TE definitions expand to the big endian
one. Use the latter which is more explicit.

Mechanical change running:

  $ sed -i -e s/MO_TE/MO_BE/ \
        $(git grep -wl MO_TE target/sparc/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c |  6 ++--
 target/sparc/translate.c   | 58 +++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c63eb9e036..a87a0b3eee0 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1169,7 +1169,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
         break;
     case MO_16:
         ret = cpu_ldw_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
+        if ((mop & MO_BSWAP) != MO_BE) {
             ret = bswap16(ret);
         }
         if (mop & MO_SIGN) {
@@ -1178,7 +1178,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
         break;
     case MO_32:
         ret = cpu_ldl_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
+        if ((mop & MO_BSWAP) != MO_BE) {
             ret = bswap32(ret);
         }
         if (mop & MO_SIGN) {
@@ -1187,7 +1187,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
         break;
     case MO_64:
         ret = cpu_ldq_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
+        if ((mop & MO_BSWAP) != MO_BE) {
             ret = bswap64(ret);
         }
         break;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d6b599b71fe..23079697f52 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1764,7 +1764,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_FL16_SL:
         case ASI_FL16_P:
         case ASI_FL16_PL:
-            memop = MO_TEUW;
+            memop = MO_BEUW;
             type = GET_ASI_SHORT;
             break;
         }
@@ -2215,7 +2215,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
              * byte swapped.  We perform one 128-bit LE load, so must swap
              * the order of the writebacks.
              */
-            if ((mop & MO_BSWAP) == MO_TE) {
+            if ((mop & MO_BSWAP) == MO_BE) {
                 tcg_gen_extr_i128_i64(lo, hi, t);
             } else {
                 tcg_gen_extr_i128_i64(hi, lo, t);
@@ -2235,7 +2235,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             /* Note that LE ldda acts as if each 32-bit register
                result is byte swapped.  Having just performed one
                64-bit bswap, we need now to swap the writebacks.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
                 tcg_gen_extr_i64_tl(hi, lo, tmp);
@@ -2252,7 +2252,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             gen_helper_ld_code(tmp, tcg_env, addr, tcg_constant_i32(oi));
 
             /* See above.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
                 tcg_gen_extr_i64_tl(hi, lo, tmp);
@@ -2277,7 +2277,7 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             gen_helper_ld_asi(tmp, tcg_env, addr, r_asi, r_mop);
 
             /* See above.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
                 tcg_gen_extr_i64_tl(hi, lo, tmp);
@@ -2310,7 +2310,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
              * byte swapped.  We perform one 128-bit LE store, so must swap
              * the order of the construction.
              */
-            if ((mop & MO_BSWAP) == MO_TE) {
+            if ((mop & MO_BSWAP) == MO_BE) {
                 tcg_gen_concat_i64_i128(t, lo, hi);
             } else {
                 tcg_gen_concat_i64_i128(t, hi, lo);
@@ -2329,7 +2329,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             /* Note that LE stda acts as if each 32-bit register result is
                byte swapped.  We will perform one 64-bit LE store, so now
                we must swap the order of the construction.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
                 tcg_gen_concat_tl_i64(t64, hi, lo);
@@ -2345,7 +2345,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
          * See comments for GET_ASI_COPY above.
          */
         {
-            MemOp mop = MO_TE | MO_128 | MO_ATOM_IFALIGN_PAIR;
+            MemOp mop = MO_BE | MO_128 | MO_ATOM_IFALIGN_PAIR;
             TCGv_i64 t8 = tcg_temp_new_i64();
             TCGv_i128 t16 = tcg_temp_new_i128();
             TCGv daddr = tcg_temp_new();
@@ -2368,7 +2368,7 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             TCGv_i64 t64 = tcg_temp_new_i64();
 
             /* See above.  */
-            if ((da->memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_BE) {
                 tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
                 tcg_gen_concat_tl_i64(t64, hi, lo);
@@ -4428,13 +4428,13 @@ static bool do_ld_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
     return advance_pc(dc);
 }
 
-TRANS(LDUW, ALL, do_ld_gpr, a, MO_TEUL)
+TRANS(LDUW, ALL, do_ld_gpr, a, MO_BEUL)
 TRANS(LDUB, ALL, do_ld_gpr, a, MO_UB)
-TRANS(LDUH, ALL, do_ld_gpr, a, MO_TEUW)
+TRANS(LDUH, ALL, do_ld_gpr, a, MO_BEUW)
 TRANS(LDSB, ALL, do_ld_gpr, a, MO_SB)
-TRANS(LDSH, ALL, do_ld_gpr, a, MO_TESW)
-TRANS(LDSW, 64, do_ld_gpr, a, MO_TESL)
-TRANS(LDX, 64, do_ld_gpr, a, MO_TEUQ)
+TRANS(LDSH, ALL, do_ld_gpr, a, MO_BESW)
+TRANS(LDSW, 64, do_ld_gpr, a, MO_BESL)
+TRANS(LDX, 64, do_ld_gpr, a, MO_BEUQ)
 
 static bool do_st_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
 {
@@ -4451,10 +4451,10 @@ static bool do_st_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
     return advance_pc(dc);
 }
 
-TRANS(STW, ALL, do_st_gpr, a, MO_TEUL)
+TRANS(STW, ALL, do_st_gpr, a, MO_BEUL)
 TRANS(STB, ALL, do_st_gpr, a, MO_UB)
-TRANS(STH, ALL, do_st_gpr, a, MO_TEUW)
-TRANS(STX, 64, do_st_gpr, a, MO_TEUQ)
+TRANS(STH, ALL, do_st_gpr, a, MO_BEUW)
+TRANS(STX, 64, do_st_gpr, a, MO_BEUQ)
 
 static bool trans_LDD(DisasContext *dc, arg_r_r_ri_asi *a)
 {
@@ -4468,7 +4468,7 @@ static bool trans_LDD(DisasContext *dc, arg_r_r_ri_asi *a)
     if (addr == NULL) {
         return false;
     }
-    da = resolve_asi(dc, a->asi, MO_TEUQ);
+    da = resolve_asi(dc, a->asi, MO_BEUQ);
     gen_ldda_asi(dc, &da, addr, a->rd);
     return advance_pc(dc);
 }
@@ -4485,7 +4485,7 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
     if (addr == NULL) {
         return false;
     }
-    da = resolve_asi(dc, a->asi, MO_TEUQ);
+    da = resolve_asi(dc, a->asi, MO_BEUQ);
     gen_stda_asi(dc, &da, addr, a->rd);
     return advance_pc(dc);
 }
@@ -4516,7 +4516,7 @@ static bool trans_SWAP(DisasContext *dc, arg_r_r_ri_asi *a)
     if (addr == NULL) {
         return false;
     }
-    da = resolve_asi(dc, a->asi, MO_TEUL);
+    da = resolve_asi(dc, a->asi, MO_BEUL);
 
     dst = gen_dest_gpr(dc, a->rd);
     src = gen_load_gpr(dc, a->rd);
@@ -4544,8 +4544,8 @@ static bool do_casa(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
     return advance_pc(dc);
 }
 
-TRANS(CASA, CASA, do_casa, a, MO_TEUL)
-TRANS(CASXA, 64, do_casa, a, MO_TEUQ)
+TRANS(CASA, CASA, do_casa, a, MO_BEUL)
+TRANS(CASXA, 64, do_casa, a, MO_BEUQ)
 
 static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
 {
@@ -4561,7 +4561,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
     if (sz == MO_128 && gen_trap_float128(dc)) {
         return true;
     }
-    da = resolve_asi(dc, a->asi, MO_TE | sz);
+    da = resolve_asi(dc, a->asi, MO_BE | sz);
     gen_ldf_asi(dc, &da, sz, addr, a->rd);
     gen_update_fprs_dirty(dc, a->rd);
     return advance_pc(dc);
@@ -4590,7 +4590,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
     if (sz == MO_128 && gen_trap_float128(dc)) {
         return true;
     }
-    da = resolve_asi(dc, a->asi, MO_TE | sz);
+    da = resolve_asi(dc, a->asi, MO_BE | sz);
     gen_stf_asi(dc, &da, sz, addr, a->rd);
     return advance_pc(dc);
 }
@@ -4629,7 +4629,7 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
     /* Store the single element from the queue. */
     TCGv_i64 fq = tcg_temp_new_i64();
     tcg_gen_ld_i64(fq, tcg_env, offsetof(CPUSPARCState, fq.d));
-    tcg_gen_qemu_st_i64(fq, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN_4);
+    tcg_gen_qemu_st_i64(fq, addr, dc->mem_idx, MO_BEUQ | MO_ALIGN_4);
 
     /* Mark the queue empty, transitioning to fp_execute state. */
     tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
@@ -4655,7 +4655,7 @@ static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
     }
 
     tmp = tcg_temp_new_i32();
-    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_TEUL | MO_ALIGN);
+    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_BEUL | MO_ALIGN);
 
     tcg_gen_extract_i32(cpu_fcc[0], tmp, FSR_FCC0_SHIFT, 2);
     /* LDFSR does not change FCC[1-3]. */
@@ -4679,7 +4679,7 @@ static bool do_ldxfsr(DisasContext *dc, arg_r_r_ri *a, bool entire)
     }
 
     t64 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(t64, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(t64, addr, dc->mem_idx, MO_BEUQ | MO_ALIGN);
 
     lo = tcg_temp_new_i32();
     hi = cpu_fcc[3];
@@ -4722,8 +4722,8 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
     return advance_pc(dc);
 }
 
-TRANS(STFSR, ALL, do_stfsr, a, MO_TEUL)
-TRANS(STXFSR, 64, do_stfsr, a, MO_TEUQ)
+TRANS(STFSR, ALL, do_stfsr, a, MO_BEUL)
+TRANS(STXFSR, 64, do_stfsr, a, MO_BEUQ)
 
 static bool do_fc(DisasContext *dc, int rd, int32_t c)
 {
-- 
2.52.0


