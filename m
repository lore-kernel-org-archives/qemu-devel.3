Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4849CF6D2D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzzM-00033Q-73; Wed, 02 Oct 2024 10:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1svzzL-00033I-3I
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:05:59 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1svzzI-0004m7-Ei
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:05:58 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e0402a98caso2965361b6e.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727877954; x=1728482754; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fPETYREPVlOaeaFcRvTR3AWKMvuqWUYxAsAe7KWjxf0=;
 b=cmqh7TLBXTmzhLhqwbiF8hKSC89zuEG1tA3PoNaSE2+qtnimkm5TGro0cJF/xPHdqu
 pNo9qlIG+adiitPQq5WXBPsQB631yfei+KoV9N82mcnycxep/AM0qCBEtxGKTGJhAexm
 CaSqzHFSQBv3cxwHy46KzI7vPTV3Mq//zsPy12iGRcOW0DFYuqUuNFhokixwFB1XN2Rz
 GEy7pJWRkXKSLhXZgq6/jkPOvMgcnvMbN7Urk4P6SiRyoUQ6V6hPv+wyQnokFstARoiN
 Fjgs6yFtGrZ9zAvOPAYkgUFAC3uqMdXSQZwYA21a5si3tIicbanncQzzX+Xb+0hjuJVo
 dHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727877954; x=1728482754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPETYREPVlOaeaFcRvTR3AWKMvuqWUYxAsAe7KWjxf0=;
 b=UMnZFZNiChKinGDa+oDiHsk2vKZkG4e6cJ/bIZBfkqNERAydBWFx3vTquwZYw0ePFz
 ZtcJY5jFpU4dz0dSqjl0DSQZ0SmGMNRqRuTKztCBTr+6/NxMNgcwlilRpGkzzBSxOxIp
 LM1kRVcogteRWvsxrQkfzHbDSQFubJ57H/4Ax0Z+WSYZOpWMsCSZInN9+wwjZ70p0bUV
 /x9v2wPToQAQ8fSbSCProZB1vPkIkj7G8lRtPATE9ol1Wsyhde6kHn20E+65FY5n5bAm
 jhKbFIGBIay/NG/jBw7SNY+k7hX+/sBgzTAmMW0onk5g2cl6DRHpAxz7SbyL4eD63OsI
 yf0g==
X-Gm-Message-State: AOJu0YzNuKbYw4C/3JOln/5+VGSxmxhbLoBGr+IqBi675Ugw0RTi9oGj
 EejLJF091pmI81mmUJqxetYEznmxb0yAtwls2BlCfN2IfyVT/crFbGJ/Y4H3q2ymTMan6wKe6CZ
 HPQdb64jbARK8nlkPItrGXsQgDl4=
X-Google-Smtp-Source: AGHT+IHqSDh4Vn4c78GKcHuloJolDM9dOrfWFIu10F/v4xA/L+en8TocIOEQ9NmRB/ctaZxfVvtq3JkxOnBuaFTYVmI=
X-Received: by 2002:a05:6870:648c:b0:287:7bb6:3c54 with SMTP id
 586e51a60fabf-28788f2abe7mr2074725fac.38.1727877954341; Wed, 02 Oct 2024
 07:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
In-Reply-To: <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 2 Oct 2024 09:05:43 -0500
Message-ID: <CAFUsyf+wYJVQHFaJZZ2mE0e3MRXMoQsr+-vk3T0qU3LYd3Dujw@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
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

On Wed, Oct 2, 2024 at 3:08=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > The new option '-qemu-children' makes it so that on `execve` the
> > child
> > process will be launch by the same `qemu` executable that is
> > currently
> > running along with its current commandline arguments.
> >
> > The motivation for the change is to make it so that plugins running
> > through `qemu` can continue to run on children.  Why not just
> > `binfmt`?: Plugins can be desirable regardless of system/architecture
> > emulation, and can sometimes be useful for elf files that can run
> > natively. Enabling `binfmt` for all natively runnable elf files may
> > not be desirable.
>
> Another reason to have this is that one may not have root permissions
> to configure binfmt-misc.
>
+1

> There was a similar patch posted to the mailing list some years back,
> which I used to cherry-pick when I needed this. I'm not sure what
> happened to that discussion though.

Yes(ish): https://patchwork.ozlabs.org/project/qemu-devel/patch/1455515507-=
26877-1-git-send-email-petrosagg@resin.io/

>
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> > ---
> >  linux-user/main.c           | 22 ++++++++++++++++++++++
> >  linux-user/syscall.c        | 20 +++++++++++++++-----
> >  linux-user/user-internals.h |  4 ++++
> >  3 files changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index 8143a0d4b0..dfb303a1f2 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
> >  uintptr_t guest_base;
> >  bool have_guest_base;
> >
> > +bool qemu_dup_for_children;
> > +int qemu_argc;
> > +char ** qemu_argv;
>
> Style: ** belong to the variable name.
> There are a couple other issues, please check the output of
>
> git format-patch -1 --stdout | ./scripts/checkpatch.pl -
>

Will Do.

> > +
> >  /*
> >   * Used to implement backwards-compatibility for the `-strace`, and
> >   * QEMU_STRACE options. Without this, the QEMU_LOG can be
> > overwritten by
> > @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
> >      perf_enable_jitdump();
> >  }
> >
> > +static void handle_arg_qemu_children(const char *arg)
> > +{
> > +    qemu_dup_for_children =3D true;
> > +}
> > +
> >  static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
> >
> >  #ifdef CONFIG_PLUGIN
> > @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =3D
> > {
> >       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
> >      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
> >       "",           "Generate a jit-${pid}.dump file for perf"},
> > +    {"qemu-children",
> > +                   "QEMU_CHILDREN",    false,
> > handle_arg_qemu_children,
> > +     "",           "Run child processes (created with execve) with
> > qemu "
> > +                   "(as instantiated for the parent)"},
> >      {NULL, NULL, false, NULL, NULL, NULL}
> >  };
> >
> > @@ -729,6 +742,15 @@ int main(int argc, char **argv, char **envp)
> >
> >      optind =3D parse_args(argc, argv);
> >
> > +    if (qemu_dup_for_children) {
> > +        int i;
>
> I get the following build error:
>
> qemu/linux-user/main.c: In function =E2=80=98main=E2=80=99:
> qemu/linux-user/main.c:746:13: error: declaration of =E2=80=98i=E2=80=99 =
shadows a
> previous local [-Werror=3Dshadow=3Dcompatible-local]
>   746 |         int i;
>       |             ^
> qemu/linux-user/main.c:699:9: note: shadowed declaration is here
>   699 |     int i;
>       |         ^
>
> I don't think this variable is needed at all.
>

Bah sorry.

> > +        qemu_argc =3D optind;
> > +        qemu_argv =3D g_new0(char *, qemu_argc);
> > +        for (i =3D 0; i < optind; ++i) {
> > +            qemu_argv[i] =3D strdup(argv[i]);
> > +        }
> > +    }
> > +
> >      qemu_set_log_filename_flags(last_log_filename,
> >                                  last_log_mask | (enable_strace *
> > LOG_STRACE),
> >                                  &error_fatal);
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 9d5415674d..732ef89054 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -8459,13 +8459,14 @@ static int do_execv(CPUArchState *cpu_env,
> > int dirfd,
> >                      abi_long pathname, abi_long guest_argp,
> >                      abi_long guest_envp, int flags, bool
> > is_execveat)
> >  {
> > -    int ret;
> > +    int ret, argp_offset;
> >      char **argp, **envp;
> >      int argc, envc;
> >      abi_ulong gp;
> >      abi_ulong addr;
> >      char **q;
> >      void *p;
> > +    bool through_qemu =3D !is_execveat && qemu_dup_for_children;
>
> Wouldn't it be better to check for dirfd =3D=3D AT_FDCWD?

Yeah that works.
Ill fix in V2.
>
> >      argc =3D 0;
> >
> > @@ -8489,10 +8490,11 @@ static int do_execv(CPUArchState *cpu_env,
> > int dirfd,
> >          envc++;
> >      }
> >
> > -    argp =3D g_new0(char *, argc + 1);
> > +    argp_offset =3D through_qemu ? qemu_argc : 0;
> > +    argp =3D g_new0(char *, argc + argp_offset + 1);
> >      envp =3D g_new0(char *, envc + 1);
> >
> > -    for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeof(abi_ulong),
> > q++) {
> > +    for (gp =3D guest_argp, q =3D argp + argp_offset; gp; gp +=3D
> > sizeof(abi_ulong), q++) {
> >          if (get_user_ual(addr, gp)) {
> >              goto execve_efault;
> >          }
> > @@ -8537,9 +8539,17 @@ static int do_execv(CPUArchState *cpu_env, int
> > dirfd,
> >      }
> >
> >      const char *exe =3D p;
> > -    if (is_proc_myself(p, "exe")) {
> > +    if (through_qemu) {
> > +        int i;
> > +        for (i =3D 0; i < argp_offset; ++i) {
> > +            argp[i] =3D qemu_argv[i];
> > +        }
> > +        exe =3D qemu_argv[0];
> > +    }
> > +    else if (is_proc_myself(p, "exe")) {
> >          exe =3D exec_path;
> >      }
> > +
> >      ret =3D is_execveat
> >          ? safe_execveat(dirfd, exe, argp, envp, flags)
> >          : safe_execve(exe, argp, envp);
> > @@ -8553,7 +8563,7 @@ execve_efault:
> >      ret =3D -TARGET_EFAULT;
> >
> >  execve_end:
> > -    for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeof(abi_ulong),
> > q++) {
> > +    for (gp =3D guest_argp, q =3D argp + argp_offset; *q; gp +=3D
> > sizeof(abi_ulong), q++) {
> >          if (get_user_ual(addr, gp) || !addr) {
> >              break;
> >          }
> > diff --git a/linux-user/user-internals.h b/linux-user/user-
> > internals.h
> > index 5c7f173ceb..0719e65ff4 100644
> > --- a/linux-user/user-internals.h
> > +++ b/linux-user/user-internals.h
> > @@ -30,6 +30,10 @@ void stop_all_tasks(void);
> >  extern const char *qemu_uname_release;
> >  extern unsigned long mmap_min_addr;
> >
> > +extern bool qemu_dup_for_children;
> > +extern int qemu_argc;
> > +extern char ** qemu_argv;
> > +
> >  typedef struct IOCTLEntry IOCTLEntry;
> >
> >  typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t
> > *buf_temp,
>

