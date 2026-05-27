Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91816CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBGs-0000Of-5x; Wed, 27 May 2026 06:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSBGk-0000OD-4D
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSBGg-0002q6-SA
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779876820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6RjcohaIZy/WrbHbcVguhU6KuTOgJQOyWaAu5I581hY=;
 b=dt9XBmKQF3ZGpmpHYk9kFKQJwHY2kTeheasLQ3or5hLvNckHnGXr577SpkgEdL1d0dSDmp
 kPojAwyh+AuVtc8f/qpB96yhTTnvyLdQYPet6mJjTmbMUiFn9SvR4KKy/JdGl7oHA9sXro
 5I2jqzAUmdviCn4mbVICmBrieXedCY8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-BxcqHkmEOOqzpVq60qgHuA-1; Wed, 27 May 2026 06:13:38 -0400
X-MC-Unique: BxcqHkmEOOqzpVq60qgHuA-1
X-Mimecast-MFC-AGG-ID: BxcqHkmEOOqzpVq60qgHuA_1779876817
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45e55c44ac1so9113375f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779876817; x=1780481617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6RjcohaIZy/WrbHbcVguhU6KuTOgJQOyWaAu5I581hY=;
 b=Y/Pc8xSborQYhZXF9HFtFHyntK1owJ8ZXcQtTmTTgkLz0PgabKpmtrljBaO7B+NYq3
 HzJbdy3fZD7jWEf995kUTk7s8CgNvP1pDD69mgO8CLm3fNCfwRIf7GPDfWjMAK0/joCP
 0RoLlEIf3GIbj/pW1FhKVFgn+mbFFpgXdLy6f8iTAvSwnvPPnl1LXpOWns8zO2fGHy3N
 obXh42rlehFsjILr7xiXrQ2+Vfyeel7syRlTWgnMRRp/3+Dc2VmUF5sNa8dWtC+tw0GY
 dTXPXkmLJBDEn1sF2/sLBPV5Xx492sGalmF4t7t2TvmqM93Sg6mOEXmnz7jOgAhzss8H
 siww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779876817; x=1780481617;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RjcohaIZy/WrbHbcVguhU6KuTOgJQOyWaAu5I581hY=;
 b=Zs1liGJFDok9/pPyGdvI/KMsVlFFMS6fCiFYJBLh/Y0UUc9JEDOa/14uX9UPcdq5n7
 4vB8gofIFEZHgKOJuF3G6Vh7fi0rFEJrN0HS8LtQaD5TpN7DILYm1VFSgVH4nKur6T3i
 dMESmWdiJVfMqneT9hI1+/4ISXj1byibDsJ0ovg2/PuD/TMNgK+ScbGlxNGqqaNfaWdZ
 J7S4fK74xB9kFuWEekL73Yc8OQQXS/nGHqdbAvazKc3xr0zdFVD0w5gGBLhkQVe/dZ6Q
 IsXPicoGpxzjkOWrDsWcoGG31NHBTaho+3HC8tZ8WIB/dMATJIKGR+PU3fUVC9HmP7ez
 yIsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8U3Sxdj4KCnCQxtA8tHaafBMYsCUb6LUSj1pJmt0BNWYN0dlybTtJ1midkH/oQ+tFbgApQx7tJtCTx@nongnu.org
X-Gm-Message-State: AOJu0YzRbhfgyAk2bCqKTyIY6HURrVo5HUKF/FgLWtDnPPPytdNzXhbq
 Sd7e6crWYrobnM981CggGbeSBBpcmgO2SwxXTv2yYOCVhCOCq5Y5LzmEUIYzGLQWvG1xzKYy3vy
 N9wmpROvAjnB4hvtjo0gvxZsQMk8rXsnOEcFrnIXSmoOFM4VpS5XhcHET
X-Gm-Gg: Acq92OExGP7AOzRdh6FzbDFZEbP5kOWQ0wbokKPCGPPvwUc6ZEUFxQ/H5OCKriJyIqe
 5Ty7aWP3dx5kVm34YoCCABgXiiLuCFyl8Sv02lIEi4iKO2FcVJQuAIxwGRJWOAR0GutFHGKPUvh
 C7BtM01KNji2tTygI2Hn8RN5S8XM6lEylboCIYOjpj5FHFPlUUg48F8Uv+mIOQQ9Lnhd2F7jYzb
 W2PMcOkxfktfYOBfiKV62LNmob/Y5wOtm73O7WUUBRHWCd3SMQbpLQnwTnsxINm0rgQbSKztSKn
 6ooET0pzEiI6WP7MrbqrkAu4p9no5+96pBDfQjfZB4OEheqmiWwNJC12fI71yQwY02u6oeY+JK1
 rSA3AqQL6poo2Vdpro496V7G/U0d+pg9MdkD/aNAcWn6dPJxNyChSYfdLGRiesQmVRK1R0g0=
X-Received: by 2002:a05:600c:a402:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-490426b4da5mr306683055e9.15.1779876817455; 
 Wed, 27 May 2026 03:13:37 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-490426b4da5mr306682645e9.15.1779876817000; 
 Wed, 27 May 2026 03:13:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490456274ebsm367725335e9.15.2026.05.27.03.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 03:13:36 -0700 (PDT)
Message-ID: <c3d7c7a9-446e-4f2a-9873-0e71c8888098@redhat.com>
Date: Wed, 27 May 2026 12:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/container: Restrict dma_map_file() to shared RAM
 or RAM devices
To: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
References: <20260527101109.71781-1-chenyi.qiang@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260527101109.71781-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/27/26 12:11, Chenyi Qiang wrote:
> vfio_container_dma_map() uses dma_map_file() whenever a RAMBlock has an
> fd and the VFIO IOMMU backend supports file-based DMA mapping. That is
> not correct for private file-backed guest RAM.
> 
> dma_map_file() resolves PFNs from the backing file, but private guest
> RAM mappings (MAP_PRIVATE) can run on different PFNs than the file
> because they are subject to copy-on-write (COW) anomalies. As a result,
> using dma_map_file() on a privately mapped RAMBlock can program DMA
> against pages that do not back QEMU's actual guest memory.
> 
> Fix this by using dma_map_file() only for shared mapped RAMBlocks
> (MAP_SHARED) or RAM device regions.
> 
> Fixes: fb32965b6dd8 ("vfio/iommufd: use IOMMU_IOAS_MAP_FILE")
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220776
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> 
> ---
> Changes in v2:
> - Extract the dma_map_file check into a helper.
> - Add the missing RAM device case which is also allowed by dma_map_file.
> ---
>   hw/vfio/container.c | 34 +++++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 4c2816b574..56bd9ac009 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -74,15 +74,43 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>       bcontainer->space = space;
>   }
>   
> +static bool vfio_container_can_dma_map_file(VFIOContainer *bcontainer,
> +                                            MemoryRegion *mr, int *fd)
> +{
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    RAMBlock *rb = mr->ram_block;
> +
> +    if (!vioc->dma_map_file || !rb) {
> +        return false;
> +    }
> +
> +    *fd = qemu_ram_get_fd(rb);
> +    if (*fd < 0) {
> +        return false;
> +    }
> +
> +    /*
> +     * We can use IOMMU DMA mapping (IOMMU_IOAS_MAP_FILE) for :
> +     *
> +     * 1) Guest RAM blocks explicitly configured as shared (MAP_SHARED)
> +     * 2) RAM device sub-regions (MMIO BARs)
> +     *
> +     * Private RAM mappings (MAP_PRIVATE) are strictly excluded. Because
> +     * they are subject to copy-on-write (COW) anomalies, their underlying
> +     * PFNs can permanently diverge from the backing file
> +     */
> +    return qemu_ram_is_shared(rb) || memory_region_is_ram_device(mr);
> +}
> +
>   int vfio_container_dma_map(VFIOContainer *bcontainer,
>                              hwaddr iova, uint64_t size,
>                              void *vaddr, bool readonly, MemoryRegion *mr)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> -    RAMBlock *rb = mr->ram_block;
> -    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
> +    int mfd;
>   
> -    if (mfd >= 0 && vioc->dma_map_file) {
> +    if (vfio_container_can_dma_map_file(bcontainer, mr, &mfd)) {
> +        RAMBlock *rb = mr->ram_block;
>           unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
>           unsigned long offset = qemu_ram_get_fd_offset(rb);
>   


