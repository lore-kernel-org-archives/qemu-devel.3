Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38BDC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4de6-0006o6-GA; Tue, 15 Apr 2025 06:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4ddr-0006mM-Ny
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:35:48 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4ddo-0002Sv-1z
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:35:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso3264547f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744713341; x=1745318141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WqoY9aiCPzz7oMLgOYLWxXzmvq1PfVk76jsjfj1/6hQ=;
 b=zKfBReQy9qW+rfqiaUsHRuFflqP5XGYcJf6zD4XNy/wxI9x3bU1U4qWCS1mzAcON1X
 58EJ2QSHPblHJCmWii7ZyFDU6tvkqQpGHfhrGRXIHBDgKANWK4QmPIlnLJd6CZrSvMpn
 VYspALkdYlko6YtFhD6z9RWn43atr6tbMwrqE3a60BKlXJ3qdUAxyg6ZF2w7YjjrklGE
 uzwDmuNT11s1i/fveJYhazldZDhakciXPuCzA/QkIGi5ts7RAsBYwzxmc6CeEYF1U9hE
 2m62mQ58gNflgmMVzUdpYYGjVc6StVhEBQk/jJIAU4y2usO5ijtIZPJ3GB6LXjV01/qk
 ltzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744713341; x=1745318141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WqoY9aiCPzz7oMLgOYLWxXzmvq1PfVk76jsjfj1/6hQ=;
 b=vorNQZLBdhgAgX/R+priIJRmKeTDO0TYbIWpyqt7SEA9GTI2oNpyetT9E6kt0i8Y+o
 7aWEdNB6fCrU3+OxKGmJs6irh+tRu2qNDL20JLv127YO8WHjSFs5CZE9fpNcS7a9FlQM
 i/hKS1TCRFvaocRPuvhz//tohb27uO2TGXybh9/AcawUS6gnJKpMm9Bdi9Zq1zCfzd/0
 nwoxfslJ4tAGwk+UnYy9bejjV9w66VB14PlxRwNiPjXDALx/zdoKbBosiPJgpIcjAprt
 u5RdQSNvKjXTjaoqtXWnALFXQRbNOmHYjPVNmnp6kvOHQ/ev4u2AZRahwpWzM+5H5egm
 TCPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSjNt0YsEr1zXU9e0MmoLr5gU6LuzZ1SYUlZTOahilIVkpX/ApvnVsjcsVARKv/VtVZmquqTxg74Pw@nongnu.org
X-Gm-Message-State: AOJu0Yxfah8dwT3PHFW1OGNiDPtjwzdIGPoay9JwyGMDXh5buOlnVF6d
 jWJNOMniWhMv+zJppk774hscEnfd3rRq3jYuLrBUs0UkRx2GJ3hmWp6do0ViqcM=
X-Gm-Gg: ASbGnct6bf91IiO+4ARBcFxfsnr/JrEOTzyMlmlyZdXW6XuYYuYJHEbnMANRtoFkHSB
 0Zs+zVSK3J1U3gCxu4O2BNIVjiKiwg2il2aDgm2W8wNC2HYzoY9brSFUrD1k+cjEh+QadHdF4BX
 K/rRE72WzSckOyjCtWgmF4WrUErZ1Fnnpv0Hu9+fi8E5ceqGTsGlYRj+70T03K/tfUHIXLWHTxb
 euWeRhI0vIW+ph4q4Mo/MNDXimIfxpbkt4gB8t5vhHUBgblw9f9HOz+tE+/eibLK0qVYIKe967B
 5ugJBwZlRdhmM1scv4uCR32hvnbiLpUfN/V7cgLkk7CrpJIZ6mb7USqqXYY7eiLbCOl2CfieAo6
 mhPu7Bx6Q
X-Google-Smtp-Source: AGHT+IHFk3HqUoKuWjkUHFFoRh1mWdmWpkuO4a00gOmfD+v++ewwVEvKPMMH+m1SZtyyFCd2rq8trA==
X-Received: by 2002:a05:6000:2289:b0:391:9b2:f496 with SMTP id
 ffacd0b85a97d-39edc30b604mr2535230f8f.16.1744713341501; 
 Tue, 15 Apr 2025 03:35:41 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2338d7cdsm213619275e9.8.2025.04.15.03.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 03:35:40 -0700 (PDT)
Message-ID: <bdd79b83-8487-479b-ba30-ada01476fdde@linaro.org>
Date: Tue, 15 Apr 2025 12:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/display: re-arrange memory region tracking
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
 <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/4/25 14:26, Manos Pitsidianakis wrote:
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> QOM objects can be embedded in other QOM objects and managed as part
> of their lifetime but this isn't the case for
> virtio_gpu_virgl_hostmem_region. However before we can split it out we
> need some other way of associating the wider data structure with the
> memory region.
> 
> Fortunately MemoryRegion has an opaque pointer. This is passed down to
> MemoryRegionOps for device type regions but is unused in the
> memory_region_init_ram_ptr() case.

It is unclear to me what layer is supposed to set/consume it. So far
in memory_region_init_io/ram/rom it is kind of internal to the memory
layer, but MemoryRegionOps aren't. Yeah well, OK then.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Use the opaque to carry the
> reference and allow the final MemoryRegion object to be reaped when
> its reference count is cleared.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   include/exec/memory.h         |  1 +
>   hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>   2 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index d09af58c97..bb735a3c7e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -784,6 +784,7 @@ struct MemoryRegion {
>       DeviceState *dev;
>   
>       const MemoryRegionOps *ops;
> +    /* opaque data, used by backends like @ops */
>       void *opaque;
>       MemoryRegion *container;
>       int mapped_via_alias; /* Mapped via an alias, container might be NULL */
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 145a0b3879..71a7500de9 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   
>   #if VIRGL_VERSION_MAJOR >= 1
>   struct virtio_gpu_virgl_hostmem_region {
> -    MemoryRegion mr;
> +    MemoryRegion *mr;
>       struct VirtIOGPU *g;
>       bool finish_unmapping;
>   };
>   
> -static struct virtio_gpu_virgl_hostmem_region *
> -to_hostmem_region(MemoryRegion *mr)
> -{
> -    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
> -}
> -
>   static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>   {
>       VirtIOGPU *g = opaque;
> @@ -73,14 +67,12 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>   static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>   {
>       MemoryRegion *mr = MEMORY_REGION(obj);
> -    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    struct virtio_gpu_virgl_hostmem_region *vmr = mr->opaque;
>       VirtIOGPUBase *b;
>       VirtIOGPUGL *gl;
>   
> -    vmr = to_hostmem_region(mr);
> -    vmr->finish_unmapping = true;
> -
>       b = VIRTIO_GPU_BASE(vmr->g);
> +    vmr->finish_unmapping = true;
>       b->renderer_blocked--;
>   
>       /*
> @@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>   
>       vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>       vmr->g = g;
> +    mr = g_new0(MemoryRegion, 1);
>   
> -    mr = &vmr->mr;
>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>       memory_region_add_subregion(&b->hostmem, offset, mr);
>       memory_region_set_enabled(mr, true);
> @@ -131,7 +123,9 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>        * command processing until MR is fully unreferenced and freed.
>        */
>       OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
> +    mr->opaque = vmr;
>   
> +    vmr->mr = mr;
>       res->mr = mr;
>   
>       return 0;
> @@ -142,16 +136,15 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>                                        struct virtio_gpu_virgl_resource *res,
>                                        bool *cmd_suspended)
>   {
> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>       VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>       MemoryRegion *mr = res->mr;
> +    struct virtio_gpu_virgl_hostmem_region *vmr;

Same same but different? ;)

>       int ret;
>   
>       if (!mr) {
>           return 0;
>       }
> -
> -    vmr = to_hostmem_region(res->mr);
> +    vmr = mr->opaque;
>   
>       /*
>        * Perform async unmapping in 3 steps:


