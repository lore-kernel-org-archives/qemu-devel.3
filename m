Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA80C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 07:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI0XT-0004Yv-7T; Thu, 22 May 2025 03:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uI0XQ-0004YQ-CS
 for qemu-devel@nongnu.org; Thu, 22 May 2025 03:40:24 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uI0XN-0008SY-9c
 for qemu-devel@nongnu.org; Thu, 22 May 2025 03:40:23 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so4651240a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 00:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747899619; x=1748504419;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JEcGccdnHcYRckmT1Mk8VXQ+DqIZ40eBlOHSPojs6rE=;
 b=MSXWHcGfldOdqaICvLHmsdUljFINjzWfEYfu6ABpDzY3Lw6iBWWYGxYNFHnbPIlp52
 aswUBYmyhImAGpkuOtk2egT1jtotsqDkaKWmqLMeKBQjXpV9ONDJVPQ/3gJgCGoLZnLs
 WLwkQnksNUFrMZvQLTvW6Hk4g+mvoYHuMWidwe9TMgF9PodQ0k7TzogcGs6nPKoreCtz
 UF8hdYbWoXpFSU4fgQXfq48bVFxWaWnLu4HdHQdrh7ThBMKNaF5GfJy6sdoX7VZfgrGJ
 NzYh4LyAPBvDXHL3hN7V/gMsRz5G28GPAtJfInXgZ86UkESz7quWir/alARazI5jDU0S
 3neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747899619; x=1748504419;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JEcGccdnHcYRckmT1Mk8VXQ+DqIZ40eBlOHSPojs6rE=;
 b=TzkI4aRCQLWpDTesgz0lzl544uZaANqE9T3rixYYNnTzNEgkXzdB0K4KJCkfPs2xvA
 GR8bs96sc1rYapEWETScYlu6dy391DGCkroa22WPtWLe/6/ik354cWb74omfE7kjUB+9
 a7xURebIlFWtU/npHR8TUd/nwQydcfGPktamDT+UNDQfipoIdLEJfubeZHVtKEnST0vc
 WcNEooaFHBi5wklPHMizMs/2aCYZiaP9AY7AtT/WwEPoU/brmsi4Tm8KJ1gM8IF7XFdl
 dAy4EGfaOScIlx+7+kMfzhd2E0V5f+euaWr8Jhb66AD/PYODFq5I0adEryddtA0MX6sr
 rNdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMwg08R4QulKIJ9f+agA+TFbt6xCgjkgkpT30rYgNxAd5p6mSqRI4LfdKDHKDWDXWJBNBbiZTWZ849@nongnu.org
X-Gm-Message-State: AOJu0YwGlXDxZj54X/vC2A3FFwx3wEFQ6CA5/PGUDWFCHjLkCq5TIS9F
 8ooWiC1TiJHKaQwqe28PUZIQuNmWH1kwXlAwbXMJT4PvykScRxaD8QZekqP5YmlfdpU=
X-Gm-Gg: ASbGncsLigg3jp2wZCmlArAdodFKQBUIVr+3MeZWGzpJI+w81VE9SLSoDu5ZraGM8wf
 AtzVsRxx9BYe0X9G5vDKLYaC5xns2ZM7thoCQyTeNqCkjOfkPAYGFIYZVBwP8i0XotcAj9NqVC6
 krN6hgS9DE5b/dHSa7qFhic8hPMQl0mcgW3g0InbkGgezvyVnZ10nEkpWIDSVhcLnUuUbecoUG6
 SBmnS/uswyi/4H64WSvifz9IJL4kmyPHgjM2zBB6pETs7dXCBV4HOD3srmpcLUSdlFDJIBnFTLP
 EuEzpO5u4xF4nM8RspHid5jJ17n56m2mpeG4pgwICHEpl7zB/lJ5vywc5GYSlQ==
X-Google-Smtp-Source: AGHT+IHKVz9BAmIbe3UyeYJT62whNh3N71DDQ+/3k55HSKvplD4U+oNev/8be9BUEcYySbXKmJjwnw==
X-Received: by 2002:a17:90b:570b:b0:305:5f32:d9f0 with SMTP id
 98e67ed59e1d1-30e7d540033mr35484206a91.19.1747899619484; 
 Thu, 22 May 2025 00:40:19 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650006esm4936820a91.35.2025.05.22.00.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 00:40:19 -0700 (PDT)
Message-ID: <199e7486-7d05-459b-ad51-cb9b130f299f@daynix.com>
Date: Thu, 22 May 2025 16:40:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/20] virtio-gpu: fix hang under TCG when unmapping
 blob
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAjaMXZ8acKBSGHvcQOcOnzBDCjFU1SOjse7pHtHWxNeREc2gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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

On 2025/05/22 16:31, Manos Pitsidianakis wrote:
> On Thu, May 22, 2025 at 10:03 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/05/22 15:45, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2025/05/22 1:42, Alex Bennée wrote:
>>>>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>> This commit fixes an indefinite hang when using VIRTIO GPU blob
>>>>> objects
>>>>> under TCG in certain conditions.
>>>>> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
>>>>> MemoryRegion and attaches it to an offset on a PCI BAR of the
>>>>> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
>>>>> it.
>>>>> Because virglrenderer commands are not thread-safe they are only
>>>>> called on the main context and QEMU performs the cleanup in three steps
>>>>> to prevent a use-after-free scenario where the guest can access the
>>>>> region after it’s unmapped:
>>>>> 1. From the main context, the region’s field finish_unmapping is
>>>>> false
>>>>>       by default, so it sets a variable cmd_suspended, increases the
>>>>>       renderer_blocked variable, deletes the blob subregion, and unparents
>>>>>       the blob subregion causing its reference count to decrement.
>>>>> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>>>>>       recalculated, the free callback of the blob region
>>>>>       virtio_gpu_virgl_hostmem_region_free is called which sets the
>>>>>       region’s field finish_unmapping to true, allowing the main thread
>>>>>       context to finish replying to the command
>>>>> 3. From the main context, the command is processed again, but this
>>>>> time
>>>>>       finish_unmapping is true, so virgl_renderer_resource_unmap can be
>>>>>       called and a response is sent to the guest.
>>>>> It happens so that under TCG, if the guest has no timers configured
>>>>> (and
>>>>> thus no interrupt will cause the CPU to exit), the RCU thread does not
>>>>> have enough time to grab the locks and recalculate the FlatView.
>>>>> That’s not a big problem in practice since most guests will assume a
>>>>> response will happen later in time and go on to do different things,
>>>>> potentially triggering interrupts and allowing the RCU context to run.
>>>>> If the guest waits for the unmap command to complete though, it blocks
>>>>> indefinitely. Attaching to the QEMU monitor and force quitting the guest
>>>>> allows the cleanup to continue.
>>>>> There's no reason why the FlatView recalculation can't occur right
>>>>> away
>>>>> when we delete the blob subregion, however. It does not, because when we
>>>>> create the subregion we set the object as its own parent:
>>>>>        memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>>>> The extra reference is what prevents freeing the memory region
>>>>> object in
>>>>> the memory transaction of deleting the subregion.
>>>>> This commit changes the owner object to the device, which removes
>>>>> the
>>>>> extra owner reference in the memory region and causes the MR to be
>>>>> freed right away in the main context.
>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> ---
>>>>>     hw/display/virtio-gpu-virgl.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> diff --git a/hw/display/virtio-gpu-virgl.c
>>>>> b/hw/display/virtio-gpu-virgl.c
>>>>> index 71a7500de9..8fbe4e70cc 100644
>>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>>> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>>         vmr->g = g;
>>>>>         mr = g_new0(MemoryRegion, 1);
>>>>>     -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size,
>>>>> data);
>>>>> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>>>>>         memory_region_add_subregion(&b->hostmem, offset, mr);
>>>>>         memory_region_set_enabled(mr, true);
>>>>>
>>>>
>>>> I suggest dropping this patch for now due to the reason I pointed out
>>>> for the first version of this series.
>>>
>>> This fixes an actual bug - without it we get a hang.
>>>
>>
>> I understand that but it also introduces a regression; "[PATCH v3 14/20]
>> ui/gtk-gl-area: Remove extra draw call in refresh" is also a similar case.
>>
>> Ideally such a bug should be fixed without regression, but I understand
>> it is sometimes difficult to do that and postponing the bug resolution
>> until figuring out the correct way does not make sense.
>>
>> In such a case, a bug should be fixed minimizing the regression and the
>> documentation of the regression should be left in the code.
>>
>> In particular, this patch can cause use-after-free whether TCG is used
>> or not. Instead, I suggest to avoid freeing memory regions at all on
>> TCG. It will surely leak memory, but won't result in use-after-free at
>> least and the other accelerators will be unaffected.
>>
>> Regards,
>> Akihiko Odaki
> 
> We tested this fix with ASAN and didn't see anything. Do you have a
> test case in mind that can reproduce this use-after-free? It'd help
> make a certain decision on whether to drop this patch or not. I'm not
> doubting that this can cause a use-after-free by the way, it's just
> that it is hypothetical only. If it causes a use-after-free for sure
> we should definitely drop it.

No, I don't have a test case and it should rarely occur. More 
concretely, a UAF occurs if the guest accesses the memory region while 
trying to unmap it. It is just a theory indeed, but the theory says the 
UAF is possible.

> 
>> Instead, I suggest to avoid freeing memory regions at all on
>> TCG. It will surely leak memory, but won't result in use-after-free at
>> least and the other accelerators will be unaffected.
> 
> Leaking memory for blob objects is also not ideal, since they are
> frequently allocated. It's memory-safe but the leak can accumulate
> over time.
 >

Memory safety and leak free cannot be compatible unless RCU is fixed. We 
need to choose either of them.

Regards,
Akihiko Odaki

