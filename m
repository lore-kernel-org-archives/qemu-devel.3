Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F2CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 04:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIgG3-0001sS-H5; Mon, 10 Nov 2025 23:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIgFx-0001kU-3Q
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 23:45:25 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIgFt-0005zB-P5
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 23:45:24 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AB4jFDR018323
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 11 Nov 2025 13:45:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PKiGqHYYsUHiuTchy40XMQ9R7cHERWkXWBfmWoqochI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762836315; v=1;
 b=CEUp1RaMM1iKJeUl+q2a+a0KScGU/UkwTzFuA3igWD4qJIdpHD0Dmvh9aPE+i7PV
 JG6IRDNYPgNUMImY2xrPQ3S4w2nLD6IhN3c83ckWHm+ckF/lfZPb/UitbmQHpJFr
 qjqn9PjOEFGxeXRqHENAJ/Ia2UDZ1HauJkAPbpUuNWdtp1ZXP2ENgH6M2lHJPhg/
 zR/+n/k4NIFDj1uCx/Qk7cTEfuS0JX5ZcYSY1k3rLOKgmdhrB1D4vEDy24AsnUFh
 FlYf26q+O3oZFDh+P12YjnYWkuZn8dttOASO8zfZOs9pAdzGXMOYthUBz45W2J0m
 Zmkg3x4GTHHYqJkQnQxN0Q==
Message-ID: <ea2e1bd7-d681-4929-b902-1948b854e488@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 11 Nov 2025 13:45:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-3-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251109053801.2267149-3-vivek.kasireddy@intel.com>
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

On 2025/11/09 14:33, Vivek Kasireddy wrote:
> If the Guest provides a DMA address that is associated with a ram
> device (such as a PCI device region and not its system memory),
> then we can obtain the hva (host virtual address) by invoking
> address_space_translate() followed by memory_region_get_ram_ptr().
> 
> This is because the ram device's address space is not accessible
> to virtio-gpu directly and hence dma_memory_map() cannot be used.
> Therefore, we first need to identify the memory region associated
> with the DMA address and figure out if it belongs to a ram device
> or not and decide how to obtain the host address accordingly.
> 
> Note that we take a reference on the memory region if it belongs
> to a ram device but we would still call dma_memory_unmap() later
> (to unref mr) regardless of how we obtained the hva.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 199b18c746..d352b5afd6 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -798,6 +798,26 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
>                                 &fb, res, &ss.r, &cmd->error);
>   }
>   
> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> +                                       struct virtio_gpu_ctrl_command *cmd,
> +                                       uint64_t a, hwaddr *len)
> +{
> +    MemoryRegion *mr = NULL;
> +    hwaddr xlat;
> +
> +    mr = address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat, len,
> +                                 DMA_DIRECTION_TO_DEVICE,
> +                                 MEMTXATTRS_UNSPECIFIED);
> +    if (memory_region_is_ram_device(mr)) {
> +        memory_region_ref(mr);
> +        return memory_region_get_ram_ptr(mr) + xlat;
> +    }
> +
> +    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> +                          DMA_DIRECTION_TO_DEVICE,
> +                          MEMTXATTRS_UNSPECIFIED);

This function should:
- call memory_region_get_ram_ptr(mr)
   if memory_region_is_ram(mr)
- return NULL otherwise

There are a few reasons. First, the documentation of dma_memory_map() 
tells to use it "only for reads OR writes - not for read-modify-write 
operations." It can be used for read-modify-write operations so 
dma_memory_map() should be avoided.

Second, it ensures that the mapped pointer is writable.
"[PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs associated 
with VFIO devices" adds checks for memory_region_is_ram() and 
memory_region_is_ram_device() to virtio_gpu_init_dmabuf(), but the other 
callers also use the function to map writable pointers.

It also makes the check of memory_region_is_ram_device() and 
memory_region_is_ram() unnecessary for virtio_gpu_init_dmabuf(), 
reducing the overall complexity.

Regards,
Akihiko Odaki

> +}
> +
>   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>                                     uint32_t nr_entries, uint32_t offset,
>                                     struct virtio_gpu_ctrl_command *cmd,
> @@ -839,9 +859,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
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


