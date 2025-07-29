Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3932C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 02:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugaFQ-0004V4-0b; Mon, 28 Jul 2025 22:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ugaF2-0004P1-A9
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 22:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ugaEm-0000VW-AF
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 22:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753756721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5cF9a7TcVzfka2OM17bTmlqLbvlFroFrbUDlk4M/Gk=;
 b=I2JYGiKkZv0ssA/UtlaJ8k2bVEgcFCm+13iNGlL6mih5cT8Kb5DhghTWJzRI/7t82stbyA
 7XilXo8guJCWCBqCPa9wMQhARTY2bZQMbAR+0VDwVWM0yFZwkdQ/l7Ep1t+2kbFEg0Wixh
 GutLLl1uReSaKEzp7atlBfSz7ibWV/Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-gUqBrsFkMA-6vFXHXypzlw-1; Mon, 28 Jul 2025 22:38:38 -0400
X-MC-Unique: gUqBrsFkMA-6vFXHXypzlw-1
X-Mimecast-MFC-AGG-ID: gUqBrsFkMA-6vFXHXypzlw_1753756717
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-748e1e474f8so8472227b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 19:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753756717; x=1754361517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5cF9a7TcVzfka2OM17bTmlqLbvlFroFrbUDlk4M/Gk=;
 b=YMaak8zCxtSxhDom57bFSefM7gmoqjqN3dB5qryRXUiG9+dMZ0+OuFbVLbEXrs+ar/
 5HpA/H5nwBzAbs51Tmak8wtB8P6N1vzYqOVCEmtQqwfTfZvtRExWhuOjKKw5Mx8VLjQ9
 Q6VYB/L9G+zc1XVsNX1rUpGl8ytIa2epPaSM1Ru6NQjzrfK32BRf4luPCOR3ySwKH8Pn
 /up2p8OSBk5VfGZTIoW+QHJmRKAusjkfoqhafNHNsX8NXlD/hjlo90XQJcpN+781A0C/
 FtmhyI5P/TtCYBRNVx4xqQwsmBSNu6EXDiyFzu4uCfua2/9RQJwMXhP3e2JQZVfBQumx
 I7nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXWTtQBYmhIMbWU+rTXVhiFC4x6buaFHKpCva+5B7QZKuvf8uKmDeh0hs309OsxrEXLxb1gTjECJVO@nongnu.org
X-Gm-Message-State: AOJu0YygrbczT+atXEB0IKPgB3bvIVIkIxiMZV1vW9KOp7VpbfjXRsRo
 Q1Up0lU2nhUjhPkMYyh4ef7d+Kb1ZMvK3J8ls6FHX1MobsoXjoe8PLRcybB0gCfsXkIJjn7mZ7L
 scIdZydsLzIUA19Mol4mmUHOeNUbHIO18tn/ls65T3O3sPTg8OC77SoD+PZ0osKBiPhZ/sPZiUS
 XtDbKmY3gBikDDOEod2WNfGXvCJXXju8A=
X-Gm-Gg: ASbGncsVS5RcSka8fazH6jhgTbZiLv1RlCgqKxzoVZ5WM/GeW4105SEC13pxyYI4oaR
 6CsvwJ2Nrns+EjhCzn9y2SQPzxrNs1jnXTUkuReCpJPnG/8IMW4KcxmNzBeLGzYmGDGeVP8h1xe
 9XU3AzbusFQh3d+8OTIos=
X-Received: by 2002:a05:6a20:3ca1:b0:23d:4777:49bd with SMTP id
 adf61e73a8af0-23d7017299amr23121912637.21.1753756717529; 
 Mon, 28 Jul 2025 19:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+wvvWF6Y9V2lRxu5GsyxWXjd4VtxrooXJM7f8RH8lFrWe4eRTLIxKYhUVaRWVGyGjlcgiWoCWlRP3JNqs7gs=
X-Received: by 2002:a05:6a20:3ca1:b0:23d:4777:49bd with SMTP id
 adf61e73a8af0-23d7017299amr23121878637.21.1753756717110; Mon, 28 Jul 2025
 19:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
 <20250725053122-mutt-send-email-mst@kernel.org>
 <CACGkMEvTgCAbBG20iLB1m_WfYzMZA7FYZ2FuL6To4EV86PXZbA@mail.gmail.com>
 <CACGkMEtCiqq0P_7aB-d5CrQraHL2xky5Qa+9LyZce4hk+wvvYQ@mail.gmail.com>
 <CAJaqyWeJVjG+FbXvYZOu7fXXg-U5vSmt8_+YDw_t7hKv5DH8ew@mail.gmail.com>
In-Reply-To: <CAJaqyWeJVjG+FbXvYZOu7fXXg-U5vSmt8_+YDw_t7hKv5DH8ew@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:38:25 +0800
X-Gm-Features: Ac12FXwsBeQTQM7fc5Yn6pmpOG8GEun0L-kBcugkwRz1GVzWctZcEGOmAtPuLus
Message-ID: <CACGkMEvq0zX+HQJSpjOVB_0_5R=N8_xe2Eb5g4SA1HqeiNHGmw@mail.gmail.com>
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Mon, Jul 28, 2025 at 10:51=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jul 28, 2025 at 9:36=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Jul 28, 2025 at 3:09=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Jul 25, 2025 at 5:33=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Jul 24, 2025 at 05:59:20PM -0400, Jonah Palmer wrote:
> > > > >
> > > > >
> > > > > On 7/23/25 1:51 AM, Jason Wang wrote:
> > > > > > On Tue, Jul 22, 2025 at 8:41=E2=80=AFPM Jonah Palmer <jonah.pal=
mer@oracle.com> wrote:
> > > > > > >
> > > > > > > This series is an RFC initial implementation of iterative liv=
e
> > > > > > > migration for virtio-net devices.
> > > > > > >
> > > > > > > The main motivation behind implementing iterative migration f=
or
> > > > > > > virtio-net devices is to start on heavy, time-consuming opera=
tions
> > > > > > > for the destination while the source is still active (i.e. be=
fore
> > > > > > > the stop-and-copy phase).
> > > > > >
> > > > > > It would be better to explain which kind of operations were hea=
vy and
> > > > > > time-consuming and how iterative migration help.
> > > > > >
> > > > >
> > > > > You're right. Apologies for being vague here.
> > > > >
> > > > > I did do some profiling of the virtio_load call for virtio-net to=
 try and
> > > > > narrow down where exactly most of the downtime is coming from dur=
ing the
> > > > > stop-and-copy phase.
> > > > >
> > > > > Pretty much the entirety of the downtime comes from the vmstate_l=
oad_state
> > > > > call for the vmstate_virtio's subsections:
> > > > >
> > > > > /* Subsections */
> > > > > ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> > > > > if (ret) {
> > > > >     return ret;
> > > > > }
> > > > >
> > > > > More specifically, the vmstate_virtio_virtqueues and
> > > > > vmstate_virtio_extra_state subsections.
> > > > >
> > > > > For example, currently (with no iterative migration), for a virti=
o-net
> > > > > device, the virtio_load call took 13.29ms to finish. 13.20ms of t=
hat time
> > > > > was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).
> > > > >
> > > > > Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtq=
ueues and
> > > > > ~6.33ms was spent migrating the vmstate_virtio_extra_state subsec=
tions. And
> > > > > I believe this is from walking VIRTIO_QUEUE_MAX virtqueues, twice=
.
> > > >
> > > > Can we optimize it simply by sending a bitmap of used vqs?
> > >
> > > +1.
> > >
> > > For example devices like virtio-net may know exactly the number of
> > > virtqueues that will be used.
> >
> > Ok, I think it comes from the following subsections:
> >
> > static const VMStateDescription vmstate_virtio_virtqueues =3D {
> >     .name =3D "virtio/virtqueues",
> >     .version_id =3D 1,
> >     .minimum_version_id =3D 1,
> >     .needed =3D &virtio_virtqueue_needed,
> >     .fields =3D (const VMStateField[]) {
> >         VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
> >                       VIRTIO_QUEUE_MAX, 0, vmstate_virtqueue, VirtQueue=
),
> >         VMSTATE_END_OF_LIST()
> >     }
> > };
> >
> > static const VMStateDescription vmstate_virtio_packed_virtqueues =3D {
> >     .name =3D "virtio/packed_virtqueues",
> >     .version_id =3D 1,
> >     .minimum_version_id =3D 1,
> >     .needed =3D &virtio_packed_virtqueue_needed,
> >     .fields =3D (const VMStateField[]) {
> >         VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
> >                       VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, Vi=
rtQueue),
> >         VMSTATE_END_OF_LIST()
> >     }
> > };
> >
> > A rough idea is to disable those subsections and use new subsections
> > instead (and do the compatibility work) like virtio_save():
> >
> >     for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> >         if (vdev->vq[i].vring.num =3D=3D 0)
> >             break;
> >     }
> >
> >     qemu_put_be32(f, i);
> >     ....
> >
>
> While I think this is a very good area to explore, I think we will get
> more benefits by pre-warming vhost-vdpa devices, as they take one or
> two orders of magnitude more than sending and processing the
> virtio-net state (1s~10s vs 10~100ms).

Yes, but note that Jonah does the testing on a software virtio device.

Thanks

>


