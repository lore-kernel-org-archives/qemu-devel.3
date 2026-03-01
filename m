Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55DFFD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0b-0000MF-Mx; Sun, 01 Mar 2026 09:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0O-0000KW-Lt
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0N-0005jo-0M
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deYnPH+WwmjHg35s4eVEO2RLAXpYeAKTB9VpdhYUCQ8=;
 b=jHfHmgyfzszyPnI18Hw7zOk5bjrnK07TllSCDK0vzHRd58medzI+hIqM1117vcr5Pa4DJC
 DJFT1QLGm41te7t1ado1VpI0bDPaSGVb67oYIINfRzpD+3cU/IZ8Vf4yAa/0I/I3xe9zzR
 40LB3u8F1qwU80InV41ILmvF0e5xBl4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-gnLSWEV1Ob20y0XJt0OsUw-1; Sun, 01 Mar 2026 09:42:45 -0500
X-MC-Unique: gnLSWEV1Ob20y0XJt0OsUw-1
X-Mimecast-MFC-AGG-ID: gnLSWEV1Ob20y0XJt0OsUw_1772376164
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439ab866bc1so1182891f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376163; x=1772980963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=deYnPH+WwmjHg35s4eVEO2RLAXpYeAKTB9VpdhYUCQ8=;
 b=EcigXfY3cOWbjTX/fZ7dci766SoJkCR2EvNcAjqZ6SD1wvjjiur2AtsVpioYOSGKZB
 EnxELy92ZCwVHAYDTlAnnfEzaVCBVlyvihqGWqdKqvgFBi0jwcksVTdL8gXes2UUcVuV
 CVdYE42yyeI0vhK8D5SttBfPXwaOLBRFwDjkiRmqDyJr2ZlH4z4Vs8/kN6oZpTsDu2eC
 d3oKqzvaJdsGeY7052rZhx/iBhgR4YJV1Ou7GPx/3jMQBxVIqhOOjgSyHPG1tlEFGPQ2
 TimpRqwiu9rHUX3uOpM0vKRUqXoDNDQ6SCd8k4u/Y974Yb9W86iAlneYUG3NmJujtE7B
 qbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376163; x=1772980963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=deYnPH+WwmjHg35s4eVEO2RLAXpYeAKTB9VpdhYUCQ8=;
 b=jTWQ6yfOXhKRrMgBiWvyTwZwOwJR9iTe2Z0e/9YgfLCLkxsLGNDqCOXdiFnKN79jBf
 ifHq7lgKbLzgc5yyqNwLBHjfY+Ubtn/somM/aJ+CI+loWBxS+INZDEI6Op7YalEtUFKO
 mFR79CwXt4DXkURDHPcV5IwiJ9LQGACk7/Zg+c1MVUkKvmKwVKzTG7ZHBbnTrTOaOmIs
 MfKrobMWPwHBhPb+iEYcoocUDj035EzWS7ZuZmnLJ404pfErcqd7zQnjmyiLrO+AQTUl
 uymWgkpSvOEidC24qvTfq0CmvBuDEeNz9hUrY34cKWPhZiko+ZewnU7okcWic8EDpksR
 73oQ==
X-Gm-Message-State: AOJu0Yzn1WtftabzaWVihLeB/4dr8339RAimTpZr7mQXbRSI+9+xG8fc
 5IMRgacWwwqzbazkbi5yzKCivkQSTNqUq/O2jCeBAAjodWrtfnlsF4dYukSR+5f4OeFKYlEorll
 lePK4DCo/e7tX9Jdp01Qa0L2uV+yowgRGWreK0+ljXo5D9g7+TuB7RFBsqem/TJvfEHoH6q7Qo4
 93URuNfEsBXTMMxCnhMGco4hTitrx4IncqLcsiIptp
X-Gm-Gg: ATEYQzxBpbhcNXzPaOShJPCIJHweAnSpU3ER6jxwYPOyHYiqk67qEJAK4MGaYqXcjjk
 Qa5r7RayPstiWdEBNv96u2Uf9EPL/xLc4A2XI5rsT50RkvoqpwHDO/O3EW1hp5SgBhOTZ8DGrdd
 cFC7HF9ksWbo8eiMv8SCjAIAxlxirWGWs5ddYmeEqDRbit38DRxHmkaqzjAQVEfCqGlGWgX3ZId
 7xKsl/Ih1OYSsPRagHN1YuZyqmOTsoKWOf1Lpn4/6zUgMZhVN0R+NJdDEculiT/ChrRRE0aYquH
 hH3FtQNNwgcSUDD6PY/6wS4KJ+8IccH8NwAJnBwhLbejO7K3+CIW4gcqWN5FCOybkwfdBBY8Rrr
 Vz82tq7TMJHeYmZ++gZMEr2vUOs8g5S/U73EqfSDpBGYusvmrAsxCpYF78fwSY3ssWs/C5wWK0h
 14hxZUXTgPmNcWnM5jfj+0wmmndaU=
X-Received: by 2002:a05:6000:604:b0:439:afd8:6223 with SMTP id
 ffacd0b85a97d-439afd86729mr3996765f8f.3.1772376163286; 
 Sun, 01 Mar 2026 06:42:43 -0800 (PST)
X-Received: by 2002:a05:6000:604:b0:439:afd8:6223 with SMTP id
 ffacd0b85a97d-439afd86729mr3996720f8f.3.1772376162542; 
 Sun, 01 Mar 2026 06:42:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c67sm22388100f8f.32.2026.03.01.06.42.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/18] target/i386/tcg: extend VEX.vvvv parsing for APX
Date: Sun,  1 Mar 2026 15:42:10 +0100
Message-ID: <20260301144218.458140-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Reuse the code that is already in place for AVX's operand type H,
so that APX can use type B without the VEX/EVEX prefix.

APX mostly uses VEX.vvvv for the destination.  This is already
supported for AVX, though that one only uses VEX.vvvv for
the destination in the case of shifts.  However, APX has two
extra possibilities that we need to consider:

- instructions with VEX/EVEX prefix but no new data destination.
  To handle this, store into s->vex_ndd whether the B (or H)
  operand comes from VEX.vvvv or from modrm.

- instructions with operands "m,r" that are extended to "r,m,r".
  In this case, the non-NDD format "m,r" expands the B operand to a
  memory location; when this happens, it is incorrect to parse again op1
  as a memory location, because that would read the displacement again
  from the instruction stream.  Instead, transform op1 into X86_TYPE_2op.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  1 +
 target/i386/tcg/decode-new.c.inc | 38 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 47eef81ba05..9bf4a1fd516 100644
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
index a17fc8550fb..b7988c64f86 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2330,10 +2330,9 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
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
@@ -2463,18 +2462,25 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         };
         break;
 
-    case X86_TYPE_H:  /* For AVX, VEX.vvvv selects an XMM/YMM register */
-        if ((s->prefix & PREFIX_VEX)) {
-            op->unit = X86_OP_SSE;
+    case X86_TYPE_H:  /* VEX.vvvv selects an XMM/YMM register, else use modrm */
+        op->unit = X86_OP_SSE;
+    get_vex_v:
+        if (s->vex_ndd) {
+            assert(s->prefix & (PREFIX_VEX | PREFIX_EVEX));
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
@@ -2717,6 +2723,14 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 {
     X86OpEntry *e = &decode->e;
 
+    if (s->prefix & (PREFIX_VEX | PREFIX_EVEX)) {
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
@@ -2804,10 +2818,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         return true;
     }
 
-    if (s->vex_v != 0 &&
-        e->op0 != X86_TYPE_H && e->op0 != X86_TYPE_B &&
-        e->op1 != X86_TYPE_H && e->op1 != X86_TYPE_B &&
-        e->op2 != X86_TYPE_H && e->op2 != X86_TYPE_B) {
+    if (s->vex_v != 0 && !s->vex_ndd) {
         goto illegal;
     }
 
@@ -2886,6 +2897,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_l = 0;
     s->vex_v = 0;
     s->vex_w = false;
+    s->vex_ndd = false;
     s->has_modrm = false;
     s->prefix = 0;
 
-- 
2.52.0


