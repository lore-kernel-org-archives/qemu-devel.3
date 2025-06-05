Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F5CC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN63F-0001QV-SI; Thu, 05 Jun 2025 04:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uN63B-0001P9-EB
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:34:14 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uN639-0006cr-Fn
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:34:13 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b2c2c762a89so485551a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749112449; x=1749717249;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tMOHrZzVrUi2/6e4m1AAupXpv/NaqEkKjQB9KOeRi1A=;
 b=Jnys4NONVJWc7XVZUpeez4JMQO/vDcKEMwwulQChvj2PjFQEVcdJUrBVy+QEjmHU7E
 pY9ffCA3GysBvcs/o50vBroYp7TsTNcw8Nx9P5OvXPt2os/1CLwh+8Eq89dSsCGLkXMS
 4P8Cc2haT9piBCfR4wZtY2EVoUtH4xeny66gX21Juk3MeIqOBY3+Ve2GKsJ3gEAYfXnS
 ZX28cB3bTCFYIzCqoEvftFxrqq4b+pQV/5E1oXD9sIuQ490dkCk/SsDXKgRJ/sAW/xS3
 id+6XRNm/scUJ5PBn+GBmELf4TP8NaBVz60QW3qimpmbq1NXJDEVdt3KGrtMpFgT4dtn
 gVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749112449; x=1749717249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tMOHrZzVrUi2/6e4m1AAupXpv/NaqEkKjQB9KOeRi1A=;
 b=AndVBDPvNJrE6G1O70WfqipTmRHt8iNm6YuT4KjikxIvg7tCArlEd29RLM13GkG5Ty
 1kBxKWpaje8gZzDo+VewPlH9+ZBghkR7K3julBj5BVQLRuhbvEvPjqNpoU7qJRerhVwH
 4BFL9GplXxjd6e3w/TjL0ME4TwJGGjnmiHLaI5VLtQUvnxgH73T9O4u4QCJHgOPe3thN
 Fbtn/iGBdv5x442zu4pzl8jQLibcK1IkCmz7//4NJoBKoXuQ8+j/PzndUZWtIq7OvLM7
 maznQgITbEr8U4fo+o1APCYEJlCw3iFEMQ6UvZH9V+JAEhWPzVDvmwnXQqoYTM2Z0qoW
 C19A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHO9sYZJkx4q/Z2sNuIzMamUjFC7RczJrORncaWJXoUpup15Eh6BtJDKF0/HXmKqUoY3HjQxv6Kka5@nongnu.org
X-Gm-Message-State: AOJu0YzGeXB3RTF6kkpGhrjZE9UXzTpj0jyEUlHOEfNQIuOOfGPl2azq
 KHJUGy+hpgHcm12UCLn/ali6XnguEdEKoPyGuwDI+5MnpZhMJm9zcx/HIaKHlrY/uFU=
X-Gm-Gg: ASbGnct+YtQ1UM7VPuL6Xb0XDv3mafpfAwfBdyZuUXBAohLKKsK60EN1rV9euK8lHur
 JfEdUL2EclHTqHmf61QcmlXGKLlqfrxcVZ318XQMAdzujwAcXhSP8aoS1TiihMC9MgM+AE4r9L3
 ZQhntO2LHbVKeaiBkKmjv9GMDJglwvweqhzIkaOElvO+z49OG4iC+JT7IrawFkNLtUhYj+lXrFC
 KiFIa63qLpFGe1OEbhid5ONUcboFhoW4y9vspGvTOxCoE0DqcUblW9fldJO4WRKJGqXuWD02qpv
 4J6OW+sab5LXc+VmsN9BoMfE0SOfDUMscwObg4BUaG5wqi2WoEs+1KELCgCzok7sGPruCge7anE
 rcwu8p0tA3A==
X-Google-Smtp-Source: AGHT+IGqeYx3+8JeKcdJXqGq7bE+FRenx1qtz0UucT0C/Q7fc5XqK5vOMmMJ6CCApw3GTNNxFQzQeQ==
X-Received: by 2002:a17:90b:1e07:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-31310fff2d3mr7436095a91.8.1749112448977; 
 Thu, 05 Jun 2025 01:34:08 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313318e68f6sm762612a91.2.2025.06.05.01.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 01:34:08 -0700 (PDT)
Message-ID: <1a86b86d-145a-44fc-9f87-2804767fb109@daynix.com>
Date: Thu, 5 Jun 2025 17:34:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] hw/display: re-arrange memory region tracking
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-stable@nongnu.org
References: <20250603110204.838117-1-alex.bennee@linaro.org>
 <20250603110204.838117-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250603110204.838117-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/06/03 20:01, Alex Bennée wrote:
> QOM objects can be embedded in other QOM objects and managed as part
> of their lifetime but this isn't the case for
> virtio_gpu_virgl_hostmem_region. However before we can split it out we
> need some other way of associating the wider data structure with the
> memory region.
> 
> Fortunately MemoryRegion has an opaque pointer. This is passed down to
> MemoryRegionOps for device type regions but is unused in the
> memory_region_init_ram_ptr() case. Use the opaque to carry the
> reference and allow the final MemoryRegion object to be reaped when
> its reference count is cleared.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   include/system/memory.h       |  1 +
>   hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>   2 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index fc35a0dcad..90715ff44a 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
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

This patch does nothing more than adding a separate allocation for 
MemoryRegion. Besides there is no corresponding g_free(). This patch can 
be simply dropped.

Regards,
Akihiko Odaki

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


