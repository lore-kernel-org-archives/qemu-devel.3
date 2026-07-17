Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C9EC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfXm-0000lL-S8; Fri, 17 Jul 2026 06:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkfXW-0000ZY-23
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkfXT-0007ED-Dm
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784283077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPtPLpFB9DB+T+jLOSK01xb1uTSfBn7IgIxhUc8qI4w=;
 b=c8ZuFIHMf6QiIaQiIPW/h/xcdLE/Rjk1eyX/ts3WdpF8Qthuj2+aYLOkYatYpRKCUi1Vg5
 +H9rdEZ1CuAFyAWy5WPnD44YibrYELkHDKON0oSGQtFHRqx4aLMFynPMYECaS4981PRXPC
 HV6uALBQph2Fg+vBaothwsGB1pqtk2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-um7UIhaUMmaThrYkNre6wA-1; Fri, 17 Jul 2026 06:11:16 -0400
X-MC-Unique: um7UIhaUMmaThrYkNre6wA-1
X-Mimecast-MFC-AGG-ID: um7UIhaUMmaThrYkNre6wA_1784283075
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49545755b03so11189015e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784283075; x=1784887875; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aPtPLpFB9DB+T+jLOSK01xb1uTSfBn7IgIxhUc8qI4w=;
 b=pYPwqW43v6QjXveO8kDbjRUyPMJ9DPril00u9WiTWrI+vWpR2E0oz9BfSOFGkwGGTf
 wffCcXCQgiQZ6qRtqAaTHS6wJ/6ctPEyuZ/i/rhZ0Kinu+oxwNxQxOc6hRAZPWj5YhmJ
 p9v3+1fLFrpWqWz08UdvcckRZDKbhAHPZo7/3YzLmRF/SPDANtku3jHh/8vxurODB8Id
 QyMrzdMXz+3YoOXrzisEmJKRDQnCgvCeui7dT6v8FdBb3v9IvaLncVrMj9CwcSF+25fv
 kCdaO0AFTp0JPoqG/oewK4SR5EO1F/DMRj7aJV6p0oh8GoqznN4sVaNGJtXPMWCyOVHK
 Uu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784283075; x=1784887875;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aPtPLpFB9DB+T+jLOSK01xb1uTSfBn7IgIxhUc8qI4w=;
 b=U00y3B0UNJ7lB1O7fqVGpGxI5goaKRn5O2KgcXa0nZnIRVTfEe/+KfncRTufWcCvND
 Gn0gt2rN/9X83x+mLeObKlkQl/KqQYewDaMyKnNO+HdZaVYFW6h0fgjxIKkGcuWF64i9
 UGH0UncvTKfjwsm+LelUvwaCcVOuVEfPHJPej9NsBMc7fZDOBaJ3Y7NHgOf7wh3vYXFC
 MO2Rkvkp2cjbHaq7S/T2Zh4mMYfmA8ti4VpBu8iSEInDXX+0Wi3prZPWfFohEUfOEbch
 vguUgh6IdOt4xkMJviHGEaOPg1XuFP/8OV4Devqh8WqxMFOBzkbMUMy1YrX453TR2mHL
 Zr8w==
X-Gm-Message-State: AOJu0Yw8p36qia9Os7cc9TMVwRAn4p/MZd/6u40+ZcGYgW4xwh3eAs8x
 OWgjiSGajXa4pqsoZ2IA0+iqldLQWA/Zy6ZP+J9gfNfZ8Mlkkp6Vd2qv6sTXQc7fOBc8CPY3l9H
 xG/H3F65+QAIf6ndysRTr+jzD0ug36YbB6767rid/C2wTP9QU4z7iF8V+
X-Gm-Gg: AfdE7cnxVMttXx24UMOVkA29f+9WlB3WaMvMY9hdXWuBVt7JvblaMWnHGCW4GxfYu0L
 tkONujvJ0fQ4au7aUds/AECWQ2+4ew4Cx/RtsNWd5E3g+tYze7Cr1ySiOHV/AsxDgfNQN8MJfDW
 HwNRonb1X4y4DrtjEyE91Kzoxvkh3j/HSOrdkE+LFkq7qaosIBR/PnklGZFNOKKmjmCMSZN1lKW
 R63q+WxHyVqa+3qkvgsq5Pvwmq3UchUvgXOyzC2IekI08Xts5dcHCgRuGr0T0l94U1fAt3jtMn8
 S/Afz4UF55HTL9c+yfXUl8uzZBWyWtPbUDv2KhVxwddX6F3c9sXWxDJaaQYBwJOF6nB1ad/RCVb
 ZM8j9bImLBIxSxiuI1dd8qN3C
X-Received: by 2002:a05:600c:35d5:b0:493:d0f7:69c3 with SMTP id
 5b1f17b1804b1-4954a749117mr24443565e9.33.1784283074939; 
 Fri, 17 Jul 2026 03:11:14 -0700 (PDT)
X-Received: by 2002:a05:600c:35d5:b0:493:d0f7:69c3 with SMTP id
 5b1f17b1804b1-4954a749117mr24443085e9.33.1784283074342; 
 Fri, 17 Jul 2026 03:11:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954995b78dsm25300335e9.0.2026.07.17.03.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:11:13 -0700 (PDT)
Date: Fri, 17 Jul 2026 06:11:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com
Subject: Re: [PATCH v2 3/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
Message-ID: <20260717061057-mutt-send-email-mst@kernel.org>
References: <20260717093925.214023-1-dbassey@redhat.com>
 <20260717093925.214023-4-dbassey@redhat.com>
 <20260717055918-mutt-send-email-mst@kernel.org>
 <CACzuRyw=QTSwz1aWVhBG7EO6MeWi85YTMvV-DT_+tsWADMcfqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzuRyw=QTSwz1aWVhBG7EO6MeWi85YTMvV-DT_+tsWADMcfqw@mail.gmail.com>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 17, 2026 at 12:07:21PM +0200, Dorinda Bassey wrote:
> You're right, I will reorder it in v3. The fix came last because I only
> discovered the deadlock while testing the shmem/blob support,
> but it makes sense to have it first since patch 2 depends on it.

thanks. it needs a Fixes tag too.

> On Fri, Jul 17, 2026 at 12:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Fri, Jul 17, 2026 at 11:39:25AM +0200, Dorinda Bassey wrote:
>     > Commit the memory region transaction before sending the SHMEM_MAP reply
>     > so the KVM memory slot exists before the guest can access the mapped
>     > region.
>     >
>     > This moves the commit to while the backend is still blocked waiting for
>     > the reply, which can trigger ADD_MEM_REG back to the backend and
>     > deadlock. Filter shmem mapping regions out of vhost_section() by
>     > checking the MR owner type to prevent this.
>     >
>     > The explicit transaction begin/commit wrapping is dropped since
>     > virtio_add_shmem_map() already commits via memory_region_add_subregion().
>     >
>     > Suggested-by: Albert Esteve <aesteve@redhat.com>
>     > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> 
>     i do not get this ordering) of patches) why are there features and last
>     patch
>     is a bugfix? if this is a dependency it should come first.
> 
>     > ---
>     >  hw/virtio/vhost-user.c | 20 ++------------------
>     >  hw/virtio/vhost.c      | 10 ++++++++++
>     >  2 files changed, 12 insertions(+), 18 deletions(-)
>     >
>     > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>     > index 517cc4ca716..01468f7441a 100644
>     > --- a/hw/virtio/vhost-user.c
>     > +++ b/hw/virtio/vhost-user.c
>     > @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct
>     vhost_dev *dev,
>     >          }
>     >      }
>     > 
>     > -    memory_region_transaction_begin();
>     > -
>     >      /* Create VirtioSharedMemoryMapping object */
>     >      VirtioSharedMemoryMapping *mapping =
>     virtio_shared_memory_mapping_new(
>     >          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
>     > @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct
>     vhost_dev *dev,
>     > 
>     >      if (!mapping) {
>     >          ret = -EFAULT;
>     > -        goto send_reply_commit;
>     > +        goto send_reply;
>     >      }
>     > 
>     >      /* Add the mapping to the shared memory region */
>     > @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct
>     vhost_dev *dev,
>     >          error_report("Failed to add shared memory mapping");
>     >          object_unref(OBJECT(mapping));
>     >          ret = -EFAULT;
>     > -        goto send_reply_commit;
>     > -    }
>     > -
>     > -send_reply_commit:
>     > -    /* Send reply and commit after transaction started */
>     > -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
>     > -        payload->u64 = !!ret;
>     > -        hdr->size = sizeof(payload->u64);
>     > -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
>     > -            error_report_err(local_err);
>     > -            memory_region_transaction_commit();
>     > -            return -EFAULT;
>     > -        }
>     > +        goto send_reply;
>     >      }
>     > -    memory_region_transaction_commit();
>     > -    return 0;
>     > 
>     >  send_reply:
>     >      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
>     > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>     > index af41841b529..e5c219be095 100644
>     > --- a/hw/virtio/vhost.c
>     > +++ b/hw/virtio/vhost.c
>     > @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev,
>     MemoryRegionSection *section)
>     >  {
>     >      MemoryRegion *mr = section->mr;
>     > 
>     > +    /*
>     > +     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMAP.
>     > +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP
>     transaction
>     > +     * commit, deadlocking the backend.
>     > +     */
>     > +    if (object_dynamic_cast(memory_region_owner(mr),
>     > +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
>     > +        return false;
>     > +    }
>     > +
>     >      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
>     >          uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
>     >          uint8_t handled_dirty;
>     > --
>     > 2.52.0
> 
> 


