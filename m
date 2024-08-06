Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AE7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 03:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbAXd-0001v2-Sm; Mon, 05 Aug 2024 23:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbAXc-0001uS-9Q
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 23:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbAXa-0003vD-Lv
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 23:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722913631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wXoEHq0f1uxpOhiZEHaKDocCWiDnPzPwBOmJ8uzH/o=;
 b=To7p8JJBs4rk/trvVQ3gpD9ma/gihPGA3A+SR8QfgIjL25MDGCqBaurDQ3XQqbMbYKlgT1
 HSftZxe2EFBh01hSPkeftENOpIx5Zcgog+gwTE9//CT8f9Jzm+osCoULkMhCwd4hNuYT9A
 kflcKQoB8aifg7pS+Tq7XP2AhDDk6g0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-p8OR1a-HPE2CYiJrIRrpnQ-1; Mon, 05 Aug 2024 23:07:10 -0400
X-MC-Unique: p8OR1a-HPE2CYiJrIRrpnQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cb600e1169so218308a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 20:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722913629; x=1723518429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wXoEHq0f1uxpOhiZEHaKDocCWiDnPzPwBOmJ8uzH/o=;
 b=hJv7SwxRJjdEczNNLB7Q8gMlbzq/QkePaRuRhVrhjKERcnXzNDb/f1ZryayDKVATbb
 yicdirevMhIncSKm/aTbN3S53D1mAQ2oxH2NcyA4TjSlaVnOUBsiJqdaWtxspn/YbZ1k
 fp0s53qlDzYaL4BBQ3rdo+VtL0Feowe8RtY8dRMlw9VQoW8TPNKIv7fNSA5YsSQq7eSM
 M7BrPEGWIJl04/dSiyrZS/ckuEOgFxk7WvL1luYOMP1DWLq/F1K+L04QqSga7Ijc6fBf
 xtkh9KX6K8Ii5zsCYhN5zcfFIzp9I+7N4miNDOosFOvFb4tvPVT5itgk1BCCWhk5ci0o
 nunw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUABe8//H8nVHPOK7sJWBDQ9ftL0fi+dQWdQ04Q8H7uW+xFpL0QQmcxUMQHUcFO7ElcYaHnLqWJG+DIRpVqo3kspxE1GRk=
X-Gm-Message-State: AOJu0YxH/4m6q/EaDFx4SEWubxvIZi5XLj7c0ouCOTF59zfaZmLaiGTP
 c7ozSsWmMlfFqLQTiBCqFF2Xtgkj30q1zkFWMUP13Q+zUB6vER4MxIU8VvfqT7hey4fy6SZTw8z
 62MwuTnYWINuPZRjOANXjiTyemcZSrN1EHgKK1lIhu0JfQWw6+nTj4X8JQwJt8B0c0F5Ldc8oXG
 pihTr0EHjwOThWaizAhSzNOdwQYak=
X-Received: by 2002:a17:90a:6042:b0:2c8:ea7b:8891 with SMTP id
 98e67ed59e1d1-2cff95144c8mr12507621a91.29.1722913629107; 
 Mon, 05 Aug 2024 20:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJcxijXYRfmYGGNk6h4L5orUK7wOGWmclJKVLnTGQ8PZVVeezyHu5F1TWYl6+8O9h2AAJJ9Ev5VKQjhiF2r0I=
X-Received: by 2002:a17:90a:6042:b0:2c8:ea7b:8891 with SMTP id
 98e67ed59e1d1-2cff95144c8mr12507593a91.29.1722913628376; Mon, 05 Aug 2024
 20:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
In-Reply-To: <20240806005814.51651-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 11:06:55 +0800
Message-ID: <CACGkMEuCJT8KYsDgJaXzvy1Fhm6+tJinowdTtoAngsnvYjB54Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio_net: Add the check for vdpa's mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 6, 2024 at 8:58=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> When using a VDPA device, it is important to ensure that
> the MAC address in the hardware matches the MAC address
> from the QEMU command line.
> This will allow the device to boot.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..7f51bd0dd3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3579,12 +3579,36 @@ static bool failover_hide_primary_device(DeviceLi=
stener *listener,
>      /* failover_primary_hidden is set during feature negotiation */
>      return qatomic_read(&n->failover_primary_hidden);
>  }
> +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n, =
MACAddr *cmdline_mac,
> +                                     Error **errp)
> +{
> +       struct virtio_net_config hwcfg =3D {};
> +       static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> +
> +       vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, =
ETH_ALEN);
> +
> +    /*
> +     * For VDPA device: Only two situations are acceptable:
> +     * 1.The hardware MAC address is the same as the QEMU command line M=
AC
> +     *   address, and both of them are not 0.

I guess there should be a bullet 2?

> +     */
> +
> +       if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> +               if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=
=3D 0)) {
> +                       return true;
> +               }
> +       }
> +       error_setg(errp, "vDPA device's mac !=3D the mac address from qem=
u cmdline"
> +                        "Please check the the vdpa device's setting.");

For error messages I think it's better to use english instead of "!=3D"
to describe the issue.

>
> +       return false;
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
> @@ -3692,6 +3716,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>
>      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status =3D VIRTIO_NET_S_LINK_UP;
> @@ -3739,10 +3764,10 @@ static void virtio_net_device_realize(DeviceState=
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
> +          if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp))=
 {
> +                  virtio_cleanup(vdev);
> +                  return;
> +          }

Any reason we remove vhost_net_set_config() here? It is not described
in the commit or does it belong to another patch?

Thanks

>      }
>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev =3D dev;
> --
> 2.45.0
>


