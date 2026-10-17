Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D238CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9cI-0003vU-9T; Sat, 17 Oct 2026 14:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9c5-0003Uw-Ro; Sat, 17 Oct 2026 14:58:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9c3-0003rr-Rf; Sat, 17 Oct 2026 14:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263396; bh=JG2OZB0G7bDBx1Eg8+jX2hzX482Ryji3SBhBjSQ2CmA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ITLsLqEEb+joet+Xr7UqLiUJgTFKv2xOIPcgXqd37J+ETryFdBToh2ki/ibGf45HM
 zQvJ0qOLV9h+LtPmOxqWxEr5IXuJ0lOLSmfdQDKpmUPmBBg32PVlVz2blRe85g7WG/
 Ger5DLNFiUnWdUseHDuhUwZxbvLoe/diLf7wtq7pWDMkmMlWKT9crCZPz7NNmaSUBd
 5wwX8YWYfUifYdeTc6W/nYTeoeGv/mF9QvWfgw6tzSrbwFg27sWn8jPwDg7wBMTp0I
 myNePdsHYCR98XkNSG64/FEYcqnAC6+F4hVhl14chlOi/zDMtnelDvojPqmJ+7byfV
 tj2vwLagQz92w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8278D1DE6C0;
 Sat, 17 Oct 2026 21:56:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B0CDF44338B;
 Sat, 17 Oct 2026 21:56:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Polivoda <apolivodaa433@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 32/63] target/i386/tcg: ignore VEX.L for unary scalar
 instructions
Date: Sat, 17 Oct 2026 21:54:48 +0300
Message-ID: <20261017185528.722197-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

According to both Volume 2 of Intel 64 and IA-32 Architectures Software
Developer's Manual and Volume 4 of AMD64 Architecture Programmer's Manual,
VEX.L is a "don't care" bit for `VROUNDSS`, `VROUNDSD`, `VMOVSS`, `VMOVSD`.

Currently, QEMU handles VEX.L with these instructions differently:
- In the VMOVSS and VMOVSD case, VEX.L allows to select the register size
  (XMM or YMM), leading to differences between QEMU and the real hardware.
- In `gen_VROUNDSS()` and `gen_VROUNDSD()`, there is an assert which checks
  that `s->vex_l` is not set. When either instruction is encountered with VEX.L
  bit set, the QEMU process crashes with an assertion failure.

These behaviors deviate from real hardware, and in VROUNDSS/VROUNDSD case,
it also allows unprivileged guest userspace to crash the QEMU process itself.
Instead, always handle the instructions as if VEX.L=0.

Reported-by: Andrey Polivoda <apolivodaa433@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a5b4837a253ed3944dd7d4419c52830079e221ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 704858ff57..b3989e07b4 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -260,6 +260,7 @@
 #define svm(a) .intercept = SVM_EXIT_##a, .has_intercept = true,
 
 #define avx2_256 .vex_special = X86_VEX_AVX2_256,
+#define vex_lig .vex_special = X86_VEX_LIG,
 
 #define P_00          1
 #define P_66          (1 << PREFIX_DATA)
@@ -887,8 +888,8 @@ static const X86OpEntry opcodes_0F3A[256] = {
      * For other unary operations such as VSQRTSx this is hidden by the "REPScalar"
      * value of vex_special, because the table lists the operand types of VSQRTPx.
      */
-    [0x0a] = X86_OP_ENTRY4(VROUNDSS,   V,x,  H,x, W,ss, vex3 cpuid(SSE41) p_66),
-    [0x0b] = X86_OP_ENTRY4(VROUNDSD,   V,x,  H,x, W,sd, vex3 cpuid(SSE41) p_66),
+    [0x0a] = X86_OP_ENTRY4(VROUNDSS,   V,x,  H,x, W,ss, vex3 vex_lig cpuid(SSE41) p_66),
+    [0x0b] = X86_OP_ENTRY4(VROUNDSD,   V,x,  H,x, W,sd, vex3 vex_lig cpuid(SSE41) p_66),
     [0x0c] = X86_OP_ENTRY4(VBLENDPS,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) p_66),
     [0x0d] = X86_OP_ENTRY4(VBLENDPD,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) p_66),
     [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
@@ -944,8 +945,8 @@ static void decode_0F10(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F10_mem[4] = {
         X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex5),
-        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex5),
+        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex5 vex_lig),
+        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex5 vex_lig),
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -967,8 +968,8 @@ static void decode_0F11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F11_mem[4] = {
         X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5),
-        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5), /* MOVSD */
+        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5 vex_lig),
+        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5 vex_lig), /* MOVSD */
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -2401,6 +2402,10 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     case X86_VEX_None:
         break;
 
+    case X86_VEX_LIG:
+        s->vex_l = 0;
+        break;
+
     case X86_VEX_REPScalar:
         /*
          * Instructions which differ between 00/66 and F2/F3 in the
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 9282296900..25f7d2215e 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -263,6 +263,12 @@ typedef enum X86VEXSpecial {
      * operands, and thus handled by decode_op_size.
      */
     X86_VEX_AVX2_256,
+
+    /*
+     * Instructions that do not care about VEX.L; used for scalar operands, because
+     * they *should* be used only with VEX.L=0 but may accept VEX.L=1 on some machines.
+     */
+    X86_VEX_LIG,
 } X86VEXSpecial;
 
 
-- 
2.47.3


