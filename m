Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E510BC5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTYk-0005dF-Rx; Fri, 06 Jun 2025 05:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNTYj-0005b0-25
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:40:21 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNTYc-00038P-RP
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:40:20 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so1880929a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749202812; x=1749807612;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=esAWygc9eCcOYXnhqUzkKA5xdMdkCaGowu3g4HIGKF4=;
 b=JD88InJx6XIAfKrdHrxQ8fDNBbBiZ5AZdnMLCCvQn235Px5gGhLmJgftYhCipMVmA4
 cgWl23/uTfRnCu9bPmcZyHVTCXb0QRLHwsYH+xC5+gvV42/TpLWkxLdZn/c467LK2chg
 ktOC2cAHXA2Mv78E0ZzUhy2EGCM+eQ+ZvXU1WnzK37lk8z5K5ee/InrP30vnJo1lbSHw
 2/njAoORminibhHg2bpwxD/dCNirkRKpRocnYrw53t/rnqaZmHoRPvpMHXah0PeYDk8G
 q4Tz9ka/e3Ko5JSPygBanVmFDV3PEx2VcsxFnGE5MOBVbJ4X++DMcNuFaNb48185AWpw
 aOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749202812; x=1749807612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=esAWygc9eCcOYXnhqUzkKA5xdMdkCaGowu3g4HIGKF4=;
 b=jD8SlIu9+/zMPYHbkAPkgI5m+cn++qsRSnpl7nxnLBbVR86tilCkezH/xBzT4yhK1g
 VbEA/QF+uAsHEcd8XGI84W18uo+evi4OZ4UnjcGr9WDJc5urjHgGB/vVupQEuIxUj+1s
 0mq+XoywKTfcU7aimCxDWoVHzPGQpZ3MszJg2azIlmOzh9dyRaEKfo993M/XQUBsyj0y
 YulJyAXz4N7UTkVRt3iv3HqgHA25v+fyYQngDJZRoIb+LKz5wewJVte/aTwhrHco/b8w
 kYMNJKq53Ji6/0a6Gtv36q48yHqERKaznnSQnTA4BJR37XSKvkBQbs3qSnZ8rzCXL5p5
 IABg==
X-Gm-Message-State: AOJu0YzZCvH2zOlLeIgzPUpnWRRUqzFPpirHpsNiutNTDBP5szxF+ebJ
 Xe3O6Lr8EiCvaitAOIEUZLK/qq7ozaAZE34YWT2oTS5ihOUyVQPGImI6lDV/BuiG+Gz32gLSpb2
 Zxrim
X-Gm-Gg: ASbGncs9ObW0RK8YmILY/lBAeaEQjXrONQTgupufT8pTt2EPdXaY8lwvBmIvniHCCB+
 ucynDPXaDpR7wbbo7vySRm99gOB41wCMed0YyUTfNQMpOOCqhrRwUC3T63OEw/e+2zqNrijxDm+
 kJLaSE9idg1jecGVaQfnnm1slgYqe+2YQgUiYNDLhtyVi4AN8M2QYnpNDqNm+TmKVk/X2x5HGIK
 9r1du8InStsBgZ63ForOM3djhcZ6rybtV53WOCSel8U+HtIzKD05MVUfABtRs82LOfjMDV0OppE
 KiqRKGVRKpGRtTkJpYn+Jr1s/p/44rO8qIoe8Rg6CmkR4dO2udaTRecaKByMZxIY
X-Google-Smtp-Source: AGHT+IGBVyPvGf5uZ80vgYoPctKkqm2xqLaepitaeEtfhQ91NtA0+dzX4v/O0NMhXHhTORsu5UDgng==
X-Received: by 2002:a17:90b:3fcb:b0:312:959:dc41 with SMTP id
 98e67ed59e1d1-3134768b6d2mr4418558a91.27.1749202812203; 
 Fri, 06 Jun 2025 02:40:12 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31349f17bc7sm979252a91.7.2025.06.06.02.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 02:40:11 -0700 (PDT)
Message-ID: <5f91c8a2-06ce-45f8-97bd-0602a52e0d21@daynix.com>
Date: Fri, 6 Jun 2025 18:40:06 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87o6v2764e.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
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

On 2025/06/05 20:57, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/06/03 20:01, Alex Bennée wrote:
>>> QOM objects can be embedded in other QOM objects and managed as part
>>> of their lifetime but this isn't the case for
>>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>>> need some other way of associating the wider data structure with the
>>> memory region.
>>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>>> to
>>> MemoryRegionOps for device type regions but is unused in the
>>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>>> reference and allow the final MemoryRegion object to be reaped when
>>> its reference count is cleared.
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>>> Cc: qemu-stable@nongnu.org
>>> ---
>>>    include/system/memory.h       |  1 +
>>>    hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>>>    2 files changed, 9 insertions(+), 15 deletions(-)
>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>> index fc35a0dcad..90715ff44a 100644
>>> --- a/include/system/memory.h
>>> +++ b/include/system/memory.h
>>> @@ -784,6 +784,7 @@ struct MemoryRegion {
>>>        DeviceState *dev;
>>>          const MemoryRegionOps *ops;
>>> +    /* opaque data, used by backends like @ops */
>>>        void *opaque;
>>>        MemoryRegion *container;
>>>        int mapped_via_alias; /* Mapped via an alias, container might be NULL */
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 145a0b3879..71a7500de9 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>>>      #if VIRGL_VERSION_MAJOR >= 1
>>>    struct virtio_gpu_virgl_hostmem_region {
>>> -    MemoryRegion mr;
>>> +    MemoryRegion *mr;
>>>        struct VirtIOGPU *g;
>>>        bool finish_unmapping;
>>>    };
>>>    -static struct virtio_gpu_virgl_hostmem_region *
>>> -to_hostmem_region(MemoryRegion *mr)
>>> -{
>>> -    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
>>> -}
>>> -
>>>    static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>>    {
>>>        VirtIOGPU *g = opaque;
>>> @@ -73,14 +67,12 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>>    static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>>>    {
>>>        MemoryRegion *mr = MEMORY_REGION(obj);
>>> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>>> +    struct virtio_gpu_virgl_hostmem_region *vmr = mr->opaque;
>>>        VirtIOGPUBase *b;
>>>        VirtIOGPUGL *gl;
>>>    -    vmr = to_hostmem_region(mr);
>>> -    vmr->finish_unmapping = true;
>>> -
>>>        b = VIRTIO_GPU_BASE(vmr->g);
>>> +    vmr->finish_unmapping = true;
>>>        b->renderer_blocked--;
>>>          /*
>>> @@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>          vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>>>        vmr->g = g;
>>> +    mr = g_new0(MemoryRegion, 1);
>>
>> This patch does nothing more than adding a separate allocation for
>> MemoryRegion. Besides there is no corresponding g_free(). This patch
>> can be simply dropped.
> 
> As the patch says the MemoryRegion is now free'd when it is
> de-referenced. Do you have a test case showing it leaking?

"De-referenced" is confusing and sounds like pointer dereferencing.

OBJECT(mr)->free, which has virtio_gpu_virgl_hostmem_region_free() as 
its value, will be called to free mr when the references of mr are 
removed. This patch however does not add a corresponding g_free() call 
to virtio_gpu_virgl_hostmem_region_free(), leaking mr.

AddressSanitizer will catch the memory leak.

Regards,
Akihiko Odaki

