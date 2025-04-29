Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D80C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9sMg-0002IB-Lq; Tue, 29 Apr 2025 17:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9sMd-0002Fr-92
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:19:39 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9sMZ-00069y-It
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:19:38 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so760128966b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745961574; x=1746566374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwjMJdixUoEFxoWQ9KRgIIpWBwkvw/t5kEH72Y/MwLY=;
 b=aVGJr+Q89siGrCNc8UvSmzQgf1sdY5vWG2U7mHCwkkkra6s/oxbo/08JbN76O9AKI4
 zuzfR6cv7pk9ofCssKklnaPdp0j4uS7X1+ayW0AdLcsqvqEtAC5Vz2I9WUMgIUXISt/l
 u7SLE2Ep18Em7tiZRrh0MUMHbkY2k1pB5ONe3rgVXOYMkPLW9D7hPtDa/wyBQAKy1e5B
 EsFfTOjAqy7BqdFqHOW/PqGXVfGIeDZ5N0FwsX8z5IdogUIFVt5NKf/bA0/ubhcqV7vN
 LG1uICTiv+eEc2DsokxUQhwd/jUzRg6KJXgoK7FJBA3eQndIE4hhlSOFS1//Nue/sCSY
 8g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745961574; x=1746566374;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dwjMJdixUoEFxoWQ9KRgIIpWBwkvw/t5kEH72Y/MwLY=;
 b=maU/nthJ4FzJqnxxDy1k410BREzcYw13Vf1LoYUjcBIWyUC2UTMxhy+1+1W4FbOma8
 2ecG61n4kquaHU+RVKgKnMmEIxyjNZyHrG+vxspjIQG44KvpYHE3ird6JTr1mODW/5Df
 fXBPDeEk+hhmoMIzURt/Ti3W2xE6Ija2XO+7auJbbMZKq7dALfX9q9aP/5D8y3w5JX2z
 +5+GHzA4yRux7Y1X9CvKovEn25k0i/LRTJksvYASd7UqVddSwhnQv50kqjZsuuQY/ZtN
 CF42MVIdFHLCEaGjMdf1Uefi0hzWYPk+QxnhvlFaJZZlogn8IGYoiG5Bx1bDuiQBdlQ1
 gsuQ==
X-Gm-Message-State: AOJu0Yz39VaoEENgJPR/xsIw/ETbWM0IDyRJ18ecEGDmdFmWBKr8FR1h
 lMPKT8tw/JGQlLXhajROtHciKbikCFxWUy3s9bGElEZHYjx0TDYP8PL+l0MoGb4=
X-Gm-Gg: ASbGncsS+MYdqjG66xx22UiCzTWZsqNqWKMApc4Tkh/OzuMN75ZWwuDGUDydPGQNGis
 zqM6eTzrW6uMjbVfPIr/ulU1tgW5gN7fNBsQAr8pFLhFxgqf+yEG53XefoDIbdzwo2yAVIqS40W
 0CW78Y/0I+cTdw1cfDiN70Zdcc9WrqooaaxhXeoJHld5TxqJf+lOiEBpzHOaEt928dBef4kDdq4
 aqYGfcQvU5goRyMMCuFeDIIeeMwcIGp0eEkcGRkeF6QU/Jzi8vE4XKgb1EtqLXL5WZynUaKEOAd
 gdsX/go5rc992hfqXEoY40SL3l02+2GotNVNYeH9fIQ=
X-Google-Smtp-Source: AGHT+IGwNJNnHVyolWdi6S+Ungiq7YTk1HewwFq09ovc0HDW947Btu85rhkZKHOh5ILLl2+nZQ6rFA==
X-Received: by 2002:a17:907:7daa:b0:ace:c3b9:c710 with SMTP id
 a640c23a62f3a-acedc66ca50mr85168566b.36.1745961573556; 
 Tue, 29 Apr 2025 14:19:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41c934sm827865466b.8.2025.04.29.14.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 14:19:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E33C5FAEE;
 Tue, 29 Apr 2025 22:19:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-devel@nongnu.org,  Akihiko Odaki <akihiko.odaki@daynix.com>,
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
In-Reply-To: <8b123991-21f2-47b5-851d-6b53fbfaa691@collabora.com> (Dmitry
 Osipenko's message of "Tue, 29 Apr 2025 21:48:02 +0300")
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-9-alex.bennee@linaro.org>
 <8b123991-21f2-47b5-851d-6b53fbfaa691@collabora.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 29 Apr 2025 22:19:31 +0100
Message-ID: <87o6we3bto.fsf@draig.linaro.org>
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 4/28/25 15:59, Alex Benn=C3=83=C2=A9e wrote:
>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>=20
>> This commit fixes an indefinite hang when using VIRTIO GPU blob objects
>> under TCG in certain conditions.
>>=20
>> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
>> MemoryRegion and attaches it to an offset on a PCI BAR of the
>> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
>> it.
>>=20
>> Because virglrenderer commands are not thread-safe they are only
>> called on the main context and QEMU performs the cleanup in three steps
>> to prevent a use-after-free scenario where the guest can access the
>> region after it=E2=80=99s unmapped:
>>=20
>> 1. From the main context, the region=E2=80=99s field finish_unmapping is=
 false
>>    by default, so it sets a variable cmd_suspended, increases the
>>    renderer_blocked variable, deletes the blob subregion, and unparents
>>    the blob subregion causing its reference count to decrement.
>>=20
>> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>>    recalculated, the free callback of the blob region
>>    virtio_gpu_virgl_hostmem_region_free is called which sets the
>>    region=E2=80=99s field finish_unmapping to true, allowing the main th=
read
>>    context to finish replying to the command
>>=20
>> 3. From the main context, the command is processed again, but this time
>>    finish_unmapping is true, so virgl_renderer_resource_unmap can be
>>    called and a response is sent to the guest.
>>=20
>> It happens so that under TCG, if the guest has no timers configured (and
>> thus no interrupt will cause the CPU to exit), the RCU thread does not
>> have enough time to grab the locks and recalculate the FlatView.
>>=20
>> That=E2=80=99s not a big problem in practice since most guests will assu=
me a
>> response will happen later in time and go on to do different things,
>> potentially triggering interrupts and allowing the RCU context to run.
>> If the guest waits for the unmap command to complete though, it blocks
>> indefinitely. Attaching to the QEMU monitor and force quitting the guest
>> allows the cleanup to continue.
>>=20
>> There's no reason why the FlatView recalculation can't occur right away
>> when we delete the blob subregion, however. It does not, because when we
>> create the subregion we set the object as its own parent:
>>=20
>>     memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>=20
>> The extra reference is what prevents freeing the memory region object in
>> the memory transaction of deleting the subregion.
>>=20
>> This commit changes the owner object to the device, which removes the
>> extra owner reference in the memory region and causes the MR to be
>> freed right away in the main context.
>>=20
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
>> Cc: qemu-stable@nongnu.org
>> ---
>>  hw/display/virtio-gpu-virgl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl=
.c
>> index 71a7500de9..8fbe4e70cc 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>      vmr->g =3D g;
>>      mr =3D g_new0(MemoryRegion, 1);
>>=20=20
>> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>>      memory_region_add_subregion(&b->hostmem, offset, mr);
>>      memory_region_set_enabled(mr, true);
>>=20=20
>
> This change makes QEMU to crash.

What is your command line to cause the crash?

>
> AFAICT, it effectively reverts code to old bugged version [1] that was
> rejected in the past.
>
> +Akihiko Odaki
>
> [1]
> https://lore.kernel.org/qemu-devel/20230915111130.24064-10-ray.huang@amd.=
com/

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

