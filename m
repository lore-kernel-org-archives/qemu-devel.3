Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9851DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 10:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJDE-0004a0-IT; Mon, 15 Apr 2024 06:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rwJDC-0004Zo-Ex
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:05:18 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rwJD7-0002eI-RE
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:05:18 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso1911937a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713175512; x=1713780312;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hilhxvaMVV7rm+w6K+VA4tZtOrkq7aFFzc+J8jht57E=;
 b=lYKLZhTeEaqLTrkCH8AHv57poFttZFzaPGpW8mqxQAJEXSRBe+zhfTWayRtujG4FRz
 1krfw6mUhVOqIHgd1C56ZjcasT5eRmd//gajgnkvoKsuM9xpajRmyJ6QZQzpivlzmZCP
 pqRcQLfATsDDQkLy82VxFL+aGI1Z2jbjUhFrxv95fACYHWwB3AmzUjHDhTxC8KKO2b0w
 u9oRSI4JTdo4WsmF22/DmwGcfjlQOM22VZxo+4DiuaQOQ4FdmOA/TeveeoUT+zAYDfBq
 aipUS4GGvChgtSejHcWZlSh8AVW9l0ViUBfD9QiCWYUhWpnf0URWao5wZInECbMODrL5
 2rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713175512; x=1713780312;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hilhxvaMVV7rm+w6K+VA4tZtOrkq7aFFzc+J8jht57E=;
 b=av9rq7u8eXD4yF9H6M/GFx9nQleiNtCRtSSS4jC715ipozyRSfzUj8mV3ILXxZRIRr
 jtMoMa5TDHZc6QqUBOVDwutKRhHfbRiH7PtKsanv36+1vqLRXjQv4gUnPA9kqoy6Pnzc
 r5utwi/KtB1AYSFA68Gs43v6Vz5yzc6TpmE2X2EYqHkOPicYYXiPSIQ3ag7QYyzmXpOi
 yyjkOJiWgAXCa3k7xJ/kSp5xDWxp/fmKzfriP14P+U+s2UeL9ZsBJjosBILTd8ka7bl6
 STnS4Sh8MUJPUxWug2SseXtxxOB6ZnV/evgZBYPAAk1rkE4Zpokd12ngru7MYh+INLXA
 kpkg==
X-Gm-Message-State: AOJu0Yya1aV0+cap/3+aFWFm+RhmKpAxs+7bpYsYUueiZEbisFCwNdCr
 OykPD9qvqp3HEyGemjbpkitlAZmqi2bMIKcUb1klqRu/lp0ZAI7OLMrbRRv7DPk=
X-Google-Smtp-Source: AGHT+IF58HW35q3+wYUEIwaLkZS1YKn5LWIL6ofclDd/mDTvrqhRKx9B50EldXlMfbBaeQW08JIoSw==
X-Received: by 2002:a17:902:b105:b0:1e4:5b89:dbfe with SMTP id
 q5-20020a170902b10500b001e45b89dbfemr9494089plr.25.1713175512186; 
 Mon, 15 Apr 2024 03:05:12 -0700 (PDT)
Received: from [157.82.206.17] ([157.82.206.17])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a170902e88a00b001e3e0a8b32asm7501836plg.45.2024.04.15.03.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 03:05:11 -0700 (PDT)
Message-ID: <1fc1d55d-7eb7-49f4-9ed1-f52fe34cc876@daynix.com>
Date: Mon, 15 Apr 2024 19:05:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] virtio-gpu: Handle resource blob commands
Content-Language: en-US
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
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
 <20240411102002.240536-8-dmitry.osipenko@collabora.com>
 <29a55f63-593e-46d0-8dfe-f55e2b2de7ac@daynix.com>
 <918fb26b-72e9-446a-841b-810eb983dabe@collabora.com>
 <83e4454f-98d5-4e7d-b8d0-46d3d52442b1@daynix.com>
 <68c33b13-83ea-4ea4-b219-43a930a6ad10@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <68c33b13-83ea-4ea4-b219-43a930a6ad10@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
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

On 2024/04/15 17:49, Dmitry Osipenko wrote:
> On 4/15/24 11:13, Akihiko Odaki wrote:
>> On 2024/04/15 17:03, Dmitry Osipenko wrote:
>>> Hello,
>>>
>>> On 4/13/24 14:57, Akihiko Odaki wrote:
>>> ...
>>>>> +static void
>>>>> +virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>>>>> +                                     struct
>>>>> virtio_gpu_simple_resource *res)
>>>>> +{
>>>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>>>> +
>>>>> +    if (!res->mr) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    memory_region_set_enabled(res->mr, false);
>>>>> +    memory_region_del_subregion(&b->hostmem, res->mr);
>>>>> +
>>>>> +    /* memory region owns res->mr object and frees it when mr is
>>>>> released */
>>>>> +    res->mr = NULL;
>>>>> +
>>>>> +    virgl_renderer_resource_unmap(res->resource_id);
>>>>
>>>> Hi,
>>>>
>>>> First, thanks for keeping working on this.
>>>>
>>>> This patch has some changes since the previous version, but it is still
>>>> vulnerable to the race condition pointed out. The memory region is
>>>> asynchronously unmapped from the guest address space, but the backing
>>>> memory on the host address space is unmapped synchronously before that.
>>>> This results in use-after-free. The whole unmapping operation needs to
>>>> be implemented in an asynchronous manner.
>>>
>>> Thanks for the clarification! I missed this point from the previous
>>> discussion.
>>>
>>> Could you please clarify what do you mean by the "asynchronous manner"?
>>> Virglrenderer API works only in the virtio-gpu-gl context, it can't be
>>> accessed from other places.
>>>
>>> The memory_region_del_subregion() should remove the region as long as
>>> nobody references it, isn't it? On Linux guest nobody should reference
>>> hostmem regions besides virtio-gpu device on the unmap, don't know about
>>> other guests.
>>>
>>> We can claim it a guest's fault if MR lives after the deletion and in
>>> that case exit Qemu with a noisy error msg or leak resource. WDYT?
>>>
>>
>> We need to be prepared for a faulty guest for reliability and security
>> as they are common goals of virtualization, and it is nice to have them
>> after all.
>>
>> You need to call virgl_renderer_resource_unmap() after the MR actually
>> gets freed. The virtio-gpu-gl context is just a context with BQL so it
>> is fine to call virgl functions in most places.
> 
> Do you have example of a legit use-case where hostmem MR could outlive
> resource mapping?

MR outliving after memory_region_del_subregion() is not a use-case, but 
a situation that occurs due to the limitation of the memory subsystem. 
It is not easy to answer how often such a situation happens.

> 
> Turning it into a error condition is much more reasonable to do than to
> to worry about edge case that nobody cares about, which can't be tested
> easily and that not trivial to support, IMO.
> 
I'm not sure what you mean by turning into an error condition. I doubt 
it's possible to emit errors when someone touches an unmapped region.

Reproducing this issue is not easy as it's often cases for 
use-after-free bugs, but fixing it is not that complicated in my opinion 
since you already have an implementation which asynchronously unmaps the 
region in v6. I write my suggestions to fix problems in v6:

- Remove ref member in virgl_gpu_resource, vres_get_ref(), 
vres_put_ref(), and virgl_resource_unmap().

- Change virtio_gpu_virgl_process_cmd(), 
virgl_cmd_resource_unmap_blob(), and virgl_cmd_resource_unref() to 
return a bool, which tells if the command was processed or suspended.

- In virtio_gpu_process_cmdq(), break if the command was suspended.

- In virgl_resource_blob_async_unmap(), call virtio_gpu_gl_block(g, false).

- In virgl_cmd_resource_unmap_blob() and virgl_cmd_resource_unref(), 
call memory_region_del_subregion() and virtio_gpu_gl_block(g, true), and 
tell that the command was suspended if the reference counter of 
MemoryRegion > 0. Free and unmap the MR otherwise.

Regards,
Akihiko Odaki

