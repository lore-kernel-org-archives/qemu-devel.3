Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40389C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 06:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHzh5-0005Tt-FA; Thu, 22 May 2025 02:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHzgP-0005CY-F2
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:45:37 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHzgJ-0001vb-G0
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:45:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad563b69908so716577266b.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 23:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747896328; x=1748501128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J7uC1npS4YKcnvvAfYlbcxMHbtmZ3tkmXLYiDXua/4=;
 b=d1hERuaoHmamEmnnWi428p4NV5J1NNlsI8EsCSfY5a8fTg1qRONdetltLt5LLOtvn7
 ZTzhgskiAVDuchoDdRK/4xwBaZSncEsoDvj4w9Ac5ddN9bK/bHHY2hX5Z/jj3El87kCz
 I1kwfiKFVVeGLmu3/XAaOrMOQJNY0vQbZhPhd1clPunOXmgPiqPIDbIPgvexvO0z/+30
 KqprGdy1iaHsXPrV803Fdj+PrMMxmGGOtGkhoaMJUIosKz1BANgElTEhFG5AEljCCG4y
 UCo/0g3OOav4VKvSVh8eF9s6asvNXdq2FWnRaQFHj0yXbxBUHSpBOHfQppSh/L7aMx/I
 +dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747896328; x=1748501128;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6J7uC1npS4YKcnvvAfYlbcxMHbtmZ3tkmXLYiDXua/4=;
 b=gBBMqboYLG6XZ8htug0K5FOjI+ZIx+nwfySJsI+qIxMSidextTFCunOAziAGcRwSFd
 +3JuTLNIIA1aOjdMz9ZA37nn/OfLj+l1lPkD/EYb7OzNK4co1muHeLvzIby5FOKeilgY
 fz0SIdhcjuR8sDp77T7SlKHV1KE9BnTHsWG5n/HhqYK6RCY0EWQ3XjwwH0klquN2dYsB
 RTnpHuOQVpjciQ6RFt8uWSsY3VJCLlTo9GXLjEiTG74fg4+DlWUCGsYK+jijfsc7+Tb2
 m2227u7Gg1cwTUb3gB/f6mmwpb44WZTTPBQyWC1IyOEBBW6yvPf1AI3ZNcGEcDIE+z8n
 1bTQ==
X-Gm-Message-State: AOJu0Yzpov/yN3TGvEqFHr3+7EE0J6Ir9xSTBPzaYoo/kvRlCA806q0y
 8NTlFCluMeb0hXLGpvpdcWq9eDzgqqH8bGp10Xbe1VE8l8xbgvZSGpMSsVmaLnDFTv+eougVWfN
 BJZfOkzE=
X-Gm-Gg: ASbGncseSX9x53pLk8IAJ1o9ZnDlm2WODuEA43yschZWI8OvYmZ/Q1tBYX041O58xSj
 aPxiPMNrFagat1v4Au/KRN5+nFMNemkAzvxXuTEHjrNgqnJ6q87aLKwo2Z0X1LsUS7C61QhGSoo
 kpP0qUCluMZB7YDCr+Vm4VOkgwbaUsTYcR7ibF5rlDeTtp1Ijea+4OpDGE8Yd8r5PJpG26PDfg4
 yG4lPOZu62qD/gLC79CpMVPrwUk7lZcLnwEIVVVfdigLkvg1wwJ1KWkZ/CDQHI9onpEJnjT1Uc+
 9GGJAaM5V+R4R0jBmVSQnvSL1IM43Y74VJ2U4X+rlpMeg7+fXSa2
X-Google-Smtp-Source: AGHT+IHVZsHSSPJZO0dVPAwFImTfmxdl84gaYRxIyKQGU7o51a3y479uomXS6fO1s9/lED1JQZcBbQ==
X-Received: by 2002:a17:907:1c07:b0:ad5:a121:6ebc with SMTP id
 a640c23a62f3a-ad5a121708bmr636223666b.0.1747896328048; 
 Wed, 21 May 2025 23:45:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d047738sm1036285266b.19.2025.05.21.23.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 23:45:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AFF315F8AD;
 Thu, 22 May 2025 07:45:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Markus Armbruster
 <armbru@redhat.com>,  David Hildenbrand <david@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3 12/20] virtio-gpu: fix hang under TCG when unmapping
 blob
In-Reply-To: <4d300cca-3ac2-4072-a35c-0b6aef970b26@daynix.com> (Akihiko
 Odaki's message of "Thu, 22 May 2025 14:59:38 +0900")
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-13-alex.bennee@linaro.org>
 <4d300cca-3ac2-4072-a35c-0b6aef970b26@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 22 May 2025 07:45:26 +0100
Message-ID: <87bjrl87p5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

> On 2025/05/22 1:42, Alex Benn=C3=A9e wrote:
>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> This commit fixes an indefinite hang when using VIRTIO GPU blob
>> objects
>> under TCG in certain conditions.
>> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
>> MemoryRegion and attaches it to an offset on a PCI BAR of the
>> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
>> it.
>> Because virglrenderer commands are not thread-safe they are only
>> called on the main context and QEMU performs the cleanup in three steps
>> to prevent a use-after-free scenario where the guest can access the
>> region after it=E2=80=99s unmapped:
>> 1. From the main context, the region=E2=80=99s field finish_unmapping is
>> false
>>     by default, so it sets a variable cmd_suspended, increases the
>>     renderer_blocked variable, deletes the blob subregion, and unparents
>>     the blob subregion causing its reference count to decrement.
>> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>>     recalculated, the free callback of the blob region
>>     virtio_gpu_virgl_hostmem_region_free is called which sets the
>>     region=E2=80=99s field finish_unmapping to true, allowing the main t=
hread
>>     context to finish replying to the command
>> 3. From the main context, the command is processed again, but this
>> time
>>     finish_unmapping is true, so virgl_renderer_resource_unmap can be
>>     called and a response is sent to the guest.
>> It happens so that under TCG, if the guest has no timers configured
>> (and
>> thus no interrupt will cause the CPU to exit), the RCU thread does not
>> have enough time to grab the locks and recalculate the FlatView.
>> That=E2=80=99s not a big problem in practice since most guests will assu=
me a
>> response will happen later in time and go on to do different things,
>> potentially triggering interrupts and allowing the RCU context to run.
>> If the guest waits for the unmap command to complete though, it blocks
>> indefinitely. Attaching to the QEMU monitor and force quitting the guest
>> allows the cleanup to continue.
>> There's no reason why the FlatView recalculation can't occur right
>> away
>> when we delete the blob subregion, however. It does not, because when we
>> create the subregion we set the object as its own parent:
>>      memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>> The extra reference is what prevents freeing the memory region
>> object in
>> the memory transaction of deleting the subregion.
>> This commit changes the owner object to the device, which removes
>> the
>> extra owner reference in the memory region and causes the MR to be
>> freed right away in the main context.
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
>> Cc: qemu-stable@nongnu.org
>> ---
>>   hw/display/virtio-gpu-virgl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/hw/display/virtio-gpu-virgl.c
>> b/hw/display/virtio-gpu-virgl.c
>> index 71a7500de9..8fbe4e70cc 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>       vmr->g =3D g;
>>       mr =3D g_new0(MemoryRegion, 1);
>>   -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size,
>> data);
>> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>>       memory_region_add_subregion(&b->hostmem, offset, mr);
>>       memory_region_set_enabled(mr, true);
>>=20=20=20
>
> I suggest dropping this patch for now due to the reason I pointed out
> for the first version of this series.

This fixes an actual bug - without it we get a hang.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

