Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCA7C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5LS-0006Jt-KQ; Tue, 11 Jun 2024 13:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rrh.henry@gmail.com>)
 id 1sH4Et-00039j-C1
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 12:20:51 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rrh.henry@gmail.com>)
 id 1sH4Er-0000kP-Bj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 12:20:51 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f6176b0420so4311785ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718122847; x=1718727647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYALSgq6uCw4sIrLmod3F1XOC4BmsDQqBTUq1GtgRGs=;
 b=hFYRBfp4xvGmjlugmqyOCQa3hhkoM9CN/INnW01utljOAQeaN2/GC6Kpm86sOU8Fe3
 KPH70L5fIAGgWcN40v1A0aIY+zTF/qvi0rQUvbVLecNafhbBgnPnoiKQ97D4rguwaOlL
 atSWWtJ4qz+Mc4PmgH1azWQYqhnhJX1ADIQ4X4QbLcenVq8zJdf/C496XMvqgI8hsSMA
 t5Guda1/lAPgc3+pbCWJFvv5ut8C37a4/3Z3i/3MwqPBl5pRHH0XWL4Eumkd5XMLWVFC
 HV6oCYLPSgtokR7c2zNlIWQHkoAmHCBlQMs25VDRKB+/0tKh+cYGAmflk9i/HpRe2AvL
 3rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718122847; x=1718727647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYALSgq6uCw4sIrLmod3F1XOC4BmsDQqBTUq1GtgRGs=;
 b=jERATXPoH29b+WyNoXyGWWRlDRVYRiZUIrQkXzBT+4EsPRk9VccQLe7IBBCBSsAdxv
 o9kq2YtjVETCoUici7sH+HRJ8xk7Zcglm+AEZHJ1GpCKaIvwjz9oDGkuLzu/s61SRlUU
 Co9AzwvPet8R2br8W5VxRZ1ji3J7/64W0X6DmZtq9/Oy/m6y1KDbr0un6hXp9ylU7+3X
 mGWGl0tFuotwijMMvtfFtDT7ScVLZdzRN8Cp4z/Fa8CmFhK+y95Fr+O7H+CYIiEOUs3K
 6ZSXxWGdFC+Gsen9ibaYUeRJOdexcrIeYN59yEb2Nt4VeaXLhbzz89Zha+gQWQn8U9zz
 qXgw==
X-Gm-Message-State: AOJu0YygxPZUBYdM/NoWv/f9Uz++EWWbggtXBL1lwP+ab1XaOMAPB+cC
 8xSqXwD00tcD05o8CB1PrF4LfX0l6gob6dru1P4jsPi6l3AmwfT92luoEw==
X-Google-Smtp-Source: AGHT+IFq7QRHJ8pdlDXLwawkSjWwrC6C+U4oodkwAkv/vkruuKbk2mEhDjSlEcjzJta/VE0LyzjUuw==
X-Received: by 2002:a17:902:ea0b:b0:1f2:ffbc:7156 with SMTP id
 d9443c01a7336-1f6d02c1450mr141189765ad.1.1718122847222; 
 Tue, 11 Jun 2024 09:20:47 -0700 (PDT)
Received: from ahadg-ubnt-05.lan ([2605:59c8:7c5:ea10:1363:e947:a6b8:de4a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6facdba8esm59426355ad.238.2024.06.11.09.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:20:46 -0700 (PDT)
From: "Robert R. Henry" <rrh.henry@gmail.com>
X-Google-Original-From: "Robert R. Henry" <robhenry@microsoft.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 "Robert R. Henry" <robhenry@microsoft.com>
Subject: [PATCH 1/1] i386/tcg: Allow IRET from user mode to user mode for
 dotnet runtime
Date: Tue, 11 Jun 2024 09:20:21 -0700
Message-Id: <20240611162021.269457-2-robhenry@microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611162021.269457-1-robhenry@microsoft.com>
References: <20240611162021.269457-1-robhenry@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=rrh.henry@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Jun 2024 13:31:40 -0400
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

This fixes a bug wherein i386/tcg assumed an interrupt return using
the IRET instruction was always returning from kernel mode to either
kernel mode or user mode. This assumption is violated when IRET is used
as a clever way to restore thread state, as for example in the dotnet
runtime. There, IRET returns from user mode to user mode.

This bug manifested itself as a page fault in the guest Linux kernel.

This bug appears to have been in QEMU since the beginning.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/249
Signed-off-by: Robert R. Henry <robhenry@microsoft.com>
---
 target/i386/tcg/seg_helper.c | 78 ++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 715db1f232..815d26e61d 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -843,20 +843,35 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
 #ifdef TARGET_X86_64
 
-#define PUSHQ_RA(sp, val, ra)                   \
-    {                                           \
-        sp -= 8;                                \
-        cpu_stq_kernel_ra(env, sp, (val), ra);  \
-    }
-
-#define POPQ_RA(sp, val, ra)                    \
-    {                                           \
-        val = cpu_ldq_kernel_ra(env, sp, ra);   \
-        sp += 8;                                \
-    }
+#define PUSHQ_RA(sp, val, ra, cpl, dpl) \
+  FUNC_PUSHQ_RA(env, &sp, val, ra, cpl, dpl)
+
+static inline void FUNC_PUSHQ_RA(
+    CPUX86State *env, target_ulong *sp,
+    target_ulong val, target_ulong ra, int cpl, int dpl) {
+  *sp -= 8;
+  if (dpl == 0) {
+    cpu_stq_kernel_ra(env, *sp, val, ra);
+  } else {
+    cpu_stq_data_ra(env, *sp, val, ra);
+  } 
+}
 
-#define PUSHQ(sp, val) PUSHQ_RA(sp, val, 0)
-#define POPQ(sp, val) POPQ_RA(sp, val, 0)
+#define POPQ_RA(sp, val, ra, cpl, dpl) \
+  val = FUNC_POPQ_RA(env, &sp, ra, cpl, dpl)
+
+static inline target_ulong FUNC_POPQ_RA(
+    CPUX86State *env, target_ulong *sp,
+    target_ulong ra, int cpl, int dpl) {
+  target_ulong val;
+  if (cpl == 0) {  /* TODO perhaps both arms reduce to cpu_ldq_data_ra? */
+    val = cpu_ldq_kernel_ra(env, *sp, ra);
+  } else {
+    val = cpu_ldq_data_ra(env, *sp, ra);
+  }
+  *sp += 8;
+  return val;
+}
 
 static inline target_ulong get_rsp_from_tss(CPUX86State *env, int level)
 {
@@ -901,6 +916,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     uint32_t e1, e2, e3, ss, eflags;
     target_ulong old_eip, esp, offset;
     bool set_rf;
+    const target_ulong retaddr = 0;
 
     has_error_code = 0;
     if (!is_int && !is_hw) {
@@ -989,13 +1005,13 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
         eflags |= RF_MASK;
     }
 
-    PUSHQ(esp, env->segs[R_SS].selector);
-    PUSHQ(esp, env->regs[R_ESP]);
-    PUSHQ(esp, eflags);
-    PUSHQ(esp, env->segs[R_CS].selector);
-    PUSHQ(esp, old_eip);
+    PUSHQ_RA(esp, env->segs[R_SS].selector, retaddr, cpl, dpl);
+    PUSHQ_RA(esp, env->regs[R_ESP],         retaddr, cpl, dpl);
+    PUSHQ_RA(esp, eflags,                   retaddr, cpl, dpl);
+    PUSHQ_RA(esp, env->segs[R_CS].selector, retaddr, cpl, dpl);
+    PUSHQ_RA(esp, old_eip,                  retaddr, cpl, dpl);
     if (has_error_code) {
-        PUSHQ(esp, error_code);
+        PUSHQ_RA(esp, error_code, retaddr, cpl, dpl);
     }
 
     /* interrupt gate clear IF mask */
@@ -1621,8 +1637,8 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 
             /* 64 bit case */
             rsp = env->regs[R_ESP];
-            PUSHQ_RA(rsp, env->segs[R_CS].selector, GETPC());
-            PUSHQ_RA(rsp, next_eip, GETPC());
+            PUSHQ_RA(rsp, env->segs[R_CS].selector, GETPC(), cpl, dpl);
+            PUSHQ_RA(rsp, next_eip, GETPC(), cpl, dpl);
             /* from this point, not restartable */
             env->regs[R_ESP] = rsp;
             cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
@@ -1792,8 +1808,8 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 #ifdef TARGET_X86_64
             if (shift == 2) {
                 /* XXX: verify if new stack address is canonical */
-                PUSHQ_RA(sp, env->segs[R_SS].selector, GETPC());
-                PUSHQ_RA(sp, env->regs[R_ESP], GETPC());
+                PUSHQ_RA(sp, env->segs[R_SS].selector, GETPC(), cpl, dpl);
+                PUSHQ_RA(sp, env->regs[R_ESP], GETPC(), cpl, dpl);
                 /* parameters aren't supported for 64-bit call gates */
             } else
 #endif
@@ -1828,8 +1844,8 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 
 #ifdef TARGET_X86_64
         if (shift == 2) {
-            PUSHQ_RA(sp, env->segs[R_CS].selector, GETPC());
-            PUSHQ_RA(sp, next_eip, GETPC());
+            PUSHQ_RA(sp, env->segs[R_CS].selector, GETPC(), cpl, dpl);
+            PUSHQ_RA(sp, next_eip, GETPC(), cpl, dpl);
         } else
 #endif
         if (shift == 1) {
@@ -1944,6 +1960,7 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     int cpl, dpl, rpl, eflags_mask, iopl;
     target_ulong ssp, sp, new_eip, new_esp, sp_mask;
 
+    cpl = env->hflags & HF_CPL_MASK;
 #ifdef TARGET_X86_64
     if (shift == 2) {
         sp_mask = -1;
@@ -1957,11 +1974,11 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     new_eflags = 0; /* avoid warning */
 #ifdef TARGET_X86_64
     if (shift == 2) {
-        POPQ_RA(sp, new_eip, retaddr);
-        POPQ_RA(sp, new_cs, retaddr);
+        POPQ_RA(sp, new_eip, retaddr, cpl, dpl);
+        POPQ_RA(sp, new_cs, retaddr, cpl, dpl);
         new_cs &= 0xffff;
         if (is_iret) {
-            POPQ_RA(sp, new_eflags, retaddr);
+            POPQ_RA(sp, new_eflags, retaddr, cpl, dpl);
         }
     } else
 #endif
@@ -1999,7 +2016,6 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         !(e2 & DESC_CS_MASK)) {
         raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, retaddr);
     }
-    cpl = env->hflags & HF_CPL_MASK;
     rpl = new_cs & 3;
     if (rpl < cpl) {
         raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, retaddr);
@@ -2030,8 +2046,8 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         /* return to different privilege level */
 #ifdef TARGET_X86_64
         if (shift == 2) {
-            POPQ_RA(sp, new_esp, retaddr);
-            POPQ_RA(sp, new_ss, retaddr);
+            POPQ_RA(sp, new_esp, retaddr, cpl, dpl);
+            POPQ_RA(sp, new_ss, retaddr, cpl, dpl);
             new_ss &= 0xffff;
         } else
 #endif
-- 
2.34.1


