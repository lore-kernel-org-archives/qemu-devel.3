Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A095DCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIE-0006cw-SK; Wed, 17 Jun 2026 10:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIC-0006cJ-TN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIB-0007ac-1S
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fd6BBqQIYST9qCiFwtdSCjOI5XueEX5XbUawSErV3d4=;
 b=ROhFDGhWny46Jv9dt6hFgYgUGxSbFmyETeqG1u5lutMwz6ZgEiTfQANw0JO/VSUry7S8k/
 8eLjZmlvoSzlh6U9+5Xcq4gVLMfKtI8dLmHhVpbjkty8Mjwc38QUSWG73NJRQglOj4aEey
 kp/agPAmFIK3a9aTNVdfICqJia7Csts=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-O7WaRMWHN7mzX40oZO5dBQ-1; Wed, 17 Jun 2026 10:30:56 -0400
X-MC-Unique: O7WaRMWHN7mzX40oZO5dBQ-1
X-Mimecast-MFC-AGG-ID: O7WaRMWHN7mzX40oZO5dBQ_1781706655
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c069fa2be84so54752166b.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706655; x=1782311455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fd6BBqQIYST9qCiFwtdSCjOI5XueEX5XbUawSErV3d4=;
 b=csLjzvD6COeL3990glvl5oqC7JkB9g6pX1IC42301gv/bs+oZiuSHk5gARvNubrC4X
 LWenG2VMF/8jjNTY7mFl+qJ4W/QHB+OHbi3MvwLJMcctsiJvNoA6F7MPv0mhBYN6NI+M
 OPnKGC3gCgUXiu+ZMR2+VFE8ZnF7xV7mFTsiEBZ4HvK/TnZsMxA6Gl60NWVAmiVsKygJ
 UHRhqVvMLQO+v9zXGCGZ87L/lfciKqxQunQzoeZoE3x0kIuvFrWNNDnKKuLMSMT3Bfg5
 Z02mn3CA+zbilyu84XMyuIrBVr5mkrhs3TxD3Gefo+hvRrEm1ZQRT19W+Pn+ExPK6MBN
 S5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706655; x=1782311455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fd6BBqQIYST9qCiFwtdSCjOI5XueEX5XbUawSErV3d4=;
 b=l//uQNvsURPkMzz0SDFe9RyQCwqkFBOdUDN+2vvPqt5fTu6US/UP0H6KBLD1xH3Ihx
 Rb56MPt4ABJ7DahtiGt+3GUmW7/EB7O5HIoJOl2HDVJN0/y3MwkZt8IVeGnhh5XNQFSL
 66b/cDWQuvxb8qXgXF66ZnMsBvZeXPG7duEZpZPspyYjeymPjslI7WlJnXlVuF9cFnQg
 eOD973z5K8BiOGh1aQWWU04r8jItUipYBvy7ry39prPn/oQ8ZNpXKL5OZhvskvk0NRz9
 +dRjcaQx40XDAxZj04dx2BiCR2xhvmx0Duic+jXl38qwpH+J3T7bsdiYswIUfxs0fCjX
 JIOA==
X-Gm-Message-State: AOJu0YwHK9Qd4GSLodoYTC/tnHgtuzJMyalOYxyeJUSmj8GzSIbpOFaI
 jY7AW6ecM7bVDYaKnrEq4G0yMo2WsvCF+oHm3rJ7+T/72ssVoZ8iFcq5+gyyvTGftC6MY+XqBci
 EA4N7MqLHqvHzZY0eZ5Xw/mT+fEIMvYhviOShHMuUCM5rTylLiGKt1fBmEKDyjA0jz4koLefdBj
 baXEtLF9avOX659aJ0IIEivG0UZQMcf12b5qgmra/e
X-Gm-Gg: Acq92OEDrhMe8LHqv1S0oJMZm90c8hDH32QXxwu/FHZ/0hW5SA2B8UuYrUECxgVCCRV
 F+tHcvbdws8PmKeCoBMpILuwCadrjkNXP/XanphE+h8PGWjO/N/vApfAmSqwVG5RCeRCQr0Y/15
 H7AkKvOKPtne9sg/g8bqtCNRlwzCMJA2/YHwg2R0smql7yNa/6YvsvplmLgOSCVT/Tcju4RU663
 FOg8cdfy7ixNrMHrGfjdc++KCCNDS+pjCV1uYCP/E9tgg86J8y4EjYm+xlme4vOzcJ+rhOazEQT
 hTB5rXroCyxMK/98uBsxZusrpStsXR/lR8xvPIwFaDkuG0rTu9HK/To46b/EhjK7WEIW+/D5ZUE
 JI6nLJCGDrq3UkrAomhJ3MZxIcSdS758SmwhzTIKCb1G8YGzsPEqmesqDCWc/JwTGmEJtK4RX2Z
 8M9kLJyCIu8ZtS8Rr6
X-Received: by 2002:a17:907:763a:b0:c03:db29:4c87 with SMTP id
 a640c23a62f3a-c05a68e8c68mr216197366b.21.1781706654782; 
 Wed, 17 Jun 2026 07:30:54 -0700 (PDT)
X-Received: by 2002:a17:907:763a:b0:c03:db29:4c87 with SMTP id
 a640c23a62f3a-c05a68e8c68mr216190966b.21.1781706653861; 
 Wed, 17 Jun 2026 07:30:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f264333sm56564100f8f.4.2026.06.17.07.30.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:30:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] target/i386: apply mod to immediate count of an RCL/RCR
 operation
Date: Wed, 17 Jun 2026 16:30:32 +0200
Message-ID: <20260617143046.445322-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

RCR and RCL instructions with a count of 9 are the same as if the
count was 0, but they generated incorrect code because the can_be_zero
flag is false.  This causes 0 to underflow into -1 at
tcg_gen_subi_tl(count, count, 1).

Fix by absorbing the modulo computation into gen_shift_count(), now
renamed gen_shift_count_1(), so that it can handle both reductions.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 64 +++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ce636b6c56c..8eca66b6967 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3244,8 +3244,9 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
-static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
-                             bool *can_be_zero, TCGv *count, int unit)
+static MemOp gen_shift_count_1(DisasContext *s, X86DecodedInsn *decode,
+                               bool *can_be_zero, TCGv *count, int unit,
+                               int mod)
 {
     MemOp ot = decode->op[0].ot;
     int mask = (ot <= MO_32 ? 0x1f : 0x3f);
@@ -3255,16 +3256,31 @@ static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
     case X86_OP_INT:
         *count = tcg_temp_new();
         tcg_gen_andi_tl(*count, cpu_regs[R_ECX], mask);
+
+        if (mod < mask) {
+            TCGv temp = tcg_temp_new();
+            assert(mod * 4 >= mask);
+            if (mod * 2 < mask) {
+                tcg_gen_subi_tl(temp, *count, mod * 2);
+                tcg_gen_movcond_tl(TCG_COND_GE, *count, temp, tcg_constant_tl(0), temp, *count);
+            }
+            tcg_gen_subi_tl(temp, *count, mod);
+            tcg_gen_movcond_tl(TCG_COND_GE, *count, temp, tcg_constant_tl(0), temp, *count);
+        }
         *can_be_zero = true;
         break;
 
     case X86_OP_IMM:
-        if ((decode->immediate & mask) == 0) {
+        decode->immediate &= mask;
+        if (mod < mask) {
+            decode->immediate %= mod;
+        }
+        if (decode->immediate == 0) {
             *count = NULL;
             break;
         }
         *count = tcg_temp_new();
-        tcg_gen_movi_tl(*count, decode->immediate & mask);
+        tcg_gen_movi_tl(*count, decode->immediate);
         break;
 
     case X86_OP_SKIP:
@@ -3279,6 +3295,13 @@ static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
     return ot;
 }
 
+static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
+                             bool *can_be_zero, TCGv *count, int unit)
+{
+    return gen_shift_count_1(s, decode, can_be_zero, count, unit,
+                             INT_MAX);
+}
+
 /*
  * Compute existing flags in decode->cc_src, for gen_* functions that wants
  * to set the cc_op set to CC_OP_ADCOX.  In particular, this allows rotate
@@ -3397,29 +3420,14 @@ static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old,
 /*
  * RCx operations are invariant modulo 8*operand_size+1.  For 8 and 16-bit operands,
  * this is less than 0x1f (the mask applied by gen_shift_count) so reduce further.
+ * FIXME: are flags updated if the count is nonzero, but a multiple of (8 << op) + 1?
  */
-static void gen_rotc_mod(MemOp ot, TCGv count)
+static MemOp gen_rotc_count(DisasContext *s, X86DecodedInsn *decode,
+                            bool *can_be_zero, TCGv *count, int unit)
 {
-    TCGv temp;
-
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
-    }
+    MemOp ot = decode->op[0].ot;
+    return gen_shift_count_1(s, decode, can_be_zero, count, unit,
+                             (8 << ot) + 1);
 }
 
 /*
@@ -3440,7 +3448,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
+    MemOp ot = gen_rotc_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, low_count;
 
     if (!count) {
@@ -3451,7 +3459,6 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     high = tcg_temp_new();
     low_count = tcg_temp_new();
 
-    gen_rotc_mod(ot, count);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
@@ -3492,7 +3499,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
+    MemOp ot = gen_rotc_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, high_count;
 
     if (!count) {
@@ -3503,7 +3510,6 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     high = tcg_temp_new();
     high_count = tcg_temp_new();
 
-    gen_rotc_mod(ot, count);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
-- 
2.54.0


