Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2BFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwZzl-0006kL-HV; Tue, 16 Apr 2024 00:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwZzj-0006kB-Cc
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwZzh-0005zs-Db
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713240028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S620PDxaog88g389vkszhBhnmo9nEZjvdMMPa0mftDg=;
 b=LmfXoO8bZEAQxIuQKDJ/GNK+FjyTw+miEROxCa7tE1qghlc8T+6i7XMagfvOUELXOW7dsB
 nixeoBRQjnqJoCHNQ+UOx4qnO9HMP92sAZVjJtz+cOmrJUXD3ncUCAwAO0DyWugQ6vdmD2
 J8ILjqWrmvA3BdcQhDjCYkwMl+H7aIg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Y0ypEryuMqalHi75cNTeiQ-1; Tue, 16 Apr 2024 00:00:23 -0400
X-MC-Unique: Y0ypEryuMqalHi75cNTeiQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2a537ab9d7eso3726050a91.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240022; x=1713844822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S620PDxaog88g389vkszhBhnmo9nEZjvdMMPa0mftDg=;
 b=NXNfUDlW5bXaEyqxvh9fH9ZVOHqqMGQLgXOOkLMSU1II2i2xHyJgsWcnpLvipAfHN5
 THMWlsrVzUvE2TGImvxVLmEK71l7WKEHbJ62g929FFi4ZZchJhWcNjrAfDCsXxdzQLOj
 nhK9iuNDS3uTqLO0s3MkZUIIYP7gm23OaTezkGBf71RssyucMqRGpMnZGoMMynT8NcVB
 Bzmw+VR1kmDB7l5tiaP2m3m5flGvpOXTjNT/3Ao/klOWY8zGS6W11CxAlrDA9lzDXq/H
 UDkOa6Nn+bTt33I23U8FKydRpbI4dYrqCqoyMu8bOi1oRPutQYGKu4Iqst0lYXb9wvk8
 4AEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPJQQ8SPI3j3K23RibSMK7KEI6r+T6dZg7O3RYp9f8b4AV6wD+vvzEJDWz1SI2o1UOkEKx6w4MerTDuo/BtD4InK64g4o=
X-Gm-Message-State: AOJu0YzJn0I2AwKX2V6yX8eig0/e36zhCDUE6NRDCWOXJKWfBjS4/fqQ
 fgn1HmoPM9Sk6MqkAxjgEZKbIfQeTHAE1Moehi5oE9kkWUbdJsmIQ776aGMKO90whjT7mVki1Mn
 0PqS4fwigvFyOkbBcwOkcsLRx6VntCHvupLUMvf+1VxZ13Ccp5vqBaGBfQ6M0bfjoQhhbhAjkFl
 qpsCmmVN5Yl8nwLo7/LALGBB6tmpA=
X-Received: by 2002:a17:90b:4b8e:b0:2a5:3f9a:97ae with SMTP id
 lr14-20020a17090b4b8e00b002a53f9a97aemr9155235pjb.38.1713240022001; 
 Mon, 15 Apr 2024 21:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtCPsXNo7XP1o3J5pUQhePv5jvAMZs9xIE23uPMtGVxd4L7P8982djQz4zhlgEkO5eQplOEtKmFZCdo7P3Lk0=
X-Received: by 2002:a17:90b:4b8e:b0:2a5:3f9a:97ae with SMTP id
 lr14-20020a17090b4b8e00b002a53f9a97aemr9155209pjb.38.1713240021288; Mon, 15
 Apr 2024 21:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
 <CAOEp5OeXLFTUsH5egdMfsEPACM0O2XODOeYbpggD0T2Zv6ceYQ@mail.gmail.com>
In-Reply-To: <CAOEp5OeXLFTUsH5egdMfsEPACM0O2XODOeYbpggD0T2Zv6ceYQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 12:00:10 +0800
Message-ID: <CACGkMEuG5mDzU-UwHvrZ3TWvZ9rpDWN-Vuw0GPE+_9nEkr6jdw@mail.gmail.com>
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

On Mon, Apr 15, 2024 at 10:05=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Wed, Apr 3, 2024 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
> >
> > vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> > implicitly disables RSS even if the user explicitly requests it. Return
> > an error instead of implicitly disabling RSS if RSS is requested but no=
t
> > available.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++-------------------=
--------
> >  1 file changed, 48 insertions(+), 49 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 61b49e335dea..3d53eba88cfc 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODevic=
e *vdev, uint64_t features,
> >          return features;
> >      }
> >
> > -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> > -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> > -    }
> >      features =3D vhost_net_get_features(get_vhost_net(nc->peer), featu=
res);
> >      vdev->backend_features =3D features;
> >
> > @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(DeviceL=
istener *listener,
> >      return qatomic_read(&n->failover_primary_hidden);
> >  }
> >
> > +static void virtio_net_device_unrealize(DeviceState *dev)
> > +{
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > +    VirtIONet *n =3D VIRTIO_NET(dev);
> > +    int i, max_queue_pairs;
> > +
> > +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > +        virtio_net_unload_ebpf(n);
> > +    }
> > +
> > +    /* This will stop vhost backend if appropriate. */
> > +    virtio_net_set_status(vdev, 0);
> > +
> > +    g_free(n->netclient_name);
> > +    n->netclient_name =3D NULL;
> > +    g_free(n->netclient_type);
> > +    n->netclient_type =3D NULL;
> > +
> > +    g_free(n->mac_table.macs);
> > +    g_free(n->vlans);
> > +
> > +    if (n->failover) {
> > +        qobject_unref(n->primary_opts);
> > +        device_listener_unregister(&n->primary_listener);
> > +        migration_remove_notifier(&n->migration_state);
> > +    } else {
> > +        assert(n->primary_opts =3D=3D NULL);
> > +    }
> > +
> > +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> > +    for (i =3D 0; i < max_queue_pairs; i++) {
> > +        virtio_net_del_queue(n, i);
> > +    }
> > +    /* delete also control vq */
> > +    virtio_del_queue(vdev, max_queue_pairs * 2);
> > +    qemu_announce_timer_del(&n->announce_timer, false);
> > +    g_free(n->vqs);
> > +    qemu_del_nic(n->nic);
> > +    virtio_net_rsc_cleanup(n);
> > +    g_free(n->rss_data.indirections_table);
> > +    net_rx_pkt_uninit(n->rx_pkt);
> > +    virtio_cleanup(vdev);
> > +}
> > +
> >  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
> >
> >      net_rx_pkt_init(&n->rx_pkt);
> >
> > -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > -        virtio_net_load_ebpf(n);
> > -    }
> > -}
> > -
> > -static void virtio_net_device_unrealize(DeviceState *dev)
> > -{
> > -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > -    VirtIONet *n =3D VIRTIO_NET(dev);
> > -    int i, max_queue_pairs;
> > -
> > -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > -        virtio_net_unload_ebpf(n);
> > +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> > +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
> > +        virtio_net_device_unrealize(dev);
> > +        error_setg(errp, "Can't load eBPF RSS for vhost");
> >      }
>
> As I already mentioned, I think this is an extremely bad idea to
> fail to run qemu due to such a reason as .absence of one feature.
> What I suggest is:
> 1. Redefine rss as tri-state (off|auto|on)
> 2. Fail to run only if rss is on and not available via ebpf
> 3. On auto - silently drop it

"Auto" might be promatic for migration compatibility which is hard to
be used by management layers like libvirt. The reason is that there's
no way for libvirt to know if it is supported by device or not.

Thanks

> 4. The same with 'hash' option - it is not compatible with vhost (at
> least at the moment)
> 5. Reformat the patch as it is hard to review it due to replacing
> entire procedures, i.e. one patch with replacing without changes,
> another one - with real changes.
> If this is hard to review only for me - please ignore that.
>
> > -
> > -    /* This will stop vhost backend if appropriate. */
> > -    virtio_net_set_status(vdev, 0);
> > -
> > -    g_free(n->netclient_name);
> > -    n->netclient_name =3D NULL;
> > -    g_free(n->netclient_type);
> > -    n->netclient_type =3D NULL;
> > -
> > -    g_free(n->mac_table.macs);
> > -    g_free(n->vlans);
> > -
> > -    if (n->failover) {
> > -        qobject_unref(n->primary_opts);
> > -        device_listener_unregister(&n->primary_listener);
> > -        migration_remove_notifier(&n->migration_state);
> > -    } else {
> > -        assert(n->primary_opts =3D=3D NULL);
> > -    }
> > -
> > -    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> > -    for (i =3D 0; i < max_queue_pairs; i++) {
> > -        virtio_net_del_queue(n, i);
> > -    }
> > -    /* delete also control vq */
> > -    virtio_del_queue(vdev, max_queue_pairs * 2);
> > -    qemu_announce_timer_del(&n->announce_timer, false);
> > -    g_free(n->vqs);
> > -    qemu_del_nic(n->nic);
> > -    virtio_net_rsc_cleanup(n);
> > -    g_free(n->rss_data.indirections_table);
> > -    net_rx_pkt_uninit(n->rx_pkt);
> > -    virtio_cleanup(vdev);
> >  }
> >
> >  static void virtio_net_reset(VirtIODevice *vdev)
> >
> > --
> > 2.44.0
> >
>


