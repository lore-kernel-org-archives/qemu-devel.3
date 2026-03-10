Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99983FCC9AE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 03:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vznOZ-0005Fk-8Q; Mon, 09 Mar 2026 23:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vznOX-0005Ey-18
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vznOU-0007FI-Sl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773111865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rRImk9nm7CX2l/GZXfLaDKtYIMgHnurTZF2nXZqHXk=;
 b=e6hHQhUyojmjSNjzQcGsjTZ6Ns4AkezYVAYlPblaOGmchwPZSpMS57QQdhEH3KQFuoW9U/
 yVnpEBFUOID+Yi+OyajCUq8t4sM/ZYd1rNAkUicq2qRYvHaQrpAXLhQiLTI0JvZkw2JKD4
 8ipmoRC3JJ9uU5FtprOxc1WOB+zT96A=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-v8o2cx_gPPWSE60WUtZkkg-1; Mon, 09 Mar 2026 23:04:23 -0400
X-MC-Unique: v8o2cx_gPPWSE60WUtZkkg-1
X-Mimecast-MFC-AGG-ID: v8o2cx_gPPWSE60WUtZkkg_1773111863
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c738bebd53fso17534292a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 20:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773111862; cv=none;
 d=google.com; s=arc-20240605;
 b=PJAXPd2UQrgw2rztXxxcluZEinBOUUCDCOLulaPIDS2fVRastCmEa9tuygJl+yi9ib
 DloAtuEErmiBCjZT0NcwJaZzCtXzl9DIcrBVUI8T551PF6RNYbh6n6zbLTl1ZdJwI+We
 sqALqHSVplo2fb0SDIWQ12ibt72y2ZdpU/KIMXLQCbJnfDJjs8fRhBgOazuO7//J6nIT
 HghYnoZtmUv1AVOOCasrZgyQE46uhC5ww8Ok5VeFwENPoanpfurxD6YFn1vtORt7L66j
 JIc2In3Hz+rHsewwOZLSB3ktfGKCZ3Aozf5kwFnvXUxbaQn+cWQUXI+GrPHZpgoP06k7
 /xeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2rRImk9nm7CX2l/GZXfLaDKtYIMgHnurTZF2nXZqHXk=;
 fh=CCzwMatiZjClffqXfYCT0E4TCmw+jdyoA/vgnnKOdRs=;
 b=TyY2eBgqJzEXGz+lsjGYCrMRwkQ16JE5E3SguT9oe2WhrSY/iHsgOsBurOl3KdDGGs
 XxDGp0/7WkoriqhgRQwqZtDpZtb+AQQVzbqZEDT55AeYaExwruo4t3ygtpdmHl13IBGw
 3s46gZtx0HeyGWIDFACuMGarw+lfk77D0Bn5OB3wjn85kTu1YcXqL6ekwmZ3Ju9P5yhX
 ubHnFJJkffQZKKZGwhApkYrGzQBye1/lLXHIr3jGN136GfeRwBxkTUVBhkUPM8CgRj6d
 8WSjULnNSDih4lO47AppvQ+PsZrsrl23gWlK52SDAJhG9FQ1gwtBtZp7IDovFfNTJ9Bs
 apVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773111862; x=1773716662; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rRImk9nm7CX2l/GZXfLaDKtYIMgHnurTZF2nXZqHXk=;
 b=e4ogCJgUkwZS885OXVnHTgpwkpzGsCVDUuvi5P+uk0YNvjm+ERWN1SHdfOUNhOn/0Q
 y81BwCIrkDLucYOaCfqaJNQiPzX/DAeHzFJ62N8+8UOWmzVaApiXQQZ4ESL+I0cUWtoy
 ofAJNwJVUNZ9DE+Jhs8W/t7VXOr4tkgAa7WboFl658+Axia3/pRB+n+BVOm9baSTuMzH
 +mNyUU45rXXRaamuHguQ/vouenhe1UWag2vOSxDr06TQ2XKsQCgUwrn4qCenknfWvp85
 MgCHFh6lxk+obabEAi0JIYFGKNYNEQ5gpquJ4YMGlL/eXjYApIn20887h/Fsd67uvoaP
 xkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773111862; x=1773716662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2rRImk9nm7CX2l/GZXfLaDKtYIMgHnurTZF2nXZqHXk=;
 b=mY3xDzFNyG++Do41FT6LOTLtoiCS3X0rl1byGucNKC9f02d9aP6bqSKCMP8WQ2bVst
 jKEoKfoElc98bhoFQbUwKRwuDf41TDcAC0+IHI9wz1abUtiyxrxwbjmWwJzwXi9F/O7b
 RtePeHvNybBzE+JhZB1dIUydHJSXN2Gi0+BaeNEjP750TC3DPY1GXhMjU87RMM/kSqee
 fIOmTH6Szo4jOvKsEOeCg2GzzrOiQNVH8a67h0SPlGketFQ0zswlu0yKpEYl3bstb/iQ
 aVjjX8Ak17CZ3y6kyiTyoToCUj/mynM2bcPWpPGJam4oqMUXgf3z9RLWxe2ewzRXe34l
 2puQ==
X-Gm-Message-State: AOJu0YweZ4mAlx0wjxpKtzwgEBT2phCmLgpmiM9vFv5tmnVQ+/9yrqn0
 +wpcrv8dQQmhdyQPp9LZ4gmcgs1yiYC+UZUlWMGSmkc5EtWr6nDbGYpr9LZhR7mZ/UplkWao5re
 /odWevzWu9WJYa6VUwNtXNkXT9HEYKRh0XOa51X62MqaR4/w7sA4rMD1wrjwf33hsgPglA28eRL
 9PHAv0+S685zDWTPHwXp62cVvJUIFophM=
X-Gm-Gg: ATEYQzz8Wny/c0En8EiUx1UYAaoI8uhIjekldMCO0VeMA4v1ws0JQch5bZacxwn6hCB
 5JeuTXW29wFuKD+OhODHTyRSbCVEBEq72jGvwNwd1GcnzLCoeZ7CX5AmhU45Y5JhLAIbofajLNu
 tdYVFd1LDE8Ba3cLgUQxkARyy6IHpUCXrywWaFS90Zvnn0Rn0SFEZNp6eeMPVxAby3735dXPZR3
 Jn88+Zl
X-Received: by 2002:a05:6a21:9ccb:b0:394:7ee5:2fe1 with SMTP id
 adf61e73a8af0-398590b4454mr12649006637.51.1773111862545; 
 Mon, 09 Mar 2026 20:04:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:9ccb:b0:394:7ee5:2fe1 with SMTP id
 adf61e73a8af0-398590b4454mr12648978637.51.1773111862127; Mon, 09 Mar 2026
 20:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-6-eperezma@redhat.com>
 <CACGkMEsCDDSV1m9-2cz3SGEh=MB0viA6h5a9vF5BCHPEhadfUQ@mail.gmail.com>
 <CAJaqyWdPbU3HXxsc-e4+K_CBPtnYZzbW8vrQJYK-nSUu35LtWg@mail.gmail.com>
In-Reply-To: <CAJaqyWdPbU3HXxsc-e4+K_CBPtnYZzbW8vrQJYK-nSUu35LtWg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:04:11 +0800
X-Gm-Features: AaiRm50gfk1ZB2xagT6rpSayOwyY02JeseClR2OlmyD7ceqlVQYLWBxWSNV-tBU
Message-ID: <CACGkMEscrowNUuZyeCiae-Oww5gkoyfQ+-mK0B2FSvKJFAUX=Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] vhost: factor out the detach buf logic in SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 9, 2026 at 5:43=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Mar 9, 2026 at 9:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Mar 5, 2026 at 1:36=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > This code path is modified to handle in order devices.  Abstract here=
 so
> > > we can generalize on the caller.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  hw/virtio/vhost-shadow-virtqueue.c | 24 ++++++++++++++++--------
> > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-sha=
dow-virtqueue.c
> > > index e7e3c9155cd0..2d8fc82cc06f 100644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -473,11 +473,24 @@ static uint16_t vhost_svq_last_desc_of_chain(co=
nst VhostShadowVirtqueue *svq,
> > >      return i;
> > >  }
> > >
> > > +G_GNUC_WARN_UNUSED_RESULT
> > > +static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *=
svq,
> > > +                                              uint16_t id)
> > > +{
> > > +    uint16_t num =3D svq->desc_state[id].ndescs;
> > > +    uint16_t last_used_chain =3D vhost_svq_last_desc_of_chain(svq, n=
um, id);
> > > +
> > > +    svq->desc_state[last_used_chain].next =3D svq->free_head;
> > > +    svq->free_head =3D id;
> > > +
> > > +    return g_steal_pointer(&svq->desc_state[id].elem);
> > > +}
> > > +
> > >  G_GNUC_WARN_UNUSED_RESULT
> > >  static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq=
,
> > >                                             uint32_t *len)
> > >  {
> > > -    uint16_t last_used, last_used_chain, num;
> > > +    uint16_t last_used;
> > >
> > >      if (!vhost_svq_more_used(svq)) {
> > >          return NULL;
> > > @@ -500,14 +513,9 @@ static VirtQueueElement *vhost_svq_get_buf(Vhost=
ShadowVirtqueue *svq,
> > >          return NULL;
> > >      }
> > >
> > > -    num =3D svq->desc_state[last_used].ndescs;
> > > +    svq->num_free +=3D svq->desc_state[last_used].ndescs;
> > >      svq->desc_state[last_used].ndescs =3D 0;
> >
> > Any reason we don't factor those two lines?
> >
>
> They are common for split and split_in_order case.

Exactly, so why not factoring out them as well? Or you mean
vhost_svq_detach_buf is only for in-order (then we probably need to
rename).

Thanks

>
> > > -    last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, last_=
used);
> > > -    svq->desc_state[last_used_chain].next =3D svq->free_head;
> > > -    svq->free_head =3D last_used;
> > > -    svq->num_free +=3D num;
> > > -
> > > -    return g_steal_pointer(&svq->desc_state[last_used].elem);
> > > +    return vhost_svq_detach_buf(svq, last_used);
> > >  }
> > >
> > >  /**
> > > --
> > > 2.53.0
> > >
> >
> > Thanks
> >
>


