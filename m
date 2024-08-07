Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD34AC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbWXO-0003iX-LB; Tue, 06 Aug 2024 22:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbWXN-0003hE-2q
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbWXK-0003L9-Pc
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722998185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQpRHf+2h7L5kvI42jU5Ge0NPjQwzESG7wv4H5cH2ZE=;
 b=GZViLbA3eEh4gWIMmvYFX37IaCcUYfCo04tx3zF1ktHpy1jw633lvLuk1NrshwUH9LroFn
 4guKgETJDB7yIfBu13m+j6urMtKC/Ylh6kIqG5fG6ehSaoeg9YZoUU6aQ+FY1PHAUldmeZ
 jFXZGSnEpzSYXx2OH4u8HIjQofoDhEw=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-tb6_eHm5NuKZ1u_kpYI9yQ-1; Tue, 06 Aug 2024 22:36:23 -0400
X-MC-Unique: tb6_eHm5NuKZ1u_kpYI9yQ-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-82c772e70c7so347373241.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722998183; x=1723602983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQpRHf+2h7L5kvI42jU5Ge0NPjQwzESG7wv4H5cH2ZE=;
 b=N7ACdlpA+n48TpezZQejeEFZTnBB+rgVpzUn7p6iJMSMoffatBEJ8+AADnv8uJpsak
 BCaCL0W7G+TjoiEzAaH3zrb78IASUvHY7267HjtyQjz7ky1cnJ5bJsn7RD3Y6gEuMAsf
 Xr6iYWU1l+7ThxH7r/Z/mrMNAnGh6lwfSycw5LMJjK5SyOjP8kRZ4wBcrmeXdPnMINyZ
 aqmdPdbeu1VKoPXsuhwjBy3lVZ49bpEilpP7Ch2Wnj1bNqueOLpOwn+9P0qbSlFQT16q
 /yK0cj0mWc/Gj94OQZfaVoF4TZdwXvrjNrdefv+xT4RCz1Tz4ZPYXg9YvpNvt3tIKF01
 9naw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVzHpqWIavU7tMhUco1ARQDHqQfDfPZuzxsgeYRJCUk9xvUPUA6BTJR/m3MOEwqJmGwdrE0rogatFtZlSK27rIk+GkSm8=
X-Gm-Message-State: AOJu0YymhVmbiVhNQbc1R1JGoxaa35nT+lLa+DTS8RIeuw90NLZuyrW8
 t2RS4HkZQnb39IuVzJemXNR5KDf8QPjzDSzGHZ2dmJwwybYyjmZlaEgoWW3muYuGt4KdzJXaC89
 JIFNJi+t339nZL1Xw1rT/hS+VVGary53xK5tykewJqwWG1lK8U5Skzf+/9MkeODtC0diPT8iFPI
 weV5Gr+RtO7avAs9wefH+JI1Jhv1E=
X-Received: by 2002:a05:6102:441b:b0:493:8695:b194 with SMTP id
 ada2fe7eead31-495b82d24acmr363152137.11.1722998182919; 
 Tue, 06 Aug 2024 19:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2r1g9ewYBABtbfnus27SQPUDvnbExPGXFrbkFAID9eCwgpZBhK0RxoAyyAr7IyBzVuxJm4zjzH2Q2RtH8H3M=
X-Received: by 2002:a05:6102:441b:b0:493:8695:b194 with SMTP id
 ada2fe7eead31-495b82d24acmr363145137.11.1722998182484; Tue, 06 Aug 2024
 19:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
 <CACGkMEuCJT8KYsDgJaXzvy1Fhm6+tJinowdTtoAngsnvYjB54Q@mail.gmail.com>
 <CACLfguU47TPw5=GpS93AMWEYcy95JJ6+uG-PYpdmeD=hrKGa1Q@mail.gmail.com>
In-Reply-To: <CACLfguU47TPw5=GpS93AMWEYcy95JJ6+uG-PYpdmeD=hrKGa1Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Aug 2024 10:35:52 +0800
Message-ID: <CACGkMEvCSKfahpBQLAMmSzdFN-QPhg5Zx+UQVrFX0HsWybZZNA@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio_net: Add the check for vdpa's mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Tue, Aug 6, 2024 at 5:44=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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

Probably, but I meant it needs to be a separate patch.

For example the title said "add ...." but here it's a removal of something.

Thanks

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


