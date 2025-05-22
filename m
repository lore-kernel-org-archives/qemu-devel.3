Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D0DC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 09:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI2dK-0000JY-Be; Thu, 22 May 2025 05:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uI2dH-0000Ix-Dk
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:54:35 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uI2dD-0000nJ-Ae
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:54:35 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30e7e46cb47so6353228a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747907667; x=1748512467;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aaFSaf23Koy2JTgytHwLuqhpvUUPb3U0eibHAUGSHAE=;
 b=LsgqJjY+j+7Rtjf+uDOuPiv02JGk5PW7izDHzNsRd5FgC/nFfNTWVfNBOFn8GaXBuf
 1XZuzSAqAWmbLY0tvBBrtpucn7Uqxl8+IQg0GR7w+cMbPxbPBfh+LSZIpvRh0wssFQWw
 7U/aF6sG9M8CI5McEJFkTkueuBv6s+JlNehNfLyurVfxD6Ka3+GgdfjuYYd1FscVEEIM
 pYSbcelqd2ute8nui4jn2I8EC94d6VAyAciIFDXBZ8hM2VKRwJCPBo++N3xuXJ9s6Gmm
 lj5VzBhzMAVuPrhoVHXe19i8R4dFUs4NJwuOGVWRLOgsTV354w43YgWwK8IcQDIGjAMU
 whWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747907667; x=1748512467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aaFSaf23Koy2JTgytHwLuqhpvUUPb3U0eibHAUGSHAE=;
 b=CQTh49AtoDMqpGWGaF+yYpNeAH1OlwqtgVLXU/hS/06QrPVYAaklHIW54oqrJnaH5X
 Te6V7DwpK5zNO02lUvHN45afSm/EujFI0v6+3Z/7MwBbYr03gK856+DElveuRL//GxlJ
 Grry7ONxol2vPciZmNyoc5SlBBeaReAVjNILntV/1KLpS6Ifjh4jqLPBf5xLOkz8o+MO
 qEkqLcdGhC0+6Ph2gkeAmcD9KhxhHPPkPb5Yb1fwFYBPocZJol3rVFlgAflGvewBgWHz
 qv6Uc3a+3x4MfgWmC9oN6+PUQ1ZAcabmZxNNUpvI8MXeoKvCheXV5KHarbUJgVXpWBwv
 XlNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyo1VYc2zUE+iiarS5qYl5lD550gm2AsgwOkSbLywVO8v8bTBcywk8o/iAF9n17eAFRJRnTNpsoQ8D@nongnu.org
X-Gm-Message-State: AOJu0YxAhky6rTUw1Ipbraqvt2rkE5PKrV24P+aiCRrsfLieVKrRkenf
 jQBILpbxRFBgPHJJEU0udPI5CdA2UEHHlLxlC89UFbeR66cEDj4j+ZM1GSDFpXAVYe8=
X-Gm-Gg: ASbGncvwxOi3v4kzLmhhBcLCnfHZfBb0TA1pKFjJwsN0ku30zlQ6Vw/BDCpAjvgfNqo
 80Cjyl9FUKDS8dKtY0nxnUyNTjgYdXrzQzah8CyWkHA6E4c1EuGeAP3EIIAzpVl+BPIN0HzWoQt
 13CP0vn9S6vcPuQwBf9nwMZLsI72PIoLkg9jpTd1MQHfNYNjAm6Cysd6b2ZGJCDNeiMDvUW5Osk
 AqBcZVF3vkcp2h+FQUD2vXdaXKb/POv+pxtNZslQhxY9EyPjMMuLCUP7L+arfUAjQ51dZO0CekB
 HVEivOXsgi7hdwII8We5gBSKKwSe2XQuL3cavBsmlN80KGGP1SsE+Vg0oMK8fw==
X-Google-Smtp-Source: AGHT+IEjjvXahyD+ZoN6VDhT/fLVUUwGSIJiUMdvYkOUf/B37fx+ADX5fFMGVTX7TzDFaeQVU/99HQ==
X-Received: by 2002:a17:90b:3d85:b0:30e:5042:a8c8 with SMTP id
 98e67ed59e1d1-30e8313d1camr44708085a91.18.1747907667355; 
 Thu, 22 May 2025 02:54:27 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f365c4f84sm5559881a91.14.2025.05.22.02.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 02:54:26 -0700 (PDT)
Message-ID: <d5c429eb-d583-4b9d-85c1-b0636e789e9c@daynix.com>
Date: Thu, 22 May 2025 18:54:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/20] virtio-gpu: fix hang under TCG when unmapping
 blob
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-13-alex.bennee@linaro.org>
 <4d300cca-3ac2-4072-a35c-0b6aef970b26@daynix.com>
 <87bjrl87p5.fsf@draig.linaro.org>
 <83945c43-bfb2-4469-90bd-e3a7c2ca5d89@daynix.com>
 <CAAjaMXZ8acKBSGHvcQOcOnzBDCjFU1SOjse7pHtHWxNeREc2gg@mail.gmail.com>
 <199e7486-7d05-459b-ad51-cb9b130f299f@daynix.com>
 <875xht805w.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <875xht805w.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/05/22 18:28, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/05/22 16:31, Manos Pitsidianakis wrote:
>>> On Thu, May 22, 2025 at 10:03 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/05/22 15:45, Alex Bennée wrote:
>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>
>>>>>> On 2025/05/22 1:42, Alex Bennée wrote:
>>>>>>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>>>> This commit fixes an indefinite hang when using VIRTIO GPU blob
>>>>>>> objects
>>>>>>> under TCG in certain conditions.
>>>>>>> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
>>>>>>> MemoryRegion and attaches it to an offset on a PCI BAR of the
>>>>>>> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
>>>>>>> it.
>>>>>>> Because virglrenderer commands are not thread-safe they are only
>>>>>>> called on the main context and QEMU performs the cleanup in three steps
>>>>>>> to prevent a use-after-free scenario where the guest can access the
>>>>>>> region after it’s unmapped:
>>>>>>> 1. From the main context, the region’s field finish_unmapping is
>>>>>>> false
>>>>>>>        by default, so it sets a variable cmd_suspended, increases the
>>>>>>>        renderer_blocked variable, deletes the blob subregion, and unparents
>>>>>>>        the blob subregion causing its reference count to decrement.
>>>>>>> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>>>>>>>        recalculated, the free callback of the blob region
>>>>>>>        virtio_gpu_virgl_hostmem_region_free is called which sets the
>>>>>>>        region’s field finish_unmapping to true, allowing the main thread
>>>>>>>        context to finish replying to the command
>>>>>>> 3. From the main context, the command is processed again, but this
>>>>>>> time
>>>>>>>        finish_unmapping is true, so virgl_renderer_resource_unmap can be
>>>>>>>        called and a response is sent to the guest.
>>>>>>> It happens so that under TCG, if the guest has no timers configured
>>>>>>> (and
>>>>>>> thus no interrupt will cause the CPU to exit), the RCU thread does not
>>>>>>> have enough time to grab the locks and recalculate the FlatView.
>>>>>>> That’s not a big problem in practice since most guests will assume a
>>>>>>> response will happen later in time and go on to do different things,
>>>>>>> potentially triggering interrupts and allowing the RCU context to run.
>>>>>>> If the guest waits for the unmap command to complete though, it blocks
>>>>>>> indefinitely. Attaching to the QEMU monitor and force quitting the guest
>>>>>>> allows the cleanup to continue.
>>>>>>> There's no reason why the FlatView recalculation can't occur right
>>>>>>> away
>>>>>>> when we delete the blob subregion, however. It does not, because when we
>>>>>>> create the subregion we set the object as its own parent:
>>>>>>>         memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>>>>>> The extra reference is what prevents freeing the memory region
>>>>>>> object in
>>>>>>> the memory transaction of deleting the subregion.
>>>>>>> This commit changes the owner object to the device, which removes
>>>>>>> the
>>>>>>> extra owner reference in the memory region and causes the MR to be
>>>>>>> freed right away in the main context.
>>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>>> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
>>>>>>> Cc: qemu-stable@nongnu.org
>>>>>>> ---
>>>>>>>      hw/display/virtio-gpu-virgl.c | 2 +-
>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>> diff --git a/hw/display/virtio-gpu-virgl.c
>>>>>>> b/hw/display/virtio-gpu-virgl.c
>>>>>>> index 71a7500de9..8fbe4e70cc 100644
>>>>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>>>>> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>>>>          vmr->g = g;
>>>>>>>          mr = g_new0(MemoryRegion, 1);
>>>>>>>      -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size,
>>>>>>> data);
>>>>>>> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>>>>>>>          memory_region_add_subregion(&b->hostmem, offset, mr);
>>>>>>>          memory_region_set_enabled(mr, true);
>>>>>>>
>>>>>>
>>>>>> I suggest dropping this patch for now due to the reason I pointed out
>>>>>> for the first version of this series.
>>>>>
>>>>> This fixes an actual bug - without it we get a hang.
>>>>>
>>>>
>>>> I understand that but it also introduces a regression; "[PATCH v3 14/20]
>>>> ui/gtk-gl-area: Remove extra draw call in refresh" is also a similar case.
>>>>
>>>> Ideally such a bug should be fixed without regression, but I understand
>>>> it is sometimes difficult to do that and postponing the bug resolution
>>>> until figuring out the correct way does not make sense.
>>>>
>>>> In such a case, a bug should be fixed minimizing the regression and the
>>>> documentation of the regression should be left in the code.
>>>>
>>>> In particular, this patch can cause use-after-free whether TCG is used
>>>> or not. Instead, I suggest to avoid freeing memory regions at all on
>>>> TCG. It will surely leak memory, but won't result in use-after-free at
>>>> least and the other accelerators will be unaffected.
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>> We tested this fix with ASAN and didn't see anything. Do you have a
>>> test case in mind that can reproduce this use-after-free? It'd help
>>> make a certain decision on whether to drop this patch or not. I'm not
>>> doubting that this can cause a use-after-free by the way, it's just
>>> that it is hypothetical only. If it causes a use-after-free for sure
>>> we should definitely drop it.
>>
>> No, I don't have a test case and it should rarely occur. More
>> concretely, a UAF occurs if the guest accesses the memory region while
>> trying to unmap it. It is just a theory indeed, but the theory says
>> the UAF is possible.
> 
> I have a test case this fixes which I think trumps a theoretical UAF
> without a test case.
> 
> Why would the guest attempt to access after triggering the free itself?
> Wouldn't it be correct to fault the guest for violating its own memory
> safety rules?

docs/devel/secure-coding-practices.rst says "Unexpected accesses must 
not cause memory corruption or leaks in QEMU".

I'm not completely sure whether it is safe without concurrent accesses 
either. In particular, KVM does not immediately update the guest memory 
mapping, so it may result in a time window where the guest memory is 
mapped to an unmapped host memory region, and I suspect that could cause 
a problem. That also motivates limiting the scope of the change to TCG.

> 
>>>> Instead, I suggest to avoid freeing memory regions at all on
>>>> TCG. It will surely leak memory, but won't result in use-after-free at
>>>> least and the other accelerators will be unaffected.
>>> Leaking memory for blob objects is also not ideal, since they are
>>> frequently allocated. It's memory-safe but the leak can accumulate
>>> over time.
>>>
>>
>> Memory safety and leak free cannot be compatible unless RCU is fixed.
>> We need to choose either of them.
> 
> How can the guest access something that is now unmapped? The RCU should
> only run after the flatview has been updated.

This patch bypasses RCU. That's why it solves the hang even though the 
RCU itself is not fixed.

Let me summarize the theory and the actual behavior below:

The theory is that RCU satisfies the common requirement of concurrent 
algorithms. More concretely:
1) It is race-free; for RCU, it means it prevents use-after-free.
2) It does not prevent forward progress.

The patch message suggests 2) is not satisfied. A proper fix would be to 
change RCU to satisfy 2).

However, this patch workarounds the problem by circumventing RCU, which 
solves 2) but it regresses 1).

My suggestion is to document and to limit the impact of 1) by:
a) Limiting the scope of the change to TCG.
b) Not freeing memory regions, which will prevent use-after-free while 
leaking memory.

Manos said b) can be problematic because mappings are frequently 
created. Whether b) makes sense or not depends on the probability and 
impact of UAF and memory leak.

Regards,
Akihiko Odaki

