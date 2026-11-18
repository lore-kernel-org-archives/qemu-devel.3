Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5E606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RikYXzuD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiI-0002bk-R6; Wed, 18 Nov 2026 07:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiB-0002Sj-Vq
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei8-0005c2-Dg
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNVHdTLgAXFTTy2Jj1zw03rSyxQGc3Pu1htUe3O/JkQ=;
 b=RikYXzuDjDo/poFeO7d890yo1t/52wNxaxKSXBEvKWT0HlfKXYnEyG6AwsrrGGm3JOHRmm
 PQvR8WDgphkDTYkasYi22VQ7ZlojlUd66H1Tkm7jpmOIVv9LdS+pjDb0rHTBy6PC5vtsxl
 JCJwEuOQuLKW4rKDUIiGqPmhLOaAk2M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-OmsXEoMJPIG1AHnB1ETvPQ-1; Wed,
 18 Nov 2026 07:24:21 -0500
X-MC-Unique: OmsXEoMJPIG1AHnB1ETvPQ-1
X-Mimecast-MFC-AGG-ID: OmsXEoMJPIG1AHnB1ETvPQ_1795004660
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C37D51956095
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:20 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 213C7180055C
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 19/26] target/i386/tcg: convert EVEX map 4 to decode.def
Date: Wed, 18 Nov 2026 13:23:50 +0100
Message-ID: <20261118122357.659634-20-pbonzini@redhat.com>
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

Describe EVEX map 4 in decode.def and remove opcodes_EVEX_map4,
decode_EVEX4cc, decode_EVEX4_MOVBE, decode_EVEX4_66, decode_EVEX4_8F and
decode_EVEX4_FF.  decode_EVEX_map4() now runs the program from entry
point 4.

NFx and NDx prefixes, plus splitting on register/memory operands,
make it easy to specify CMOVcc, CFCMOVcc and SETcc and get rid of the
cfcmov_nd0 and cfcmov_nd1 tables.  The E operand of the register forms
needs to become R for maketable.py to identify the split correctly,
and likewise MOVBE is split into register and memory entries instead of
rewriting E to M in decode_EVEX4_MOVBE().

While APX shares groups 1, 2 and 3 are shared with the legacy encoding,
I am inlining them in order to have the NF0 annotations specified directly
in the decoding table.  Groups 4 and 5 are also shared but only for INC,
DEC, so expanding them is not a particular problem.

AI-used-for: code
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 257 +++++--------------------------
 target/i386/tcg/decode.def       | 197 +++++++++++++++++++++++
 2 files changed, 233 insertions(+), 221 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1c5c6687419..7d91ddbd4c5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1293,9 +1293,10 @@ static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 
     if (op == 7) {
         /* prevent writeback for CMP */
+        entry->op1 = entry->op0;
+        entry->s1 = entry->s0;
         entry->op0 = X86_TYPE_None;
         entry->s0 = X86_SIZE_None;
-        entry->vex_class = X86_EVEX_APX_cmp;
     } else {
         entry->special = X86_SPECIAL_HasLock;
     }
@@ -1335,24 +1336,24 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 {
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
-        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b, evex_apx_cmp p_00),
-        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b, evex_apx_cmp p_00),
-        [0x02] = X86_OP_ENTRYwr(NOT,  B,b, E,b, evex_apx p_00 chk(nf0) lock),
-        [0x03] = X86_OP_ENTRYwr(NEG,  B,b, E,b, evex_apx p_00 lock),
-        [0x04] = X86_OP_ENTRYrr(MUL,  E,b, 0,b, evex_apx p_00 zextT0 zextT1),
-        [0x05] = X86_OP_ENTRYrr(IMUL, E,b, 0,b, evex_apx p_00 sextT0 sextT1),
-        [0x06] = X86_OP_ENTRYr(DIV,   E,b,      evex_apx p_00),
-        [0x07] = X86_OP_ENTRYr(IDIV,  E,b,      evex_apx p_00),
+        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b),
+        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b),
+        [0x02] = X86_OP_ENTRY1(NOT,   E,b,      lock),
+        [0x03] = X86_OP_ENTRY1(NEG,   E,b,      lock),
+        [0x04] = X86_OP_ENTRYrr(MUL,  E,b, 0,b, zextT0 zextT1),
+        [0x05] = X86_OP_ENTRYrr(IMUL, E,b, 0,b, sextT0 sextT1),
+        [0x06] = X86_OP_ENTRYr(DIV,   E,b),
+        [0x07] = X86_OP_ENTRYr(IDIV,  E,b),
 
         /* 0xf7 */
-        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z, evex_apx_cmp p_00_66),
-        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z, evex_apx_cmp p_00_66),
-        [0x0a] = X86_OP_ENTRYwr(NOT,  B,v, E,v, evex_apx p_00_66 chk(nf0) lock),
-        [0x0b] = X86_OP_ENTRYwr(NEG,  B,v, E,v, evex_apx p_00_66 lock),
-        [0x0c] = X86_OP_ENTRYrr(MUL,  E,v, 0,v, evex_apx p_00_66 zextT0 zextT1),
-        [0x0d] = X86_OP_ENTRYrr(IMUL, E,v, 0,v, evex_apx p_00_66 sextT0 sextT1),
-        [0x0e] = X86_OP_ENTRYr(DIV,   E,v,      evex_apx p_00_66),
-        [0x0f] = X86_OP_ENTRYr(IDIV,  E,v,      evex_apx p_00_66),
+        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z),
+        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z),
+        [0x0a] = X86_OP_ENTRY1(NOT,   E,v,      lock),
+        [0x0b] = X86_OP_ENTRY1(NEG,   E,v,      lock),
+        [0x0c] = X86_OP_ENTRYrr(MUL,  E,v, 0,v, zextT0 zextT1),
+        [0x0d] = X86_OP_ENTRYrr(IMUL, E,v, 0,v, sextT0 sextT1),
+        [0x0e] = X86_OP_ENTRYr(DIV,   E,v),
+        [0x0f] = X86_OP_ENTRYr(IDIV,  E,v),
     };
 
     int w = (*b & 1);
@@ -1365,12 +1366,12 @@ static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry
 {
     static const X86OpEntry opcodes_grp4_5[16] = {
         /* 0xfe */
-        [0x00] = X86_OP_ENTRYwr(INC,    B,b, E,b,                      evex_apx p_00 lock),
-        [0x01] = X86_OP_ENTRYwr(DEC,    B,b, E,b,                      evex_apx p_00 lock),
+        [0x00] = X86_OP_ENTRY1(INC,    E,b,                            lock),
+        [0x01] = X86_OP_ENTRY1(DEC,    E,b,                            lock),
 
         /* 0xff */
-        [0x08] = X86_OP_ENTRYwr(INC,    B,v, E,v,                      evex_apx p_00_66 lock),
-        [0x09] = X86_OP_ENTRYwr(DEC,    B,v, E,v,                      evex_apx p_00_66 lock),
+        [0x08] = X86_OP_ENTRY1(INC,     E,v,                           lock),
+        [0x09] = X86_OP_ENTRY1(DEC,     E,v,                           lock),
         [0x0a] = X86_OP_ENTRYr(CALL_m,  E,f64,                         zextT0),
         [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
         [0x0c] = X86_OP_ENTRYr(JMP_m,   E,f64,                         zextT0),
@@ -1481,11 +1482,10 @@ static const X86OpEntry opcodes_root[256] = {
     [0x76] = X86_OP_ENTRYr(Jcc, J,b),
     [0x77] = X86_OP_ENTRYr(Jcc, J,b),
 
-    /* decode_group1 is shared with EVEX map4.  */
-    [0x80] = X86_OP_GROUP3(group1, B,b, E,b, I,b),
-    [0x81] = X86_OP_GROUP3(group1, B,v, E,v, I,z),
-    [0x82] = X86_OP_GROUP3(group1, B,b, E,b, I,b, chk(i64)),
-    [0x83] = X86_OP_GROUP3(group1, B,v, E,v, I,b),
+    [0x80] = X86_OP_GROUP2(group1, E,b, I,b),
+    [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
+    [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
+    [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
     [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b),
     [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v),
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
@@ -1518,9 +1518,8 @@ static const X86OpEntry opcodes_root[256] = {
     [0xB6] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
     [0xB7] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
 
-    /* decode_group2 is shared with EVEX map4.  */
-    [0xC0] = X86_OP_GROUP3(group2, B,b, E,b, I,b),
-    [0xC1] = X86_OP_GROUP3(group2, B,v, E,v, I,b),
+    [0xC0] = X86_OP_GROUP2(group2, E,b, I,b),
+    [0xC1] = X86_OP_GROUP2(group2, E,v, I,b),
     [0xC2] = X86_OP_ENTRYr(RET, I,w),
     [0xC3] = X86_OP_ENTRY0(RET),
     [0xC4] = X86_OP_ENTRY3(LES, G,z, EM,p, None, None, chk(i64)),
@@ -1528,11 +1527,10 @@ static const X86OpEntry opcodes_root[256] = {
     [0xC6] = X86_OP_GROUP3(group11, E,b, I,b, None, None), /* reg=000b */
     [0xC7] = X86_OP_GROUP3(group11, E,v, I,z, None, None), /* reg=000b */
 
-    /* decode_group2 is shared with EVEX map4.  */
-    [0xD0] = X86_OP_GROUPwr(group2, B,b, E,b),
-    [0xD1] = X86_OP_GROUPwr(group2, B,v, E,v),
-    [0xD2] = X86_OP_GROUP3(group2, B,b, E,b, 1,b), /* CL */
-    [0xD3] = X86_OP_GROUP3(group2, B,v, E,v, 1,b), /* CL */
+    [0xD0] = X86_OP_GROUP1(group2, E,b),
+    [0xD1] = X86_OP_GROUP1(group2, E,v),
+    [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
+    [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
     [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b, chk(i64)),
     [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b, chk(i64)),
     [0xD6] = X86_OP_ENTRYw(SALC, 0,b, chk(i64)),
@@ -1765,196 +1763,13 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
     decode_REX2(s, env, entry, b, opcode_rex2_map1);
 }
 
-static void decode_EVEX4cc(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    uint8_t modrm = get_modrm(s, env);
-    int mod = (modrm >> 6) & 3;
-
-    static const X86OpEntry setcc =
-        X86_OP_ENTRYw(SETcc, E,b, evex_apx_zu chk(nf0) p_f2);
-
-    /*
-     * All EVEX-promoted register-destination conditional moves (all CFCMOV
-     * cases except "CFCMOV rm, r", and three-operand CMOV) have zero-upper
-     * Note that this is specific to CMOV/CFCMOV, and not ZU!
-     *
-     * For NDD=0, NF represents the direction.  For NDD=1, NF represents fault
-     * suppression.
-     */
-    static const X86OpEntry cfcmov_nd0[2][2] = {
-        { /* NF=0 */
-            X86_OP_ENTRY3(CFCMOVcc_ld,  G,v, ZERO,v, M,v, p_00_66 evex_apx zextwT0),
-            X86_OP_ENTRY3(CMOVcc,       G,v, ZERO,v, E,v, p_00_66 evex_apx zextwT0),
-        },
-        { /* NF=1 */
-            X86_OP_ENTRYwr(CFCMOVcc_st, M,v, G,v,         p_00_66 evex_apx),
-            X86_OP_ENTRY3(CMOVcc,       E,v, ZERO,v, G,v, p_00_66 evex_apx zextwT0),
-        },
-    };
-    static const X86OpEntry cfcmov_nd1[2][2] = {
-        { /* NF=0 */
-            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx zextwT0),
-            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx zextwT0),
-        },
-        { /* NF=1 */
-            X86_OP_ENTRY3(CFCMOVcc_ld,  B,v, G,v, M,v,    p_00_66 evex_apx zextwT0),
-            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx zextwT0),
-        },
-    };
-
-    if (s->prefix & PREFIX_REPNZ) {
-        *entry = setcc;
-    } else {
-        *entry = (EVEX_APX_ND(s) ? cfcmov_nd1 : cfcmov_nd0)[EVEX_APX_NF(s)][mod == 3];
-    }
-}
-
-static void decode_EVEX4_MOVBE(DisasContext *s, CPUX86State *env,
-                               X86OpEntry *entry, uint8_t *b)
-{
-    entry->gen = gen_MOVBE;
-    if ((get_modrm(s, env) >> 6) != 3) {
-        /* skip the load/store to be able to use MO_BE in code generation.  */
-        if (entry->op0 == X86_TYPE_E) {
-            entry->op0 = X86_TYPE_M;
-        } else {
-            entry->op1 = X86_TYPE_M;
-        }
-    }
-}
-
-static void decode_EVEX4_66(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    entry->gen = (s->prefix & PREFIX_DATA) ? gen_ADCX : gen_ADOX;
-}
-
-static void decode_EVEX4_8F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    int op = (get_modrm(s, env) >> 3) & 7;
-    if (op == 0) {
-        entry->gen = gen_POP2;
-    } else {
-        *entry = UNKNOWN_OPCODE;
-    }
-}
-
-static void decode_EVEX4_FF(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    static const X86OpEntry push2 =
-        X86_OP_ENTRYrr(PUSH2, B,d64, R,d64,     evex_apx_pp2 p_00);
-
-    int op = (get_modrm(s, env) >> 3) & 7;
-    if (op == 6) {
-        *entry = push2;
-    } else {
-        decode_group4_5(s, env, entry, b);
-    }
-}
-
-/*
- * Missing: ENQCMD, ENQCMDS, INVEPT, INVPCID, INVVPID,
- * KMOVD, KMOVW, KMOVD, KMOVQ, MOVDIR64B, MOVDIRI, URDMSR,
- * UWRMSR, WRSSD, WRSSQ, WRUSSD, WRUSSQ, LDTILECFG, STTILECFG,
- * TILELOADD, TILELOADDDT1, TILESTORED.
- */
-static const X86OpEntry opcodes_EVEX_map4[256] = {
-    [0x00] = X86_OP_ENTRY3(ADD, B,b, E,b, G,b, evex_apx p_00 lock),
-    [0x01] = X86_OP_ENTRY3(ADD, B,v, E,v, G,v, evex_apx p_00_66 lock),
-    [0x02] = X86_OP_ENTRY3(ADD, B,b, G,b, E,b, evex_apx p_00 lock),
-    [0x03] = X86_OP_ENTRY3(ADD, B,v, G,v, E,v, evex_apx p_00_66 lock),
-    [0x08] = X86_OP_ENTRY3(OR, B,b, E,b, G,b, evex_apx p_00 lock),
-    [0x09] = X86_OP_ENTRY3(OR, B,v, E,v, G,v, evex_apx p_00_66 lock),
-    [0x0A] = X86_OP_ENTRY3(OR, B,b, G,b, E,b, evex_apx p_00 lock),
-    [0x0B] = X86_OP_ENTRY3(OR, B,v, G,v, E,v, evex_apx p_00_66 lock),
-
-    [0x10] = X86_OP_ENTRY3(ADC, B,b, E,b, G,b, evex_apx p_00 chk(nf0) lock),
-    [0x11] = X86_OP_ENTRY3(ADC, B,v, E,v, G,v, evex_apx p_00_66 chk(nf0) lock),
-    [0x12] = X86_OP_ENTRY3(ADC, B,b, G,b, E,b, evex_apx p_00 chk(nf0) lock),
-    [0x13] = X86_OP_ENTRY3(ADC, B,v, G,v, E,v, evex_apx p_00_66 chk(nf0) lock),
-    [0x18] = X86_OP_ENTRY3(SBB, B,b, E,b, G,b, evex_apx p_00 chk(nf0) lock),
-    [0x19] = X86_OP_ENTRY3(SBB, B,v, E,v, G,v, evex_apx p_00_66 chk(nf0) lock),
-    [0x1A] = X86_OP_ENTRY3(SBB, B,b, G,b, E,b, evex_apx p_00 chk(nf0) lock),
-    [0x1B] = X86_OP_ENTRY3(SBB, B,v, G,v, E,v, evex_apx p_00_66 chk(nf0) lock),
-
-    [0x20] = X86_OP_ENTRY3(AND,  B,b, E,b, G,b, evex_apx p_00 lock),
-    [0x21] = X86_OP_ENTRY3(AND,  B,v, E,v, G,v, evex_apx p_00_66 lock),
-    [0x22] = X86_OP_ENTRY3(AND,  B,b, G,b, E,b, evex_apx p_00 lock),
-    [0x23] = X86_OP_ENTRY3(AND,  B,v, G,v, E,v, evex_apx p_00_66 lock),
-    [0x24] = X86_OP_ENTRY4(SHLD, B,v, E,v, G,v, evex_apx p_00_66),
-    [0x28] = X86_OP_ENTRY3(SUB,  B,b, E,b, G,b, evex_apx p_00 lock),
-    [0x29] = X86_OP_ENTRY3(SUB,  B,v, E,v, G,v, evex_apx p_00_66 lock),
-    [0x2A] = X86_OP_ENTRY3(SUB,  B,b, G,b, E,b, evex_apx p_00 lock),
-    [0x2B] = X86_OP_ENTRY3(SUB,  B,v, G,v, E,v, evex_apx p_00_66 lock),
-    [0x2C] = X86_OP_ENTRY4(SHRD, B,v, E,v, G,v, evex_apx p_00_66),
-
-    [0x30] = X86_OP_ENTRY3(XOR, B,b, E,b, G,b, evex_apx p_00 lock),
-    [0x31] = X86_OP_ENTRY3(XOR, B,v, E,v, G,v, evex_apx p_00_66 lock),
-    [0x32] = X86_OP_ENTRY3(XOR, B,b, G,b, E,b, evex_apx p_00 lock),
-    [0x33] = X86_OP_ENTRY3(XOR, B,v, G,v, E,v, evex_apx p_00_66 lock),
-    [0x38] = X86_OP_ENTRYrr(CMP, E,b, G,b, evex_apx_cmp p_00),
-    [0x39] = X86_OP_ENTRYrr(CMP, E,v, G,v, evex_apx_cmp p_00_66),
-    [0x3A] = X86_OP_ENTRYrr(CMP, G,b, E,b, evex_apx_cmp p_00),
-    [0x3B] = X86_OP_ENTRYrr(CMP, G,v, E,v, evex_apx_cmp p_00_66),
-
-    [0x40] = X86_OP_GROUP0(EVEX4cc),
-    [0x41] = X86_OP_GROUP0(EVEX4cc),
-    [0x42] = X86_OP_GROUP0(EVEX4cc),
-    [0x43] = X86_OP_GROUP0(EVEX4cc),
-    [0x44] = X86_OP_GROUP0(EVEX4cc),
-    [0x45] = X86_OP_GROUP0(EVEX4cc),
-    [0x46] = X86_OP_GROUP0(EVEX4cc),
-    [0x47] = X86_OP_GROUP0(EVEX4cc),
-    [0x48] = X86_OP_GROUP0(EVEX4cc),
-    [0x49] = X86_OP_GROUP0(EVEX4cc),
-    [0x4A] = X86_OP_GROUP0(EVEX4cc),
-    [0x4B] = X86_OP_GROUP0(EVEX4cc),
-    [0x4C] = X86_OP_GROUP0(EVEX4cc),
-    [0x4D] = X86_OP_GROUP0(EVEX4cc),
-    [0x4E] = X86_OP_GROUP0(EVEX4cc),
-    [0x4F] = X86_OP_GROUP0(EVEX4cc),
-
-    [0x60] = X86_OP_GROUPwr(EVEX4_MOVBE,  G,v, E,v,     evex_apx cpuid(MOVBE) chk(nf0) p_00_66),
-    [0x61] = X86_OP_GROUPwr(EVEX4_MOVBE,  E,v, G,v,     evex_apx cpuid(MOVBE) chk(nf0) p_00_66),
-    [0x66] = X86_OP_GROUP3(EVEX4_66, B,y, G,y, E,y,     evex_apx zextT0 zextT1 cpuid(ADX) chk(nf0) p_66_f3),
-    [0x69] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,z,        evex_apx_zu sextT0 p_00_66),
-    [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b,        evex_apx_zu sextT0 p_00_66),
-
-    [0x80] = X86_OP_GROUP3(group1,   B,b, E,b, I,b,     evex_apx p_00),
-    [0x81] = X86_OP_GROUP3(group1,   B,v, E,v, I,z,     evex_apx p_00_66),
-    [0x83] = X86_OP_GROUP3(group1,   B,v, E,v, I,b,     evex_apx p_00_66),
-    [0x84] = X86_OP_ENTRYrr(TEST,    E,b, G,b,          evex_apx_cmp p_00_66),
-    [0x85] = X86_OP_ENTRYrr(TEST,    E,v, G,v,          evex_apx_cmp p_00_66),
-    [0x88] = X86_OP_ENTRYwr(POPCNT,  G,v, E,v,          evex_apx cpuid(POPCNT) zextT0 p_00_66),
-    [0x8F] = X86_OP_GROUPw(EVEX4_8F, R,d64, /* B,d64 */ evex_apx_pp2 p_00),
-
-    [0xA4] = X86_OP_ENTRY4(SHLD,     B,v, E,v, G,v,     evex_apx p_00_66),
-    [0xA5] = X86_OP_ENTRY3(SHLD,     B,v, E,v, G,v,     evex_apx p_00_66),
-    [0xAC] = X86_OP_ENTRY4(SHRD,     B,v, E,v, G,v,     evex_apx p_00_66),
-    [0xAD] = X86_OP_ENTRY3(SHRD,     B,v, E,v, G,v,     evex_apx p_00_66),
-    [0xAF] = X86_OP_ENTRY3(IMUL3,    B,v, G,v, E,v,     evex_apx sextT0 sextT1 p_00_66),
-
-    [0xC0] = X86_OP_GROUP3(group2,   B,b, E,b, I,b,     evex_apx p_00),
-    [0xC1] = X86_OP_GROUP3(group2,   B,v, E,v, I,b,     evex_apx p_00_66),
-
-    [0xD0] = X86_OP_GROUPwr(group2,  B,b, E,b,          evex_apx p_00),
-    [0xD1] = X86_OP_GROUPwr(group2,  B,v, E,v,          evex_apx p_00_66),
-    [0xD2] = X86_OP_GROUP3(group2,   B,b, E,b, 1,b,     evex_apx p_00), /* CL */
-    [0xD3] = X86_OP_GROUP3(group2,   B,v, E,v, 1,b,     evex_apx p_00_66), /* CL */
-
-    [0xF0] = X86_OP_ENTRY2(CRC32,    G,d, E,b,          evex_apx cpuid(SSE42) chk(nf0) p_00),
-    [0xF1] = X86_OP_ENTRY2(CRC32,    G,d, E,v,          evex_apx cpuid(SSE42) chk(nf0) p_00_66),
-    [0xF4] = X86_OP_ENTRYwr(TZCNT,   G,v, E,v,          evex_apx zextT0 p_00_66),
-    [0xF5] = X86_OP_ENTRYwr(LZCNT,   G,v, E,v,          evex_apx zextT0 p_00_66),
-    [0xF6] = X86_OP_GROUP1(group3,   E,b),
-    [0xF7] = X86_OP_GROUP1(group3,   E,v),
-    [0xFE] = X86_OP_GROUP1(group4_5, E,b),
-    [0xFF] = X86_OP_GROUP1(EVEX4_FF, E,v),
-};
-
 static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
+    const X86OpEntry *row;
+
     *b = x86_ldub_code(env, s);
-    *entry = opcodes_EVEX_map4[*b];
+    row = decode_run(s, env, 4, b);
+    *entry = row ? *row : UNKNOWN_OPCODE;
 }
 #endif
 
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index 658cbe7f7b9..d30885a11e6 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -457,3 +457,200 @@ NP.0F3A CC                      SHA1RNDS4     Vdq,Wdq,Ib         cpuid(SHA_NI)
 VEX.66.0F3A DF                  VAESKEYGEN    Vdq,Wdq,Ib         E4 cpuid(AES, AVX)
 
 VEX|EVEX.F2.0F3A.LZ.NF0 F0      RORX          Gy,Ey,Ib           E13 cpuid(BMI2)
+
+
+// EVEX map 4 (APX)
+// ----------------
+//
+// Missing: ENQCMD, ENQCMDS, INVEPT, INVPCID, INVVPID, KMOVD, KMOVW, KMOVD, KMOVQ,
+// MOVDIR64B, MOVDIRI, URDMSR, UWRMSR, WRSSD, WRSSQ, WRUSSD, WRUSSQ, LDTILECFG,
+// STTILECFG, TILELOADD, TILELOADDDT1, TILESTORED.
+//
+// All of APX is only reachable in 64-bit mode.  maketable.py leaves the rows
+// of this map empty in 32-bit builds, so that they do not reference gen_*
+// emitters that are only defined for TARGET_X86_64.
+
+EVEX.NP.MAP4               00     ADD         Bb,Eb,Gb                   APX lock
+EVEX.NP|66.MAP4            01     ADD         Bv,Ev,Gv                   APX lock
+EVEX.NP.MAP4               02     ADD         Bb,Gb,Eb                   APX lock
+EVEX.NP|66.MAP4            03     ADD         Bv,Gv,Ev                   APX lock
+
+EVEX.NP.MAP4               08     OR          Bb,Eb,Gb                   APX lock
+EVEX.NP|66.MAP4            09     OR          Bv,Ev,Gv                   APX lock
+EVEX.NP.MAP4               0A     OR          Bb,Gb,Eb                   APX lock
+EVEX.NP|66.MAP4            0B     OR          Bv,Gv,Ev                   APX lock
+
+EVEX.NP.MAP4.NF0           10     ADC         Bb,Eb,Gb                   APX lock
+EVEX.NP|66.MAP4.NF0        11     ADC         Bv,Ev,Gv                   APX lock
+EVEX.NP.MAP4.NF0           12     ADC         Bb,Gb,Eb                   APX lock
+EVEX.NP|66.MAP4.NF0        13     ADC         Bv,Gv,Ev                   APX lock
+
+EVEX.NP.MAP4.NF0           18     SBB         Bb,Eb,Gb                   APX lock
+EVEX.NP|66.MAP4.NF0        19     SBB         Bv,Ev,Gv                   APX lock
+EVEX.NP.MAP4.NF0           1A     SBB         Bb,Gb,Eb                   APX lock
+EVEX.NP|66.MAP4.NF0        1B     SBB         Bv,Gv,Ev                   APX lock
+
+EVEX.NP.MAP4               20     AND         Bb,Eb,Gb                   APX lock
+EVEX.NP|66.MAP4            21     AND         Bv,Ev,Gv                   APX lock
+EVEX.NP.MAP4               22     AND         Bb,Gb,Eb                   APX lock
+EVEX.NP|66.MAP4            23     AND         Bv,Gv,Ev                   APX lock
+EVEX.NP|66.MAP4            24     SHLD        Bv,Ev,Gv,Ib                APX
+
+EVEX.NP.MAP4               28     SUB         Bb,Eb,Gb                   APX lock
+EVEX.NP|66.MAP4            29     SUB         Bv,Ev,Gv                   APX lock
+EVEX.NP.MAP4               2A     SUB         Bb,Gb,Eb                   APX lock
+EVEX.NP|66.MAP4            2B     SUB         Bv,Gv,Ev                   APX lock
+EVEX.NP|66.MAP4            2C     SHRD        Bv,Ev,Gv,Ib                APX
+
+EVEX.NP.MAP4               30     XOR         Bb,Eb,Gb                   APX lock
+EVEX.NP|66.MAP4            31     XOR         Bv,Ev,Gv                   APX lock
+EVEX.NP.MAP4               32     XOR         Bb,Gb,Eb                   APX lock
+EVEX.NP|66.MAP4            33     XOR         Bv,Gv,Ev                   APX lock
+
+EVEX.NP.MAP4               38     CMP         Eb(r),Gb                   APX_cmp
+EVEX.NP|66.MAP4            39     CMP         Ev(r),Gv                   APX_cmp
+EVEX.NP.MAP4               3A     CMP         Gb(r),Eb                   APX_cmp
+EVEX.NP|66.MAP4            3B     CMP         Gv(r),Ev                   APX_cmp
+
+// Conditional moves.  All the EVEX-promoted register-destination conditional
+// moves (all CFCMOV cases except "CFCMOV rm, r", and three-operand CMOV) have
+// zero-upper semantics.  Note that this is specific to CMOV/CFCMOV, and not
+// ZU!
+//
+// For ND=0, NF represents the direction.  For ND=1, NF represents fault
+// suppression.  The memory forms of CFCMOV use the M operand type so that
+// the emitter does the load or store only if needed.
+EVEX.NP|66.MAP4.ND0.NF0    40..4F CFCMOVcc_ld Gv(w,zx),ZEROv,Mv          APX
+EVEX.NP|66.MAP4.ND0.NF0    40..4F CMOVcc      Gv(w,zx),ZEROv,Rv          APX
+EVEX.NP|66.MAP4.ND0.NF1    40..4F CFCMOVcc_st Mv(w),Gv                   APX
+EVEX.NP|66.MAP4.ND0.NF1    40..4F CMOVcc      Rv(w,zx),ZEROv,Gv          APX
+EVEX.NP|66.MAP4.ND1.NF0    40..4F CMOVcc      Bv(w,zx),Gv,Ev             APX
+EVEX.NP|66.MAP4.ND1.NF1    40..4F CFCMOVcc_ld Bv(w,zx),Gv,Mv             APX
+EVEX.NP|66.MAP4.ND1.NF1    40..4F CMOVcc      Bv(w,zx),Gv,Rv             APX
+EVEX.F2.MAP4.NF0           40..4F SETcc       Eb(w)                      APX_zu
+
+// The memory forms of MOVBE use the M operand type, so that gen_MOVBE does
+// the load or store with MO_BE.  The register forms (not present in the
+// legacy encoding) use the R operand type, which is loaded or stored
+// normally, and gen_MOVBE then swaps the bytes of the loaded value.
+EVEX.NP|66.MAP4.NF0        60     MOVBE       Gv(w),Mv                   APX cpuid(MOVBE)
+EVEX.NP|66.MAP4.NF0        60     MOVBE       Gv(w),Rv                   APX cpuid(MOVBE)
+EVEX.NP|66.MAP4.NF0        61     MOVBE       Mv(w),Gv                   APX cpuid(MOVBE)
+EVEX.NP|66.MAP4.NF0        61     MOVBE       Rv(w),Gv                   APX cpuid(MOVBE)
+
+EVEX.66.MAP4.NF0           66     ADCX        By,Gy(zx),Ey(zx)           APX cpuid(ADX)
+EVEX.F3.MAP4.NF0           66     ADOX        By,Gy(zx),Ey(zx)           APX cpuid(ADX)
+EVEX.NP|66.MAP4            69     IMUL3       Gv,Ev(sx),Iz               APX_zu
+EVEX.NP|66.MAP4            6B     IMUL3       Gv,Ev(sx),Ib               APX_zu
+
+EVEX.NP.MAP4               80 /0  ADD         Bb,Eb,Ib                   APX lock
+EVEX.NP.MAP4               80 /1  OR          Bb,Eb,Ib                   APX lock
+EVEX.NP.MAP4.NF0           80 /2  ADC         Bb,Eb,Ib                   APX lock
+EVEX.NP.MAP4.NF0           80 /3  SBB         Bb,Eb,Ib                   APX lock
+EVEX.NP.MAP4               80 /4  AND         Bb,Eb,Ib                   APX lock
+EVEX.NP.MAP4               80 /5  SUB         Bb,Eb,Ib                   APX lock
+EVEX.NP.MAP4               80 /6  XOR         Bb,Eb,Ib                   APX lock
+EVEX.NP.MAP4               80 /7  CMP         Eb(r),Ib                   APX_cmp
+EVEX.NP|66.MAP4            81 /0  ADD         Bv,Ev,Iz                   APX lock
+EVEX.NP|66.MAP4            81 /1  OR          Bv,Ev,Iz                   APX lock
+EVEX.NP|66.MAP4.NF0        81 /2  ADC         Bv,Ev,Iz                   APX lock
+EVEX.NP|66.MAP4.NF0        81 /3  SBB         Bv,Ev,Iz                   APX lock
+EVEX.NP|66.MAP4            81 /4  AND         Bv,Ev,Iz                   APX lock
+EVEX.NP|66.MAP4            81 /5  SUB         Bv,Ev,Iz                   APX lock
+EVEX.NP|66.MAP4            81 /6  XOR         Bv,Ev,Iz                   APX lock
+EVEX.NP|66.MAP4            81 /7  CMP         Ev(r),Iz                   APX_cmp
+EVEX.NP|66.MAP4            83 /0  ADD         Bv,Ev,Ib                   APX lock
+EVEX.NP|66.MAP4            83 /1  OR          Bv,Ev,Ib                   APX lock
+EVEX.NP|66.MAP4.NF0        83 /2  ADC         Bv,Ev,Ib                   APX lock
+EVEX.NP|66.MAP4.NF0        83 /3  SBB         Bv,Ev,Ib                   APX lock
+EVEX.NP|66.MAP4            83 /4  AND         Bv,Ev,Ib                   APX lock
+EVEX.NP|66.MAP4            83 /5  SUB         Bv,Ev,Ib                   APX lock
+EVEX.NP|66.MAP4            83 /6  XOR         Bv,Ev,Ib                   APX lock
+EVEX.NP|66.MAP4            83 /7  CMP         Ev(r),Ib                   APX_cmp
+EVEX.NP|66.MAP4            84     TEST        Eb(r),Gb                   APX_cmp
+EVEX.NP|66.MAP4            85     TEST        Ev(r),Gv                   APX_cmp
+EVEX.NP|66.MAP4            88     POPCNT      Gv(w),Ev(zx)               APX cpuid(POPCNT)
+// The destinations are R and B.
+EVEX.NP.MAP4               8F /0  POP2        Rd64(w)                    APX_pp2
+
+EVEX.NP|66.MAP4            A4     SHLD        Bv,Ev,Gv,Ib                APX
+EVEX.NP|66.MAP4            A5     SHLD        Bv,Ev,Gv                   APX
+EVEX.NP|66.MAP4            AC     SHRD        Bv,Ev,Gv,Ib                APX
+EVEX.NP|66.MAP4            AD     SHRD        Bv,Ev,Gv                   APX
+EVEX.NP|66.MAP4            AF     IMUL3       Bv,Gv(sx),Ev(sx)           APX
+
+EVEX.NP.MAP4               C0 /0  ROL         Bb,Eb(zx),Ib               APX
+EVEX.NP.MAP4               C0 /1  ROR         Bb,Eb(zx),Ib               APX
+EVEX.NP.MAP4.NF0           C0 /2  RCL         Bb,Eb(zx),Ib               APX
+EVEX.NP.MAP4.NF0           C0 /3  RCR         Bb,Eb(zx),Ib               APX
+EVEX.NP.MAP4               C0 /4  SHL         Bb,Eb(zx),Ib               APX
+EVEX.NP.MAP4               C0 /5  SHR         Bb,Eb(zx),Ib               APX
+EVEX.NP.MAP4               C0 /6  SHL         Bb,Eb(zx),Ib               APX
+EVEX.NP.MAP4               C0 /7  SAR         Bb,Eb(sx),Ib               APX
+EVEX.NP|66.MAP4            C1 /0  ROL         Bv,Ev(zx),Ib               APX
+EVEX.NP|66.MAP4            C1 /1  ROR         Bv,Ev(zx),Ib               APX
+EVEX.NP|66.MAP4.NF0        C1 /2  RCL         Bv,Ev(zx),Ib               APX
+EVEX.NP|66.MAP4.NF0        C1 /3  RCR         Bv,Ev(zx),Ib               APX
+EVEX.NP|66.MAP4            C1 /4  SHL         Bv,Ev(zx),Ib               APX
+EVEX.NP|66.MAP4            C1 /5  SHR         Bv,Ev(zx),Ib               APX
+EVEX.NP|66.MAP4            C1 /6  SHL         Bv,Ev(zx),Ib               APX
+EVEX.NP|66.MAP4            C1 /7  SAR         Bv,Ev(sx),Ib               APX
+
+EVEX.NP.MAP4               D0 /0  ROL         Bb(w),Eb(zx)               APX
+EVEX.NP.MAP4               D0 /1  ROR         Bb(w),Eb(zx)               APX
+EVEX.NP.MAP4.NF0           D0 /2  RCL         Bb(w),Eb(zx)               APX
+EVEX.NP.MAP4.NF0           D0 /3  RCR         Bb(w),Eb(zx)               APX
+EVEX.NP.MAP4               D0 /4  SHL         Bb(w),Eb(zx)               APX
+EVEX.NP.MAP4               D0 /5  SHR         Bb(w),Eb(zx)               APX
+EVEX.NP.MAP4               D0 /6  SHL         Bb(w),Eb(zx)               APX
+EVEX.NP.MAP4               D0 /7  SAR         Bb(w),Eb(sx)               APX
+EVEX.NP|66.MAP4            D1 /0  ROL         Bv(w),Ev(zx)               APX
+EVEX.NP|66.MAP4            D1 /1  ROR         Bv(w),Ev(zx)               APX
+EVEX.NP|66.MAP4.NF0        D1 /2  RCL         Bv(w),Ev(zx)               APX
+EVEX.NP|66.MAP4.NF0        D1 /3  RCR         Bv(w),Ev(zx)               APX
+EVEX.NP|66.MAP4            D1 /4  SHL         Bv(w),Ev(zx)               APX
+EVEX.NP|66.MAP4            D1 /5  SHR         Bv(w),Ev(zx)               APX
+EVEX.NP|66.MAP4            D1 /6  SHL         Bv(w),Ev(zx)               APX
+EVEX.NP|66.MAP4            D1 /7  SAR         Bv(w),Ev(sx)               APX
+EVEX.NP.MAP4               D2 /0  ROL         Bb,Eb(zx),RCXb             APX
+EVEX.NP.MAP4               D2 /1  ROR         Bb,Eb(zx),RCXb             APX
+EVEX.NP.MAP4.NF0           D2 /2  RCL         Bb,Eb(zx),RCXb             APX
+EVEX.NP.MAP4.NF0           D2 /3  RCR         Bb,Eb(zx),RCXb             APX
+EVEX.NP.MAP4               D2 /4  SHL         Bb,Eb(zx),RCXb             APX
+EVEX.NP.MAP4               D2 /5  SHR         Bb,Eb(zx),RCXb             APX
+EVEX.NP.MAP4               D2 /6  SHL         Bb,Eb(zx),RCXb             APX
+EVEX.NP.MAP4               D2 /7  SAR         Bb,Eb(sx),RCXb             APX
+EVEX.NP|66.MAP4            D3 /0  ROL         Bv,Ev(zx),RCXb             APX
+EVEX.NP|66.MAP4            D3 /1  ROR         Bv,Ev(zx),RCXb             APX
+EVEX.NP|66.MAP4.NF0        D3 /2  RCL         Bv,Ev(zx),RCXb             APX
+EVEX.NP|66.MAP4.NF0        D3 /3  RCR         Bv,Ev(zx),RCXb             APX
+EVEX.NP|66.MAP4            D3 /4  SHL         Bv,Ev(zx),RCXb             APX
+EVEX.NP|66.MAP4            D3 /5  SHR         Bv,Ev(zx),RCXb             APX
+EVEX.NP|66.MAP4            D3 /6  SHL         Bv,Ev(zx),RCXb             APX
+EVEX.NP|66.MAP4            D3 /7  SAR         Bv,Ev(sx),RCXb             APX
+
+EVEX.NP.MAP4.NF0           F0     CRC32       Gd,Eb                      APX cpuid(SSE42)
+EVEX.NP|66.MAP4.NF0        F1     CRC32       Gd,Ev                      APX cpuid(SSE42)
+EVEX.NP|66.MAP4            F4     TZCNT       Gv(w),Ev(zx)               APX
+EVEX.NP|66.MAP4            F5     LZCNT       Gv(w),Ev(zx)               APX
+EVEX.NP.MAP4               F6 /0  TEST        Eb(r),Ib                   APX_cmp
+EVEX.NP.MAP4               F6 /1  TEST        Eb(r),Ib                   APX_cmp
+EVEX.NP.MAP4.NF0           F6 /2  NOT         Bb(w),Eb                   APX lock
+EVEX.NP.MAP4               F6 /3  NEG         Bb(w),Eb                   APX lock
+EVEX.NP.MAP4               F6 /4  MUL         Eb(r,zx),RAXb(zx)          APX
+EVEX.NP.MAP4               F6 /5  IMUL        Eb(r,sx),RAXb(zx)          APX
+EVEX.NP.MAP4               F6 /6  DIV         Eb(r)                      APX
+EVEX.NP.MAP4               F6 /7  IDIV        Eb(r)                      APX
+EVEX.NP|66.MAP4            F7 /0  TEST        Ev(r),Iz                   APX_cmp
+EVEX.NP|66.MAP4            F7 /1  TEST        Ev(r),Iz                   APX_cmp
+EVEX.NP|66.MAP4.NF0        F7 /2  NOT         Bv(w),Ev                   APX lock
+EVEX.NP|66.MAP4            F7 /3  NEG         Bv(w),Ev                   APX lock
+EVEX.NP|66.MAP4            F7 /4  MUL         Ev(r,zx),RAXv(zx)          APX
+EVEX.NP|66.MAP4            F7 /5  IMUL        Ev(r,sx),RAXv(zx)          APX
+EVEX.NP|66.MAP4            F7 /6  DIV         Ev(r)                      APX
+EVEX.NP|66.MAP4            F7 /7  IDIV        Ev(r)                      APX
+EVEX.NP.MAP4               FE /0  INC         Bb(w),Eb                   APX lock
+EVEX.NP.MAP4               FE /1  DEC         Bb(w),Eb                   APX lock
+EVEX.NP|66.MAP4            FF /0  INC         Bv(w),Ev                   APX lock
+EVEX.NP|66.MAP4            FF /1  DEC         Bv(w),Ev                   APX lock
+EVEX.NP.MAP4               FF /6  PUSH2       Bd64(r),Rd64               APX_pp2
-- 
2.56.0



