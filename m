Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C085C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qpa-0007aE-BN; Wed, 23 Sep 2026 13:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qo5-0006nl-FO
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qo3-0003kj-Oq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYkNO/TdjB0qzTy0KRTNz8bADgBksuDXeNWhGmrxZks=;
 b=iWLLidNRVRHXt9KoE9KKTCwPJp+PctWmRtAQ/WiS7gfVIs1SLv+tVLUYljsVoqtro5cnGG
 Sf+77M6TikmkSAb+inMtferQqzPzVdCoSffHhHkwoYBUbzLRK/7KMHGlCTlwXdpIe/423B
 SPzwMUVQL0gYy7+H2OrJ/pyIAUcE0Wc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-BU7e1abwNGaml7UEGk88LQ-1; Wed, 23 Sep 2026 13:30:53 -0400
X-MC-Unique: BU7e1abwNGaml7UEGk88LQ-1
X-Mimecast-MFC-AGG-ID: BU7e1abwNGaml7UEGk88LQ_1790184652
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6c17ec1dso13919005e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184652; x=1790789452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OYkNO/TdjB0qzTy0KRTNz8bADgBksuDXeNWhGmrxZks=;
 b=BmOPmDOWuizAvU2DBoXg+oAgPK8Fqwf5EPDikkMAkqp4uLdcAXhaBUKuCNi/DPWsw5
 +LOyYFeDI9WWuOQd2GxRPe/n/SyecqqW7rZ6aKS+SNM+2hbN2xZ7plUdmuRzcqLbqLuc
 1uezE8zugf5BdOKaIpXfwjg06NxQg3H6paPTiz1SmUA/ynTjRdeabB+MH71OKkFRpfNR
 phyfNVczTeiDPoTx8FR9BAFgySoaa8hEZHL85dFmpT0Uxhc8J15ihMqgYSLpL4T276F4
 RZABptJByv/jUNFS7o/OJwRScpQBbfGaA+9gCCWW/YjEm+0L/OArUSksiPaeV8G8t3/t
 UCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184652; x=1790789452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OYkNO/TdjB0qzTy0KRTNz8bADgBksuDXeNWhGmrxZks=;
 b=DzjE6c4MJMGjmBhbBQqsCtDDxVAivZdqD48GMU53QpW4EJT6q5uR6m6wdHb0dLY43/
 nIJnHUM+xXKt34Ax8IURzNbalvCbAAB3yz5FdhOv6emIL1pWZb+pXIUiXn/76vmgVN8S
 NpcoE1BTDhcgkOxM/ACd2a6fBaSwmkwE0xSQCUFnPcUlXCTdK7zi0w1deCT5u75+Uvxv
 MQRJng1qTqysjBEYYXOBIviunlwZlWNuFV+HVWwX080S4zysCFx4h/qqWTMkl7ddkYl9
 1kAwpiRukGXIWNGdtI3CYi66TmWvkbVMqUHiwM1L+QuTJRbicdCsLMv3AyP7ZNLz+LvQ
 Ay1w==
X-Gm-Message-State: AFuF++mwtCQM5KoRoEVQViFIOzRBj/MLk1s5N5NxBd3z5TEXUOOY8rMm
 3zsaM3wzxfIt84URb2uSjOb0Bet9jnsYBHtdhXrc7L8J8W9zYX6g1iyuUdrLs915YXPN/3d4G5M
 Q+qnfJw6mCYPadlGyvXWOyNn+ZClRbJH7KaNOclogpvS1RudcToU5mhIf4cTSWT/5bVzFbxNNDb
 eGQ9N/8Byc5Ui3lRrHSwP6ksQMVUrlihJgZJSVuJcP
X-Gm-Gg: AYBFou17RF62KbtgkvzHg5u1tKO80bP0CbW9POfGfKhHLWy4IbBwpa/3M9yta8E7ABF
 1LEjv1G8+GR7czJhanug/joyJiITonB4TSCAmsTOMXToMGTXy7Ufk3fqyuHDOsvGTolFATku/Jj
 7jLZnJqA5zCGWhwTYhjRB3jv7onNrZvboQwDlFwSJmBC5jUSv6cNQhNnnKMPQm5PxshZgTBXXwZ
 tWDfiuyEUJ0IYd2IMy35FLfxofi1SvfpNcFSOhScb/v+jMNhlfPtycuSo2JbsCjWpF0orKf6PNI
 zkGyNtA5IoLzS3t1WdVIrA/NBHe8W3c/l559a7eS4oqI0e29Ulro9giNE1qVakxhJ/5acACqhsM
 xmHVqQglrXvAiUd1TrjuOmIpkalXWgpkO9TPzXDKATY3hj0LWiKSawywnu/ZM/lSHQ2nd7ZvuLF
 bDI7PU645x3OHwEi4=
X-Received: by 2002:a05:600c:3b11:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49fdeffcf0amr51171305e9.6.1790184652252; 
 Wed, 23 Sep 2026 10:30:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b11:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49fdeffcf0amr51171035e9.6.1790184651852; 
 Wed, 23 Sep 2026 10:30:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd2bacsm1410555e9.13.2026.09.23.10.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 11/17] target/i386/tcg: extend VEX.vvvv parsing for APX
Date: Wed, 23 Sep 2026 19:30:15 +0200
Message-ID: <20260923173021.317809-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  1 +
 target/i386/tcg/decode-new.c.inc | 38 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index edef866a24b..1901d9372bb 100644
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
index b6d909d5f2b..b3873043b16 100644
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


