Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678C9CCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wgy-0007q8-5m; Thu, 09 Oct 2025 15:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgu-0007lu-Mj
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgq-0004WI-Jy
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so6825735e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760039558; x=1760644358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//OvBXjjJD5TG2oi7zK+Oe/RnLlh4YLUxRdHdhJw4K4=;
 b=ZFpnIJaQtk0RyFuLhiIIy4G9VJL2RVBIK/8fH+WiRhRo2tMGq/Y5ULYPI/FvFkmck/
 OKO9BRO5fFXduHNzxeBFprhkGl2wY+41v0YkYN2H52mTdpz3V6sjK7u/ODrPxxu8hBtq
 z5Hb0yGpPaziAdhOxuZX/zazBpNCwAcrh1jaC4rQjXrt+OHlbfgWMhj7GSbGcuLMvtbH
 mq90rCNvtiO4K3FvdWEAmv/QhTEsByT5Alh8XIFb7F3vrs3YyhfrhwwIjMduf6cTO32L
 d9s9L7S0XLNyJB+YD7zVlC+lIWeO50yvskBOlscfTydpV+Y3A4zJKhh40pFpYV8yQv9K
 5osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039558; x=1760644358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//OvBXjjJD5TG2oi7zK+Oe/RnLlh4YLUxRdHdhJw4K4=;
 b=Y8A5atUp6WfYCJNUayJ30UFw9ph0HeFoEY6qF0UCoagwy9Tk6gVIejXeGJMyJH+Koj
 oh5lMWRAPeyfNDBQyWsJ6fMY3d4TBfO6NnRm755dyhSfhfEe02k9xnbhe+JVdsscRIUN
 iaAnsGTifP8/oGB8NnGvS0BEQIvtCUa3eyRKwrwtAnKb3ZnASDKiJLRZwuNI5N4uvTRY
 uN5ES+x6RGSbEsoCwpJQDcHxI6NG0kTsB9lUJdODS5SHTjVTW5/RrktbA7ay/HojIKS+
 NPqaFJh1Sr+6Xeo6iM4Vm8+SNSA1i1OmpUTvaXQwAqhflogfStxUAPkbPSqGtyXQAvIa
 c+wA==
X-Gm-Message-State: AOJu0YxBmhpQ1qc11X5ebK371WXxBb84/fEe6W4KG+cH6jDi+6QfQlVW
 GXrcg53r79UBZsd0OLwigMrIYMO8EnNXqmTWWgDftYIimkWDGGbw0YLEj4GTCeWSsXv6YsTc2pm
 eixKKbLU8VnuP
X-Gm-Gg: ASbGncsdN+bPqORFK4zcIWy3qBZPHGOVuAEfcXYJrBJX5BHNnggo0AqbEmwfgj7NPAO
 dkIQGuSE2GqEINSesbZxK/h4L/IFQMC3ZhC1gMnXL9XjwTeidW5Iq3wYzao60BSF0+IbrykvHbz
 9GO2P793FvTx9GQlcZmsg2qihhQih+gGhiQK/IOrgGY1f0xZa5Swy8LJk5R9F55yYaX1kk5NRA8
 owV5XbrMEM+ho+h4uYca6BYqbRTNUCl66XN3XZ/sVzbvLumHqrqeLyrzzbnG166heR6tSIpFWPU
 vqHE1rTVRN75vSup2WPgT996AytxTAUKfptEEtynBIGCg/L8AFByvgaPSYxOBuCQMNrVeUX1V0h
 bp+fGrq8TFnSQina0me8oevL/xR0kwZYgz/JZNDfVae7fslADqX5RdzUeRTRXs1+2BB01lIpvzX
 qNlldd6Ccq3yaKZxDM+cYdYOAS
X-Google-Smtp-Source: AGHT+IHx4aFG2zolcimmOvcbT6c6bi+JSiHkQPPmgAHQZqr+TYXHgKWlD6icqQw+LJLf1kBy3eVkww==
X-Received: by 2002:a05:600c:502c:b0:46e:1f86:aeba with SMTP id
 5b1f17b1804b1-46fa9af014cmr61723275e9.17.1760039557780; 
 Thu, 09 Oct 2025 12:52:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cce5sm571530f8f.1.2025.10.09.12.52.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 12:52:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 5/7] tcg/mips: Remove support for 32-bit hosts
Date: Thu,  9 Oct 2025 21:52:08 +0200
Message-ID: <20251009195210.33161-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009195210.33161-1-philmd@linaro.org>
References: <20251009195210.33161-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"), released as v10.0.
The next release being v10.2, we can remove the TCG backend
for 32-bit MIPS hosts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h |   2 -
 tcg/mips/tcg-target.c.inc | 277 ++++++--------------------------------
 2 files changed, 38 insertions(+), 241 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index b9eb3385288..88f0145efba 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,11 +39,9 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#endif
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 77af0d8658a..c52f749b43b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -32,15 +32,6 @@
 #define TCG_TARGET_CALL_ARG_I32       TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_ARG_I128      TCG_CALL_ARG_EVEN
 
-#if TCG_TARGET_REG_BITS == 32
-# define LO_OFF  (HOST_BIG_ENDIAN * 4)
-# define HI_OFF  (4 - LO_OFF)
-#else
-/* Assert at compile-time that these values are never used for 64-bit. */
-# define LO_OFF  ({ qemu_build_not_reached(); 0; })
-# define HI_OFF  ({ qemu_build_not_reached(); 0; })
-#endif
-
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "zero",
@@ -84,11 +75,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_TMP3  TCG_REG_T7
 
 #define TCG_GUEST_BASE_REG TCG_REG_S7
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_REG_TB         TCG_REG_S6
-#else
-#define TCG_REG_TB         ({ qemu_build_not_reached(); TCG_REG_ZERO; })
-#endif
 
 /* check if we really need so many registers :P */
 static const int tcg_target_reg_alloc_order[] = {
@@ -559,7 +546,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     tcg_target_long tmp;
     int sh, lo;
 
-    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+    if (type == TCG_TYPE_I32) {
         arg = (int32_t)arg;
     }
 
@@ -567,7 +554,6 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     if (tcg_out_movi_two(s, ret, arg)) {
         return;
     }
-    assert(TCG_TARGET_REG_BITS == 64);
 
     /* Load addresses within 2GB of TB with 1 or 3 insns. */
     tmp = tcg_tbrel_diff(s, (void *)arg);
@@ -630,7 +616,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg)
 {
-    TCGReg tbreg = TCG_TARGET_REG_BITS == 64 ? TCG_REG_TB : 0;
+    TCGReg tbreg = TCG_REG_TB;
     tcg_out_movi_int(s, type, ret, arg, tbreg);
 }
 
@@ -658,7 +644,6 @@ static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out_opc_sa(s, OPC_SLL, rd, rs, 0);
 }
 
@@ -701,7 +686,6 @@ static void tcg_out_bswap_subr(TCGContext *s, const tcg_insn_unit *sub)
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     if (use_mips32r2_instructions) {
         tcg_out_opc_bf(s, OPC_DEXT, ret, arg, 31, 0);
     } else {
@@ -728,7 +712,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
     MIPSInsn opc = OPC_LD;
-    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
+    if (type == TCG_TYPE_I32) {
         opc = OPC_LW;
     }
     tcg_out_ldst(s, opc, arg, arg1, arg2);
@@ -738,7 +722,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
     MIPSInsn opc = OPC_SD;
-    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
+    if (type == TCG_TYPE_I32) {
         opc = OPC_SW;
     }
     tcg_out_ldst(s, opc, arg, arg1, arg2);
@@ -918,72 +902,6 @@ void tcg_out_br(TCGContext *s, TCGLabel *l)
     tgen_brcond(s, TCG_TYPE_I32, TCG_COND_EQ, TCG_REG_ZERO, TCG_REG_ZERO, l);
 }
 
-static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
-                                TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
-{
-    int flags = 0;
-
-    switch (cond) {
-    case TCG_COND_EQ:
-        flags |= SETCOND_INV;
-        /* fall through */
-    case TCG_COND_NE:
-        flags |= SETCOND_NEZ;
-        tcg_out_opc_reg(s, OPC_XOR, TCG_TMP0, al, bl);
-        tcg_out_opc_reg(s, OPC_XOR, TCG_TMP1, ah, bh);
-        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
-        break;
-
-    default:
-        tgen_setcond(s, TCG_TYPE_I32, TCG_COND_EQ, TCG_TMP0, ah, bh);
-        tgen_setcond(s, TCG_TYPE_I32, tcg_unsigned_cond(cond),
-                     TCG_TMP1, al, bl);
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP0);
-        tgen_setcond(s, TCG_TYPE_I32, tcg_high_cond(cond), TCG_TMP0, ah, bh);
-        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
-        break;
-    }
-    return ret | flags;
-}
-
-static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
-                          TCGReg al, TCGReg ah,
-                          TCGArg bl, bool const_bl,
-                          TCGArg bh, bool const_bh)
-{
-    int tmpflags = tcg_out_setcond2_int(s, cond, ret, al, ah, bl, bh);
-    tcg_out_setcond_end(s, ret, tmpflags);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpSetcond2 outop_setcond2 = {
-    .base.static_constraint = C_O1_I4(r, r, r, rz, rz),
-    .out = tgen_setcond2,
-};
-
-static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                         TCGArg bl, bool const_bl,
-                         TCGArg bh, bool const_bh, TCGLabel *l)
-{
-    int tmpflags = tcg_out_setcond2_int(s, cond, TCG_TMP0, al, ah, bl, bh);
-    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
-    MIPSInsn b_opc = tmpflags & SETCOND_INV ? OPC_BEQ : OPC_BNE;
-
-    tcg_out_reloc(s, s->code_ptr, R_MIPS_PC16, l, 0);
-    tcg_out_opc_br(s, b_opc, tmp, TCG_REG_ZERO);
-    tcg_out_nop(s);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpBrcond2 outop_brcond2 = {
-    .base.static_constraint = C_O0_I4(r, r, rz, rz),
-    .out = tgen_brcond2,
-};
-
 static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
                          TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
                          TCGArg v1, bool const_v1, TCGArg v2, bool const_v2)
@@ -1189,7 +1107,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, TCG_AREG0, table_off);
 
         /* Extract the TLB index from the address into TMP3.  */
-        if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addr,
                            TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         } else {
@@ -1201,7 +1119,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
         /* Load the tlb comparator.  */
-        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3,
                        cmp_off + HOST_BIG_ENDIAN * 4);
         } else {
@@ -1218,8 +1136,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          */
         tcg_out_movi(s, addr_type, TCG_TMP1, TARGET_PAGE_MASK | a_mask);
         if (a_mask < s_mask) {
-            tcg_out_opc_imm(s, (TCG_TARGET_REG_BITS == 32
-                                || addr_type == TCG_TYPE_I32
+            tcg_out_opc_imm(s, (addr_type == TCG_TYPE_I32
                                 ? OPC_ADDIU : OPC_DADDIU),
                             TCG_TMP2, addr, s_mask - a_mask);
             tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP2);
@@ -1228,7 +1145,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
 
         /* Zero extend a 32-bit guest address for a 64-bit host. */
-        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_ext32u(s, TCG_TMP2, addr);
             addr = TCG_TMP2;
         }
@@ -1261,7 +1178,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
 
         base = addr;
-        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_ext32u(s, TCG_REG_A0, base);
             base = TCG_REG_A0;
         }
@@ -1297,7 +1214,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_LH, lo, base, 0);
         break;
     case MO_UL:
-        if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I64) {
+        if (type == TCG_TYPE_I64) {
             tcg_out_opc_imm(s, OPC_LWU, lo, base, 0);
             break;
         }
@@ -1307,15 +1224,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         break;
     case MO_UQ:
         /* Prefer to load from offset 0 first, but allow for overlap.  */
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
-        } else if (HOST_BIG_ENDIAN ? hi != base : lo == base) {
-            tcg_out_opc_imm(s, OPC_LW, hi, base, HI_OFF);
-            tcg_out_opc_imm(s, OPC_LW, lo, base, LO_OFF);
-        } else {
-            tcg_out_opc_imm(s, OPC_LW, lo, base, LO_OFF);
-            tcg_out_opc_imm(s, OPC_LW, hi, base, HI_OFF);
-        }
+        tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
         break;
     default:
         g_assert_not_reached();
@@ -1357,21 +1266,14 @@ static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
     case MO_32:
         tcg_out_opc_imm(s, lw1, lo, base, 0);
         tcg_out_opc_imm(s, lw2, lo, base, 3);
-        if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I64 && !sgn) {
+        if (type == TCG_TYPE_I64 && !sgn) {
             tcg_out_ext32u(s, lo, lo);
         }
         break;
 
     case MO_64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_opc_imm(s, ld1, lo, base, 0);
-            tcg_out_opc_imm(s, ld2, lo, base, 7);
-        } else {
-            tcg_out_opc_imm(s, lw1, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 0);
-            tcg_out_opc_imm(s, lw2, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 3);
-            tcg_out_opc_imm(s, lw1, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 0);
-            tcg_out_opc_imm(s, lw2, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 3);
-        }
+        tcg_out_opc_imm(s, ld1, lo, base, 0);
+        tcg_out_opc_imm(s, ld2, lo, base, 7);
         break;
 
     default:
@@ -1407,36 +1309,8 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .out = tgen_qemu_ld,
 };
 
-static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    MemOp opc = get_memop(oi);
-    TCGLabelQemuLdst *ldst;
-    HostAddress h;
-
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-    ldst = prepare_host_addr(s, &h, addr, oi, true);
-
-    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
-        tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, type);
-    } else {
-        tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, type);
-    }
-
-    if (ldst) {
-        ldst->type = type;
-        ldst->datalo_reg = datalo;
-        ldst->datahi_reg = datahi;
-        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
-    }
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
-    /* Ensure that the mips32 code is compiled but discarded for mips64. */
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 32 ? C_O2_I1(r, r, r) : C_NotImplemented,
-    .out =
-        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_ld2 : NULL,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
@@ -1453,12 +1327,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_SW, lo, base, 0);
         break;
     case MO_64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_opc_imm(s, OPC_SD, lo, base, 0);
-        } else {
-            tcg_out_opc_imm(s, OPC_SW, HOST_BIG_ENDIAN ? hi : lo, base, 0);
-            tcg_out_opc_imm(s, OPC_SW, HOST_BIG_ENDIAN ? lo : hi, base, 4);
-        }
+        tcg_out_opc_imm(s, OPC_SD, lo, base, 0);
         break;
     default:
         g_assert_not_reached();
@@ -1486,15 +1355,8 @@ static void tcg_out_qemu_st_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
         break;
 
     case MO_64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_opc_imm(s, sd1, lo, base, 0);
-            tcg_out_opc_imm(s, sd2, lo, base, 7);
-        } else {
-            tcg_out_opc_imm(s, sw1, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 0);
-            tcg_out_opc_imm(s, sw2, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 3);
-            tcg_out_opc_imm(s, sw1, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 0);
-            tcg_out_opc_imm(s, sw2, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 3);
-        }
+        tcg_out_opc_imm(s, sd1, lo, base, 0);
+        tcg_out_opc_imm(s, sd2, lo, base, 7);
         break;
 
     default:
@@ -1530,36 +1392,8 @@ static const TCGOutOpQemuLdSt outop_qemu_st = {
     .out = tgen_qemu_st,
 };
 
-static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    MemOp opc = get_memop(oi);
-    TCGLabelQemuLdst *ldst;
-    HostAddress h;
-
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-    ldst = prepare_host_addr(s, &h, addr, oi, false);
-
-    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
-        tcg_out_qemu_st_direct(s, datalo, datahi, h.base, opc);
-    } else {
-        tcg_out_qemu_st_unalign(s, datalo, datahi, h.base, opc);
-    }
-
-    if (ldst) {
-        ldst->type = type;
-        ldst->datalo_reg = datalo;
-        ldst->datahi_reg = datahi;
-        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
-    }
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
-    /* Ensure that the mips32 code is compiled but discarded for mips64. */
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 32 ? C_O0_I3(rz, rz, r) : C_NotImplemented,
-    .out =
-        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_st2 : NULL,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_mb(TCGContext *s, unsigned a0)
@@ -1584,22 +1418,14 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
     int16_t lo = 0;
 
     if (a0) {
-        intptr_t ofs;
-        if (TCG_TARGET_REG_BITS == 64) {
-            ofs = tcg_tbrel_diff(s, (void *)a0);
-            lo = ofs;
-            if (ofs == lo) {
-                base = TCG_REG_TB;
-            } else {
-                base = TCG_REG_V0;
-                tcg_out_movi(s, TCG_TYPE_PTR, base, ofs - lo);
-                tcg_out_opc_reg(s, ALIAS_PADD, base, base, TCG_REG_TB);
-            }
+        intptr_t ofs = tcg_tbrel_diff(s, (void *)a0);
+        lo = ofs;
+        if (ofs == lo) {
+            base = TCG_REG_TB;
         } else {
-            ofs = a0;
-            lo = ofs;
             base = TCG_REG_V0;
             tcg_out_movi(s, TCG_TYPE_PTR, base, ofs - lo);
+            tcg_out_opc_reg(s, ALIAS_PADD, base, base, TCG_REG_TB);
         }
     }
     if (!tcg_out_opc_jmp(s, OPC_J, tb_ret_addr)) {
@@ -1616,35 +1442,24 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     TCGReg base, dest;
 
     /* indirect jump method */
-    if (TCG_TARGET_REG_BITS == 64) {
-        dest = TCG_REG_TB;
-        base = TCG_REG_TB;
-        ofs = tcg_tbrel_diff(s, (void *)ofs);
-    } else {
-        dest = TCG_TMP0;
-        base = TCG_REG_ZERO;
-    }
+    dest = TCG_REG_TB;
+    base = TCG_REG_TB;
+    ofs = tcg_tbrel_diff(s, (void *)ofs);
     tcg_out_ld(s, TCG_TYPE_PTR, dest, base, ofs);
     tcg_out_opc_reg(s, OPC_JR, 0, dest, 0);
     /* delay slot */
     tcg_out_nop(s);
 
     set_jmp_reset_offset(s, which);
-    if (TCG_TARGET_REG_BITS == 64) {
-        /* For the unlinked case, need to reset TCG_REG_TB. */
-        tcg_out_ldst(s, ALIAS_PADDI, TCG_REG_TB, TCG_REG_TB,
-                     -tcg_current_code_size(s));
-    }
+    /* For the unlinked case, need to reset TCG_REG_TB. */
+    tcg_out_ldst(s, ALIAS_PADDI, TCG_REG_TB, TCG_REG_TB,
+                 -tcg_current_code_size(s));
 }
 
 static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
 {
     tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
-    } else {
-        tcg_out_nop(s);
-    }
+    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
@@ -1839,7 +1654,6 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
     tcg_out_dsra(s, a0, a1, 32);
@@ -1849,7 +1663,6 @@ static const TCGOutOpUnary outop_extrh_i64_i32 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_extrh_i64_i32,
 };
-#endif
 
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
@@ -2238,7 +2051,6 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
@@ -2256,7 +2068,6 @@ static const TCGOutOpUnary outop_bswap64 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_bswap64,
 };
-#endif /* TCG_TARGET_REG_BITS == 64 */
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
@@ -2384,7 +2195,6 @@ static const TCGOutOpLoad outop_ld16s = {
     .out = tgen_ld16s,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
@@ -2406,7 +2216,6 @@ static const TCGOutOpLoad outop_ld32s = {
     .base.static_constraint = C_O1_I1(r, r),
     .out = tgen_ld32s,
 };
-#endif
 
 static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
                        TCGReg base, ptrdiff_t offset)
@@ -2549,7 +2358,7 @@ static tcg_insn_unit *align_code_ptr(TCGContext *s)
 }
 
 /* Stack frame parameters.  */
-#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define REG_SIZE   8
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
 #define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
 
@@ -2581,17 +2390,15 @@ static void tcg_target_qemu_prologue(TCGContext *s)
          * with the address of the prologue, so we can use that instead
          * of TCG_REG_TB.
          */
-#if TCG_TARGET_REG_BITS == 64 && !defined(__mips_abicalls)
+#if !defined(__mips_abicalls)
 # error "Unknown mips abi"
 #endif
         tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base,
-                         TCG_TARGET_REG_BITS == 64 ? TCG_REG_T9 : 0);
+                         TCG_REG_T9);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
 
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
-    }
+    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
 
     /* Call generated code */
     tcg_out_opc_reg(s, OPC_JR, 0, tcg_target_call_iarg_regs[1], 0);
@@ -2647,10 +2454,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     /* t3 = dcba -- delay slot */
     tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        return;
-    }
-
     /*
      * bswap32u -- unsigned 32-bit swap.  a0 = ....abcd.
      */
@@ -2745,9 +2548,7 @@ static void tcg_target_init(TCGContext *s)
 {
     tcg_target_detect_isa();
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
-    }
+    tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V0);
@@ -2778,9 +2579,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);   /* return address */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);   /* stack pointer */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);   /* global pointer */
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB); /* tc->tc_ptr */
-    }
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);   /* tc->tc_ptr */
 }
 
 typedef struct {
@@ -2798,7 +2597,7 @@ static const DebugFrame debug_frame = {
     .h.cie.id = -1,
     .h.cie.version = 1,
     .h.cie.code_align = 1,
-    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.data_align = -REG_SIZE & 0x7f, /* sleb128 */
     .h.cie.return_column = TCG_REG_RA,
 
     /* Total FDE size does not include the "len" member.  */
-- 
2.51.0


