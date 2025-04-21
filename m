Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F1EC369C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 03:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6hgO-00082i-KK; Sun, 20 Apr 2025 23:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hgN-00082V-9W
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hgL-00021N-Bw
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745205532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lS9lptnKdrB6vQc/0SYByJQvjVis33ZreLKAYEC1nac=;
 b=Iik7hgZNfDg8Zo/iXUFWK81iXKX7y4SWvHs2HVzB+RJRzMFDKXeBiVQcg5OhP4hOqLm7pK
 yD2wX8OZtRJ54OIseTR3eSaW9obEGIVrk57rFTL2BVv014XL0TluLcq5Bg79mZdr3yMibM
 2ri7VFGCZwyZynFQVdKxm+VFcjPC7EM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-y1kuMfECNrafg4yKq96y1g-1; Sun, 20 Apr 2025 23:18:50 -0400
X-MC-Unique: y1kuMfECNrafg4yKq96y1g-1
X-Mimecast-MFC-AGG-ID: y1kuMfECNrafg4yKq96y1g_1745205530
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff798e8c3bso3033027a91.2
 for <qemu-devel@nongnu.org>; Sun, 20 Apr 2025 20:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745205528; x=1745810328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lS9lptnKdrB6vQc/0SYByJQvjVis33ZreLKAYEC1nac=;
 b=VcP5cvxqPyIxaV9XZj46R+rdkjJAd3ItSkeiQetLmDFZc7ON7D0HIv+9apOShsuWCR
 ZDShOXF4zmM6xMh3qBM/3K+5kut6dia+zM/wIdnSiF206C/lj7s3SMLW5dGCaObAp9Wo
 eQJmY3FQI6kCz+9MagJ+LLjupiMArV0J7BwJtyz6EUNbpZQHJU832JGnqDYZt3pWlBp/
 6J3aOHZkINKpA78W/hsSw6Vt9qXXJZtR6jAeLp0D1HAYfNRMHXJtnqhccZRM3nlC7oWo
 m8TLrjESkPGJxbPp1viRKw7v3DYI0lVHBZpdRP2krs6PBIWyDxvr3Clahc1SxaWhonRx
 UbbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiPdvRRIa8wOq4zjgLMBZBOu5xWohEPw+wcMh6NYeh7vO+i5gm1EE4TQKTkQ/tpoiBt+ZtvQxZIrXf@nongnu.org
X-Gm-Message-State: AOJu0YxYP4WAOVarIwwP1wMq7HHelPjxvit+q88r6gGmSLCl6FzBo1ny
 fkRSi0WtTuFdqS2i/d4ZgKoqOjacDunHlKx9q2ZMVpTlOg6hiM+TEZT5U+WoTK1p7j7SzBQKciR
 sTh3ooDsCUV5Hl8sa1A4zxmL2C2WjX6gzo3nyXnDazSDF0Z+dsGDH1zuquzrdF4S8gVX0mFyGiz
 ynCb70D9FDuwoIsSUK6dBbDkD7wzuwCaCearKgGA==
X-Gm-Gg: ASbGncsqJYgDAIMQlkTI2goNIoq2S9I31z5q2cH/kdjnEfF4n6Hg1fHmUdXKhsiec9W
 UtslDh5mcAtIVMnBJfxWUmAiXzIddjVsWyik1xsWPEl2PTz9JgDEGiM3SbjjntruZfbaLSw==
X-Received: by 2002:a17:90b:278e:b0:305:2d9d:81c9 with SMTP id
 98e67ed59e1d1-3087bb692f8mr17008187a91.16.1745205528242; 
 Sun, 20 Apr 2025 20:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXlhOen4GGOqWG8Xhmwqplg+rPeVjedyzzWPsdUH/GSbui3nkjsbxYJIpBOhWZn0XCglceIT4CYBXM4TGyl60=
X-Received: by 2002:a17:90b:278e:b0:305:2d9d:81c9 with SMTP id
 98e67ed59e1d1-3087bb692f8mr17008159a91.16.1745205527847; Sun, 20 Apr 2025
 20:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250417102522.4125379-1-lulu@redhat.com>
 <20250417102522.4125379-3-lulu@redhat.com>
In-Reply-To: <20250417102522.4125379-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:18:35 +0800
X-Gm-Features: ATxdqUHF9tEKOZKh1V1u-6k4GoR7G5FvEp7bigICXL_tYMdP3RYgij2-gKIeB5M
Message-ID: <CACGkMEsS=_KQgA-gkHy+WAZ_seq72UeA14Lt3Z8aOpfE5moUjQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] virtio_net: Add the check for vdpa's mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.69,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Apr 17, 2025 at 6:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> When using a VDPA device, it is important to ensure that the MAC
> address is correctly set. The MAC address in the hardware should
> match the MAC address from the QEMU command line. This is a recommended
> configuration and will allow the system to boot.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index bd37651dab..0b6a4e5634 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3744,12 +3744,29 @@ static bool failover_hide_primary_device(DeviceLi=
stener *listener,
>      /* failover_primary_hidden is set during feature negotiation */
>      return qatomic_read(&n->failover_primary_hidden);
>  }
> +static bool virtio_net_check_vdpa_mac(VirtIONet *n, uint8_t *hwmac,
> +                                      MACAddr *cmdline_mac, Error **errp=
)
> +{
> +    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> +
> +    if (memcmp(hwmac, &zero, sizeof(MACAddr)) !=3D 0) {
> +        /*
> +         * 1. The hardware MAC address is the same as the QEMU command l=
ine MAC
> +         *   address, and both of them are not 0.
> +         */
> +        if ((memcmp(hwmac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0)) {
> +            return true;
> +        }
> +    }
>
> +    return false;
> +}
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIONet *n =3D VIRTIO_NET(dev);
>      NetClientState *nc;
> +    MACAddr macaddr_cmdline;
>      int i;
>
>      if (n->net_conf.mtu) {
> @@ -3857,6 +3874,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>
>      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status =3D VIRTIO_NET_S_LINK_UP;
> @@ -3903,8 +3921,28 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>      nc =3D qemu_get_queue(n->nic);
>      nc->rxfilter_notify_enabled =3D 1;
>
> -   if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA) {
> +    if (nc->peer && (nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST=
_VDPA)) {
> +
>          struct virtio_net_config netcfg =3D {};
> +        if (nc->peer->check_mac) {
> +            vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&ne=
tcfg,
> +                                 ETH_ALEN);
> +            if (!virtio_net_check_vdpa_mac(n, (uint8_t *)&netcfg.mac,
> +                                           &macaddr_cmdline, errp)) {
> +                error_setg(errp, "vDPA device's MAC address "
> +                           "%02x:%02x:%02x:%02x:%02x:%02x "
> +                           "is not same as the QEMU command line MAC add=
ress"
> +                           "%02x:%02x:%02x:%02x:%02x:%02x,"
> +                           "Initialization failed.",
> +                           netcfg.mac[0], netcfg.mac[1], netcfg.mac[2],
> +                           netcfg.mac[3], netcfg.mac[4], netcfg.mac[5],
> +                           macaddr_cmdline.a[0], macaddr_cmdline.a[1],
> +                           macaddr_cmdline.a[2], macaddr_cmdline.a[3],
> +                           macaddr_cmdline.a[4], macaddr_cmdline.a[5]);
> +                virtio_cleanup(vdev);
> +                return;
> +            }
> +        }
>          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>          vhost_net_set_config(get_vhost_net(nc->peer),
>              (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONT=
END);

If the mac check passes, do we still need to go here to override the
config space which is tricky as some parents doesn't even support set
config.

Thanks

> --
> 2.45.0
>


