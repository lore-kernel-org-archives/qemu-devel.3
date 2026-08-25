Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D4FC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHv-0004kX-Tg; Tue, 25 Aug 2026 08:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHr-0004ji-3q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHp-0000NZ-6l
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6wRjevlWr6mabZHk5tPd3ynvi80Zfpo7zSUjaoAC1U=;
 b=bq2CE1HUZeKnfYQQAECO8USvASprKonzVoXvkLmzIZVIbNQ9w6STVucccd3lxO99wdSCAi
 uhhV5q3MyZXj8X6K2MzldfYZUG2L+NdjlDKJMffTfDHsPLoj5kQ2YGDtC5EhFI/IzOhiYo
 1RNGktHE7zBo1X6QswDGdSuKEDrHNCg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Wxf67T3NPTGXQeub-y5qWg-1; Tue, 25 Aug 2026 08:29:50 -0400
X-MC-Unique: Wxf67T3NPTGXQeub-y5qWg-1
X-Mimecast-MFC-AGG-ID: Wxf67T3NPTGXQeub-y5qWg_1787660989
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a22bf0so5212863a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660989; x=1788265789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I6wRjevlWr6mabZHk5tPd3ynvi80Zfpo7zSUjaoAC1U=;
 b=l74YQ6tOnkrYHH9oQEulT428n20uqXa6rP2Fjzf/0++ROH+/Bv/iucqEavGEGjxZwr
 XBjUrJKWnMopft1J5ZDnO7SnFiD7is4N4RZqfHTg1MGZl8n0WMuBwZjNoN05jrQ2jJpW
 QCk9kSQEpravvhn/jQZka7NjqxtS8y/yvwKT9KRb9LWnDDMP6SCSgwZ3nfyhqUCBtasj
 oAy5uBqmahLEOVRkWcuEkN4sTZb+Se3mWSIYjyrPoIOnCP2bX5aweHTSt4tpwSeTXdlL
 6ZOdpTtaR9YUIksiYZLVGSgNUeumuA37Ag7a5g/xdKIRUzmoaZLMej0uahFfPb+GuyIq
 bs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660989; x=1788265789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I6wRjevlWr6mabZHk5tPd3ynvi80Zfpo7zSUjaoAC1U=;
 b=qRi2wUGbrf+ubeCP4T6rPw3HJBQ+/wW595AgTum2XyfQZ5gT0urVqgFXmG4YtfHO87
 tiWxeemZdFcHbtTSY/No2upswVwpaUJT1UVSlNOblQYt9HLACUvCgNMFz9Md5d3jPDmK
 aF2Vn9akn3lVXReRTpsQ31sYgMC6nyRfeGy+DcbLZCyXB5PN7LqJZweBLiiTDqlIko75
 qJUgIvEEX6PBtRDpPV0J9xT/89SkLyYATcqO+bu9laTpECyu0aXTV3FS/oBy0O62p0Mt
 W509yg+GCNQE805MqtVPjY2AsvG7OVOpwqbSpe8tcqFEjxq1VV1/C26N1/es1HuwhsvD
 9kEw==
X-Gm-Message-State: AFuF++lyqSR65yZd8InuMpNTODnj3vVKwdlV+DMWqFqPasHShqViWUQe
 9InwYGMZKpw0zAnX+MpD0JY2asqPuwIsrOxR7+X69jVQkDYcJIqfCIqF2G6MOPrknlzMP6SRLPg
 ScjbRFJNhOTkknoqXhDqieujqd3xexmsWz0pvYqloLhDdB657++bmIy1mJzPBRlrGsHOUjCj4Jr
 WIB9Sd+SpkdcvB3lrhZ1lthyk0f/EZU8BIFrg8NClw
X-Gm-Gg: AR+sD134aEYOZrNyrX9Xwc3U392tTAoQpIDDElo2j5PTN6QJhbAcHfEcBj4TUR/WuDq
 5aHJC2kUaurImXRuyUYmpyvmNhUupOkqtya45Up0wsjKN4cGcyJnIlpHqHSXp5fNFueJKgkKJid
 GPIFxV+wEC8SvdGQ+M1AeSUyTVeKdl/mZl9d8qIc3uEFtH/v8/gIcDM62d23ErTVtGnpTwOZXui
 fhKgLpcBPAdetkT7SlS37d62pINXZk2QYNWUiUFV17414Q/pRfR5MMdzCrUxOVW4mVIkgZ6GB1+
 NdadmPUtXw5mPK7JsOu3qVuVqMTKj/GyFXbwz8US8XPZvsfo6sHuxPT2To2kvA0D0SDN4YQ1wno
 mTQvE9hvQtE+Ug61w8Gz3YGn0QH9mrzbx+yBBhFmP6iWRoNinE5gxoxyjhqNqLD+TCuhQIUCx1r
 jCMe4=
X-Received: by 2002:a05:6402:24c3:b0:6a3:eb92:8554 with SMTP id
 4fb4d7f45d1cf-6a42f216d74mr32428514a12.10.1787660989210; 
 Tue, 25 Aug 2026 05:29:49 -0700 (PDT)
X-Received: by 2002:a05:6402:24c3:b0:6a3:eb92:8554 with SMTP id
 4fb4d7f45d1cf-6a42f216d74mr32428434a12.10.1787660988429; 
 Tue, 25 Aug 2026 05:29:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59dd550bcsm14256365a12.0.2026.08.25.05.29.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/20] target/i386/tcg: fetch modrm early
Date: Tue, 25 Aug 2026 14:29:12 +0200
Message-ID: <20260825122921.431739-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index d215d28cec5..2033776ce1c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2086,9 +2086,8 @@ static int reg_nb_mask(DisasContext *s, int unit)
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
 
@@ -2297,11 +2296,33 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
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
@@ -2317,7 +2338,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
         op->unit = X86_OP_CR;
-        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        op->n = ((s->modrm >> 3) & 7) | REX_R(s);
         if (op->n == 0 && (s->prefix & PREFIX_LOCK) &&
             (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
             op->n = 8;
@@ -2333,7 +2354,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_D:  /* REG in the modrm byte selects a debug register */
         op->unit = X86_OP_DR;
-        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        op->n = ((s->modrm >> 3) & 7) | REX_R(s);
         if (op->n >= 8) {
             /*
              * illegal opcode.  The DR4 and DR5 case is checked in the generated
@@ -2352,14 +2373,14 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
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
 
@@ -2371,7 +2392,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
             op->unit = X86_OP_SSE;
         }
     get_reg:
-        op->n = ((get_modrm(s, env) >> 3) & 7);
+        op->n = ((s->modrm >> 3) & 7);
         op->n |= REX_R(s) & reg_nb_mask(s, op->unit);
         break;
 
@@ -2408,8 +2429,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     case X86_TYPE_R:  /* R/M in the modrm byte selects a register */
         op->unit = X86_OP_INT;
     get_modrm_reg:
-        modrm = get_modrm(s, env);
-        if ((modrm >> 6) != 3) {
+        if ((s->modrm >> 6) != 3) {
             return false;
         }
         goto get_modrm;
@@ -2423,8 +2443,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         /* fall through */
     case X86_TYPE_M:  /* modrm byte selects a memory operand */
     get_modrm_mem:
-        modrm = get_modrm(s, env);
-        if ((modrm >> 6) == 3) {
+        if ((s->modrm >> 6) == 3) {
             return false;
         }
         /* fall through */
@@ -2532,7 +2551,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         return false;
     }
 
-    /* First compute size of operands in order to initialize s->rip_offset.  */
+    /* Compute size of operands here in order to initialize s->rip_offset.  */
     if (e->op0 != X86_TYPE_None) {
         if (!decode_op_size(s, e, e->s0, &decode->op[0].ot)) {
             return false;
@@ -2565,6 +2584,13 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
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
@@ -3096,6 +3122,15 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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


