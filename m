Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4CEFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGfIs-0008Lk-Ex; Sat, 25 Apr 2026 11:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIX-00081E-To
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:52:04 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIW-00014i-8s
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:52:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A3F5600AE;
 Sat, 25 Apr 2026 15:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3326C2BCB0;
 Sat, 25 Apr 2026 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777132319;
 bh=ZCgbefl3znT//LnX5C+F02YXGLn7Vtw2haVvLrZdTz0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mRw2oF8uSH0zjRPXG4XK9EQXZHrPQSjX7RTnD1M3w5fwPKAMhEOpzIip/KZwOLgX4
 4+8vV/sFJruvkp8JTUTBIgtmWY6q6E/QgSHkPBzJDYuH9w2kvMHiYK5bA9knmyTp+w
 LTdxO3FYmb4rDPiyUZSp8qx9B12GgohGXr0RKwAHAPug64Zt54DjQ7/R/atvpBsjO8
 Y096AHkKWlnSVscZPI+TlkBfyqrNyQXIBq+xIqW3e0JeciufYOEn3CGU3MQAnUO8zO
 KS4gX64pDiB3zfBdGCG07Bm5oybkfQlpLqx8nUJZgs54Ow5axUpaW5X6MgcKP4s1Se
 LigpZSBxZp33A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/14] linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON
 userlands
Date: Sat, 25 Apr 2026 17:51:34 +0200
Message-ID: <20260425155140.50186-9-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425155140.50186-1-deller@kernel.org>
References: <20260425155140.50186-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/elfload.c         | 3 +++
 linux-user/mips/target_cpu.h | 5 +++++
 linux-user/qemu.h            | 1 +
 linux-user/syscall.c         | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 59b543f740..0e757787d2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1476,6 +1476,9 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
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
index cfe5f45fc4..7f98fb2607 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -65,6 +65,7 @@ struct image_info {
         uint32_t        note_flags;
 
 #ifdef TARGET_MIPS
+        bool            use_k0_tls;
         int             fp_abi;
         int             interp_fp_abi;
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4b74ad350..8e96cc26db 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13216,7 +13216,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_set_thread_area
     case TARGET_NR_set_thread_area:
 #if defined(TARGET_MIPS)
-      cpu_env->active_tc.CP0_UserLocal = arg1;
+      cpu_set_tls(cpu_env, arg1);
       return 0;
 #elif defined(TARGET_I386) && defined(TARGET_ABI32)
       return do_set_thread_area(cpu_env, arg1);
-- 
2.53.0


