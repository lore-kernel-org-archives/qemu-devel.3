Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8A4C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm57-0006EZ-Pk; Wed, 07 May 2025 17:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4p-0006Al-6E
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:15 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4m-0006E9-VG
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:14 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso402613b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652391; x=1747257191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Zno0MG6t3l2a+DW91RyVv73EZeQnXuZuzFVudL8NUE=;
 b=niRxeH3ApzlfkTeftJ5ybVjauyrVkIiVH6yY9C0Lm0tj93eFwXXj7viNZI3aLLLemJ
 s9SIqY6Zw5bbskTo74HDAgr+kExrBTyoGF+67H/NWl5gDHRz1EQuR4QiQvv/TjXgQaId
 We3YPaOmV1dtPg1T2HR0OWanLyEK4L9T0NUmruoe8ADaz4+jjSCVPSMUpWICTBcrL6Qs
 6SvtJsxLgkF0hRdm9RuwFb+7T6+87uBj1lqMeGUI8+7/Bgc4GH1MDXhaMTGSkXudI++u
 5kHSGVNHmuU/CG61pzhi26CiggJ28wb1QggxNzJgIpkBuWZvtImcqXdPP574x2eow6oh
 m87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652391; x=1747257191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Zno0MG6t3l2a+DW91RyVv73EZeQnXuZuzFVudL8NUE=;
 b=jjW5VSvPqtwAgbWjqAmAgwI3Kpju3tUA/hrccSnOH7XfN3owVfrMRUCi6WrEjyu5sK
 erzXzaqzUVALLud5SbIY/1zT+pYZJcLBSh8xrghmO1JzIgjKGEb7kuAEGlLPAyJIYc7k
 2ReZ0Jfcyj68GK9PZvG1i6XT6bciJ1ZG/hh5tCMK0hNVNx/zVFTMSTHXIelxPY95BbW0
 0v2Hr1n2ChVIbPEm88RLZeXG7y94vvY0xZbiNsfiCga54q9/0SC/n2RJ28u+a1RbhFre
 xYrw+31JcwXYCy1/Fv3MoY0KzPCalRmOhuE0m2iU9jtF3+cHXE8yJb3osTD2SzpGpoYr
 N4KQ==
X-Gm-Message-State: AOJu0Yz39hdO/PSQ9O4RudiylNK+dICGzr/9FZ9Q0cb4vkI7RWsOLsL5
 uL12Anu6LpYJ+MelQ6MWXi8ltX46tPu0jmoR16GBko9W+iTwj6Y7801Fs0+dRtmTFMMUQtd53WR
 J
X-Gm-Gg: ASbGnctR4ZoabnLVnASc1c5TvytpY8eupYdY+GHFT6bvs7tvQWrbCXTIGJHygVMlcBU
 fGlhOjPE2pQ8xG5y83bM02FaqEhvKHIBzniH4EeZBHBB4PLJu8IhJOpvE2t6YXr67JreIeYpI+m
 309lLcRD7sPvl64v68TYk4NULAQI6anVS7x8BRCsoYtIG0VSHZmLk4c8jswbmFxzTCtNMuAvuCB
 5A1AtYUImOOc8TkpIHA3LWZ3ul68iBEyyj2pLMHiOhCQ72qJIWJFLz2lLZ6hs8yK3poB/MPRdb4
 ithKDYmEQ1q1MkI4EENiqR/BYImHMxfhR9gzUTnavORRG8FxbhkER2demxOiU6+NitcfRMReRkY
 =
X-Google-Smtp-Source: AGHT+IHDB0Qr4S+EySJCvng9pY9oMuyWdsxabA+hyrq2XmvFrc7Yx8IVo0+WBvZRc3pTg1BpL5M//A==
X-Received: by 2002:a05:6a20:9d8f:b0:1f5:8e94:2e83 with SMTP id
 adf61e73a8af0-2148b523326mr8076702637.8.1746652391386; 
 Wed, 07 May 2025 14:13:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v5 11/24] target/m68k: Split gen_ea_mode for load/store
Date: Wed,  7 May 2025 14:12:46 -0700
Message-ID: <20250507211300.9735-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Replace with gen_load_mode and gen_store_mode.
Return bool for success from gen_store_mode,
which makes store_dummy unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 155 ++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 79 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 593ff9ba2d..0abdb1673a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -60,8 +60,6 @@ static TCGv_i64 cpu_macc[4];
 
 static TCGv NULL_QREG;
 #define IS_NULL_QREG(t) (t == NULL_QREG)
-/* Used to distinguish stores from bad addressing modes.  */
-static TCGv store_dummy;
 
 void m68k_tcg_init(void)
 {
@@ -105,7 +103,6 @@ void m68k_tcg_init(void)
     }
 
     NULL_QREG = tcg_global_mem_new(tcg_env, -4, "NULL");
-    store_dummy = tcg_global_mem_new(tcg_env, -8, "NULL");
 }
 
 /* internal defines */
@@ -339,21 +336,6 @@ typedef enum {
     EA_LOADS
 } ea_what;
 
-/*
- * Generate an unsigned load if VAL is 0 a signed load if val is -1,
- * otherwise generate a store.
- */
-static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
-                     ea_what what, int index)
-{
-    if (what == EA_STORE) {
-        gen_store(s, opsize, addr, val, index);
-        return store_dummy;
-    } else {
-        return gen_load(s, opsize, addr, what == EA_LOADS, index);
-    }
-}
-
 /* Read a 16-bit immediate constant */
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
@@ -795,9 +777,9 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
  * a write otherwise it is a read (0 == sign extend, -1 == zero extend).
  * ADDRP is non-null for readwrite operands.
  */
-static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
-                        int opsize, TCGv val, TCGv *addrp, ea_what what,
-                        int index)
+static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
+                          int mode, int reg0, int opsize, TCGv *addrp,
+                          int sign, int index)
 {
     TCGv reg, ret, addr = NULL;
     int32_t offset;
@@ -805,40 +787,28 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     switch (mode) {
     case 0: /* Data register direct.  */
         reg = cpu_dregs[reg0];
-        if (what == EA_STORE) {
-            gen_partset_reg(opsize, reg, val);
-            ret = store_dummy;
-        } else {
-            ret = gen_extend(s, reg, opsize, what == EA_LOADS);
-        }
+        ret = gen_extend(s, reg, opsize, sign);
         break;
 
     case 1: /* Address register direct.  */
         reg = get_areg(s, reg0);
-        if (what == EA_STORE) {
-            tcg_gen_mov_i32(reg, val);
-            ret = store_dummy;
-        } else {
-            ret = gen_extend(s, reg, opsize, what == EA_LOADS);
-        }
+        ret = gen_extend(s, reg, opsize, sign);
         break;
 
     case 7: /* Other */
-        if (reg0 == 4 && what != EA_STORE) {
+        if (reg0 == 4) {
             /* Immediate: sign extend values for consistency.  */
             switch (opsize) {
             case OS_BYTE:
-                if (what == EA_LOADS) {
-                    offset = (int8_t)read_im8(env, s);
-                } else {
-                    offset = read_im8(env, s);
+                offset = read_im8(env, s);
+                if (sign) {
+                    offset = (int8_t)offset;
                 }
                 break;
             case OS_WORD:
-                if (what == EA_LOADS) {
-                    offset = (int16_t)read_im16(env, s);
-                } else {
-                    offset = read_im16(env, s);
+                offset = read_im16(env, s);
+                if (sign) {
+                    offset = (int16_t)offset;
                 }
                 break;
             case OS_LONG:
@@ -857,17 +827,13 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     case 4: /* Indirect predecrememnt.  */
     case 5: /* Indirect displacement.  */
     case 6: /* Indirect index + displacement.  */
-        if (what == EA_STORE && addrp && *addrp) {
-            addr = *addrp;
-        } else {
-            addr = gen_lea_mode(env, s, mode, reg0, opsize);
-            if (IS_NULL_QREG(addr)) {
-                ret = addr;
-                addr = NULL;
-                break;
-            }
+        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        if (IS_NULL_QREG(addr)) {
+            ret = addr;
+            addr = NULL;
+            break;
         }
-        ret = gen_ldst(s, opsize, addr, val, what, index);
+        ret = gen_load(s, opsize, addr, sign, index);
         break;
 
     default:
@@ -880,6 +846,43 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     return ret;
 }
 
+static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
+                           int mode, int reg0, int opsize,
+                           TCGv val, TCGv addr, int index)
+{
+    TCGv reg;
+
+    switch (mode) {
+    case 0: /* Data register direct.  */
+        reg = cpu_dregs[reg0];
+        gen_partset_reg(opsize, reg, val);
+        return true;
+
+    case 1: /* Address register direct.  */
+        reg = get_areg(s, reg0);
+        tcg_gen_mov_i32(reg, val);
+        return true;
+
+    case 2: /* Indirect register */
+    case 3: /* Indirect postincrement.  */
+    case 4: /* Indirect predecrememnt.  */
+    case 5: /* Indirect displacement.  */
+    case 6: /* Indirect index + displacement.  */
+    case 7: /* Other */
+        if (!addr) {
+            addr = gen_lea_mode(env, s, mode, reg0, opsize);
+            if (IS_NULL_QREG(addr)) {
+                return false;
+            }
+        }
+        gen_store(s, opsize, addr, val, index);
+        return true;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static TCGv_ptr gen_fp_ptr(int freg)
 {
     TCGv_ptr fp = tcg_temp_new_ptr();
@@ -1322,13 +1325,9 @@ static void gen_exit_tb(DisasContext *s)
 
 #define SRC_EA(env, result, opsize, op_sign, addrp)                     \
     do {                                                                \
-        TCGv *addrp_ = (addrp);                                         \
-        if (addrp_) {                                                   \
-            *addrp_ = NULL;                                             \
-        }                                                               \
-        result = gen_ea_mode(env, s, extract32(insn, 3, 3),             \
-                             REG(insn, 0), opsize, NULL_QREG, addrp_,   \
-                             op_sign ? EA_LOADS : EA_LOADU, IS_USER(s)); \
+        result = gen_load_mode(env, s, extract32(insn, 3, 3),           \
+                               REG(insn, 0), opsize, addrp,             \
+                               op_sign, IS_USER(s));                    \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
             return;                                                     \
@@ -1337,10 +1336,10 @@ static void gen_exit_tb(DisasContext *s)
 
 #define DEST_EA(env, insn, opsize, val, addrp)                          \
     do {                                                                \
-        TCGv ea_result = gen_ea_mode(env, s, extract32(insn, 3, 3),     \
-                                     REG(insn, 0), opsize, val, addrp,  \
-                                     EA_STORE, IS_USER(s));             \
-        if (IS_NULL_QREG(ea_result)) {                                  \
+        TCGv *addrp_ = (addrp);                                         \
+        if (!gen_store_mode(env, s, extract32(insn, 3, 3),              \
+                            REG(insn, 0), opsize, val,                  \
+                            addrp_ ? *addrp_ : NULL, IS_USER(s))) {     \
             gen_addr_fault(s);                                          \
             return;                                                     \
         }                                                               \
@@ -1702,15 +1701,14 @@ DISAS_INSN(abcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                      NULL_QREG, NULL, EA_LOADU, IS_USER(s));
-    dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                       NULL_QREG, &addr, EA_LOADU, IS_USER(s));
+    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
+                        NULL, false, IS_USER(s));
+    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
+                         &addr, false, IS_USER(s));
 
     bcd_add(dest, src);
 
-    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
-                EA_STORE, IS_USER(s));
+    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1739,15 +1737,14 @@ DISAS_INSN(sbcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                      NULL_QREG, NULL, EA_LOADU, IS_USER(s));
-    dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                       NULL_QREG, &addr, EA_LOADU, IS_USER(s));
+    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
+                        NULL, false, IS_USER(s));
+    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
+                         &addr, false, IS_USER(s));
 
     bcd_sub(dest, src);
 
-    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
-                EA_STORE, IS_USER(s));
+    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -3124,11 +3121,11 @@ DISAS_INSN(cmpm)
     TCGv src, dst;
 
     /* Post-increment load (mode 3) from Ay.  */
-    src = gen_ea_mode(env, s, 3, REG(insn, 0), opsize,
-                      NULL_QREG, NULL, EA_LOADS, IS_USER(s));
+    src = gen_load_mode(env, s, 3, REG(insn, 0), opsize,
+                        NULL, true, IS_USER(s));
     /* Post-increment load (mode 3) from Ax.  */
-    dst = gen_ea_mode(env, s, 3, REG(insn, 9), opsize,
-                      NULL_QREG, NULL, EA_LOADS, IS_USER(s));
+    dst = gen_load_mode(env, s, 3, REG(insn, 9), opsize,
+                        NULL, true, IS_USER(s));
 
     gen_update_cc_cmp(s, dst, src, opsize);
 }
-- 
2.43.0


