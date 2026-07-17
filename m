Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF07C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfN5-0001SL-Bw; Fri, 17 Jul 2026 06:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkfN0-0001Rs-9S
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkfMy-0005mw-9o
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784282434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6I3U5SmFXc/hePmB8fG1YfozTGqtqHzCFpwzDKGkto=;
 b=QQAdColIN4aqDutGx31YFYFS/JgTV7V1P1wQddveb96sMO4X/wnJ6+bZWQO8g+Z6V3cKBt
 sNECLRswS197tX4wgrdNjkfLJZexJR6D79yIclmRarn0hNBsr8Fg60P6BX8IaisiAtd5Lc
 JElYBbip5Ota+txbTaj1j6f2+CKlOBY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-vd_1q5NNPj-M7ET99qpgug-1; Fri, 17 Jul 2026 06:00:31 -0400
X-MC-Unique: vd_1q5NNPj-M7ET99qpgug-1
X-Mimecast-MFC-AGG-ID: vd_1q5NNPj-M7ET99qpgug_1784282430
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39dba2e8dccso9629771fa.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784282430; x=1784887230; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z6I3U5SmFXc/hePmB8fG1YfozTGqtqHzCFpwzDKGkto=;
 b=mTqKWN9Qd+N6mcVTCl4SF4SkdneIAGxVbzjxGuk7yDUtAoKKbwDmmBKXBpQU5h2FAp
 Sgw8ChmuXNO74qYjB0lMN3Goaqmjzra8bgFgp7bCfqAOyKrlxhh1VLrYVMt8AwrH3f/r
 a7xTFzh62Rlg6VYOHlTQAgv8d+NZJ4EWiufvDtyLYqWDbyJ642gcBNuMaALiUt8Bnax2
 Bdz0UERXseiSn3qMcpkn6LQ2QFn8ofxKc3y0xZgswUntdlgskjuPMhQ8PguUo0wZbrK8
 6E5+HaQdaJiBJJhfO3NzhQaFhKyrZuQmO3OsE6Fy9lbwMXUOQ0GCqj4xSlRsfM6u7hkF
 H69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282430; x=1784887230;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z6I3U5SmFXc/hePmB8fG1YfozTGqtqHzCFpwzDKGkto=;
 b=X3hEnYxXgAN7q2edwbrYtmRv4ZeVliZkgZdwxnLklX5GHvcOfVAjTL4XTl0b3OPst0
 usPU7ro0n+1stLR+UVnwvPgde4pqwNTEL7WMLDXATPwjf1AxTRaxD5LvK/OoKbbqTMe3
 hq3PuwYlJJIG8ZxET+IMRCbKvW9L/lzpAXcwgWmBv2wlxRMjjhYZ0adR4qT//1lBVz4P
 9BGVFSot7EF5FqCEKNeVxzCTIDY9fTsHP+5sQfmPJ1LSaCLUH/ytPJRQipwLYTxJafv2
 68CIBDoS3Rngok62G81PnA5cC91ba5FfpstnYKSlSjcVF8DrXEJw/o8noP2eBOtDoS0P
 41cw==
X-Gm-Message-State: AOJu0YzGsKQ1vUbw+E5YuLCQOxdhOYKJiipw/TKWhkprkBZY+6WsgA49
 G18cit06VX38T+fqiF9O7QlXlktUDJEjiGhFe3bPimofuSev+Y8FJza+A7IHpSe1DStgtCT1to3
 V39VBGHl37UHIZUnJCqjVKKWosvS26PTO4V7fhGOn6Nb4LIPzxd/y5R+n
X-Gm-Gg: AfdE7claKpMMsMUVnnaRTq1xeWi7QHnN+LhiXzQR53cOpFiofJxSIZKAtfv/MkOpCUl
 BZ6vgxBLTEJCqrzlvPjlovstIwwhwwVFLs+puSUcVpAjxlVOnp6ndTjoOrNXXEjJ6QNOv5B86x4
 N5U0jhZGVZ7No6MoR4sWnJeIDv0ftZLlehF6o3xDNPG4ajRqTQk2HOyy2dZuJmhBovngyXpw7Rh
 Jr+JWdj89L6vlFclz+TVDhUuUGvBL/8p8Ta8PtaqKdQaezcmnlfT1a+jLQAIBP1ng3jJm6yyBDN
 uaVmtyyjJciyuKn0mdEQRc1qU8i0ljHwhVGGZcdpFFb9whhinWErn4yO/CSYHtv4GurTBuaVe32
 Zo3Yfkzky8lIfetby3yqUGXNt
X-Received: by 2002:a05:6512:2216:b0:5ae:b887:19a with SMTP id
 2adb3069b0e04-5b28fcbf527mr448230e87.64.1784282429622; 
 Fri, 17 Jul 2026 03:00:29 -0700 (PDT)
X-Received: by 2002:a05:6512:2216:b0:5ae:b887:19a with SMTP id
 2adb3069b0e04-5b28fcbf527mr448209e87.64.1784282428907; 
 Fri, 17 Jul 2026 03:00:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b291e0eb4bsm212385e87.46.2026.07.17.03.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:00:28 -0700 (PDT)
Date: Fri, 17 Jul 2026 06:00:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com
Subject: Re: [PATCH v2 3/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
Message-ID: <20260717055918-mutt-send-email-mst@kernel.org>
References: <20260717093925.214023-1-dbassey@redhat.com>
 <20260717093925.214023-4-dbassey@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717093925.214023-4-dbassey@redhat.com>
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

On Fri, Jul 17, 2026 at 11:39:25AM +0200, Dorinda Bassey wrote:
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
> Suggested-by: Albert Esteve <aesteve@redhat.com>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>

i do not get this ordering) of patches) why are there features and last patch
is a bugfix? if this is a dependency it should come first.

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
> -- 
> 2.52.0


