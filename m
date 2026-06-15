Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1393CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8vF-0005gj-IP; Mon, 15 Jun 2026 11:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wZ8vD-0005gG-7Q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wZ8v9-0002UM-0U
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781536092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZcFWmuOOBiI0WPp8c6pzJyCNVMPvjHdELzi6wLfOnVs=;
 b=YfGfOx88/YsKIH62uYPEy2saCo56olqXwsifRtjOvvw8AdB8yzpez9WqHj3McgFoGPOY1j
 8E9yNIxS7xKOByJxxjIT9v0taIUC2/bP7tcWR2ReGi90VlmM5vW4sYD6UQiydOCaajkwl/
 /5yIhzFR9nmznfDNluOW7/7H9hQooys=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-djUPwEUgOI6KDwNhU4P5Zg-1; Mon, 15 Jun 2026 11:08:10 -0400
X-MC-Unique: djUPwEUgOI6KDwNhU4P5Zg-1
X-Mimecast-MFC-AGG-ID: djUPwEUgOI6KDwNhU4P5Zg_1781536090
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7ebbe5b410eso57914907b3.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 08:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781536090; cv=none;
 d=google.com; s=arc-20240605;
 b=JHIXhV8BKDvkATdmmSGTMjYHYajwMwYNhhILDR6GFKTgjCpBdwhLeDdSBqprOPztND
 iC3oklLhE5s/jwK8EhJUO7qGNqfhkHfP8SgwpONZqmkZu8gOsAx01IvZZRIMaHauDrQN
 zc80288QkSkLduCnCx5cBLj+Svx7hRbIDSdWR0D+ytDByWd1npDUjizejIdF0p+0uCS1
 //nqztHla6BrtRznuY+ER0KhPsOFP2byBpd+2K+XR1moS1YcvE2tBBI7VJ0tCWeg7IeD
 QdIxOVVIICUXVPBNiHYGji4Sy/vqLQ3Tkop2rQ7T/gnjSw8J+xn+6/KuJFv+LjGcLP3i
 Ua1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZcFWmuOOBiI0WPp8c6pzJyCNVMPvjHdELzi6wLfOnVs=;
 fh=xr86ryelAdLIIqRv6YUAoK2cRAM62KuousGFOjvKNGM=;
 b=geYOZYlGRcNkLZW9prxPNEz5KPzEfgTmZ5SrX4bpJICg9kaz1nwYd0Ma1qt13EQjFK
 tNyMxlvkIEVc80RnU6BUmV6CrxV8jQTIxsbOq/hluAQ8+sJWKELF4pYf1VY8oery7pej
 IawJYoSZVN6h7br/GVuvxVudC4A2jS12WcBTkQPrcWQn786EV8R7/LWWXhsglTGmokpT
 76VmC+S7WGoiDyE8VBZUs5S1KozOSHvH5krVnfFmry3TaHrWo9vfX6/HKnspBnIODrhc
 ASsEu2R8z6rB6Irr5W/P9npukhRN5SdAqXYcCe2v1sleNj4T9qMa4Ogk4CIcOqJFZDGj
 wMrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781536090; x=1782140890; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcFWmuOOBiI0WPp8c6pzJyCNVMPvjHdELzi6wLfOnVs=;
 b=cb2Ugxj9jAvzTeNb5UJEHjEQP9wUQJ2bsYaXGNwQh40Kj7k0GXtf7+sX68ItBP4rl4
 7Lxv2PsLlHFxlrIVfN/G/vZBfPXNLWkBm0DIfSr37gnTym1c/ShAE/eih37tELA5g+E6
 q8m9ekQqpIyZ/XaFAsWTDdDXRDtLySIz0vuAPz0NGSEOP+oZkAST9aWBgFKV7cJgO/ty
 3AjpE1sZwHu3zTM1hgCn2aHEiWtD7iG5R4KL+Xlg5OyLH6o0FT7Ma9KdH60G+/qctg1s
 Zmsh3/me3zaH3PzuKUwPwoaWNjF094WU4LoZ6xjvJmwkFRh0H8B8SnLfINMJXtA/zYab
 3y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781536090; x=1782140890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZcFWmuOOBiI0WPp8c6pzJyCNVMPvjHdELzi6wLfOnVs=;
 b=rT75erlqSuYFXOkLQz5T8ZIB7crB1FGuzpBgZwdXXE3E6PpJQeRZcVAGRJKzBD1WLV
 MBy0+l+URtJjiiu9J8pJFrtoVUapQrzPjr4hAhi++Hhp06V2AChHnUBNomFT/8X9qkEm
 8Rnz+5ffOKFdfomgWpYzOm8gQFEwSdXwxgYMMawAyUQousspYn7HNIFztZU0q5xD++mI
 BFHQwaGgAPDm4q0NcyrRFW6aNHK9Tyr1y2kBswgoXRU38YvUpJHBaDRh7djMGW38+V0/
 Gcg2MVF3sf7apBm/1QNFlWWgXdkBRggIlxdZIVpnOr+ND8eirjPfRdQiykyh1GwHWcXE
 8dQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9X/we9LBf8+VGuxm14Cg9nR3aN5mSQsIO2kE/8ailoZ1SPttcXFgBARwUKQpH3BBkEPnztBlTav8JG@nongnu.org
X-Gm-Message-State: AOJu0YxuB/TS3vcNtIfJWD3y6M2BnH1VD4s4u2PHmRow46/n2mkCFz9L
 BIN0hgLYn5W6sPjNbu/DE/BksS4es+mfrrejOe1O5NiIDbsPeiQv+y4TyJ9nFVZoUSS+bmvjnxs
 7G1SexKhDloAruLJ32YenC76Kc8kYJ+mqPbalFJsJUAWfRcxx495BaiygHm9jGXIkHHdA4JZFJ6
 ByoBdy0ZAt4k96Kmn8LuTehdkDJCXxgPk=
X-Gm-Gg: Acq92OH93+TZUseqF9Bky2FbMZFozDxYs02SJRv1JY+ioItPcl9zxw0oDXqbxBe25mA
 sbFd3qh4kM0bWuiZFS/3E6VcUY34TiPeBw/do2ITcsGJKExYDvZaBx6v+VFvlib2+gqvQSPl3fz
 dtUTM5c0qa5FSTpGhBwV1f4nesLMSuiodYtoXcZE4rE8IgYLi780T2FeyC7f7njIP/fqy9GP4yy
 HgXfg==
X-Received: by 2002:a05:690e:138c:b0:660:6bd2:499c with SMTP id
 956f58d0204a3-66278315e6bmr11295517d50.32.1781536089598; 
 Mon, 15 Jun 2026 08:08:09 -0700 (PDT)
X-Received: by 2002:a05:690e:138c:b0:660:6bd2:499c with SMTP id
 956f58d0204a3-66278315e6bmr11295462d50.32.1781536088978; Mon, 15 Jun 2026
 08:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251231110110.18201-1-wafer@jaguarmicro.com>
 <CAJaqyWerEFbYXuRZaRhit0vS5WZCgj5vfxwXCTxcvUuYEvOR+w@mail.gmail.com>
 <PUZPR06MB4713F96E5FB2078DD7F8B80FA28BA@PUZPR06MB4713.apcprd06.prod.outlook.com>
 <CAJaqyWf0GC6j6R=qVSDoqdNRbkJuo1jWpDZPanbcpb+n2QR8hw@mail.gmail.com>
 <SI2PR06MB47248753C619E17D40B73A4CA2352@SI2PR06MB4724.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB47248753C619E17D40B73A4CA2352@SI2PR06MB4724.apcprd06.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 15 Jun 2026 17:07:30 +0200
X-Gm-Features: AVVi8CdNsxjPOvjsDESxJvy1CYqxtWmjHz76JlIqYNWXPd47DR95F94A9pusKMw
Message-ID: <CAJaqyWd_dWia2c-tpCi-YU=tJx6BbSSvdpVzXOtP-Qps1NcNUg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vhost: SVQ add the indirect descriptors to
 available ring
To: Wafer <wafer@jaguarmicro.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leiyang@redhat.com" <leiyang@redhat.com>, 
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 Angus Chen <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 30, 2026 at 2:11=E2=80=AFPM Wafer <wafer@jaguarmicro.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Eugenio Perez Martin <eperezma@redhat.com>
> > Sent: 2026=E5=B9=B41=E6=9C=8819=E6=97=A5 17:29
> > To: Wafer <wafer@jaguarmicro.com>
> > Cc: mst@redhat.com; jasowang@redhat.com; qemu-devel@nongnu.org;
> > leiyang@redhat.com; sgarzare@redhat.com; Angus Chen
> > <angus.chen@jaguarmicro.com>
> > Subject: Re: [PATCH v4 4/4] vhost: SVQ add the indirect descriptors to
> > available ring
> >
> > External Mail: This email originated from OUTSIDE of the organization!
> > Do not click links, open attachments or provide ANY information unless =
you
> > recognize the sender and know the content is safe.
> >
> >
> > On Sun, Jan 18, 2026 at 9:31=E2=80=AFAM Wafer <wafer@jaguarmicro.com> w=
rote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Eugenio Perez Martin <eperezma@redhat.com>
> > > > Sent: 2026=E5=B9=B41=E6=9C=8815=E6=97=A5 18:56
> > > > To: Wafer <wafer@jaguarmicro.com>
> > > > Cc: mst@redhat.com; jasowang@redhat.com; qemu-devel@nongnu.org;
> > > > leiyang@redhat.com; sgarzare@redhat.com; Angus Chen
> > > > <angus.chen@jaguarmicro.com>
> > > > Subject: Re: [PATCH v4 4/4] vhost: SVQ add the indirect descriptors
> > > > to available ring
> > > >
> > > > External Mail: This email originated from OUTSIDE of the organizati=
on!
> > > > Do not click links, open attachments or provide ANY information
> > > > unless you recognize the sender and know the content is safe.
> > > >
> > > >
> > > > On Wed, Dec 31, 2025 at 12:01=E2=80=AFPM Wafer Xie <wafer@jaguarmic=
ro.com>
> > > > wrote:
> > > > >
> > > > > From: wafer Xie <wafer@jaguarmicro.com>
> > > > >
> > > > > Retrieve the target buffer from the indirect buffers by index, ad=
d
> > > > > the elements sent by the guest into the buffer=E2=80=99s indirect
> > > > > descriptors, and update freed_head and freed_number. If
> > > > > freed_number is zero, or if the current buffer=E2=80=99s freed_nu=
mber is
> > > > > less than the number of elements, update the buffer state to
> > SVQ_INDIRECT_BUF_FREEING.
> > > > >
> > > > > If the current indirect buffer does not have enough freed
> > > > > descriptors to accommodate the SVQ descriptors, descriptors can b=
e
> > > > > borrowed from the next indirect buffer.
> > > > >
> > > > > Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
> > > > > ---
> > > > >  hw/virtio/vhost-shadow-virtqueue.c | 341
> > > > > +++++++++++++++++++++++++----
> > > > >  1 file changed, 299 insertions(+), 42 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> > > > > b/hw/virtio/vhost-shadow-virtqueue.c
> > > > > index 4f564f514c..02a238548c 100644
> > > > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > > > @@ -139,86 +139,340 @@ static bool vhost_svq_translate_addr(const
> > > > > VhostShadowVirtqueue *svq,  }
> > > > >
> > > > >  /**
> > > > > - * Write descriptors to SVQ vring
> > > > > + * Add a single descriptor to a descriptor table
> > > > > + *
> > > > > + * @desc: The descriptor to write to
> > > > > + * @addr: IOVA address
> > > > > + * @len: Length of the buffer
> > > > > + * @flags: Descriptor flags (VRING_DESC_F_WRITE,
> > > > > +VRING_DESC_F_NEXT)
> > > > > + * @next: Next descriptor index (only used if VRING_DESC_F_NEXT
> > > > > +is
> > > > > +set)  */ static void vhost_svq_vring_add_desc(vring_desc_t *desc=
,
> > > > > +                                       hwaddr addr,
> > > > > +                                       uint32_t len,
> > > > > +                                       uint16_t flags,
> > > > > +                                       uint16_t next) {
> > > > > +    desc->addr =3D cpu_to_le64(addr);
> > > > > +    desc->len =3D cpu_to_le32(len);
> > > > > +    desc->flags =3D flags;
> > > > > +    if (flags & cpu_to_le16(VRING_DESC_F_NEXT)) {
> > > > > +        desc->next =3D cpu_to_le16(next);
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * Write descriptors to a descriptor table (chain or indirect)
> > > > >   *
> > > > >   * @svq: The shadow virtqueue
> > > > >   * @sg: Cache for hwaddr
> > > > >   * @iovec: The iovec from the guest
> > > > >   * @num: iovec length
> > > > >   * @addr: Descriptors' GPAs, if backed by guest memory
> > > > > + * @descs: The descriptor table to write to
> > > > > + * @start_idx: Starting index in the descriptor table
> > > > > + * @offset_idx: Offset for next field calculation (used for
> > > > > + indirect)
> > > > >   * @more_descs: True if more descriptors come in the chain
> > > > >   * @write: True if they are writeable descriptors
> > > > > + * @indirect: True if writing to indirect descriptor table
> > > > >   *
> > > > > - * Return true if success, false otherwise and print error.
> > > > > + * Return the next free descriptor index if success, -1 on error=
.
> > > > >   */
> > > > > -static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue
> > > > > *svq,
> > > > hwaddr *sg,
> > > > > -                                        const struct iovec *iove=
c, size_t num,
> > > > > -                                        const hwaddr *addr, bool=
 more_descs,
> > > > > -                                        bool write)
> > > > > +static int vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq=
,
> > > > > +                                       hwaddr *sg,
> > > > > +                                       const struct iovec *iovec=
,
> > > > > +                                       size_t num,
> > > > > +                                       const hwaddr *addr,
> > > > > +                                       vring_desc_t *descs,
> > > > > +                                       uint16_t start_idx,
> > > > > +                                       size_t offset_idx,
> > > > > +                                       bool more_descs,
> > > > > +                                       bool write,
> > > > > +                                       bool indirect)
> > > > >  {
> > > > > -    uint16_t i =3D svq->free_head, last =3D svq->free_head;
> > > > > -    unsigned n;
> > > > > +    uint16_t i =3D start_idx, last =3D start_idx;
> > > > >      uint16_t flags =3D write ? cpu_to_le16(VRING_DESC_F_WRITE) :=
 0;
> > > > > -    vring_desc_t *descs =3D svq->vring.desc;
> > > > >      bool ok;
> > > > >
> > > > >      if (num =3D=3D 0) {
> > > > > -        return true;
> > > > > +        return start_idx;
> > > > >      }
> > > > >
> > > > >      ok =3D vhost_svq_translate_addr(svq, sg, iovec, num, addr);
> > > > >      if (unlikely(!ok)) {
> > > > > -        return false;
> > > > > +        return -1;
> > > > >      }
> > > > >
> > > > > -    for (n =3D 0; n < num; n++) {
> > > > > -        if (more_descs || (n + 1 < num)) {
> > > > > -            descs[i].flags =3D flags | cpu_to_le16(VRING_DESC_F_=
NEXT);
> > > > > -            descs[i].next =3D cpu_to_le16(svq->desc_next[i]);
> > > > > +    for (size_t n =3D 0; n < num; n++) {
> > > > > +        uint16_t desc_flags =3D flags;
> > > > > +        uint16_t next;
> > > > > +
> > > > > +        if (indirect) {
> > > > > +            next =3D offset_idx + n + 1;
> > > > >          } else {
> > > > > -            descs[i].flags =3D flags;
> > > > > +            next =3D svq->desc_next[i];
> > > > >          }
> > > > > -        descs[i].addr =3D cpu_to_le64(sg[n]);
> > > > > -        descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
> > > > >
> > > > > +        if (more_descs || (n + 1 < num)) {
> > > > > +            desc_flags |=3D cpu_to_le16(VRING_DESC_F_NEXT);
> > > > > +        }
> > > > > +        vhost_svq_vring_add_desc(&descs[i], sg[n],
> > > > > +                                   iovec[n].iov_len, desc_flags,
> > > > > + next);
> > > > >          last =3D i;
> > > > > -        i =3D svq->desc_next[i];
> > > > > +        if (indirect) {
> > > > > +            i++;
> > > > > +        } else {
> > > > > +            i =3D next;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    /* Return the next free index */
> > > > > +    if (!indirect) {
> > > > > +        i =3D svq->desc_next[last];
> > > > > +    }
> > > > > +    return i;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * Add descriptors to SVQ vring using indirect descriptors
> > > > > +(dual-buffer)
> > > > > + *
> > > > > + * @svq: The shadow virtqueue
> > > > > + * @out_sg: The out iovec from the guest
> > > > > + * @out_num: The out iovec length
> > > > > + * @out_addr: The out descriptors' GPAs
> > > > > + * @in_sg: The in iovec from the guest
> > > > > + * @in_num: The in iovec length
> > > > > + * @in_addr: The in descriptors' GPAs
> > > > > + * @sgs: Cache for hwaddr
> > > > > + * @buf_idx: Index of the indirect buffer to use
> > > > > + *
> > > > > + * Return true if success, false otherwise and print error.
> > > > > + */
> > > > > +static bool vhost_svq_add_split_indirect(VhostShadowVirtqueue
> > *svq,
> > > > > +                                         const struct iovec *out=
_sg,
> > > > > +                                         size_t out_num,
> > > > > +                                         const hwaddr *out_addr,
> > > > > +                                         const struct iovec *in_=
sg,
> > > > > +                                         size_t in_num,
> > > > > +                                         const hwaddr *in_addr,
> > > > > +                                         hwaddr *sgs, int buf_id=
x) {
> > > > > +    SVQIndirectDescBuf *buf =3D &svq->indirect.bufs[buf_idx];
> > > > > +    uint16_t start_idx =3D buf->start_idx + buf->freed_head;
> > > > > +    size_t total_descs =3D out_num + in_num;
> > > > > +    hwaddr indirect_iova;
> > > > > +    int ret;
> > > > > +
> > > > > +    /* Populate indirect descriptor table for out descriptors */
> > > > > +    ret =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_nu=
m,
> > > > out_addr,
> > > > > +                                      svq->indirect.desc, start_=
idx,
> > > > > +                                      0, in_num > 0, false, true=
);
> > > > > +    if (unlikely(ret < 0)) {
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > > +    /* Populate indirect descriptor table for in descriptors */
> > > > > +    ret =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num,=
 in_addr,
> > > > > +                                      svq->indirect.desc, start_=
idx + out_num,
> > > > > +                                      out_num, false, true, true=
);
> > > > > +    if (unlikely(ret < 0)) {
> > > > > +        return false;
> > > > >      }
> > > > >
> > > > > -    svq->free_head =3D svq->desc_next[last];
> > > > > +    /* Calculate IOVA for this indirect descriptor range */
> > > > > +    indirect_iova =3D svq->indirect.iova + start_idx *
> > > > > + sizeof(vring_desc_t);
> > > > > +
> > > > > +    /* Add a single descriptor pointing to the indirect table */
> > > > > +    svq->vring.desc[svq->free_head].addr =3D cpu_to_le64(indirec=
t_iova);
> > > > > +    svq->vring.desc[svq->free_head].len =3D
> > > > > +            cpu_to_le32(total_descs * sizeof(vring_desc_t));
> > > > > +    svq->vring.desc[svq->free_head].flags =3D
> > > > > + cpu_to_le16(VRING_DESC_F_INDIRECT);
> > > > > +
> > > > > +    /* Store indirect descriptor info in desc_state */
> > > > > +    svq->desc_state[svq->free_head].indirect_buf_idx =3D buf_idx=
;
> > > > > +
> > > > > +    /* Update buffer state */
> > > > > +    buf->freed_head +=3D total_descs;
> > > > > +    buf->freed_descs -=3D total_descs;
> > > > > +
> > > > > +    /* Move free_head forward */
> > > > > +    svq->free_head =3D svq->desc_next[svq->free_head];
> > > > > +
> > > > >      return true;
> > > > >  }
> > > > >
> > > > > -static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
> > > > > +/**
> > > > > + * Try to borrow descriptors from the next buffer segment
> > > > > + *
> > > > > + * @svq: The shadow virtqueue
> > > > > + * @buf_idx: Current buffer index
> > > > > + * @needed: Number of additional descriptors needed
> > > > > + *
> > > > > + * Returns true if successfully borrowed, false otherwise.
> > > > > + * Note: Last buffer cannot borrow from first buffer (IOVA not
> > > > contiguous).
> > > > > + */
> > > > > +static bool vhost_svq_borrow_from_next(VhostShadowVirtqueue
> > *svq,
> > > > > +                                       int buf_idx, size_t neede=
d) {
> > > > > +    SVQIndirectDescBuf *cur_buf =3D &svq->indirect.bufs[buf_idx]=
;
> > > > > +    SVQIndirectDescBuf *next_buf;
> > > > > +    int next_idx;
> > > > > +
> > > > > +    /* Last buffer cannot borrow from first - IOVA would not be
> > > > > + contiguous
> > > > */
> > > > > +    if (buf_idx =3D=3D SVQ_NUM_INDIRECT_BUFS - 1) {
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > > +    next_idx =3D buf_idx + 1;
> > > > > +    next_buf =3D &svq->indirect.bufs[next_idx];
> > > > > +
> > > > > +    /* Can borrow if next buffer is in FREED state and has
> > > > > + freed_head at 0
> > > > */
> > > > > +    if (next_buf->state !=3D SVQ_INDIRECT_BUF_FREED ||
> > > > > +        next_buf->freed_head !=3D 0) {
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > > +    /* Check if next buffer has enough free descriptors to lend =
*/
> > > > > +    if (next_buf->freed_descs < needed) {
> > > > > +        return false;
> > > > > +    }
> > > > > +    /* Borrow descriptors: expand current buffer, shrink next bu=
ffer */
> > > > > +    cur_buf->num_descs +=3D needed;
> > > > > +    cur_buf->borrowed_descs +=3D needed;
> > > > > +    cur_buf->freed_descs +=3D needed;
> > > > > +
> > > > > +    next_buf->start_idx +=3D needed;
> > > > > +    next_buf->num_descs -=3D needed;
> > > > > +    next_buf->freed_descs -=3D needed;
> > > > > +
> > > >
> > > > I don't think I understand the algorithm for indirect tables
> > > > allocation and freeing. Let me know what I'm missing.
> > > >
> > > > We can have at max SVQ_NUM_INDIRECT_BUFS (4) indirect tables, as
> > the
> > > > information we use to locate the indirect table itself is
> > > > svq->desc_state[used_elem.id].indirect_buf_idx. This is used to
> > > > svq->access
> > > > the svq->indirect.bufs, whose size is SVQ_NUM_INDIRECT_BUFS.
> > > >
> > > > These tables could grow until the maximum descriptors allowed, whic=
h
> > > > is the size of the vring per VirtIO standard. The function
> > > > virtqueue_pop already checks this. But this code does not allow mor=
e
> > > > than 4 indirect tables anyway, even if they were smaller than vq
> > > > size and there is contiguous space in the mapped buffer for the ind=
irect
> > tables.
> > > >
> > >
> > >      Thank you for the detailed review! Let me clarify the design as =
I think
> > >      there may be some misunderstanding.
> > >
> > >      BUFFER ALLOCATION:
> > >      ------------------
> > >     # define CONFIG_MAX_SKB_FRAGS 17
> > >       In the Linux kernel, virtio-net limits the maximum scatterlist =
size to 17
> > entries. With a vq_size of 256 and indirect descriptors enabled,
> > >       the virtio-net driver can therefore submit up to 256 * 17 scatt=
er-gather
> > entries.
> > >
> > >       Based on this, the implementation allocates an indirect descrip=
tor
> > capacity about half of the theoretical maximum, specifically vq_size * =
2 * 4.
> > >
> > >      The total allocation is:
> > >
> > >        SVQ_NUM_INDIRECT_BUFS(4) * vq_size * 2 descriptors
> > >
> > >      Each buf[i] has capacity of 2*vq_size, not vq_size. So the full =
buffer
> > >      is divided into 4 segments, each capable of holding 2x the vring=
 size.
> > >      There is no wasted space.
> > >
> > >      +---------------------------------------------------------------=
------+
> > >      |         Total: 4 bufs * 2 * vq_size =3D 8 * vq_size descriptor=
s       |
> > >      +----------------+----------------+----------------+------------=
------+
> > >      |     buf[0]     |     buf[1]     |     buf[2]     |      buf[3]=
      |
> > >      |  2*vq_size cap |  2*vq_size cap |  2*vq_size cap |   2*vq_size=
 cap  |
> > >
> > > +----------------+----------------+----------------+-----------------=
-
> > > +
> > >
> > >      WHY 2*vq_size PER BUFFER:
> > >      -------------------------
> > >      The reason each buffer has 2*vq_size capacity (instead of 1*vq_s=
ize) is
> > >      to REDUCE the frequency of borrowing scenarios and improve
> > performance.
> > >
> > >      With 2*vq_size capacity per buffer:
> > >      - Most requests can be satisfied within a single buffer
> > >      - Borrowing from next buffer only happens in rare edge cases
> > >      - Better cache locality and fewer cross-buffer operations
> > >
> > >      If we used 1*vq_size per buffer, borrowing would occur much more
> > >      frequently, adding overhead to the common path.
> > >
> > >      WHY BORROWING IS STILL NEEDED:
> > >      ------------------------------
> > >      Even with 2*vq_size capacity, the borrowing mechanism addresses =
edge
> > >      cases that you mentioned in your previous review about to reuse =
the
> > free holes.
> > >
> > >
> > > https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg02779.html
> > >
> > >      Consider this situation:
> > >
> > >        buf[0] state after heavy usage:
> > >        +------------------------------------------------------------+
> > >        | freed_descs =3D 4  (only 4 free at the tail)                =
 |
> > >        | freeing_descs =3D 100  (waiting for device to return)       =
 |
> > >        | freed_head =3D 508                                          =
 |
> > >        |                                                            |
> > >        | [0.....507: IN_USE/FREEING] [508,509,510,511: FREE]        |
> > >        +------------------------------------------------------------+
> > >
> > >      Now driver sends a request needing 8 descriptors:
> > >
> > >      WITHOUT borrowing:
> > >        - buf[0] has only 4 freed_descs < 8 needed
> > >        - buf[0] transitions to FREEING state
> > >        - Those 4 free descriptors are WASTED
> > >        - Must use buf[1] from scratch
> > >
> > >      WITH borrowing:
> > >        - buf[0] has 4 freed_descs, needs 4 more
> > >        - Borrow 4 from buf[1]'s head (IOVA is contiguous!)
> > >        - Now have 8 contiguous descriptors: [508-511 from buf[0]] +
> > > [0-3 from buf[1]]
> > >
> > >        buf[0]:                              buf[1]:
> > >        +--------------------------------+   +----------------------+
> > >        | [508,509,510,511,|0,1,2,3]     |   | start_idx: 4         |
> > >        |  <-- original --> <--borrowed->|   | num_descs: 2*vq-4    |
> > >        |      8 contiguous descs        |   |                      |
> > >        +--------------------------------+   +----------------------+
> > >               Contiguous IOVA!
> > >
> >
> > I understand that algorithm, but I don't get what it buys. As you're on=
ly
> > allowing 4 indirect tables in flight at max, you are just moving the de=
scriptors
> > you tag as "wasted" from the tail of the queue to the inter-buf space. =
And
> > this edge case has comparatively way more complexity than the regular c=
ode
> > path.
> >
> > Let's try from a different angle, can you describe a buf[0,1,2,3] state=
 where
> > forwarding an indirect table is not possible without splitting it betwe=
en many
> > buffers?
> >
>
> Sorry for the late reply, and thanks for your reivew.
>
> To clarify the specific case you asked for (buf[0..3] style state),
> here is a concrete fragmented state where forwarding is blocked if we req=
uire strict sequential allocation from a single free_head and no split:
>
> Goal: keep allocation logic simple, i.e. consume descriptor buffers seque=
ntially from free_head.
> Each inter-buf can hold exactly two indirect buf.

I don't understand this sentence. Does this mean that a single
indirect table can span between two SVQIndirectDescBuf at most?

Reusing the name 'buf' for this makes it harder to discuss about it...
Can we rename it to pool? arena?

>
> Current occupancy:
> buf[0-1] =3D occupied by req A (in flight)
> buf[2]   =3D free
> buf[3]   =3D free
> buf[4]   =3D free
> buf[5-6] =3D occupied by req B (in flight)
> buf[7]   =3D free (free_head)
>
> Now request C arrives and needs 2 buffers.
> With strict sequential allocation from free_head=3Dbuf[7], we only have 1=
 sequential slot before wrap, so C cannot be forwarded immediately (even th=
ough total free buffers are enough).
>

How is it possible that a new indirect table requires two bufs if
buf[7] is free and it is able to hold at least two indirect tables? If
it is not entirely free, can you post the value of
svq->desc_state[*].indirect_buf_idx for all the in-flight descriptors,
SVQIndirectInfo.current_buf and all SVQIndirectInfo.bufs values before
and after request C arrives?

Maybe we can simplify this by handling tables that span two buffers as
an optimization on top; this would require more patches but be easier
to review.

> If we partition into two lists:
>
> list[0] =3D buf[0..3]
> list[1] =3D buf[4..7]
>
> then:
>
> list[0]: buf[0-1]=3DA, buf[2]=3Dfree (free_head), buf[3]=3Dfree
> list[1]: buf[4]=3Dfree, buf[5-6]=3DB, buf[7]=3Dfree (free_head)
>
> For request C (needs 2 buffers), list[0] can provide buf[2] + buf[3] cont=
iguously, so forwarding succeeds without waiting for A/B completion.
>
> So the benefit is not =E2=80=9Cmore total free descriptors=E2=80=9D, but =
better usability under fragmentation while keeping simple sequential alloca=
tion rules.
> Also, since virtio completion is not guaranteed to follow submission orde=
r, this fragmentation pattern is expected in practice.
>
> > >      BORROWING RULES:
> > >      ----------------
> > >      To keep the design simple and predictable:
> > >
> > >      1. Each buf[i] can only borrow ONCE from buf[i+1]
> > >      2. After borrowing, svq->indirect.current_buf is set to buf[i+1]
> > >      3. Subsequent requests will use buf[i+1] as the starting point
> > >
> > >      This ensures:
> > >      - No complex multi-level borrowing chains
> > >      - Predictable buffer rotation
> > >      - Simple bookkeeping (only track borrowed_descs per buffer)
> > >
> > >      Example flow:
> > >                  +---------------------------------------------------=
----------+
> > >        | current_buf =3D 0                                           =
  |
> > >        | buf[0] needs to borrow from buf[1]                          =
|
> > >        |   -> borrow succeeds                                        =
|
> > >        |   -> current_buf =3D 1  (next requests start from buf[1])   =
  |
> > >        |                                                             =
|
> > >        | Later, buf[1] needs to borrow from buf[2]                   =
|
> > >        |   -> borrow succeeds                                        =
|
> > >        |   -> current_buf =3D 2  (next requests start from buf[2])   =
  |
> > >        +-------------------------------------------------------------=
+
> > >
> > >      DESIGN SUMMARY:
> > >      ---------------
> > >        +-------------------------------------------------------------=
+
> > >        |  2*vq_size per buffer  ->  Reduces borrowing frequency      =
|
> > >        |                            (performance optimization)       =
|
> > >        +-------------------------------------------------------------=
+
> > >        |  Borrowing mechanism   ->  Handles edge cases when buffer   =
|
> > >        |                            is almost full but not empty     =
|
> > >        |                            (avoids descriptor waste)        =
|
> > >        +-------------------------------------------------------------=
+
> > >        |  One-time borrow rule  ->  Simple state management          =
|
> > >        |                            (current_buf moves to next)      =
|
> > >        +-------------------------------------------------------------=
+
> > >
> > >      WHY NOT FIXED CHUNKS:
> > >      ---------------------
> > >      Fixed vq_size chunks would waste descriptors in the scenario abo=
ve.
> > >      The 2*vq_size capacity + borrowing allows:
> > >
> > >      1. Single request can use up to 2*vq_size descs (exceeding vq_si=
ze)
> > >      2. Partially-used buffers can still contribute to new requests
> > >      3. Maximum utilization of the pre-allocated IOVA space
> > >
> > >      REGARDING BUDDY ALLOCATOR:
> > >      --------------------------
> > >      A buddy allocator would be more flexible, but adds complexity fo=
r
> > >      managing splits/merges. The current design with 4 large segments=
 +
> > >      borrowing provides a good balance:
> > >      - Simple allocation (round-robin through 4 bufs)
> > >      - Efficient utilization (borrowing avoids waste)
> > >      - Predictable performance (no fragmentation)
> > >
> > >      Does this clarify the design? Please let me know if you have
> > >      further questions.
> > >
> > >      Thanks,
> > >
> > > > The code allocates a buffer big enough for 8 indirect tables in
> > > > vhost_vdpa_svq_init_indirect, as they can only be svq->vring.num
> > > > big, so half of it will never be allocated under any circumstance.
> > > >
> > > > Now let's say the driver allocates 4 indirect tables (IT). The
> > > > shared buffer now looks like:
> > > >
> > > > [
> > > >   [1st IT],
> > > >   [2nd IT],
> > > >   [3rd IT],
> > > >   [4th IT],
> > > >   [free size for at least 4 indirect tables more] ]
> > > >
> > > > Now the device starts freeing indirect descriptors and the dance of
> > > > reallocating could start. The condition for borrowing and returning
> > > > descriptors may be met at 2*vq_size boundaries. But, by that time,
> > > > it is guaranteed that you can allocate an indirect table of vq_num
> > > > descriptors at some position N*vq_num, with N between 0 and 7.
> > > >
> > > > Why complicate the code with this dance of resizing
> > > > svq->indirect.bufs[j] then? Why not divide all the mapped buffer in
> > > > svq->8
> > > > chunks of vq size and never move them?
> > > >
> > > > I would prefer to remove the 4 (or any number) indirect tables
> > > > limitation and use something like the IOVA allocator or the buddy
> > > > allocator to find contiguous space though.
> > > >
> > > > Thanks!
> > > >
> > > > > +    return true;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * Try to get a freed indirect buffer for use
> > > > > + *
> > > > > + * @svq: The shadow virtqueue
> > > > > + * @total_descs: Number of descriptors needed
> > > > > + *
> > > > > + * Returns buffer index (0 to SVQ_NUM_INDIRECT_BUFS-1)
> > > > > + * if available, -1 if none available.
> > > > > + */
> > > > > +static int vhost_svq_get_indirect_buf(VhostShadowVirtqueue *svq,
> > > > > +                                      size_t total_descs) {
> > > > > +    int cur =3D svq->indirect.current_buf;
> > > > > +    SVQIndirectDescBuf *buf;
> > > > > +
> > > > > +    if (!svq->indirect.enabled) {
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > > > +    if ( cur < 0) {
> > > > > +        cur =3D 0;
> > > > > +    }
> > > > > +    /* Start from current or first buffer, try all buffers in or=
der */
> > > > > +    for (int i =3D 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
> > > > > +        int idx =3D (cur + i) % SVQ_NUM_INDIRECT_BUFS;
> > > > > +        buf =3D &svq->indirect.bufs[idx];
> > > > > +
> > > > > +        if (buf->state !=3D SVQ_INDIRECT_BUF_FREED) {
> > > > > +            continue;
> > > > > +        }
> > > > > +
> > > > > +        /* Check if we have enough free descriptors */
> > > > > +        if (buf->freed_descs >=3D total_descs) {
> > > > > +            svq->indirect.current_buf =3D idx;
> > > > > +            return idx;
> > > > > +        }
> > > > > +
> > > > > +        /* Try to borrow from next buffer */
> > > > > +        size_t needed =3D total_descs - buf->freed_descs;
> > > > > +        if ((buf->freed_descs > 0) &&
> > > > > +            vhost_svq_borrow_from_next(svq, idx, needed)) {
> > > > > +            svq->indirect.current_buf =3D idx + 1;
> > > > > +            return idx;
> > > > > +        }
> > > > > +
> > > > > +        /* Not enough space, mark as FREEING if it's the current=
 buffer */
> > > > > +        buf->state =3D SVQ_INDIRECT_BUF_FREEING;
> > > > > +    }
> > > > > +
> > > > > +    /* All buffers unavailable, fallback to chain mode */
> > > > > +    return -1;
> > > > > +}
> > > > > +
> > > > > +static int vhost_svq_add_split(VhostShadowVirtqueue *svq,
> > > > >                                  const struct iovec *out_sg, size=
_t out_num,
> > > > >                                  const hwaddr *out_addr,
> > > > >                                  const struct iovec *in_sg, size_=
t in_num,
> > > > > -                                const hwaddr *in_addr, unsigned =
*head)
> > > > > +                                const hwaddr *in_addr, unsigned =
*head,
> > > > > +                                bool *used_indirect)
> > > > >  {
> > > > >      unsigned avail_idx;
> > > > >      vring_avail_t *avail =3D svq->vring.avail;
> > > > >      bool ok;
> > > > > +    int ret;
> > > > >      g_autofree hwaddr *sgs =3D g_new(hwaddr, MAX(out_num, in_num=
));
> > > > > +    size_t total_descs =3D out_num + in_num;
> > > > > +    int indirect_buf_idx =3D -1;
> > > > >
> > > > >      *head =3D svq->free_head;
> > > > > +    *used_indirect =3D false;
> > > > >
> > > > >      /* We need some descriptors here */
> > > > >      if (unlikely(!out_num && !in_num)) {
> > > > >          qemu_log_mask(LOG_GUEST_ERROR,
> > > > >                        "Guest provided element with no descriptor=
s");
> > > > > -        return false;
> > > > > +        return -EINVAL;
> > > > >      }
> > > > >
> > > > > -    ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num=
,
> > out_addr,
> > > > > -                                     in_num > 0, false);
> > > > > -    if (unlikely(!ok)) {
> > > > > -        return false;
> > > > > +    /* Try to use indirect descriptors if feature is negotiated =
and total > 1
> > */
> > > > > +    if (virtio_vdev_has_feature(svq->vdev,
> > > > VIRTIO_RING_F_INDIRECT_DESC) &&
> > > > > +        total_descs > 1) {
> > > > > +        indirect_buf_idx =3D vhost_svq_get_indirect_buf(svq,
> > > > > + total_descs);
> > > > >      }
> > > > >
> > > > > -    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, =
in_addr,
> > > > false,
> > > > > -                                     true);
> > > > > -    if (unlikely(!ok)) {
> > > > > -        return false;
> > > > > +    if (indirect_buf_idx >=3D 0) {
> > > > > +        /* Indirect mode: only need 1 main descriptor slot */
> > > > > +        if (unlikely(vhost_svq_available_slots(svq) < 1)) {
> > > > > +            return -ENOSPC;
> > > > > +        }
> > > > > +
> > > > > +        /* Use indirect mode */
> > > > > +        ok =3D vhost_svq_add_split_indirect(svq, out_sg, out_num=
,
> > out_addr,
> > > > > +                                          in_sg, in_num, in_addr=
,
> > > > > +                                          sgs, indirect_buf_idx)=
;
> > > > > +        if (unlikely(!ok)) {
> > > > > +            error_report("indirect error, out_num %zu in_num %zu=
 "
> > > > > +                         "avail index %u head %u",
> > > > > +                         out_num, in_num, svq->shadow_avail_idx,=
 *head);
> > > > > +            return -EINVAL;
> > > > > +        }
> > > > > +        *used_indirect =3D true;
> > > > > +    } else {
> > > > > +        /* Chain mode: need total_descs descriptor slots */
> > > > > +        if (unlikely(vhost_svq_available_slots(svq) < total_desc=
s)) {
> > > > > +            return -ENOSPC;
> > > > > +        }
> > > > > +
> > > > > +        /* Use direct (chain) mode */
> > > > > +        svq->desc_state[svq->free_head].indirect_buf_idx =3D -1;
> > > > > +
> > > > > +        ret =3D vhost_svq_vring_write_descs(svq, sgs, out_sg,
> > > > > + out_num,
> > > > out_addr,
> > > > > +                                          svq->vring.desc, svq->=
free_head, 0,
> > > > > +                                          in_num > 0, false, fal=
se);
> > > > > +        if (unlikely(ret < 0)) {
> > > > > +            return -EINVAL;
> > > > > +        }
> > > > > +        svq->free_head =3D ret;
> > > > > +
> > > > > +        ret =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_=
num,
> > in_addr,
> > > > > +                                          svq->vring.desc, svq->=
free_head, 0,
> > > > > +                                          false, true, false);
> > > > > +        if (unlikely(ret < 0)) {
> > > > > +            return -EINVAL;
> > > > > +        }
> > > > > +        svq->free_head =3D ret;
> > > > >      }
> > > > >
> > > > >      /*
> > > > > @@ -233,7 +487,7 @@ static bool
> > > > vhost_svq_add_split(VhostShadowVirtqueue *svq,
> > > > >      smp_wmb();
> > > > >      avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
> > > > >
> > > > > -    return true;
> > > > > +    return 0;
> > > > >  }
> > > > >
> > > > >  static void vhost_svq_kick(VhostShadowVirtqueue *svq) @@ -249,7
> > > > > +503,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> > > > >      if (virtio_vdev_has_feature(svq->vdev,
> > VIRTIO_RING_F_EVENT_IDX)) {
> > > > >          uint16_t avail_event =3D le16_to_cpu(
> > > > >                  *(uint16_t *)(&svq->vring.used->ring[svq->vring.=
num]));
> > > > > -        needs_kick =3D vring_need_event(avail_event, svq-
> > >shadow_avail_idx,
> > > > svq->shadow_avail_idx - 1);
> > > > > +        needs_kick =3D vring_need_event(avail_event, svq-
> > >shadow_avail_idx,
> > > > > +                                      svq->shadow_avail_idx - 1)=
;
> > > > >      } else {
> > > > >          needs_kick =3D
> > > > >                  !(svq->vring.used->flags &
> > > > > cpu_to_le16(VRING_USED_F_NO_NOTIFY));
> > > > > @@ -274,19 +529,21 @@ int vhost_svq_add(VhostShadowVirtqueue
> > *svq,
> > > > > const struct iovec *out_sg,  {
> > > > >      unsigned qemu_head;
> > > > >      unsigned ndescs =3D in_num + out_num;
> > > > > -    bool ok;
> > > > > +    int r;
> > > > > +    bool used_indirect =3D false;
> > > > >
> > > > > -    if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
> > > > > -        return -ENOSPC;
> > > > > +    r =3D vhost_svq_add_split(svq, out_sg, out_num, out_addr,
> > > > > + in_sg,
> > > > in_num,
> > > > > +                             in_addr, &qemu_head, &used_indirect=
);
> > > > > +    if (unlikely(r !=3D 0)) {
> > > > > +        return r;
> > > > >      }
> > > > >
> > > > > -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, out_addr, i=
n_sg,
> > > > in_num,
> > > > > -                             in_addr, &qemu_head);
> > > > > -    if (unlikely(!ok)) {
> > > > > -        return -EINVAL;
> > > > > +    /* If using indirect, only 1 main descriptor is used; otherw=
ise ndescs
> > */
> > > > > +    if (used_indirect) {
> > > > > +        svq->num_free -=3D 1;
> > > > > +    } else {
> > > > > +        svq->num_free -=3D ndescs;
> > > > >      }
> > > > > -
> > > > > -    svq->num_free -=3D ndescs;
> > > > >      svq->desc_state[qemu_head].elem =3D elem;
> > > > >      svq->desc_state[qemu_head].ndescs =3D ndescs;
> > > > >      vhost_svq_kick(svq);
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
> > >
>


