Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133B6C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 14:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryBgd-0008Tm-AS; Sat, 20 Apr 2024 10:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ryBgb-0008Ta-Cb
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 10:27:25 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ryBgY-0004lb-PA
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 10:27:25 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c74b643aebso893215b6e.0
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713623236; x=1714228036;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql0RZWsx9a3iEbBA/3UrQ0kIKn/4BT8jqSnMDWoBr8Y=;
 b=d5S3fO8d1hTTfaI1aXfSCxXMRM0BDBsoxoARmnJeHGE1/ZKtjuuT6dne4rVetoYvxu
 MfWmWWtgUcL/9ppxjyHUYnDwaKibEqp9g80pQ54AWACk5AfdxM/GqoWKwajfZXFJ5kUP
 zENB6jMWd7lJXSnOcdNWT4v36e/QB2l7xnbUHIG6/TA9jFh1f2fkGj2JTjSQj+onXhB3
 L0wlyH8uCIfHPVz0qO0uFEy8w9EJekjNc6pTO7Wvq1extGjdB3kvTrYpjctCurJWA2Fb
 m5meRw/671U6G2l/RB4oSrkufXwjrxxEV/wLtBBYIGMpEiYd0/I6UrtvvzQaXNT+Wl+t
 RfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713623236; x=1714228036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ql0RZWsx9a3iEbBA/3UrQ0kIKn/4BT8jqSnMDWoBr8Y=;
 b=JtGxFg552CZfaIojKvVSZ8kR2OASoJLjTq7+oS4uB6PPNfDGq6KaKE2dCM9ZXrEYmm
 HbdfJ0M75cI3Xr4GjUa2yKdNP+HPlezkOei2pQov7hmZLsyereux1Xaxz+EzFVwf1K7B
 BRt2eMCfVdvjOjUB6u08OOUribNZ8EKCNg37HUe4FMf6TaREucq1GlfRVMTwPDjsiyQJ
 TEHTKDIOdbHHcvAiQa/KzlZIZiZriWU4G7AvbEdO3Qw4VVZvOsokq8mDgCL9X912dcxd
 DiDL46yAYA4oSAGZ7hG6yRPRCnbN9qGfBU5GZ+SNSe+za/k5iuf6XxjVhIIuVlxS4+4+
 meCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiNdKDLYyCmJJNg9Wu9gGgdX+taFQrxeuIp+5XRRXZ48aMWEUaxM203jyKGMlQ1iRwwwnCmhw3YixOzRvRRwX7t2cQJCY=
X-Gm-Message-State: AOJu0Yw+ZTGTF0WHdBDETVH5CAjoq2LJyAZAmfcflsOdS/sm4yIeNZVg
 W/WqQfcYhaDdfJ/5qUf6X5nu6MhJpQ90mTKEih7s+i9br1XNr2gXW91dYj71GQL0Vh7TGVLpzQj
 ATj1snJ8QZSF1yn2LQ0YBj1WrQIQE9Wb5ZF7bSw==
X-Google-Smtp-Source: AGHT+IGsb2nPRpCtfrq4VspKltJaJr+MZ4ThwXwvQLs1ihLuu52CODrFzqOTrvJpQdcIvYBmt4VJWLKB45gCaoar4Yg=
X-Received: by 2002:a05:6808:2808:b0:3c7:4fd4:ae76 with SMTP id
 et8-20020a056808280800b003c74fd4ae76mr3184119oib.10.1713623236637; Sat, 20
 Apr 2024 07:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
 <CAOEp5OeXLFTUsH5egdMfsEPACM0O2XODOeYbpggD0T2Zv6ceYQ@mail.gmail.com>
 <CACGkMEuG5mDzU-UwHvrZ3TWvZ9rpDWN-Vuw0GPE+_9nEkr6jdw@mail.gmail.com>
 <dabf20e9-1002-469e-b255-d3954bf8cf3d@daynix.com>
In-Reply-To: <dabf20e9-1002-469e-b255-d3954bf8cf3d@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sat, 20 Apr 2024 17:27:04 +0300
Message-ID: <CAOEp5Oc0k6BhcJSPKrnWwfh+6CVjJQicnt304=Rukfu0Rtef5g@mail.gmail.com>
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 16, 2024 at 9:54=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/04/16 13:00, Jason Wang wrote:
> > On Mon, Apr 15, 2024 at 10:05=E2=80=AFPM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> >>
> >> On Wed, Apr 3, 2024 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>>
> >>> vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> >>> implicitly disables RSS even if the user explicitly requests it. Retu=
rn
> >>> an error instead of implicitly disabling RSS if RSS is requested but =
not
> >>> available.
> >>>
> >>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>> ---
> >>>   hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++----------------=
-----------
> >>>   1 file changed, 48 insertions(+), 49 deletions(-)
> >>>
> >>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>> index 61b49e335dea..3d53eba88cfc 100644
> >>> --- a/hw/net/virtio-net.c
> >>> +++ b/hw/net/virtio-net.c
> >>> @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODev=
ice *vdev, uint64_t features,
> >>>           return features;
> >>>       }
> >>>
> >>> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> >>> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> >>> -    }
> >>>       features =3D vhost_net_get_features(get_vhost_net(nc->peer), fe=
atures);
> >>>       vdev->backend_features =3D features;
> >>>
> >>> @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(Devic=
eListener *listener,
> >>>       return qatomic_read(&n->failover_primary_hidden);
> >>>   }
> >>>
> >>> +static void virtio_net_device_unrealize(DeviceState *dev)
> >>> +{
> >>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >>> +    VirtIONet *n =3D VIRTIO_NET(dev);
> >>> +    int i, max_queue_pairs;
> >>> +
> >>> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> >>> +        virtio_net_unload_ebpf(n);
> >>> +    }
> >>> +
> >>> +    /* This will stop vhost backend if appropriate. */
> >>> +    virtio_net_set_status(vdev, 0);
> >>> +
> >>> +    g_free(n->netclient_name);
> >>> +    n->netclient_name =3D NULL;
> >>> +    g_free(n->netclient_type);
> >>> +    n->netclient_type =3D NULL;
> >>> +
> >>> +    g_free(n->mac_table.macs);
> >>> +    g_free(n->vlans);
> >>> +
> >>> +    if (n->failover) {
> >>> +        qobject_unref(n->primary_opts);
> >>> +        device_listener_unregister(&n->primary_listener);
> >>> +        migration_remove_notifier(&n->migration_state);
> >>> +    } else {
> >>> +        assert(n->primary_opts =3D=3D NULL);
> >>> +    }
> >>> +
> >>> +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> >>> +    for (i =3D 0; i < max_queue_pairs; i++) {
> >>> +        virtio_net_del_queue(n, i);
> >>> +    }
> >>> +    /* delete also control vq */
> >>> +    virtio_del_queue(vdev, max_queue_pairs * 2);
> >>> +    qemu_announce_timer_del(&n->announce_timer, false);
> >>> +    g_free(n->vqs);
> >>> +    qemu_del_nic(n->nic);
> >>> +    virtio_net_rsc_cleanup(n);
> >>> +    g_free(n->rss_data.indirections_table);
> >>> +    net_rx_pkt_uninit(n->rx_pkt);
> >>> +    virtio_cleanup(vdev);
> >>> +}
> >>> +
> >>>   static void virtio_net_device_realize(DeviceState *dev, Error **err=
p)
> >>>   {
> >>>       VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >>> @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceS=
tate *dev, Error **errp)
> >>>
> >>>       net_rx_pkt_init(&n->rx_pkt);
> >>>
> >>> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> >>> -        virtio_net_load_ebpf(n);
> >>> -    }
> >>> -}
> >>> -
> >>> -static void virtio_net_device_unrealize(DeviceState *dev)
> >>> -{
> >>> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >>> -    VirtIONet *n =3D VIRTIO_NET(dev);
> >>> -    int i, max_queue_pairs;
> >>> -
> >>> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> >>> -        virtio_net_unload_ebpf(n);
> >>> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> >>> +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
> >>> +        virtio_net_device_unrealize(dev);
> >>> +        error_setg(errp, "Can't load eBPF RSS for vhost");
> >>>       }
> >>
> >> As I already mentioned, I think this is an extremely bad idea to
> >> fail to run qemu due to such a reason as .absence of one feature.
> >> What I suggest is:
> >> 1. Redefine rss as tri-state (off|auto|on)
> >> 2. Fail to run only if rss is on and not available via ebpf
> >> 3. On auto - silently drop it
> >
> > "Auto" might be promatic for migration compatibility which is hard to
> > be used by management layers like libvirt. The reason is that there's
> > no way for libvirt to know if it is supported by device or not.
>
> Certainly auto is not good for migration, but it is useful in the other
> situations. You can still set "on" or "off" if you care migration. I'll
> add "auto" support in the next version.

It will be very nice if you take this patch to separate series, all
others will pass without questions, I think.

Thanks,
Yuri Benditovich

>
> >
> > Thanks
> >
> >> 4. The same with 'hash' option - it is not compatible with vhost (at
> >> least at the moment)
> >> 5. Reformat the patch as it is hard to review it due to replacing
> >> entire procedures, i.e. one patch with replacing without changes,
> >> another one - with real changes. >> If this is hard to review only for=
 me - please ignore that.
>
> I'll split this patch accordingly in the next version.
>
> Regards,
> Akihiko Odak

