Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F86C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 05:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0DRi-000370-El; Thu, 03 Apr 2025 01:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u0DRd-00036P-HV
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 01:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u0DRb-0008MK-CX
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 01:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743659330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QAhsCbtMKgjYG8vexX36LZnarsnyvS4iPLjvW7fXa4=;
 b=axrSjsZFsyq9fujY7g/MtShgCMpSwJyTHbw/LaamCItFbypPhWHCDDKBYmk3SLnj/shK1C
 /vfBo+dXLSNvt2zc3/tk6FroO4A4dMvlVL67bgf340Nox1NWLcQbdp8gRSwqtx78YAs+R/
 /iwkwcYurTaS980dZfbt2pLtoaz7dW8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-jXnuVa01MWKX6ZdJDmUxyw-1; Thu, 03 Apr 2025 01:48:46 -0400
X-MC-Unique: jXnuVa01MWKX6ZdJDmUxyw-1
X-Mimecast-MFC-AGG-ID: jXnuVa01MWKX6ZdJDmUxyw_1743659325
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac27d8ac365so36737666b.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 22:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743659324; x=1744264124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0QAhsCbtMKgjYG8vexX36LZnarsnyvS4iPLjvW7fXa4=;
 b=vhYwC5n5WOJynueRC6fJm3ET/zlH7erbhERnvhu8BsKjuKO4GUmfthSR/gNoUOy+yM
 oeZGA/EruuuAtptv6w5Z+100M43UcoOcDwRbAjnzdJ6SgBKnJXErubWUY4hb9wTudK9/
 ND6U6gf1XSy1jVSZU9miqIzEUwr+u4fPBE8+SP1LU1oltFuOW3tDrcNkdLvIvRIrO/Lr
 sxx72JJ3JAaJDCiKesvdQ04fPs21YBjJo3FxlEFISQ3HF6acqOa6AFc0lPwNV5hs5oC3
 e1+1vo45A0f32tjiLKGKrRkvSpE3KIwfLDI+UZeEXCyCg5UGSloPXyBYZNwI+VBlvB+7
 Qv5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX7pdamtgX+OTCImqSWliBvE9FkHwqzA1soPciLBiDrGb9vXDHiCACiCfo3G/SoNpRGYWFb8z5cYZn@nongnu.org
X-Gm-Message-State: AOJu0YzzcL4Y+SKaEHn0F/EjioGGdnNUJb5YMh13Hqw3TMnv0GHf1XzI
 joDaQ54Wh3DUITwiUjMQN1GrWLNgmc1x4xTG3s/9RXp93ZxqAhL97rUPf//LJkna6SQ246nH2XF
 dfvhhPY0ycWA50XxPXd9nS7wxWZExI02oakO7sPwEqDRRn1nGzfDwpv1eV46H39Tm3LGXdrHPsi
 r5tqHkRRqlB62tJYnYK0qU3qBUO1A55ccAPfI=
X-Gm-Gg: ASbGncu3B6guxPL+NrjZgngjI42XD42IajoR7nVGXZdfVNkNDm8oV3okZzo4kVeG+NU
 ZGDu3EmOT9Mq+NLjCjRa8AloLfcj/8kB0P3OrtcRSogCoVxzJ8bIvIBfamfvcTbgTqFiGt99yiA
 ==
X-Received: by 2002:a17:907:3e8f:b0:ac3:47b1:d210 with SMTP id
 a640c23a62f3a-ac7a197279emr397744566b.39.1743659323913; 
 Wed, 02 Apr 2025 22:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRqcO3aHn4VL03C7jHEa+ig34zU1P2MMHbLD0sUWZMicPcrv1vRQT3otrtuhhkytxwDZomQ1Qy4qv3dtEpvmY=
X-Received: by 2002:a17:907:3e8f:b0:ac3:47b1:d210 with SMTP id
 a640c23a62f3a-ac7a197279emr397742866b.39.1743659323446; Wed, 02 Apr 2025
 22:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250326132021.1215568-1-lulu@redhat.com>
 <20250326132021.1215568-3-lulu@redhat.com>
 <20250402123150-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250402123150-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 3 Apr 2025 13:48:06 +0800
X-Gm-Features: ATxdqUHTjMG6t6FpbxPEbJG1tVm5sdOYStS4kKlvivyk4N6D50PKFqo7AYlXPZU
Message-ID: <CACLfguUoLPAdh-M5V1nQu_NCRSsqdFv=1gY=4VLZXmHvU6+mkA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] virtio_net: Add the check for vdpa's mac address
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Thu, Apr 3, 2025 at 12:34=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 26, 2025 at 09:19:31PM +0800, Cindy Lu wrote:
> > When using a VDPA device, it is important to ensure that the MAC
> > address is correctly set. The MAC address in the hardware should
> > match the MAC address from the QEMU command line. This is a recommended
> > configuration and will allow the system to boot.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 40 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index de87cfadff..a3b431e000 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3749,12 +3749,43 @@ static bool failover_hide_primary_device(Device=
Listener *listener,
> >      /* failover_primary_hidden is set during feature negotiation */
> >      return qatomic_read(&n->failover_primary_hidden);
> >  }
> > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n=
,
> > +                                      MACAddr *cmdline_mac, Error **er=
rp)
> > +{
> > +    struct virtio_net_config hwcfg =3D {};
> > +    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> > +
> > +    vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, E=
TH_ALEN);
> > +
> > +    /*For VDPA device following situations are acceptable:*/
>
>
> /* This is how you format comments in QEMU */
>
>
>
> /*Never like this*/
>
Will fix this

> > +    if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> > +        /*
> > +         * 1.The hardware MAC address is the same as the QEMU command =
line MAC
>
> space after .
>
will fix this
> > +         *   address, and both of them are not 0.
> > +         */
> > +        if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0=
)) {
> > +            return true;
> > +        }
> > +    }
> >
> > +    error_setg(errp,
> > +               "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
> > +               "not same with the cmdline's mac %02x:%02x:%02x:%02x:%0=
2x:%02x,"
>
> the same with the command line mac (avoid abbreviation)
>
> > +               "Please check.",
>
> space after , and no uppercase
>
> > +               hwcfg.mac[0], hwcfg.mac[1], hwcfg.mac[2], hwcfg.mac[3],
> > +               hwcfg.mac[4], hwcfg.mac[5], cmdline_mac->a[0], cmdline_=
mac->a[1],
> > +               cmdline_mac->a[2], cmdline_mac->a[3], cmdline_mac->a[4]=
,
> > +               cmdline_mac->a[5]);
>
>
> check what?  maybe "initialization failed"?
>
sure, will change these
thanks
cindy
> > +
> > +    return false;
> > +}
> >  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VirtIONet *n =3D VIRTIO_NET(dev);
> >      NetClientState *nc;
> > +    MACAddr macaddr_cmdline;
> >      int i;
> >
> >      if (n->net_conf.mtu) {
> > @@ -3862,6 +3893,7 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> >      virtio_net_add_queue(n, 0);
> >
> >      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> > +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
> >      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> >      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> >      n->status =3D VIRTIO_NET_S_LINK_UP;
> > @@ -3908,7 +3940,13 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
> >      nc =3D qemu_get_queue(n->nic);
> >      nc->rxfilter_notify_enabled =3D 1;
> >
> > -   if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST=
_VDPA) {
> > +    if (nc->peer && (nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHO=
ST_VDPA)) {
> > +        if (nc->peer->check_mac) {
> > +            if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, er=
rp)) {
> > +                virtio_cleanup(vdev);
> > +                return;
> > +            }
> > +        }
> >          struct virtio_net_config netcfg =3D {};
> >          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> >          vhost_net_set_config(get_vhost_net(nc->peer),
> > --
> > 2.45.0
>


