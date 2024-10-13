Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1AECF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pP-00076v-O2; Sun, 13 Oct 2024 18:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pO-00075y-7Z
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:42 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pM-0000tU-KT
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:41 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so1716369a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857559; x=1729462359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8UtO3iFeY9lIilr4u+dWsz4U2zyzDHMfO1R07G1hdY=;
 b=jRs7SHdqvx1EQKj0LQpWGCKvLcEyGNNTShyaLCjpyHi50E/OYZjTKxZucs302MTIux
 8lPvYFhwo97usz6m3n56DgdW7swXWqYoar7s8ZhlpG2j/RjneFNablGy7CgIAoUewZsS
 S5jQV1V9FHZwsUE5GaXIfrc9lKWUNSTYHmxSN6Go71YDKrl3du7oPQeS1IwkiNIBYMOF
 RuLv0NVQTYahtt2BbIA1Tjfd/8VV2Su6yEqcNaRTv/l70dnYQHZVXwFU8W556YPHYe7I
 qYt/0TLpS7M11JY6Fov66kjjvzOYZf90wJEKqaWu/4Q0J1dA8B35gR8fPVmoaRjApb9/
 a81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857559; x=1729462359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8UtO3iFeY9lIilr4u+dWsz4U2zyzDHMfO1R07G1hdY=;
 b=D/OjQYlqwTjNIc1AyGHaKuihXzOBDjLNBviEZvvpcmPEtTG8XWanUTKil07D+EDUZp
 k7znVXiqGCgeubw706u/Vngg4DB5ZaBj34sTvBK4lwqvvRIbdqkutKOfbzFFDTGlxt+o
 +rYzmW0cZPcHR1HP3wIouvhQLabOgrihK02u6Ynv/0BrnnYLDHCOMGnZ4UltT/SNQmdy
 t3oxZBoo43aj5fr57nqFcij0LQUe6kKSdViSluXHw9zTBqfWBPYmZ+4oRunFwhuWwsYq
 LoPHdIkjoDTb/Emz9zMeSamfyNtLkhoi/aINxtNs8u2AIk/2Ie3THPzOHjSzTkW1xy7T
 OKXQ==
X-Gm-Message-State: AOJu0YzpUBhxVM3GeNOwBstR7TVfQfVptbtcFbL5DQwOs88UFaqK8MV8
 PkXZjwYHRPp50iIJ9PorUvKolcxbH3XngDtm6VmQLrpaGt94HrL9xbvxBZJh8jVgR5wlKKHhWvx
 T
X-Google-Smtp-Source: AGHT+IGwAmG/FeJEzj828OJZ49kZ2mPr27NKZkudX36VAC1y4TS3nbdbRZ8jGUnUvzUQzmoVLmBSLA==
X-Received: by 2002:a17:90a:7402:b0:2e2:b513:d534 with SMTP id
 98e67ed59e1d1-2e31536f287mr8547619a91.37.1728857559254; 
 Sun, 13 Oct 2024 15:12:39 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 03/27] linux-user/i386: Emulate orig_ax
Date: Sun, 13 Oct 2024 15:12:11 -0700
Message-ID: <20241013221235.1585193-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The kernel uses orig_rax/orig_eax to store the syscall number before
a syscall. One can see this value in core dumps and ptrace.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240912093012.402366-3-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h          | 4 ++++
 linux-user/elfload.c       | 4 ++--
 linux-user/i386/cpu_loop.c | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 98ad848ab2..895bdd722a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -113,6 +113,10 @@ struct TaskState {
     struct target_vm86plus_struct vm86plus;
     uint32_t v86flags;
     uint32_t v86mask;
+#endif
+#if defined(TARGET_I386)
+    /* Last syscall number. */
+    target_ulong orig_ax;
 #endif
     abi_ulong child_tidptr;
 #ifdef TARGET_M68K
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 352960b771..6cef8db3b5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -203,7 +203,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
     (*regs)[12] = tswapreg(env->regs[R_EDX]);
     (*regs)[13] = tswapreg(env->regs[R_ESI]);
     (*regs)[14] = tswapreg(env->regs[R_EDI]);
-    (*regs)[15] = tswapreg(env->regs[R_EAX]); /* XXX */
+    (*regs)[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
     (*regs)[16] = tswapreg(env->eip);
     (*regs)[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
     (*regs)[18] = tswapreg(env->eflags);
@@ -306,7 +306,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
     (*regs)[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
     (*regs)[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
     (*regs)[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[11] = tswapreg(env->regs[R_EAX]); /* XXX */
+    (*regs)[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
     (*regs)[12] = tswapreg(env->eip);
     (*regs)[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
     (*regs)[14] = tswapreg(env->eflags);
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 92beb6830c..7a35215278 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -172,6 +172,7 @@ static void emulate_vsyscall(CPUX86State *env)
     /*
      * Perform the syscall.  None of the vsyscalls should need restarting.
      */
+    get_task_state(env_cpu(env))->orig_ax = syscall;
     ret = do_syscall(env, syscall, env->regs[R_EDI], env->regs[R_ESI],
                      env->regs[R_EDX], env->regs[10], env->regs[8],
                      env->regs[9], 0, 0);
@@ -221,6 +222,7 @@ void cpu_loop(CPUX86State *env)
         case EXCP_SYSCALL:
 #endif
             /* linux syscall from int $0x80 */
+            get_task_state(cs)->orig_ax = env->regs[R_EAX];
             ret = do_syscall(env,
                              env->regs[R_EAX],
                              env->regs[R_EBX],
@@ -239,6 +241,7 @@ void cpu_loop(CPUX86State *env)
 #ifdef TARGET_X86_64
         case EXCP_SYSCALL:
             /* linux syscall from syscall instruction.  */
+            get_task_state(cs)->orig_ax = env->regs[R_EAX];
             ret = do_syscall(env,
                              env->regs[R_EAX],
                              env->regs[R_EDI],
-- 
2.43.0


