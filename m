Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B40C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28Q3-0003wz-Dj; Tue, 08 Apr 2025 08:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u28Q0-0003tL-3C
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 08:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u28Px-0004UL-62
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 08:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744116663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ng2YjyHMogXFSUSz0sREORwCz4cmZqeh+zunGjjn/Ng=;
 b=cpW+FWtYqP/5UHkhgWHzG/ir7ZDvDwmivyPrVLHs3CBvYPSaurrrFIARA8SfkZK6awduU3
 UnPbyY/GWcIHOp9J6abQTqjvauBur0b4lX2z6iNtt8+MfVZCWssccK6egqQzdRSWSHyb+i
 UYn/7wF884jIofLwUcjR6ncZ64b/DBY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-jHx_wqh0OtGiOkzrmwmfhw-1; Tue, 08 Apr 2025 08:51:01 -0400
X-MC-Unique: jHx_wqh0OtGiOkzrmwmfhw-1
X-Mimecast-MFC-AGG-ID: jHx_wqh0OtGiOkzrmwmfhw_1744116660
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39ac9b0cb6aso3597324f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 05:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744116660; x=1744721460;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ng2YjyHMogXFSUSz0sREORwCz4cmZqeh+zunGjjn/Ng=;
 b=fXF+xyX4Ok2HwcEiJLy3u4QrrPh2YU0sDZjv5P3wG4m3MfAmZGM5BYSSY24Tq3VVFW
 l0jsFjeueW2h2212IiDkrjNpiQmRGeGp7Ts00BX9pw3sad5T5bEs9Gdi0hhEcVuoTC2H
 /mbXqzdmm2ayFCKOAsGq3eAwNEy43D5ihfB8tU6p9+nI1HRmgEeICNbrG7GqMIzzD2+i
 MG1+NN0YascyUqeSW7KEAFONctZp0cxicxKggHOBnYJM81cjdLKJz+r/wmSRm1hduDSZ
 05pUO6KxaaEzdAIdv6tcJwpItvciCjthnVTmk9+FVEdsB9RM8arlONDVdl7CMeWoq3lt
 foOw==
X-Gm-Message-State: AOJu0YyllYgJCokJrnrqkn8te5Q1wsqZDgvildKwCtIS8HGbv1O4HZrC
 3eTBSFbZ5Be3GHNnGhWsdcbZTQzTiHADnkkcsUYn/TdiiFPLfQliyUibRxswxCdGqr7Y7/4CEpw
 sqo/U8Ojc4HMe9xaug1K966WF6yFItp/X3AgbyGsuUj7AMKwwN2Xh
X-Gm-Gg: ASbGnctGNo18ZradYNvxkwPeQfwTwagkajnfsunc+IV9Iwh1FR/qBX00XW0bk8Iuses
 9KXg2B/bHsEWS+/YEbiVck3WqGIj444CLtAPcoJZCd/72YOIQhU8VwG0OZF95rrmXGKQKBuscZk
 hlmGUjs4fAt1/QMPJ3/GDshuc+v0b347JBG3HlP9JmsLayc2BiRwTH1s+oiAZRudnkG62384QHV
 ju0RvdA3d8ABYczj5LN2mzOqqkcuODX+vOv7Y4loXyBVO0xui0B6KdF3J+T69X3ZNs8PEFapwIX
 TYZhk6PC2iIoJ/Oy+LK2/9mq7OGpWUVsZg+EEUrT3RPllXXD5M/PIQ==
X-Received: by 2002:a05:6000:2281:b0:390:de58:d7fe with SMTP id
 ffacd0b85a97d-39d6fd366a1mr9869918f8f.51.1744116660123; 
 Tue, 08 Apr 2025 05:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETLD0cUFBpSni56Y/a7BJqh70mUdA/SpRZSHw6qkBTsrB7C+/Xu9q90Hn/FLIapDl31yrJjQ==
X-Received: by 2002:a05:6000:2281:b0:390:de58:d7fe with SMTP id
 ffacd0b85a97d-39d6fd366a1mr9869884f8f.51.1744116659748; 
 Tue, 08 Apr 2025 05:50:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a92desm159662085e9.14.2025.04.08.05.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 05:50:59 -0700 (PDT)
Message-ID: <c1c55f9b-8628-421e-99af-970e30867dcb@redhat.com>
Date: Tue, 8 Apr 2025 14:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vfio/spapr: Fix L2 crash with PCI device
 passthrough and memory > 128G
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
 <20250408124042.2695955-3-amachhiw@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250408124042.2695955-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/8/25 14:40, Amit Machhiwal wrote:
> An L2 KVM guest fails to boot inside a pSeries LPAR when booted with a
> memory more than 128 GB and PCI device passthrough. The L2 guest also
> crashes when it is booted with a memory greater than 128 GB and a PCI
> device is hotplugged later.
> 
> The issue arises from a conditional check for `levels > 1` in
> `spapr_tce_create_table()` within L1 KVM. This check is meant to prevent
> multi-level TCEs, which are not supported by the PowerVM hypervisor. As
> a result, when QEMU makes a `VFIO_IOMMU_SPAPR_TCE_CREATE` ioctl call
> with `levels > 1`, it triggers the conditional check and returns
> `EINVAL`, causing the guest to crash with the following errors:
> 
>   2025-03-04T06:36:36.133117Z qemu-system-ppc64: Failed to create a window, ret = -1 (Invalid argument)
>   2025-03-04T06:36:36.133176Z qemu-system-ppc64: Failed to create SPAPR window: Invalid argument
>   qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> Fix this by checking the supported DDW "levels" returned by the
> VFIO_IOMMU_SPAPR_TCE_GET_INFO ioctl before attempting the TCE create
> ioctl in KVM.
> 
> The patch has been tested on KVM guests with memory configurations of up
> to 390GB, and 450GB on PowerVM and bare-metal environments respectively.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/spapr.c | 36 +++++++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index dd9207679dbe..32611096fa29 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -26,6 +26,7 @@ typedef struct VFIOSpaprContainer {
>       VFIOContainer container;
>       MemoryListener prereg_listener;
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> +    unsigned int levels;
>   } VFIOSpaprContainer;
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
> @@ -236,9 +237,11 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
>   {
>       int ret = 0;
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
> +                                                  container);
>       IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
>       uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
> -    unsigned entries, bits_total, bits_per_level, max_levels;
> +    unsigned entries, bits_total, bits_per_level, max_levels, ddw_levels;
>       struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
>       long rampagesize = qemu_minrampagesize();
>   
> @@ -291,16 +294,29 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
>        */
>       bits_per_level = ctz64(qemu_real_host_page_size()) + 8;
>       create.levels = bits_total / bits_per_level;
> -    if (bits_total % bits_per_level) {
> -        ++create.levels;
> -    }
> -    max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
> -    for ( ; create.levels <= max_levels; ++create.levels) {
> -        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
> -        if (!ret) {
> -            break;
> +
> +    ddw_levels = scontainer->levels;
> +    if (ddw_levels > 1) {
> +        if (bits_total % bits_per_level) {
> +            ++create.levels;
>           }
> +        max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
> +        for ( ; create.levels <= max_levels; ++create.levels) {
> +            ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
> +            if (!ret) {
> +                break;
> +            }
> +        }
> +    } else { /* ddw_levels == 1 */
> +        if (create.levels > ddw_levels) {
> +            error_setg_errno(errp, EINVAL, "Host doesn't support multi-level TCE tables"
> +                             ". Use larger IO page size. Supported mask is 0x%lx",
> +                             bcontainer->pgsizes);
> +            return false;
> +        }
> +        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
>       }
> +
>       if (ret) {
>           error_setg_errno(errp, errno, "Failed to create a window, ret = %d", ret);
>           return false;
> @@ -501,6 +517,8 @@ static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
>           goto listener_unregister_exit;
>       }
>   
> +    scontainer->levels = info.ddw.levels;
> +
>       if (v2) {
>           bcontainer->pgsizes = info.ddw.pgsizes;
>           /*


