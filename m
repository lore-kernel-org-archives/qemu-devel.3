Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC9FD66BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 02:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG7YY-0004yt-Ka; Tue, 26 Nov 2024 21:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tG7YW-0004yT-HU
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 21:13:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tG7YU-0003Bj-Sf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 21:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732673604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07JoLij0j7IFqx3ACXBURCgjwbIuRCVRW/gMPjsOuYg=;
 b=YEQJSGC1QLXOq3HN6puyfQneC8MxLAMUTaoF4MM9A7MhG5CnO8/yFtKDHdOtIQ9pGM/j28
 4fZclrCkPBtWKC2stJ66u0WMFYOgd5BUcd88ExjtvGmEYTW5APLA7i0Bo62yY3fDGQQZkL
 3c3wVgGzYR9yLbNS56bmzdyHpvwd5SM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-251gq6D1OXeDqB0O9A5fqQ-1; Tue, 26 Nov 2024 21:13:23 -0500
X-MC-Unique: 251gq6D1OXeDqB0O9A5fqQ-1
X-Mimecast-MFC-AGG-ID: 251gq6D1OXeDqB0O9A5fqQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3822f550027so3047880f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 18:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732673602; x=1733278402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07JoLij0j7IFqx3ACXBURCgjwbIuRCVRW/gMPjsOuYg=;
 b=wX62E1MmsqixjKvT6LNFN3891zPJm0zFKK59KLFhqnDL0WD2PHdrmV/CV0zxFyqbVi
 DCdbWOPEbXxSt16aHddQBhBKpiOltWITr8QPptMQT9VnUjNiMmA8eqhnWlisxBp5s42m
 hltkDnXx7ZCg45rN1S3xUOvRBEknbBzJo+QIwS6x1eov6FC84JhCNv51Ir86rtihUEt/
 MHLaLJFXdoWDhWBYURMbMetTlAByn+6MS2luhCJJpOjPBVEQA8FAt3dS+YEHLzfsqsQu
 bxIR4oOCwaS7T8SSoq79OgxMaD5WozAAQOevK9xG90cm6xtiSfjYLIYrEXlnjgdI8r27
 4z+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh8ohL02GkCS+Wn8cOhDH3whnePCd/B0dfuRpsmUDaLi7lrMuYnkH1F4qb4cSYpNy7C3m3cRWcANNF@nongnu.org
X-Gm-Message-State: AOJu0YzKqxicZdb7z/+DdnjYxH+WMtuUsEy9RQmOWrzdCmnwSvb4SxGg
 nKe2z4+c2HH0fep/yZzJIcKCN+Wq3MTPLtiWmXKXwm7P48hxOXCVQmTQnK06OY4nqqyoTpZzO8a
 vGAdOQoyl11mFBZFqhE9lNpDGkY9qM9c+tftFe7CDDcp0C+oDpDkjLwOX8lK39TWg8aAP+P+2tz
 JeNZPzGEgdYDfAdEyXFK1f3qn4zjk=
X-Gm-Gg: ASbGncvUr0Ernw5tXx6gHoUSFHRXSL1tmZvL6UP3iv64GVFWNFfICHcp1I6B3cc0aye
 4hiZ01JFL0wVK/gB7fdUjV3/P50flSctD
X-Received: by 2002:a5d:6482:0:b0:382:356a:c927 with SMTP id
 ffacd0b85a97d-385c6eb7eccmr839943f8f.9.1732673601959; 
 Tue, 26 Nov 2024 18:13:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv37+/+Vgo2151LDNwLNbkoVJuq0uhErrVmsU/Mv5bXnX+fQYnbo7mCH0MqdwNYjYP6EWY7ryzbOrM7A/B3YY=
X-Received: by 2002:a5d:6482:0:b0:382:356a:c927 with SMTP id
 ffacd0b85a97d-385c6eb7eccmr839930f8f.9.1732673601677; Tue, 26 Nov 2024
 18:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20241109063241.1039433-1-lulu@redhat.com>
 <20241109063241.1039433-3-lulu@redhat.com>
In-Reply-To: <20241109063241.1039433-3-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 27 Nov 2024 10:12:44 +0800
Message-ID: <CAPpAL=z6aybHaEajNeCziTEpB7QDv1YRXrHBi_NshBSxHt4o0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] virtio_net: Add the check for vdpa's mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

QE tested this series patch with regression tests and tested
"check-mac=3Dtrue" separately. Regression test pass, about the
"check-mac=3Dtrue" test results, QE also think it is expect result:
1. Boot guest with vdpa device and "check-mac=3Dtrue", and randomly
setup a mac address.
-netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0,che=
ck-mac=3Dtrue
\
-device virtio-net-pci,netdev=3Dvhost-vdpa0,mac=3D00:11:22:33:44:55 \
2. Check it inside the guest, what is different from the previous
situation is that the nic with a randomly set mac address can still
obtain an ip from the dhcp server.
3. Re-setup mac address and boot again this guest, it will fail with:
vDPA device's mac 00:11:22:33:44:66not same with the cmdline's mac
00:11:22:33:44:55,Please check.

Tested-by: Lei Yang <leiyang@redhat.com>


On Sat, Nov 9, 2024 at 2:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> index f2104ed364..01cac20d92 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3594,12 +3594,43 @@ static bool failover_hide_primary_device(DeviceLi=
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
> +    /*For VDPA device following situations are acceptable:*/
> +
> +    if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> +        /*
> +         * 1.The hardware MAC address is the same as the QEMU command li=
ne MAC
> +         *   address, and both of them are not 0.
> +         */
> +        if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0))=
 {
> +            return true;
> +        }
> +    }
>
> +    error_setg(errp,
> +               "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
> +               "not same with the cmdline's mac %02x:%02x:%02x:%02x:%02x=
:%02x,"
> +               "Please check.",
> +               hwcfg.mac[0], hwcfg.mac[1], hwcfg.mac[2], hwcfg.mac[3],
> +               hwcfg.mac[4], hwcfg.mac[5], cmdline_mac->a[0], cmdline_ma=
c->a[1],
> +               cmdline_mac->a[2], cmdline_mac->a[3], cmdline_mac->a[4],
> +               cmdline_mac->a[5]);
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
> @@ -3707,6 +3738,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>
>      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status =3D VIRTIO_NET_S_LINK_UP;
> @@ -3753,7 +3785,13 @@ static void virtio_net_device_realize(DeviceState =
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
>
>


