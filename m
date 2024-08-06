Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5367C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 11:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbI90-00063T-8O; Tue, 06 Aug 2024 07:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1sbI8w-00062a-Dg
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 07:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1sbI8s-0001BA-En
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 07:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722942846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPam5XtrtzfL5H+cB6My2oOmySe8txmtEsZNEufCKqQ=;
 b=OfuvYIPfZXE+r1B01OW2FAYzzat+DucAwwN3T+8F7ARlkpVotHiZzLHgncqNEK0MNLdoE9
 9Xq5EPd5Y7rkDuLc0eiXSxm8TMfre9kFDoD6TFoeWjlZXQaXvoMGmEx3wqW9sjcRK7hm5+
 +kiQ11mSDqSCZ6IDOANsbmgWEro70Jo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-QjHtZ_5dPHepZHmc0uUghw-1; Tue, 06 Aug 2024 07:12:56 -0400
X-MC-Unique: QjHtZ_5dPHepZHmc0uUghw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-8213223337eso195249241.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 04:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722942775; x=1723547575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPam5XtrtzfL5H+cB6My2oOmySe8txmtEsZNEufCKqQ=;
 b=uw33xeXvoBZJad9yDdMEtoe8s1i8qb9SiXXcpQSKdgUGNSoUIiIx97m8Hf1YbxNh/C
 /EwK/1jHCWLJCDXLeGSvqoJhA3rKSPfEDNwByUQF96m79W5vLoV+ffdi23xrCM5xt5lu
 LdmtOfJvjy2UxiduGJfpx14gC0L8tJHGfocRXQII7C10c9jY7OINy7sc8n+sRDzok5+3
 Wr350jK5ZsqsabXNsP/RTmIBt4A8QAo34+HgEKUhj1/X1BEbAHmMga8M9k2zwNrvMeUn
 fYicWXrqSYe/YHXiQVyGRIg+Hakp38BzgzQoBSr1VTpFn3N1xNIXFh6DoPJpk3dd/xP0
 pJKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsCPho98sRX9mif3TZXIXJMMgmKA3QWGTQKxQgYEYqG1BnqpJ0KsZzV8Aahvyt5EBm38cPlUYrFdsScMKjWxCc7ZUzpXQ=
X-Gm-Message-State: AOJu0YzM1k9/iV+d44pn1OlNu2zrxkYPJS+uWybG/SULuUQyiV3HKaa1
 tTkMJTgjHsxCvSIyoj5ak1G52qDGIr4I8Gw1L9LwpIC2TM3QWpBw/4dbhxb90i3qtKUV53uin4d
 1hT9ZN24NLz1McrzTtUc1jJ9+Tw6NrL97tpalSITsVejSD0UEMf2oBj4qgmyFuHusB8V1ykdooi
 iNF2daVMYgZfu6XN0yO7pHpBm11sw=
X-Received: by 2002:a05:6122:2090:b0:4f6:ae65:1e10 with SMTP id
 71dfb90a1353d-4f89ff60bb5mr18910675e0c.4.1722942775509; 
 Tue, 06 Aug 2024 04:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFis24odXYa45lD5Fvw9ep4xIh/FqPuvK4zVAx5auGbJWvu6jRJm8cokKn8zdxprHgPk/fISgfQg/zr+ZKcrp8=
X-Received: by 2002:a05:6122:2090:b0:4f6:ae65:1e10 with SMTP id
 71dfb90a1353d-4f89ff60bb5mr18910654e0c.4.1722942775154; Tue, 06 Aug 2024
 04:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
 <CACGkMEuCJT8KYsDgJaXzvy1Fhm6+tJinowdTtoAngsnvYjB54Q@mail.gmail.com>
 <CACLfguU47TPw5=GpS93AMWEYcy95JJ6+uG-PYpdmeD=hrKGa1Q@mail.gmail.com>
In-Reply-To: <CACLfguU47TPw5=GpS93AMWEYcy95JJ6+uG-PYpdmeD=hrKGa1Q@mail.gmail.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 6 Aug 2024 14:12:44 +0300
Message-ID: <CAGoVJZw5=1nsdpJu86QTQqc-2nuWjwRGpe1qaO1wvQF4u=9L4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio_net: Add the check for vdpa's mac address
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do we check that the MAC from the command line or HW was formed
correctly and doesn't include multicast bit?

Best regards,
Yan.


On Tue, Aug 6, 2024 at 12:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, 6 Aug 2024 at 11:07, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Aug 6, 2024 at 8:58=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > When using a VDPA device, it is important to ensure that
> > > the MAC address in the hardware matches the MAC address
> > > from the QEMU command line.
> > > This will allow the device to boot.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  hw/net/virtio-net.c | 33 +++++++++++++++++++++++++++++----
> > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 9c7e85caea..7f51bd0dd3 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -3579,12 +3579,36 @@ static bool failover_hide_primary_device(Devi=
ceListener *listener,
> > >      /* failover_primary_hidden is set during feature negotiation */
> > >      return qatomic_read(&n->failover_primary_hidden);
> > >  }
> > > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet =
*n, MACAddr *cmdline_mac,
> > > +                                     Error **errp)
> > > +{
> > > +       struct virtio_net_config hwcfg =3D {};
> > > +       static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } }=
;
> > > +
> > > +       vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwc=
fg, ETH_ALEN);
> > > +
> > > +    /*
> > > +     * For VDPA device: Only two situations are acceptable:
> > > +     * 1.The hardware MAC address is the same as the QEMU command li=
ne MAC
> > > +     *   address, and both of them are not 0.
> >
> > I guess there should be a bullet 2?
> >
> yes, there is a section 2, will change this code here
> Thanks
> cindy
> > > +     */
> > > +
> > > +       if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> > > +               if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr))=
 =3D=3D 0)) {
> > > +                       return true;
> > > +               }
> > > +       }
> > > +       error_setg(errp, "vDPA device's mac !=3D the mac address from=
 qemu cmdline"
> > > +                        "Please check the the vdpa device's setting.=
");
> >
> > For error messages I think it's better to use english instead of "!=3D"
> > to describe the issue.
> >
> > >
> > > +       return false;
> > > +}
> > >  static void virtio_net_device_realize(DeviceState *dev, Error **errp=
)
> > >  {
> > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > >      VirtIONet *n =3D VIRTIO_NET(dev);
> > >      NetClientState *nc;
> > > +    MACAddr macaddr_cmdline;
> > >      int i;
> > >
> > >      if (n->net_conf.mtu) {
> > > @@ -3692,6 +3716,7 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
> > >      virtio_net_add_queue(n, 0);
> > >
> > >      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl=
);
> > > +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
> > >      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> > >      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> > >      n->status =3D VIRTIO_NET_S_LINK_UP;
> > > @@ -3739,10 +3764,10 @@ static void virtio_net_device_realize(DeviceS=
tate *dev, Error **errp)
> > >      nc->rxfilter_notify_enabled =3D 1;
> > >
> > >     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHO=
ST_VDPA) {
> > > -        struct virtio_net_config netcfg =3D {};
> > > -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > -        vhost_net_set_config(get_vhost_net(nc->peer),
> > > -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_F=
RONTEND);
> > > +          if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, er=
rp)) {
> > > +                  virtio_cleanup(vdev);
> > > +                  return;
> > > +          }
> >
> > Any reason we remove vhost_net_set_config() here? It is not described
> > in the commit or does it belong to another patch?
> >
> > Thanks
> >
> as we discussed before=EF=BC=8C the MAC address in hardware should have a
> "higher priority"
> than the MAC address in qemu cmdline. So I remove the set_config there,
> the MAC address from the hardware will overwrite the MAC in qemu
> cmdline. so don't need to set_config to hardware now
> Thanks,
> cindy
> > >      }
> > >      QTAILQ_INIT(&n->rsc_chains);
> > >      n->qdev =3D dev;
> > > --
> > > 2.45.0
> > >
> >
>
>


