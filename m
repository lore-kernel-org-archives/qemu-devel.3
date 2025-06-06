Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F93C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYak-00024x-Db; Fri, 06 Jun 2025 11:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNYai-00024Q-Fg
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:02:44 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNYag-0005U0-0K
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:02:44 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6fafb6899c2so25075666d6.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749222160; x=1749826960;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9BAMIL9hV8jWW4Q8+lqzUQSMZs1DJJaHIjLDQyZEqT8=;
 b=QFCbqC3kEZl4zJ7lMUDe0bsVGiOKuF+FKsYTkyJpCwipdV8/cZu66zEHWgZgrEZ26X
 dL1ZbIfNIS6C7dhlX/jkoQ+bMQlqtyNIO4pF8PeTB5xCVpahltAkgTblPYn8jWa8M9DB
 A/F7sdA3d1lpeH4xN4fUjoxDYojwiiE7G6I1OVtIV06fpXybXE8Xb04Grl1aJYKsiB27
 jdCamp7At2+xllh84vfBfhRzoP6jSwgNnAaqUpZuE85u7Q917yLYK88ou1lMt8S9v0aU
 1csELoSIKMm2xRKc2QqM0xJ/2r4D1zKGgXPXDO8jstMjKaIjz3m/eUJzZ3p3U/Nn04o3
 39pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749222160; x=1749826960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9BAMIL9hV8jWW4Q8+lqzUQSMZs1DJJaHIjLDQyZEqT8=;
 b=XMIvjqDu9OdL8iPhwx6sIrOcSVSPEeUZPICcRz2qpLUtDWjqjTnGp9cvABVb7a/oRx
 q0L6SqNOUTlvuZp54tBUUBBsxO3QKH3wPoqf+H1eUfisV8mhgnnkxGIBKh3zruR9ql6O
 3S/TMsoAHxu6Rd6jfNSiV6ADoUXAI2Lf/b1LMcVjDTtGTlWv6JlSImniS8t1eU6RKuRY
 Y5lsZmsMeVRimo6wfkbekUcm2K9khbH7uh+3u4cdt8Bs9m4aNYSm3a+wKYuYmbfFn7yh
 w70tV8fjYRGlwE8EmR5Y5YlgaGv+QSm5aJVsdpciIexxSq2jHe8iRQgOEukvx1QkUyVf
 0tuQ==
X-Gm-Message-State: AOJu0YzhWDpFNNMx63CG1gJf9GgvwOt6Y7gGPubdN7PVcAKupRkxQXsd
 jBK9T+L/RgsjHUlwgKkoUHOUxaFgQd/7bs9OLFxayg2bCJWecb+VA9ulPb6mGEApgaN/hVIMPIV
 WnWKQ
X-Gm-Gg: ASbGncs9Cz85zCoMe2Sp0UJyqKbs31FLp00tScJTml5DKKIcMdJeU5nAwhO+EtKz/9E
 Dw4i6kCEKhd0jymBBN1tgtQitnmDI1D2xzKX+xNCTAeYTHAcqprSKadOg0i+mEI1WCyCKTBvoUZ
 TmA2WVtxIPxHWBihi8zn7zOcRCOJRumeOcennKSoioddhLBdpClkEePpUzDZwymUHSx3GJPT9MB
 bNZtEMSChuJ48KL9iwLrLy8V92di9DxNpCD14msn79/4QLnbyzJtukbwmcLvHmKvSEfr+5+wmwH
 psJ1m269QPIsnK8SADB1uLzqPUG8pbMEHOuBU6GJ3NvlZG7XfVucNhiR0PpJ3A9wTK3E6gH0DPo
 qfFb8NQ5EtWW1P1udnFIn9nNZvHZd+MmmvQeK2504
X-Google-Smtp-Source: AGHT+IHWyJvGJD7tHxI9Bm35mwMFBmkqDB72n+i5KCq+24/nbdhBoqk9bvjxESqCTUobnQpJF8RhHg==
X-Received: by 2002:a17:902:ccc8:b0:234:595d:a58e with SMTP id
 d9443c01a7336-23603a651cdmr44734015ad.25.1749222149796; 
 Fri, 06 Jun 2025 08:02:29 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236030926a5sm13333645ad.58.2025.06.06.08.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 08:02:29 -0700 (PDT)
Message-ID: <69ab9a77-0e31-4c3a-91de-d8bea9d87a0a@daynix.com>
Date: Sat, 7 Jun 2025 00:02:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] hw/display: re-arrange memory region tracking
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-stable@nongnu.org
References: <20250603110204.838117-1-alex.bennee@linaro.org>
 <20250603110204.838117-10-alex.bennee@linaro.org>
 <1a86b86d-145a-44fc-9f87-2804767fb109@daynix.com>
 <87o6v2764e.fsf@draig.linaro.org>
 <5f91c8a2-06ce-45f8-97bd-0602a52e0d21@daynix.com>
 <87tt4t41kr.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87tt4t41kr.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qv1-xf30.google.com
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



On 2025/06/06 19:16, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/06/05 20:57, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2025/06/03 20:01, Alex Bennée wrote:
>>>>> QOM objects can be embedded in other QOM objects and managed as part
>>>>> of their lifetime but this isn't the case for
>>>>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>>>>> need some other way of associating the wider data structure with the
>>>>> memory region.
>>>>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>>>>> to
>>>>> MemoryRegionOps for device type regions but is unused in the
>>>>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>>>>> reference and allow the final MemoryRegion object to be reaped when
>>>>> its reference count is cleared.
>>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> ---
>>>>>     include/system/memory.h       |  1 +
>>>>>     hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>>>>>     2 files changed, 9 insertions(+), 15 deletions(-)
>>>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>>>> index fc35a0dcad..90715ff44a 100644
>>>>> --- a/include/system/memory.h
>>>>> +++ b/include/system/memory.h
>>>>> @@ -784,6 +784,7 @@ struct MemoryRegion {
>>>>>         DeviceState *dev;
>>>>>           const MemoryRegionOps *ops;
>>>>> +    /* opaque data, used by backends like @ops */
>>>>>         void *opaque;
>>>>>         MemoryRegion *container;
>>>>>         int mapped_via_alias; /* Mapped via an alias, container might be NULL */
>>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>>>> index 145a0b3879..71a7500de9 100644
>>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>>> @@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>>>>>       #if VIRGL_VERSION_MAJOR >= 1
>>>>>     struct virtio_gpu_virgl_hostmem_region {
>>>>> -    MemoryRegion mr;
>>>>> +    MemoryRegion *mr;
>>>>>         struct VirtIOGPU *g;
>>>>>         bool finish_unmapping;
>>>>>     };
>>>>>     -static struct virtio_gpu_virgl_hostmem_region *
>>>>> -to_hostmem_region(MemoryRegion *mr)
>>>>> -{
>>>>> -    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
>>>>> -}
>>>>> -
>>>>>     static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>>>>     {
>>>>>         VirtIOGPU *g = opaque;
>>>>> @@ -73,14 +67,12 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>>>>     static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>>>>>     {
>>>>>         MemoryRegion *mr = MEMORY_REGION(obj);
>>>>> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>>>>> +    struct virtio_gpu_virgl_hostmem_region *vmr = mr->opaque;
>>>>>         VirtIOGPUBase *b;
>>>>>         VirtIOGPUGL *gl;
>>>>>     -    vmr = to_hostmem_region(mr);
>>>>> -    vmr->finish_unmapping = true;
>>>>> -
>>>>>         b = VIRTIO_GPU_BASE(vmr->g);
>>>>> +    vmr->finish_unmapping = true;
>>>>>         b->renderer_blocked--;
>>>>>           /*
>>>>> @@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>>           vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>>>>>         vmr->g = g;
>>>>> +    mr = g_new0(MemoryRegion, 1);
>>>>
>>>> This patch does nothing more than adding a separate allocation for
>>>> MemoryRegion. Besides there is no corresponding g_free(). This patch
>>>> can be simply dropped.
>>> As the patch says the MemoryRegion is now free'd when it is
>>> de-referenced. Do you have a test case showing it leaking?
>>
>> "De-referenced" is confusing and sounds like pointer dereferencing.
>>
>> OBJECT(mr)->free, which has virtio_gpu_virgl_hostmem_region_free() as
>> its value, will be called to free mr when the references of mr are
>> removed. This patch however does not add a corresponding g_free() call
>> to virtio_gpu_virgl_hostmem_region_free(), leaking mr.
>>
>> AddressSanitizer will catch the memory leak.
> 
> Example invocation?
> 
> I ran the AddressSantizier against all the virtio-gpu tests yesterday
> and it did not complain.

The following command line triggered the memory leak. The image is a 
clean Debian 12 installation. I booted the installation, and shut down 
it by pressing the button on the booted GDM:

build/qemu-system-x86_64 -drive file=debian12.qcow2 -m 8G -smp 8 -device 
virtio-vga-gl,blob=on,hostmem=1G -display egl-headless,gl=on -vnc :0 -M 
q35,accel=kvm
==361968==WARNING: ASan doesn't fully support makecontext/swapcontext 
functions and may produce false positives in some cases!
==361968==WARNING: ASan is ignoring requested __asan_handle_no_return: 
stack type: default top: 0x7bf41d2b8380; bottom 0x7bf2e0f4c000; size: 
0x00013c36c380 (5305189248)
False positive error reports may follow
For details see https://github.com/google/sanitizers/issues/189

=================================================================
==361968==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 816 byte(s) in 3 object(s) allocated from:
     #0 0x7ff640f50a43 in calloc (/lib64/libasan.so.8+0xe6a43) (BuildId: 
6a82bb83b1f19d3f3a2118085acf79daa3b52371)
     #1 0x7ff64077c901 in g_malloc0 (/lib64/libglib-2.0.so.0+0x48901) 
(BuildId: 6827394d759bc44f207f57e7ab5f8e6b17e82c1c)
     #2 0x557fa8080dc5 in virtio_gpu_virgl_map_resource_blob 
../hw/display/virtio-gpu-virgl.c:113
     #3 0x557fa8080dc5 in virgl_cmd_resource_map_blob 
../hw/display/virtio-gpu-virgl.c:772
     #4 0x557fa8080dc5 in virtio_gpu_virgl_process_cmd 
../hw/display/virtio-gpu-virgl.c:952

SUMMARY: AddressSanitizer: 816 byte(s) leaked in 3 allocation(s).

Regards,
Akihiko Odaki

