Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F603C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 04:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwwks-0001dW-2J; Wed, 17 Apr 2024 00:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwwkq-0001dN-SB
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwwko-0006xd-Fq
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713327517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYMq2u5CVajln3iU/tO1HQiUX1L8QQoXAuxu8HlFvP4=;
 b=PZZOfHzKd3RP9vcbPmqkXz5S8HeMR6qTSmYJI7HNM8hI4MHdsqE0OgAy7CQdKzVpmTx2A/
 LBnGNZo3PM6hDwUpjMqQtWEDzAokHdTcEmiIW41dZWZm36vsOMWfkcCJT6Jmff1FiY9rHw
 beQ+eijMRNkJVesA92kRHD1WcvI8+T8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-HG4a3qF2M6qYNM_qmUEqPA-1; Wed, 17 Apr 2024 00:18:35 -0400
X-MC-Unique: HG4a3qF2M6qYNM_qmUEqPA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6ed5a1724b2so2399105b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 21:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713327514; x=1713932314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYMq2u5CVajln3iU/tO1HQiUX1L8QQoXAuxu8HlFvP4=;
 b=UAobsuyi4nIgMtp0rraA/8fGQe8Mj58QGHIbKkJFSGW8GRbTLzTb99yk5hH9szLxvx
 5pzpgvRW14kgH55bW2DDskcEgzUPMLOIbmvhtouf5Fw0gyp51s1tcTr8whAwHKjuefcO
 7SyKfCM/P+YufR4agsVyZqTYwZIvK1YvjyLf5IcQSI7G8Thgb13Ca6rzUVsBxfe/Gscp
 7DG0Pk4X/CwIpak0Z0zdFKJ0lyqPSKjQyyrUdtYXg05EQ7n5UWp3Nmj/6QH/uW0E1S9x
 aAqpeH/e3E3VcN8HPe6uf6fIypbjM05PBKrVWYCMCS3Lj/hik/SBCzqaftiApJzBhrWl
 ZbNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwBZYy8lI3RoqKKgvFnk9++5EB0UIjlkKGjNwLCp/OhBM4Uqd/8bnCvnPynqqbn2GzWaCfmN7E4Lbl3yBcjfyZcRhFuQc=
X-Gm-Message-State: AOJu0YyZ/6D7lZiRtku1cmeR+Z723df5IhkM+Svyyhs9zwJN8cBLyuSw
 1E6TsDWFVV0SY0UD1tENjFOkj+DzN9VATtefvrPT/bXdw8qL+RmfUfZRSWZDS3Pzi71Fkk4bbBG
 9poBQjsGnBqSl+HVGJ1IYBIzpJwln8rWJHRQ4VCTguLcrlViPW4Gkk30n5JYLlTHdry2m6c+c06
 nB+0j3SAUEv9pEt/9eO3LW2v0FzbE=
X-Received: by 2002:a05:6a21:3985:b0:1a9:a32d:17cc with SMTP id
 ad5-20020a056a21398500b001a9a32d17ccmr16838903pzc.18.1713327514093; 
 Tue, 16 Apr 2024 21:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC6vMynwZ4Snah7LIm2y8DKVzPhi9XeVBikhOycHn8iFjNia0OL+K/IeIBW/uYC5ubq6YexQqbHQE7oQC9/3M=
X-Received: by 2002:a05:6a21:3985:b0:1a9:a32d:17cc with SMTP id
 ad5-20020a056a21398500b001a9a32d17ccmr16838886pzc.18.1713327513751; Tue, 16
 Apr 2024 21:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
 <CAOEp5OeXLFTUsH5egdMfsEPACM0O2XODOeYbpggD0T2Zv6ceYQ@mail.gmail.com>
 <CACGkMEuG5mDzU-UwHvrZ3TWvZ9rpDWN-Vuw0GPE+_9nEkr6jdw@mail.gmail.com>
 <CAOEp5OcsP+-wtbJcinAXE=We_52HwmpHxX93FUsAFrjVNPge_Q@mail.gmail.com>
 <CACGkMEuT7Dw4p-gKTefrw4LwmXv2cKde_gKxVb0TF7PHA+63MA@mail.gmail.com>
 <CAOEp5OdNGmCbmrqPCW4Pp3boOVxF+JGMPaVM3utjV0gC0emY2g@mail.gmail.com>
In-Reply-To: <CAOEp5OdNGmCbmrqPCW4Pp3boOVxF+JGMPaVM3utjV0gC0emY2g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Apr 2024 12:18:21 +0800
Message-ID: <CACGkMEvNVCVsQVM_meeW9eAZwuUvzX8Jir3TcBS2t_uk9_O+vQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org, 
 Jonathon Jongsma <jjongsma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Tue, Apr 16, 2024 at 5:51=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Tue, Apr 16, 2024 at 10:14=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Apr 16, 2024 at 1:43=E2=80=AFPM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 7:00=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Mon, Apr 15, 2024 at 10:05=E2=80=AFPM Yuri Benditovich
> > > > <yuri.benditovich@daynix.com> wrote:
> > > > >
> > > > > On Wed, Apr 3, 2024 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> > > > > >
> > > > > > vhost requires eBPF for RSS. When eBPF is not available, virtio=
-net
> > > > > > implicitly disables RSS even if the user explicitly requests it=
. Return
> > > > > > an error instead of implicitly disabling RSS if RSS is requeste=
d but not
> > > > > > available.
> > > > > >
> > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > ---
> > > > > >  hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++-----------=
----------------
> > > > > >  1 file changed, 48 insertions(+), 49 deletions(-)
> > > > > >
> > > > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > > > index 61b49e335dea..3d53eba88cfc 100644
> > > > > > --- a/hw/net/virtio-net.c
> > > > > > +++ b/hw/net/virtio-net.c
> > > > > > @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(Vir=
tIODevice *vdev, uint64_t features,
> > > > > >          return features;
> > > > > >      }
> > > > > >
> > > > > > -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> > > > > > -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> > > > > > -    }
> > > > > >      features =3D vhost_net_get_features(get_vhost_net(nc->peer=
), features);
> > > > > >      vdev->backend_features =3D features;
> > > > > >
> > > > > > @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device=
(DeviceListener *listener,
> > > > > >      return qatomic_read(&n->failover_primary_hidden);
> > > > > >  }
> > > > > >
> > > > > > +static void virtio_net_device_unrealize(DeviceState *dev)
> > > > > > +{
> > > > > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > > > > +    VirtIONet *n =3D VIRTIO_NET(dev);
> > > > > > +    int i, max_queue_pairs;
> > > > > > +
> > > > > > +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)=
) {
> > > > > > +        virtio_net_unload_ebpf(n);
> > > > > > +    }
> > > > > > +
> > > > > > +    /* This will stop vhost backend if appropriate. */
> > > > > > +    virtio_net_set_status(vdev, 0);
> > > > > > +
> > > > > > +    g_free(n->netclient_name);
> > > > > > +    n->netclient_name =3D NULL;
> > > > > > +    g_free(n->netclient_type);
> > > > > > +    n->netclient_type =3D NULL;
> > > > > > +
> > > > > > +    g_free(n->mac_table.macs);
> > > > > > +    g_free(n->vlans);
> > > > > > +
> > > > > > +    if (n->failover) {
> > > > > > +        qobject_unref(n->primary_opts);
> > > > > > +        device_listener_unregister(&n->primary_listener);
> > > > > > +        migration_remove_notifier(&n->migration_state);
> > > > > > +    } else {
> > > > > > +        assert(n->primary_opts =3D=3D NULL);
> > > > > > +    }
> > > > > > +
> > > > > > +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1=
;
> > > > > > +    for (i =3D 0; i < max_queue_pairs; i++) {
> > > > > > +        virtio_net_del_queue(n, i);
> > > > > > +    }
> > > > > > +    /* delete also control vq */
> > > > > > +    virtio_del_queue(vdev, max_queue_pairs * 2);
> > > > > > +    qemu_announce_timer_del(&n->announce_timer, false);
> > > > > > +    g_free(n->vqs);
> > > > > > +    qemu_del_nic(n->nic);
> > > > > > +    virtio_net_rsc_cleanup(n);
> > > > > > +    g_free(n->rss_data.indirections_table);
> > > > > > +    net_rx_pkt_uninit(n->rx_pkt);
> > > > > > +    virtio_cleanup(vdev);
> > > > > > +}
> > > > > > +
> > > > > >  static void virtio_net_device_realize(DeviceState *dev, Error =
**errp)
> > > > > >  {
> > > > > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > > > > @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(D=
eviceState *dev, Error **errp)
> > > > > >
> > > > > >      net_rx_pkt_init(&n->rx_pkt);
> > > > > >
> > > > > > -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)=
) {
> > > > > > -        virtio_net_load_ebpf(n);
> > > > > > -    }
> > > > > > -}
> > > > > > -
> > > > > > -static void virtio_net_device_unrealize(DeviceState *dev)
> > > > > > -{
> > > > > > -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > > > > -    VirtIONet *n =3D VIRTIO_NET(dev);
> > > > > > -    int i, max_queue_pairs;
> > > > > > -
> > > > > > -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)=
) {
> > > > > > -        virtio_net_unload_ebpf(n);
> > > > > > +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)=
 &&
> > > > > > +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
> > > > > > +        virtio_net_device_unrealize(dev);
> > > > > > +        error_setg(errp, "Can't load eBPF RSS for vhost");
> > > > > >      }
> > > > >
> > > > > As I already mentioned, I think this is an extremely bad idea to
> > > > > fail to run qemu due to such a reason as .absence of one feature.
> > > > > What I suggest is:
> > > > > 1. Redefine rss as tri-state (off|auto|on)
> > > > > 2. Fail to run only if rss is on and not available via ebpf
> > > > > 3. On auto - silently drop it
> > > >
> > > > "Auto" might be promatic for migration compatibility which is hard =
to
> > > > be used by management layers like libvirt. The reason is that there=
's
> > > > no way for libvirt to know if it is supported by device or not.
> > >
> > > In terms of migration every feature that somehow depends on the kerne=
l
> > > is problematic, not only RSS.
> >
> > True, but if we can avoid more, it would still be better.
> >
> > > Last time we added the USO feature - is
> > > it different?
> >
> > I may miss something but we never define tristate for USO?
> >
> >     DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
> >                       VIRTIO_NET_F_GUEST_USO4, true),
> >     DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
> >                       VIRTIO_NET_F_GUEST_USO6, true),
> >     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >                       VIRTIO_NET_F_HOST_USO, true),
> >
> When I've added USO feature I followed the existing approach of virtio-ne=
t.
> On get_features - check what was "requested" including those that were "o=
n"
> by default and drop those that aren't supported (vhost by itself also
> can drop some of features).
>
> Still if we have on source machine kernel that supports USO (visible
> on TAP flags)
> and on dest we have older kernel without such support, the migration
> will probably fail.

I may miss something, do we have something USO specific to migrate? If
not, the migration won't fail. And even if migration fails, it's still
not good.

Kernel intends to remove UFO support from 2016, but it breaks the
migration so there's no other choice by introducing UFO (via
emulation) back.

>
> The available solution today is to reduce machine generation in
> libvirt profile (as an example),
> aligning the generation over all the machines that are expected to
> participate in migration.
>
> IMO we should think on some _generic_ solution, for example feature
> negotiation between
> machines before the migration - if the driver receives notification
> from the device it
> can negotiate the change of hardware features to OS (at least for most of=
 them).
> Not trivial, but IMO better than just failing the execution.

Adding Jonathon.

Yes, technically libvirt can detect the support for USO/RSS and
generate the correct qemu command line.

But what I want to say is, failing the launching is still better than
failing the workload running in the guest.

>
> > ?
> > > And in terms of migration "rss=3Don" is problematic the same way as "=
rss=3Dauto".
> >
> > Failing early when launching Qemu is better than failing silently as a
> > guest after a migration.
>
> Do I understand correctly - you mean fail qemu initialization on the
> destination machine?

Yes, it's a hint for the management layer that the migration
compatibility check is wrong.

>
> >
> > > Can you please show one scenario of migration where they will behave
> > > differently?
> >
> > If you mean the problem of "auto", here's one:
> >
> > Assuming auto is used in both src and dst. On source, rss is enabled
> > but not destination. RSS failed to work after migration.
>
> I think in this case the migration will fail when set_feature is
> called on destination.
> The same way as with "on". Am I mistaken?

See above.

>
> >
> > > And in terms of regular experience there is a big advantage.
> >
> > Similarly, silent clearing a feature is also not good:
> >
> >     if (!peer_has_vnet_hdr(n)) {
> >         virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
> >         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
> >         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
> >         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
> >
> >         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
> >         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
> >         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
> >         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
> >
> >         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> >         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> >         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> >
> >         virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
> >     }
> >
> > The reason we never see complaints is probably because vhost/TAP are
> > the only backend that supports migration where vnet support there has
> > been more than a decade.
>
> I think we never see complaints because we did not add new features
> for a long time.

Probably but I basically meant peer_has_vnet_hdr() is always true for
the cases we support. So Qemu won't silently clear them even if they
were turned on explicitly by qemu command line.

Thanks

>
> >
> > Thanks
> >
> >
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > > 4. The same with 'hash' option - it is not compatible with vhost =
(at
> > > > > least at the moment)
> > > > > 5. Reformat the patch as it is hard to review it due to replacing
> > > > > entire procedures, i.e. one patch with replacing without changes,
> > > > > another one - with real changes.
> > > > > If this is hard to review only for me - please ignore that.
> > > > >
> > > > > > -
> > > > > > -    /* This will stop vhost backend if appropriate. */
> > > > > > -    virtio_net_set_status(vdev, 0);
> > > > > > -
> > > > > > -    g_free(n->netclient_name);
> > > > > > -    n->netclient_name =3D NULL;
> > > > > > -    g_free(n->netclient_type);
> > > > > > -    n->netclient_type =3D NULL;
> > > > > > -
> > > > > > -    g_free(n->mac_table.macs);
> > > > > > -    g_free(n->vlans);
> > > > > > -
> > > > > > -    if (n->failover) {
> > > > > > -        qobject_unref(n->primary_opts);
> > > > > > -        device_listener_unregister(&n->primary_listener);
> > > > > > -        migration_remove_notifier(&n->migration_state);
> > > > > > -    } else {
> > > > > > -        assert(n->primary_opts =3D=3D NULL);
> > > > > > -    }
> > > > > > -
> > > > > > -    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1=
;
> > > > > > -    for (i =3D 0; i < max_queue_pairs; i++) {
> > > > > > -        virtio_net_del_queue(n, i);
> > > > > > -    }
> > > > > > -    /* delete also control vq */
> > > > > > -    virtio_del_queue(vdev, max_queue_pairs * 2);
> > > > > > -    qemu_announce_timer_del(&n->announce_timer, false);
> > > > > > -    g_free(n->vqs);
> > > > > > -    qemu_del_nic(n->nic);
> > > > > > -    virtio_net_rsc_cleanup(n);
> > > > > > -    g_free(n->rss_data.indirections_table);
> > > > > > -    net_rx_pkt_uninit(n->rx_pkt);
> > > > > > -    virtio_cleanup(vdev);
> > > > > >  }
> > > > > >
> > > > > >  static void virtio_net_reset(VirtIODevice *vdev)
> > > > > >
> > > > > > --
> > > > > > 2.44.0
> > > > > >
> > > > >
> > > >
> > >
> >
>


