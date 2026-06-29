Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2432C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we7Q0-0006jg-8z; Mon, 29 Jun 2026 04:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1we7Py-0006jV-9D
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:32:38 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1we7Pw-0005ua-1d
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:32:38 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c124c3c876aso187043366b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 01:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782721954; cv=none;
 d=google.com; s=arc-20260327;
 b=rp5mSvY8kiGbfUPZALHNi8UStYylMdu72aFrkxi5coUoetonyTY5sZOj3f/D2Dhh9c
 3oZyfD3bzQAQYiomLZzUyvsn3UtjOYdEryGbMi403gzdb8a5rHNqzzBvPu9LCHltMPQH
 nerAADG5RW5qszV5WGfT9R55KMKza4CGtFBYs7oey/62D6FyxTQvWImBy8hxmYWM8mRr
 e0oIFcB3crr8PZ04tfA8NA0uRUSFfwDxtbQON0prAohZR2SZEa1i7lZthvkKnQASr3dR
 M/fUkD5dxmWjEpidx44EQKFLCs3NZCIjiyWC4LBAY4/+DrK/QLhdrBZK9Ysr8eoTWRMR
 Sa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dPPWYEN8H613lAMb7zSZWHcVrudV3LLaWLE5jhX72h8=;
 fh=XlSsuloH83uiYGd5wjFfxhBlTtHH/VsvoyCW8PyiI6I=;
 b=M+kzmS685nfdypT05iXcFE0n+4g2iAJxsdShbzA0qi+WmB6ODKaBg9vmqWhJkmJD4H
 pva446OiVOoT/ayl+BpKFUTIi+24dfFTEUwb3PeXppjui9zpzn8N4FgQAtOlcUHQUblV
 Piqh7n/fUNtkZUOeL9kU1ctk5m/j8r0ZDA3SjcSVQdnha7+thJCA7wmx9u5GJi2/Awpc
 Hsj9w7Tu5GKJwIaYMXVZ7pkOtIHTcl+oYW3qN5KW7PmiKUS+xVd433uvFyr/sGZgcRa+
 0I41ydS/Zj2+tmQkOgBw/DXH5nPM1wWN3Jg/pe4oA9QwSnvppd1FFwwDspZYoOgphbzh
 oOXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782721954; x=1783326754; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPPWYEN8H613lAMb7zSZWHcVrudV3LLaWLE5jhX72h8=;
 b=S180PuHQtbO3ER70FebBJ287Ej/kIQnazZpFklzdavmgpHM3acefzI3iZjmtCqtLes
 vFOz6toj95lmFqwqiCJJtIw4GTacZzxDl0DNyZHzwMG4DSyVvy/Ai9MBZQgEf1owLB0c
 jOw5s5L9JDSQxrdbSjCoFzwsyaP9AqxtB6efpNcqYCyupzUeGsdUOEoMz08kJ/pYx/vn
 00/Kb1durk6ZTssm8PxTwGarXYC3PTsno+H917D//OwjwqqVsQWyxP98nG15hggM/UHE
 T2S/KWicQ0OAJdAbhAzXEzK4ZSLL2ReFWEw+KZBajxfG/S0kBJr4itGN+Vt3kp0cY2dp
 gzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782721954; x=1783326754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dPPWYEN8H613lAMb7zSZWHcVrudV3LLaWLE5jhX72h8=;
 b=snKmVTeAE9lGUD/DQnjuBsi645DimR3loytVdtOTfd7NLmY8LvBjObSVU4rv3UdKcU
 w3piaM/zkrkjtMCFqNOLgFXI4cIE9XBVjUjPKLoGVU2hd9VMS40PhBUHzForBaTpE5S0
 WfXah3fqlWtVS9GPY/qpmaRd5xnf/ztpyPXJx8kX4geMzRAhSjbnZQ1fEMUu16Os5ahe
 X2t35rvWfemd07zWeAcawf83C/KFuRDEhwWRYJopy1zZgFY7u6et/8k/BvL+o+mhh0gq
 xh558TNNaKCfEG/sKeKUs07uvEWagYDQYlJfQJm+lM246QPTQqSlO2G+HsmkCFCuEDN/
 ymbA==
X-Gm-Message-State: AOJu0Yy08l2HerWzEh32A9uLNJtvQbavfI+MkstozV+JBq9qJISZsmlV
 3Gbe+ae9LC3TT5AkELQwUgdNj1e8oPgCRQafad/paldzVYirKEgeuhRD3hfq/9p7MSa7b/6A3dk
 2TBt39k5zd39WlHZB7tXYSR2T6wWkt/o=
X-Gm-Gg: AfdE7cnhB95BqUJA1jC0U6UMO/08X6Xf/T7AbA776amt7hec6J2o5UQQ+Kqw+N6hnzU
 aMVuhedavt8xYtwTfEBeRBGQiCjVBwVLBf7VHG2cnnqx9BllmD8QjzY/A0XTcNTFsrbOM8Cp7Kc
 mn6NA4C1/e9TzYL4LCzl3Bq7zfQYlui7UtrtKnJxLsgT3Ho5KInMfjSJKVDWbA7oHuwFDEdoPG/
 uiu0NYwWS5iQJVz9m07zVJCtedwhbJMoePe+mYEIQH+vy5MDC0R4vgvMn91M5p6J1x42R4BVg==
X-Received: by 2002:a17:907:a08a:b0:bec:2a21:785d with SMTP id
 a640c23a62f3a-c1205f09ea5mr828333966b.46.1782721954078; Mon, 29 Jun 2026
 01:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-7-zhangckid@gmail.com>
 <aj5_T__4oqt41IWv@redhat.com>
In-Reply-To: <aj5_T__4oqt41IWv@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 29 Jun 2026 16:31:56 +0800
X-Gm-Features: AVVi8CcVl-6-qzf1-eZie0Mu_xrnGX2yVoIC3yl6P05pMNcssOA3C-14XSaAfrY
Message-ID: <CAK3tnvLTwLdWm2ZHcLhHRsncHZVvEgW_B14Ua4ZS9EX6BE1Erw@mail.gmail.com>
Subject: Re: [PATCH V9 06/17] monitor: refactor monitor_data_init() to pass ID
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
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

On Fri, Jun 26, 2026 at 9:32=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Jun 24, 2026 at 03:08:40PM +0800, Zhang Chen wrote:
> > Anonymous monitors (e.g., '-monitor stdio' or GDB stub) leave their 'id=
'
> > field as NULL. To allow downstream subsystems (like iothread tracking) =
to
> > identify these instances later, the initialization paths must propagate
> > the context.
> >
> > Refactor monitor_data_init() to accept the 'id' parameters, and
> > update all internal QMP/HMP paths to pass these identifiers.
> >
> > For anonymous monitors, 'mon->id' remains NULL at this stage to avoid
> > namespace pollution, setting up infrastructure for subsequent patches.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  chardev/char.c             | 2 +-
> >  gdbstub/system.c           | 3 ++-
> >  include/monitor/monitor.h  | 5 +++--
> >  monitor/hmp.c              | 5 +++--
> >  monitor/monitor-internal.h | 4 +++-
> >  monitor/monitor.c          | 9 ++++++---
> >  monitor/qmp-cmds.c         | 2 +-
> >  monitor/qmp.c              | 5 +++--
> >  stubs/monitor-internal.c   | 3 ++-
> >  9 files changed, 24 insertions(+), 14 deletions(-)
>
> This patch will significantly conflict with my series that
> creates QOM objects for the monitors. They will all be
> guaranteed to have an "id" at that point though, which
> addresses the problem you're trying to solve IIUC.
>
> https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg06427.html
>

Thank you for your updates.
As Markus's help, we already know your series for create
QOM for the monitors. So this series V7 based on the assumption of
your patch merged. But for the comments:
"Feels like this patch should not be merged as is."
https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04214.html

I have to fix it by myself.
I'm very happy this series based on your series, I can conveniently make
the monitor as a regular QOM object like others in this series.
If you think that OK, I will rebase my series on your QOM for monitor patch=
es
in next version.

Thanks
Chen




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
> > index 55649a8664..4a5eb20bea 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -19,8 +19,9 @@ bool monitor_cur_is_qmp(void);
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
> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > index cc4390486e..4ee8cb58d1 100644
> > --- a/monitor/hmp.c
> > +++ b/monitor/hmp.c
> > @@ -1522,7 +1522,8 @@ static void monitor_readline_flush(void *opaque)
> >      monitor_flush(&mon->common);
> >  }
> >
> > -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
> > +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> > +                      Error **errp)
> >  {
> >      MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
> >
> > @@ -1531,7 +1532,7 @@ void monitor_init_hmp(Chardev *chr, bool use_read=
line, Error **errp)
> >          return;
> >      }
> >
> > -    monitor_data_init(&mon->common, false, false, false);
> > +    monitor_data_init(&mon->common, false, false, false, id);
> >
> >      mon->use_readline =3D use_readline;
> >      if (mon->use_readline) {
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index a5c4aba306..f651ba6a90 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -108,6 +108,8 @@ struct Monitor {
> >      bool skip_flush;
> >      bool use_io_thread;
> >
> > +    char *id;
> > +
> >      char *mon_cpu_path;
> >      QTAILQ_ENTRY(Monitor) entry;
> >
> > @@ -179,7 +181,7 @@ extern QemuMutex monitor_lock;
> >  extern MonitorList mon_list;
> >
> >  void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> > -                       bool use_io_thread);
> > +                       bool use_io_thread, const char *id);
> >  void monitor_data_destroy(Monitor *mon);
> >  int monitor_can_read(void *opaque);
> >  void monitor_list_append(Monitor *mon);
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 00b93ed612..65749f931e 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -608,8 +608,10 @@ static void monitor_iothread_init(void)
> >  }
> >
> >  void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> > -                       bool use_io_thread)
> > +                       bool use_io_thread, const char *id)
> >  {
> > +    mon->id =3D id ? g_strdup(id) : NULL;
> > +
> >      if (use_io_thread && !mon_iothread) {
> >          monitor_iothread_init();
> >      }
> > @@ -629,6 +631,7 @@ void monitor_data_destroy(Monitor *mon)
> >      } else {
> >          readline_free(container_of(mon, MonitorHMP, common)->rs);
> >      }
> > +    g_free(mon->id);
> >      g_string_free(mon->outbuf, true);
> >      qemu_mutex_destroy(&mon->mon_lock);
> >  }
> > @@ -732,7 +735,7 @@ int monitor_init(MonitorOptions *opts, bool allow_h=
mp, Error **errp)
> >
> >      switch (opts->mode) {
> >      case MONITOR_MODE_CONTROL:
> > -        monitor_init_qmp(chr, opts->pretty, errp);
> > +        monitor_init_qmp(chr, opts->pretty, opts->id, errp);
> >          break;
> >      case MONITOR_MODE_READLINE:
> >          if (!allow_hmp) {
> > @@ -743,7 +746,7 @@ int monitor_init(MonitorOptions *opts, bool allow_h=
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
> > diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> > index 0c409c27dc..e49b9cbf8b 100644
> > --- a/monitor/qmp-cmds.c
> > +++ b/monitor/qmp-cmds.c
> > @@ -168,7 +168,7 @@ char *qmp_human_monitor_command(const char *command=
_line, bool has_cpu_index,
> >      char *output =3D NULL;
> >      MonitorHMP hmp =3D {};
> >
> > -    monitor_data_init(&hmp.common, false, true, false);
> > +    monitor_data_init(&hmp.common, false, true, false, NULL);
> >
> >      if (has_cpu_index) {
> >          int ret =3D monitor_set_cpu(&hmp.common, cpu_index);
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 687019811f..8fd71386e8 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -513,7 +513,7 @@ static void monitor_qmp_setup_handlers_bh(void *opa=
que)
> >      monitor_list_append(&mon->common);
> >  }
> >
> > -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> > +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error=
 **errp)
> >  {
> >      MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
> >
> > @@ -525,7 +525,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Er=
ror **errp)
> >
> >      /* Note: we run QMP monitor in I/O thread when @chr supports that =
*/
> >      monitor_data_init(&mon->common, true, false,
> > -                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCON=
TEXT));
> > +                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCON=
TEXT),
> > +                      id);
> >
> >      mon->pretty =3D pretty;
> >
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
> > --
> > 2.49.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

