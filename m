Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BC1C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzas4-0002uA-8j; Thu, 27 Aug 2026 10:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzas2-0002tb-N9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzart-0005vP-8w
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pLSMCLpxSN80qw8SiP74TkTNU4AhuCBzxyGia3kBIw=;
 b=GUbUNoUWUCb1qOHrbpNMJ1W/zdYpoEgbjBTvJ4rdE16KWw6mc2xM5HAxoMXu9RpkgcILqM
 Oyff2OCgPOS121lmyu8DPg4Rkiq2lH1ZTWjX1Op4Li3pwQM9EnfFlJ/UkQig/Hu2E17lIC
 EAejOMGoM20dphw7e46gtI3K5grYd3I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-4-lIyT5hN7C8UEqR7Rbc2g-1; Thu, 27 Aug 2026 10:14:11 -0400
X-MC-Unique: 4-lIyT5hN7C8UEqR7Rbc2g-1
X-Mimecast-MFC-AGG-ID: 4-lIyT5hN7C8UEqR7Rbc2g_1787840050
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c2192261d79so249401766b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840050; x=1788444850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1pLSMCLpxSN80qw8SiP74TkTNU4AhuCBzxyGia3kBIw=;
 b=IjdCTQG7pMw1rdcWXoOce/mVTyg8VgQs78ZHaG3JOXmfRNzvQ2cZTAlCsMW5ntShcr
 88HsV0XOPxSD3grnTMZaQmFAyJyZ0s/w8kvk8fqS3MLGQF+l1z30k7x2KKuEeooplj+J
 U2v7uM8VEoMq3Yjxa3dGevOZbyCVCduOOHHPGf670ndYlGrNtHXE4n72JFc+4gBK2Vi+
 twa4bFHt1P/7J9Ju7suS5POdj294qO6WaDHPVgDbPAzoJ3RzAI1hyBj3f/EpYV3fyQEG
 8gXh3fhr6xUqWqwvyNIvWEF8JSAlqthxsQj92Y1IN2nUUIrUV5D/J8mfZygx5tbPz3fZ
 WIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840050; x=1788444850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1pLSMCLpxSN80qw8SiP74TkTNU4AhuCBzxyGia3kBIw=;
 b=EeeWi9XdxjbNsn/Z9KXZZJg49b5n7gc+70T9FhII5XZrlzJuT9sR81+2yr+kdFi3lS
 3KBd2Rlu8ZlqidVsf+rti3ZzV5ZYlV7AAlWTUImWyPPvpvLvhl2F9x6Ajl/i4Ay7pjEk
 WYl5ppk3npUpv2pjB3CsDTOXudczcoQsvCWssWo74IygJwtthQ5yon421OVJY8XoZLHo
 o9gecj1KyQGm5Q4IAl8YzeKtkeW77nG9fmZ01VqC+TJtTp6aHaHw6dI2NfNtdWPJi5cs
 /rrwDWANLJpJ/74NXpXE6SoGdAFK/+VBD/gYFTmf5fY/hmQcU1k98z4tOi/7j06E1NMf
 d0CA==
X-Gm-Message-State: AFuF++nk8Rnaqia59z1xieTa08vpVSkjA7W2Z/8vO7suaIHBtoQVvt2Y
 0wQs9SKFhikBzi0ewyrSAX41dn8JxI7S5o9dUCz5CIY1TOuNQsPBCxpH/TY3x/pB+DkSF7QMxFp
 1jdMxi+3lWoDsjXeMRc2q1d+MjlkwSRZf99nO4Vbaws5x2Qk6/H9mklOCjPTJQT7Ug62Ufjffq/
 g2fiefBvaqH2de9us7SaIjIYU7xx2Oj+uZoGo9u8dX
X-Gm-Gg: AR+sD12cJV8U6l1MEMHQkmzi88Cm1oOm/pTRrYjQP+/+K4k/+5v6q9XxFK+7FrNg4Dg
 2QV/o9wVUK32+tv9ennFJvTSpT53ram6kbAp/cWxDrDm5zk4SLhOB8/RdGwXaC5ocpFWKVpNVq8
 +JL9QxnfvOIj760h17WQPVHvQRFVN3rl4sh+tDVvKCnlPnk3BdDE2LKGJLSnvRgJ/PBWCY4MdQT
 ScL4iRpm04kPitmIS3nE5vZE+ZemthbMoiyLfGHsSeQjdYbMINuIe2Kb5s/3DL0qZPOBrW8EkR/
 XOW+eFkpVcb9ezEZAzaQSJTpyYzVl5e8f38FTjjKDbxKGRaK47cLDEGxhmHpg+9lcWiLfUDQHDM
 j2Aamr3/ImMu8crPzEffk8NxaNdBZ05r6+ybVqEr5BV78DOxtaHTtrL7bWONrB9q+1KpYEOv48X
 ht5Jc=
X-Received: by 2002:a17:907:3d0c:b0:c25:37e2:2d3b with SMTP id
 a640c23a62f3a-c2537e230c6mr534568666b.10.1787840049686; 
 Thu, 27 Aug 2026 07:14:09 -0700 (PDT)
X-Received: by 2002:a17:907:3d0c:b0:c25:37e2:2d3b with SMTP id
 a640c23a62f3a-c2537e230c6mr534561766b.10.1787840048909; 
 Thu, 27 Aug 2026 07:14:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9e96bdsm584567466b.55.2026.08.27.07.14.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:14:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/23] target/i386/tcg: fetch modrm early
Date: Thu, 27 Aug 2026 16:13:06 +0200
Message-ID: <20260827141314.1099352-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

As a first step towards handling EVEX prefixes, fetch the modrm
byte before decode_ops().  This way, EVEX validation can use the
mod bits: for example, APX instructions require X4=0 if the r/m
operand is a register.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 65 ++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 47bc30a22fc..f5f36ef1731 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2012,9 +2012,8 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 static void decode_modrm(DisasContext *s, CPUX86State *env,
                          X86DecodedInsn *decode, X86DecodedOp *op)
 {
-    int modrm = get_modrm(s, env);
-    int mod = (modrm >> 6) & 3;
-    int rm = modrm & 7;
+    int mod = (s->modrm >> 6) & 3;
+    int rm = s->modrm & 7;
     bool is_vsib = decode->e.vex_class == 12;
     int sib = -1;
 
@@ -2226,11 +2225,33 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
     }
 }
 
+static bool op_has_modrm(X86OpType type)
+{
+    switch (type) {
+    case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
+    case X86_TYPE_D:  /* REG in the modrm byte selects a debug register */
+    case X86_TYPE_E:  /* ALU modrm operand */
+    case X86_TYPE_EM:  /* modrm byte selects an ALU memory operand */
+    case X86_TYPE_G:  /* REG in the modrm byte selects a GPR */
+    case X86_TYPE_M:  /* modrm byte selects a memory operand */
+    case X86_TYPE_nop:  /* modrm operand decoded but not fetched */
+    case X86_TYPE_N:  /* R/M in the modrm byte selects an MMX register */
+    case X86_TYPE_P:  /* REG in the modrm byte selects an MMX register */
+    case X86_TYPE_Q:  /* MMX modrm operand */
+    case X86_TYPE_R:  /* R/M in the modrm byte selects a register */
+    case X86_TYPE_U:  /* R/M in the modrm byte selects an XMM/YMM register */
+    case X86_TYPE_V:  /* reg in the modrm byte selects an XMM/YMM register */
+    case X86_TYPE_WM:  /* modrm byte selects an XMM/YMM memory operand */
+    case X86_TYPE_W:  /* XMM/YMM modrm operand */
+        return true;
+    default:
+        return false;
+    }
+}
+
 static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
                       X86DecodedOp *op, X86OpType type, int b)
 {
-    int modrm;
-
     switch (type) {
     case X86_TYPE_None:  /* Implicit or absent */
     case X86_TYPE_A:  /* Implicit */
@@ -2246,7 +2267,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
         op->unit = X86_OP_CR;
-        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        op->n = ((s->modrm >> 3) & 7) | REX_R(s);
         if (op->n == 0 && (s->prefix & PREFIX_LOCK) &&
             (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
             op->n = 8;
@@ -2262,7 +2283,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_D:  /* REG in the modrm byte selects a debug register */
         op->unit = X86_OP_DR;
-        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        op->n = ((s->modrm >> 3) & 7) | REX_R(s);
         if (op->n >= 8) {
             /*
              * illegal opcode.  The DR4 and DR5 case is checked in the generated
@@ -2281,14 +2302,14 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_S:  /* reg selects a segment register */
         op->unit = X86_OP_SEG;
-        op->n = (get_modrm(s, env) >> 3) & 7;
+        op->n = (s->modrm >> 3) & 7;
         /* Values outside [CDEFGS]S, as well as storing to CS, are invalid.  */
         if (op->n >= 6 || (op->n == R_CS && op == &decode->op[0])) {
             return false;
         }
         break;
 
-    case X86_TYPE_P:
+    case X86_TYPE_P:  /* REG in the modrm byte selects an MMX register */
         op->unit = X86_OP_MMX;
         goto get_reg;
 
@@ -2300,7 +2321,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
             op->unit = X86_OP_SSE;
         }
     get_reg:
-        op->n = ((get_modrm(s, env) >> 3) & 7);
+        op->n = ((s->modrm >> 3) & 7);
         if (op->unit != X86_OP_MMX) {
             op->n |= REX_R(s);
         }
@@ -2339,8 +2360,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     case X86_TYPE_R:  /* R/M in the modrm byte selects a register */
         op->unit = X86_OP_INT;
     get_modrm_reg:
-        modrm = get_modrm(s, env);
-        if ((modrm >> 6) != 3) {
+        if ((s->modrm >> 6) != 3) {
             return false;
         }
         goto get_modrm;
@@ -2354,8 +2374,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         /* fall through */
     case X86_TYPE_M:  /* modrm byte selects a memory operand */
     get_modrm_mem:
-        modrm = get_modrm(s, env);
-        if ((modrm >> 6) == 3) {
+        if ((s->modrm >> 6) == 3) {
             return false;
         }
         /* fall through */
@@ -2463,7 +2482,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         return false;
     }
 
-    /* First compute size of operands in order to initialize s->rip_offset.  */
+    /* Compute size of operands here in order to initialize s->rip_offset.  */
     if (e->op0 != X86_TYPE_None) {
         if (!decode_op_size(s, e, e->s0, &decode->op[0].ot)) {
             return false;
@@ -2496,6 +2515,13 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         assert(e->op3 == X86_TYPE_I && e->s3 == X86_SIZE_b);
         s->rip_offset += 1;
     }
+    return true;
+}
+
+static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
+                       X86DecodedInsn *decode)
+{
+    X86OpEntry *e = &decode->e;
 
     if (e->op0 != X86_TYPE_None &&
         !decode_op(s, env, decode, &decode->op[0], e->op0, decode->b)) {
@@ -2993,6 +3019,15 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
     }
 
+    if (op_has_modrm(decode.e.op0) || op_has_modrm(decode.e.op1) ||
+        op_has_modrm(decode.e.op2)) {
+        get_modrm(s, env);
+    }
+
+    if (!decode_ops(s, env, decode_func, &decode)) {
+        goto illegal_op;
+    }
+
     switch (decode.e.special) {
     case X86_SPECIAL_None:
         break;
-- 
2.55.0


