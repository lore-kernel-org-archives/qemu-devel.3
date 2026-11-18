Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5699606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N1HZxvVs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiN-0002dy-U7; Wed, 18 Nov 2026 07:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiF-0002Vp-7U
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiA-0005pP-9Q
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TtgjxR5Vju+hQdB2B5fPI/Mb2/oFJJUOem687wP/gwg=;
 b=N1HZxvVsK3KH9+MXfv2s2/QMc60bvb5UWbVvYrQRhs38EY9jFqH4wiPutr0eteIa9Qc8+Z
 2mvuz39wNWYKuxANXMHSPjG63aS3/WSd9l/AsMqlYI40ynLD/fbM4QOvcNiePZ4TEaMyfK
 rxehnhw2AHbC8UF6jrkCGy6/wLZZD7Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-vBDuCNgJMYaP-ndnMrom7Q-1; Wed,
 18 Nov 2026 07:24:23 -0500
X-MC-Unique: vBDuCNgJMYaP-ndnMrom7Q-1
X-Mimecast-MFC-AGG-ID: vBDuCNgJMYaP-ndnMrom7Q_1795004663
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED3CD195608F
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:22 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A74218011D3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 21/26] target/i386/tcg: convert the 0F map to decode.def
Date: Wed, 18 Nov 2026 13:23:52 +0100
Message-ID: <20261118122357.659634-22-pbonzini@redhat.com>
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

Finish the conversion of the opcode map to decode.def with map 0F,
including groups 8, 9, 12, 13, 14 and 15.  decode_0F() runs the program
from entry point 1, except that it handles the 38 and 3A escapes of the
legacy encoding itself, excluding them from VEX/EVEX/REX2 and directing
them to entry points 2 and 3 without going through decode_0F38() and
decode_0F3A().

Instructions that depend on the prefix or on ModRM.mod have separate
lines, using U, N, R or the m modifier to tell the register and
memory forms apart.  Patching of rows is removed by listing variants
on separate lines; for example the memory form of MOVDDUP lists VEX.256
separately to pick a different size for operand 2.

Alternatively, an R(nop) operand to set a constraint of ModRM.mod==3
(SEL_MOD=1).

This fixes some bugs, for example opcode 38 or 3A after a VEX or EVEX
prefix now raises #UD instead of being decoded as the 0F 38 and 0F 3A maps.
VZEROUPPER and VZEROALL also require VEX.pp=0.

And finaly, the emitters for FSGSBASE instructions are now built only
for TARGET_X86_64, because chk(o64) now compiles those rows out.

AI-used-for: code
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h      |   6 +-
 target/i386/tcg/decode-new.c.inc  | 859 +-----------------------------
 target/i386/tcg/emit.c.inc        |  20 +-
 target/i386/tcg/decode.def        | 339 ++++++++++++
 target/i386/tcg/test_maketable.py |   7 +
 5 files changed, 386 insertions(+), 845 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index c97afdcb323..92652f92f5b 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -95,6 +95,7 @@ typedef enum X86OpSize {
 typedef enum X86CPUIDFeature {
     X86_FEAT_None,
     X86_FEAT_3DNOW,
+    X86_FEAT_ABM,
     X86_FEAT_ADX,
     X86_FEAT_AES,
     X86_FEAT_AVX,
@@ -301,7 +302,8 @@ struct DisasContext;
  * trie whose leaves are rows of a table of X86OpEntry structs.  There is
  * one entry point for each opcode map: 0 for the one-byte opcodes, 1 for
  * 0F, 2 for 0F38, 3 for 0F3A and 4-7 for the EVEX maps.  The bytecode
- * interpreter is invoked from X86DecodeFuncs.
+ * interpreter is invoked from X86DecodeFuncs, for example decode_0F()
+ * can invoke decode_run() for any of maps 1..3.
  *
  * The program can look at:
  * - b, the last opcode byte that was fetched
@@ -417,7 +419,7 @@ typedef enum X86DecoderSel {
     X86_SEL_CPUID,
 } X86DecoderSel;
 
-/* Values of X86_SEL_PREFIX, in the same order as decode_by_prefix().  */
+/* Values of X86_SEL_PREFIX.  */
 typedef enum X86MandatoryPrefix {
     X86_PREFIX_NP,
     X86_PREFIX_66,
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 983ab466bfb..20c2a1328d4 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -55,9 +55,10 @@
  * mask could be applied (and the original sign-extended value would be
  * optimized away by TCG) in the emitter function.
  *
- * Finally, a "nop" operand type is used for multi-byte NOPs.  It accepts
- * any value of mod including 11b (unlike M) but it does not try to
- * interpret the operand (like M).
+ * Finally, a "nop" operand type is used for multi-byte NOPs and for
+ * some ModRM instructions such as LFENCE.  It accepts any value of
+ * mod including 11b (unlike M) but it does not try to interpret the
+ * operand (like M).
  *
  * Vector operands
  * ---------------
@@ -441,281 +442,6 @@ static inline const X86OpEntry *decode_by_prefix(DisasContext *s, const X86OpEnt
     }
 }
 
-static void decode_group8(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86GenFunc group8_gen[8] = {
-        NULL, NULL, NULL, NULL,
-        gen_BT, gen_BTS, gen_BTR, gen_BTC,
-    };
-    int op = (get_modrm(s, env) >> 3) & 7;
-    entry->gen = group8_gen[op];
-    if (op == 4) {
-        /* prevent writeback and LOCK for BT */
-        entry->op1 = entry->op0;
-        entry->op0 = X86_TYPE_None;
-        entry->s0 = X86_SIZE_None;
-    } else {
-        entry->special = X86_SPECIAL_HasLock;
-    }
-}
-
-static void decode_group9(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry group9_reg =
-        X86_OP_ENTRY0(multi0F);  /* unconverted */
-    static const X86OpEntry cmpxchg8b =
-        X86_OP_ENTRY1(CMPXCHG8B,  M,q,  lock p_00 cpuid(CX8));
-    static const X86OpEntry cmpxchg16b =
-        X86_OP_ENTRY1(CMPXCHG16B, M,dq, lock p_00 cpuid(CX16));
-
-    int modrm = get_modrm(s, env);
-    int op = (modrm >> 3) & 7;
-
-    if ((modrm >> 6) == 3) {
-        *entry = group9_reg;
-    } else if (op == 1) {
-        *entry = REX_W(s) ? cmpxchg16b : cmpxchg8b;
-    } else {
-        *entry = UNKNOWN_OPCODE;
-    }
-}
-
-static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry group15_reg[8] = {
-        [0] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
-        [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
-        [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
-        [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
-        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE) p_00),
-        [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
-        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE) p_00),
-    };
-
-    static const X86OpEntry group15_mem[8] = {
-        [0] = X86_OP_ENTRYw(FXSAVE,     M,y, cpuid(FXSR) p_00),
-        [1] = X86_OP_ENTRYr(FXRSTOR,    M,y, cpuid(FXSR) p_00),
-        [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128) p_00),
-        [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128) p_00),
-        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
-        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
-        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00 chk(no_rex2)),
-        [7] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLFLUSH) p_00),
-    };
-
-    static const X86OpEntry group15_mem_66[8] = {
-        [6] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLWB)),
-        [7] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLFLUSHOPT)),
-    };
-
-    uint8_t modrm = get_modrm(s, env);
-    int op = (modrm >> 3) & 7;
-
-    if ((modrm >> 6) == 3) {
-        *entry = group15_reg[op];
-    } else if (s->prefix & PREFIX_DATA) {
-        *entry = group15_mem_66[op];
-    } else {
-        *entry = group15_mem[op];
-    }
-}
-
-static void decode_group12(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_group12[8] = {
-        {},
-        {},
-        X86_OP_ENTRY3(PSRLW_i,  H,x, U,x, I,b, vex7 mmx avx2_256 p_00_66),
-        {},
-        X86_OP_ENTRY3(PSRAW_i,  H,x, U,x, I,b, vex7 mmx avx2_256 p_00_66),
-        {},
-        X86_OP_ENTRY3(PSLLW_i,  H,x, U,x, I,b, vex7 mmx avx2_256 p_00_66),
-        {},
-    };
-
-    int op = (get_modrm(s, env) >> 3) & 7;
-    *entry = opcodes_group12[op];
-}
-
-static void decode_group13(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_group13[8] = {
-        {},
-        {},
-        X86_OP_ENTRY3(PSRLD_i,  H,x, U,x, I,b, vex7 mmx avx2_256 p_00_66),
-        {},
-        X86_OP_ENTRY3(PSRAD_i,  H,x, U,x, I,b, vex7 mmx avx2_256 p_00_66),
-        {},
-        X86_OP_ENTRY3(PSLLD_i,  H,x, U,x, I,b, vex7 mmx avx2_256 p_00_66),
-        {},
-    };
-
-    int op = (get_modrm(s, env) >> 3) & 7;
-    *entry = opcodes_group13[op];
-}
-
-static void decode_group14(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_group14[8] = {
-        /* grp14 */
-        {},
-        {},
-        X86_OP_ENTRY3(PSRLQ_i,  H,x, U,x, I,b, vex7 mmx avx2_256 p_00_66),
-        X86_OP_ENTRY3(PSRLDQ_i, H,x, U,x, I,b, vex7 avx2_256 p_66),
-        {},
-        {},
-        X86_OP_ENTRY3(PSLLQ_i,  H,x, U,x, I,b, vex7 mmx avx2_256 p_00_66),
-        X86_OP_ENTRY3(PSLLDQ_i, H,x, U,x, I,b, vex7 avx2_256 p_66),
-    };
-
-    int op = (get_modrm(s, env) >> 3) & 7;
-    *entry = opcodes_group14[op];
-}
-
-static void decode_0F6F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F6F[4] = {
-        X86_OP_ENTRY3(MOVDQ,       P,q, None,None, Q,q, vex5 mmx),  /* movq */
-        X86_OP_ENTRY3(MOVDQ,       V,x, None,None, W,x, vex1),      /* movdqa */
-        X86_OP_ENTRY3(MOVDQ,       V,x, None,None, W,x, vex4_unal), /* movdqu */
-        {},
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F6F);
-}
-
-static void decode_0F70(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry pshufw[4] = {
-        X86_OP_ENTRY3(PSHUFW,  P,q, Q,q, I,b, vex4 mmx),
-        X86_OP_ENTRY3(PSHUFD,  V,x, W,x, I,b, vex4 avx2_256),
-        X86_OP_ENTRY3(PSHUFHW, V,x, W,x, I,b, vex4 avx2_256),
-        X86_OP_ENTRY3(PSHUFLW, V,x, W,x, I,b, vex4 avx2_256),
-    };
-
-    *entry = *decode_by_prefix(s, pshufw);
-}
-
-static void decode_0F77(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    if (!(s->prefix & PREFIX_VEX)) {
-        entry->gen = gen_EMMS;
-    } else if (!s->vex_l) {
-        entry->gen = gen_VZEROUPPER;
-        entry->vex_class = 8;
-    } else {
-        entry->gen = gen_VZEROALL;
-        entry->vex_class = 8;
-    }
-}
-
-static void decode_0F78(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F78_f2 =
-        X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A)); /* AMD extension */
-    static const X86OpEntry opcodes_0F78_66 =
-        X86_OP_ENTRY3(EXTRQ_i,       U,x, None,None, I,w,  cpuid(SSE4A)); /* AMD extension */
-
-    entry->gen = NULL;
-    if (s->prefix & PREFIX_REPNZ) {
-        *entry = opcodes_0F78_f2;
-    } else if (s->prefix & PREFIX_REPZ) {
-        /* undefined */
-    } else if (s->prefix & PREFIX_DATA) {
-        int op = (get_modrm(s, env) >> 3) & 7;
-        if (op == 0) {
-            *entry = opcodes_0F78_66;
-        }
-    }
-}
-
-static void decode_0F79(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    entry->gen = NULL;
-    if (s->prefix & PREFIX_REPNZ) {
-        entry->gen = gen_INSERTQ_r; /* AMD extension */
-    } else if (s->prefix & PREFIX_REPZ) {
-        /* undefined */
-    } else if (s->prefix & PREFIX_DATA) {
-        entry->gen = gen_EXTRQ_r; /* AMD extension */
-    };
-}
-
-static void decode_0F7E(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F7E[4] = {
-        X86_OP_ENTRY3(MOVD_from,  E,y, None,None, P,y, vex5 mmx),
-        X86_OP_ENTRY3(MOVD_from,  E,y, None,None, V,y, vex5),
-        X86_OP_ENTRY3(MOVQ,       V,dq,None,None, W,q, vex5),  /* wrong dest Vq on SDM! */
-        {},
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F7E);
-}
-
-static void decode_0F7F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F7F[4] = {
-        X86_OP_ENTRY3(MOVDQ,       W,x, None,None, V,x, vex5 mmx), /* movq */
-        X86_OP_ENTRY3(MOVDQ,       W,x, None,None, V,x, vex1), /* movdqa */
-        X86_OP_ENTRY3(MOVDQ,       W,x, None,None, V,x, vex4_unal), /* movdqu */
-        {},
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F7F);
-}
-
-static void decode_0FB8(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry popcnt =
-        X86_OP_ENTRYwr(POPCNT,    G,v, E,v,  cpuid(POPCNT) zextT0);
-
-    if (s->prefix & PREFIX_REPZ) {
-        *entry = popcnt;
-    } else {
-        memset(entry, 0, sizeof(*entry));
-    }
-}
-
-static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0FBC[4] = {
-        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1),
-        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1), /* 0x66 */
-        X86_OP_ENTRYwr(TZCNT, G,v, E,v, zextT0), /* 0xf3 */
-        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1), /* 0xf2 */
-    };
-    if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
-        *entry = opcodes_0FBC[0];
-    } else {
-        *entry = *decode_by_prefix(s, opcodes_0FBC);
-    }
-}
-
-static void decode_0FBD(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0FBD[4] = {
-        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1),
-        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1), /* 0x66 */
-        X86_OP_ENTRYwr(LZCNT, G,v, E,v, zextT0), /* 0xf3 */
-        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1), /* 0xf2 */
-    };
-    if (!(s->cpuid_ext3_features & CPUID_EXT3_ABM)) {
-        *entry = opcodes_0FBD[0];
-    } else {
-        *entry = *decode_by_prefix(s, opcodes_0FBD);
-    }
-}
-
-static void decode_0FD6(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry movq[4] = {
-        {},
-        X86_OP_ENTRY3(MOVQ,    W,dq, None, None, V,q, vex5),
-        X86_OP_ENTRY3(MOVq_dq, V,dq, None, None, N,q),
-        X86_OP_ENTRY3(MOVq_dq, P,q,  None, None, U,q),
-    };
-
-    *entry = *decode_by_prefix(s, movq);
-}
-
 static const X86OpEntry *decode_run(DisasContext *s, CPUX86State *env,
                                     int map, uint8_t *b);
 
@@ -741,532 +467,28 @@ static void decode_0F3A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     }
 }
 
-/*
- * There are some mistakes in the operands in the manual, and the load/store/register
- * cases are easiest to keep separate, so the entries for 10-17 follow simplicity and
- * efficiency of implementation rather than copying what the manual says.
- *
- * In particular:
- *
- * 1) "VMOVSS m32, xmm1" and "VMOVSD m64, xmm1" do not support VEX.vvvv != 1111b,
- * but this is not mentioned in the tables.
- *
- * 2) MOVHLPS, MOVHPS, MOVHPD, MOVLPD, MOVLPS read the high quadword of one of their
- * operands, which must therefore be dq; MOVLPD and MOVLPS also write the high
- * quadword of the V operand.
- */
-static void decode_0F10(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F10_reg[4] = {
-        X86_OP_ENTRY3(MOVDQ,   V,x,  None,None, W,x, vex4_unal), /* MOVUPS */
-        X86_OP_ENTRY3(MOVDQ,   V,x,  None,None, W,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS,  V,x,  H,x,       W,x, vex5 vex_lig),
-        X86_OP_ENTRY3(VMOVLPx, V,x,  H,x,       W,x, vex5), /* MOVSD */
-    };
-
-    static const X86OpEntry opcodes_0F10_mem[4] = {
-        X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPS */
-        X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex5 vex_lig),
-        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex5 vex_lig),
-    };
-
-    if ((get_modrm(s, env) >> 6) == 3) {
-        *entry = *decode_by_prefix(s, opcodes_0F10_reg);
-    } else {
-        *entry = *decode_by_prefix(s, opcodes_0F10_mem);
-    }
-}
-
-static void decode_0F11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F11_reg[4] = {
-        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4_unal), /* MOVUPS */
-        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS,  W,x,  H,x,       V,x, vex5 vex_lig),
-        X86_OP_ENTRY3(VMOVLPx, W,x,  H,x,       V,q, vex5), /* MOVSD */
-    };
-
-    static const X86OpEntry opcodes_0F11_mem[4] = {
-        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPS */
-        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5 vex_lig),
-        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5 vex_lig), /* MOVSD */
-    };
-
-    if ((get_modrm(s, env) >> 6) == 3) {
-        *entry = *decode_by_prefix(s, opcodes_0F11_reg);
-    } else {
-        *entry = *decode_by_prefix(s, opcodes_0F11_mem);
-    }
-}
-
-static void decode_0F12(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F12_mem[4] = {
-        /*
-         * Use dq for operand for compatibility with gen_MOVSD and
-         * to allow VEX128 only.
-         */
-        X86_OP_ENTRY3(VMOVLPx_ld, V,dq, H,dq,      M,q, vex5), /* MOVLPS */
-        X86_OP_ENTRY3(VMOVLPx_ld, V,dq, H,dq,      M,q, vex5), /* MOVLPD */
-        X86_OP_ENTRY3(VMOVSLDUP,  V,x,  None,None, W,x, vex4 cpuid(SSE3)),
-        X86_OP_ENTRY3(VMOVDDUP,   V,x,  None,None, WM,q, vex5 cpuid(SSE3)), /* qq if VEX.256 */
-    };
-    static const X86OpEntry opcodes_0F12_reg[4] = {
-        X86_OP_ENTRY3(VMOVHLPS,  V,dq, H,dq,       U,dq, vex7),
-        X86_OP_ENTRY3(VMOVLPx,   W,dq, H,dq,       U,q,  vex5), /* MOVLPD */
-        X86_OP_ENTRY3(VMOVSLDUP, V,x,  None,None,  U,x,  vex4 cpuid(SSE3)),
-        X86_OP_ENTRY3(VMOVDDUP,  V,x,  None,None,  U,x,  vex5 cpuid(SSE3)),
-    };
-
-    if ((get_modrm(s, env) >> 6) == 3) {
-        *entry = *decode_by_prefix(s, opcodes_0F12_reg);
-    } else {
-        *entry = *decode_by_prefix(s, opcodes_0F12_mem);
-        if ((s->prefix & PREFIX_REPNZ) && s->vex_l) {
-            entry->s2 = X86_SIZE_qq;
-        }
-    }
-}
-
-static void decode_0F16(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F16_mem[4] = {
-        /*
-         * Operand 1 technically only reads the low 64 bits, but uses dq so that
-         * it is easier to check for op0 == op1 in an endianness-neutral manner.
-         */
-        X86_OP_ENTRY3(VMOVHPx_ld, V,dq, H,dq,      M,q, vex5), /* MOVHPS */
-        X86_OP_ENTRY3(VMOVHPx_ld, V,dq, H,dq,      M,q, vex5), /* MOVHPD */
-        X86_OP_ENTRY3(VMOVSHDUP,  V,x,  None,None, W,x, vex4 cpuid(SSE3)),
-        {},
-    };
-    static const X86OpEntry opcodes_0F16_reg[4] = {
-        /* Same as above, operand 1 could be Hq if it wasn't for big-endian.  */
-        X86_OP_ENTRY3(VMOVLHPS,  V,dq, H,dq,      U,q, vex7),
-        X86_OP_ENTRY3(VMOVHPx,   V,x,  H,x,       U,x, vex5), /* MOVHPD */
-        X86_OP_ENTRY3(VMOVSHDUP, V,x,  None,None, U,x, vex4 cpuid(SSE3)),
-        {},
-    };
-
-    if ((get_modrm(s, env) >> 6) == 3) {
-        *entry = *decode_by_prefix(s, opcodes_0F16_reg);
-    } else {
-        *entry = *decode_by_prefix(s, opcodes_0F16_mem);
-    }
-}
-
-static void decode_0F2A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F2A[4] = {
-        X86_OP_ENTRY3(CVTPI2Px,  V,x,  None,None, Q,q),
-        X86_OP_ENTRY3(CVTPI2Px,  V,x,  None,None, Q,q),
-        X86_OP_ENTRY3(VCVTSI2Sx, V,x,  H,x, E,y,        vex3 vex_lig),
-        X86_OP_ENTRY3(VCVTSI2Sx, V,x,  H,x, E,y,        vex3 vex_lig),
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F2A);
-}
-
-static void decode_0F2B(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F2B[4] = {
-        X86_OP_ENTRY3(MOVDQ,      M,x,  None,None, V,x, vex1), /* MOVNTPS */
-        X86_OP_ENTRY3(MOVDQ,      M,x,  None,None, V,x, vex1), /* MOVNTPD */
-        /* AMD extensions */
-        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex4 cpuid(SSE4A)), /* MOVNTSS */
-        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex4 cpuid(SSE4A)), /* MOVNTSD */
-    };
-
-    *entry = *decode_by_prefix(s, opcodes_0F2B);
-}
-
-static void decode_0F2C(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F2C[4] = {
-        /* Listed as ps/pd in the manual, but CVTTPS2PI only reads 64-bit.  */
-        X86_OP_ENTRY3(CVTTPx2PI,  P,q,  None,None, W,q),
-        X86_OP_ENTRY3(CVTTPx2PI,  P,q,  None,None, W,dq),
-        X86_OP_ENTRY3(VCVTTSx2SI, G,y,  None,None, W,ss, vex3 vex_lig),
-        X86_OP_ENTRY3(VCVTTSx2SI, G,y,  None,None, W,sd, vex3 vex_lig),
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F2C);
-}
-
-static void decode_0F2D(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F2D[4] = {
-        /* Listed as ps/pd in the manual, but CVTPS2PI only reads 64-bit.  */
-        X86_OP_ENTRY3(CVTPx2PI,  P,q,  None,None, W,q),
-        X86_OP_ENTRY3(CVTPx2PI,  P,q,  None,None, W,dq),
-        X86_OP_ENTRY3(VCVTSx2SI, G,y,  None,None, W,ss, vex3 vex_lig),
-        X86_OP_ENTRY3(VCVTSx2SI, G,y,  None,None, W,sd, vex3 vex_lig),
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F2D);
-}
-
-static void decode_VxCOMISx(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    /*
-     * VUCOMISx and VCOMISx are different and use no-prefix and 0x66 for SS and SD
-     * respectively.  Scalar values usually are associated with 0xF2 and 0xF3, for
-     * which X86_VEX_REPScalar exists, but here it has to be decoded by hand.
-     */
-    entry->s1 = entry->s2 = (s->prefix & PREFIX_DATA ? X86_SIZE_sd : X86_SIZE_ss);
-    entry->gen = (*b == 0x2E ? gen_VUCOMI : gen_VCOMI);
-}
-
-static void decode_sse_unary(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    if (!(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ))) {
-        entry->op1 = X86_TYPE_None;
-        entry->s1 = X86_SIZE_None;
-    }
-    switch (*b) {
-    case 0x51: entry->gen = gen_VSQRT; break;
-    case 0x52: entry->gen = gen_VRSQRT; break;
-    case 0x53: entry->gen = gen_VRCP; break;
-    }
-}
-
-static void decode_0F5A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F5A[4] = {
-        X86_OP_ENTRY2(VCVTPS2PD,  V,x,       W,xh, vex2),      /* VCVTPS2PD */
-        X86_OP_ENTRY2(VCVTPD2PS,  V,x,       W,x,  vex2),      /* VCVTPD2PS */
-        X86_OP_ENTRY3(VCVTSS2SD,  V,x,  H,x, W,x,  vex2_rep3), /* VCVTSS2SD */
-        X86_OP_ENTRY3(VCVTSD2SS,  V,x,  H,x, W,x,  vex2_rep3), /* VCVTSD2SS */
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F5A);
-}
-
-static void decode_0F5B(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0F5B[4] = {
-        X86_OP_ENTRY2(VCVTDQ2PS,   V,x, W,x,      vex2),
-        X86_OP_ENTRY2(VCVTPS2DQ,   V,x, W,x,      vex2),
-        X86_OP_ENTRY2(VCVTTPS2DQ,  V,x, W,x,      vex2),
-        {},
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F5B);
-}
-
-static void decode_0FE6(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_0FE6[4] = {
-        {},
-        X86_OP_ENTRY2(VCVTTPD2DQ,  V,x, W,x,      vex2),
-        X86_OP_ENTRY2(VCVTDQ2PD,   V,x, W,x,      vex5),
-        X86_OP_ENTRY2(VCVTPD2DQ,   V,x, W,x,      vex2),
-    };
-    *entry = *decode_by_prefix(s, opcodes_0FE6);
-}
-
-/*
- * These ignore the mod bits (assume (modrm&0xc0)==0xc0), so group the
- * pre-decode tweak here for all MOVs from/to CR and DR.
- *
- * AMD documentation (24594.pdf) and testing of Intel 386 and 486
- * processors all show that the mod bits are assumed to be 1's,
- * regardless of actual values.
- */
-static void decode_MOV_CR_DR(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    /*
-     */
-    get_modrm(s, env);
-    s->modrm |= 0xC0;
-
-    entry->gen = gen_MOV;
-}
-
-static const X86OpEntry opcodes_0F[256] = {
-    [0x00] = X86_OP_ENTRY1(multi0F,     nop,v,                nolea), /* unconverted */
-    [0x01] = X86_OP_ENTRY1(multi0F,     nop,v,                nolea), /* unconverted */
-    [0x02] = X86_OP_ENTRYwr(LAR,        G,v, E,w,             chk(prot)),
-    [0x03] = X86_OP_ENTRYwr(LSL,        G,v, E,w,             chk(prot)),
-    [0x05] = X86_OP_ENTRY0(SYSCALL,                           chk(o64_intel)),
-    [0x06] = X86_OP_ENTRY0(CLTS,                              chk(cpl0) svm(WRITE_CR0)),
-    [0x07] = X86_OP_ENTRY0(SYSRET,                            chk3(o64_intel, prot, cpl0)),
-
-    [0x10] = X86_OP_GROUP0(0F10),
-    [0x11] = X86_OP_GROUP0(0F11),
-    [0x12] = X86_OP_GROUP0(0F12),
-    [0x13] = X86_OP_ENTRY3(VMOVLPx_st,  M,q, None,None, V,q,  vex5 p_00_66),
-    [0x14] = X86_OP_ENTRY3(VUNPCKLPx,   V,x, H,x, W,x,        vex4 p_00_66),
-    [0x15] = X86_OP_ENTRY3(VUNPCKHPx,   V,x, H,x, W,x,        vex4 p_00_66),
-    [0x16] = X86_OP_GROUP0(0F16),
-    /* Incorrectly listed as Mq,Vq in the manual */
-    [0x17] = X86_OP_ENTRY3(VMOVHPx_st,  M,q, None,None, V,dq, vex5 p_00_66),
-
-    /*
-     * Incorrectly listed as using "d" operand type in the manual.  In reality
-     * there's no 16-bit version (like y) and it does not use REX.W (like d64).
-     */
-    [0x20] = X86_OP_GROUPwr(MOV_CR_DR,   R,y_d64, C,y_d64, chk(cpl0) svm(READ_CR0)),
-    [0x21] = X86_OP_GROUPwr(MOV_CR_DR,   R,y_d64, D,y_d64, chk(cpl0) svm(READ_DR0)),
-    [0x22] = X86_OP_GROUPwr(MOV_CR_DR,   C,y_d64, R,y_d64, zextT0 chk(cpl0) svm(WRITE_CR0)),
-    [0x23] = X86_OP_GROUPwr(MOV_CR_DR,   D,y_d64, R,y_d64, zextT0 chk(cpl0) svm(WRITE_DR0)),
-
-    [0x30] = X86_OP_ENTRY0(WRMSR,                             chk(cpl0)),
-    [0x31] = X86_OP_ENTRY0(RDTSC),
-    [0x32] = X86_OP_ENTRY0(RDMSR,                             chk(cpl0)),
-    [0x33] = X86_OP_ENTRY0(RDPMC),
-    [0x34] = X86_OP_ENTRY0(SYSENTER,                          chk2(i64_amd, prot_or_vm86)),
-    [0x35] = X86_OP_ENTRY0(SYSEXIT,                           chk3(i64_amd, prot, cpl0)),
-
-    [0x40] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x41] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x42] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x43] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x44] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x45] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x46] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x47] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-
-    [0x50] = X86_OP_ENTRY3(MOVMSK,     G,y, None,None, U,x, vex7 p_00_66),
-    [0x51] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2), /* sqrtps */
-    [0x52] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex4_rep5 p_00_f3), /* rsqrtps */
-    [0x53] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex4_rep5 p_00_f3), /* rcpps */
-    [0x54] = X86_OP_ENTRY3(PAND,       V,x, H,x, W,x,  vex4 p_00_66), /* vand */
-    [0x55] = X86_OP_ENTRY3(PANDN,      V,x, H,x, W,x,  vex4 p_00_66), /* vandn */
-    [0x56] = X86_OP_ENTRY3(POR,        V,x, H,x, W,x,  vex4 p_00_66), /* vor */
-    [0x57] = X86_OP_ENTRY3(PXOR,       V,x, H,x, W,x,  vex4 p_00_66), /* vxor */
-
-    [0x60] = X86_OP_ENTRY3(PUNPCKLBW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x61] = X86_OP_ENTRY3(PUNPCKLWD,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x62] = X86_OP_ENTRY3(PUNPCKLDQ,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x63] = X86_OP_ENTRY3(PACKSSWB,   V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x64] = X86_OP_ENTRY3(PCMPGTB,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x65] = X86_OP_ENTRY3(PCMPGTW,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x66] = X86_OP_ENTRY3(PCMPGTD,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x67] = X86_OP_ENTRY3(PACKUSWB,   V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-
-    [0x70] = X86_OP_GROUP0(0F70),
-    [0x71] = X86_OP_GROUP0(group12),
-    [0x72] = X86_OP_GROUP0(group13),
-    [0x73] = X86_OP_GROUP0(group14),
-    [0x74] = X86_OP_ENTRY3(PCMPEQB,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x75] = X86_OP_ENTRY3(PCMPEQW,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x76] = X86_OP_ENTRY3(PCMPEQD,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x77] = X86_OP_GROUP0(0F77),
-
-    [0x80] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x81] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x82] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x83] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x84] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x85] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x86] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x87] = X86_OP_ENTRYr(Jcc, J,z_f64),
-
-    [0x90] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x91] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x92] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x93] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x94] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x95] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x96] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x97] = X86_OP_ENTRYw(SETcc, E,b),
-
-    [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
-    [0xa1] = X86_OP_ENTRYw(POP, FS, w),
-    [0xa2] = X86_OP_ENTRY0(CPUID),
-    [0xa3] = X86_OP_ENTRYrr(BT,   E,v, G,v,          btEvGv),
-    [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
-    [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
-
-    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock zextT1),
-    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock zextT1),
-    [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
-    [0xb3] = X86_OP_ENTRY2(BTR,    E,v, G,v,             btEvGv),
-    [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
-    [0xb5] = X86_OP_ENTRY3(LGS,    G,v, EM,p, None, None),
-    [0xb6] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, zextT0), /* MOVZX */
-    [0xb7] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, zextT0), /* MOVZX */
-
-    [0xc0] = X86_OP_ENTRY2(XADD,       E,b, G,b,            lock),
-    [0xc1] = X86_OP_ENTRY2(XADD,       E,v, G,v,            lock),
-    [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
-    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2) p_00), /* MOVNTI */
-    [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
-    [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
-    [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
-    [0xc7] = X86_OP_GROUP0(group9),
-
-    [0xd0] = X86_OP_ENTRY3(VADDSUB,   V,x, H,x, W,x,        vex2 cpuid(SSE3) p_66_f2),
-    [0xd1] = X86_OP_ENTRY3(PSRLW_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd2] = X86_OP_ENTRY3(PSRLD_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd3] = X86_OP_ENTRY3(PSRLQ_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd4] = X86_OP_ENTRY3(PADDQ,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd5] = X86_OP_ENTRY3(PMULLW,    V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd6] = X86_OP_GROUP0(0FD6),
-    [0xd7] = X86_OP_ENTRY3(PMOVMSKB,  G,d, None,None, U,x,  vex7 mmx avx2_256 p_00_66),
-
-    [0xe0] = X86_OP_ENTRY3(PAVGB,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xe1] = X86_OP_ENTRY3(PSRAW_r,   V,x, H,x, W,x,        vex7 mmx avx2_256 p_00_66),
-    [0xe2] = X86_OP_ENTRY3(PSRAD_r,   V,x, H,x, W,x,        vex7 mmx avx2_256 p_00_66),
-    [0xe3] = X86_OP_ENTRY3(PAVGW,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xe4] = X86_OP_ENTRY3(PMULHUW,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xe5] = X86_OP_ENTRY3(PMULHW,    V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xe6] = X86_OP_GROUP0(0FE6),
-    [0xe7] = X86_OP_ENTRY3(MOVDQ,     W,x, None,None, V,x,  vex1 mmx p_00_66), /* MOVNTQ/MOVNTDQ */
-
-    [0xf0] = X86_OP_ENTRY3(MOVDQ,    V,x, None,None, WM,x,  vex4_unal cpuid(SSE3) p_f2), /* LDDQU */
-    [0xf1] = X86_OP_ENTRY3(PSLLW_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
-    [0xf2] = X86_OP_ENTRY3(PSLLD_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
-    [0xf3] = X86_OP_ENTRY3(PSLLQ_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
-    [0xf4] = X86_OP_ENTRY3(PMULUDQ,  V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
-    [0xf5] = X86_OP_ENTRY3(PMADDWD,  V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
-    [0xf6] = X86_OP_ENTRY3(PSADBW,   V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
-    [0xf7] = X86_OP_ENTRY3(MASKMOV,  None,None, V,dq, U,dq, vex4_unal avx2_256 mmx p_00_66),
-
-    [0x08] = X86_OP_ENTRY0(NOP,           svm(INVD)),
-    [0x09] = X86_OP_ENTRY0(NOP,           svm(WBINVD)),
-    [0x0b] = X86_OP_ENTRY0(UD),           /* UD2 */
-    [0x0d] = X86_OP_ENTRY1(NOP,  M,v),    /* 3DNow! prefetch */
-    [0x0e] = X86_OP_ENTRY0(EMMS,                              cpuid(3DNOW)), /* femms */
-    /*
-     * 3DNow!'s opcode byte comes *after* modrm and displacements, making it
-     * more like an Ib operand.  Dispatch to the right helper in a single gen_*
-     * function.
-     */
-    [0x0f] = X86_OP_ENTRY3(3dnow,       P,q, Q,q, I,b,        cpuid(3DNOW)),
-
-    [0x18] = X86_OP_ENTRY1(NOP,  nop,v),  /* prefetch/reserved NOP */
-    [0x19] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
-    [0x1a] = X86_OP_ENTRY1(multi0F, nop,v, nolea),  /* unconverted MPX */
-    [0x1b] = X86_OP_ENTRY1(multi0F, nop,v, nolea),  /* unconverted MPX */
-    [0x1c] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
-    [0x1d] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
-    [0x1e] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
-    [0x1f] = X86_OP_ENTRY1(NOP,  nop,v),  /* NOP/reserved NOP */
-
-    [0x28] = X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x, vex1 p_00_66), /* MOVAPS */
-    [0x29] = X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex1 p_00_66), /* MOVAPS */
-    [0x2A] = X86_OP_GROUP0(0F2A),
-    [0x2B] = X86_OP_GROUP0(0F2B),
-    [0x2C] = X86_OP_GROUP0(0F2C),
-    [0x2D] = X86_OP_GROUP0(0F2D),
-    [0x2E] = X86_OP_GROUP3(VxCOMISx,   None,None, V,x, W,x,  vex3 vex_lig p_00_66), /* VUCOMISS/SD */
-    [0x2F] = X86_OP_GROUP3(VxCOMISx,   None,None, V,x, W,x,  vex3 vex_lig p_00_66), /* VCOMISS/SD */
-
-    [0x38] = X86_OP_GROUP0(0F38),
-    [0x3a] = X86_OP_GROUP0(0F3A),
-
-    [0x48] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x49] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x4a] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x4b] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x4c] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x4d] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x4e] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-    [0x4f] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
-
-    [0x58] = X86_OP_ENTRY3(VADD,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-    [0x59] = X86_OP_ENTRY3(VMUL,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-    [0x5a] = X86_OP_GROUP0(0F5A),
-    [0x5b] = X86_OP_GROUP0(0F5B),
-    [0x5c] = X86_OP_ENTRY3(VSUB,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-    [0x5d] = X86_OP_ENTRY3(VMIN,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-    [0x5e] = X86_OP_ENTRY3(VDIV,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-    [0x5f] = X86_OP_ENTRY3(VMAX,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-
-    [0x68] = X86_OP_ENTRY3(PUNPCKHBW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x69] = X86_OP_ENTRY3(PUNPCKHWD,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x6a] = X86_OP_ENTRY3(PUNPCKHDQ,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x6b] = X86_OP_ENTRY3(PACKSSDW,   V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0x6c] = X86_OP_ENTRY3(PUNPCKLQDQ, V,x, H,x, W,x,  vex4 p_66 avx2_256),
-    [0x6d] = X86_OP_ENTRY3(PUNPCKHQDQ, V,x, H,x, W,x,  vex4 p_66 avx2_256),
-    [0x6e] = X86_OP_ENTRY3(MOVD_to,    V,dq,None,None, E,y, vex5 mmx p_00_66),  /* wrong dest Vy on SDM! */
-    [0x6f] = X86_OP_GROUP0(0F6F),
-
-    [0x78] = X86_OP_GROUP0(0F78),
-    [0x79] = X86_OP_GROUP2(0F79,       V,x, U,x,       cpuid(SSE4A)),
-    [0x7c] = X86_OP_ENTRY3(VHADD,      V,x, H,x, W,x,  vex2 cpuid(SSE3) p_66_f2),
-    [0x7d] = X86_OP_ENTRY3(VHSUB,      V,x, H,x, W,x,  vex2 cpuid(SSE3) p_66_f2),
-    [0x7e] = X86_OP_GROUP0(0F7E),
-    [0x7f] = X86_OP_GROUP0(0F7F),
-
-    [0x88] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x89] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x8a] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x8b] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x8c] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x8d] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x8e] = X86_OP_ENTRYr(Jcc, J,z_f64),
-    [0x8f] = X86_OP_ENTRYr(Jcc, J,z_f64),
-
-    [0x98] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x99] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x9a] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x9b] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x9c] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x9d] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x9e] = X86_OP_ENTRYw(SETcc, E,b),
-    [0x9f] = X86_OP_ENTRYw(SETcc, E,b),
-
-    [0xa8] = X86_OP_ENTRYr(PUSH,   GS, w),
-    [0xa9] = X86_OP_ENTRYw(POP,    GS, w),
-    [0xaa] = X86_OP_ENTRY0(RSM,             chk(smm) svm(RSM)),
-    [0xab] = X86_OP_ENTRY2(BTS,    E,v, G,v,             btEvGv),
-    [0xac] = X86_OP_ENTRY4(SHRD,   E,v, 2op,v, G,v),
-    [0xad] = X86_OP_ENTRY3(SHRD,   E,v, 2op,v, G,v),
-    [0xae] = X86_OP_GROUP0(group15),
-    [0xaf] = X86_OP_ENTRY2(IMUL3,  G,v, E,v, sextT0 sextT1),
-
-    [0xb8] = X86_OP_GROUP0(0FB8),
-    /* decoded as modrm, which is visible as a difference between page fault and #UD */
-    [0xb9] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD1 */
-    [0xba] = X86_OP_GROUP2(group8, E,v, I,b),
-    [0xbb] = X86_OP_ENTRY2(BTC,    E,v, G,v,             btEvGv),
-    [0xbc] = X86_OP_GROUP0(0FBC),
-    [0xbd] = X86_OP_GROUP0(0FBD),
-    [0xbe] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, sextT0), /* MOVSX */
-    [0xbf] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, sextT0), /* MOVSX */
-
-    [0xc8] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
-    [0xc9] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
-    [0xca] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
-    [0xcb] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
-    [0xcc] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
-    [0xcd] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
-    [0xce] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
-    [0xcf] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
-
-    /* Incorrectly missing from 2-17 */
-    [0xd8] = X86_OP_ENTRY3(PSUBUSB,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xd9] = X86_OP_ENTRY3(PSUBUSW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xda] = X86_OP_ENTRY3(PMINUB,   V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xdb] = X86_OP_ENTRY3(PAND,     V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xdc] = X86_OP_ENTRY3(PADDUSB,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xdd] = X86_OP_ENTRY3(PADDUSW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xde] = X86_OP_ENTRY3(PMAXUB,   V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xdf] = X86_OP_ENTRY3(PANDN,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-
-    [0xe8] = X86_OP_ENTRY3(PSUBSB,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xe9] = X86_OP_ENTRY3(PSUBSW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xea] = X86_OP_ENTRY3(PMINSW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xeb] = X86_OP_ENTRY3(POR,     V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xec] = X86_OP_ENTRY3(PADDSB,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xed] = X86_OP_ENTRY3(PADDSW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xee] = X86_OP_ENTRY3(PMAXSW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xef] = X86_OP_ENTRY3(PXOR,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-
-    [0xf8] = X86_OP_ENTRY3(PSUBB,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xf9] = X86_OP_ENTRY3(PSUBW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xfa] = X86_OP_ENTRY3(PSUBD,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xfb] = X86_OP_ENTRY3(PSUBQ,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xfc] = X86_OP_ENTRY3(PADDB,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xfd] = X86_OP_ENTRY3(PADDW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xfe] = X86_OP_ENTRY3(PADDD,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-    [0xff] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD0 */
-};
-
 static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
+    const X86OpEntry *row;
+
     *b = x86_ldub_code(env, s);
-    *entry = opcodes_0F[*b];
+
+    /*
+     * The VEX and EVEX maps 2 and 3 are selected by the prefix,
+     * and 0x38/0x3A are in the areas where REX2 differs from
+     * legacy encoding.
+     */
+    if (!(s->prefix & (PREFIX_REX2 | PREFIX_VEX | PREFIX_EVEX))) {
+        if (*b == 0x38) {
+            decode_0F38(s, env, entry, b);
+            return;
+        } else if (*b == 0x3a) {
+            decode_0F3A(s, env, entry, b);
+            return;
+        }
+    }
+    row = decode_run(s, env, 1, b);
+    *entry = row ? *row : UNKNOWN_OPCODE;
 }
 
 static void decode_grp_xchg_ax(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
@@ -1287,37 +509,6 @@ static void decode_grp_xchg_ax(DisasContext *s, CPUX86State *env, X86OpEntry *en
 }
 
 #ifdef TARGET_X86_64
-static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
-                        const X86OpEntry **map)
-{
-    const X86OpEntry *group = map[*b >> 4];
-    *entry = group ? group[*b & 15] : UNKNOWN_OPCODE;
-}
-
-static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry *opcode_rex2_map1[16] = {
-        &opcodes_0F[0x00],
-        &opcodes_0F[0x10],
-        &opcodes_0F[0x20],
-        NULL,
-        &opcodes_0F[0x40],
-        &opcodes_0F[0x50],
-        &opcodes_0F[0x60],
-        &opcodes_0F[0x70],
-        NULL,
-        &opcodes_0F[0x90],
-        &opcodes_0F[0xA0],
-        &opcodes_0F[0xB0],
-        &opcodes_0F[0xC0],
-        &opcodes_0F[0xD0],
-        &opcodes_0F[0xE0],
-        &opcodes_0F[0xF0],
-    };
-    *b = x86_ldub_code(env, s);
-    decode_REX2(s, env, entry, b, opcode_rex2_map1);
-}
-
 static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     const X86OpEntry *row;
@@ -2145,6 +1336,8 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
 
     case X86_FEAT_3DNOW:
         return (s->cpuid_ext2_features & CPUID_EXT2_3DNOW);
+    case X86_FEAT_ABM:
+        return (s->cpuid_ext3_features & CPUID_EXT3_ABM);
     case X86_FEAT_SSE4A:
         return (s->cpuid_ext3_features & CPUID_EXT3_SSE4A);
 
@@ -2565,7 +1758,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             /* Leave b consistent with the non-REX2 encoding.  */
             if (rex2 & 0x80) {
                 b = 0x0f;
-                decode_func = decode_REX2_map1;
+                decode_func = decode_0F;
             } else {
                 b = x86_ldub_code(env, s);
                 decode_func = decode_root;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 10e64576cb9..ff94ebf6365 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1617,12 +1617,14 @@ static void gen_CLI(DisasContext *s, X86DecodedInsn *decode)
     gen_reset_eflags(s, IF_MASK);
 }
 
+#ifndef CONFIG_USER_ONLY
 static void gen_CLTS(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_clts(tcg_env);
     /* abort block because static cpu state changed */
     s->base.is_jmp = DISAS_EOB_NEXT;
 }
+#endif
 
 static void gen_CMC(DisasContext *s, X86DecodedInsn *decode)
 {
@@ -1977,9 +1979,9 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_sub_tl(decode->cc_dst, cmpv, oldv);
 }
 
+#ifdef TARGET_X86_64
 static void gen_CMPXCHG16B(DisasContext *s, X86DecodedInsn *decode)
 {
-#ifdef TARGET_X86_64
     MemOp mop = MO_LE | MO_128 | MO_ALIGN;
     TCGv_i64 t0, t1;
     TCGv_i128 cmp, val;
@@ -2017,10 +2019,8 @@ static void gen_CMPXCHG16B(DisasContext *s, X86DecodedInsn *decode)
      */
     tcg_gen_mov_i64(cpu_regs[R_EAX], s->T0);
     tcg_gen_mov_i64(cpu_regs[R_EDX], s->T1);
-#else
-    abort();
-#endif
 }
+#endif
 
 static void gen_CMPXCHG8B(DisasContext *s, X86DecodedInsn *decode)
 {
@@ -3772,8 +3772,6 @@ static void gen_RDMSR(DisasContext *s, X86DecodedInsn *decode)
     gen_helper_rdmsr(tcg_env);
     s->base.is_jmp = DISAS_EOB_NEXT;
 }
-#else
-#define gen_RDMSR gen_unreachable
 #endif
 
 static void gen_RDPMC(DisasContext *s, X86DecodedInsn *decode)
@@ -3793,6 +3791,7 @@ static void gen_RDTSC(DisasContext *s, X86DecodedInsn *decode)
     gen_helper_rdtsc(tcg_env);
 }
 
+#ifdef TARGET_X86_64
 static void gen_RDxxBASE(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv base = cpu_seg_base[s->modrm & 8 ? R_GS : R_FS];
@@ -3801,6 +3800,7 @@ static void gen_RDxxBASE(DisasContext *s, X86DecodedInsn *decode)
     gen_helper_cr4_testbit(tcg_env, tcg_constant_i32(CR4_FSGSBASE_MASK));
     tcg_gen_mov_tl(s->T0, base);
 }
+#endif
 
 static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 {
@@ -3976,8 +3976,6 @@ static void gen_RSM(DisasContext *s, X86DecodedInsn *decode)
     assume_cc_op(s, CC_OP_EFLAGS);
     s->base.is_jmp = DISAS_EOB_ONLY;
 }
-#else
-#define gen_RSM gen_UD
 #endif
 
 static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
@@ -4363,6 +4361,7 @@ static void gen_SYSENTER(DisasContext *s, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_EOB_ONLY;
 }
 
+#ifndef CONFIG_USER_ONLY
 static void gen_SYSEXIT(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_sysexit(tcg_env, tcg_constant_i32(s->dflag - 1));
@@ -4384,6 +4383,7 @@ static void gen_SYSRET(DisasContext *s, X86DecodedInsn *decode)
      */
     s->base.is_jmp = DISAS_EOB_RECHECK_TF;
 }
+#endif
 
 static void gen_TEST(DisasContext *s, X86DecodedInsn *decode)
 {
@@ -4950,10 +4950,9 @@ static void gen_WRMSR(DisasContext *s, X86DecodedInsn *decode)
     gen_helper_wrmsr(tcg_env);
     s->base.is_jmp = DISAS_EOB_NEXT;
 }
-#else
-#define gen_WRMSR gen_unreachable
 #endif
 
+#ifdef TARGET_X86_64
 static void gen_WRxxBASE(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv base = cpu_seg_base[s->modrm & 8 ? R_GS : R_FS];
@@ -4962,6 +4961,7 @@ static void gen_WRxxBASE(DisasContext *s, X86DecodedInsn *decode)
     gen_helper_cr4_testbit(tcg_env, tcg_constant_i32(CR4_FSGSBASE_MASK));
     tcg_gen_mov_tl(base, s->T0);
 }
+#endif
 
 static void gen_XADD(DisasContext *s, X86DecodedInsn *decode)
 {
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index 65b69a3016d..7588484a9bd 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -512,6 +512,345 @@ FF /6                       PUSH     Ed64(r)
 REX2.NP.W0 A1                   JMP_m         Iq                 chk(no_adr)   // JMPABS
 
 
+// 0F
+// --
+
+0F 00                         multi0F       Ev(nop)                   nolea
+0F 01                         multi0F       Ev(nop)                   nolea
+0F 02                         LAR           Gv(w),Ew                  chk(prot)
+0F 03                         LSL           Gv(w),Ew                  chk(prot)
+0F 05                         SYSCALL                                 chk(o64_intel)
+0F 06                         CLTS                                    chk(cpl0) svm(WRITE_CR0)
+0F 07                         SYSRET                                  chk(o64_intel, prot, cpl0)
+
+0F 08                         NOP                                     svm(INVD)
+0F 09                         NOP                                     svm(WBINVD)
+0F 0B                         UD                                      // UD2
+// 3DNow! prefetch
+0F 0D                         NOP           Mv
+0F 0E                         EMMS                                    cpuid(3DNOW)   // femms
+// 3DNow!'s opcode byte comes *after* modrm and displacements, making it
+// more like an Ib operand.  Dispatch to the right helper in a single gen_*
+// function.
+0F 0F                         3dnow         Pq,Qq,Ib                  cpuid(3DNOW)
+
+// Opcodes 10 to 12 and 16 are split by prefix and by register or memory operand.
+//
+// There are some mistakes in the operands in the manual, and the load/store/register
+// cases are easiest to keep separate, so the entries for 10-17 follow simplicity and
+// efficiency of implementation rather than copying what the manual says.
+//
+// In particular:
+//
+// 1) "VMOVSS m32, xmm1" and "VMOVSD m64, xmm1" do not support VEX.vvvv != 1111b,
+// but this is not mentioned in the tables.
+//
+// 2) MOVHLPS, MOVHPS, MOVHPD, MOVLPD, MOVLPS read the high quadword of one of their
+// operands, which must therefore be dq; MOVLPD and MOVLPS also write the high
+// quadword of the V operand.
+SSE|VEX.NP|66.0F 10           MOVDQ         Vx(w),Wx(op2)             E4(unaligned)  // MOVUPS, MOVUPD
+SSE|VEX.F3.LIG.0F 10          VMOVSS        Vx,Hx,Ux                  E5
+SSE|VEX.F3.LIG.0F 10          VMOVSS_ld     Vx,Hx,Mss                 E5
+SSE|VEX.F2.LIG.0F 10          VMOVLPx       Vx,Hx,Ux                  E5             // MOVSD
+SSE|VEX.F2.LIG.0F 10          VMOVSD_ld     Vx,Hx,Msd                 E5
+SSE|VEX.NP|66.0F 11           MOVDQ         Wx(w),Vx(op2)             E4(unaligned)  // MOVUPS, MOVUPD
+SSE|VEX.F3.LIG.0F 11          VMOVSS        Ux,Hx,Vx                  E5
+SSE|VEX.F3.LIG.0F 11          VMOVSS_st     Mss(w),Vx(op2)            E5
+SSE|VEX.F2.LIG.0F 11          VMOVLPx       Ux,Hx,Vq                  E5  // MOVSD
+SSE|VEX.F2.LIG.0F 11          VMOVLPx_st    Msd(w),Vx(op2)            E5
+// Use dq for operand for compatibility with gen_MOVSD and to allow VEX128 only.
+SSE|VEX.NP|66.0F 12           VMOVLPx_ld    Vdq,Hdq,Mq                E5  // MOVLPS, MOVLPD
+SSE|VEX.F3.0F 12              VMOVSLDUP     Vx(w),Wx(op2)             E4 cpuid(SSE3)
+// The memory operand of MOVDDUP is qq if VEX.L is set.
+SSE|VEX.F2.L0.0F 12           VMOVDDUP      Vx(w),Wq(m,op2)           E5 cpuid(SSE3)
+VEX.F2.L1.0F 12               VMOVDDUP      Vx(w),Wqq(m,op2)          E5 cpuid(SSE3)
+SSE|VEX.F2.0F 12              VMOVDDUP      Vx(w),Ux(op2)             E5 cpuid(SSE3)
+SSE|VEX.NP.0F 12              VMOVHLPS      Vdq,Hdq,Udq               E7
+SSE|VEX.66.0F 12              VMOVLPx       Udq,Hdq,Uq                E5  // MOVLPD
+SSE|VEX.NP|66.0F 13           VMOVLPx_st    Mq(w),Vq(op2)             E5
+SSE|VEX.NP|66.0F 14           VUNPCKLPx     Vx,Hx,Wx                  E4
+SSE|VEX.NP|66.0F 15           VUNPCKHPx     Vx,Hx,Wx                  E4
+// Operand 1 technically only reads the low 64 bits, but uses dq so that it is easier
+// to check for op0 == op1 in an endianness-neutral manner.
+SSE|VEX.NP|66.0F 16           VMOVHPx_ld    Vdq,Hdq,Mq                E5  // MOVHPS, MOVHPD
+SSE|VEX.F3.0F 16              VMOVSHDUP     Vx(w),Wx(op2)             E4 cpuid(SSE3)
+// Same as above, operand 1 could be Hq if it was not for big-endian.
+SSE|VEX.NP.0F 16              VMOVLHPS      Vdq,Hdq,Uq                E7
+SSE|VEX.66.0F 16              VMOVHPx       Vx,Hx,Ux                  E5  // MOVHPD
+// Incorrectly listed as Mq,Vq in the manual
+SSE|VEX.NP|66.0F 17           VMOVHPx_st    Mq(w),Vdq(op2)            E5
+
+//.0F 18 to 1F are NOPs (including reserved NOPs and prefetches), except for MPX.
+0F 18..19                     NOP           Ev(nop)
+0F 1A..1B                     multi0F       Ev(nop)                   nolea  // unconverted MPX
+0F 1C..1F                     NOP           Ev(nop)
+
+// Incorrectly listed as using "d" operand type in the manual.  In reality
+// there is no 16-bit version (like y) and it does not use REX.W (like d64).
+// The mod bits are ignored and assumed to be 11b on all processors.
+0F 20                         MOV           Ry_d64(w),Cy_d64          ignore_mod chk(cpl0) svm(READ_CR0)
+0F 21                         MOV           Ry_d64(w),Dy_d64          ignore_mod chk(cpl0) svm(READ_DR0)
+0F 22                         MOV           Cy_d64(w),Ry_d64(zx)      ignore_mod chk(cpl0) svm(WRITE_CR0)
+0F 23                         MOV           Dy_d64(w),Ry_d64(zx)      ignore_mod chk(cpl0) svm(WRITE_DR0)
+
+SSE|VEX.NP|66.0F 28           MOVDQ         Vx(w),Wx(op2)             E1     // MOVAPS, MOVAPD
+SSE|VEX.NP|66.0F 29           MOVDQ         Wx(w),Vx(op2)             E1     // MOVAPS, MOVAPD
+NP|66.0F 2A                   CVTPI2Px      Vx(w),Qq(op2)
+SSE|VEX.F3|F2.0F.LIG 2A       VCVTSI2Sx     Vx,Hx,Ey                  E3
+SSE|VEX.NP|66.0F 2B           MOVDQ         Mx(w),Vx(op2)             E1     // MOVNTPS, MOVNTPD
+// AMD extensions
+SSE|VEX.F3.0F 2B              VMOVSS_st     Mss(w),Vx(op2)            E4 cpuid(SSE4A)   // MOVNTSS
+SSE|VEX.F2.0F 2B              VMOVLPx_st    Msd(w),Vx(op2)            E4 cpuid(SSE4A)   // MOVNTSD
+// CVTTPS2PI and CVTPS2PI are listed as ps/pd in the manual, but they only read 64 bits.
+NP.0F 2C                      CVTTPx2PI     Pq(w),Wq(op2)
+66.0F 2C                      CVTTPx2PI     Pq(w),Wdq(op2)
+SSE|VEX.F3.LIG.0F 2C          VCVTTSx2SI    Gy(w),Wss(op2)            E3
+SSE|VEX.F2.LIG.0F 2C          VCVTTSx2SI    Gy(w),Wsd(op2)            E3
+NP.0F 2D                      CVTPx2PI      Pq(w),Wq(op2)
+66.0F 2D                      CVTPx2PI      Pq(w),Wdq(op2)
+SSE|VEX.F3.LIG.0F 2D          VCVTSx2SI     Gy(w),Wss(op2)            E3
+SSE|VEX.F2.LIG.0F 2D          VCVTSx2SI     Gy(w),Wsd(op2)            E3
+// VUCOMISx and VCOMISx are different and use no-prefix and 0x66 for SS and SD
+// respectively.  Scalar values are usually associated with 0xF2 and 0xF3, for
+// which E2(rep-scalar) exists, but here they are listed one by one.
+SSE|VEX.NP.LIG.0F 2E          VUCOMI        Vss(r),Wss                E3
+SSE|VEX.66.LIG.0F 2E          VUCOMI        Vsd(r),Wsd                E3
+SSE|VEX.NP.LIG.0F 2F          VCOMI         Vss(r),Wss                E3
+SSE|VEX.66.LIG.0F 2F          VCOMI         Vsd(r),Wsd                E3
+
+0F 30                         WRMSR                                   chk(cpl0)
+0F 31                         RDTSC
+0F 32                         RDMSR                                   chk(cpl0)
+0F 33                         RDPMC
+0F 34                         SYSENTER                                chk(i64_amd, prot_or_vm86)
+0F 35                         SYSEXIT                                 chk(i64_amd, prot, cpl0)
+
+0F 40..4F                     CMOVcc        Gv,Ev                     cpuid(CMOV)
+
+SSE|VEX.NP|66.0F 50           MOVMSK        Gy(w),Ux(op2)             E7
+SSE|VEX.NP|66.0F 51           VSQRT         Vx(w),Wx(op2)             E2
+SSE|VEX.F3|F2.0F 51           VSQRT         Vx,Hx,Wx                  E2(rep-scalar)
+SSE|VEX.NP.0F 52              VRSQRT        Vx(w),Wx(op2)             E4
+SSE|VEX.F3.0F 52              VRSQRT        Vx,Hx,Wx                  E4(rep-scalar)
+SSE|VEX.NP.0F 53              VRCP          Vx(w),Wx(op2)             E4
+SSE|VEX.F3.0F 53              VRCP          Vx,Hx,Wx                  E4(rep-scalar)
+SSE|VEX.NP|66.0F 54           PAND          Vx,Hx,Wx                  E4     // ANDPS, ANDPD
+SSE|VEX.NP|66.0F 55           PANDN         Vx,Hx,Wx                  E4    // ANDNPS, ANDNPD
+SSE|VEX.NP|66.0F 56           POR           Vx,Hx,Wx                  E4     // ORPS, ORPD
+SSE|VEX.NP|66.0F 57           PXOR          Vx,Hx,Wx                  E4    // XORPS, XORPD
+SSE|VEX.NP|66|F3|F2.0F 58     VADD          Vx,Hx,Wx                  E2(rep-scalar)
+SSE|VEX.NP|66|F3|F2.0F 59     VMUL          Vx,Hx,Wx                  E2(rep-scalar)
+SSE|VEX.NP.0F 5A              VCVTPS2PD     Vx,Wxh                    E2
+SSE|VEX.66.0F 5A              VCVTPD2PS     Vx,Wx                     E2
+SSE|VEX.F3.0F 5A              VCVTSS2SD     Vx,Hx,Wx                  E2(rep-scalar)
+SSE|VEX.F2.0F 5A              VCVTSD2SS     Vx,Hx,Wx                  E2(rep-scalar)
+SSE|VEX.NP.0F 5B              VCVTDQ2PS     Vx,Wx                     E2
+SSE|VEX.66.0F 5B              VCVTPS2DQ     Vx,Wx                     E2
+SSE|VEX.F3.0F 5B              VCVTTPS2DQ    Vx,Wx                     E2
+SSE|VEX.NP|66|F3|F2.0F 5C     VSUB          Vx,Hx,Wx                  E2(rep-scalar)
+SSE|VEX.NP|66|F3|F2.0F 5D     VMIN          Vx,Hx,Wx                  E2(rep-scalar)
+SSE|VEX.NP|66|F3|F2.0F 5E     VDIV          Vx,Hx,Wx                  E2(rep-scalar)
+SSE|VEX.NP|66|F3|F2.0F 5F     VMAX          Vx,Hx,Wx                  E2(rep-scalar)
+
+SSE|VEX.NP|66.0F 60           PUNPCKLBW     Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 61           PUNPCKLWD     Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 62           PUNPCKLDQ     Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 63           PACKSSWB      Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 64           PCMPGTB       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 65           PCMPGTW       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 66           PCMPGTD       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 67           PACKUSWB      Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 68           PUNPCKHBW     Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 69           PUNPCKHWD     Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 6A           PUNPCKHDQ     Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 6B           PACKSSDW      Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.66.0F 6C              PUNPCKLQDQ    Vx,Hx,Wx                  E4(avx2_256)
+SSE|VEX.66.0F 6D              PUNPCKHQDQ    Vx,Hx,Wx                  E4(avx2_256)
+SSE|VEX.NP|66.0F 6E           MOVD_to       Vdq(w),Ey(op2)            E5(mmx)
+// MOVQ, MOVDQA and MOVDQU.
+SSE|VEX.NP.0F 6F              MOVDQ         Pq(w),Qq(op2)             E5(mmx)
+SSE|VEX.66.0F 6F              MOVDQ         Vx(w),Wx(op2)             E1
+SSE|VEX.F3.0F 6F              MOVDQ         Vx(w),Wx(op2)             E4(unaligned)
+
+SSE|VEX.NP.0F 70              PSHUFW        Pq(w),Qq,Ib               E4(mmx)
+SSE|VEX.66.0F 70              PSHUFD        Vx(w),Wx,Ib               E4(avx2_256)
+SSE|VEX.F3.0F 70              PSHUFHW       Vx(w),Wx,Ib               E4(avx2_256)
+SSE|VEX.F2.0F 70              PSHUFLW       Vx(w),Wx,Ib               E4(avx2_256)
+SSE|VEX.NP|66.0F 71 /2        PSRLW_i       Hx,Ux,Ib                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F 71 /4        PSRAW_i       Hx,Ux,Ib                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F 71 /6        PSLLW_i       Hx,Ux,Ib                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F 72 /2        PSRLD_i       Hx,Ux,Ib                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F 72 /4        PSRAD_i       Hx,Ux,Ib                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F 72 /6        PSLLD_i       Hx,Ux,Ib                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F 73 /2        PSRLQ_i       Hx,Ux,Ib                  E7(avx2_256, mmx)
+SSE|VEX.66.0F 73 /3           PSRLDQ_i      Hx,Ux,Ib                  E7(avx2_256)
+SSE|VEX.NP|66.0F 73 /6        PSLLQ_i       Hx,Ux,Ib                  E7(avx2_256, mmx)
+SSE|VEX.66.0F 73 /7           PSLLDQ_i      Hx,Ux,Ib                  E7(avx2_256)
+SSE|VEX.NP|66.0F 74           PCMPEQB       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 75           PCMPEQW       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F 76           PCMPEQD       Vx,Hx,Wx                  E4(avx2_256, mmx)
+// EMMS, VZEROUPPER and VZEROALL.
+NP.0F 77                      EMMS
+VEX.NP.L0.0F 77               VZEROUPPER                              E8
+VEX.NP.L1.0F 77               VZEROALL                                E8
+// AMD extensions
+F2.0F 78                      INSERTQ_i     Vx,Ux,Iw                  cpuid(SSE4A)
+66.0F 78 /0                   EXTRQ_i       Ux(w),Iw(op2)             cpuid(SSE4A)
+F2.0F 79                      INSERTQ_r     Vx,Ux                     cpuid(SSE4A)
+66.0F 79                      EXTRQ_r       Vx,Ux                     cpuid(SSE4A)
+SSE|VEX.66|F2.0F 7C           VHADD         Vx,Hx,Wx                  E2 cpuid(SSE3)
+SSE|VEX.66|F2.0F 7D           VHSUB         Vx,Hx,Wx                  E2 cpuid(SSE3)
+SSE|VEX.NP.0F 7E              MOVD_from     Ey(w),Py(op2)             E5(mmx)
+// The destination operand of MOVQ is wrongly listed as Vq in the manual.
+SSE|VEX.66.0F 7E              MOVD_from     Ey(w),Vy(op2)             E5
+SSE|VEX.F3.0F 7E              MOVQ          Vdq(w),Wq(op2)            E5
+SSE|VEX.NP.0F 7F              MOVDQ         Wx(w),Vx(op2)             E5(mmx)    // MOVQ
+SSE|VEX.66.0F 7F              MOVDQ         Wx(w),Vx(op2)             E1        // MOVDQA
+SSE|VEX.F3.0F 7F              MOVDQ         Wx(w),Vx(op2)             E4(unaligned)   // MOVDQU
+
+0F 80..8F                     Jcc           Jz_f64
+0F 90..9F                     SETcc         Eb(w)
+
+0F A0                         PUSH          FSw(r)
+0F A1                         POP           FSw(w)
+0F A2                         CPUID
+0F A3                         BT            Ev(r),Gv                  btEvGv
+0F A4                         SHLD          Ev(r,w),Gv,Ib
+0F A5                         SHLD          Ev(r,w),Gv
+0F A8                         PUSH          GSw(r)
+0F A9                         POP           GSw(w)
+0F AA                         RSM                                     chk(smm) svm(RSM)
+0F AB                         BTS           Ev,Gv                     btEvGv
+0F AC                         SHRD          Ev(r,w),Gv,Ib
+0F AD                         SHRD          Ev(r,w),Gv
+
+// Group 15.  The register forms have an R operand that is not used by the emitter,
+// and only requires ModRM.mod == 3 for all values of ModRM.rm.
+F3.0F AE /0                   RDxxBASE      Ry(w)                     cpuid(FSGSBASE) chk(o64)
+F3.0F AE /1                   RDxxBASE      Ry(w)                     cpuid(FSGSBASE) chk(o64)
+F3.0F AE /2                   WRxxBASE      Ry(r,zx)                  cpuid(FSGSBASE) chk(o64)
+F3.0F AE /3                   WRxxBASE      Ry(r,zx)                  cpuid(FSGSBASE) chk(o64)
+NP.0F AE /5                   LFENCE        Rd(nop)                   cpuid(SSE)
+NP.0F AE /6                   MFENCE        Rd(nop)                   cpuid(SSE2)
+NP.0F AE /7                   SFENCE        Rd(nop)                   cpuid(SSE)
+NP.0F AE /0                   FXSAVE        My(w)                     cpuid(FXSR)
+NP.0F AE /1                   FXRSTOR       My(r)                     cpuid(FXSR)
+SSE|VEX.NP.128.0F AE /2       LDMXCSR       Ed(r,m)                   E5
+SSE|VEX.NP.128.0F AE /3       STMXCSR       Ed(w,m)                   E5
+NP.0F AE /4                   XSAVE         My(w)                     cpuid(XSAVE) chk(no_rex2)
+NP.0F AE /5                   XRSTOR        My(r)                     cpuid(XSAVE) chk(no_rex2)
+NP.0F AE /6                   XSAVEOPT      Mb(w)                     cpuid(XSAVEOPT) chk(no_rex2)
+NP.0F AE /7                   NOP           Mb(w)                     cpuid(CLFLUSH)
+66.0F AE /6                   NOP           Mb(w)                     cpuid(CLWB)
+66.0F AE /7                   NOP           Mb(w)                     cpuid(CLFLUSHOPT)
+0F AF                         IMUL3         Gv(sx),Ev(sx)
+
+0F B0                         CMPXCHG       Eb,Gb(zx)                 lock
+0F B1                         CMPXCHG       Ev,Gv(zx)                 lock
+0F B2                         LSS           Gv(w),Ep(m)
+0F B3                         BTR           Ev,Gv                     btEvGv
+0F B4                         LFS           Gv(w),Ep(m)
+0F B5                         LGS           Gv(w),Ep(m)
+// MOVZX
+0F B6                         MOV           Gv(w),Eb(zx)
+0F B7                         MOV           Gv(w),Ew(zx)
+
+F3.0F B8                      POPCNT        Gv(w),Ev(zx)              cpuid(POPCNT)
+// UD1 is decoded as modrm, which is visible as a difference between page fault and #UD.
+0F B9                         UD            Ev(nop)
+0F BA /4                      BT            Ev(r),Ib
+0F BA /5                      BTS           Ev,Ib                     lock
+0F BA /6                      BTR           Ev,Ib                     lock
+0F BA /7                      BTC           Ev,Ib                     lock
+0F BB                         BTC           Ev,Gv                     btEvGv
+// TZCNT and LZCNT are BSF and BSR if the CPU does not have BMI1 and ABM respectively.
+F3.0F BC                      TZCNT         Gv(w),Ev(zx)              cpuid(BMI1)
+0F BC                         BSF           Gv,Ev(zx)
+F3.0F BD                      LZCNT         Gv(w),Ev(zx)              cpuid(ABM)
+0F BD                         BSR           Gv,Ev(zx)
+// MOVSX
+0F BE                         MOV           Gv(w),Eb(sx)
+0F BF                         MOV           Gv(w),Ew(sx)
+
+0F C0                         XADD          Eb,Gb                     lock
+0F C1                         XADD          Ev,Gv                     lock
+SSE|VEX.NP|66|F3|F2.0F C2     VCMP          Vx,Hx,Wx,Ib               E2(rep-scalar)
+// MOVNTI
+NP.0F C3                      MOV           Ey(w,m),Gy                cpuid(SSE2)
+SSE|VEX.NP|66.0F C4           PINSRW        Vdq,Hdq,Ew,Ib             E5(mmx)
+SSE|VEX.NP|66.0F C5           PEXTRW        Gd,Udq,Ib                 E5(mmx)
+SSE|VEX.NP|66.0F C6           VSHUF         Vx,Hx,Wx,Ib               E4
+// Group 9.  The register forms (RDRAND and others) are not converted yet.
+NP.W0.0F C7 /1                CMPXCHG8B     Mq                        lock cpuid(CX8)
+NP.W1.0F C7 /1                CMPXCHG16B    Mdq                       lock cpuid(CX16)
+0F C7 /0                      multi0F       Rd(nop)                   // unconverted
+0F C7 /1                      multi0F       Rd(nop)                   // unconverted
+0F C7 /2                      multi0F       Rd(nop)                   // unconverted
+0F C7 /3                      multi0F       Rd(nop)                   // unconverted
+0F C7 /4                      multi0F       Rd(nop)                   // unconverted
+0F C7 /5                      multi0F       Rd(nop)                   // unconverted
+0F C7 /6                      multi0F       Rd(nop)                   // unconverted
+0F C7 /7                      multi0F       Rd(nop)                   // unconverted
+0F C8..CF+r                   BSWAP         Ry
+
+SSE|VEX.66|F2.0F D0           VADDSUB       Vx,Hx,Wx                  E2 cpuid(SSE3)
+SSE|VEX.NP|66.0F D1           PSRLW_r       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F D2           PSRLD_r       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F D3           PSRLQ_r       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F D4           PADDQ         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F D5           PMULLW        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.66.0F D6              MOVQ          Wdq(w),Vq(op2)            E5
+F3.0F D6                      MOVq_dq       Vdq(w),Nq(op2)
+F2.0F D6                      MOVq_dq       Pq(w),Uq(op2)
+SSE|VEX.NP|66.0F D7           PMOVMSKB      Gd(w),Ux(op2)             E7(avx2_256, mmx)
+// Incorrectly missing from 2-17
+SSE|VEX.NP|66.0F D8           PSUBUSB       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F D9           PSUBUSW       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F DA           PMINUB        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F DB           PAND          Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F DC           PADDUSB       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F DD           PADDUSW       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F DE           PMAXUB        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F DF           PANDN         Vx,Hx,Wx                  E4(avx2_256, mmx)
+
+SSE|VEX.NP|66.0F E0           PAVGB         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F E1           PSRAW_r       Vx,Hx,Wx                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F E2           PSRAD_r       Vx,Hx,Wx                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F E3           PAVGW         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F E4           PMULHUW       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F E5           PMULHW        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.66.0F E6              VCVTTPD2DQ    Vx,Wx                     E2
+SSE|VEX.F3.0F E6              VCVTDQ2PD     Vx,Wx                     E5
+SSE|VEX.F2.0F E6              VCVTPD2DQ     Vx,Wx                     E2
+// MOVNTQ and MOVNTDQ
+SSE|VEX.NP|66.0F E7           MOVDQ         Wx(w),Vx(op2)             E1(mmx)
+SSE|VEX.NP|66.0F E8           PSUBSB        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F E9           PSUBSW        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F EA           PMINSW        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F EB           POR           Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F EC           PADDSB        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F ED           PADDSW        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F EE           PMAXSW        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F EF           PXOR          Vx,Hx,Wx                  E4(avx2_256, mmx)
+
+// LDDQU
+SSE|VEX.F2.0F F0              MOVDQ         Vx(w),Wx(m,op2)           E4(unaligned) cpuid(SSE3)
+SSE|VEX.NP|66.0F F1           PSLLW_r       Vx,Hx,Wx                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F F2           PSLLD_r       Vx,Hx,Wx                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F F3           PSLLQ_r       Vx,Hx,Wx                  E7(avx2_256, mmx)
+SSE|VEX.NP|66.0F F4           PMULUDQ       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F F5           PMADDWD       Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F F6           PSADBW        Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F F7           MASKMOV       Vdq(r),Udq                E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F F8           PSUBB         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F F9           PSUBW         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F FA           PSUBD         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F FB           PSUBQ         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F FC           PADDB         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F FD           PADDW         Vx,Hx,Wx                  E4(avx2_256, mmx)
+SSE|VEX.NP|66.0F FE           PADDD         Vx,Hx,Wx                  E4(avx2_256, mmx)
+0F FF                         UD            Ev(nop)
+
 // 0F 38
 // -----
 
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
index 53d57ebb21e..92b01d106ba 100644
--- a/target/i386/tcg/test_maketable.py
+++ b/target/i386/tcg/test_maketable.py
@@ -561,3 +561,10 @@ def lookup(enc: int, l: int, features: collections.abc.Container[str]) -> int |
         self.assertIsNone(lookup(ENC_VEX, 0, {'AES'}))
         self.assertIsNone(lookup(ENC_VEX, 1, {'AES', 'AVX'}))
         self.assertEqual(lookup(ENC_VEX, 1, {'AES', 'AVX', 'VAES'}), 3)
+
+    def test_cpuid_overlap(self) -> None:
+        self.assertRaises(SemanticError, self.build,
+                          '0F BC   X   Gv,Ev   cpuid(BMI1)', 'F3.0F BC   Y   Gv,Ev   cpuid(ABM)')
+        self.assertRaises(SemanticError, self.build,
+                          '0F BC   X   Gv,Ev', 'F3.0F BC   Y   Gv,Ev   cpuid(ABM)',
+                          'F3.0F BC   Z   Gv,Ev   cpuid(BMI1)')
-- 
2.56.0



