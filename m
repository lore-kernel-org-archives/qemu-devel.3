Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D119CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB37-0007EV-Dh; Mon, 28 Sep 2026 09:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1O-0005jm-9t
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1J-0004RF-Pu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52e4faWssyxGURsVURAPVwvV3RY7QYsEwLZ4TKxGv/Y=;
 b=GBi4gdWOux1lK7KZqM/urvmMK+B+0Wx140iqAFn2LMbV9wuAgl8e0OZz33df+9xn3ehcbA
 YAOz+KR6yJ+n+QgSF9+s8xdLOTgosgm7ZyuGo8i0TrsOQSO31KfisPN51aLmkzlew8UwmQ
 4MWgp/CQjoZAo1YZm4FyAc5edatPo/M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-8116foH-OwWTR0esj9RLRA-1; Mon, 28 Sep 2026 09:03:46 -0400
X-MC-Unique: 8116foH-OwWTR0esj9RLRA-1
X-Mimecast-MFC-AGG-ID: 8116foH-OwWTR0esj9RLRA_1790600625
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c29bc25836fso318040266b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600625; x=1791205425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=52e4faWssyxGURsVURAPVwvV3RY7QYsEwLZ4TKxGv/Y=;
 b=EDDfBb/Sw3nvWJN90XB9enYzBg2++B2XAk0afPalthairSVDJaxIiQvH2ddEhRSYts
 QFaBcVjEqJaBTQTqrM7PBRj6q8eP7dLh9n5hjdVGQcD2iLNodAEA8XLqEeoZRhzp0RNB
 HlopvPiazwoTL+ibNi7xh/1sSmtUglQtrdwXq909Q1/E+e42jiC3EEX9fsTgfA2Dxn7o
 lMQ8P7bmlgmngGVF2n0t7D/fPZNQLoiKWA2oKsVhaq6XdRykh9M4Hb6HOUrO1eG/gJHo
 TC7aKE4VpTchkY6WaZMqFHpF7pooOvT0DnoNqtwCKLg7A+fYKyoJgU76yLngkJUrxvdU
 1v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600625; x=1791205425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=52e4faWssyxGURsVURAPVwvV3RY7QYsEwLZ4TKxGv/Y=;
 b=FZSGF4Vrdy76QzHCn/g2M5AUlhZXDVxXsprghL9Xx+Y+sKFSz3bnx7nn3y+qSnfIOd
 2ucZkMpElhoFP0OneRP6cVBSIqcHaTwV6f6A4uVhqsSDJr0tL8ZXx8MfCDuheNQSvWMH
 WQL32U9Hv0ViI3x2YcKx0X7OjcFrmbd+ZMuBImYSoncQCEXASY7fplZ67/gJgMZrGb45
 Wpy2XXJeW/Kc77PzFTtA3nQe6rKRnqiHwn/O3dtpRm6s4mruitcI1w1VjD0bNS7KSrXa
 1IgBkgMI2OApuTn4NzYK8tsNKxjZAdKZjXVl8aHWaEDfO3UN5MFt1Cw/hyMjXF3r9k4M
 3fBg==
X-Gm-Message-State: AFuF++nf9TkUmMu07EaYEToj/5n5M7qJBoGnoeXQGYaSE26S8Aky4jUH
 Dslz2z8DeYXJGoEbcBoTo7WCFDY+uUucwoNQfSLBGmrpT/HxNtoERL2xVJp2UGzCvNa6NvAIZZi
 +ytutd+KWWjDN/hmSV+80WhiHIXjfS644JMsY4r5p4o1H4Opa/dvUVGHhm7eM+jafIgSra0vMh8
 +OuH3jdj0gf4IF4tVCa6q16AR29g0BQaaj99/tZ+wK
X-Gm-Gg: AYBFou2IJ443XAt+B020BU/jDFBosoRe21dSGpAa11PAmzRRRWp/433kZ4EmLsPxLvL
 ddXQnlg+AJd4pRgKpGlWUdYYe6s3a/qWj9Vz6BmSkNShl71NRN+ZyYYXFiywgNTydKQ2nDTNJjI
 MBgcWySTJH4laHNGrkH9y6zvOutnzP7XniUBpZdZ6j1AoQqQsHQn6yj8+Hl0fGCyNodeQNFNH7q
 KDm79s8E+2IroirxBYWyL60S0g7KdMHgnlu0kW2+91awC+ppkPcigkAt4rNWEFJP6OId/2DKIsX
 gVicgPMk2z9KBOTrVBdTrZMd+ZElD5ero8VVrZ/yFtnGhlPZoj3/SihRZDBMCvWiWILTkjpviCD
 +JxtIE9EqpIJKR0Uc5057MY+oMZ8kq+RAn6x7Z7Xf2FrLD/gM/Rf8QpmNznHoBLP9uQ==
X-Received: by 2002:a17:906:9fcc:b0:c2a:34fe:ea4d with SMTP id
 a640c23a62f3a-c2ae9f315a8mr748455966b.25.1790600619746; 
 Mon, 28 Sep 2026 06:03:39 -0700 (PDT)
X-Received: by 2002:a17:906:9fcc:b0:c2a:34fe:ea4d with SMTP id
 a640c23a62f3a-c2ae9f315a8mr748452266b.25.1790600619076; 
 Mon, 28 Sep 2026 06:03:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dec56dac3sm37192266b.9.2026.09.28.06.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/30] target/i386/tcg: extend VEX.vvvv parsing for APX
Date: Mon, 28 Sep 2026 15:02:20 +0200
Message-ID: <20260928130228.877003-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

BMI uses operand type B when VEX.vvvv provides one of the register indices
of three-operand instructions.  However, APX needs to use it even for
two-operand instructions, similar to how SSE and AVX share destination
but use the modrm operand when there is no VEX prefix.

To do this , operand type B can mostly reuse the code for operand type H
but there are two extra possibilities:

- instructions with VEX/EVEX prefix but no new data destination.  To handle
  this, use a new field s->vex_ndd to retrieve whether the B (or H) operand
  comes from VEX.vvvv or from modrm.  For now, this uses the same existing
  logic from validate_vex(), but later it will be extended to read EVEX.NDD.

- instructions with operands "m,r" that NDD extends to "r,m,r".
  In this case, in the non-NDD format "m,r" the B operand corresponds to
  a memory location; when this happens, it is incorrect to parse again
  op1 as a memory location, because that would read the displacement again
  from the instruction stream.  Instead, transform op1 into X86_TYPE_2op
  if VEX.vvvv is the destination operand.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  1 +
 target/i386/tcg/decode-new.c.inc | 38 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 99c74e4d5d5..4e012521bd9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -105,6 +105,7 @@ typedef struct DisasContext {
 #endif
     uint8_t vex_l;  /* vex vector length */
     uint8_t vex_v;  /* vex vvvv register, without 1's complement.  */
+    bool vex_ndd; /* is this a 3-operand instruction? */
     uint8_t popl_esp_hack; /* for correct popl with esp base handling */
     uint8_t rip_offset; /* only used in x86_64, but left for simplicity */
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index b42a4fd47dd..5289df7d6eb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2333,10 +2333,9 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     case X86_TYPE_Y:  /* string destination */
         break;
 
-    case X86_TYPE_B:  /* VEX.vvvv selects a GPR */
+    case X86_TYPE_B:  /* VEX.vvvv selects a GPR, else use modrm */
         op->unit = X86_OP_INT;
-        op->n = s->vex_v;
-        break;
+        goto get_vex_v;
 
     case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
         op->unit = X86_OP_CR;
@@ -2466,18 +2465,25 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         };
         break;
 
-    case X86_TYPE_H:  /* For AVX, VEX.vvvv selects an XMM/YMM register */
-        if ((s->prefix & PREFIX_VEX)) {
-            op->unit = X86_OP_SSE;
+    case X86_TYPE_H:  /* VEX.vvvv selects an XMM/YMM register, else use modrm */
+        op->unit = X86_OP_SSE;
+    get_vex_v:
+        if (s->vex_ndd) {
+            assert(s->prefix & PREFIX_VEX);
             op->n = s->vex_v;
             break;
         }
+        /* Two-operand form: the other one of op0 and op1 is a modrm operand, use it. */
+        assert(decode->e.s1 == decode->e.s0);
         if (op == &decode->op[0]) {
-            /* shifts place the destination in VEX.vvvv, use modrm */
-            return decode_op(s, env, decode, op, decode->e.op1, b);
+            if (!decode_op(s, env, decode, op, decode->e.op1, b)) {
+                return false;
+            }
+            decode->e.op1 = X86_TYPE_2op;
         } else {
-            return decode_op(s, env, decode, op, decode->e.op0, b);
+            *op = decode->op[0];
         }
+        break;
 
     case X86_TYPE_I:  /* Immediate */
     case X86_TYPE_J:  /* Relative offset for a jump */
@@ -2723,6 +2729,14 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 {
     X86OpEntry *e = &decode->e;
 
+    if (s->prefix & PREFIX_VEX) {
+        if (e->op0 == X86_TYPE_H || e->op0 == X86_TYPE_B ||
+            e->op1 == X86_TYPE_H || e->op1 == X86_TYPE_B ||
+            e->op2 == X86_TYPE_H || e->op2 == X86_TYPE_B) {
+            s->vex_ndd = true;
+        }
+    }
+
     switch (e->vex_special) {
     case X86_VEX_None:
         break;
@@ -2814,10 +2828,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         return true;
     }
 
-    if (s->vex_v != 0 &&
-        e->op0 != X86_TYPE_H && e->op0 != X86_TYPE_B &&
-        e->op1 != X86_TYPE_H && e->op1 != X86_TYPE_B &&
-        e->op2 != X86_TYPE_H && e->op2 != X86_TYPE_B) {
+    if (s->vex_v != 0 && !s->vex_ndd) {
         goto illegal;
     }
 
@@ -2896,6 +2907,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_l = 0;
     s->vex_v = 0;
     s->vex_w = false;
+    s->vex_ndd = false;
     s->has_modrm = false;
     s->prefix = 0;
 
-- 
2.55.0


