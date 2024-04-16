Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887D8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 07:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwd1D-0000oz-CK; Tue, 16 Apr 2024 03:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwd1B-0000oa-Aw
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwd13-00038V-0o
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713251641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cS9sYn2KSxDbKqb8zp4FbcF8t/DxN0jdIivMEbcc7c=;
 b=faLW9kVWN+BEfuAqJs2j7SJ+wJknn0oijdaoPiXsNe4gqgcDERcYQAsmhjVtGGcc20bqSF
 LQN4e2FkY4h1wLnwLy/0ssAFlOntCcgBh2qqP8JX8hQwpxHLupdm9J/BcEwYX/y3DMrUyY
 wsdqbo8Bj0S/uQ5hLmluIFJ9fgX82zI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389--v4llHEBPzaP-RTigYKU_g-1; Tue, 16 Apr 2024 03:13:59 -0400
X-MC-Unique: -v4llHEBPzaP-RTigYKU_g-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c65e666609so4051340a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 00:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713251638; x=1713856438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cS9sYn2KSxDbKqb8zp4FbcF8t/DxN0jdIivMEbcc7c=;
 b=K+4ui2jKUvgLNke6Zec1jBo9xwCdrqPSGRpUiOYT9gfkyUp1Q/r2BTVDxHsI9OGmSL
 ii7zEcZb3XxK/SheWBPPNMeSoXLFHOeNbfSQtuBN889JlIFvKJ9aeDmuCl8M78KXqIds
 LMOclieD/7jclEhvCkyeViIZIDORITlBaywZGXQ9/+0/pMrz94Jkrjlr9888Ft3IDPwl
 zSEXtq9jdk0BF5vaHH2jItT3CeJ3BQj0GeGqDTZjMeoV/KMNd7n4u+D5GZnkkg/J9thV
 TeaAO/5Ls3ju1WHjCjeQ18tFCJjLGekUM2ydWqvzr2TKgVZKBsDFJE8CVmaxigedysdt
 OQ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ4QP3eBmNoqYh62js+3zsJV3F8AsvGhOhN1fLRjMaE7hIYfRJYYLE8BRJ9S876eB0LmtXTLOrJbagw3plN4wXVRKIbg4=
X-Gm-Message-State: AOJu0Ywyfdf9Q2eTI1OwV6jO0VVI/6QxMoShMasSvbOvB4ZhtgSk+u3v
 ImTbkoI8yNe7uUfJMCh5e+LoaCvbpb9xzwle0vPNGikK5MOHD0k1O4Mg+xD8HWGfRiYWW9B9UtX
 7bbUIlASCxd2BWhTSCNlUc3m5vWtbAX8lWjDdh0EcbbZrqaWOmyyO+SdhC++zx8Zg3TDYU4W7KJ
 SKOBX+7rYrrzfqEDRSLjcOtr8HTI8=
X-Received: by 2002:a05:6a20:6891:b0:1a9:8251:41ba with SMTP id
 n17-20020a056a20689100b001a9825141bamr10864884pzj.51.1713251638041; 
 Tue, 16 Apr 2024 00:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ6O2uNfGq9bwH5xmnml+vwHC7ElptS/nSG6R5yhYFzWDvsZo6R9HXg5aRUEcTBx8+y/1F7qamawFySwdF7JU=
X-Received: by 2002:a05:6a20:6891:b0:1a9:8251:41ba with SMTP id
 n17-20020a056a20689100b001a9825141bamr10864873pzj.51.1713251637637; Tue, 16
 Apr 2024 00:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
 <CAOEp5OeXLFTUsH5egdMfsEPACM0O2XODOeYbpggD0T2Zv6ceYQ@mail.gmail.com>
 <CACGkMEuG5mDzU-UwHvrZ3TWvZ9rpDWN-Vuw0GPE+_9nEkr6jdw@mail.gmail.com>
 <CAOEp5OcsP+-wtbJcinAXE=We_52HwmpHxX93FUsAFrjVNPge_Q@mail.gmail.com>
In-Reply-To: <CAOEp5OcsP+-wtbJcinAXE=We_52HwmpHxX93FUsAFrjVNPge_Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 15:13:44 +0800
Message-ID: <CACGkMEuT7Dw4p-gKTefrw4LwmXv2cKde_gKxVb0TF7PHA+63MA@mail.gmail.com>
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Apr 16, 2024 at 1:43=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Tue, Apr 16, 2024 at 7:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Apr 15, 2024 at 10:05=E2=80=AFPM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> > > >
> > > > vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> > > > implicitly disables RSS even if the user explicitly requests it. Re=
turn
> > > > an error instead of implicitly disabling RSS if RSS is requested bu=
t not
> > > > available.
> > > >
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > ---
> > > >  hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++---------------=
------------
> > > >  1 file changed, 48 insertions(+), 49 deletions(-)
> > > >
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index 61b49e335dea..3d53eba88cfc 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIOD=
evice *vdev, uint64_t features,
> > > >          return features;
> > > >      }
> > > >
> > > > -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> > > > -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> > > > -    }
> > > >      features =3D vhost_net_get_features(get_vhost_net(nc->peer), f=
eatures);
> > > >      vdev->backend_features =3D features;
> > > >
> > > > @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(Dev=
iceListener *listener,
> > > >      return qatomic_read(&n->failover_primary_hidden);
> > > >  }
> > > >
> > > > +static void virtio_net_device_unrealize(DeviceState *dev)
> > > > +{
> > > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > > +    VirtIONet *n =3D VIRTIO_NET(dev);
> > > > +    int i, max_queue_pairs;
> > > > +
> > > > +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > > > +        virtio_net_unload_ebpf(n);
> > > > +    }
> > > > +
> > > > +    /* This will stop vhost backend if appropriate. */
> > > > +    virtio_net_set_status(vdev, 0);
> > > > +
> > > > +    g_free(n->netclient_name);
> > > > +    n->netclient_name =3D NULL;
> > > > +    g_free(n->netclient_type);
> > > > +    n->netclient_type =3D NULL;
> > > > +
> > > > +    g_free(n->mac_table.macs);
> > > > +    g_free(n->vlans);
> > > > +
> > > > +    if (n->failover) {
> > > > +        qobject_unref(n->primary_opts);
> > > > +        device_listener_unregister(&n->primary_listener);
> > > > +        migration_remove_notifier(&n->migration_state);
> > > > +    } else {
> > > > +        assert(n->primary_opts =3D=3D NULL);
> > > > +    }
> > > > +
> > > > +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> > > > +    for (i =3D 0; i < max_queue_pairs; i++) {
> > > > +        virtio_net_del_queue(n, i);
> > > > +    }
> > > > +    /* delete also control vq */
> > > > +    virtio_del_queue(vdev, max_queue_pairs * 2);
> > > > +    qemu_announce_timer_del(&n->announce_timer, false);
> > > > +    g_free(n->vqs);
> > > > +    qemu_del_nic(n->nic);
> > > > +    virtio_net_rsc_cleanup(n);
> > > > +    g_free(n->rss_data.indirections_table);
> > > > +    net_rx_pkt_uninit(n->rx_pkt);
> > > > +    virtio_cleanup(vdev);
> > > > +}
> > > > +
> > > >  static void virtio_net_device_realize(DeviceState *dev, Error **er=
rp)
> > > >  {
> > > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > > @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(Devic=
eState *dev, Error **errp)
> > > >
> > > >      net_rx_pkt_init(&n->rx_pkt);
> > > >
> > > > -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > > > -        virtio_net_load_ebpf(n);
> > > > -    }
> > > > -}
> > > > -
> > > > -static void virtio_net_device_unrealize(DeviceState *dev)
> > > > -{
> > > > -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > > -    VirtIONet *n =3D VIRTIO_NET(dev);
> > > > -    int i, max_queue_pairs;
> > > > -
> > > > -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > > > -        virtio_net_unload_ebpf(n);
> > > > +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> > > > +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
> > > > +        virtio_net_device_unrealize(dev);
> > > > +        error_setg(errp, "Can't load eBPF RSS for vhost");
> > > >      }
> > >
> > > As I already mentioned, I think this is an extremely bad idea to
> > > fail to run qemu due to such a reason as .absence of one feature.
> > > What I suggest is:
> > > 1. Redefine rss as tri-state (off|auto|on)
> > > 2. Fail to run only if rss is on and not available via ebpf
> > > 3. On auto - silently drop it
> >
> > "Auto" might be promatic for migration compatibility which is hard to
> > be used by management layers like libvirt. The reason is that there's
> > no way for libvirt to know if it is supported by device or not.
>
> In terms of migration every feature that somehow depends on the kernel
> is problematic, not only RSS.

True, but if we can avoid more, it would still be better.

> Last time we added the USO feature - is
> it different?

I may miss something but we never define tristate for USO?

    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
                      VIRTIO_NET_F_GUEST_USO4, true),
    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
                      VIRTIO_NET_F_GUEST_USO6, true),
    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                      VIRTIO_NET_F_HOST_USO, true),

?
> And in terms of migration "rss=3Don" is problematic the same way as "rss=
=3Dauto".

Failing early when launching Qemu is better than failing silently as a
guest after a migration.

> Can you please show one scenario of migration where they will behave
> differently?

If you mean the problem of "auto", here's one:

Assuming auto is used in both src and dst. On source, rss is enabled
but not destination. RSS failed to work after migration.

> And in terms of regular experience there is a big advantage.

Similarly, silent clearing a feature is also not good:

    if (!peer_has_vnet_hdr(n)) {
        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);

        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);

        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);

        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
    }

The reason we never see complaints is probably because vhost/TAP are
the only backend that supports migration where vnet support there has
been more than a decade.

Thanks


>
>
> >
> > Thanks
> >
> > > 4. The same with 'hash' option - it is not compatible with vhost (at
> > > least at the moment)
> > > 5. Reformat the patch as it is hard to review it due to replacing
> > > entire procedures, i.e. one patch with replacing without changes,
> > > another one - with real changes.
> > > If this is hard to review only for me - please ignore that.
> > >
> > > > -
> > > > -    /* This will stop vhost backend if appropriate. */
> > > > -    virtio_net_set_status(vdev, 0);
> > > > -
> > > > -    g_free(n->netclient_name);
> > > > -    n->netclient_name =3D NULL;
> > > > -    g_free(n->netclient_type);
> > > > -    n->netclient_type =3D NULL;
> > > > -
> > > > -    g_free(n->mac_table.macs);
> > > > -    g_free(n->vlans);
> > > > -
> > > > -    if (n->failover) {
> > > > -        qobject_unref(n->primary_opts);
> > > > -        device_listener_unregister(&n->primary_listener);
> > > > -        migration_remove_notifier(&n->migration_state);
> > > > -    } else {
> > > > -        assert(n->primary_opts =3D=3D NULL);
> > > > -    }
> > > > -
> > > > -    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> > > > -    for (i =3D 0; i < max_queue_pairs; i++) {
> > > > -        virtio_net_del_queue(n, i);
> > > > -    }
> > > > -    /* delete also control vq */
> > > > -    virtio_del_queue(vdev, max_queue_pairs * 2);
> > > > -    qemu_announce_timer_del(&n->announce_timer, false);
> > > > -    g_free(n->vqs);
> > > > -    qemu_del_nic(n->nic);
> > > > -    virtio_net_rsc_cleanup(n);
> > > > -    g_free(n->rss_data.indirections_table);
> > > > -    net_rx_pkt_uninit(n->rx_pkt);
> > > > -    virtio_cleanup(vdev);
> > > >  }
> > > >
> > > >  static void virtio_net_reset(VirtIODevice *vdev)
> > > >
> > > > --
> > > > 2.44.0
> > > >
> > >
> >
>


