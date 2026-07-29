Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C25DC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp2kn-0004vK-US; Wed, 29 Jul 2026 07:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp2kg-0004v1-EA
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp2kb-0004fo-G2
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785325622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5C13yGT+gJyh/ixZyqAFvEuCXJTGdr0IGsEzSjACUU=;
 b=i/0eh2D0uqeK7sTFti6dZmou1dSTLqbRfk4zNtI5VGyvHHFlToWw1+G8CiY3YeMyONpNts
 o+VD70tXOynC0xp+VtH2bv2kgQTTKkpqnDK2kiT3i0SDdz27p4n1zkvacU/BetCerA+tDn
 ZtsgHyqeUi9g1JLQyIx6RMZ2x6LNIBc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-pKAMlDauN8S-i7vXwQW9Gw-1; Wed, 29 Jul 2026 07:47:01 -0400
X-MC-Unique: pKAMlDauN8S-i7vXwQW9Gw-1
X-Mimecast-MFC-AGG-ID: pKAMlDauN8S-i7vXwQW9Gw_1785325620
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f6db77430so592921f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785325620; x=1785930420; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t5C13yGT+gJyh/ixZyqAFvEuCXJTGdr0IGsEzSjACUU=;
 b=rVTJPd4HxL0aUIwYmHsgXHW9WQYXfLC6LvVvryEQJReAbUVFs4SBONSTJHTCnDx6gc
 dg+2Vc4ZcFg73VsyIXCvOQjDBsmv96NJj4K0rY4urM5PBhQbGUSt6Jlji/dBee7rARh6
 jkcYr4dNAv+il9FBu3CNnqsWFG4FEc3BH01BFf0RwinW/pz9JpCf+OHti3p+NG9Ex3zg
 7vd47tuGJlXRWZa93mw8qWkfj4N20F0CbF1Fqxjabn9VwQ4ye1jyM1H7FaJxcDtF4sli
 gSPWNFg/EBjanYGgO8uwms4GzCWkD06CQyGISZJX554HlG2iqACRO9vkWc3jp3grnWoc
 DiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785325620; x=1785930420;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t5C13yGT+gJyh/ixZyqAFvEuCXJTGdr0IGsEzSjACUU=;
 b=O379kf02gEjfwIOs2qJJJBqw/Gzd9TBxn4ltUqRwK6gd6FYbTNLZ6Vtxr2FkYp41ve
 Ixsitdu5SCICMxpbtOZEagzTh+3ghx6HGD6aDq/ONQYwMAlzoRUK+RX8Olvq53dY8TGp
 9Zb6DzQAXdcAUnNTde6FHpvNYbeHiqPe2hTc9c+Hu44EKhR3g/2W7+QaispMoSAz4/rQ
 AzI5kPQtPQSSOrmsGlmjZk1nHn2e9coevUXwLPLp6N0Jq/ajhfQmgL+IkOqp/wxEB9MD
 o4QLzrMaPaq5vgs2ZkmaynJ8EB4V7JUh4m75QGHmokcGZe1jbw21yUryHyfGgolhKMY+
 NdMA==
X-Gm-Message-State: AOJu0YyBXXfP6eHF2Ic4HJM38hucofLduz9e6Cl0nqAG0/sPS4hSgTnl
 rCY7v/7rF9o9Enkx8pC+q6jMZtifd1ja0rOaV+3am4AKH63Q/WN8NnASBK8kJtJG2flf8X7tbwE
 TU035/5SDJVCfrVDHTkN7HIgGZgrac3r8MGG1N6X/sKrz83dmm6jHirUo
X-Gm-Gg: AR+sD11Bz1WKyGuqzyhp/sltTdOd5VsSJc2lechcg006Uz3SJLYA1fAX29Dy9BAZWRe
 pWFzkQIRhTqXnnUT6w2K8qZ7lgxP4bljl7yHEIIDUTbZqM1X3DWZtUpRk+WF0fywVO2+09KiDoH
 vlEyWY1SVi32WX1Tkn5B0sYTerEnyX/bFQwTgEm7N4WTTDjj4GMVNVgvv3nZlTlGrHKbKqihRE5
 fpEZH3KYfTzsPIlZDnuqrq+j56E9EtzGChkBaPNQ7TLoTsd5bQZOllO8c5hnlndtls2a6uNP7bV
 Cwipf3ySU6z93Jb31e7FugqcyDOTu9ncvJjQ9rYhU1mwr1tvH8drwonT6NXaPdixYXc0HxS/6JE
 dYNpgWPR49MT/V2+/NTEoYCY=
X-Received: by 2002:a5d:5d0b:0:b0:47f:80c3:92a0 with SMTP id
 ffacd0b85a97d-47fb1f13dffmr7819011f8f.29.1785325619593; 
 Wed, 29 Jul 2026 04:46:59 -0700 (PDT)
X-Received: by 2002:a5d:5d0b:0:b0:47f:80c3:92a0 with SMTP id
 ffacd0b85a97d-47fb1f13dffmr7818971f8f.29.1785325619036; 
 Wed, 29 Jul 2026 04:46:59 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6acbfb3sm7305501f8f.14.2026.07.29.04.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 04:46:58 -0700 (PDT)
Date: Wed, 29 Jul 2026 07:46:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com
Subject: Re: [PATCH v2] hw/virtio: reject inverted virtio-iommu IOVA ranges
Message-ID: <20260729074021-mutt-send-email-mst@kernel.org>
References: <20260729045037-mutt-send-email-mst@kernel.org>
 <20260729105247.1719595-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729105247.1719595-1-physicalmtea@gmail.com>
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

On Wed, Jul 29, 2026 at 06:52:47PM +0800, Jia Jia wrote:
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
> Fixes: fe2cacae2438 ("virtio-iommu: Implement map/unmap")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4104
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
> v2:
> - Drop migration-state validation and keep the existing post-load callback.
> 
>  hw/virtio/virtio-iommu.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
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


you do not need to move the delta assignment.


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
> -- 
> 2.34.1


