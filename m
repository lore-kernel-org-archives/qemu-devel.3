Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2CBC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4eMH-0000je-2w; Tue, 15 Apr 2025 07:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4eME-0000jF-6g
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:21:38 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4eMC-0007KK-1Z
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:21:37 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e6194e9d2cso10816324a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744716093; x=1745320893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hHrYMGEPXrmtKgQQI7MLvBL47tpfhZNVXm6Dc1fUfY=;
 b=MifiaSlvnOeD7/g2DwiL9mAvFU/SB4XLspwQ3bdUTWq7AoPcpnrbeRc6KPNWCHwKO7
 SZ1cpyLshLipA+CwXqgiWj2HqSdlApVWGUZO2fecAMlGzOaldLcTuAZhV7JsWINWctOj
 awMh++zCf8rmUWM9L8k0RGM4ShpfqxnwM1vyiwa+ECEG/Dj4JaE+tdDbBjTW8nSiWM73
 6tw52HwDidtfqtcb+DKuvB5dUEB8Id9vWqf2FaAbpaomQsMB5rPMFIEBj6VWG87RNr6u
 wM4y4R/A00UoCPf+Hn7uVDfyRY+N20Ho+DgvnoLLAPXoQVWmCOJQOELq1lXLgh/XQc2h
 jy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744716093; x=1745320893;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hHrYMGEPXrmtKgQQI7MLvBL47tpfhZNVXm6Dc1fUfY=;
 b=FzhtlJ7fDvRejdfHVJ4Plu2gRom+ZDhX/WtCzPPEYYHj/++nEhf7F49QhFIaTh4zjQ
 sUQBGU3AxZ43GXHWSn2Ekxv5HYdmDmg/u6CjDf0E8EBvPWAfoqS77ciwWRt2at5mRKtr
 vQSu7hbqEPHq8glGtlMlS07HsNzeHMkRCJ5Kq8IWn+3ABupVyirjjGbOAxq6F5MAyCNo
 OdzC1B1qU6Z/2Wldc9kpattBpNfPzjCVJ0TeUu51R3yjbAoIBuoqtuxaLQElP1QbuTKP
 2WSEBeMMF49cVuSlBus4DLqQN2TmxrTy0pQlVTTXmBoQ6zmF0FP3t8yzwFi/U+8QjRL7
 0Fpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVETOdu4IqXqGKV/sqto4qk/6v+v3pvTjyd/3ZJ9s54lzWtlnP7GvaDP5FJ+fq2RWMLPvQPDCJBSUNK@nongnu.org
X-Gm-Message-State: AOJu0YyjhA1JOdY8/GxhFRgO4jQ3a4fOlz+6MWIV13PNMIaUcQJypIgP
 ZkML4xPyMTqJ3EFTe4Cm9hoTHC/HrSQZKuE1pZ1LV9XM/o2dDvY/x9ddL1aGeEI=
X-Gm-Gg: ASbGncuIl/3q1WCd6sR85625RiyR34Q4Fuqd/IZN+Od6veMPc0p0BhX8BFME1HXN2TO
 dWGu1AW33G0zTg/ky2p8BuYlieSoyCI7OURTIrSoMWDtpfZqACk6s1fXoKMsWbdEH2J8d+vas+T
 ZW4vaHrWzi5I2pKAqgIKdeUvi//1PUZnIE0EuL3kwJfIp8du+Gc+H0FiTDtutomcdVi3HQC9MQ1
 0+lispCLQNue1SblPy0s0QzoM5woaEqmRiwREyo8ReZVAeXI/vn1vsPYcvVCN3k0IQlh+oFRgEP
 x/hq7tLFPGHISuoMi5iq9WL8O3vNsURo5lHvq7cWxtQnrdUtphAswA==
X-Google-Smtp-Source: AGHT+IF4xvvAKdRme6AL9CHrPKvbIhHoLT75VZBZoS4RuZblL9bhCbTbjFP0WBkdSZWIirjfePn2yQ==
X-Received: by 2002:a17:906:d7c5:b0:acb:107d:ef51 with SMTP id
 a640c23a62f3a-acb107df1c0mr363297266b.2.1744716093131; 
 Tue, 15 Apr 2025 04:21:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fdcsm1090622666b.176.2025.04.15.04.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 04:21:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 833945F915;
 Tue, 15 Apr 2025 12:21:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,  David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH v2 1/3] hw/display: re-arrange memory region tracking
In-Reply-To: <bdd79b83-8487-479b-ba30-ada01476fdde@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 15 Apr 2025 12:35:39
 +0200")
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
 <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
 <bdd79b83-8487-479b-ba30-ada01476fdde@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 15 Apr 2025 12:21:31 +0100
Message-ID: <871ptteklg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 10/4/25 14:26, Manos Pitsidianakis wrote:
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> QOM objects can be embedded in other QOM objects and managed as part
>> of their lifetime but this isn't the case for
>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>> need some other way of associating the wider data structure with the
>> memory region.
>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>> to
>> MemoryRegionOps for device type regions but is unused in the
>> memory_region_init_ram_ptr() case.
>
> It is unclear to me what layer is supposed to set/consume it. So far
> in memory_region_init_io/ram/rom it is kind of internal to the memory
> layer, but MemoryRegionOps aren't. Yeah well, OK then.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>> Use the opaque to carry the
>> reference and allow the final MemoryRegion object to be reaped when
>> its reference count is cleared.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>   include/exec/memory.h         |  1 +
>>   hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>>   2 files changed, 9 insertions(+), 15 deletions(-)
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index d09af58c97..bb735a3c7e 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -784,6 +784,7 @@ struct MemoryRegion {
>>       DeviceState *dev;
>>         const MemoryRegionOps *ops;
>> +    /* opaque data, used by backends like @ops */
>>       void *opaque;
>>       MemoryRegion *container;
>>       int mapped_via_alias; /* Mapped via an alias, container might be N=
ULL */
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl=
.c
>> index 145a0b3879..71a7500de9 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>>     #if VIRGL_VERSION_MAJOR >=3D 1
>>   struct virtio_gpu_virgl_hostmem_region {
>> -    MemoryRegion mr;
>> +    MemoryRegion *mr;
>>       struct VirtIOGPU *g;
>>       bool finish_unmapping;
>>   };
>>   -static struct virtio_gpu_virgl_hostmem_region *
>> -to_hostmem_region(MemoryRegion *mr)
>> -{
>> -    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
>> -}
>> -
>>   static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>   {
>>       VirtIOGPU *g =3D opaque;
>> @@ -73,14 +67,12 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *op=
aque)
>>   static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>>   {
>>       MemoryRegion *mr =3D MEMORY_REGION(obj);
>> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>> +    struct virtio_gpu_virgl_hostmem_region *vmr =3D mr->opaque;
>>       VirtIOGPUBase *b;
>>       VirtIOGPUGL *gl;
>>   -    vmr =3D to_hostmem_region(mr);
>> -    vmr->finish_unmapping =3D true;
>> -
>>       b =3D VIRTIO_GPU_BASE(vmr->g);
>> +    vmr->finish_unmapping =3D true;
>>       b->renderer_blocked--;
>>         /*
>> @@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>         vmr =3D g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>>       vmr->g =3D g;
>> +    mr =3D g_new0(MemoryRegion, 1);
>>   -    mr =3D &vmr->mr;
>>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>       memory_region_add_subregion(&b->hostmem, offset, mr);
>>       memory_region_set_enabled(mr, true);
>> @@ -131,7 +123,9 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>        * command processing until MR is fully unreferenced and freed.
>>        */
>>       OBJECT(mr)->free =3D virtio_gpu_virgl_hostmem_region_free;
>> +    mr->opaque =3D vmr;
>>   +    vmr->mr =3D mr;
>>       res->mr =3D mr;
>>         return 0;
>> @@ -142,16 +136,15 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>>                                        struct virtio_gpu_virgl_resource =
*res,
>>                                        bool *cmd_suspended)
>>   {
>> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>>       VirtIOGPUBase *b =3D VIRTIO_GPU_BASE(g);
>>       MemoryRegion *mr =3D res->mr;
>> +    struct virtio_gpu_virgl_hostmem_region *vmr;
>
> Same same but different? ;)

Hmm I think I just reflexively put unassigned variables at the bottom of
the list of declarations so they stand out more.

>
>>       int ret;
>>         if (!mr) {
>>           return 0;
>>       }
>> -
>> -    vmr =3D to_hostmem_region(res->mr);
>> +    vmr =3D mr->opaque;
>>         /*
>>        * Perform async unmapping in 3 steps:

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

