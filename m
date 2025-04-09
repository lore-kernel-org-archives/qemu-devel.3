Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3EDC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 07:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2PVI-0003fA-1V; Wed, 09 Apr 2025 03:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u2PV9-0003eZ-4e
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u2PV6-0006Jd-QC
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744182329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oufmMzE7QQPC3+IqtHva0JXHIwQF0Mrzu3DTmtWUwkM=;
 b=WLog7Anty4ioe2mWwwZUWRDD+OvguuLn795sY+NoCFHrF8qTv/d1KzIB337x4eyLAbT0sr
 Ddp60E6HLkJx1+ItAxRsudc/rDhA6SFvp4TGJDDcQCYmWbo/XaaW1/Deq6YGj0UOux1BjZ
 VncxzJFhh0jMN1Chu8In4EA4mPMZBco=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-HATYMjj_MuuF8OaW3hX1bw-1; Wed, 09 Apr 2025 03:05:26 -0400
X-MC-Unique: HATYMjj_MuuF8OaW3hX1bw-1
X-Mimecast-MFC-AGG-ID: HATYMjj_MuuF8OaW3hX1bw_1744182326
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac6caf952d7so769777566b.3
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 00:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744182326; x=1744787126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oufmMzE7QQPC3+IqtHva0JXHIwQF0Mrzu3DTmtWUwkM=;
 b=uJBJxVA+lGnbtyO1d1Qv335+vTk5z/TFLR9A9i4brfcrk2J4DpiyitkZ7SrJ2+3vqJ
 H3QBWoUEO2BycM4RN2TAIioNlP0X3oCtpd7Avf2h2pVkexP3b2TC3jOEAlctlgqFJ9hr
 Zv/1g6DzH3r3+fegTRYwb+EakZgz1siY83ljOeL7aXudn4TIA7v2O/hvO5OzMPrBvPB2
 Yfn1c+SL8yu3vB6ltHyGNVxSAzZa+mw3ov1nLkgS7QPejTj62eX3NZT9WCQdGfYM7kQv
 i+RQBo6QGORg8/ES/VcZAqzV2wsOooMXnByew0qr6vTi+h5lZK/9FKDTmdwPKvBGTvzS
 BYsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTzwGiFN0WQDuuSK0/OxLUvBbCp8XWWvpzkXv0JjYJHCg55n5qCRYuk0LMWXdXNGIlwXc0dZqsSYpb@nongnu.org
X-Gm-Message-State: AOJu0YylAVU/5KLFZdK3Ex2/QspCDaiUm+5S9+QEp1IUrS3ZWhV/S2+T
 7ZTGWakpUjI/DOqKVA8T7vyJwMM7Ossw5YDh95csZfw0VmV9jxFCjd7sbsKNrOpekaMijPJJWVY
 C6tIWjxAm82XrpBZ9BGbIFnTYDvX7mg9dCDZl2UrcSKJ8xHOm8zdnaYvdu/khHLErNvQcLIgUMC
 lM94WtASThVneSVsSzsdogi0MnmAU=
X-Gm-Gg: ASbGncuKOkEgIDec9ghLNSmtS77mHusX/X5z2XEQC9YpvmS2ckQyLj2y6BTA1/43MvK
 jDmmpAnGK6N8X2MEppU7ywNfJwoksSPA37/0lMC1GAd2mDPa6bINC9CdkpO7xgJ0BP5grGg==
X-Received: by 2002:a17:907:3c96:b0:ac1:e53c:d13f with SMTP id
 a640c23a62f3a-aca9b772764mr163464266b.50.1744182325527; 
 Wed, 09 Apr 2025 00:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3wpM/Zz5t0Xn32Uca2+6fT+WUfd1b6YEzPEWBmj2EyCRZRRrfIBwL+MLnSy8w3/AbEwX45wWPEPQOFGYz9gI=
X-Received: by 2002:a17:907:3c96:b0:ac1:e53c:d13f with SMTP id
 a640c23a62f3a-aca9b772764mr163462266b.50.1744182325154; Wed, 09 Apr 2025
 00:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250408061327.2590372-1-lulu@redhat.com>
 <20250408061327.2590372-3-lulu@redhat.com>
 <CACGkMEtfu_aa8cakY7_Snn25BYcMmFFp8XDvtnq=1ob9XP9Wig@mail.gmail.com>
In-Reply-To: <CACGkMEtfu_aa8cakY7_Snn25BYcMmFFp8XDvtnq=1ob9XP9Wig@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 9 Apr 2025 15:04:46 +0800
X-Gm-Features: ATxdqUEY9deoIhD768yTAEP7iP25dr1XdPGc4dq5oHKoixlh4V_qlfi4ujKiU5M
Message-ID: <CACLfguWUVHKvuoCVbLF8JGWHwvBoR7spDjy6tQ_CQBi-CnrvVQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] virtio_net: Add the check for vdpa's mac address
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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

On Tue, Apr 8, 2025 at 2:46=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Apr 8, 2025 at 2:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
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
> > index 340c6b6422..94ee21d1fc 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3751,12 +3751,43 @@ static bool failover_hide_primary_device(Device=
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
> > +    /* For VDPA device following situations are acceptable: */
> >
>
> Let's drop the comment here and below as the code explains themselves.
>
sure, will do
> > +    if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> > +        /*
> > +         * 1. The hardware MAC address is the same as the QEMU command=
 line MAC
> > +         *   address, and both of them are not 0.
> > +         */
> > +        if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0=
)) {
> > +            return true;
> > +        }
> > +    }
> > +    error_setg(errp,
> > +               "vDPA device's MAC address %02x:%02x:%02x:%02x:%02x:%02=
x "
> > +               "is not the same as the QEMU command line MAC address "
> > +               "%02x:%02x:%02x:%02x:%02x:%02x,"
> > +               "Initialization failed.",
> > +               hwcfg.mac[0], hwcfg.mac[1], hwcfg.mac[2], hwcfg.mac[3],
> > +               hwcfg.mac[4], hwcfg.mac[5], cmdline_mac->a[0], cmdline_=
mac->a[1],
> > +               cmdline_mac->a[2], cmdline_mac->a[3], cmdline_mac->a[4]=
,
> > +               cmdline_mac->a[5]);
>
> I would move this to the caller to be consistent with other errors.
>
sure, will do

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
> > @@ -3864,6 +3895,7 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> >      virtio_net_add_queue(n, 0);
> >
> >      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> > +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>
> Can we avoid this memcpy?
>
n->nic_conf.macaddr will be modified in the
qemu_macaddr_default_if_unset(&n->nic_conf.macaddr) function.If the
MAC is 0, it will be overwritten,
so if we don't use memcpy, we still need another way to track if the
MAC has changed
I think using memcpy here would make the code cleaner and more
straightforward. Maybe we can keep it
thanks
Cindy

> >      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> >      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> >      n->status =3D VIRTIO_NET_S_LINK_UP;
> > @@ -3910,7 +3942,13 @@ static void virtio_net_device_realize(DeviceStat=
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
> Thanks
>
> >
>


