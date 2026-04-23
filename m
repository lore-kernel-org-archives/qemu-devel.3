Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ABAF589B0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFtQR-0001Qa-Jx; Thu, 23 Apr 2026 08:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFtQG-0001My-Ni
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFtQB-0005au-QT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776948281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AA/vG85kQQQaeHfmH2VF/+SNo4lCTlq/pTQQlxrt0Iw=;
 b=OSDU+3SEw6vY+3SZru1RJEvJZTMU7KJbUQv1ZGfC4LiNVMSvgG/0F8q9vby9T8jjSzN6tC
 qDxlkgakzazK0S0rUZgUc/zP7/1GFXQlsySqI13CHwZkSVAk+QF5qLKObiLb5YLChhE0uH
 ehCv1QCR2tNEmx0yVdywLEthXa0VB+U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-ofh67pcPNF-G2okcrpEx4g-1; Thu,
 23 Apr 2026 08:44:37 -0400
X-MC-Unique: ofh67pcPNF-G2okcrpEx4g-1
X-Mimecast-MFC-AGG-ID: ofh67pcPNF-G2okcrpEx4g_1776948276
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3845C19560AE; Thu, 23 Apr 2026 12:44:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6135D19560AB; Thu, 23 Apr 2026 12:44:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0465A21E6A28; Thu, 23 Apr 2026 14:44:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V6 06/14] monitor: Update tracking iothread users with
 holder name
In-Reply-To: <20260410150457.85190-7-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 10 Apr 2026 23:04:49 +0800")
References: <20260410150457.85190-1-zhangckid@gmail.com>
 <20260410150457.85190-7-zhangckid@gmail.com>
Date: Thu, 23 Apr 2026 14:44:32 +0200
Message-ID: <87ldedongv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> Since the Monitor struct is not a QOM Object, we cannot use
> object_get_canonical_path(). Instead, this patch uses the monitor's
> name (or a default type-based name) as the holder identifier.
>
> Cache the AioContext in the Monitor struct to avoid repeated calls to
> iothread_get_aio_context() and ensure symmetrical ref/unref during
> monitor lifecycle.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  monitor/monitor-internal.h |  3 +++
>  monitor/monitor.c          | 24 ++++++++++++++++++++++--
>  monitor/qmp.c              |  3 ++-
>  3 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index feca111ae3..51cedf90e4 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -116,6 +116,9 @@ struct Monitor {
>      guint out_watch;
>      int mux_out;
>      int reset_seen;
> +
> +    /* iothread context */
> +    AioContext *ctx;
>  };
>=20=20
>  struct MonitorHMP {
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 00b93ed612..b6efe776d6 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -529,7 +529,7 @@ int monitor_suspend(Monitor *mon)
>           * Kick I/O thread to make sure this takes effect.  It'll be
>           * evaluated again in prepare() of the watch object.
>           */
> -        aio_notify(iothread_get_aio_context(mon_iothread));
> +        aio_notify(mon->ctx);
>      }
>=20=20
>      trace_monitor_suspend(mon, 1);
> @@ -564,7 +564,7 @@ void monitor_resume(Monitor *mon)
>          AioContext *ctx;
>=20=20
>          if (mon->use_io_thread) {
> -            ctx =3D iothread_get_aio_context(mon_iothread);
> +            ctx =3D mon->ctx;
>          } else {
>              ctx =3D qemu_get_aio_context();
>          }
> @@ -612,6 +612,18 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bo=
ol skip_flush,
>  {
>      if (use_io_thread && !mon_iothread) {
>          monitor_iothread_init();
> +        /*
> +         * Because of current Monitor is not a QOM Object,
> +         * so using OBJECT(mon) is undefined behavior and may crash.
> +         * Try using a hard-coded future implementation of the qom path =
instead.
> +         * (Like the name of the "mon_iothread").
> +         * long-term solution would be making Monitor QOM, after that ch=
ange
> +         * here to:
> +         * g_autofree path =3D object_get_canonical_path(OBJECT(mon));
> +         */
> +        g_autofree char *path =3D g_strdup(is_qmp ? "/monitor/qmp_mon0" :
> +                                                  "/monitor/hmp_mon0");
> +        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, path=
);

Oh.

PATCH 02 defines QAPI type IoThreadHolder as a union with two branches
for the two kinds of holders: one for block node holder, and one for QOM
object holder.  Both branches use a string to identify the holder.

The C code in PATCH 02 uses just a string to identify the holder.  This
silently assumes that the strings for block nodes are distinct from the
strings for QOM objects.  True as long as we only use absolute QOM
paths: these start with '/', and block nodes can't.

This patch shows me there's actually a third kind: monitor.  You use the
QOM object branch for it.  That's confusing; a monitor is not a QOM
object.  Moreover, you make yet another silent assumption: absolute QOM
paths do not start with "/monitor/".

This is too much for me.

Please use a separate IoThreadHolderKind value and IoThreadHolder branch
for each kind of holder.  The kinds I've seen so far are block-node, QOM
object, monitor.

If Daniel Berrang=C3=A9's "[PATCH RFC 00/17] monitor: turn QMP and HMP into
QOM objects" gets merged, kind monitor can go away.

Use of just a string to identify the holder requires strings for
different kinds to be distinct.  The argument why they are must be
written down, simple, and likely to remain true.

But I'd prefer to use IoThreadHolder instead of string.  No assumptions
necessary then.

If this IoThreadHolder arguments make the calls ugly or overly verbose,
consider thin wrappers for each kind, i.e.

    new_ctx =3D iothread_get_aio_context_block(iothread, bs);

instead of

    holder_name =3D bdrv_get_node_name(bs);
    new_ctx =3D iothread_get_aio_context(iothread, holder_name);

and so forth.

Questions?

>      }
>      qemu_mutex_init(&mon->mon_lock);
>      mon->is_qmp =3D is_qmp;
> @@ -631,6 +643,14 @@ void monitor_data_destroy(Monitor *mon)
>      }
>      g_string_free(mon->outbuf, true);
>      qemu_mutex_destroy(&mon->mon_lock);
> +
> +    if (mon->ctx && mon_iothread) {
> +        g_autofree char *path =3D g_strdup(monitor_is_qmp(mon) ?
> +                                        "/monitor/qmp_mon0" :
> +                                        "/monitor/hmp_mon0");
> +        iothread_put_aio_context(mon_iothread, path);
> +        mon->ctx =3D NULL;
> +    }
>  }
>=20=20
>  void monitor_cleanup(void)
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 687019811f..8e4a775fac 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -549,7 +549,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Erro=
r **errp)
>           * since chardev might be running in the monitor I/O
>           * thread.  Schedule a bottom half.
>           */
> -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> +        Monitor *mon_p =3D &mon->common;
> +        aio_bh_schedule_oneshot(mon_p->ctx,
>                                  monitor_qmp_setup_handlers_bh, mon);
>          /* The bottom half will add @mon to @mon_list */
>      } else {


