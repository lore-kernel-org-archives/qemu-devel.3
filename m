Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A955C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wki8z-0008Qw-J2; Fri, 17 Jul 2026 08:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wki8u-0008NX-N9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wki8s-0003lt-4x
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784293092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCdDEAGDR/VRBuPyJ7IXtSXgrebr8pRzPTlHPhStxHc=;
 b=FAbBEWefAWRm/cla605Cb0dXOMrJF4CavEgVS/NjEQcvdnRoVJIcoc0l1gYp4qRk4n8N9e
 bLMW73HXPBAjv8wwPKKKwbA+jWqbDWY15YYhW4I0bRhE9K7VNxO7KbOa6E9eR0rqYQskz9
 E89QaC+fHboAb0SM+cCKx2swgY1Rr/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-RNzK9lBlOoGou8pSQdi6sA-1; Fri, 17 Jul 2026 08:58:09 -0400
X-MC-Unique: RNzK9lBlOoGou8pSQdi6sA-1
X-Mimecast-MFC-AGG-ID: RNzK9lBlOoGou8pSQdi6sA_1784293088
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49545071724so14082435e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784293088; x=1784897888; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iCdDEAGDR/VRBuPyJ7IXtSXgrebr8pRzPTlHPhStxHc=;
 b=Fl2pqBZ4FvF2QhpBV9A4HCaj1avO1UcydTgC50NH/nhvcVNOCx76FciuxEt6yRXnhx
 gR526cL+/93pmjlwClCK9kZItfYvO0Vuu9kTfnEfScy7c2vS7T81dYF74zDvrzKBfYcl
 mLNGXVagWTVQbuOds6GOb5WF4hwELx97hFDs4XEPWJihl+1cJJBUBt0aEBcS/nxKqhR/
 mOcOAsRJhNGu3XmORJUgnUs4uM44UT9XEcmyCq5Gu2sPN35CUU3fKW0RSnGinqDtOGVG
 r2QldJwEuTed/koTJUcITbx5Z356z3KY3FBqnlBRTqpuUAWxy1vx0yIL+AksBZie9Ven
 HNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784293088; x=1784897888;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iCdDEAGDR/VRBuPyJ7IXtSXgrebr8pRzPTlHPhStxHc=;
 b=IpPxsRD4SP5kAylCZPhj4gcTiEi75uYjyr5YuoLR8oJoAvn4rOpzN/Pj7zeQSbJW7e
 w+m1Yv1cXc73DiVhb62rJHMk5T3Es3+oh5ViVZe6AlURjm7KKKt29j6/UrKuZtXGEdk6
 wskqQSdJP89agVpoDk38Vl7bPBZc0umCtZhQjUlLpRcDPpK+XoSAi3UbEKvLMVlx4lzB
 zn59Oh5ZT5Dzlhap8ePEyn0iOZxW/es7qCiuYV/Pol3/grpKPoVsiSE3pG1Bo/O+01Od
 wzYu8xyOFpy9J3w5/axZXH2mYYcFEmoxG1SI8K1/8Mr0MpP3pmc4YDRW+Khr3v+cnuXZ
 UITQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxAwKjTHu6uOOotih5u2V324Z+P+KgwC49DnCH5wmg4Me8ehJ0peQikswwLyhd+3GCFDNGZAiN76wG@nongnu.org
X-Gm-Message-State: AOJu0YwFaxP1mzz2ksaqqhRSGHbdejKcri03tANBswtU2YBy9iGq8txj
 3sWBgFe4hYqXOqttl6pE6cT4onGDe/Su6RFh2yJgGCeVNerxKzCX4lPTBFHdyqcM4UVz1NWwt7X
 5nOEeOdebAhz4KcXRSsS1XG6BhyVu01DRlo9RJi8FiPHsx5EgwvWn/0X0
X-Gm-Gg: AfdE7cmMsN346GX34w6Gx+PQbGo8AAjBtQtkt2pSLg6McopAGMioM1fbjVinq/z4pAJ
 /HcldZe70P7pAcP+OYrezEfDFM/FiI62b7MjeCYpIakSinDKCEKkO9c5v3pCGnjJdlZM8DTYjaW
 kzBVeEn46xZqFZ/UJnrLCkgJp+zJvUCenxsZBx2J2hzHY2bvnkZxsjH77f8Mlpm07Q2WyG9qcAo
 q+vHaYcfhgh2qhPacBZCUXxtZiAoF3UMSSPPCU2qSYHHREmKXYhImCsKEIDxNmtYBt9cdjnnmAF
 oJTr4IlNa9PkgM1Q+f7yTnnuv597t+nD0RUgV3mjiYMQShzGgZ6dCTk8/Vl/w+CtCbONLch/f3O
 uIz/50CoQ5oCOJ0UrY89XOI1F
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id
 5b1f17b1804b1-4954a771521mr29831895e9.33.1784293088101; 
 Fri, 17 Jul 2026 05:58:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id
 5b1f17b1804b1-4954a771521mr29831605e9.33.1784293087516; 
 Fri, 17 Jul 2026 05:58:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49500sm3550066f8f.2.2026.07.17.05.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:58:07 -0700 (PDT)
Date: Fri, 17 Jul 2026 08:58:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org,
 mhrica@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
Message-ID: <20260717085600-mutt-send-email-mst@kernel.org>
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-2-dbassey@redhat.com>
 <20260717063641-mutt-send-email-mst@kernel.org>
 <CADSE00+Uoy=fu3OnvMCr0Cn=tHSj27LkD9y7_CPqT32oSaDFow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+Uoy=fu3OnvMCr0Cn=tHSj27LkD9y7_CPqT32oSaDFow@mail.gmail.com>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 17, 2026 at 01:50:31PM +0200, Albert Esteve wrote:
> On Fri, Jul 17, 2026 at 12:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wrote:
> > > Commit the memory region transaction before sending the SHMEM_MAP reply
> > > so the KVM memory slot exists before the guest can access the mapped
> > > region.
> > >
> > > This moves the commit to while the backend is still blocked waiting for
> > > the reply, which can trigger ADD_MEM_REG back to the backend and
> > > deadlock. Filter shmem mapping regions out of vhost_section() by
> > > checking the MR owner type to prevent this.
> > >
> > > The explicit transaction begin/commit wrapping is dropped since
> > > virtio_add_shmem_map() already commits via memory_region_add_subregion().
> > >
> > > Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
> > > Suggested-by: Albert Esteve <aesteve@redhat.com>
> > > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > > ---
> > >  hw/virtio/vhost-user.c | 20 ++------------------
> > >  hw/virtio/vhost.c      | 10 ++++++++++
> > >  2 files changed, 12 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 517cc4ca716..01468f7441a 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > >          }
> > >      }
> > >
> > > -    memory_region_transaction_begin();
> > > -
> > >      /* Create VirtioSharedMemoryMapping object */
> > >      VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
> > >          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> > > @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > >
> > >      if (!mapping) {
> > >          ret = -EFAULT;
> > > -        goto send_reply_commit;
> > > +        goto send_reply;
> > >      }
> > >
> > >      /* Add the mapping to the shared memory region */
> > > @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > >          error_report("Failed to add shared memory mapping");
> > >          object_unref(OBJECT(mapping));
> > >          ret = -EFAULT;
> > > -        goto send_reply_commit;
> > > -    }
> > > -
> > > -send_reply_commit:
> > > -    /* Send reply and commit after transaction started */
> > > -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > -        payload->u64 = !!ret;
> > > -        hdr->size = sizeof(payload->u64);
> > > -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> > > -            error_report_err(local_err);
> > > -            memory_region_transaction_commit();
> > > -            return -EFAULT;
> > > -        }
> > > +        goto send_reply;
> > >      }
> > > -    memory_region_transaction_commit();
> > > -    return 0;
> > >
> > >  send_reply:
> > >      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index af41841b529..e5c219be095 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
> > >  {
> > >      MemoryRegion *mr = section->mr;
> > >
> > > +    /*
> > > +     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMAP.
> > > +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP transaction
> > > +     * commit, deadlocking the backend.
> > > +     */
> > > +    if (object_dynamic_cast(memory_region_owner(mr),
> > > +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
> > > +        return false;
> > > +    }
> > > +
> > >      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> > >          uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
> > >          uint8_t handled_dirty;
> >
> >
> > This all seems risky i have to say.  Is this always map never unmap?
> 
> The filter covers both, and this is a good point. For symmetry the
> handle_shmem_unmap() should call virtio_del_shmem_map() before
> replying.
> 
> BR,
> Albert.

the reverse order I would say?

if we add, first we commit then update the backend

if we delete first update the backend then commit?



> >
> > > --
> > > 2.52.0
> >


