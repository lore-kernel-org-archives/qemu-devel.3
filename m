Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0172CF2592
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 01:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0AFM-0005Dj-HK; Sun, 13 Oct 2024 21:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t0AFH-0005BM-Ug
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 21:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t0AFG-00046J-Lp
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 21:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728870697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ychx6i39IkL5/guFGM+90FXsMKJWsQp1m7bQm+xG7to=;
 b=gXmH8PD2g2d/6DnWE7JlhquHg1yu555ILw6JYrIs1jiO+J8qk4NYWXA0QDUQFKsIy4+5TP
 fC9QH8bvT99i2bvQP/sVVkt4op4TLkCsUWgI/51EPZeyxQWnDhhY2j1QI5GpNTWJQmKhlc
 0zKoK4Zdn8S7+iKBeefvqwL2H5qKdHM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-jEHsQ77HPwGUR02zFggxYQ-1; Sun, 13 Oct 2024 21:51:33 -0400
X-MC-Unique: jEHsQ77HPwGUR02zFggxYQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a9946fff3adso224893166b.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 18:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728870692; x=1729475492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ychx6i39IkL5/guFGM+90FXsMKJWsQp1m7bQm+xG7to=;
 b=Pckme26oZN08ucMQprctpkbXSLf6ExjyARAu2c+Cg3ZxNVUGinLrWZSS7KEklZo0kO
 6jMw3yCK3yH29CW1JA8zYusKIbBIsTqmX6mQnl/iXKYsjdFDW0bRbEnkzY4h+4IfkYx6
 +fY7Q+tMSqFf/xH2tg0Y7nKpQk1HNJP6itEvnpov6LXWSAy3OqizHm1NoHrSPRhvNk5e
 3cdOK+GlOpO9sATxI2BRykKX+cDLHx+Rw8gr7kwb17GI2x3v7Nhayk+qo5ONKD1il5cR
 70G19mEOVaN6XAo/QIqWMoHUdrKEnhPF/U3Zl6XuckQwjcUqbfkhGFMPXbvzCecrdJEd
 Wy7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrvTBWW2vYRad0Gncw9yEk86oeNZKOynnpnntKQ3v8eKlCWrMqiw/2hr2pGV2js0Mc4VhWUy0RdWyV@nongnu.org
X-Gm-Message-State: AOJu0YxVGhBvl0KIee5Uv6C7jBOsAbdFAnkYm4vAfC8hpkes33/yhjZk
 L3pKpH9ZReJAYRVjHCt3A5Z2fO/P5CTXzgmy1CUOru8Z22OCqCfNb1cnYWhxZUBrkatmcRESaoi
 j4rGc4z0j/WitWbQPQSa/Afyf0pUb4DzzziKx58UPJS99yGUIsjioDcMKO/eH3zCiz3O8DrrKlz
 hjV+7UDQb0Kz89ir1SIK3Q0lhJ3jw=
X-Received: by 2002:a17:907:7ba1:b0:a9a:9b1:f972 with SMTP id
 a640c23a62f3a-a9a09b1fabamr311961066b.40.1728870692341; 
 Sun, 13 Oct 2024 18:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRbxnCCJKTbKBUkld4ezGxu7f+felA4gPENr4OWQ6iNbZ8+1Lr9tSMF5mU09DvC/GsOqvE7yqr4U8nONMwMLA=
X-Received: by 2002:a17:907:7ba1:b0:a9a:9b1:f972 with SMTP id
 a640c23a62f3a-a9a09b1fabamr311960466b.40.1728870691964; Sun, 13 Oct 2024
 18:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240929160045.2133423-1-lulu@redhat.com>
 <20240929160045.2133423-4-lulu@redhat.com>
 <CACGkMEsMbzi42mHUopNfA=0Z1Dx1ZZ9Yf9RxJxgESbrCiQAp6w@mail.gmail.com>
In-Reply-To: <CACGkMEsMbzi42mHUopNfA=0Z1Dx1ZZ9Yf9RxJxgESbrCiQAp6w@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 14 Oct 2024 09:50:55 +0800
Message-ID: <CACLfguX7umUo7DcwpaQtPH=FWvgtMnJfHNAY9+bnAW6Rou47yg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio_net: Add the 3rd acceptable situation for
 Mac setup.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, 9 Oct 2024 at 16:30, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Sep 30, 2024 at 12:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > While the hardware MAC address is 0 and the MAC address in
> > the QEMU command line is also 0, this configuration is
> > acceptable.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 5c610d8078..668fbed9f2 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3620,6 +3620,17 @@ static bool virtio_net_check_vdpa_mac(NetClientS=
tate *nc, VirtIONet *n,
> >              return true;
> >          }
> >      }
> > +    /*
> > +     * 3.The hardware MAC address is 0,
> > +     *  and the MAC address in the QEMU command line is also 0.
> > +     *  In this situation, qemu will use random mac address
>
> And explain how the device knows such a random mac address or it's
> just for a best effort try.
>
> Thanks
>
sure, will add these
Thanks
cindy
> > +     */
> > +    if ((memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) =3D=3D 0) &&
> > +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> > +        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> > +
> > +        return true;
> > +    }
> >
> >      error_setg(errp,
> >                 "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
> > --
> > 2.45.0
> >
>


