Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C2FCD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGw-0004xD-Oh; Tue, 12 May 2026 17:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuF2-0000JD-DZ; Tue, 12 May 2026 17:02:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEy-0007Da-LU; Tue, 12 May 2026 17:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=wjKFdBI2hTktfmkYGQ1QHrVajNpvah9EuFHX1c2i0+s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w+tb3EyPW5e6o6HamfPEy31xzzf1GfGUxd+02mfFJk3KgDB3kklj+4xPnnnIxB/nY
 eGWdPNrkC15Y4s4SqZJc8O4Xlo42DIf8YQNVR30naV1UCxXb06tWkXHPMw9g5rlj1P
 Z9nlaehOZHHeVExD5W061Ou1MooB+J3wUhFjgOScQOGjBTx1tpyzgAG0bTolu1CnL/
 WBpdKhYan1k4wg1OC3inWzx7U7BlM4wxhWF8kPtgmpAFOBSamRpwNjZQvRkGPaSREE
 8ef+spgqfcjfyyvdLaPKxx+Ff9oDceIFdeOf2xqa9Mn2yKz8aT20zCtVKGKi7miJNx
 4xpNpOBUPfjxw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5BE7C1AA317;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 672363ABC88;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 075/107] linux-user/mips: sync k0 TLS for
 EF_MIPS_MACH_OCTEON userlands
Date: Tue, 12 May 2026 23:54:02 +0300
Message-ID: <20260512205437.360850-75-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: James Hilliard <james.hilliard1@gmail.com>

Cavium Octeon userspace is not following a generic MIPS Linux TLS
ABI rule here. Older Octeon glibc uses the k0 register as the fast
thread pointer, while newer Octeon2 and Octeon3 glibc variants use
the normal rdhwr $29 path.

linux-user already updates CP0_UserLocal for cpu_set_tls() and
TARGET_NR_set_thread_area, but it does not keep gpr[26]
synchronized. That leaves EF_MIPS_MACH_OCTEON userlands able to
complete set_thread_area() and still reach pthread startup or
pthread_self() with a stale k0 value.

Use the existing MIPS ELF machine flags from linux-user/elfload.c and
mirror CP0_UserLocal into gpr[26] only for EF_MIPS_MACH_OCTEON.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 4c681ba3b82d9a9f00a3f361399a1bb7612f3535)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0f05db4715..a791396ead 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3405,6 +3405,9 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     /* Usual start for brk is after all sections of the main executable. */
     info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
     info->elf_flags = ehdr->e_flags;
+#ifdef TARGET_MIPS
+    info->use_k0_tls = (ehdr->e_flags & EF_MIPS_MACH) == EF_MIPS_MACH_OCTEON;
+#endif
 
     prot_exec = PROT_EXEC;
 #ifdef TARGET_AARCH64
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index c375616c55..2bbd0a81c5 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -35,7 +35,12 @@ static inline void cpu_clone_regs_parent(CPUMIPSState *env, unsigned flags)
 
 static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
 {
+    TaskState *ts = get_task_state(env_cpu(env));
+
     env->active_tc.CP0_UserLocal = newtls;
+    if (ts->info->use_k0_tls) {
+        env->active_tc.gpr[26] = newtls;
+    }
 }
 
 static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5f00750151..f2b16ef54b 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -64,6 +64,7 @@ struct image_info {
         uint32_t        note_flags;
 
 #ifdef TARGET_MIPS
+        bool            use_k0_tls;
         int             fp_abi;
         int             interp_fp_abi;
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f2c8037356..ea1711ff95 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12972,7 +12972,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_set_thread_area
     case TARGET_NR_set_thread_area:
 #if defined(TARGET_MIPS)
-      cpu_env->active_tc.CP0_UserLocal = arg1;
+      cpu_set_tls(cpu_env, arg1);
       return 0;
 #elif defined(TARGET_I386) && defined(TARGET_ABI32)
       return do_set_thread_area(cpu_env, arg1);
-- 
2.47.3


