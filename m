Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32DFCD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsJf-0001oG-0s; Tue, 09 Jun 2026 05:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wWsJX-0001nQ-OR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:00:03 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wWsJT-00068R-O8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:00:03 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6924a68e3f3so331619a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 01:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780995597; cv=none;
 d=google.com; s=arc-20240605;
 b=OHmKmY/Davoq3I3auvKtU/SIa921+gLaeI0nvTTvFheBOoAX/0sEMZ2i+G34vaMeTM
 KNUisNY7Y1qUJANZnUCbyjEWBIrWMoxlpEXBLR0BjvwXyS58nsiRJQH7GyI4WfGoFxAH
 wduNjkdNW4s62sZI45CTywTN6UPpvKkXmSvSSOPKbpbEeOsPKh+7CD9YL5SZFEpUmpMQ
 v9UV04J+f7fBKvamF3Zuqcty8aeEfWZQNpCmhYic/vWUC088gK8xo7cmDvAEzJReGwWX
 ZAtHRYngmnB88tJJVaRZLpqvVzMIJQ0hlSqAalWjW7MWnZNbQc08M7PcRAySprmbvSMI
 sl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PQWWrwk66F2ncL3ugxEaaV8S+bqNZ9tMTIPG2kdr7eM=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=IdXPkHHsBx5lupdWQxuKg/v+uDzwUhQULERVRJhzvLBu7tm22IwzfUbQUkXz2aiu1r
 vuqdu8C0cHNtANp3Olk7q3eHqWfl5Rk+funXsrKnSsWrTACz9FNOoh1/fdVHkC0DMz5m
 Xyr91yeJ7aDlApkTuCYxMCWTaTaYSFebgsaAKHtnKB/9fydIBGLVds72o2qQ7CKtUQV0
 Vt0RMO9S+v91cnVOkw1DqkB1z3Vd2gHEFj/boGSICMgaV0RVjj1xEmjdFM4JgJ3etpGB
 mwiJ/+6JGdX7TDIAi5uqPBjdnR75CH4Lb5JjlRV/l2dUgZesgW+tIlKyEJvhsZJK9tC8
 ZjrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780995597; x=1781600397; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQWWrwk66F2ncL3ugxEaaV8S+bqNZ9tMTIPG2kdr7eM=;
 b=WuY171TJivBiCQ1bmYq/2TV18VF92hdU83qApXo8RM2viaWncUiqPhk1g4PwvKJoZf
 wG2p4uYHdbLwlAk6IAa6Qf1WGDwbfAlwUwbsENbTv7GdIWdArGvUotviFdVsDr3nEsKt
 7azW8uL9CfS0xeiuqJGVPserNSU1PFWlMPGOqxsW/FsXJ9Y5H8/CmRSd6Inf28g9Zy1r
 ZMby+nraGKAwPXqQ7TBlIpJycghKPAVmmTcXI4WoNdRPHAsUeviDGwMFLeQYI0hdIzYG
 kGLhU3LsYZZbxi5+dLV0MCFMHDip8ReWl8lI4in0cBM5J9zqO6TyeOeoUUefC2qL+6Zc
 lfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995597; x=1781600397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PQWWrwk66F2ncL3ugxEaaV8S+bqNZ9tMTIPG2kdr7eM=;
 b=aBZZTmUNR0JpN8eDhBidB2cDfIosUdRKg5aEZV7JiV3sBdE30u5MJl9oHX1LpebHZi
 v+vbNiRibEDKiwNPpWeqP4Y7Xp5405sgp4Q3TPdzpSvCcP3MLlm4FSm7GEOnZZML1c+X
 Kb+usDlc0XQQWeTKLpC4Y01XqbDssylVtzI16gF18X4Ce/aWKW3D7KPWRt9KR2qUu/Xz
 rXwhZDkxEd8VBm12r5BKcdqkA9yXda066mSL2E/e52QQIwvkIbpMYsdDxhlAKtDvlpIk
 AYaRbwo7J8F5oWd5slLeYy0dq/j3WVKkmh0YyvVskyNm7z7KyzfRqGFvW1xDlh4SeWiT
 T78w==
X-Gm-Message-State: AOJu0Yw9A1fWzNgTzF6qs+Ircd1usAtNQMxTcqcnqVOwRgHDkm8mLisc
 wde9X7iZrKsbuzuxrV/vZl+wigSSyvLAigRyeBG88+puC7YynZNRZ/3JrDZeEIjfLaazL5UrXZ3
 Cz84wKvgaV/FOVRdgi7SpadW0BmJ0MzA=
X-Gm-Gg: Acq92OE9n/DWydowlTG09Lk+Gm2dX3PIwvvFVYyXRithQ+dGIEf/bNt8HG8S9lOWI52
 DoRMFjlLwJwxi2gTQrPsw7n+IMeS7zXZEWRHfSs4wbWNXBgFzrKrT7zNI9PZsrTZCtkDnL/dh97
 0kM/qsKO/q/Mq85pWH4Ptg1vhXHpnd7ruduTpegXVexI/vC/IzPsYlBpoomXriWyXMr91rfM5ws
 aqmC1iZgWkxLcur3+y5xXwlnwdsZDxPqsem2zFEAcA+nDfKpg2o7S46ZyGPKb09E/pnAw1IX3H8
 5jD91c5jqLA04qYLPrY=
X-Received: by 2002:a17:907:c398:b0:bda:d9e1:4e1d with SMTP id
 a640c23a62f3a-bf37283c93emr1023755366b.34.1780995596916; Tue, 09 Jun 2026
 01:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-7-zhangckid@gmail.com>
 <87ecioswnv.fsf@pond.sub.org>
 <CAK3tnvJ1UHfAviTJd5vanpSBV2b+OR8XSJbVzh9WvL0nSr9MMQ@mail.gmail.com>
 <87ecihl6qz.fsf@pond.sub.org>
In-Reply-To: <87ecihl6qz.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 9 Jun 2026 16:59:20 +0800
X-Gm-Features: AVVi8CfSzfBc3RmAAl0hWpkQeT78mI9KYAxGWOy_YmUyC2bYwGZ-o-_bOZj9z0M
Message-ID: <CAK3tnvKAZtR9SX-q9msdXs+9T6mRVYiO3+c4eGVzxb-e-6eNqA@mail.gmail.com>
Subject: Re: [PATCH V8 06/15] monitor: assign unique default ID to anonymous
 monitors
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 8, 2026 at 6:41=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Wed, Jun 3, 2026 at 1:02=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > Currently, dynamically or implicitly created monitors (such as those
> >> > generated via '-monitor stdio', GDB stub terminals, or mux chardevs)
> >> > leave the 'id' field in the Monitor struct as NULL.
> >>
> >> There is no @id member in struct Monitor.
> >
> > Yes, I try to add it in this patch.
> >
> >>
> >> >                                                     But the original
> >> > @MonitorOptions have the @id field.
> >>
> >> QAPI type MonitorOptions has an optional member @id.
> >>
> >> Instances are only created by monitor_init_opts() from a QemuOpts, and
> >> member @id is set to the QemuOpts's @id, which is also optional.
> >>
> >> monitor_init_opts() is only called during startup on behalf of CLI
> >> option -mon, its shorthands -monitor, -qmp, -qmp-pretty, and for defau=
lt
> >> monitors.
> >>
> >> -mon accepts an "id" parameter, but it's optional.
> >>
> >> The others make up an "id".  For instance, the default monitor usually
> >> gets "compat_monitor0".
> >>
> >> Aside: there's code that checks whether a non-null QemuOpts "id" start=
s
> >> with "compat_monitor".  That's horrifying.
> >>
> >> As far as I can tell, the only way to create a monitor with null @id i=
n
> >> MonitorOptions is -mon without "id".
> >>
> >> This is a swamp.  Instead of messing with MonitorOptions member @id, .=
..
> >
> > I don't quite understand here, the "compat_monitor0" has been saved in
> > the struct chardev's label field. I know each monitor need to bind to a=
 chardev.
> > In principle, the "compat_monitor0" mark belonging to the chardev, not
> > the monitor.
> > Why is it forbidden to replace monitor with chardev?
> > So I think the monitor need to a unique ID field in the struct monitor.
> >
> >>
> >> >                                     This makes it difficult to track=
,
> >> > debug, or associate monitors with specific iothreads or
> >> > infrastructure components.
> >> >
> >> > Fix this by introducing monitor_get_id(), which uses an atomic count=
er
> >> > to generate a unique fallback name ("mon_default_X") when 'id' is
> >> > not explicitly supplied in MonitorOptions. Update all internal HMP
> >> > and QMP initialization paths to propagate and store this string.
> >>
> >> ... you create yet another ID that is used for nothing but referring t=
o
> >> monitors from IOThreadHolder.  Hmm.
> >>
> >> Is it really necessary that every monitor has an ID?  If a user want
> >> one, they can simply avoid -mon without id.
> >
> > I think yes, the iothread ref/unref is the first user.
>
> What would happen if we used MonitorOptions @id instead of adding yet
> another monitor ID?  IOThreadHolderMonitor then has to use
> MonitorOptions @id, and query-iothreads can then identify the monitor
> holding the I/O thread only when the user assigned a monitor ID.
>
> The only way *not* to assign one is -mon without "id".
>
> I'd expect human users to use the shorthands instead of -mon, and I'd
> expect management applications to use -mon with "id".  So, monitors
> without "id" should be rare.
>
> But even if they are rare, and probably unwise, they're not impossible.
> What are the consequences?
>
> I can't see truly bad ones.  If you want query-iothreads to identify
> your monitors, just give them IDs!  That's why I'm doubting the need for
> yet another monitor ID.
>
> Note that entire issue goes away if we can make monitors QOM objects
> before the interface becomes unchangable.
>
> >> If it's not necessary, ignore the remainder of my review.
> >>
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> > ---
> >> >  chardev/char.c             |  2 +-
> >> >  gdbstub/system.c           |  3 ++-
> >> >  include/monitor/monitor.h  |  6 ++++--
> >> >  monitor/hmp.c              | 20 +++++++++++++++++++-
> >> >  monitor/monitor-internal.h |  2 ++
> >> >  monitor/monitor.c          |  4 ++--
> >> >  monitor/qmp.c              | 18 +++++++++++++++++-
> >> >  stubs/monitor-internal.c   |  3 ++-
> >> >  8 files changed, 49 insertions(+), 9 deletions(-)
> >> >
> >> > diff --git a/chardev/char.c b/chardev/char.c
> >> > index ca8b37ed8d..f057247001 100644
> >> > --- a/chardev/char.c
> >> > +++ b/chardev/char.c
> >> > @@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const cha=
r *label, const char *filename,
> >> >
> >> >      if (qemu_opt_get_bool(opts, "mux", 0)) {
> >> >          assert(permit_mux_mon);
> >> > -        monitor_init_hmp(chr, true, &err);
> >> > +        monitor_init_hmp(chr, true, NULL, &err);
> >> >          if (err) {
> >> >              error_report_err(err);
> >> >              object_unparent(OBJECT(chr));
> >> > diff --git a/gdbstub/system.c b/gdbstub/system.c
> >> > index e86c5870ab..50f934fde3 100644
> >> > --- a/gdbstub/system.c
> >> > +++ b/gdbstub/system.c
> >> > @@ -388,7 +388,8 @@ bool gdbserver_start(const char *device, Error *=
*errp)
> >> >          /* Initialize a monitor terminal for gdb */
> >> >          mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
> >> >                                     NULL, NULL, &error_abort);
> >> > -        monitor_init_hmp(mon_chr, false, &error_abort);
> >> > +
> >> > +        monitor_init_hmp(mon_chr, false, NULL, &error_abort);
> >> >      } else {
> >> >          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
> >> >          mon_chr =3D gdbserver_system_state.mon_chr;
> >> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> >> > index 55649a8664..c6ccd34cda 100644
> >> > --- a/include/monitor/monitor.h
> >> > +++ b/include/monitor/monitor.h
> >> > @@ -19,11 +19,13 @@ bool monitor_cur_is_qmp(void);
> >> >
> >> >  void monitor_init_globals(void);
> >> >  void monitor_init_globals_core(void);
> >> > -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
> >> > -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp=
);
> >> > +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Er=
ror **errp);
> >> > +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *=
id,
> >> > +                      Error **errp);
> >> >  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp=
);
> >> >  int monitor_init_opts(QemuOpts *opts, Error **errp);
> >> >  void monitor_cleanup(void);
> >> > +char *monitor_get_id(void);
> >> >
> >> >  int monitor_suspend(Monitor *mon);
> >> >  void monitor_resume(Monitor *mon);
> >> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> >> > index cc4390486e..47f57f69e5 100644
> >> > --- a/monitor/hmp.c
> >> > +++ b/monitor/hmp.c
> >> > @@ -43,6 +43,8 @@
> >> >  #include "system/block-backend.h"
> >> >  #include "trace.h"
> >> >
> >> > +static int mon_hmp_id_counter;
> >> > +
> >> >  static void monitor_command_cb(void *opaque, const char *cmdline,
> >> >                                 void *readline_opaque)
> >> >  {
> >> > @@ -65,6 +67,14 @@ void monitor_read_command(MonitorHMP *mon, int sh=
ow_prompt)
> >> >      }
> >> >  }
> >> >
> >> > +static char *monitor_hmp_get_id(void)
> >> > +{
> >> > +    int id =3D qatomic_fetch_inc(&mon_hmp_id_counter);
> >>
> >> Why atomic?  As far as I can see, this is only called during startup i=
n
> >> the main thread.  Even if we merge dynamic monitor creation, the monit=
or
> >> command to create a monitor will also run in the main thread.
> >
> > Yes, you are right.
> > Will change it to:
> > int id =3D mon_hmp_id_counter++;
> >
> >
> >>
> >> > +    char *name =3D g_strdup_printf("mon_default_hmp_%d", id);
> >>
> >> Can clash with the user's monitor IDs.
> >
> > Just run it when the user didn't input thie monitor ID:
> >
> > +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> > +                      Error **errp)
> >  {
> >      MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
> >
> > +    if (!id) {
> > +        g_autofree char *mon_id =3D  monitor_hmp_get_id();
> > +        mon->common.id =3D g_strdup(mon_id);
> > +    } else {
> > +        mon->common.id =3D g_strdup(id);
> > +    }
>
> I'm not sure I was able to express myself with sufficient clarity, so
> let me try again.
>
> Something like
>
>      -mon mode=3Dcontrol,chardev=3Dqmp2 -chardev socket,id=3Dqmp2,server=
=3Don,wait=3Doff,path=3Dtest-qmp
>
> will make your code generate monitor-name "mon_default_qmp_0".
>
> Something like
>
>     -mon mode=3Dcontrol,chardev=3Dqmp2,id=3Dmon_default_qmp_0 -chardev so=
cket,id=3Dqmp2,server=3Don,wait=3Doff,path=3Dtest-qmp
>
> will *also* produce monitor-name "mon_default_qmp_0".
>
> Thus, your auto-generated monitor names can clash with the user's.
> That's bad.
>

OK, I got it. In the next version, I will remove the
monitor_hmp/qmp_get_id() and
keep the NULL ID for the monitors, and use the "mon->chr->label" as
the backup ID
for the monitor.

For example:
/* monitor/monitor.c */
void monitor_data_init(Monitor *mon, Chardev *chr, bool is_qmp, bool skip_f=
lush,
                       bool use_io_thread)
{
    mon->chr =3D chr;

    if (use_io_thread && !mon_iothread) {
        monitor_iothread_init();
        const char *holder_name =3D mon->id ? mon->id : chr->label;
--------------> As the backup ID

        IOThreadHolder holder =3D {
            .type =3D IO_THREAD_HOLDER_KIND_MONITOR_NAME,
            .u.monitor_name.monitor_name =3D (char *)holder_name,
        };
        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, &holder=
);
    } else {
        mon->ctx =3D qemu_get_aio_context();
--------------------------> Fix the Segmentation fault you found,
thank you.
    }
}

Any comments?

Thanks
Chen


>
> While testing this, I ran into a crash:
>
>     $ qemu-system-x86_64 -S -nodefaults -display none -qmp stdio -mon mod=
e=3Dcontrol,chardev=3Dqmp2 -chardev socket,id=3Dqmp2,server=3Don,wait=3Doff=
,path=3Dtest-qmp
>     Segmentation fault         (core dumped) qemu-system-x86_64 -S -nodef=
aults -display none -qmp stdio -mon mode=3Dcontrol,chardev=3Dqmp2 -chardev =
socket,id=3Dqmp2,server=3Don,wait=3Doff,path=3Dtest-qmp
>
> Stack backtrace:
>
>     #0  0x0000555555f09eae in aio_bh_enqueue (bh=3D0x555557a18760, new_fl=
ags=3D10)
>         at ../util/async.c:95
>     #1  0x0000555555f0a084 in aio_bh_schedule_oneshot_full
>         (ctx=3D0x0, cb=3D0x555555df6733 <monitor_qmp_setup_handlers_bh>, =
opaque=3D0x555557791cc0, name=3D0x55555648240f "monitor_qmp_setup_handlers_=
bh")
>         at ../util/async.c:141
>     #2  0x0000555555df69bf in monitor_init_qmp
>         (chr=3D0x555557a17e60, pretty=3Dfalse, id=3D0x0, errp=3D0x7ffffff=
fd860)
>         at ../monitor/qmp.c:569
>     #3  0x0000555555df4e73 in monitor_init
>         (opts=3D0x555557a18c60, allow_hmp=3Dtrue, errp=3D0x7fffffffd860)
>         at ../monitor/monitor.c:751
>     #4  0x0000555555df5028 in monitor_init_opts
>         (opts=3D0x555557790600, errp=3D0x555557646870 <error_fatal>)
>         at ../monitor/monitor.c:784
>     #5  0x0000555555a668fb in mon_init_func
>         (opaque=3D0x0, opts=3D0x555557790600, errp=3D0x555557646870 <erro=
r_fatal>)
>         at ../system/vl.c:1249
>     #6  0x0000555555efb375 in qemu_opts_foreach
>         (list=3D0x555557517da0 <qemu_mon_opts>, func=3D0x555555a668d4 <mo=
n_init_func>, opaque=3D0x0, errp=3D0x555557646870 <error_fatal>) at ../util=
/qemu-option.c:1148
>     #7  0x0000555555a68e1c in qemu_create_late_backends () at ../system/v=
l.c:2117
>     #8  0x0000555555a6e1e2 in qemu_init (argc=3D11, argv=3D0x7fffffffdc98=
)
>         at ../system/vl.c:3822
>     #9  0x0000555555e170a8 in main (argc=3D11, argv=3D0x7fffffffdc98)
>         at ../system/main.c:71
>
> I did not bisect to find the commit that breaks this.
>
> [...]
>

