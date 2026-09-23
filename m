Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8A1C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qof-0006x8-Ut; Wed, 23 Sep 2026 13:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnf-0006d1-UT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qne-0003gn-3y
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuRC7n0+gw4SOha1luYw+NxRqCsnfBNhqiW7oZ+36/w=;
 b=UQz3yuqMQueiAjTSqnLfEoR1iRO8xw3ngQAaMJlOAryuIF3Z7hsYEt0hDVwq1adNMPKSJq
 YKvfOgiKPVwruo9m808rsAHQG2lNW59IQzg9O4P+6PiWoHVlMJtp/YPvy73kx4EUE+B00m
 epEXXCgf6j0P9U2Yb1s9IZpAIkqD2Rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-KmRGN7FKNzq6ITYgCZvfLQ-1; Wed, 23 Sep 2026 13:30:25 -0400
X-MC-Unique: KmRGN7FKNzq6ITYgCZvfLQ-1
X-Mimecast-MFC-AGG-ID: KmRGN7FKNzq6ITYgCZvfLQ_1790184624
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfad90f1so10165305e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184624; x=1790789424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MuRC7n0+gw4SOha1luYw+NxRqCsnfBNhqiW7oZ+36/w=;
 b=OIKWHSBn+xu76x1j+eeNxpGcrt+ZfQqjYW21Q6N/E5PyQyBhBe9xuiIjR7o+nL96Sk
 U4u5cC4dT6/kfJLvHPgEzydP40sj9Au1xcNCHN7Ur2DxhNqXSSYNOn0UlpCWgnY//2zY
 Kv3urgBS0bzwjMKH4K03mQXtoZBpncV6t3Iti5wBDZM/JTGS6gubuLN3WwKt7ccDNwdD
 mrZlHx4UTKk+MStF0mq9jLdPEH3Ajz5c4twhRjMiOzMQu4AiCCs8Qpmi6uIl/esSZ5rv
 As7eZ43LZE1aZxrOb//rmpwanN0C3170g+MJk7gnc9kJm47DIXVuVaE6kDoBE8zWaX4L
 tfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184624; x=1790789424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MuRC7n0+gw4SOha1luYw+NxRqCsnfBNhqiW7oZ+36/w=;
 b=YdJKe95QVudZGidYLYZrLMlcWyaowJ14uL2FFir+B1ZHZksiLaZQphgZegg9q8cb6n
 uyjkgZbJDx7HDqSwN/TLh0UMDki/XJx1aWhMA+QFJFdPTwRl8AaDTTrOHPF1LBvd4cUZ
 vH9vITbW173whNJ74eierm1Q1mvTjXEDzE4T3andqMuaX9bFxlzfxpbGADZ8Yqi4ZBV3
 VNc4AiQGQfL/ph1lYi2Ro7SF4VYrUWtGZE4IzdD62teUCl3poHa8pVRuMi0JFt3GQSmD
 SZJvH8EySyNUul4/R+b1Zzk1EAHihqP+uPZusinFY+BnmOIkWDmrkIGocGrmfty2yHuZ
 cJcQ==
X-Gm-Message-State: AFuF++kMp9b8aLn0bjI5WjGoeOS5z7KxE/88rNNMcO4eB2nB5vB0PGkx
 wzftxWUGXq14hqMojGdksHuYSmfgAesB+BTntvyCVB2kZtKG3Od1FOKKOshZI0JP51tqwC7EpkZ
 O8vO7f5BeHkBLCjrw1pWTi7O90GPiuuzOsi2SpOkmfZx5rCLUXxyjIkjBGydY5DiCaW9fXDM3Hc
 rqBQTXN3X+t6fzhLbmGPXo/1SpEPDmtgNuUhqTC/F+
X-Gm-Gg: AYBFou3tGFG42HRvLHJuvVKoC156TMq0KjWkHtKEF4NvYBRtq4PhepW7lTh2B8VOida
 ObackVab4HM43MX23jPAkLIDRJYtlq6IN0Tu7rDE4/5zTXw7XQifLVPxiFmbULSqeu89Ns9lCoe
 fy5jrSR4Ah2DP/FqMPtC6G8WWFCZO7Yrz69yRBgDmGSL/uAxQfvOuLzfrpwQuOX4V8Y3BxTYrbp
 7AtygIv+A2PV9gWz6CohEUmPlQR8EgPcvm/RCT6J8QAqCjDLAkT3dEqVuJKWcevIHfcp6AI8nL8
 ZzG5xJUi4eXai1vOO1DUblBU91O9LdfOIeDF1xIlvbOhpKUcduLuPwjY50dsMZJDfAA/Z4C40+R
 GPsr4KaewRuclDkTvB1mquAHj8K7ihMRjQ0sbSXafREbMTPZQjZc7EToLo/NNVeTzywh4aV6nDJ
 +Skb8z
X-Received: by 2002:a05:600c:3b88:b0:49f:cc2a:f73a with SMTP id
 5b1f17b1804b1-49fdf1454dfmr55059835e9.25.1790184624385; 
 Wed, 23 Sep 2026 10:30:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3b88:b0:49f:cc2a:f73a with SMTP id
 5b1f17b1804b1-49fdf1454dfmr55059355e9.25.1790184623983; 
 Wed, 23 Sep 2026 10:30:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf9691e2sm81738145e9.1.2026.09.23.10.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 01/17] target/i386/tcg: generalize zero- and sign-extension
Date: Wed, 23 Sep 2026 19:30:05 +0200
Message-ID: <20260923173021.317809-2-pbonzini@redhat.com>
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

Allow applying sign and zero extension to T1 load and T0 writeback.
T1 load is useful for some cases where the tables are hacked to
put the sign extended operand in T0; T0 writeback is used for APX ZU
instructions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 15 +++++++++++----
 target/i386/tcg/decode-new.c.inc | 21 +++++++++++----------
 target/i386/tcg/emit.c.inc       | 16 ++++++++++------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 25f7d2215ee..a3702b00614 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -148,6 +148,12 @@ typedef enum X86OpUnit {
     X86_OP_MMX,     /* address in either s->ptrX or s->A0 depending on has_ea */
 } X86OpUnit;
 
+typedef enum X86OpExt {
+    X86_EXT_None,
+    X86_EXT_Signed,
+    X86_EXT_Unsigned,
+} X86OpExt;
+
 typedef enum X86InsnCheck {
     /* Illegal or exclusive to 64-bit mode */
     X86_CHECK_i64 = 1,
@@ -226,10 +232,6 @@ typedef enum X86InsnSpecial {
      */
     X86_SPECIAL_MMX,
 
-    /* When loaded into s->T0, register operand 1 is zero/sign extended.  */
-    X86_SPECIAL_SExtT0,
-    X86_SPECIAL_ZExtT0,
-
     /* Memory operand size of MOV from segment register is MO_16 */
     X86_SPECIAL_Op0_Mw,
 } X86InsnSpecial;
@@ -300,6 +302,10 @@ struct X86OpEntry {
     X86OpSize    s3:8;
 
     X86InsnSpecial special:8;
+    unsigned     ext0:2;
+    unsigned     ext1:2;
+    unsigned     ext2:2;
+    unsigned     :2;
     X86CPUIDFeature cpuid:8;
     unsigned     vex_class:8;
     X86VEXSpecial vex_special:8;
@@ -314,6 +320,7 @@ typedef struct X86DecodedOp {
     int8_t n;
     MemOp ot;     /* For b/c/d/p/s/q/v/w/y/z */
     X86OpUnit unit;
+    X86OpExt ext;
     bool has_ea;
     int offset;   /* For MMX and SSE */
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 26f6d6277be..e8b21c77743 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -233,8 +233,12 @@
 #define op0_Rd .special = X86_SPECIAL_Op0_Rd,
 #define op2_Ry .special = X86_SPECIAL_Op2_Ry,
 #define avx_movx .special = X86_SPECIAL_AVXExtMov,
-#define sextT0 .special = X86_SPECIAL_SExtT0,
-#define zextT0 .special = X86_SPECIAL_ZExtT0,
+#define sextwT0 .ext0 = X86_EXT_Signed,
+#define zextwT0 .ext0 = X86_EXT_Unsigned,
+#define sextT0  .ext1 = X86_EXT_Signed,
+#define zextT0  .ext1 = X86_EXT_Unsigned,
+#define sextT1  .ext2 = X86_EXT_Signed,
+#define zextT1  .ext2 = X86_EXT_Unsigned,
 #define op0_Mw .special = X86_SPECIAL_Op0_Mw,
 #define btEvGv .special = X86_SPECIAL_BitTest,
 
@@ -1614,9 +1618,9 @@ static void decode_group2(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     int op = (get_modrm(s, env) >> 3) & 7;
     entry->gen = group2_gen[op];
     if (op == 7) {
-        entry->special = X86_SPECIAL_SExtT0;
+        entry->ext1 = X86_EXT_Signed;
     } else {
-        entry->special = X86_SPECIAL_ZExtT0;
+        entry->ext1 = X86_EXT_Unsigned;
     }
 }
 
@@ -2491,6 +2495,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         if (e->op0 == X86_TYPE_I) {
             s->rip_offset += 1 << decode->op[0].ot;
         }
+        decode->op[0].ext = e->ext0;
     }
     if (e->op1 != X86_TYPE_None) {
         if (!decode_op_size(s, e, e->s1, &decode->op[1].ot)) {
@@ -2499,6 +2504,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         if (e->op1 == X86_TYPE_I) {
             s->rip_offset += 1 << decode->op[1].ot;
         }
+        decode->op[1].ext = e->ext1;
     }
     if (e->op2 != X86_TYPE_None) {
         if (!decode_op_size(s, e, e->s2, &decode->op[2].ot)) {
@@ -2507,6 +2513,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         if (e->op2 == X86_TYPE_I) {
             s->rip_offset += 1 << decode->op[2].ot;
         }
+        decode->op[2].ext = e->ext2;
     }
     if (e->op3 != X86_TYPE_None) {
         /*
@@ -3079,12 +3086,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
 
-    case X86_SPECIAL_SExtT0:
-    case X86_SPECIAL_ZExtT0:
-        /* Handled in gen_load.  */
-        assert(decode.op[1].unit == X86_OP_INT);
-        break;
-
     case X86_SPECIAL_Op0_Mw:
         assert(decode.op[0].unit == X86_OP_INT);
         if (decode.op[0].has_ea) {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c83ab809408..54dc23ca624 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -266,23 +266,21 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
 #endif
     case X86_OP_INT:
         if (op->has_ea) {
-            if (v == s->T0 && decode->e.special == X86_SPECIAL_SExtT0) {
+            if (op->ext == X86_EXT_Signed) {
                 gen_op_ld_v(s, op->ot | MO_SIGN, v, s->A0);
             } else {
                 gen_op_ld_v(s, op->ot, v, s->A0);
             }
 
-        } else if (op->ot < MO_TL && v == s->T0 &&
-                   (decode->e.special == X86_SPECIAL_SExtT0 ||
-                    decode->e.special == X86_SPECIAL_ZExtT0)) {
+        } else if (op->ot < MO_TL && op->ext != X86_EXT_None) {
             if (op->ot == MO_8 && byte_reg_is_xH(s, op->n)) {
-                if (decode->e.special == X86_SPECIAL_SExtT0) {
+                if (op->ext == X86_EXT_Signed) {
                     tcg_gen_sextract_tl(v, cpu_regs[op->n - 4], 8, 8);
                 } else {
                     tcg_gen_extract_tl(v, cpu_regs[op->n - 4], 8, 8);
                 }
             } else {
-                if (decode->e.special == X86_SPECIAL_SExtT0) {
+                if (op->ext == X86_EXT_Signed) {
                     tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot | MO_SIGN);
                 } else {
                     tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot);
@@ -347,6 +345,12 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
     case X86_OP_INT:
         if (op->has_ea) {
             gen_op_st_v(s, op->ot, v, s->A0);
+        } else if (op->ot < MO_TL && op->ext != X86_EXT_None) {
+            if (op->ext == X86_EXT_Signed) {
+                tcg_gen_ext_tl(cpu_regs[op->n], v, op->ot | MO_SIGN);
+            } else {
+                tcg_gen_ext_tl(cpu_regs[op->n], v, op->ot);
+            }
         } else {
             gen_op_mov_reg_v(s, op->ot, op->n, v);
         }
-- 
2.55.0


