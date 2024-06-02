Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35691C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 05:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDe2d-0000AM-5R; Sun, 02 Jun 2024 01:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDe2a-0000A0-3Z
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 01:46:00 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDe2X-0003Wu-Mw
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 01:45:59 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d1c1f4bbf5so2089496b6e.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 22:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717307156; x=1717911956;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4O+PnkKSHDnumVRdzVBeWsFY/j3j0WJLkSVzwu/nrIw=;
 b=RtBfY3PpWdfPl9QSS3s9wZVwvom1ki8QtLdr1/JwykJbRws6jfcWe2/litjTw59RBt
 KQngvfYExjziZI1fjUFcgwv9f+IQvXAMSDpOe7Uxvr4SNN1KpuHwvWhu20q2kN+iazBi
 un9m73thGeuwkpN/YlVLz8315SFr44EnlD04tw+JNJXqO9bX+nHNH4/dwlDzREXvEARy
 lLam5vL1mgOD9zYZN9CjtPWGRam1ebzll5HvXzohzrf5DVtCXZn6NAfqigd5+Ix/wvKr
 BvC09QvFH28hNQtajAxQfUlAX4co56VYBlDYJ3ZPkhd8cA8sBDOPlGaTGwirPfyqhvJP
 rtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717307156; x=1717911956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4O+PnkKSHDnumVRdzVBeWsFY/j3j0WJLkSVzwu/nrIw=;
 b=QyV/k/klgXgutW/ke7A6wDYsliU/cAZJbNE88vu6rLWfBx4ZAASTFCaHFhJZCXkZIp
 afldMCDN+eCcQYSgAmz2XSn3uhSCyHmlUrVtAOTR+BLtWJWN4PbA7953PhdqjeyYJ1Hn
 VpbWsLAQhwy24/LrAXl4E81ZQ6St+qUPE6BoP3NlgTJHXO8vp9Lb3nWWdFfDCTxNSDq1
 4d1ZtjGm4owQGouJee7BhCFqir1wBe/jPe1IuSFoP2gGvJ50Tp3uW9T0AjfSxxP7hEMp
 B9+wKUS5plpS7r0713IY/np/MpBj/2Xrg5w3Yqp6JRVstmv0LAChjXzJhrWq2owc5DDS
 KKMg==
X-Gm-Message-State: AOJu0YxGcXrh0SYx7XUhBH5SG4+7NZGpsNteX2N8PiccJeChcKsuXYBq
 LH4PxrNGsX/hyB6tbGhVj5cP0a2ifjpBPX6zMb1GCvqkxpHh9G9RIHL7+qcCcyM=
X-Google-Smtp-Source: AGHT+IEdk3jfao4bX1dODFVxBIUH/FMuOpSCdcRvHTJcL/3E3CZ5jsiaFGiNr8eXXpUtVyX7E9iLFQ==
X-Received: by 2002:a54:4707:0:b0:3d1:d08b:36ab with SMTP id
 5614622812f47-3d1e3473c8bmr6380144b6e.4.1717307155992; 
 Sat, 01 Jun 2024 22:45:55 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702688e7e3dsm223532b3a.215.2024.06.01.22.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jun 2024 22:45:55 -0700 (PDT)
Message-ID: <dba6eb97-e1d1-4694-bfb6-e72db95715dd@daynix.com>
Date: Sun, 2 Jun 2024 14:45:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/13] virtio-gpu: Handle resource blob commands
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-12-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240527030233.3775514-12-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/05/27 12:02, Dmitry Osipenko wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Support BLOB resources creation, mapping and unmapping by calling the
> new stable virglrenderer 0.10 interface. Only enabled when available and
> via the blob config. E.g. -device virtio-vga-gl,blob=true
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c  | 320 ++++++++++++++++++++++++++++++++-
>   hw/display/virtio-gpu.c        |   4 +-
>   include/hw/virtio/virtio-gpu.h |   2 +
>   3 files changed, 322 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 7f45b4fa5fd7..0c73d9ba65f9 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -26,6 +26,7 @@
>   
>   struct virtio_gpu_virgl_resource {
>       struct virtio_gpu_simple_resource base;
> +    MemoryRegion *mr;
>   };
>   
>   static struct virtio_gpu_virgl_resource *
> @@ -49,6 +50,159 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   }
>   #endif
>   
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +typedef enum {
> +    HOSTMEM_MR_MAPPED,
> +    HOSTMEM_MR_UNMAPPING,
> +    HOSTMEM_MR_FINISH_UNMAPPING,
> +} HostmemMRState;
> +
> +struct virtio_gpu_virgl_hostmem_region {
> +    MemoryRegion mr;
> +    struct VirtIOGPU *g;
> +    HostmemMRState state;
> +};
> +
> +static struct virtio_gpu_virgl_hostmem_region *
> +to_hostmem_region(MemoryRegion *mr)
> +{
> +    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
> +}
> +
> +static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
> +{
> +    VirtIOGPU *g = opaque;
> +
> +    virtio_gpu_process_cmdq(g);
> +}
> +
> +static void virtio_gpu_virgl_hostmem_region_free(void *obj)
> +{
> +    MemoryRegion *mr = MEMORY_REGION(obj);
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    VirtIOGPUBase *b;
> +    VirtIOGPUGL *gl;
> +
> +    vmr = to_hostmem_region(mr);
> +    vmr->state = HOSTMEM_MR_FINISH_UNMAPPING;
> +
> +    b = VIRTIO_GPU_BASE(vmr->g);
> +    b->renderer_blocked--;
> +
> +    /*
> +     * memory_region_unref() is executed from RCU thread context, while
> +     * virglrenderer works only on the main-loop thread that's holding GL
> +     * context.
> +     */
> +    gl = VIRTIO_GPU_GL(vmr->g);
> +    qemu_bh_schedule(gl->cmdq_resume_bh);
> +}
> +
> +static int
> +virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> +                                   struct virtio_gpu_virgl_resource *res,
> +                                   uint64_t offset)
> +{
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +    MemoryRegion *mr;
> +    uint64_t size;
> +    void *data;
> +    int ret;
> +
> +    if (!virtio_gpu_hostmem_enabled(b->conf)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: hostmem disabled\n", __func__);
> +        return -EOPNOTSUPP;
> +    }
> +
> +    ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
> +                      __func__, strerror(-ret));
> +        return ret;
> +    }
> +
> +    vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
> +    vmr->g = g;
> +
> +    mr = &vmr->mr;
> +    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_add_subregion(&b->hostmem, offset, mr);
> +    memory_region_set_enabled(mr, true);
> +
> +    /*
> +     * MR could outlive the resource if MR's reference is held outside of
> +     * virtio-gpu. In order to prevent unmapping resource while MR is alive,
> +     * and thus, making the data pointer invalid, we will block virtio-gpu
> +     * command processing until MR is fully unreferenced and freed.
> +     */
> +    OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
> +
> +    res->mr = mr;
> +
> +    return 0;
> +}
> +
> +static int
> +virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
> +                                     struct virtio_gpu_virgl_resource *res,
> +                                     bool *cmd_suspended)
> +{
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +    MemoryRegion *mr = res->mr;
> +    int ret;
> +
> +    if (!mr) {
> +        return 0;
> +    }
> +
> +    vmr = to_hostmem_region(res->mr);
> +
> +    /*
> +     * Perform async unmapping in 3 steps:
> +     *
> +     * 1. Begin async unmapping with memory_region_del_subregion()
> +     *    and suspend/block cmd processing.
> +     * 2. Wait for res->mr to be freed and cmd processing resumed
> +     *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
> +     * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
> +     */
> +
> +    switch (vmr->state) {
> +    case HOSTMEM_MR_MAPPED:
> +        vmr->state = HOSTMEM_MR_UNMAPPING;
> +
> +        *cmd_suspended = true;
> +
> +        /* render will be unblocked once MR is freed */
> +        b->renderer_blocked++;
> +
> +        /* memory region owns self res->mr object and frees it by itself */
> +        memory_region_set_enabled(mr, false);
> +        memory_region_del_subregion(&b->hostmem, mr);
> +        object_unparent(OBJECT(mr));
> +        break;
> +    case HOSTMEM_MR_FINISH_UNMAPPING:
> +        ret = virgl_renderer_resource_unmap(res->base.resource_id);
> +        if (ret) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: failed to unmap virgl resource: %s\n",
> +                          __func__, strerror(-ret));
> +            return ret;
> +        }
> +        res->mr = NULL;
> +        g_free(vmr);
> +        break;
> +    case HOSTMEM_MR_UNMAPPING:
> +        *cmd_suspended = true;

This code path should be unreachable since the command processing is 
blocked while unmapping.

> +        break;
> +    }
> +
> +    return 0;
> +}
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
> +
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -146,7 +300,8 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>   }
>   
>   static void virgl_cmd_resource_unref(VirtIOGPU *g,
> -                                     struct virtio_gpu_ctrl_command *cmd)
> +                                     struct virtio_gpu_ctrl_command *cmd,
> +                                     bool *cmd_suspended)
>   {
>       struct virtio_gpu_resource_unref unref;
>       struct virtio_gpu_virgl_resource *res;
> @@ -164,6 +319,16 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>           return;
>       }
>   
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +        return;
> +    }
> +    if (*cmd_suspended) {
> +        return;
> +    }
> +#endif
> +
>       virgl_renderer_resource_detach_iov(unref.resource_id,
>                                          &res_iovs,
>                                          &num_iovs);
> @@ -514,6 +679,133 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>   }
>   
>   #ifdef HAVE_VIRGL_RESOURCE_BLOB
> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
> +                                           struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct virtio_gpu_virgl_resource *res;
> +    int ret;
> +
> +    if (!virtio_gpu_blob_enabled(g->parent_obj.conf)) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(cblob);
> +    virtio_gpu_create_blob_bswap(&cblob);
> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
> +
> +    if (cblob.resource_id == 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
> +                      __func__);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res = virtio_gpu_virgl_find_resource(g, cblob.resource_id);
> +    if (res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
> +                      __func__, cblob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res = g_new0(struct virtio_gpu_virgl_resource, 1);
> +    res->base.resource_id = cblob.resource_id;
> +    res->base.blob_size = cblob.size;
> +    res->base.dmabuf_fd = -1;
> +
> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
> +                                            cmd, &res->base.addrs,
> +                                            &res->base.iov, &res->base.iov_cnt);
> +        if (!ret) {
> +            g_free(res);

As noted for an earlier version:
 > Use g_autofree instead of writing duplicate g_free() calls. See
 > docs/devel/style.rst for details.

