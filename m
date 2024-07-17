Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6318CC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 01:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTtQg-0005Dk-R3; Tue, 16 Jul 2024 21:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sTtQe-0005CR-E1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sTtQb-0004JC-Ls
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721179556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOXQFsF6zB29YXXgPZ87eKa8OHqfql6zyecjmBPcwwA=;
 b=DeoWyTEW9cxOfld6yoLydJAVNB5x9i5zaz3PeArb0Wt+Dnrt6ip3yHtPYmPLfV0QQyFFoz
 MnJN0xS9+Cj1Ua4YVMRE/RoeXCdctnxlnGI34+owZlCYRZNmfw0s11ZhQN61h+1np/LxVk
 HSIyOCm9+7BDqKUB9nvfOXEakqOQHWE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-zcv_weEhPmCI0ihHU1yUjg-1; Tue, 16 Jul 2024 21:25:54 -0400
X-MC-Unique: zcv_weEhPmCI0ihHU1yUjg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-70affb2ea9aso4545488b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 18:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721179551; x=1721784351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JOXQFsF6zB29YXXgPZ87eKa8OHqfql6zyecjmBPcwwA=;
 b=MK1ikUfV+1vUUNHdbVyhlToBny9GVAvpcGUQvIc3yWZZcfM2qNKuxGrrK2FWScnfNY
 RKgls8OQSIUeTulCNTQpDGnUoyxhw3T2nOvWH8776Kd0wmzRpfl59EMECoRLxIKPkFSE
 iC22AL+sFj2UfR8OAfOFjwORuxl+V2FExSQSM8YQP19nNOSFaBJrIKHqCypjAZkTivyD
 HuU//Q8NlEKuPXkUe0+OajNY4beDyB7h586T9idmSBSqd44G7zIyNg9fyomxUpbYAjgC
 b5fFTbDSpjEqGQm8M2VICiHnuSwAxPhdcasfconLbjIuNQRBLb4hpn9qIF1jrm1sIL72
 3Bqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR5S6edoCFuI6alAfj1egJ27TnB2PiyEYDWLyRXlakqPkIEnmz6Lif2aLxPAsTBZjNexCHKlxw5jATBSAmgpVC8/11g9E=
X-Gm-Message-State: AOJu0YwqeH+8kSIdasOuz/gqkhv6RZICo5gkANIA9DcbZCIEtgU+tL+i
 kfR0anHnmD2vrLReRDsChx33aQDCrYwNQI3l6kkVNlXAHTOwcfRR+pD1RWZsWYJeb7ehzoRCWvr
 nnJ0/9fwyXPt8ihgq/Y+6cy70ZwwKQRCFQpz+93yTeA9oi16/aE1hP+WyMzM27s5n1UY2QRwhRt
 FvOPhWWO8N+kjautTquZCwW/ww06Y=
X-Received: by 2002:a05:6a00:4b0d:b0:706:700c:7864 with SMTP id
 d2e1a72fcca58-70ce4d83920mr186142b3a.4.1721179550916; 
 Tue, 16 Jul 2024 18:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2yRNLBA+F3ePgboAz9Ln08fTrEhXvP1D9RgyUmWNrXhVduXydfrWnFIU1gm4+73AtyAJL/wlcv4hOdin224E=
X-Received: by 2002:a05:6a00:4b0d:b0:706:700c:7864 with SMTP id
 d2e1a72fcca58-70ce4d83920mr186132b3a.4.1721179550470; Tue, 16 Jul 2024
 18:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com>
 <CACGkMEszp7U-x7UeBy6vSGv0Hox8YBD0nmWK=DNpfx7F5xGZYw@mail.gmail.com>
 <CACLfguXNyp1iM+FnxVTrLRntcNxhHpfciE=z6nhhBtWYRFSy9w@mail.gmail.com>
In-Reply-To: <CACLfguXNyp1iM+FnxVTrLRntcNxhHpfciE=z6nhhBtWYRFSy9w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Jul 2024 09:25:39 +0800
Message-ID: <CACGkMEvxMuowCxxJHNVYr=Ro4cvYs3D3VD0+Ds+4EgD1s53Gcg@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
 netdev@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Tue, Jul 16, 2024 at 2:09=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, 16 Jul 2024 at 13:37, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Jul 16, 2024 at 9:14=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > When using a VDPA device, it is important to ensure that the MAC addr=
ess
> > > in the hardware matches the MAC address from the QEMU command line.
> > >
> > > There are only two acceptable situations:
> > > 1. The hardware MAC address is the same as the MAC address specified =
in the QEMU
> > > command line, and both MAC addresses are not 0.
> > > 2. The hardware MAC address is not 0, and the MAC address in the QEMU=
 command line is 0.
> > > In this situation, the hardware MAC address will overwrite the QEMU c=
ommand line address.
> >
> > If this patch tries to do the above two, I'd suggest splitting it into
> > two patches.
> >
> This code is very simple. So I have put these two into one function.
> thanks

Better to split no matter how simple it is if there are two issues.

Btw, it's better to tell what kind of setup has been tested by this,
and do we need a fix tag here as well? (Or is this needed by -stable?)

> cindy
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  hw/net/virtio-net.c | 43 +++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 37 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 9c7e85caea..8f79785f59 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -178,8 +178,8 @@ static void virtio_net_get_config(VirtIODevice *v=
dev, uint8_t *config)
> > >           * correctly elsewhere - just not reported by the device.
> > >           */
> > >          if (memcmp(&netcfg.mac, &zero, sizeof(zero)) =3D=3D 0) {
> > > -            info_report("Zero hardware mac address detected. Ignorin=
g.");
> > > -            memcpy(netcfg.mac, n->mac, ETH_ALEN);
> > > +          error_report("Zero hardware mac address detected in vdpa d=
evice. "
> > > +                       "please check the vdpa device!");
> >
> > I had two questions:
> >
> > 1) any reason to do this check while the guest is running?
> > 2) I think we need a workaround for this, unless I miss something.
> >
> this is a code change to adjust the new fix. If the mac address is 0
> the guest should fail
> to load. Maybe I can just assert fail here?

I mean get_config is usually called during VM running. It's not good
to assert here and can we move the check to realize or other place
before the VM is running?

> Thanks
> cindy
> > >          }
> > >
> > >          netcfg.status |=3D virtio_tswap16(vdev,
> > > @@ -3579,12 +3579,42 @@ static bool failover_hide_primary_device(Devi=
ceListener *listener,
> > >      /* failover_primary_hidden is set during feature negotiation */
> > >      return qatomic_read(&n->failover_primary_hidden);
> > >  }
> > > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet =
*n,
> > > +                                      MACAddr *cmdline_mac, Error **=
errp) {
> > > +  struct virtio_net_config hwcfg =3D {};
> > > +  static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> > >
> > > +  vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, E=
TH_ALEN);
> > > +
> > > +  /* For VDPA device: Only two situations are acceptable:
> > > +   * 1.The hardware MAC address is the same as the QEMU command line=
 MAC
> > > +   *   address, and both of them are not 0.
> > > +   * 2.The hardware MAC address is NOT 0, and the QEMU command line =
MAC address
> > > +   *   is 0.
> >
> > Did you mean -device virtio-net-pci,macaddr=3D0 ? Or you mean mac
> > address is not specified in the qemu command line?
> >
> yes, what I mean is mac address not specified, sorry for the confusion,
> I will rewrite this part
> Thanks
> cindy
>

Thanks


