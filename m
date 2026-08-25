Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1DBC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqI1-0004mJ-9r; Tue, 25 Aug 2026 08:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHw-0004kn-3R
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHu-0000PP-1F
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXafqi5leop9xl+L0588iutqTCj7yUSlxdRFeScICqs=;
 b=E1+cVc6Svzw2SOoq770g4iNE3/3ubhUFbqw5Ck3BibslqpJqAnZSFRXE14/jsbJFK6G8/p
 626B8osyXDpUlOxgjFNnLGzpfl9M8BhFO0YvKl8zkQ25ANUMGj3frfNK8AVgEdvKhtKu3H
 QJbLR3zm2CS/+5qBkPQbxyij9YnK0sM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-1V3y8L8RMmSBX-C1Xjp6mw-1; Tue, 25 Aug 2026 08:29:55 -0400
X-MC-Unique: 1V3y8L8RMmSBX-C1Xjp6mw-1
X-Mimecast-MFC-AGG-ID: 1V3y8L8RMmSBX-C1Xjp6mw_1787660994
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c1670dd0f5dso157103666b.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660993; x=1788265793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eXafqi5leop9xl+L0588iutqTCj7yUSlxdRFeScICqs=;
 b=d0P54WlLMVYoTHIAUyqrlAjGLpZe9uHJU6y7zGqMwGtvCySRZgUGgV4Z7//9ZmTxDF
 mcBFDxKDViEBOIHk0WtF0DWXmDU6O2mgLffln+xvYgqRh5wax5Fkoy3cOAJ84YAOY21V
 5bUJbCwGdRijvXgJPcnIPSV9G1X6AnARJK6YhcIB2WjwOJWitNzZ5HMIz6cnrERD3TqQ
 7vskYY51waHyZ6TTSq29OyRfklZp4kCWoi5H+upauJcYOQBw6FfreJvnFcdAhM0esKQo
 G3hTzB2LJm63B9LGELHXx+XtqVfDQPUVVtnj3SEUF6fVhDRXC4jd/L0AdnRs0ApNrtkY
 XOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660993; x=1788265793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eXafqi5leop9xl+L0588iutqTCj7yUSlxdRFeScICqs=;
 b=DTk/u1Eww8SHBRsb5m6T9iQl9kS1SCBriPNSwpFubfwDGEIvadRJyKi0SHAbhjUuTj
 ppFLrhF4d7uSxXBAqQf3+/EMAGNsJr6q+5y1QvZY3J4SRQx9qivYxFkDT5+4jgDPZFUy
 NHvFBnxz9K3fw/N7unbk/VFmAs1rHbkrVv/GCBd0D+ntCf4b1vPGFUq+tBhpo/k1NZcb
 NrMVQW/a9ZM5RM6Hl7ZLKvngUn2q4huN0CgTovKKFuqVHLJ4oVBVemBbIqB9wtjcC18z
 gWo9dPo4ro9VDVTTukSag/Zx+OInPV/CSGFIIN7ZrDJTdk7bkFqkFnDdLAdehDxcGvK6
 it8w==
X-Gm-Message-State: AFuF++lGp+wYro6ilRKxirPKaeoInZgM7kLS9uelRydju6PxvwjIw7zu
 WdghLpp2ZRguUqdx6Yg1wSXQRmUp5hVzCktJmVvxDxoAn2b0enWadjOxHYU1jCvWlE4H3CcCFtw
 HBVjITkphk0idnXkUTJd4S4db3cbBbV7FCkMKSYhEqwPi3ehrDWQB0uGic9QmiTwKcQUKzZv7xr
 EpHguEkphZFn6yDZGZk0hgP5qoQRjq8ULDLvKyUkXd
X-Gm-Gg: AR+sD12tQRlM866dTkbrIk1w50RsVZ0xNkpJRD2rBBvHd55INAKwqS918NWpgb0ckUh
 abKkJeKsyqbvemj5PVCLZvJ9tmDfPSB/qvH6Nx2fxP4nv741OXEeN+1EttswbOHgYyTZyCztnSd
 tbc5gFANN+70xqV22LOY7sXObysnaY01aEL3F30sGJvPvB8V6wIZETWIoOo9wlEY/mWIycZyybg
 0FCIyQyXFlrtqwxsNKqUtU8Sw2m4CD87eR3LDyGTA89Yjv55EgS8XwCscDxlmPNFfQggoJvLs/N
 H5Gfw8TVTqXvK65z9cJnxvURr6AvLQvX4Pz4l435Ng361dcKdglaXOW+6zzd0owfXNvOOQbOBU8
 42/3l1RNAD870mlLH1v0KF87RfW0L6P140SoIlXJXNmTVdhq5sZkSHl0FQrc0mAK0pqqqctV6Uc
 j06as=
X-Received: by 2002:a17:906:f5a8:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c24920d3c7fmr2853023966b.20.1787660993590; 
 Tue, 25 Aug 2026 05:29:53 -0700 (PDT)
X-Received: by 2002:a17:906:f5a8:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c24920d3c7fmr2853014966b.20.1787660993108; 
 Tue, 25 Aug 2026 05:29:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8fasm1932591066b.8.2026.08.25.05.29.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/20] target/i386/tcg: extend VEX.vvvv parsing for APX
Date: Tue, 25 Aug 2026 14:29:14 +0200
Message-ID: <20260825122921.431739-14-pbonzini@redhat.com>
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
index ea70e9a5568..7e50cf2355f 100644
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
index d49f467cc84..08f1fdddf16 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2331,10 +2331,9 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
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
@@ -2464,18 +2463,25 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
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
@@ -2718,6 +2724,14 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
@@ -2805,10 +2819,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         return true;
     }
 
-    if (s->vex_v != 0 &&
-        e->op0 != X86_TYPE_H && e->op0 != X86_TYPE_B &&
-        e->op1 != X86_TYPE_H && e->op1 != X86_TYPE_B &&
-        e->op2 != X86_TYPE_H && e->op2 != X86_TYPE_B) {
+    if (s->vex_v != 0 && !s->vex_ndd) {
         goto illegal;
     }
 
@@ -2887,6 +2898,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_l = 0;
     s->vex_v = 0;
     s->vex_w = false;
+    s->vex_ndd = false;
     s->has_modrm = false;
     s->prefix = 0;
 
-- 
2.55.0


