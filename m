Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1331C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGsq-0002NN-J6; Wed, 29 May 2024 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sCGsp-0002N5-2s; Wed, 29 May 2024 06:50:15 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sCGsm-0001vr-Sm; Wed, 29 May 2024 06:50:14 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7E986443A7;
 Wed, 29 May 2024 12:50:09 +0200 (CEST)
Message-ID: <94b38346-7ad7-4fa4-b7e8-3ba00cc72f16@proxmox.com>
Date: Wed, 29 May 2024 12:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/9] virtio-gpu: fix v2 migration
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
References: <20240522222034.4001-1-farosas@suse.de>
 <20240522222034.4001-7-farosas@suse.de>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240522222034.4001-7-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

CC-ing stable, because this already is an issue in 9.0.0

Am 23.05.24 um 00:20 schrieb Fabiano Rosas:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Commit dfcf74fa ("virtio-gpu: fix scanout migration post-load") broke
> forward/backward version migration. Versioning of nested VMSD structures
> is not straightforward, as the wire format doesn't have nested
> structures versions. Introduce x-scanout-vmstate-version and a field
> test to save/load appropriately according to the machine version.
> 
> Fixes: dfcf74fa ("virtio-gpu: fix scanout migration post-load")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> [fixed long lines]
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  hw/core/machine.c              |  1 +
>  hw/display/virtio-gpu.c        | 30 ++++++++++++++++++++++--------
>  include/hw/virtio/virtio-gpu.h |  1 +
>  3 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c7ceb11501..8d6dc69f0e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -42,6 +42,7 @@ GlobalProperty hw_compat_8_2[] = {
>      { "migration", "zero-page-detection", "legacy"},
>      { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
> +    { "virtio-gpu-device", "x-scanout-vmstate-version", "1" },
>  };
>  const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>  
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ae831b6b3e..d60b1b2973 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1166,10 +1166,17 @@ static void virtio_gpu_cursor_bh(void *opaque)
>      virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
>  }
>  
> +static bool scanout_vmstate_after_v2(void *opaque, int version)
> +{
> +    struct VirtIOGPUBase *base = container_of(opaque, VirtIOGPUBase, scanout);
> +    struct VirtIOGPU *gpu = container_of(base, VirtIOGPU, parent_obj);
> +
> +    return gpu->scanout_vmstate_version >= 2;
> +}
> +
>  static const VMStateDescription vmstate_virtio_gpu_scanout = {
>      .name = "virtio-gpu-one-scanout",
> -    .version_id = 2,
> -    .minimum_version_id = 1,
> +    .version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(resource_id, struct virtio_gpu_scanout),
>          VMSTATE_UINT32(width, struct virtio_gpu_scanout),
> @@ -1181,12 +1188,18 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
>          VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
>          VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
>          VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
> -        VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
> +        VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,
> +                            scanout_vmstate_after_v2),
> +        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,
> +                            scanout_vmstate_after_v2),
> +        VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,
> +                            scanout_vmstate_after_v2),
> +        VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,
> +                            scanout_vmstate_after_v2),
> +        VMSTATE_UINT32_TEST(fb.stride, struct virtio_gpu_scanout,
> +                            scanout_vmstate_after_v2),
> +        VMSTATE_UINT32_TEST(fb.offset, struct virtio_gpu_scanout,
> +                            scanout_vmstate_after_v2),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -1659,6 +1672,7 @@ static Property virtio_gpu_properties[] = {
>      DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>      DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> +    DEFINE_PROP_UINT8("x-scanout-vmstate-version", VirtIOGPU, scanout_vmstate_version, 2),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 56d6e821bf..7a59379f5a 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -177,6 +177,7 @@ typedef struct VGPUDMABuf {
>  struct VirtIOGPU {
>      VirtIOGPUBase parent_obj;
>  
> +    uint8_t scanout_vmstate_version;
>      uint64_t conf_max_hostmem;
>  
>      VirtQueue *ctrl_vq;


