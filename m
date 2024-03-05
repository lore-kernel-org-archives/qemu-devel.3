Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C240DC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTdn-0002qy-57; Tue, 05 Mar 2024 07:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTct-0001ca-3M
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcd-0001QT-Di
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:30 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412e783c94fso12230595e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640612; x=1710245412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQce98qJEyJHk/DsO8BnMbADDzmjEz9JOc/CPq8YOck=;
 b=gJ4iwIgjmd2O5FnlzSRNaM8XdQGotZO5eilFYHfoJgE5fsw2E5cIDSHauA0BV4By1L
 5PRB+JCIOoKisnKclA9tBH2GzgvbKsfwA1QiaXv2IVgUQorWte3rz5FPBz0yNhPP9K7q
 5oNqrqpco2q8o2yBqwgiQn+4/4qO+LVn6RT5huD7oICOgdcpLp03RoA7l5oAb/GtGDkA
 i+rxQA92VX2K9cn4bSocQLmXbsewJVenmxbC9JMEsV46VGQAGFAKc09h0MyNaoJTqtrO
 IRg2Cl14FoVH/wETz/LgwVPypn5BYxf+ufOEyub/R4XUhIUo9I7yPCTTfBLs46rp31uz
 O/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640612; x=1710245412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQce98qJEyJHk/DsO8BnMbADDzmjEz9JOc/CPq8YOck=;
 b=wF/Ek71eRucsM5b+qPRSlmqR/f4RtAyqj07xRajJ5KYlrPXsxIR1rLi21QWj93G7Oh
 yfmt2bBca9CDenqHQ03jlk2OTHAYdQwypxj42PTwXIYIyNle2IMzxTui7j15xhKtPwFf
 Pn/iYYGVYDLm/AH/pisz5txWotBxrHknzqKHZHdrSp3rjIGt2ROftEOUMIQRiUX4+6Z/
 wyp0oC27WdCNcYv0zbdm4erR5hOApmyL0BX3hb/dAac+UF1MwW9+Ld2/6OuOdfPiZlI2
 GwH9+KfugTYO7YO45iw+3wPkB825TSW3T0i7NmTOVHcz9rtJGm/nYBjynkO06a2ViyVP
 QKcg==
X-Gm-Message-State: AOJu0YwRmBCEE8Vm/33sDQ6QOFYDKiAzqhBn9vbe61kNw4+quruJ7Peg
 NnlIRTDQJZ6ieh+jy/5pQNlqMX/LNnU9ziAau6Zg3LRcaYkdnYSt6xrEzGzvS2c=
X-Google-Smtp-Source: AGHT+IHupt0qcpOJj0SIQLFcIyMz8Hyj8VllcouPhlZKUwvjs09k/K4XCmZlScyHdHo+GEsuLbhsNQ==
X-Received: by 2002:a05:600c:198c:b0:412:c7d9:bd96 with SMTP id
 t12-20020a05600c198c00b00412c7d9bd96mr9590907wmq.8.1709640612224; 
 Tue, 05 Mar 2024 04:10:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k4-20020a05600c1c8400b00412e556d4besm5248221wms.48.2024.03.05.04.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C68645F950;
 Tue,  5 Mar 2024 12:10:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 03/29] {linux,bsd}-user: Introduce get_task_state()
Date: Tue,  5 Mar 2024 12:09:39 +0000
Message-Id: <20240305121005.3528075-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

A CPU's TaskState is stored in the CPUState's void *opaque field,
accessing which is somewhat awkward due to having to use a cast.
Introduce a wrapper and use it everywhere.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240219141628.246823-3-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 bsd-user/bsd-file.h           |  2 +-
 bsd-user/qemu.h               |  5 +++++
 include/user/safe-syscall.h   |  2 +-
 linux-user/m68k/target_cpu.h  |  2 +-
 linux-user/qemu.h             |  5 +++++
 linux-user/signal-common.h    |  2 +-
 bsd-user/signal.c             | 20 ++++++++++----------
 gdbstub/user-target.c         |  4 ++--
 linux-user/aarch64/cpu_loop.c |  2 +-
 linux-user/arm/cpu_loop.c     |  4 ++--
 linux-user/arm/signal.c       |  2 +-
 linux-user/cris/cpu_loop.c    |  2 +-
 linux-user/elfload.c          |  2 +-
 linux-user/hppa/signal.c      |  2 +-
 linux-user/linuxload.c        |  2 +-
 linux-user/m68k/cpu_loop.c    |  2 +-
 linux-user/mips/cpu_loop.c    |  2 +-
 linux-user/ppc/signal.c       |  4 ++--
 linux-user/riscv/cpu_loop.c   |  2 +-
 linux-user/signal.c           | 30 +++++++++++++++---------------
 linux-user/syscall.c          | 26 +++++++++++++-------------
 linux-user/vm86.c             | 18 +++++++++---------
 linux-user/xtensa/signal.c    |  2 +-
 plugins/api.c                 |  8 ++++----
 semihosting/arm-compat-semi.c |  8 ++++----
 25 files changed, 85 insertions(+), 75 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index 3c00dc00567..6fa2c30b4de 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -641,7 +641,7 @@ static abi_long do_bsd_readlink(CPUArchState *env, abi_long arg1,
     }
     if (strcmp(p1, "/proc/curproc/file") == 0) {
         CPUState *cpu = env_cpu(env);
-        TaskState *ts = (TaskState *)cpu->opaque;
+        TaskState *ts = get_task_state(cpu);
         strncpy(p2, ts->bprm->fullpath, arg3);
         ret = MIN((abi_long)strlen(ts->bprm->fullpath), arg3);
     } else {
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index c05c5127676..4adb75d19ff 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -117,6 +117,11 @@ typedef struct TaskState {
     struct target_sigaltstack sigaltstack_used;
 } __attribute__((aligned(16))) TaskState;
 
+static inline TaskState *get_task_state(CPUState *cs)
+{
+    return cs->opaque;
+}
+
 void stop_all_tasks(void);
 extern const char *interp_prefix;
 extern const char *qemu_uname_release;
diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h
index 27b71cdbd8e..aa075f4d5cd 100644
--- a/include/user/safe-syscall.h
+++ b/include/user/safe-syscall.h
@@ -134,7 +134,7 @@ extern char safe_syscall_start[];
 extern char safe_syscall_end[];
 
 #define safe_syscall(...)                                                 \
-    safe_syscall_base(&((TaskState *)thread_cpu->opaque)->signal_pending, \
+    safe_syscall_base(&get_task_state(thread_cpu)->signal_pending,        \
                       __VA_ARGS__)
 
 #endif
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index c3f288dfe83..4b40c09a8d6 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -37,7 +37,7 @@ static inline void cpu_clone_regs_parent(CPUM68KState *env, unsigned flags)
 static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
 
     ts->tp_value = newtls;
 }
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4de9ec783f6..32cd43d9eff 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -162,6 +162,11 @@ typedef struct TaskState {
     uint64_t start_boottime;
 } TaskState;
 
+static inline TaskState *get_task_state(CPUState *cs)
+{
+    return cs->opaque;
+}
+
 abi_long do_brk(abi_ulong new_brk);
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
                     int flags, mode_t mode, bool safe);
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 3e2dc604c2f..a7df12fc445 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -113,7 +113,7 @@ int process_sigsuspend_mask(sigset_t **pset, target_ulong sigset,
 static inline void finish_sigsuspend_mask(int ret)
 {
     if (ret != -QEMU_ERESTARTSYS) {
-        TaskState *ts = (TaskState *)thread_cpu->opaque;
+        TaskState *ts = get_task_state(thread_cpu);
         ts->in_sigsuspend = 1;
     }
 }
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index f4352e4530f..e9f80a06d32 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -319,7 +319,7 @@ void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t *info)
 
 int block_signals(void)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     sigset_t set;
 
     /*
@@ -359,7 +359,7 @@ void dump_core_and_abort(int target_sig)
 {
     CPUState *cpu = thread_cpu;
     CPUArchState *env = cpu_env(cpu);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     int core_dumped = 0;
     int host_sig;
     struct sigaction act;
@@ -421,7 +421,7 @@ void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
 
     trace_user_queue_signal(env, sig);
 
@@ -476,7 +476,7 @@ void force_sig_fault(int sig, int code, abi_ulong addr)
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUState *cpu = thread_cpu;
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     target_siginfo_t tinfo;
     ucontext_t *uc = puc;
     struct emulated_sigtable *k;
@@ -585,7 +585,7 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 /* compare to kern/kern_sig.c sys_sigaltstack() and kern_sigaltstack() */
 abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     int ret;
     target_stack_t oss;
 
@@ -714,7 +714,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 static inline abi_ulong get_sigframe(struct target_sigaction *ka,
         CPUArchState *env, size_t frame_size)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     abi_ulong sp;
 
     /* Use default user stack */
@@ -789,7 +789,7 @@ static int reset_signal_mask(target_ucontext_t *ucontext)
     int i;
     sigset_t blocked;
     target_sigset_t target_set;
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
 
     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __get_user(target_set.__bits[i], &ucontext->uc_sigmask.__bits[i]);
@@ -839,7 +839,7 @@ badframe:
 
 void signal_init(void)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     struct sigaction act;
     struct sigaction oact;
     int i;
@@ -878,7 +878,7 @@ static void handle_pending_signal(CPUArchState *env, int sig,
                                   struct emulated_sigtable *k)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     struct target_sigaction *sa;
     int code;
     sigset_t set;
@@ -967,7 +967,7 @@ void process_pending_signals(CPUArchState *env)
     int sig;
     sigset_t *blocked_set, set;
     struct emulated_sigtable *k;
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
 
     while (qatomic_read(&ts->signal_pending)) {
         sigfillset(&set);
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index b7d4c37cd81..6646684a4c6 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -204,7 +204,7 @@ int gdb_target_signal_to_gdb(int sig)
 
 int gdb_get_cpu_index(CPUState *cpu)
 {
-    TaskState *ts = (TaskState *) cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     return ts ? ts->ts_tid : -1;
 }
 
@@ -399,7 +399,7 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
         return;
     }
 
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     if (!ts || !ts->bprm || !ts->bprm->filename) {
         gdb_put_packet("E00");
         return;
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 8c20dc8a39a..71cdc8be50c 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -189,7 +189,7 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
     struct image_info *info = ts->info;
     int i;
 
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index b404117ff30..db1a41e27f4 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -263,7 +263,7 @@ static bool insn_is_linux_bkpt(uint32_t opcode, bool is_thumb)
 
 static bool emulate_arm_fpa11(CPUARMState *env, uint32_t opcode)
 {
-    TaskState *ts = env_cpu(env)->opaque;
+    TaskState *ts = get_task_state(env_cpu(env));
     int rc = EmulateAll(opcode, &ts->fpa, env);
     int raise, enabled;
 
@@ -514,7 +514,7 @@ void cpu_loop(CPUARMState *env)
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     struct image_info *info = ts->info;
     int i;
 
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index f77f692c63f..59806335f5b 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -177,7 +177,7 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
     abi_ulong handler = 0;
     abi_ulong handler_fdpic_GOT = 0;
     abi_ulong retcode;
-    bool is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
+    bool is_fdpic = info_is_fdpic(get_task_state(thread_cpu)->info);
     bool is_rt = ka->sa_flags & TARGET_SA_SIGINFO;
     bool thumb;
 
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index 01e6ff16fc9..04c9086b6dc 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -72,7 +72,7 @@ void cpu_loop(CPUCRISState *env)
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     struct image_info *info = ts->info;
 
     env->regs[0] = regs->r0;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0c299a7c15e..4dbca056461 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4404,7 +4404,7 @@ static int wmr_write_region(void *opaque, target_ulong start,
 static int elf_core_dump(int signr, const CPUArchState *env)
 {
     const CPUState *cpu = env_cpu((CPUArchState *)env);
-    const TaskState *ts = (const TaskState *)cpu->opaque;
+    const TaskState *ts = (const TaskState *)get_task_state((CPUState *)cpu);
     struct rlimit dumpsize;
     CountAndSizeRegions css;
     off_t offset, note_offset, data_offset;
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index d08a97dae61..c84557e906a 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -112,7 +112,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr, sp, haddr;
     struct target_rt_sigframe *frame;
     int i;
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
 
     sp = get_sp_from_cpustate(env);
     if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 4a794f8cea1..37f132be4af 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -89,7 +89,7 @@ static int prepare_binprm(struct linux_binprm *bprm)
 abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
                               abi_ulong stringp, int push_ptr)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     int n = sizeof(abi_ulong);
     abi_ulong envp;
     abi_ulong argv;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index caead1cb741..f79b8e4ab05 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -95,7 +95,7 @@ void cpu_loop(CPUM68KState *env)
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     struct image_info *info = ts->info;
 
     env->pc = regs->pc;
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 990b03e727b..462387a0737 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -214,7 +214,7 @@ done_syscall:
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     struct image_info *info = ts->info;
     int i;
 
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 7e7302823b0..c232424c1e8 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -486,7 +486,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i, err = 0;
 #if defined(TARGET_PPC64)
     struct target_sigcontext *sc = 0;
-    struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
+    struct image_info *image = get_task_state(thread_cpu)->info;
 #endif
 
     rt_sf_addr = get_sigframe(ka, env, sizeof(*rt_sf));
@@ -673,7 +673,7 @@ abi_long do_swapcontext(CPUArchState *env, abi_ulong uold_ctx,
     }
 
     if (uold_ctx) {
-        TaskState *ts = (TaskState *)thread_cpu->opaque;
+        TaskState *ts = get_task_state(thread_cpu);
 
         if (!lock_user_struct(VERIFY_WRITE, uctx, uold_ctx, 1)) {
             return -TARGET_EFAULT;
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index bffca7db127..52c49c2e426 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -97,7 +97,7 @@ void cpu_loop(CPURISCVState *env)
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     struct image_info *info = ts->info;
 
     env->pc = regs->sepc;
diff --git a/linux-user/signal.c b/linux-user/signal.c
index d3e62ab030f..cc7dd78e41f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -172,7 +172,7 @@ void target_to_host_old_sigset(sigset_t *sigset,
 
 int block_signals(void)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     sigset_t set;
 
     /* It's OK to block everything including SIGSEGV, because we won't
@@ -194,7 +194,7 @@ int block_signals(void)
  */
 int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
 
     if (oldset) {
         *oldset = ts->signal_mask;
@@ -237,7 +237,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
  */
 void set_sigmask(const sigset_t *set)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
 
     ts->signal_mask = *set;
 }
@@ -246,7 +246,7 @@ void set_sigmask(const sigset_t *set)
 
 int on_sig_stack(unsigned long sp)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
 
     return (sp - ts->sigaltstack_used.ss_sp
             < ts->sigaltstack_used.ss_size);
@@ -254,7 +254,7 @@ int on_sig_stack(unsigned long sp)
 
 int sas_ss_flags(unsigned long sp)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
 
     return (ts->sigaltstack_used.ss_size == 0 ? SS_DISABLE
             : on_sig_stack(sp) ? SS_ONSTACK : 0);
@@ -265,7 +265,7 @@ abi_ulong target_sigsp(abi_ulong sp, struct target_sigaction *ka)
     /*
      * This is the X/Open sanctioned signal stack switching.
      */
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
 
     if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
         return ts->sigaltstack_used.ss_sp + ts->sigaltstack_used.ss_size;
@@ -275,7 +275,7 @@ abi_ulong target_sigsp(abi_ulong sp, struct target_sigaction *ka)
 
 void target_save_altstack(target_stack_t *uss, CPUArchState *env)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
 
     __put_user(ts->sigaltstack_used.ss_sp, &uss->ss_sp);
     __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &uss->ss_flags);
@@ -284,7 +284,7 @@ void target_save_altstack(target_stack_t *uss, CPUArchState *env)
 
 abi_long target_restore_altstack(target_stack_t *uss, CPUArchState *env)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     size_t minstacksize = TARGET_MINSIGSTKSZ;
     target_stack_t ss;
 
@@ -571,7 +571,7 @@ static void signal_table_init(void)
 
 void signal_init(void)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     struct sigaction act, oact;
 
     /* initialize signal conversion tables */
@@ -730,7 +730,7 @@ static G_NORETURN
 void dump_core_and_abort(CPUArchState *env, int target_sig)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = (TaskState *)cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     int host_sig, core_dumped = 0;
 
     /* On exit, undo the remapping of SIGABRT. */
@@ -769,7 +769,7 @@ void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info)
 {
     CPUState *cpu = env_cpu(env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
 
     trace_user_queue_signal(env, sig);
 
@@ -954,7 +954,7 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUState *cpu = thread_cpu;
     CPUArchState *env = cpu_env(cpu);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     target_siginfo_t tinfo;
     host_sigcontext *uc = puc;
     struct emulated_sigtable *k;
@@ -1174,7 +1174,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     sigset_t set;
     target_sigset_t target_old_set;
     struct target_sigaction *sa;
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
 
     trace_user_handle_signal(cpu_env, sig);
     /* dequeue signal */
@@ -1256,7 +1256,7 @@ void process_pending_signals(CPUArchState *cpu_env)
 {
     CPUState *cpu = env_cpu(cpu_env);
     int sig;
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     sigset_t set;
     sigset_t *blocked_set;
 
@@ -1316,7 +1316,7 @@ void process_pending_signals(CPUArchState *cpu_env)
 int process_sigsuspend_mask(sigset_t **pset, target_ulong sigset,
                             target_ulong sigsize)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    TaskState *ts = get_task_state(thread_cpu);
     sigset_t *host_set = &ts->sigsuspend_mask;
     target_sigset_t *target_sigset;
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bc8c06522f8..c233d4eb30a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6515,7 +6515,7 @@ static void *clone_func(void *arg)
     env = info->env;
     cpu = env_cpu(env);
     thread_cpu = cpu;
-    ts = (TaskState *)cpu->opaque;
+    ts = get_task_state(cpu);
     info->tid = sys_gettid();
     task_settid(ts);
     if (info->child_tidptr)
@@ -6557,7 +6557,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         flags &= ~(CLONE_VFORK | CLONE_VM);
 
     if (flags & CLONE_VM) {
-        TaskState *parent_ts = (TaskState *)cpu->opaque;
+        TaskState *parent_ts = get_task_state(cpu);
         new_thread_info info;
         pthread_attr_t attr;
 
@@ -6680,7 +6680,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                 put_user_u32(sys_gettid(), child_tidptr);
             if (flags & CLONE_PARENT_SETTID)
                 put_user_u32(sys_gettid(), parent_tidptr);
-            ts = (TaskState *)cpu->opaque;
+            ts = get_task_state(cpu);
             if (flags & CLONE_SETTLS)
                 cpu_set_tls (env, newtls);
             if (flags & CLONE_CHILD_CLEARTID)
@@ -7946,7 +7946,7 @@ int host_to_target_waitstatus(int status)
 static int open_self_cmdline(CPUArchState *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu(cpu_env);
-    struct linux_binprm *bprm = ((TaskState *)cpu->opaque)->bprm;
+    struct linux_binprm *bprm = get_task_state(cpu)->bprm;
     int i;
 
     for (i = 0; i < bprm->argc; i++) {
@@ -8146,7 +8146,7 @@ static int open_self_smaps(CPUArchState *cpu_env, int fd)
 static int open_self_stat(CPUArchState *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu(cpu_env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     g_autoptr(GString) buf = g_string_new(NULL);
     int i;
 
@@ -8187,7 +8187,7 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
 static int open_self_auxv(CPUArchState *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu(cpu_env);
-    TaskState *ts = cpu->opaque;
+    TaskState *ts = get_task_state(cpu);
     abi_ulong auxv = ts->info->saved_auxv;
     abi_ulong len = ts->info->auxv_len;
     char *ptr;
@@ -9012,7 +9012,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         pthread_mutex_lock(&clone_lock);
 
         if (CPU_NEXT(first_cpu)) {
-            TaskState *ts = cpu->opaque;
+            TaskState *ts = get_task_state(cpu);
 
             if (ts->child_tidptr) {
                 put_user_u32(0, ts->child_tidptr);
@@ -9439,7 +9439,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_pause /* not on alpha */
     case TARGET_NR_pause:
         if (!block_signals()) {
-            sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
+            sigsuspend(&get_task_state(cpu)->signal_mask);
         }
         return -TARGET_EINTR;
 #endif
@@ -10005,7 +10005,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             sigset_t *set;
 
 #if defined(TARGET_ALPHA)
-            TaskState *ts = cpu->opaque;
+            TaskState *ts = get_task_state(cpu);
             /* target_to_host_old_sigset will bswap back */
             abi_ulong mask = tswapal(arg1);
             set = &ts->sigsuspend_mask;
@@ -10406,7 +10406,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_mprotect:
         arg1 = cpu_untagged_addr(cpu, arg1);
         {
-            TaskState *ts = cpu->opaque;
+            TaskState *ts = get_task_state(cpu);
             /* Special hack to detect libc making the stack executable.  */
             if ((arg3 & PROT_GROWSDOWN)
                 && arg1 >= ts->info->stack_limit
@@ -12537,7 +12537,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
       return do_set_thread_area(cpu_env, arg1);
 #elif defined(TARGET_M68K)
       {
-          TaskState *ts = cpu->opaque;
+          TaskState *ts = get_task_state(cpu);
           ts->tp_value = arg1;
           return 0;
       }
@@ -12551,7 +12551,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_get_thread_area(cpu_env, arg1);
 #elif defined(TARGET_M68K)
         {
-            TaskState *ts = cpu->opaque;
+            TaskState *ts = get_task_state(cpu);
             return ts->tp_value;
         }
 #else
@@ -12676,7 +12676,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_set_tid_address)
     case TARGET_NR_set_tid_address:
     {
-        TaskState *ts = cpu->opaque;
+        TaskState *ts = get_task_state(cpu);
         ts->child_tidptr = arg1;
         /* do not call host set_tid_address() syscall, instead return tid() */
         return get_errno(sys_gettid());
diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index c2facf3fc2d..9f512a2242b 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -74,7 +74,7 @@ static inline unsigned int vm_getl(CPUX86State *env,
 void save_v86_state(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
     struct target_vm86plus_struct * target_v86;
 
     if (!lock_user_struct(VERIFY_WRITE, target_v86, ts->target_v86, 0))
@@ -134,7 +134,7 @@ static inline void return_to_32bit(CPUX86State *env, int retval)
 static inline int set_IF(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
 
     ts->v86flags |= VIF_MASK;
     if (ts->v86flags & VIP_MASK) {
@@ -147,7 +147,7 @@ static inline int set_IF(CPUX86State *env)
 static inline void clear_IF(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
 
     ts->v86flags &= ~VIF_MASK;
 }
@@ -165,7 +165,7 @@ static inline void clear_AC(CPUX86State *env)
 static inline int set_vflags_long(unsigned long eflags, CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
 
     set_flags(ts->v86flags, eflags, ts->v86mask);
     set_flags(env->eflags, eflags, SAFE_MASK);
@@ -179,7 +179,7 @@ static inline int set_vflags_long(unsigned long eflags, CPUX86State *env)
 static inline int set_vflags_short(unsigned short flags, CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
 
     set_flags(ts->v86flags, flags, ts->v86mask & 0xffff);
     set_flags(env->eflags, flags, SAFE_MASK);
@@ -193,7 +193,7 @@ static inline int set_vflags_short(unsigned short flags, CPUX86State *env)
 static inline unsigned int get_vflags(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
     unsigned int flags;
 
     flags = env->eflags & RETURN_MASK;
@@ -210,7 +210,7 @@ static inline unsigned int get_vflags(CPUX86State *env)
 static void do_int(CPUX86State *env, int intno)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
     uint32_t int_addr, segoffs, ssp;
     unsigned int sp;
 
@@ -269,7 +269,7 @@ void handle_vm86_trap(CPUX86State *env, int trapno)
 void handle_vm86_fault(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
     uint32_t csp, ssp;
     unsigned int ip, sp, newflags, newip, newcs, opcode, intno;
     int data32, pref_done;
@@ -394,7 +394,7 @@ void handle_vm86_fault(CPUX86State *env)
 int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
 {
     CPUState *cs = env_cpu(env);
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
     struct target_vm86plus_struct * target_v86;
     int ret;
 
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 32dcfa52291..003208a9161 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -157,7 +157,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 {
     abi_ulong frame_addr;
     struct target_rt_sigframe *frame;
-    int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
+    int is_fdpic = info_is_fdpic(get_task_state(thread_cpu)->info);
     abi_ulong handler = 0;
     abi_ulong handler_fdpic_GOT = 0;
     uint32_t ra;
diff --git a/plugins/api.c b/plugins/api.c
index 81f43c9ce8a..e905e995bd6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -378,7 +378,7 @@ const char *qemu_plugin_path_to_binary(void)
 {
     char *path = NULL;
 #ifdef CONFIG_USER_ONLY
-    TaskState *ts = (TaskState *) current_cpu->opaque;
+    TaskState *ts = get_task_state(current_cpu);
     path = g_strdup(ts->bprm->filename);
 #endif
     return path;
@@ -388,7 +388,7 @@ uint64_t qemu_plugin_start_code(void)
 {
     uint64_t start = 0;
 #ifdef CONFIG_USER_ONLY
-    TaskState *ts = (TaskState *) current_cpu->opaque;
+    TaskState *ts = get_task_state(current_cpu);
     start = ts->info->start_code;
 #endif
     return start;
@@ -398,7 +398,7 @@ uint64_t qemu_plugin_end_code(void)
 {
     uint64_t end = 0;
 #ifdef CONFIG_USER_ONLY
-    TaskState *ts = (TaskState *) current_cpu->opaque;
+    TaskState *ts = get_task_state(current_cpu);
     end = ts->info->end_code;
 #endif
     return end;
@@ -408,7 +408,7 @@ uint64_t qemu_plugin_entry_code(void)
 {
     uint64_t entry = 0;
 #ifdef CONFIG_USER_ONLY
-    TaskState *ts = (TaskState *) current_cpu->opaque;
+    TaskState *ts = get_task_state(current_cpu);
     entry = ts->info->entry;
 #endif
     return entry;
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 329ea112607..d78c6428b90 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -214,7 +214,7 @@ static target_ulong syscall_err;
 static inline uint32_t get_swi_errno(CPUState *cs)
 {
 #ifdef CONFIG_USER_ONLY
-    TaskState *ts = cs->opaque;
+    TaskState *ts = get_task_state(cs);
 
     return ts->swi_errno;
 #else
@@ -226,7 +226,7 @@ static void common_semi_cb(CPUState *cs, uint64_t ret, int err)
 {
     if (err) {
 #ifdef CONFIG_USER_ONLY
-        TaskState *ts = cs->opaque;
+        TaskState *ts = get_task_state(cs);
         ts->swi_errno = err;
 #else
         syscall_err = err;
@@ -586,7 +586,7 @@ void do_common_semihosting(CPUState *cs)
 #if !defined(CONFIG_USER_ONLY)
             const char *cmdline;
 #else
-            TaskState *ts = cs->opaque;
+            TaskState *ts = get_task_state(cs);
 #endif
             GET_ARG(0);
             GET_ARG(1);
@@ -664,7 +664,7 @@ void do_common_semihosting(CPUState *cs)
             target_ulong retvals[4];
             int i;
 #ifdef CONFIG_USER_ONLY
-            TaskState *ts = cs->opaque;
+            TaskState *ts = get_task_state(cs);
             target_ulong limit;
 #else
             LayoutInfo info = common_semi_find_bases(cs);
-- 
2.39.2


