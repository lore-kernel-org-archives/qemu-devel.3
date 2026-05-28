Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977CECD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScPo-0001my-3f; Thu, 28 May 2026 11:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wScPm-0001mp-SB
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wScPk-0005dF-8v
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779981171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=24lUrOk/U0t9+g0kbtjK7DGKRrtUWEDS9CwSzasHH4M=;
 b=TbIekI6iXhKXwJTiotsJJce6xEgRpW2kjBDHhZpinKqDUUHyeTCcxhiMbPzWTAaROmZllk
 Gv4z4XOfbC2M5pYKqxRfX9pbdPVBnZYJPTA3OVOHGVH4gLo8oRJenAxYIendCBSq8qLORf
 2qBg64HX/loHfL3vHzF3GenMXDEkaFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-8m39A8wXNpq8hTI4XSYrRg-1; Thu, 28 May 2026 11:12:49 -0400
X-MC-Unique: 8m39A8wXNpq8hTI4XSYrRg-1
X-Mimecast-MFC-AGG-ID: 8m39A8wXNpq8hTI4XSYrRg_1779981168
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49051422d55so60305345e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779981168; x=1780585968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=24lUrOk/U0t9+g0kbtjK7DGKRrtUWEDS9CwSzasHH4M=;
 b=NBVqa37VKwpMx0RTWjBwl2MEOE+vGuxto3TUi616GcOFqNbpFJBGDsPEE5wCN7PWLv
 CF4qaTSUSUd48zv1M8FwZJ0T6ywspjdZjh+9WfUUHwzME0Ife6563KgqzBa8u2I/M1Jt
 M7SB2gEmneI9iP0IfvMTZSZj0WnH+i50xt2VfwEJGxmP7fTQs798IBClRh7T/W/b3gWV
 rgtJQZeK/DuPuCuZ6PKnl0Z/E89plvsGnfu73QLKfwPADgOwsIGWRSovzHmrSXFtJw5V
 oU9BQparoOX6HyamL8KA6eElGgo1v0VzHTd0A6pUpYivltEQxcgvxYPzza/PzF+6+gTk
 TUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981168; x=1780585968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24lUrOk/U0t9+g0kbtjK7DGKRrtUWEDS9CwSzasHH4M=;
 b=QNC/o5h51Gfx3Ax+w7iciI87JVSF4FpMgPDvTS72BnzgJRHhht30FFTUsYeeb+5shx
 a7o8qa983aACAL0M+EKMeVDj3i1Pf5VqVQ0t1K4WJ7nNr5y0vCOmLdrXbfPBJaFeO2NV
 rScdZlsxzl4/YMVShmKuHVSu4r7oHSFyh+IdZq1JmWKmVqwFk3nKrr5EiP9pcgZeOkE8
 OM+er+UOaK2/UliTpOqM+YDn3J1QpGoI1n6kG8TqhSwzy7dNQXmls5OdwJyPDYgWygd0
 CCONlTtJ3NPn4DEUZ1HbOO3TBz3cBRLTY/UY769lnUA4MYl1sURQSp0ovXsKth6RRZxq
 oUUA==
X-Gm-Message-State: AOJu0Yz+OWK6PGxvHBiamgTgF1VkGHxso4JI+VYNtlbrssOvAS1lRZzA
 9KyNhH8K1ox1KFr6nx+IAn2gVJQypzIyb3p3zx3DfuAP+mAfWn8Mta+hC8tLcganSYQd5S8wwWL
 IqYRxJn6/HASijGsfgtirUOWpmamMPGbj1w/t6J0ofgbC/a2ncc8DaOT9CkXujuoypsLmS69hdN
 D/AAvdQb2PPDG9QgOsbOA4qlJl5DCig+HDd02SLiOB
X-Gm-Gg: Acq92OFhBmTVpMoChtTLc1+vttTRjkr2VNbBXc4aYv2kI5ZxkSe1Rs62GWFjfNm54c9
 tD+vJKXkkES1VBsbGtnixHRsBEbowdksREm+5mVlh8vYOdN+dm/1OsHOjNBf/pNwtmqdeiCQNpY
 KuyUQuVssJHP+EjE1x60pWGijqkjPnBhBItvkKrAHqjLkxwDBRcagatJqw2U0N20Fm8nkHKpVK0
 7151q0MABbXoFf1BD2TJBOAmKxh0gBo6lvy3GfJyXI9G6k8W1pdm2L7futL8X3dJxKbXk0le2T6
 SDCi+ePGEhpD5d4gOpXu1pw1ZbqzgmffQE7oYDh1HZzQCV7klSgUjg7V9l9HUsBw4QeVNM6CoDG
 iRwfoY9Ih8cCkUzkzOI3w+cxd+3SSaFuYFq/0RvYsDLQ+7t4eq1b2V55yu9M9iQcnQojy7F4Uie
 3xjqzLrUtkBICdhHtFzJ6sgZrzWyZ81BYyC40jZA==
X-Received: by 2002:a05:600c:6094:b0:490:625e:bb68 with SMTP id
 5b1f17b1804b1-490625ebc14mr309763795e9.3.1779981168119; 
 Thu, 28 May 2026 08:12:48 -0700 (PDT)
X-Received: by 2002:a05:600c:6094:b0:490:625e:bb68 with SMTP id
 5b1f17b1804b1-490625ebc14mr309762915e9.3.1779981167530; 
 Thu, 28 May 2026 08:12:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eef3cb25dsm79407f8f.8.2026.05.28.08.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:12:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Abhigyan Kumar <314abh@gmail.com>,
	richard.henderson@linaro.org
Subject: [PATCH] target/i386: apply mod to immediate count of an RCL/RCR
 operation
Date: Thu, 28 May 2026 17:12:45 +0200
Message-ID: <20260528151245.845539-1-pbonzini@redhat.com>
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
---
 target/i386/tcg/emit.c.inc | 85 +++++++++++++++++++++++---------------
 roms/opensbi               |  2 +-
 2 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ce636b6c56c..41dcd82ab70 100644
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
+         * The caller applied the mask (this is unobvious; unfortunately the
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
+            tcg_gen_subi_tl(temp, count, mod * 2);
+            tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
+        }
+        tcg_gen_subi_tl(temp, count, mod);
+        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
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
diff --git a/roms/opensbi b/roms/opensbi
index 74434f25587..a32a9106911 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 74434f255873d74e56cc50aa762d1caf24c099f8
+Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
-- 
2.54.0


