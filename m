Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC93C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 01:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTXSC-0003YY-Kj; Mon, 15 Jul 2024 21:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1sTXSA-0003Xq-F1
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1sTXS8-00067m-Js
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721095082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJ9uRaA/pgUTohQkTocotLavEjg0G3cgh1Hl90+UeSE=;
 b=aMkVvbwORVWCwrcvqCJBLBqHg5yvvL8Yr/VkHN/XViwZ38jQIwVbLTPOuvKcgRW6TMbVLh
 SRuZIvgx7TG7cAkoef2aGw1anckumagf5OgBVCrFGI5/y7hJcuRARHQcYAZqWGd90St8yn
 wggydGEOPNfcxuTLdtzSeVMALWeHRlY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-FfJ5Jsk_PtSmF9Ozr1sTsg-1; Mon, 15 Jul 2024 21:56:41 -0400
X-MC-Unique: FfJ5Jsk_PtSmF9Ozr1sTsg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-59980727364so3394971a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 18:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721095000; x=1721699800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJ9uRaA/pgUTohQkTocotLavEjg0G3cgh1Hl90+UeSE=;
 b=YAWctoUUDWDK5P/29cziI7+Sm0ZYoum4GNoV1w4sjALza2o56YJZ6SVu4Es+euY+f3
 bddQv9MWW5w0WZptwF38QfdjpO/G/Q4czBZnyennosaswE6w3RKnDQ3205YITxo78VzE
 tN8XSkiwF41SSBbAyAegdK9JowCNOFQcK4MDlyV+NAYqx8q37fY0u8AIJruxwjr4hdIW
 33q+BqxnhnzTDCXWfo4m61cgFM9uRtJZEJgNM8RwmgxJXLiu9vscuNSGQkEOyF3S6HdN
 +0GxKVQlbt0sgbkwz64WyFNhB6s59AIThK9/a+475faqpRXJSli1dKzBNepvgZDEHB1F
 7ZeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBzu57crfyzpAj/55x4BR8hiOfsZ6ax69A6sP/yFG56AR1p9rbydIKRD+Dslr/g6492UsNEjUWPbak7n75pLId5c+Bbyk=
X-Gm-Message-State: AOJu0Yx2CQpuWvm7ZZR03fId5ikUHMyjsfsSzz+++gbjJlqBHWBfCcyJ
 FrcHrd2whB/sUefOFTbFz4Sd8KwDyMXAk0D45rHxB9ynLa7+25ToQKWVmb43HkO816MotTotJYH
 eenWfkfPa5F1jJLB+kJswFgsETB35Erps9kuIYY0+8R/D1IdSAWEYOF7wpMiXBR9Uwzl59Mm2K9
 m6XvQgpJFDC/ZiV7wG/wItlF8JdaM=
X-Received: by 2002:a17:906:c251:b0:a77:d52c:c431 with SMTP id
 a640c23a62f3a-a79ea437a59mr29232366b.22.1721095000341; 
 Mon, 15 Jul 2024 18:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIlY9QdoGy1wvXGDzqvzgSlrEtvYJuX9YNa/bprVSKTIgkcYrp0DjzVKUwrkNd96+xSC0OHOUCNG9hJd/6q1c=
X-Received: by 2002:a17:906:c251:b0:a77:d52c:c431 with SMTP id
 a640c23a62f3a-a79ea437a59mr29231666b.22.1721094999978; Mon, 15 Jul 2024
 18:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com>
In-Reply-To: <20240716011349.821777-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 16 Jul 2024 09:56:03 +0800
Message-ID: <CAPpAL=xKRjtAYPW9+sVfqnKR=ZOiThh+=XVEQb_aokD1WGKgAA@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
 netdev@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Cindy

If needed, QE can help test this MR before merging into the master branch.

Best Regards
Lei


On Tue, Jul 16, 2024 at 9:14=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> When using a VDPA device, it is important to ensure that the MAC address
> in the hardware matches the MAC address from the QEMU command line.
>
> There are only two acceptable situations:
> 1. The hardware MAC address is the same as the MAC address specified in t=
he QEMU
> command line, and both MAC addresses are not 0.
> 2. The hardware MAC address is not 0, and the MAC address in the QEMU com=
mand line is 0.
> In this situation, the hardware MAC address will overwrite the QEMU comma=
nd line address.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..8f79785f59 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -178,8 +178,8 @@ static void virtio_net_get_config(VirtIODevice *vdev,=
 uint8_t *config)
>           * correctly elsewhere - just not reported by the device.
>           */
>          if (memcmp(&netcfg.mac, &zero, sizeof(zero)) =3D=3D 0) {
> -            info_report("Zero hardware mac address detected. Ignoring.")=
;
> -            memcpy(netcfg.mac, n->mac, ETH_ALEN);
> +          error_report("Zero hardware mac address detected in vdpa devic=
e. "
> +                       "please check the vdpa device!");
>          }
>
>          netcfg.status |=3D virtio_tswap16(vdev,
> @@ -3579,12 +3579,42 @@ static bool failover_hide_primary_device(DeviceLi=
stener *listener,
>      /* failover_primary_hidden is set during feature negotiation */
>      return qatomic_read(&n->failover_primary_hidden);
>  }
> +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
> +                                      MACAddr *cmdline_mac, Error **errp=
) {
> +  struct virtio_net_config hwcfg =3D {};
> +  static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
>
> +  vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH_A=
LEN);
> +
> +  /* For VDPA device: Only two situations are acceptable:
> +   * 1.The hardware MAC address is the same as the QEMU command line MAC
> +   *   address, and both of them are not 0.
> +   * 2.The hardware MAC address is NOT 0, and the QEMU command line MAC =
address
> +   *   is 0. In this situation, the hardware MAC address will overwrite =
the QEMU
> +   *   command line address.
> +   */
> +
> +  if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> +    if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0) ||
> +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> +      /* overwrite the mac address with hardware address*/
> +      memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> +      memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> +
> +      return true;
> +    }
> +  }
> +  error_setg(errp, "vdpa hardware mac !=3D the mac address from "
> +                   "qemu cmdline, please check the the vdpa device's set=
ting.");
> +
> +  return false;
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
> @@ -3692,6 +3722,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>
>      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status =3D VIRTIO_NET_S_LINK_UP;
> @@ -3739,10 +3770,10 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>      nc->rxfilter_notify_enabled =3D 1;
>
>     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA) {
> -        struct virtio_net_config netcfg =3D {};
> -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> -        vhost_net_set_config(get_vhost_net(nc->peer),
> -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONT=
END);
> +     if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
> +       virtio_cleanup(vdev);
> +       return;
> +     }
>      }
>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev =3D dev;
> --
> 2.45.0
>
>


