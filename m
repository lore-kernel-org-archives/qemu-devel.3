Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510F7CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOyJt-0007pP-8C; Mon, 18 May 2026 09:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wOyJr-0007nx-Au
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:47:43 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wOyJo-0004Oo-LT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:47:43 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so555166966b.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 06:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779112059; cv=none;
 d=google.com; s=arc-20240605;
 b=Yu1q2GRHpAYNE9uS4WCxG8+PXrziznSGJUNhwP9WzOutlO5b4KkROQGtuWZ/BxMwoL
 ueB2M3fFF2zNdTU3si/9RYzqxdB2fx7A7QTbtXw82kqYWDSzTowbLgEfNprVjAiYbLzR
 P66/aLv5lloHXikjD8s80Iy8mVc5i45XcecEJ1PYqJsaJsqDylZ6b9Aff78Bc1DsTK5i
 GNFfzb1jVbuRMh9TvSTm8XImVjqbWYimdFbOkqgyuqnc5KAqt3b5ZUB3G6Gr/+9olpQp
 7V/hD4Z3AQC6w5j+q7eikhirlblFEQ9hw14b6vpbDKjUyo4PijNZkqUScz9msBHn5CqL
 TroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0f4i7DG+j+GuzQwrPpJtLZLiN80yaglRwoHWwhr6xPw=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=aimL4F8PM7s/pDsv9p0/l2Yynt+Qw9muvloZVHdWqCCBw2vtcK9s1oyma/k++dsZ8N
 4rp9G3DazuEHCtMQ4R9SsDkv7kkiPGDaIoA/Y9WVybSz/Da/7QPYWftggM5S16/JDf5V
 TuRMRzhYDENQDda+mBiWoEVp4101pgF3Kl1MqPdkupNutzcL1pOY59mwcuWxKwxwbJaQ
 it4nktQjfK/c3RmHJmXKQCpojd4FefarZigBlPMSKiuI1PhOvCJSPKwEmyR9Ojn0zHbs
 /iykV6OfLaE/2Bsm/9x1vXFOrSmU3O2xuvz1e5mM3yvOh5WLQ0zRoRszUSK8i+uEFTKl
 jaIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779112059; x=1779716859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0f4i7DG+j+GuzQwrPpJtLZLiN80yaglRwoHWwhr6xPw=;
 b=kibzDH02VOe0qwrDUJkqtUoiEPZzM5mLejDCWsq+AwG3593r+nV5yfBOtQ9tzIk93R
 zF0yptouu/1+I/4X0B6yAtYsfkaHtI013Dx3ySO5zFCWJGHfew1lc9vhgx89S5E7HMEt
 ZdW+xtbkU3msfDMQGH5I1v7XmPS1mtSg3JZYEoUBd6A3j0/r/KE8cZO6qRPpepxpqqDL
 SpnHM1xZl2evtygTEGYgJa+X7rr+YWP5EgHwovFXITQ8jfQXoHxlcyUXl4FVmMW63Vy8
 IuQi+S9Kco2UMtU83ZYvYQrXouDF85AuwfXBxaDYZbHIbhQtHRXGOZwTW0rc+K0WMfYg
 vfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779112059; x=1779716859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0f4i7DG+j+GuzQwrPpJtLZLiN80yaglRwoHWwhr6xPw=;
 b=mfuWP6ZIezKAmwlHeNjG4j9DFRPIRCe9w+aQ+1GsfJfFhoI4iT9uE9lAHXVQ+WqvSA
 xBjEo0l2SmOGo8KNYCh4LOcXkQtemxu6ZuVzgRwyQAmJoRWj41XFCbYQ89awo7FJyD0r
 rjjju2fDKDLc4d9cpt0qC+lx74lDTZzcWsV4XabB64o+M+q72Xq+OX6DUidQz2JF/Yzx
 Iqu4olpCpW2JyInKPfkxUiADiEkpxh7eI2U3hmVfAh8uXpghDwaYvHRu4s+MvgWuHHR7
 Nf0sOgEydVM4VT2hMwPfgxubNAhOI0f2pR/WFAFRz0qeHMMksW0+mYriJKfZE2gl23E8
 tRJw==
X-Gm-Message-State: AOJu0YzknNn/quYvB0Usco32+FOBlDHp7OVaRZmMUkeX1JokG/xy57kR
 IRiqLn2Y9lVo+fOiwI7J9TbxEpThYsEXsAbUlgdZ0GWmHPrPOlf8VqBbc9YTf0c7YiciywdAzC6
 yD4qecmXOmSMLRbYiwR/HrnVSDbtmlRE=
X-Gm-Gg: Acq92OGBQkuf3rOEA/CSqtPmI5VKhvg4KBNN+bG0ztVpuK2eAY2aGnUdDN0BpvodFI4
 ikqrhscADP9vFKFj/jtDM4LDVkEt8vLyQaNo/V8i1vUmxY3CS+htD0/20JZlv3kMBwhf2BFoS0c
 wdr0xKvO/iDF41gM1q+o2EAHNdigr8gwW1eY7huVMODF3qq1Jt0HxW1FFaR33nBQo+ROsJyrLSK
 M/9HGQ9a8WuDAPOdmLr3WxQ+HX0g75HRQCnc+T6HPlYWw3fWfZWuxYpz+qHC5IIe/0pdhomUguf
 gyeOQhAg
X-Received: by 2002:a17:907:6185:b0:bd3:c952:9b2f with SMTP id
 a640c23a62f3a-bd51792c271mr510388266b.37.1779112058568; Mon, 18 May 2026
 06:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-7-zhangckid@gmail.com>
 <8733zpudzp.fsf@pond.sub.org>
In-Reply-To: <8733zpudzp.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 18 May 2026 21:47:01 +0800
X-Gm-Features: AVHnY4KWPfaJQ_OcaXl1XZD1qrKDQ2eAG7VpwDUCYX5nroz6wVO4ckwHTs6gyZs
Message-ID: <CAK3tnvJ2a+wZGwdZx7m7=CMiPn4+Vfka7VyfR84xUnAVXUUVSw@mail.gmail.com>
Subject: Re: [PATCH V7 06/14] monitor: Update tracking iothread users with
 holder name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x632.google.com
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

On Mon, May 18, 2026 at 7:57=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Since the Monitor struct is not a QOM Object, we cannot use
> > object_get_canonical_path(). Instead, this patch uses the monitor's
> > name (or a default type-based name) as the holder identifier like QOM
> > Object.
> >
> > Because Daniel Berrang=C3=A9's "[PATCH RFC 00/17] monitor: turn QMP and=
 HMP into
> > QOM objects" under review, when that series gets merged, the kind monit=
or
> > can go away. Current patch assume the monitor already been a QOM Object
> > in IOthread. Will keep looking at Daniel Berrang=C3=A9's patch about mo=
nitor
> > QOM in case any future changes needed here.
>
> Feels like this patch should not be merged as is.
>
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
> > index a5c4aba306..3e2c141c27 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -125,6 +125,9 @@ struct Monitor {
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
>
> This is wrong.
>
> First, inventing QOM paths is cheating.  Fine for RFC patches, but not
> for merging.
>
> Second, we can have multiple QMP and multiple HMP monitors.  For
> instance
>
>     $ qemu-system-x86_64 -S -display none -monitor stdio -chardev "socket=
,id=3Dchr-mon1,path=3Dhmp-sock,server=3Don,wait=3Doff" -mon "id=3Dmon1,char=
dev=3Dchr-mon1,mode=3Dreadline"
>
> runs QEMU with an HMP monitor on stdio, and another one on Unix domain
> socket hmp-sock.

Yes, you are right.
And here looks has same issue for multi iothreads:
static void monitor_iothread_init(void)
{
    mon_iothread =3D iothread_create("mon_iothread", &error_abort);
}

If yes, I will fix it by the way in next version.

Back to this patch, the "struct Monitor" doesn't seem to be a unique
field like id or qom path.
We need to add this field or any comments here?

Then, as discussed in patch 02/14, I will add a new type for the monitor:
"IO_THREAD_HOLDER_KIND_MONITOR"

Thanks
Chen

>
> > +        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, pa=
th);
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

