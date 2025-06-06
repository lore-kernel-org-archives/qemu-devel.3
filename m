Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB23C5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNU8C-0002aO-RW; Fri, 06 Jun 2025 06:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNU88-0002Z5-Am
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:16:59 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNU84-0000nB-Sg
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:16:54 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-604f26055c6so6024349a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749205011; x=1749809811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UikEJ81MNENXFoo/Ycn310wAJxzi7CV52YomLicIYtc=;
 b=zg2G0gs0pdyYvtu+jxyvjfKuj34IM3ZB8CoaMIHUCOFz+0Ela1p7KP6ERaMFsjCT2W
 z0rqhuMqxBvWOW6KtdXJjq8iChB8h3g+b3x43G2FpHDGPuo1O8CKNT5/J+XFRhAgQxXL
 GruMgYcYNdWxxj2HbaA3YhofxShK8U/Ag4pS8Gb6sPNtbYJb8Vvqj8w5Eq+F+8lGLioj
 xwBzeEI4av/DRGbNnpJKcO+MrqC3QQd2who4JiERUfv61qPS4c+byIRz0MvbsuFm7Cs6
 qjSuAQ2n+oEdSJmhDJ7vYFmCA2ilK45OfV8TpptjOH2OPG0hZeArT3u4+ibycUdBVCnK
 6Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749205011; x=1749809811;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UikEJ81MNENXFoo/Ycn310wAJxzi7CV52YomLicIYtc=;
 b=DRE4SBw+OqBeg4smv+3eEwcNQ1YZ/ON9Mku0FJ2Nr5nh7yWP0zRdzkbYrBfWyjjbSz
 e3WilxZsF5598koPUrocqj7pSXWR7Z5scUZMGr3dnqAy4FO5g2mrLzX1pFbKq36QaDuA
 voQaNo1GPCXgcitQ2EDLkZt6L4GmIuIkOAVVAxmcWYEnVU1MNos/31Jax/RlQSZubzsD
 JpqwbSRTw1VH7jY4XpY9YFwDL5H9eK/Pxdi/v0ZrV3Lqxsik6iyaOY0J2JLqDEx43DPN
 jaaPwljItsWgxr8kyb5ZsWhpkG11/3hk1SV3oxe2nuu7y6HXiLuVzUCyr9UGh26u1B5C
 ERTw==
X-Gm-Message-State: AOJu0YwFnI8pPjU6iJEpK8kxs0DTHLKdhlDrcjCjMumtlWVrW80HQVEF
 FsrdX8EBsnEqxCPMUz8J9KyJzgSRFqjj+2QG21kKPRgPFhVdLYZ+GnyLrWoNrIi0GJNPEa7gPXp
 QljvXtK8=
X-Gm-Gg: ASbGnctcv1a+l443IZmbkDhEMRMP7iGQguQ4WSDLG1537c9yyP4L0DssMQoZEtrn19t
 93zChLw8ExVt0mTPUvDtxRq/wnI6NMmOc8h3tf1h9HxZNUw2Zm8/xOvod+5Ryldxi6m07+Deuz1
 Kf6GBkwjtUEL/qYHn3Xplr4YPuLZaHArBJOkJPT1fWw1rkxyhfcemxvGv5+wIryWuPqO0l4V4dB
 IkYzS5EPX4nNDzT7U3xjAPdiP/ZdGHItUj4pajNPMapY4hbhTE/8S7sdTi/5WiJzmJyaGBXKeDb
 Iioa0WAEQAeoIHIZg0y9rYfudTO2g+Qbfk/LoBUiW1sx0MEFEN8jwAj2kI80QtM=
X-Google-Smtp-Source: AGHT+IF9tbwwADZS/N8zhsgA6iNmMmf7EL+DxRkXLTGBEwjneswhb2tGWWQ5eP8u2NusSai/TJKdTA==
X-Received: by 2002:a17:907:7ba1:b0:ad8:93a3:29a0 with SMTP id
 a640c23a62f3a-ade1a9de788mr247876966b.18.1749204997675; 
 Fri, 06 Jun 2025 03:16:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc7b202sm91694966b.161.2025.06.06.03.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 03:16:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6905C5F7E1;
 Fri, 06 Jun 2025 11:16:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  John
 Snow <jsnow@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Gustavo Romero <gustavo.romero@linaro.org>,  Markus
 Armbruster <armbru@redhat.com>,  David Hildenbrand <david@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  qemu-stable@nongnu.org
Subject: Re: [PATCH v4 09/17] hw/display: re-arrange memory region tracking
In-Reply-To: <5f91c8a2-06ce-45f8-97bd-0602a52e0d21@daynix.com> (Akihiko
 Odaki's message of "Fri, 6 Jun 2025 18:40:06 +0900")
References: <20250603110204.838117-1-alex.bennee@linaro.org>
 <20250603110204.838117-10-alex.bennee@linaro.org>
 <1a86b86d-145a-44fc-9f87-2804767fb109@daynix.com>
 <87o6v2764e.fsf@draig.linaro.org>
 <5f91c8a2-06ce-45f8-97bd-0602a52e0d21@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 06 Jun 2025 11:16:36 +0100
Message-ID: <87tt4t41kr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/06/05 20:57, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2025/06/03 20:01, Alex Benn=C3=A9e wrote:
>>>> QOM objects can be embedded in other QOM objects and managed as part
>>>> of their lifetime but this isn't the case for
>>>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>>>> need some other way of associating the wider data structure with the
>>>> memory region.
>>>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>>>> to
>>>> MemoryRegionOps for device type regions but is unused in the
>>>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>>>> reference and allow the final MemoryRegion object to be reaped when
>>>> its reference count is cleared.
>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>>>> Cc: qemu-stable@nongnu.org
>>>> ---
>>>>    include/system/memory.h       |  1 +
>>>>    hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>>>>    2 files changed, 9 insertions(+), 15 deletions(-)
>>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>>> index fc35a0dcad..90715ff44a 100644
>>>> --- a/include/system/memory.h
>>>> +++ b/include/system/memory.h
>>>> @@ -784,6 +784,7 @@ struct MemoryRegion {
>>>>        DeviceState *dev;
>>>>          const MemoryRegionOps *ops;
>>>> +    /* opaque data, used by backends like @ops */
>>>>        void *opaque;
>>>>        MemoryRegion *container;
>>>>        int mapped_via_alias; /* Mapped via an alias, container might b=
e NULL */
>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-vir=
gl.c
>>>> index 145a0b3879..71a7500de9 100644
>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>> @@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>>>>      #if VIRGL_VERSION_MAJOR >=3D 1
>>>>    struct virtio_gpu_virgl_hostmem_region {
>>>> -    MemoryRegion mr;
>>>> +    MemoryRegion *mr;
>>>>        struct VirtIOGPU *g;
>>>>        bool finish_unmapping;
>>>>    };
>>>>    -static struct virtio_gpu_virgl_hostmem_region *
>>>> -to_hostmem_region(MemoryRegion *mr)
>>>> -{
>>>> -    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, m=
r);
>>>> -}
>>>> -
>>>>    static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>>>    {
>>>>        VirtIOGPU *g =3D opaque;
>>>> @@ -73,14 +67,12 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *=
opaque)
>>>>    static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>>>>    {
>>>>        MemoryRegion *mr =3D MEMORY_REGION(obj);
>>>> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>>>> +    struct virtio_gpu_virgl_hostmem_region *vmr =3D mr->opaque;
>>>>        VirtIOGPUBase *b;
>>>>        VirtIOGPUGL *gl;
>>>>    -    vmr =3D to_hostmem_region(mr);
>>>> -    vmr->finish_unmapping =3D true;
>>>> -
>>>>        b =3D VIRTIO_GPU_BASE(vmr->g);
>>>> +    vmr->finish_unmapping =3D true;
>>>>        b->renderer_blocked--;
>>>>          /*
>>>> @@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>          vmr =3D g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>>>>        vmr->g =3D g;
>>>> +    mr =3D g_new0(MemoryRegion, 1);
>>>
>>> This patch does nothing more than adding a separate allocation for
>>> MemoryRegion. Besides there is no corresponding g_free(). This patch
>>> can be simply dropped.
>> As the patch says the MemoryRegion is now free'd when it is
>> de-referenced. Do you have a test case showing it leaking?
>
> "De-referenced" is confusing and sounds like pointer dereferencing.
>
> OBJECT(mr)->free, which has virtio_gpu_virgl_hostmem_region_free() as
> its value, will be called to free mr when the references of mr are
> removed. This patch however does not add a corresponding g_free() call
> to virtio_gpu_virgl_hostmem_region_free(), leaking mr.
>
> AddressSanitizer will catch the memory leak.

Example invocation?

I ran the AddressSantizier against all the virtio-gpu tests yesterday
and it did not complain.

>
> Regards,
> Akihiko Odaki

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

