Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91D8C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2RW-0006xD-W9; Tue, 11 Jun 2024 10:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RV-0006wj-0i
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RT-0005zu-7p
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DKevtbrkfxNUqdbBiwO/iM4isVZ7jyc8Kd9+OEOr0w=;
 b=MkeiklHW4adJVKvRkoetLQuuaPHGQ3d34XKNwcTs0mQNJ7xPIN08N6jKvq8hqNjcd/uvT7
 dUi6id9Sgh0JR0ZVWn1u9aWYezty73raeJtfIoIPd3rthvo4LAVhpVf7ogyF1PibnvT81x
 08/md1R+DfsmS7c5unHWzasnn4pypaw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-BbEhq56-Ody30D7rRbyKGQ-1; Tue, 11 Jun 2024 10:25:40 -0400
X-MC-Unique: BbEhq56-Ody30D7rRbyKGQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57c748dd112so957037a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115939; x=1718720739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DKevtbrkfxNUqdbBiwO/iM4isVZ7jyc8Kd9+OEOr0w=;
 b=hkP4AIWgfaTXhmvO0/oNm//cRsTDFEKELfyhb8pYb5YMZ6SrkOavuz+R25cxpcTAhH
 /iFqthHWOMsQpulT588z4vEUNZC/PqyJWkAXrOby8z1rMdxZ7yj56rXU9C5nx7Ay/CwV
 Vw/d3bveTGF8o06xMloMb7uSOJHUyNLgDnC46xVtFuhkQ7GDCI5IhDx3P44AWeMWwhqv
 2t2JFRW/JPjarL8xfPcuVGd3RPCy7vPrQDJwaQ0rFLPi8UN/WUWEiVOuXlfBEZwLRpgC
 wkY25uiE2MVJIE7XPqUucIKufT0pgF6pZz29QVDxN9GLgHWVMAK02xvhEs8D/HMGAqi/
 32fA==
X-Gm-Message-State: AOJu0YwELWy5fJCWwINIh+nWsbwolOCRo19wwx0WiPGAxRjwVLZSdF6L
 rQQhprkS6eNpzoYTTsIZ04lG1T0S/nZXD3e9fbUXl7sJpZibIa4WEasn6ZnzpT6NkcnjEgAmxcf
 UIckpGPuN7Tz3l55awpOZtouHQ2gGquPm4gC1N/ccqPuY0rETgixzUrl5uoGwaomwSy9YSbNnDw
 ViPnDKLsC/hiQyQMRo4HBOaDFu1Zm4Lobu7f/5
X-Received: by 2002:a50:9b42:0:b0:57c:9dbc:2b6e with SMTP id
 4fb4d7f45d1cf-57c9dbc2cdcmr856574a12.42.1718115938759; 
 Tue, 11 Jun 2024 07:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoOVCdcQYra8b9kvSw0ZnmRSj5+GCyldJjXCljZrTM3SyCuPOeLxdwTTfLGrZ8EJg6NdFJDg==
X-Received: by 2002:a50:9b42:0:b0:57c:9dbc:2b6e with SMTP id
 4fb4d7f45d1cf-57c9dbc2cdcmr856556a12.42.1718115938442; 
 Tue, 11 Jun 2024 07:25:38 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c7407b4f0sm5395444a12.92.2024.06.11.07.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/25] target/i386: rewrite flags writeback for ADCX/ADOX
Date: Tue, 11 Jun 2024 16:25:05 +0200
Message-ID: <20240611142524.83762-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Avoid using set_cc_op() in preparation for implementing APX; treat
CC_OP_EFLAGS similar to the case where we have the "opposite" cc_op
(CC_OP_ADOX for ADCX and CC_OP_ADCX for ADOX), except the resulting
cc_op is not CC_OP_ADCOX. This is written easily as two "if"s, whose
conditions are both false for CC_OP_EFLAGS, both true for CC_OP_ADCOX,
and one each true for CC_OP_ADCX/ADOX.

The new logic also makes it easy to drop usage of tmp0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h          |  9 +++---
 target/i386/tcg/emit.c.inc | 61 ++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8fe28b67e0f..7e2a9b56aea 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1260,6 +1260,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* Use a clearer name for this.  */
 #define CPU_INTERRUPT_INIT      CPU_INTERRUPT_RESET
 
+#define CC_OP_HAS_EFLAGS(op) ((op) >= CC_OP_EFLAGS && (op) <= CC_OP_ADCOX)
+
 /* Instead of computing the condition codes after each x86 instruction,
  * QEMU just stores one operand (called CC_SRC), the result
  * (called CC_DST) and the type of operation (called CC_OP). When the
@@ -1270,6 +1272,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 typedef enum {
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
     CC_OP_EFLAGS,  /* all cc are explicitly computed, CC_SRC = flags */
+    CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
+    CC_OP_ADOX, /* CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
 
     CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
@@ -1326,10 +1331,6 @@ typedef enum {
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
-    CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
-    CC_OP_ADOX, /* CC_DST = O, CC_SRC = rest.  */
-    CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
-
     CC_OP_CLR, /* Z set, all other flags clear.  */
     CC_OP_POPCNT, /* Z via CC_SRC, all other flags clear.  */
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index df7597c7e2f..2041ea9d04a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1122,24 +1122,41 @@ static void gen_ADC(DisasContext *s, X86DecodedInsn *decode)
     prepare_update3_cc(decode, s, CC_OP_ADCB + ot, c_in);
 }
 
-/* ADCX/ADOX do not have memory operands and can use set_cc_op.  */
-static void gen_ADCOX(DisasContext *s, MemOp ot, int cc_op)
+static void gen_ADCOX(DisasContext *s, X86DecodedInsn *decode, int cc_op)
 {
-    int opposite_cc_op;
+    MemOp ot = decode->op[0].ot;
     TCGv carry_in = NULL;
-    TCGv carry_out = (cc_op == CC_OP_ADCX ? cpu_cc_dst : cpu_cc_src2);
+    TCGv *carry_out = (cc_op == CC_OP_ADCX ? &decode->cc_dst : &decode->cc_src2);
     TCGv zero;
 
-    if (cc_op == s->cc_op || s->cc_op == CC_OP_ADCOX) {
-        /* Re-use the carry-out from a previous round.  */
-        carry_in = carry_out;
-    } else {
-        /* We don't have a carry-in, get it out of EFLAGS.  */
-        if (s->cc_op != CC_OP_ADCX && s->cc_op != CC_OP_ADOX) {
-            gen_compute_eflags(s);
+    decode->cc_op = cc_op;
+    *carry_out = tcg_temp_new();
+    if (CC_OP_HAS_EFLAGS(s->cc_op)) {
+        decode->cc_src = cpu_cc_src;
+
+        /* Re-use the carry-out from a previous round?  */
+        if (s->cc_op == cc_op || s->cc_op == CC_OP_ADCOX) {
+            carry_in = (cc_op == CC_OP_ADCX ? cpu_cc_dst : cpu_cc_src2);
         }
-        carry_in = s->tmp0;
-        tcg_gen_extract_tl(carry_in, cpu_cc_src,
+
+        /* Preserve the opposite carry from previous rounds?  */
+        if (s->cc_op != cc_op && s->cc_op != CC_OP_EFLAGS) {
+            decode->cc_op = CC_OP_ADCOX;
+            if (carry_out == &decode->cc_dst) {
+                decode->cc_src2 = cpu_cc_src2;
+            } else {
+                decode->cc_dst = cpu_cc_dst;
+            }
+        }
+    } else {
+        decode->cc_src = tcg_temp_new();
+        gen_mov_eflags(s, decode->cc_src);
+    }
+
+    if (!carry_in) {
+        /* Get carry_in out of EFLAGS.  */
+        carry_in = tcg_temp_new();
+        tcg_gen_extract_tl(carry_in, decode->cc_src,
             ctz32(cc_op == CC_OP_ADCX ? CC_C : CC_O), 1);
     }
 
@@ -1151,28 +1168,20 @@ static void gen_ADCOX(DisasContext *s, MemOp ot, int cc_op)
         tcg_gen_ext32u_tl(s->T1, s->T1);
         tcg_gen_add_i64(s->T0, s->T0, s->T1);
         tcg_gen_add_i64(s->T0, s->T0, carry_in);
-        tcg_gen_shri_i64(carry_out, s->T0, 32);
+        tcg_gen_shri_i64(*carry_out, s->T0, 32);
         break;
 #endif
     default:
         zero = tcg_constant_tl(0);
-        tcg_gen_add2_tl(s->T0, carry_out, s->T0, zero, carry_in, zero);
-        tcg_gen_add2_tl(s->T0, carry_out, s->T0, carry_out, s->T1, zero);
+        tcg_gen_add2_tl(s->T0, *carry_out, s->T0, zero, carry_in, zero);
+        tcg_gen_add2_tl(s->T0, *carry_out, s->T0, *carry_out, s->T1, zero);
         break;
     }
-
-    opposite_cc_op = cc_op == CC_OP_ADCX ? CC_OP_ADOX : CC_OP_ADCX;
-    if (s->cc_op == CC_OP_ADCOX || s->cc_op == opposite_cc_op) {
-        /* Merge with the carry-out from the opposite instruction.  */
-        set_cc_op(s, CC_OP_ADCOX);
-    } else {
-        set_cc_op(s, cc_op);
-    }
 }
 
 static void gen_ADCX(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_ADCOX(s, decode->op[0].ot, CC_OP_ADCX);
+    gen_ADCOX(s, decode, CC_OP_ADCX);
 }
 
 static void gen_ADD(DisasContext *s, X86DecodedInsn *decode)
@@ -1190,7 +1199,7 @@ static void gen_ADD(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_ADOX(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_ADCOX(s, decode->op[0].ot, CC_OP_ADOX);
+    gen_ADCOX(s, decode, CC_OP_ADOX);
 }
 
 static void gen_AND(DisasContext *s, X86DecodedInsn *decode)
-- 
2.45.1


