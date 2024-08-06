Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7A2C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGnm-0006QJ-Rm; Tue, 06 Aug 2024 05:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sbGnm-0006Pq-6Z
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sbGnk-00053J-Mk
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722937699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IQUKpBYcH6nNtBEgkzO65EzEaH0vEOFcCO83eM27+A=;
 b=W/441vKcEsXqBmg7IcboMIUDmkhsZHZ7KCLvbDBLuIBm7Qda2rCATs2f7biL+WfO8lPWPj
 ECWsb3cCeIvvEjQkKnOmVwDdVfdywEKlxjMELn+Q7iqpAkQ2KWLenbt98Cpc8W3xsyiKf4
 dihuf5iHliEyivriNijGDL8Zy6psupE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-m9QkwzCVO5qUgn3JO2RHPw-1; Tue, 06 Aug 2024 05:48:18 -0400
X-MC-Unique: m9QkwzCVO5qUgn3JO2RHPw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a8b0832d9cso449764a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 02:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722937697; x=1723542497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4IQUKpBYcH6nNtBEgkzO65EzEaH0vEOFcCO83eM27+A=;
 b=RcbCMTU2rLrC3cmLD1ueZZtTkGw0Blz2jPSy/I/flUDHrTc3QTNJQt7mJS4tOENneR
 fO7Aey0znV+wP/tQX9bEN3hq1/cmVO2hBsqvRBR+ilBrhsIWO3WiAzbBKkk2V7+x2fFi
 49QRsjZbDRGo1DBra03TmzPOgBRu23IJIFWywSADbKzbJ/GA6x+sUtjiH3JFOYu9IwXI
 C3+8h1SanIq7QJkSdpPJn/l719j4/ocZ8R45ZdSuPKxDRzHgqpqv7FKTbSaAKaIxlvGu
 Pusoi/10c1zulQoiS+uWuNwSKxqHY/iS7n5QqjHy+AEAQZ/e6c2JFLPndUK77bc9NJ2z
 1kjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh6WQTPdXNncKEnIfLrBEKQbT0vgNhTmRAEUDMMWiGtKZtWYOgdc4IkkcJT9C7ynYKuZ4IcIZ0iW3u1CO6QdSdgfZ/ZRY=
X-Gm-Message-State: AOJu0YySgoVQUmkIAlyRXlJbw/45qY3ksfLMX+RgbEjN9rFStMyasQFK
 /2wzuiz5BJk2+8iN1Y11qn2nsh4q/M/UQeaxwlaULkpEFQ5IirxFTlm3L3msvxGP+pwSLkVnxhr
 C29t3/TitnF91QJF0L7NMnNCFW0+ddR8YLVRm2twkYmXBue9g2SZ84Oflop+UXcbfeBFzuoVdzk
 RqmQQUob5hq3zuT7k2wJViw1HDd4E=
X-Received: by 2002:a50:ff0b:0:b0:5a0:e61c:edfd with SMTP id
 4fb4d7f45d1cf-5b7f3ad6b9amr9739663a12.14.1722937697314; 
 Tue, 06 Aug 2024 02:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEioIPM+7JD6BBS5Evh/rXZRfbPzQd/Xx3u6+lFQ9VRfNgQzMGitjs+XiOJM5XW6MbMORkfZ5k1/FMKN10RnWQ=
X-Received: by 2002:a50:ff0b:0:b0:5a0:e61c:edfd with SMTP id
 4fb4d7f45d1cf-5b7f3ad6b9amr9739648a12.14.1722937696884; Tue, 06 Aug 2024
 02:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
 <20240806005814.51651-3-lulu@redhat.com>
 <CACGkMEtg+jApyj4Wxi3b_x=hEpHc0Hx3=cziMef6jq0Ft5S3Pw@mail.gmail.com>
In-Reply-To: <CACGkMEtg+jApyj4Wxi3b_x=hEpHc0Hx3=cziMef6jq0Ft5S3Pw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 6 Aug 2024 17:47:40 +0800
Message-ID: <CACLfguVvXDMeR+RsGW-ToUt+X8v-=zRZepSDbvjesC5jLRXbJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio_net: remove the unnecessary check in get_config
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
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

On Tue, 6 Aug 2024 at 11:09, Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Aug 6, 2024 at 8:58=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > The vdpa device with MAC address 0 should not boot.
> > So remove the check here
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Please describe what issues you've seen, and how it is fixed by this comm=
it.
>
> Thanks
>
this is a fix after the previous one. In the previous fix, the device
with MAC address 0 would not allow booting, so there is no need to
check if the MAC address is 0 here.
I will re-organize  the whole patch and make it more clear
Thanks
Cindy
> > ---
> >  hw/net/virtio-net.c | 13 -------------
> >  1 file changed, 13 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index c144ae2e78..8a7c743ad3 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -142,7 +142,6 @@ static void virtio_net_get_config(VirtIODevice *vde=
v, uint8_t *config)
> >      VirtIONet *n =3D VIRTIO_NET(vdev);
> >      struct virtio_net_config netcfg;
> >      NetClientState *nc =3D qemu_get_queue(n->nic);
> > -    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> >
> >      int ret =3D 0;
> >      memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> > @@ -170,18 +169,6 @@ static void virtio_net_get_config(VirtIODevice *vd=
ev, uint8_t *config)
> >          if (ret =3D=3D -1) {
> >              return;
> >          }
> > -
> > -        /*
> > -         * Some NIC/kernel combinations present 0 as the mac address. =
 As that
> > -         * is not a legal address, try to proceed with the address fro=
m the
> > -         * QEMU command line in the hope that the address has been con=
figured
> > -         * correctly elsewhere - just not reported by the device.
> > -         */
> > -        if (memcmp(&netcfg.mac, &zero, sizeof(zero)) =3D=3D 0) {
> > -            info_report("Zero hardware mac address detected. Ignoring.=
");
> > -            memcpy(netcfg.mac, n->mac, ETH_ALEN);
> > -        }
> > -
> >          netcfg.status |=3D virtio_tswap16(vdev,
> >                                          n->status & VIRTIO_NET_S_ANNOU=
NCE);
> >          memcpy(config, &netcfg, n->config_size);
> > --
> > 2.45.0
> >
>


