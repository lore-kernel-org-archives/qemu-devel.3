Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7301C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 08:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6RIH-0000cq-7n; Mon, 13 May 2024 04:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s6RIF-0000cW-PB
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:44:24 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s6RID-0005NA-VJ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:44:23 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f112c8f2bfso48298a34.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1715589859; x=1716194659;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZBuw4FHwBMQyyJEe7MmHAisUaE6ebrUGufJksCO7v9w=;
 b=pbzxTAp4WsvrMYJPorfQEhd9bi8ISQ8qoYcZB2+hwzup94s74X1Rpu/qtTbaekJWaP
 lmww2re1PoyMh5tX2YjzGqfjvivU2YNK4YlmV2P2WqHDVXoPDx1sdLLLWaa46IVzPPDk
 OYUzxfLUliK2zSCah3SGSCmUOzmkuSJIcSaJML+4FWDXUoEascdugjM4JastXjAeEnMP
 +NqgI2eU3VdaG5wfn9fboXGjyYMrg+S1mlM9Bp33xq+rICi8jse7ER8gwFYcycLz3cre
 7bzKYaJj8KMnqJmYr636UyPJi4mwvUujPhK4BEQNCIzLDTe/dnpBkYMsjadkywkHBZzb
 QPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715589859; x=1716194659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBuw4FHwBMQyyJEe7MmHAisUaE6ebrUGufJksCO7v9w=;
 b=vPhtFcDB594Sb+8veiMrHvP43UeOHmHiq5SbPJFPEW2Qnb4lTslNhAmVpY+BDH42ih
 stCTavc2WPwOcEgkLdH3dE0svuuFFhjp83dXlbRQnAK5qEgLB/sBc1T8cvma2V5+ItLn
 5O9OnkzdDvYVD2hklpf1p8dEU+upKRyGSnNapFiKdAeGL43DVvbzzkMGh+IhNn7HFRbY
 YTKijtuTNWupXP8J25GbSY64Akrs5/huWbyNAnIZHXKcDTnJO4YzSCJ+2ppAmFU/mtVP
 P7Bwc2XaFSJ3Jz2+83F7MHgTXR21vP6NSjgXvJM/O0l2GEteDSkcJAKtWSRVtsrhWZwB
 yzHg==
X-Gm-Message-State: AOJu0Yzka8u1yReNX4qJryeQZRz+rE4jjoCs646RmvmWD05GqYcBgEU/
 cesRDV4oTbhfDiAmXZ4toCWpbm/dHifSIa0sigSYSGg5W5XhuZaLmonSPbGxRfo=
X-Google-Smtp-Source: AGHT+IGHbGhbbBWsFKTiwlmkY9fy5ujk7/hK48OCX6fwVrbm778pi6CfyKXwVvKFrIYJGd7WE/cgeA==
X-Received: by 2002:a05:6871:4192:b0:23c:bbe9:570 with SMTP id
 586e51a60fabf-24172f7139bmr15507368fac.37.1715589858969; 
 Mon, 13 May 2024 01:44:18 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340c8a6bfdsm6350945a12.46.2024.05.13.01.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 01:44:18 -0700 (PDT)
Message-ID: <f8d3f2d8-6759-4a74-8792-1091a47e1e43@daynix.com>
Date: Mon, 13 May 2024 17:44:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/10] virtio-gpu: Unrealize GL device
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
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
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
 <20240511182251.1442078-2-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240511182251.1442078-2-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/05/12 3:22, Dmitry Osipenko wrote:
> Even though GL GPU doesn't support hotplugging today, free virgl
> resources when GL device is unrealized. For consistency.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     | 11 +++++++++++
>   hw/display/virtio-gpu-virgl.c  |  9 +++++++++
>   include/hw/virtio/virtio-gpu.h |  1 +
>   3 files changed, 21 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index e06be60dfbfc..0c0a8d136954 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -136,6 +136,16 @@ static Property virtio_gpu_gl_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
> +{
> +    VirtIOGPU *g = VIRTIO_GPU(qdev);
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
> +
> +    if (gl->renderer_inited) {
> +        virtio_gpu_virgl_deinit(g);
> +    }
> +}
> +
>   static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -149,6 +159,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
>       vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
>   
>       vdc->realize = virtio_gpu_gl_device_realize;
> +    vdc->unrealize = virtio_gpu_gl_device_unrealize;
>       vdc->reset = virtio_gpu_gl_reset;
>       device_class_set_props(dc, virtio_gpu_gl_properties);
>   }
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 9f34d0e6619c..b0500eccf8e0 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -665,3 +665,12 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>   
>       return capset2_max_ver ? 2 : 1;
>   }
> +
> +void virtio_gpu_virgl_deinit(VirtIOGPU *g)
> +{
> +    if (g->fence_poll) {

Isn't g->fence_poll always non-NULL when this function is called?

> +        timer_free(g->fence_poll);
> +    }
> +
> +    virgl_renderer_cleanup(NULL);
> +}
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index ed44cdad6b34..b657187159d9 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -336,6 +336,7 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
>   void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>   void virtio_gpu_virgl_reset(VirtIOGPU *g);
>   int virtio_gpu_virgl_init(VirtIOGPU *g);
> +void virtio_gpu_virgl_deinit(VirtIOGPU *g);
>   int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
>   
>   #endif

