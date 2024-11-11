Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F5D12D73
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 05:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAMvu-0001c6-BB; Mon, 11 Nov 2024 00:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMvr-0001bj-Sk
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 00:25:47 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMvp-0001BF-S8
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 00:25:47 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so3422513b3a.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 21:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731302744; x=1731907544;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JQYjJd5gL9uXMjBsqxuTk8zxVaVAcJ1ldHebPG2etTs=;
 b=SxFOfogK/4+zY6OBu8haaTO959hFaIEJ/D+j1fQEaPwzkCPc8NKGxVQGAxu3DcOWnZ
 tXKFltGn6MMtrOjlaLSndCIPgSbJNUExhN3vmBN0drP448YLyqnUDLLzx0rcShJD858O
 qb+oWhYoNG+GVsCUDY0ACJZZGycyBVcWpR2oT9NIkfNypkDZzzd1JEDFumbfzAw/FKnG
 xi/X4vN0SVYxagaOGoQGQPvq4Qadkc6cGKHk16PSjK6TFyQ58aNLdnQoHGyfnupQw+qF
 PhwE4GS2LCmT7GuxyjuRLJh29xVxnZ59OGp313W64999UbUaaaPJn7QpCYptYcele5Yv
 9RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731302744; x=1731907544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JQYjJd5gL9uXMjBsqxuTk8zxVaVAcJ1ldHebPG2etTs=;
 b=Wl4mbAKPorQdiwmt6nD9oqe61tUPT/vKd4eg8ZTWMXaK4Mz/YZCDlkWKfzDh648/ev
 TXifH1HYJ4dK0PtvI8vU6Hm1Q3OCQ9548RApWol1ijt6oKLPQUI2xTg5XbbtkXtOcGQf
 jJMXBXrP5rXXNSwEU1bcNdIhlEU4ods5pG2ZIUk229HjilQb6PuDmzg/Y1i0vOyh5dQW
 oAtzcTMdZqGFuzoarIAlolMxKouPu6EjwbE0DtFXLGAyxO0L2eL0OuSxTxoQ3RZiZmzx
 n9BbCvs7K2mk5DgmaUimEECBLG04dlipw6B+++rnOXXgH9jO5EUXhWQNBfJbJzk5uDZC
 X1jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIo8EN49bS40DL4iYY2d/odnAi/bJjpQ+ck8cP4EZeviS2Ni0ixlYslIjjh4g8mIW62Qr5COBlvQ4a@nongnu.org
X-Gm-Message-State: AOJu0YxKls+VNbCH1Vxlx9eJkPE/OL/cA6aDKJbOKXQguTB0WltUuJUL
 8RmItDMtssnGkTavggvPAk9sCt8O2W0JNRkm32hf1vKO4omjxSAiV8KtKFpKZZk=
X-Google-Smtp-Source: AGHT+IGmX5sh61h8hWbVwWLZ5poDORNEGVAyNGdS0sdJ6gJaAWAkAj/pXnaJecJlkjp/TcufARkO2A==
X-Received: by 2002:aa7:88c4:0:b0:71e:594:f1ef with SMTP id
 d2e1a72fcca58-724133600ddmr13904479b3a.16.1731302744218; 
 Sun, 10 Nov 2024 21:25:44 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078cd28asm8145655b3a.85.2024.11.10.21.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 21:25:43 -0800 (PST)
Message-ID: <91c98764-c9ab-4299-8bbb-2d1a60e4d73c@daynix.com>
Date: Mon, 11 Nov 2024 14:25:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] virtio-gpu: Support DRM native context
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-7-dmitry.osipenko@collabora.com>
 <87sescin4u.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87sescin4u.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

On 2024/10/31 19:26, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
>> using a new virtio-gpu-gl device option "drm=on".
> 
> I feel like using "drm" is confusing in this context because drm exists
> for the host and guest. What about "native-context" or even
> "context=[opengl|vulkan|wayland|native]"?

The terminology in the specification is "capset". Multiple capabilities 
can be enabled at a time (e.g., DRM and VENUS) and we don't have a means 
to express that with one property.

The best option I came up with is to strip the VIRTIO_GPU_ prefix from 
definitions in the specification. i.e.,:

VIRTIO_GPU_CAPSET_VIRGL -> capset-virgl
VIRTIO_GPU_CAPSET_VIRGL2 -> capset-virgl2
VIRTIO_GPU_CAPSET_GFXSTREAM -> capset-gfxstream
VIRTIO_GPU_CAPSET_GFXSTREAM_VULKAN -> capset-gfxstream-vulkan
VIRTIO_GPU_CAPSET_VENUS -> capset-venus
VIRTIO_GPU_CAPSET_CROSS_DOMAIN -> capset-cross-domain
VIRTIO_GPU_CAPSET_DRM -> capset-drm

> 
> The GPU command line is already getting complex so now might be the time
> to rationalise it.
> 
> As an aside can mesa build the intel drivers on non-x86 systems as now I
> could potentially pass my native intel context to my emulated aarch64
> guests?
> 
>>
>> Unlike Virgl and Venus contexts that operate on application API level,
>> DRM native contexts work on a kernel UAPI level. This lower level results
>> in a lightweight context implementations that yield better performance.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   docs/system/devices/virtio-gpu.rst | 11 +++++++++++
>>   hw/display/virtio-gpu-gl.c         |  2 ++
>>   hw/display/virtio-gpu-virgl.c      | 22 ++++++++++++++++++++++
>>   hw/display/virtio-gpu.c            | 15 +++++++++++++++
>>   include/hw/virtio/virtio-gpu.h     |  3 +++
>>   5 files changed, 53 insertions(+)
>>
>> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
>> index b7eb0fc0e727..49a75138f7ef 100644
>> --- a/docs/system/devices/virtio-gpu.rst
>> +++ b/docs/system/devices/virtio-gpu.rst
>> @@ -82,6 +82,17 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
>>   
>>   .. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
>>   
>> +DRM native context is supported since release of `virglrenderer`_ v1.0.0
>> +using `drm`_ protocol. ``DRM`` virtio-gpu capability set ("capset") requires
>> +host blob support (``hostmem`` and ``blob`` fields) and should be enabled
>> +using ``drm`` field. The ``hostmem`` field specifies the size of virtio-gpu
>> +host memory window. This is typically between 256M and 8G.
>> +
>> +.. parsed-literal::
>> +    -device virtio-gpu-gl,hostmem=8G,blob=on,drm=on
>> +
>> +.. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
>> +
>>   virtio-gpu rutabaga
>>   -------------------
>>   
>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>> index 53d938f23f20..bd0c0692a5c4 100644
>> --- a/hw/display/virtio-gpu-gl.c
>> +++ b/hw/display/virtio-gpu-gl.c
>> @@ -159,6 +159,8 @@ static Property virtio_gpu_gl_properties[] = {
>>                       VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>>       DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
>>                       VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
>> +    DEFINE_PROP_BIT("drm", VirtIOGPU, parent_obj.conf.flags,
>> +                    VIRTIO_GPU_FLAG_DRM_ENABLED, false),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>> index 37b40e258398..89ca1878fb7c 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -1232,6 +1232,19 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>>       if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>>           flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
>>       }
>> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
>> +        flags |= VIRGL_RENDERER_DRM;
>> +
>> +        if (!gl->context_fence_enabled) {
>> +            /*
>> +             * Virglrenderer skips enabling DRM context support without
>> +             * enabled async-fence feature. VirtIO-GPU will initialize
>> +             * successfully, but DRM context won't be available in guest.
>> +             */
>> +            error_report("DRM native context requires EGL display");
>> +            return -EINVAL;
>> +        }
>> +    }
>>   #endif
>>   
>>       ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>> @@ -1294,5 +1307,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>>           }
>>       }
>>   
>> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
>> +        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_DRM,
>> +                                   &capset_max_ver,
>> +                                   &capset_max_size);
>> +        if (capset_max_size) {
>> +            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_DRM);
>> +        }
>> +    }
>> +
>>       return capset_ids;
>>   }
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index c0570ef8565a..c1acafe6246b 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -1492,6 +1492,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>>   #endif
>>       }
>>   
>> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
>> +#ifdef VIRGL_VERSION_MAJOR
>> +    #if VIRGL_VERSION_MAJOR >= 1
>> +        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
>> +            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
>> +            error_setg(errp, "drm requires enabled blob and hostmem options");
>> +            return;
>> +        }
>> +    #else
>> +        error_setg(errp, "old virglrenderer, drm unsupported");
>> +        return;
>> +    #endif
>> +#endif
>> +    }
>> +
>>       if (!virtio_gpu_base_device_realize(qdev,
>>                                           virtio_gpu_handle_ctrl_cb,
>>                                           virtio_gpu_handle_cursor_cb,
>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>> index 99cc6286f473..f1799fcb6eee 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -98,6 +98,7 @@ enum virtio_gpu_base_conf_flags {
>>       VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>>       VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
>>       VIRTIO_GPU_FLAG_VENUS_ENABLED,
>> +    VIRTIO_GPU_FLAG_DRM_ENABLED,
>>   };
>>   
>>   #define virtio_gpu_virgl_enabled(_cfg) \
>> @@ -118,6 +119,8 @@ enum virtio_gpu_base_conf_flags {
>>       (_cfg.hostmem > 0)
>>   #define virtio_gpu_venus_enabled(_cfg) \
>>       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
>> +#define virtio_gpu_drm_enabled(_cfg) \
>> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
>>   
>>   struct virtio_gpu_base_conf {
>>       uint32_t max_outputs;
> 


