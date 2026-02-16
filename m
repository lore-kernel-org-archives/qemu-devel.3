Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E6BEF48D2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 09:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrupX-0007SX-V9; Mon, 16 Feb 2026 04:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vrupV-0007SE-Tv
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:23:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vrupT-0000lE-KW
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771233821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lzf4lWOhPOHWvHPPyz1GhUtgMp03D/cUtr0z3/mVhVw=;
 b=jUbWRVbd99gIBCFI+E+Z0TPpAI96TEDSyWxmC9Zd7Snv3EgAAWra0Lnj4Hjr/vbY0qM3kj
 E3d9QE9uXiLVEJljRzm2R1x/HBsT0MDSnKZAQOKz7hv5KaQANthPg7lVLPhhkqikLqpif5
 tna3B3n6kqmdgVXtgDf1u/dErconjBY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Crom3xLmM5-k2mPUG8vkVw-1; Mon, 16 Feb 2026 04:23:40 -0500
X-MC-Unique: Crom3xLmM5-k2mPUG8vkVw-1
X-Mimecast-MFC-AGG-ID: Crom3xLmM5-k2mPUG8vkVw_1771233819
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435991d4a3aso1698795f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 01:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771233819; x=1771838619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lzf4lWOhPOHWvHPPyz1GhUtgMp03D/cUtr0z3/mVhVw=;
 b=OJz6fWqlUrzae/1UghrZYjpXsr//QqVfnbZxflU0CXJT2jPUVXW31tn6AGWMCUkXnj
 CpSzwpxtc7jB03YrxoZ08HEfmm6HVWCMhr3JRhqeUHTeRukymQycrb/L/XCrEIkahYWW
 qXebiHB9Dvl0Z6ZIl8NuZ0Um/HuTBs6WAVM2K96FZky9fGeB0R/1QqZoBojyu9W6aUFL
 rHv+g0CgzkNlVBnpClkjw4dT+LRUXgwaa/kUo1UhScyJdQYsXtGMDOESoWEuRIexk/zP
 jFbcIV3Xy15FPVOQASP77goPiyyg5qmA5BrFq/8ZB0+GeLAwDpq11uJ9Zx8SWV0eZ+Ks
 m2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771233819; x=1771838619;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzf4lWOhPOHWvHPPyz1GhUtgMp03D/cUtr0z3/mVhVw=;
 b=I/hDkroDI+HF/YjzFac3f8jQohf3MgpOuV5ErmvHxYHokUOawzFbgfs2ioLS5BkbCP
 Ug1xYYvUCirs0wnw1ghHWWKyrvTH29MtTS3ozxrAp/sxRA7Rhf7MbW3akFsXLxFwxGsY
 CSXuoTRabpDD+3OlyTYXoXbjX8o4uGGasQDRkY7sBE66+6yYfi7Gfx3ziZZ2XC1FHSas
 inK9UR73nbG5d8coYjB5G1jMO44vMXF/HVe6zDaGKg0cg4uuVlpRGiMlF3giaAC7DDM9
 yw374VFgTJjpagnRynxTYHYhg3hKNAApn/0b4afRJ5x35paDiUImcp/xkMEDIzf7KroR
 VF+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNLEXitZXRcrVTbDphfMG6akE7YnYwPcMNAhMfI5xp8a7BZGtRQOGLnxb1pRetNdxZTtlYxSftPz/X@nongnu.org
X-Gm-Message-State: AOJu0Yzi8OOUe4zSc8HYScp9o8+mBKlOM2sfmPjnK5Jb2NwFnvUVHEJd
 g4ULe6nxCUH1nQDzvLtGgZNOHOLQI8epLogVi+AyEo96CTkAoq4YLousUK1Y63JfbZXwzyxJsTM
 eBGghj0Hm676XUHTUiZ1TiIDO2uQwpW2WDcSef9Uj6/pHKJcBdkrJ5UUb
X-Gm-Gg: AZuq6aJF7u0oPXjZ82lBNboK41Eq/eVpCKRqAuXhUPxB29v8USV0hlBQxzsViN1398d
 144K8G43LfxB6FM7s9VQeqVYzHQJcEYOutAotlLxNH4Ak4ju4rXgP2iTWZkYuG4qbSMlSt6jS/u
 wHtn+1gW00W8cvZ/xxaApqWTY/xHxNYK2ocONkqy8EKLuHF2Gg0OSCN/pQ3bSFmMB4yJkeGHE1z
 DGAsTrW7x2CeZ96aIikMg9O4k7FXDiKwUsVLxjKoSnrH5hjbJIrSg8Pzfi9d3HVoU5m2YoMNjn2
 6TzU1ZKZ10Mse/Te4e7wXscT0rsgSzNc7Wp55SiAjkj8yPwPHinJKm9wEMuGlMF1I05vnGLBleI
 mvWrcJfpgBvl5N/eqLxPdaSgqCgLJLUIQjkvyMZgsE/rI7Qhq0wheO61VumHD
X-Received: by 2002:a05:6000:2313:b0:437:6625:d0d7 with SMTP id
 ffacd0b85a97d-43797917d9amr19497782f8f.42.1771233818755; 
 Mon, 16 Feb 2026 01:23:38 -0800 (PST)
X-Received: by 2002:a05:6000:2313:b0:437:6625:d0d7 with SMTP id
 ffacd0b85a97d-43797917d9amr19497738f8f.42.1771233818243; 
 Mon, 16 Feb 2026 01:23:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm27998153f8f.28.2026.02.16.01.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 01:23:37 -0800 (PST)
Message-ID: <d4d9dbc7-12f2-4413-863a-02dcc68ed8b1@redhat.com>
Date: Mon, 16 Feb 2026 10:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/vfio: align mmap to power-of-2 of region size
 for hugepfnmap
To: ankita@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, alex@shazbot.org
Cc: aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, zhiw@nvidia.com, mochs@nvidia.com, kjaju@nvidia.com,
 qemu-devel@nongnu.org
References: <20260215084950.4657-1-ankita@nvidia.com>
 <20260215084950.4657-4-ankita@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260215084950.4657-4-ankita@nvidia.com>
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
> On Grace-based systems such as GB200, device memory is exposed as a
> BAR but the actual mappable size is not power-of-2 aligned. The
> previous algorithm aligned each sparse mmap area based on its
> individual size using ctz64() which prevented efficient huge page
> usage by the kernel.
> 
> Adjust VFIO region mapping alignment to use the next power-of-2 of
> the total region size and place the sparse subregions at their
> appropriate offset. This provides better opportunities to get huge
> alignment allowing the kernel to use larger page sizes for the VMA.
> 
> This enables the use of PMD-level huge pages which can significantly
> improve memory access performance and reduce TLB pressure for large
> device memory regions.
> 
> With this change:
> - Create a single aligned base mapping for the entire region
> - Change Alignment to be based on pow2ceil(region->size), capped at 1GiB
> - Unmap gaps between sparse regions
> - Use MAP_FIXED to overlay sparse mmap areas at their offsets
> 
> Example VMA for device memory of size 0x2F00F00000 on GB200:
> 
> Before (misaligned, no hugepfnmap):
> ff88ff000000-ffb7fff00000 rw-s 400000000000 00:06 727                    /dev/vfio/devices/vfio1
> 
> After (aligned to 1GiB boundary, hugepfnmap enabled):
> ff8ac0000000-ffb9c0f00000 rw-s 400000000000 00:06 727                    /dev/vfio/devices/vfio1
> 
> Requires sparse regions to be sorted by offset (done in previous
> patch) to correctly identify and handle gaps.

Please add a visible comment saying that vfio_region_mmap() assumes
that the array mmap[] is sorted. May be before the loop :

    for (i = 0; i < region->nr_mmaps; i++) {
    ...

Or some other place, but it should be clear.

     /*
      * Regions should already be sorted by vfio_setup_region_sparse_mmaps().
      * This is critical for the algorithm below which relies on ascending
      * order.
      */

Thanks,

C.

> 
> cc: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>   hw/vfio/region.c | 81 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 54 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index b83b09fa2f..51523a33b1 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -344,8 +344,11 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
>   
>   int vfio_region_mmap(VFIORegion *region)
>   {
> -    int i, ret, prot = 0;
> +    void *map_base, *map_align;
>       Error *local_err = NULL;
> +    int i, ret, prot = 0;
> +    off_t map_offset = 0;
> +    size_t align;
>       char *name;
>       int fd;
>   
> @@ -356,41 +359,56 @@ int vfio_region_mmap(VFIORegion *region)
>       prot |= region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0;
>       prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
>   
> -    for (i = 0; i < region->nr_mmaps; i++) {
> -        size_t align = MIN(1ULL << ctz64(region->mmaps[i].size), 1 * GiB);
> -        void *map_base, *map_align;
> +    /*
> +     * Align the mmap for more efficient mapping in the kernel. Ideally
> +     * we'd know the PMD and PUD mapping sizes to use as discrete alignment
> +     * intervals, but we don't. As of Linux v6.19, the largest PUD size
> +     * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
> +     * on x86_64).
> +     *
> +     * Align by power-of-two of the size of the entire region - capped
> +     * by 1G - and place the sparse subregions at their appropriate offset.
> +     * This will get maximum alignment.
> +     *
> +     * NB. qemu_memalign() and friends actually allocate memory, whereas
> +     * the region size here can exceed host memory, therefore we manually
> +     * create an oversized anonymous mapping and clean it up for alignment.
> +     */
>   
> -        /*
> -         * Align the mmap for more efficient mapping in the kernel.  Ideally
> -         * we'd know the PMD and PUD mapping sizes to use as discrete alignment
> -         * intervals, but we don't.  As of Linux v6.12, the largest PUD size
> -         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
> -         * on x86_64).  Align by power-of-two size, capped at 1GiB.
> -         *
> -         * NB. qemu_memalign() and friends actually allocate memory, whereas
> -         * the region size here can exceed host memory, therefore we manually
> -         * create an oversized anonymous mapping and clean it up for alignment.
> -         */
> -        map_base = mmap(0, region->mmaps[i].size + align, PROT_NONE,
> -                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -        if (map_base == MAP_FAILED) {
> -            ret = -errno;
> -            goto no_mmap;
> -        }
> +    align = MIN(pow2ceil(region->size), 1 * GiB);
>   
> -        fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
> +    map_base = mmap(0, region->size + align, PROT_NONE,
> +                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    if (map_base == MAP_FAILED) {
> +        ret = -errno;
> +        trace_vfio_region_mmap_fault(memory_region_name(region->mem), -1,
> +                                     region->fd_offset,
> +                                     region->fd_offset + region->size - 1, ret);
> +        return ret;
> +    }
> +
> +    fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
>   
> -        map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
> -        munmap(map_base, map_align - map_base);
> -        munmap(map_align + region->mmaps[i].size,
> -               align - (map_align - map_base));
> +    map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
> +    munmap(map_base, map_align - map_base);
> +    munmap(map_align + region->size,
> +           align - (map_align - map_base));
>   
> -        region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        munmap(map_align + map_offset, region->mmaps[i].offset - map_offset);
> +        region->mmaps[i].mmap = mmap(map_align + region->mmaps[i].offset,
> +                                     region->mmaps[i].size, prot,
>                                        MAP_SHARED | MAP_FIXED, fd,
>                                        region->fd_offset +
>                                        region->mmaps[i].offset);
>           if (region->mmaps[i].mmap == MAP_FAILED) {
>               ret = -errno;
> +            /*
> +             * Only unmap the rest of the region. Any mmaps that were successful
> +             * will be unmapped in no_mmap.
> +             */
> +            munmap(map_align + region->mmaps[i].offset,
> +                   region->size - region->mmaps[i].offset);
>               goto no_mmap;
>           }
>   
> @@ -408,6 +426,15 @@ int vfio_region_mmap(VFIORegion *region)
>                                  region->mmaps[i].offset,
>                                  region->mmaps[i].offset +
>                                  region->mmaps[i].size - 1);
> +
> +        map_offset = region->mmaps[i].offset + region->mmaps[i].size;
> +    }
> +
> +    /*
> +     * Unmap the rest of the region not covered by sparse mmap.
> +     */
> +    if (map_offset < region->size) {
> +        munmap(map_align + map_offset, region->size - map_offset);
>       }
>   
>       if (!vfio_region_create_dma_buf(region, &local_err)) {


