Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BADECD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSds4-0008Ch-EQ; Thu, 28 May 2026 12:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSds2-0008CR-NX
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSdrz-0007Ea-HW
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779986765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ysFZsnS/3HXx55MFHw5/NkaBXVjsJ6TrVZh3E89wVdA=;
 b=R6J4xEysxGDEl5xe1J1DbPqtPSQBT+V/PzxG09P8iKTqD9Uo9PV6EHHYM3SNkq5dWQWMPy
 ACCJkaDT7vvi9e58cS8OnlkCjuYi1Xl/Amcytwxm/ydHFry4AeG/iP4TtJlfPkviHoIsCx
 zDmVYtnn9OzL+tw9jT/w0AWfh9/n5uw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-TIsth52SNwuKrh1s5G_vFw-1; Thu, 28 May 2026 12:46:03 -0400
X-MC-Unique: TIsth52SNwuKrh1s5G_vFw-1
X-Mimecast-MFC-AGG-ID: TIsth52SNwuKrh1s5G_vFw_1779986763
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a71109b94so8660946f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779986762; x=1780591562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ysFZsnS/3HXx55MFHw5/NkaBXVjsJ6TrVZh3E89wVdA=;
 b=lvoXNgoNayh9imAUDpZpDQgYktfsPqoRA6F3vdkf/dAlp8IhATuxDo73alNOIQSIN9
 /hte1PsyD41xX4LCA/b42W2+9u02qJcGMsz4NEp6s9fz8Q5s068adSX7+SzrIc1Do+ui
 ucl1ocdvr0bYb6syFMV3X/6aQrUjQu6BrkSrEJ+Gy2yd1Xisa6a4qy+omzS7kjvQQfmk
 PBAsLX5xLEgh5JzskX3RJ20Xeb/ONv22OPhvR/ySoetWltdjx8Lt4DFz6oYdo4xggFwj
 dCBGt2QGTLu6aBcEtPAKxGfp/7iKM4Dt5WCPTKT8CBMVwajNJ2VU1Rz2POR1DdEy+pen
 EUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779986762; x=1780591562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysFZsnS/3HXx55MFHw5/NkaBXVjsJ6TrVZh3E89wVdA=;
 b=IbX5jcs5CBUiYGM+DCUF+qHWH/pv/P/OadrTvQPEyT3DG8ntGsmbyH4jWxIHWC3fj5
 qTemkapMRGH1qwcbCz690nClvXRQgh9Y5/bBtDRv+JpKbHPKPIZ3dRUihumQCWxgZFZJ
 Rzmwt8JVMQybufHzt+nH29LtSY3WE7YQCfazQwbDXSKB+tiIVdQZ/6bTfDnc1sAVld35
 PxQGzKBviVDNchU0ssKvCCzdy+0Y544Cfc1He7zZcNhjczrFeH0kMoKekOB/chUbdBpp
 tJIZi3MhRHjJO9DuuV5EeABMpZ55Dx5plu+lUHG6/RfVmUhQQZ1x0g0ByIjxg3G1GwX2
 f13Q==
X-Gm-Message-State: AOJu0YzkmL/UXYuRF3f+XNiwRHaP14+YqBrCZSPg7wQvtSDpUgO0rP6Q
 LRT5f9HRWKJY0vghLaZgiza+kySVlRaUIyqbHt0XQk0jKm8nzez+5n3uRNfbPFcX0X3FR7Nybss
 GhexllGQ1cyDXj5Ta9qGQAeEXOrYK18kBt8iAlpiaLLF/Bv5wbRp7yBz8QzXIiy1BRuZanTuQwf
 b3SCE6IukeGfa2NW42EipeKf2OjtYZ22QD3KlFeswo
X-Gm-Gg: Acq92OHZDkoy9JLNuQrpR4DzWN8qcfdYyxNpS30hfS6Aqgv/vV6YAPzMmSvI6WW4MlK
 TsHcsbCLdpsIrLsC34soXdFaYCIdnDz9FH/3oi4F6VvqB60g4BRLU48Lqrwvqvt1vQMQMH+3wNM
 5enhbCAPVE7RVyxs11vYp6pj9vazDe1h1TJcjQB+EWFfhM9JhElj855THYP9HuGFDSDGbuqOHCe
 hI65TzY6eQwSfB+Q1tXkByLDZurReAS/VPwzr54Yj87CO5Rnu40xrujnV3+ful4CFOnjjPmZltG
 78TKSi5Esvlg3o5fSwQjQZt3hGiOMzuXxgoAxU6DfYZLItdnJ3v7aXe20rgyM9ye64s40UuFa3F
 2U8lS0T5cA6/8wG3lKhYciu/7esroElPEYK0GDS9uHE/5dUUDsPPXVMRuH4cG4UqQdERDcR5hH5
 oK5zmRRkaA/lLO78V+1FXMbgKgzw7GeT1btud5OA==
X-Received: by 2002:a05:6000:1844:b0:455:70bc:216d with SMTP id
 ffacd0b85a97d-45eb367f5fcmr50048985f8f.12.1779986762425; 
 Thu, 28 May 2026 09:46:02 -0700 (PDT)
X-Received: by 2002:a05:6000:1844:b0:455:70bc:216d with SMTP id
 ffacd0b85a97d-45eb367f5fcmr50048928f8f.12.1779986761857; 
 Thu, 28 May 2026 09:46:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a432sm20658930f8f.3.2026.05.28.09.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:46:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Abhigyan Kumar <314abh@gmail.com>, richard.henderson@linaro.org,
 philmd@linaro.org
Subject: [PATCH] target/i386: apply mod to immediate count of an RCL/RCR
 operation
Date: Thu, 28 May 2026 18:46:00 +0200
Message-ID: <20260528164600.868982-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

RCR and RCL instructions with a count of 9 are the same as if the
count was 0, but they generated incorrect code because the can_be_zero
flag is false.  This causes 0 to underflow into -1 at
tcg_gen_subi_tl(count, count, 1).

Fix by absorbind the call to gen_shift_count() into gen_rotc_mod(),
so that the new function handles both mask and mod.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 85 +++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ce636b6c56c..c6b0be1f60d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3244,12 +3244,10 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
-                             bool *can_be_zero, TCGv *count, int unit)
+static void gen_shift_count_1(DisasContext *s, X86DecodedInsn *decode,
+                              bool *can_be_zero, TCGv *count, int unit,
+                              int mask)
 {
-    MemOp ot = decode->op[0].ot;
-    int mask = (ot <= MO_32 ? 0x1f : 0x3f);
-
     *can_be_zero = false;
     switch (unit) {
     case X86_OP_INT:
@@ -3259,12 +3257,17 @@ static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
         break;
 
     case X86_OP_IMM:
-        if ((decode->immediate & mask) == 0) {
+        /*
+         * The caller applied the mask (this is awkward; unfortunately the
+         * mask must be applied *before* the modulo operation for RCL/RCR,
+         * and the modulo operation must be before this check for zero).
+         */
+        if (decode->immediate == 0) {
             *count = NULL;
             break;
         }
         *count = tcg_temp_new();
-        tcg_gen_movi_tl(*count, decode->immediate & mask);
+        tcg_gen_movi_tl(*count, decode->immediate);
         break;
 
     case X86_OP_SKIP:
@@ -3275,7 +3278,19 @@ static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
     default:
         g_assert_not_reached();
     }
+}
 
+static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
+                             bool *can_be_zero, TCGv *count, int unit)
+{
+    MemOp ot = decode->op[0].ot;
+    int mask = (ot <= MO_32 ? 0x1f : 0x3f);
+
+    if (unit == X86_OP_IMM) {
+        decode->immediate &= mask;
+    }
+
+    gen_shift_count_1(s, decode, can_be_zero, count, unit, mask);
     return ot;
 }
 
@@ -3394,32 +3409,38 @@ static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old,
     }
 }
 
-/*
- * RCx operations are invariant modulo 8*operand_size+1.  For 8 and 16-bit operands,
- * this is less than 0x1f (the mask applied by gen_shift_count) so reduce further.
- */
-static void gen_rotc_mod(MemOp ot, TCGv count)
+static MemOp gen_rotc_count(DisasContext *s, X86DecodedInsn *decode,
+                            bool *can_be_zero, TCGv *count, int unit)
 {
     TCGv temp;
+    MemOp ot = decode->op[0].ot;
+    int mod = (8 << ot) + 1;
+    int mask = (ot <= MO_32 ? 0x1f : 0x3f);
 
-    switch (ot) {
-    case MO_8:
-        temp = tcg_temp_new();
-        tcg_gen_subi_tl(temp, count, 18);
-        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
-        tcg_gen_subi_tl(temp, count, 9);
-        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
-        break;
-
-    case MO_16:
-        temp = tcg_temp_new();
-        tcg_gen_subi_tl(temp, count, 17);
-        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
-        break;
-
-    default:
-        break;
+    /*
+     * RCx operations are invariant modulo 8*operand_size+1.  For 8 and 16-bit
+     * operands, this is less than 0x1f (the mask applied by gen_shift_count)
+     * so reduce further.  Failure to do so results in incorrect shifts
+     * in gen_RCL/gen_RCR.
+     */
+    if (unit == X86_OP_IMM) {
+        decode->immediate &= mask;
+        decode->immediate %= mod;
     }
+
+    gen_shift_count_1(s, decode, can_be_zero, count, unit, mask);
+
+    if (unit == X86_OP_INT && mod < mask) {
+        temp = tcg_temp_new();
+        if (mod * 2 < mask) {
+            tcg_gen_subi_tl(temp, *count, mod * 2);
+            tcg_gen_movcond_tl(TCG_COND_GE, *count, temp, tcg_constant_tl(0), temp, *count);
+        }
+        tcg_gen_subi_tl(temp, *count, mod);
+        tcg_gen_movcond_tl(TCG_COND_GE, *count, temp, tcg_constant_tl(0), temp, *count);
+    }
+
+    return ot;
 }
 
 /*
@@ -3440,7 +3461,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
+    MemOp ot = gen_rotc_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, low_count;
 
     if (!count) {
@@ -3451,7 +3472,6 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     high = tcg_temp_new();
     low_count = tcg_temp_new();
 
-    gen_rotc_mod(ot, count);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
@@ -3492,7 +3512,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
+    MemOp ot = gen_rotc_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, high_count;
 
     if (!count) {
@@ -3503,7 +3523,6 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     high = tcg_temp_new();
     high_count = tcg_temp_new();
 
-    gen_rotc_mod(ot, count);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
-- 
2.54.0


