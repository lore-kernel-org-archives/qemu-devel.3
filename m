Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF57C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HPO-00052J-TG; Wed, 15 May 2024 12:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s7HPN-000521-2F
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:23:13 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s7HPB-0007qD-Go
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:23:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ecd9a81966so56471375ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1715790179; x=1716394979;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nZ6fjgZWxIJniltxkTBgUya3s2olJxgAhkL4nA4Ykco=;
 b=HqZRHS33zVf50V9KGKPShQ4ys9/m446kH+vcRcUX8b+MdibtPRmuDWLpLlIpT0SAEF
 yiumCTqT5mnctPhoSeJBcsgMBafVClHjUoydOwfJh6elLiXqtpz2PGLXWIcOR0L6q7km
 D8a1ROZed99HHEiLOPtnjF4cYOsYZSXS0ar8lfLBnHIKG9YIeQLp8aw4we16pn/WFh2/
 7FXe/QWF2qQq+msRMOSx1dqXRihEWMq7d9dVyLhGxzjSERWwmP/h1zvs3kKysjLQzEYO
 h91K4oTgQhatf1YmGooj65z7eXt0cvkuycomjnLet48JHENtXaAM/U+4yonu+zY7UdNB
 NsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715790179; x=1716394979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZ6fjgZWxIJniltxkTBgUya3s2olJxgAhkL4nA4Ykco=;
 b=RYmjq92/tIk9qq2lwMBvPwNO13AAxet4Tll+CrXJq8Wd0nb10lBR7QkCSlq7o3yRbO
 csyxCNerJyQWWFAOCqjFkPPad42q5X10SqJ1xU493Aj06kM2+/dk1OXPxnXAnkfVL63i
 aHWWqAxSBoe6HY686E2nuvrGoMCS2L9eGBSlHp/nmqY/4eN2SdKQFLBV/I5yb92ZGmwX
 G7TLkt5XGR1LdWw7DaI+hYAJpLT7XG3BDoG/AUxVtsaLn7DPH8jTchh1ei9bhaQpd0UZ
 NVGM73i6h/dw1oauaz06r8dzAwsFzQ/MhLQR1th8IyLHwJRNsChb/ltXEfiQuxv9Bdyi
 915w==
X-Gm-Message-State: AOJu0YwTjagIBiGXvbZOYOHg7kDtLCmO1chPuU8wWLhx/1+6q3xQQ8ld
 hTh1aW5HSnM3CN/j9KouwUDKH67MHvUACzno6LTd7tJfI5IN/RUsY5j+Rzcf8vA=
X-Google-Smtp-Source: AGHT+IHwMbtEaLIKQ62sZOYmLx3IWerz/igCWsS3yfGvnShROWMwb/rDIYCLZR8WPTZPlLqa9h77Cw==
X-Received: by 2002:a17:903:1109:b0:1eb:101d:bf53 with SMTP id
 d9443c01a7336-1eef9f346demr286477885ad.1.1715790179051; 
 Wed, 15 May 2024 09:22:59 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf30b0csm120796265ad.176.2024.05.15.09.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 09:22:58 -0700 (PDT)
Message-ID: <dd81b552-8f81-4bdd-9c9d-45fec6b6a526@daynix.com>
Date: Thu, 16 May 2024 01:22:52 +0900
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
 <f8d3f2d8-6759-4a74-8792-1091a47e1e43@daynix.com>
 <ec463ed4-de2b-434d-a1ee-e8b5d4a843b6@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ec463ed4-de2b-434d-a1ee-e8b5d4a843b6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

On 2024/05/16 1:18, Dmitry Osipenko wrote:
> On 5/13/24 11:44, Akihiko Odaki wrote:
>> On 2024/05/12 3:22, Dmitry Osipenko wrote:
>>> Even though GL GPU doesn't support hotplugging today, free virgl
>>> resources when GL device is unrealized. For consistency.
>>>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>    hw/display/virtio-gpu-gl.c     | 11 +++++++++++
>>>    hw/display/virtio-gpu-virgl.c  |  9 +++++++++
>>>    include/hw/virtio/virtio-gpu.h |  1 +
>>>    3 files changed, 21 insertions(+)
>>>
>>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>>> index e06be60dfbfc..0c0a8d136954 100644
>>> --- a/hw/display/virtio-gpu-gl.c
>>> +++ b/hw/display/virtio-gpu-gl.c
>>> @@ -136,6 +136,16 @@ static Property virtio_gpu_gl_properties[] = {
>>>        DEFINE_PROP_END_OF_LIST(),
>>>    };
>>>    +static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>>> +{
>>> +    VirtIOGPU *g = VIRTIO_GPU(qdev);
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
>>> +
>>> +    if (gl->renderer_inited) {
>>> +        virtio_gpu_virgl_deinit(g);
>>> +    }
>>> +}
>>> +
>>>    static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
>>>    {
>>>        DeviceClass *dc = DEVICE_CLASS(klass);
>>> @@ -149,6 +159,7 @@ static void virtio_gpu_gl_class_init(ObjectClass
>>> *klass, void *data)
>>>        vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
>>>          vdc->realize = virtio_gpu_gl_device_realize;
>>> +    vdc->unrealize = virtio_gpu_gl_device_unrealize;
>>>        vdc->reset = virtio_gpu_gl_reset;
>>>        device_class_set_props(dc, virtio_gpu_gl_properties);
>>>    }
>>> diff --git a/hw/display/virtio-gpu-virgl.c
>>> b/hw/display/virtio-gpu-virgl.c
>>> index 9f34d0e6619c..b0500eccf8e0 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -665,3 +665,12 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>>>          return capset2_max_ver ? 2 : 1;
>>>    }
>>> +
>>> +void virtio_gpu_virgl_deinit(VirtIOGPU *g)
>>> +{
>>> +    if (g->fence_poll) {
>>
>> Isn't g->fence_poll always non-NULL when this function is called?
> 
> virtio_gpu_virgl_init() is invoked when first cmd is executed, please
> see virtio_gpu_gl_handle_ctrl() that invokes it. Hence g->fence_poll can
> be NULL.
> 

But it already checks renderer_inited, doesn't it? And I think it's 
better to utilize one single flag to represent that virgl is enabled 
instead of checking several variables (fence_poll and cmdq_resume_bh in 
the future).

