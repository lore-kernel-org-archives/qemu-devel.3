Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29D2C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPxW-0004sO-14; Mon, 28 Jul 2025 11:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ugPwq-0003RG-LK
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ugPwo-00026o-LW
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753717168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=633gIv/hUWbflz7ELIrGUdAVKw56h9FnUiTLXuugcSo=;
 b=BEia1vpInkiXQTgp1vZ95F1J0f58tFbgAWFca800teedmT7j/owx1cyc/qrTXj7OJzHaxk
 D0Rp07Tlka5UP4+qK184puYyVmtT1gO9qCJIme9odLU9VpyfwK2r5ZZEC8yQO9LNgfChwh
 9KgxqMGPAT4351puJlmy6wcb/gJD9Cg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-h3Ndl_QmNQW1QGv3pjLd5w-1; Mon, 28 Jul 2025 11:39:26 -0400
X-MC-Unique: h3Ndl_QmNQW1QGv3pjLd5w-1
X-Mimecast-MFC-AGG-ID: h3Ndl_QmNQW1QGv3pjLd5w_1753717166
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31ed4a4a05bso15962a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717166; x=1754321966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=633gIv/hUWbflz7ELIrGUdAVKw56h9FnUiTLXuugcSo=;
 b=SgLE87xLb4mwN8A0dek5ixZ8y5SHn38AEmp3zUNBicccvaBF89mwkE7VyvwXId+KPP
 lCKCcw36IEPGgiI0nvxgYGSEkQd6r/QKkpufPHOvHd++B+ADxGIzznseYsQNn6MVaN9C
 4fzPcRO8jjRkGc4JU2CeNr4x1hIwqpo6eD7Lw6RXwQ1kX8lq3Sj9XuOnV96aA69VmTSo
 VaFcMM5eTzf/3aE83QeKEPUWktiPSqSO4iDVkAOFmaCIUGNQ04eJNiGnlj1UAtVwxxgA
 J97GUC5L/O68zEinQc0N/c4SYhhm8zBKzbtCjFanDbKwZB7WUO7+s2/6EEhPRJw3Oi6d
 o5Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnjlveG1OG5wEjRoM4LH3GxdyAMsfIQdpZfO7rE4N0efzFeqQt1VC7/fBqA9pr7TYQOQ3fHvSd78Ni@nongnu.org
X-Gm-Message-State: AOJu0Yw5xrY/r0tXhKkkWV5vkbnEew8oywIkcR9Rxew1hrIiAuJn3gJu
 d+QNEb+5F7G1n+FASq2NALgFLWCmNeJbYzWWiDrohkWwf1ZDlXtfpjH63YhyK6fW6gekk4BGyzo
 OVE3KuqbUVyghILWV5dTGPt1nX/F4n86wxuEZOhsY9jRy0NSqkJkH3maYPIYKkBauRsWT10kf13
 BVZBJ8NfxvbskcYEfYG6kakOh6GcfKW+s=
X-Gm-Gg: ASbGncuDqc8CHZbg1j/7bqFFVvFMC97aPIbLtiBGCu5w/uGl594CHiTNvX12XDwZrL4
 qCKC9zvgfJZk58/AxV7cLmeqxhIQSvkdFTNoVhVjJ0zLjkJY2ezhYC/W8+z2aFHMUf9PIakG3rf
 KewWtIC0WI5GyKiZTyVWBh
X-Received: by 2002:a17:90b:2d8e:b0:31e:934b:d00b with SMTP id
 98e67ed59e1d1-31f28c920dfmr72636a91.7.1753717165499; 
 Mon, 28 Jul 2025 08:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1jMS1RwQa2HYUIKA6o3iRP6c7OGmeG2uLVXbhW4+z6X7tPAQUow5iw9oZsn5YSxiCJWFrs+eOevsVQWTHwiA=
X-Received: by 2002:a17:90b:2d8e:b0:31e:934b:d00b with SMTP id
 98e67ed59e1d1-31f28c920dfmr72592a91.7.1753717164999; Mon, 28 Jul 2025
 08:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
 <20250725053122-mutt-send-email-mst@kernel.org>
 <CACGkMEvTgCAbBG20iLB1m_WfYzMZA7FYZ2FuL6To4EV86PXZbA@mail.gmail.com>
 <CACGkMEtCiqq0P_7aB-d5CrQraHL2xky5Qa+9LyZce4hk+wvvYQ@mail.gmail.com>
 <CAJaqyWeJVjG+FbXvYZOu7fXXg-U5vSmt8_+YDw_t7hKv5DH8ew@mail.gmail.com>
In-Reply-To: <CAJaqyWeJVjG+FbXvYZOu7fXXg-U5vSmt8_+YDw_t7hKv5DH8ew@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Jul 2025 17:38:48 +0200
X-Gm-Features: Ac12FXyZA3ZKkwUUUganCo5Bh3VrH06ioE_o8vK_Zvfw8i6NJhD7PwuaLQ8rHl0
Message-ID: <CAJaqyWc-WKhuuKYFV2axJLTVtWqP_ftqz1Sn7+ufNo-5SZ8pRQ@mail.gmail.com>
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

On Mon, Jul 28, 2025 at 4:51=E2=80=AFPM Eugenio Perez Martin
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

Expanding on this,

This is a great base to start from! My proposal is to perform these as
next steps:
1) Track in the destination what members changes from the vmstate sent
in the iterative phase and the downtime phase. I would start by
creating a copy of the last VirtIODevice and VirtIONet, at least for a
first RFC on top of this one.
2) Start the vhost-vdpa net device by the time the first iterative
state reaches us. Just creating the virtqueues should be noticeable,
but sending the CVQ messages here gives us even more downtime
reduction. Do not send these messages in the downtime if the
properties have not changed!

If we want to take a small detour to make a first revision simpler, we
could do the same with vhost-net first: Pre-warm the device creation
with the mq etc.

Thanks!


