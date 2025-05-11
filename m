Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22101C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDOz-0002yp-RH; Sun, 11 May 2025 16:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOx-0002ly-GQ
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:59 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOv-0006LG-2S
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:59 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b1fcb97d209so4205374a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995755; x=1747600555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCkIdDSY0crVuCGfVkZY/TkUQKO0hTHMo7T3lmMlX/c=;
 b=PcOWZG5OJ83wR9Vk2BLebIrPIj9D7Q4Z2RlEqEMz2oOBwKezIawqcQEW+MeIUe8vvD
 SZ61k4m1GzgU7Q0GS26SXj1W2DpFBiiHuRa5n6kyJJxtd3zBtxV+NODAj4pgAZhIxN8C
 O17RQ96673/pQhx6jeB13VvkwvTExQT50CSf5G8U4c0HXzeIOJTS/BWNcxq0v8NUdngC
 A08+RsiChPeXOuMqIhRMpfUr1fhASkfppt02zF41nqRYAKMdvSA7W2Ue2O/0zDEZb4MR
 RkoIoDD/IupqF2pETjbiPLjwBx3eF0MMx+esB+EJ27k/DmzRGtVPbxNXbY+6kKpWZWlt
 vAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995755; x=1747600555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCkIdDSY0crVuCGfVkZY/TkUQKO0hTHMo7T3lmMlX/c=;
 b=GDQWh7JcFPL4h0gGT5RZlngINTxVQzgS936pw67zAzZcp1ubGMd0TY7jhJQt+rtjkF
 h/Je9WdY30eDzJnoeCLiRmLO1xJkkYKotWkrhyWtpbkv1+nogF7gwOQRyjAnT6/Z2Y4x
 YuzKF/tmicwtZbgB2mZX5OZfDmk9eNHqMf4gs0X21LUZZOveQO3LZYaYw958y35nzTiB
 50/yQtAbSZHIAHe53edzYGYJUYmK9ChP+Rp544LUMlyjJqqsMHR9w5JspvU93mt0NsNg
 1vYEZpVHDmkPFKiyp5+STN5wKLkWsECNQh+pFpkQHcU6ZJNPCxAXzRpJVufypGuYaLyw
 262w==
X-Gm-Message-State: AOJu0YxgJhjpFgF62sAhGJ8Js6gFc+RVfn+XX//lSFbZrEAZR8KCtXls
 FGlNYRqk48DSYiUsbl2yLsvwT0VNULf8QnIyrOgTZWZ0dMcTRFfcLxvlysn/HlQ/2ZMLiUq0gD/
 X
X-Gm-Gg: ASbGncuEmk9DRGOvubkamTGYudr6BmudOdxmwT0cbdm9kxEk1WqHuAA8g5xYGMoHs3C
 pnLsdLxZoNe3qDGL/S0pcaAXg1m+nBH0kQDWe/VqIMyPRK5bkb3aMFpUuvLgUtmM2f2flbRTxOV
 Lwobm9raVS8jqnuQunWrjLDg8v0qd4IYQN4VSjz6aRAMR5u1cxoj8EE0J3trp5svAy6v6nuVQSs
 1fzBtuogKAtLV0kJFA2DGEJnU9EN5SLLlSYMLN5T46zTZO9BqOwc+ujSGshWq/QJElxn4VICV+G
 kgJpre4QghEYNj4J6hX2e1G7BQ2F+JS1yKfTZwvyEuFVx28LaNjYqauGZI9DtF6d1C9ImmbPa1B
 vlrzd5eAyCg==
X-Google-Smtp-Source: AGHT+IFn5H14sBACARKq5VF8pHgDrnvfzhPr8FXiVxe7LkaP9x36rvA6jHtROE83AgxK7YlIqOv+vA==
X-Received: by 2002:a17:902:fc8d:b0:22e:457d:3989 with SMTP id
 d9443c01a7336-22e845bcb87mr238429085ad.0.1746995755540; 
 Sun, 11 May 2025 13:35:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	schwab@linux-m68k.org
Subject: [PATCH v6 10/24] target/m68k: Move pre-dec/post-inc to gen_lea_mode
Date: Sun, 11 May 2025 13:35:32 -0700
Message-ID: <20250511203546.139788-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
index b6d46c3bdb..593ff9ba2d 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -699,15 +699,23 @@ static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
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
 
@@ -715,34 +723,37 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
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
@@ -788,7 +799,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
                         int opsize, TCGv val, TCGv *addrp, ea_what what,
                         int index)
 {
-    TCGv reg, tmp, result;
+    TCGv reg, ret, addr = NULL;
     int32_t offset;
 
     switch (mode) {
@@ -796,76 +807,25 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
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
@@ -887,12 +847,37 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
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
@@ -1069,43 +1054,9 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
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
@@ -1148,11 +1099,22 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
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
@@ -1360,8 +1322,12 @@ static void gen_exit_tb(DisasContext *s)
 
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
@@ -1730,7 +1696,7 @@ DISAS_INSN(abcd_reg)
 
 DISAS_INSN(abcd_mem)
 {
-    TCGv src, dest, addr;
+    TCGv src, dest, addr = NULL;
 
     gen_flush_flags(s); /* !Z is sticky */
 
@@ -1767,7 +1733,7 @@ DISAS_INSN(sbcd_reg)
 
 DISAS_INSN(sbcd_mem)
 {
-    TCGv src, dest, addr;
+    TCGv src, dest, addr = NULL;
 
     gen_flush_flags(s); /* !Z is sticky */
 
@@ -2356,15 +2322,6 @@ DISAS_INSN(cas)
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
@@ -2728,15 +2685,6 @@ DISAS_INSN(tas)
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
 
@@ -4453,17 +4401,6 @@ DISAS_INSN(moves)
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
@@ -4846,7 +4783,7 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
                 }
             }
        }
-       tcg_gen_mov_i32(AREG(insn, 0), addr);
+       delay_set_areg(s, REG(insn, 0), addr, true);
     } else {
         for (i = 0; i < 3; i++, mask >>= 1) {
             if (mask & 1) {
@@ -4861,7 +4798,7 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
             }
         }
         if (mode == 3) {
-            tcg_gen_mov_i32(AREG(insn, 0), addr);
+            delay_set_areg(s, REG(insn, 0), addr, true);
         }
     }
 }
@@ -4922,7 +4859,7 @@ static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
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


