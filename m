Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B1606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mm7paZhL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiI-0002bW-OC; Wed, 18 Nov 2026 07:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei8-0002Rp-Ml
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei4-0005Cm-Lx
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KwXTFI35iuY8vu/vaPknfluekQIXrnmpDZiAqptzhs=;
 b=Mm7paZhLQrMZI4x5dbgztMrr1k8G1FMX72Jl6OsaokTgH77LMtCBXiLzjoCWgx9CkzwGBT
 EjsU4h0AOXEiiM1U28KqFX73rK+ImMLyscnJ370QgORQnSSofWV4V9wJnXXERqiKudETiG
 lcJzfT3ymC/GVyE/ZsBLCatj0qJdJfo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-IRujMYl0OgO8Mb7ESVblQw-1; Wed,
 18 Nov 2026 07:24:18 -0500
X-MC-Unique: IRujMYl0OgO8Mb7ESVblQw-1
X-Mimecast-MFC-AGG-ID: IRujMYl0OgO8Mb7ESVblQw_1795004657
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 946F819560B2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:17 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E70C518011D9
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 16/26] target/i386/tcg: convert the 0F38 map to decode.def
Date: Wed, 18 Nov 2026 13:23:47 +0100
Message-ID: <20261118122357.659634-17-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Describe the 0F38 opcode map in decode.def.  The new rows replace
opcodes_0F38_00toEF, opcodes_0F38_F0toFF and decode_group17.  The
generated rows match the old tables, using features such as the op2
modifier for unary instructions (PABS*, VPMOVSX/ZX*, VPBROADCAST*,
VAESIMC, ...), "/digit" constraints for group 17, and multiple CPUID
features to support 256-bit AES (VAES).

AI-used-for: code
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h              |   4 +-
 target/i386/tcg/decode-new.c.inc          | 264 +---------------------
 target/i386/tcg/emit.c.inc                |   2 +
 target/i386/tcg/decode.def                | 192 ++++++++++++++++
 target/i386/tcg/maketable.py              |  23 +-
 target/i386/tcg/maketable_codegen.py      |   2 +
 target/i386/tcg/test_maketable.py         |  22 ++
 target/i386/tcg/test_maketable_codegen.py |   6 +
 8 files changed, 248 insertions(+), 267 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index cd4bb360c2d..c97afdcb323 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -123,6 +123,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_SSE41,
     X86_FEAT_SSE42,
     X86_FEAT_SSE4A,
+    X86_FEAT_VAES,
     X86_FEAT_XSAVE,
     X86_FEAT_XSAVEOPT,
 } X86CPUIDFeature;
@@ -253,9 +254,6 @@ typedef enum X86InsnSpecial {
 typedef enum X86VEXSpecial {
     X86_VEX_None,
 
-    /* SSE and AVX instructions use different encoding */
-    X86_VEX_SSEOnly,
-
     /* Legacy SSE instructions that allow unaligned operands */
     X86_VEX_SSEUnaligned,
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0ae6deff65a..49a40eebbc7 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -253,7 +253,6 @@
 #define vex2_rep3 .vex_class = 2, .vex_special = X86_VEX_REPScalar,
 #define vex3 .vex_class = 3,
 #define vex4 .vex_class = 4,
-#define sse4 .vex_class = 4, .vex_special = X86_VEX_SSEOnly,
 #define vex4_unal .vex_class = 4, .vex_special = X86_VEX_SSEUnaligned,
 #define vex4_rep5 .vex_class = 4, .vex_special = X86_VEX_REPScalar,
 #define vex5 .vex_class = 5,
@@ -521,15 +520,6 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     }
 }
 
-static void decode_group17(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86GenFunc group17_gen[8] = {
-        NULL, gen_BLSR, gen_BLSMSK, gen_BLSI,
-    };
-    int op = (get_modrm(s, env) >> 3) & 7;
-    entry->gen = group17_gen[op];
-}
-
 static void decode_group12(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry opcodes_group12[8] = {
@@ -726,243 +716,17 @@ static void decode_0FD6(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = *decode_by_prefix(s, movq);
 }
 
-static const X86OpEntry opcodes_0F38_00toEF[240] = {
-    [0x00] = X86_OP_ENTRY3(PSHUFB,    V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x01] = X86_OP_ENTRY3(PHADDW,    V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x02] = X86_OP_ENTRY3(PHADDD,    V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x03] = X86_OP_ENTRY3(PHADDSW,   V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x04] = X86_OP_ENTRY3(PMADDUBSW, V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x05] = X86_OP_ENTRY3(PHSUBW,    V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x06] = X86_OP_ENTRY3(PHSUBD,    V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x07] = X86_OP_ENTRY3(PHSUBSW,   V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-
-    [0x10] = X86_OP_ENTRY2(PBLENDVB,  V,x,         W,x,  sse4 cpuid(SSE41) p_66),
-    [0x13] = X86_OP_ENTRY2(VCVTPH2PS, V,x,         W,xh, vex11 chk(W0) cpuid(F16C) p_66),
-    [0x14] = X86_OP_ENTRY2(BLENDVPS,  V,x,         W,x,  sse4 cpuid(SSE41) p_66),
-    [0x15] = X86_OP_ENTRY2(BLENDVPD,  V,x,         W,x,  sse4 cpuid(SSE41) p_66),
-    /* Listed incorrectly as type 4 */
-    [0x16] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 chk(W0) cpuid(AVX2) p_66), /* vpermps */
-    [0x17] = X86_OP_ENTRY3(VPTEST,    None,None, V,x,  W,x,   vex4 cpuid(SSE41) p_66),
-
-    /*
-     * Source operand listed as Mq/Ux and similar in the manual; incorrectly listed
-     * as 128-bit only in 2-17.
-     */
-    [0x20] = X86_OP_ENTRY3(VPMOVSXBW, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x21] = X86_OP_ENTRY3(VPMOVSXBD, V,x,  None,None, W,d,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x22] = X86_OP_ENTRY3(VPMOVSXBQ, V,x,  None,None, W,w,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x23] = X86_OP_ENTRY3(VPMOVSXWD, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x24] = X86_OP_ENTRY3(VPMOVSXWQ, V,x,  None,None, W,d,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x25] = X86_OP_ENTRY3(VPMOVSXDQ, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-
-    /* Same as PMOVSX.  */
-    [0x30] = X86_OP_ENTRY3(VPMOVZXBW, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x31] = X86_OP_ENTRY3(VPMOVZXBD, V,x,  None,None, W,d,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x32] = X86_OP_ENTRY3(VPMOVZXBQ, V,x,  None,None, W,w,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x33] = X86_OP_ENTRY3(VPMOVZXWD, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x34] = X86_OP_ENTRY3(VPMOVZXWQ, V,x,  None,None, W,d,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x35] = X86_OP_ENTRY3(VPMOVZXDQ, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x36] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 chk(W0) cpuid(AVX2) p_66),
-    [0x37] = X86_OP_ENTRY3(PCMPGTQ,   V,x,  H,x,       W,x,   vex4 cpuid(SSE42) avx2_256 p_66),
-
-    [0x40] = X86_OP_ENTRY3(PMULLD,      V,x,  H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x41] = X86_OP_ENTRY3(VPHMINPOSUW, V,dq, None,None, W,dq, vex4 cpuid(SSE41) p_66),
-    /* Listed incorrectly as type 4 */
-    [0x45] = X86_OP_ENTRY3(VPSRLV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
-    [0x46] = X86_OP_ENTRY3(VPSRAV,      V,x,  H,x,       W,x,  vex6 chk(W0) cpuid(AVX2) p_66),
-    [0x47] = X86_OP_ENTRY3(VPSLLV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
-
-    [0x90] = X86_OP_ENTRY3(VPGATHERD, V,x,  H,x,  M,d,  vex12 cpuid(AVX2) p_66), /* vpgatherdd/q */
-    [0x91] = X86_OP_ENTRY3(VPGATHERQ, V,x,  H,x,  M,q,  vex12 cpuid(AVX2) p_66), /* vpgatherqd/q */
-    [0x92] = X86_OP_ENTRY3(VPGATHERD, V,x,  H,x,  M,d,  vex12 cpuid(AVX2) p_66), /* vgatherdps/d */
-    [0x93] = X86_OP_ENTRY3(VPGATHERQ, V,x,  H,x,  M,q,  vex12 cpuid(AVX2) p_66), /* vgatherqps/d */
-
-    /* Should be exception type 2 but they do not have legacy SSE equivalents? */
-    [0x96] = X86_OP_ENTRY3(VFMADDSUB132Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x97] = X86_OP_ENTRY3(VFMSUBADD132Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-
-    [0xa6] = X86_OP_ENTRY3(VFMADDSUB213Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xa7] = X86_OP_ENTRY3(VFMSUBADD213Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-
-    [0xb6] = X86_OP_ENTRY3(VFMADDSUB231Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xb7] = X86_OP_ENTRY3(VFMSUBADD231Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-
-    [0x08] = X86_OP_ENTRY3(PSIGNB,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x09] = X86_OP_ENTRY3(PSIGNW,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x0a] = X86_OP_ENTRY3(PSIGND,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x0b] = X86_OP_ENTRY3(PMULHRSW,  V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    /* Listed incorrectly as type 4 */
-    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
-    [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
-    [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
-    [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
-
-    [0x18] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 chk(W0) cpuid(AVX) p_66), /* vbroadcastss */
-    [0x19] = X86_OP_ENTRY3(VPBROADCASTQ,   V,qq, None,None, W,q,  vex6 chk(W0) cpuid(AVX) p_66), /* vbroadcastsd */
-    [0x1a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 chk(W0) cpuid(AVX) p_66),
-    [0x1c] = X86_OP_ENTRY3(PABSB,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x1d] = X86_OP_ENTRY3(PABSW,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x1e] = X86_OP_ENTRY3(PABSD,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-
-    [0x28] = X86_OP_ENTRY3(PMULDQ,        V,x, H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x29] = X86_OP_ENTRY3(PCMPEQQ,       V,x, H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x2a] = X86_OP_ENTRY3(MOVDQ,         V,x, None,None, WM,x, vex1 cpuid(SSE41) avx2_256 p_66), /* movntdqa */
-    [0x2b] = X86_OP_ENTRY3(VPACKUSDW,     V,x, H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x2c] = X86_OP_ENTRY3(VMASKMOVPS,    V,x, H,x,       WM,x, vex6 chk(W0) cpuid(AVX) p_66),
-    [0x2d] = X86_OP_ENTRY3(VMASKMOVPD,    V,x, H,x,       WM,x, vex6 chk(W0) cpuid(AVX) p_66),
-    /* Incorrectly listed as Mx,Hx,Vx in the manual */
-    [0x2e] = X86_OP_ENTRY3(VMASKMOVPS_st, M,x, V,x,       H,x,  vex6 chk(W0) cpuid(AVX) p_66),
-    [0x2f] = X86_OP_ENTRY3(VMASKMOVPD_st, M,x, V,x,       H,x,  vex6 chk(W0) cpuid(AVX) p_66),
-
-    [0x38] = X86_OP_ENTRY3(PMINSB,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x39] = X86_OP_ENTRY3(PMINSD,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x3a] = X86_OP_ENTRY3(PMINUW,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x3b] = X86_OP_ENTRY3(PMINUD,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x3c] = X86_OP_ENTRY3(PMAXSB,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x3d] = X86_OP_ENTRY3(PMAXSD,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x3e] = X86_OP_ENTRY3(PMAXUW,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x3f] = X86_OP_ENTRY3(PMAXUD,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-
-    /* VPBROADCASTQ not listed as W0 in table 2-16 */
-    [0x58] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 chk(W0) cpuid(AVX2) p_66),
-    [0x59] = X86_OP_ENTRY3(VPBROADCASTQ,   V,x,  None,None, W,q,  vex6 chk(W0) cpuid(AVX2) p_66),
-    [0x5a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 chk(W0) cpuid(AVX2) p_66),
-
-    [0x78] = X86_OP_ENTRY3(VPBROADCASTB,   V,x,  None,None, W,b,  vex6 chk(W0) cpuid(AVX2) p_66),
-    [0x79] = X86_OP_ENTRY3(VPBROADCASTW,   V,x,  None,None, W,w,  vex6 chk(W0) cpuid(AVX2) p_66),
-
-    [0x8c] = X86_OP_ENTRY3(VPMASKMOV,    V,x,  H,x, WM,x, vex6 cpuid(AVX2) p_66),
-    [0x8e] = X86_OP_ENTRY3(VPMASKMOV_st, M,x,  V,x, H,x,  vex6 cpuid(AVX2) p_66),
-
-    /* Should be exception type 2 or 3 but they do not have legacy SSE equivalents? */
-    [0x98] = X86_OP_ENTRY3(VFMADD132Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x99] = X86_OP_ENTRY3(VFMADD132Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0x9a] = X86_OP_ENTRY3(VFMSUB132Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x9b] = X86_OP_ENTRY3(VFMSUB132Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0x9c] = X86_OP_ENTRY3(VFNMADD132Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x9d] = X86_OP_ENTRY3(VFNMADD132Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0x9e] = X86_OP_ENTRY3(VFNMSUB132Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x9f] = X86_OP_ENTRY3(VFNMSUB132Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-
-    [0xa8] = X86_OP_ENTRY3(VFMADD213Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xa9] = X86_OP_ENTRY3(VFMADD213Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0xaa] = X86_OP_ENTRY3(VFMSUB213Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xab] = X86_OP_ENTRY3(VFMSUB213Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0xac] = X86_OP_ENTRY3(VFNMADD213Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xad] = X86_OP_ENTRY3(VFNMADD213Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0xae] = X86_OP_ENTRY3(VFNMSUB213Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xaf] = X86_OP_ENTRY3(VFNMSUB213Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-
-    [0xb8] = X86_OP_ENTRY3(VFMADD231Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xb9] = X86_OP_ENTRY3(VFMADD231Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0xba] = X86_OP_ENTRY3(VFMSUB231Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xbb] = X86_OP_ENTRY3(VFMSUB231Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0xbc] = X86_OP_ENTRY3(VFNMADD231Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xbd] = X86_OP_ENTRY3(VFNMADD231Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-    [0xbe] = X86_OP_ENTRY3(VFNMSUB231Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xbf] = X86_OP_ENTRY3(VFNMSUB231Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
-
-    [0xc8] = X86_OP_ENTRY2(SHA1NEXTE,   V,dq, W,dq, cpuid(SHA_NI)),
-    [0xc9] = X86_OP_ENTRY2(SHA1MSG1,    V,dq, W,dq, cpuid(SHA_NI)),
-    [0xca] = X86_OP_ENTRY2(SHA1MSG2,    V,dq, W,dq, cpuid(SHA_NI)),
-    [0xcb] = X86_OP_ENTRY2(SHA256RNDS2, V,dq, W,dq, cpuid(SHA_NI)),
-    [0xcc] = X86_OP_ENTRY2(SHA256MSG1,  V,dq, W,dq, cpuid(SHA_NI)),
-    [0xcd] = X86_OP_ENTRY2(SHA256MSG2,  V,dq, W,dq, cpuid(SHA_NI)),
-
-    [0xdb] = X86_OP_ENTRY3(VAESIMC,     V,dq, None,None, W,dq, vex4 cpuid(AES) p_66),
-    [0xdc] = X86_OP_ENTRY3(VAESENC,     V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
-    [0xdd] = X86_OP_ENTRY3(VAESENCLAST, V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
-    [0xde] = X86_OP_ENTRY3(VAESDEC,     V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
-    [0xdf] = X86_OP_ENTRY3(VAESDECLAST, V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
-
-    /*
-     * REG selects srcdest2 operand, VEX.vvvv selects src3.  VEX class not found
-     * in manual, assumed to be 13 from the VEX.L0 constraint; EVEX-APX-BMI and
-     * EVEX-APX-CMPccXADD are also pretty much the same; the difference are
-     * reflected in chk(nf0) and in the M operand type.
-     */
-    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-
-    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xea] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xec] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xed] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xee] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-    [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
-};
-
-/*
- * four rows for no prefix, 66, F3, F2 (including 66+F2 operand size override).
- * all VEX13 instructions extend to APX, while MOVBE/CRC32 move to EVEX map4
- */
-static const X86OpEntry opcodes_0F38_F0toFF[16][4] = {
-    /*
-     * MOVBE and CRC32 are incorrectly listed as always doing 32-bit operation
-     * without prefix and 16-bit operation with 0x66.
-     */
-    [0] = {
-        X86_OP_ENTRYwr(MOVBE, G,v, M,v, cpuid(MOVBE)),
-        X86_OP_ENTRYwr(MOVBE, G,v, M,v, cpuid(MOVBE)),
-        {},
-        X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
-    },
-    [1] = {
-        X86_OP_ENTRYwr(MOVBE, M,v, G,v, cpuid(MOVBE)),
-        X86_OP_ENTRYwr(MOVBE, M,v, G,v, cpuid(MOVBE)),
-        {},
-        X86_OP_ENTRY2(CRC32, G,d, E,v, cpuid(SSE42)),
-    },
-    [2] = {
-        X86_OP_ENTRY3(ANDN, G,y, B,y, E,y, vex13 cpuid(BMI1)),
-        {},
-        {},
-        {},
-    },
-    [3] = {
-        X86_OP_GROUP3(group17, B,y, None,None, E,y, vex13 cpuid(BMI1)),
-        {},
-        {},
-        {},
-    },
-    [5] = {
-        X86_OP_ENTRY3(BZHI, G,y, E,y, B,b, vex13 zextT1 cpuid(BMI1)),
-        {},
-        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 chk(nf0) cpuid(BMI2)),
-        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 chk(nf0) cpuid(BMI2)),
-    },
-    [6] = {
-        {},
-        X86_OP_ENTRY2(ADCX, G,y, E,y, zextT0 zextT1 cpuid(ADX)),
-        X86_OP_ENTRY2(ADOX, G,y, E,y, zextT0 zextT1 cpuid(ADX)),
-        X86_OP_ENTRY3(MULX, /* B,y, */ G,y, E,y, 2,y, vex13 chk(nf0) cpuid(BMI2)),
-    },
-    [7] = {
-        X86_OP_ENTRY3(BEXTR, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 chk(nf0) cpuid(BMI1)),
-        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 chk(nf0) sextT0 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 chk(nf0) zextT0 cpuid(BMI1)),
-    },
-};
-
 static const X86OpEntry *decode_run(DisasContext *s, CPUX86State *env,
                                     int map, uint8_t *b);
 
 static void decode_0F38(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
+    const X86OpEntry *row;
+
     *b = x86_ldub_code(env, s);
-    if (*b < 0xf0) {
-        *entry = opcodes_0F38_00toEF[*b];
-    } else {
-        *entry = *decode_by_prefix(s, opcodes_0F38_F0toFF[*b & 15]);
+    row = decode_run(s, env, 2, b);
+    if (row) {
+        *entry = *row;
     }
 }
 
@@ -2997,15 +2761,9 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     case X86_FEAT_SSE42:
         return (s->cpuid_ext_features & CPUID_EXT_SSE42);
     case X86_FEAT_AES:
-        if (!(s->cpuid_ext_features & CPUID_EXT_AES)) {
-            return false;
-        } else if (!(s->prefix & PREFIX_VEX)) {
-            return true;
-        } else if (!(s->cpuid_ext_features & CPUID_EXT_AVX)) {
-            return false;
-        } else {
-            return !s->vex_l || (s->cpuid_7_0_ecx_features & CPUID_7_0_ECX_VAES);
-        }
+        return (s->cpuid_ext_features & CPUID_EXT_AES);
+    case X86_FEAT_VAES:
+        return (s->cpuid_7_0_ecx_features & CPUID_7_0_ECX_VAES);
     case X86_FEAT_AVX:
         return (s->cpuid_ext_features & CPUID_EXT_AVX);
     case X86_FEAT_XSAVE:
@@ -3162,12 +2920,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         }
         break;
 
-    case X86_VEX_SSEOnly:
-        if (s->prefix & PREFIX_VEX) {
-            goto illegal;
-        }
-        break;
-
     case X86_VEX_SSEUnaligned:
         /* handled in sse_needs_alignment.  */
         break;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ab11c61344b..ec0c9a6f360 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1818,6 +1818,7 @@ static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
     gen_dfv_movcond(s, decode, cond, dfv, ot, cout);
 }
 
+#ifdef TARGET_X86_64
 static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGLabel *label_top = gen_new_label();
@@ -1917,6 +1918,7 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
     decode->cc_src = cmpv;
     decode->cc_op = CC_OP_SUBB + ot;
 }
+#endif
 
 static void gen_CMPS(DisasContext *s, X86DecodedInsn *decode)
 {
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index 36b0eabbc87..7ef0b1dd65b 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -120,6 +120,12 @@
 //             ModRM.mod == 3 and any ModRM.rm for instructions that have
 //             no operands.
 //
+//     op2     the operand is the only source and the emitter reads it
+//             from decode->op[2], leaving op[1] empty.  It is used for
+//             unary operations such as PABSB Vx(w),Wx(op2); it cannot be
+//             used if the first operand is also read, because the
+//             emitter then reads it from op[1].
+//
 // The fourth operand, if present, must be Ib.
 //
 //
@@ -194,6 +200,192 @@
 //       decode.def:867: 66.0F38 10                  PBLENDVB      Vx,Wx              E4 cpuid(SSE41): needs ENC=legacy
 //
 
+// 0F 38
+// -----
+
+SSE|VEX.NP|66.0F38 00      PSHUFB        Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 01      PHADDW        Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 02      PHADDD        Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 03      PHADDSW       Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 04      PMADDUBSW     Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 05      PHSUBW        Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 06      PHSUBD        Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 07      PHSUBSW       Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+
+SSE|VEX.NP|66.0F38 08      PSIGNB        Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 09      PSIGNW        Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 0A      PSIGND        Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 0B      PMULHRSW      Vx,Hx,Wx          E4(avx2_256, mmx) cpuid(SSSE3)
+// Listed incorrectly as type 4
+VEX.66.0F38.W0 0C           VPERMILPS     Vx,Hx,Wx           E6 cpuid(AVX)
+VEX.66.0F38.W0 0D           VPERMILPD     Vx,Hx,Wx           E6 cpuid(AVX)
+VEX.66.0F38.W0 0E           VTESTPS       Vx(r),Wx           E6 cpuid(AVX)
+VEX.66.0F38.W0 0F           VTESTPD       Vx(r),Wx           E6 cpuid(AVX)
+
+// The VEX encodings of the BLENDV instructions do not exist (VBLENDVPS and
+// others are in map 0F3A).
+66.0F38 10                  PBLENDVB      Vx,Wx              E4 cpuid(SSE41)
+VEX.66.0F38.W0 13           VCVTPH2PS     Vx,Wxh             E11 cpuid(F16C)
+66.0F38 14                  BLENDVPS      Vx,Wx              E4 cpuid(SSE41)
+66.0F38 15                  BLENDVPD      Vx,Wx              E4 cpuid(SSE41)
+// Listed incorrectly as type 4
+VEX.66.0F38.W0 16           VPERMD        Vqq,Hqq,Wqq        E6 cpuid(AVX2)   // VPERMPS
+SSE|VEX.66.0F38 17          VPTEST        Vx(r),Wx           E4 cpuid(SSE41)
+
+VEX.66.0F38.W0 18           VPBROADCASTD  Vx(w),Wd(op2)      E6 cpuid(AVX)    // VBROADCASTSS
+VEX.66.0F38.W0 19           VPBROADCASTQ  Vqq(w),Wq(op2)     E6 cpuid(AVX)    // VBROADCASTSD
+VEX.66.0F38.W0 1A           VBROADCASTx128 Vqq(w),Wdq(m,op2) E6 cpuid(AVX)
+SSE|VEX.NP|66.0F38 1C      PABSB         Vx(w),Wx(op2)      E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 1D      PABSW         Vx(w),Wx(op2)      E4(avx2_256, mmx) cpuid(SSSE3)
+SSE|VEX.NP|66.0F38 1E      PABSD         Vx(w),Wx(op2)      E4(avx2_256, mmx) cpuid(SSSE3)
+
+// Source operand listed as Mq/Ux and similar in the manual; incorrectly listed
+// as 128-bit only in 2-17.
+SSE|VEX.66.0F38 20          VPMOVSXBW     Vx(w),Wq(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 21          VPMOVSXBD     Vx(w),Wd(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 22          VPMOVSXBQ     Vx(w),Ww(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 23          VPMOVSXWD     Vx(w),Wq(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 24          VPMOVSXWQ     Vx(w),Wd(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 25          VPMOVSXDQ     Vx(w),Wq(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+
+// Same as PMOVSX.
+SSE|VEX.66.0F38 30          VPMOVZXBW     Vx(w),Wq(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 31          VPMOVZXBD     Vx(w),Wd(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 32          VPMOVZXBQ     Vx(w),Ww(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 33          VPMOVZXWD     Vx(w),Wq(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 34          VPMOVZXWQ     Vx(w),Wd(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+SSE|VEX.66.0F38 35          VPMOVZXDQ     Vx(w),Wq(op2)      E5(avx2_256) cpuid(SSE41) avx_movx
+
+SSE|VEX.66.0F38 28          PMULDQ        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 29          PCMPEQQ       Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 2A          MOVDQ         Vx(w),Wx(m,op2)    E1(avx2_256) cpuid(SSE41)  // MOVNTDQA
+SSE|VEX.66.0F38 2B          VPACKUSDW     Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+VEX.66.0F38.W0 2C           VMASKMOVPS    Vx,Hx,Wx(m)        E6 cpuid(AVX)
+VEX.66.0F38.W0 2D           VMASKMOVPD    Vx,Hx,Wx(m)        E6 cpuid(AVX)
+// Incorrectly listed as Mx,Hx,Vx in the manual
+VEX.66.0F38.W0 2E           VMASKMOVPS_st Mx,Vx,Hx           E6 cpuid(AVX)
+VEX.66.0F38.W0 2F           VMASKMOVPD_st Mx,Vx,Hx           E6 cpuid(AVX)
+
+VEX.66.0F38.W0 36           VPERMD        Vqq,Hqq,Wqq        E6 cpuid(AVX2)
+SSE|VEX.66.0F38 37          PCMPGTQ       Vx,Hx,Wx           E4(avx2_256) cpuid(SSE42)
+
+SSE|VEX.66.0F38 38          PMINSB        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 39          PMINSD        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 3A          PMINUW        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 3B          PMINUD        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 3C          PMAXSB        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 3D          PMAXSD        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 3E          PMAXUW        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 3F          PMAXUD        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+
+SSE|VEX.66.0F38 40          PMULLD        Vx,Hx,Wx           E4(avx2_256) cpuid(SSE41)
+SSE|VEX.66.0F38 41          VPHMINPOSUW   Vdq(w),Wdq(op2)    E4 cpuid(SSE41)
+// Listed incorrectly as type 4
+VEX.66.0F38 45              VPSRLV        Vx,Hx,Wx           E6 cpuid(AVX2)
+VEX.66.0F38.W0 46           VPSRAV        Vx,Hx,Wx           E6 cpuid(AVX2)
+VEX.66.0F38 47              VPSLLV        Vx,Hx,Wx           E6 cpuid(AVX2)
+
+// VPBROADCASTQ not listed as W0 in table 2-16
+VEX.66.0F38.W0 58           VPBROADCASTD  Vx(w),Wd(op2)      E6 cpuid(AVX2)
+VEX.66.0F38.W0 59           VPBROADCASTQ  Vx(w),Wq(op2)      E6 cpuid(AVX2)
+VEX.66.0F38.W0 5A           VBROADCASTx128 Vqq(w),Wdq(m,op2) E6 cpuid(AVX2)
+
+VEX.66.0F38.W0 78           VPBROADCASTB  Vx(w),Wb(op2)      E6 cpuid(AVX2)
+VEX.66.0F38.W0 79           VPBROADCASTW  Vx(w),Ww(op2)      E6 cpuid(AVX2)
+
+VEX.66.0F38 8C              VPMASKMOV     Vx,Hx,Wx(m)        E6 cpuid(AVX2)
+VEX.66.0F38 8E              VPMASKMOV_st  Mx,Vx,Hx           E6 cpuid(AVX2)
+
+VEX.66.0F38 90              VPGATHERD     Vx,Hx,Md           E12 cpuid(AVX2)  // VPGATHERDD/Q
+VEX.66.0F38 91              VPGATHERQ     Vx,Hx,Mq           E12 cpuid(AVX2)  // VPGATHERQD/Q
+VEX.66.0F38 92              VPGATHERD     Vx,Hx,Md           E12 cpuid(AVX2)  // VGATHERDPS/D
+VEX.66.0F38 93              VPGATHERQ     Vx,Hx,Mq           E12 cpuid(AVX2)  // VGATHERQPS/D
+
+// Should be exception type 2 or 3 but they do not have legacy SSE equivalents?
+VEX.66.0F38 96              VFMADDSUB132Px  Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 97              VFMSUBADD132Px  Vx,Hx,Wx          E6 cpuid(FMA)
+
+VEX.66.0F38 98              VFMADD132Px     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG 99          VFMADD132Sx     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 9A              VFMSUB132Px     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG 9B          VFMSUB132Sx     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 9C              VFNMADD132Px    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG 9D          VFNMADD132Sx    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 9E              VFNMSUB132Px    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG 9F          VFNMSUB132Sx    Vx,Hx,Wx          E6 cpuid(FMA)
+
+VEX.66.0F38 A6              VFMADDSUB213Px  Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 A7              VFMSUBADD213Px  Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 A8              VFMADD213Px     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG A9          VFMADD213Sx     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 AA              VFMSUB213Px     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG AB          VFMSUB213Sx     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 AC              VFNMADD213Px    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG AD          VFNMADD213Sx    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 AE              VFNMSUB213Px    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG AF          VFNMSUB213Sx    Vx,Hx,Wx          E6 cpuid(FMA)
+
+VEX.66.0F38 B6              VFMADDSUB231Px  Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 B7              VFMSUBADD231Px  Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 B8              VFMADD231Px     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG B9          VFMADD231Sx     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 BA              VFMSUB231Px     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG BB          VFMSUB231Sx     Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 BC              VFNMADD231Px    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG BD          VFNMADD231Sx    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38 BE              VFNMSUB231Px    Vx,Hx,Wx          E6 cpuid(FMA)
+VEX.66.0F38.LIG BF          VFNMSUB231Sx    Vx,Hx,Wx          E6 cpuid(FMA)
+
+NP.0F38 C8                  SHA1NEXTE     Vdq,Wdq            cpuid(SHA_NI)
+NP.0F38 C9                  SHA1MSG1      Vdq,Wdq            cpuid(SHA_NI)
+NP.0F38 CA                  SHA1MSG2      Vdq,Wdq            cpuid(SHA_NI)
+NP.0F38 CB                  SHA256RNDS2   Vdq,Wdq            cpuid(SHA_NI)
+NP.0F38 CC                  SHA256MSG1    Vdq,Wdq            cpuid(SHA_NI)
+NP.0F38 CD                  SHA256MSG2    Vdq,Wdq            cpuid(SHA_NI)
+
+66.0F38 DB                  VAESIMC       Vdq(w),Wdq(op2)    E4 cpuid(AES)
+VEX.66.0F38.128 DB          VAESIMC       Vdq(w),Wdq(op2)    E4 cpuid(AES, AVX)
+66.0F38 DC                  VAESENC       Vx,Hx,Wx          E4 cpuid(AES)
+VEX.66.0F38.128 DC          VAESENC       Vx,Hx,Wx          E4 cpuid(AES, AVX)
+VEX.66.0F38.256 DC          VAESENC       Vx,Hx,Wx          E4 cpuid(AES, AVX, VAES)
+66.0F38 DD                  VAESENCLAST   Vx,Hx,Wx          E4 cpuid(AES)
+VEX.66.0F38.128 DD          VAESENCLAST   Vx,Hx,Wx          E4 cpuid(AES, AVX)
+VEX.66.0F38.256 DD          VAESENCLAST   Vx,Hx,Wx          E4 cpuid(AES, AVX, VAES)
+66.0F38 DE                  VAESDEC       Vx,Hx,Wx          E4 cpuid(AES)
+VEX.66.0F38.128 DE          VAESDEC       Vx,Hx,Wx          E4 cpuid(AES, AVX)
+VEX.66.0F38.256 DE          VAESDEC       Vx,Hx,Wx          E4 cpuid(AES, AVX, VAES)
+66.0F38 DF                  VAESDECLAST   Vx,Hx,Wx          E4 cpuid(AES)
+VEX.66.0F38.128 DF          VAESDECLAST   Vx,Hx,Wx          E4 cpuid(AES, AVX)
+VEX.66.0F38.256 DF          VAESDECLAST   Vx,Hx,Wx          E4 cpuid(AES, AVX, VAES)
+
+// REG selects srcdest2 operand, VEX.vvvv selects src3.  VEX class not found
+// in manual, assumed to be 13 from the VEX.L0 constraint; EVEX-APX-BMI and
+// EVEX-APX-CMPccXADD are also pretty much the same; the differences are
+// reflected in NF0 and in the M operand type.
+VEX|EVEX.66.0F38.LZ.NF0 E0..EF   CMPccXADD  My,Gy,By         E13 xchg chk(o64) cpuid(CMPCCXADD)
+
+// MOVBE and CRC32 are incorrectly listed as always doing 32-bit operation
+// without prefix and 16-bit operation with 0x66.
+NP|66.0F38 F0               MOVBE         Gv(w),Mv           cpuid(MOVBE)
+F2.0F38 F0                  CRC32         Gd,Eb              cpuid(SSE42)
+NP|66.0F38 F1               MOVBE         Mv(w),Gv           cpuid(MOVBE)
+F2.0F38 F1                  CRC32         Gd,Ev              cpuid(SSE42)
+
+// All VEX13 instructions extend to APX, while MOVBE and CRC32 move to EVEX map 4.
+VEX|EVEX.NP.0F38.LZ F2      ANDN          Gy,By,Ey          E13 cpuid(BMI1)
+VEX|EVEX.NP.0F38.LZ F3 /1   BLSR          By(w),Ey(op2)     E13 cpuid(BMI1)
+VEX|EVEX.NP.0F38.LZ F3 /2   BLSMSK        By(w),Ey(op2)     E13 cpuid(BMI1)
+VEX|EVEX.NP.0F38.LZ F3 /3   BLSI          By(w),Ey(op2)     E13 cpuid(BMI1)
+VEX|EVEX.NP.0F38.LZ F5      BZHI          Gy,Ey,Bb(zx)      E13 cpuid(BMI1)
+VEX|EVEX.F3.0F38.LZ.NF0 F5  PEXT          Gy,By(zx),Ey      E13 cpuid(BMI2)
+VEX|EVEX.F2.0F38.LZ.NF0 F5  PDEP          Gy,By(zx),Ey      E13 cpuid(BMI2)
+66.0F38 F6                  ADCX          Gy(zx),Ey(zx)     cpuid(ADX)
+F3.0F38 F6                  ADOX          Gy(zx),Ey(zx)     cpuid(ADX)
+VEX|EVEX.F2.0F38.LZ.NF0 F6  MULX          Gy,Ey,RDXy        E13 cpuid(BMI2)
+VEX|EVEX.NP.0F38.LZ F7      BEXTR         Gy,Ey(zx),By      E13 cpuid(BMI1)
+VEX|EVEX.66.0F38.LZ.NF0 F7  SHLX          Gy,Ey,By          E13 cpuid(BMI1)
+VEX|EVEX.F3.0F38.LZ.NF0 F7  SARX          Gy,Ey(sx),By      E13 cpuid(BMI1)
+VEX|EVEX.F2.0F38.LZ.NF0 F7  SHRX          Gy,Ey(zx),By      E13 cpuid(BMI1)
 
 // 0F 3A
 // -----
diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index 62bd6e0bddb..0fbdb3b8e32 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -467,7 +467,7 @@ def c_names(path: str, prefix: str) -> frozenset[str]:
 INTEGER_TYPES = {'B', 'E', 'G', 'I', 'M', 'O', 'R',
                  'RAX', 'RCX', 'RDX', 'RBX', 'RSP', 'RBP', 'RSI', 'RDI'}
 
-OPERAND_MODS = {'r', 'w', 'm', 'zx', 'sx', 'nop'}
+OPERAND_MODS = {'r', 'w', 'm', 'zx', 'sx', 'nop', 'op2'}
 
 # Modifiers without arguments, grouped by the X86OpEntry field they set.
 SPECIAL_MODIFIERS = {'nolea', 'xchg', 'lock', 'op0_Rd', 'op2_Ry', 'avx_movx',
@@ -661,19 +661,26 @@ def check_operands(self) -> None:
             raise self.error(f'at most {len(DEFAULT_ACCESS) - 1} operands are supported')
 
         if self.insn.operands:
+            slots = len(self.insn.operands)
+            if any('op2' in op.mods for op in self.insn.operands) and slots > 2:
+                raise self.error('op2 is only valid with a single source operand')
+
             # X86OpEntry has a single destination (op0), so only the first
-            # operand can be written.
+            # operand can be written.  A r/w first operand counts as two operands.
             if any('w' in op.mods for op in self.insn.operands[1:]):
                 raise self.error('only the first operand can be written')
-
-            # The fourth operand is always an 8-bit immediate (see X86_OP_ENTRY4).
-            # A r/w operand counts as two.
-            slots = len(self.insn.operands)
             mods = self.insn.operands[0].mods
             if 'r' not in mods and 'w' not in mods and 'nop' not in mods:
                 mods = DEFAULT_ACCESS[slots][0]
-            if 'r' in mods and 'w' in mods:
-                slots += 1
+            if 'w' in mods:
+                if 'op2' in mods:
+                    raise self.error('op2 is only valid for source operands')
+                if 'r' in mods:
+                    if slots >= 2 and 'op2' in self.insn.operands[1].mods:
+                        raise self.error('op2 is not necessary with a read/write operand')
+                    slots += 1
+
+            # The fourth operand is always an 8-bit immediate (see X86_OP_ENTRY4).
             if slots == 4:
                 op = self.insn.operands[-1]
                 if op.type != 'I' or op.size != 'b' or op.mods:
diff --git a/target/i386/tcg/maketable_codegen.py b/target/i386/tcg/maketable_codegen.py
index 87353042cae..fb58a136dda 100644
--- a/target/i386/tcg/maketable_codegen.py
+++ b/target/i386/tcg/maketable_codegen.py
@@ -66,6 +66,8 @@ def set_operand(slot: int, type: str, size: str | None, ext: str | None) -> None
             set_operand(0, dest.type, dest.size, operand_ext(dest))
         next(sources)
     for src in sources:
+        if 'op2' in src.mods:
+            slot += 1
         if slot > 2:
             assert slot == 3 and src.type == 'I' and src.size == 'b'
         set_operand(slot, src.type, src.size, operand_ext(src))
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
index 215aad13ae7..53d57ebb21e 100644
--- a/target/i386/tcg/test_maketable.py
+++ b/target/i386/tcg/test_maketable.py
@@ -401,6 +401,11 @@ def test_modrm(self) -> None:
     def test_mode64(self) -> None:
         self.assertRaises(SemanticError, self.analyze, '63   X   Ew,Gw   chk(i64, o64)')
 
+    def test_op2(self) -> None:
+        self.assertRaises(SemanticError, self.analyze, '00   X   Ev(w,op2),Gv')
+        self.assertRaises(SemanticError, self.analyze, '00   X   Ev(r,w),Gv(op2)')
+        self.assertRaises(SemanticError, self.analyze, '00   X   Ev(w),Gv,Iv(op2)')
+
 
 class TestTrie(unittest.TestCase):
     def build(self, *lines: str) -> Trie:
@@ -539,3 +544,20 @@ def test_overlap(self) -> None:
                           'NP|66.0F 67   X   Vx', '66.0F 67   Y   Vx')
         self.assertRaises(SemanticError, self.build,
                           '0F AE /0   X   Ey', 'F3.0F AE /0   Y   Ry(w)')
+
+    def test_cpuid_several(self) -> None:
+        trie = self.build('66.0F38 DC         AESENC   Vx(w),Hx,Wx   E4 cpuid(AES)',
+                          'VEX.66.0F38.128 DC AESENC   Vx(w),Hx,Wx   E4 cpuid(AES, AVX)',
+                          'VEX.66.0F38.256 DC AESENC   Vx(w),Hx,Wx   E4 cpuid(AES, AVX, VAES)')
+
+        def lookup(enc: int, l: int, features: collections.abc.Container[str]) -> int | None:
+            entry = trie.lookup(2, {Sel.BYTE: 0xDC, Sel.PREFIX: 1, Sel.ENC: enc, Sel.L: l},
+                                features)
+            return None if entry is None else entry.insn.lineno
+
+        self.assertEqual(lookup(ENC_LEGACY, 0, {'AES'}), 1)
+        self.assertIsNone(lookup(ENC_LEGACY, 0, {'AVX', 'VAES'}))
+        self.assertEqual(lookup(ENC_VEX, 0, {'AES', 'AVX'}), 2)
+        self.assertIsNone(lookup(ENC_VEX, 0, {'AES'}))
+        self.assertIsNone(lookup(ENC_VEX, 1, {'AES', 'AVX'}))
+        self.assertEqual(lookup(ENC_VEX, 1, {'AES', 'AVX', 'VAES'}), 3)
diff --git a/target/i386/tcg/test_maketable_codegen.py b/target/i386/tcg/test_maketable_codegen.py
index a56afbb7677..52fe1c9e433 100644
--- a/target/i386/tcg/test_maketable_codegen.py
+++ b/target/i386/tcg/test_maketable_codegen.py
@@ -308,3 +308,9 @@ def test_immediate_in_op3(self) -> None:
         fields = row_fields(entry('0F A4   SHLD   Ev(r,w),Gv,Ib'))
         self.assertEqual([fields[f'op{i}'] for i in range(4)],
                          ['X86_TYPE_E', 'X86_TYPE_2op', 'X86_TYPE_G', 'X86_TYPE_I'])
+
+    def test_op2(self) -> None:
+        # Like X86_OP_ENTRY3(PABSB, V,x, None,None, W,x).
+        fields = row_fields(entry('SSE|VEX.NP|66.0F38 1C   PABSB   Vx(w),Wx(op2)   E4(mmx)'))
+        self.assertEqual((fields['op0'], fields['op2']), ('X86_TYPE_V', 'X86_TYPE_W'))
+        self.assertNotIn('op1', fields)
-- 
2.56.0



