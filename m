Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20753606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gte81XqU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiE-0002Uu-Br; Wed, 18 Nov 2026 07:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei5-0002Qm-PG
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei3-00054V-Ds
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw20x0LdOsSXnEOVQJ1xgnl3/jenJ8fQd0gtfc2zDlw=;
 b=Gte81XqUxoDf3v4O/yJl60Xgqypsq8/E9zumG4JqNdkVlnS7dD6fZIzLq5acQFPpEwS6Tk
 juZnFGer+JW3y9tzikIqMlIO7vyH/jzZLypvEFs+r2dkibootywc993c40zSpA+SdUakA4
 PZX+xLTWsgwVYcBJrSnv01kBFDnJnBE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-5u9Sa_G2MXqo38iGU__3Rw-1; Wed,
 18 Nov 2026 07:24:17 -0500
X-MC-Unique: 5u9Sa_G2MXqo38iGU__3Rw-1
X-Mimecast-MFC-AGG-ID: 5u9Sa_G2MXqo38iGU__3Rw_1795004656
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 824F41955F7C
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:16 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D709F18004FC
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 15/26] target/i386/tcg: convert the 0F3A map to decode.def
Date: Wed, 18 Nov 2026 13:23:46 +0100
Message-ID: <20261118122357.659634-16-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe the 0F3A opcode map in decode.def.  The generated rows match
opcodes_0F3A with some simplifications:

- chk(W0), chk(W1) and chk(nf0) become W0, W1 and NF0 in the prefix,
  and are checked by the program instead of the row

- vex_lig becomes LIG, which the program implements by setting VEX.L
  to 0 instead of X86_VEX_LIG in validate_vex()

- VINSERTPS is split into register and memory forms (the U and M
  operands), replacing decode_VINSERTPS()

VAESKEYGEN is split into legacy and VEX forms; the latter requires
AVX explicitly, so that the three AES/AVX/VAES cases can move out of
has_cpuid_feature().

AI-used-for: code
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 91 ++++----------------------------
 target/i386/tcg/decode.def       | 66 +++++++++++++++++++++++
 2 files changed, 75 insertions(+), 82 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 7fdd7a86f46..0ae6deff65a 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -953,6 +953,9 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][4] = {
     },
 };
 
+static const X86OpEntry *decode_run(DisasContext *s, CPUX86State *env,
+                                    int map, uint8_t *b);
+
 static void decode_0F38(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     *b = x86_ldub_code(env, s);
@@ -963,88 +966,15 @@ static void decode_0F38(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     }
 }
 
-static void decode_VINSERTPS(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry
-        vinsertps_reg = X86_OP_ENTRY4(VINSERTPS_r, V,dq, H,dq, U,dq, vex5 cpuid(SSE41) p_66),
-        vinsertps_mem = X86_OP_ENTRY4(VINSERTPS_m, V,dq, H,dq, M,d,  vex5 cpuid(SSE41) p_66);
-
-    int modrm = get_modrm(s, env);
-    *entry = (modrm >> 6) == 3 ? vinsertps_reg : vinsertps_mem;
-}
-
-static const X86OpEntry opcodes_0F3A[256] = {
-    /*
-     * These are VEX-only, but incorrectly listed in the manual as exception type 4.
-     * Also the "qq" instructions are sometimes omitted by Table 2-17, but are VEX256
-     * only.
-     */
-    [0x00] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 chk(W1) cpuid(AVX2) p_66),
-    [0x01] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 chk(W1) cpuid(AVX2) p_66), /* VPERMPD */
-    [0x02] = X86_OP_ENTRY4(VBLENDPS,    V,x,  H,x,  W,x,  vex6 chk(W0) cpuid(AVX2) p_66), /* VPBLENDD */
-    [0x04] = X86_OP_ENTRY3(VPERMILPS_i, V,x,  W,x,  I,b,  vex6 chk(W0) cpuid(AVX) p_66),
-    [0x05] = X86_OP_ENTRY3(VPERMILPD_i, V,x,  W,x,  I,b,  vex6 chk(W0) cpuid(AVX) p_66),
-    [0x06] = X86_OP_ENTRY4(VPERM2x128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
-
-    [0x14] = X86_OP_ENTRY3(PEXTRB,     E,b,  V,dq, I,b,  vex5 cpuid(SSE41) op0_Rd p_66),
-    [0x15] = X86_OP_ENTRY3(PEXTRW,     E,w,  V,dq, I,b,  vex5 cpuid(SSE41) op0_Rd p_66),
-    [0x16] = X86_OP_ENTRY3(PEXTR,      E,y,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
-    [0x17] = X86_OP_ENTRY3(VEXTRACTPS, E,d,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
-    [0x1d] = X86_OP_ENTRY3(VCVTPS2PH,  W,xh, V,x,  I,b,  vex11 chk(W0) cpuid(F16C) p_66),
-
-    [0x20] = X86_OP_ENTRY4(PINSRB,     V,dq, H,dq, E,b,  vex5 cpuid(SSE41) op2_Ry p_66),
-    [0x21] = X86_OP_GROUP0(VINSERTPS),
-    [0x22] = X86_OP_ENTRY4(PINSR,      V,dq, H,dq, E,y,  vex5 cpuid(SSE41) p_66),
-
-    [0x40] = X86_OP_ENTRY4(VDPPS,      V,x,  H,x,  W,x,  vex2 cpuid(SSE41) p_66),
-    [0x41] = X86_OP_ENTRY4(VDPPD,      V,dq, H,dq, W,dq, vex2 cpuid(SSE41) p_66),
-    [0x42] = X86_OP_ENTRY4(VMPSADBW,   V,x,  H,x,  W,x,  vex2 cpuid(SSE41) avx2_256 p_66),
-    [0x44] = X86_OP_ENTRY4(PCLMULQDQ,  V,dq, H,dq, W,dq, vex4 cpuid(PCLMULQDQ) p_66),
-    [0x46] = X86_OP_ENTRY4(VPERM2x128, V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
-
-    [0x60] = X86_OP_ENTRY4(PCMPESTRM,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
-    [0x61] = X86_OP_ENTRY4(PCMPESTRI,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
-    [0x62] = X86_OP_ENTRY4(PCMPISTRM,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
-    [0x63] = X86_OP_ENTRY4(PCMPISTRI,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
-
-    [0x08] = X86_OP_ENTRY3(VROUNDPS,   V,x,  W,x,  I,b,  vex2 cpuid(SSE41) p_66),
-    [0x09] = X86_OP_ENTRY3(VROUNDPD,   V,x,  W,x,  I,b,  vex2 cpuid(SSE41) p_66),
-    /*
-     * Not listed as four operand in the manual.  Also writes and reads 128-bits
-     * from the first two operands due to the V operand picking higher entries of
-     * the H operand; the "Vss,Hss,Wss" description from the manual is incorrect.
-     * For other unary operations such as VSQRTSx this is hidden by the "REPScalar"
-     * value of vex_special, because the table lists the operand types of VSQRTPx.
-     */
-    [0x0a] = X86_OP_ENTRY4(VROUNDSS,   V,x,  H,x, W,ss, vex3 vex_lig cpuid(SSE41) p_66),
-    [0x0b] = X86_OP_ENTRY4(VROUNDSD,   V,x,  H,x, W,sd, vex3 vex_lig cpuid(SSE41) p_66),
-    [0x0c] = X86_OP_ENTRY4(VBLENDPS,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) p_66),
-    [0x0d] = X86_OP_ENTRY4(VBLENDPD,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) p_66),
-    [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x0f] = X86_OP_ENTRY4(PALIGNR,    V,x,  H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-
-    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,dq, vex6 chk(W0) cpuid(AVX) p_66),
-    [0x19] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX) p_66),
-
-    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,dq, vex6 chk(W0) cpuid(AVX2) p_66),
-    [0x39] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX2) p_66),
-
-    /* Listed incorrectly as type 4 */
-    [0x4a] = X86_OP_ENTRY4(VBLENDVPS, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66),
-    [0x4b] = X86_OP_ENTRY4(VBLENDVPD, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66),
-    [0x4c] = X86_OP_ENTRY4(VPBLENDVB, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66 avx2_256),
-
-    [0xcc] = X86_OP_ENTRY3(SHA1RNDS4,  V,dq, W,dq, I,b,  cpuid(SHA_NI)),
-
-    [0xdf] = X86_OP_ENTRY3(VAESKEYGEN, V,dq, W,dq, I,b,  vex4 cpuid(AES) p_66),
-
-    [0xF0] = X86_OP_ENTRY3(RORX,       G,y, E,y, I,b,    vex13 chk(nf0) cpuid(BMI2) p_f2),
-};
-
 static void decode_0F3A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
+    const X86OpEntry *row;
+
     *b = x86_ldub_code(env, s);
-    *entry = opcodes_0F3A[*b];
+    row = decode_run(s, env, 3, b);
+    if (row) {
+        *entry = *row;
+    }
 }
 
 /*
@@ -2762,7 +2692,6 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
     return e->valid_prefix & (1 << sse_prefixes);
 }
 
-#if 0
 static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid);
 
 #include "decode-table.h"
@@ -2894,7 +2823,6 @@ static const X86OpEntry *decode_run(DisasContext *s, CPUX86State *env,
         }
     }
 }
-#endif
 
 static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
                         X86DecodedInsn *decode)
@@ -3078,7 +3006,6 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
         } else {
             return !s->vex_l || (s->cpuid_7_0_ecx_features & CPUID_7_0_ECX_VAES);
         }
-
     case X86_FEAT_AVX:
         return (s->cpuid_ext_features & CPUID_EXT_AVX);
     case X86_FEAT_XSAVE:
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index 5342de00f55..36b0eabbc87 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -193,3 +193,69 @@
 //       ENC=VEX -> #UD
 //       decode.def:867: 66.0F38 10                  PBLENDVB      Vx,Wx              E4 cpuid(SSE41): needs ENC=legacy
 //
+
+
+// 0F 3A
+// -----
+
+// These are VEX-only, but incorrectly listed in the manual as exception type 4.
+// Also the "qq" instructions are sometimes omitted by Table 2-17, but are VEX256
+// only.
+VEX.66.0F3A.W1 00..01           VPERMQ        Vqq,Wqq,Ib         E6 cpuid(AVX2)   // VPERMQ, VPERMPD
+VEX.66.0F3A.W0 02               VBLENDPS      Vx,Hx,Wx,Ib        E6 cpuid(AVX2)   // VPBLENDD
+VEX.66.0F3A.W0 04               VPERMILPS_i   Vx,Wx,Ib           E6 cpuid(AVX)
+VEX.66.0F3A.W0 05               VPERMILPD_i   Vx,Wx,Ib           E6 cpuid(AVX)
+VEX.66.0F3A.W0 06               VPERM2x128    Vqq,Hqq,Wqq,Ib     E6 cpuid(AVX)
+
+SSE|VEX.66.0F3A 08           VROUNDPS      Vx,Wx,Ib           E2 cpuid(SSE41)
+SSE|VEX.66.0F3A 09           VROUNDPD      Vx,Wx,Ib           E2 cpuid(SSE41)
+// Not listed as four operand in the manual.  Also writes and reads 128-bits
+// from the first two operands due to the V operand picking higher entries of
+// the H operand; the "Vss,Hss,Wss" description from the manual is incorrect.
+// For other unary operations such as VSQRTSx this is hidden by the "REPScalar"
+// value of vex_special, because the table lists the operand types of VSQRTPx.
+SSE|VEX.66.0F3A.LIG 0A          VROUNDSS      Vx,Hx,Wss,Ib       E3 cpuid(SSE41)
+SSE|VEX.66.0F3A.LIG 0B          VROUNDSD      Vx,Hx,Wsd,Ib       E3 cpuid(SSE41)
+SSE|VEX.66.0F3A 0C              VBLENDPS      Vx,Hx,Wx,Ib        E4 cpuid(SSE41)
+SSE|VEX.66.0F3A 0D              VBLENDPD      Vx,Hx,Wx,Ib        E4 cpuid(SSE41)
+SSE|VEX.66.0F3A 0E              VPBLENDW      Vx,Hx,Wx,Ib        E4(avx2_256) cpuid(SSE41)
+SSE|VEX.NP|66.0F3A 0F           PALIGNR       Vx,Hx,Wx,Ib        E4(avx2_256, mmx) cpuid(SSSE3)
+
+SSE|VEX.66.0F3A 14              PEXTRB        Eb,Vdq,Ib          E5 cpuid(SSE41) op0_Rd
+SSE|VEX.66.0F3A 15              PEXTRW        Ew,Vdq,Ib          E5 cpuid(SSE41) op0_Rd
+SSE|VEX.66.0F3A 16              PEXTR         Ey,Vdq,Ib          E5 cpuid(SSE41)
+SSE|VEX.66.0F3A 17              VEXTRACTPS    Ed,Vdq,Ib          E5 cpuid(SSE41)
+VEX.66.0F3A.W0 18               VINSERTx128   Vqq,Hqq,Wdq,Ib     E6 cpuid(AVX)
+VEX.66.0F3A.W0 19               VEXTRACTx128  Wdq,Vqq,Ib         E6 cpuid(AVX)
+VEX.66.0F3A.W0 1D               VCVTPS2PH     Wxh,Vx,Ib          E11 cpuid(F16C)
+
+SSE|VEX.66.0F3A 20              PINSRB        Vdq,Hdq,Eb,Ib      E5 cpuid(SSE41) op2_Ry
+SSE|VEX.66.0F3A 21              VINSERTPS_r   Vdq,Hdq,Udq,Ib     E5 cpuid(SSE41)
+SSE|VEX.66.0F3A 21              VINSERTPS_m   Vdq,Hdq,Md,Ib      E5 cpuid(SSE41)
+SSE|VEX.66.0F3A 22              PINSR         Vdq,Hdq,Ey,Ib      E5 cpuid(SSE41)
+
+VEX.66.0F3A.W0 38               VINSERTx128   Vqq,Hqq,Wdq,Ib     E6 cpuid(AVX2)
+VEX.66.0F3A.W0 39               VEXTRACTx128  Wdq,Vqq,Ib         E6 cpuid(AVX2)
+
+SSE|VEX.66.0F3A 40              VDPPS         Vx,Hx,Wx,Ib        E2 cpuid(SSE41)
+SSE|VEX.66.0F3A 41              VDPPD         Vdq,Hdq,Wdq,Ib     E2 cpuid(SSE41)
+SSE|VEX.66.0F3A 42              VMPSADBW      Vx,Hx,Wx,Ib        E2(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F3A 44              PCLMULQDQ     Vdq,Hdq,Wdq,Ib     E4 cpuid(PCLMULQDQ)
+VEX.66.0F3A.W0 46               VPERM2x128    Vqq,Hqq,Wqq,Ib     E6 cpuid(AVX2)
+
+// Listed incorrectly as type 4
+VEX.66.0F3A.W0 4A               VBLENDVPS     Vx,Hx,Wx,Ib        E6 cpuid(AVX)
+VEX.66.0F3A.W0 4B               VBLENDVPD     Vx,Hx,Wx,Ib        E6 cpuid(AVX)
+VEX.66.0F3A.W0 4C               VPBLENDVB     Vx,Hx,Wx,Ib        E6(avx2_256) cpuid(AVX)
+
+SSE|VEX.66.0F3A 60              PCMPESTRM     Vdq(r),Wdq,Ib      E4(unaligned) cpuid(SSE42)
+SSE|VEX.66.0F3A 61              PCMPESTRI     Vdq(r),Wdq,Ib      E4(unaligned) cpuid(SSE42)
+SSE|VEX.66.0F3A 62              PCMPISTRM     Vdq(r),Wdq,Ib      E4(unaligned) cpuid(SSE42)
+SSE|VEX.66.0F3A 63              PCMPISTRI     Vdq(r),Wdq,Ib      E4(unaligned) cpuid(SSE42)
+
+NP.0F3A CC                      SHA1RNDS4     Vdq,Wdq,Ib         cpuid(SHA_NI)
+
+66.0F3A DF                      VAESKEYGEN    Vdq,Wdq,Ib         E4 cpuid(AES)
+VEX.66.0F3A DF                  VAESKEYGEN    Vdq,Wdq,Ib         E4 cpuid(AES, AVX)
+
+VEX|EVEX.F2.0F3A.LZ.NF0 F0      RORX          Gy,Ey,Ib           E13 cpuid(BMI2)
-- 
2.56.0



