Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EB1FD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0Q-0000Ki-RT; Sun, 01 Mar 2026 09:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0K-0000Jp-GD
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0I-0005jJ-OX
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdDc4qndHc5H6nxB+5xYth9Be8C8ZEs/W9FPzkVwAYA=;
 b=XeKay0AG/PRap4KGMJ1enzuIq+J30kr8s+P2q9sJbadCaQIdVMmhQXKrIHssnWWiEo4VEF
 GQoHbQP0pfs6to22BcjGbD80fQTI/D3SzNWbiChBB0qAk/QluOM5kX7JY2l7wjCnOpZmFP
 FSlNHypcdclqltcESZ3KAEa6LDdRXDg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-NJVt3-xXNE6GIBNv0Y3T6A-1; Sun, 01 Mar 2026 09:42:40 -0500
X-MC-Unique: NJVt3-xXNE6GIBNv0Y3T6A-1
X-Mimecast-MFC-AGG-ID: NJVt3-xXNE6GIBNv0Y3T6A_1772376159
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836b7c302fso37428785e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376159; x=1772980959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BdDc4qndHc5H6nxB+5xYth9Be8C8ZEs/W9FPzkVwAYA=;
 b=GyJFWdQbvxTVVjx/NMAnet6dDidxZPjdxqph0E+E+lCXapgU/3zSi2P72x2Enwlksj
 wX8NLbQVzFo4OzWs1HPp6dNSrmoSkU1N+9XKn32O42i1wzvCqH46QPOmV8PbXQTn82WO
 4r/vAVZWq7Jeal2rvjfp6CEeHAjLybmnI+6uD/Srfeya7r4ZyylFMtaBWDW3p8p2OYLq
 AjQRMkK/d/XG4mJVLPZU5uof9XPpVBb+jwieUirXc8gJVjmsiODuWCne6NIgXZ85/mhT
 7oZjsF6rSQ3IPgstotq15lbkvOtjQI90ok54zKVcrs+6omdvw2pAzqfnkWyN4kTpLPWK
 FLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376159; x=1772980959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BdDc4qndHc5H6nxB+5xYth9Be8C8ZEs/W9FPzkVwAYA=;
 b=GXy1Nm0Gx/NYR/hoGf+Chmk1QHRRBXwZpe4P0+yq4CbiWZHZjsZeLfN6QWg1wt/u9N
 +D+pRf+kIOm0FFgnWrNlbhs59Y2q9RK6EZPZsth5Cm32fGOKABbZYgcp7yWp/FIWsK31
 vHP1fPd3TF/IGrcWmHuzfSipMe0p5WYinsaCskpnxgQvdSJgoCB+T61pbM4Prva5rlfr
 xRXeQHGskyPOn4vHxz0JMBcIhW4//spWwV7RnNYaxuoXQZHlg9SefbkSpwDz07p6CHjG
 D3L7EKkhPAP+rvBKaRjn8D/E/eHd+5dwnH8PED0FVoVfyWXBCPnCqBbHFXkgOpgU7sZl
 1H/Q==
X-Gm-Message-State: AOJu0YxdLv/z565ffbWpMnDD7RwnFV0/NAc8QuG9hq1TPr2oAUAN5TtQ
 rsmoCY4bDb0svTN0a63SLYRxlB06YZrYZFlbYRtewo5r+UNmOM8REI1YHInxSmOgfd9xI2cjQUF
 19AIMVmFriRgDS04ZrC8IQFmx0nUNfjK6VXaFJLon23GzGgjt1cF1bB7VLyv46G15sLmUPblMGF
 ZMReb7/j9pom/a6FT1wAbKyBTY0wwH31KVtfd8srze
X-Gm-Gg: ATEYQzy+NQuKOxt8coWYJRPSvHoubarXQLtqLIhF9ucLJ7a5Hjk+qsvfpRpXRrpiQNG
 idL4HaOFd6qyH8aF8BPvKEP7ocTLXx+WnXA09DHlHPP7oe6/2X0E9xT9rQHb+JWc/nChezlAgPi
 YwOxjxXblhkEOoTSomEJHJeNhSLNpN9ZbU6+kt+qoPQN79GjIUlKqsnvGnD9H5vWPhBXucHaNsa
 qb1F98pDuG9pqGQS/LcGm7ZwalBAt1YqV3v49c6q70HT2g8P1H9xuE68YlnniMOzkUN1v3mbZG6
 z5uC3XHwIiwDBnUk74iBzHts1GL8dgf9L6avWuCfT1EUrS5g3svPOS2Y7KfNlvLmK6NlgeMCk1r
 CgVTMU0aMI90t7Mlg3Dzn6RILqDz7jt8zc4ddLhi1dBlH5kIQgjDIdzkS5RRYx1wJamjia7Z+lA
 49/hxhO4hAXAEvryq0GSxRCAd75Jg=
X-Received: by 2002:a05:600c:3111:b0:483:78c5:d743 with SMTP id
 5b1f17b1804b1-483c9c2baa9mr164392655e9.28.1772376158733; 
 Sun, 01 Mar 2026 06:42:38 -0800 (PST)
X-Received: by 2002:a05:600c:3111:b0:483:78c5:d743 with SMTP id
 5b1f17b1804b1-483c9c2baa9mr164392125e9.28.1772376158139; 
 Sun, 01 Mar 2026 06:42:38 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf673sm134951505e9.19.2026.03.01.06.42.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/18] target/i386/tcg: fetch modrm early
Date: Sun,  1 Mar 2026 15:42:08 +0100
Message-ID: <20260301144218.458140-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index d8a5025ac07..3205a046a6b 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2085,9 +2085,8 @@ static int reg_nb_mask(DisasContext *s, int unit)
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
 
@@ -2296,11 +2295,33 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
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
@@ -2316,7 +2337,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
         op->unit = X86_OP_CR;
-        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        op->n = ((s->modrm >> 3) & 7) | REX_R(s);
         if (op->n == 0 && (s->prefix & PREFIX_LOCK) &&
             (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
             op->n = 8;
@@ -2332,7 +2353,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_D:  /* REG in the modrm byte selects a debug register */
         op->unit = X86_OP_DR;
-        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        op->n = ((s->modrm >> 3) & 7) | REX_R(s);
         if (op->n >= 8) {
             /*
              * illegal opcode.  The DR4 and DR5 case is checked in the generated
@@ -2351,14 +2372,14 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
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
 
@@ -2370,7 +2391,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
             op->unit = X86_OP_SSE;
         }
     get_reg:
-        op->n = ((get_modrm(s, env) >> 3) & 7);
+        op->n = ((s->modrm >> 3) & 7);
         op->n |= REX_R(s) & reg_nb_mask(s, op->unit);
         break;
 
@@ -2407,8 +2428,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     case X86_TYPE_R:  /* R/M in the modrm byte selects a register */
         op->unit = X86_OP_INT;
     get_modrm_reg:
-        modrm = get_modrm(s, env);
-        if ((modrm >> 6) != 3) {
+        if ((s->modrm >> 6) != 3) {
             return false;
         }
         goto get_modrm;
@@ -2422,8 +2442,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         /* fall through */
     case X86_TYPE_M:  /* modrm byte selects a memory operand */
     get_modrm_mem:
-        modrm = get_modrm(s, env);
-        if ((modrm >> 6) == 3) {
+        if ((s->modrm >> 6) == 3) {
             return false;
         }
         /* fall through */
@@ -2531,7 +2550,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         return false;
     }
 
-    /* First compute size of operands in order to initialize s->rip_offset.  */
+    /* Compute size of operands here in order to initialize s->rip_offset.  */
     if (e->op0 != X86_TYPE_None) {
         if (!decode_op_size(s, e, e->s0, &decode->op[0].ot)) {
             return false;
@@ -2564,6 +2583,13 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
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
@@ -3087,6 +3113,15 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
2.52.0


