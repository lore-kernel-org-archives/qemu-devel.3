Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47CBD5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kMx-0002gM-ED; Sat, 09 Nov 2024 07:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kMn-0002DQ-6y; Sat, 09 Nov 2024 07:15:01 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kMk-0004m0-Tf; Sat, 09 Nov 2024 07:15:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C7CF7A162B;
 Sat,  9 Nov 2024 15:08:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8CFDD167FB3;
 Sat,  9 Nov 2024 15:09:01 +0300 (MSK)
Received: (nullmailer pid 3296135 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Robert R . Henry" <rrh.henry@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 03/58] target/i386/tcg: Use DPL-level accesses for
 interrupts and call gates
Date: Sat,  9 Nov 2024 15:08:04 +0300
Message-Id: <20241109120901.3295995-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Stack accesses should be explicit and use the privilege level of the
target stack.  This ensures that SMAP is not applied when the target
stack is in ring 3.

This fixes a bug wherein i386/tcg assumed that an interrupt return, or a
far call using the CALL or JMP instruction, was always going from kernel
or user mode to kernel mode when using a call gate. This assumption is
violated if the call gate has a DPL that is greater than 0.

Analyzed-by: Robert R. Henry <rrh.henry@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/249
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e136648c5c95ee4ea233cccf999c07e065bef26d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 3b8fd827e1..02ae6a0d1f 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -695,7 +695,6 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
 
     if (type == 5) {
         /* task gate */
@@ -705,7 +704,9 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         }
         shift = switch_tss(env, intno * 8, e1, e2, SWITCH_TSS_CALL, old_eip);
         if (has_error_code) {
-            /* push the error code */
+            /* push the error code on the destination stack */
+            cpl = env->hflags & HF_CPL_MASK;
+            sa.mmu_index = x86_mmu_index_pl(env, cpl);
             if (env->segs[R_SS].flags & DESC_B_MASK) {
                 sa.sp_mask = 0xffffffff;
             } else {
@@ -750,6 +751,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     if (e2 & DESC_C_MASK) {
         dpl = cpl;
     }
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
     if (dpl < cpl) {
         /* to inner privilege */
         uint32_t esp;
@@ -1001,7 +1003,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
     sa.sp_mask = -1;
     sa.ss_base = 0;
     if (dpl < cpl || ist != 0) {
@@ -1135,7 +1137,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = 0xffff;
     sa.ss_base = env->segs[R_SS].base;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
 
     if (is_int) {
         old_eip = next_eip;
@@ -1599,7 +1601,7 @@ void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.ss_base = env->segs[R_SS].base;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
 
     if (shift) {
         pushl(&sa, env->segs[R_CS].selector);
@@ -1639,9 +1641,9 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 
     sa.env = env;
     sa.ra = GETPC();
-    sa.mmu_index = cpu_mmu_index_kernel(env);
 
     if (e2 & DESC_S_MASK) {
+        /* "normal" far call, no stack switch possible */
         if (!(e2 & DESC_CS_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
         }
@@ -1665,6 +1667,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             raise_exception_err_ra(env, EXCP0B_NOSEG, new_cs & 0xfffc, GETPC());
         }
 
+        sa.mmu_index = x86_mmu_index_pl(env, cpl);
 #ifdef TARGET_X86_64
         /* XXX: check 16/32 bit cases in long mode */
         if (shift == 2) {
@@ -1792,6 +1795,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 
         if (!(e2 & DESC_C_MASK) && dpl < cpl) {
             /* to inner privilege */
+            sa.mmu_index = x86_mmu_index_pl(env, dpl);
 #ifdef TARGET_X86_64
             if (shift == 2) {
                 ss = dpl;  /* SS = NULL selector with RPL = new CPL */
@@ -1870,6 +1874,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             new_stack = 1;
         } else {
             /* to same privilege */
+            sa.mmu_index = x86_mmu_index_pl(env, cpl);
             sa.sp = env->regs[R_ESP];
             sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
             sa.ss_base = env->segs[R_SS].base;
-- 
2.39.5


