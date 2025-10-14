Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9DCCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 04:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Woe-0002yw-Dx; Tue, 14 Oct 2025 00:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8Wob-0002ye-VO
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:39:13 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8Woa-0000N8-0R
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:39:13 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59E4ckdk029839
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 14 Oct 2025 13:38:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=pDiOocztbAWegHPiu6oMAcaMrlW0BI4e36q5JhffQ2U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760416726; v=1;
 b=Tle9vLLZyKeUNxS4vl1b5Nc/fOQBEx3aFCeZofqyrXkawVhgrdiHCGnOREe5Pvcd
 lcuAhCMPVO05Lm7jGPKiUuR1P+WKGBA2vYbPlzTk8MN9pmBo9Dh3p9vebt4WtuIv
 vkORgmNhe5NtgPStbBjyjxm5/2zpCnfXNRWw0z2tBHo80PfXfjuteWfW+XfhoPqR
 me3EhVKS/zjy/UzNr/ggCkjOt2imKXbUMHEycoDA1qBuE/xxWUZGam+F62T0AzqY
 YlcvhSC3+ekvgkH8AV8XLTRVAMyYeU+f4a0YK+0oGefS37St+lzS41hN2mIYvj2D
 h3KjfZTbUpVspfw0Sg9HpA==
Message-ID: <ebb13e38-adf6-4754-ad06-d72e2eb309f1@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 14 Oct 2025 13:38:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-4-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251003234138.85820-4-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/04 8:35, Vivek Kasireddy wrote:
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
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu.c | 30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index df696611a4..22bbe76809 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -801,6 +801,32 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
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
> +    if (cmd->cmd_hdr.type != VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB) {

I wonder what this conditional for. I think this breaks mapping VFIO 
with VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING.

> +        return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> +                              DMA_DIRECTION_TO_DEVICE,
> +                              MEMTXATTRS_UNSPECIFIED);
> +    }
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
> +}
> +
>   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>                                     uint32_t nr_entries, uint32_t offset,
>                                     struct virtio_gpu_ctrl_command *cmd,
> @@ -842,9 +868,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
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


