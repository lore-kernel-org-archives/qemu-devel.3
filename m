Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A371C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2S6-0007tW-DB; Tue, 11 Jun 2024 10:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S2-0007hL-Fj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Ry-0006Ab-Jb
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MpOMc5fAmMGlEE6N+wma1282p2g1YwkY5zTNBu61hNk=;
 b=aDOHFdE3422iLgGkUVGN7bzVKO6rTHdKl1PRE7HYHt9g/aNTYSFec28D1wTvM89AuFYuHX
 La9jwjZNGh8VTh/cgPBvwbHgo2bYAyeVAmxNhq1AnwX7w5vDKfIZouEcwumP5p2B1dwYg1
 1gdiW0Erkvse9CswTwC7EnAgEf2PrFk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-rCgKSAzRO9eEFhrhjjZ-ZQ-1; Tue, 11 Jun 2024 10:26:11 -0400
X-MC-Unique: rCgKSAzRO9eEFhrhjjZ-ZQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57c8b34a26eso774274a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115969; x=1718720769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpOMc5fAmMGlEE6N+wma1282p2g1YwkY5zTNBu61hNk=;
 b=hthiHw6ATbs89R+C3cEHmMGRHtYNL2eSFRWL0VoGBnoRtwX699jmZDSyLNq/BrDHgO
 tPEh05QDNxUrAIsyGUKdI6Xd/v8SdZOboAttdUG2pMJCnj6faFOepVMU4kHj4KjW2Tul
 halvGazl1L7eUII12D/hZ96PMuG3jQi+sXG3xCZg4A8IWFhFPfhaYWwz7M4Y0W5H7Xx8
 X9l7Rcj5iplbzdXClGC3hnnrWzXq4oshUixyFKeoXUgrfOS/JNnEK/jHxoURa6USnhyy
 RP+okQqLzQ08MCbMxnHnFyAWhSVEUuag75n7jnFlcrDjOnJfoASJeIEn+8PPRqh0VEw/
 RUlA==
X-Gm-Message-State: AOJu0YxvBDg+MXgSOJDlgUG2AkoetEgQEIZ48cs0YAeRdHZ9oEa+u2Oh
 Qjba02qXAr8lOTEqb3L2itPTZHaZZhQ8dqKasWILuljazz7w+KaS7A2Qhg4oPjoyyk+L8h90MIL
 UIVpujigFzX8O9NG0lZS6v5Vq5qfyI8NThuQbZu2i2wGeQWTvIe2q22RhV27I1XT4vtx322S+HF
 exbd+8wTYkaarf38wOEg3IemvhtrrfzC4vsUy5
X-Received: by 2002:a50:d712:0:b0:579:e6ff:c61f with SMTP id
 4fb4d7f45d1cf-57c508fd7f6mr11778552a12.25.1718115969215; 
 Tue, 11 Jun 2024 07:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgut4qL3MC09PLBQDbHWHIPaYXuYJfJDrJue/7KFLIDTwQ2C+TcxMh/erwbEdlh5KGv0larA==
X-Received: by 2002:a50:d712:0:b0:579:e6ff:c61f with SMTP id
 4fb4d7f45d1cf-57c508fd7f6mr11778532a12.25.1718115968845; 
 Tue, 11 Jun 2024 07:26:08 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c8e5a77d6sm2272051a12.0.2024.06.11.07.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/25] target/i386: adapt gen_shift_count for SHLD/SHRD
Date: Tue, 11 Jun 2024 16:25:18 +0200
Message-ID: <20240611142524.83762-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

SHLD/SHRD can have 3 register operands - s->T0, s->T1 and either
1 or CL - and therefore decode->op[2] is taken by the low part
of the register being shifted.  Pass X86_OP_* to gen_shift_count
from its current callers and hardcode cpu_regs[R_ECX] as the
shift count.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 92635f53cf4..156ea282af4 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2874,16 +2874,16 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
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
 
@@ -3068,7 +3068,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, low_count;
 
     if (!count) {
@@ -3120,7 +3120,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     bool have_1bit_cin, can_be_zero;
     TCGv count;
     TCGLabel *zero_label = NULL;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv low, high, high_count;
 
     if (!count) {
@@ -3298,7 +3298,7 @@ static void gen_ROL(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv_i32 temp32, count32;
     TCGv old = tcg_temp_new();
 
@@ -3326,7 +3326,7 @@ static void gen_ROR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
     TCGv_i32 temp32, count32;
     TCGv old = tcg_temp_new();
 
@@ -3438,7 +3438,7 @@ static void gen_SAR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
 
     if (!count) {
         return;
@@ -3566,7 +3566,7 @@ static void gen_SHL(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
 
     if (!count) {
         return;
@@ -3598,7 +3598,7 @@ static void gen_SHR(DisasContext *s, X86DecodedInsn *decode)
 {
     bool can_be_zero;
     TCGv count;
-    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count);
+    MemOp ot = gen_shift_count(s, decode, &can_be_zero, &count, decode->op[2].unit);
 
     if (!count) {
         return;
-- 
2.45.1


