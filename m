Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2DCD5CCB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 14:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t69QW-0005mn-UD; Wed, 30 Oct 2024 10:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t69QU-0005mN-IP
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:11:58 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t69QS-0000uV-G2
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:11:58 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e605ffe10cso3968268b6e.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730297515; x=1730902315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XX6ApW+3Rv8d16BwBGHN6DHomWngpFJav7+/HRd9dYg=;
 b=eTuTMniiZSj1XhsVPDZsTW5BZ2EZfHTh42FFPr0jspqLNbAcRcEhQZkscyErMZ1xpr
 KkWCYdInStA4Xb8TI/QrxpBJ76slmD2T3N9q8ZiwdLC3/SbmEegTBm/UVXRJRQYjDaj3
 Fw3AZiLNYsv0/1b2Eqkc/ta6rJVbFToWJ7rHjJnPsIhrnLByETqCxKPokM11L7ffqtvq
 13v/AocBic1/XdYXvYqw6UJnjDofAj0TrkhUYnhaGNex7reruYpSLEKkIBWhQplK2wc2
 vqxSZOD1x9wUiexqlgLJUtFJTAjlKe5K9gpdrdKq1Utj0VmEI+xKWlffNdWHjV3Z6WqC
 Jx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730297515; x=1730902315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XX6ApW+3Rv8d16BwBGHN6DHomWngpFJav7+/HRd9dYg=;
 b=RaszN1qaTIE0bM8do6af3sKX3yq5eS35dXQ4XU4HR7uN6KoofGRbbYvrCsh0WvidRl
 ixXChQI+RJMX3C+0RwwAigbFWCac1GurnwQptX4bCURwf7zKt8WdxN2VPrDE9myQoIUd
 dsZeyd6NbzHSVleHx1fe8eIwfe09Hj4Aj9HmegChVimb8/pY5ikDAFqG/rlsBDgTcbxY
 wzBmL8FjdsXsvaogdVtK+G9bZ12zriBMSbYEti08nk8GT85vV7xxhFUjx0VThsCFeNPU
 EjNts/fU9kS8iy+Cf7zhp9QNzramw6Zu9miVxkV9pCukIDFSJzw2x2vgy2X9V6G4PywH
 wzAQ==
X-Gm-Message-State: AOJu0YxoaGQkMJHfqCzFohk3b/euW+7YQcRXi0qwry+FkSaagcuIUcXY
 YWpJkzyFBm9NcMjhryGFNTPy0W0MNPZ9KAG/NYZWj5CqhRvXVMzjniX5bsXR4BFpm+OhuDaJRij
 7HbTpPQvi/FFH3G0Sgi3N8rsuL7y9SvhO
X-Google-Smtp-Source: AGHT+IFkkOaaZceLKxlXqNJR38yjdYENk8VDQUa2cHcd0B1fKf3yhUYRh4v668C1vL+R/vaj0Q74bMtCUR59/ip0iy8=
X-Received: by 2002:a05:6808:2116:b0:3e6:14a6:4288 with SMTP id
 5614622812f47-3e63824716emr13476721b6e.11.1730297514812; Wed, 30 Oct 2024
 07:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
In-Reply-To: <20241030141037.375897-1-goldstein.w.n@gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 30 Oct 2024 09:11:42 -0500
Message-ID: <CAFUsyfJ4zTUPDeZrkjuc8sVKyjG0Qm1uH8+y+eKTPdcKU4=e2A@mail.gmail.com>
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Oct 30, 2024 at 9:10=E2=80=AFAM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
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
>
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> ---
>  linux-user/main.c                             | 21 ++++++
>  linux-user/syscall.c                          | 21 ++++--
>  linux-user/user-internals.h                   |  4 ++
>  tests/tcg/multiarch/Makefile.target           |  8 +++
>  .../linux/linux-execve-qemu-children.c        | 68 +++++++++++++++++++
>  5 files changed, 117 insertions(+), 5 deletions(-)
>  create mode 100644 tests/tcg/multiarch/linux/linux-execve-qemu-children.=
c
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8143a0d4b0..5e3d41dc2b 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
>  uintptr_t guest_base;
>  bool have_guest_base;
>
> +bool qemu_dup_for_children;
> +int qemu_argc;
> +char **qemu_argv;
> +
>  /*
>   * Used to implement backwards-compatibility for the `-strace`, and
>   * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten by
> @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
>      perf_enable_jitdump();
>  }
>
> +static void handle_arg_qemu_children(const char *arg)
> +{
> +    qemu_dup_for_children =3D true;
> +}
> +
>  static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
>
>  #ifdef CONFIG_PLUGIN
> @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =3D {
>       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
>      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
>       "",           "Generate a jit-${pid}.dump file for perf"},
> +    {"qemu-children",
> +                   "QEMU_CHILDREN",    false, handle_arg_qemu_children,
> +     "",           "Run child processes (created with execve) with qemu =
"
> +                   "(as instantiated for the parent)"},
>      {NULL, NULL, false, NULL, NULL, NULL}
>  };
>
> @@ -729,6 +742,14 @@ int main(int argc, char **argv, char **envp)
>
>      optind =3D parse_args(argc, argv);
>
> +    if (qemu_dup_for_children) {
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
> index 59b2080b98..96b105e9ce 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8550,13 +8550,14 @@ static int do_execv(CPUArchState *cpu_env, int di=
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
> +    bool through_qemu =3D dirfd =3D=3D AT_FDCWD && qemu_dup_for_children=
;
>
>      argc =3D 0;
>
> @@ -8580,10 +8581,12 @@ static int do_execv(CPUArchState *cpu_env, int di=
rfd,
>          envc++;
>      }
>
> -    argp =3D g_new0(char *, argc + 1);
> +    argp_offset =3D through_qemu ? qemu_argc : 0;
> +    argp =3D g_new0(char *, argc + argp_offset + 1);
>      envp =3D g_new0(char *, envc + 1);
>
> -    for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeof(abi_ulong), q=
++) {
> +    for (gp =3D guest_argp, q =3D argp + argp_offset;
> +         gp; gp +=3D sizeof(abi_ulong), q++) {
>          if (get_user_ual(addr, gp)) {
>              goto execve_efault;
>          }
> @@ -8628,9 +8631,16 @@ static int do_execv(CPUArchState *cpu_env, int dir=
fd,
>      }
>
>      const char *exe =3D p;
> -    if (is_proc_myself(p, "exe")) {
> +    if (through_qemu) {
> +        int i;
> +        for (i =3D 0; i < argp_offset; ++i) {
> +            argp[i] =3D qemu_argv[i];
> +        }
> +        exe =3D qemu_argv[0];
> +    } else if (is_proc_myself(p, "exe")) {
>          exe =3D exec_path;
>      }
> +
>      ret =3D is_execveat
>          ? safe_execveat(dirfd, exe, argp, envp, flags)
>          : safe_execve(exe, argp, envp);
> @@ -8644,7 +8654,8 @@ execve_efault:
>      ret =3D -TARGET_EFAULT;
>
>  execve_end:
> -    for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeof(abi_ulong), q=
++) {
> +    for (gp =3D guest_argp, q =3D argp + argp_offset;
> +         *q; gp +=3D sizeof(abi_ulong), q++) {
>          if (get_user_ual(addr, gp) || !addr) {
>              break;
>          }
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 46ffc093f4..ed3ed666a0 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -30,6 +30,10 @@ void stop_all_tasks(void);
>  extern const char *qemu_uname_release;
>  extern unsigned long mmap_min_addr;
>
> +extern bool qemu_dup_for_children;
> +extern int qemu_argc;
> +extern char **qemu_argv;
> +
>  typedef struct IOCTLEntry IOCTLEntry;
>
>  typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index 78b83d5575..0e220953e7 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -30,6 +30,14 @@ run-float_%: float_%
>         $(call conditional-diff-out,$<,$(SRC_PATH)/tests/tcg/$(TARGET_NAM=
E)/$<.ref)
>
>
> +run-linux-execve-qemu-children: linux-execve-qemu-children
> +       $(call run-test,$<, $(QEMU) $(QEMU_OPTS) -qemu-children $< $(QEMU=
) 0)
> +       $(call run-test,$<, $(QEMU) $(QEMU_OPTS) $< linux-execve 0 skip)
> +
> +run-plugin-linux-execve-qemu-children-with-%: linux-execve-qemu-children
> +       $(call run-test,$<, $(QEMU) $(QEMU_OPTS) -qemu-children $< $(QEMU=
) 0)
> +       $(call run-test,$<, $(QEMU) $(QEMU_OPTS) $< linux-execve 0 skip)
> +
>  testthread: LDFLAGS+=3D-lpthread
>
>  threadcount: LDFLAGS+=3D-lpthread
> diff --git a/tests/tcg/multiarch/linux/linux-execve-qemu-children.c b/tes=
ts/tcg/multiarch/linux/linux-execve-qemu-children.c
> new file mode 100644
> index 0000000000..60d6537666
> --- /dev/null
> +++ b/tests/tcg/multiarch/linux/linux-execve-qemu-children.c
> @@ -0,0 +1,68 @@
> +#include <assert.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <libgen.h>
> +#include <malloc.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#define MAX_COMM_SIZE (4096)
> +
> +int
> +main(int argc, char ** argv, char ** envp) {
> +    int          fd;
> +    char         next_arg[2];
> +    char *       buf;
> +    ssize_t      off;
> +    const char * expec_comm;
> +    assert(argc =3D=3D 3 || argc =3D=3D 4);
> +    fd =3D open("/proc/self/comm", O_RDONLY);
> +    assert(fd > 0);
> +
> +    buf =3D calloc(MAX_COMM_SIZE + 1, 1);
> +    assert(buf !=3D NULL);
> +
> +    off =3D 0;
> +    for (;;) {
> +        ssize_t res =3D read(fd, buf + off, 1);
> +        if (res < 0 && errno !=3D EAGAIN) {
> +            perror("Failed to read comm");
> +            return -1;
> +        }
> +        if (res =3D=3D 0) {
> +            break;
> +        }
> +
> +        off +=3D res;
> +
> +        if (off >=3D MAX_COMM_SIZE) {
> +            fprintf(stderr, "/proc/self/comm too large for test\n");
> +            return -1;
> +        }
> +    }
> +    assert(off && buf[off] =3D=3D '\0' && buf[off - 1] =3D=3D '\n');
> +    buf[off - 1] =3D '\0';
> +    expec_comm   =3D basename(argv[1]);
> +    if (argc =3D=3D 3 && strncmp(buf, expec_comm, strlen(expec_comm))) {
> +        fprintf(stderr,
> +                "Didn't propagate qemu settings\nComm:  '%s'\nExpec: '%s=
'\n",
> +                buf, expec_comm);
> +        return -1;
> +    }
> +    free(buf);
> +    next_arg[0] =3D argv[2][0];
> +    next_arg[1] =3D '\0';
> +    if (next_arg[0] =3D=3D '9') {
> +        return 0;
> +    }
> +    next_arg[0] +=3D 1;
> +    char * next_args[] =3D { argv[0], argv[1], next_arg, NULL };
> +    int    eres        =3D execve(argv[0], &next_args[0], envp);
> +    if (eres !=3D 0) {
> +        fprintf(stderr, "Unable to execve: %d/%d -> %s\n", eres, errno,
> +                strerror(errno));
> +        return -1;
> +    }
> +    return 0;
> +}
> --
> 2.43.0
>

Added test that tests both old behavior (no propagation of qemu)
and new behavior (propagation of qemu + cmdline).

Tested on Aarch64 + Linux with:
```
make check-tcg
```

