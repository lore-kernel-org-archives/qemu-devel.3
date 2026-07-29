Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C11FC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp02I-0006ex-FJ; Wed, 29 Jul 2026 04:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp02H-0006eb-9a
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp02F-0001av-CR
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785315186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tv6K40ZRYLXtDOO9k56dhSmeM2GbO4ttQZWVT8p8xvI=;
 b=VJRSSPE10iY0sMrdz4VqkQrwyR59pFJvmgB6QyvtS8xtByTgZGco1iv4TAaVxqA74ocvRf
 fXsTA8ytO4VsbaXprLaB1XNg/dP4nJE8A2mS7GW23vp0vyeFSuc+rNzoVRMkwqPjDbIAsH
 jONV9qeTyUNzlOUOWgWDt/34iIgTD4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-2TswCvqHNymlzNdme-JoLg-1; Wed, 29 Jul 2026 04:53:04 -0400
X-MC-Unique: 2TswCvqHNymlzNdme-JoLg-1
X-Mimecast-MFC-AGG-ID: 2TswCvqHNymlzNdme-JoLg_1785315183
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47485fde05aso498271f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785315183; x=1785919983; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tv6K40ZRYLXtDOO9k56dhSmeM2GbO4ttQZWVT8p8xvI=;
 b=GidYwdbWIDIJJv5aaXLLrWqMRgIeXVt+d/WFuzLNxW1fu2GWz5FW9o92PoxI8LHxkR
 7tqlAuGysnA+h8/Ykb9gPaFO0ITyA2sPV2ozCmmYWTopv2ePBl9vl6sYiaswLmnkTpLW
 Ea/dTm7ZgvJL0sLFQw9k3mW/WCAkgmQHy1wEY8swzy0mZDZr6Rgu3kenZyVUbnHQ4w88
 +RO6ckavYyTv8ulY2ZWp0iI6qjvztvEztRkq26x8UiM7H08Mx1pU3vFSR7qbSudB/jN9
 c2JDj/V+L6+qRMpIQ6DzBAfQ18yypCUdsus0uoKcl03E0l/8Bt7ydUTWGEUDrxXOOzlP
 okCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785315183; x=1785919983;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tv6K40ZRYLXtDOO9k56dhSmeM2GbO4ttQZWVT8p8xvI=;
 b=RdFOzkoUJOoT88pkDBUk+unRi1azy14MG2GlU6NZzNB88Sj3AQAqFUZ4nZWbn/5hI3
 eZwRb7snik9opYwxMrYL1mc392l5oM+6vCq+tVs+9kYRw3C/uEx8af44ZALJJRDI3vZ8
 n2HW39YK223ArgQ2BSeUBZZJRmo/Uj/ZlWvidl5aDrrDR2kNdZ3hW6dX8h6r9LQlhith
 A3M5Dyfxe6Z2Wgr2/Yz3xIp2Rg4MT0cwybxfEqwCP7ZWmHp1VMUF+bIoHT72nsGJ1G3O
 eU1X63FFK3xCgIxHAsHGIpB4NEpblsmTeH4atJgPnuPotdHu9Acg9zlcQMUQVplUKw6u
 eLBQ==
X-Gm-Message-State: AOJu0YxOIkC83Smcz1uPldqBMkWIW5GeZqEhzQ/iAnYC2SLoFPgGFoxO
 lRV4QZHAQEp4yLAFnPPSFVYS/+SspkS52LE0QWApZsG4yV2TeDTRerScc6sHYTUUFUOrCgcaiH2
 ZiWuuWA1AxXqzRKkN8p6ciP6MCcvHMuG2avfkBjnLIhMmIKtUXt8O5qUH
X-Gm-Gg: AR+sD13rlJZaggMYEYMr5rRh9r6PUI/yIdr9uR3MZ7MZS/6qS2RhBsYHj5wT9sdNEvM
 iPSnIFSO7EYmCvsAnk8deop/Nh4kPSZH1Y3E7MFUPfFrcof1rQ4ZS0hLLYF+SwhV4pbB2byS9cA
 6WIPGWD2qWe3rN3pjsZuw56KjxGy9X8nrsJdTOuQ4se3A6qUDlm0Wj6Et717jtLhoQHSZ1qPuqi
 +iwCKLyqhonn5jTv15GW5sH/M73YvTpC953uhmw9sw1kakdn46Pgnegl5FCoEma0QY45sXl4vuM
 43IU1O8dka/SXuk5s3mf9y7o1Stg2wygNPDDB5JCKA/AD8FMYmjl61P2r3a3gD6cTyAq5OGudL7
 75yoOjdi5EWvs/ifi5dWCpfQ=
X-Received: by 2002:a05:6000:2010:b0:47f:949e:1c17 with SMTP id
 ffacd0b85a97d-47fb1f17d09mr6889665f8f.44.1785315183350; 
 Wed, 29 Jul 2026 01:53:03 -0700 (PDT)
X-Received: by 2002:a05:6000:2010:b0:47f:949e:1c17 with SMTP id
 ffacd0b85a97d-47fb1f17d09mr6889619f8f.44.1785315182720; 
 Wed, 29 Jul 2026 01:53:02 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0ee81sm6459799f8f.17.2026.07.29.01.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 01:53:02 -0700 (PDT)
Date: Wed, 29 Jul 2026 04:52:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com
Subject: Re: [PATCH] hw/virtio: reject inverted virtio-iommu IOVA ranges
Message-ID: <20260729045037-mutt-send-email-mst@kernel.org>
References: <20260729065153.1718783-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729065153.1718783-1-physicalmtea@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Wed, Jul 29, 2026 at 02:51:53PM +0800, Jia Jia wrote:
> Guest MAP and UNMAP requests can set virt_end below virt_start. Since
> virt_end is inclusive, this is not a valid interval. MAP nevertheless
> stores it in domain->mappings, but interval_cmp() assumes low <= high.
> For an inverted key, interval_cmp(key, key) returns -1. A covering UNMAP
> can therefore find the key but fail to remove it and repeat forever while
> holding s->mutex.
> 
> Reject inverted request ranges with VIRTIO_IOMMU_S_INVAL and make the
> notifier range decomposition skip invalid ranges. Keep the existing
> notifier-before-remove ordering, but return VIRTIO_IOMMU_S_DEVERR if
> g_tree_remove() fails.
> 
> State produced by an older QEMU can still carry such a key over
> migration. Reconstruct endpoints first so failed loads can be cleaned up by
> the normal reset and unrealize paths. Validate every mapping before switching
> address spaces or scheduling command processing, and reject invalid migration
> state.
> 
> Fixes: fe2cacae2438 ("virtio-iommu: Implement map/unmap")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4104
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

I'm fine with rejecting this to make debugging such issues easier, but
worrying about migrating from qemu with this is IMHO not worth it.


> ---
>  hw/virtio/virtio-iommu.c | 77 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 533bd5073f..b7145c8277 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -210,7 +210,13 @@ static void virtio_iommu_notify_map_unmap(IOMMUMemoryRegion *mr,
>                                            IOMMUTLBEvent *event,
>                                            hwaddr virt_start, hwaddr virt_end)
>  {
> -    uint64_t delta = virt_end - virt_start;
> +    uint64_t delta;
> +
> +    if (virt_end < virt_start) {
> +        return;
> +    }
> +
> +    delta = virt_end - virt_start;
>  
>      event->entry.iova = virt_start;
>      event->entry.addr_mask = delta;
> @@ -807,6 +813,10 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>          return VIRTIO_IOMMU_S_INVAL;
>      }
>  
> +    if (virt_end < virt_start) {
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +
>      domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
>      if (!domain) {
>          return VIRTIO_IOMMU_S_NOENT;
> @@ -857,6 +867,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>  
>      trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
>  
> +    if (virt_end < virt_start) {
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +
>      domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
>      if (!domain) {
>          return VIRTIO_IOMMU_S_NOENT;
> @@ -879,7 +893,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>                  virtio_iommu_notify_unmap(ep->iommu_mr, current_low,
>                                            current_high);
>              }
> -            g_tree_remove(domain->mappings, iter_key);
> +            if (!g_tree_remove(domain->mappings, iter_key)) {
> +                ret = VIRTIO_IOMMU_S_DEVERR;
> +                break;
> +            }
>              trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
>          } else {
>              ret = VIRTIO_IOMMU_S_RANGE;
> @@ -1639,12 +1656,62 @@ static gboolean reconstruct_endpoints(gpointer key, gpointer value,
>      return false; /* continue the domain traversal */
>  }
>  
> -static int iommu_post_load(void *opaque, int version_id)
> +typedef struct VirtIOIOMMUMappingValidation {
> +    bool valid;
> +    uint32_t domain_id;
> +    uint64_t low;
> +    uint64_t high;
> +} VirtIOIOMMUMappingValidation;
> +
> +static gboolean virtio_iommu_validate_mapping(gpointer key, gpointer value,
> +                                              gpointer data)
> +{
> +    VirtIOIOMMUInterval *interval = key;
> +    VirtIOIOMMUMappingValidation *validation = data;
> +
> +    if (interval->high < interval->low) {
> +        validation->valid = false;
> +        validation->low = interval->low;
> +        validation->high = interval->high;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static gboolean virtio_iommu_validate_domain_mappings(gpointer key,
> +                                                      gpointer value,
> +                                                      gpointer data)
> +{
> +    VirtIOIOMMUDomain *domain = value;
> +    VirtIOIOMMUMappingValidation *validation = data;
> +
> +    validation->domain_id = domain->id;
> +    g_tree_foreach(domain->mappings, virtio_iommu_validate_mapping,
> +                   validation);
> +    return !validation->valid;
> +}
> +
> +static bool iommu_post_load_errp(void *opaque, int version_id, Error **errp)
>  {
>      VirtIOIOMMU *s = opaque;
> +    VirtIOIOMMUMappingValidation validation = {
> +        .valid = true,
> +    };
>  
> +    /* Rebuild ownership before validation so failed loads can be cleaned up. */
>      g_tree_foreach(s->domains, reconstruct_endpoints, s);
>  
> +    g_tree_foreach(s->domains, virtio_iommu_validate_domain_mappings,
> +                   &validation);
> +    if (!validation.valid) {
> +        error_setg(errp,
> +                   "virtio-iommu: invalid migrated mapping in domain %u: "
> +                   "[0x%" PRIx64 ", 0x%" PRIx64 "]",
> +                   validation.domain_id, validation.low, validation.high);
> +        return false;
> +    }
> +
>      /*
>       * Memory regions are dynamically turned on/off depending on
>       * 'config.bypass' and attached domain type if there is. After
> @@ -1657,14 +1724,14 @@ static int iommu_post_load(void *opaque, int version_id)
>          timer_mod(s->cmd_timer,
>                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
>      }
> -    return 0;
> +    return true;
>  }
>  
>  static const VMStateDescription vmstate_virtio_iommu_device = {
>      .name = "virtio-iommu-device",
>      .minimum_version_id = 2,
>      .version_id = 2,
> -    .post_load = iommu_post_load,
> +    .post_load_errp = iommu_post_load_errp,
>      .fields = (const VMStateField[]) {
>          VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
>                                     &vmstate_domain, VirtIOIOMMUDomain),
> -- 
> 2.34.1


