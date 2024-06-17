Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0816EC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEy0-0005Ek-DW; Mon, 17 Jun 2024 12:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJExv-0005Dr-Uy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:12:20 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJExs-0008AV-PB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:12:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f717b3f2d8so38959945ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718640735; x=1719245535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LU4SjJKqf+ERRYZSLiiBynsCwrBC0K0Sn0nz4JVZgM=;
 b=tkY3Frkv6sg9r9w+9WoM59yKC5SczI8N/REkb5fvmusk+yyuvVkX646Wp0fRCizbPf
 gWXX0Jg/rrDn40JmKfkXx0H6ZZS+TiE287qy/cPfXM/MS1UJsqQTica5rDHeUIrG4Fse
 HKuABe2y4ALLtU/SAkGmfcxGdkYILpf7RPhl2k/IvQ1bp3MT27TFoyXrezcWORN9s1QM
 /rLTI/5fSXau3dUNKz6vAPaQkBrhr1838amiGUrG0GeDCJiJ30tSZAMfOrSkrspK6fsT
 7iKecPNcwZtgwDDxobf24iuNcDXzmwWFv5fdf7KiGwmc+qQkHZE6JW9rcqFwJrcbQNnD
 xVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718640735; x=1719245535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LU4SjJKqf+ERRYZSLiiBynsCwrBC0K0Sn0nz4JVZgM=;
 b=lKzQjMCJNMhqCTSof/TtxZeyR6AeV92MYxP/CV2gcpIcCg5oUf2xqzhlz0j4Or3Oti
 R6z3dBXPcV+8X5XbKaeiqJyG5GMi2aMwThhdI/pVYHLsF8vrt04NFR4X2DxtNTT9DCv8
 bOi2G+sbeqrJ0sCUlO7Cx9QG1mhbv46jNXlCkI8n8mUW+P7aqRanrlCPkez2XYRIu/Py
 YbS48CvLVZicuurcW14AstFuvsDgX8WcMSssfCbku3+VTwX4I8UHs/UJZqFWRiXiXZAZ
 AWFyQ27bySlajAN7wmuNMb2DUHK5VJsgpu+K3pPtBnf5xU3j8tKFj8Mtn9g4aR9SpYuj
 02fg==
X-Gm-Message-State: AOJu0YxJEmaVHPL8b85h3JIsJL9IYRA9Gu2XnyWdnvduQ2zaZGVjSto3
 CC27yck7mSWb6zzpEuZOA4u9QL5PQLwcrnggrOOPktJAGe7tURT8T2+1m2KBJu43q6yJTJ8G4Cg
 9
X-Google-Smtp-Source: AGHT+IGhuxE2eYHMQF5/AX8jZOZBGQVHP3AHlWwrK6zIXXmF+s69V8Gv/kprcpICKTArchZV7TQjSA==
X-Received: by 2002:a17:902:f54f:b0:1f7:1bf3:db10 with SMTP id
 d9443c01a7336-1f98b23f6afmr1542315ad.20.1718640734490; 
 Mon, 17 Jun 2024 09:12:14 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee8317sm80829285ad.145.2024.06.17.09.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 09:12:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 3/3] target/i386: Reorg push/pop within seg_helper.c
Date: Mon, 17 Jun 2024 09:12:10 -0700
Message-Id: <20240617161210.4639-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617161210.4639-1-richard.henderson@linaro.org>
References: <20240617161210.4639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use a structure to contain the stack parameters,
env, unwind return address, and mmu index.
Rewrite the macros into functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/seg_helper.c | 465 +++++++++++++++++++----------------
 1 file changed, 253 insertions(+), 212 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 8884d82b33..d5bacd25f5 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -579,35 +579,47 @@ int exception_has_error_code(int intno)
     } while (0)
 #endif
 
-/* XXX: add a is_user flag to have proper security support */
-#define PUSHW_RA(ssp, sp, sp_mask, val, ra)                      \
-    {                                                            \
-        sp -= 2;                                                 \
-        cpu_stw_kernel_ra(env, (ssp) + (sp & (sp_mask)), (val), ra); \
-    }
+typedef struct PushPop
+{
+    CPUX86State *env;
+    uintptr_t ra;
+    target_ulong ss_base;
+    target_ulong sp;
+    target_ulong sp_mask;
+    int mmu_index;
+} PushPop;
 
-#define PUSHL_RA(ssp, sp, sp_mask, val, ra)                             \
-    {                                                                   \
-        sp -= 4;                                                        \
-        cpu_stl_kernel_ra(env, (ssp) + (sp & (sp_mask)), (val), ra); \
-    }
+static void pushw(PushPop *pp, uint16_t val)
+{
+    pp->sp -= 2;
+    cpu_stw_mmuidx_ra(pp->env, pp->ss_base + (pp->sp & pp->sp_mask),
+                      val, pp->mmu_index, pp->ra);
+}
 
-#define POPW_RA(ssp, sp, sp_mask, val, ra)                       \
-    {                                                            \
-        val = cpu_lduw_kernel_ra(env, (ssp) + (sp & (sp_mask)), ra); \
-        sp += 2;                                                 \
-    }
+static void pushl(PushPop *pp, uint32_t val)
+{
+    pp->sp -= 4;
+    cpu_stl_mmuidx_ra(pp->env, pp->ss_base + (pp->sp & pp->sp_mask),
+                      val, pp->mmu_index, pp->ra);
+}
 
-#define POPL_RA(ssp, sp, sp_mask, val, ra)                              \
-    {                                                                   \
-        val = (uint32_t)cpu_ldl_kernel_ra(env, (ssp) + (sp & (sp_mask)), ra); \
-        sp += 4;                                                        \
-    }
+static uint16_t popw(PushPop *pp)
+{
+    uint16_t ret = cpu_lduw_mmuidx_ra(pp->env,
+                                      pp->ss_base + (pp->sp & pp->sp_mask),
+                                      pp->mmu_index, pp->ra);
+    pp->sp += 2;
+    return ret;
+}
 
-#define PUSHW(ssp, sp, sp_mask, val) PUSHW_RA(ssp, sp, sp_mask, val, 0)
-#define PUSHL(ssp, sp, sp_mask, val) PUSHL_RA(ssp, sp, sp_mask, val, 0)
-#define POPW(ssp, sp, sp_mask, val) POPW_RA(ssp, sp, sp_mask, val, 0)
-#define POPL(ssp, sp, sp_mask, val) POPL_RA(ssp, sp, sp_mask, val, 0)
+static uint32_t popl(PushPop *pp)
+{
+    uint32_t ret = cpu_ldl_mmuidx_ra(pp->env,
+                                     pp->ss_base + (pp->sp & pp->sp_mask),
+                                     pp->mmu_index, pp->ra);
+    pp->sp += 4;
+    return ret;
+}
 
 /* protected mode interrupt */
 static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
@@ -615,12 +627,13 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
                                    int is_hw)
 {
     SegmentCache *dt;
-    target_ulong ptr, ssp;
+    target_ulong ptr;
     int type, dpl, selector, ss_dpl, cpl;
     int has_error_code, new_stack, shift;
-    uint32_t e1, e2, offset, ss = 0, esp, ss_e1 = 0, ss_e2 = 0;
-    uint32_t old_eip, sp_mask, eflags;
+    uint32_t e1, e2, offset, ss = 0, ss_e1 = 0, ss_e2 = 0;
+    uint32_t old_eip, eflags;
     int vm86 = env->eflags & VM_MASK;
+    PushPop pp;
     bool set_rf;
 
     has_error_code = 0;
@@ -662,6 +675,10 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         raise_exception_err(env, EXCP0D_GPF, intno * 8 + 2);
     }
 
+    pp.env = env;
+    pp.ra = 0;
+    pp.mmu_index = cpu_mmu_index_kernel(env);
+
     if (type == 5) {
         /* task gate */
         /* must do that check here to return the correct error code */
@@ -670,22 +687,20 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         }
         shift = switch_tss(env, intno * 8, e1, e2, SWITCH_TSS_CALL, old_eip);
         if (has_error_code) {
-            uint32_t mask;
-
             /* push the error code */
             if (env->segs[R_SS].flags & DESC_B_MASK) {
-                mask = 0xffffffff;
+                pp.sp_mask = 0xffffffff;
             } else {
-                mask = 0xffff;
+                pp.sp_mask = 0xffff;
             }
-            esp = (env->regs[R_ESP] - (2 << shift)) & mask;
-            ssp = env->segs[R_SS].base + esp;
+            pp.sp = env->regs[R_ESP];
+            pp.ss_base = env->segs[R_SS].base;
             if (shift) {
-                cpu_stl_kernel(env, ssp, error_code);
+                pushl(&pp, error_code);
             } else {
-                cpu_stw_kernel(env, ssp, error_code);
+                pushw(&pp, error_code);
             }
-            SET_ESP(esp, mask);
+            SET_ESP(pp.sp, pp.sp_mask);
         }
         return;
     }
@@ -719,7 +734,9 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     }
     if (dpl < cpl) {
         /* to inner privilege */
+        uint32_t esp;
         get_ss_esp_from_tss(env, &ss, &esp, dpl, 0);
+        pp.sp = esp;
         if ((ss & 0xfffc) == 0) {
             raise_exception_err(env, EXCP0A_TSS, ss & 0xfffc);
         }
@@ -742,17 +759,17 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
             raise_exception_err(env, EXCP0A_TSS, ss & 0xfffc);
         }
         new_stack = 1;
-        sp_mask = get_sp_mask(ss_e2);
-        ssp = get_seg_base(ss_e1, ss_e2);
+        pp.sp_mask = get_sp_mask(ss_e2);
+        pp.ss_base = get_seg_base(ss_e1, ss_e2);
     } else  {
         /* to same privilege */
         if (vm86) {
             raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
         }
         new_stack = 0;
-        sp_mask = get_sp_mask(env->segs[R_SS].flags);
-        ssp = env->segs[R_SS].base;
-        esp = env->regs[R_ESP];
+        pp.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+        pp.ss_base = env->segs[R_SS].base;
+        pp.sp = env->regs[R_ESP];
     }
 
     shift = type >> 3;
@@ -777,36 +794,36 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     if (shift == 1) {
         if (new_stack) {
             if (vm86) {
-                PUSHL(ssp, esp, sp_mask, env->segs[R_GS].selector);
-                PUSHL(ssp, esp, sp_mask, env->segs[R_FS].selector);
-                PUSHL(ssp, esp, sp_mask, env->segs[R_DS].selector);
-                PUSHL(ssp, esp, sp_mask, env->segs[R_ES].selector);
+                pushl(&pp, env->segs[R_GS].selector);
+                pushl(&pp, env->segs[R_FS].selector);
+                pushl(&pp, env->segs[R_DS].selector);
+                pushl(&pp, env->segs[R_ES].selector);
             }
-            PUSHL(ssp, esp, sp_mask, env->segs[R_SS].selector);
-            PUSHL(ssp, esp, sp_mask, env->regs[R_ESP]);
+            pushl(&pp, env->segs[R_SS].selector);
+            pushl(&pp, env->regs[R_ESP]);
         }
-        PUSHL(ssp, esp, sp_mask, eflags);
-        PUSHL(ssp, esp, sp_mask, env->segs[R_CS].selector);
-        PUSHL(ssp, esp, sp_mask, old_eip);
+        pushl(&pp, eflags);
+        pushl(&pp, env->segs[R_CS].selector);
+        pushl(&pp, old_eip);
         if (has_error_code) {
-            PUSHL(ssp, esp, sp_mask, error_code);
+            pushl(&pp, error_code);
         }
     } else {
         if (new_stack) {
             if (vm86) {
-                PUSHW(ssp, esp, sp_mask, env->segs[R_GS].selector);
-                PUSHW(ssp, esp, sp_mask, env->segs[R_FS].selector);
-                PUSHW(ssp, esp, sp_mask, env->segs[R_DS].selector);
-                PUSHW(ssp, esp, sp_mask, env->segs[R_ES].selector);
+                pushw(&pp, env->segs[R_GS].selector);
+                pushw(&pp, env->segs[R_FS].selector);
+                pushw(&pp, env->segs[R_DS].selector);
+                pushw(&pp, env->segs[R_ES].selector);
             }
-            PUSHW(ssp, esp, sp_mask, env->segs[R_SS].selector);
-            PUSHW(ssp, esp, sp_mask, env->regs[R_ESP]);
+            pushw(&pp, env->segs[R_SS].selector);
+            pushw(&pp, env->regs[R_ESP]);
         }
-        PUSHW(ssp, esp, sp_mask, eflags);
-        PUSHW(ssp, esp, sp_mask, env->segs[R_CS].selector);
-        PUSHW(ssp, esp, sp_mask, old_eip);
+        pushw(&pp, eflags);
+        pushw(&pp, env->segs[R_CS].selector);
+        pushw(&pp, old_eip);
         if (has_error_code) {
-            PUSHW(ssp, esp, sp_mask, error_code);
+            pushw(&pp, error_code);
         }
     }
 
@@ -824,10 +841,10 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
             cpu_x86_load_seg_cache(env, R_GS, 0, 0, 0, 0);
         }
         ss = (ss & ~3) | dpl;
-        cpu_x86_load_seg_cache(env, R_SS, ss,
-                               ssp, get_seg_limit(ss_e1, ss_e2), ss_e2);
+        cpu_x86_load_seg_cache(env, R_SS, ss, pp.ss_base,
+                               get_seg_limit(ss_e1, ss_e2), ss_e2);
     }
-    SET_ESP(esp, sp_mask);
+    SET_ESP(pp.sp, pp.sp_mask);
 
     selector = (selector & ~3) | dpl;
     cpu_x86_load_seg_cache(env, R_CS, selector,
@@ -839,20 +856,18 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
 #ifdef TARGET_X86_64
 
-#define PUSHQ_RA(sp, val, ra)                   \
-    {                                           \
-        sp -= 8;                                \
-        cpu_stq_kernel_ra(env, sp, (val), ra);  \
-    }
+static void pushq(PushPop *pp, uint64_t val)
+{
+    pp->sp -= 8;
+    cpu_stq_mmuidx_ra(pp->env, pp->sp, val, pp->mmu_index, pp->ra);
+}
 
-#define POPQ_RA(sp, val, ra)                    \
-    {                                           \
-        val = cpu_ldq_kernel_ra(env, sp, ra);   \
-        sp += 8;                                \
-    }
-
-#define PUSHQ(sp, val) PUSHQ_RA(sp, val, 0)
-#define POPQ(sp, val) POPQ_RA(sp, val, 0)
+static uint64_t popq(PushPop *pp)
+{
+    uint64_t ret = cpu_ldq_mmuidx_ra(pp->env, pp->sp, pp->mmu_index, pp->ra);
+    pp->sp += 8;
+    return ret;
+}
 
 static inline target_ulong get_rsp_from_tss(CPUX86State *env, int level)
 {
@@ -895,8 +910,15 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     int type, dpl, selector, cpl, ist;
     int has_error_code, new_stack;
     uint32_t e1, e2, e3, ss, eflags;
-    target_ulong old_eip, esp, offset;
+    target_ulong old_eip, offset;
     bool set_rf;
+    PushPop pp;
+
+    pp.env = env;
+    pp.ra = 0;
+    pp.mmu_index = cpu_mmu_index_kernel(env);
+    pp.sp_mask = -1;
+    pp.ss_base = 0;
 
     has_error_code = 0;
     if (!is_int && !is_hw) {
@@ -967,7 +989,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     if (dpl < cpl || ist != 0) {
         /* to inner privilege */
         new_stack = 1;
-        esp = get_rsp_from_tss(env, ist != 0 ? ist + 3 : dpl);
+        pp.sp = get_rsp_from_tss(env, ist != 0 ? ist + 3 : dpl);
         ss = 0;
     } else {
         /* to same privilege */
@@ -975,9 +997,9 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
             raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
         }
         new_stack = 0;
-        esp = env->regs[R_ESP];
+        pp.sp = env->regs[R_ESP];
     }
-    esp &= ~0xfLL; /* align stack */
+    pp.sp &= ~0xfLL; /* align stack */
 
     /* See do_interrupt_protected.  */
     eflags = cpu_compute_eflags(env);
@@ -985,13 +1007,13 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
         eflags |= RF_MASK;
     }
 
-    PUSHQ(esp, env->segs[R_SS].selector);
-    PUSHQ(esp, env->regs[R_ESP]);
-    PUSHQ(esp, eflags);
-    PUSHQ(esp, env->segs[R_CS].selector);
-    PUSHQ(esp, old_eip);
+    pushq(&pp, env->segs[R_SS].selector);
+    pushq(&pp, env->regs[R_ESP]);
+    pushq(&pp, eflags);
+    pushq(&pp, env->segs[R_CS].selector);
+    pushq(&pp, old_eip);
     if (has_error_code) {
-        PUSHQ(esp, error_code);
+        pushq(&pp, error_code);
     }
 
     /* interrupt gate clear IF mask */
@@ -1004,7 +1026,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
         ss = 0 | dpl;
         cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, dpl << DESC_DPL_SHIFT);
     }
-    env->regs[R_ESP] = esp;
+    env->regs[R_ESP] = pp.sp;
 
     selector = (selector & ~3) | dpl;
     cpu_x86_load_seg_cache(env, R_CS, selector,
@@ -1076,10 +1098,11 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
                               int error_code, unsigned int next_eip)
 {
     SegmentCache *dt;
-    target_ulong ptr, ssp;
+    target_ulong ptr;
     int selector;
-    uint32_t offset, esp;
+    uint32_t offset;
     uint32_t old_cs, old_eip;
+    PushPop pp;
 
     /* real mode (simpler!) */
     dt = &env->idt;
@@ -1089,8 +1112,14 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     ptr = dt->base + intno * 4;
     offset = cpu_lduw_kernel(env, ptr);
     selector = cpu_lduw_kernel(env, ptr + 2);
-    esp = env->regs[R_ESP];
-    ssp = env->segs[R_SS].base;
+
+    pp.env = env;
+    pp.ra = 0;
+    pp.sp = env->regs[R_ESP];
+    pp.sp_mask = 0xffff;
+    pp.ss_base = env->segs[R_SS].base;
+    pp.mmu_index = cpu_mmu_index_kernel(env);
+
     if (is_int) {
         old_eip = next_eip;
     } else {
@@ -1098,12 +1127,12 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     }
     old_cs = env->segs[R_CS].selector;
     /* XXX: use SS segment size? */
-    PUSHW(ssp, esp, 0xffff, cpu_compute_eflags(env));
-    PUSHW(ssp, esp, 0xffff, old_cs);
-    PUSHW(ssp, esp, 0xffff, old_eip);
+    pushw(&pp, cpu_compute_eflags(env));
+    pushw(&pp, old_cs);
+    pushw(&pp, old_eip);
 
     /* update processor state */
-    env->regs[R_ESP] = (env->regs[R_ESP] & ~0xffff) | (esp & 0xffff);
+    SET_ESP(pp.sp, pp.sp_mask);
     env->eip = offset;
     env->segs[R_CS].selector = selector;
     env->segs[R_CS].base = (selector << 4);
@@ -1546,21 +1575,24 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
                        int shift, uint32_t next_eip)
 {
-    uint32_t esp, esp_mask;
-    target_ulong ssp;
+    PushPop pp;
+
+    pp.env = env;
+    pp.ra = GETPC();
+    pp.sp = env->regs[R_ESP];
+    pp.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+    pp.ss_base = env->segs[R_SS].base;
+    pp.mmu_index = cpu_mmu_index_kernel(env);
 
-    esp = env->regs[R_ESP];
-    esp_mask = get_sp_mask(env->segs[R_SS].flags);
-    ssp = env->segs[R_SS].base;
     if (shift) {
-        PUSHL_RA(ssp, esp, esp_mask, env->segs[R_CS].selector, GETPC());
-        PUSHL_RA(ssp, esp, esp_mask, next_eip, GETPC());
+        pushl(&pp, env->segs[R_CS].selector);
+        pushl(&pp, next_eip);
     } else {
-        PUSHW_RA(ssp, esp, esp_mask, env->segs[R_CS].selector, GETPC());
-        PUSHW_RA(ssp, esp, esp_mask, next_eip, GETPC());
+        pushw(&pp, env->segs[R_CS].selector);
+        pushw(&pp, next_eip);
     }
 
-    SET_ESP(esp, esp_mask);
+    SET_ESP(pp.sp, pp.sp_mask);
     env->eip = new_eip;
     env->segs[R_CS].selector = new_cs;
     env->segs[R_CS].base = (new_cs << 4);
@@ -1572,9 +1604,14 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 {
     int new_stack, i;
     uint32_t e1, e2, cpl, dpl, rpl, selector, param_count;
-    uint32_t ss = 0, ss_e1 = 0, ss_e2 = 0, type, ss_dpl, sp_mask;
-    uint32_t val, limit, old_sp_mask;
-    target_ulong ssp, old_ssp, offset, sp;
+    uint32_t ss = 0, ss_e1 = 0, ss_e2 = 0, type, ss_dpl;
+    uint32_t limit;
+    target_ulong offset;
+    PushPop pp;
+
+    pp.env = env;
+    pp.ra = GETPC();
+    pp.mmu_index = cpu_mmu_index_kernel(env);
 
     LOG_PCALL("lcall %04x:" TARGET_FMT_lx " s=%d\n", new_cs, new_eip, shift);
     LOG_PCALL_STATE(env_cpu(env));
@@ -1613,14 +1650,14 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 #ifdef TARGET_X86_64
         /* XXX: check 16/32 bit cases in long mode */
         if (shift == 2) {
-            target_ulong rsp;
-
             /* 64 bit case */
-            rsp = env->regs[R_ESP];
-            PUSHQ_RA(rsp, env->segs[R_CS].selector, GETPC());
-            PUSHQ_RA(rsp, next_eip, GETPC());
+            pp.sp = env->regs[R_ESP];
+            pp.sp_mask = -1;
+            pp.ss_base = 0;
+            pushq(&pp, env->segs[R_CS].selector);
+            pushq(&pp, next_eip);
             /* from this point, not restartable */
-            env->regs[R_ESP] = rsp;
+            env->regs[R_ESP] = pp.sp;
             cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
                                    get_seg_base(e1, e2),
                                    get_seg_limit(e1, e2), e2);
@@ -1628,15 +1665,15 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         } else
 #endif
         {
-            sp = env->regs[R_ESP];
-            sp_mask = get_sp_mask(env->segs[R_SS].flags);
-            ssp = env->segs[R_SS].base;
+            pp.sp = env->regs[R_ESP];
+            pp.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+            pp.ss_base = env->segs[R_SS].base;
             if (shift) {
-                PUSHL_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
-                PUSHL_RA(ssp, sp, sp_mask, next_eip, GETPC());
+                pushl(&pp, env->segs[R_CS].selector);
+                pushl(&pp, next_eip);
             } else {
-                PUSHW_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
-                PUSHW_RA(ssp, sp, sp_mask, next_eip, GETPC());
+                pushw(&pp, env->segs[R_CS].selector);
+                pushw(&pp, next_eip);
             }
 
             limit = get_seg_limit(e1, e2);
@@ -1644,7 +1681,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                 raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
             }
             /* from this point, not restartable */
-            SET_ESP(sp, sp_mask);
+            SET_ESP(pp.sp, pp.sp_mask);
             cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
                                    get_seg_base(e1, e2), limit, e2);
             env->eip = new_eip;
@@ -1739,13 +1776,13 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             /* to inner privilege */
 #ifdef TARGET_X86_64
             if (shift == 2) {
-                sp = get_rsp_from_tss(env, dpl);
+                pp.sp = get_rsp_from_tss(env, dpl);
                 ss = dpl;  /* SS = NULL selector with RPL = new CPL */
                 new_stack = 1;
-                sp_mask = 0;
-                ssp = 0;  /* SS base is always zero in IA-32e mode */
+                pp.sp_mask = -1;
+                pp.ss_base = 0;  /* SS base is always zero in IA-32e mode */
                 LOG_PCALL("new ss:rsp=%04x:%016llx env->regs[R_ESP]="
-                          TARGET_FMT_lx "\n", ss, sp, env->regs[R_ESP]);
+                          TARGET_FMT_lx "\n", ss, pp.sp, env->regs[R_ESP]);
             } else
 #endif
             {
@@ -1754,7 +1791,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                 LOG_PCALL("new ss:esp=%04x:%08x param_count=%d env->regs[R_ESP]="
                           TARGET_FMT_lx "\n", ss, sp32, param_count,
                           env->regs[R_ESP]);
-                sp = sp32;
+                pp.sp = sp32;
                 if ((ss & 0xfffc) == 0) {
                     raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
                 }
@@ -1777,63 +1814,63 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                     raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
                 }
 
-                sp_mask = get_sp_mask(ss_e2);
-                ssp = get_seg_base(ss_e1, ss_e2);
+                pp.sp_mask = get_sp_mask(ss_e2);
+                pp.ss_base = get_seg_base(ss_e1, ss_e2);
             }
 
             /* push_size = ((param_count * 2) + 8) << shift; */
 
-            old_sp_mask = get_sp_mask(env->segs[R_SS].flags);
-            old_ssp = env->segs[R_SS].base;
 #ifdef TARGET_X86_64
             if (shift == 2) {
                 /* XXX: verify if new stack address is canonical */
-                PUSHQ_RA(sp, env->segs[R_SS].selector, GETPC());
-                PUSHQ_RA(sp, env->regs[R_ESP], GETPC());
+                pushq(&pp, env->segs[R_SS].selector);
+                pushq(&pp, env->regs[R_ESP]);
                 /* parameters aren't supported for 64-bit call gates */
             } else
 #endif
-            if (shift == 1) {
-                PUSHL_RA(ssp, sp, sp_mask, env->segs[R_SS].selector, GETPC());
-                PUSHL_RA(ssp, sp, sp_mask, env->regs[R_ESP], GETPC());
-                for (i = param_count - 1; i >= 0; i--) {
-                    val = cpu_ldl_kernel_ra(env, old_ssp +
-                                            ((env->regs[R_ESP] + i * 4) &
-                                             old_sp_mask), GETPC());
-                    PUSHL_RA(ssp, sp, sp_mask, val, GETPC());
-                }
-            } else {
-                PUSHW_RA(ssp, sp, sp_mask, env->segs[R_SS].selector, GETPC());
-                PUSHW_RA(ssp, sp, sp_mask, env->regs[R_ESP], GETPC());
-                for (i = param_count - 1; i >= 0; i--) {
-                    val = cpu_lduw_kernel_ra(env, old_ssp +
-                                             ((env->regs[R_ESP] + i * 2) &
-                                              old_sp_mask), GETPC());
-                    PUSHW_RA(ssp, sp, sp_mask, val, GETPC());
+            {
+                PushPop old_pp;
+
+                old_pp = pp;
+                old_pp.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+                old_pp.ss_base = env->segs[R_SS].base;
+
+                if (shift == 1) {
+                    pushl(&pp, env->segs[R_SS].selector);
+                    pushl(&pp, env->regs[R_ESP]);
+                    for (i = param_count - 1; i >= 0; i--) {
+                        pushl(&pp, popl(&old_pp));
+                    }
+                } else {
+                    pushw(&pp, env->segs[R_SS].selector);
+                    pushw(&pp, env->regs[R_ESP]);
+                    for (i = param_count - 1; i >= 0; i--) {
+                        pushw(&pp, popw(&old_pp));
+                    }
                 }
             }
             new_stack = 1;
         } else {
             /* to same privilege */
-            sp = env->regs[R_ESP];
-            sp_mask = get_sp_mask(env->segs[R_SS].flags);
-            ssp = env->segs[R_SS].base;
+            pp.sp = env->regs[R_ESP];
+            pp.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+            pp.ss_base = env->segs[R_SS].base;
             /* push_size = (4 << shift); */
             new_stack = 0;
         }
 
 #ifdef TARGET_X86_64
         if (shift == 2) {
-            PUSHQ_RA(sp, env->segs[R_CS].selector, GETPC());
-            PUSHQ_RA(sp, next_eip, GETPC());
+            pushq(&pp, env->segs[R_CS].selector);
+            pushq(&pp, next_eip);
         } else
 #endif
         if (shift == 1) {
-            PUSHL_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
-            PUSHL_RA(ssp, sp, sp_mask, next_eip, GETPC());
+            pushl(&pp, env->segs[R_CS].selector);
+            pushl(&pp, next_eip);
         } else {
-            PUSHW_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
-            PUSHW_RA(ssp, sp, sp_mask, next_eip, GETPC());
+            pushw(&pp, env->segs[R_CS].selector);
+            pushw(&pp, next_eip);
         }
 
         /* from this point, not restartable */
@@ -1847,7 +1884,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             {
                 ss = (ss & ~3) | dpl;
                 cpu_x86_load_seg_cache(env, R_SS, ss,
-                                       ssp,
+                                       pp.ss_base,
                                        get_seg_limit(ss_e1, ss_e2),
                                        ss_e2);
             }
@@ -1858,7 +1895,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                        get_seg_base(e1, e2),
                        get_seg_limit(e1, e2),
                        e2);
-        SET_ESP(sp, sp_mask);
+        SET_ESP(pp.sp, pp.sp_mask);
         env->eip = offset;
     }
 }
@@ -1866,26 +1903,29 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 /* real and vm86 mode iret */
 void helper_iret_real(CPUX86State *env, int shift)
 {
-    uint32_t sp, new_cs, new_eip, new_eflags, sp_mask;
-    target_ulong ssp;
+    uint32_t new_cs, new_eip, new_eflags;
     int eflags_mask;
+    PushPop pp;
+
+    pp.env = env;
+    pp.ra = GETPC();
+    pp.mmu_index = cpu_mmu_index_kernel(env);
+    pp.sp_mask = 0xffff; /* XXXX: use SS segment size? */
+    pp.sp = env->regs[R_ESP];
+    pp.ss_base = env->segs[R_SS].base;
 
-    sp_mask = 0xffff; /* XXXX: use SS segment size? */
-    sp = env->regs[R_ESP];
-    ssp = env->segs[R_SS].base;
     if (shift == 1) {
         /* 32 bits */
-        POPL_RA(ssp, sp, sp_mask, new_eip, GETPC());
-        POPL_RA(ssp, sp, sp_mask, new_cs, GETPC());
-        new_cs &= 0xffff;
-        POPL_RA(ssp, sp, sp_mask, new_eflags, GETPC());
+        new_eip = popl(&pp);
+        new_cs = popl(&pp) & 0xffff;
+        new_eflags = popl(&pp);
     } else {
         /* 16 bits */
-        POPW_RA(ssp, sp, sp_mask, new_eip, GETPC());
-        POPW_RA(ssp, sp, sp_mask, new_cs, GETPC());
-        POPW_RA(ssp, sp, sp_mask, new_eflags, GETPC());
+        new_eip = popw(&pp);
+        new_cs = popw(&pp);
+        new_eflags = popw(&pp);
     }
-    env->regs[R_ESP] = (env->regs[R_ESP] & ~sp_mask) | (sp & sp_mask);
+    SET_ESP(pp.sp, pp.sp_mask);
     env->segs[R_CS].selector = new_cs;
     env->segs[R_CS].base = (new_cs << 4);
     env->eip = new_eip;
@@ -1938,47 +1978,50 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     uint32_t new_es, new_ds, new_fs, new_gs;
     uint32_t e1, e2, ss_e1, ss_e2;
     int cpl, dpl, rpl, eflags_mask, iopl;
-    target_ulong ssp, sp, new_eip, new_esp, sp_mask;
+    target_ulong new_eip, new_esp;
+    PushPop pp;
+
+    pp.env = env;
+    pp.ra = retaddr;
+    pp.mmu_index = cpu_mmu_index_kernel(env);
 
 #ifdef TARGET_X86_64
     if (shift == 2) {
-        sp_mask = -1;
+        pp.sp_mask = -1;
     } else
 #endif
     {
-        sp_mask = get_sp_mask(env->segs[R_SS].flags);
+        pp.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     }
-    sp = env->regs[R_ESP];
-    ssp = env->segs[R_SS].base;
+    pp.sp = env->regs[R_ESP];
+    pp.ss_base = env->segs[R_SS].base;
     new_eflags = 0; /* avoid warning */
 #ifdef TARGET_X86_64
     if (shift == 2) {
-        POPQ_RA(sp, new_eip, retaddr);
-        POPQ_RA(sp, new_cs, retaddr);
-        new_cs &= 0xffff;
+        new_eip = popq(&pp);
+        new_cs = popq(&pp) & 0xffff;
         if (is_iret) {
-            POPQ_RA(sp, new_eflags, retaddr);
+            new_eflags = popq(&pp);
         }
     } else
 #endif
     {
         if (shift == 1) {
             /* 32 bits */
-            POPL_RA(ssp, sp, sp_mask, new_eip, retaddr);
-            POPL_RA(ssp, sp, sp_mask, new_cs, retaddr);
-            new_cs &= 0xffff;
+            new_eip = popl(&pp);
+            new_cs = popl(&pp) & 0xffff;
             if (is_iret) {
-                POPL_RA(ssp, sp, sp_mask, new_eflags, retaddr);
+                new_eflags = popl(&pp);
                 if (new_eflags & VM_MASK) {
                     goto return_to_vm86;
                 }
             }
         } else {
             /* 16 bits */
-            POPW_RA(ssp, sp, sp_mask, new_eip, retaddr);
-            POPW_RA(ssp, sp, sp_mask, new_cs, retaddr);
+            new_eip = popw(&pp);
+            new_cs = popw(&pp);
             if (is_iret) {
-                POPW_RA(ssp, sp, sp_mask, new_eflags, retaddr);
+                new_eflags = popw(&pp);
             }
         }
     }
@@ -2014,7 +2057,7 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         raise_exception_err_ra(env, EXCP0B_NOSEG, new_cs & 0xfffc, retaddr);
     }
 
-    sp += addend;
+    pp.sp += addend;
     if (rpl == cpl && (!(env->hflags & HF_CS64_MASK) ||
                        ((env->hflags & HF_CS64_MASK) && !is_iret))) {
         /* return to same privilege level */
@@ -2026,21 +2069,19 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         /* return to different privilege level */
 #ifdef TARGET_X86_64
         if (shift == 2) {
-            POPQ_RA(sp, new_esp, retaddr);
-            POPQ_RA(sp, new_ss, retaddr);
-            new_ss &= 0xffff;
+            new_esp = popq(&pp);
+            new_ss = popq(&pp) & 0xffff;
         } else
 #endif
         {
             if (shift == 1) {
                 /* 32 bits */
-                POPL_RA(ssp, sp, sp_mask, new_esp, retaddr);
-                POPL_RA(ssp, sp, sp_mask, new_ss, retaddr);
-                new_ss &= 0xffff;
+                new_esp = popl(&pp);
+                new_ss = popl(&pp) & 0xffff;
             } else {
                 /* 16 bits */
-                POPW_RA(ssp, sp, sp_mask, new_esp, retaddr);
-                POPW_RA(ssp, sp, sp_mask, new_ss, retaddr);
+                new_esp = popw(&pp);
+                new_ss = popw(&pp);
             }
         }
         LOG_PCALL("new ss:esp=%04x:" TARGET_FMT_lx "\n",
@@ -2090,14 +2131,14 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
                        get_seg_base(e1, e2),
                        get_seg_limit(e1, e2),
                        e2);
-        sp = new_esp;
+        pp.sp = new_esp;
 #ifdef TARGET_X86_64
         if (env->hflags & HF_CS64_MASK) {
-            sp_mask = -1;
+            pp.sp_mask = -1;
         } else
 #endif
         {
-            sp_mask = get_sp_mask(ss_e2);
+            pp.sp_mask = get_sp_mask(ss_e2);
         }
 
         /* validate data segments */
@@ -2106,9 +2147,9 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         validate_seg(env, R_FS, rpl);
         validate_seg(env, R_GS, rpl);
 
-        sp += addend;
+        pp.sp += addend;
     }
-    SET_ESP(sp, sp_mask);
+    SET_ESP(pp.sp, pp.sp_mask);
     env->eip = new_eip;
     if (is_iret) {
         /* NOTE: 'cpl' is the _old_ CPL */
@@ -2128,12 +2169,12 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     return;
 
  return_to_vm86:
-    POPL_RA(ssp, sp, sp_mask, new_esp, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_ss, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_es, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_ds, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_fs, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_gs, retaddr);
+    new_esp = popl(&pp);
+    new_ss = popl(&pp);
+    new_es = popl(&pp);
+    new_ds = popl(&pp);
+    new_fs = popl(&pp);
+    new_gs = popl(&pp);
 
     /* modify processor state */
     cpu_load_eflags(env, new_eflags, TF_MASK | AC_MASK | ID_MASK |
-- 
2.34.1


