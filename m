Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55198CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4qB-0001LE-W8; Thu, 04 Jun 2026 05:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wV4q9-0001Kt-1D
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:58:17 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wV4q6-0006H3-OA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:58:16 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bed2195323cso72102866b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780567092; cv=none;
 d=google.com; s=arc-20240605;
 b=THSo5jAvW7UH3VdW+phfRNj7lWz+DVdxK7KjFTvf1bZcDpnoz+4R0J+m+QQfw5zTY8
 gRscB2XQmtQvXAIhg3/Sqkziv1T0X+ZjedNxBT11tJIlMBU+c9td/jBQJw3HuRPSwVpV
 mK6OfHkqta92XhFE/crpfSbVTVwTZfD5q4Yp27kk6PokaX+sprrLIeIJ9f22zpdDowR9
 uuNClJNxGi9zqcRwcSsB+zLzKSRBQKIHLxlhGZ89mm2GmhK2p1vHCUzLPGKTr8XQ39GL
 UrMWqt7Qc7lWelrNNccaJNX5npFbD5dldibYPkeKKuZ+WkTYCocg6tKPimLms07FkERN
 vbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PbCpmMSpxs1Hd2YwpkKI59NJ2W4kFRfabpmYWC40V30=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=ZPqYgDdeFSfN8HD8ZxwxEvhd86kZjytsvdylQJg5XVeKl7jcnHSqmDP7Qrae3wi6nD
 jmpNPQ3ujdanAW5vshpWMb6fR1cg+j57rxwJw7L1y+3+wl61V3It6oHLxeQPDKrViWrc
 NxKe1sxuDuBfQrX8GB4rMNTBpjqITEGOhGamUz3Q4yERzV1Lnkbz2P77PbLQPlfVaZmA
 IJKXBzdRLI4tZtXZNdb2zth+tlE+AfboF7n03FLZyP7vbeTJEewKMWRvlE4IFyedXwDt
 YNltrKDLljOy+iCy4VuObKenhbnmOSE1f+7kyNfe9Lw6t01DnteHPLGQX7Gg/bjiRvqF
 eTwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780567092; x=1781171892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbCpmMSpxs1Hd2YwpkKI59NJ2W4kFRfabpmYWC40V30=;
 b=LA1ALOXDWiUqEG4DQql7mWjXcw5IQCjlLrbSZSdrVsgqT04d+uvAnKox+59gGtKmsg
 nnQfI4j/TcdQZG8rc3XcGhGC2GehpIh0YeOtBrQesvqRk2039S0HPJC9cLBHoRmmpUrj
 JefLFsKCDaJSKhNlH1PWfcsRXNCzY0wzmp4pAPd6UWu6TuuxkBZSDe8bLhmrg+myo9v3
 UYbkMxgpKY4YmSVA7lGnUGJlTN87AEi1WEbj2bDhfwLdqkRUNzLuVQU6xu3h72uEmFC6
 OrWOI/Arb7oBXwpomlfMjo8hYkknnTYTP1si/wHicjyVrbl+gvGx7gckf9C0uBARw/Ed
 ddyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567092; x=1781171892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PbCpmMSpxs1Hd2YwpkKI59NJ2W4kFRfabpmYWC40V30=;
 b=lSJSkoDJQz7eSBA0yzF7szzH5QFC/V4EwIiMyTr9DvbTl7kexEWJ1Q/gBzkDUkf3qD
 cOYCg694ufYiYtWN2k+z2VKQOtOd9TFKwa8WjfQVR9OGhngicPO8Wr/7I8azjYFwIUeo
 RZKQQvsAl9QKUYXyA1h9Y7RzpFC/+MJdX1Y7JiQ1rlARoaey58Gyeu+W+9EZGNh+f2Q2
 /kHExFXLv1PHdgshSVZbIHyhvDtyuBrB9Tdo2/sRAZ50eIVl66J2sYF/FGCqM7WFCWaZ
 ad+L//dBvrK4d8x2yuA1R/VpmtOGLgT+JMGExGrrDeVmTNmHhwZuBLtzlzy3IrY3im/B
 QZLg==
X-Gm-Message-State: AOJu0Ywd78NZ+7jogu08nE/ubr+Ztkdt6YhcpWECqZgnVeeEoTL/JbKD
 fmU8dYuE+g/tIgjcTuWDPbbdlag84leSF5WjzNCdRKbwZK1weEoEEL7v4Tbx+X84/t5FyyvzhCY
 rEiYwX3byyQaeTybMk3tTwIcnEKu1iCQ=
X-Gm-Gg: Acq92OGvEj3qrrPo5lLYbZQ+3QTi/CB+1icxV1KYE2PX3EU366LSRbpfJ02ndmQYEYq
 FNTqe1qjM1zi9IBfd2kCDts+zv9qZh0Y7p+xUqFVCIZJcemoARPHUm60a1xnAQjqFAopqOJgykI
 nilxm39fFWaO13WisACIQw5TpJyKvWsSnWc3v0dirTam549sS0KwU+dSL8qWfUvmCzPzBjD0/B2
 o+PBrCkyaQ6Uj7OIcGCjtmufyOwsAXvleY2V3wYRJZ4ZsiTFyjc39uKxUgZZXMREM1WcF72KC68
 Ql8hVFpSj0UivNt8dbUSvVzgrthzzw==
X-Received: by 2002:a17:907:ab5:b0:bdd:f2e9:37d2 with SMTP id
 a640c23a62f3a-bf0aef024f6mr256404666b.33.1780567092079; Thu, 04 Jun 2026
 02:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-7-zhangckid@gmail.com>
 <87ecioswnv.fsf@pond.sub.org>
In-Reply-To: <87ecioswnv.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 4 Jun 2026 17:57:34 +0800
X-Gm-Features: AVHnY4LHNniXPL1RPSXtJUriGzAO13jardetCYSprA32dnsQU4q5SpxUTJ61J4c
Message-ID: <CAK3tnvJ1UHfAviTJd5vanpSBV2b+OR8XSJbVzh9WvL0nSr9MMQ@mail.gmail.com>
Subject: Re: [PATCH V8 06/15] monitor: assign unique default ID to anonymous
 monitors
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62e.google.com
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

On Wed, Jun 3, 2026 at 1:02=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Currently, dynamically or implicitly created monitors (such as those
> > generated via '-monitor stdio', GDB stub terminals, or mux chardevs)
> > leave the 'id' field in the Monitor struct as NULL.
>
> There is no @id member in struct Monitor.

Yes, I try to add it in this patch.

>
> >                                                     But the original
> > @MonitorOptions have the @id field.
>
> QAPI type MonitorOptions has an optional member @id.
>
> Instances are only created by monitor_init_opts() from a QemuOpts, and
> member @id is set to the QemuOpts's @id, which is also optional.
>
> monitor_init_opts() is only called during startup on behalf of CLI
> option -mon, its shorthands -monitor, -qmp, -qmp-pretty, and for default
> monitors.
>
> -mon accepts an "id" parameter, but it's optional.
>
> The others make up an "id".  For instance, the default monitor usually
> gets "compat_monitor0".
>
> Aside: there's code that checks whether a non-null QemuOpts "id" starts
> with "compat_monitor".  That's horrifying.
>
> As far as I can tell, the only way to create a monitor with null @id in
> MonitorOptions is -mon without "id".
>
> This is a swamp.  Instead of messing with MonitorOptions member @id, ...

I don't quite understand here, the "compat_monitor0" has been saved in
the struct chardev's label field. I know each monitor need to bind to a cha=
rdev.
In principle, the "compat_monitor0" mark belonging to the chardev, not
the monitor.
Why is it forbidden to replace monitor with chardev?
So I think the monitor need to a unique ID field in the struct monitor.

>
> >                                     This makes it difficult to track,
> > debug, or associate monitors with specific iothreads or
> > infrastructure components.
> >
> > Fix this by introducing monitor_get_id(), which uses an atomic counter
> > to generate a unique fallback name ("mon_default_X") when 'id' is
> > not explicitly supplied in MonitorOptions. Update all internal HMP
> > and QMP initialization paths to propagate and store this string.
>
> ... you create yet another ID that is used for nothing but referring to
> monitors from IOThreadHolder.  Hmm.
>
> Is it really necessary that every monitor has an ID?  If a user want
> one, they can simply avoid -mon without id.

I think yes, the iothread ref/unref is the first user.

>
> If it's not necessary, ignore the remainder of my review.
>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  chardev/char.c             |  2 +-
> >  gdbstub/system.c           |  3 ++-
> >  include/monitor/monitor.h  |  6 ++++--
> >  monitor/hmp.c              | 20 +++++++++++++++++++-
> >  monitor/monitor-internal.h |  2 ++
> >  monitor/monitor.c          |  4 ++--
> >  monitor/qmp.c              | 18 +++++++++++++++++-
> >  stubs/monitor-internal.c   |  3 ++-
> >  8 files changed, 49 insertions(+), 9 deletions(-)
> >
> > diff --git a/chardev/char.c b/chardev/char.c
> > index ca8b37ed8d..f057247001 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char *=
label, const char *filename,
> >
> >      if (qemu_opt_get_bool(opts, "mux", 0)) {
> >          assert(permit_mux_mon);
> > -        monitor_init_hmp(chr, true, &err);
> > +        monitor_init_hmp(chr, true, NULL, &err);
> >          if (err) {
> >              error_report_err(err);
> >              object_unparent(OBJECT(chr));
> > diff --git a/gdbstub/system.c b/gdbstub/system.c
> > index e86c5870ab..50f934fde3 100644
> > --- a/gdbstub/system.c
> > +++ b/gdbstub/system.c
> > @@ -388,7 +388,8 @@ bool gdbserver_start(const char *device, Error **er=
rp)
> >          /* Initialize a monitor terminal for gdb */
> >          mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
> >                                     NULL, NULL, &error_abort);
> > -        monitor_init_hmp(mon_chr, false, &error_abort);
> > +
> > +        monitor_init_hmp(mon_chr, false, NULL, &error_abort);
> >      } else {
> >          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
> >          mon_chr =3D gdbserver_system_state.mon_chr;
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 55649a8664..c6ccd34cda 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -19,11 +19,13 @@ bool monitor_cur_is_qmp(void);
> >
> >  void monitor_init_globals(void);
> >  void monitor_init_globals_core(void);
> > -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
> > -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
> > +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error=
 **errp);
> > +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> > +                      Error **errp);
> >  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
> >  int monitor_init_opts(QemuOpts *opts, Error **errp);
> >  void monitor_cleanup(void);
> > +char *monitor_get_id(void);
> >
> >  int monitor_suspend(Monitor *mon);
> >  void monitor_resume(Monitor *mon);
> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > index cc4390486e..47f57f69e5 100644
> > --- a/monitor/hmp.c
> > +++ b/monitor/hmp.c
> > @@ -43,6 +43,8 @@
> >  #include "system/block-backend.h"
> >  #include "trace.h"
> >
> > +static int mon_hmp_id_counter;
> > +
> >  static void monitor_command_cb(void *opaque, const char *cmdline,
> >                                 void *readline_opaque)
> >  {
> > @@ -65,6 +67,14 @@ void monitor_read_command(MonitorHMP *mon, int show_=
prompt)
> >      }
> >  }
> >
> > +static char *monitor_hmp_get_id(void)
> > +{
> > +    int id =3D qatomic_fetch_inc(&mon_hmp_id_counter);
>
> Why atomic?  As far as I can see, this is only called during startup in
> the main thread.  Even if we merge dynamic monitor creation, the monitor
> command to create a monitor will also run in the main thread.

Yes, you are right.
Will change it to:
int id =3D mon_hmp_id_counter++;


>
> > +    char *name =3D g_strdup_printf("mon_default_hmp_%d", id);
>
> Can clash with the user's monitor IDs.

Just run it when the user didn't input thie monitor ID:

+void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
+                      Error **errp)
 {
     MonitorHMP *mon =3D g_new0(MonitorHMP, 1);

+    if (!id) {
+        g_autofree char *mon_id =3D  monitor_hmp_get_id();
+        mon->common.id =3D g_strdup(mon_id);
+    } else {
+        mon->common.id =3D g_strdup(id);
+    }

>
> > +
> > +    return name;
> > +}
> > +
> >  int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func=
,
> >                            void *opaque)
> >  {
> > @@ -1522,10 +1532,18 @@ static void monitor_readline_flush(void *opaque=
)
> >      monitor_flush(&mon->common);
> >  }
> >
> > -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
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
> > +
> >      if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
> >          g_free(mon);
> >          return;
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index a5c4aba306..2060311b03 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -108,6 +108,8 @@ struct Monitor {
> >      bool skip_flush;
> >      bool use_io_thread;
> >
> > +    char *id;
>
> Needs a comment.  In case you doubt it: explaining monitor IDs in my
> review of the commit message took me ~120 words.

OK, I learned a lot from your comments~

Thanks~
Chen

>
> > +
> >      char *mon_cpu_path;
> >      QTAILQ_ENTRY(Monitor) entry;
> >
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 00b93ed612..dafb4ad8b0 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -732,7 +732,7 @@ int monitor_init(MonitorOptions *opts, bool allow_h=
mp, Error **errp)
> >
> >      switch (opts->mode) {
> >      case MONITOR_MODE_CONTROL:
> > -        monitor_init_qmp(chr, opts->pretty, errp);
> > +        monitor_init_qmp(chr, opts->pretty, opts->id, errp);
> >          break;
> >      case MONITOR_MODE_READLINE:
> >          if (!allow_hmp) {
> > @@ -743,7 +743,7 @@ int monitor_init(MonitorOptions *opts, bool allow_h=
mp, Error **errp)
> >              error_setg(errp, "'pretty' is not compatible with HMP moni=
tors");
> >              return -1;
> >          }
> > -        monitor_init_hmp(chr, true, errp);
> > +        monitor_init_hmp(chr, true, opts->id, errp);
> >          break;
> >      default:
> >          g_assert_not_reached();
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 687019811f..b210850a15 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -56,6 +56,7 @@
> >   * Access must be atomic for thread safety.
> >   */
> >  static bool qmp_dispatcher_co_busy =3D true;
> > +static int mon_qmp_id_counter;
> >
> >  struct QMPRequest {
> >      /* Owner of the request */
> > @@ -76,6 +77,14 @@ static bool qmp_oob_enabled(MonitorQMP *mon)
> >      return mon->capab[QMP_CAPABILITY_OOB];
> >  }
> >
> > +static char *monitor_qmp_get_id(void)
> > +{
> > +    int id =3D qatomic_fetch_inc(&mon_qmp_id_counter);
>
> Again, why atomic?
>
> > +    char *name =3D g_strdup_printf("mon_default_qmp_%d", id);
>
> Again, can clash with the user's IDs.
>
> > +
> > +    return name;
> > +}
> > +
> >  static void monitor_qmp_caps_reset(MonitorQMP *mon)
> >  {
> >      memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
> > @@ -513,10 +522,17 @@ static void monitor_qmp_setup_handlers_bh(void *o=
paque)
> >      monitor_list_append(&mon->common);
> >  }
> >
> > -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> > +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error=
 **errp)
> >  {
> >      MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
> >
> > +    if (!id) {
> > +        g_autofree char *mon_id =3D  monitor_qmp_get_id();
> > +        mon->common.id =3D g_strdup(mon_id);
> > +    } else {
> > +        mon->common.id =3D g_strdup(id);
> > +    }
> > +
> >      if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
> >          g_free(mon);
> >          return;
> > diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
> > index 4fece49d53..325a559e62 100644
> > --- a/stubs/monitor-internal.c
> > +++ b/stubs/monitor-internal.c
> > @@ -8,6 +8,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Erro=
r **errp)
> >      return -1;
> >  }
> >
> > -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
> > +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> > +                      Error **errp)
> >  {
> >  }
>

