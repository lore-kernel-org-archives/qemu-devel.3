Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1124606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dp3h7R0f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiL-0002dc-Q3; Wed, 18 Nov 2026 07:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiD-0002Vk-St
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei9-0005lp-MZ
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JxK6aSaVJF+xj+HZlZO06k4LS7WoHAUSj/9sH6nvQE=;
 b=dp3h7R0fEZXyllyjFznsvGOs/ZIO4BdAjoDkBjhI9Qq6Xfbjo1F3HuKPHDOnNunmhi6xu7
 K48VnH7bE13VpHAhM01/Qznu+xuRoy+QMe6NG9K7TLPiHyDdJUUZizZux+2s/GmCxdbfpA
 97Unhx2w8o42pSGk0GPJpgd+XK5vVbY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-vcSvFGFdN8WR4BqNFLVa2A-1; Wed,
 18 Nov 2026 07:24:22 -0500
X-MC-Unique: vcSvFGFdN8WR4BqNFLVa2A-1
X-Mimecast-MFC-AGG-ID: vcSvFGFdN8WR4BqNFLVa2A_1795004662
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED044180044F
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:21 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35B1218004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 20/26] target/i386/tcg: convert the legacy map to
 decode.def
Date: Wed, 18 Nov 2026 13:23:51 +0100
Message-ID: <20261118122357.659634-21-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Describe the one-byte opcode map in decode.def.  decode_root(),
which can now be used also for REX2 map 0 (because the trie
checks for REX2 encodings anyway), runs the program from entry
point 0.

The generated rows match the old table except that for compactness
INC and DEC use 40..47+r and 48..4F+r with an R operand.

Small decoders like operand 63 are replaced by multiple lines that
are automatically dispatched on (e.g. based on MODE64 and REX.W),
while groups (80-83, C0-C3, D0-D3, C6-C7, F6-F7, FE-FF) are expanded into
one line for each ModRM.reg value, while group 1A (8F) simply adds /0
to the opcode as it is the only defined value of bits 3-5.

Opcode 90 is the last remaining use of is_decode, in order to choose
between NOP, PAUSE and XCHG with R8, because the generated program
cannot look at REX.B.  It would be possible as an alternative to add
that as a separate selector (e.g. "REXB0 90" for NOP/PAUSE and
"REXB1 90+r" for XCHG).

The x87 opcodes (D8..DF) put the nop operand in op1 instead of op0,
but anyway gen_x87 only looks at s->modrm and decode->mem.

AI-used-for: code
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc          | 472 +---------------------
 target/i386/tcg/emit.c.inc                |   4 +-
 target/i386/tcg/decode.def                | 306 ++++++++++++++
 target/i386/tcg/maketable_codegen.py      |  10 +-
 target/i386/tcg/test_maketable_codegen.py |   7 +
 5 files changed, 337 insertions(+), 462 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 7d91ddbd4c5..983ab466bfb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1269,438 +1269,23 @@ static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
     *entry = opcodes_0F[*b];
 }
 
-static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+static void decode_grp_xchg_ax(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    static const X86OpEntry arpl = X86_OP_ENTRY2(ARPL, E,w, G,w, chk(prot));
-    static const X86OpEntry mov = X86_OP_ENTRY3(MOV, G,v, E,v, None, None);
-    static const X86OpEntry movsxd = X86_OP_ENTRY3(MOV, G,v, E,d, None, None, sextT0);
-    if (!CODE64(s)) {
-        *entry = arpl;
-    } else if (REX_W(s)) {
-        *entry = movsxd;
-    } else {
-        *entry = mov;
-    }
-}
-
-static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86GenFunc group1_gen[8] = {
-        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_CMP,
-    };
-    int op = (get_modrm(s, env) >> 3) & 7;
-    entry->gen = group1_gen[op];
-
-    if (op == 7) {
-        /* prevent writeback for CMP */
-        entry->op1 = entry->op0;
-        entry->s1 = entry->s0;
-        entry->op0 = X86_TYPE_None;
-        entry->s0 = X86_SIZE_None;
-    } else {
-        entry->special = X86_SPECIAL_HasLock;
-    }
-}
-
-static void decode_group1A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    int op = (get_modrm(s, env) >> 3) & 7;
-    if (op != 0) {
-        /* could be XOP prefix too */
-        *entry = UNKNOWN_OPCODE;
-    } else {
-        entry->gen = gen_POP;
-        entry->special = X86_SPECIAL_PopESP;
-    }
-}
-
-static void decode_group2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86GenFunc group2_gen[8] = {
-        gen_ROL, gen_ROR, gen_RCL, gen_RCR,
-        gen_SHL, gen_SHR, gen_SHL /* SAL, undocumented */, gen_SAR,
-    };
-    int op = (get_modrm(s, env) >> 3) & 7;
-    entry->gen = group2_gen[op];
-    if (op == 2 || op == 3) {
-        entry->check |= X86_CHECK_nf0;
-    }
-    if (op == 7) {
-        entry->ext1 = X86_EXT_Signed;
-    } else {
-        entry->ext1 = X86_EXT_Unsigned;
-    }
-}
-
-static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_grp3[16] = {
-        /* 0xf6 */
-        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b),
-        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b),
-        [0x02] = X86_OP_ENTRY1(NOT,   E,b,      lock),
-        [0x03] = X86_OP_ENTRY1(NEG,   E,b,      lock),
-        [0x04] = X86_OP_ENTRYrr(MUL,  E,b, 0,b, zextT0 zextT1),
-        [0x05] = X86_OP_ENTRYrr(IMUL, E,b, 0,b, sextT0 sextT1),
-        [0x06] = X86_OP_ENTRYr(DIV,   E,b),
-        [0x07] = X86_OP_ENTRYr(IDIV,  E,b),
-
-        /* 0xf7 */
-        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z),
-        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z),
-        [0x0a] = X86_OP_ENTRY1(NOT,   E,v,      lock),
-        [0x0b] = X86_OP_ENTRY1(NEG,   E,v,      lock),
-        [0x0c] = X86_OP_ENTRYrr(MUL,  E,v, 0,v, zextT0 zextT1),
-        [0x0d] = X86_OP_ENTRYrr(IMUL, E,v, 0,v, sextT0 sextT1),
-        [0x0e] = X86_OP_ENTRYr(DIV,   E,v),
-        [0x0f] = X86_OP_ENTRYr(IDIV,  E,v),
-    };
-
-    int w = (*b & 1);
-    int reg = (get_modrm(s, env) >> 3) & 7;
-
-    *entry = opcodes_grp3[(w << 3) | reg];
-}
-
-static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry opcodes_grp4_5[16] = {
-        /* 0xfe */
-        [0x00] = X86_OP_ENTRY1(INC,    E,b,                            lock),
-        [0x01] = X86_OP_ENTRY1(DEC,    E,b,                            lock),
-
-        /* 0xff */
-        [0x08] = X86_OP_ENTRY1(INC,     E,v,                           lock),
-        [0x09] = X86_OP_ENTRY1(DEC,     E,v,                           lock),
-        [0x0a] = X86_OP_ENTRYr(CALL_m,  E,f64,                         zextT0),
-        [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
-        [0x0c] = X86_OP_ENTRYr(JMP_m,   E,f64,                         zextT0),
-        [0x0d] = X86_OP_ENTRYr(JMPF_m,  M,p),
-        [0x0e] = X86_OP_ENTRYr(PUSH,    E,d64),
-    };
-
-    int w = (*b & 1);
-    int reg = (get_modrm(s, env) >> 3) & 7;
-
-    *entry = opcodes_grp4_5[(w << 3) | reg];
-}
-
-
-static void decode_group11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    int op = (get_modrm(s, env) >> 3) & 7;
-    if (op != 0) {
-        *entry = UNKNOWN_OPCODE;
-    } else {
-        entry->gen = gen_MOV;
-    }
-}
-
-static void decode_90(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static X86OpEntry pause = X86_OP_ENTRY0(PAUSE, svm(PAUSE));
-    static X86OpEntry nop = X86_OP_ENTRY0(NOP);
-    static X86OpEntry xchg_ax = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v);
-
     if (REX_B(s)) {
-        *entry = xchg_ax;
+        entry->gen = gen_XCHG;
+        return;
+    }
+
+    memset(entry, 0, sizeof(*entry));
+    if (s->prefix & PREFIX_REPZ) {
+        entry->gen = gen_PAUSE;
+        entry->intercept = SVM_EXIT_PAUSE;
+        entry->has_intercept = true;
     } else {
-        *entry = (s->prefix & PREFIX_REPZ) ? pause : nop;
+        entry->gen = gen_NOP;
     }
 }
 
-static const X86OpEntry opcodes_root[256] = {
-    [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b, lock),
-    [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v, lock),
-    [0x02] = X86_OP_ENTRY2(ADD, G,b, E,b, lock),
-    [0x03] = X86_OP_ENTRY2(ADD, G,v, E,v, lock),
-    [0x04] = X86_OP_ENTRY2(ADD, 0,b, I,b, lock),   /* AL, Ib */
-    [0x05] = X86_OP_ENTRY2(ADD, 0,v, I,z, lock),   /* rAX, Iz */
-    [0x06] = X86_OP_ENTRYr(PUSH, ES, w, chk(i64)),
-    [0x07] = X86_OP_ENTRYw(POP, ES, w, chk(i64)),
-
-    [0x10] = X86_OP_ENTRY2(ADC, E,b, G,b, lock),
-    [0x11] = X86_OP_ENTRY2(ADC, E,v, G,v, lock),
-    [0x12] = X86_OP_ENTRY2(ADC, G,b, E,b, lock),
-    [0x13] = X86_OP_ENTRY2(ADC, G,v, E,v, lock),
-    [0x14] = X86_OP_ENTRY2(ADC, 0,b, I,b, lock),   /* AL, Ib */
-    [0x15] = X86_OP_ENTRY2(ADC, 0,v, I,z, lock),   /* rAX, Iz */
-    [0x16] = X86_OP_ENTRYr(PUSH, SS, w, chk(i64)),
-    [0x17] = X86_OP_ENTRYw(POP, SS, w, chk(i64)),
-
-    [0x20] = X86_OP_ENTRY2(AND, E,b, G,b, lock),
-    [0x21] = X86_OP_ENTRY2(AND, E,v, G,v, lock),
-    [0x22] = X86_OP_ENTRY2(AND, G,b, E,b, lock),
-    [0x23] = X86_OP_ENTRY2(AND, G,v, E,v, lock),
-    [0x24] = X86_OP_ENTRY2(AND, 0,b, I,b, lock),   /* AL, Ib */
-    [0x25] = X86_OP_ENTRY2(AND, 0,v, I,z, lock),   /* rAX, Iz */
-    [0x26] = {},
-    [0x27] = X86_OP_ENTRY0(DAA, chk(i64)),
-
-    [0x30] = X86_OP_ENTRY2(XOR, E,b, G,b, lock),
-    [0x31] = X86_OP_ENTRY2(XOR, E,v, G,v, lock),
-    [0x32] = X86_OP_ENTRY2(XOR, G,b, E,b, lock),
-    [0x33] = X86_OP_ENTRY2(XOR, G,v, E,v, lock),
-    [0x34] = X86_OP_ENTRY2(XOR, 0,b, I,b, lock),   /* AL, Ib */
-    [0x35] = X86_OP_ENTRY2(XOR, 0,v, I,z, lock),   /* rAX, Iz */
-    [0x36] = {},
-    [0x37] = X86_OP_ENTRY0(AAA, chk(i64)),
-
-    [0x40] = X86_OP_ENTRY1(INC, 0,v, chk(i64)),
-    [0x41] = X86_OP_ENTRY1(INC, 1,v, chk(i64)),
-    [0x42] = X86_OP_ENTRY1(INC, 2,v, chk(i64)),
-    [0x43] = X86_OP_ENTRY1(INC, 3,v, chk(i64)),
-    [0x44] = X86_OP_ENTRY1(INC, 4,v, chk(i64)),
-    [0x45] = X86_OP_ENTRY1(INC, 5,v, chk(i64)),
-    [0x46] = X86_OP_ENTRY1(INC, 6,v, chk(i64)),
-    [0x47] = X86_OP_ENTRY1(INC, 7,v, chk(i64)),
-
-    [0x50] = X86_OP_ENTRYr(PUSH, LoBits,d64),
-    [0x51] = X86_OP_ENTRYr(PUSH, LoBits,d64),
-    [0x52] = X86_OP_ENTRYr(PUSH, LoBits,d64),
-    [0x53] = X86_OP_ENTRYr(PUSH, LoBits,d64),
-    [0x54] = X86_OP_ENTRYr(PUSH, LoBits,d64),
-    [0x55] = X86_OP_ENTRYr(PUSH, LoBits,d64),
-    [0x56] = X86_OP_ENTRYr(PUSH, LoBits,d64),
-    [0x57] = X86_OP_ENTRYr(PUSH, LoBits,d64),
-
-    [0x60] = X86_OP_ENTRY0(PUSHA, chk(i64)),
-    [0x61] = X86_OP_ENTRY0(POPA, chk(i64)),
-    [0x62] = X86_OP_ENTRYrr(BOUND, G,v, M,a, chk(i64)),
-    [0x63] = X86_OP_GROUP0(63),
-    [0x64] = {},
-    [0x65] = {},
-    [0x66] = {},
-    [0x67] = {},
-
-    [0x70] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x71] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x72] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x73] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x74] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x75] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x76] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x77] = X86_OP_ENTRYr(Jcc, J,b),
-
-    [0x80] = X86_OP_GROUP2(group1, E,b, I,b),
-    [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
-    [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
-    [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
-    [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b),
-    [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v),
-    [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
-    [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
-
-    [0x90] = X86_OP_GROUP0(90),
-    [0x91] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
-    [0x92] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
-    [0x93] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
-    [0x94] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
-    [0x95] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
-    [0x96] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
-    [0x97] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
-
-    [0xA0] = X86_OP_ENTRY3(MOV, 0,b, O,b, None, None), /* AL, Ob */
-    [0xA1] = X86_OP_ENTRY3(MOV, 0,v, O,v, None, None), /* rAX, Ov */
-    [0xA2] = X86_OP_ENTRY3(MOV, O,b, 0,b, None, None), /* Ob, AL */
-    [0xA3] = X86_OP_ENTRY3(MOV, O,v, 0,v, None, None), /* Ov, rAX */
-    [0xA4] = X86_OP_ENTRY0(MOVS),
-    [0xA5] = X86_OP_ENTRY0(MOVS),
-    [0xA6] = X86_OP_ENTRY0(CMPS),
-    [0xA7] = X86_OP_ENTRY0(CMPS),
-
-    [0xB0] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
-    [0xB1] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
-    [0xB2] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
-    [0xB3] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
-    [0xB4] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
-    [0xB5] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
-    [0xB6] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
-    [0xB7] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
-
-    [0xC0] = X86_OP_GROUP2(group2, E,b, I,b),
-    [0xC1] = X86_OP_GROUP2(group2, E,v, I,b),
-    [0xC2] = X86_OP_ENTRYr(RET, I,w),
-    [0xC3] = X86_OP_ENTRY0(RET),
-    [0xC4] = X86_OP_ENTRY3(LES, G,z, EM,p, None, None, chk(i64)),
-    [0xC5] = X86_OP_ENTRY3(LDS, G,z, EM,p, None, None, chk(i64)),
-    [0xC6] = X86_OP_GROUP3(group11, E,b, I,b, None, None), /* reg=000b */
-    [0xC7] = X86_OP_GROUP3(group11, E,v, I,z, None, None), /* reg=000b */
-
-    [0xD0] = X86_OP_GROUP1(group2, E,b),
-    [0xD1] = X86_OP_GROUP1(group2, E,v),
-    [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
-    [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
-    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b, chk(i64)),
-    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b, chk(i64)),
-    [0xD6] = X86_OP_ENTRYw(SALC, 0,b, chk(i64)),
-    [0xD7] = X86_OP_ENTRY1(XLAT, 0,b, zextT0), /* AL read/written */
-
-    [0xE0] = X86_OP_ENTRYr(LOOPNE, J,b), /* implicit: CX with aflag size */
-    [0xE1] = X86_OP_ENTRYr(LOOPE,  J,b), /* implicit: CX with aflag size */
-    [0xE2] = X86_OP_ENTRYr(LOOP,   J,b), /* implicit: CX with aflag size */
-    [0xE3] = X86_OP_ENTRYr(JCXZ,   J,b), /* implicit: CX with aflag size */
-    [0xE4] = X86_OP_ENTRYwr(IN,    0,b, I_unsigned,b), /* AL */
-    [0xE5] = X86_OP_ENTRYwr(IN,    0,z, I_unsigned,b), /* AX/EAX */
-    [0xE6] = X86_OP_ENTRYrr(OUT,   0,b, I_unsigned,b), /* AL */
-    [0xE7] = X86_OP_ENTRYrr(OUT,   0,z, I_unsigned,b), /* AX/EAX */
-
-    [0xF1] = X86_OP_ENTRY0(INT1,   svm(ICEBP)),
-    [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0) svm(HLT)),
-    [0xF5] = X86_OP_ENTRY0(CMC),
-    [0xF6] = X86_OP_GROUP1(group3, E,b),
-    [0xF7] = X86_OP_GROUP1(group3, E,v),
-
-    [0x08] = X86_OP_ENTRY2(OR, E,b, G,b, lock),
-    [0x09] = X86_OP_ENTRY2(OR, E,v, G,v, lock),
-    [0x0A] = X86_OP_ENTRY2(OR, G,b, E,b, lock),
-    [0x0B] = X86_OP_ENTRY2(OR, G,v, E,v, lock),
-    [0x0C] = X86_OP_ENTRY2(OR, 0,b, I,b, lock),   /* AL, Ib */
-    [0x0D] = X86_OP_ENTRY2(OR, 0,v, I,z, lock),   /* rAX, Iz */
-    [0x0E] = X86_OP_ENTRYr(PUSH, CS, w, chk(i64)),
-
-    [0x18] = X86_OP_ENTRY2(SBB, E,b, G,b, lock),
-    [0x19] = X86_OP_ENTRY2(SBB, E,v, G,v, lock),
-    [0x1A] = X86_OP_ENTRY2(SBB, G,b, E,b, lock),
-    [0x1B] = X86_OP_ENTRY2(SBB, G,v, E,v, lock),
-    [0x1C] = X86_OP_ENTRY2(SBB, 0,b, I,b, lock),   /* AL, Ib */
-    [0x1D] = X86_OP_ENTRY2(SBB, 0,v, I,z, lock),   /* rAX, Iz */
-    [0x1E] = X86_OP_ENTRYr(PUSH, DS, w, chk(i64)),
-    [0x1F] = X86_OP_ENTRYw(POP, DS, w, chk(i64)),
-
-    [0x28] = X86_OP_ENTRY2(SUB, E,b, G,b, lock),
-    [0x29] = X86_OP_ENTRY2(SUB, E,v, G,v, lock),
-    [0x2A] = X86_OP_ENTRY2(SUB, G,b, E,b, lock),
-    [0x2B] = X86_OP_ENTRY2(SUB, G,v, E,v, lock),
-    [0x2C] = X86_OP_ENTRY2(SUB, 0,b, I,b, lock),   /* AL, Ib */
-    [0x2D] = X86_OP_ENTRY2(SUB, 0,v, I,z, lock),   /* rAX, Iz */
-    [0x2E] = {},
-    [0x2F] = X86_OP_ENTRY0(DAS, chk(i64)),
-
-    [0x38] = X86_OP_ENTRYrr(CMP, E,b, G,b),
-    [0x39] = X86_OP_ENTRYrr(CMP, E,v, G,v),
-    [0x3A] = X86_OP_ENTRYrr(CMP, G,b, E,b),
-    [0x3B] = X86_OP_ENTRYrr(CMP, G,v, E,v),
-    [0x3C] = X86_OP_ENTRYrr(CMP, 0,b, I,b),   /* AL, Ib */
-    [0x3D] = X86_OP_ENTRYrr(CMP, 0,v, I,z),   /* rAX, Iz */
-    [0x3E] = {},
-    [0x3F] = X86_OP_ENTRY0(AAS, chk(i64)),
-
-    [0x48] = X86_OP_ENTRY1(DEC, 0,v, chk(i64)),
-    [0x49] = X86_OP_ENTRY1(DEC, 1,v, chk(i64)),
-    [0x4A] = X86_OP_ENTRY1(DEC, 2,v, chk(i64)),
-    [0x4B] = X86_OP_ENTRY1(DEC, 3,v, chk(i64)),
-    [0x4C] = X86_OP_ENTRY1(DEC, 4,v, chk(i64)),
-    [0x4D] = X86_OP_ENTRY1(DEC, 5,v, chk(i64)),
-    [0x4E] = X86_OP_ENTRY1(DEC, 6,v, chk(i64)),
-    [0x4F] = X86_OP_ENTRY1(DEC, 7,v, chk(i64)),
-
-    [0x58] = X86_OP_ENTRYw(POP, LoBits,d64),
-    [0x59] = X86_OP_ENTRYw(POP, LoBits,d64),
-    [0x5A] = X86_OP_ENTRYw(POP, LoBits,d64),
-    [0x5B] = X86_OP_ENTRYw(POP, LoBits,d64),
-    [0x5C] = X86_OP_ENTRYw(POP, LoBits,d64),
-    [0x5D] = X86_OP_ENTRYw(POP, LoBits,d64),
-    [0x5E] = X86_OP_ENTRYw(POP, LoBits,d64),
-    [0x5F] = X86_OP_ENTRYw(POP, LoBits,d64),
-
-    [0x68] = X86_OP_ENTRYr(PUSH, I,z),
-    [0x69] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,z, sextT0),
-    [0x6A] = X86_OP_ENTRYr(PUSH, I,b),
-    [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b, sextT0),
-    [0x6C] = X86_OP_ENTRYr(INS, 2,w,             zextT0), /* DX */
-    [0x6D] = X86_OP_ENTRYr(INS, 2,w,             zextT0), /* DX */
-    [0x6E] = X86_OP_ENTRYr(OUTS, 2,w,            zextT0), /* DX */
-    [0x6F] = X86_OP_ENTRYr(OUTS, 2,w,            zextT0), /* DX */
-
-    [0x78] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x79] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x7A] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x7B] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x7C] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x7D] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x7E] = X86_OP_ENTRYr(Jcc, J,b),
-    [0x7F] = X86_OP_ENTRYr(Jcc, J,b),
-
-    [0x88] = X86_OP_ENTRYwr(MOV, E,b, G,b),
-    [0x89] = X86_OP_ENTRYwr(MOV, E,v, G,v),
-    [0x8A] = X86_OP_ENTRYwr(MOV, G,b, E,b),
-    [0x8B] = X86_OP_ENTRYwr(MOV, G,v, E,v),
-     /* Missing in Table A-2: memory destination is always 16-bit.  */
-    [0x8C] = X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
-    [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, nolea),
-    [0x8E] = X86_OP_ENTRYwr(MOV, S,w, E,w),
-    [0x8F] = X86_OP_GROUPw(group1A, E,d64),
-
-    [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
-    [0x99] = X86_OP_ENTRYwr(CWD,   2,v, 0,v), /* rDX, rAX */
-    [0x9A] = X86_OP_ENTRYrr(CALLF, I_unsigned,p, I_unsigned,w, chk(i64)),
-    [0x9B] = X86_OP_ENTRY0(WAIT),
-    [0x9C] = X86_OP_ENTRY0(PUSHF,  chk(vm86_iopl) svm(PUSHF)),
-    [0x9D] = X86_OP_ENTRY0(POPF,   chk(vm86_iopl) svm(POPF)),
-    [0x9E] = X86_OP_ENTRY0(SAHF),
-    [0x9F] = X86_OP_ENTRY0(LAHF),
-
-    [0xA8] = X86_OP_ENTRYrr(TEST, 0,b, I,b),   /* AL, Ib */
-    [0xA9] = X86_OP_ENTRYrr(TEST, 0,v, I,z),   /* rAX, Iz */
-    [0xAA] = X86_OP_ENTRYr(STOS, 0,b),
-    [0xAB] = X86_OP_ENTRYr(STOS, 0,v),
-    /* Manual writeback because REP LODS (!) has to write EAX/RAX after every LODS.  */
-    [0xAC] = X86_OP_ENTRY0(LODS),
-    [0xAD] = X86_OP_ENTRY0(LODS),
-    [0xAE] = X86_OP_ENTRYr(SCAS, 0,b),
-    [0xAF] = X86_OP_ENTRYr(SCAS, 0,v),
-
-    [0xB8] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
-    [0xB9] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
-    [0xBA] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
-    [0xBB] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
-    [0xBC] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
-    [0xBD] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
-    [0xBE] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
-    [0xBF] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
-
-    [0xC8] = X86_OP_ENTRYrr(ENTER, I_unsigned, w, I, b),
-    [0xC9] = X86_OP_ENTRY0(LEAVE),
-    [0xCA] = X86_OP_ENTRYr(RETF,  I,w),
-    [0xCB] = X86_OP_ENTRY0(RETF),
-    [0xCC] = X86_OP_ENTRY0(INT3),
-    [0xCD] = X86_OP_ENTRYr(INT, I,b,  chk(vm86_iopl)),
-    [0xCE] = X86_OP_ENTRY0(INTO, chk(i64)),
-    [0xCF] = X86_OP_ENTRY0(IRET,      chk(vm86_iopl) svm(IRET)),
-
-    /*
-     * x87 is nolea because it needs the address without segment base,
-     * in order to store it in fdp.
-     */
-    [0xD8] = X86_OP_ENTRY1(x87,    nop,v, nolea),
-    [0xD9] = X86_OP_ENTRY1(x87,    nop,v, nolea),
-    [0xDA] = X86_OP_ENTRY1(x87,    nop,v, nolea),
-    [0xDB] = X86_OP_ENTRY1(x87,    nop,v, nolea),
-    [0xDC] = X86_OP_ENTRY1(x87,    nop,v, nolea),
-    [0xDD] = X86_OP_ENTRY1(x87,    nop,v, nolea),
-    [0xDE] = X86_OP_ENTRY1(x87,    nop,v, nolea),
-    [0xDF] = X86_OP_ENTRY1(x87,    nop,v, nolea),
-
-    [0xE8] = X86_OP_ENTRYr(CALL,   J,z_f64),
-    [0xE9] = X86_OP_ENTRYr(JMP,    J,z_f64),
-    [0xEA] = X86_OP_ENTRYrr(JMPF,  I_unsigned,p, I_unsigned,w, chk(i64)),
-    [0xEB] = X86_OP_ENTRYr(JMP,    J,b),
-    [0xEC] = X86_OP_ENTRYwr(IN,    0,b, 2,w,  zextT0), /* AL, DX */
-    [0xED] = X86_OP_ENTRYwr(IN,    0,z, 2,w,  zextT0), /* AX/EAX, DX */
-    [0xEE] = X86_OP_ENTRYrr(OUT,   0,b, 2,w,  zextT1), /* DX, AL */
-    [0xEF] = X86_OP_ENTRYrr(OUT,   0,z, 2,w,  zextT1), /* DX, AX/EAX */
-
-    [0xF8] = X86_OP_ENTRY0(CLC),
-    [0xF9] = X86_OP_ENTRY0(STC),
-    [0xFA] = X86_OP_ENTRY0(CLI,    chk(iopl)),
-    [0xFB] = X86_OP_ENTRY0(STI,    chk(iopl)),
-    [0xFC] = X86_OP_ENTRY0(CLD),
-    [0xFD] = X86_OP_ENTRY0(STD),
-    [0xFE] = X86_OP_GROUP1(group4_5, E,b),
-    [0xFF] = X86_OP_GROUP1(group4_5, E,v),
-};
-
 #ifdef TARGET_X86_64
 static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
                         const X86OpEntry **map)
@@ -1709,36 +1294,6 @@ static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = group ? group[*b & 15] : UNKNOWN_OPCODE;
 }
 
-static void decode_REX2_map0(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry *opcode_rex2_map0[16] = {
-        &opcodes_root[0x00],
-        &opcodes_root[0x10],
-        &opcodes_root[0x20],
-        &opcodes_root[0x30],
-        NULL,
-        &opcodes_root[0x50],
-        &opcodes_root[0x60],
-        NULL,
-        &opcodes_root[0x80],
-        &opcodes_root[0x90],
-        NULL,
-        &opcodes_root[0xB0],
-        &opcodes_root[0xC0],
-        &opcodes_root[0xD0],
-        NULL,
-        &opcodes_root[0xF0],
-    };
-
-    /* The rows that differ from the legacy encoding are in decode.def.  */
-    if (opcode_rex2_map0[*b >> 4]) {
-        decode_REX2(s, env, entry, b, opcode_rex2_map0);
-    } else {
-        const X86OpEntry *row = decode_run(s, env, 0, b);
-        *entry = row ? *row : UNKNOWN_OPCODE;
-    }
-}
-
 static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry *opcode_rex2_map1[16] = {
@@ -1793,7 +1348,8 @@ static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entr
 
 static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    *entry = opcodes_root[*b];
+    const X86OpEntry *row = decode_run(s, env, 0, b);
+    *entry = row ? *row : UNKNOWN_OPCODE;
 }
 
 static int reg_nb_mask(DisasContext *s, int unit)
@@ -3012,7 +2568,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 decode_func = decode_REX2_map1;
             } else {
                 b = x86_ldub_code(env, s);
-                decode_func = decode_REX2_map0;
+                decode_func = decode_root;
             }
         }
         break;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ec0c9a6f360..10e64576cb9 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2219,15 +2219,15 @@ static void gen_FXSAVE(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifdef CONFIG_SYSTEM_ONLY
 static void gen_HLT(DisasContext *s, X86DecodedInsn *decode)
 {
-#ifdef CONFIG_SYSTEM_ONLY
     gen_update_cc_op(s);
     gen_update_eip_next(s);
     gen_helper_hlt(tcg_env);
     s->base.is_jmp = DISAS_NORETURN;
-#endif
 }
+#endif
 
 static void gen_IDIV(DisasContext *s, X86DecodedInsn *decode)
 {
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index d30885a11e6..65b69a3016d 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -83,6 +83,11 @@
 //
 // The name of the gen_* function in emit.c.inc, without the gen_ prefix.
 //
+// Names that start with "grp" are instead the name of a decode_* function
+// in decode-new.c.inc, without the prefix.  The function is called with the
+// row described by the line, and completes it, for example by choosing the
+// gen_* function based on ModRM.reg.
+//
 //
 // Operands
 // --------
@@ -200,6 +205,307 @@
 //       decode.def:867: 66.0F38 10                  PBLENDVB      Vx,Wx              E4 cpuid(SSE41): needs ENC=legacy
 //
 
+// Legacy map
+// ----------
+
+00                          ADD      Eb,Gb                   lock
+01                          ADD      Ev,Gv                   lock
+02                          ADD      Gb,Eb                   lock
+03                          ADD      Gv,Ev                   lock
+04                          ADD      RAXb,Ib                 lock
+05                          ADD      RAXv,Iz                 lock
+06                          PUSH     ESw(r)                  chk(i64)
+07                          POP      ESw(w)                  chk(i64)
+
+08                          OR       Eb,Gb                   lock
+09                          OR       Ev,Gv                   lock
+0A                          OR       Gb,Eb                   lock
+0B                          OR       Gv,Ev                   lock
+0C                          OR       RAXb,Ib                 lock
+0D                          OR       RAXv,Iz                 lock
+0E                          PUSH     CSw(r)                  chk(i64)
+
+10                          ADC      Eb,Gb                   lock
+11                          ADC      Ev,Gv                   lock
+12                          ADC      Gb,Eb                   lock
+13                          ADC      Gv,Ev                   lock
+14                          ADC      RAXb,Ib                 lock
+15                          ADC      RAXv,Iz                 lock
+16                          PUSH     SSw(r)                  chk(i64)
+17                          POP      SSw(w)                  chk(i64)
+
+18                          SBB      Eb,Gb                   lock
+19                          SBB      Ev,Gv                   lock
+1A                          SBB      Gb,Eb                   lock
+1B                          SBB      Gv,Ev                   lock
+1C                          SBB      RAXb,Ib                 lock
+1D                          SBB      RAXv,Iz                 lock
+1E                          PUSH     DSw(r)                  chk(i64)
+1F                          POP      DSw(w)                  chk(i64)
+
+20                          AND      Eb,Gb                   lock
+21                          AND      Ev,Gv                   lock
+22                          AND      Gb,Eb                   lock
+23                          AND      Gv,Ev                   lock
+24                          AND      RAXb,Ib                 lock
+25                          AND      RAXv,Iz                 lock
+27                          DAA                              chk(i64)
+
+28                          SUB      Eb,Gb                   lock
+29                          SUB      Ev,Gv                   lock
+2A                          SUB      Gb,Eb                   lock
+2B                          SUB      Gv,Ev                   lock
+2C                          SUB      RAXb,Ib                 lock
+2D                          SUB      RAXv,Iz                 lock
+2F                          DAS                              chk(i64)
+
+30                          XOR      Eb,Gb                   lock
+31                          XOR      Ev,Gv                   lock
+32                          XOR      Gb,Eb                   lock
+33                          XOR      Gv,Ev                   lock
+34                          XOR      RAXb,Ib                 lock
+35                          XOR      RAXv,Iz                 lock
+37                          AAA                              chk(i64)
+
+38                          CMP      Eb(r),Gb
+39                          CMP      Ev(r),Gv
+3A                          CMP      Gb(r),Eb
+3B                          CMP      Gv(r),Ev
+3C                          CMP      RAXb(r),Ib
+3D                          CMP      RAXv(r),Iz
+3F                          AAS                              chk(i64)
+
+// INC, DEC and the REX prefixes.  REX2 has no equivalent of these rows.
+40..47+r                    INC      Rv                      chk(i64)
+48..4F+r                    DEC      Rv                      chk(i64)
+
+50..57+r                    PUSH     Rd64(r)
+58..5F+r                    POP      Rd64(w)
+
+60                          PUSHA                            chk(i64)
+61                          POPA                             chk(i64)
+62                          BOUND    Gv(r),Ma                chk(i64)
+// ARPL, or MOVSXD in 64-bit mode.
+63                          ARPL     Ew,Gw                   chk(prot, i64)
+W1 63                       MOV      Gv(w),Ed(sx)            chk(o64)
+W0 63                       MOV      Gv(w),Ev                chk(o64)
+
+68                          PUSH     Iz
+69                          IMUL3    Gv,Ev(sx),Iz
+6A                          PUSH     Ib
+6B                          IMUL3    Gv,Ev(sx),Ib
+6C..6D                      INS      RDXw(r,zx)
+6E..6F                      OUTS     RDXw(r,zx)
+
+70..7F                      Jcc      Jb
+
+80 /0                       ADD      Eb,Ib                   lock
+80 /1                       OR       Eb,Ib                   lock
+80 /2                       ADC      Eb,Ib                   lock
+80 /3                       SBB      Eb,Ib                   lock
+80 /4                       AND      Eb,Ib                   lock
+80 /5                       SUB      Eb,Ib                   lock
+80 /6                       XOR      Eb,Ib                   lock
+80 /7                       CMP      Eb(r),Ib
+81 /0                       ADD      Ev,Iz                   lock
+81 /1                       OR       Ev,Iz                   lock
+81 /2                       ADC      Ev,Iz                   lock
+81 /3                       SBB      Ev,Iz                   lock
+81 /4                       AND      Ev,Iz                   lock
+81 /5                       SUB      Ev,Iz                   lock
+81 /6                       XOR      Ev,Iz                   lock
+81 /7                       CMP      Ev(r),Iz
+82 /0                       ADD      Eb,Ib                   lock chk(i64)
+82 /1                       OR       Eb,Ib                   lock chk(i64)
+82 /2                       ADC      Eb,Ib                   lock chk(i64)
+82 /3                       SBB      Eb,Ib                   lock chk(i64)
+82 /4                       AND      Eb,Ib                   lock chk(i64)
+82 /5                       SUB      Eb,Ib                   lock chk(i64)
+82 /6                       XOR      Eb,Ib                   lock chk(i64)
+82 /7                       CMP      Eb(r),Ib                chk(i64)
+83 /0                       ADD      Ev,Ib                   lock
+83 /1                       OR       Ev,Ib                   lock
+83 /2                       ADC      Ev,Ib                   lock
+83 /3                       SBB      Ev,Ib                   lock
+83 /4                       AND      Ev,Ib                   lock
+83 /5                       SUB      Ev,Ib                   lock
+83 /6                       XOR      Ev,Ib                   lock
+83 /7                       CMP      Ev(r),Ib
+84                          TEST     Eb(r),Gb
+85                          TEST     Ev(r),Gv
+86                          XCHG     Eb,Gb                   xchg
+87                          XCHG     Ev,Gv                   xchg
+
+88                          MOV      Eb(w),Gb
+89                          MOV      Ev(w),Gv
+8A                          MOV      Gb(w),Eb
+8B                          MOV      Gv(w),Ev
+// Missing in Table A-2: memory destination is always 16-bit.
+8C                          MOV      Ev(w),Sw                op0_Mw
+8D                          LEA      Gv(w),Mv                nolea
+8E                          MOV      Sw(w),Ew
+8F /0                       POP      Ed64(w)                 popESP
+
+// NOP, PAUSE, or XCHG with R8 if REX.B is set.
+// Note "+r" is needed on the 90+r so that Rv does not use a modrm byte.
+90+r                        grp_xchg_ax  RAXv,Rv
+91..97+r                    XCHG         RAXv,Rv
+
+98                          CBW      RAXv
+99                          CWD      RDXv(w),RAXv
+9A                          CALLF    Ip(zx),Iw(zx)           chk(i64)
+9B                          WAIT
+9C                          PUSHF                            chk(vm86_iopl) svm(PUSHF)
+9D                          POPF                             chk(vm86_iopl) svm(POPF)
+9E                          SAHF
+9F                          LAHF
+
+A0                          MOV      RAXb(w),Ob
+A1                          MOV      RAXv(w),Ov
+A2                          MOV      Ob(w),RAXb
+A3                          MOV      Ov(w),RAXv
+A4..A5                      MOVS
+A6..A7                      CMPS
+A8                          TEST     RAXb(r),Ib
+A9                          TEST     RAXv(r),Iz
+AA                          STOS     RAXb(r)
+AB                          STOS     RAXv(r)
+// Manual writeback because REP LODS (!) has to write EAX/RAX after every LODS.
+AC..AD                      LODS
+AE                          SCAS     RAXb(r)
+AF                          SCAS     RAXv(r)
+
+B0..B7+r                    MOV      Rb(w),Ib
+B8..BF+r                    MOV      Rv(w),Iv
+
+C0 /0                       ROL      Eb(zx),Ib
+C0 /1                       ROR      Eb(zx),Ib
+C0 /2                       RCL      Eb(zx),Ib
+C0 /3                       RCR      Eb(zx),Ib
+C0 /4                       SHL      Eb(zx),Ib
+C0 /5                       SHR      Eb(zx),Ib
+C0 /6                       SHL      Eb(zx),Ib
+C0 /7                       SAR      Eb(sx),Ib
+C1 /0                       ROL      Ev(zx),Ib
+C1 /1                       ROR      Ev(zx),Ib
+C1 /2                       RCL      Ev(zx),Ib
+C1 /3                       RCR      Ev(zx),Ib
+C1 /4                       SHL      Ev(zx),Ib
+C1 /5                       SHR      Ev(zx),Ib
+C1 /6                       SHL      Ev(zx),Ib
+C1 /7                       SAR      Ev(sx),Ib
+C2                          RET      Iw
+C3                          RET
+C4                          LES      Gz(w),Ep(m)             chk(i64)
+C5                          LDS      Gz(w),Ep(m)             chk(i64)
+C6 /0                       MOV      Eb(w),Ib
+C7 /0                       MOV      Ev(w),Iz
+C8                          ENTER    Iw(zx),Ib
+C9                          LEAVE
+CA                          RETF     Iw
+CB                          RETF
+CC                          INT3
+CD                          INT      Ib                      chk(vm86_iopl)
+CE                          INTO                             chk(i64)
+CF                          IRET                             chk(vm86_iopl) svm(IRET)
+
+D0 /0                       ROL      Eb(zx)
+D0 /1                       ROR      Eb(zx)
+D0 /2                       RCL      Eb(zx)
+D0 /3                       RCR      Eb(zx)
+D0 /4                       SHL      Eb(zx)
+D0 /5                       SHR      Eb(zx)
+D0 /6                       SHL      Eb(zx)
+D0 /7                       SAR      Eb(sx)
+D1 /0                       ROL      Ev(zx)
+D1 /1                       ROR      Ev(zx)
+D1 /2                       RCL      Ev(zx)
+D1 /3                       RCR      Ev(zx)
+D1 /4                       SHL      Ev(zx)
+D1 /5                       SHR      Ev(zx)
+D1 /6                       SHL      Ev(zx)
+D1 /7                       SAR      Ev(sx)
+// The shift count is in CL.
+D2 /0                       ROL      Eb(zx),RCXb
+D2 /1                       ROR      Eb(zx),RCXb
+D2 /2                       RCL      Eb(zx),RCXb
+D2 /3                       RCR      Eb(zx),RCXb
+D2 /4                       SHL      Eb(zx),RCXb
+D2 /5                       SHR      Eb(zx),RCXb
+D2 /6                       SHL      Eb(zx),RCXb
+D2 /7                       SAR      Eb(sx),RCXb
+D3 /0                       ROL      Ev(zx),RCXb
+D3 /1                       ROR      Ev(zx),RCXb
+D3 /2                       RCL      Ev(zx),RCXb
+D3 /3                       RCR      Ev(zx),RCXb
+D3 /4                       SHL      Ev(zx),RCXb
+D3 /5                       SHR      Ev(zx),RCXb
+D3 /6                       SHL      Ev(zx),RCXb
+D3 /7                       SAR      Ev(sx),RCXb
+D4                          AAM      RAXw,Ib                 chk(i64)
+// AAD is the REX2 prefix in 64-bit mode.
+D5                          AAD      RAXw,Ib                 chk(i64)
+D6                          SALC     RAXb(w)                 chk(i64)
+// AL is read and written.
+D7                          XLAT     RAXb(zx)
+
+// x87 is nolea because it needs the address without segment base, in order to store it in fdp.
+D8..DF                      x87      Ev(nop)                 nolea
+
+// LOOPcc and JCXZ use CX with the address size as an implicit operand.
+E0                          LOOPNE   Jb
+E1                          LOOPE    Jb
+E2                          LOOP     Jb
+E3                          JCXZ     Jb
+E4                          IN       RAXb(w),Ib(zx)
+E5                          IN       RAXz(w),Ib(zx)
+E6                          OUT      RAXb(r),Ib(zx)
+E7                          OUT      RAXz(r),Ib(zx)
+E8                          CALL     Jz_f64
+E9                          JMP      Jz_f64
+EA                          JMPF     Ip(zx),Iw(zx)           chk(i64)
+EB                          JMP      Jb
+EC                          IN       RAXb(w),RDXw(zx)
+ED                          IN       RAXz(w),RDXw(zx)
+EE                          OUT      RAXb(r),RDXw(zx)
+EF                          OUT      RAXz(r),RDXw(zx)
+
+F1                          INT1                             svm(ICEBP)
+F4                          HLT                              chk(cpl0) svm(HLT)
+F5                          CMC
+F6 /0                       TEST     Eb(r),Ib
+F6 /1                       TEST     Eb(r),Ib
+F6 /2                       NOT      Eb                      lock
+F6 /3                       NEG      Eb                      lock
+F6 /4                       MUL      Eb(r,zx),RAXb(zx)
+F6 /5                       IMUL     Eb(r,sx),RAXb(sx)
+F6 /6                       DIV      Eb(r)
+F6 /7                       IDIV     Eb(r)
+F7 /0                       TEST     Ev(r),Iz
+F7 /1                       TEST     Ev(r),Iz
+F7 /2                       NOT      Ev                      lock
+F7 /3                       NEG      Ev                      lock
+F7 /4                       MUL      Ev(r,zx),RAXv(zx)
+F7 /5                       IMUL     Ev(r,sx),RAXv(sx)
+F7 /6                       DIV      Ev(r)
+F7 /7                       IDIV     Ev(r)
+F8                          CLC
+F9                          STC
+FA                          CLI                              chk(iopl)
+FB                          STI                              chk(iopl)
+FC                          CLD
+FD                          STD
+FE /0                       INC      Eb                      lock
+FE /1                       DEC      Eb                      lock
+FF /0                       INC      Ev                      lock
+FF /1                       DEC      Ev                      lock
+FF /2                       CALL_m   Ef64(r,zx)
+FF /3                       CALLF_m  Mp(r)
+FF /4                       JMP_m    Ef64(r,zx)
+FF /5                       JMPF_m   Mp(r)
+FF /6                       PUSH     Ed64(r)
+
+
 // REX2 map 0
 // ----------
 
diff --git a/target/i386/tcg/maketable_codegen.py b/target/i386/tcg/maketable_codegen.py
index fb58a136dda..99f0aaf2c91 100644
--- a/target/i386/tcg/maketable_codegen.py
+++ b/target/i386/tcg/maketable_codegen.py
@@ -38,8 +38,14 @@ def operand_ext(op: Operand) -> str | None:
 
 
 def row_fields(entry: Entry) -> dict[str, str]:
-    # Fields of the X86OpEntry for an entry, as C expressions.
-    fields = {'gen': f'gen_{entry.insn.emitter}'}
+    # Fields of the X86OpEntry for an entry, as C expressions.  Groups that
+    # are shared between opcode maps (for example the legacy encoding and
+    # EVEX map 4) keep a decode_* function that completes the row.
+    name = entry.insn.emitter
+    if name.startswith('grp'):
+        fields = {'decode': f'decode_{name}', 'is_decode': 'true'}
+    else:
+        fields = {'gen': f'gen_{name}'}
 
     def set_operand(slot: int, type: str, size: str | None, ext: str | None) -> None:
         fields[f'op{slot}'] = f'X86_TYPE_{C_TYPES.get(type, type)}'
diff --git a/target/i386/tcg/test_maketable_codegen.py b/target/i386/tcg/test_maketable_codegen.py
index 52fe1c9e433..b2fe3753c43 100644
--- a/target/i386/tcg/test_maketable_codegen.py
+++ b/target/i386/tcg/test_maketable_codegen.py
@@ -314,3 +314,10 @@ def test_op2(self) -> None:
         fields = row_fields(entry('SSE|VEX.NP|66.0F38 1C   PABSB   Vx(w),Wx(op2)   E4(mmx)'))
         self.assertEqual((fields['op0'], fields['op2']), ('X86_TYPE_V', 'X86_TYPE_W'))
         self.assertNotIn('op1', fields)
+
+    def test_group(self) -> None:
+        # Names starting with grp are completed by a decode_* function.
+        fields = row_fields(entry('80   grp1   Eb,Ib   lock'))
+        self.assertEqual((fields['decode'], fields['is_decode']), ('decode_grp1', 'true'))
+        self.assertNotIn('gen', fields)
+        self.assertEqual((fields['op0'], fields['op1']), ('X86_TYPE_E', 'X86_TYPE_2op'))
-- 
2.56.0



