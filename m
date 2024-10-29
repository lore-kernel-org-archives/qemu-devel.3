Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B18D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o4L-0004k0-0O; Tue, 29 Oct 2024 11:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5o4J-0004je-6H
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:23:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5o4H-00012a-6I
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:23:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso53754305e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730215415; x=1730820215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg4b3iVoy8MmioaHEEOujuU524p+ZJARx4Au6CJKExg=;
 b=DjX4cx3NMTOEQSIkCz9XZmOI3P3b6MeERWy8E4PrUpe+WBYrC4K6pH3ysmGibMfiM0
 2CUZpWPc5vjyZVB2VZdnVip2tIdrRfHmywPngKHHXCipDpLt77T+/ZS6GSsGC6cWxfOw
 wTS0QtylVV6STe6xdHWzZIqyVuZUMXyZvsIA2piyt1iMgXcsLBiPK1ZJd81myh73Db6h
 xypBsxoKZmL+sPO3wtCArGU0/MVkf6f0ZYfZoq5HPP4K7uhJfwzPf0DcCY0EY31+Nia/
 2vz22tgZ70Gadld0QOMcRnhwGEIANw69lNJ69MNSsymRo0rpWmad0c3zcD5GFWdCoUs6
 dO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215415; x=1730820215;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pg4b3iVoy8MmioaHEEOujuU524p+ZJARx4Au6CJKExg=;
 b=cfWqFowsMqI0EA5f+ddWzRvQlQVjtsd4UXt02M6UTKJYyHHbTn9pckmliRuQnQSffu
 uq/dEUYkAnehNxOVU8Nn3u+Lwl62PY/yd7I8fc+ElYOg9TV9cvHyamtjnduObQkXkWKn
 BFrrfywptyNGfEVNv1nYhIyB8zhGr4BCHmzoMoIJaGiNIUHNnMJtU1KWsVgu0N3LEqTh
 DilrMypMMXy/W8LjmEGPjhoJToa2G85TXlFY9HKkVXeq/pKCsJU35/6VdKU3bKKZDVaK
 MwhcXvXSkYJhYe0vDJaywwaezOJsLRuXhkHY6sDXuXjtMCWn1uKCnnGp6IsStjvmXqyB
 c/pg==
X-Gm-Message-State: AOJu0YwoiCNI3IMSbvzx9GaxLpuRCl9ePp1wsIz2hvOlxaYXnf6pPjnG
 XXultEQp8v+0MExQqxlZ88Pk3liLZUou3NijLPwCq/gD1gk/xZyyZPSw+FoTyV8647269YvWDHq
 2
X-Google-Smtp-Source: AGHT+IEVBmnowZvtYLuocbXqePat0Oh1L0e/nxX3MDP4fNwN6VkuMysaV/nwkDocBwYDVLytX5pYAQ==
X-Received: by 2002:a05:600c:354c:b0:42f:7e87:3438 with SMTP id
 5b1f17b1804b1-4319ab8d515mr111251785e9.0.1730215415105; 
 Tue, 29 Oct 2024 08:23:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b58b510sm180352515e9.46.2024.10.29.08.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:23:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B8B365F860;
 Tue, 29 Oct 2024 15:23:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: qemu-devel@nongnu.org,  laurent@vivier.eu
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
In-Reply-To: <20240830223601.2796327-1-goldstein.w.n@gmail.com> (Noah
 Goldstein's message of "Fri, 30 Aug 2024 15:36:01 -0700")
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 29 Oct 2024 15:23:33 +0000
Message-ID: <87iktb6ih6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Noah Goldstein <goldstein.w.n@gmail.com> writes:

> The new option '-qemu-children' makes it so that on `execve` the child
> process will be launch by the same `qemu` executable that is currently
> running along with its current commandline arguments.
>
> The motivation for the change is to make it so that plugins running
> through `qemu` can continue to run on children.  Why not just
> `binfmt`?: Plugins can be desirable regardless of system/architecture
> emulation, and can sometimes be useful for elf files that can run
> natively. Enabling `binfmt` for all natively runnable elf files may
> not be desirable.

Broadly I don't see anything wrong with the patch. However my principle
concern is how test it. Currently nothing in check-tcg ensures this
mechanism works and stresses the argument copying.

>
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> ---
>  linux-user/main.c           | 22 ++++++++++++++++++++++
>  linux-user/syscall.c        | 20 +++++++++++++++-----
>  linux-user/user-internals.h |  4 ++++
>  3 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8143a0d4b0..dfb303a1f2 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
>  uintptr_t guest_base;
>  bool have_guest_base;
>=20=20
> +bool qemu_dup_for_children;
> +int qemu_argc;
> +char ** qemu_argv;
> +
>  /*
>   * Used to implement backwards-compatibility for the `-strace`, and
>   * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten by
> @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
>      perf_enable_jitdump();
>  }
>=20=20
> +static void handle_arg_qemu_children(const char *arg)
> +{
> +    qemu_dup_for_children =3D true;
> +}
> +
>  static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
>=20=20
>  #ifdef CONFIG_PLUGIN
> @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =3D {
>       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
>      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
>       "",           "Generate a jit-${pid}.dump file for perf"},
> +    {"qemu-children",
> +                   "QEMU_CHILDREN",    false, handle_arg_qemu_children,
> +     "",           "Run child processes (created with execve) with qemu "
> +                   "(as instantiated for the parent)"},
>      {NULL, NULL, false, NULL, NULL, NULL}
>  };
>=20=20
> @@ -729,6 +742,15 @@ int main(int argc, char **argv, char **envp)
>=20=20
>      optind =3D parse_args(argc, argv);
>=20=20
> +    if (qemu_dup_for_children) {
> +        int i;
> +        qemu_argc =3D optind;
> +        qemu_argv =3D g_new0(char *, qemu_argc);
> +        for (i =3D 0; i < optind; ++i) {
> +            qemu_argv[i] =3D strdup(argv[i]);
> +        }
> +    }
> +
>      qemu_set_log_filename_flags(last_log_filename,
>                                  last_log_mask | (enable_strace * LOG_STR=
ACE),
>                                  &error_fatal);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9d5415674d..732ef89054 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8459,13 +8459,14 @@ static int do_execv(CPUArchState *cpu_env, int di=
rfd,
>                      abi_long pathname, abi_long guest_argp,
>                      abi_long guest_envp, int flags, bool is_execveat)
>  {
> -    int ret;
> +    int ret, argp_offset;
>      char **argp, **envp;
>      int argc, envc;
>      abi_ulong gp;
>      abi_ulong addr;
>      char **q;
>      void *p;
> +    bool through_qemu =3D !is_execveat && qemu_dup_for_children;
>=20=20
>      argc =3D 0;
>=20=20
> @@ -8489,10 +8490,11 @@ static int do_execv(CPUArchState *cpu_env, int di=
rfd,
>          envc++;
>      }
>=20=20
> -    argp =3D g_new0(char *, argc + 1);
> +    argp_offset =3D through_qemu ? qemu_argc : 0;
> +    argp =3D g_new0(char *, argc + argp_offset + 1);
>      envp =3D g_new0(char *, envc + 1);
>=20=20
> -    for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeof(abi_ulong), q=
++) {
> +    for (gp =3D guest_argp, q =3D argp + argp_offset; gp; gp +=3D sizeof=
(abi_ulong), q++) {
>          if (get_user_ual(addr, gp)) {
>              goto execve_efault;
>          }
> @@ -8537,9 +8539,17 @@ static int do_execv(CPUArchState *cpu_env, int dir=
fd,
>      }
>=20=20
>      const char *exe =3D p;
> -    if (is_proc_myself(p, "exe")) {
> +    if (through_qemu) {
> +        int i;
> +        for (i =3D 0; i < argp_offset; ++i) {
> +            argp[i] =3D qemu_argv[i];
> +        }
> +        exe =3D qemu_argv[0];
> +    }
> +    else if (is_proc_myself(p, "exe")) {
>          exe =3D exec_path;
>      }
> +
>      ret =3D is_execveat
>          ? safe_execveat(dirfd, exe, argp, envp, flags)
>          : safe_execve(exe, argp, envp);
> @@ -8553,7 +8563,7 @@ execve_efault:
>      ret =3D -TARGET_EFAULT;
>=20=20
>  execve_end:
> -    for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeof(abi_ulong), q=
++) {
> +    for (gp =3D guest_argp, q =3D argp + argp_offset; *q; gp +=3D sizeof=
(abi_ulong), q++) {
>          if (get_user_ual(addr, gp) || !addr) {
>              break;
>          }
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 5c7f173ceb..0719e65ff4 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -30,6 +30,10 @@ void stop_all_tasks(void);
>  extern const char *qemu_uname_release;
>  extern unsigned long mmap_min_addr;
>=20=20
> +extern bool qemu_dup_for_children;
> +extern int qemu_argc;
> +extern char ** qemu_argv;
> +
>  typedef struct IOCTLEntry IOCTLEntry;
>=20=20
>  typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

