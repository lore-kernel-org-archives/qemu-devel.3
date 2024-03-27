Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E58CD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 02:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJRV-0006cN-OQ; Tue, 26 Mar 2024 22:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJRU-0006c0-Jz
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJRS-0002Ns-S6
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711508105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbUHJTNNynBJmNFPkPf8ijGFABNkSqrjCe9qiuGj8O0=;
 b=ObfO6Vp/JXHls/njZpkB7TXqlT3NqzKIBblSW9lsiNjv6BIeRc9ALVby3qDzQRLjThY815
 foE7pXM6u6+rEg+F7cJ9oAGsxyJ3PmdFmI6nFENCJiF8ARyi4jzITj9qB9y9kQhBTTNbsY
 lRSw5NmEvFfRCU1sYPcT8SInFySvoZM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-CJ1d-RB-PQmmvk_roFyHQg-1; Tue, 26 Mar 2024 22:55:03 -0400
X-MC-Unique: CJ1d-RB-PQmmvk_roFyHQg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5e4a072ce28so5162940a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 19:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711508102; x=1712112902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbUHJTNNynBJmNFPkPf8ijGFABNkSqrjCe9qiuGj8O0=;
 b=mbdOZKb3sNdNJIcUWRuead92nPXD7FTSleqJ3DAhvOpUc93324Ft+1LFk9VLXTPiG9
 8XdqbeUhDz6ASwlclhxYBMmCMsAu8Kw+osiYc2OcTPx5fEk+/4EQwi7k6x2IkJiQwSou
 rkS9nTc7visIZPN4sh5WywvpEhi31mHMhFD/TZwK/M8aljSesYMdTzzsjDMkCMFXYd7T
 zdWZS7xMpYY+gK7ni+Tql3c9p9mzE7AqDMF8c4x93+tftyrhKJQhK4JdozsFzZU/aMXZ
 JH4EytIeC24hvk0gEWWoUNOPDzQ6Luv4NKZwTbUy2Fe6/zn9xvgzV3Hpf2zzg4UV1pWY
 +ncQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWskBeoVI+kDMYjtZ8FnFvcFG9unIVjqL5KJ38NkL+dxlXyuags5z70ffgY+jTqyFvs/B2PoOjgKiEj0zUxoLyz8q6H69o=
X-Gm-Message-State: AOJu0Yws19pfBQIdJC5kFBluALvyBEWPLm9FjJgpHf8ylxYQiK8gg46p
 dsIWqjB/9Ji4nsVQFch0BRtSfjmYLrhpa+h4Jo3ecD1hGFq9+7yMNEv8RAR/NBPhtY1O1+4WrIe
 2Od3ngWTOhigJRe8ehiJUp/Q/WwjeU82jHN79s1knbqlHHgZzkb+KdnWUJ9deWRrf+fxMNAj3Zw
 K9iyB1P6jE6wueuA82rBTSF2wOHWM=
X-Received: by 2002:a05:6a20:2d22:b0:1a3:e23d:6003 with SMTP id
 g34-20020a056a202d2200b001a3e23d6003mr1369163pzl.62.1711508102421; 
 Tue, 26 Mar 2024 19:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCdkz7pAjdbQokp9ZawTOsCWTXC4GM0VkaisRGbsVCoMUQNlbeMayRtOurvSrHIaRDRudacO43O3qIpV6/oB8=
X-Received: by 2002:a05:6a20:2d22:b0:1a3:e23d:6003 with SMTP id
 g34-20020a056a202d2200b001a3e23d6003mr1369155pzl.62.1711508102104; Tue, 26
 Mar 2024 19:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <20240327012905.70188-2-lulu@redhat.com>
In-Reply-To: <20240327012905.70188-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:54:50 +0800
Message-ID: <CACGkMEuAGx+8Aw9kuv_i=GE_fJa2VgbfGA8u-z9h3svAR=JHvQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio-net: disable the configure interrupt for not
 support device
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Only the vdpa device support configure interrupt, we need to disable the
> configure interrupt process in all other device.

I think we need to tweak the terminology here at least.

It's not about configure interrupt, it's about whether or not we can
try to use irqfd for configure interrupt.

Btw, have you tried this on the old kernel that doesn't support
configure interrupt for vDPA?

> In order to achieve this, I added a check in the virtio_net_device_realiz=
e().
> When the peer's type is vdpa, the value of config_irq_enabled in the stru=
cture
> VirtIODevice will set to true.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c        | 5 ++++-
>  hw/virtio/virtio.c         | 1 +
>  include/hw/virtio/virtio.h | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 80c56f0cfc..3b487864a8 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3749,12 +3749,15 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>
>      nc =3D qemu_get_queue(n->nic);
>      nc->rxfilter_notify_enabled =3D 1;
> +    vdev->config_irq_enabled =3D false;

Let's tweak the name of the variable.

But in another thought, there's no easy way to know if vDPA support
configure interrupt at device realization.

We need a graceful fallback or just disable irqfd to configure irq.

>
> -   if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA) {
> +    if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_=
VDPA) {
>          struct virtio_net_config netcfg =3D {};
>          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>          vhost_net_set_config(get_vhost_net(nc->peer),
>              (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONT=
END);
> +
> +        vdev->config_irq_enabled =3D true;
>      }
>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev =3D dev;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 3a160f86ed..6b52a7190d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3255,6 +3255,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t devic=
e_id, size_t config_size)
>              virtio_vmstate_change, vdev);
>      vdev->device_endian =3D virtio_default_endian();
>      vdev->use_guest_notifier_mask =3D true;
> +    vdev->config_irq_enabled =3D false;
>  }
>
>  /*
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c8f72850bc..a7763b71e0 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -164,6 +164,7 @@ struct VirtIODevice
>       */
>      EventNotifier config_notifier;
>      bool device_iotlb_enabled;
> +    bool config_irq_enabled;
>  };
>
>  struct VirtioDeviceClass {

Thanks

> --
> 2.43.0
>


