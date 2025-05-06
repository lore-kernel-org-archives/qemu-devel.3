Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79564C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCE5h-0001pU-Ud; Tue, 06 May 2025 04:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCE5Z-0001Dl-P8
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:55:46 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCE5V-0007l7-GS
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:55:45 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso856647666b.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746521739; x=1747126539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r7WeRI1zx+FoyOA/YldoDkOxqvxpYNFgz6XaGrQKjpI=;
 b=RxqajIzsWt7yGo37M/ka+LtCn3Yyu3E+z7elSuzhXZNv6jifG34HzUoaoN/Bym0EAH
 Eum7SWZpfdaQM3y1W9u48B7BFEXhketYtfZ6n4TYS8mMOSsLcnelQ/FRqNTnJhq8ghis
 gLvduNVbSiuF5pMCSpN1WJzgO6VhXEWguDEQC5iUcouxriaIvZMviYdhEbBRY6b1Nl37
 pMYYbYqT+WJ744ba+s+Iw/ZmY2oVqyUAL1p+FkrKsaYl0eiy3LtB5HMNjb5J6lyb6e0j
 D/mU3NIkZfWJCx3eadLRhlAdASrVYLXe/NefPvSglrBs67WFySKT0Jn00IIW4mnOf3AN
 +1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746521739; x=1747126539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r7WeRI1zx+FoyOA/YldoDkOxqvxpYNFgz6XaGrQKjpI=;
 b=UpYTkMu4hsO6cVJFxlDllkdKgDkJF7IFyDNG0QJeQI7t2jGTiV55JcZ4RQ3zEtzS/g
 qwWGcq0uzCzj08Tjj/HXXBShWgNEz2GDOig7K//j0euj2sUagH6rMt8UEj2XnkZwLHDE
 igwK02/lUl5/TgrzpWTqqX1wP7mOyfAd+vfK+xuU1ezXGXzIMfmaiQ3QEa7EHVwCkL8j
 mATl1268xfMUWGpX2XzQRJsysj5E0JOkLKX8WUobzQ89Pd8eq0sOd1pjIgawf0NsbYGk
 1yz0Pm2ugcfHns4enquZ8ryno2AMnXZZ/LVbP8KbSbxe1M8+3fLbVTru3Tvhs5cvj9YS
 xU3g==
X-Gm-Message-State: AOJu0YzXFQcRFVhEnmChRpTd51txfa7p4Y7qdySPJEvk4gpv+bATE93+
 tUrUx5FTkxWMx8ATszM6pZGkd7Gfp0xNvnsIbD+md2CV0M3b9FO/yf6VXvgzIOo=
X-Gm-Gg: ASbGnctbM/7gWyqit+vt0tHnArD1i9evHWp1THYWPMaj8DBZ7phpF8gm1PVYyfZ/T8U
 cL8LkMoPJitGJa0EqP57R/6MQF4Q0tTwk0FQA5DNjaG/ahLiLLYwtz8qVmk/1WOEMrasQzHWGTO
 pRGMNr55hHfHmNwExnr5hF9fV9JT92Z1Yh7tH7WtltnLpe9fw6Bjcoz/eOEl/dy5lTL+pC4JWmq
 6E/CGjC0GhQah7C7GoG3ER0oyMysZWAZXKp3BitrI91xtZr1/IBjAySx/uPjctj+0IAqOo4uOxf
 7iM4gr9KTk4UwWgIi7jgUIZ/PHzMAHV8Mgn9ZjhW6fTx8ReNNlQUbvnQtZ7WqWhZVEJOlDJyoYN
 P8f8XTdnk0DRwbQ==
X-Google-Smtp-Source: AGHT+IHifHRffEq5bdMQfPubSpOyrj3WXjvuBj9ZM/+bmICtF/DDCxyvX+7c81bPwv9FmYrdouWSVA==
X-Received: by 2002:a17:907:3fa4:b0:abf:73ba:fd60 with SMTP id
 a640c23a62f3a-ad17b5dbc19mr1529984066b.29.1746521738971; 
 Tue, 06 May 2025 01:55:38 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189146f61sm661188366b.9.2025.05.06.01.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:55:37 -0700 (PDT)
Message-ID: <59c4d557-2f73-4b56-8650-f16ed3cd7bb2@linaro.org>
Date: Tue, 6 May 2025 10:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/virtio: Introduce CONFIG_VIRTIO_LEGACY to disable
 legacy support
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250502132441.64723-1-philmd@linaro.org>
 <aBnCk2WE_SNkRgSH@redhat.com> <20250506040903-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506040903-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/5/25 10:12, Michael S. Tsirkin wrote:
> On Tue, May 06, 2025 at 09:04:50AM +0100, Daniel P. Berrangé wrote:
>> On Fri, May 02, 2025 at 03:24:41PM +0200, Philippe Mathieu-Daudé wrote:
>>> Legacy VirtIO devices don't have their endianness clearly defined.
>>> QEMU infers it taking the endianness of the (target) binary, or,
>>> when a target support switching endianness at runtime, taking the
>>> endianness of the vCPU accessing the device.
>>>
>>> Devices modelling shouldn't really change depending on a property
>>> of a CPU accessing it.
>>>
>>> For heterogeneous systems, it is simpler to break such dev <-> cpu

         ^^^^^^^^^^^^^

>>> dependency, only allowing generic device models, with no knowledge
>>> of CPU (or DMA controller) accesses.
>>>
>>> Therefore we introduce the VIRTIO_LEGACY Kconfig key. We keep the
>>> current default (enabled).
>>> New binaries can set CONFIG_VIRTIO_LEGACY=n to restrict models to
>>> the VirtIO version 1 spec.
>>
>> IMHO that isn't acceptable. In order to be able to provide an
>> upgrade path from the old binaries, we need the need the new
>> binaries to be able to serve the same use cases & disabling
>> virtio 0.9 support prevents that.

This isn't for the single binary effort, there we are taking a
lot of care to not introduce any change.

This is for after it; once we have a single binary (one architecture
run by an instance) we can start testing heterogeneous emulation
(different architectures in the same instance).

>> I don't see a compelling
>> technical reason why we can't support virtio 0.9 from this
>> endian point.

VirtIO 0.9 needs knowledge of the vCPU architecture to get its
endianness. So we need to somehow propagate that at creation
time, guarantying which vCPU (or set of vCPUs) will access a
virtio device.

The use case I'd like to figure out is how should we model
plugging a virtio 0.9 device in into a fully emulated
ZynqMP machine, which has little-endian ARM cores and big
endian MicroBlaze cores.

Alex said this is unlikely to happen, and better is to
ignore this case by not allowing virtio pre-1.0 devices in
our future heterogeneous emulator.

In this same thread Pierrick pointed me to the reference in
the spec: '2.4.3 Legacy Interfaces: A Note on Virtqueue Endianness',
"It is assumed that the host is already aware of the guest endian."

I suppose this means a pre-1.0 virtio device expect to be used by
a single guest OS, but it is not clear the guest OS as fixed
endianness, because the code path checks vCPU endianness at
runtime, so passing guest endianness as a property to pre-1.0
devices isn't really an option.

Anyway I think 1/ I posted this too early, "speculating" as Pierrick
noticed, and confuse the community w.r.t. "single binary" and
2/ I don' t understand legacy virtio and its endianness handling
enough to figure a clever idea to keep using it heterogeneous
setup, so I'll let this task to someone more familiar with that tech.

>> Yes may be more ugly/messy than we would like, but that's par
>> for the course with QEMU emulating arbitrary device models.
>> If the new binaries can't cope with messy devices then I think
>> we are doing something wrong.

> 
> To be more specific, having a kconfig knob modifying the device
> without regards for machine types, means it is no longer
> enough to inspect the command line to figure out the
> compatiblity. That's a problem.
> 

OK. I won't pursue in this direction. I apologize for mentioning
this topic again too early.

Regards,

Phil.

