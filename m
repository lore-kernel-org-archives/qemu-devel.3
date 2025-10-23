Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51391CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 05:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBns3-0005M7-32; Thu, 23 Oct 2025 01:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vBns0-0005LQ-Pk
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vBnry-0008E0-Ei
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761197291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTqu3y35rfRJvZkb26SlJGntnowj/Ehh2Wo1fQVQYOE=;
 b=QC/sK80kk6rFmaPRSCuR2Db0BRKRsYbuv6b023xZ8xOQyByqALzUqq+Jy3rvu7pCJ/u+n0
 1YH0AdYPV1LYW4vUOMrDXWk2NzPcfSFPBQlfr1Upk/Jf0DT3aFtJcGKKXhIEroWgiB32zW
 1QiJzAcHC3HKN2hNfb4pO8sW4mKOJ54=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-Vs1BW3exNVKG8FvFH8G63Q-1; Thu, 23 Oct 2025 01:28:09 -0400
X-MC-Unique: Vs1BW3exNVKG8FvFH8G63Q-1
X-Mimecast-MFC-AGG-ID: Vs1BW3exNVKG8FvFH8G63Q_1761197289
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63e1e96b6d3so446218d50.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 22:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761197289; x=1761802089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTqu3y35rfRJvZkb26SlJGntnowj/Ehh2Wo1fQVQYOE=;
 b=lTxCI1dBoGQvWIv04cG1RPA47SrWE63JsOwGjj2tftdP5Cd3yDsCTASSjBsOBBrPeY
 AugDfT0hvvrT6q381//57dBiiy2I9PEExUXqBxOh77WbSuhdDCTPI96cxYx1FicVT7ys
 XnWcnxLlTWcY0lKHtTUjnW2WcWMu8A/ClyPAGxQ//HXkNGVwLXjZWiSVMFr85T8pL/dT
 tJ4/FNkSuMOHxtOt07+Y0Axv8wXE2FcNLbgZmdccGaJgLGgXLDd1uH/7cHRyLX+2JBBF
 O7Nyxa1DJoLMTePgYjJtT5joADtkQ4rbS77EsQUtJqDaA18QORHJCKkBtGyURGgfdQR1
 +dBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHnOSPJIYWEnEfKF1g7TPYXsZq6q0fYZFU9v5bialHAQlhZxhbayL9OEnEFJsACE5jkkoSnt59HOP4@nongnu.org
X-Gm-Message-State: AOJu0YxhazKEM+hRRhYnZeEKWN0NKve+WuyJYuxBH/JLxKZ2vbGORlEN
 6t8uU90J5bwCApeFUPdcb3XgK3rDwtAGu3hcp7JwCdBvHNteYJXcE0r7KMtrn8UZ1HTbnlINEfC
 RYNdlYtjBUl0fjtn0pJRUvbvp/jkhzEPlcZQOQ/ualTGfHUDgqC9gbElaN4vnk5++kgY2LiX2Ps
 FdrQDWAvX2bt3+u0iLquJu5c7/xPtWqM4=
X-Gm-Gg: ASbGncuFBpVNiJrguglMiLZS1g4M0DnNQDhXcvnx1dJFdXGMUOMbETyEaPeTavVWHed
 XGoPXIg1MVMO74vLSuAR1ed6O8S248dydAmwuxolLil49RO3udV/rwPhy5EP3Zjir7gFzR0gZmx
 iJ2q7psb1QtL+EB9+tARtO6aM0q+L9WNRuxiDV/yVAX1fT9fxA9S7AC3fUN9RVxDAcmehpFkJPH
 59xkWVWvhVHKgqXRDjkVLJgI8vakJehgNLICU8Shuk=
X-Received: by 2002:a05:690e:d56:b0:63e:de8:7327 with SMTP id
 956f58d0204a3-63f37820cdcmr912687d50.29.1761197289202; 
 Wed, 22 Oct 2025 22:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyX/z79BLLMoO6FfLxbo/Y+IXNRg2oJhqMRUqfTiC52X4LJ1ykTQD0giPLHhG+PZVBwtmdHB6r5YcmW93MlBw=
X-Received: by 2002:a05:690e:d56:b0:63e:de8:7327 with SMTP id
 956f58d0204a3-63f37820cdcmr912680d50.29.1761197288901; Wed, 22 Oct 2025
 22:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251022133228.301365-1-gmaglione@redhat.com>
 <CAJaqyWccaCUfQLzQXdX+3+sQNz+-AjSvqmCignXR+URfz7FHww@mail.gmail.com>
 <den4gz23dnkg6eyjmfoflujd2oimw7ktxoz6ha727ei576w2iw@ei6aogzv6bt6>
 <CAJh=p+7m-_rOh_y8GCnK5ogS0fWjn+DrOrsPngeJr=+xsiFmbQ@mail.gmail.com>
In-Reply-To: <CAJh=p+7m-_rOh_y8GCnK5ogS0fWjn+DrOrsPngeJr=+xsiFmbQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 23 Oct 2025 07:27:32 +0200
X-Gm-Features: AS18NWDC8yJf8ttKp_G-jKKxwLfHntnp0YH7ITM0fVpuKLbDAXC_iNnhAezJULY
Message-ID: <CAJaqyWdZWjzZGGG9ziPuaiqBENAwx1yiXkNiKdE2sBSV1=+Whg@mail.gmail.com>
Subject: Re: [PATCH] Make vhost_set_vring_file() synchronous
To: German Maglione <gmaglione@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org, 
 Hanna Czenczek <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 22, 2025 at 6:24=E2=80=AFPM German Maglione <gmaglione@redhat.c=
om> wrote:
>
> On Wed, Oct 22, 2025 at 4:04=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 03:49:25PM +0200, Eugenio Perez Martin wrote:
> > >On Wed, Oct 22, 2025 at 3:32=E2=80=AFPM <gmaglione@redhat.com> wrote:
> > >>
> > >> From: German Maglione <gmaglione@redhat.com>
> > >>
> > >> QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
> > >> setting the NEED_REPLY flag, i.e. by the time the respective
> > >> vhost_user_set_vring_*() function returns, it is completely up to ch=
ance
> > >> whether whether the back-end has already processed the request and
> > >> switched over to the new FD for interrupts.
> > >>
> > >> At least for vhost_user_set_vring_call(), that is a problem: It is
> > >> called through vhost_virtqueue_mask(), which is generally used in th=
e
> > >> VirtioDeviceClass.guest_notifier_mask() implementation, which is in =
turn
> > >> called by virtio_pci_one_vector_unmask().  The fact that we do not w=
ait
> > >> for the back-end to install the FD leads to a race there:
> > >>
> > >> Masking interrupts is implemented by redirecting interrupts to an
> > >> internal event FD that is not connected to the guest.  Unmasking the=
n
> > >> re-installs the guest-connected IRQ FD, then checks if there are pen=
ding
> > >> interrupts left on the masked event FD, and if so, issues an interru=
pt
> > >> to the guest.
> > >>
> > >> Because guest_notifier_mask() (through vhost_user_set_vring_call())
> > >> doesn't wait for the back-end to switch over to the actual IRQ FD, i=
t's
> > >> possible we check for pending interrupts while the back-end is still
> > >> using the masked event FD, and then we will lose interrupts that occ=
ur
> > >> before the back-end finally does switch over.
> > >>
> > >> Fix this by setting NEED_REPLY on those VHOST_USER_SET_VRING_* messa=
ges,
> > >> so when we get that reply, we know that the back-end is now using th=
e
> > >> new FD.
> > >>
> > >
> > >Fixes: 5f6f6664bf24 ("Add vhost-user as a vhost backend.") ?
> > >
> > >> Signed-off-by: German Maglione <gmaglione@redhat.com>
> > >> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > >> ---
> > >>  hw/virtio/vhost-user.c | 18 +++++++++++++++++-
> > >>  1 file changed, 17 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > >> index 36c9c2e04d..641960293b 100644
> > >> --- a/hw/virtio/vhost-user.c
> > >> +++ b/hw/virtio/vhost-user.c
> > >> @@ -1327,8 +1327,11 @@ static int vhost_set_vring_file(struct vhost_=
dev *dev,
> > >>                                  VhostUserRequest request,
> > >>                                  struct vhost_vring_file *file)
> > >>  {
> > >> +    int ret;
> > >>      int fds[VHOST_USER_MAX_RAM_SLOTS];
> > >>      size_t fd_num =3D 0;
> > >> +    bool reply_supported =3D virtio_has_feature(dev->protocol_featu=
res,
> > >> +                                              VHOST_USER_PROTOCOL_F=
_REPLY_ACK);
> > >
> > >Why not use  directly?
> >
> > I was about to suggest the same thing, but IIUC does not support passin=
g
> > fds.
> >
> > However, yes, I agree that we should extend vhost_user_write_sync() in
> > another patch and then use it either here and in other places (e.g.
> > vhost_user_set_mem_table(), vhost_setup_backend_channel()).
> >
> > But maybe that could be a follow-up later, since this is a fix to
> > backport without touching too much code around. Up to German and you,
> > I'm fine with both.
>
>
> If you don't mind, I prefer to keep this as small as possible, and extend
> vhost_user_write_sync() in a follow-up
>

Absolutely, it makes sense.

Out of curiosity, what about using the vhost_user_get_features trick
to also support backends without VHOST_USER_PROTOCOL_F_REPLY_ACK?


