Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C33EF48C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruQr-0001xb-BQ; Mon, 16 Feb 2026 03:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vruQn-0001xN-Ic
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vruQk-0003St-QV
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771232288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qPkKlFLN1DWiTfpVaxSEdHmP9UKP70+z6xPfERyxxKY=;
 b=N+vIqos4XXb525IUqZpvKeQJViyw8h7oNe4nl+sEEZ7Dw8hJPae7ocvTijaFJ0owHGqvSn
 7+HEpOHt7GP3GhuzYU+upHMCqLPKPoS93uZsbUXXhrNGY12snrJ++jeMwvF5i5dbcy9Hab
 hD+hdooXpw61C7HFqZg5Ok2A0zvFpQg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-KIDJrApDOdeTbZLPg2Ef7Q-1; Mon, 16 Feb 2026 03:58:06 -0500
X-MC-Unique: KIDJrApDOdeTbZLPg2Ef7Q-1
X-Mimecast-MFC-AGG-ID: KIDJrApDOdeTbZLPg2Ef7Q_1771232286
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4376e25bb4dso3531113f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771232285; x=1771837085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qPkKlFLN1DWiTfpVaxSEdHmP9UKP70+z6xPfERyxxKY=;
 b=F6qUFb2ieo3WM0ojvBbPzukBzfbKm9qXPFp3SHhN1mdxeR7TTa5mxeVwfcuNFUzdES
 37e/ibdUqR5BaJNgJo0rFLy61Gmdim1TqPx2P9P1WF8x1HqhQsQmTxtAbwhEmXyQDaco
 nP62cfIj+oiDM4U5NlKZ1xyR3zks75ujbezrybrRebfrs2tawEfZtVyushYlz1cdmme5
 FWs9QXkDEFMgb9nhIaC0sAhIsOt2hW816GFZMpb/2meAJuHiLv8oH1H17aGzXhro+Frd
 ov5QdGzbyZzdAYyii02m7HfHp4hvxCyyspOJFIlfCl1pJrPqDDNDLA8kXvAjHTBQDzLQ
 QDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771232285; x=1771837085;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPkKlFLN1DWiTfpVaxSEdHmP9UKP70+z6xPfERyxxKY=;
 b=Ky86zD9vqs/RZV+zUdeMtqrb1MAm41Ojxvc1cQo0HpjUWmGokKgr4lTFgVR6+QkYsu
 ipFrhO8dv5H44Bm+DBe/y/T0hBKYUG3v4wA/G1fOqCHq5E4r4dRlVSy5rHktl/AV4XMg
 34HQFyJ7iSMTJtP8Jlxnl2QRk+YUxex707ac1WHsqk+wN2pLt8h+/4wvRi3v/iqglaIv
 rgWWVoKa/+lHlTMeYtfedOIwxqw0Iy1ibWaU2uvb8xh9ulcu0Qwbx0RupEitc9vlDb0O
 7O3mvZlpV7OHBgloiLnkTslh93/4ucjEEH+xkMrrUYeL+Wz78yKE2sD9Gya4L0vPpGrB
 pLVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPCscTkZuk3tPaP1sOajBWN2VVt4UBWws6GGNs2QqQBZSBfWJtESigU0v5+8d2vkq40+N/JFh3a8W+@nongnu.org
X-Gm-Message-State: AOJu0YzkLOL+ZCQOuQGdeYl9WpDqfqmIEgH3uutt63KVUTJAmHQM4Ptp
 5arTqPMEY699lNGZQFG+QUiIBcd77Em9bA8HqM/aZeoLRVLjOYVQU5JEr3ulVbQf100jns1YZNm
 N3oWOzQLFoYY4qwdIwc2BULNH42g59mdqJ8sWfOGo1ySwbARoXHfRvymu
X-Gm-Gg: AZuq6aImTROAvcHUoC18fndScjAZ88sEA4OdDM1SMYjEErzb5fAGBK+OdXFP31CWx/T
 MLq2gB/4O36eKd5UJomjn3n2hy6n4igcSJfTH+4UqVlVaqdTQwkP/+YL+2l73rpwV3EykutxxdC
 QkVcNkYrU5KW9nR8d2h05G0GTx73mjKHyT9DgI7lCCqMnygruU4BWflQHLOAAcYTQ0fMIkgFJNX
 4cEgbeZTM+HKpaRwv+/99iRwSYfY7oFUO5nCky7s0ZNbYvCTLhvLQE6WFXsXjGDKq8ZVGlGD68y
 mq+KDnvsKoMmquIgcJwfny/fyO5VgbO6krJ/Nxalt+CrEUzxflybSQM7kUlWXinzh8KtQD3UccD
 dvsIby2EO3tr+6i2zTSxaoxt7ffPO131YTCykcrYyeqZ6AhLp0Z7ASi9PwebR
X-Received: by 2002:a05:6000:603:b0:435:9d70:f299 with SMTP id
 ffacd0b85a97d-43796ac2063mr16518573f8f.22.1771232285540; 
 Mon, 16 Feb 2026 00:58:05 -0800 (PST)
X-Received: by 2002:a05:6000:603:b0:435:9d70:f299 with SMTP id
 ffacd0b85a97d-43796ac2063mr16518536f8f.22.1771232285097; 
 Mon, 16 Feb 2026 00:58:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abd793sm25467351f8f.25.2026.02.16.00.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 00:58:04 -0800 (PST)
Message-ID: <b0c45e8f-8a84-44a4-a813-31dfaa02dbf2@redhat.com>
Date: Mon, 16 Feb 2026 09:58:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/vfio: sort and validate sparse mmap regions by
 offset
To: ankita@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, alex@shazbot.org
Cc: aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, zhiw@nvidia.com, mochs@nvidia.com, kjaju@nvidia.com,
 qemu-devel@nongnu.org
References: <20260215084950.4657-1-ankita@nvidia.com>
 <20260215084950.4657-2-ankita@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260215084950.4657-2-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 2/15/26 09:49, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Sort sparse mmap regions by offset during region setup to ensure
> predictable mapping order, avoid overlaps and a proper handling
> of the gaps between sub-regions.
> 
> Add validation to detect overlapping sparse regions early during
> setup before any mapping operations begin.
> 
> The sorting is performed on the subregions ranges during
> vfio_setup_region_sparse_mmaps(). This also ensures that subsequent
> mapping code can rely on subregions being in ascending offset order.
> 
> This is preparatory work for alignment adjustments needed to support
> hugepfnmap on systems where device memory (e.g., Grace-based systems)
> may have non-power-of-2 sizes.
> 
> cc: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>   hw/vfio/region.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index ab39d77574..177494c379 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -149,6 +149,19 @@ static const MemoryRegionOps vfio_region_ops = {
>       },
>   };
>   
> +static int vfio_mmap_compare_offset(const void *a, const void *b)
> +{
> +    const VFIOMmap *mmap_a = a;
> +    const VFIOMmap *mmap_b = b;
> +
> +    if (mmap_a->offset < mmap_b->offset) {
> +        return -1;
> +    } else if (mmap_a->offset > mmap_b->offset) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
>   static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>                                             struct vfio_region_info *info)
>   {
> @@ -182,6 +195,34 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>       region->nr_mmaps = j;
>       region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
>   
> +    /*
> +     * Sort sparse mmaps by offset to ensure proper handling of gaps
> +     * and predictable mapping order in vfio_region_mmap().
> +     */
> +    if (region->nr_mmaps > 1) {
> +        qsort(region->mmaps, region->nr_mmaps, sizeof(VFIOMmap),
> +              vfio_mmap_compare_offset);
> +
> +        /*
> +         * Validate that sparse regions dont overlap after sorting.

dont -> don't

> +         */
> +        for (i = 1; i < region->nr_mmaps; i++) {
> +            off_t prev_end = region->mmaps[i - 1].offset +
> +                             region->mmaps[i - 1].size;
> +            if (prev_end > region->mmaps[i].offset) {
> +                error_report("%s: overlapping sparse mmap regions detected "
> +                             "in region %d: [0x%lx-0x%lx] overlaps with [0x%lx-0x%lx]",
> +                             __func__, region->nr, region->mmaps[i - 1].offset,
> +                             prev_end - 1, region->mmaps[i].offset,
> +                             region->mmaps[i].offset + region->mmaps[i].size - 1);
> +                g_free(region->mmaps);
> +                region->mmaps = NULL;
> +                region->nr_mmaps = 0;
> +                return -EINVAL;
> +            }
> +        }
> +    }
> +
>       return 0;
>   }
>   
> @@ -213,11 +254,13 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>   
>               ret = vfio_setup_region_sparse_mmaps(region, info);
>   
> -            if (ret) {
> +            if (ret == -ENODEV) {
>                   region->nr_mmaps = 1;
>                   region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
>                   region->mmaps[0].offset = 0;
>                   region->mmaps[0].size = region->size;
> +            } else if (ret) {
> +                return ret;
>               }
>           }
>       }


