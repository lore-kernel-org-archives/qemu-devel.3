Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC18CD4F54
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwbS-0007Ja-GK; Mon, 18 May 2026 07:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOwbO-0007JH-2Z
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOwbM-0001GY-A6
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779105458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ji+d2AMJEPbcbB8KJNHJLhRuCYB1q5fAStOTPkYT3ug=;
 b=IjuuNOQ+dWYLYzwrupvy+Fz8k+cx3EcKogfxIngrNqfaScHUIjId/M941HyWZpGnvs/pOM
 hD7SfPHFb6kXeRPYc93OHf4C/n5+DXfe7XudyTGkOcFCFFfeU/eihvUim2oDuL8JG0CSOJ
 gfmRw0dfsyiKR1wohFh54KzfnTR1ubk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-WFNneBG4N0yj-ZbtUCDCQw-1; Mon,
 18 May 2026 07:57:35 -0400
X-MC-Unique: WFNneBG4N0yj-ZbtUCDCQw-1
X-Mimecast-MFC-AGG-ID: WFNneBG4N0yj-ZbtUCDCQw_1779105454
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9C63180035D; Mon, 18 May 2026 11:57:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D585B1956053; Mon, 18 May 2026 11:57:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B00421E6A01; Mon, 18 May 2026 13:57:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V7 06/14] monitor: Update tracking iothread users with
 holder name
In-Reply-To: <20260511140416.28271-7-zhangckid@gmail.com> (Zhang Chen's
 message of "Mon, 11 May 2026 22:04:08 +0800")
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-7-zhangckid@gmail.com>
Date: Mon, 18 May 2026 13:57:30 +0200
Message-ID: <8733zpudzp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> name (or a default type-based name) as the holder identifier like QOM
> Object.
>
> Because Daniel Berrang=C3=A9's "[PATCH RFC 00/17] monitor: turn QMP and H=
MP into
> QOM objects" under review, when that series gets merged, the kind monitor
> can go away. Current patch assume the monitor already been a QOM Object
> in IOthread. Will keep looking at Daniel Berrang=C3=A9's patch about moni=
tor
> QOM in case any future changes needed here.

Feels like this patch should not be merged as is.

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
> index a5c4aba306..3e2c141c27 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -125,6 +125,9 @@ struct Monitor {
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

This is wrong.

First, inventing QOM paths is cheating.  Fine for RFC patches, but not
for merging.

Second, we can have multiple QMP and multiple HMP monitors.  For
instance

    $ qemu-system-x86_64 -S -display none -monitor stdio -chardev "socket,i=
d=3Dchr-mon1,path=3Dhmp-sock,server=3Don,wait=3Doff" -mon "id=3Dmon1,charde=
v=3Dchr-mon1,mode=3Dreadline"

runs QEMU with an HMP monitor on stdio, and another one on Unix domain
socket hmp-sock.

> +        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, path=
);
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


