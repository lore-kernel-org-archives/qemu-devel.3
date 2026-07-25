Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD80C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 15:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wneNB-0005aH-H1; Sat, 25 Jul 2026 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wneN6-0005Z7-HS
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 11:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wneN4-0006ri-GU
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 11:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784993580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LUaNHwQ6YYFTN6d8k96j/AfC3nXZInV96Ov3LbNxtzA=;
 b=eDBUhbwXc4e/7Ltmzwyg4qYN6qd3AyxEtYmqaUEixj4QOJ6H8mUnnimpS5QObiU+jocznw
 ybHd/EUEMn0OO/BtN8e7HRRTyNqVoBn1EeOGXyYlPYkovDAS/Vo5xXov40lX9wAA0ln12Z
 dThxlinEAfKgSu0BHj87tM3YkuRHr5Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-HM_eFetjPXOfGHB9hzGTGw-1; Sat, 25 Jul 2026 11:32:58 -0400
X-MC-Unique: HM_eFetjPXOfGHB9hzGTGw-1
X-Mimecast-MFC-AGG-ID: HM_eFetjPXOfGHB9hzGTGw_1784993577
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-475e540a0ffso725531f8f.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784993577; x=1785598377; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LUaNHwQ6YYFTN6d8k96j/AfC3nXZInV96Ov3LbNxtzA=;
 b=IezI4GXnief5VFjvOezJ55z3OmsDnzBuQiKYuTtK1/BrEEbHuoT+a5N5LnG+zOXs1L
 Fy2dH/wpSB06UKl9aGrmH2aurhfhspi7Dy1MWCTKhHIRBWhNo34rLNgmH+hn+fzny35b
 6FGzoLpCNf1r6U8ldy8hqrNurzZBjjiiognR0OOQ8GphPV/wp41mV752v/hItEp8vQnU
 IqcxoTIfzUZgcLoleNH7iTau1UmNtTXptWp87MBqdVr6PBpaXh+8a3s2w1wSYyJN1ED4
 Yh06x223eZDiog+VWcC0GrdogQczrU3xB+hYKPqoXIK/gV1gC6R/FHHrhoYC6H7yIat2
 s+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784993577; x=1785598377;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LUaNHwQ6YYFTN6d8k96j/AfC3nXZInV96Ov3LbNxtzA=;
 b=RQeWkaBLHXHfaWwU0KZtSHD7/7TjvwHmatE+cdrNATwhNprH9hLmiduLQXlvHrNU4y
 0FUGZTISBd+Rdbxxn30o21ra392h6oxXa6i27Eef/RRljmroRioqGbKIUOtiUa2Vkw+E
 Dxquw0Fx0k7pImdeDvMTPa/S4TQbqmIw4zxERthEaCk7byPIzwrLlOISeFJydL5JOl+/
 FSn7c89V6tqnpBW/pzJcnJhyMwDFSjBWWeaMYwUk1G2KSRhQ7k8aHeuHVU7PiAkZ0Whl
 SSTQ0+GpazWJ/ZOQtQYmDL9RHBSL1tn5eaZrQCqRgJVu5xQsr+4jTKnBsrPYZHntQPKH
 9Y1w==
X-Gm-Message-State: AOJu0YwVKaF0gAJk9P7rS+RBtou2RBD2W0l42YXh18x/Ku1DYhLN2+p+
 SnbnbB1bQxrVE3+XG2tsStbjVgOKII5NikU+u1RYO7lhhbQJkZwXtRHO1YjKPelY8jZ1bwW0HeH
 I1hFHuCwNMiJozk+5YHlS2zekmDQnIfy5GKaw5YEerm0oXjYI8t9MD6sH1Q6Ym8gr
X-Gm-Gg: AR+sD12Zth/t0UAbrwaA7FQmGGEa+pmgoRHz+QRdXYL7AOHZ1An2Ch76xBQFxMtb04c
 kQRilch0Jubf7h+7KnyDLYDKL8bK27i0W90Q3WoAadUPzyT0NKamq+sRRJN2S1+AkVfTFVx1/Yt
 /+nCX3mMbl25KOI7jS+rk8IrGVvvXFDT5RWdpKSe5qnUvoHNpKxc/v4SLKdAV8FrJZCxyhIXn/t
 HslGVwcqiCsejScROCbpUcaMrRJeVulHIip1qVjfUjwIpMy4BJiK7TZKjpcpiHHIzmRcSigNEH5
 y6IpC7ToGazgwuzIJPSkjnmZNLHfTXvNQTtlJ2lrhnlLds00TCctKieTFtOuJIN30ln4XXRn1xb
 VtxsBecjQVF2U1xj8tCqczq2PPLJQ45U=
X-Received: by 2002:a5d:5d86:0:b0:47f:8ed4:1337 with SMTP id
 ffacd0b85a97d-47f9feb26bdmr2969668f8f.46.1784993577354; 
 Sat, 25 Jul 2026 08:32:57 -0700 (PDT)
X-Received: by 2002:a5d:5d86:0:b0:47f:8ed4:1337 with SMTP id
 ffacd0b85a97d-47f9feb26bdmr2969648f8f.46.1784993576789; 
 Sat, 25 Jul 2026 08:32:56 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm32133868f8f.16.2026.07.25.08.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 08:32:56 -0700 (PDT)
Date: Sat, 25 Jul 2026 11:32:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] virtio: validate split queue head count before popping
Message-ID: <20260725112924-mutt-send-email-mst@kernel.org>
References: <20260710022025-mutt-send-email-mst@kernel.org>
 <20260710073517.13472-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710073517.13472-1-physicalmtea@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 10, 2026 at 03:35:17PM +0800, Jia Jia wrote:
> virtqueue_split_pop() reads the next split avail ring entry after
> checking that the ring is configured. Call virtqueue_num_heads() before
> consuming that entry, so an avail index distance larger than the queue
> size is rejected.
> 
> virtqueue_num_heads() also reports an empty queue and keeps the read
> barrier needed before the avail ring entry is read. Drop the now unused
> virtio_queue_empty_rcu() helper.
> 
> This prevents an invalid split queue state from being expanded into
> repeated device command processing.

We can summarize this as:

virtio: reduce code duplication for split ring

virtio_queue_empty_rcu duplicates virtqueue_num_heads
for no good reason, let's not do it. As a nice side effect,
we gain better handling for misbehaving guests.


> Link: https://gitlab.com/qemu-project/qemu/-/issues/3930


not sure this is very relevant.

> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
> v2:
> - Drop virtio_queue_empty_rcu() from the split pop path.
> - Keep only the existing !vq->vring.avail early exit before
>   virtqueue_num_heads().
> - Remove the now unused virtio_queue_empty_rcu() helper.
> 
> Tested with qemu-system-x86_64 11.0.50, built from origin/master
> f893c46c3931 plus this patch, configured with:
>   --target-list=x86_64-softmmu --enable-kvm --disable-tcg
> 
> The original virtio-iommu live-vring qtest reproducer used for the
> report completed successfully on the patched build without host OOM,
> confirming that this reproducer is fixed by the patch.
> 
>  hw/virtio/virtio.c | 30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index f4d86a3655..68ec3f0751 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -716,26 +716,6 @@ static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
>      return (avail != used) && (avail == wrap_counter);
>  }
>  
> -/* Fetch avail_idx from VQ memory only when we really need to know if
> - * guest has added some buffers.
> - * Called within rcu_read_lock().  */
> -static int virtio_queue_empty_rcu(VirtQueue *vq)
> -{
> -    if (virtio_device_disabled(vq->vdev)) {
> -        return 1;
> -    }

This check is no longer there. intentional?

> -
> -    if (unlikely(!vq->vring.avail)) {
> -        return 1;
> -    }
> -
> -    if (vq->shadow_avail_idx != vq->last_avail_idx) {
> -        return 0;
> -    }
> -
> -    return vring_avail_idx(vq) == vq->last_avail_idx;
> -}
> -
>  static int virtio_queue_split_empty(VirtQueue *vq)
>  {
>      bool empty;
> @@ -1748,12 +1728,14 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>      address_space_cache_init_empty(&indirect_desc_cache);
>  
>      RCU_READ_LOCK_GUARD();
> -    if (virtio_queue_empty_rcu(vq)) {
> +    if (unlikely(!vq->vring.avail)) {
> +        goto done;
> +    }
> +
> +    rc = virtqueue_num_heads(vq, vq->last_avail_idx);
> +    if (rc <= 0) {
>          goto done;
>      }
> -    /* Needed after virtio_queue_empty(), see comment in
> -     * virtqueue_num_heads(). */
> -    smp_rmb();
>  
>      /* When we start there are none of either input nor output. */
>      out_num = in_num = elem_entries = 0;
> -- 
> 2.34.1


