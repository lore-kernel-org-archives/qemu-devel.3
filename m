Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7890C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 06:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22ip-0001j5-4z; Tue, 08 Apr 2025 02:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u22ik-0001ik-Hd
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u22ig-0005sn-4V
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744094758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ortHe0ddGn5yKSp/mYatnbihkxePePB5yAQ7wvoiL6I=;
 b=Lp8z4076bVoX+7IjNWMMxiTXSTlkF/yGTorCDEKiX4jd3hWdojL8Y8SRPB6CrQDTgS6lCq
 a9VNmmLlB124g8N7M9Sj+C9z95weIZgJ/V9XJdZOBtRY3bk6JqIx/rV5QHtmWSOtnoye/o
 QNqlyhYb1hzavpvafxG2Yy2KfCCTycQ=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-bgBRCeGWMc2fk08oqckEjA-1; Tue, 08 Apr 2025 02:45:56 -0400
X-MC-Unique: bgBRCeGWMc2fk08oqckEjA-1
X-Mimecast-MFC-AGG-ID: bgBRCeGWMc2fk08oqckEjA_1744094756
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-524021ac776so1606065e0c.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 23:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744094756; x=1744699556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ortHe0ddGn5yKSp/mYatnbihkxePePB5yAQ7wvoiL6I=;
 b=Q7fRN+8Mvi0voqXkgkibAdEdX/7PpkQnW2YR7936r6Qbtds+dVa1u0m0KzMTONgTzg
 qqy224BB4fOdTxgMkMXtRJUbBfrFmlmwuwqoNCmCMXZd5P9l0IAkTp04UlaLAVaZuCmS
 ATxseupH0Wh4jlJsFP7nX/CCvh7vNQ3w9J0DoF5zg1F0gDxTDUaTdCR5OeCfaGSBGnS+
 jk+eIH8rGQMaih9sFx30I/rfKDRit1M0nKwJlLuOXBghYp030kpYtTMrNvWQyABsiCfc
 UGP6PlswpJUVs98Xjm+n/epAwUU7n/sUAy/UepfyyEMMKsAgWxL1Z8eW35iUp/1CBN5D
 3gjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI++v9mt9vNC6DanWBzJGGxXG+NBiTm5aWG8h45QNV4zDP89XcmKkLt3NGO4UC8O9hu7YRQ7NOICLm@nongnu.org
X-Gm-Message-State: AOJu0Yx9eewaaAZtB8Bnjnhhh/zn/6kr2NCpcvDQsfqXTgq+tyJ6VCKb
 f/7+Sj21jo8EIbE1eIRXbvH0nyuBhbPJkhFLRWd3tbYvGJgLJFDrvTy8fv2DYMFtkJ79/ifAJDO
 nK8Vmp8KdFgAaUyfTjYGaSrUCbHHd2c+oiSEheuijuGT5dbyMReozZAVSu6JWYMDVO3CWjLZElz
 m2KXxi0n4eNBxM24hbXgONH6Z3Bmg=
X-Gm-Gg: ASbGncvTGGRN5NJH/HpD83rIsj560w4SSng+Dlwa5PVKQWVL7MM9wRv7oApYIzETXxF
 S+VnQ1zuelSr67SW71Hnq2siV/lSqa2XDi19g3uht657ZCeLeN43I4rm8Q3ihuFZVmpBM+ZAT
X-Received: by 2002:a05:6102:334d:b0:4c3:6979:2ec with SMTP id
 ada2fe7eead31-4c8568e59dcmr11692248137.11.1744094756151; 
 Mon, 07 Apr 2025 23:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3g7KcUkY4UdKBZcuZ4TbY5ScN4Zo3SLGsJxq91eq/9v+Qtfl1w6E8Au8hgASSI5AdYPED8fS44U7XGkuLtx8=
X-Received: by 2002:a05:6102:334d:b0:4c3:6979:2ec with SMTP id
 ada2fe7eead31-4c8568e59dcmr11692241137.11.1744094755738; Mon, 07 Apr 2025
 23:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250408061327.2590372-1-lulu@redhat.com>
 <20250408061327.2590372-3-lulu@redhat.com>
In-Reply-To: <20250408061327.2590372-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 14:45:43 +0800
X-Gm-Features: ATxdqUHq10lmUOnQYP9eEjiYrx3i-KCNmBUukhsfIhPK9-CefrY9JnL4rZfkMdo
Message-ID: <CACGkMEtfu_aa8cakY7_Snn25BYcMmFFp8XDvtnq=1ob9XP9Wig@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] virtio_net: Add the check for vdpa's mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 8, 2025 at 2:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> index 340c6b6422..94ee21d1fc 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3751,12 +3751,43 @@ static bool failover_hide_primary_device(DeviceLi=
stener *listener,
>      /* failover_primary_hidden is set during feature negotiation */
>      return qatomic_read(&n->failover_primary_hidden);
>  }
> +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
> +                                      MACAddr *cmdline_mac, Error **errp=
)
> +{
> +    struct virtio_net_config hwcfg =3D {};
> +    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> +
> +    vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH=
_ALEN);
> +
> +    /* For VDPA device following situations are acceptable: */
>

Let's drop the comment here and below as the code explains themselves.

> +    if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> +        /*
> +         * 1. The hardware MAC address is the same as the QEMU command l=
ine MAC
> +         *   address, and both of them are not 0.
> +         */
> +        if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0))=
 {
> +            return true;
> +        }
> +    }
> +    error_setg(errp,
> +               "vDPA device's MAC address %02x:%02x:%02x:%02x:%02x:%02x =
"
> +               "is not the same as the QEMU command line MAC address "
> +               "%02x:%02x:%02x:%02x:%02x:%02x,"
> +               "Initialization failed.",
> +               hwcfg.mac[0], hwcfg.mac[1], hwcfg.mac[2], hwcfg.mac[3],
> +               hwcfg.mac[4], hwcfg.mac[5], cmdline_mac->a[0], cmdline_ma=
c->a[1],
> +               cmdline_mac->a[2], cmdline_mac->a[3], cmdline_mac->a[4],
> +               cmdline_mac->a[5]);

I would move this to the caller to be consistent with other errors.

> +
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
> @@ -3864,6 +3895,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>
>      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));

Can we avoid this memcpy?

>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status =3D VIRTIO_NET_S_LINK_UP;
> @@ -3910,7 +3942,13 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>      nc =3D qemu_get_queue(n->nic);
>      nc->rxfilter_notify_enabled =3D 1;
>
> -   if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA) {
> +    if (nc->peer && (nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST=
_VDPA)) {
> +        if (nc->peer->check_mac) {
> +            if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp=
)) {
> +                virtio_cleanup(vdev);
> +                return;
> +            }
> +        }
>          struct virtio_net_config netcfg =3D {};
>          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>          vhost_net_set_config(get_vhost_net(nc->peer),
> --
> 2.45.0

Thanks

>


