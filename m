Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B6CECE585
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC0-0004xf-OR; Mon, 09 Sep 2024 13:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBr-0004Rv-Pw
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:40 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBp-000628-Jw
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:39 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7d50e7a3652so2517368a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902916; x=1726507716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4dTvSybEV7VzDyHmHb8tECkMFQaU3PsYdjzGv5GBu8=;
 b=wG3VSMKhMis9KqflPxTR4LQOLykkaZANb/tGcpqwQzToVo6kzg61bBwYSYbraZfehX
 EiU4BmLlgtTPLOd/w0wdyfYGPVVM/yxbAEdvNJd5GKYlVxFTeETX+yPPp148OGqeLhdF
 3VBLcdscuDzXDXJlw7ve9fs89jEcHEU8svriQhTrd2W2Fyl2sbj4kF4Peezfdcpjfm+H
 eSVInGqidufHlDEm1EyTzR4oJHrlxvXPbUtwWnPz1U6Wwzdd+O9kWE7jvWOVhpWJREkp
 dOHnnTO2lzxhAIrfX+htNomkbTSbMd2cE4puu0YFI2WiRyoLzVnqhxBvlQhih6VX5GnQ
 uEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902916; x=1726507716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4dTvSybEV7VzDyHmHb8tECkMFQaU3PsYdjzGv5GBu8=;
 b=SSkYG5RYb7ZwG4N3ZkmXt76VTjNJtHPri/EpfQDJFCc2gcO3+QxISAm5ihqkFv+R5e
 ngtDzUiFW59lFwUys6ezjswx+vIjhP3GM/mynosN0NTrM27cvciKQ5VUqM2gtALu5UUm
 6fIZ+Agg9GRi6EIJVCo1IqkhvhCCyi78uuJ76zqJfhytCDSgY/aovh5H5Aq+1JyCTnDf
 Go/9aVH36aRnlolNYcn+oNos6dgVj/63DbgBnv1xBMZAot4o1HDzXseSNBDLYA/MOgng
 p37rNTQnRR0BXz0+mQZsYqR9YknjB+I5RBu458aJrnHPr6mh5eS754RO49dohRxC3EVL
 YjFA==
X-Gm-Message-State: AOJu0YzlfHzeQS2hdfbGL+NEE6c2Th1GRqRwbIU+g9QHXDgJObDZ/1Ir
 AMHcxWQerkxMJ5EsXP6WRiP1g0sxLbV+qsJZzM2tiF9Xb/URsifcNKQR1zvNAl3iX9cfgZ7A+rh
 9
X-Google-Smtp-Source: AGHT+IFrBv44dgsJ9x5gqVQNmnnlPJCEZH/bHgNE82aEbM79GjGCCTtR5CwiPFWb84jmEBk9qVmEQA==
X-Received: by 2002:a17:902:e848:b0:206:ca91:1dda with SMTP id
 d9443c01a7336-206f04f6634mr90176705ad.17.1725902916093; 
 Mon, 09 Sep 2024 10:28:36 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 12/26] target/m68k: Move pre-dec/post-inc to gen_lea_mode
Date: Mon,  9 Sep 2024 10:28:09 -0700
Message-ID: <20240909172823.649837-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Move autoinc down the call chain so that it happens in one place,
more or less.  This unifies code from gen_ea_mode and gen_ea_mode_fp,
as well as the by-hand autoinc from CAS, TAS, MOVES, and MAC.
In FMOVE_FCR and FMOVEM, use delay_set_areg to update the value
to be stored at the end of the insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 264 +++++++++++++++-------------------------
 1 file changed, 95 insertions(+), 169 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index c94ed8d463..c6b901ff83 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -698,15 +698,23 @@ static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
     }
 }
 
+static int addr_inc_size(DisasContext *s, int reg0, int opsize)
+{
+    if (reg0 == 7
+        && opsize == OS_BYTE
+        && m68k_feature(s->env, M68K_FEATURE_M68K)) {
+        return 2;
+    }
+    return opsize_bytes(opsize);
+}
+
 /*
- * Generate code for an "effective address".  Does not adjust the base
- * register for autoincrement addressing modes.
+ * Generate code for an "effective address".
  */
 static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
                          int mode, int reg0, int opsize)
 {
-    TCGv reg;
-    TCGv tmp;
+    TCGv reg, addr, tmp;
     uint16_t ext;
     uint32_t offset;
 
@@ -714,34 +722,37 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
     case 0: /* Data register direct.  */
     case 1: /* Address register direct.  */
         return NULL_QREG;
+    case 2: /* Indirect register */
+        reg = get_areg(s, reg0);
+        addr = tcg_temp_new();
+        tcg_gen_mov_i32(addr, reg);
+        return addr;
     case 3: /* Indirect postincrement.  */
         if (opsize == OS_UNSIZED) {
             return NULL_QREG;
         }
-        /* fallthru */
-    case 2: /* Indirect register */
+        reg = get_areg(s, reg0);
+        addr = tcg_temp_new();
+        tcg_gen_mov_i32(addr, get_areg(s, reg0));
         tmp = tcg_temp_new();
-        tcg_gen_mov_i32(tmp, get_areg(s, reg0));
-        return tmp;
+        tcg_gen_addi_i32(tmp, reg, addr_inc_size(s, reg0, opsize));
+        delay_set_areg(s, reg0, tmp, true);
+        return addr;
     case 4: /* Indirect predecrememnt.  */
         if (opsize == OS_UNSIZED) {
             return NULL_QREG;
         }
         reg = get_areg(s, reg0);
-        tmp = tcg_temp_new();
-        if (reg0 == 7 && opsize == OS_BYTE &&
-            m68k_feature(s->env, M68K_FEATURE_M68K)) {
-            tcg_gen_subi_i32(tmp, reg, 2);
-        } else {
-            tcg_gen_subi_i32(tmp, reg, opsize_bytes(opsize));
-        }
-        return tmp;
+        addr = tcg_temp_new();
+        tcg_gen_subi_i32(addr, reg, addr_inc_size(s, reg0, opsize));
+        delay_set_areg(s, reg0, addr, false);
+        return addr;
     case 5: /* Indirect displacement.  */
         reg = get_areg(s, reg0);
-        tmp = tcg_temp_new();
+        addr = tcg_temp_new();
         ext = read_im16(env, s);
-        tcg_gen_addi_i32(tmp, reg, (int16_t)ext);
-        return tmp;
+        tcg_gen_addi_i32(addr, reg, (int16_t)ext);
+        return addr;
     case 6: /* Indirect index + displacement.  */
         reg = get_areg(s, reg0);
         return gen_lea_indexed(env, s, reg);
@@ -787,7 +798,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
                         int opsize, TCGv val, TCGv *addrp, ea_what what,
                         int index)
 {
-    TCGv reg, tmp, result;
+    TCGv reg, ret, addr = NULL;
     int32_t offset;
 
     switch (mode) {
@@ -795,76 +806,25 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
         reg = cpu_dregs[reg0];
         if (what == EA_STORE) {
             gen_partset_reg(opsize, reg, val);
-            return store_dummy;
+            ret = store_dummy;
         } else {
-            return gen_extend(s, reg, opsize, what == EA_LOADS);
+            ret = gen_extend(s, reg, opsize, what == EA_LOADS);
         }
+        break;
+
     case 1: /* Address register direct.  */
         reg = get_areg(s, reg0);
         if (what == EA_STORE) {
             tcg_gen_mov_i32(reg, val);
-            return store_dummy;
+            ret = store_dummy;
         } else {
-            return gen_extend(s, reg, opsize, what == EA_LOADS);
+            ret = gen_extend(s, reg, opsize, what == EA_LOADS);
         }
-    case 2: /* Indirect register */
-        reg = get_areg(s, reg0);
-        return gen_ldst(s, opsize, reg, val, what, index);
-    case 3: /* Indirect postincrement.  */
-        reg = get_areg(s, reg0);
-        result = gen_ldst(s, opsize, reg, val, what, index);
-        if (what == EA_STORE || !addrp) {
-            tmp = tcg_temp_new();
-            if (reg0 == 7 && opsize == OS_BYTE &&
-                m68k_feature(s->env, M68K_FEATURE_M68K)) {
-                tcg_gen_addi_i32(tmp, reg, 2);
-            } else {
-                tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
-            }
-            delay_set_areg(s, reg0, tmp, true);
-        }
-        return result;
-    case 4: /* Indirect predecrememnt.  */
-        if (addrp && what == EA_STORE) {
-            tmp = *addrp;
-        } else {
-            tmp = gen_lea_mode(env, s, mode, reg0, opsize);
-            if (IS_NULL_QREG(tmp)) {
-                return tmp;
-            }
-            if (addrp) {
-                *addrp = tmp;
-            }
-        }
-        result = gen_ldst(s, opsize, tmp, val, what, index);
-        if (what == EA_STORE || !addrp) {
-            delay_set_areg(s, reg0, tmp, false);
-        }
-        return result;
-    case 5: /* Indirect displacement.  */
-    case 6: /* Indirect index + displacement.  */
-    do_indirect:
-        if (addrp && what == EA_STORE) {
-            tmp = *addrp;
-        } else {
-            tmp = gen_lea_mode(env, s, mode, reg0, opsize);
-            if (IS_NULL_QREG(tmp)) {
-                return tmp;
-            }
-            if (addrp) {
-                *addrp = tmp;
-            }
-        }
-        return gen_ldst(s, opsize, tmp, val, what, index);
+        break;
+
     case 7: /* Other */
-        switch (reg0) {
-        case 0: /* Absolute short.  */
-        case 1: /* Absolute long.  */
-        case 2: /* pc displacement  */
-        case 3: /* pc index+displacement.  */
-            goto do_indirect;
-        case 4: /* Immediate.  */
-            /* Sign extend values for consistency.  */
+        if (reg0 == 4 && what != EA_STORE) {
+            /* Immediate: sign extend values for consistency.  */
             switch (opsize) {
             case OS_BYTE:
                 if (what == EA_LOADS) {
@@ -886,12 +846,37 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             default:
                 g_assert_not_reached();
             }
-            return tcg_constant_i32(offset);
-        default:
-            return NULL_QREG;
+            ret = tcg_constant_i32(offset);
+            break;
         }
+        /* fall through */
+
+    case 2: /* Indirect register */
+    case 3: /* Indirect postincrement.  */
+    case 4: /* Indirect predecrememnt.  */
+    case 5: /* Indirect displacement.  */
+    case 6: /* Indirect index + displacement.  */
+        if (what == EA_STORE && addrp && *addrp) {
+            addr = *addrp;
+        } else {
+            addr = gen_lea_mode(env, s, mode, reg0, opsize);
+            if (IS_NULL_QREG(addr)) {
+                ret = addr;
+                addr = NULL;
+                break;
+            }
+        }
+        ret = gen_ldst(s, opsize, addr, val, what, index);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
-    g_assert_not_reached();
+
+    if (addrp) {
+        *addrp = addr;
+    }
+    return ret;
 }
 
 static TCGv_ptr gen_fp_ptr(int freg)
@@ -1068,43 +1053,9 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
         return 0;
     case 1: /* Address register direct.  */
         return -1;
-    case 2: /* Indirect register */
-        addr = get_areg(s, reg0);
-        gen_ldst_fp(s, opsize, addr, fp, what, index);
-        return 0;
-    case 3: /* Indirect postincrement.  */
-        addr = cpu_aregs[reg0];
-        gen_ldst_fp(s, opsize, addr, fp, what, index);
-        tcg_gen_addi_i32(addr, addr, opsize_bytes(opsize));
-        return 0;
-    case 4: /* Indirect predecrememnt.  */
-        addr = gen_lea_mode(env, s, mode, reg0, opsize);
-        if (IS_NULL_QREG(addr)) {
-            return -1;
-        }
-        gen_ldst_fp(s, opsize, addr, fp, what, index);
-        tcg_gen_mov_i32(cpu_aregs[reg0], addr);
-        return 0;
-    case 5: /* Indirect displacement.  */
-    case 6: /* Indirect index + displacement.  */
-    do_indirect:
-        addr = gen_lea_mode(env, s, mode, reg0, opsize);
-        if (IS_NULL_QREG(addr)) {
-            return -1;
-        }
-        gen_ldst_fp(s, opsize, addr, fp, what, index);
-        return 0;
+
     case 7: /* Other */
-        switch (reg0) {
-        case 0: /* Absolute short.  */
-        case 1: /* Absolute long.  */
-        case 2: /* pc displacement  */
-        case 3: /* pc index+displacement.  */
-            goto do_indirect;
-        case 4: /* Immediate.  */
-            if (what == EA_STORE) {
-                return -1;
-            }
+        if (reg0 == 4 && what != EA_STORE) {
             switch (opsize) {
             case OS_BYTE:
                 tmp = tcg_constant_i32((int8_t)read_im8(env, s));
@@ -1147,11 +1098,22 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
                 g_assert_not_reached();
             }
             return 0;
-        default:
+        }
+        /* fall through */
+
+    case 2: /* Indirect register */
+    case 3: /* Indirect postincrement.  */
+    case 4: /* Indirect predecrememnt.  */
+    case 5: /* Indirect displacement.  */
+    case 6: /* Indirect index + displacement.  */
+        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        if (IS_NULL_QREG(addr)) {
             return -1;
         }
+        gen_ldst_fp(s, opsize, addr, fp, what, index);
+        return 0;
     }
-    return -1;
+    g_assert_not_reached();
 }
 
 static int gen_ea_fp(CPUM68KState *env, DisasContext *s, uint16_t insn,
@@ -1359,8 +1321,12 @@ static void gen_exit_tb(DisasContext *s)
 
 #define SRC_EA(env, result, opsize, op_sign, addrp)                     \
     do {                                                                \
+        TCGv *addrp_ = (addrp);                                         \
+        if (addrp_) {                                                   \
+            *addrp_ = NULL;                                             \
+        }                                                               \
         result = gen_ea_mode(env, s, extract32(insn, 3, 3),             \
-                             REG(insn, 0), opsize, NULL_QREG, addrp,    \
+                             REG(insn, 0), opsize, NULL_QREG, addrp_,   \
                              op_sign ? EA_LOADS : EA_LOADU, IS_USER(s)); \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
@@ -1729,7 +1695,7 @@ DISAS_INSN(abcd_reg)
 
 DISAS_INSN(abcd_mem)
 {
-    TCGv src, dest, addr;
+    TCGv src, dest, addr = NULL;
 
     gen_flush_flags(s); /* !Z is sticky */
 
@@ -1766,7 +1732,7 @@ DISAS_INSN(sbcd_reg)
 
 DISAS_INSN(sbcd_mem)
 {
-    TCGv src, dest, addr;
+    TCGv src, dest, addr = NULL;
 
     gen_flush_flags(s); /* !Z is sticky */
 
@@ -2355,15 +2321,6 @@ DISAS_INSN(cas)
     /* update flags before setting cmp to load */
     gen_update_cc_cmp(s, load, cmp, opsize);
     gen_partset_reg(opsize, DREG(ext, 0), load);
-
-    switch (extract32(insn, 3, 3)) {
-    case 3: /* Indirect postincrement.  */
-        tcg_gen_addi_i32(AREG(insn, 0), addr, opsize_bytes(opsize));
-        break;
-    case 4: /* Indirect predecrememnt.  */
-        tcg_gen_mov_i32(AREG(insn, 0), addr);
-        break;
-    }
 }
 
 DISAS_INSN(cas2w)
@@ -2727,15 +2684,6 @@ DISAS_INSN(tas)
         tcg_gen_atomic_fetch_or_tl(src1, addr, tcg_constant_tl(0x80),
                                    IS_USER(s), MO_SB);
         gen_logic_cc(s, src1, OS_BYTE);
-
-        switch (mode) {
-        case 3: /* Indirect postincrement.  */
-            tcg_gen_addi_i32(AREG(insn, 0), addr, 1);
-            break;
-        case 4: /* Indirect predecrememnt.  */
-            tcg_gen_mov_i32(AREG(insn, 0), addr);
-            break;
-        }
     }
 }
 
@@ -4452,17 +4400,6 @@ DISAS_INSN(moves)
             gen_partset_reg(opsize, reg, tmp);
         }
     }
-    switch (extract32(insn, 3, 3)) {
-    case 3: /* Indirect postincrement.  */
-        tcg_gen_addi_i32(AREG(insn, 0), addr,
-                         REG(insn, 0) == 7 && opsize == OS_BYTE
-                         ? 2
-                         : opsize_bytes(opsize));
-        break;
-    case 4: /* Indirect predecrememnt.  */
-        tcg_gen_mov_i32(AREG(insn, 0), addr);
-        break;
-    }
 }
 
 DISAS_INSN(move_to_sr)
@@ -4845,7 +4782,7 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
                 }
             }
        }
-       tcg_gen_mov_i32(AREG(insn, 0), addr);
+       delay_set_areg(s, REG(insn, 0), addr, true);
     } else {
         for (i = 0; i < 3; i++, mask >>= 1) {
             if (mask & 1) {
@@ -4860,7 +4797,7 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
             }
         }
         if (mode == 3) {
-            tcg_gen_mov_i32(AREG(insn, 0), addr);
+            delay_set_areg(s, REG(insn, 0), addr, true);
         }
     }
 }
@@ -4921,7 +4858,7 @@ static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
         }
     }
     if ((insn & 070) == 030 || (insn & 070) == 040) {
-        tcg_gen_mov_i32(AREG(insn, 0), tmp);
+        delay_set_areg(s, REG(insn, 0), tmp, true);
     }
 }
 
@@ -5572,17 +5509,6 @@ DISAS_INSN(mac)
         TCGv rw;
         rw = (insn & 0x40) ? AREG(insn, 9) : DREG(insn, 9);
         tcg_gen_mov_i32(rw, loadval);
-        /*
-         * FIXME: Should address writeback happen with the masked or
-         * unmasked value?
-         */
-        switch ((insn >> 3) & 7) {
-        case 3: /* Post-increment.  */
-            tcg_gen_addi_i32(AREG(insn, 0), addr, 4);
-            break;
-        case 4: /* Pre-decrement.  */
-            tcg_gen_mov_i32(AREG(insn, 0), addr);
-        }
     }
 }
 
-- 
2.43.0


