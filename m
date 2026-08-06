Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5526C55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpiw-0003ZJ-9s; Thu, 06 Aug 2026 00:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrpio-0003JK-Rs
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:28:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrpij-0003GR-Sv
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:28:45 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6764SYXf034952
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Aug 2026 13:28:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2Yy4A4P6gmHDFzXvtHxn7hhego+l1LQ/jolheE8wAjo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785990514; v=1;
 b=IYy1ov8bTvZjqWpmRve9reYIVT2Qfam7pPWXxzt1soP05cj6oKY1p1OvFfLAKx6y
 WJaCYO4usczbdRB7iGjVkz1IawE5XAVKYs7zMD0bpseqFVDDhIMat9Uf7rjoCdSN
 8k0ZBKZt4Sf/2SU0wSQVFFLX8B7DmQth2eSrr6rodfC44zgbzq6AN8fN0i+N+/43
 uWjaxV5xjBHXT+ZV9s8dOVTnVpkmP+bH8zVDik5BAtFDaTa84oSxhU4td3EknEBO
 YxoN928SMo/OLRd46YN/XhitBJ3FF9FzftPPz0fMsDCsIQZQXzAX2SJRfruEaV4w
 V/JX9ya/ZpdzXGjxid2x7Q==
Message-ID: <e077aae9-fbf4-4836-85d2-2f513e2691ad@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Aug 2026 13:28:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] virtio-gpu: use g_try_malloc to avoid guest-triggered
 abort
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260805130141.211398-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260805130141.211398-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/05 22:01, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failure
> returns an error to the guest rather than crashing the host (glib
> behaviour).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> ---
> v5:
>   - also fail gracefully in virtio_gpu_create_udmabuf()
> ---
>   contrib/vhost-user-gpu/vhost-user-gpu.c | 25 ++++++++++-----
>   contrib/vhost-user-gpu/virgl.c          |  6 +++-
>   contrib/vhost-user-gpu/vugbm.c          |  5 ++-
>   hw/display/virtio-gpu-rutabaga.c        | 14 +++++++--
>   hw/display/virtio-gpu-udmabuf.c         |  7 +++--
>   hw/display/virtio-gpu-virgl.c           |  6 +++-
>   hw/display/virtio-gpu.c                 | 42 ++++++++++++++++++-------
>   7 files changed, 79 insertions(+), 26 deletions(-)
> 
> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
> index 786488150932..933bdbb671c0 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -487,7 +487,7 @@ vg_create_mapping_iov(VuGpu *g,
>                         struct virtio_gpu_ctrl_command *cmd,
>                         struct iovec **iov)
>   {
> -    struct virtio_gpu_mem_entry *ents;
> +    g_autofree struct virtio_gpu_mem_entry *ents = NULL;
>       size_t esize, s;
>       int i;
>   
> @@ -498,17 +498,22 @@ vg_create_mapping_iov(VuGpu *g,
>       }
>   
>       esize = sizeof(*ents) * ab->nr_entries;
> -    ents = g_malloc(esize);
> +    ents = g_try_malloc(esize);
> +    if (!ents && esize) {
> +        return -1;
> +    }
>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                      sizeof(*ab), ents, esize);
>       if (s != esize) {
>           g_critical("%s: command data size incorrect %zu vs %zu",
>                      __func__, s, esize);
> -        g_free(ents);
>           return -1;
>       }
>   
> -    *iov = g_new0(struct iovec, ab->nr_entries);
> +    *iov = g_try_new0(struct iovec, ab->nr_entries);
> +    if (!*iov && ab->nr_entries) {
> +        return -1;
> +    }
>       for (i = 0; i < ab->nr_entries; i++) {
>           uint64_t len = ents[i].length;
>           (*iov)[i].iov_len = ents[i].length;
> @@ -517,12 +522,10 @@ vg_create_mapping_iov(VuGpu *g,
>               g_critical("%s: resource %d element %d",
>                          __func__, ab->resource_id, i);
>               g_free(*iov);
> -            g_free(ents);
>               *iov = NULL;
>               return -1;
>           }
>       }
> -    g_free(ents);
>       return 0;
>   }
>   
> @@ -828,8 +831,14 @@ vg_resource_flush(VuGpu *g,
>                   PIXMAN_FORMAT_BPP(pixman_image_get_format(res->image)) / 8;
>               size_t size = width * height * bpp;
>   
> -            void *p = g_malloc(VHOST_USER_GPU_HDR_SIZE +
> -                               sizeof(VhostUserGpuUpdate) + size);
> +            void *p = g_try_malloc(VHOST_USER_GPU_HDR_SIZE +
> +                                   sizeof(VhostUserGpuUpdate) + size);
> +            if (!p) {
> +                pixman_region_fini(&region);
> +                pixman_region_fini(&finalregion);
> +                cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +                break;
> +            }
>               VhostUserGpuMsg *msg = p;
>               msg->request = VHOST_USER_GPU_UPDATE;
>               msg->size = sizeof(VhostUserGpuUpdate) + size;
> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
> index 550fd03bf5c4..20bae57d0fe4 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -209,7 +209,11 @@ virgl_cmd_submit_3d(VuGpu *g,
>           return;
>       }
>   
> -    buf = g_malloc(cs.size);
> +    buf = g_try_malloc(cs.size);
> +    if (!buf && cs.size) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                      sizeof(cs), buf, cs.size);
>       if (s != cs.size) {
> diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
> index 710d54529779..e2d8385fd857 100644
> --- a/contrib/vhost-user-gpu/vugbm.c
> +++ b/contrib/vhost-user-gpu/vugbm.c
> @@ -13,7 +13,10 @@
>   static bool
>   mem_alloc_bo(struct vugbm_buffer *buf)
>   {
> -    buf->mmap = g_malloc((uint64_t)buf->width * buf->height * 4);
> +    buf->mmap = g_try_malloc((uint64_t)buf->width * buf->height * 4);
> +    if (!buf->mmap && buf->width && buf->height) {
> +        return false;
> +    }
>       buf->stride = buf->width * 4;
>       return true;
>   }
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index a054f8117f14..041216a10d04 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -366,10 +366,20 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
>           return;
>       }
>   
> -    buf = g_new0(uint8_t, cs.size);
> +    buf = g_try_new0(uint8_t, cs.size);
> +    if (!buf && cs.size) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                      sizeof(cs), buf, cs.size);
> -    CHECK(s == cs.size, cmd);
> +    if (s != cs.size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: size mismatch (%zu/%u)\n",
> +                      __func__, s, cs.size);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
>   
>       rutabaga_cmd.ctx_id = cs.hdr.ctx_id;
>       rutabaga_cmd.cmd = buf;
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
> index 5f08c855dde1..816f52a51457 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -39,8 +39,11 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>           return;
>       }
>   
> -    list = g_malloc0(sizeof(struct udmabuf_create_list) +
> -                     sizeof(struct udmabuf_create_item) * res->iov_cnt);
> +    list = g_try_malloc0(sizeof(struct udmabuf_create_list) +
> +                         sizeof(struct udmabuf_create_item) * res->iov_cnt);
> +    if (!list) {
> +        return;
> +    }
>   
>       for (i = 0; i < res->iov_cnt; i++) {
>           rcu_read_lock();
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 6e298f997d66..9bda572426b2 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -620,7 +620,11 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
>           return;
>       }
>   
> -    buf = g_malloc(cs.size);
> +    buf = g_try_malloc(cs.size);
> +    if (!buf && cs.size) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                      sizeof(cs), buf, cs.size);
>       if (s != cs.size) {
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index fbb6fec7a0ad..9eb010082d0d 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -892,7 +892,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>       }
>   
>       esize = sizeof(*ents) * nr_entries;
> -    ents = g_malloc(esize);
> +    ents = g_try_malloc(esize);
> +    if (!ents && esize) {
> +        return -1;
> +    }
>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                      offset, ents, esize);
>       if (s != esize) {
> @@ -913,6 +916,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>           hwaddr len;
>           void *map;
>   
> +        /* TODO: a common DMA map SG helper */
>           do {
>               len = l;
>               map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
> @@ -921,20 +925,27 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>               if (!map) {
>                   qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
>                                 " element %d\n", __func__, e);
> -                virtio_gpu_cleanup_mapping_iov(g, *iov, v);
> -                g_free(ents);
> -                *iov = NULL;
> -                if (addr) {
> -                    g_free(*addr);
> -                    *addr = NULL;
> -                }
> -                return -1;
> +                goto err;
>               }
>   
>               if (!(v % 16)) {
> -                *iov = g_renew(struct iovec, *iov, v + 16);
> +                struct iovec *new_iov;
> +                new_iov = g_try_renew(struct iovec, *iov, v + 16);
> +                if (!new_iov) {
> +                    dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as, map, len,
> +                                     DMA_DIRECTION_TO_DEVICE, len);
> +                    goto err;
> +                }
> +                *iov = new_iov;
>                   if (addr) {
> -                    *addr = g_renew(uint64_t, *addr, v + 16);
> +                    uint64_t *new_addr;
> +                    new_addr = g_try_renew(uint64_t, *addr, v + 16);
> +                    if (!new_addr) {
> +                        dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as, map, len,
> +                                         DMA_DIRECTION_TO_DEVICE, len);
> +                        goto err;
> +                    }
> +                    *addr = new_addr;
>                   }
>               }
>               (*iov)[v].iov_base = map;
> @@ -952,6 +963,15 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>   
>       g_free(ents);
>       return 0;
> +
> +err:
> +    virtio_gpu_cleanup_mapping_iov(g, *iov, v);
> +    *iov = NULL;
> +    if (addr) {
> +        g_clear_pointer(addr, g_free);
> +    }
> +    g_free(ents);
> +    return -1;
>   }
>   
>   void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,


