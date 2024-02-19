Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07980C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4hG-0005Uk-CP; Mon, 19 Feb 2024 09:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rc4hD-0005UI-9B
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:32:39 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rc4h6-0003U4-0C
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:32:37 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5649eb3ab68so864627a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1708353149; x=1708957949;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YIPapkEi/otTYT4PX/alPCOL+BDxPpaQE6f83M2a6wE=;
 b=eFnDEn/Q0TI5ZN1eFc/ig1+4x28Tv2pzWIFHvPZUm9/4cX4p2cmQDfXyIxEUPzMqxk
 kEx2qVeOaf1hPGrm+EKmIS8ybfD/qxUa0kXryFaPjSAhSrFZ1w9dLX29XQ3GGcuKRU+L
 iZWaADpwjrowFbG9tneV8Gh7U/Bf9O/86e3cVdOAY/ZD8pqpt1WWc5/uxlBuwbgu28bZ
 GDwhCSdDslnnWTRjSOXAWsk2W2Vkp1PmVJh4tYVi+1yazeHS9k67BDkid5RQuGGwquiJ
 bthTmFf724iv/q3eykOK6rr1A4kdcaKye+kSRq97VlAkpDsRjYaN/yFVWByL91TB76Vr
 g+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708353149; x=1708957949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YIPapkEi/otTYT4PX/alPCOL+BDxPpaQE6f83M2a6wE=;
 b=ctrBo637pPuXDsfdEZNARsfCrfJpDKkbZqwNQg447GS9/P7EqRLLs4YG9ztrvjBe86
 PxqZVkeFJ5wiKjrjPM2iwmqKji53fGU5d8atF01Z7EohQZeklvsa9bMPuobzAn6mvqWT
 rMPti1A7LlR0LOyGZ1++Ie6FRhi0u8fb5WtGcFGsPmh0GupbiuRVhHj1Nu+Y9gS4g4yS
 WefvKu7414Ike+4zlT6B4Q/w30p61PfEylY43B2Xt/0uJyBmQLsS8vsU4EtfdJ5SX0mO
 9zp2hjdTB4K1HAqDwNKOGqMsAaLh8xcWE4pspl+QGfdsV8nCMyn0L8wdor0eYutmC5ZD
 I46g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWQt6kzlBI9fsAdF8BQ0mOc0GRbWpT/AcGiQpXttUdajOr2gTlxLx6ujRlRQrECe34pSowimumAyJ2FR5uAQzSfXuNya0=
X-Gm-Message-State: AOJu0YyNQxwkhWvEeCXsnG5iRJLg5huE/hjuNcH7L/i1XhDWWmIv6xdI
 t7Ns/RRazz6lP5P3YrVzu+a+UdqFUJnV75VA0HfhWd8V29TSMVXY+PEnNn+c0qW4C5dIkpsuBZY
 3ZlNsQv3dweAXnORddt0SptHWwwQMvtSQnowA0w==
X-Google-Smtp-Source: AGHT+IHOpPps/Sbbm4pnr2swt39GlNTHTRll2RLHInh7EC+SW/Y2t8KSSNrcBwIVQHc0EiubOcTkXseJMV2u4rOwtDk=
X-Received: by 2002:aa7:d354:0:b0:560:4e74:9cf8 with SMTP id
 m20-20020aa7d354000000b005604e749cf8mr7953759edr.34.1708353148535; Mon, 19
 Feb 2024 06:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20240219141628.246823-1-iii@linux.ibm.com>
 <20240219141628.246823-3-iii@linux.ibm.com>
In-Reply-To: <20240219141628.246823-3-iii@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 19 Feb 2024 07:32:26 -0700
Message-ID: <CANCZdfq9UewuFbTr_EH31gM1pAbUAWJHqah8G8UDeUto=un1Pg@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] {linux,bsd}-user: Introduce get_task_state()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000091e9a10611bcf6e0"
Received-SPF: none client-ip=2a00:1450:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--00000000000091e9a10611bcf6e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:21=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:

> A CPU's TaskState is stored in the CPUState's void *opaque field,
> accessing which is somewhat awkward due to having to use a cast.
> Introduce a wrapper and use it everywhere.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

The bsd-user stuff is definitely good. The linux-user seems good, but I
didn't look
at it as closely.

Warner

>  bsd-user/bsd-file.h           |  2 +-
>  bsd-user/qemu.h               |  5 +++++
>  bsd-user/signal.c             | 20 ++++++++++----------
>  gdbstub/user-target.c         |  4 ++--
>  include/user/safe-syscall.h   |  2 +-
>  linux-user/aarch64/cpu_loop.c |  2 +-
>  linux-user/arm/cpu_loop.c     |  4 ++--
>  linux-user/arm/signal.c       |  2 +-
>  linux-user/cris/cpu_loop.c    |  2 +-
>  linux-user/elfload.c          |  6 +++---
>  linux-user/hppa/signal.c      |  2 +-
>  linux-user/linuxload.c        |  2 +-
>  linux-user/m68k/cpu_loop.c    |  2 +-
>  linux-user/m68k/target_cpu.h  |  2 +-
>  linux-user/mips/cpu_loop.c    |  2 +-
>  linux-user/ppc/signal.c       |  4 ++--
>  linux-user/qemu.h             |  5 +++++
>  linux-user/riscv/cpu_loop.c   |  2 +-
>  linux-user/signal-common.h    |  2 +-
>  linux-user/signal.c           | 30 +++++++++++++++---------------
>  linux-user/syscall.c          | 26 +++++++++++++-------------
>  linux-user/vm86.c             | 18 +++++++++---------
>  linux-user/xtensa/signal.c    |  2 +-
>  plugins/api.c                 |  8 ++++----
>  semihosting/arm-compat-semi.c |  8 ++++----
>  25 files changed, 87 insertions(+), 77 deletions(-)
>
> diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
> index 3c00dc00567..6fa2c30b4de 100644
> --- a/bsd-user/bsd-file.h
> +++ b/bsd-user/bsd-file.h
> @@ -641,7 +641,7 @@ static abi_long do_bsd_readlink(CPUArchState *env,
> abi_long arg1,
>      }
>      if (strcmp(p1, "/proc/curproc/file") =3D=3D 0) {
>          CPUState *cpu =3D env_cpu(env);
> -        TaskState *ts =3D (TaskState *)cpu->opaque;
> +        TaskState *ts =3D get_task_state(cpu);
>          strncpy(p2, ts->bprm->fullpath, arg3);
>          ret =3D MIN((abi_long)strlen(ts->bprm->fullpath), arg3);
>      } else {
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index dc842fffa7d..a2417b25156 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -110,6 +110,11 @@ typedef struct TaskState {
>      struct target_sigaltstack sigaltstack_used;
>  } __attribute__((aligned(16))) TaskState;
>
> +static inline TaskState *get_task_state(CPUState *cs)
> +{
> +    return cs->opaque;
> +}
> +
>  void stop_all_tasks(void);
>  extern const char *interp_prefix;
>  extern const char *qemu_uname_release;
> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> index f4352e4530f..e9f80a06d32 100644
> --- a/bsd-user/signal.c
> +++ b/bsd-user/signal.c
> @@ -319,7 +319,7 @@ void host_to_target_siginfo(target_siginfo_t *tinfo,
> const siginfo_t *info)
>
>  int block_signals(void)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      sigset_t set;
>
>      /*
> @@ -359,7 +359,7 @@ void dump_core_and_abort(int target_sig)
>  {
>      CPUState *cpu =3D thread_cpu;
>      CPUArchState *env =3D cpu_env(cpu);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      int core_dumped =3D 0;
>      int host_sig;
>      struct sigaction act;
> @@ -421,7 +421,7 @@ void queue_signal(CPUArchState *env, int sig, int
> si_type,
>                    target_siginfo_t *info)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>
>      trace_user_queue_signal(env, sig);
>
> @@ -476,7 +476,7 @@ void force_sig_fault(int sig, int code, abi_ulong add=
r)
>  static void host_signal_handler(int host_sig, siginfo_t *info, void *puc=
)
>  {
>      CPUState *cpu =3D thread_cpu;
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      target_siginfo_t tinfo;
>      ucontext_t *uc =3D puc;
>      struct emulated_sigtable *k;
> @@ -585,7 +585,7 @@ static void host_signal_handler(int host_sig,
> siginfo_t *info, void *puc)
>  /* compare to kern/kern_sig.c sys_sigaltstack() and kern_sigaltstack() *=
/
>  abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr,
> abi_ulong sp)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      int ret;
>      target_stack_t oss;
>
> @@ -714,7 +714,7 @@ int do_sigaction(int sig, const struct
> target_sigaction *act,
>  static inline abi_ulong get_sigframe(struct target_sigaction *ka,
>          CPUArchState *env, size_t frame_size)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      abi_ulong sp;
>
>      /* Use default user stack */
> @@ -789,7 +789,7 @@ static int reset_signal_mask(target_ucontext_t
> *ucontext)
>      int i;
>      sigset_t blocked;
>      target_sigset_t target_set;
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>
>      for (i =3D 0; i < TARGET_NSIG_WORDS; i++) {
>          __get_user(target_set.__bits[i], &ucontext->uc_sigmask.__bits[i]=
);
> @@ -839,7 +839,7 @@ badframe:
>
>  void signal_init(void)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      struct sigaction act;
>      struct sigaction oact;
>      int i;
> @@ -878,7 +878,7 @@ static void handle_pending_signal(CPUArchState *env,
> int sig,
>                                    struct emulated_sigtable *k)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      struct target_sigaction *sa;
>      int code;
>      sigset_t set;
> @@ -967,7 +967,7 @@ void process_pending_signals(CPUArchState *env)
>      int sig;
>      sigset_t *blocked_set, set;
>      struct emulated_sigtable *k;
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>
>      while (qatomic_read(&ts->signal_pending)) {
>          sigfillset(&set);
> diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
> index b7d4c37cd81..6646684a4c6 100644
> --- a/gdbstub/user-target.c
> +++ b/gdbstub/user-target.c
> @@ -204,7 +204,7 @@ int gdb_target_signal_to_gdb(int sig)
>
>  int gdb_get_cpu_index(CPUState *cpu)
>  {
> -    TaskState *ts =3D (TaskState *) cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      return ts ? ts->ts_tid : -1;
>  }
>
> @@ -399,7 +399,7 @@ void gdb_handle_query_xfer_exec_file(GArray *params,
> void *user_ctx)
>          return;
>      }
>
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      if (!ts || !ts->bprm || !ts->bprm->filename) {
>          gdb_put_packet("E00");
>          return;
> diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h
> index 27b71cdbd8e..aa075f4d5cd 100644
> --- a/include/user/safe-syscall.h
> +++ b/include/user/safe-syscall.h
> @@ -134,7 +134,7 @@ extern char safe_syscall_start[];
>  extern char safe_syscall_end[];
>
>  #define safe_syscall(...)
>  \
> -    safe_syscall_base(&((TaskState *)thread_cpu->opaque)->signal_pending=
,
> \
> +    safe_syscall_base(&get_task_state(thread_cpu)->signal_pending,
> \
>                        __VA_ARGS__)
>
>  #endif
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.=
c
> index 8c20dc8a39a..71cdc8be50c 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -189,7 +189,7 @@ void target_cpu_copy_regs(CPUArchState *env, struct
> target_pt_regs *regs)
>  {
>      ARMCPU *cpu =3D env_archcpu(env);
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>      struct image_info *info =3D ts->info;
>      int i;
>
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index b404117ff30..db1a41e27f4 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -263,7 +263,7 @@ static bool insn_is_linux_bkpt(uint32_t opcode, bool
> is_thumb)
>
>  static bool emulate_arm_fpa11(CPUARMState *env, uint32_t opcode)
>  {
> -    TaskState *ts =3D env_cpu(env)->opaque;
> +    TaskState *ts =3D get_task_state(env_cpu(env));
>      int rc =3D EmulateAll(opcode, &ts->fpa, env);
>      int raise, enabled;
>
> @@ -514,7 +514,7 @@ void cpu_loop(CPUARMState *env)
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs=
)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      struct image_info *info =3D ts->info;
>      int i;
>
> diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
> index f77f692c63f..59806335f5b 100644
> --- a/linux-user/arm/signal.c
> +++ b/linux-user/arm/signal.c
> @@ -177,7 +177,7 @@ setup_return(CPUARMState *env, struct target_sigactio=
n
> *ka, int usig,
>      abi_ulong handler =3D 0;
>      abi_ulong handler_fdpic_GOT =3D 0;
>      abi_ulong retcode;
> -    bool is_fdpic =3D info_is_fdpic(((TaskState
> *)thread_cpu->opaque)->info);
> +    bool is_fdpic =3D info_is_fdpic(get_task_state(thread_cpu)->info);
>      bool is_rt =3D ka->sa_flags & TARGET_SA_SIGINFO;
>      bool thumb;
>
> diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
> index 01e6ff16fc9..04c9086b6dc 100644
> --- a/linux-user/cris/cpu_loop.c
> +++ b/linux-user/cris/cpu_loop.c
> @@ -72,7 +72,7 @@ void cpu_loop(CPUCRISState *env)
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs=
)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      struct image_info *info =3D ts->info;
>
>      env->regs[0] =3D regs->r0;
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index b8eef893d0c..6de72da585d 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -4499,7 +4499,7 @@ static int write_note(struct memelfnote *men, int f=
d)
>  static void fill_thread_info(struct elf_note_info *info, const
> CPUArchState *env)
>  {
>      CPUState *cpu =3D env_cpu((CPUArchState *)env);
> -    TaskState *ts =3D (TaskState *)cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      struct elf_thread_status *ets;
>
>      ets =3D g_malloc0(sizeof (*ets));
> @@ -4529,7 +4529,7 @@ static int fill_note_info(struct elf_note_info *inf=
o,
>  {
>  #define NUMNOTES 3
>      CPUState *cpu =3D env_cpu((CPUArchState *)env);
> -    TaskState *ts =3D (TaskState *)cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      int i;
>
>      info->notes =3D g_new0(struct memelfnote, NUMNOTES);
> @@ -4653,7 +4653,7 @@ static int write_note_info(struct elf_note_info
> *info, int fd)
>  static int elf_core_dump(int signr, const CPUArchState *env)
>  {
>      const CPUState *cpu =3D env_cpu((CPUArchState *)env);
> -    const TaskState *ts =3D (const TaskState *)cpu->opaque;
> +    const TaskState *ts =3D (const TaskState *)get_task_state((CPUState
> *)cpu);
>      struct vm_area_struct *vma =3D NULL;
>      g_autofree char *corefile =3D NULL;
>      struct elf_note_info info;
> diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
> index d08a97dae61..c84557e906a 100644
> --- a/linux-user/hppa/signal.c
> +++ b/linux-user/hppa/signal.c
> @@ -112,7 +112,7 @@ void setup_rt_frame(int sig, struct target_sigaction
> *ka,
>      abi_ulong frame_addr, sp, haddr;
>      struct target_rt_sigframe *frame;
>      int i;
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>
>      sp =3D get_sp_from_cpustate(env);
>      if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
> diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
> index 4a794f8cea1..37f132be4af 100644
> --- a/linux-user/linuxload.c
> +++ b/linux-user/linuxload.c
> @@ -89,7 +89,7 @@ static int prepare_binprm(struct linux_binprm *bprm)
>  abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
>                                abi_ulong stringp, int push_ptr)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      int n =3D sizeof(abi_ulong);
>      abi_ulong envp;
>      abi_ulong argv;
> diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
> index caead1cb741..f79b8e4ab05 100644
> --- a/linux-user/m68k/cpu_loop.c
> +++ b/linux-user/m68k/cpu_loop.c
> @@ -95,7 +95,7 @@ void cpu_loop(CPUM68KState *env)
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs=
)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      struct image_info *info =3D ts->info;
>
>      env->pc =3D regs->pc;
> diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
> index c3f288dfe83..4b40c09a8d6 100644
> --- a/linux-user/m68k/target_cpu.h
> +++ b/linux-user/m68k/target_cpu.h
> @@ -37,7 +37,7 @@ static inline void cpu_clone_regs_parent(CPUM68KState
> *env, unsigned flags)
>  static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>
>      ts->tp_value =3D newtls;
>  }
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 990b03e727b..462387a0737 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -214,7 +214,7 @@ done_syscall:
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs=
)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      struct image_info *info =3D ts->info;
>      int i;
>
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index 7e7302823b0..c232424c1e8 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -486,7 +486,7 @@ void setup_rt_frame(int sig, struct target_sigaction
> *ka,
>      int i, err =3D 0;
>  #if defined(TARGET_PPC64)
>      struct target_sigcontext *sc =3D 0;
> -    struct image_info *image =3D ((TaskState *)thread_cpu->opaque)->info=
;
> +    struct image_info *image =3D get_task_state(thread_cpu)->info;
>  #endif
>
>      rt_sf_addr =3D get_sigframe(ka, env, sizeof(*rt_sf));
> @@ -673,7 +673,7 @@ abi_long do_swapcontext(CPUArchState *env, abi_ulong
> uold_ctx,
>      }
>
>      if (uold_ctx) {
> -        TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +        TaskState *ts =3D get_task_state(thread_cpu);
>
>          if (!lock_user_struct(VERIFY_WRITE, uctx, uold_ctx, 1)) {
>              return -TARGET_EFAULT;
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 4de9ec783f6..32cd43d9eff 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -162,6 +162,11 @@ typedef struct TaskState {
>      uint64_t start_boottime;
>  } TaskState;
>
> +static inline TaskState *get_task_state(CPUState *cs)
> +{
> +    return cs->opaque;
> +}
> +
>  abi_long do_brk(abi_ulong new_brk);
>  int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char
> *pathname,
>                      int flags, mode_t mode, bool safe);
> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index bffca7db127..52c49c2e426 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -97,7 +97,7 @@ void cpu_loop(CPURISCVState *env)
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs=
)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      struct image_info *info =3D ts->info;
>
>      env->pc =3D regs->sepc;
> diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
> index 3e2dc604c2f..a7df12fc445 100644
> --- a/linux-user/signal-common.h
> +++ b/linux-user/signal-common.h
> @@ -113,7 +113,7 @@ int process_sigsuspend_mask(sigset_t **pset,
> target_ulong sigset,
>  static inline void finish_sigsuspend_mask(int ret)
>  {
>      if (ret !=3D -QEMU_ERESTARTSYS) {
> -        TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +        TaskState *ts =3D get_task_state(thread_cpu);
>          ts->in_sigsuspend =3D 1;
>      }
>  }
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index d3e62ab030f..cc7dd78e41f 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -172,7 +172,7 @@ void target_to_host_old_sigset(sigset_t *sigset,
>
>  int block_signals(void)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      sigset_t set;
>
>      /* It's OK to block everything including SIGSEGV, because we won't
> @@ -194,7 +194,7 @@ int block_signals(void)
>   */
>  int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>
>      if (oldset) {
>          *oldset =3D ts->signal_mask;
> @@ -237,7 +237,7 @@ int do_sigprocmask(int how, const sigset_t *set,
> sigset_t *oldset)
>   */
>  void set_sigmask(const sigset_t *set)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>
>      ts->signal_mask =3D *set;
>  }
> @@ -246,7 +246,7 @@ void set_sigmask(const sigset_t *set)
>
>  int on_sig_stack(unsigned long sp)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>
>      return (sp - ts->sigaltstack_used.ss_sp
>              < ts->sigaltstack_used.ss_size);
> @@ -254,7 +254,7 @@ int on_sig_stack(unsigned long sp)
>
>  int sas_ss_flags(unsigned long sp)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>
>      return (ts->sigaltstack_used.ss_size =3D=3D 0 ? SS_DISABLE
>              : on_sig_stack(sp) ? SS_ONSTACK : 0);
> @@ -265,7 +265,7 @@ abi_ulong target_sigsp(abi_ulong sp, struct
> target_sigaction *ka)
>      /*
>       * This is the X/Open sanctioned signal stack switching.
>       */
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>
>      if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
>          return ts->sigaltstack_used.ss_sp + ts->sigaltstack_used.ss_size=
;
> @@ -275,7 +275,7 @@ abi_ulong target_sigsp(abi_ulong sp, struct
> target_sigaction *ka)
>
>  void target_save_altstack(target_stack_t *uss, CPUArchState *env)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>
>      __put_user(ts->sigaltstack_used.ss_sp, &uss->ss_sp);
>      __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &uss->ss_flags);
> @@ -284,7 +284,7 @@ void target_save_altstack(target_stack_t *uss,
> CPUArchState *env)
>
>  abi_long target_restore_altstack(target_stack_t *uss, CPUArchState *env)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      size_t minstacksize =3D TARGET_MINSIGSTKSZ;
>      target_stack_t ss;
>
> @@ -571,7 +571,7 @@ static void signal_table_init(void)
>
>  void signal_init(void)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      struct sigaction act, oact;
>
>      /* initialize signal conversion tables */
> @@ -730,7 +730,7 @@ static G_NORETURN
>  void dump_core_and_abort(CPUArchState *env, int target_sig)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D (TaskState *)cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      int host_sig, core_dumped =3D 0;
>
>      /* On exit, undo the remapping of SIGABRT. */
> @@ -769,7 +769,7 @@ void queue_signal(CPUArchState *env, int sig, int
> si_type,
>                    target_siginfo_t *info)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>
>      trace_user_queue_signal(env, sig);
>
> @@ -954,7 +954,7 @@ static void host_signal_handler(int host_sig,
> siginfo_t *info, void *puc)
>  {
>      CPUState *cpu =3D thread_cpu;
>      CPUArchState *env =3D cpu_env(cpu);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      target_siginfo_t tinfo;
>      host_sigcontext *uc =3D puc;
>      struct emulated_sigtable *k;
> @@ -1174,7 +1174,7 @@ static void handle_pending_signal(CPUArchState
> *cpu_env, int sig,
>      sigset_t set;
>      target_sigset_t target_old_set;
>      struct target_sigaction *sa;
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>
>      trace_user_handle_signal(cpu_env, sig);
>      /* dequeue signal */
> @@ -1256,7 +1256,7 @@ void process_pending_signals(CPUArchState *cpu_env)
>  {
>      CPUState *cpu =3D env_cpu(cpu_env);
>      int sig;
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      sigset_t set;
>      sigset_t *blocked_set;
>
> @@ -1316,7 +1316,7 @@ void process_pending_signals(CPUArchState *cpu_env)
>  int process_sigsuspend_mask(sigset_t **pset, target_ulong sigset,
>                              target_ulong sigsize)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    TaskState *ts =3D get_task_state(thread_cpu);
>      sigset_t *host_set =3D &ts->sigsuspend_mask;
>      target_sigset_t *target_sigset;
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e384e142489..3e105488ee2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6515,7 +6515,7 @@ static void *clone_func(void *arg)
>      env =3D info->env;
>      cpu =3D env_cpu(env);
>      thread_cpu =3D cpu;
> -    ts =3D (TaskState *)cpu->opaque;
> +    ts =3D get_task_state(cpu);
>      info->tid =3D sys_gettid();
>      task_settid(ts);
>      if (info->child_tidptr)
> @@ -6557,7 +6557,7 @@ static int do_fork(CPUArchState *env, unsigned int
> flags, abi_ulong newsp,
>          flags &=3D ~(CLONE_VFORK | CLONE_VM);
>
>      if (flags & CLONE_VM) {
> -        TaskState *parent_ts =3D (TaskState *)cpu->opaque;
> +        TaskState *parent_ts =3D get_task_state(cpu);
>          new_thread_info info;
>          pthread_attr_t attr;
>
> @@ -6680,7 +6680,7 @@ static int do_fork(CPUArchState *env, unsigned int
> flags, abi_ulong newsp,
>                  put_user_u32(sys_gettid(), child_tidptr);
>              if (flags & CLONE_PARENT_SETTID)
>                  put_user_u32(sys_gettid(), parent_tidptr);
> -            ts =3D (TaskState *)cpu->opaque;
> +            ts =3D get_task_state(cpu);
>              if (flags & CLONE_SETTLS)
>                  cpu_set_tls (env, newtls);
>              if (flags & CLONE_CHILD_CLEARTID)
> @@ -7946,7 +7946,7 @@ int host_to_target_waitstatus(int status)
>  static int open_self_cmdline(CPUArchState *cpu_env, int fd)
>  {
>      CPUState *cpu =3D env_cpu(cpu_env);
> -    struct linux_binprm *bprm =3D ((TaskState *)cpu->opaque)->bprm;
> +    struct linux_binprm *bprm =3D get_task_state(cpu)->bprm;
>      int i;
>
>      for (i =3D 0; i < bprm->argc; i++) {
> @@ -8130,7 +8130,7 @@ static int open_self_smaps(CPUArchState *cpu_env,
> int fd)
>  static int open_self_stat(CPUArchState *cpu_env, int fd)
>  {
>      CPUState *cpu =3D env_cpu(cpu_env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      g_autoptr(GString) buf =3D g_string_new(NULL);
>      int i;
>
> @@ -8171,7 +8171,7 @@ static int open_self_stat(CPUArchState *cpu_env, in=
t
> fd)
>  static int open_self_auxv(CPUArchState *cpu_env, int fd)
>  {
>      CPUState *cpu =3D env_cpu(cpu_env);
> -    TaskState *ts =3D cpu->opaque;
> +    TaskState *ts =3D get_task_state(cpu);
>      abi_ulong auxv =3D ts->info->saved_auxv;
>      abi_ulong len =3D ts->info->auxv_len;
>      char *ptr;
> @@ -8996,7 +8996,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env,
> int num, abi_long arg1,
>          pthread_mutex_lock(&clone_lock);
>
>          if (CPU_NEXT(first_cpu)) {
> -            TaskState *ts =3D cpu->opaque;
> +            TaskState *ts =3D get_task_state(cpu);
>
>              if (ts->child_tidptr) {
>                  put_user_u32(0, ts->child_tidptr);
> @@ -9423,7 +9423,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env,
> int num, abi_long arg1,
>  #ifdef TARGET_NR_pause /* not on alpha */
>      case TARGET_NR_pause:
>          if (!block_signals()) {
> -            sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
> +            sigsuspend(&get_task_state(cpu)->signal_mask);
>          }
>          return -TARGET_EINTR;
>  #endif
> @@ -9989,7 +9989,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env,
> int num, abi_long arg1,
>              sigset_t *set;
>
>  #if defined(TARGET_ALPHA)
> -            TaskState *ts =3D cpu->opaque;
> +            TaskState *ts =3D get_task_state(cpu);
>              /* target_to_host_old_sigset will bswap back */
>              abi_ulong mask =3D tswapal(arg1);
>              set =3D &ts->sigsuspend_mask;
> @@ -10390,7 +10390,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env=
,
> int num, abi_long arg1,
>      case TARGET_NR_mprotect:
>          arg1 =3D cpu_untagged_addr(cpu, arg1);
>          {
> -            TaskState *ts =3D cpu->opaque;
> +            TaskState *ts =3D get_task_state(cpu);
>              /* Special hack to detect libc making the stack executable.
> */
>              if ((arg3 & PROT_GROWSDOWN)
>                  && arg1 >=3D ts->info->stack_limit
> @@ -12521,7 +12521,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env=
,
> int num, abi_long arg1,
>        return do_set_thread_area(cpu_env, arg1);
>  #elif defined(TARGET_M68K)
>        {
> -          TaskState *ts =3D cpu->opaque;
> +          TaskState *ts =3D get_task_state(cpu);
>            ts->tp_value =3D arg1;
>            return 0;
>        }
> @@ -12535,7 +12535,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env=
,
> int num, abi_long arg1,
>          return do_get_thread_area(cpu_env, arg1);
>  #elif defined(TARGET_M68K)
>          {
> -            TaskState *ts =3D cpu->opaque;
> +            TaskState *ts =3D get_task_state(cpu);
>              return ts->tp_value;
>          }
>  #else
> @@ -12660,7 +12660,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env=
,
> int num, abi_long arg1,
>  #if defined(TARGET_NR_set_tid_address)
>      case TARGET_NR_set_tid_address:
>      {
> -        TaskState *ts =3D cpu->opaque;
> +        TaskState *ts =3D get_task_state(cpu);
>          ts->child_tidptr =3D arg1;
>          /* do not call host set_tid_address() syscall, instead return
> tid() */
>          return get_errno(sys_gettid());
> diff --git a/linux-user/vm86.c b/linux-user/vm86.c
> index c2facf3fc2d..9f512a2242b 100644
> --- a/linux-user/vm86.c
> +++ b/linux-user/vm86.c
> @@ -74,7 +74,7 @@ static inline unsigned int vm_getl(CPUX86State *env,
>  void save_v86_state(CPUX86State *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>      struct target_vm86plus_struct * target_v86;
>
>      if (!lock_user_struct(VERIFY_WRITE, target_v86, ts->target_v86, 0))
> @@ -134,7 +134,7 @@ static inline void return_to_32bit(CPUX86State *env,
> int retval)
>  static inline int set_IF(CPUX86State *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>
>      ts->v86flags |=3D VIF_MASK;
>      if (ts->v86flags & VIP_MASK) {
> @@ -147,7 +147,7 @@ static inline int set_IF(CPUX86State *env)
>  static inline void clear_IF(CPUX86State *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>
>      ts->v86flags &=3D ~VIF_MASK;
>  }
> @@ -165,7 +165,7 @@ static inline void clear_AC(CPUX86State *env)
>  static inline int set_vflags_long(unsigned long eflags, CPUX86State *env=
)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>
>      set_flags(ts->v86flags, eflags, ts->v86mask);
>      set_flags(env->eflags, eflags, SAFE_MASK);
> @@ -179,7 +179,7 @@ static inline int set_vflags_long(unsigned long
> eflags, CPUX86State *env)
>  static inline int set_vflags_short(unsigned short flags, CPUX86State *en=
v)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>
>      set_flags(ts->v86flags, flags, ts->v86mask & 0xffff);
>      set_flags(env->eflags, flags, SAFE_MASK);
> @@ -193,7 +193,7 @@ static inline int set_vflags_short(unsigned short
> flags, CPUX86State *env)
>  static inline unsigned int get_vflags(CPUX86State *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>      unsigned int flags;
>
>      flags =3D env->eflags & RETURN_MASK;
> @@ -210,7 +210,7 @@ static inline unsigned int get_vflags(CPUX86State *en=
v)
>  static void do_int(CPUX86State *env, int intno)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>      uint32_t int_addr, segoffs, ssp;
>      unsigned int sp;
>
> @@ -269,7 +269,7 @@ void handle_vm86_trap(CPUX86State *env, int trapno)
>  void handle_vm86_fault(CPUX86State *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>      uint32_t csp, ssp;
>      unsigned int ip, sp, newflags, newip, newcs, opcode, intno;
>      int data32, pref_done;
> @@ -394,7 +394,7 @@ void handle_vm86_fault(CPUX86State *env)
>  int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>      struct target_vm86plus_struct * target_v86;
>      int ret;
>
> diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
> index 32dcfa52291..003208a9161 100644
> --- a/linux-user/xtensa/signal.c
> +++ b/linux-user/xtensa/signal.c
> @@ -157,7 +157,7 @@ void setup_rt_frame(int sig, struct target_sigaction
> *ka,
>  {
>      abi_ulong frame_addr;
>      struct target_rt_sigframe *frame;
> -    int is_fdpic =3D info_is_fdpic(((TaskState *)thread_cpu->opaque)->in=
fo);
> +    int is_fdpic =3D info_is_fdpic(get_task_state(thread_cpu)->info);
>      abi_ulong handler =3D 0;
>      abi_ulong handler_fdpic_GOT =3D 0;
>      uint32_t ra;
> diff --git a/plugins/api.c b/plugins/api.c
> index 5521b0ad36c..1d7b72c0f67 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -392,7 +392,7 @@ const char *qemu_plugin_path_to_binary(void)
>  {
>      char *path =3D NULL;
>  #ifdef CONFIG_USER_ONLY
> -    TaskState *ts =3D (TaskState *) current_cpu->opaque;
> +    TaskState *ts =3D get_task_state(current_cpu);
>      path =3D g_strdup(ts->bprm->filename);
>  #endif
>      return path;
> @@ -402,7 +402,7 @@ uint64_t qemu_plugin_start_code(void)
>  {
>      uint64_t start =3D 0;
>  #ifdef CONFIG_USER_ONLY
> -    TaskState *ts =3D (TaskState *) current_cpu->opaque;
> +    TaskState *ts =3D get_task_state(current_cpu);
>      start =3D ts->info->start_code;
>  #endif
>      return start;
> @@ -412,7 +412,7 @@ uint64_t qemu_plugin_end_code(void)
>  {
>      uint64_t end =3D 0;
>  #ifdef CONFIG_USER_ONLY
> -    TaskState *ts =3D (TaskState *) current_cpu->opaque;
> +    TaskState *ts =3D get_task_state(current_cpu);
>      end =3D ts->info->end_code;
>  #endif
>      return end;
> @@ -422,7 +422,7 @@ uint64_t qemu_plugin_entry_code(void)
>  {
>      uint64_t entry =3D 0;
>  #ifdef CONFIG_USER_ONLY
> -    TaskState *ts =3D (TaskState *) current_cpu->opaque;
> +    TaskState *ts =3D get_task_state(current_cpu);
>      entry =3D ts->info->entry;
>  #endif
>      return entry;
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.=
c
> index 329ea112607..d78c6428b90 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -214,7 +214,7 @@ static target_ulong syscall_err;
>  static inline uint32_t get_swi_errno(CPUState *cs)
>  {
>  #ifdef CONFIG_USER_ONLY
> -    TaskState *ts =3D cs->opaque;
> +    TaskState *ts =3D get_task_state(cs);
>
>      return ts->swi_errno;
>  #else
> @@ -226,7 +226,7 @@ static void common_semi_cb(CPUState *cs, uint64_t ret=
,
> int err)
>  {
>      if (err) {
>  #ifdef CONFIG_USER_ONLY
> -        TaskState *ts =3D cs->opaque;
> +        TaskState *ts =3D get_task_state(cs);
>          ts->swi_errno =3D err;
>  #else
>          syscall_err =3D err;
> @@ -586,7 +586,7 @@ void do_common_semihosting(CPUState *cs)
>  #if !defined(CONFIG_USER_ONLY)
>              const char *cmdline;
>  #else
> -            TaskState *ts =3D cs->opaque;
> +            TaskState *ts =3D get_task_state(cs);
>  #endif
>              GET_ARG(0);
>              GET_ARG(1);
> @@ -664,7 +664,7 @@ void do_common_semihosting(CPUState *cs)
>              target_ulong retvals[4];
>              int i;
>  #ifdef CONFIG_USER_ONLY
> -            TaskState *ts =3D cs->opaque;
> +            TaskState *ts =3D get_task_state(cs);
>              target_ulong limit;
>  #else
>              LayoutInfo info =3D common_semi_find_bases(cs);
> --
> 2.43.2
>
>

--00000000000091e9a10611bcf6e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 19, 2024 at 7:21=E2=80=AF=
AM Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">A CPU&#39;s TaskState is stored in the CPUState&#39;s void *opaque field=
,<br>
accessing which is somewhat awkward due to having to use a cast.<br>
Introduce a wrapper and use it everywhere.<br>
<br>
Suggested-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org=
" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br></blockquote><div><br></div><d=
iv>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdim=
p.com</a>&gt;</div><div><br></div><div>The bsd-user stuff is definitely goo=
d. The linux-user seems good, but I didn&#39;t look</div><div>at it as clos=
ely.</div><div><br></div><div>Warner <br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
=C2=A0bsd-user/bsd-file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
 +-<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 5 +++++<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 20=
 ++++++++++----------<br>
=C2=A0gdbstub/user-target.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--=
<br>
=C2=A0include/user/safe-syscall.h=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0linux-user/aarch64/cpu_loop.c |=C2=A0 2 +-<br>
=C2=A0linux-user/arm/cpu_loop.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0linux-user/arm/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0linux-user/cris/cpu_loop.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +++-=
--<br>
=C2=A0linux-user/hppa/signal.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/linuxload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/m68k/cpu_loop.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/m68k/target_cpu.h=C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/mips/cpu_loop.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/ppc/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0linux-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 5 +++++<br>
=C2=A0linux-user/riscv/cpu_loop.c=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0linux-user/signal-common.h=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++++=
+++++++++++---------------<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 +++++++++=
++++-------------<br>
=C2=A0linux-user/vm86.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18=
 +++++++++---------<br>
=C2=A0linux-user/xtensa/signal.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0plugins/api.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 8 ++++----<br>
=C2=A0semihosting/arm-compat-semi.c |=C2=A0 8 ++++----<br>
=C2=A025 files changed, 87 insertions(+), 77 deletions(-)<br>
<br>
diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h<br>
index 3c00dc00567..6fa2c30b4de 100644<br>
--- a/bsd-user/bsd-file.h<br>
+++ b/bsd-user/bsd-file.h<br>
@@ -641,7 +641,7 @@ static abi_long do_bsd_readlink(CPUArchState *env, abi_=
long arg1,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (strcmp(p1, &quot;/proc/curproc/file&quot;) =3D=3D 0=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)cpu-&gt;opaque;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncpy(p2, ts-&gt;bprm-&gt;fullpath, arg=
3);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D MIN((abi_long)strlen(ts-&gt;bprm-=
&gt;fullpath), arg3);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
index dc842fffa7d..a2417b25156 100644<br>
--- a/bsd-user/qemu.h<br>
+++ b/bsd-user/qemu.h<br>
@@ -110,6 +110,11 @@ typedef struct TaskState {<br>
=C2=A0 =C2=A0 =C2=A0struct target_sigaltstack sigaltstack_used;<br>
=C2=A0} __attribute__((aligned(16))) TaskState;<br>
<br>
+static inline TaskState *get_task_state(CPUState *cs)<br>
+{<br>
+=C2=A0 =C2=A0 return cs-&gt;opaque;<br>
+}<br>
+<br>
=C2=A0void stop_all_tasks(void);<br>
=C2=A0extern const char *interp_prefix;<br>
=C2=A0extern const char *qemu_uname_release;<br>
diff --git a/bsd-user/signal.c b/bsd-user/signal.c<br>
index f4352e4530f..e9f80a06d32 100644<br>
--- a/bsd-user/signal.c<br>
+++ b/bsd-user/signal.c<br>
@@ -319,7 +319,7 @@ void host_to_target_siginfo(target_siginfo_t *tinfo, co=
nst siginfo_t *info)<br>
<br>
=C2=A0int block_signals(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0sigset_t set;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -359,7 +359,7 @@ void dump_core_and_abort(int target_sig)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D thread_cpu;<br>
=C2=A0 =C2=A0 =C2=A0CPUArchState *env =3D cpu_env(cpu);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0int core_dumped =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int host_sig;<br>
=C2=A0 =C2=A0 =C2=A0struct sigaction act;<br>
@@ -421,7 +421,7 @@ void queue_signal(CPUArchState *env, int sig, int si_ty=
pe,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=
_siginfo_t *info)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_user_queue_signal(env, sig);<br>
<br>
@@ -476,7 +476,7 @@ void force_sig_fault(int sig, int code, abi_ulong addr)=
<br>
=C2=A0static void host_signal_handler(int host_sig, siginfo_t *info, void *=
puc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D thread_cpu;<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0target_siginfo_t tinfo;<br>
=C2=A0 =C2=A0 =C2=A0ucontext_t *uc =3D puc;<br>
=C2=A0 =C2=A0 =C2=A0struct emulated_sigtable *k;<br>
@@ -585,7 +585,7 @@ static void host_signal_handler(int host_sig, siginfo_t=
 *info, void *puc)<br>
=C2=A0/* compare to kern/kern_sig.c sys_sigaltstack() and kern_sigaltstack(=
) */<br>
=C2=A0abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_=
ulong sp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0target_stack_t oss;<br>
<br>
@@ -714,7 +714,7 @@ int do_sigaction(int sig, const struct target_sigaction=
 *act,<br>
=C2=A0static inline abi_ulong get_sigframe(struct target_sigaction *ka,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUArchState *env, size_t frame_size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong sp;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Use default user stack */<br>
@@ -789,7 +789,7 @@ static int reset_signal_mask(target_ucontext_t *ucontex=
t)<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0sigset_t blocked;<br>
=C2=A0 =C2=A0 =C2=A0target_sigset_t target_set;<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; TARGET_NSIG_WORDS; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__get_user(target_set.__bits[i], &amp;uco=
ntext-&gt;uc_sigmask.__bits[i]);<br>
@@ -839,7 +839,7 @@ badframe:<br>
<br>
=C2=A0void signal_init(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct sigaction act;<br>
=C2=A0 =C2=A0 =C2=A0struct sigaction oact;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
@@ -878,7 +878,7 @@ static void handle_pending_signal(CPUArchState *env, in=
t sig,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct emulated_sigtabl=
e *k)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct target_sigaction *sa;<br>
=C2=A0 =C2=A0 =C2=A0int code;<br>
=C2=A0 =C2=A0 =C2=A0sigset_t set;<br>
@@ -967,7 +967,7 @@ void process_pending_signals(CPUArchState *env)<br>
=C2=A0 =C2=A0 =C2=A0int sig;<br>
=C2=A0 =C2=A0 =C2=A0sigset_t *blocked_set, set;<br>
=C2=A0 =C2=A0 =C2=A0struct emulated_sigtable *k;<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (qatomic_read(&amp;ts-&gt;signal_pending)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigfillset(&amp;set);<br>
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c<br>
index b7d4c37cd81..6646684a4c6 100644<br>
--- a/gdbstub/user-target.c<br>
+++ b/gdbstub/user-target.c<br>
@@ -204,7 +204,7 @@ int gdb_target_signal_to_gdb(int sig)<br>
<br>
=C2=A0int gdb_get_cpu_index(CPUState *cpu)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *) cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0return ts ? ts-&gt;ts_tid : -1;<br>
=C2=A0}<br>
<br>
@@ -399,7 +399,7 @@ void gdb_handle_query_xfer_exec_file(GArray *params, vo=
id *user_ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0if (!ts || !ts-&gt;bprm || !ts-&gt;bprm-&gt;filename) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_put_packet(&quot;E00&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h<br>
index 27b71cdbd8e..aa075f4d5cd 100644<br>
--- a/include/user/safe-syscall.h<br>
+++ b/include/user/safe-syscall.h<br>
@@ -134,7 +134,7 @@ extern char safe_syscall_start[];<br>
=C2=A0extern char safe_syscall_end[];<br>
<br>
=C2=A0#define safe_syscall(...)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 safe_syscall_base(&amp;((TaskState *)thread_cpu-&gt;opaque)-=
&gt;signal_pending, \<br>
+=C2=A0 =C2=A0 safe_syscall_base(&amp;get_task_state(thread_cpu)-&gt;signal=
_pending,=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__VA_ARGS__)<br>
<br>
=C2=A0#endif<br>
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c<=
br>
index 8c20dc8a39a..71cdc8be50c 100644<br>
--- a/linux-user/aarch64/cpu_loop.c<br>
+++ b/linux-user/aarch64/cpu_loop.c<br>
@@ -189,7 +189,7 @@ void target_cpu_copy_regs(CPUArchState *env, struct tar=
get_pt_regs *regs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ARMCPU *cpu =3D env_archcpu(env);<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
=C2=A0 =C2=A0 =C2=A0struct image_info *info =3D ts-&gt;info;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c<br>
index b404117ff30..db1a41e27f4 100644<br>
--- a/linux-user/arm/cpu_loop.c<br>
+++ b/linux-user/arm/cpu_loop.c<br>
@@ -263,7 +263,7 @@ static bool insn_is_linux_bkpt(uint32_t opcode, bool is=
_thumb)<br>
<br>
=C2=A0static bool emulate_arm_fpa11(CPUARMState *env, uint32_t opcode)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D env_cpu(env)-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(env_cpu(env));<br>
=C2=A0 =C2=A0 =C2=A0int rc =3D EmulateAll(opcode, &amp;ts-&gt;fpa, env);<br=
>
=C2=A0 =C2=A0 =C2=A0int raise, enabled;<br>
<br>
@@ -514,7 +514,7 @@ void cpu_loop(CPUARMState *env)<br>
=C2=A0void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *r=
egs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct image_info *info =3D ts-&gt;info;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c<br>
index f77f692c63f..59806335f5b 100644<br>
--- a/linux-user/arm/signal.c<br>
+++ b/linux-user/arm/signal.c<br>
@@ -177,7 +177,7 @@ setup_return(CPUARMState *env, struct target_sigaction =
*ka, int usig,<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong handler =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong handler_fdpic_GOT =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong retcode;<br>
-=C2=A0 =C2=A0 bool is_fdpic =3D info_is_fdpic(((TaskState *)thread_cpu-&gt=
;opaque)-&gt;info);<br>
+=C2=A0 =C2=A0 bool is_fdpic =3D info_is_fdpic(get_task_state(thread_cpu)-&=
gt;info);<br>
=C2=A0 =C2=A0 =C2=A0bool is_rt =3D ka-&gt;sa_flags &amp; TARGET_SA_SIGINFO;=
<br>
=C2=A0 =C2=A0 =C2=A0bool thumb;<br>
<br>
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c<br>
index 01e6ff16fc9..04c9086b6dc 100644<br>
--- a/linux-user/cris/cpu_loop.c<br>
+++ b/linux-user/cris/cpu_loop.c<br>
@@ -72,7 +72,7 @@ void cpu_loop(CPUCRISState *env)<br>
=C2=A0void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *r=
egs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct image_info *info =3D ts-&gt;info;<br>
<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;regs[0] =3D regs-&gt;r0;<br>
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index b8eef893d0c..6de72da585d 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -4499,7 +4499,7 @@ static int write_note(struct memelfnote *men, int fd)=
<br>
=C2=A0static void fill_thread_info(struct elf_note_info *info, const CPUArc=
hState *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu((CPUArchState *)env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct elf_thread_status *ets;<br>
<br>
=C2=A0 =C2=A0 =C2=A0ets =3D g_malloc0(sizeof (*ets));<br>
@@ -4529,7 +4529,7 @@ static int fill_note_info(struct elf_note_info *info,=
<br>
=C2=A0{<br>
=C2=A0#define NUMNOTES 3<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu((CPUArchState *)env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;notes =3D g_new0(struct memelfnote, NUMNOTES);=
<br>
@@ -4653,7 +4653,7 @@ static int write_note_info(struct elf_note_info *info=
, int fd)<br>
=C2=A0static int elf_core_dump(int signr, const CPUArchState *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const CPUState *cpu =3D env_cpu((CPUArchState *)env);<b=
r>
-=C2=A0 =C2=A0 const TaskState *ts =3D (const TaskState *)cpu-&gt;opaque;<b=
r>
+=C2=A0 =C2=A0 const TaskState *ts =3D (const TaskState *)get_task_state((C=
PUState *)cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct vm_area_struct *vma =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *corefile =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0struct elf_note_info info;<br>
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c<br>
index d08a97dae61..c84557e906a 100644<br>
--- a/linux-user/hppa/signal.c<br>
+++ b/linux-user/hppa/signal.c<br>
@@ -112,7 +112,7 @@ void setup_rt_frame(int sig, struct target_sigaction *k=
a,<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong frame_addr, sp, haddr;<br>
=C2=A0 =C2=A0 =C2=A0struct target_rt_sigframe *frame;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0sp =3D get_sp_from_cpustate(env);<br>
=C2=A0 =C2=A0 =C2=A0if ((ka-&gt;sa_flags &amp; TARGET_SA_ONSTACK) &amp;&amp=
; !sas_ss_flags(sp)) {<br>
diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c<br>
index 4a794f8cea1..37f132be4af 100644<br>
--- a/linux-user/linuxload.c<br>
+++ b/linux-user/linuxload.c<br>
@@ -89,7 +89,7 @@ static int prepare_binprm(struct linux_binprm *bprm)<br>
=C2=A0abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong stringp, int push_ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0int n =3D sizeof(abi_ulong);<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong envp;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong argv;<br>
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c<br>
index caead1cb741..f79b8e4ab05 100644<br>
--- a/linux-user/m68k/cpu_loop.c<br>
+++ b/linux-user/m68k/cpu_loop.c<br>
@@ -95,7 +95,7 @@ void cpu_loop(CPUM68KState *env)<br>
=C2=A0void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *r=
egs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct image_info *info =3D ts-&gt;info;<br>
<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;pc =3D regs-&gt;pc;<br>
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h<br=
>
index c3f288dfe83..4b40c09a8d6 100644<br>
--- a/linux-user/m68k/target_cpu.h<br>
+++ b/linux-user/m68k/target_cpu.h<br>
@@ -37,7 +37,7 @@ static inline void cpu_clone_regs_parent(CPUM68KState *en=
v, unsigned flags)<br>
=C2=A0static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls=
)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ts-&gt;tp_value =3D newtls;<br>
=C2=A0}<br>
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c<br>
index 990b03e727b..462387a0737 100644<br>
--- a/linux-user/mips/cpu_loop.c<br>
+++ b/linux-user/mips/cpu_loop.c<br>
@@ -214,7 +214,7 @@ done_syscall:<br>
=C2=A0void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *r=
egs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct image_info *info =3D ts-&gt;info;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c<br>
index 7e7302823b0..c232424c1e8 100644<br>
--- a/linux-user/ppc/signal.c<br>
+++ b/linux-user/ppc/signal.c<br>
@@ -486,7 +486,7 @@ void setup_rt_frame(int sig, struct target_sigaction *k=
a,<br>
=C2=A0 =C2=A0 =C2=A0int i, err =3D 0;<br>
=C2=A0#if defined(TARGET_PPC64)<br>
=C2=A0 =C2=A0 =C2=A0struct target_sigcontext *sc =3D 0;<br>
-=C2=A0 =C2=A0 struct image_info *image =3D ((TaskState *)thread_cpu-&gt;op=
aque)-&gt;info;<br>
+=C2=A0 =C2=A0 struct image_info *image =3D get_task_state(thread_cpu)-&gt;=
info;<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0rt_sf_addr =3D get_sigframe(ka, env, sizeof(*rt_sf));<b=
r>
@@ -673,7 +673,7 @@ abi_long do_swapcontext(CPUArchState *env, abi_ulong uo=
ld_ctx,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (uold_ctx) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;=
opaque;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!lock_user_struct(VERIFY_WRITE, uctx,=
 uold_ctx, 1)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EFAULT;<br>
diff --git a/linux-user/qemu.h b/linux-user/qemu.h<br>
index 4de9ec783f6..32cd43d9eff 100644<br>
--- a/linux-user/qemu.h<br>
+++ b/linux-user/qemu.h<br>
@@ -162,6 +162,11 @@ typedef struct TaskState {<br>
=C2=A0 =C2=A0 =C2=A0uint64_t start_boottime;<br>
=C2=A0} TaskState;<br>
<br>
+static inline TaskState *get_task_state(CPUState *cs)<br>
+{<br>
+=C2=A0 =C2=A0 return cs-&gt;opaque;<br>
+}<br>
+<br>
=C2=A0abi_long do_brk(abi_ulong new_brk);<br>
=C2=A0int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pat=
hname,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int flags, mode_t mode, bool safe);<br>
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c<br>
index bffca7db127..52c49c2e426 100644<br>
--- a/linux-user/riscv/cpu_loop.c<br>
+++ b/linux-user/riscv/cpu_loop.c<br>
@@ -97,7 +97,7 @@ void cpu_loop(CPURISCVState *env)<br>
=C2=A0void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *r=
egs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct image_info *info =3D ts-&gt;info;<br>
<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;pc =3D regs-&gt;sepc;<br>
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h<br>
index 3e2dc604c2f..a7df12fc445 100644<br>
--- a/linux-user/signal-common.h<br>
+++ b/linux-user/signal-common.h<br>
@@ -113,7 +113,7 @@ int process_sigsuspend_mask(sigset_t **pset, target_ulo=
ng sigset,<br>
=C2=A0static inline void finish_sigsuspend_mask(int ret)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (ret !=3D -QEMU_ERESTARTSYS) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;=
opaque;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ts-&gt;in_sigsuspend =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
diff --git a/linux-user/signal.c b/linux-user/signal.c<br>
index d3e62ab030f..cc7dd78e41f 100644<br>
--- a/linux-user/signal.c<br>
+++ b/linux-user/signal.c<br>
@@ -172,7 +172,7 @@ void target_to_host_old_sigset(sigset_t *sigset,<br>
<br>
=C2=A0int block_signals(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0sigset_t set;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* It&#39;s OK to block everything including SIGSEGV, b=
ecause we won&#39;t<br>
@@ -194,7 +194,7 @@ int block_signals(void)<br>
=C2=A0 */<br>
=C2=A0int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)<br=
>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (oldset) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*oldset =3D ts-&gt;signal_mask;<br>
@@ -237,7 +237,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset=
_t *oldset)<br>
=C2=A0 */<br>
=C2=A0void set_sigmask(const sigset_t *set)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ts-&gt;signal_mask =3D *set;<br>
=C2=A0}<br>
@@ -246,7 +246,7 @@ void set_sigmask(const sigset_t *set)<br>
<br>
=C2=A0int on_sig_stack(unsigned long sp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return (sp - ts-&gt;sigaltstack_used.ss_sp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt; ts-&gt;sigaltstack_use=
d.ss_size);<br>
@@ -254,7 +254,7 @@ int on_sig_stack(unsigned long sp)<br>
<br>
=C2=A0int sas_ss_flags(unsigned long sp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return (ts-&gt;sigaltstack_used.ss_size =3D=3D 0 ? SS_D=
ISABLE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: on_sig_stack(sp) ? SS_ONS=
TACK : 0);<br>
@@ -265,7 +265,7 @@ abi_ulong target_sigsp(abi_ulong sp, struct target_siga=
ction *ka)<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * This is the X/Open sanctioned signal stack switching=
.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if ((ka-&gt;sa_flags &amp; TARGET_SA_ONSTACK) &amp;&amp=
; !sas_ss_flags(sp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ts-&gt;sigaltstack_used.ss_sp + ts=
-&gt;sigaltstack_used.ss_size;<br>
@@ -275,7 +275,7 @@ abi_ulong target_sigsp(abi_ulong sp, struct target_siga=
ction *ka)<br>
<br>
=C2=A0void target_save_altstack(target_stack_t *uss, CPUArchState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0__put_user(ts-&gt;sigaltstack_used.ss_sp, &amp;uss-&gt;=
ss_sp);<br>
=C2=A0 =C2=A0 =C2=A0__put_user(sas_ss_flags(get_sp_from_cpustate(env)), &am=
p;uss-&gt;ss_flags);<br>
@@ -284,7 +284,7 @@ void target_save_altstack(target_stack_t *uss, CPUArchS=
tate *env)<br>
<br>
=C2=A0abi_long target_restore_altstack(target_stack_t *uss, CPUArchState *e=
nv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0size_t minstacksize =3D TARGET_MINSIGSTKSZ;<br>
=C2=A0 =C2=A0 =C2=A0target_stack_t ss;<br>
<br>
@@ -571,7 +571,7 @@ static void signal_table_init(void)<br>
<br>
=C2=A0void signal_init(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0struct sigaction act, oact;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* initialize signal conversion tables */<br>
@@ -730,7 +730,7 @@ static G_NORETURN<br>
=C2=A0void dump_core_and_abort(CPUArchState *env, int target_sig)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0int host_sig, core_dumped =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* On exit, undo the remapping of SIGABRT. */<br>
@@ -769,7 +769,7 @@ void queue_signal(CPUArchState *env, int sig, int si_ty=
pe,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=
_siginfo_t *info)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_user_queue_signal(env, sig);<br>
<br>
@@ -954,7 +954,7 @@ static void host_signal_handler(int host_sig, siginfo_t=
 *info, void *puc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D thread_cpu;<br>
=C2=A0 =C2=A0 =C2=A0CPUArchState *env =3D cpu_env(cpu);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0target_siginfo_t tinfo;<br>
=C2=A0 =C2=A0 =C2=A0host_sigcontext *uc =3D puc;<br>
=C2=A0 =C2=A0 =C2=A0struct emulated_sigtable *k;<br>
@@ -1174,7 +1174,7 @@ static void handle_pending_signal(CPUArchState *cpu_e=
nv, int sig,<br>
=C2=A0 =C2=A0 =C2=A0sigset_t set;<br>
=C2=A0 =C2=A0 =C2=A0target_sigset_t target_old_set;<br>
=C2=A0 =C2=A0 =C2=A0struct target_sigaction *sa;<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_user_handle_signal(cpu_env, sig);<br>
=C2=A0 =C2=A0 =C2=A0/* dequeue signal */<br>
@@ -1256,7 +1256,7 @@ void process_pending_signals(CPUArchState *cpu_env)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(cpu_env);<br>
=C2=A0 =C2=A0 =C2=A0int sig;<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0sigset_t set;<br>
=C2=A0 =C2=A0 =C2=A0sigset_t *blocked_set;<br>
<br>
@@ -1316,7 +1316,7 @@ void process_pending_signals(CPUArchState *cpu_env)<b=
r>
=C2=A0int process_sigsuspend_mask(sigset_t **pset, target_ulong sigset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong sigsize)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *)thread_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(thread_cpu);<br>
=C2=A0 =C2=A0 =C2=A0sigset_t *host_set =3D &amp;ts-&gt;sigsuspend_mask;<br>
=C2=A0 =C2=A0 =C2=A0target_sigset_t *target_sigset;<br>
<br>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index e384e142489..3e105488ee2 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -6515,7 +6515,7 @@ static void *clone_func(void *arg)<br>
=C2=A0 =C2=A0 =C2=A0env =3D info-&gt;env;<br>
=C2=A0 =C2=A0 =C2=A0cpu =3D env_cpu(env);<br>
=C2=A0 =C2=A0 =C2=A0thread_cpu =3D cpu;<br>
-=C2=A0 =C2=A0 ts =3D (TaskState *)cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;tid =3D sys_gettid();<br>
=C2=A0 =C2=A0 =C2=A0task_settid(ts);<br>
=C2=A0 =C2=A0 =C2=A0if (info-&gt;child_tidptr)<br>
@@ -6557,7 +6557,7 @@ static int do_fork(CPUArchState *env, unsigned int fl=
ags, abi_ulong newsp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags &amp;=3D ~(CLONE_VFORK | CLONE_VM);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (flags &amp; CLONE_VM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *parent_ts =3D (TaskState *)cpu-&gt;=
opaque;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *parent_ts =3D get_task_state(cpu);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_thread_info info;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_attr_t attr;<br>
<br>
@@ -6680,7 +6680,7 @@ static int do_fork(CPUArchState *env, unsigned int fl=
ags, abi_ulong newsp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0put_user_u32(=
sys_gettid(), child_tidptr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; CLONE_PAREN=
T_SETTID)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0put_user_u32(=
sys_gettid(), parent_tidptr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts =3D (TaskState *)cpu-&gt;opaq=
ue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; CLONE_SETTL=
S)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_set_tls (=
env, newtls);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; CLONE_CHILD=
_CLEARTID)<br>
@@ -7946,7 +7946,7 @@ int host_to_target_waitstatus(int status)<br>
=C2=A0static int open_self_cmdline(CPUArchState *cpu_env, int fd)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(cpu_env);<br>
-=C2=A0 =C2=A0 struct linux_binprm *bprm =3D ((TaskState *)cpu-&gt;opaque)-=
&gt;bprm;<br>
+=C2=A0 =C2=A0 struct linux_binprm *bprm =3D get_task_state(cpu)-&gt;bprm;<=
br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; bprm-&gt;argc; i++) {<br>
@@ -8130,7 +8130,7 @@ static int open_self_smaps(CPUArchState *cpu_env, int=
 fd)<br>
=C2=A0static int open_self_stat(CPUArchState *cpu_env, int fd)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(cpu_env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0g_autoptr(GString) buf =3D g_string_new(NULL);<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
@@ -8171,7 +8171,7 @@ static int open_self_stat(CPUArchState *cpu_env, int =
fd)<br>
=C2=A0static int open_self_auxv(CPUArchState *cpu_env, int fd)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu(cpu_env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong auxv =3D ts-&gt;info-&gt;saved_auxv;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong len =3D ts-&gt;info-&gt;auxv_len;<br>
=C2=A0 =C2=A0 =C2=A0char *ptr;<br>
@@ -8996,7 +8996,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, in=
t num, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_lock(&amp;clone_lock);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (CPU_NEXT(first_cpu)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state=
(cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ts-&gt;child_tidptr) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0put_user_u32(=
0, ts-&gt;child_tidptr);<br>
@@ -9423,7 +9423,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, in=
t num, abi_long arg1,<br>
=C2=A0#ifdef TARGET_NR_pause /* not on alpha */<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_NR_pause:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!block_signals()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sigsuspend(&amp;((TaskState *)cp=
u-&gt;opaque)-&gt;signal_mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sigsuspend(&amp;get_task_state(c=
pu)-&gt;signal_mask);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EINTR;<br>
=C2=A0#endif<br>
@@ -9989,7 +9989,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, in=
t num, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigset_t *set;<br>
<br>
=C2=A0#if defined(TARGET_ALPHA)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state=
(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* target_to_host_old_sigse=
t will bswap back */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong mask =3D tswapal(=
arg1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set =3D &amp;ts-&gt;sigsusp=
end_mask;<br>
@@ -10390,7 +10390,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, =
int num, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_NR_mprotect:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg1 =3D cpu_untagged_addr(cpu, arg1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state=
(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Special hack to detect l=
ibc making the stack executable.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((arg3 &amp; PROT_GROWSD=
OWN)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; ar=
g1 &gt;=3D ts-&gt;info-&gt;stack_limit<br>
@@ -12521,7 +12521,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, =
int num, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0return do_set_thread_area(cpu_env, arg1);<br>
=C2=A0#elif defined(TARGET_M68K)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ts-&gt;tp_value =3D arg1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -12535,7 +12535,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, =
int num, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return do_get_thread_area(cpu_env, arg1);=
<br>
=C2=A0#elif defined(TARGET_M68K)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state=
(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ts-&gt;tp_value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else<br>
@@ -12660,7 +12660,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, =
int num, abi_long arg1,<br>
=C2=A0#if defined(TARGET_NR_set_tid_address)<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_NR_set_tid_address:<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ts-&gt;child_tidptr =3D arg1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* do not call host set_tid_address() sys=
call, instead return tid() */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return get_errno(sys_gettid());<br>
diff --git a/linux-user/vm86.c b/linux-user/vm86.c<br>
index c2facf3fc2d..9f512a2242b 100644<br>
--- a/linux-user/vm86.c<br>
+++ b/linux-user/vm86.c<br>
@@ -74,7 +74,7 @@ static inline unsigned int vm_getl(CPUX86State *env,<br>
=C2=A0void save_v86_state(CPUX86State *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
=C2=A0 =C2=A0 =C2=A0struct target_vm86plus_struct * target_v86;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!lock_user_struct(VERIFY_WRITE, target_v86, ts-&gt;=
target_v86, 0))<br>
@@ -134,7 +134,7 @@ static inline void return_to_32bit(CPUX86State *env, in=
t retval)<br>
=C2=A0static inline int set_IF(CPUX86State *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ts-&gt;v86flags |=3D VIF_MASK;<br>
=C2=A0 =C2=A0 =C2=A0if (ts-&gt;v86flags &amp; VIP_MASK) {<br>
@@ -147,7 +147,7 @@ static inline int set_IF(CPUX86State *env)<br>
=C2=A0static inline void clear_IF(CPUX86State *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ts-&gt;v86flags &amp;=3D ~VIF_MASK;<br>
=C2=A0}<br>
@@ -165,7 +165,7 @@ static inline void clear_AC(CPUX86State *env)<br>
=C2=A0static inline int set_vflags_long(unsigned long eflags, CPUX86State *=
env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0set_flags(ts-&gt;v86flags, eflags, ts-&gt;v86mask);<br>
=C2=A0 =C2=A0 =C2=A0set_flags(env-&gt;eflags, eflags, SAFE_MASK);<br>
@@ -179,7 +179,7 @@ static inline int set_vflags_long(unsigned long eflags,=
 CPUX86State *env)<br>
=C2=A0static inline int set_vflags_short(unsigned short flags, CPUX86State =
*env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0set_flags(ts-&gt;v86flags, flags, ts-&gt;v86mask &amp; =
0xffff);<br>
=C2=A0 =C2=A0 =C2=A0set_flags(env-&gt;eflags, flags, SAFE_MASK);<br>
@@ -193,7 +193,7 @@ static inline int set_vflags_short(unsigned short flags=
, CPUX86State *env)<br>
=C2=A0static inline unsigned int get_vflags(CPUX86State *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
=C2=A0 =C2=A0 =C2=A0unsigned int flags;<br>
<br>
=C2=A0 =C2=A0 =C2=A0flags =3D env-&gt;eflags &amp; RETURN_MASK;<br>
@@ -210,7 +210,7 @@ static inline unsigned int get_vflags(CPUX86State *env)=
<br>
=C2=A0static void do_int(CPUX86State *env, int intno)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t int_addr, segoffs, ssp;<br>
=C2=A0 =C2=A0 =C2=A0unsigned int sp;<br>
<br>
@@ -269,7 +269,7 @@ void handle_vm86_trap(CPUX86State *env, int trapno)<br>
=C2=A0void handle_vm86_fault(CPUX86State *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t csp, ssp;<br>
=C2=A0 =C2=A0 =C2=A0unsigned int ip, sp, newflags, newip, newcs, opcode, in=
tno;<br>
=C2=A0 =C2=A0 =C2=A0int data32, pref_done;<br>
@@ -394,7 +394,7 @@ void handle_vm86_fault(CPUX86State *env)<br>
=C2=A0int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
=C2=A0 =C2=A0 =C2=A0struct target_vm86plus_struct * target_v86;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c<br>
index 32dcfa52291..003208a9161 100644<br>
--- a/linux-user/xtensa/signal.c<br>
+++ b/linux-user/xtensa/signal.c<br>
@@ -157,7 +157,7 @@ void setup_rt_frame(int sig, struct target_sigaction *k=
a,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong frame_addr;<br>
=C2=A0 =C2=A0 =C2=A0struct target_rt_sigframe *frame;<br>
-=C2=A0 =C2=A0 int is_fdpic =3D info_is_fdpic(((TaskState *)thread_cpu-&gt;=
opaque)-&gt;info);<br>
+=C2=A0 =C2=A0 int is_fdpic =3D info_is_fdpic(get_task_state(thread_cpu)-&g=
t;info);<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong handler =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong handler_fdpic_GOT =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t ra;<br>
diff --git a/plugins/api.c b/plugins/api.c<br>
index 5521b0ad36c..1d7b72c0f67 100644<br>
--- a/plugins/api.c<br>
+++ b/plugins/api.c<br>
@@ -392,7 +392,7 @@ const char *qemu_plugin_path_to_binary(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0char *path =3D NULL;<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *) current_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(current_cpu);<br>
=C2=A0 =C2=A0 =C2=A0path =3D g_strdup(ts-&gt;bprm-&gt;filename);<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0return path;<br>
@@ -402,7 +402,7 @@ uint64_t qemu_plugin_start_code(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t start =3D 0;<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *) current_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(current_cpu);<br>
=C2=A0 =C2=A0 =C2=A0start =3D ts-&gt;info-&gt;start_code;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0return start;<br>
@@ -412,7 +412,7 @@ uint64_t qemu_plugin_end_code(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t end =3D 0;<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *) current_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(current_cpu);<br>
=C2=A0 =C2=A0 =C2=A0end =3D ts-&gt;info-&gt;end_code;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0return end;<br>
@@ -422,7 +422,7 @@ uint64_t qemu_plugin_entry_code(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t entry =3D 0;<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
-=C2=A0 =C2=A0 TaskState *ts =3D (TaskState *) current_cpu-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(current_cpu);<br>
=C2=A0 =C2=A0 =C2=A0entry =3D ts-&gt;info-&gt;entry;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0return entry;<br>
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c<=
br>
index 329ea112607..d78c6428b90 100644<br>
--- a/semihosting/arm-compat-semi.c<br>
+++ b/semihosting/arm-compat-semi.c<br>
@@ -214,7 +214,7 @@ static target_ulong syscall_err;<br>
=C2=A0static inline uint32_t get_swi_errno(CPUState *cs)<br>
=C2=A0{<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
-=C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return ts-&gt;swi_errno;<br>
=C2=A0#else<br>
@@ -226,7 +226,7 @@ static void common_semi_cb(CPUState *cs, uint64_t ret, =
int err)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state(cs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ts-&gt;swi_errno =3D err;<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syscall_err =3D err;<br>
@@ -586,7 +586,7 @@ void do_common_semihosting(CPUState *cs)<br>
=C2=A0#if !defined(CONFIG_USER_ONLY)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *cmdline;<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state=
(cs);<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GET_ARG(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GET_ARG(1);<br>
@@ -664,7 +664,7 @@ void do_common_semihosting(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong retvals[4];<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D cs-&gt;opaque;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TaskState *ts =3D get_task_state=
(cs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong limit;<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LayoutInfo info =3D common_=
semi_find_bases(cs);<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div></div>

--00000000000091e9a10611bcf6e0--

