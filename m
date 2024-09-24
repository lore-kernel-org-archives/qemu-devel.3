Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E4ACF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 14:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st6lS-0000g6-Vl; Tue, 24 Sep 2024 10:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1st6lR-0000ef-Pk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 10:43:41 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1st6lP-0006WC-Tu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 10:43:41 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7124352ecc3so3473057a34.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727189018; x=1727793818; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gofgbQs8eKQddScVXUqPFNSjPhfiCm/uSgxx1k5bXpY=;
 b=jhqs0jJA3bMhTgEmP9t8zGL7QyUhQeXwlAuQPF7IZqp+PQmbadu1eqRccz4IEe9dpV
 4oY1I7IFKdg5Frj3fkLmeA5qqnuOIgE6Wvxy5N2npYFI3CBEPJosXo6q0TnzY1yR35Gp
 MPlisqx3RugzooDi7V4S37WvySYY0G7if43Q7GZCHc8Gyx1IKL7XEsh3P8iH+3MJOQa0
 /AkphSWTXfuU4QW0opKwIcDsElxwF2sueNFsWaCdfP3mgwSfh2zZPrBYXi1lO4XHi9Y7
 RpnZHixqXfiz0mVOLTDAQ60ua9G0jf+loHW8elSLnbTLSJR9ep2lKcQ2EIkz9dt+QAkm
 9I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727189018; x=1727793818;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gofgbQs8eKQddScVXUqPFNSjPhfiCm/uSgxx1k5bXpY=;
 b=IbpVe8lo656fzurVOLB2XR3tQ+c0OGBv2G8Qa6WxPnEUmvanEzh2dHB6aKxlS3gAoU
 wBHfgcpQuhZZrwK7apFWiwW/aCtRgVtIJcLeWfXTokMxkPWP37OXO0x8jU1HgCDxzZ6+
 j1oFjFOGDjQ9ktTNedcYX9PAlQYnwGTzSrgKmT5tlgjM8nYZW5lSVzMlT6bJs8YhPWGR
 XP3kWVxxPWzyFQJBeqxk+BUDuD8vqdtMCSOUjT8/Xs3didiBeV9kG3+2pEtR12pCCpf7
 Bv9p90lXMOo2rRJHDgy0bJt0yaBheaZ6IJYN1mvEWxW8umHhPvsnRqnG3Sstmm29EJ3i
 XToA==
X-Gm-Message-State: AOJu0Yy77AGToQLNG3o7ivtgq9KZ5Aokd7lye7vNYJen7kSXSOAXyHMF
 Nclw9Z4b7YpkJ5wzJJ3l2fMftgIMNO1+llcOfisNVwEKYt5wfx0MUhrQ+/F8Ve74Vkrso/eTUpl
 OXR1635XIP18i2r3QkrTZ+9wcqkoXFg==
X-Google-Smtp-Source: AGHT+IGCqH3gRQnqvYNQEx10rNomv7xwou6DGxjw7O+5Nb5RcgEmiNl9kw7AcHJ/7F60DCcYx7/CyNl697TBQ5xL3hE=
X-Received: by 2002:a05:6830:6582:b0:70f:6ec2:5e1e with SMTP id
 46e09a7af769-7139357c4bcmr9503086a34.29.1727189017933; Tue, 24 Sep 2024
 07:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <CAFUsyf+NgiOrzUEK_0Y6DxBG+49FLckbu_NdLQQ1LqWhDdVfMQ@mail.gmail.com>
 <CAFUsyfL+qWrxJ=05W6JbT8bUF2K65L8LLfEXPo3UeLsjYyvWUQ@mail.gmail.com>
In-Reply-To: <CAFUsyfL+qWrxJ=05W6JbT8bUF2K65L8LLfEXPo3UeLsjYyvWUQ@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Tue, 24 Sep 2024 07:43:26 -0700
Message-ID: <CAFUsyfKg-Yx78aF7F+Tgr_GMyj5K4Jgw5m_eqkDnCorhJ76Jxw@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-ot1-x336.google.com
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

On Tue, Sep 10, 2024 at 3:06=E2=80=AFPM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
> On Fri, Aug 30, 2024 at 3:37=E2=80=AFPM Noah Goldstein <goldstein.w.n@gma=
il.com> wrote:
> >
> > On Fri, Aug 30, 2024 at 3:36=E2=80=AFPM Noah Goldstein <goldstein.w.n@g=
mail.com> wrote:
> > >
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
> > >  linux-user/main.c           | 22 ++++++++++++++++++++++
> > >  linux-user/syscall.c        | 20 +++++++++++++++-----
> > >  linux-user/user-internals.h |  4 ++++
> > >  3 files changed, 41 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/linux-user/main.c b/linux-user/main.c
> > > index 8143a0d4b0..dfb303a1f2 100644
> > > --- a/linux-user/main.c
> > > +++ b/linux-user/main.c
> > > @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
> > >  uintptr_t guest_base;
> > >  bool have_guest_base;
> > >
> > > +bool qemu_dup_for_children;
> > > +int qemu_argc;
> > > +char ** qemu_argv;
> > > +
> > >  /*
> > >   * Used to implement backwards-compatibility for the `-strace`, and
> > >   * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritte=
n by
> > > @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
> > >      perf_enable_jitdump();
> > >  }
> > >
> > > +static void handle_arg_qemu_children(const char *arg)
> > > +{
> > > +    qemu_dup_for_children =3D true;
> > > +}
> > > +
> > >  static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
> > >
> > >  #ifdef CONFIG_PLUGIN
> > > @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =
=3D {
> > >       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
> > >      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
> > >       "",           "Generate a jit-${pid}.dump file for perf"},
> > > +    {"qemu-children",
> > > +                   "QEMU_CHILDREN",    false, handle_arg_qemu_childr=
en,
> > > +     "",           "Run child processes (created with execve) with q=
emu "
> > > +                   "(as instantiated for the parent)"},
> > >      {NULL, NULL, false, NULL, NULL, NULL}
> > >  };
> > >
> > > @@ -729,6 +742,15 @@ int main(int argc, char **argv, char **envp)
> > >
> > >      optind =3D parse_args(argc, argv);
> > >
> > > +    if (qemu_dup_for_children) {
> > > +        int i;
> > > +        qemu_argc =3D optind;
> > > +        qemu_argv =3D g_new0(char *, qemu_argc);
> > > +        for (i =3D 0; i < optind; ++i) {
> > > +            qemu_argv[i] =3D strdup(argv[i]);
> > > +        }
> > > +    }
> > > +
> > >      qemu_set_log_filename_flags(last_log_filename,
> > >                                  last_log_mask | (enable_strace * LOG=
_STRACE),
> > >                                  &error_fatal);
> > > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > > index 9d5415674d..732ef89054 100644
> > > --- a/linux-user/syscall.c
> > > +++ b/linux-user/syscall.c
> > > @@ -8459,13 +8459,14 @@ static int do_execv(CPUArchState *cpu_env, in=
t dirfd,
> > >                      abi_long pathname, abi_long guest_argp,
> > >                      abi_long guest_envp, int flags, bool is_execveat=
)
> > >  {
> > > -    int ret;
> > > +    int ret, argp_offset;
> > >      char **argp, **envp;
> > >      int argc, envc;
> > >      abi_ulong gp;
> > >      abi_ulong addr;
> > >      char **q;
> > >      void *p;
> > > +    bool through_qemu =3D !is_execveat && qemu_dup_for_children;
> > >
> > I wasn't sure if this was feasible for `evecveat`. If anyone has any th=
oughts
> > it would be nice to support that as well.
> >
> > >      argc =3D 0;
> > >
> > > @@ -8489,10 +8490,11 @@ static int do_execv(CPUArchState *cpu_env, in=
t dirfd,
> > >          envc++;
> > >      }
> > >
> > > -    argp =3D g_new0(char *, argc + 1);
> > > +    argp_offset =3D through_qemu ? qemu_argc : 0;
> > > +    argp =3D g_new0(char *, argc + argp_offset + 1);
> > >      envp =3D g_new0(char *, envc + 1);
> > >
> > > -    for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeof(abi_ulong=
), q++) {
> > > +    for (gp =3D guest_argp, q =3D argp + argp_offset; gp; gp +=3D si=
zeof(abi_ulong), q++) {
> > >          if (get_user_ual(addr, gp)) {
> > >              goto execve_efault;
> > >          }
> > > @@ -8537,9 +8539,17 @@ static int do_execv(CPUArchState *cpu_env, int=
 dirfd,
> > >      }
> > >
> > >      const char *exe =3D p;
> > > -    if (is_proc_myself(p, "exe")) {
> > > +    if (through_qemu) {
> > > +        int i;
> > > +        for (i =3D 0; i < argp_offset; ++i) {
> > > +            argp[i] =3D qemu_argv[i];
> > > +        }
> > > +        exe =3D qemu_argv[0];
> > > +    }
> > > +    else if (is_proc_myself(p, "exe")) {
> > >          exe =3D exec_path;
> > >      }
> > > +
> > >      ret =3D is_execveat
> > >          ? safe_execveat(dirfd, exe, argp, envp, flags)
> > >          : safe_execve(exe, argp, envp);
> > > @@ -8553,7 +8563,7 @@ execve_efault:
> > >      ret =3D -TARGET_EFAULT;
> > >
> > >  execve_end:
> > > -    for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeof(abi_ulong=
), q++) {
> > > +    for (gp =3D guest_argp, q =3D argp + argp_offset; *q; gp +=3D si=
zeof(abi_ulong), q++) {
> > >          if (get_user_ual(addr, gp) || !addr) {
> > >              break;
> > >          }
> > > diff --git a/linux-user/user-internals.h b/linux-user/user-internals.=
h
> > > index 5c7f173ceb..0719e65ff4 100644
> > > --- a/linux-user/user-internals.h
> > > +++ b/linux-user/user-internals.h
> > > @@ -30,6 +30,10 @@ void stop_all_tasks(void);
> > >  extern const char *qemu_uname_release;
> > >  extern unsigned long mmap_min_addr;
> > >
> > > +extern bool qemu_dup_for_children;
> > > +extern int qemu_argc;
> > > +extern char ** qemu_argv;
> > > +
> > >  typedef struct IOCTLEntry IOCTLEntry;
> > >
> > >  typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp=
,
> > > --
> > > 2.34.1
> > >
>
> ping
ping

