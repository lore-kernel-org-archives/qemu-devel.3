Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D2EC5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 10:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOCqx-0004FT-0d; Sun, 08 Jun 2025 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uOCqt-0004F2-Tb
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 06:02:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uOCqr-0002Za-2f
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 06:02:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-234d3261631so23877495ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749376923; x=1749981723;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hZavyLoFgQnVu2C8zewgsMaHdePrvtquamgJX6i7HKc=;
 b=O9rhOSpsIb2CIVF436LN7DifWsJgRq7eosdNHDrYdsMjGTIL6fRCK78M4Qg8WAlFUa
 hpIeypo9iKqcBHEEycVBE1BBbOl+ryAxdfT97vmtPi5u0CUnFo59u977uZOyFiSp/OqB
 ug4+EhYOFd25OfEmclrWs+UKya4OZ37k1T9yvY8jlZHBijElC5CwMqsQ8+LwwtIINfE+
 IKr+yC02RN4tv90AiiZt4mRA/6Z29UqFnu1v/hDm8P0efaNaC/pyo4fk8LfVaUelFi6x
 NrhvpiqAKitjN2jB5ALMoevXRT22L/cv3RXjiFXVyKxkbib2n0IJtl5oWrxhKprksZs4
 7YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749376923; x=1749981723;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hZavyLoFgQnVu2C8zewgsMaHdePrvtquamgJX6i7HKc=;
 b=Ol3XWw/L/GAvcWECDqhPRm2MLcrOzmjrFDmidKLNVI6P7KPVArivWFuwPAT3tH9pSy
 0slgjrRjik0T98WSGPrHy8aUHCNzfjMlofAMgOu7hvWYaiRXBsCEeANM0T12Mj2SDX0R
 5y8aZnxXm3VAHLJT+nTigE9o9vWGiDNa4sY3QDYaPZyxrLlMv5tEeIeSbgsabjDqIQgn
 8tCidC2UPDv/QCB2RF2JUAXqMuFovKjAO82CpsO050XxkmrJRCC8Q8AblUax5uok2/1Q
 Y+yixc5oLaVESJ3yN+vhrA7lVKGJDVKGXRUcs3bhWJp5wmppeqkMD8HOcfA+oAz1KHwK
 JBZQ==
X-Gm-Message-State: AOJu0YwSQltKZ7daUHqSzGydPUnFN0ToedJiZm85iy7MDiODdmRW2m6z
 irQpKxYR5FFdkV7Sky24+3SJqleuFZI2WiJqrf8ZvfBTBNAOKeQaNKj3sEYHCaA2H8k=
X-Gm-Gg: ASbGncu1uGozLMGLjP8pxBPzP69A8iHlprSimBmUWkAe3B0XpH7Mpfmg57IRhqAHt10
 O0mVmj8Y1x3DUm1mArs/r1rm4r9K9hMq4W071ydZRVprOvONm0Q09IWKKWXyhfhtw4JunUlKgNT
 FagqFq8tlGjxxKJSeELA+1FxqJvxGPji23Xh54BAK7H/+XbUY/NqqyLFq2DiLJt1PGMYPEoQaEY
 sI/q5qXc6d+k9ighw6wzrJKrtQeq/6ktp7M2/SYx1o5hC4R0GBDByxVtOrv7IAJTWwFcmgO/OvH
 bIfTVA47gVm5tsGPTVTvv7FUjJmv0SKKBSKXIkNacoZWhy2bvjHbZItDwV/7e9YR
X-Google-Smtp-Source: AGHT+IEJRQbQFiQatiXQNg2WxKcc3DCJ7adIOVe5bpMI/+HsWp/tHBVvJMyKX1m4TEi+HkJ95lVu+w==
X-Received: by 2002:a17:903:2f89:b0:234:f6ba:e68a with SMTP id
 d9443c01a7336-23601deb581mr129971635ad.45.1749376923061; 
 Sun, 08 Jun 2025 03:02:03 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236032ff216sm37364905ad.111.2025.06.08.03.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Jun 2025 03:02:02 -0700 (PDT)
Message-ID: <a0a03a8b-f431-4ad8-8ee5-80ca660325d3@daynix.com>
Date: Sun, 8 Jun 2025 19:01:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] hw/display: re-arrange memory region tracking
From: Akihiko Odaki <akihiko.odaki@daynix.com>
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
 <69ab9a77-0e31-4c3a-91de-d8bea9d87a0a@daynix.com>
Content-Language: en-US
In-Reply-To: <69ab9a77-0e31-4c3a-91de-d8bea9d87a0a@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2025/06/07 0:02, Akihiko Odaki wrote:
> 
> 
> On 2025/06/06 19:16, Alex Bennée wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>
>>> On 2025/06/05 20:57, Alex Bennée wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2025/06/03 20:01, Alex Bennée wrote:
>>>>>> QOM objects can be embedded in other QOM objects and managed as part
>>>>>> of their lifetime but this isn't the case for
>>>>>> virtio_gpu_virgl_hostmem_region. However before we can split it 
>>>>>> out we
>>>>>> need some other way of associating the wider data structure with the
>>>>>> memory region.
>>>>>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>>>>>> to
>>>>>> MemoryRegionOps for device type regions but is unused in the
>>>>>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>>>>>> reference and allow the final MemoryRegion object to be reaped when
>>>>>> its reference count is cleared.
>>>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>>>>>> Cc: qemu-stable@nongnu.org
>>>>>> ---
>>>>>>     include/system/memory.h       |  1 +
>>>>>>     hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>>>>>>     2 files changed, 9 insertions(+), 15 deletions(-)
>>>>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>>>>> index fc35a0dcad..90715ff44a 100644
>>>>>> --- a/include/system/memory.h
>>>>>> +++ b/include/system/memory.h
>>>>>> @@ -784,6 +784,7 @@ struct MemoryRegion {
>>>>>>         DeviceState *dev;
>>>>>>           const MemoryRegionOps *ops;
>>>>>> +    /* opaque data, used by backends like @ops */
>>>>>>         void *opaque;
>>>>>>         MemoryRegion *container;
>>>>>>         int mapped_via_alias; /* Mapped via an alias, container 
>>>>>> might be NULL */
>>>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio- 
>>>>>> gpu-virgl.c
>>>>>> index 145a0b3879..71a7500de9 100644
>>>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>>>> @@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>>>>>>       #if VIRGL_VERSION_MAJOR >= 1
>>>>>>     struct virtio_gpu_virgl_hostmem_region {
>>>>>> -    MemoryRegion mr;
>>>>>> +    MemoryRegion *mr;
>>>>>>         struct VirtIOGPU *g;
>>>>>>         bool finish_unmapping;
>>>>>>     };
>>>>>>     -static struct virtio_gpu_virgl_hostmem_region *
>>>>>> -to_hostmem_region(MemoryRegion *mr)
>>>>>> -{
>>>>>> -    return container_of(mr, struct 
>>>>>> virtio_gpu_virgl_hostmem_region, mr);
>>>>>> -}
>>>>>> -
>>>>>>     static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>>>>>     {
>>>>>>         VirtIOGPU *g = opaque;
>>>>>> @@ -73,14 +67,12 @@ static void 
>>>>>> virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>>>>>     static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>>>>>>     {
>>>>>>         MemoryRegion *mr = MEMORY_REGION(obj);
>>>>>> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>>>>>> +    struct virtio_gpu_virgl_hostmem_region *vmr = mr->opaque;
>>>>>>         VirtIOGPUBase *b;
>>>>>>         VirtIOGPUGL *gl;
>>>>>>     -    vmr = to_hostmem_region(mr);
>>>>>> -    vmr->finish_unmapping = true;
>>>>>> -
>>>>>>         b = VIRTIO_GPU_BASE(vmr->g);
>>>>>> +    vmr->finish_unmapping = true;
>>>>>>         b->renderer_blocked--;
>>>>>>           /*
>>>>>> @@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>>>           vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>>>>>>         vmr->g = g;
>>>>>> +    mr = g_new0(MemoryRegion, 1);
>>>>>
>>>>> This patch does nothing more than adding a separate allocation for
>>>>> MemoryRegion. Besides there is no corresponding g_free(). This patch
>>>>> can be simply dropped.
>>>> As the patch says the MemoryRegion is now free'd when it is
>>>> de-referenced. Do you have a test case showing it leaking?
>>>
>>> "De-referenced" is confusing and sounds like pointer dereferencing.
>>>
>>> OBJECT(mr)->free, which has virtio_gpu_virgl_hostmem_region_free() as
>>> its value, will be called to free mr when the references of mr are
>>> removed. This patch however does not add a corresponding g_free() call
>>> to virtio_gpu_virgl_hostmem_region_free(), leaking mr.
>>>
>>> AddressSanitizer will catch the memory leak.
>>
>> Example invocation?
>>
>> I ran the AddressSantizier against all the virtio-gpu tests yesterday
>> and it did not complain.
> 
> The following command line triggered the memory leak. The image is a 
> clean Debian 12 installation. I booted the installation, and shut down 
> it by pressing the button on the booted GDM:
> 
> build/qemu-system-x86_64 -drive file=debian12.qcow2 -m 8G -smp 8 -device 
> virtio-vga-gl,blob=on,hostmem=1G -display egl-headless,gl=on -vnc :0 -M 
> q35,accel=kvm
> ==361968==WARNING: ASan doesn't fully support makecontext/swapcontext 
> functions and may produce false positives in some cases!
> ==361968==WARNING: ASan is ignoring requested __asan_handle_no_return: 
> stack type: default top: 0x7bf41d2b8380; bottom 0x7bf2e0f4c000; size: 
> 0x00013c36c380 (5305189248)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> 
> =================================================================
> ==361968==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 816 byte(s) in 3 object(s) allocated from:
>      #0 0x7ff640f50a43 in calloc (/lib64/libasan.so.8+0xe6a43) (BuildId: 
> 6a82bb83b1f19d3f3a2118085acf79daa3b52371)
>      #1 0x7ff64077c901 in g_malloc0 (/lib64/libglib-2.0.so.0+0x48901) 
> (BuildId: 6827394d759bc44f207f57e7ab5f8e6b17e82c1c)
>      #2 0x557fa8080dc5 in virtio_gpu_virgl_map_resource_blob ../hw/ 
> display/virtio-gpu-virgl.c:113
>      #3 0x557fa8080dc5 in virgl_cmd_resource_map_blob ../hw/display/ 
> virtio-gpu-virgl.c:772
>      #4 0x557fa8080dc5 in virtio_gpu_virgl_process_cmd ../hw/display/ 
> virtio-gpu-virgl.c:952
> 
> SUMMARY: AddressSanitizer: 816 byte(s) leaked in 3 allocation(s).

The following command line also reproduced the issue:

LIBGL_ALWAYS_SOFTWARE=1 \
LSAN_OPTIONS=suppressions=<(echo leak:fontconfig) \
build/qemu-system-aarch64 -M virt,accel=kvm -cpu host -smp 8 -m 8G \
-device virtio-gpu-gl,blob=on,hostmem=256M -display gtk,gl=on \
-drive file=Fedora-Workstation-Live-42-1.1.aarch64.iso,format=raw \
-bios /usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.raw \
-serial mon:stdio

Fedora's Live disk allows you to test without installation.

By the way, I tried TCG to reproduce the hang, but I couldn't. I'd 
appreciate if you tell:

- how to reproduce the issue
- whether the CPU usage saturates with 100 %
   (i.e., if the hang is a busy-loop or not).
- the stack traces of all the threads when the hang happens.

Hopefully they will provide more insights into the problem and your fix.

Regards,
Akihiko Odaki

