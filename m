Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30287C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 10:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCFI4-0006QF-Qj; Tue, 06 May 2025 06:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCFI2-0006PY-4d
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:12:42 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCFHy-0000dT-7E
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:12:41 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f6214f189bso10273580a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746526356; x=1747131156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3OXNmuE7ethlsV0NbytaaYfvl2zsKsHLJr5BOq/Mjk=;
 b=hKSmP9+pIjdIstG5OKc842mcVmtxaCg+N49/Pk3vUfP3y68QG7K0ALyZ2iQGGmAUfP
 /rX7hAcBALYYPwY8jT4is3hAlRcZ0tLQMj1Oumo3EiVCys+ODHCOx0zRSrSJiDGSSiSs
 ie+NPb7Rm2yBnjvEdwy0F2VLfbF8x55Oz6iVg8LkaHP68wM8BUagMwCLnTQP/MdL/kRM
 jQzhaSSkSZOm6pDZCHZbfgd+HXFFIakCH3OQ32H2eNsA9dmelvf+dTAPXt+VYQJdCo6m
 HfZjk4z3XO82GmJCmT92HQfd94Jj3NGVuwX+JLiXBbZzN3yGN9cYL1nVyBWDKxvzqAdm
 468A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746526356; x=1747131156;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n3OXNmuE7ethlsV0NbytaaYfvl2zsKsHLJr5BOq/Mjk=;
 b=UwljdscybQG27Axa5yb71ek+2a7eoQmkRSDstDQ/J7TfB+MFC9z2HeW8C561mr/UFJ
 17V/LLVyAZXbgwGutdAYhiaHWin1kMZdIA/TjdHhCNzzZybgubA3xD7pOWwg07kmCSG1
 phF2kgPndyBcf8OlWMS2VPqVMHutunASXJGx0MFBZ0ikC4MUCbmoEm22sBcSIkdbXNW0
 pcv+i9QouA2QTB1qOPtvtWIVKH/TPlDlJIbh2iIR82f9Y8BFpjkbcV6yeVxKm0/gVGjz
 Ld3o7APEDM5tPpjqS0CVTGqRBlTB/xTc0kuSqRaLMA5c/ogSymWH7mCkjqlW+RMy+r2n
 wfmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpLQk25raiyCfnKzqULYndYB2J6ovDFXbs2Lk8WN3uyxJPh9BVFw21If4xkIobudfsLdW8sJ+Zj/I0@nongnu.org
X-Gm-Message-State: AOJu0Yy28OZQ4Vg4NfU0K05EddrIylXq5VtD3lM7XV0m6N2NywuCqMje
 SFuWxhNmwqJcvj+43zbfBjsEhxJB7wo536YqYfU89v8IJpJhobPDNmZ0AjC5zpQ=
X-Gm-Gg: ASbGncvxfbq5EhpRd9UOICmNAfPjQEp/MFgGJ02oCCL2VWuu67bY0kT5mVsHoBv9FTm
 lFIq5BzIrU0wBl39ClOnMbiQ6C5ycRSoovkJtRFx4USQv/tsnM8AfHkSRdUAvEu5YgqJ0WnYyHl
 AkLTa7CvbtHWH5INvkE4y9ooCNNcNRFpaZSkB79Cu6EhchHQiB+O4ej9cl4ZG0SaygfakmdFvfA
 5NOCpQEA5uyc6cJ+HhOlO0OZ1tmkG9NyjfG2piYCBnq2HdVyGMYuDzqOxVLKHy6TKGqK4Pl4E9k
 dKVg9SyKP+N3UmbzGvwTEWG9Ay3nAVx+j0i+p7Ht83w=
X-Google-Smtp-Source: AGHT+IHNvV90odi9HGPJDqs45WcBYcKnkFp144V1/3p0UBKoLEYNBv8LWVLCpp6v/alhfvCU7XTwVg==
X-Received: by 2002:a17:906:dc8a:b0:ac3:afb1:dee7 with SMTP id
 a640c23a62f3a-ad17b5dbc98mr1535447566b.28.1746526355935; 
 Tue, 06 May 2025 03:12:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c02a8sm670773666b.122.2025.05.06.03.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 03:12:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A36745F8BD;
 Tue,  6 May 2025 11:12:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,  qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  David Hildenbrand <david@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  qemu-arm@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  qemu-stable@nongnu.org
Subject: Re: [PATCH 8/9] virtio-gpu: fix hang under TCG when unmapping blob
In-Reply-To: <8994da6c-a369-40c7-b1c6-433519ba90a5@daynix.com> (Akihiko
 Odaki's message of "Sun, 4 May 2025 17:19:45 +0900")
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-9-alex.bennee@linaro.org>
 <8b123991-21f2-47b5-851d-6b53fbfaa691@collabora.com>
 <8994da6c-a369-40c7-b1c6-433519ba90a5@daynix.com>
User-Agent: mu4e 1.12.10; emacs 30.1
Date: Tue, 06 May 2025 11:12:34 +0100
Message-ID: <874ixyoxnx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

> On 2025/04/30 3:48, Dmitry Osipenko wrote:
>> On 4/28/25 15:59, Alex Benn=C3=83=C2=A9e wrote:
>>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>
>>> This commit fixes an indefinite hang when using VIRTIO GPU blob objects
>>> under TCG in certain conditions.
>>>
>>> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
>>> MemoryRegion and attaches it to an offset on a PCI BAR of the
>>> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
>>> it.
>>>
>>> Because virglrenderer commands are not thread-safe they are only
>>> called on the main context and QEMU performs the cleanup in three steps
>>> to prevent a use-after-free scenario where the guest can access the
>>> region after it=E2=80=99s unmapped:
>>>
>>> 1. From the main context, the region=E2=80=99s field finish_unmapping i=
s false
>>>     by default, so it sets a variable cmd_suspended, increases the
>>>     renderer_blocked variable, deletes the blob subregion, and unparents
>>>     the blob subregion causing its reference count to decrement.
>>>
>>> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>>>     recalculated, the free callback of the blob region
>>>     virtio_gpu_virgl_hostmem_region_free is called which sets the
>>>     region=E2=80=99s field finish_unmapping to true, allowing the main =
thread
>>>     context to finish replying to the command
>>>
>>> 3. From the main context, the command is processed again, but this time
>>>     finish_unmapping is true, so virgl_renderer_resource_unmap can be
>>>     called and a response is sent to the guest.
>>>
>>> It happens so that under TCG, if the guest has no timers configured (and
>>> thus no interrupt will cause the CPU to exit), the RCU thread does not
>>> have enough time to grab the locks and recalculate the FlatView.
>>>
>>> That=E2=80=99s not a big problem in practice since most guests will ass=
ume a
>>> response will happen later in time and go on to do different things,
>>> potentially triggering interrupts and allowing the RCU context to run.
>>> If the guest waits for the unmap command to complete though, it blocks
>>> indefinitely. Attaching to the QEMU monitor and force quitting the guest
>>> allows the cleanup to continue.
>
> The RCU thread should be free to kick in if the guest is waiting and
> idle. That may be a problem that should be analyzed and fixed.
>
>>>
>>> There's no reason why the FlatView recalculation can't occur right away
>>> when we delete the blob subregion, however. It does not, because when we
>>> create the subregion we set the object as its own parent:
>>>
>>>      memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>>
>>> The extra reference is what prevents freeing the memory region object in
>>> the memory transaction of deleting the subregion.
>>>
>>> This commit changes the owner object to the device, which removes the
>>> extra owner reference in the memory region and causes the MR to be
>>> freed right away in the main context.
>>>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
>>> Cc: qemu-stable@nongnu.org
>>> ---
>>>   hw/display/virtio-gpu-virgl.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
>>> index 71a7500de9..8fbe4e70cc 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>       vmr->g =3D g;
>>>       mr =3D g_new0(MemoryRegion, 1);
>>>   -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size,
>>> data);
>>> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>>>       memory_region_add_subregion(&b->hostmem, offset, mr);
>>>       memory_region_set_enabled(mr, true);
>>>=20=20=20
>> This change makes QEMU to crash.
>> AFAICT, it effectively reverts code to old bugged version [1] that
>> was
>> rejected in the past.
>> +Akihiko Odaki
>> [1]
>> https://lore.kernel.org/qemu-devel/20230915111130.24064-10-ray.huang@amd=
.com/
>
> I think you are right.
>
> Changing the owner indeed makes the MR to be freed right away, but
> this is because it makes a reference by the FlatView to the MR
> dangling and can lead to use-after-free.
>
> Setting the owner to the device implies that the device keeps the
> storage of the MR and. The references to the MR must be counted by the
> device to keep the storage available in such a case.

Well the lifetime of the region is effectively controlled by the virgl
resource manager. There is a disconnect between when we can finally free
the MR and when the virglrenderer is done with it.

> The MR itself doesn't count the references. It is fine as long as the
> MR is kept alive by being parented by the device, but
> virtio_gpu_virgl_unmap_resource_blob() unparents the MR and breaks the
> assumption. That's why the device shouldn't be the the owner of the
> MR.

Then who should? Ultimately some object needs to "own" the MR until we
know it can be freed (so no longer mapped into the guest and no longer
referenced by virglrenderer). The normal MR refcounting isn't enough
because the lifetime extends beyond when it is "visible" in the FlatView.

>
> Regards,
> Akihiko Odaki

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

