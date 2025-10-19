Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC8BCCD1AA
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY9F-0005Ci-Gl; Sun, 19 Oct 2025 14:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY99-0005B8-DA
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:47 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY96-0000aM-9V
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:47 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so3745963a12.2
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898523; x=1761503323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vPqycgqeHYP9wqVvXLdWY9Rm0HF5lWr6/dZ0KCgJxg=;
 b=WTZXsu2/ozW/+cxFsnrxo2ZWy4iO2iCFccgoCkQnST6nNj1KcipESscu20OEutrEGQ
 j8obrT9ANBhUyj45Sommov3+j9AESlGOVkiO98nWgkeZpmy/yj8oDLHt7J3Q/f0ESBwP
 4B7FSWYnfP2Li7I+h1si881r9ma6XrlBdxuCNrp1mZofaaoa+kTJI9DCJH/eHGYGEv5W
 SLgGRLHajBke0fp9qGYIE44IYWXrYqwYdGasgfxyf/IoejQ/505c2BS5kP/UYrcz+Cm+
 WaYuIagAvS1twn/eLFwDSL3b1cEPGvf4ICOZzgL2XA8E3X8Ec2dRu6z36CR36wx6DUf0
 cDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898523; x=1761503323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vPqycgqeHYP9wqVvXLdWY9Rm0HF5lWr6/dZ0KCgJxg=;
 b=tqlbxtX5TSfXjKQE9bunD4hi5f0JBILUxfBW4jI8er3N2Xo/Li8+JQlbt3waW43kuZ
 jkOnumUZgKB01ZjB/yi1xvT4lBo1VndvsS0y0z6cx/9+gR8SXl/eCkpnqCj6cwzVTbks
 MHaEu3+TqINQ2cm2BMS5I1xch+BluoS8mFJXw5onJAO4LFkE8El6Rag7ezf6BhjaDusN
 JSbylgkqFjqRdzhjbPayQGBX3Y13MImACzq6oBT87C80/Up9xwK2T1iEKTvYz9no07KQ
 UXNp1NBz1N0dI3VngP9Mcj49AH38Eip6VNCUjtDIDOBgxXPUdtcGG46aCElLj71hSAol
 nmgA==
X-Gm-Message-State: AOJu0YzB2KVEdU0wpD5cpwMErxH7sRSagzz8ErErc3F66JIvX4CXzhGB
 /RnJvhDCvYk7kPwaw4PZq6VPATxYw98SfGvCpeWH136nR6GOS/RKOqWjkvaJqXnVZ89nRkBBD+W
 EAD3NBqw=
X-Gm-Gg: ASbGncvAfuPHkhrz78m3rTnBHfcYFebiyahex1Z1lESFiUgAp75AA9Y+Ofp7A5pfcgR
 hGKXKWdtIXuRR/xgztqXvkyCdKIFEVPE9Y5ougeFSsJbVs1RhnrDnXCLxo2MZI04Qp06kApfO2l
 uS/VeKVJoPR5cCx7zkyCxt8JrbxpYp+BWjP4w1EqTwUhKXnWwwbLr+z7pPrPRjTCDyd6fWy0zr2
 OCNor5bnHayvabKAiBdNOy5AeY7lhpFZMh+Igoi6XwFsO9Q3ZSAFh2M2ee4v7UEz6ysOES3HmH6
 eC6jdpnxCbrOUzNE7QbXUFQa/c3jSVUaXdwK7zEaRYh7/e7J5za+TJTg1mZAwVnEKMNwTAsLniX
 dKETEXILfhVAf21DYH6ny8WTr0evu9PvRdKYOBteMc3jp+VzfR5ole28f0y+sXrQ80Ihm8Z4wgG
 jjywSiZw==
X-Google-Smtp-Source: AGHT+IEgp4izNpnMmxvgGEdPwu0QTrIhDikKgR0Ur20NkqoTX4XacTTzWrSohfwNggTiX1dkfiLwCA==
X-Received: by 2002:a17:902:e546:b0:269:91b2:e9d6 with SMTP id
 d9443c01a7336-290cb65c529mr138388435ad.46.1760898522434; 
 Sun, 19 Oct 2025 11:28:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 9/9] tcg/ppc: Remove support for 32-bit hosts
Date: Sun, 19 Oct 2025 11:28:34 -0700
Message-ID: <20251019182834.481541-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
References: <20251019182834.481541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"), released as v10.0.
The next release being v10.2, we can remove the TCG backend
for 32-bit PPC hosts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251014173900.87497-2-philmd@linaro.org>
---
 tcg/ppc/tcg-target-has.h      |   5 +-
 tcg/ppc/tcg-target-reg-bits.h |   8 +-
 tcg/ppc/tcg-target.c.inc      | 385 +++++++---------------------------
 3 files changed, 79 insertions(+), 319 deletions(-)

diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 81ec5aece7..a3711feeae 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,12 +17,9 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional instructions */
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#endif
 
-#define TCG_TARGET_HAS_qemu_ldst_i128   \
-    (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
+#define TCG_TARGET_HAS_qemu_ldst_i128   have_isa_2_07
 
 #define TCG_TARGET_HAS_tst              1
 
diff --git a/tcg/ppc/tcg-target-reg-bits.h b/tcg/ppc/tcg-target-reg-bits.h
index 0efa80e7e0..3a15d7bee4 100644
--- a/tcg/ppc/tcg-target-reg-bits.h
+++ b/tcg/ppc/tcg-target-reg-bits.h
@@ -7,10 +7,10 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#ifdef _ARCH_PPC64
-# define TCG_TARGET_REG_BITS  64
-#else
-# define TCG_TARGET_REG_BITS  32
+#ifndef _ARCH_PPC64
+# error Expecting 64-bit host architecture
 #endif
 
+#define TCG_TARGET_REG_BITS  64
+
 #endif
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index cd2b68f9e1..3c36b26f25 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -29,35 +29,18 @@
  * Apple XCode does not define _CALL_DARWIN.
  * Clang defines _CALL_ELF (64-bit) but not _CALL_SYSV or _CALL_AIX.
  */
-#if TCG_TARGET_REG_BITS == 64
-# ifdef _CALL_AIX
+#ifdef _CALL_AIX
     /* ok */
-# elif defined(_CALL_ELF) && _CALL_ELF == 1
+#elif defined(_CALL_ELF) && _CALL_ELF == 1
 #  define _CALL_AIX
-# elif defined(_CALL_ELF) && _CALL_ELF == 2
+#elif defined(_CALL_ELF) && _CALL_ELF == 2
     /* ok */
-# else
-#  error "Unknown ABI"
-# endif
 #else
-# if defined(_CALL_SYSV) || defined(_CALL_DARWIN)
-    /* ok */
-# elif defined(__APPLE__)
-#  define _CALL_DARWIN
-# elif defined(__ELF__)
-#  define _CALL_SYSV
-# else
 #  error "Unknown ABI"
-# endif
 #endif
 
-#if TCG_TARGET_REG_BITS == 64
-# define TCG_TARGET_CALL_ARG_I32   TCG_CALL_ARG_EXTEND
-# define TCG_TARGET_CALL_RET_I128  TCG_CALL_RET_NORMAL
-#else
-# define TCG_TARGET_CALL_ARG_I32   TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128  TCG_CALL_RET_BY_REF
-#endif
+#define TCG_TARGET_CALL_ARG_I32   TCG_CALL_ARG_EXTEND
+#define TCG_TARGET_CALL_RET_I128  TCG_CALL_RET_NORMAL
 #ifdef _CALL_SYSV
 # define TCG_TARGET_CALL_ARG_I64   TCG_CALL_ARG_EVEN
 # define TCG_TARGET_CALL_ARG_I128  TCG_CALL_ARG_BY_REF
@@ -81,7 +64,7 @@
 #define TCG_VEC_TMP2    TCG_REG_V1
 
 #define TCG_REG_TB     TCG_REG_R31
-#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64 && !have_isa_3_00)
+#define USE_REG_TB     !have_isa_3_00
 
 /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
 #define SZP  ((int)sizeof(void *))
@@ -327,8 +310,7 @@ static bool tcg_target_const_match(int64_t sval, int ct,
             if (uval == (uint32_t)uval && mask_operand(uval, &mb, &me)) {
                 return 1;
             }
-            if (TCG_TARGET_REG_BITS == 64 &&
-                mask64_operand(uval << clz64(uval), &mb, &me)) {
+            if (mask64_operand(uval << clz64(uval), &mb, &me)) {
                 return 1;
             }
             return 0;
@@ -857,10 +839,8 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
         return true;
     }
     switch (type) {
-    case TCG_TYPE_I64:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-        /* fallthru */
     case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
         if (ret < TCG_REG_V0) {
             if (arg < TCG_REG_V0) {
                 tcg_out32(s, OR | SAB(arg, ret, arg));
@@ -898,7 +878,6 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 static void tcg_out_rld_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
                            int sh, int mb, bool rc)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     sh = SH(sh & 0x1f) | (((sh >> 5) & 1) << 1);
     mb = MB64((mb >> 5) | ((mb << 1) & 0x3f));
     tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb | rc);
@@ -946,13 +925,11 @@ static void tcg_out_ext16u(TCGContext *s, TCGReg dst, TCGReg src)
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg dst, TCGReg src)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out32(s, EXTSW | RA(dst) | RS(src));
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg dst, TCGReg src)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out_rld(s, RLDICL, dst, src, 0, 32);
 }
 
@@ -968,7 +945,6 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg dst, TCGReg src)
 
 static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out_mov(s, TCG_TYPE_I32, rd, rn);
 }
 
@@ -1037,9 +1013,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     tcg_target_long tmp;
     int shift;
 
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-
-    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+    if (type == TCG_TYPE_I32) {
         arg = (int32_t)arg;
     }
 
@@ -1076,7 +1050,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 
     /* Load 32-bit immediates with two insns.  Note that we've already
        eliminated bare ADDIS, so we know both insns are required.  */
-    if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
+    if (arg == (int32_t)arg) {
         tcg_out32(s, ADDIS | TAI(ret, 0, arg >> 16));
         tcg_out32(s, ORI | SAI(ret, ret, arg));
         return;
@@ -1227,19 +1201,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (have_vsx) {
         load_insn = type == TCG_TYPE_V64 ? LXSDX : LXVDSX;
         load_insn |= VRT(ret) | RB(TCG_REG_TMP1);
-        if (TCG_TARGET_REG_BITS == 64) {
-            new_pool_label(s, val, rel, s->code_ptr, add);
-        } else {
-            new_pool_l2(s, rel, s->code_ptr, add, val >> 32, val);
-        }
+        new_pool_label(s, val, rel, s->code_ptr, add);
     } else {
         load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
-        if (TCG_TARGET_REG_BITS == 64) {
-            new_pool_l2(s, rel, s->code_ptr, add, val, val);
-        } else {
-            new_pool_l4(s, rel, s->code_ptr, add,
-                        val >> 32, val, val >> 32, val);
-        }
+        new_pool_l2(s, rel, s->code_ptr, add, val, val);
     }
 
     if (USE_REG_TB) {
@@ -1351,7 +1316,6 @@ static void tcg_out_andi64(TCGContext *s, TCGReg dst, TCGReg src, uint64_t c)
 {
     int mb, me;
 
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     if (mask64_operand(c, &mb, &me)) {
         if (mb == 0) {
             tcg_out_rld(s, RLDICR, dst, src, 0, me);
@@ -1543,7 +1507,6 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         break;
     case TCG_TYPE_I64:
         if (ret < TCG_REG_V0) {
-            tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
             tcg_out_mem_long(s, LD, LDX, ret, base, offset);
             break;
         }
@@ -1598,7 +1561,6 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         break;
     case TCG_TYPE_I64:
         if (arg < TCG_REG_V0) {
-            tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
             tcg_out_mem_long(s, STD, STDX, arg, base, offset);
             break;
         }
@@ -1641,7 +1603,7 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
                          bool const_arg2, TCGType type, bool rc)
 {
-    int mb, me;
+    int mb, me, sh;
 
     if (!const_arg2) {
         tcg_out32(s, AND | SAB(arg1, dest, arg2) | rc);
@@ -1664,12 +1626,10 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
         tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
         return;
     }
-    if (TCG_TARGET_REG_BITS == 64) {
-        int sh = clz64(arg2);
-        if (mask64_operand(arg2 << sh, &mb, &me)) {
-            tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
-            return;
-        }
+    sh = clz64(arg2);
+    if (mask64_operand(arg2 << sh, &mb, &me)) {
+        tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
+        return;
     }
     /* Constraints should satisfy this. */
     g_assert_not_reached();
@@ -1680,8 +1640,6 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
 {
     uint32_t op;
 
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-
     /*
      * Simplify the comparisons below wrt CMPI.
      * All of the tests are 16-bit, so a 32-bit sign extend always works.
@@ -1747,7 +1705,7 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
 static void tcg_out_setcond_eq0(TCGContext *s, TCGType type,
                                 TCGReg dst, TCGReg src, bool neg)
 {
-    if (neg && (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I64)) {
+    if (neg && type == TCG_TYPE_I64) {
         /*
          * X != 0 implies X + -1 generates a carry.
          * RT = (~X + X) + CA
@@ -1774,7 +1732,7 @@ static void tcg_out_setcond_eq0(TCGContext *s, TCGType type,
 static void tcg_out_setcond_ne0(TCGContext *s, TCGType type,
                                 TCGReg dst, TCGReg src, bool neg)
 {
-    if (!neg && (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I64)) {
+    if (!neg && type == TCG_TYPE_I64) {
         /*
          * X != 0 implies X + -1 generates a carry.  Extra addition
          * trickery means: R = X-1 + ~X + C = X-1 + (-X+1) + C = C.
@@ -1814,8 +1772,6 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     int sh;
     bool inv;
 
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-
     /* Ignore high bits of a potential constant arg2.  */
     if (type == TCG_TYPE_I32) {
         arg2 = (uint32_t)arg2;
@@ -2117,109 +2073,6 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
     }
 }
 
-static void tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                         TCGArg bl, bool blconst, TCGArg bh, bool bhconst)
-{
-    static const struct { uint8_t bit1, bit2; } bits[] = {
-        [TCG_COND_LT ] = { CR_LT, CR_LT },
-        [TCG_COND_LE ] = { CR_LT, CR_GT },
-        [TCG_COND_GT ] = { CR_GT, CR_GT },
-        [TCG_COND_GE ] = { CR_GT, CR_LT },
-        [TCG_COND_LTU] = { CR_LT, CR_LT },
-        [TCG_COND_LEU] = { CR_LT, CR_GT },
-        [TCG_COND_GTU] = { CR_GT, CR_GT },
-        [TCG_COND_GEU] = { CR_GT, CR_LT },
-    };
-
-    TCGCond cond2;
-    int op, bit1, bit2;
-
-    switch (cond) {
-    case TCG_COND_EQ:
-        op = CRAND;
-        goto do_equality;
-    case TCG_COND_NE:
-        op = CRNAND;
-    do_equality:
-        tcg_out_cmp(s, cond, al, bl, blconst, 6, TCG_TYPE_I32);
-        tcg_out_cmp(s, cond, ah, bh, bhconst, 7, TCG_TYPE_I32);
-        tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
-        break;
-
-    case TCG_COND_TSTEQ:
-    case TCG_COND_TSTNE:
-        if (blconst) {
-            tcg_out_andi32(s, TCG_REG_R0, al, bl);
-        } else {
-            tcg_out32(s, AND | SAB(al, TCG_REG_R0, bl));
-        }
-        if (bhconst) {
-            tcg_out_andi32(s, TCG_REG_TMP1, ah, bh);
-        } else {
-            tcg_out32(s, AND | SAB(ah, TCG_REG_TMP1, bh));
-        }
-        tcg_out32(s, OR | SAB(TCG_REG_R0, TCG_REG_R0, TCG_REG_TMP1) | 1);
-        break;
-
-    case TCG_COND_LT:
-    case TCG_COND_LE:
-    case TCG_COND_GT:
-    case TCG_COND_GE:
-    case TCG_COND_LTU:
-    case TCG_COND_LEU:
-    case TCG_COND_GTU:
-    case TCG_COND_GEU:
-        bit1 = bits[cond].bit1;
-        bit2 = bits[cond].bit2;
-        op = (bit1 != bit2 ? CRANDC : CRAND);
-        cond2 = tcg_unsigned_cond(cond);
-
-        tcg_out_cmp(s, cond, ah, bh, bhconst, 6, TCG_TYPE_I32);
-        tcg_out_cmp(s, cond2, al, bl, blconst, 7, TCG_TYPE_I32);
-        tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, bit2));
-        tcg_out32(s, CROR | BT(0, CR_EQ) | BA(6, bit1) | BB(0, CR_EQ));
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
-                          TCGReg al, TCGReg ah,
-                          TCGArg bl, bool const_bl,
-                          TCGArg bh, bool const_bh)
-{
-    tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
-    tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
-    tcg_out_rlw(s, RLWINM, ret, TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpSetcond2 outop_setcond2 = {
-    .base.static_constraint = C_O1_I4(r, r, r, rU, rC),
-    .out = tgen_setcond2,
-};
-
-static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                         TCGArg bl, bool const_bl,
-                         TCGArg bh, bool const_bh, TCGLabel *l)
-{
-    assert(TCG_TARGET_REG_BITS == 32);
-    tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
-    tcg_out_bc_lab(s, TCG_COND_EQ, l);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpBrcond2 outop_brcond2 = {
-    .base.static_constraint = C_O0_I4(r, r, rU, rC),
-    .out = tgen_brcond2,
-};
-
 static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     uint32_t insn;
@@ -2438,13 +2291,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_AREG0, table_off);
 
         /* Extract the page index, shifted into place for tlb index.  */
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_shri32(s, TCG_REG_R0, addr,
-                           TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
-        } else {
-            tcg_out_shri64(s, TCG_REG_R0, addr,
-                           TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
-        }
+        tcg_out_shri64(s, TCG_REG_R0, addr,
+                       TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
 
         /*
@@ -2453,8 +2301,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * We will ignore the high bits with tcg_out_cmp(..., addr_type).
          */
         if (cmp_off == 0) {
-            tcg_out32(s, (TCG_TARGET_REG_BITS == 64 ? LDUX : LWZUX)
-                      | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
+            tcg_out32(s, LDUX | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
         } else {
             tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
             tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
@@ -2464,51 +2311,36 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * Load the TLB addend for use on the fast path.
          * Do this asap to minimize any load use delay.
          */
-        if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
-            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
-                       offsetof(CPUTLBEntry, addend));
-        }
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
+                   offsetof(CPUTLBEntry, addend));
 
         /* Clear the non-page, non-alignment bits from the address in R0. */
-        if (TCG_TARGET_REG_BITS == 32) {
-            /*
-             * We don't support unaligned accesses on 32-bits.
-             * Preserve the bottom bits and thus trigger a comparison
-             * failure on unaligned accesses.
-             */
-            if (a_bits < s_bits) {
-                a_bits = s_bits;
-            }
-            tcg_out_rlw(s, RLWINM, TCG_REG_R0, addr, 0,
+        TCGReg t = addr;
+
+        /*
+         * If the access is unaligned, we need to make sure we fail if we
+         * cross a page boundary.  The trick is to add the access size-1
+         * to the address before masking the low bits.  That will make the
+         * address overflow to the next page if we cross a page boundary,
+         * which will then force a mismatch of the TLB compare.
+         */
+        if (a_bits < s_bits) {
+            unsigned a_mask = (1 << a_bits) - 1;
+            unsigned s_mask = (1 << s_bits) - 1;
+            tcg_out32(s, ADDI | TAI(TCG_REG_R0, t, s_mask - a_mask));
+            t = TCG_REG_R0;
+        }
+
+        /* Mask the address for the requested alignment.  */
+        if (addr_type == TCG_TYPE_I32) {
+            tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
                         (32 - a_bits) & 31, 31 - TARGET_PAGE_BITS);
+        } else if (a_bits == 0) {
+            tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - TARGET_PAGE_BITS);
         } else {
-            TCGReg t = addr;
-
-            /*
-             * If the access is unaligned, we need to make sure we fail if we
-             * cross a page boundary.  The trick is to add the access size-1
-             * to the address before masking the low bits.  That will make the
-             * address overflow to the next page if we cross a page boundary,
-             * which will then force a mismatch of the TLB compare.
-             */
-            if (a_bits < s_bits) {
-                unsigned a_mask = (1 << a_bits) - 1;
-                unsigned s_mask = (1 << s_bits) - 1;
-                tcg_out32(s, ADDI | TAI(TCG_REG_R0, t, s_mask - a_mask));
-                t = TCG_REG_R0;
-            }
-
-            /* Mask the address for the requested alignment.  */
-            if (addr_type == TCG_TYPE_I32) {
-                tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
-                            (32 - a_bits) & 31, 31 - TARGET_PAGE_BITS);
-            } else if (a_bits == 0) {
-                tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - TARGET_PAGE_BITS);
-            } else {
-                tcg_out_rld(s, RLDICL, TCG_REG_R0, t,
-                            64 - TARGET_PAGE_BITS, TARGET_PAGE_BITS - a_bits);
-                tcg_out_rld(s, RLDICL, TCG_REG_R0, TCG_REG_R0, TARGET_PAGE_BITS, 0);
-            }
+            tcg_out_rld(s, RLDICL, TCG_REG_R0, t,
+                        64 - TARGET_PAGE_BITS, TARGET_PAGE_BITS - a_bits);
+            tcg_out_rld(s, RLDICL, TCG_REG_R0, TCG_REG_R0, TARGET_PAGE_BITS, 0);
         }
 
         /* Full comparison into cr0. */
@@ -2537,7 +2369,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         h->base = guest_base ? TCG_GUEST_BASE_REG : 0;
     }
 
-    if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+    if (addr_type == TCG_TYPE_I32) {
         /* Zero-extend the guest address for use in the host address. */
         tcg_out_ext32u(s, TCG_REG_TMP2, addr);
         h->index = TCG_REG_TMP2;
@@ -2554,40 +2386,22 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
     HostAddress h;
+    uint32_t insn = qemu_ldx_opc[opc & (MO_BSWAP | MO_SSIZE)];
 
     ldst = prepare_host_addr(s, &h, addr, oi, true);
 
-    if (TCG_TARGET_REG_BITS == 32 && (opc & MO_SIZE) == MO_64) {
-        if (opc & MO_BSWAP) {
-            tcg_out32(s, ADDI | TAI(TCG_REG_R0, h.index, 4));
-            tcg_out32(s, LWBRX | TAB(datalo, h.base, h.index));
-            tcg_out32(s, LWBRX | TAB(datahi, h.base, TCG_REG_R0));
-        } else if (h.base != 0) {
-            tcg_out32(s, ADDI | TAI(TCG_REG_R0, h.index, 4));
-            tcg_out32(s, LWZX | TAB(datahi, h.base, h.index));
-            tcg_out32(s, LWZX | TAB(datalo, h.base, TCG_REG_R0));
-        } else if (h.index == datahi) {
-            tcg_out32(s, LWZ | TAI(datalo, h.index, 4));
-            tcg_out32(s, LWZ | TAI(datahi, h.index, 0));
-        } else {
-            tcg_out32(s, LWZ | TAI(datahi, h.index, 0));
-            tcg_out32(s, LWZ | TAI(datalo, h.index, 4));
-        }
+    if (!have_isa_2_06 && insn == LDBRX) {
+        tcg_out32(s, ADDI | TAI(TCG_REG_R0, h.index, 4));
+        tcg_out32(s, LWBRX | TAB(datalo, h.base, h.index));
+        tcg_out32(s, LWBRX | TAB(TCG_REG_R0, h.base, TCG_REG_R0));
+        tcg_out_rld(s, RLDIMI, datalo, TCG_REG_R0, 32, 0);
+    } else if (insn) {
+        tcg_out32(s, insn | TAB(datalo, h.base, h.index));
     } else {
-        uint32_t insn = qemu_ldx_opc[opc & (MO_BSWAP | MO_SSIZE)];
-        if (!have_isa_2_06 && insn == LDBRX) {
-            tcg_out32(s, ADDI | TAI(TCG_REG_R0, h.index, 4));
-            tcg_out32(s, LWBRX | TAB(datalo, h.base, h.index));
-            tcg_out32(s, LWBRX | TAB(TCG_REG_R0, h.base, TCG_REG_R0));
-            tcg_out_rld(s, RLDIMI, datalo, TCG_REG_R0, 32, 0);
-        } else if (insn) {
-            tcg_out32(s, insn | TAB(datalo, h.base, h.index));
-        } else {
-            insn = qemu_ldx_opc[opc & (MO_SIZE | MO_BSWAP)];
-            tcg_out32(s, insn | TAB(datalo, h.base, h.index));
-            tcg_out_movext(s, TCG_TYPE_REG, datalo,
-                           TCG_TYPE_REG, opc & MO_SSIZE, datalo);
-        }
+        insn = qemu_ldx_opc[opc & (MO_SIZE | MO_BSWAP)];
+        tcg_out32(s, insn | TAB(datalo, h.base, h.index));
+        tcg_out_movext(s, TCG_TYPE_REG, datalo,
+                       TCG_TYPE_REG, opc & MO_SSIZE, datalo);
     }
 
     if (ldst) {
@@ -2604,32 +2418,17 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
     HostAddress h;
+    uint32_t insn = qemu_stx_opc[opc & (MO_BSWAP | MO_SIZE)];
 
     ldst = prepare_host_addr(s, &h, addr, oi, false);
 
-    if (TCG_TARGET_REG_BITS == 32 && (opc & MO_SIZE) == MO_64) {
-        if (opc & MO_BSWAP) {
-            tcg_out32(s, ADDI | TAI(TCG_REG_R0, h.index, 4));
-            tcg_out32(s, STWBRX | SAB(datalo, h.base, h.index));
-            tcg_out32(s, STWBRX | SAB(datahi, h.base, TCG_REG_R0));
-        } else if (h.base != 0) {
-            tcg_out32(s, ADDI | TAI(TCG_REG_R0, h.index, 4));
-            tcg_out32(s, STWX | SAB(datahi, h.base, h.index));
-            tcg_out32(s, STWX | SAB(datalo, h.base, TCG_REG_R0));
-        } else {
-            tcg_out32(s, STW | TAI(datahi, h.index, 0));
-            tcg_out32(s, STW | TAI(datalo, h.index, 4));
-        }
+    if (!have_isa_2_06 && insn == STDBRX) {
+        tcg_out32(s, STWBRX | SAB(datalo, h.base, h.index));
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP2, h.index, 4));
+        tcg_out_shri64(s, TCG_REG_R0, datalo, 32);
+        tcg_out32(s, STWBRX | SAB(TCG_REG_R0, h.base, TCG_REG_TMP2));
     } else {
-        uint32_t insn = qemu_stx_opc[opc & (MO_BSWAP | MO_SIZE)];
-        if (!have_isa_2_06 && insn == STDBRX) {
-            tcg_out32(s, STWBRX | SAB(datalo, h.base, h.index));
-            tcg_out32(s, ADDI | TAI(TCG_REG_TMP2, h.index, 4));
-            tcg_out_shri64(s, TCG_REG_R0, datalo, 32);
-            tcg_out32(s, STWBRX | SAB(TCG_REG_R0, h.base, TCG_REG_TMP2));
-        } else {
-            tcg_out32(s, insn | SAB(datalo, h.base, h.index));
-        }
+        tcg_out32(s, insn | SAB(datalo, h.base, h.index));
     }
 
     if (ldst) {
@@ -2709,16 +2508,11 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
 static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
                           TCGReg datahi, TCGReg addr, MemOpIdx oi)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_out_qemu_ld(s, datalo, datahi, addr, oi, type);
-    } else {
-        tcg_out_qemu_ldst_i128(s, datalo, datahi, addr, oi, true);
-    }
+    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr, oi, true);
 }
 
 static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 64 ? C_N1O1_I1(o, m, r) : C_O2_I1(r, r, r),
+    .base.static_constraint = C_N1O1_I1(o, m, r),
     .out = tgen_qemu_ld2,
 };
 
@@ -2736,16 +2530,11 @@ static const TCGOutOpQemuLdSt outop_qemu_st = {
 static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
                           TCGReg datahi, TCGReg addr, MemOpIdx oi)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_out_qemu_st(s, datalo, datahi, addr, oi, type);
-    } else {
-        tcg_out_qemu_ldst_i128(s, datalo, datahi, addr, oi, false);
-    }
+    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr, oi, false);
 }
 
 static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 64 ? C_O0_I3(o, m, r) : C_O0_I3(r, r, r),
+    .base.static_constraint =  C_O0_I3(o, m, r),
     .out = tgen_qemu_st2,
 };
 
@@ -2767,16 +2556,11 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 #elif defined(_CALL_DARWIN)
 # define LINK_AREA_SIZE                (6 * SZR)
 # define LR_OFFSET                     (2 * SZR)
-#elif TCG_TARGET_REG_BITS == 64
+#else
 # if defined(_CALL_ELF) && _CALL_ELF == 2
 #  define LINK_AREA_SIZE               (4 * SZR)
 #  define LR_OFFSET                    (1 * SZR)
 # endif
-#else /* TCG_TARGET_REG_BITS == 32 */
-# if defined(_CALL_SYSV)
-#  define LINK_AREA_SIZE               (2 * SZR)
-#  define LR_OFFSET                    (1 * SZR)
-# endif
 #endif
 #ifndef LR_OFFSET
 # error "Unhandled abi"
@@ -3107,7 +2891,6 @@ static void tgen_eqv(TCGContext *s, TCGType type,
     tcg_out32(s, EQV | SAB(a1, a0, a2));
 }
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
     tcg_out_shri64(s, a0, a1, 32);
@@ -3117,7 +2900,6 @@ static const TCGOutOpUnary outop_extrh_i64_i32 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_extrh_i64_i32,
 };
-#endif
 
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
@@ -3596,7 +3378,6 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
 {
     TCGReg t0 = dst == src ? TCG_REG_R0 : dst;
@@ -3639,7 +3420,6 @@ static const TCGOutOpUnary outop_bswap64 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_bswap64,
 };
-#endif /* TCG_TARGET_REG_BITS == 64 */
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
@@ -3776,7 +3556,6 @@ static const TCGOutOpLoad outop_ld16s = {
     .out = tgen_ld16s,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
@@ -3798,7 +3577,6 @@ static const TCGOutOpLoad outop_ld32s = {
     .base.static_constraint = C_O1_I1(r, r),
     .out = tgen_ld32s,
 };
-#endif
 
 static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
                      TCGReg base, ptrdiff_t offset)
@@ -4278,14 +4056,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_bitsel_vec(s, a0, a1, a2, args[3]);
         return;
 
-    case INDEX_op_dup2_vec:
-        assert(TCG_TARGET_REG_BITS == 32);
-        /* With inputs a1 = xLxx, a2 = xHxx  */
-        tcg_out32(s, VMRGHW | VRT(a0) | VRA(a2) | VRB(a1));  /* a0  = xxHL */
-        tcg_out_vsldoi(s, TCG_VEC_TMP1, a0, a0, 8);          /* tmp = HLxx */
-        tcg_out_vsldoi(s, a0, a0, TCG_VEC_TMP1, 8);          /* a0  = HLHL */
-        return;
-
     case INDEX_op_ppc_mrgh_vec:
         insn = mrgh_op[vece];
         break;
@@ -4465,7 +4235,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ppc_muleu_vec:
     case INDEX_op_ppc_mulou_vec:
     case INDEX_op_ppc_pkum_vec:
-    case INDEX_op_dup2_vec:
         return C_O1_I2(v, v, v);
 
     case INDEX_op_not_vec:
@@ -4543,9 +4312,7 @@ static void tcg_target_init(TCGContext *s)
 #if defined(_CALL_SYSV)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R2); /* toc pointer */
 #endif
-#if defined(_CALL_SYSV) || TCG_TARGET_REG_BITS == 64
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R13); /* thread pointer */
-#endif
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP2);
     tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP1);
@@ -4566,11 +4333,7 @@ typedef struct {
 /* We're expecting a 2 byte uleb128 encoded value.  */
 QEMU_BUILD_BUG_ON(FRAME_SIZE >= (1 << 14));
 
-#if TCG_TARGET_REG_BITS == 64
-# define ELF_HOST_MACHINE EM_PPC64
-#else
-# define ELF_HOST_MACHINE EM_PPC
-#endif
+#define ELF_HOST_MACHINE EM_PPC64
 
 static DebugFrame debug_frame = {
     .cie.len = sizeof(DebugFrameCIE)-4, /* length after .len member */
-- 
2.43.0


