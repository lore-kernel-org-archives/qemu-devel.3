Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39F5C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfg-0003P0-BR; Sat, 25 May 2024 07:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfe-0003O3-VX
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfU-00049R-CI
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UnQ8XaXrLzcSQsikYbP5n1x5Mt965H3dqhhEnw6Bkp0=;
 b=Sx6hDHSiL8/KXUMqDU0lN5aMxOmciiJeKKgjCNAkxfadW0rcd8LCdLQJLNflLJsG3f4O9a
 P5W0BjcTjoSMtI+X+66kD0/fp+gFDOECg5n7eONZ/KrxlEmrlRd8wrAdfX9Vui/u+dQKSN
 1hfMFDq+V0V0uNhPVvDyfPysWGJPty0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-PkEY-N03OwateNCqJXrBQw-1; Sat, 25 May 2024 07:34:29 -0400
X-MC-Unique: PkEY-N03OwateNCqJXrBQw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e95ad38ad1so14782161fa.3
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636867; x=1717241667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnQ8XaXrLzcSQsikYbP5n1x5Mt965H3dqhhEnw6Bkp0=;
 b=m1QPaHD/3l9Ai9Kdo3wTDUQbLr8y6WzyFr7RLjFTqjGhsk6MxvKaiLFg4yCN56s9bU
 pZ+W5nMgL4lRBnfTekRYCqIXmZ2Lv7OlHfqpWXUbOyNJuwmzUHXOio+nsgJBYiWduDcR
 B7KAauGDJsHHsKg1LapyA38lm4/esBpQM3+RUZP12HKvyxYssZAfGHOw64/A/iRf+xZk
 lh1P34LqzjAZj9mZnU0EgEqsQwDH/pO1mNVbv5fPJVmRMz4xFYFDoHrRA+/aKJ7cRs7g
 KfIkVq62vjodOhYwoJDelUKWxm/Ho/nMdTA52f/zipVgT2zNfKhCOd3A5+zBNSgIJkBn
 4LPA==
X-Gm-Message-State: AOJu0YxknomiKVwoaegMwR6UC4CxLVnIHvl0+sFuBxBLIojxaSaqIT7/
 k25ztQP45LDZP7XAi4nhIv9RdYjX3SBc0dd+HqrSIvwXSQyw9J7hlSw/2oo4y4HeINR3OzXJCQC
 WoN1mmsZuthN8GraSS5cJR0+L6/F+8NJATFxMP8UXsznelsmQYRjZBurialWbekRaWg+F+fPqtZ
 kLyYYZbQPl5LdGDMNlZqTWd5YU2Zc2eyh8wk+X
X-Received: by 2002:a05:651c:2222:b0:2de:ca7f:c849 with SMTP id
 38308e7fff4ca-2e95b279514mr44795671fa.43.1716636866736; 
 Sat, 25 May 2024 04:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFMgxgqCuK/qIRDRXRM0xm9/2a+3H1SszWZnAkX/TX3+bnmrwFpiUvx9q5dcSxgBVwAp0Fiw==
X-Received: by 2002:a05:651c:2222:b0:2de:ca7f:c849 with SMTP id
 38308e7fff4ca-2e95b279514mr44795501fa.43.1716636866233; 
 Sat, 25 May 2024 04:34:26 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93a812sm246492166b.50.2024.05.25.04.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/24] target/i386: introduce gen_lea_ss_ofs
Date: Sat, 25 May 2024 13:33:25 +0200
Message-ID: <20240525113332.1404158-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Generalize gen_stack_A0() to include an initial add and to use an arbitrary
destination.  This is a common pattern and it is not a huge burden to
add the extra arguments to the only caller of gen_stack_A0().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 51 +++++++++++++++----------------------
 target/i386/tcg/emit.c.inc  |  2 +-
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2a20f9bafbb..15993f83024 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2035,24 +2035,27 @@ static inline void gen_stack_update(DisasContext *s, int addend)
     gen_op_add_reg_im(s, mo_stacksize(s), R_ESP, addend);
 }
 
+static void gen_lea_ss_ofs(DisasContext *s, TCGv dest, TCGv src, target_ulong offset)
+{
+    if (offset) {
+        tcg_gen_addi_tl(dest, src, offset);
+        src = dest;
+    }
+    gen_lea_v_seg_dest(s, mo_stacksize(s), dest, src, R_SS, -1);
+}
+
 /* Generate a push. It depends on ss32, addseg and dflag.  */
 static void gen_push_v(DisasContext *s, TCGv val)
 {
     MemOp d_ot = mo_pushpop(s, s->dflag);
     MemOp a_ot = mo_stacksize(s);
     int size = 1 << d_ot;
-    TCGv new_esp = s->A0;
+    TCGv new_esp = tcg_temp_new();
 
-    tcg_gen_subi_tl(s->A0, cpu_regs[R_ESP], size);
-
-    if (!CODE64(s)) {
-        if (ADDSEG(s)) {
-            new_esp = tcg_temp_new();
-            tcg_gen_mov_tl(new_esp, s->A0);
-        }
-        gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
-    }
+    tcg_gen_subi_tl(new_esp, cpu_regs[R_ESP], size);
 
+    /* Now reduce the value to the address size and apply SS base.  */
+    gen_lea_ss_ofs(s, s->A0, new_esp, 0);
     gen_op_st_v(s, d_ot, val, s->A0);
     gen_op_mov_reg_v(s, a_ot, R_ESP, new_esp);
 }
@@ -2062,7 +2065,7 @@ static MemOp gen_pop_T0(DisasContext *s)
 {
     MemOp d_ot = mo_pushpop(s, s->dflag);
 
-    gen_lea_v_seg_dest(s, mo_stacksize(s), s->T0, cpu_regs[R_ESP], R_SS, -1);
+    gen_lea_ss_ofs(s, s->T0, cpu_regs[R_ESP], 0);
     gen_op_ld_v(s, d_ot, s->T0, s->T0);
 
     return d_ot;
@@ -2073,21 +2076,14 @@ static inline void gen_pop_update(DisasContext *s, MemOp ot)
     gen_stack_update(s, 1 << ot);
 }
 
-static inline void gen_stack_A0(DisasContext *s)
-{
-    gen_lea_v_seg(s, mo_stacksize(s), cpu_regs[R_ESP], R_SS, -1);
-}
-
 static void gen_pusha(DisasContext *s)
 {
-    MemOp s_ot = mo_stacksize(s);
     MemOp d_ot = s->dflag;
     int size = 1 << d_ot;
     int i;
 
     for (i = 0; i < 8; i++) {
-        tcg_gen_addi_tl(s->A0, cpu_regs[R_ESP], (i - 8) * size);
-        gen_lea_v_seg(s, s_ot, s->A0, R_SS, -1);
+        gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], (i - 8) * size);
         gen_op_st_v(s, d_ot, cpu_regs[7 - i], s->A0);
     }
 
@@ -2096,7 +2092,6 @@ static void gen_pusha(DisasContext *s)
 
 static void gen_popa(DisasContext *s)
 {
-    MemOp s_ot = mo_stacksize(s);
     MemOp d_ot = s->dflag;
     int size = 1 << d_ot;
     int i;
@@ -2106,8 +2101,7 @@ static void gen_popa(DisasContext *s)
         if (7 - i == R_ESP) {
             continue;
         }
-        tcg_gen_addi_tl(s->A0, cpu_regs[R_ESP], i * size);
-        gen_lea_v_seg(s, s_ot, s->A0, R_SS, -1);
+        gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], i * size);
         gen_op_ld_v(s, d_ot, s->T0, s->A0);
         gen_op_mov_reg_v(s, d_ot, 7 - i, s->T0);
     }
@@ -2123,7 +2117,7 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
 
     /* Push BP; compute FrameTemp into T1.  */
     tcg_gen_subi_tl(s->T1, cpu_regs[R_ESP], size);
-    gen_lea_v_seg(s, a_ot, s->T1, R_SS, -1);
+    gen_lea_ss_ofs(s, s->A0, s->T1, 0);
     gen_op_st_v(s, d_ot, cpu_regs[R_EBP], s->A0);
 
     level &= 31;
@@ -2132,18 +2126,15 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
 
         /* Copy level-1 pointers from the previous frame.  */
         for (i = 1; i < level; ++i) {
-            tcg_gen_subi_tl(s->A0, cpu_regs[R_EBP], size * i);
-            gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
+            gen_lea_ss_ofs(s, s->A0, cpu_regs[R_EBP], -size * i);
             gen_op_ld_v(s, d_ot, s->tmp0, s->A0);
 
-            tcg_gen_subi_tl(s->A0, s->T1, size * i);
-            gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
+            gen_lea_ss_ofs(s, s->A0, s->T1, -size * i);
             gen_op_st_v(s, d_ot, s->tmp0, s->A0);
         }
 
         /* Push the current FrameTemp as the last level.  */
-        tcg_gen_subi_tl(s->A0, s->T1, size * level);
-        gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
+        gen_lea_ss_ofs(s, s->A0, s->T1, -size * level);
         gen_op_st_v(s, d_ot, s->T1, s->A0);
     }
 
@@ -2160,7 +2151,7 @@ static void gen_leave(DisasContext *s)
     MemOp d_ot = mo_pushpop(s, s->dflag);
     MemOp a_ot = mo_stacksize(s);
 
-    gen_lea_v_seg(s, a_ot, cpu_regs[R_EBP], R_SS, -1);
+    gen_lea_ss_ofs(s, s->A0, cpu_regs[R_EBP], 0);
     gen_op_ld_v(s, d_ot, s->T0, s->A0);
 
     tcg_gen_addi_tl(s->T1, cpu_regs[R_EBP], 1 << d_ot);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 01ad57629e4..0a13be4989a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3077,7 +3077,7 @@ static void gen_RETF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     int16_t adjust = decode->e.op2 == X86_TYPE_I ? decode->immediate : 0;
 
     if (!PE(s) || VM86(s)) {
-        gen_stack_A0(s);
+        gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
         /* pop offset */
         gen_op_ld_v(s, s->dflag, s->T0, s->A0);
         /* NOTE: keeping EIP updated is not a problem in case of
-- 
2.45.1


