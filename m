Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CCCD40D0D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8THf-00046Z-Uw; Tue, 05 Nov 2024 18:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8THe-00046E-E8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:48:26 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8THY-0000Ww-6s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:48:26 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5ebbed44918so3564980eaf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730850498; x=1731455298; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zrihGIBxoAgDApMMSoW1g27Sc9UciTYxjqef5X71Nc=;
 b=kHs6xP6TcYPR35ZPEU9894c4vWP7dryWhOh9rUQ9ms+QU/NeBTjOdv+OB29azbaxbe
 /MBspfd5zgVw+6k+nKkJhQjMJPNLtTO7n4dS3fjaL1zIrReNlvUv8dwKRQuamQCNuW09
 qG2xRqUu8yVLGKNaSYUFW2U5eN/m7d+QoZhxqykkmyKZ/W7spat6NGJmHLkghHPfJvH9
 exKG0EHollCZl1xqiuAM/KLYOWN6YLXMxHG/kIcf99kAPhaMh0B6iRC39lZfJ2zEhhLB
 qCeEXGBtYBBU/udk/4qS79OaDfiKZIks4/9revLyLsg0ULEeWyGKG6y2RZ9CRLW7Hv28
 Wpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730850498; x=1731455298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zrihGIBxoAgDApMMSoW1g27Sc9UciTYxjqef5X71Nc=;
 b=r94IAuMHiFgy1D+yZPrcx8xVaTDbXR+vWt4aB9SSH53ilvrHGU7AMOXoWO+uFyNcDB
 6MkC/nW5og5cnAYe+kBjuaAeSrBDzujjIq32DUytONd338AHLP9ziK3SQxmzXZ+sJASu
 QLw1jx3/cWUxVOluKBUipzxDikNGAjjTXtMwcW+pImRj385Py6pJlb5r0a93FkStgyuK
 0tyEgasV00KNOxi/ITwMjphUrwZKhdUieRddHPPx16omiHY6xaMIgQ3ujpuM/ay9UdZg
 MWAl9UrtuJHZasMomgiAuTWYynHawY0db4uAMVOn/ZPBSsdcsnrls6+jaqkNYUMxwXQD
 5oXw==
X-Gm-Message-State: AOJu0Yze7qbBs7xRjI0G2gjKSNAXCD/sNN9nFrxFwuUvGVfft8yWzqP1
 TDPO1E3NrWZNfeU5paufzt6HVDxFJNJPiAQQjwawHzgachfMjMRbTJ9q0h4/SSOR1GmE/eZSgYO
 vC5u7RtCqD5N7tN3K/g4H/uxcO0E=
X-Google-Smtp-Source: AGHT+IFtFtc34WKlYfD4/Usd7XiMtCHg75TA6kTw5INHnQn0lCVie1wmk+BEVI79OMUk0olobzhdtOyhS7Z1omFhXtw=
X-Received: by 2002:a05:6820:541:b0:5e1:cd24:c19c with SMTP id
 006d021491bc7-5ec5e9adae1mr17616840eaf.0.1730850497802; Tue, 05 Nov 2024
 15:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
In-Reply-To: <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Tue, 5 Nov 2024 17:48:06 -0600
Message-ID: <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oo1-xc36.google.com
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

On Tue, Nov 5, 2024 at 5:37=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/30/24 14:10, Noah Goldstein wrote:
> > The new option '-qemu-children' makes it so that on `execve` the child
> > process will be launch by the same `qemu` executable that is currently
> > running along with its current commandline arguments.
> >
> > The motivation for the change is to make it so that plugins running
> > through `qemu` can continue to run on children.  Why not just
> > `binfmt`?: Plugins can be desirable regardless of system/architecture
> > emulation, and can sometimes be useful for elf files that can run
> > natively. Enabling `binfmt` for all natively runnable elf files may
> > not be desirable.
> >
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> > ---
> >   linux-user/main.c                             | 21 ++++++
> >   linux-user/syscall.c                          | 21 ++++--
> >   linux-user/user-internals.h                   |  4 ++
> >   tests/tcg/multiarch/Makefile.target           |  8 +++
> >   .../linux/linux-execve-qemu-children.c        | 68 ++++++++++++++++++=
+
> >   5 files changed, 117 insertions(+), 5 deletions(-)
> >   create mode 100644 tests/tcg/multiarch/linux/linux-execve-qemu-childr=
en.c
> >
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index 8143a0d4b0..5e3d41dc2b 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
> >   uintptr_t guest_base;
> >   bool have_guest_base;
> >
> > +bool qemu_dup_for_children;
> > +int qemu_argc;
> > +char **qemu_argv;
> > +
> >   /*
> >    * Used to implement backwards-compatibility for the `-strace`, and
> >    * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten=
 by
> > @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
> >       perf_enable_jitdump();
> >   }
> >
> > +static void handle_arg_qemu_children(const char *arg)
> > +{
> > +    qemu_dup_for_children =3D true;
> > +}
> > +
> >   static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
> >
> >   #ifdef CONFIG_PLUGIN
> > @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =3D =
{
> >        "",           "Generate a /tmp/perf-${pid}.map file for perf"},
> >       {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
> >        "",           "Generate a jit-${pid}.dump file for perf"},
> > +    {"qemu-children",
> > +                   "QEMU_CHILDREN",    false, handle_arg_qemu_children=
,
> > +     "",           "Run child processes (created with execve) with qem=
u "
> > +                   "(as instantiated for the parent)"},
> >       {NULL, NULL, false, NULL, NULL, NULL}
> >   };
> >
> > @@ -729,6 +742,14 @@ int main(int argc, char **argv, char **envp)
> >
> >       optind =3D parse_args(argc, argv);
> >
> > +    if (qemu_dup_for_children) {
> > +        qemu_argc =3D optind;
> > +        qemu_argv =3D g_new0(char *, qemu_argc);
> > +        for (i =3D 0; i < optind; ++i) {
> > +            qemu_argv[i] =3D strdup(argv[i]);
>
> g_strdup.
ack
>
> > +    bool through_qemu =3D dirfd =3D=3D AT_FDCWD && qemu_dup_for_childr=
en;
>
> Why is this limited to AT_FDCWD?  Why not for execvat too?
>

We could, initially it was because AFAICT qemu doesn't support executing a
program relative to another dir, but it would be simple enough to just join
the relative program path and path dirfd points to.

Want me to add support?
> > @@ -8628,9 +8631,16 @@ static int do_execv(CPUArchState *cpu_env, int d=
irfd,
> >       }
> >
> >       const char *exe =3D p;
> > -    if (is_proc_myself(p, "exe")) {
> > +    if (through_qemu) {
> > +        int i;
> > +        for (i =3D 0; i < argp_offset; ++i) {
> > +            argp[i] =3D qemu_argv[i];
> > +        }
> > +        exe =3D qemu_argv[0];
> > +    } else if (is_proc_myself(p, "exe")) {
> >           exe =3D exec_path;
> >       }
> > +
>
> You still need to handle is_proc_myself, for the guest binary.
>
> I wonder if those two cases are related.  Do we need to also add an argum=
ent so that we
> can pass the executable to the next qemu via file descriptor?  I.e. execv=
at becomes
>
>      f =3D openat()
>      execv(qemu, "-execfd", f)
>
> and is_proc_myself uses execfd, which we already have open.
>
>
> r~

