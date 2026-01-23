Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E94D3EE9A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAvW-0007FJ-5o; Fri, 23 Jan 2026 01:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjAvT-0007DN-3X
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:45:47 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjAvR-0005el-26
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:45:46 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60N6jeaH019321
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 23 Jan 2026 15:45:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JJwR3g49tg51hHq9QqsrKtMPuywTujjrFBqXZr0Y9L0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769150742; v=1;
 b=bnTub9ab5wyGZ3QXdOAi3Oa8kpP/+FrY5htaHJsH+BhTC4Y27c4+erNrjyXAvIMa
 wD4Mtn6AXCJLk2vAtvzI4ugqn9p13OJ5TZqZ1Uod25cn1mFINDb+xNJgyZpO1sac
 4F63+JNSgVDg9IGIjTP9R7OCurNCPgct0X6QKOZ9mKQcCJyc82WNhAl63xbt4W9a
 Yd4/3IzJAe9gflaM8Rpn10a+G5jm9VIUzXuFrAn6IZaBnsOA5CVgU7rXdwhMqa7V
 xcotqRYmqSSbEisNza48Q64ApSm9bK9sQesf3RwuR2/hCQnZbjWTHnZeTnsTBLab
 VFPp+SjMj2udzT6LGW9mdA==
Message-ID: <0d57e3df-3ae6-496f-b621-8d979e2ab3f8@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 23 Jan 2026 15:45:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-3-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260123062042.568703-3-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/01/23 15:17, Vivek Kasireddy wrote:
> If the Guest provides a DMA address that is associated with a ram
> device (such as a PCI device region and not its system memory),
> then we can obtain the hva (host virtual address) by invoking
> address_space_translate() followed by memory_region_get_ram_ptr().
> 
> This is because the ram device's address space is not accessible
> to virtio-gpu directly and hence dma_memory_map() cannot be used.

This description is a bit confusing.

The first problem is with the phrase "the ram device's address space". 
The address space we are dealing with is always 
VIRTIO_DEVICE(g)->dma_as. More precisely it is a memory region, not 
address space.

The second problem is that it says the ram device's memory region is not 
directly accessible. It is usually true, but here we are directly 
accessing it anyway because the guest knows how to do so.

Regards,
Akihiko Odaki

> Therefore, we first need to identify the memory region associated
> with the DMA address and add the offset to the pointer returned
> from memory_region_get_ram_ptr() to obtain the host address.
> 
> Note that we take a reference on the memory region but we would
> still eventually call dma_memory_unmap() (to unref the mr).
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 3d58cebf4b..9930a21317 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -798,6 +798,23 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
>                                 &fb, res, &ss.r, &cmd->error);
>   }
>   
> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> +                                       struct virtio_gpu_ctrl_command *cmd,
> +                                       uint64_t a, hwaddr *len)
> +{
> +    MemoryRegion *mr;
> +    hwaddr xlat;
> +
> +    mr = address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat, len,
> +                                 DMA_DIRECTION_TO_DEVICE,
> +                                 MEMTXATTRS_UNSPECIFIED);
> +    if (memory_region_is_ram(mr)) {
> +        memory_region_ref(mr);
> +        return memory_region_get_ram_ptr(mr) + xlat;
> +    }
> +    return NULL;
> +}
> +
>   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>                                     uint32_t nr_entries, uint32_t offset,
>                                     struct virtio_gpu_ctrl_command *cmd,
> @@ -839,9 +856,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>   
>           do {
>               len = l;
> -            map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
> -                                 DMA_DIRECTION_TO_DEVICE,
> -                                 MEMTXATTRS_UNSPECIFIED);
> +            map = virtio_gpu_dma_memory_map(g, cmd, a, &len);
>               if (!map) {
>                   qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
>                                 " element %d\n", __func__, e);


