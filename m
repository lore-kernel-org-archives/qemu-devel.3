Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B72CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFny-0005nx-NR; Wed, 24 Jun 2026 01:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFnx-0005nW-WB; Wed, 24 Jun 2026 01:05:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFnv-0005ZJ-VF; Wed, 24 Jun 2026 01:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277465; bh=u7UyKd+bg4frYUjd5OWvNzr9eA/rRHuaP2afJs6Di2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vOY6AvTECxc+NS670x3WzRoT6i2rAlWjzfS9konWs+LXw3WnsY7j7y8uV/ywdlKwU
 v6E1gjA9UaZVv2WC/3EhQFm9U/KadDRYF3jWo653mpgr3ExNxRiMrP8HhnHxRlxhKt
 J9pOAkl+l/bc2JZu2zn+FieI/hvhCFIilqAxAtMz3L3gN9iQJ0tSFPVK1R+swHSyQu
 6RiHT8JfZLQhHX8L5kn+n3qVB2RRGF9OZ3H6HImW2F+ldMCXVzsNjqw/5jM5rUM04N
 YMay1PTLxrXRMkTHljY0O7kIl4w/7NB1FrQ5pGlW8PjqjrMHhZWREsYIlHN2ir96dg
 O06+E+aJ6D8fw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 796D81BA63E;
 Wed, 24 Jun 2026 08:04:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 640013DDAC9;
 Wed, 24 Jun 2026 08:04:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 75/86] target/i386: apply mod to immediate count of
 an RCL/RCR operation
Date: Wed, 24 Jun 2026 08:02:46 +0300
Message-ID: <20260624050404.394225-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

RCR and RCL instructions with a count of 9 are the same as if the
count was 0, but they generated incorrect code because the can_be_zero
flag is false.  This causes 0 to underflow into -1 at
tcg_gen_subi_tl(count, count, 1).

Fix by absorbing the modulo computation into gen_shift_count(), now
renamed gen_shift_count_1(), so that it can handle both reductions.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e38d0afade7c134cd4d675f54d26c394cc3cc31f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a22673e4b4..af1cea92be 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3237,8 +3237,9 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
     gen_push_v(s, s->T0);
 }
 
-static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
-                             bool *can_be_zero, TCGv *count, int unit)
+static MemOp gen_shift_count_1(DisasContext *s, X86DecodedInsn *decode,
+                               bool *can_be_zero, TCGv *count, int unit,
+                               int mod)
 {
     MemOp ot = decode->op[0].ot;
     int mask = (ot <= MO_32 ? 0x1f : 0x3f);
@@ -3248,16 +3249,31 @@ static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
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
@@ -3272,6 +3288,13 @@ static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
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
@@ -3390,29 +3413,14 @@ static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old,
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
@@ -3433,7 +3441,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
+    MemOp ot = gen_rotc_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, low_count;
 
     if (!count) {
@@ -3444,7 +3452,6 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     high = tcg_temp_new();
     low_count = tcg_temp_new();
 
-    gen_rotc_mod(ot, count);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
@@ -3485,7 +3492,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
+    MemOp ot = gen_rotc_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, high_count;
 
     if (!count) {
@@ -3496,7 +3503,6 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     high = tcg_temp_new();
     high_count = tcg_temp_new();
 
-    gen_rotc_mod(ot, count);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
-- 
2.47.3


