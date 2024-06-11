Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0610C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2Rf-00077D-6B; Tue, 11 Jun 2024 10:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rb-0006zM-Om
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RZ-00062R-VG
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtpA8jO2B8YYkVW7V6besTBoo0joDWNRiMliiJ4GgY8=;
 b=bHRG7bJqJhqmQXtNj4en8aR0HeKF5XDxznSpkfJP5zk1XY3ItPKT63iXTMF4bo9TziSyh5
 W7MPYhQyMSHAZmGFTqT4a6+K09C5FdWJ3yPI/9sYiK81KlRtg9utEob2Eac2v5ePMMWc5z
 BODQ/Lm3i5Iy+mYWgQ5HATUEgCZhOME=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-r-5EmMJcPWabOj-7CkUewQ-1; Tue, 11 Jun 2024 10:25:48 -0400
X-MC-Unique: r-5EmMJcPWabOj-7CkUewQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6ef4489474so214907766b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115945; x=1718720745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtpA8jO2B8YYkVW7V6besTBoo0joDWNRiMliiJ4GgY8=;
 b=WE9zqGvFsvxkoL72WNhcKTX9dyULoetBSoMIx1bEkkonDYGe6vnrSPd358i3Hi6n5J
 wjprDeTznVG3TaIL4pLK/7CGyw4U/XYy4AXpSCEEHebDPgeYTdSlJJQD4ShMn3cJf9Zy
 tvTYrzxLNJWVeui7gAiYwvFBQQnKpVa4q2nyfzpSvinCHoDT2/PGEkIAzYw2y1jolDb5
 rKFmgGROTLojq36gi3xcD4e1n76c6Az6nXDFRNd7vq9wYG/DoSLmCxQtmTPYvyHWLLKq
 RM1PDmQscG9yVbdrHxaOeQcxK9OM1GPxiI1c7mqFvm7DkovQwssTbH8OqA27eBvsPToP
 hOpg==
X-Gm-Message-State: AOJu0YzPvzSkJ7uN1QZf1s6J1VN11x8+31RH8zJ7JJIgsyU82MLHqn35
 EHjB9CzsLEEe6F7H7cNQaRP7KPj5YclI9hp2B9kcixW+YZPu7/AyuHkD+MUgmNicxHLRv8g87DY
 O/6morrR443iMzrn3VswiWgNpKI4ZpjSEIMMGiLl3PDP9spgTrYU9Y6m8d2X/1QH+T+jvODX9he
 qgTTiPA/NMR6QrCDQ9539OjA1MhFpx5d4zqzty
X-Received: by 2002:a17:906:cc93:b0:a6e:88cc:bee9 with SMTP id
 a640c23a62f3a-a6e88ccbf2bmr663606566b.24.1718115944766; 
 Tue, 11 Jun 2024 07:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnFrP2SVZ3xiw8Ayxo+ba5VMn4BBlhiYgesJmG9oIftX/2LHuZGrzjSStWl23T8s93xXpinw==
X-Received: by 2002:a17:906:cc93:b0:a6e:88cc:bee9 with SMTP id
 a640c23a62f3a-a6e88ccbf2bmr663605666b.24.1718115944329; 
 Tue, 11 Jun 2024 07:25:44 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1480821esm356150566b.150.2024.06.11.07.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/25] target/i386: change X86_ENTRYr to use T0
Date: Tue, 11 Jun 2024 16:25:07 +0200
Message-ID: <20240611142524.83762-10-pbonzini@redhat.com>
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

I am not sure why I made it use T1.  It is a bit more symmetric with
respect to X86_ENTRYwr (which uses T0 for the "w"ritten operand
and T1 for the "r"ead operand), but it is also less flexible because it
does not let you apply zextT0/sextT0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc |  6 +++---
 target/i386/tcg/emit.c.inc       | 34 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 380fb793531..f9d3e2577b2 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -186,7 +186,7 @@
 #define X86_OP_ENTRYw(op, op0, s0, ...)                           \
     X86_OP_ENTRY3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRYr(op, op0, s0, ...)                           \
-    X86_OP_ENTRY3(op, None, None, None, None, op0, s0, ## __VA_ARGS__)
+    X86_OP_ENTRY3(op, None, None, op0, s0, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRY1(op, op0, s0, ...)                           \
     X86_OP_ENTRY3(op, op0, s0, 2op, s0, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRY0(op, ...)                                    \
@@ -1335,9 +1335,9 @@ static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry
         /* 0xff */
         [0x08] = X86_OP_ENTRY1(INC,     E,v,                           lock),
         [0x09] = X86_OP_ENTRY1(DEC,     E,v,                           lock),
-        [0x0a] = X86_OP_ENTRY3(CALL_m,  None, None, E,f64, None, None, zextT0),
+        [0x0a] = X86_OP_ENTRYr(CALL_m,  E,f64,                         zextT0),
         [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
-        [0x0c] = X86_OP_ENTRY3(JMP_m,   None, None, E,f64, None, None, zextT0),
+        [0x0c] = X86_OP_ENTRYr(JMP_m,   E,f64,                         zextT0),
         [0x0d] = X86_OP_ENTRYr(JMPF_m,  M,p),
         [0x0e] = X86_OP_ENTRYr(PUSH,    E,f64),
     };
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a25b3dfc6b5..797e6e81406 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1363,7 +1363,7 @@ static void gen_CALLF(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_CALLF_m(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[2].ot;
+    MemOp ot = decode->op[1].ot;
 
     gen_op_ld_v(s, ot, s->T0, s->A0);
     gen_add_A0_im(s, 1 << ot);
@@ -1593,22 +1593,22 @@ static void gen_DEC(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_DIV(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[2].ot;
+    MemOp ot = decode->op[1].ot;
 
     switch(ot) {
     case MO_8:
-        gen_helper_divb_AL(tcg_env, s->T1);
+        gen_helper_divb_AL(tcg_env, s->T0);
         break;
     case MO_16:
-        gen_helper_divw_AX(tcg_env, s->T1);
+        gen_helper_divw_AX(tcg_env, s->T0);
         break;
     default:
     case MO_32:
-        gen_helper_divl_EAX(tcg_env, s->T1);
+        gen_helper_divl_EAX(tcg_env, s->T0);
         break;
 #ifdef TARGET_X86_64
     case MO_64:
-        gen_helper_divq_EAX(tcg_env, s->T1);
+        gen_helper_divq_EAX(tcg_env, s->T0);
         break;
 #endif
     }
@@ -1649,22 +1649,22 @@ static void gen_HLT(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_IDIV(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[2].ot;
+    MemOp ot = decode->op[1].ot;
 
     switch(ot) {
     case MO_8:
-        gen_helper_idivb_AL(tcg_env, s->T1);
+        gen_helper_idivb_AL(tcg_env, s->T0);
         break;
     case MO_16:
-        gen_helper_idivw_AX(tcg_env, s->T1);
+        gen_helper_idivw_AX(tcg_env, s->T0);
         break;
     default:
     case MO_32:
-        gen_helper_idivl_EAX(tcg_env, s->T1);
+        gen_helper_idivl_EAX(tcg_env, s->T0);
         break;
 #ifdef TARGET_X86_64
     case MO_64:
-        gen_helper_idivq_EAX(tcg_env, s->T1);
+        gen_helper_idivq_EAX(tcg_env, s->T0);
         break;
 #endif
     }
@@ -1926,7 +1926,7 @@ static void gen_JMPF(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_JMPF_m(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[2].ot;
+    MemOp ot = decode->op[1].ot;
 
     gen_op_ld_v(s, ot, s->T0, s->A0);
     gen_add_A0_im(s, 1 << ot);
@@ -1947,7 +1947,7 @@ static void gen_LAHF(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_LDMXCSR(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
+    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
     gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
 }
 
@@ -1995,7 +1995,7 @@ static void gen_LGS(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_LODS(DisasContext *s, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[2].ot;
+    MemOp ot = decode->op[1].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
         gen_repz(s, ot, gen_lods);
     } else {
@@ -2765,7 +2765,7 @@ static void gen_PSLLDQ_i(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_PUSH(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_push_v(s, s->T1);
+    gen_push_v(s, s->T0);
 }
 
 static void gen_PUSHA(DisasContext *s, X86DecodedInsn *decode)
@@ -3077,7 +3077,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 {
-    int16_t adjust = decode->e.op2 == X86_TYPE_I ? decode->immediate : 0;
+    int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
 
     MemOp ot = gen_pop_T0(s);
     gen_stack_update(s, adjust + (1 << ot));
@@ -3088,7 +3088,7 @@ static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_RETF(DisasContext *s, X86DecodedInsn *decode)
 {
-    int16_t adjust = decode->e.op2 == X86_TYPE_I ? decode->immediate : 0;
+    int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
 
     if (!PE(s) || VM86(s)) {
         gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
-- 
2.45.1


