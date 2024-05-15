Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A3BC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HnI-0005kr-1E; Wed, 15 May 2024 12:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7HnF-0005ic-II
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:47:53 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7HnB-0001Ou-Jt
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715791664;
 bh=0NZBK9Xr1TMymybrg+ZO5mJAmzqe851lDX0m2oqbrf0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=1HdTlhTATcV1QCOJKzXje/VJYpnBNNQuPevunm4l9YhKW4Fs3g6zAORpqnILIQHW0
 cJYI4wOR1evFIxz66VSbVhSQl2PWyOUrJdWe+oZtCBjFZsZA7CoUKdT61+38v1Dm6m
 iZZ7cCv0X4YFIV+HhG7KCux8uNivrPjIQjZTLN/A0f5gJyKCYfgm9jnh4Rvm1jT3Zu
 4+bnbr4Hfou4MB3hWgx/SF+XVUs+7Z+lt7FGOsd/gJlhu/t5f7WIJS2YWcKjUc7F4i
 EGQGIvs+SmL7t8XtZoWmK4g+RKeuEKpLOqmhXMv19H+QR0IyLyRKTwGu/DTfbu2eEV
 CyqdDKxFwSJCQ==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 846093782157;
 Wed, 15 May 2024 16:47:42 +0000 (UTC)
Message-ID: <d63ae799-0f4b-4a8b-b1da-a70e06be978a@collabora.com>
Date: Wed, 15 May 2024 19:47:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/10] virtio-gpu: Unrealize GL device
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
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
 <dd81b552-8f81-4bdd-9c9d-45fec6b6a526@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <dd81b552-8f81-4bdd-9c9d-45fec6b6a526@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 5/15/24 19:22, Akihiko Odaki wrote:
> On 2024/05/16 1:18, Dmitry Osipenko wrote:
>> On 5/13/24 11:44, Akihiko Odaki wrote:
>>> On 2024/05/12 3:22, Dmitry Osipenko wrote:
>>>> Even though GL GPU doesn't support hotplugging today, free virgl
>>>> resources when GL device is unrealized. For consistency.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> ---
>>>>    hw/display/virtio-gpu-gl.c     | 11 +++++++++++
>>>>    hw/display/virtio-gpu-virgl.c  |  9 +++++++++
>>>>    include/hw/virtio/virtio-gpu.h |  1 +
>>>>    3 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>>>> index e06be60dfbfc..0c0a8d136954 100644
>>>> --- a/hw/display/virtio-gpu-gl.c
>>>> +++ b/hw/display/virtio-gpu-gl.c
>>>> @@ -136,6 +136,16 @@ static Property virtio_gpu_gl_properties[] = {
>>>>        DEFINE_PROP_END_OF_LIST(),
>>>>    };
>>>>    +static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>>>> +{
>>>> +    VirtIOGPU *g = VIRTIO_GPU(qdev);
>>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
>>>> +
>>>> +    if (gl->renderer_inited) {
>>>> +        virtio_gpu_virgl_deinit(g);
>>>> +    }
>>>> +}
>>>> +
>>>>    static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
>>>>    {
>>>>        DeviceClass *dc = DEVICE_CLASS(klass);
>>>> @@ -149,6 +159,7 @@ static void virtio_gpu_gl_class_init(ObjectClass
>>>> *klass, void *data)
>>>>        vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
>>>>          vdc->realize = virtio_gpu_gl_device_realize;
>>>> +    vdc->unrealize = virtio_gpu_gl_device_unrealize;
>>>>        vdc->reset = virtio_gpu_gl_reset;
>>>>        device_class_set_props(dc, virtio_gpu_gl_properties);
>>>>    }
>>>> diff --git a/hw/display/virtio-gpu-virgl.c
>>>> b/hw/display/virtio-gpu-virgl.c
>>>> index 9f34d0e6619c..b0500eccf8e0 100644
>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>> @@ -665,3 +665,12 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>>>>          return capset2_max_ver ? 2 : 1;
>>>>    }
>>>> +
>>>> +void virtio_gpu_virgl_deinit(VirtIOGPU *g)
>>>> +{
>>>> +    if (g->fence_poll) {
>>>
>>> Isn't g->fence_poll always non-NULL when this function is called?
>>
>> virtio_gpu_virgl_init() is invoked when first cmd is executed, please
>> see virtio_gpu_gl_handle_ctrl() that invokes it. Hence g->fence_poll can
>> be NULL.
>>
> 
> But it already checks renderer_inited, doesn't it? And I think it's
> better to utilize one single flag to represent that virgl is enabled
> instead of checking several variables (fence_poll and cmdq_resume_bh in
> the future).

The virtio_gpu_virgl_init() will have to be changed to do that because
virgl_renderer_init() can fail before fence_poll/cmdq_resume_bh are inited.

Though, the error returned by virtio_gpu_virgl_init() isn't checked by
virtio_gpu_gl_handle_ctrl(), which leads to a further Qemu crash due to
fence_poll=NULL. I'll try to improve it all in v12, thanks.

-- 
Best regards,
Dmitry


