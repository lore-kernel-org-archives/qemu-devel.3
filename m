Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C48C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx9XS-00021z-MH; Thu, 20 Aug 2026 16:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wx9XR-00021V-7L
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:39:01 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wx9XP-0006Se-Ct
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:39:00 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-51bfad59921so1770961cf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787258338; cv=none;
 d=google.com; s=arc-20260327;
 b=GTrx0RLJBdFVx9MdDXSD/aJ3m+88topdupF0cBCfarv9ktMViMmAxc7MiTkuhNOqrk
 nJMnVNwVi+3Njo3vMZ7wxa/p9Nnm1LUn0FVVY8nF2VGAz1+lPAxZSshrQhmvWoxSQ43q
 ADV6AUpk1yjLha3bRi4C6wP1RbHKW5fwBBIXUH2m3u3B9FcFmVynIe7kt0XjuM0A5Gp2
 umhBLHJQHhNQaXeNPoyZml33EeN1qXkpBCQmaoOUMOQykHm4SITCEKB31guyy8CZJzVp
 5NGtgi/RtET9ndIJVxMXaLGLoyCo8enG2nZmxTpDJO8+n7PpkFADgLQC7k7ZjiKC2Ugt
 aHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yw/70XDHxmOe5vI6aQ6n4t71n8LG9vKd/gcLCxbLG5Y=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=UUgfC8cGJvwoWRmjtcI/hFiDfb5X/pqp52ckVsuIMqPwWr1NvxTymaOX4zJ2m2+J6/
 SztdL33Nfd3mD04QnFTeqIiGZqbM6cWYwWVjYZ+yFCWFhC0nZZsSV7aeeq9FvOmhrlpt
 KugYWU3u42ZHnj8alkrf4TuWmE5s9EqZBCgvJwOjtaHVrNUvuq+gICeBNhi1Oe0mboxQ
 b8RQw2kkWnmapg43HmUEmsw6MNPYRD6hIK9X0evGSU7jNQhTK3rJz7IduoJJaCJATRpU
 VLCoKMiSpoJJBv+mYzOkQNmGBdUmpaV70JKM6jkLzr42g74NS2gqD90vpSjrUwR3HtAe
 bFtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787258338; x=1787863138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yw/70XDHxmOe5vI6aQ6n4t71n8LG9vKd/gcLCxbLG5Y=;
 b=Eb0NmmDsiOXkvM0j+eOGQpBcXhjrKsuq43BBNQe/urZiBJXqf7nblL0AIfprrFVRxP
 VuNJzOMUW8x6zTe6t5D2shyTRE3FWvsIWH5dPd/ZfAPkF6rduZbUzn+jfTzuXXEXrQWU
 PglEOpLb/xAbs1/4ctps1irS13uY35R8D3+WrOQkhjg6xQ4w3/ZRMhCT9a+FBtWnFWUL
 3gG7GGssXm8pGTwiU4/b43k+6JvkFWRep4/x0+ZyCfT9q8vkrKRvRMgMspC9tDrrqaWc
 R1HcWQTeU65qmDau/i3uNkU/3qOdBzjMscGPeI7W2dfDTfJauwiX4bcppnk2YuB7BMTD
 KkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787258338; x=1787863138;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yw/70XDHxmOe5vI6aQ6n4t71n8LG9vKd/gcLCxbLG5Y=;
 b=JY0w5XFC/0y0U9XLOjWSpSuh+9n/pyeCHvTCeOwuFrcvsxZtjAdGRnmglRiQuqFSG4
 G9yjWa16ENq588V6cGoCHhTTdVXPmAnGPLjzfmMJQZKKpw2Ib8fAVYHfHerfVKi5SAHV
 BaEWL1kEn4IY33HR0Y555KhMDoLz6ogJRPOnmMbPe/l8/DTT4G9Xr5RIJuXP/XxWCfEu
 bLsYzXQbToMccPIziuHbUbEXvFq9CvO3gs83EE51Y9GDWlHCE1N7d2CyBYogRTx9khU7
 P/c4/lF/26tnrkKyDhIjQKfGbr9U8fVb9gkNMZHollygpjI39faLlI8ZHE62lG4MUufm
 U30w==
X-Gm-Message-State: AOJu0YzN5AoavwELWFGfa2ltJfygQjnh/a0y3putJr3NUxCYzGmxDlYr
 usuLj1A+aB5luUti/KSservHlBhbk5cRF7y7uIOVLj9DTAAmstz/waxb5Rlo54CgiNfd8RBQLHV
 XGnxQ0gLrILjMRtKgwD8FG9Xgl+Kh3gM=
X-Gm-Gg: AR+sD12wQzf0DN4m71RK3VpSVTYjbc0B51vNYC7bqwlTwyOmD7+lZj1ycPh0XI5lfSd
 TvY68bpqUH4GF/1yZpdvl2jTTeTWeCdDVjNhvVSMgHXX8ZRC/J6mRPfWMJxJZfp9z2EtPa86YPn
 1v+NBCJ/kwpgCT1Fr9A4UIWu0VZ225RB1F9dGFIYp5pPcC1ofGIui68y/5C3fgxK9YUm4u8yJR3
 cYtrbAhSC8Dz3YJMU/9OtavQ1BZdCvFpA8mT7JFuYZ/XOANiu5ZNa3R5k4frJ8zPJcftKJjm4bQ
 z2IX4zBt8nYOZuf9+Nzd/Z+p9T1ECd8wQx99q8wZJPHailrnS3T/Ss44Ef2fY16VoBurQpW2Zt5
 g8jM=
X-Received: by 2002:a05:622a:1b28:b0:51b:ecca:f2e0 with SMTP id
 d75a77b69052e-52df56f7dfamr12524441cf.5.1787258338304; Thu, 20 Aug 2026
 13:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-9-948aae960abb@gmail.com>
 <7b4d2e3d-4593-492c-887a-db560d590ac6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7b4d2e3d-4593-492c-887a-db560d590ac6@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 20 Aug 2026 13:38:47 -0700
X-Gm-Features: AcwNN1VXrXAFLHLrkZHM8t6w7717j2YQmN1Mi7V8JgTbf-cGaUWANLEc02NuWF8
Message-ID: <CA+spn3qzO_d5n9AOLyhRRu1Tz-ANyh5OfQJgCJP4Dn1+wDptug@mail.gmail.com>
Subject: Re: [PATCH RFC v2 09/13] hw/virtio/vhost-user: add shadow virtqueues
 and eventfd intercepts
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 18, 2026 at 5:35=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
>
> A whitespace problem remains here.
>

Got it!  This is fixed now

> >   } IsolationModeCtx;
> >
> >   struct vhost_user {
> > @@ -1128,15 +1130,38 @@ static int vhost_user_set_mem_table_postcopy(st=
ruct vhost_dev *dev,
> >       return 0;
> >   }
> >
> > -static void cleanup_isolation_regions(struct vhost_dev *dev)
> > +static void vhost_user_svq_cleanup(struct vhost_user *u, bool reset)
> > +{
> > +    VhostShadowVirtqueue *svq;
> > +    for (int i =3D 0; i < u->iso_mem_ctx.shadow_vqs->len; i++) {
> > +        svq =3D g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, i);
> > +        vhost_svq_stop(svq);
> > +        event_notifier_cleanup(&svq->hdev_call);
> > +        event_notifier_cleanup(&svq->hdev_kick);
> > +    }
> > +
> > +    if (!reset) {
> > +        g_ptr_array_free(u->iso_mem_ctx.shadow_vqs, true);
> > +    }
> > +}
> > +
> > +static void cleanup_isolation_regions(struct vhost_dev *dev, bool rese=
t)
> >   {
> >       struct vhost_user *u =3D dev->opaque;
> >       if (u->iso_mem_ctx.shared_mem_addr) {
>
> If vhost_dev_init() fails after vhost_user_init_svq(), shadow_vqs is
> present but shared_mem_addr is not because init_isolation_regions() is
> not called yet. shadow_vqs will be leaked then.
>

Good catch!  The call to vhost_user_svq_cleanup will be moved out of
the conditional statement so it always runs during cleanup.  I also
realized that it is possible for an error to occur after the call to
qemu_memfd_alloc but before the iova tree is allocated, so I am adding
a check before calling vhost_iova_tree_delete.

> > +        vhost_user_svq_cleanup(u, reset);
> >           vhost_iova_tree_delete(u->iso_mem_ctx.tree);
> >           qemu_memfd_free(u->iso_mem_ctx.shared_mem_addr,
> >                           u->iso_mem_ctx.size,
> >                           u->iso_mem_ctx.fd);
> > +
> > +        GPtrArray *temp =3D u->iso_mem_ctx.shadow_vqs;
>
> This is a mixed declaration prohibited in docs/devel/style.rst

Got it!  I will fix this.

>
> >           memset(&u->iso_mem_ctx, 0, sizeof(IsolationModeCtx));
> > +
> > +        if (!reset) {
>
> This condition is inverted. When reset is true, vhost_user_svq_cleanup()
> retains the array so the pointer to it should be kept.
>

You are right!  This is now fixed

...

> >   static int vhost_user_set_vring_kick(struct vhost_dev *dev,
> >                                        struct vhost_vring_file *file)
> >   {
> > -    int ret =3D vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, f=
ile);
> > +    struct vhost_user *u =3D dev->opaque;
> > +    int svq_idx =3D file->index - dev->vq_index;
> > +    VhostShadowVirtqueue *svq =3D NULL;
> > +    struct vhost_vring_file vr_file =3D *file;
> > +    int ret;
> > +
> > +    vhost_user_get_vq_index(dev, file->index); /* bounds checking */
> > +
> > +    if (u->user->memory_isolation) {
> > +        svq =3D g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, svq_idx);
> > +        vhost_svq_set_svq_kick_fd(svq, file->fd);
>
> The svq->svq_kick EventNotifier is left set in the error paths.
>

I did not want to close the svq_kick notifier, since it shares its fd
with the host notifier in the underlying vq, and closing that from
here might be unexpected.  However, a safer alternative is probably to
call vhost_svq_set_svq_kck_fd with -1 to simply unbind the notifier,
which I suspect is what you are actually recommending here.

> Regards,
> Akihiko Odaki
>
...

> > @@ -1769,7 +1835,35 @@ static int vhost_user_set_vring_kick(struct vhos=
t_dev *dev,
> >   static int vhost_user_set_vring_call(struct vhost_dev *dev,
> >                                        struct vhost_vring_file *file)
> >   {
> > -    return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, file);
> > +    struct vhost_user *u =3D dev->opaque;
> > +    int svq_idx =3D file->index - dev->vq_index;
> > +    VhostShadowVirtqueue *svq =3D NULL;
> > +    struct vhost_vring_file vr_file =3D *file;
> > +    int ret;
> > +
> > +    vhost_user_get_vq_index(dev, file->index); /* bounds checking */
> > +
> > +    if (u->user->memory_isolation) {
> > +        svq =3D g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, svq_idx);
> > +        vhost_svq_set_svq_call_fd(svq, file->fd);
> > +
> > +        if (file->fd !=3D -1) {
> > +            if (!svq->hdev_call.initialized) {
> > +                ret =3D event_notifier_init(&svq->hdev_call, 0);
> > +                if (ret < 0) {
> > +                    event_notifier_cleanup(&svq->hdev_call);
> > +                    error_report("Failed to create call event notifier=
");
> > +                    return ret;
> > +                }
> > +            }
> > +
> > +            vr_file.fd =3D event_notifier_get_fd(&svq->hdev_call);
> > +        } else {
> > +            event_notifier_cleanup(&svq->hdev_call);
> > +        }
> > +    }
> > +
> > +    return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, &vr_fi=
le);
>
> Clean up svq->hdev_call when this fails.
>

Did you mean cleanup svq->svq_call, similar to your feedback on
svq->svq_kick?  I believe svq->hdev_call already gets cleaned up on
failure.  I'll go ahead and add a call to vhost_svq_set_svq_call_fd
with fd=3D-1 here as well.

Thank you!
Connor

