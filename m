Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F28EC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiLm-0002bM-Kq; Fri, 17 Jul 2026 09:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkiLi-0002ax-AL
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkiLg-0005Hd-0v
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784293887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c21ngzhNu8vEXEKz8l8oi1F4s1dWDx1lzEgbYldAVcA=;
 b=VwgS3PJ76EPttuQORcmqRMmc8C7WY0U4FTftJ5YTHk+50w9j1pELzE5Ip7/WrDAcTn/G7m
 E3iqsD3M2Acw89rVSoW6WJWxigOM/7jHC6Y058AKPJNOoQDurH1n9vcUcuMTTFkVW+l4u9
 XR2PU13KEGu71AXqILYlryqnaxnNgR4=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-exKYXqB3O1uubqw4UJ8c0Q-1; Fri, 17 Jul 2026 09:11:26 -0400
X-MC-Unique: exKYXqB3O1uubqw4UJ8c0Q-1
X-Mimecast-MFC-AGG-ID: exKYXqB3O1uubqw4UJ8c0Q_1784293885
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-667faef9726so7579772d50.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784293885; cv=none;
 d=google.com; s=arc-20260327;
 b=XwBwQf90Yv+LOU+LDJl5PFcttwq79Mja+98OoFPkWg/FmjoyHSOEIKIlq5TQ2PchnP
 ILhHolXBH3+wBpZEH5msG+8v96k3JOzdoWpDZMDY6tGMHca1tkNj4IiwT71pkWKlN4lM
 qj2lLLTn723uyMc2JMhp+BC3NzqpwoZVPreHbnajtYerKzEjrDoynu3ga4zFVMHV7t/W
 8iwr6ImPcuPyPOXm0+pEFuKIDGn0jno22mdT/zSXYqgXaViNnAoaI/Q1gEqzheBANmtO
 ybSf5BfKLVB8HTTLmIjAJkpo0FfEnd/vu34H1HQBhWAteW9HWUbJDD1iIttjGqqRaBVw
 3o9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c21ngzhNu8vEXEKz8l8oi1F4s1dWDx1lzEgbYldAVcA=;
 fh=dgHOEyvLTFWxBOHVcjTZIkX/IduerwJ6VQV61zqCcDc=;
 b=LI1Dakz5ce/aSpX0LpqhZaTM0neiS/SIf+OgF4KH8RdSOR2C8PB9TbztmnrR2fVt+p
 veZ4sBzsF3E+vA8c/BuYiWwVUzoaN8U4Ek32qBFLghC9F8oAtrl1kuBrOKwN8XU20ri8
 e5zX1q3rDTjvUnzxM9sMDZacF0Dls786Kra/FC+QHpQvMm+MTgaZCwdll5JOvx1FkwDg
 CaeHKY4N3P2+BRqHhdzC1A5B1mtC+66HxqC03bckUaQpasQJKFrI9gI+i3c4Q7r46M/f
 qhrgp4r8jIW82BsXr0G1Y+6il7IqgfFeCNPa8BO3Q9Y2kgETo/L2Ei4bepMYWJyFb303
 EPaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784293885; x=1784898685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c21ngzhNu8vEXEKz8l8oi1F4s1dWDx1lzEgbYldAVcA=;
 b=IaFvVxvz2vfaPUmfr8zQOZB/OIrd17OuaLE1kNmoYGb2iKVrag0ANvtbwpv47Q7RQk
 +AbqHrLu/TSmiF3rGjLUIjuX8wLz+JX45VygHfBKiRbG0VcK36Dp9EjCWQntU/5q9wUX
 69KRBb1WJPvZ6U1/T6MBCXxdimFemnr9n8FH/GkFvTkbCwx5cZVLqD0ehrxWarPb7FZo
 1BXxrn13ZiyfyFwxvnkQlvDdN50bCHSf7u/2LVjhAWiBVhT5OeUk9ulxj3+meN++vnDf
 5Qmxy7r84rhI91OPELg6xnofDkF/+8Fvgck2M3dVmArChpocJDssSmJi6X/EpQPq+pk8
 LgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784293885; x=1784898685;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c21ngzhNu8vEXEKz8l8oi1F4s1dWDx1lzEgbYldAVcA=;
 b=S94xvpl9yt/+JjdDF9gQsyzKlXvZABlcTXHX1oB206OBztrItSEys0mUVkAXtbNdrJ
 ougTbQ24i7uAPODFEjfPczqU+vm6EmPC28+l0gM0v06VgiTzrKBywth9ZhDBje8nzYpT
 b9S9XAR+jdlDzm9q+aK2uX3aNhLxpf8dKR9KZCqu22W9GoOOEvgzYFHpd1FhRF9+XR/+
 39SSgVWPizzsupG3KjBfMmXTSuo8AxcivVEm3d1G3YO/JwLLk5hDouTml1OSvRRnJZQW
 lR/NprgHIU5AfQVUvwD40XaTdzKIpLfZWqPdTB/0vRyElPELwuynCiX4fdxRvT939mpx
 hgIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNxrOG3RC9iI4QGCKNCb0/it0JnzVvKzfY31H9ykK20fNhQdD3JgoL1yU/bFQkFOioar7EL4PJkxPG@nongnu.org
X-Gm-Message-State: AOJu0Yxsepxu2OzJkeZs5xaazM0P4J1ZOebv8JEX2qdB52dW4NAA9r3W
 t6bUrRjxp7gu86E6gnzYv8HR2OVOscKEJQfVzFmNceA2uCIzvS7zSkejvlqHSbZAmB5lxR/HVIt
 FRrceJn5Cwf3+1QAx28TBqp3f1cDuzNVtiHMO1dp0qex9wTd2FVbnsBrfGdWE7a2DdOi9Okw5gc
 m0BPPgLdQ5OgC5/Pum26lVF0Ik8NwzqAs=
X-Gm-Gg: AfdE7cmBxbOehtrBEJs8cfjSBPvyhN0GO2euFyBFtL8FFM+RLT9AkDIj6i3vvFDfKrG
 loNHZwhdEsb+NgzdgAzaiORjX9BEnUAmaxZTLPXDZuLgRSauBVN/U44luRdilSgalm1Ww5nlL7A
 2kI9rUiKRzyzPkSHN0Iy1yyRoR4UU9QIoczZQeWbxbTSal4vwhWNCnSzpd
X-Received: by 2002:a53:d790:0:b0:667:b7f0:e712 with SMTP id
 956f58d0204a3-6683bdd0d69mr464907d50.76.1784293884348; 
 Fri, 17 Jul 2026 06:11:24 -0700 (PDT)
X-Received: by 2002:a53:d790:0:b0:667:b7f0:e712 with SMTP id
 956f58d0204a3-6683bdd0d69mr464899d50.76.1784293883871; Fri, 17 Jul 2026
 06:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-2-dbassey@redhat.com>
 <20260717063641-mutt-send-email-mst@kernel.org>
 <CADSE00+Uoy=fu3OnvMCr0Cn=tHSj27LkD9y7_CPqT32oSaDFow@mail.gmail.com>
 <20260717085600-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260717085600-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Jul 2026 15:11:12 +0200
X-Gm-Features: AUfX_mw5kj_ND3lW8ZhH4fDjdwJoI-GAAx4cYW_jD81ThedHziE77mvg31l1csA
Message-ID: <CADSE00K8xv0WOZQjL95SuZTEMadKc+HyMTffFkJ0EG27f3bHOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org,
 mhrica@redhat.com, sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=aesteve@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 17, 2026 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 17, 2026 at 01:50:31PM +0200, Albert Esteve wrote:
> > On Fri, Jul 17, 2026 at 12:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wrote:
> > > > Commit the memory region transaction before sending the SHMEM_MAP r=
eply
> > > > so the KVM memory slot exists before the guest can access the mappe=
d
> > > > region.
> > > >
> > > > This moves the commit to while the backend is still blocked waiting=
 for
> > > > the reply, which can trigger ADD_MEM_REG back to the backend and
> > > > deadlock. Filter shmem mapping regions out of vhost_section() by
> > > > checking the MR owner type to prevent this.
> > > >
> > > > The explicit transaction begin/commit wrapping is dropped since
> > > > virtio_add_shmem_map() already commits via memory_region_add_subreg=
ion().
> > > >
> > > > Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map requ=
est")
> > > > Suggested-by: Albert Esteve <aesteve@redhat.com>
> > > > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > > > ---
> > > >  hw/virtio/vhost-user.c | 20 ++------------------
> > > >  hw/virtio/vhost.c      | 10 ++++++++++
> > > >  2 files changed, 12 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index 517cc4ca716..01468f7441a 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vh=
ost_dev *dev,
> > > >          }
> > > >      }
> > > >
> > > > -    memory_region_transaction_begin();
> > > > -
> > > >      /* Create VirtioSharedMemoryMapping object */
> > > >      VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_ma=
pping_new(
> > > >          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offse=
t,
> > > > @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vh=
ost_dev *dev,
> > > >
> > > >      if (!mapping) {
> > > >          ret =3D -EFAULT;
> > > > -        goto send_reply_commit;
> > > > +        goto send_reply;
> > > >      }
> > > >
> > > >      /* Add the mapping to the shared memory region */
> > > > @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct v=
host_dev *dev,
> > > >          error_report("Failed to add shared memory mapping");
> > > >          object_unref(OBJECT(mapping));
> > > >          ret =3D -EFAULT;
> > > > -        goto send_reply_commit;
> > > > -    }
> > > > -
> > > > -send_reply_commit:
> > > > -    /* Send reply and commit after transaction started */
> > > > -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > > -        payload->u64 =3D !!ret;
> > > > -        hdr->size =3D sizeof(payload->u64);
> > > > -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) =
{
> > > > -            error_report_err(local_err);
> > > > -            memory_region_transaction_commit();
> > > > -            return -EFAULT;
> > > > -        }
> > > > +        goto send_reply;
> > > >      }
> > > > -    memory_region_transaction_commit();
> > > > -    return 0;
> > > >
> > > >  send_reply:
> > > >      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > index af41841b529..e5c219be095 100644
> > > > --- a/hw/virtio/vhost.c
> > > > +++ b/hw/virtio/vhost.c
> > > > @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *de=
v, MemoryRegionSection *section)
> > > >  {
> > > >      MemoryRegion *mr =3D section->mr;
> > > >
> > > > +    /*
> > > > +     * Skip shmem mapping regions, they are managed via SHMEM_MAP/=
UNMAP.
> > > > +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP tr=
ansaction
> > > > +     * commit, deadlocking the backend.
> > > > +     */
> > > > +    if (object_dynamic_cast(memory_region_owner(mr),
> > > > +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
> > > > +        return false;
> > > > +    }
> > > > +
> > > >      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> > > >          uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr=
);
> > > >          uint8_t handled_dirty;
> > >
> > >
> > > This all seems risky i have to say.  Is this always map never unmap?
> >
> > The filter covers both, and this is a good point. For symmetry the
> > handle_shmem_unmap() should call virtio_del_shmem_map() before
> > replying.
> >
> > BR,
> > Albert.
>
> the reverse order I would say?
>
> if we add, first we commit then update the backend
>
> if we delete first update the backend then commit?

I think it could be argued both ways, so I'd be ok with what you
described (which is what's done in current mainline for the unmap
side).

The reason the commit (the whole del_shmem_map() op) was delayed
before on unmap was to avoid the deadlock (the same as for map).

With the filter, that is no longer a problem. So I would say that if
the backend sends a SHMEM_UNMAP request, by the time it receives the
reply the unmap operation is already commited. It's more symmetrical:
the frontend only replies when the requested memory operation (map or
unmap) is finished and committed.

>
>
>
> > >
> > > > --
> > > > 2.52.0
> > >
>


