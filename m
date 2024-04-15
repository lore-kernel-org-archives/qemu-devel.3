Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA90FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMxU-0006Ni-DI; Mon, 15 Apr 2024 10:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rwMxS-0006NS-9v
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:05:18 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rwMxQ-0000lj-1h
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:05:18 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4346b686dbdso19260391cf.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713189914; x=1713794714;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DutWCV6RMM1Ai841LqBl34Kj0ec3v7jN1zE2nGSYZNA=;
 b=ZtoeV3RkHe0vNbzlJwzrNBOn18V8MmjMC61F/EdbwYfxmLajCFBr2dNeKSn1qdWBlr
 faJhI35AbDs4uyeAqbZZzAc3Og0QvDrNXiAqNTv7FF5u9Py9PvOgS4eFx3naUBK0tRRs
 PvJXF9uu6WRG5rhP2UmQSBFES8+MWhrsduTphwMMVWYqzcwo+aop0Rf8ils+8r/fXsWb
 WyBk1RKKZorUmC+38++q5xdwubKqZZhuVdcD0b7x2FXIYFgc5JMfxwCVX73UYiepuELM
 NNCB8QZMrKhxA2bqY21gWCSVi1qTTRq7JNc0RgZb/3FLlSKbqlSraauSe1k9kaM0RTLx
 QLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713189914; x=1713794714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DutWCV6RMM1Ai841LqBl34Kj0ec3v7jN1zE2nGSYZNA=;
 b=mUoCA18Pt1JXOBfuzViMAdVOnUnYQhtL9+NL7pWsLmTMlEzNHcwGSxWOcNripcMIW8
 eTbNtrZwN6lyryivHlgq36IVdYoCR7AGoJB5rbPli7hloCzrmNzV3wIOAjsaA2Zn77/Y
 0WI3WafSUAyFxYzPTOZduWuDteCrXvz7I0ZsBFA3MrcPROZ5o3D8me56Bn4a/fTuZPjr
 SlRRen6hmFi1swUbKyZO4zdQRm4o5SnwLtXiqJuEBtz5ZYQBwECxeBaAhyhEcit34Fx5
 kEPWE5ewsiGBwZUCzAV4gq++yfrp3AvPIDoapzr+YHkWVpoa238a4QU2vBwt/A0LvtXt
 cJBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoptXi//mRsKxFIHVdflF//ON1bf5KgzGMRWeN/vFR+XNLV0M0Qdr6ztnzkXjLeZwrBuRKUUNQIx26/0y8sEeSob3EdfU=
X-Gm-Message-State: AOJu0YxfiRPT0rkfS6Yhm2nIqDVfIQ89y2SuE2FBQcv2sIGj1k9uSu/R
 h4z0oUk76NAljgXoMfTDkBk/vI5Qpwb+kMCmiiicSly5h0hnz1ofrE82/S5+6Fg4lcObBFaw+3I
 +WipUopKkXpeeLNhLnyLZDH2L10Ov4o7nJmidng==
X-Google-Smtp-Source: AGHT+IFwb2MJAkvn9KpzsvZ0dQNZgpEcoVViCbtRUMn1UP/0kmM27dUpMf4gmo8RdEBnMFzWrtessQcnwvShbEpnF24=
X-Received: by 2002:a05:622a:1210:b0:435:9214:7d4 with SMTP id
 y16-20020a05622a121000b00435921407d4mr11858872qtx.14.1713189914387; Mon, 15
 Apr 2024 07:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 15 Apr 2024 17:05:03 +0300
Message-ID: <CAOEp5OeXLFTUsH5egdMfsEPACM0O2XODOeYbpggD0T2Zv6ceYQ@mail.gmail.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::82a;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qt1-x82a.google.com
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

On Wed, Apr 3, 2024 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> implicitly disables RSS even if the user explicitly requests it. Return
> an error instead of implicitly disabling RSS if RSS is requested but not
> available.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 48 insertions(+), 49 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 61b49e335dea..3d53eba88cfc 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODevice =
*vdev, uint64_t features,
>          return features;
>      }
>
> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> -    }
>      features =3D vhost_net_get_features(get_vhost_net(nc->peer), feature=
s);
>      vdev->backend_features =3D features;
>
> @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(DeviceLis=
tener *listener,
>      return qatomic_read(&n->failover_primary_hidden);
>  }
>
> +static void virtio_net_device_unrealize(DeviceState *dev)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIONet *n =3D VIRTIO_NET(dev);
> +    int i, max_queue_pairs;
> +
> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> +        virtio_net_unload_ebpf(n);
> +    }
> +
> +    /* This will stop vhost backend if appropriate. */
> +    virtio_net_set_status(vdev, 0);
> +
> +    g_free(n->netclient_name);
> +    n->netclient_name =3D NULL;
> +    g_free(n->netclient_type);
> +    n->netclient_type =3D NULL;
> +
> +    g_free(n->mac_table.macs);
> +    g_free(n->vlans);
> +
> +    if (n->failover) {
> +        qobject_unref(n->primary_opts);
> +        device_listener_unregister(&n->primary_listener);
> +        migration_remove_notifier(&n->migration_state);
> +    } else {
> +        assert(n->primary_opts =3D=3D NULL);
> +    }
> +
> +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> +    for (i =3D 0; i < max_queue_pairs; i++) {
> +        virtio_net_del_queue(n, i);
> +    }
> +    /* delete also control vq */
> +    virtio_del_queue(vdev, max_queue_pairs * 2);
> +    qemu_announce_timer_del(&n->announce_timer, false);
> +    g_free(n->vqs);
> +    qemu_del_nic(n->nic);
> +    virtio_net_rsc_cleanup(n);
> +    g_free(n->rss_data.indirections_table);
> +    net_rx_pkt_uninit(n->rx_pkt);
> +    virtio_cleanup(vdev);
> +}
> +
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>
>      net_rx_pkt_init(&n->rx_pkt);
>
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> -        virtio_net_load_ebpf(n);
> -    }
> -}
> -
> -static void virtio_net_device_unrealize(DeviceState *dev)
> -{
> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> -    VirtIONet *n =3D VIRTIO_NET(dev);
> -    int i, max_queue_pairs;
> -
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> -        virtio_net_unload_ebpf(n);
> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
> +        virtio_net_device_unrealize(dev);
> +        error_setg(errp, "Can't load eBPF RSS for vhost");
>      }

As I already mentioned, I think this is an extremely bad idea to
fail to run qemu due to such a reason as .absence of one feature.
What I suggest is:
1. Redefine rss as tri-state (off|auto|on)
2. Fail to run only if rss is on and not available via ebpf
3. On auto - silently drop it
4. The same with 'hash' option - it is not compatible with vhost (at
least at the moment)
5. Reformat the patch as it is hard to review it due to replacing
entire procedures, i.e. one patch with replacing without changes,
another one - with real changes.
If this is hard to review only for me - please ignore that.

> -
> -    /* This will stop vhost backend if appropriate. */
> -    virtio_net_set_status(vdev, 0);
> -
> -    g_free(n->netclient_name);
> -    n->netclient_name =3D NULL;
> -    g_free(n->netclient_type);
> -    n->netclient_type =3D NULL;
> -
> -    g_free(n->mac_table.macs);
> -    g_free(n->vlans);
> -
> -    if (n->failover) {
> -        qobject_unref(n->primary_opts);
> -        device_listener_unregister(&n->primary_listener);
> -        migration_remove_notifier(&n->migration_state);
> -    } else {
> -        assert(n->primary_opts =3D=3D NULL);
> -    }
> -
> -    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> -    for (i =3D 0; i < max_queue_pairs; i++) {
> -        virtio_net_del_queue(n, i);
> -    }
> -    /* delete also control vq */
> -    virtio_del_queue(vdev, max_queue_pairs * 2);
> -    qemu_announce_timer_del(&n->announce_timer, false);
> -    g_free(n->vqs);
> -    qemu_del_nic(n->nic);
> -    virtio_net_rsc_cleanup(n);
> -    g_free(n->rss_data.indirections_table);
> -    net_rx_pkt_uninit(n->rx_pkt);
> -    virtio_cleanup(vdev);
>  }
>
>  static void virtio_net_reset(VirtIODevice *vdev)
>
> --
> 2.44.0
>

