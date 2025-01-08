Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E34E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVZjp-00088n-7L; Wed, 08 Jan 2025 12:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVZjm-00088A-UF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:20:58 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVZjk-0005QE-QZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:20:58 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso25346730a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736356855; x=1736961655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbpkaucunY4b+fTUw/PaFTglC8a/K9MkTNBBUqfX5DM=;
 b=NNby8SgbUJOvrQugnH+34Tw53g6WImgZdQQG1SnoJpILEdeCASquUN6JJ4mc7bybZY
 4N2KH5hDNoNddXatLXZPfyRIcsLV0P+FbQRNqUITOJ39RvwxJzC9Qgvozi9C0xCJRlVW
 /cJ+b9NEgytwGHI7XINXCAFpH9BIjiCUtoTTT9wiwfYZR6DdpXjQQUl3jjNgy7wzjr3K
 e+rapILtLutTSRG+qVeNDos3gF5yZsCCxBLmVfjt0X9K0TIEXBh9/clA4EpRdm0BVYl2
 H9+Io9fQWyER08oNxSDOv6nUTTIajQdKkYKJK2BrR+svDqib0Sv+TvbPpplfj3DImYYM
 zuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736356855; x=1736961655;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AbpkaucunY4b+fTUw/PaFTglC8a/K9MkTNBBUqfX5DM=;
 b=ZnKQqTKhikaGnoc6KpkZY+CZnaVuAF26FgWfKDRjEfDsdzv5n9sNOt1iE369dj518a
 UGgHryocJIVQGH0eF7DeLZYDZzunRQsbnKr3hXh8bzGORydY4NcBk/4wN6Clz8ysN8i9
 l8onPF5kKdw9Htbz+6ZnX/5+f5MOU6AwueRYUhtR7a7YCEfbM6GF+VD1+C260t2p7PCf
 hQfcq8IC4PYvdtSuKcrjVHoslf41heSNBlbQFuH2l68CSZ5pg66vdyiG1VH6esykVYEw
 +N5wNTDAEK9C3VJv4rnq9O+cRLv75A8YfeyQlqCeb5fgxZGZOt7BXmFZGbTM5A8AaEMn
 Blfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF+nJsjMXc/AMEfBS1VwLSpzV0bA8Ckc9g+2+dAPqL4zNNYRFRiA2k7yMPli6/nQraKCDhtnWV00Ts@nongnu.org
X-Gm-Message-State: AOJu0YxW2NspV/u/CgfeqfGlYc2z+XJkn/hktSlyLBjJ7NGgOlDiW23L
 3LmEw3jypKD0RcHGa+r76O/qPdgO0drbvEO9V4s4f2uhBXrW/0lwgzijsAzAtLqRyKHkCv1xw9z
 Wf0k=
X-Gm-Gg: ASbGncugUKeKCLDKOj4N/pGMOavcZTbkGaGnEv+Gfkenl6XZAJZfwczQ6aTZqrGmwim
 vUD1HPOF0xrYB+WMDc/aasWP9/GEk4d+fUOe8n/Ub2A0vt7HXXPBKTz584/PRuVHb25ydSxNyZg
 4rextrndoXtQhcuXWasUUPIuML21+JhDWQNnxpmzeycpvJNsfoLzeqmphboKAETxYaYu9voY/V1
 rJGxqTsyIleJL3s21kOefcBOkOBvVN8uuYCGE2W79tAJQJfLWHxdTk=
X-Google-Smtp-Source: AGHT+IFL+BjT0FRXuCTfzyT+AoPU4q7GNpVjLrUaqUaXL3uPBC09ZE3UytKAWMS4ZFrP2qVuQeOpoA==
X-Received: by 2002:a05:6402:5251:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5d972e63ddfmr7252635a12.23.1736356854957; 
 Wed, 08 Jan 2025 09:20:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82f2fasm2508243866b.9.2025.01.08.09.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 09:20:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 762235F8AC;
 Wed,  8 Jan 2025 17:20:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 6/8] gdbstub: Allow late attachment
In-Reply-To: <20241216123412.77450-7-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Mon, 16 Dec 2024 13:33:24 +0100")
References: <20241216123412.77450-1-iii@linux.ibm.com>
 <20241216123412.77450-7-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 08 Jan 2025 17:20:52 +0000
Message-ID: <87tta99q8b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Allow debugging individual processes in multi-process applications by
> starting them with export QEMU_GDB=3D/tmp/qemu-%d.sock,suspend=3Dn.
> Currently one would have to attach to every process to ensure the app
> makes progress.
>
> In case suspend=3Dn is not specified, the flow remains unchanged. If it
> is specified, then accepting the client connection is delegated to a
> thread. In the future this machinery may be reused for handling
> reconnections and interruptions.
>
> On accepting a connection, the thread schedules gdb_handlesig() on the
> first CPU and wakes it up with host_interrupt_signal. Note that the
> result of this gdb_handlesig() invocation is handled, as opposed to
> many other existing call sites. These other call sites probably need to
> be fixed separately.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  bsd-user/main.c   |   1 -
>  gdbstub/user.c    | 120 ++++++++++++++++++++++++++++++++++++++++++----
>  linux-user/main.c |   1 -
>  3 files changed, 110 insertions(+), 12 deletions(-)
>
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 61ca73c4781..ca4773a3f40 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -628,7 +628,6 @@ int main(int argc, char **argv)
>=20=20
>      if (gdbstub) {
>          gdbserver_start(gdbstub);
> -        gdb_handlesig(cpu, 0, NULL, NULL, 0);
>      }
>      cpu_loop(env);
>      /* never exits */
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index c900d0a52fe..6ada0d687b9 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -10,6 +10,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include <sys/syscall.h>

Whats this needed for? I can build without it.

>  #include "qemu/bitops.h"
>  #include "qemu/cutils.h"
>  #include "qemu/sockets.h"
> @@ -21,6 +22,7 @@
>  #include "gdbstub/user.h"
>  #include "gdbstub/enums.h"
>  #include "hw/core/cpu.h"
> +#include "user/signal.h"
>  #include "trace.h"
>  #include "internals.h"
>=20=20
> @@ -416,11 +418,101 @@ static int gdbserver_open_port(int port)
>      return fd;
>  }
>=20=20
> -int gdbserver_start(const char *port_or_path)
> +static bool gdbserver_accept(int port, int gdb_fd, const char *port_or_p=
ath)
>  {
> -    int port =3D g_ascii_strtoull(port_or_path, NULL, 10);
> +    bool ret;
> +
> +    if (port > 0) {
> +        ret =3D gdb_accept_tcp(gdb_fd);
> +    } else {
> +        ret =3D gdb_accept_socket(gdb_fd);
> +        if (ret) {
> +            gdbserver_user_state.socket_path =3D g_strdup(port_or_path);
> +        }
> +    }
> +
> +    if (!ret) {
> +        close(gdb_fd);
> +    }
> +
> +    return ret;
> +}

Is the clean-up worth it here for the extra level of indirection. Is the
string even port_or_path at this point because if it was a port the int
port > 0?

> +
> +struct {
> +    int port;
>      int gdb_fd;
> +    char *port_or_path;
> +} gdbserver_args;
> +
> +static void do_gdb_handlesig(CPUState *cs, run_on_cpu_data arg)
> +{
> +    int sig;
> +
> +    sig =3D target_to_host_signal(gdb_handlesig(cs, 0, NULL, NULL, 0));
> +    if (sig >=3D 1 && sig < NSIG) {
> +        qemu_kill_thread(gdb_get_cpu_index(cs), sig);
> +    }
> +}
> +
> +static void *gdbserver_accept_thread(void *arg)
> +{
> +    if (gdbserver_accept(gdbserver_args.port, gdbserver_args.gdb_fd,
> +                         gdbserver_args.port_or_path)) {
> +        CPUState *cs =3D first_cpu;
> +
> +        async_safe_run_on_cpu(cs, do_gdb_handlesig, RUN_ON_CPU_NULL);
> +        qemu_kill_thread(gdb_get_cpu_index(cs), host_interrupt_signal);
> +    }
> +
> +    g_free(gdbserver_args.port_or_path);

Should we set gdbserver_args.port_or_path =3D NULL here to avoid trying to
reference or free it again?

> +
> +    return NULL;
> +}
> +
> +__attribute__((__format__(__printf__, 1, 2)))
> +static void print_usage(const char *format, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, format);
> +    vfprintf(stderr, format, ap);
> +    va_end(ap);
> +    fprintf(stderr, "Usage: -g {port|path}[,suspend=3D{y|n}]\n");
> +}
> +
> +#define SUSPEND "suspend=3D"
> +
> +int gdbserver_start(const char *args)
> +{
> +    g_auto(GStrv) argv =3D g_strsplit(args, ",", 0);
> +    const char *port_or_path =3D NULL;
> +    bool suspend =3D true;
> +    int gdb_fd, port;
> +    GStrv arg;
>=20=20
> +    for (arg =3D argv; *arg; arg++) {
> +        if (g_str_has_prefix(*arg, SUSPEND)) {
> +            const char *val =3D *arg + strlen(SUSPEND);
> +
> +            suspend =3D (strcmp(val, "y") =3D=3D 0);
> +            if (!suspend && (strcmp(val, "n") !=3D 0)) {
> +                print_usage("Bad option value: %s", *arg);
> +                return -1;
> +            }
> +        } else {
> +            if (port_or_path) {
> +                print_usage("Unknown option: %s", *arg);
> +                return -1;
> +            }
> +            port_or_path =3D *arg;
> +        }
> +    }

We have some useful utility functions to parsing all the bools,
something like:

    for (arg =3D argv; *arg; arg++) {
        g_auto(GStrv) tokens =3D g_strsplit(*arg, "=3D", 2);
        if (g_strcmp0(tokens[0], "suspend") =3D=3D 0 && tokens[1]) {
            qapi_bool_parse(tokens[0], tokens[1], &suspend, &error_fatal);
        } else {
            if (port_or_path) {
                print_usage("Unknown option: %s", *arg);
                return -1;
            }
            port_or_path =3D *arg;
        }
    }

which also avoids the #define and strlen messing about as well.

(side note to no one in particular: should qapi_bool_parse being using g_st=
rcmp0()?)

> +    if (!port_or_path) {
> +        print_usage("Port or path not specified");
> +        return -1;
> +    }
> +
> +    port =3D g_ascii_strtoull(port_or_path, NULL, 10);
>      if (port > 0) {
>          gdb_fd =3D gdbserver_open_port(port);
>      } else {
> @@ -431,16 +523,24 @@ int gdbserver_start(const char *port_or_path)
>          return -1;
>      }
>=20=20
> -    if (port > 0 && gdb_accept_tcp(gdb_fd)) {
> -        return 0;
> -    } else if (gdb_accept_socket(gdb_fd)) {
> -        gdbserver_user_state.socket_path =3D g_strdup(port_or_path);
> +    if (suspend) {
> +        if (gdbserver_accept(port, gdb_fd, port_or_path)) {
> +            gdb_handlesig(first_cpu, 0, NULL, NULL, 0);
> +            return 0;
> +        } else {
> +            return -1;
> +        }
> +    } else {
> +        QemuThread thread;
> +
> +        gdbserver_args.port =3D port;
> +        gdbserver_args.gdb_fd =3D gdb_fd;
> +        gdbserver_args.port_or_path =3D g_strdup(port_or_path);
> +        qemu_thread_create(&thread, "gdb-accept",
> +                           &gdbserver_accept_thread, NULL,
> +                           QEMU_THREAD_DETACHED);
>          return 0;
>      }
> -
> -    /* gone wrong */
> -    close(gdb_fd);
> -    return -1;
>  }

Not a problem with this patch in particular but it seems to me
gdbserver_start should probably look like:

  bool gdbserver_start(const char *args, Error **errp)

so we can do the right thing when starting from the command line or via
HMP. I'll see if I can clean that up on gdbstub/next.

>=20=20
>  void gdbserver_fork_start(void)
> diff --git a/linux-user/main.c b/linux-user/main.c
> index b09af8d4365..97245ab37c2 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -1027,7 +1027,6 @@ int main(int argc, char **argv, char **envp)
>                      gdbstub);
>              exit(EXIT_FAILURE);
>          }
> -        gdb_handlesig(cpu, 0, NULL, NULL, 0);
>      }
>=20=20
>  #ifdef CONFIG_SEMIHOSTING

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

