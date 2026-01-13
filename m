Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECDAD29DC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 04:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfWOE-0003DO-5q; Mon, 12 Jan 2026 23:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vfWOC-00039R-5P
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 23:52:20 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vfWOA-0003a4-8v
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 23:52:19 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60D4pqCJ029784
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 13 Jan 2026 13:51:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TRJ9OTmbsCq2kbVSYPRSkg6B6oV6N0TcJYetYmbRZec=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1768279917; v=1;
 b=lytDUIkfdIijKF4JDMPZexrztHXNwHnbR5iA9XRN1VD4SmoJ7y3XUi6jq5fw5T0x
 U3m5AygYBT7g1Qhwj4O/9WYlSHb3pksRA0ARw78hiEjFQ66HbE/dlgT0+iPQ/U9v
 T1rRq5eW1YbdhQv7DllgyLX+WuhIn7yy/6kYwjBmPChSS1p8pYVBWp2ptVOSM6qb
 jD/zIQw1sPTcoQ56m0M7pE0zktzHDMZzRmRiMzULqf8NWU/10zEMYsUTSUthJfZJ
 uJ3gmRAy1fs/5R62JphKYKbDLkQyf5XVWak+2WG8mVnKR0ZMqPzj99cldVoLVnu+
 iq3V/nvztj8pcz1Umd830Q==
Message-ID: <1011721c-cc29-4e85-a6fe-c26398685ba1@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 13 Jan 2026 13:51:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/5] virtio-gpu: Replace finish_unmapping with
 mapping_state
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
References: <20260112225246.3526313-1-dmitry.osipenko@collabora.com>
 <20260112225246.3526313-4-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260112225246.3526313-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/01/13 7:52, Dmitry Osipenko wrote:
> Allow virtio_gpu_virgl_unmap_resource_blob() to be invoked while async
> unmapping is in progress. Do it in preparation to improvement of virtio-gpu
> resetting that will require this change.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/trace-events       |  2 +-
>   hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++-----
>   2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index e323a82cff24..4bfc457fbac1 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -39,7 +39,7 @@ virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h)
>   virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
>   virtio_gpu_cmd_res_create_blob(uint32_t res, uint64_t size) "res 0x%x, size %" PRId64
>   virtio_gpu_cmd_res_map_blob(uint32_t res, void *vmr, void *mr) "res 0x%x, vmr %p, mr %p"
> -virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, bool finish_unmapping) "res 0x%x, mr %p, finish_unmapping %d"
> +virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, int mapping_state) "res 0x%x, mr %p, mapping_state %d"
>   virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 6a2aac0b6e5c..342e93728df0 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -68,10 +68,16 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   #endif
>   
>   #if VIRGL_VERSION_MAJOR >= 1
> +enum virtio_gpu_virgl_hostmem_region_mapping_state {
> +    VIRTIO_GPU_MR_MAPPED,
> +    VIRTIO_GPU_MR_UNMAP_STARTED,
> +    VIRTIO_GPU_MR_UNMAP_COMPLETED,
> +};
> +
>   struct virtio_gpu_virgl_hostmem_region {
>       MemoryRegion mr;
>       struct VirtIOGPU *g;
> -    bool finish_unmapping;
> +    enum virtio_gpu_virgl_hostmem_region_mapping_state mapping_state;
>   };
>   
>   static struct virtio_gpu_virgl_hostmem_region *
> @@ -95,7 +101,7 @@ static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>       VirtIOGPUGL *gl;
>   
>       vmr = to_hostmem_region(mr);
> -    vmr->finish_unmapping = true;
> +    vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_COMPLETED;
>   
>       b = VIRTIO_GPU_BASE(vmr->g);
>       b->renderer_blocked--;
> @@ -135,6 +141,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>   
>       vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>       vmr->g = g;
> +    vmr->mapping_state = VIRTIO_GPU_MR_MAPPED;
>   
>       mr = &vmr->mr;
>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> @@ -171,7 +178,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>   
>       vmr = to_hostmem_region(res->mr);
>   
> -    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr, vmr->finish_unmapping);
> +    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr,
> +                                        vmr->mapping_state);
>   
>       /*
>        * Perform async unmapping in 3 steps:
> @@ -182,7 +190,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>        *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
>        * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
>        */
> -    if (vmr->finish_unmapping) {
> +    switch (vmr->mapping_state) {
> +    case VIRTIO_GPU_MR_UNMAP_COMPLETED:
>           res->mr = NULL;
>           g_free(vmr);
>   
> @@ -193,15 +202,24 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>                             __func__, strerror(-ret));
>               return ret;
>           }
> -    } else {
> +        break;
> +
> +    case VIRTIO_GPU_MR_MAPPED:
>           *cmd_suspended = true;
>   
>           /* render will be unblocked once MR is freed */
>           b->renderer_blocked++;
>   
> +        vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED;
> +
>           /* memory region owns self res->mr object and frees it by itself */
>           memory_region_del_subregion(&b->hostmem, mr);
>           object_unparent(OBJECT(mr));
> +        break;

I suggest:

- Put vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED; here
- Remove *cmd_suspended = true for VIRTIO_GPU_MR_MAPPED.
- Let it fall through.

This way, it is clear that we need to execute *cmd_suspended = true 
because the state is now VIRTIO_GPU_MR_UNMAP_STARTED, and we can save on 
line by not having a duplicate *cmd_suspended = true.

> +
> +    case VIRTIO_GPU_MR_UNMAP_STARTED:
> +        *cmd_suspended = true;
> +        break;
>       }
>   
>       return 0;


