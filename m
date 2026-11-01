Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E74606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LaST+s4M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNSLD-0006kE-1W; Sun, 01 Nov 2026 04:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSLB-0006jD-CC
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSL9-0007tr-Gr
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793527143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pV2cH+Hiysbru3LIBetZGwlKrZ52MuYj2AbIed9flcw=;
 b=LaST+s4MBPIOVQWQGVfR+euwL6uUkPn0Z3+IX+EMpwD+DQeMlgKzIxkUOlrEDsILcW4SrD
 msDhU2+fHFtc+b7ObNcAbkzkEDI9nobSplnJhewzti7S8mLI/1tL7Jnf2eiW0kuAVsa6sr
 kMQ7a64fvXyYwAZB1UyvRhrT9bB/SNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-TckEZAeMPTyfOKia5RF7Zg-1; Sun,
 01 Nov 2026 04:59:01 -0500
X-MC-Unique: TckEZAeMPTyfOKia5RF7Zg-1
X-Mimecast-MFC-AGG-ID: TckEZAeMPTyfOKia5RF7Zg_1793527140
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5390B19560AF
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:59:00 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1A401800495
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:58:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] target/i386/tcg: remove X and Y operand types
Date: Sun,  1 Nov 2026 10:58:46 +0100
Message-ID: <20261101095851.1557351-6-pbonzini@redhat.com>
In-Reply-To: <20261101095851.1557351-1-pbonzini@redhat.com>
References: <20261101095851.1557351-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Since the Intel SDM is moving away from operand types, remove more of
the implicit types; X and Y are meant for string instructions but the
DS:SI and ES:DI addressing modes are handled entirely in the generator
functions; the operands were just placeholders to distinguish byte
string operations from s->dflag string operations.

Note that this moves the port for INS and OUTS from s->T1 to s->T0.

This frees up some operand letters that could be useful in the future,
for example to allocate K/X/Y to mask registers in the same guise as
H/V/W for AVX.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  2 --
 target/i386/tcg/translate.c      |  6 ++++++
 target/i386/tcg/decode-new.c.inc | 30 ++++++++++++++----------------
 target/i386/tcg/emit.c.inc       | 18 +++++++++---------
 4 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index a823143bbdf..2218a4eda3a 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -41,8 +41,6 @@ typedef enum X86OpType {
     X86_TYPE_U, /* R/M in the modrm byte selects an XMM/YMM register */
     X86_TYPE_V, /* reg in the modrm byte selects an XMM/YMM register */
     X86_TYPE_W, /* XMM/YMM modrm operand */
-    X86_TYPE_X, /* string source */
-    X86_TYPE_Y, /* string destination */
 
     /* Custom */
     X86_TYPE_EM, /* modrm byte selects an ALU memory operand */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3d542acd975..b715921c379 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -403,6 +403,12 @@ static inline bool byte_reg_is_xH(DisasContext *s, int reg)
     return true;
 }
 
+/* Select the size of an INS/OUTS operation ("z" operand size).  */
+static inline MemOp mo_ins_outs(DisasContext *s)
+{
+    return s->dflag == MO_16 ? MO_16 : MO_32;
+}
+
 /* Select the size of a push/pop operation.  */
 static inline MemOp mo_pushpop(DisasContext *s, MemOp ot)
 {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 65fd402c17f..7e5ece380af 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1810,10 +1810,10 @@ static const X86OpEntry opcodes_root[256] = {
     [0xA1] = X86_OP_ENTRY3(MOV, 0,v, O,v, None, None), /* rAX, Ov */
     [0xA2] = X86_OP_ENTRY3(MOV, O,b, 0,b, None, None), /* Ob, AL */
     [0xA3] = X86_OP_ENTRY3(MOV, O,v, 0,v, None, None), /* Ov, rAX */
-    [0xA4] = X86_OP_ENTRYrr(MOVS, Y,b, X,b),
-    [0xA5] = X86_OP_ENTRYrr(MOVS, Y,v, X,v),
-    [0xA6] = X86_OP_ENTRYrr(CMPS, Y,b, X,b),
-    [0xA7] = X86_OP_ENTRYrr(CMPS, Y,v, X,v),
+    [0xA4] = X86_OP_ENTRY0(MOVS),
+    [0xA5] = X86_OP_ENTRY0(MOVS),
+    [0xA6] = X86_OP_ENTRY0(CMPS),
+    [0xA7] = X86_OP_ENTRY0(CMPS),
 
     [0xB0] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
     [0xB1] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
@@ -1916,10 +1916,10 @@ static const X86OpEntry opcodes_root[256] = {
     [0x69] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,z, sextT0),
     [0x6A] = X86_OP_ENTRYr(PUSH, I,b),
     [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b, sextT0),
-    [0x6C] = X86_OP_ENTRYrr(INS, Y,b, 2,w), /* DX */
-    [0x6D] = X86_OP_ENTRYrr(INS, Y,z, 2,w), /* DX */
-    [0x6E] = X86_OP_ENTRYrr(OUTS, X,b, 2,w), /* DX */
-    [0x6F] = X86_OP_ENTRYrr(OUTS, X,z, 2,w), /* DX */
+    [0x6C] = X86_OP_ENTRYr(INS, 2,w), /* DX */
+    [0x6D] = X86_OP_ENTRYr(INS, 2,w), /* DX */
+    [0x6E] = X86_OP_ENTRYr(OUTS, 2,w), /* DX */
+    [0x6F] = X86_OP_ENTRYr(OUTS, 2,w), /* DX */
 
     [0x78] = X86_OP_ENTRYr(Jcc, J,b),
     [0x79] = X86_OP_ENTRYr(Jcc, J,b),
@@ -1951,13 +1951,13 @@ static const X86OpEntry opcodes_root[256] = {
 
     [0xA8] = X86_OP_ENTRYrr(TEST, 0,b, I,b),   /* AL, Ib */
     [0xA9] = X86_OP_ENTRYrr(TEST, 0,v, I,z),   /* rAX, Iz */
-    [0xAA] = X86_OP_ENTRYwr(STOS, Y,b, 0,b),
-    [0xAB] = X86_OP_ENTRYwr(STOS, Y,v, 0,v),
+    [0xAA] = X86_OP_ENTRYr(STOS, 0,b),
+    [0xAB] = X86_OP_ENTRYr(STOS, 0,v),
     /* Manual writeback because REP LODS (!) has to write EAX/RAX after every LODS.  */
-    [0xAC] = X86_OP_ENTRYr(LODS, X,b),
-    [0xAD] = X86_OP_ENTRYr(LODS, X,v),
-    [0xAE] = X86_OP_ENTRYrr(SCAS, 0,b, Y,b),
-    [0xAF] = X86_OP_ENTRYrr(SCAS, 0,v, Y,v),
+    [0xAC] = X86_OP_ENTRY0(LODS),
+    [0xAD] = X86_OP_ENTRY0(LODS),
+    [0xAE] = X86_OP_ENTRYr(SCAS, 0,b),
+    [0xAF] = X86_OP_ENTRYr(SCAS, 0,v),
 
     [0xB8] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
     [0xB9] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
@@ -2552,8 +2552,6 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     switch (type) {
     case X86_TYPE_None:  /* Implicit or absent */
     case X86_TYPE_F:  /* EFLAGS/RFLAGS */
-    case X86_TYPE_X:  /* string source */
-    case X86_TYPE_Y:  /* string destination */
         break;
 
     case X86_TYPE_B:  /* VEX.vvvv selects a GPR, else use modrm */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a1ae5821746..5754f3dcc8b 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1923,7 +1923,7 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_CMPS(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[2].ot;
+    MemOp ot = decode->b & 1 ? s->dflag : MO_8;
     gen_repz_nz(s, ot, gen_cmps);
 }
 
@@ -2388,10 +2388,10 @@ static void gen_INC(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_INS(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[1].ot;
+    MemOp ot = decode->b & 1 ? mo_ins_outs(s) : MO_8;
     TCGv_i32 port = tcg_temp_new_i32();
 
-    tcg_gen_trunc_tl_i32(port, s->T1);
+    tcg_gen_trunc_tl_i32(port, s->T0);
     tcg_gen_ext16u_i32(port, port);
     if (!gen_check_io(s, ot, port,
                       SVM_IOIO_TYPE_MASK | SVM_IOIO_STR_MASK)) {
@@ -2593,7 +2593,7 @@ static void gen_LGS(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_LODS(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[1].ot;
+    MemOp ot = decode->b & 1 ? s->dflag : MO_8;
     gen_repz(s, ot, gen_lods);
 }
 
@@ -2803,7 +2803,7 @@ static void gen_MOVq_dq(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_MOVS(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[2].ot;
+    MemOp ot = decode->b & 1 ? s->dflag : MO_8;
     gen_repz(s, ot, gen_movs);
 }
 
@@ -2960,10 +2960,10 @@ static void gen_OUT(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_OUTS(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[1].ot;
+    MemOp ot = decode->b & 1 ? mo_ins_outs(s) : MO_8;
     TCGv_i32 port = tcg_temp_new_i32();
 
-    tcg_gen_trunc_tl_i32(port, s->T1);
+    tcg_gen_trunc_tl_i32(port, s->T0);
     tcg_gen_ext16u_i32(port, port);
     if (!gen_check_io(s, ot, port, SVM_IOIO_STR_MASK)) {
         return;
@@ -4128,7 +4128,7 @@ static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_SCAS(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[2].ot;
+    MemOp ot = decode->b & 1 ? s->dflag : MO_8;
     gen_repz_nz(s, ot, gen_scas);
 }
 
@@ -4332,7 +4332,7 @@ static void gen_STMXCSR(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_STOS(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[1].ot;
+    MemOp ot = decode->b & 1 ? s->dflag : MO_8;
     gen_repz(s, ot, gen_stos);
 }
 
-- 
2.56.0



