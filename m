Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E663AFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNO8-0002Ev-VF; Mon, 27 Apr 2026 10:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wHNNx-0002BF-LZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 10:56:35 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wHNNu-0000AR-OX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 10:56:33 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so1448306266b.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 07:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777301789; cv=none;
 d=google.com; s=arc-20240605;
 b=SsNWoaAXyNW45QJthxdhSsukYoiE/nCoIL3amqm+95Oru3XsZ6YjShrvZXsLJQfaEl
 GlT/BBk4WILysOK8gDqJjWVlq0+6W0Zy2X3E9prwPmIGWfJM3+Zx3bLEbrcQ4TSUo50u
 5PC2DjPiJ6GwCSTieJM2B6i86XtNIGULXE1XN/ham1h1e3yDoYWCNB6zoG/knCFmywJC
 0prGJh4jLwYzOlQ6nXW6Q44UOBK5BZSQs54jjBRLy1zkpDfWrcy2RnKH+0rfZqMe0VhD
 m+wAL3r4TJr973EVwBP5c0qoD1tZMgqYXYhzuYo5jticH6XZYROIIRNV29Zau1+RMqYM
 yOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hxL7rbVuKJY8yVpPb63/VtozjO1EjYyJ3yoGlRNQspg=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=DinZ2nHaJigeep9F55B3OD9mu/uGk+bcqp9R+ND5+MbIkwNAvqFVNF6kg1GMYsNhLg
 z+ycY6XFqp4sOFdgxumI1jJ0GVCz9ga9rN8oqjGSKj3sK1pXy7LzptLZIAaTdfnONjNh
 MSzrDaVSkci2sZxe4YUqTgu9OXF0vZLB+XwSBMkQ3GrHCAkui4Hk3lkdjTVJoSYVcgXW
 tj+uGjMUqQonuIfusU0PSy9VbVBJbNNbj1JWpk3YBsJ7j27+sfpJYJQ8UbXwR8Tp8ACY
 MFyYYruUAv+1l5s1nY3Jgedqu8JEs9TAN8mdziKtvDGjMjNUAgHO2Q9ddr0FT6N4WEPa
 6eig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777301789; x=1777906589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxL7rbVuKJY8yVpPb63/VtozjO1EjYyJ3yoGlRNQspg=;
 b=Sxe4MjQfrTCBX7b7potM1jPunZEm1uWsqZ4H9Qa7F+yJ8NQ1/YcigHl2PDVHwVoTkI
 NHabjtVmQq4rhTsobVrW/Svo02/9ma8zsDRiBBTHnFRatQhR99uX2cS0BpZlsr4WISSP
 CzaHO+jsYPX41zRtJZeTxsGK67OeTOBxEUQMk4+KLjI/mLKgGdZaLXY/VLReDyq5VPCv
 KhUUPfCWssI7352OjV0Qksb3m8NunPhxOxb9sM0zituahD8AEYT1p2VovlnD7dCuw4Ll
 D1H/jpNVtEwXznXrVsWW2uETJULmJ2xA9johJAjZbjr8BZAkjcqrQE7hbaJfE3ryNyVe
 kwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777301789; x=1777906589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hxL7rbVuKJY8yVpPb63/VtozjO1EjYyJ3yoGlRNQspg=;
 b=nviMYLBlK/Unh6E7rh6YsNWOHu1uvIV+sCkFAyKcRouQrLui1zJtUCO+Urxl0ZGUlJ
 11YBpmQRwjAHZCZIuxLnnXUeYIo0BzGjeXPyomLNEmQ5C55WwQ7yCUcxsXvHneOllJtu
 EJMXm351Vg2/wrrjCdWTOg7b+SQDOYX5nFthAm/yfAWm7BgE4VB5BbDf0gtKxMyxpb4M
 OqaC00V5mJDLmm4I5SoBg8yYGrCa4xTcj7/yHZBrKohiJWeOf5M8GwTJUGKDFF9ZmmGY
 7v7tpuw98qhyH8QGHP1szTD9lWpw5nGshtJZPkEkR8AvahSqwChdtnvwE87VQ13VChb6
 VxiA==
X-Gm-Message-State: AOJu0YzbPAHKkiBbk2kVHbPvpGirZoD9Dn8qbqDLAA/Do9wYWepd1ud0
 LRZlsUdrURfCEaZHS2aYntBWjO62vY63JLu1eHTCqcY6ivNOYox8R05OhnFK5z3ZvfKEGNqKlv1
 V0w7HSCjHSXOeeMmTRoF4j0qym+71ql4=
X-Gm-Gg: AeBDiesEk0DIdmDqUSX+y0FEQqCmsCF8O2hQrKZbFB22fOnVk1undh75vkawqnlFTpi
 tPLroxo2H+KS8s+KOoQMNcayPu1Gymrq6kIEegd90slofYh1iNf4l+2N2E9tnG7pziYELULGUxu
 Pv2w03y6imBG46RdKtsRjFKRi/crz0rDp4g5RRry5wGARtPjtI3FOyvUJV7JbAPKC+DqwwTWQiA
 qFJUxCyChW2uzXlB1zaJZbEvONj2TOav/m26DwMFmijgtsWbwZMco5NUd6p0p00iBxIIYRPudNA
 hc3q3zSIIJBN0WmYF0R0/C2O7xFwGQ==
X-Received: by 2002:a17:907:d8a:b0:ba7:f5fd:edd6 with SMTP id
 a640c23a62f3a-ba7f5fdf1b4mr1545903166b.10.1777301788659; Mon, 27 Apr 2026
 07:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260410150457.85190-1-zhangckid@gmail.com>
 <20260410150457.85190-7-zhangckid@gmail.com>
 <87ldedongv.fsf@pond.sub.org>
In-Reply-To: <87ldedongv.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 27 Apr 2026 22:55:48 +0800
X-Gm-Features: AVHnY4LR69pC6AUI-wFqZzoTSI8OMwqtvb4f6qfSpafrx4D-4UzP05A_id94uUg
Message-ID: <CAK3tnvLHHXoEVngnyUbeTeVdj3w997wSc6heOPJG6-aWmzNazg@mail.gmail.com>
Subject: Re: [PATCH V6 06/14] monitor: Update tracking iothread users with
 holder name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x634.google.com
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

On Thu, Apr 23, 2026 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Since the Monitor struct is not a QOM Object, we cannot use
> > object_get_canonical_path(). Instead, this patch uses the monitor's
> > name (or a default type-based name) as the holder identifier.
> >
> > Cache the AioContext in the Monitor struct to avoid repeated calls to
> > iothread_get_aio_context() and ensure symmetrical ref/unref during
> > monitor lifecycle.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  monitor/monitor-internal.h |  3 +++
> >  monitor/monitor.c          | 24 ++++++++++++++++++++++--
> >  monitor/qmp.c              |  3 ++-
> >  3 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index feca111ae3..51cedf90e4 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -116,6 +116,9 @@ struct Monitor {
> >      guint out_watch;
> >      int mux_out;
> >      int reset_seen;
> > +
> > +    /* iothread context */
> > +    AioContext *ctx;
> >  };
> >
> >  struct MonitorHMP {
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 00b93ed612..b6efe776d6 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -529,7 +529,7 @@ int monitor_suspend(Monitor *mon)
> >           * Kick I/O thread to make sure this takes effect.  It'll be
> >           * evaluated again in prepare() of the watch object.
> >           */
> > -        aio_notify(iothread_get_aio_context(mon_iothread));
> > +        aio_notify(mon->ctx);
> >      }
> >
> >      trace_monitor_suspend(mon, 1);
> > @@ -564,7 +564,7 @@ void monitor_resume(Monitor *mon)
> >          AioContext *ctx;
> >
> >          if (mon->use_io_thread) {
> > -            ctx =3D iothread_get_aio_context(mon_iothread);
> > +            ctx =3D mon->ctx;
> >          } else {
> >              ctx =3D qemu_get_aio_context();
> >          }
> > @@ -612,6 +612,18 @@ void monitor_data_init(Monitor *mon, bool is_qmp, =
bool skip_flush,
> >  {
> >      if (use_io_thread && !mon_iothread) {
> >          monitor_iothread_init();
> > +        /*
> > +         * Because of current Monitor is not a QOM Object,
> > +         * so using OBJECT(mon) is undefined behavior and may crash.
> > +         * Try using a hard-coded future implementation of the qom pat=
h instead.
> > +         * (Like the name of the "mon_iothread").
> > +         * long-term solution would be making Monitor QOM, after that =
change
> > +         * here to:
> > +         * g_autofree path =3D object_get_canonical_path(OBJECT(mon));
> > +         */
> > +        g_autofree char *path =3D g_strdup(is_qmp ? "/monitor/qmp_mon0=
" :
> > +                                                  "/monitor/hmp_mon0")=
;
> > +        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, pa=
th);
>
> Oh.
>
> PATCH 02 defines QAPI type IoThreadHolder as a union with two branches
> for the two kinds of holders: one for block node holder, and one for QOM
> object holder.  Both branches use a string to identify the holder.
>
> The C code in PATCH 02 uses just a string to identify the holder.  This
> silently assumes that the strings for block nodes are distinct from the
> strings for QOM objects.  True as long as we only use absolute QOM
> paths: these start with '/', and block nodes can't.
>
> This patch shows me there's actually a third kind: monitor.  You use the
> QOM object branch for it.  That's confusing; a monitor is not a QOM
> object.  Moreover, you make yet another silent assumption: absolute QOM
> paths do not start with "/monitor/".
>
> This is too much for me.
>
> Please use a separate IoThreadHolderKind value and IoThreadHolder branch
> for each kind of holder.  The kinds I've seen so far are block-node, QOM
> object, monitor.
>
> If Daniel Berrang=C3=A9's "[PATCH RFC 00/17] monitor: turn QMP and HMP in=
to
> QOM objects" gets merged, kind monitor can go away.
>
> Use of just a string to identify the holder requires strings for
> different kinds to be distinct.  The argument why they are must be
> written down, simple, and likely to remain true.
>
> But I'd prefer to use IoThreadHolder instead of string.  No assumptions
> necessary then.
>
> If this IoThreadHolder arguments make the calls ugly or overly verbose,
> consider thin wrappers for each kind, i.e.
>
>     new_ctx =3D iothread_get_aio_context_block(iothread, bs);
>
> instead of
>
>     holder_name =3D bdrv_get_node_name(bs);
>     new_ctx =3D iothread_get_aio_context(iothread, holder_name);
>
> and so forth.
>
> Questions?

Thank you for the detailed explanation.
You are right, in this patch I silent assumption: absolute QOM paths
do not start with "/monitor/".
Because the Daniel Berrang=C3=A9's RFC patch and the monitor implementation
is very special,
it creates the iothread for itself. The iothread lifecycle is same
with the monitor.
It is not a general case like QOM and block node.
Maybe no need for this case add a third kind here?

Thanks

Chen

>
> >      }
> >      qemu_mutex_init(&mon->mon_lock);
> >      mon->is_qmp =3D is_qmp;
> > @@ -631,6 +643,14 @@ void monitor_data_destroy(Monitor *mon)
> >      }
> >      g_string_free(mon->outbuf, true);
> >      qemu_mutex_destroy(&mon->mon_lock);
> > +
> > +    if (mon->ctx && mon_iothread) {
> > +        g_autofree char *path =3D g_strdup(monitor_is_qmp(mon) ?
> > +                                        "/monitor/qmp_mon0" :
> > +                                        "/monitor/hmp_mon0");
> > +        iothread_put_aio_context(mon_iothread, path);
> > +        mon->ctx =3D NULL;
> > +    }
> >  }
> >
> >  void monitor_cleanup(void)
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 687019811f..8e4a775fac 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -549,7 +549,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Er=
ror **errp)
> >           * since chardev might be running in the monitor I/O
> >           * thread.  Schedule a bottom half.
> >           */
> > -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread)=
,
> > +        Monitor *mon_p =3D &mon->common;
> > +        aio_bh_schedule_oneshot(mon_p->ctx,
> >                                  monitor_qmp_setup_handlers_bh, mon);
> >          /* The bottom half will add @mon to @mon_list */
> >      } else {
>

