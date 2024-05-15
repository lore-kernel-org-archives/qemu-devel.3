Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87686C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Gr2-0007pK-N0; Wed, 15 May 2024 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s7Gr1-0007os-1z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:47:43 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s7Gqx-0002xc-Cv
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:47:42 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-69b514d3cf4so77486746d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1715788058; x=1716392858; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3aMlS86Dl/3bZysWGuqJ6qrM9LbitCHCoAdvAVC5wgY=;
 b=ZI2duzIMxeFzkReQN9M4LeqntYA/3Vq9JE/3QGn0beubPDV/5xYu4d3nJe67DCzArP
 i1jGZmxGU1350ClYPMKTxjDKiJz0jMdf0X0owH2ixVnYQoYpB2HE7UWfEsD3GnFsonDF
 BbIKGOvLUvUxOV+ECzp0Umc6RDX3p+V7l7oOTdhEMeNLGTTUvCjTBWA/IQ64SDd0EmQv
 a6V1TD+w7FWu1JfLH/lILs5na7CllZ1ywk+2n9pHD4xNeNOYt0r7uxBNzCXuIFpNeS69
 zBBolSxLPxEKiMzo6cLFQqCV2AiLK17PIqEsiYioYcOAS5rmATEyq/1KtKWzqxBG5663
 om2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715788058; x=1716392858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3aMlS86Dl/3bZysWGuqJ6qrM9LbitCHCoAdvAVC5wgY=;
 b=bdj6ZcnNEjXENpZVBIvweBViVhqZVuVkDdtu9XEwEj0ya72aOPvUgmMDTeejvjvPDD
 5B3o7sewzPoddVN/3kyjKbSEcdrvP/lBWH+gRYNzJGtli/wUmPLJWVBh8HaAmKn0qZnI
 mV9zSOylbqpkXCPwYGWoUGXIM9Jl1EEuI35CfbDtcIe9Aj4eApOjPhrq1KrJMrwwEi0Z
 6ddMxMomAkfimhlJIW3BX9vS8aeNtYau3p944PmawtstrDQSARNisiQzGnlMRwwCvBEd
 QQs41pfPBIZQldVK9t6R7M7EuOZMo+RuRS0QPny5rOlcpo/CZrVd6hStrUYBVuvkPAxI
 leTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwAJDqRI/hMMl5FlHmxc/5WxE+ZN2GienJDDcTIAQfM9OHvzeSfQxdSmbBbykqOXah7ejmgMWTeZSYcdeHhEm7xzi320Y=
X-Gm-Message-State: AOJu0YwaIIeMQyf3QZAMA88C9W6TRj3VEQDVw9/ZILOucePBQ1nAELiz
 tuYvMqm6FTNLdksvUsUH/WNjg1dDlBmpfmENHjoV0QOxVegDQgXg6nGSs3R2kF1BdjIvy8O8BV6
 8Jqk3zkSH3SPaNXX2urYkCaUO+as/FVPWcuCaJA==
X-Google-Smtp-Source: AGHT+IGPqSOo72WEAcuQfAa5IErMZomybwmd8sut9LiF9QoNg/zJZGxxXuOFuicZs2Nxiiz05Ooe6KPCUo9KpFzbuxA=
X-Received: by 2002:a05:6214:3f8b:b0:6a0:5557:b111 with SMTP id
 6a1803df08f44-6a16821a799mr211364546d6.53.1715788057851; Wed, 15 May 2024
 08:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240514061239.86461-1-fengli@smartx.com>
 <20240514061239.86461-2-fengli@smartx.com>
 <CAMDpr=f7=H0-8PAiodcQ-J_MOaEzXmXUbkA_b2uoY36a887_BA@mail.gmail.com>
 <057D1C7C-067A-4660-943B-F3EFFFBEF30B@smartx.com>
In-Reply-To: <057D1C7C-067A-4660-943B-F3EFFFBEF30B@smartx.com>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Wed, 15 May 2024 11:47:27 -0400
Message-ID: <CAMDpr=dO0RsOwbZH+7BMj3kg2P77-1mJaChoGyornBd7qfhXUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Revert "vhost-user: fix lost reconnect"
To: Li Feng <fengli@smartx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=raphael@enfabrica.net; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 15, 2024 at 1:47=E2=80=AFAM Li Feng <fengli@smartx.com> wrote:
>
>
>
> > 2024=E5=B9=B45=E6=9C=8814=E6=97=A5 21:58=EF=BC=8CRaphael Norwitz <rapha=
el@enfabrica.net> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > The code for these two patches looks fine. Just some questions on the
> > failure case you're trying to fix.
> >
> >
> > On Tue, May 14, 2024 at 2:12=E2=80=AFAM Li Feng <fengli@smartx.com> wro=
te:
> >>
> >> This reverts commit f02a4b8e6431598612466f76aac64ab492849abf.
> >>
> >> Since the current patch cannot completely fix the lost reconnect
> >> problem, there is a scenario that is not considered:
> >> - When the virtio-blk driver is removed from the guest os,
> >>  s->connected has no chance to be set to false, resulting in
> >
> > Why would the virtio-blk driver being removed (unloaded?) in the guest
> > effect s->connected? Isn't this variable just tracking whether Qemu is
> > connected to the backend process? What does it have to do with the
> > guest driver state?
>
> Unload the virtio-blk, it will trigger =E2=80=98vhost_user_blk_stop=E2=80=
=99, and in `vhost_dev_stop`
> it will set the `hdev->vdev =3D NULL;`.
>
> Next if kill the backend, the CLOSE event will be triggered, and the `vho=
st->vdev`
> has been set to null before, then the `vhost_user_blk_disconnect` will no=
t have a
> chance to execute.So that he s->connected is still true.

Makes sense - basically if the driver is unloaded and then the device
is brought down s->connected will remain true when it should be false,
which will mess up a subsequent reconnect.

See my comments on the following patch though.

>
> static void vhost_user_async_close_bh(void *opaque)
> {
>     VhostAsyncCallback *data =3D opaque;
>     struct vhost_dev *vhost =3D data->vhost;
>
>     /*
>      * If the vhost_dev has been cleared in the meantime there is
>      * nothing left to do as some other path has completed the
>      * cleanup.
>      */
>     if (vhost->vdev) {  <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D HERE vdev is null.
>         data->cb(data->dev);
>     } else if (data->event_cb) {
>         qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
>                                  NULL, data->dev, NULL, true);
>    }
>
>     g_free(data);
> }
>
> Thanks,
> Li
>
> >
> >>  subsequent reconnection not being executed.
> >>
> >> The next patch will completely fix this issue with a better approach.
> >>
> >> Signed-off-by: Li Feng <fengli@smartx.com>
> >> ---
> >> hw/block/vhost-user-blk.c      |  2 +-
> >> hw/scsi/vhost-user-scsi.c      |  3 +--
> >> hw/virtio/vhost-user-base.c    |  2 +-
> >> hw/virtio/vhost-user.c         | 10 ++--------
> >> include/hw/virtio/vhost-user.h |  3 +--
> >> 5 files changed, 6 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> >> index 9e6bbc6950..41d1ac3a5a 100644
> >> --- a/hw/block/vhost-user-blk.c
> >> +++ b/hw/block/vhost-user-blk.c
> >> @@ -384,7 +384,7 @@ static void vhost_user_blk_event(void *opaque, QEM=
UChrEvent event)
> >>     case CHR_EVENT_CLOSED:
> >>         /* defer close until later to avoid circular close */
> >>         vhost_user_async_close(dev, &s->chardev, &s->dev,
> >> -                               vhost_user_blk_disconnect, vhost_user_=
blk_event);
> >> +                               vhost_user_blk_disconnect);
> >>         break;
> >>     case CHR_EVENT_BREAK:
> >>     case CHR_EVENT_MUX_IN:
> >> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> >> index a63b1f4948..48a59e020e 100644
> >> --- a/hw/scsi/vhost-user-scsi.c
> >> +++ b/hw/scsi/vhost-user-scsi.c
> >> @@ -214,8 +214,7 @@ static void vhost_user_scsi_event(void *opaque, QE=
MUChrEvent event)
> >>     case CHR_EVENT_CLOSED:
> >>         /* defer close until later to avoid circular close */
> >>         vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
> >> -                               vhost_user_scsi_disconnect,
> >> -                               vhost_user_scsi_event);
> >> +                               vhost_user_scsi_disconnect);
> >>         break;
> >>     case CHR_EVENT_BREAK:
> >>     case CHR_EVENT_MUX_IN:
> >> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> >> index a83167191e..4b54255682 100644
> >> --- a/hw/virtio/vhost-user-base.c
> >> +++ b/hw/virtio/vhost-user-base.c
> >> @@ -254,7 +254,7 @@ static void vub_event(void *opaque, QEMUChrEvent e=
vent)
> >>     case CHR_EVENT_CLOSED:
> >>         /* defer close until later to avoid circular close */
> >>         vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
> >> -                               vub_disconnect, vub_event);
> >> +                               vub_disconnect);
> >>         break;
> >>     case CHR_EVENT_BREAK:
> >>     case CHR_EVENT_MUX_IN:
> >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> index cdf9af4a4b..c929097e87 100644
> >> --- a/hw/virtio/vhost-user.c
> >> +++ b/hw/virtio/vhost-user.c
> >> @@ -2776,7 +2776,6 @@ typedef struct {
> >>     DeviceState *dev;
> >>     CharBackend *cd;
> >>     struct vhost_dev *vhost;
> >> -    IOEventHandler *event_cb;
> >> } VhostAsyncCallback;
> >>
> >> static void vhost_user_async_close_bh(void *opaque)
> >> @@ -2791,10 +2790,7 @@ static void vhost_user_async_close_bh(void *opa=
que)
> >>      */
> >>     if (vhost->vdev) {
> >>         data->cb(data->dev);
> >> -    } else if (data->event_cb) {
> >> -        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb=
,
> >> -                                 NULL, data->dev, NULL, true);
> >> -   }
> >> +    }
> >>
> >>     g_free(data);
> >> }
> >> @@ -2806,8 +2802,7 @@ static void vhost_user_async_close_bh(void *opaq=
ue)
> >>  */
> >> void vhost_user_async_close(DeviceState *d,
> >>                             CharBackend *chardev, struct vhost_dev *vh=
ost,
> >> -                            vu_async_close_fn cb,
> >> -                            IOEventHandler *event_cb)
> >> +                            vu_async_close_fn cb)
> >> {
> >>     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
> >>         /*
> >> @@ -2823,7 +2818,6 @@ void vhost_user_async_close(DeviceState *d,
> >>         data->dev =3D d;
> >>         data->cd =3D chardev;
> >>         data->vhost =3D vhost;
> >> -        data->event_cb =3D event_cb;
> >>
> >>         /* Disable any further notifications on the chardev */
> >>         qemu_chr_fe_set_handlers(chardev,
> >> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-=
user.h
> >> index d7c09ffd34..324cd8663a 100644
> >> --- a/include/hw/virtio/vhost-user.h
> >> +++ b/include/hw/virtio/vhost-user.h
> >> @@ -108,7 +108,6 @@ typedef void (*vu_async_close_fn)(DeviceState *cb)=
;
> >>
> >> void vhost_user_async_close(DeviceState *d,
> >>                             CharBackend *chardev, struct vhost_dev *vh=
ost,
> >> -                            vu_async_close_fn cb,
> >> -                            IOEventHandler *event_cb);
> >> +                            vu_async_close_fn cb);
> >>
> >> #endif
> >> --
> >> 2.45.0
> >>
>

