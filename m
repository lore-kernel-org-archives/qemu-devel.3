Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C54C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkic1-0001UD-9v; Fri, 17 Jul 2026 09:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkibz-0001Tq-Ed
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkibx-0007He-E8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784294896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XW+aCbooHrRBAxxBwErEF7f5takjgeo1yh4TYuGGX0=;
 b=SlUQb63ukZ0FXO2TG7ZvUGhd2BfVSdIxm8HW2UJsvhi4Oto+U8HZjPvIvet+wt87G5KzX1
 hXKdxPoLaUiTN43S2ebIKzrLG4OdnbflDPLKtNXnuk+IYB238OWuiTmiJcx3BrSJ5NzKgw
 GONkH6fIQ3SqMsqXKPIMxP6mSgFzolU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-TMS31Az7Pa-lh3AVD3slZw-1; Fri, 17 Jul 2026 09:28:15 -0400
X-MC-Unique: TMS31Az7Pa-lh3AVD3slZw-1
X-Mimecast-MFC-AGG-ID: TMS31Az7Pa-lh3AVD3slZw_1784294894
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so2921929f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784294894; x=1784899694; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2XW+aCbooHrRBAxxBwErEF7f5takjgeo1yh4TYuGGX0=;
 b=f6M4kmMLnM0igdFQJhiYzYpYF9HQsU/kUqsmQifAa9jNJCWsQcXVQmDOAz32S0VVSB
 AxG1RQKvUYH+WJeOvN9SktsyxY0iCEZs2va3ouzBgAr0TFMA7aylb9gaTWAj9N8NO7Km
 54dKrFWbPKMdoxfhNuq84ToBjhHga6/z4fpBlJJL46GhFWfweRo6yCEKQVAjgiAFF2O7
 75am8AGZ1Dmgi9kqysk7JeTGiScgeWvfB18fXwM83Rwrwk5zKGyUpwTTTZtS6WPOWsBw
 dP9AaC7Sp+vt+KMK3JZ3+S2s0l/aV7Vp9RpWC0Ge3XKBl+c5tvHZ0La8Qp7tO+ypd2SZ
 c/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784294894; x=1784899694;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2XW+aCbooHrRBAxxBwErEF7f5takjgeo1yh4TYuGGX0=;
 b=IA6cHTwAN24HZLk+EKmi6ftY4SB49TTL1XX9zZJjBCwkHqd2CYsRVWis5ddQ00oHbg
 RO1NxSU5UQec6T65hNkeJLH0qRHfKNFfMOP0kbSYWIhkz1KYwWE/md4q5KAT+WtfFr2Z
 al9hBwrhMywyfLD++MnFD/1qIQG9B1jb/RWx0NqmDh4ZSvGkzT2SdBYRi3oEoCyltc/m
 TZXc3lX8x0TUwMSGo0iukN91F3/q0SaZm04TuTVLb6eRjQXtr2F7xUXPsaqOe/heAE0I
 gqIPnmKIQVUjxjQaDvJL8RxR3Qvs/ntCp7RCh6PZokj2NEgb8vOYRQCLVwWkiuJivD+k
 5LjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roh6yshETAyGklkPXMwh7/6ACIKkDBVTNMuu45DdzCMX8InRmeHGlghJwAjVd0qMxleClQYCqFZlO0s@nongnu.org
X-Gm-Message-State: AOJu0YzvMvWNxCOHrA0sBBPgb0QQkKOm+rg2O/gMzT10+0Ce6ismXJuV
 1MPXR+R7mxYShosnfWf+R5gJmXkjO2xKkNqQRVPSXNcM2FUUmnF5sYNaoeZq1UFBYOVaOG0K8Ds
 g+i0NLmh1W5t/UavlGHiC8aq/vIFLXAbrcz9GOgZ0wGTjiOWO3HmO/sqU
X-Gm-Gg: AfdE7cnChK1gRaLtA+oIZHd50JSUIuwmDKdWyd8pRUfXKU1sefGPz3V7W0aMfdLEIUE
 UugazrRBe0Bofzp3RpQr21pU/DyjNhWlwCleCKcOIGtqS+tCZuLIqmbemCvRZKQmPruL2eUCFui
 Uid41qYk6HPKp6POOD6FQSLRdfZlildDSxEDWZiMb/A+9mOZq8dx8rjGcIEWUCNJMh0QMFFXnQS
 2+VDDtcW64xS0XVxDnO0MsWw22QxmSOjB24Bx/AJIncArp/ECLhQF5zST3EAnfj+RJjsMh5Zpgo
 g7kXNnOhK9ATQM19kO6vl/xV9HAJw8Zpo1XQy81PN7RA6mTYGeM1ZO7nL0n5Vzm3uCVcdzxf4hs
 p5cD5FwCJ5pzf/T5+YRe1jja3
X-Received: by 2002:a05:6000:2c06:b0:47d:e121:1dd1 with SMTP id
 ffacd0b85a97d-47f622f91f8mr4269522f8f.17.1784294893910; 
 Fri, 17 Jul 2026 06:28:13 -0700 (PDT)
X-Received: by 2002:a05:6000:2c06:b0:47d:e121:1dd1 with SMTP id
 ffacd0b85a97d-47f622f91f8mr4269433f8f.17.1784294893205; 
 Fri, 17 Jul 2026 06:28:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edda29sm4143446f8f.32.2026.07.17.06.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:28:12 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:28:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org,
 mhrica@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
Message-ID: <20260717092716-mutt-send-email-mst@kernel.org>
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-2-dbassey@redhat.com>
 <20260717063641-mutt-send-email-mst@kernel.org>
 <CADSE00+Uoy=fu3OnvMCr0Cn=tHSj27LkD9y7_CPqT32oSaDFow@mail.gmail.com>
 <20260717085600-mutt-send-email-mst@kernel.org>
 <CADSE00K8xv0WOZQjL95SuZTEMadKc+HyMTffFkJ0EG27f3bHOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00K8xv0WOZQjL95SuZTEMadKc+HyMTffFkJ0EG27f3bHOQ@mail.gmail.com>
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

On Fri, Jul 17, 2026 at 03:11:12PM +0200, Albert Esteve wrote:
> On Fri, Jul 17, 2026 at 2:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jul 17, 2026 at 01:50:31PM +0200, Albert Esteve wrote:
> > > On Fri, Jul 17, 2026 at 12:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wrote:
> > > > > Commit the memory region transaction before sending the SHMEM_MAP reply
> > > > > so the KVM memory slot exists before the guest can access the mapped
> > > > > region.
> > > > >
> > > > > This moves the commit to while the backend is still blocked waiting for
> > > > > the reply, which can trigger ADD_MEM_REG back to the backend and
> > > > > deadlock. Filter shmem mapping regions out of vhost_section() by
> > > > > checking the MR owner type to prevent this.
> > > > >
> > > > > The explicit transaction begin/commit wrapping is dropped since
> > > > > virtio_add_shmem_map() already commits via memory_region_add_subregion().
> > > > >
> > > > > Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
> > > > > Suggested-by: Albert Esteve <aesteve@redhat.com>
> > > > > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > > > > ---
> > > > >  hw/virtio/vhost-user.c | 20 ++------------------
> > > > >  hw/virtio/vhost.c      | 10 ++++++++++
> > > > >  2 files changed, 12 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > > index 517cc4ca716..01468f7441a 100644
> > > > > --- a/hw/virtio/vhost-user.c
> > > > > +++ b/hw/virtio/vhost-user.c
> > > > > @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > > > >          }
> > > > >      }
> > > > >
> > > > > -    memory_region_transaction_begin();
> > > > > -
> > > > >      /* Create VirtioSharedMemoryMapping object */
> > > > >      VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
> > > > >          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> > > > > @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > > > >
> > > > >      if (!mapping) {
> > > > >          ret = -EFAULT;
> > > > > -        goto send_reply_commit;
> > > > > +        goto send_reply;
> > > > >      }
> > > > >
> > > > >      /* Add the mapping to the shared memory region */
> > > > > @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > > > >          error_report("Failed to add shared memory mapping");
> > > > >          object_unref(OBJECT(mapping));
> > > > >          ret = -EFAULT;
> > > > > -        goto send_reply_commit;
> > > > > -    }
> > > > > -
> > > > > -send_reply_commit:
> > > > > -    /* Send reply and commit after transaction started */
> > > > > -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > > > -        payload->u64 = !!ret;
> > > > > -        hdr->size = sizeof(payload->u64);
> > > > > -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> > > > > -            error_report_err(local_err);
> > > > > -            memory_region_transaction_commit();
> > > > > -            return -EFAULT;
> > > > > -        }
> > > > > +        goto send_reply;
> > > > >      }
> > > > > -    memory_region_transaction_commit();
> > > > > -    return 0;
> > > > >
> > > > >  send_reply:
> > > > >      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > > index af41841b529..e5c219be095 100644
> > > > > --- a/hw/virtio/vhost.c
> > > > > +++ b/hw/virtio/vhost.c
> > > > > @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
> > > > >  {
> > > > >      MemoryRegion *mr = section->mr;
> > > > >
> > > > > +    /*
> > > > > +     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMAP.
> > > > > +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP transaction
> > > > > +     * commit, deadlocking the backend.
> > > > > +     */
> > > > > +    if (object_dynamic_cast(memory_region_owner(mr),
> > > > > +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > >      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> > > > >          uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
> > > > >          uint8_t handled_dirty;
> > > >
> > > >
> > > > This all seems risky i have to say.  Is this always map never unmap?
> > >
> > > The filter covers both, and this is a good point. For symmetry the
> > > handle_shmem_unmap() should call virtio_del_shmem_map() before
> > > replying.
> > >
> > > BR,
> > > Albert.
> >
> > the reverse order I would say?
> >
> > if we add, first we commit then update the backend
> >
> > if we delete first update the backend then commit?
> 
> I think it could be argued both ways, so I'd be ok with what you
> described (which is what's done in current mainline for the unmap
> side).
> 
> The reason the commit (the whole del_shmem_map() op) was delayed
> before on unmap was to avoid the deadlock (the same as for map).
> 
> With the filter, that is no longer a problem. So I would say that if
> the backend sends a SHMEM_UNMAP request, by the time it receives the
> reply the unmap operation is already commited. It's more symmetrical:
> the frontend only replies when the requested memory operation (map or
> unmap) is finished and committed.

I don't know, this thing makes my head hurt.
Pls document ordering for both in the commit log.

> >
> >
> >
> > > >
> > > > > --
> > > > > 2.52.0
> > > >
> >


