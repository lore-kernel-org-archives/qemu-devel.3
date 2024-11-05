Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACBDD40D0D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8TNp-0000Tx-0Y; Tue, 05 Nov 2024 18:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8TNn-0000RZ-FB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:54:47 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8TNl-0001HF-CU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:54:46 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5ebc0c05e25so3182357eaf.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730850883; x=1731455683; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlApHbkUoNyMyZ2Me0BBxP+jQnIJuGsjNHi1hN76nd0=;
 b=W6g5cJHZAf6WhV+r6gAE1Q6xhgv2nYESoWXczl2wBoZAYfb1fkrXDpqjcITHsosAfJ
 8HO+RiKz4iMRPikhRE6Kl92NNxqSUHniOiO9gubPeXsdGCymoMlzlvnycZHwY6/D74yr
 PAs3J7+IHYMSFK0KSi3FzlRlsSWM5kXtrG9NyDDnVTSNqzg8lq9Ue4m0ZZ0PeTAi7oM8
 jN/rZKT51/oZr94e/8lIak6FuMuM30AAro0d7SPWnviEeiO67yH4W5l7Ynr3RrCcdLpJ
 qKRdQsDvWZtDmxTv2UnzOpKhoUW3COGlzxygdZjvpoNPgW4PDDq4tpM5zfBwA/Xtbq09
 PIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730850883; x=1731455683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZlApHbkUoNyMyZ2Me0BBxP+jQnIJuGsjNHi1hN76nd0=;
 b=NOnLjJgPuJJJEOlXQKXo85X5sx7+34yrJILpAbuB6Jxt57nyOzUDrAlomGKMuDxbDn
 uraBIKPfb0nqBS+lJcGAGXCONAOWu00rkjxz01yTns7NfMD5gQ9pOn+UelaJ+r+J8WUF
 SSGYYnbECkTguMqrFTWzbHG6x0sf7/LGvWEeAMidXTrgjwKUy4RXi46Xo+44yVLQhHn2
 n4XvFixqc1/HdOiWNTYStxTtjq9UO8ynAL6Oxcwz+xP0M7mJpk6S5i0Fk8dlr1AoABwB
 KJYdJnj5Ymr21l6IAn6nsSN/OGsJ4bMrkZv3kq7VpEtVf28VvEfKhpNytr5EgpL4ijxx
 IiTQ==
X-Gm-Message-State: AOJu0YzqYt4sTB7yyXyAtp3nXdpK0uaF4e4B3PymefbpSefspiF7GdEr
 JK38rPS0FYxN7fkg2IH3vsYM9uraH+ulf/eOTG6PR5s8sJIqHsdaYkYlAlJf4aJsLkmmygb/q6Z
 k431wj2lRiWerslJn6eN5I76ES40=
X-Google-Smtp-Source: AGHT+IGKaYxF2/tdT6vxk6I0eR+DrOoBwLwL9kIFzEYayaCYt9PvYhcjBe8Py+J0lymYsYc3i9YStm0fL5+Xabuz9IA=
X-Received: by 2002:a05:6820:16a5:b0:5eb:b292:bb85 with SMTP id
 006d021491bc7-5ec23a890a8mr25557888eaf.6.1730850883634; Tue, 05 Nov 2024
 15:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
In-Reply-To: <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Tue, 5 Nov 2024 17:54:31 -0600
Message-ID: <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oo1-xc35.google.com
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

On Tue, Nov 5, 2024 at 5:48=E2=80=AFPM Noah Goldstein <goldstein.w.n@gmail.=
com> wrote:
>
> On Tue, Nov 5, 2024 at 5:37=E2=80=AFAM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 10/30/24 14:10, Noah Goldstein wrote:
> > > The new option '-qemu-children' makes it so that on `execve` the chil=
d
> > > process will be launch by the same `qemu` executable that is currentl=
y
> > > running along with its current commandline arguments.
> > >
> > > The motivation for the change is to make it so that plugins running
> > > through `qemu` can continue to run on children.  Why not just
> > > `binfmt`?: Plugins can be desirable regardless of system/architecture
> > > emulation, and can sometimes be useful for elf files that can run
> > > natively. Enabling `binfmt` for all natively runnable elf files may
> > > not be desirable.
> > >
> > > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> > > ---
> > >   linux-user/main.c                             | 21 ++++++
> > >   linux-user/syscall.c                          | 21 ++++--
> > >   linux-user/user-internals.h                   |  4 ++
> > >   tests/tcg/multiarch/Makefile.target           |  8 +++
> > >   .../linux/linux-execve-qemu-children.c        | 68 ++++++++++++++++=
+++
> > >   5 files changed, 117 insertions(+), 5 deletions(-)
> > >   create mode 100644 tests/tcg/multiarch/linux/linux-execve-qemu-chil=
dren.c
> > >
> > > diff --git a/linux-user/main.c b/linux-user/main.c
> > > index 8143a0d4b0..5e3d41dc2b 100644
> > > --- a/linux-user/main.c
> > > +++ b/linux-user/main.c
> > > @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
> > >   uintptr_t guest_base;
> > >   bool have_guest_base;
> > >
> > > +bool qemu_dup_for_children;
> > > +int qemu_argc;
> > > +char **qemu_argv;
> > > +
> > >   /*
> > >    * Used to implement backwards-compatibility for the `-strace`, and
> > >    * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritt=
en by
> > > @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
> > >       perf_enable_jitdump();
> > >   }
> > >
> > > +static void handle_arg_qemu_children(const char *arg)
> > > +{
> > > +    qemu_dup_for_children =3D true;
> > > +}
> > > +
> > >   static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
> > >
> > >   #ifdef CONFIG_PLUGIN
> > > @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =
=3D {
> > >        "",           "Generate a /tmp/perf-${pid}.map file for perf"}=
,
> > >       {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
> > >        "",           "Generate a jit-${pid}.dump file for perf"},
> > > +    {"qemu-children",
> > > +                   "QEMU_CHILDREN",    false, handle_arg_qemu_childr=
en,
> > > +     "",           "Run child processes (created with execve) with q=
emu "
> > > +                   "(as instantiated for the parent)"},
> > >       {NULL, NULL, false, NULL, NULL, NULL}
> > >   };
> > >
> > > @@ -729,6 +742,14 @@ int main(int argc, char **argv, char **envp)
> > >
> > >       optind =3D parse_args(argc, argv);
> > >
> > > +    if (qemu_dup_for_children) {
> > > +        qemu_argc =3D optind;
> > > +        qemu_argv =3D g_new0(char *, qemu_argc);
> > > +        for (i =3D 0; i < optind; ++i) {
> > > +            qemu_argv[i] =3D strdup(argv[i]);
> >
> > g_strdup.
> ack
> >
> > > +    bool through_qemu =3D dirfd =3D=3D AT_FDCWD && qemu_dup_for_chil=
dren;
> >
> > Why is this limited to AT_FDCWD?  Why not for execvat too?
> >
>
> We could, initially it was because AFAICT qemu doesn't support executing =
a
> program relative to another dir, but it would be simple enough to just jo=
in
> the relative program path and path dirfd points to.
>
> Want me to add support?
> > > @@ -8628,9 +8631,16 @@ static int do_execv(CPUArchState *cpu_env, int=
 dirfd,
> > >       }
> > >
> > >       const char *exe =3D p;
> > > -    if (is_proc_myself(p, "exe")) {
> > > +    if (through_qemu) {
> > > +        int i;
> > > +        for (i =3D 0; i < argp_offset; ++i) {
> > > +            argp[i] =3D qemu_argv[i];
> > > +        }
> > > +        exe =3D qemu_argv[0];
> > > +    } else if (is_proc_myself(p, "exe")) {
> > >           exe =3D exec_path;
> > >       }
> > > +
> >
> > You still need to handle is_proc_myself, for the guest binary.

Would this by handled by basically do:

```
if (is_proc_myself(p, "exe")) {
        exe =3D exec_path;
        if (through_qemu)
            argp[argp_offset] =3D exec_path;
}
```
Or am I missing something?

> >
> > I wonder if those two cases are related.  Do we need to also add an arg=
ument so that we
> > can pass the executable to the next qemu via file descriptor?  I.e. exe=
cvat becomes
> >
> >      f =3D openat()
> >      execv(qemu, "-execfd", f)
> >
> > and is_proc_myself uses execfd, which we already have open.

How does passing a fd from one process to another work?

> >
> >
> > r~

