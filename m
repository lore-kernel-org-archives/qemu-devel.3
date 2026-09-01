Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F391C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Pmj-00071K-Fq; Tue, 01 Sep 2026 10:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x1Pmf-0006z9-Qo
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:48:21 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x1Pmd-0007Zx-L6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:48:21 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2531f453eeso746675166b.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788274098; cv=none;
 d=google.com; s=arc-20260327;
 b=IeRdnfUa0AhzcDelnJqWfNLtSUk4J8gWOieWpFSRYXRmh12nGUrJFgb4xRc7PvE8QC
 mNfsg9NlSVA8O/yptDYA1RbZo13InH/qBRB1k/gQX2zHQwC/eMxQcBdaY41Ux8DpL3O/
 ce8gC/KLQyM7JEEsT8YusGDZ87xsUrR4IFoEq+EAfW28kkRqwa/VfxxSBwNiCVaZJd6c
 gR/582kV7Rj7Kmn0ELTqUJw6Eh9RKCLqX8pb+K8BL0O6OS4besMHlWH2DTZ64orpegTL
 eNEk7Q9tF7Er2fW8MJtCZS1mK6eSBh+MP/XHSawpZ/Mw1/scClJXh5+iRhwGYIwgUbpn
 I2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wiFjTrxe6C1UxDNIIzaWThV4UDLGyZ8eK88c7qkD8r0=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=nnu28muuUQT3P6xPS1C1UMCdC7Mf9w+sKxTyUPlZZUclBcQrJFdPsh9h4CLbZyoYgY
 Q0jDIy+jUuFzs0PJDV7K5WhFO7odBjMOyrzxOmBQ3i2wPSOYIIgPF6PRoLzc1TczbePO
 QwO9KrOa1Yk2iRSS3qb/VHSxQhWJwR6n+YZD0wx+ZFw6rPj9YxShFe7rVvUsvtIsxLUN
 Puq8JMSxwTkm4iNCqcDQJS6TN3RrKmLlNaDgeWenJq08jabxMPR5+1s+VSCYDEr6FjRg
 VYOJ/PVmSxCfUvmdg+UyeK2yZ3gLuXNktF7qYd2GtPsSH97HZcnpJ6OiCy8gyh81zy/k
 ebNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788274098; x=1788878898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wiFjTrxe6C1UxDNIIzaWThV4UDLGyZ8eK88c7qkD8r0=;
 b=GuNEXjNuCwKg+w/TpO+MPVn0NTF3q2eGM+KJez0HYj+dRSGqs/voTHocbt6w4gilAc
 Qf5YGj5PPXTxbdH+kHW6vTDWN8LMPBEBrzVz8bmmKCVGOGOaFGLg/pQ+SjT7ZGi3Xh2S
 pqB91QgZJvd479sgyN0sfWVRqQBFKUS3z1drwHED1Da7b+W5Vk/JeBntaP/s46B5skbR
 zFNgUMEWSuDR/rZGaghvpXQAv3EYhyWxDbHXa9h8Kd6JiiqGfL6RdvQqmmLGGF/GwW1D
 R5t8tUwK6URjmcmBCb7qigWIVJS6PIW9EldrfJFmskbLwQI04xFoKYOw3pMf3Rjz+J0F
 oyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788274098; x=1788878898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wiFjTrxe6C1UxDNIIzaWThV4UDLGyZ8eK88c7qkD8r0=;
 b=J2IUmfJnmJouLDlqTutTLZOtjY7zwnUCfVV4QL87BVRoWDqGhuTsLsxN3BP54wiIzH
 8Z06Vbtc4DbgbwvWFIi3aZXKqKaMBgisoCYQ4nYT5SEKFzxtYVto7PJzKv0TWSKsIvZv
 FMRrtgEMkMgVLhdJUjA0o8IgfxB57fy3rQRJvFCIYPq4hog7m9WUnAdMpQjLgA8l7MDJ
 jEZRNZDPiohaCCpl9t03Ve7D+sBKO4FU86iMeNjRCSE3KMuY6/AikNNT7i6i5h8bIC8q
 GWHO0cJ31FbLVfDqM34d/CMdE1I/NP27XslDczaP6bxeVCzpaEzZ/ZvrGd0EOCjA8kNF
 tN8Q==
X-Gm-Message-State: AFuF++n24BJ6Vz+1tsw1hbhpAuLftZ98b8xXBTP2Nwh6EykOrtpHZJks
 lCJqtIEKJG4bBEr5LLLtVQwALA/QUG5XZFs4Exlo9tYLsqZ8Ty4YTD0/OAgZVth2H5mZy3vftu/
 8xfdLrknC/FzqRFFD3+0k3kOBkDp3b2E=
X-Gm-Gg: AR+sD106+2m4bmI3BNJTuRG1rMPZxw1Gjb4Ux2RcvCGZpPqBmG4WtKJ0MuQvPdCNyeB
 mx7ZfcjoheCzUtD/E8ku/JHIAxjo+3KX39XGi43HyPoG3oZMqIJZwasIaL4aeuYKjXOdKx/d0Np
 /HcNPzJorFMPKdNTTdkurhQiIdlJ1vhLhic9RIRZTYtS13yWJ3zeAluIGd9Rr5qLbz7rM2ShOZI
 zN1O/zhkTrcPfHqHy68RiFb+eIsQxcOA1TQe7JQouE5CSN//x2mNVvX+NohaHfbBT2Cjp7SPl71
 bNNMdCZmCD5sXJ9sjpfgAhkf3vbgmMiMEgEszdfYf3qM
X-Received: by 2002:a17:907:73cd:b0:c24:b11a:470f with SMTP id
 a640c23a62f3a-c25b39d698cmr656491566b.0.1788274097737; Tue, 01 Sep 2026
 07:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-7-zhangckid@gmail.com>
 <8733vtbk16.fsf@pond.sub.org>
In-Reply-To: <8733vtbk16.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 1 Sep 2026 22:47:41 +0800
X-Gm-Features: AcwNN1WI6DFak982mL999BkUrLgCx5d3seTh1eX9Gs9RV4NZGtSatDILoSCo4CI
Message-ID: <CAK3tnvLbaJ4b+gRhXC678cye-cHv+aP3FFwRvhPNjyfSHxL6MA@mail.gmail.com>
Subject: Re: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
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

On Tue, Sep 1, 2026 at 1:47=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Monitors that require an IOThread share the internal mon_iothread.
> > Account for each monitor explicitly in IOThread holder tracking, using
> > the monitor's canonical QOM path to distinguish holders.
> >
> > Acquire the shared monitor IOThread AioContext once, using the monitor
> > QOM path as the holder, and reuse the stored context for later
> > operations.
> >
> > Release the holder from the Monitor ObjectClass::unparent callback,
> > while the canonical QOM path is still available. This covers every
> > object_unparent() path and avoids duplicating the cleanup in
> > monitor_cleanup() and monitor_qmp_prepare_delete().
> >
> > The internal mon_iothread remains hidden from query-iothreads, as befor=
e.
> > Management applications therefore cannot use it to determine which
> > monitors are using the IOThread. Nevertheless, track the monitor
> > holders so that they follow the same explicit holder and
> > IOThread reference lifecycle as other AioContext users.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> I have a question for our QOM experts (Paolo and Daniel).
>
> This patch takes a reference in its UserCreatableClass method
> complete(), and relinquishes it in its ObjectClass unparent() method.
> Is that correct and clean?  Or should complete() pair with
> prepare_delete()?


Add some background information in previous reviews for here:
https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg05318.html

Thanks
Chen

>
> > ---
> >  monitor/monitor-internal.h |  3 +++
> >  monitor/monitor.c          | 33 ++++++++++++++++++++++++++++-----
> >  monitor/qmp.c              |  5 +++--
> >  3 files changed, 34 insertions(+), 7 deletions(-)
> >
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index e0a124a317..74ea15c85f 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -154,6 +154,9 @@ struct Monitor {
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
> > index 6af09f2f6e..9e3b639eff 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -81,6 +81,22 @@ int monitor_device_index;
> >  OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true,
> >                              { TYPE_USER_CREATABLE }, {});
> >
> > +static void monitor_unparent(Object *obj)
> > +{
> > +    Monitor *mon =3D MONITOR(obj);
> > +
> > +    if (mon->ctx && monitor_requires_iothread(mon)) {
> > +        g_autofree char *path =3D object_get_canonical_path(obj);
> > +        const IOThreadHolder io_holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +            .u.qom_object.qom_path =3D path,
> > +        };
> > +
> > +        iothread_unref_and_put_aio_context(mon_iothread, &io_holder);
> > +        mon->ctx =3D NULL;
> > +    }
> > +}
> > +
> >  static void monitor_finalize(Object *obj)
> >  {
> >      Monitor *mon =3D MONITOR(obj);
> > @@ -116,6 +132,8 @@ static void monitor_class_init(ObjectClass *cls, co=
nst void *data)
> >  {
> >      UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(cls);
> >
> > +    cls->unparent =3D monitor_unparent;
> > +
> >      object_class_property_add_str(cls, "chardev",
> >                                    monitor_get_chardev_id,
> >                                    monitor_set_chardev_id);
> > @@ -575,7 +593,7 @@ void monitor_suspend(Monitor *mon)
> >           * Kick I/O thread to make sure this takes effect.  It'll be
> >           * evaluated again in prepare() of the watch object.
> >           */
> > -        aio_notify(iothread_get_aio_context(mon_iothread));
> > +        aio_notify(mon->ctx);
> >      }
> >
> >      trace_monitor_suspend(mon, 1);
> > @@ -715,7 +733,6 @@ char *monitor_compat_id(void)
> >  static void monitor_complete(UserCreatable *uc, Error **errp)
> >  {
> >      Monitor *mon =3D MONITOR(uc);
> > -    AioContext *ctx;
> >
> >      if (mon->chardev_id) {
> >          Chardev *chr =3D qemu_chr_find(mon->chardev_id);
> > @@ -734,11 +751,17 @@ static void monitor_complete(UserCreatable *uc, E=
rror **errp)
> >              mon_iothread =3D iothread_create("mon_iothread", &error_ab=
ort);
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
> > +        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, &i=
o_holder);
> >      } else {
> > -        ctx =3D qemu_get_aio_context();
> > +        mon->ctx =3D qemu_get_aio_context();
> >      }
> > -    mon->accept_input_bh =3D aio_bh_new(ctx, monitor_accept_input, mon=
);
> > +    mon->accept_input_bh =3D aio_bh_new(mon->ctx, monitor_accept_input=
, mon);
> >  }
> >
> >  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index aec0315775..de56345456 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -734,7 +734,8 @@ static void monitor_qmp_complete(UserCreatable *uc,=
 Error **errp)
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
> > @@ -789,7 +790,7 @@ static bool monitor_qmp_prepare_delete(UserCreatabl=
e *uc, Error **errp)
> >
> >      /* Synchronize with in-flight iothread callbacks. */
> >      if (monitor_requires_iothread(mon)) {
> > -        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
> > +        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
> >                              monitor_qmp_iothread_quiesce, NULL);
> >      }
>

