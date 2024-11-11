Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759CAD12D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 01:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAJC1-0004fQ-5F; Sun, 10 Nov 2024 20:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tAJBy-0004el-Vb
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 20:26:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tAJBt-0008Uu-Mu
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 20:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731288364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=didvIYDsdJo6E6d8xixwRgNeqg9Zl/t32NmU47rL60w=;
 b=UJ4X7YDdCZ6ijKvsQINofBDRR5fru8fnAqBe3l2JxDE6PpBdSa6olBZEYaihlKB8SyvLB5
 iLUR6vScYklVoZTSeyzAKsj9qBi+75reQf50UdOeqpz8da4nMjGBvKRX93uqePFQ/7axll
 gDY5e/J5aPm4veigQ5pROmong05m2xI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-a9KBLOkyPsmdOz5yFbac4g-1; Sun, 10 Nov 2024 20:26:02 -0500
X-MC-Unique: a9KBLOkyPsmdOz5yFbac4g-1
X-Mimecast-MFC-AGG-ID: a9KBLOkyPsmdOz5yFbac4g
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e9be88a33cso1644691a91.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 17:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731288362; x=1731893162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=didvIYDsdJo6E6d8xixwRgNeqg9Zl/t32NmU47rL60w=;
 b=d1S/czjLbUUc/mPOTvqwenP+5DgfE0PvEVS8xQ7i4MEjtU+H+JDzCBL3b6nCHO7ACs
 gnpn9v7XUW1hfqC3uwatuAkeK+gZHgbXAMRKNltIMElZ+3IhTuOHA2R8Dn7zDGYzdseQ
 2sFYtjvXRdlaHEyPyWpIroOSzodgzpTXj+TSQ3eijS6tmhCi366WaQhgdYrjv3aXnC7B
 /yEaziAE5RavqKiZ4d/852WhUM29qHppowPE3VaXiPb7dPRK53McU4yOu0NAfHPjySf3
 uZHn9FMdMeXPBmkQKNVYK2CAzlPiVGOW/JMBx/S1DwC7AwkXdfgGdDeGqsA/IQK2S8bg
 xd8g==
X-Gm-Message-State: AOJu0YyVz5qAuRVJAorOzx9wsPFO1tUo1RbuxrYWrcj9Ep0PXRxd7oYq
 RqNPh5rJhdMXLGyptiC8bli4u3QKuLinlWyxC+G55Y3y8uQD7NUmFpr9LhSKP6nHVZlE6cQAO+w
 H8sJGHcblni/BxC4UWzy5JngQFLhhxol/1TVGFD2ZN986+FhXn9dHOth23yX3Nq7KBA4pUcOwLs
 F3n1CRvfsB15VbeJd1ljarUReTxF4=
X-Received: by 2002:a17:90b:2241:b0:2e2:8995:dd1b with SMTP id
 98e67ed59e1d1-2e9b166dafdmr14169386a91.3.1731288361660; 
 Sun, 10 Nov 2024 17:26:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdc3UOXELsDJacCaj2Qp5SOwzRCYoWTEb/wk+gKJ6YStMhYhydtHQEX52nGkUllgbhlG+Aonpen7kqXSB4y4c=
X-Received: by 2002:a17:90b:2241:b0:2e2:8995:dd1b with SMTP id
 98e67ed59e1d1-2e9b166dafdmr14169355a91.3.1731288361171; Sun, 10 Nov 2024
 17:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20241107163210.3620697-1-peter.maydell@linaro.org>
 <20241107163210.3620697-2-peter.maydell@linaro.org>
 <CAFEAcA8mu0fbOtmqCm6pV_pBvAzW4UCe_1xg7P7RpL3NQY4ohw@mail.gmail.com>
In-Reply-To: <CAFEAcA8mu0fbOtmqCm6pV_pBvAzW4UCe_1xg7P7RpL3NQY4ohw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:25:49 +0800
Message-ID: <CACGkMEt5JBMJTFvvbBjmkbOgZndHQSYuEcnJiydnA5B7EQ4y=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/virtio-net.c: Don't assume IP length field is
 aligned
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
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

On Fri, Nov 8, 2024 at 4:48=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 7 Nov 2024 at 16:32, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > In virtio-net.c we assume that the IP length field in the packet is
> > aligned, and we copy its address into a uint16_t* in the
> > VirtioNetRscUnit struct which we then dereference later.  This isn't
> > a safe assumption; it will also result in compilation failures if we
> > mark the ip_header struct as QEMU_PACKED because the compiler will
> > not let you take the address of an unaligned struct field.
> >
> > Make the ip_plen field in VirtioNetRscUnit a void*, and make all the
> > places where we read or write through that pointer instead use some
> > new accessor functions read_unit_ip_len() and write_unit_ip_len()
> > which account for the pointer being potentially unaligned and also do
> > the network-byte-order conversion we were previously using htons() to
> > perform.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  include/hw/virtio/virtio-net.h |  2 +-
> >  hw/net/virtio-net.c            | 23 +++++++++++++++++++----
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> > index 060c23c04d2..b9ea9e824e3 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -102,7 +102,7 @@ typedef struct VirtioNetRscStat {
> >  /* Rsc unit general info used to checking if can coalescing */
> >  typedef struct VirtioNetRscUnit {
> >      void *ip;   /* ip header */
> > -    uint16_t *ip_plen;      /* data len pointer in ip header field */
> > +    void *ip_plen; /* pointer to unaligned uint16_t data len in ip hea=
der */
> >      struct tcp_header *tcp; /* tcp header */
> >      uint16_t tcp_hdrlen;    /* tcp header len */
> >      uint16_t payload;       /* pure payload without virtio/eth/ip/tcp =
*/
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index f2104ed364a..11cf462180d 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -2049,6 +2049,21 @@ static ssize_t virtio_net_do_receive(NetClientSt=
ate *nc, const uint8_t *buf,
> >      return virtio_net_receive_rcu(nc, buf, size, false);
> >  }
> >
> > +/*
> > + * Accessors to read and write the IP packet data length field. This
> > + * is a potentially unaligned network-byte-order 16 bit unsigned integ=
er
> > + * pointed to by unit->ip_len.
> > + */
> > +static uint16_t read_unit_ip_len(VirtioNetRscUnit *unit)
> > +{
> > +    return ldl_be_p(unit->ip_plen);
> > +}
> > +
> > +static void write_unit_ip_len(VirtioNetRscUnit *unit, uint16_t l)
> > +{
> > +    stl_be_p(unit->ip_plen, l);
> > +}
>
> These should of course be lduw_be_p() and stw_be_p(), since
> it's a 16 bit field.
>
> Interestingly nothing fails in "make check" or "make check-functional"
> if this breaks, suggesting we aren't exercising virtio-net very hard.

If I was not wrong, we don't test RSC in those tests. And RSC is only
enabled for Windows guests for certification purposes.

Thanks

>
> -- PMM
>


