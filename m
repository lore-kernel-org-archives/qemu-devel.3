Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0CFC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9Ed-0003cW-S2; Thu, 05 Jun 2025 07:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uN9EO-000396-0k
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:58:03 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uN9EL-0003Zo-5a
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:57:59 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad56cbc7b07so136332666b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 04:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749124675; x=1749729475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9x+UzHHsG2rMsf5Ov8O6nvfpk+Be90BavCWIL+ByDU=;
 b=wSye8eqnnvHgvRhjzj8bLAUmDfm7To75k/P9WzxZWcVANdWjgkqoaw9yiR2720S9DT
 cLkdmnZgCegowBL7GAlWYfgLuZ5akEztfclvFmjCHHUq045RJDM9ilFjleD5mnqO0uo2
 UnRI3aSLYnSucSTx/qn08DjfVQDQbp6r5qA67CQ7p5xvlhAlswL3OVAVP49FIFWUKDoj
 si+V/sUw/SrPup2D391AeD+0VUExskAfnhQfPJ+WeSQKKOjh17MwO+Qd68i0ZZxSO8GX
 FLUKIRTOmPcqV0/PX4P5/Tr57OLLXnQQXZHcGPNmGDypKTp2pkeYnGFYJeXkPedQaYvA
 2hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749124675; x=1749729475;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A9x+UzHHsG2rMsf5Ov8O6nvfpk+Be90BavCWIL+ByDU=;
 b=wT2yrXL23yVxKybrLP6Y4DkwyCHzk1QhqFMtIFJd7vxhi/zDy+Hc9BG3ALWqziboIN
 Q0Iz87WFQWcNA9BzN7oe74ezwt1W4f162UsZ6lnmwv5A1gYOM/YpH8VOgXAb3RNTmrmx
 wMgNlC7sA6oeC0/NvaUI0hP0Mzxq1gapVYVWt9d5w6zzbE0mGSGCJgSwb0UGQvz3iGm7
 H4ejPDoGY5S1+rug6A6+8SuTNPXBVF6TZJncg8fhX8F5E/Erw0n0Jy5rQ76tGutVmqrT
 qhSPzTkeeRDta0Z1v5i6VE3QMjI5XidV2Hzu6rrFyPvs8C8ruX+Li3cZvE43cwTUEh5l
 sTow==
X-Gm-Message-State: AOJu0YxR1C52aICc33qBYlL4LiCoaJSwu7cx5lu4sUoxusTb3I7W7Dtd
 6q8NsopY5KoD07OGECJUixl8NLmVZ12TwjCxl+62eRh2PDG17hTKAi8ABbOy9QayZ44=
X-Gm-Gg: ASbGncv7CEYsSymGffioAm7LUHuPGIfUr+vCfEKMiN6TyKd/BckWKfDIYJc6pKsEwwz
 LZPv9BrHnpRymvjqF69bSWbd5KPHbjLTbazEsVHNBLGNijvMUYnfhJ54EOtbKYM/82qyugeLNB+
 biMjKKQ/K3cro9AWLPSY1tM+MYgcCEAV3l3C0GI0uYzQQXnSebnqCTTXcARqhLSCfv8ofE1zxGs
 LCSCkkwL8uo8ref2mtBwRWCVMy0jmRD+ZM0Wzk3phDwyTRyGEiUVHylm5drcyULGZYbHQa7i3ZH
 B1HMQQGBe1EctmXk5n144BwUxg+7OxwmtswcodRRAHqC8I6YRoRUsElFqwajnMU=
X-Google-Smtp-Source: AGHT+IEeT9bnP9IQlyLt15hZpDHyANWGrAD9McjipwLeKvM18rlVRoXbpp0VLVrrD6Rj6T8Wqi3q8g==
X-Received: by 2002:a17:906:794f:b0:add:ee2c:7313 with SMTP id
 a640c23a62f3a-addf8ce7e21mr597203066b.22.1749124674669; 
 Thu, 05 Jun 2025 04:57:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82d75bsm1255284766b.56.2025.06.05.04.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 04:57:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 540E25F782;
 Thu, 05 Jun 2025 12:57:53 +0100 (BST)
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
In-Reply-To: <1a86b86d-145a-44fc-9f87-2804767fb109@daynix.com> (Akihiko
 Odaki's message of "Thu, 5 Jun 2025 17:34:03 +0900")
References: <20250603110204.838117-1-alex.bennee@linaro.org>
 <20250603110204.838117-10-alex.bennee@linaro.org>
 <1a86b86d-145a-44fc-9f87-2804767fb109@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 05 Jun 2025 12:57:53 +0100
Message-ID: <87o6v2764e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

> On 2025/06/03 20:01, Alex Benn=C3=A9e wrote:
>> QOM objects can be embedded in other QOM objects and managed as part
>> of their lifetime but this isn't the case for
>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>> need some other way of associating the wider data structure with the
>> memory region.
>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>> to
>> MemoryRegionOps for device type regions but is unused in the
>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>> reference and allow the final MemoryRegion object to be reaped when
>> its reference count is cleared.
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>> Cc: qemu-stable@nongnu.org
>> ---
>>   include/system/memory.h       |  1 +
>>   hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>>   2 files changed, 9 insertions(+), 15 deletions(-)
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index fc35a0dcad..90715ff44a 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
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
>
> This patch does nothing more than adding a separate allocation for
> MemoryRegion. Besides there is no corresponding g_free(). This patch
> can be simply dropped.

As the patch says the MemoryRegion is now free'd when it is
de-referenced. Do you have a test case showing it leaking?


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

