Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA97CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB3L-0000AQ-FQ; Mon, 28 Sep 2026 09:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0u-0005P8-SO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0r-0004O0-Sm
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mW0ys8hwwnGDqJKKC8lFlPh0MB7wA3LFYUXiLzgZ2E0=;
 b=OX2GQz/+2lJjxjC2MMLEV78cMaNYwwDVUXBmTX9RewZNiaAilD0pyzrzerKJz+dXJbvWj/
 vuX0y/ovVXH1b+BGOVRTS43z6xPJyejk6Ssi9nrz3BCq2liaoFVUnzzh2ClhRYULb7UIQN
 QnoSoau4rRS7FXFQgP+1TobgfPCPOIE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-bzDoey8cP4evzFwz17ArxA-1; Mon, 28 Sep 2026 09:03:18 -0400
X-MC-Unique: bzDoey8cP4evzFwz17ArxA-1
X-Mimecast-MFC-AGG-ID: bzDoey8cP4evzFwz17ArxA_1790600597
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c25edb54d22so336331766b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600597; x=1791205397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mW0ys8hwwnGDqJKKC8lFlPh0MB7wA3LFYUXiLzgZ2E0=;
 b=CPGq1hyj2OGQDLjSVo3a0YKgZSRzK53tOQtVnnvAki2xj7eKaZpiNW7e964FbLNd4T
 J9aIdQZJ/wtb9izdrlIcY+G836ViZPQYsNF92TLPApcyIbgT6K5M7NBYa0JU0Is9QXs8
 Kf3XDEW6fVhVVWpbm11dXPTj+YdR+OUY69YxbMDcCZzdhvzgBo+fGGBrqXQRlZrBb35k
 gJvuWQtchY/e+DCakip18jM2T1KPShpLqtXr/Mdomf+dNoJBj1DDUeL3UZc1S/qz6ohj
 12YL1lrvHlTy0mcSvTB6Q4iFxsWXrjVE3cLpp995qlFGMzjw0+FjdnnKYskUr9p8WyJU
 WmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600597; x=1791205397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mW0ys8hwwnGDqJKKC8lFlPh0MB7wA3LFYUXiLzgZ2E0=;
 b=aEgVFjJYCQojDcajLQi8LFVy48su4MJDbA6yxV+4pw4T3+QVo0TO0c1KeOsOrCmBmm
 t9fLNjVLIi0fYSlxXStQIbOpeqNc10E0uQZ1weUCXLT366L2kKclrozgII3FHWWva9ID
 bmrBm8q15DRQAuFQIv5TW7RS3v1b/ZCMpH8qV2djo/+MJGVFieLgPU1meRj7/GCfnbTB
 FLYqPuXNHaD6whDvWf9xVYsB5UJIugggY9BE/RWcwllktyGz1/FY5gSZToXzD/40Gjfr
 dzH7xf2+jDUCpzqKZREkn++NWurOevAZDkhuElKIyf8BFe9QCb/YksnTBksnQeZw49K8
 3I3A==
X-Gm-Message-State: AFuF++lK1eUgpsgVXjQb0jCREQapzEr+BVwTj26aVb3PctTrlQGQCzZk
 pFVT9+ejkMFG//3/WCacDnzINh8QBxKQ9AVfEnnbkWso7k8iHz11H5XhTJ5MPlCVXr2b23NBipg
 Gpg22Pox17po9tMTF6aROaM/LS5uM0M4Wc6GBk/AzlPfuc1nlwGQdT0hlfTyN9o2eX7n7gdMVKf
 MMQAp8yCYXXc29GdpS/s2o72evU45moMujWA//P6RQ
X-Gm-Gg: AYBFou2kswTmsMKe+g93vTstyEAjG9v5GUgHk3xnr8rzjE2vgHbaXziCxKhPHqtrIln
 /lUgKfXsKzdvRCmhHgriQAWHDwrZvCOPsJJdOW8w1BfufPUVUR+YYcQlkwgYd8HcZbmU1vKi4Fu
 8mdPu+AywVXp0quGD3g8tijY5A2pmiTgwjBs8Al8j1fqooyNnvN8hSBTzytRic5zcWfWZaC3wxC
 LJLECyXoiju4oXjRHI3bTPrFlEI9HBS4UkstF6rBvQoFdlVEZiJ0AFL6roarj7ZCDoCYvfXusOY
 EmaykFBFvYmrKJf8QmdzFAJi1+OYCAEQQq9c2/g3tcGAEmPCGiCWdYDykQH+cmOKEQDzA8N8Nhe
 1WRYqcAr5bS2ZVDadNHPWs7aPPHtXJcrTNXPiqHRmB+jQdCBA+irncpPBe0+JKABVsrw+qW/hD/
 GjrEY7
X-Received: by 2002:a17:907:96a2:b0:c29:f5d8:9c7e with SMTP id
 a640c23a62f3a-c2ac22cb906mr1124339466b.45.1790600591348; 
 Mon, 28 Sep 2026 06:03:11 -0700 (PDT)
X-Received: by 2002:a17:907:96a2:b0:c29:f5d8:9c7e with SMTP id
 a640c23a62f3a-c2ac22cb906mr1124331866b.45.1790600589805; 
 Mon, 28 Sep 2026 06:03:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dec4cec91sm37033866b.28.2026.09.28.06.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/30] target/i386/tcg: generalize zero- and sign-extension
Date: Mon, 28 Sep 2026 15:02:10 +0200
Message-ID: <20260928130228.877003-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 15 +++++++++++----
 target/i386/tcg/decode-new.c.inc | 21 +++++++++++----------
 target/i386/tcg/emit.c.inc       | 16 ++++++++++------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 25f7d2215ee..1b5a91b4f46 100644
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
+    X86OpExt     ext0:2;
+    X86OpExt     ext1:2;
+    X86OpExt     ext2:2;
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
index 26f6d6277be..07a627af5cf 100644
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
 
@@ -2528,16 +2532,19 @@ static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_f
         !decode_op(s, env, decode, &decode->op[0], e->op0, decode->b)) {
         return false;
     }
+    decode->op[0].ext = e->ext0;
 
     if (e->op1 != X86_TYPE_None &&
         !decode_op(s, env, decode, &decode->op[1], e->op1, decode->b)) {
         return false;
     }
+    decode->op[1].ext = e->ext1;
 
     if (e->op2 != X86_TYPE_None &&
         !decode_op(s, env, decode, &decode->op[2], e->op2, decode->b)) {
         return false;
     }
+    decode->op[2].ext = e->ext2;
 
     if (e->op3 != X86_TYPE_None) {
         decode->immediate = insn_get_signed(env, s, MO_8);
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


