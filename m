Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CD4C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOnR-0001EW-Cs; Thu, 16 Jul 2026 12:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkOnQ-0001EN-1F
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:18:48 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkOnN-0008J3-Pn
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:18:47 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-698562f10e7so9711212a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 09:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784218724; cv=none;
 d=google.com; s=arc-20260327;
 b=G0lx3dx3KZSpjuem9qlGztY9brMFyzDlsao6IIIKFJLBpmMBYZTQYo0BZ7376y2Dg5
 0NHa9qjg+WGCEPI8J+NLTpWqeH70kMzIE+dkDUq/HQd8Zs0waHPbFHsJmZDQ6r6P2fiZ
 Oq1kEBiow5wvkUMUBYTMiJdVFnFHJktm64hLuMu+18NKdBAZhQ6TxErKKTtq2bRDlLwA
 jDFlTkQNPZhcxESGrH7iIN/MapHqEdZ7MGlk/6sUtY1h4mFEKvvGpBfdWm9Ylf57iExI
 nPEd8GcMRnUCbey+vEou81fhyqxmaE5RYGF8S6Epyzcodtk0H8yrlIv9lQV5QpsfjFAR
 Mo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FhMOZZ0bh9iTVyM74Ive3AZMdzMWrCrzMiHX2rwW0Kc=;
 fh=XlSsuloH83uiYGd5wjFfxhBlTtHH/VsvoyCW8PyiI6I=;
 b=gN5jdgt4JsP+Kd5R9i49kl0TLTq6sSLJs1biuSMVhPxQbDamlwmaNp2aM41FW5tHQe
 M8yfR+Wx8uxjMa8UGcTAbPO8dqb6M5jwt0iNlNVf7pg22OyF9dw4FIB9hqfo5Nf2nvWD
 H9DCJhjbseBHCn5WD8Fcp4tCw+gYHFpoiQi7/zkk24zMxdMnMuG+4Jlu3MqYkXepBnMK
 hgBmoGBt/UNgmOvAtGCJa24sHGG+UMv5DEVw6H1x9fDHHB91gBcMTW5CuCFXNq+n/BnB
 I0WHU1ye38qvVCcm/6OrroQ3wuHlWo4vg0aqJztDOKyTnrbVsUQmmYzc26GiNZmrfE50
 CvLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784218724; x=1784823524; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FhMOZZ0bh9iTVyM74Ive3AZMdzMWrCrzMiHX2rwW0Kc=;
 b=QaGpe6/BfxA46O7JuMAYQDjbUY2gobjIlV9tke1cr3dvihXnFP3RvD28583U4jn69F
 9PIugurqAOj/Ic5L64s2i1OUdnyDw8lM0fkJNWatavsFmiwuKAU00J7RoLWoBunB33g7
 JYLix0W0Z62ITpmzy8n0tuEaWcvBgjNCpGiF43zG/SMO8ORG58x1bYaYfh55/PYDQqnr
 TPK8xgkfcPzBjxcRlJtN4hUNUT60AokLzo6HEhKskmwQJrVgLJYsdsV6DvvIboAdolZ8
 yaoedKYKLP5J7VdXXZoEHPhKjmdRBuNB/Y3NcnWDEP3sn+usgakqRwhmrdoW5ViKTusK
 0oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784218724; x=1784823524;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FhMOZZ0bh9iTVyM74Ive3AZMdzMWrCrzMiHX2rwW0Kc=;
 b=BF1E0LlZnFRxyf9CcBbyJx31vUYyR3ceiEdAHVHBq8kAhYpKEJm+tlaP3i47tBBaK7
 JlSCxnP0QYxEkV73fbnDG9yGpk7eHQRz0dBETCpwojK8GJrVX35/ButNlXEuz5KDzOVj
 6k/+Y8BAUNrrAMK5ItwhevnLcMCJVXraEN3iSu32lW2ndrUpLLnkdwI6w1txUsNrOEbU
 DyYOtmeAqeCFjLDyg3n7hW9SH69J2bGH4epw+uYyee8I6LDJpDs/RxFpLBKrXQ11IVRU
 BwEaqG+I2JEihNH6z3ew2DjS0q7LCXo9Ue82+25BD1FoZfvhOBLLs/gYcpm+Z5CgOrB1
 n2fA==
X-Gm-Message-State: AOJu0YxL74pZHrDESDxuvgJMY6jh29VJ0TqrO/oNxh4zlaBiaJavoxcn
 3R7crx95hUmSz4Qf3USmeLzR4kF+dzK1eJEF06dvxI+BhyRKGOAh4FYRfuddq3ZwQSc9lt6g0Xe
 D2d1pkKtTm+EvMNC5ws9YVCVqmRd0DY0=
X-Gm-Gg: AfdE7cnOVRzLp7HgZ0JPT8Kb/7abePARtUowlieJLPw5uplKmRIiOz7UVPUCbFmd88l
 AwiuPw0E/5zTVKZVY1a7gqWQrF9xkbG9jXSoZH3bQn2h3wMf21oGvfDLi6DBNank6PH/jVipAgl
 7nOjEmwcUdl2ZVFXEASsi9AwZlnPllq138WVDruxUTDXMF/oZSo2U5taFS7hZEsaQM8ipqX+1sF
 pElIrHlxhAXFRov1JLmokLvcvP97Z1pj593ZPULf4sLTc9ITuyevHSyfPwJKg==
X-Received: by 2002:a05:6402:28cf:b0:698:3b7c:7e52 with SMTP id
 4fb4d7f45d1cf-69cd6f15c69mr5922331a12.40.1784218723517; Thu, 16 Jul 2026
 09:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260716144043.76414-1-zhangckid@gmail.com>
 <20260716144043.76414-7-zhangckid@gmail.com>
 <alj0jQ_Is4VA_J2A@redhat.com>
In-Reply-To: <alj0jQ_Is4VA_J2A@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 17 Jul 2026 00:18:30 +0800
X-Gm-Features: AUfX_myr3UVmuPZPgoDixPyWM-DVhNW7HvUqWwAbzzwMO1FxTAsootVZMagesF4
Message-ID: <CAK3tnvJitF1UVuFtDoFczXC1TaB05TVM=0AbirGuLTBa4HPhbg@mail.gmail.com>
Subject: Re: [PATCH V10 06/15] monitor: Update tracking iothread users with
 holder
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="0000000000003788fb0656bccbfc"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000003788fb0656bccbfc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026, 11:11=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Thu, Jul 16, 2026 at 10:40:31PM +0800, Zhang Chen wrote:
> > Based on monitor QOM path tracking iothread users with holder.
> > Introduce the AioContext in the Monitor struct to avoid repeated calls =
to
> > iothread_get_aio_context() and ensure symmetrical ref/unref during
> > monitor lifecycle.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  monitor/monitor-internal.h |  3 +++
> >  monitor/monitor.c          | 22 ++++++++++++++++++++--
> >  monitor/qmp.c              |  5 +++--
> >  3 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index 23829f32f9..caecceec93 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -153,6 +153,9 @@ struct Monitor {
> >      guint out_watch;
> >      int mux_out;
> >      int reset_seen;
> > +
> > +    /* iothread context */
> > +    AioContext *ctx;
> >  };
> >
> >  struct MonitorHMPClass {
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index ed195fd97b..688bb85c81 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -573,7 +573,7 @@ void monitor_suspend(Monitor *mon)
> >           * Kick I/O thread to make sure this takes effect.  It'll be
> >           * evaluated again in prepare() of the watch object.
> >           */
> > -        aio_notify(iothread_get_aio_context(mon_iothread));
> > +        aio_notify(mon->ctx);
> >      }
> >
> >      trace_monitor_suspend(mon, 1);
> > @@ -668,6 +668,17 @@ void monitor_cleanup(void)
> >          qemu_mutex_unlock(&monitor_lock);
> >          monitor_flush(mon);
> >          qemu_mutex_lock(&monitor_lock);
> > +
> > +        if (mon_iothread) {
> > +            g_autofree char *path =3D
> object_get_canonical_path(OBJECT(mon));
> > +            const IOThreadHolder io_holder =3D {
> > +                .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +                .u.qom_object.qom_path =3D path,
> > +            };
> > +
> > +            iothread_put_aio_context(mon_iothread, &io_holder);
> > +            mon->ctx =3D NULL;
> > +        }
> >          object_unparent(OBJECT(mon));
> >      }
> >      qemu_mutex_unlock(&monitor_lock);
> > @@ -732,7 +743,14 @@ static void monitor_complete(UserCreatable *uc,
> Error **errp)
> >              mon_iothread =3D iothread_create("mon_iothread",
> &error_abort);
> >          }
> >
> > -        ctx =3D iothread_get_aio_context(mon_iothread);
> > +        g_autofree char *path =3D object_get_canonical_path(OBJECT(mon=
));
> > +        const IOThreadHolder io_holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +            .u.qom_object.qom_path =3D path,
> > +        };
> > +
> > +        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread,
> &io_holder);
> > +        ctx =3D mon->ctx;
> >      } else {
> >          ctx =3D qemu_get_aio_context();
> >      }
>
> Even though QMP only takes the first branch, I'd be more
> comfortable if we set mon->ctx in both branches of this
> condition, so we can always assume that mon->ctx is
> non-NULL.
>

Good catch=EF=BC=8CI will send a RESEND version for v10 as a quick fix.

Thanks
Chen


> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 223e0643c2..b16bd77688 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -732,7 +732,8 @@ static void monitor_qmp_complete(UserCreatable *uc,
> Error **errp)
> >           * thread.  Schedule a bottom half.
> >           */
> >          mon->setup_pending =3D true;
> > -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread)=
,
> > +
> > +        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
> >                                  monitor_qmp_setup_handlers_bh, mon);
> >          /* The bottom half will add @mon to @mon_list */
> >      } else {
> > @@ -787,7 +788,7 @@ static bool monitor_qmp_prepare_delete(UserCreatabl=
e
> *uc, Error **errp)
> >
> >      /* Synchronize with in-flight iothread callbacks. */
> >      if (monitor_requires_iothread(mon)) {
> > -        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
> > +        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
> >                              monitor_qmp_iothread_quiesce, NULL);
> >      }
>
> ...this unconditionally accesses mon->ctx, and so will surely hit
> a NULL
>
> >
> > --
> > 2.49.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--0000000000003788fb0656bccbfc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 16, 2026, 11:11=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>On Thu, Jul 16, 2026 at 10:40:31PM +0800, Zhang Chen wrote:<br>
&gt; Based on monitor QOM path tracking iothread users with holder.<br>
&gt; Introduce the AioContext in the Monitor struct to avoid repeated calls=
 to<br>
&gt; iothread_get_aio_context() and ensure symmetrical ref/unref during<br>
&gt; monitor lifecycle.<br>
&gt; <br>
&gt; Signed-off-by: Zhang Chen &lt;<a href=3D"mailto:zhangckid@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">zhangckid@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 monitor/monitor-internal.h |=C2=A0 3 +++<br>
&gt;=C2=A0 monitor/monitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 22 +++++++=
+++++++++++++--<br>
&gt;=C2=A0 monitor/qmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 5 +++--<br>
&gt;=C2=A0 3 files changed, 26 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h<b=
r>
&gt; index 23829f32f9..caecceec93 100644<br>
&gt; --- a/monitor/monitor-internal.h<br>
&gt; +++ b/monitor/monitor-internal.h<br>
&gt; @@ -153,6 +153,9 @@ struct Monitor {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 guint out_watch;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mux_out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int reset_seen;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* iothread context */<br>
&gt; +=C2=A0 =C2=A0 AioContext *ctx;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct MonitorHMPClass {<br>
&gt; diff --git a/monitor/monitor.c b/monitor/monitor.c<br>
&gt; index ed195fd97b..688bb85c81 100644<br>
&gt; --- a/monitor/monitor.c<br>
&gt; +++ b/monitor/monitor.c<br>
&gt; @@ -573,7 +573,7 @@ void monitor_suspend(Monitor *mon)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Kick I/O thread to make sure=
 this takes effect.=C2=A0 It&#39;ll be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* evaluated again in prepare()=
 of the watch object.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_notify(iothread_get_aio_context(mon_i=
othread));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_notify(mon-&gt;ctx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_monitor_suspend(mon, 1);<br>
&gt; @@ -668,6 +668,17 @@ void monitor_cleanup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock(&amp;monitor_lock)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_flush(mon);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock(&amp;monitor_lock);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mon_iothread) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *path =3D o=
bject_get_canonical_path(OBJECT(mon));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const IOThreadHolder io_hol=
der =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IO_=
THREAD_HOLDER_KIND_QOM_OBJECT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.qom_object=
.qom_path =3D path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iothread_put_aio_context(mo=
n_iothread, &amp;io_holder);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mon-&gt;ctx =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unparent(OBJECT(mon));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock(&amp;monitor_lock);<br>
&gt; @@ -732,7 +743,14 @@ static void monitor_complete(UserCreatable *uc, E=
rror **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mon_iothread =3D iothr=
ead_create(&quot;mon_iothread&quot;, &amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D iothread_get_aio_context(mon_ioth=
read);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *path =3D object_get_cano=
nical_path(OBJECT(mon));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const IOThreadHolder io_holder =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IO_THREAD_HOLDER_=
KIND_QOM_OBJECT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.qom_object.qom_path =3D =
path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mon-&gt;ctx =3D iothread_ref_and_get_aio_=
context(mon_iothread, &amp;io_holder);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D mon-&gt;ctx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D qemu_get_aio_context();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Even though QMP only takes the first branch, I&#39;d be more<br>
comfortable if we set mon-&gt;ctx in both branches of this<br>
condition, so we can always assume that mon-&gt;ctx is<br>
non-NULL.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Good catch=EF=BC=8CI will send a RESEND version for v10 as a quic=
k fix.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks</div><div =
dir=3D"auto">Chen</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; diff --git a/monitor/qmp.c b/monitor/qmp.c<br>
&gt; index 223e0643c2..b16bd77688 100644<br>
&gt; --- a/monitor/qmp.c<br>
&gt; +++ b/monitor/qmp.c<br>
&gt; @@ -732,7 +732,8 @@ static void monitor_qmp_complete(UserCreatable *uc=
, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* thread.=C2=A0 Schedule a bot=
tom half.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mon-&gt;setup_pending =3D true;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(iothread_get_aio_=
context(mon_iothread),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(MONITOR(mon)-&gt;=
ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_qmp_setup_handlers=
_bh, mon);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The bottom half will add @mon to =
@mon_list */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; @@ -787,7 +788,7 @@ static bool monitor_qmp_prepare_delete(UserCreatab=
le *uc, Error **errp)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Synchronize with in-flight iothread callbacks. =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (monitor_requires_iothread(mon)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_wait_bh_oneshot(iothread_get_aio_cont=
ext(mon_iothread),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_wait_bh_oneshot(MONITOR(mon)-&gt;ctx,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_qmp_iothread_quiesce, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
...this unconditionally accesses mon-&gt;ctx, and so will surely hit<br>
a NULL<br>
<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.49.0<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a> :|<b=
r>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =
=C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--0000000000003788fb0656bccbfc--

