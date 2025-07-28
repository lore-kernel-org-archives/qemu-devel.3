Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2E3C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 14:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPD8-00011r-VJ; Mon, 28 Jul 2025 10:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ugPCh-0000in-42
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ugPCe-00051n-1l
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753714302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2J16ghhjHIlLZBEagsVSrX72MBwvBw1+ZiqruG2bzRw=;
 b=eIW/uy8uzOMFZkcM+Gawzlpepy46sgK0mAPDpxYADVYyi0qYKl2Dbg/OVMtdj07EY0CZix
 LQITLBv+XB4k/10bQX/bJjhuoCp9hkqaKUAL0dQ8DfCp8c5OtvfS+ID1YoY0oE5c2yNVRs
 6a/ezg4N12DIbKA+ZYTI7h63xqftY4w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-JhO9wVXpMWSRp42Zd-IneA-1; Mon, 28 Jul 2025 10:51:41 -0400
X-MC-Unique: JhO9wVXpMWSRp42Zd-IneA-1
X-Mimecast-MFC-AGG-ID: JhO9wVXpMWSRp42Zd-IneA_1753714300
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31366819969so3903720a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 07:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753714300; x=1754319100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2J16ghhjHIlLZBEagsVSrX72MBwvBw1+ZiqruG2bzRw=;
 b=rNFxtgcsiDrw+dHUgpghZlOizgHL2ebw7NByekj4A+SNdJIWRYmXBzZCbGZYG/Gsrs
 YUtQHBuv69X69DG4OO+diEJhKGVF8adZoF3R8Jj4doL39y2npe350kiixX8L/BQrDBkx
 wo9wbnDF0zPaPG5Xy2NiKd7CssVJwz+VrwZFBV08fhvLPu94dCcs5e9IbVWHvN0Xp2AE
 Htva7rwms6M/rjE2g7jDI1x8XZBZlLBnRWk2/FYo1v44LAnx3xP+kd8siQg6imDaVZrH
 dp/GajGKNJLTgCGFkuLqml+HWtVqWz0MIAMpO8JlfH261MsgknsXT1oQ/P9MxWfereGE
 NJZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy/mv2zhk2NSwuOBh56qfKKsKSkByQ9vgSjOOZxdZsmJxSpJLWc4Mv3OsilH2xhrwGflEPeEC98dv5@nongnu.org
X-Gm-Message-State: AOJu0YyOc66knFyJPhUSdTEpWsf05rB61HcmkY89H6ZcxHH2VSorl15e
 rgDLBSceZ+Vcz7lO4amzFnY1ewxCGPbiNjtsqXVAQiTJ6XX/hchAwemE6mYshhqBAVCn8Vp7S0h
 YzLBSZ3V8eTk2Q3E+RVPPA/L4CniPckWhavXbmN5I5MPp9oXbT9K9eFi0yCjncr3Da/xz/Syo89
 Ra691rXSLBlJsjM6iFJtjAVv7FFVlpZLeCzIj9flCYHg==
X-Gm-Gg: ASbGncuS9A4ieybevXbmuIw5q9hhkMxiC9w0uHM9zYuCujcFMWXg4jMFx+juqZKP8lX
 gSiKj8XZu1N6dvXCl8p6xpEUDrsD3jvmlksyvtOek50SD9W2fb7W1bSzd6FfvFG7AYkrJXOJ91X
 ZJbdswTWnOBAa3CLXWWRw6
X-Received: by 2002:a17:90b:3806:b0:311:9c1f:8522 with SMTP id
 98e67ed59e1d1-31e77a41027mr17181647a91.10.1753714300131; 
 Mon, 28 Jul 2025 07:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVAQfXwLx4ERoDOLhJ873ViqM1jn9JKcYJLJUC/LxRADSmitnHwOFDPXOIOq+G4B+pkPDPJnnkSSMQEHFK0e4=
X-Received: by 2002:a17:90b:3806:b0:311:9c1f:8522 with SMTP id
 98e67ed59e1d1-31e77a41027mr17181507a91.10.1753714298780; Mon, 28 Jul 2025
 07:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
 <20250725053122-mutt-send-email-mst@kernel.org>
 <CACGkMEvTgCAbBG20iLB1m_WfYzMZA7FYZ2FuL6To4EV86PXZbA@mail.gmail.com>
 <CACGkMEtCiqq0P_7aB-d5CrQraHL2xky5Qa+9LyZce4hk+wvvYQ@mail.gmail.com>
In-Reply-To: <CACGkMEtCiqq0P_7aB-d5CrQraHL2xky5Qa+9LyZce4hk+wvvYQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Jul 2025 16:51:01 +0200
X-Gm-Features: Ac12FXyywSiy8Cg9xSmaVPHf-Dphbi6n6gbdPMMSvLcLoPkxEUyXxBNSsgAcsUY
Message-ID: <CAJaqyWeJVjG+FbXvYZOu7fXXg-U5vSmt8_+YDw_t7hKv5DH8ew@mail.gmail.com>
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 28, 2025 at 9:36=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Jul 28, 2025 at 3:09=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Jul 25, 2025 at 5:33=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Jul 24, 2025 at 05:59:20PM -0400, Jonah Palmer wrote:
> > > >
> > > >
> > > > On 7/23/25 1:51 AM, Jason Wang wrote:
> > > > > On Tue, Jul 22, 2025 at 8:41=E2=80=AFPM Jonah Palmer <jonah.palme=
r@oracle.com> wrote:
> > > > > >
> > > > > > This series is an RFC initial implementation of iterative live
> > > > > > migration for virtio-net devices.
> > > > > >
> > > > > > The main motivation behind implementing iterative migration for
> > > > > > virtio-net devices is to start on heavy, time-consuming operati=
ons
> > > > > > for the destination while the source is still active (i.e. befo=
re
> > > > > > the stop-and-copy phase).
> > > > >
> > > > > It would be better to explain which kind of operations were heavy=
 and
> > > > > time-consuming and how iterative migration help.
> > > > >
> > > >
> > > > You're right. Apologies for being vague here.
> > > >
> > > > I did do some profiling of the virtio_load call for virtio-net to t=
ry and
> > > > narrow down where exactly most of the downtime is coming from durin=
g the
> > > > stop-and-copy phase.
> > > >
> > > > Pretty much the entirety of the downtime comes from the vmstate_loa=
d_state
> > > > call for the vmstate_virtio's subsections:
> > > >
> > > > /* Subsections */
> > > > ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> > > > if (ret) {
> > > >     return ret;
> > > > }
> > > >
> > > > More specifically, the vmstate_virtio_virtqueues and
> > > > vmstate_virtio_extra_state subsections.
> > > >
> > > > For example, currently (with no iterative migration), for a virtio-=
net
> > > > device, the virtio_load call took 13.29ms to finish. 13.20ms of tha=
t time
> > > > was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).
> > > >
> > > > Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtque=
ues and
> > > > ~6.33ms was spent migrating the vmstate_virtio_extra_state subsecti=
ons. And
> > > > I believe this is from walking VIRTIO_QUEUE_MAX virtqueues, twice.
> > >
> > > Can we optimize it simply by sending a bitmap of used vqs?
> >
> > +1.
> >
> > For example devices like virtio-net may know exactly the number of
> > virtqueues that will be used.
>
> Ok, I think it comes from the following subsections:
>
> static const VMStateDescription vmstate_virtio_virtqueues =3D {
>     .name =3D "virtio/virtqueues",
>     .version_id =3D 1,
>     .minimum_version_id =3D 1,
>     .needed =3D &virtio_virtqueue_needed,
>     .fields =3D (const VMStateField[]) {
>         VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
>                       VIRTIO_QUEUE_MAX, 0, vmstate_virtqueue, VirtQueue),
>         VMSTATE_END_OF_LIST()
>     }
> };
>
> static const VMStateDescription vmstate_virtio_packed_virtqueues =3D {
>     .name =3D "virtio/packed_virtqueues",
>     .version_id =3D 1,
>     .minimum_version_id =3D 1,
>     .needed =3D &virtio_packed_virtqueue_needed,
>     .fields =3D (const VMStateField[]) {
>         VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
>                       VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, Virt=
Queue),
>         VMSTATE_END_OF_LIST()
>     }
> };
>
> A rough idea is to disable those subsections and use new subsections
> instead (and do the compatibility work) like virtio_save():
>
>     for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
>         if (vdev->vq[i].vring.num =3D=3D 0)
>             break;
>     }
>
>     qemu_put_be32(f, i);
>     ....
>

While I think this is a very good area to explore, I think we will get
more benefits by pre-warming vhost-vdpa devices, as they take one or
two orders of magnitude more than sending and processing the
virtio-net state (1s~10s vs 10~100ms).


