Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F242C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfwn-0004wm-2u; Fri, 17 Jul 2026 06:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkfwm-0004we-FP
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkfwk-0001lH-AR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784284653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0CoeZqrAz9XFkUYpwqbvFUcOclI2NmCO/caGnGiU7c8=;
 b=iwVR4cpCVSklr3n0ufOpr4xDPHFUzzl5IT96P/TvTn2anKe1JjBjHUmt/9wpRN/KveuAKF
 1PvEg7dGxV/7LCuGATBTpiRC56htvMZyNCUqgTUO5h0ARZ7nNRve2LoSCVPXPPGZ8StJlv
 AEYPIW4djy8bwv7KGrnNHu0WWYLEUV8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-PvGOkSoCOXyTG2kkdDXTkw-1; Fri, 17 Jul 2026 06:37:28 -0400
X-MC-Unique: PvGOkSoCOXyTG2kkdDXTkw-1
X-Mimecast-MFC-AGG-ID: PvGOkSoCOXyTG2kkdDXTkw_1784284648
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-472c330e555so3648737f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784284648; x=1784889448; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0CoeZqrAz9XFkUYpwqbvFUcOclI2NmCO/caGnGiU7c8=;
 b=ncEcu8h6TpVfM6+Bv/asgGcZ6g+XhK9SO0WMaTZ7TSLnJF9ov3KMWG9Fae2VvYhEYF
 bDIidqO/uqkHFZW+nHgCxZ73M6CRW4r3B9WrkDg3breQe+0ZNJ8w6ooxTSKusJs0BEGJ
 PryKcU/2pbZKRFQ55AhOgX2HsIvtc+TmYZQCQnqK/2cWPevqAdLSlyPMBUvmda7QvbjQ
 q9cm5xSCdQiaXPRthZYtncSkQJgB47WMTFqISigouEIEMRjbA2qUNWCzN94o6C1DE2b9
 hnwiGtddXxnnfHobcNbWBT/rQ7P/XmjMAiP9NIh+9m3l/uEe1YabIs1+3NUec+dSmGAa
 txRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784284648; x=1784889448;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0CoeZqrAz9XFkUYpwqbvFUcOclI2NmCO/caGnGiU7c8=;
 b=LTSwTUO5VZHK3yuWm6Sx7Zqq24EjA83I7evMY7y8ejC9Xy1mv0MAGE+cKpqaIHBkTV
 mPVhdm6ybciNuYjsJT8wh8Pey7nS5V3lEfJkvgIKWZH0VY5I88nbAbfEnoHE7WU7xWnF
 J3aCUP7KWx4XnWdWxgxWTyqZSlQPI8I7teYY3jFL/+lYVXj91DH7ntjzP9m2IcZe2gNK
 IXFOYzZqGTpAXPg+APY7jbEHF+0Bo0+9hiLhRVH1SBcmRzDBs5b5bDZFze5GclryeND0
 IJFgGpuuzngDk4K6UmBO4M/9CiT8uWOpxq+pfeWy/aHoFq+DUdom1ZmMORKS4lT7U951
 qodg==
X-Gm-Message-State: AOJu0YxFJWQ3HDDz+FGFP3TA3M0iBhmzWbqOzW3eUw2eqex/FuqNhSCa
 g1/t8396w4UyJHocgls66mkIubUfdESnwIxJVHldBlJTP3fRWX89DoX4w/FOorLW1J3X6b29529
 E5ejBZ7zSnrO1A4EvBmkEnGRuV4D9EB8UtHYAxSQK4m+nU4Udi0RlmQQN
X-Gm-Gg: AfdE7ckwUVbo5TmaVbaKLzZnL4345uLsMiUE6YAoJB3SBXG1xewMjtGkQHQy8IbHy4A
 mZmlk6wC1QCTvR5Q3uUSSStV0S10DBrwcfNgtDTcCj33k4rKqlbyWCIr6/meZkS6wiNAipHeyKe
 oaT3hQYBmf/5WkLBHnDFqJ5EPTLI3mEk9TSbnxiLxbgFunU4AVFViMREXYN0+YN3X7mx67Xqxnf
 H3fmzSOcjTOHH3X7al8eNf/1bB3pY4sT/fNt2kWWzr3gYji54HW8EtJ3QZCxHf+TGm98+MMxFsw
 CfL0hegjC4RAeyCxCLyByjHGrq96p6o5a8Rw5+CKhbWUPsAW2FxJtwcrl/LDsqnas47F8V+T6ec
 M4HaIyMerxAqpRV3kGTgFQzSn
X-Received: by 2002:a05:6000:2407:b0:47f:4fa9:ae33 with SMTP id
 ffacd0b85a97d-47f622fef02mr2885345f8f.12.1784284647384; 
 Fri, 17 Jul 2026 03:37:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2407:b0:47f:4fa9:ae33 with SMTP id
 ffacd0b85a97d-47f622fef02mr2885287f8f.12.1784284646748; 
 Fri, 17 Jul 2026 03:37:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edda9bsm2607410f8f.31.2026.07.17.03.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:37:25 -0700 (PDT)
Date: Fri, 17 Jul 2026 06:37:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com
Subject: Re: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
Message-ID: <20260717063641-mutt-send-email-mst@kernel.org>
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-2-dbassey@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717103301.228974-2-dbassey@redhat.com>
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

On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wrote:
> Commit the memory region transaction before sending the SHMEM_MAP reply
> so the KVM memory slot exists before the guest can access the mapped
> region.
> 
> This moves the commit to while the backend is still blocked waiting for
> the reply, which can trigger ADD_MEM_REG back to the backend and
> deadlock. Filter shmem mapping regions out of vhost_section() by
> checking the MR owner type to prevent this.
> 
> The explicit transaction begin/commit wrapping is dropped since
> virtio_add_shmem_map() already commits via memory_region_add_subregion().
> 
> Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
> Suggested-by: Albert Esteve <aesteve@redhat.com>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 20 ++------------------
>  hw/virtio/vhost.c      | 10 ++++++++++
>  2 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 517cc4ca716..01468f7441a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>          }
>      }
>  
> -    memory_region_transaction_begin();
> -
>      /* Create VirtioSharedMemoryMapping object */
>      VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
>          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>  
>      if (!mapping) {
>          ret = -EFAULT;
> -        goto send_reply_commit;
> +        goto send_reply;
>      }
>  
>      /* Add the mapping to the shared memory region */
> @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>          error_report("Failed to add shared memory mapping");
>          object_unref(OBJECT(mapping));
>          ret = -EFAULT;
> -        goto send_reply_commit;
> -    }
> -
> -send_reply_commit:
> -    /* Send reply and commit after transaction started */
> -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> -        payload->u64 = !!ret;
> -        hdr->size = sizeof(payload->u64);
> -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> -            error_report_err(local_err);
> -            memory_region_transaction_commit();
> -            return -EFAULT;
> -        }
> +        goto send_reply;
>      }
> -    memory_region_transaction_commit();
> -    return 0;
>  
>  send_reply:
>      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b529..e5c219be095 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
>  {
>      MemoryRegion *mr = section->mr;
>  
> +    /*
> +     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMAP.
> +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP transaction
> +     * commit, deadlocking the backend.
> +     */
> +    if (object_dynamic_cast(memory_region_owner(mr),
> +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
> +        return false;
> +    }
> +
>      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
>          uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
>          uint8_t handled_dirty;


This all seems risky i have to say.  Is this always map never unmap?

> -- 
> 2.52.0


