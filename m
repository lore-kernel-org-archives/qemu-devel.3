Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD72C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1who6G-0005Xt-4S; Thu, 09 Jul 2026 08:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1who6E-0005Xc-Qm
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1who6D-0003ua-AZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783601008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZx3yEI35+BLl1OHEsrMGv/yeZy1pl6cc/ZsubhglY4=;
 b=E5mBIsA2nGP4hmm5Ez/4TnH/sVpESFl3jO/Wf2LKFnHQatNbeQEL3WA1NqRsQE3pDFf4kY
 IbgGCYhqxHJqvD4TZKqkIWMmKy+xLSc4SS83qp9dfsUQgN2SkERz1fAI1TeOTXrg6YE1KU
 krcEnQqD39+5BGyXYhPbC/Cy1mKOYHQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Z-owOjJ-OYWrK1AIzK5hXw-1; Thu, 09 Jul 2026 08:43:27 -0400
X-MC-Unique: Z-owOjJ-OYWrK1AIzK5hXw-1
X-Mimecast-MFC-AGG-ID: Z-owOjJ-OYWrK1AIzK5hXw_1783601006
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-473e18559b2so1371205f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783601006; x=1784205806; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LZx3yEI35+BLl1OHEsrMGv/yeZy1pl6cc/ZsubhglY4=;
 b=Lp6A4lEM/n9etqng4Pv7s+ocxqLxqL+Qx6YpaYbHIlQR6E0vRH03s/fhYjgACWs2Ri
 66yGnqp8Qg13t3X2enj0FlzVihsh9ty4zYP8AiQYFR3ycu0tukPxlKxnC3zfrL/hSwtN
 6ABwhB3i/BPUdXqbNCLfxK8sH8mfN5fu7cHKzYP2O9PHEopKHBZ1VQl0bRVIRMO8OLsz
 csN86XZAXwcgN7uHhYTD8KTlw3fE2WwBzN7Z8umyRLFjYH7JSl0FMYyQm+s7TJ2j/9ef
 L4NJx4amdXJ/4NQhXq/uGZAmIY5VCEe11Rp8WyyTIuoxfFho0L1itsiGpaiY8KKxAEbx
 z7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601006; x=1784205806;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZx3yEI35+BLl1OHEsrMGv/yeZy1pl6cc/ZsubhglY4=;
 b=ARZz9I3gccq8+GRCRzcfyyicNwRukCPfSuex34GJ2JWfMtPcWK9pSabwngNaom7W55
 50/fVnUKLGfEp358GnUNDIYuu1zJFu7UHRgec3pH1jdaTgYWQ3JsrrPhuavxBTX2ZywV
 7qS6hDHTW3t0sEj0hccfq95LixXTQDamqPCXAxFmLCIw/q9qagkhP4YMV6SA/ylutQvl
 f3bKWX39DW4H1ftvyHwfjDp8HayX5aTs+erp3h2pri9UZxT4hklDgEy7qkG5Aqb20+py
 jG7wkdSj2CZmp/ihWfjc2c8i/zOwZfOSpiDYREtCH4UgdWDC6Pv83S0H60M/DxznxQ5d
 nLRw==
X-Gm-Message-State: AOJu0YyNoaGeaCUeN9RWdgqurliizUeem185iZ7xP/QDb+GxJNexGUMw
 1JjFXScYCGOluSlxJXLNg4VSqJTWeFa6V/I+CYsOu3b1KB5jaTzadXU3+UwvA8+a1K9NjO7LPDZ
 LiEMBX/f7eB0rjG1ZGsXpSl+EW0ePVkNjYG9puy7sIjGT72YJnUNjbyD4m8eXkdpr
X-Gm-Gg: AfdE7cmWQcprP3rDLFXuLv7fHI2iAAus7cBFU+9ITMACmzBxWn+b4fj60knquSdEneB
 Vt53ZZCWz8zIXHzmkPb0+jhiOUntpBfZEAbU/aHflXFXa00el2uqmq8lSQq6HFTzp4gL0SMGOvC
 c7qVWRB3sy5Pxla+qZ4Nv1ruCicTeFJfxn39p07TPduQqGcUEofahj11AWpgaVYHF5IPB89CYl+
 +9qLS+dKPwMeALFre16xD86//t6JKPUe83UhVfcWYvt1WybOhRKlTxRv39ipujBeGjxHaB1aBLv
 /6k1bvLF0C65u0PoF7QbAgzs7SU5HwlNze7/rWHjv9JWilsbIFw/OS5xSCpAZJp4j32TKBtpMTL
 iZuYn4Hek+yvPg95QFlSntNndFm6pZncN
X-Received: by 2002:a5d:59c1:0:b0:475:f0f0:9ec9 with SMTP id
 ffacd0b85a97d-47df08147d6mr8052656f8f.52.1783601006015; 
 Thu, 09 Jul 2026 05:43:26 -0700 (PDT)
X-Received: by 2002:a5d:59c1:0:b0:475:f0f0:9ec9 with SMTP id
 ffacd0b85a97d-47df08147d6mr8052622f8f.52.1783601005550; 
 Thu, 09 Jul 2026 05:43:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm52177371f8f.26.2026.07.09.05.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:43:25 -0700 (PDT)
Date: Thu, 9 Jul 2026 08:43:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: validate split queue head count before popping
Message-ID: <20260709084105-mutt-send-email-mst@kernel.org>
References: <20260709100529.41267-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709100529.41267-1-physicalmtea@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 09, 2026 at 06:05:29PM +0800, Jia Jia wrote:
> virtqueue_split_pop() reads the next split avail ring entry after
> virtio_queue_empty_rcu() reports work. Call virtqueue_num_heads() before
> consuming that entry, so an avail index distance larger than the queue
> size is rejected.
> 
> virtqueue_num_heads() also keeps the read barrier needed before the avail
> ring entry is read.
> 
> This prevents an invalid split queue state from being expanded into
> repeated device command processing.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/issues/3930
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
> Tested with qemu-system-x86_64 11.0.50, built from origin/master
> f893c46c3931 plus this patch, configured with:
>   --target-list=x86_64-softmmu --enable-kvm --disable-tcg
> 
> The original virtio-iommu live-vring qtest reproducer used for the
> report completed successfully on the patched build without host OOM,
> confirming that this reproducer is fixed by the patch.
> 
>  hw/virtio/virtio.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index f4d86a3655..252bff8641 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1751,9 +1751,11 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>      if (virtio_queue_empty_rcu(vq)) {
>          goto done;
>      }
> -    /* Needed after virtio_queue_empty(), see comment in
> -     * virtqueue_num_heads(). */
> -    smp_rmb();
> +
> +    rc = virtqueue_num_heads(vq, vq->last_avail_idx);
> +    if (rc <= 0) {
> +        goto done;
> +    }


Do we still need virtio_queue_empty_rcu then? Why?

>      /* When we start there are none of either input nor output. */
>      out_num = in_num = elem_entries = 0;
> -- 
> 2.34.1


