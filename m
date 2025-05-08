Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A318AC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzgQ-0006Nq-0y; Thu, 08 May 2025 07:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uCzgO-0006NR-HJ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:44:56 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uCzgL-0006Sp-Ma
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:44:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e661313a3so8759715ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746704692; x=1747309492;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y4mN7lAZSTS1MUAScK+xPavY/LezpV88F45AFAl8d08=;
 b=DewpfGT2aHj/g3dlpHBvwl1LAbiIxTzA8Mk9HRFqzLOTeum9sGuOO2MbtvAplZOizr
 z8VSaSD/DrtCjmObIk1aoScWwn+5Yo9Qfy5tIJSxFmJtH99U1coAc7HIFB6nOMcgiAy2
 7y7szla1OxmqbcvBHIAVlmmBoucrYeYpLrxMuLHpORweFIvZY7xvJ/uV0MOFvpXS8qa4
 7ugz7q2WpTRGFndqZU767oCd6NePMJvGj2NsTPcVwgqjJvihh2g6psq/YxRKMzP2HEOl
 KnLK0cUcn+09w9kUSDajpp7dG4L8Ujcj+9RXYGWAs2YMXKXs5BEG6Jsan1YinIY1DnWa
 mFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746704692; x=1747309492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y4mN7lAZSTS1MUAScK+xPavY/LezpV88F45AFAl8d08=;
 b=kPA3tNBmUHDsD3v8VSEBOS/ZimWftVi7Q49enC7e59mrTqRVsiHyn398JVQgpbt2hE
 i5NgNqMPolzay0yXKRj9yn5oPHRGznZEIQLp/fldA282REFWRdK3uRE6e5f583vj+XNc
 0jQEOsONIyqqzASC2a1E+Cu1cCoEMCauuCAO3/wTDMhDTpyZXgST0EDND0U9jmzuwvdI
 WIxeXRQgbDGojMffwZef91cnth6aPyCZyyMAJnAny6mEo1KA4Y3wSY4Nopagu0iIBylX
 h4wFti641zGgQKWg17/XyJFqEyww4/o3HjfoJocZBOoVXXF71GgthxM4hMYO3rp+iB/T
 z1Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjaet3QZYpXtO2dNHsXQXqcEeihIgIrD/BabzUdqWajThUy/H3fcN+3BEj4mKkpQNJB07dnxkLKEA5@nongnu.org
X-Gm-Message-State: AOJu0YxbmM7GA2wPOQ0RisTFC3CKGdrdAu9Qn6fyp1vDH0Z9eXef8/ZY
 aPGC0Wy4BSNsu5apk5lMcufQhnTNfa7F5AYKtbqnzed9knXNEZI+uw9hh3wI6U4=
X-Gm-Gg: ASbGnctV2sR19tQStCaDMSEJtUwk7sHJZBwKDUvzAqUVlnGKmKD8zclMXy1oyf3tQCi
 7NH7yVbTDrpIbyM6Wdo5qpZtCkw+21lCcGYyI1jkWcY1zk/4S3Wxr6pfvyRELuTmS7X8Nthje8c
 E5i4PEoTZL0EjJZ6Q9cEqigz7RWFXdeOnpaUk6oa+wR3k9VlBBZhQEFi0cXb7MCxPuZ99wVI3yA
 ShBRE4cqVKraIGe///9x3EyTpV2J/8YQgudazVyaMcaS71wTavb5sxIYLI7SNone1ScXbEeZfSk
 qAITbBXHxwKcgEg7Mp6+GAqZqRxiuEHTysaQ2kgCjUt6drrjVmc=
X-Google-Smtp-Source: AGHT+IFnw/m9PRjlh4N4SXn3THy7SpJiEbWIMiOoRDJTVi5CQcdIexmcz36u0NBm6QxcbpgvSSFZbQ==
X-Received: by 2002:a17:903:fa4:b0:22d:e57a:2795 with SMTP id
 d9443c01a7336-22e5edea81bmr106096045ad.47.1746704691787; 
 Thu, 08 May 2025 04:44:51 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e188285f8sm100724905ad.46.2025.05.08.04.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:44:51 -0700 (PDT)
Message-ID: <00c07484-4882-4ad2-97cb-b0ec250f8b5b@daynix.com>
Date: Thu, 8 May 2025 20:44:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] virtio-gpu: fix hang under TCG when unmapping blob
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-stable@nongnu.org
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-9-alex.bennee@linaro.org>
 <8b123991-21f2-47b5-851d-6b53fbfaa691@collabora.com>
 <8994da6c-a369-40c7-b1c6-433519ba90a5@daynix.com>
 <874ixyoxnx.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <874ixyoxnx.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2025/05/06 19:12, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/04/30 3:48, Dmitry Osipenko wrote:
>>> On 4/28/25 15:59, Alex BennÃ©e wrote:
>>>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>
>>>> This commit fixes an indefinite hang when using VIRTIO GPU blob objects
>>>> under TCG in certain conditions.
>>>>
>>>> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
>>>> MemoryRegion and attaches it to an offset on a PCI BAR of the
>>>> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
>>>> it.
>>>>
>>>> Because virglrenderer commands are not thread-safe they are only
>>>> called on the main context and QEMU performs the cleanup in three steps
>>>> to prevent a use-after-free scenario where the guest can access the
>>>> region after it’s unmapped:
>>>>
>>>> 1. From the main context, the region’s field finish_unmapping is false
>>>>      by default, so it sets a variable cmd_suspended, increases the
>>>>      renderer_blocked variable, deletes the blob subregion, and unparents
>>>>      the blob subregion causing its reference count to decrement.
>>>>
>>>> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>>>>      recalculated, the free callback of the blob region
>>>>      virtio_gpu_virgl_hostmem_region_free is called which sets the
>>>>      region’s field finish_unmapping to true, allowing the main thread
>>>>      context to finish replying to the command
>>>>
>>>> 3. From the main context, the command is processed again, but this time
>>>>      finish_unmapping is true, so virgl_renderer_resource_unmap can be
>>>>      called and a response is sent to the guest.
>>>>
>>>> It happens so that under TCG, if the guest has no timers configured (and
>>>> thus no interrupt will cause the CPU to exit), the RCU thread does not
>>>> have enough time to grab the locks and recalculate the FlatView.
>>>>
>>>> That’s not a big problem in practice since most guests will assume a
>>>> response will happen later in time and go on to do different things,
>>>> potentially triggering interrupts and allowing the RCU context to run.
>>>> If the guest waits for the unmap command to complete though, it blocks
>>>> indefinitely. Attaching to the QEMU monitor and force quitting the guest
>>>> allows the cleanup to continue.
>>
>> The RCU thread should be free to kick in if the guest is waiting and
>> idle. That may be a problem that should be analyzed and fixed.
>>
>>>>
>>>> There's no reason why the FlatView recalculation can't occur right away
>>>> when we delete the blob subregion, however. It does not, because when we
>>>> create the subregion we set the object as its own parent:
>>>>
>>>>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>>>
>>>> The extra reference is what prevents freeing the memory region object in
>>>> the memory transaction of deleting the subregion.
>>>>
>>>> This commit changes the owner object to the device, which removes the
>>>> extra owner reference in the memory region and causes the MR to be
>>>> freed right away in the main context.
>>>>
>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
>>>> Cc: qemu-stable@nongnu.org
>>>> ---
>>>>    hw/display/virtio-gpu-virgl.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>>> index 71a7500de9..8fbe4e70cc 100644
>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>        vmr->g = g;
>>>>        mr = g_new0(MemoryRegion, 1);
>>>>    -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size,
>>>> data);
>>>> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>>>>        memory_region_add_subregion(&b->hostmem, offset, mr);
>>>>        memory_region_set_enabled(mr, true);
>>>>    
>>> This change makes QEMU to crash.
>>> AFAICT, it effectively reverts code to old bugged version [1] that
>>> was
>>> rejected in the past.
>>> +Akihiko Odaki
>>> [1]
>>> https://lore.kernel.org/qemu-devel/20230915111130.24064-10-ray.huang@amd.com/
>>
>> I think you are right.
>>
>> Changing the owner indeed makes the MR to be freed right away, but
>> this is because it makes a reference by the FlatView to the MR
>> dangling and can lead to use-after-free.
>>
>> Setting the owner to the device implies that the device keeps the
>> storage of the MR and. The references to the MR must be counted by the
>> device to keep the storage available in such a case.
> 
> Well the lifetime of the region is effectively controlled by the virgl
> resource manager. There is a disconnect between when we can finally free
> the MR and when the virglrenderer is done with it.
> 
>> The MR itself doesn't count the references. It is fine as long as the
>> MR is kept alive by being parented by the device, but
>> virtio_gpu_virgl_unmap_resource_blob() unparents the MR and breaks the
>> assumption. That's why the device shouldn't be the the owner of the
>> MR.
> 
> Then who should? Ultimately some object needs to "own" the MR until we
> know it can be freed (so no longer mapped into the guest and no longer
> referenced by virglrenderer). The normal MR refcounting isn't enough
> because the lifetime extends beyond when it is "visible" in the FlatView.

The current code makes the MR "own" itself. This works because the 
references are kept counted by the MR's own reference counter just like 
a normal Object.

Regards,
Akihiko Odaki

