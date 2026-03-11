Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C251125892
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PNG-0003i7-Ec; Wed, 11 Mar 2026 15:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PN3-0003Li-J6; Wed, 11 Mar 2026 15:37:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PN1-0000Ql-Eb; Wed, 11 Mar 2026 15:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257668; bh=TILD+g/uDzhycfS2pBoj1b6TYap1W7Ll1VVHsgb+D8c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Db7eMmN1xwBTtk/gd7vLT1mggiPGlZLGQuV4rlq3+ehIu8QJtCs83XE8I7KxHpz8Z
 fAY8VFltMMrHpwlp1dVnH9VDAq9s0PTvivRiNCyKKy9ET6VOtYwuSGA3Bu7VT/xoxd
 j0BUG5ZzTHMUnKqpPqyzl81TtP5aeL03HbGimIrBbQZV4lZWrWyEpA3hS2BLhhCbM2
 VMzQf4a1nglXOSoi2/fIYo/wmxYbm2JV+XafwUBbhFN/qGJ1ggpkwpZ8CH5l5TcQNf
 rXoZgbeO2c81EQZG4kUPvsCFZD4OOoYAU5r8w9ITESd/OWMExzimB1Ydd/tFuvv0tA
 p3j5yP2foxvHg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8EE33192106;
 Wed, 11 Mar 2026 22:34:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CE4EE37C46B;
 Wed, 11 Mar 2026 22:35:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 30/53] target/ppc/translate: Fix TCG debug assert
 translating CLRBWIBC
Date: Wed, 11 Mar 2026 22:34:23 +0300
Message-ID: <20260311193449.1096110-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The test case in the ppe42 functional test triggers a TCG debug
assertion, which causes the test to fail in an --enable-debug
build or when the sanitizers are enabled:

#6  0x00007ffff4a3b517 in __assert_fail
    (assertion=0x5555562e7589 "!temp_readonly(ots)", file=0x5555562e5b23 "../../tcg/tcg.c", line=4928, function=0x5555562e8900 <__PRETTY_FUNCTION__.23> "tcg_reg_alloc_mov") at ./assert/assert.c:105
#7  0x0000555555cc2189 in tcg_reg_alloc_mov (s=0x7fff60000b70, op=0x7fff600126f8) at ../../tcg/tcg.c:4928
#8  0x0000555555cc74e0 in tcg_gen_code (s=0x7fff60000b70, tb=0x7fffa802f540, pc_start=4294446080) at ../../tcg/tcg.c:6667
#9  0x0000555555d02abe in setjmp_gen_code
    (env=0x555556cbe610, tb=0x7fffa802f540, pc=4294446080, host_pc=0x7fffeea00c00, max_insns=0x7fffee9f9d74, ti=0x7fffee9f9d90)
    at ../../accel/tcg/translate-all.c:257
#10 0x0000555555d02d75 in tb_gen_code (cpu=0x555556cba590, s=...) at ../../accel/tcg/translate-all.c:325
#11 0x0000555555cf5922 in cpu_exec_loop (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:970
#12 0x0000555555cf5aae in cpu_exec_setjmp (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:1016
#13 0x0000555555cf5b4b in cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/cpu-exec.c:1042
#14 0x0000555555d1e7ab in tcg_cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/tcg-accel-ops.c:82
#15 0x0000555555d1ff97 in rr_cpu_thread_fn (arg=0x555556cba590) at ../../accel/tcg/tcg-accel-ops-rr.c:285
#16 0x00005555561586c9 in qemu_thread_start (args=0x555556ee3c90) at ../../util/qemu-thread-posix.c:393
#17 0x00007ffff4a9caa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
#18 0x00007ffff4b29c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78

This can be reproduced "by hand":

 ./build/clang/qemu-system-ppc -display none -vga none \
    -machine ppe42_machine -serial stdio \
    -device loader,file=$HOME/.cache/qemu/download/03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8 \
    -device loader,addr=0xfff80040,cpu-num=0

(assuming you have the image file from the functional test
in your local cache).

This happens for this input:

IN:
0xfff80c00:  07436004  .byte    0x07, 0x43, 0x60, 0x04

which generates (among other things):

 not_i32 $0x80000,$0x80000

which the TCG optimization pass turns into:

 mov_i32 $0x80000,$0xfff7ffff             dead: 1  pref=0xffff

and where we then assert because we tried to write to a constant.

This happens for the CLRBWIBC instruction which ends up in
do_mask_branch() with rb_is_gpr false and invert true.  In this case
we will generate code that sets mask to a tcg_constant_tl() but then
uses it as the LHS in tcg_gen_not_tl().

Fix the assertion by doing the invert in the translate time C code
for the "mask is constant" case.

Cc: qemu-stable@nongnu.org
Fixes: f7ec91c23906 ("target/ppc: Add IBM PPE42 special instructions")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260212150753.1749448-1-peter.maydell@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit 78c6b6010ce7cfa54874dda514e694640b76f1e4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
index 0a0590344e..1c27facb89 100644
--- a/target/ppc/translate/ppe-impl.c.inc
+++ b/target/ppc/translate/ppe-impl.c.inc
@@ -424,11 +424,15 @@ static bool do_mask_branch(DisasContext *ctx, arg_FCB * a, bool invert,
         shift = tcg_temp_new();
         tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
         tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
+        if (invert) {
+            tcg_gen_not_tl(mask, mask);
+        }
     } else {
-        mask = tcg_constant_tl(PPC_BIT32(a->rb));
-    }
-    if (invert) {
-        tcg_gen_not_tl(mask, mask);
+        target_ulong mask_const = PPC_BIT32(a->rb);
+        if (invert) {
+            mask_const = ~mask_const;
+        }
+        mask = tcg_constant_tl(mask_const);
     }
 
     /* apply mask to ra */
-- 
2.47.3


