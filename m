Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF4EC54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 09:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI2Dy-0005Ps-71; Thu, 22 May 2025 05:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI2Dq-0005LI-5R
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:28:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI2Dn-0005ST-JC
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:28:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so55495715e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747906093; x=1748510893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDq06Qu8XjMjOqmzHAD9Z1Y173iAzWbcG825ElOCaoM=;
 b=HtARaOxbjtmD4j8Dhgwm//R+dGMOcFbq7pj8DDI8v/sIqR3NwTB+C0JYUJ7W6+JIu9
 IIrQyOaqRevlSCudq3gnbZUvoIwV9EiORMlUjmISS1Uv0veqGLnTPLicZ8s2sCb0ZbXJ
 5+N5Dz+jsSztb5tDe85NqUDVdUndfcd+qUFdQ/5kW3JfvDTLR1M3oXasGWV8dkd2qW6R
 ENGcBnMvavJw2+Ob5VKTTytO49AIdFvc0dyYPzH3aj7tICcM/ytMCPOlYXoUAA2L9iZ+
 A7oFHgwtKwpIVf8tAPBX1d17gWpkL7TRh2C4NQ0yIaIpFeUbolDe0DkthLFqVhw7vC2Q
 dPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747906093; x=1748510893;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gDq06Qu8XjMjOqmzHAD9Z1Y173iAzWbcG825ElOCaoM=;
 b=mxKRI6a8mebwt98H1OJ8VD/WDG2HFy61MlP5x6Y7iJWJvIcrvkG3NXssx8Qhx7Gpgi
 6cEiZLTtFKLlVkQO9b/mpXL/HZvl40PSLMtmAJ80Ov9avM5zF8RX9iCGJuLekRjn8eEG
 wuSLkR0B/Wb9uxvw7dXlhU8ouRkMFBqY01gQGN64Vl4L2Hx1p3mT1QQpLw4wIZpFEHMm
 TDoQEEHkS6u7Y2/lNOGELY9vGFxvdSHpWoh36U6mBVLtXR5awzk/3/uHcPnUiGCJQSlj
 zCSY2N/1d8wSb5it0iMglZQJXnyG78ZWS7j8I1BJTGDCtp/if9i2Wc3ckGiP/6ALTTQU
 ZwyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAF7l5lFciiwZ2o8UjBxKbis5Ka+2/VrQdbPcH5Yhgte/lB5jRv3kvZP0NXJhuo0GWZHzs+280FjtQ@nongnu.org
X-Gm-Message-State: AOJu0YwVFg1z3k1cZo62Ic0MUpbIxR5KGA2gyr3ylMTbbTfJjB4CwB0/
 M6ogT3QMs0/LiIwiszK9Zo9Hz+w3ByOkkDUp4QMGs2Ok52pKORfQPpG78CMR1C0+tbM=
X-Gm-Gg: ASbGncu1KVNGZMeyNsgP/wR0Zxado5tWmTc672hYIbhMtM/OsE6abHnEM/JeWWg4yPc
 G2SfVH6f6ixC5CPDgcRrv5grGm/kgA/G/iGiBJTC01lkYZb2OsOHOa8n0i6B6xslXH8x2fA28Ut
 G4qMdSYGlu3SYbsSthYrWaqoMUKufXT92suhSYAhFoA/J+SHmsN7CeCWfOKg3IeYGMSV7n5VVKn
 kxPR5rNLeBiIn+4rWXVYDOwCzpfRBc8sUKrOm6RGShjy606gGKVhFcYTN5DCCvAMsYlXb7HE017
 krEFTdBMQMHniqRK/T+9YDGf0GjRzAdi2o8aFafLAoNL9aJY262VFgVr+W4zJcE=
X-Google-Smtp-Source: AGHT+IHq+rhlziu6d7ea2I7ZoWMhtJvc573/Zr6s1oBv0Yq4Ku+fheo/mAgL9QWLHfYCoaBdacHJdg==
X-Received: by 2002:a05:6000:ecf:b0:3a3:5e77:436e with SMTP id
 ffacd0b85a97d-3a35e77460fmr16926354f8f.43.1747906093021; 
 Thu, 22 May 2025 02:28:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a04csm22165834f8f.23.2025.05.22.02.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 02:28:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 800F05F8AD;
 Thu, 22 May 2025 10:28:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
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
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3 12/20] virtio-gpu: fix hang under TCG when unmapping
 blob
In-Reply-To: <199e7486-7d05-459b-ad51-cb9b130f299f@daynix.com> (Akihiko
 Odaki's message of "Thu, 22 May 2025 16:40:13 +0900")
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-13-alex.bennee@linaro.org>
 <4d300cca-3ac2-4072-a35c-0b6aef970b26@daynix.com>
 <87bjrl87p5.fsf@draig.linaro.org>
 <83945c43-bfb2-4469-90bd-e3a7c2ca5d89@daynix.com>
 <CAAjaMXZ8acKBSGHvcQOcOnzBDCjFU1SOjse7pHtHWxNeREc2gg@mail.gmail.com>
 <199e7486-7d05-459b-ad51-cb9b130f299f@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 22 May 2025 10:28:11 +0100
Message-ID: <875xht805w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

> On 2025/05/22 16:31, Manos Pitsidianakis wrote:
>> On Thu, May 22, 2025 at 10:03=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
>>>
>>> On 2025/05/22 15:45, Alex Benn=C3=A9e wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2025/05/22 1:42, Alex Benn=C3=A9e wrote:
>>>>>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>>> This commit fixes an indefinite hang when using VIRTIO GPU blob
>>>>>> objects
>>>>>> under TCG in certain conditions.
>>>>>> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
>>>>>> MemoryRegion and attaches it to an offset on a PCI BAR of the
>>>>>> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unma=
ps
>>>>>> it.
>>>>>> Because virglrenderer commands are not thread-safe they are only
>>>>>> called on the main context and QEMU performs the cleanup in three st=
eps
>>>>>> to prevent a use-after-free scenario where the guest can access the
>>>>>> region after it=E2=80=99s unmapped:
>>>>>> 1. From the main context, the region=E2=80=99s field finish_unmappin=
g is
>>>>>> false
>>>>>>       by default, so it sets a variable cmd_suspended, increases the
>>>>>>       renderer_blocked variable, deletes the blob subregion, and unp=
arents
>>>>>>       the blob subregion causing its reference count to decrement.
>>>>>> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>>>>>>       recalculated, the free callback of the blob region
>>>>>>       virtio_gpu_virgl_hostmem_region_free is called which sets the
>>>>>>       region=E2=80=99s field finish_unmapping to true, allowing the =
main thread
>>>>>>       context to finish replying to the command
>>>>>> 3. From the main context, the command is processed again, but this
>>>>>> time
>>>>>>       finish_unmapping is true, so virgl_renderer_resource_unmap can=
 be
>>>>>>       called and a response is sent to the guest.
>>>>>> It happens so that under TCG, if the guest has no timers configured
>>>>>> (and
>>>>>> thus no interrupt will cause the CPU to exit), the RCU thread does n=
ot
>>>>>> have enough time to grab the locks and recalculate the FlatView.
>>>>>> That=E2=80=99s not a big problem in practice since most guests will =
assume a
>>>>>> response will happen later in time and go on to do different things,
>>>>>> potentially triggering interrupts and allowing the RCU context to ru=
n.
>>>>>> If the guest waits for the unmap command to complete though, it bloc=
ks
>>>>>> indefinitely. Attaching to the QEMU monitor and force quitting the g=
uest
>>>>>> allows the cleanup to continue.
>>>>>> There's no reason why the FlatView recalculation can't occur right
>>>>>> away
>>>>>> when we delete the blob subregion, however. It does not, because whe=
n we
>>>>>> create the subregion we set the object as its own parent:
>>>>>>        memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data=
);
>>>>>> The extra reference is what prevents freeing the memory region
>>>>>> object in
>>>>>> the memory transaction of deleting the subregion.
>>>>>> This commit changes the owner object to the device, which removes
>>>>>> the
>>>>>> extra owner reference in the memory region and causes the MR to be
>>>>>> freed right away in the main context.
>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
>>>>>> Cc: qemu-stable@nongnu.org
>>>>>> ---
>>>>>>     hw/display/virtio-gpu-virgl.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>> diff --git a/hw/display/virtio-gpu-virgl.c
>>>>>> b/hw/display/virtio-gpu-virgl.c
>>>>>> index 71a7500de9..8fbe4e70cc 100644
>>>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>>>> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>>>         vmr->g =3D g;
>>>>>>         mr =3D g_new0(MemoryRegion, 1);
>>>>>>     -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size,
>>>>>> data);
>>>>>> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>>>>>>         memory_region_add_subregion(&b->hostmem, offset, mr);
>>>>>>         memory_region_set_enabled(mr, true);
>>>>>>
>>>>>
>>>>> I suggest dropping this patch for now due to the reason I pointed out
>>>>> for the first version of this series.
>>>>
>>>> This fixes an actual bug - without it we get a hang.
>>>>
>>>
>>> I understand that but it also introduces a regression; "[PATCH v3 14/20]
>>> ui/gtk-gl-area: Remove extra draw call in refresh" is also a similar ca=
se.
>>>
>>> Ideally such a bug should be fixed without regression, but I understand
>>> it is sometimes difficult to do that and postponing the bug resolution
>>> until figuring out the correct way does not make sense.
>>>
>>> In such a case, a bug should be fixed minimizing the regression and the
>>> documentation of the regression should be left in the code.
>>>
>>> In particular, this patch can cause use-after-free whether TCG is used
>>> or not. Instead, I suggest to avoid freeing memory regions at all on
>>> TCG. It will surely leak memory, but won't result in use-after-free at
>>> least and the other accelerators will be unaffected.
>>>
>>> Regards,
>>> Akihiko Odaki
>> We tested this fix with ASAN and didn't see anything. Do you have a
>> test case in mind that can reproduce this use-after-free? It'd help
>> make a certain decision on whether to drop this patch or not. I'm not
>> doubting that this can cause a use-after-free by the way, it's just
>> that it is hypothetical only. If it causes a use-after-free for sure
>> we should definitely drop it.
>
> No, I don't have a test case and it should rarely occur. More
> concretely, a UAF occurs if the guest accesses the memory region while
> trying to unmap it. It is just a theory indeed, but the theory says
> the UAF is possible.

I have a test case this fixes which I think trumps a theoretical UAF
without a test case.

Why would the guest attempt to access after triggering the free itself?
Wouldn't it be correct to fault the guest for violating its own memory
safety rules?

>>> Instead, I suggest to avoid freeing memory regions at all on
>>> TCG. It will surely leak memory, but won't result in use-after-free at
>>> least and the other accelerators will be unaffected.
>> Leaking memory for blob objects is also not ideal, since they are
>> frequently allocated. It's memory-safe but the leak can accumulate
>> over time.
>>
>
> Memory safety and leak free cannot be compatible unless RCU is fixed.
> We need to choose either of them.

How can the guest access something that is now unmapped? The RCU should
only run after the flatview has been updated.

>
> Regards,
> Akihiko Odaki

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

