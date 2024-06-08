Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6497C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFreY-0003lX-SX; Sat, 08 Jun 2024 04:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreX-0003iI-QW
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreW-0001Vi-2U
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e54zIwB4ZotLZ75Nya5oaHP5znOGdXyOL0dXOi/s3BY=;
 b=OAfe4r1d29QgFMGiFzaMpID9OL+ls99iC+kcjt28N76YWbHKi1aBOsaPzzKgbU3BttkHee
 KRr4886po6JUxB6fHr81zds5/27CEbfPHTpr6g+4L/H0trSAPXNIIBrZCjwXqb1CSYKziL
 DBO+/81052tqn5OluF62R3fT6sXcY7g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-pJgg61V4PwCiUZPLE0re_w-1; Sat, 08 Jun 2024 04:42:14 -0400
X-MC-Unique: pJgg61V4PwCiUZPLE0re_w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57c6979daf7so180439a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836132; x=1718440932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e54zIwB4ZotLZ75Nya5oaHP5znOGdXyOL0dXOi/s3BY=;
 b=tfaK6V4Rl4iV+gAgGasN7GqAHAYMP5/XpcslD5/4AyQqc+1Lz0E+ueRYfwgld2r2mp
 11HnKfN5Grzn5sXdnMc0OfTyFAtllf4bsJ2cWMPH86Yfxnb9Jjxvcur6W455OQrbYE9v
 pmH8rZqKgTjB6GVp6JB/smgTMFF+8SVEeTyBh4GJqY/9WCmRdrJLw/ckXuRRs/q9d7CJ
 4v1aMleSajKNnCp4E0IyHhiDxmGDOyosS31o8VtTyhkqFrOykDdxA6zRqSqc1Y0je9Uq
 GpdjYa4MMX644n1bfjZZp2bbU1a8dm8bifvlG+Hs7wThd9RW7tLLKaAri6LCipGze9DN
 sTGQ==
X-Gm-Message-State: AOJu0YxflcqbS2cnomy/2ctvbLlAv3w0dBeQ862RlJ/nN2H0pdiWtQUk
 RSvaXRsss9BKGPiSmk+oa1HxUbk0/BadI0M9i/1m/k6TR+yDyxGxkN72FO+hYslkGcLdt/UYPCF
 pUPdP4jFR6GMwD3PtcLSta9cCap+7Yl7TJN1NuglUEBCqWRKvE4gBNFb8h143TZWfOrNwyLJGyz
 c4bBe1pa47O35uCyeV5bayi3qonN8oQxuvvWaw
X-Received: by 2002:a50:cd56:0:b0:57a:31c6:69cf with SMTP id
 4fb4d7f45d1cf-57c50990d57mr2461490a12.28.1717836132329; 
 Sat, 08 Jun 2024 01:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoEa/m+uBJrPOHWW9ztTd/5V4IWDSpV3aUNNXUADrJAueF/31IVE3psJdy5ZIldLel4XBZHw==
X-Received: by 2002:a50:cd56:0:b0:57a:31c6:69cf with SMTP id
 4fb4d7f45d1cf-57c50990d57mr2461481a12.28.1717836131850; 
 Sat, 08 Jun 2024 01:42:11 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0ffbf8sm3981249a12.39.2024.06.08.01.42.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:42:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/25] target/i386: adapt gen_shift_count for SHLD/SHRD
Date: Sat,  8 Jun 2024 10:41:04 +0200
Message-ID: <20240608084113.2770363-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SHLD/SHRD can have 3 register operands - s->T0, s->T1 and either
1 or CL - and therefore decode->op[2] is taken by the low part
of the register being shifted.  Pass X86_OP_* to gen_shift_count
from its current callers and hardcode cpu_regs[R_ECX] as the
shift count.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 41398e5130c..2e73b41cd3e 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2998,16 +2998,16 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
 }
 
 static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
-                             bool *can_be_zero, TCGv *count)
+                             bool *can_be_zero, TCGv *count, int unit)
 {
     MemOp ot = decode->op[0].ot;
     int mask = (ot <= MO_32 ? 0x1f : 0x3f);
 
     *can_be_zero = false;
-    switch (decode->op[2].unit) {
+    switch (unit) {
     case X86_OP_INT:
         *count = tcg_temp_new();
-        tcg_gen_andi_tl(*count, s->T1, mask);
+        tcg_gen_andi_tl(*count, cpu_regs[R_ECX], mask);
         *can_be_zero = true;
         break;
 
@@ -3192,7 +3192,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, low_count;
 
     if (!count) {
@@ -3244,7 +3244,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, high_count;
 
     if (!count) {
@@ -3422,7 +3422,7 @@ static void gen_ROL(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv_i32 temp32, count32;
     TCGv old = tcg_temp_new();
 
@@ -3450,7 +3450,7 @@ static void gen_ROR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv_i32 temp32, count32;
     TCGv old = tcg_temp_new();
 
@@ -3562,7 +3562,7 @@ static void gen_SAR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
 
     if (!count) {
         return;
@@ -3690,7 +3690,7 @@ static void gen_SHL(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
 
     if (!count) {
         return;
@@ -3722,7 +3722,7 @@ static void gen_SHR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
 
     if (!count) {
         return;
-- 
2.45.1


