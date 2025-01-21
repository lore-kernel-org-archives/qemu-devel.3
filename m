Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E41C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 04:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta5r2-0001OC-IC; Mon, 20 Jan 2025 23:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ta5r0-0001O3-RV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 23:27:07 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ta5qy-0000Cz-3A
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 23:27:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-215770613dbso65178735ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 20:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737433622; x=1738038422;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p0WqUMsHoQeRIM48paSm4ueaq/umKBTs5JheG4QB8BI=;
 b=LIgUjHI+F9u/UESSOVc19SFUJV4hJjIrMnG8ZZwYIPSiBYiP7Uzbv3P+P/BGgWkMTI
 +RM2joylWJpG4K1YYffduxdgkGpmF0f3+yR5Dj03UOvT2QXMxyp7mfNTelD6T3Iqwwhj
 RVnVeTR+bQySVgubsOaGmdNbhmRo80bytRi0xUVtd5Bf5+Y9ixn01BkUBfE/5y9ax5+i
 jUmOLegjr6qSFuc6WNSYGb2RujFv+kX1rU4KTPmdDVwmeEqHsNMIQlGKE/By1iApNUzz
 XKWop9neIjUCwL0WNViunf1on37r9teFclPJVQXe0AIjow0TQSjgI/wAXv+FMQE36F2z
 PXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737433622; x=1738038422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0WqUMsHoQeRIM48paSm4ueaq/umKBTs5JheG4QB8BI=;
 b=rfAfxwn9JBg7scUqjcrfvfkbupWkh4g1smCtgSuwGQtz6a2vgNC2a6JKD835k0T0qU
 Cj6nwM1ExOBUG+OUsYaBtYY0hAIqNDJwfXvXIq8IJtZEn2zawDxDCObg6Dr2sBvd6Vjh
 IkMFXhDKnp1bap72YxSrmTBKh5CQWkfsi1DLkPmTIXnbm/M5Amcse3nAgcFPvkLk1XLv
 3zs89I1HlBggIFr8xp7ChEVMVBrGVginMs3OFtYvQ+w94tXT92j2AN1JTV9uVlfnF73q
 hwErUpTqIwTVTOHuSiB40zA1EcuIX4ExUWl0whEv19rt5bTB56MPkd9tnODTSgEn3Y62
 7d3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFP//m/mdlGVUUQvrEnpmYPsUkTJk6S2A9KM60BvTFOaPMD7jBHhbckGXcivSoY5NhWCDGN71dEGTs@nongnu.org
X-Gm-Message-State: AOJu0YySYBbpLaU+9OuKc2kv3vwfpHaEVOOTKkWIpfZW4g3VQ7wNQUn1
 8EhGEyZ3LhTjV6O3ITjLtvzoZotcGMpMqjbjDlsG9+XcbaSxhRjzHRvyRBUcPZY=
X-Gm-Gg: ASbGncsf2eMddNRZXjaLLVrSURSnAbnq+04V5bIlnfkToddo0yZjxAUwsiIJv4785b6
 KbBMAbHiU4Ahi5R3Ede86dQUZgDvA9JsQYKjByFwB77Rz7bgAMQJ72whvY0ciq4Y825lZXAUR1S
 L0qkSNHzjWnU2LQJNi39H/5f3ulcAJEnDK6w/HFJDLqfB6oZkYpAzPgoRVwXegR/q0UWX2eKl3d
 N60np7T7qlOiIGq1Bo3wXpDmOh/+6C82z5b8ppKGMPvHPCgKeoWFnZY497os+bU+Sk/AodT3Tju
 pOKr
X-Google-Smtp-Source: AGHT+IGERxJ4MUARAfb7nFLX43p7SQBcVySVFyjjBVi3aDt8s/mOiXgbET3HG7/a3Yl/q2KwDGePyQ==
X-Received: by 2002:a17:903:41c3:b0:216:2b14:b625 with SMTP id
 d9443c01a7336-21c35564955mr237471975ad.31.1737433622140; 
 Mon, 20 Jan 2025 20:27:02 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c7cf69b28sm36250055ad.200.2025.01.20.20.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 20:27:01 -0800 (PST)
Message-ID: <171b1cd3-1077-438c-a27c-3b9b3ce25f0f@daynix.com>
Date: Tue, 21 Jan 2025 13:26:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] docs/system: Expand the virtio-gpu documentation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <20250119220050.15167-9-dmitry.osipenko@collabora.com>
 <c2e1c362-5d02-488e-b849-d0b14781a60f@daynix.com>
 <87ikq9r7wj.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87ikq9r7wj.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

On 2025/01/20 21:23, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/01/20 7:00, Dmitry Osipenko wrote:
>>> From: Alex Bennée <alex.bennee@linaro.org>
>>> This attempts to tidy up the VirtIO GPU documentation to make the
>>> list
>>> of requirements clearer. There are still a lot of moving parts and the
>>> distros have some catching up to do before this is all handled
>>> automatically.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> [dmitry.osipenko@collabora.com: Extended and corrected doc]
>>> ---
>>>    docs/system/devices/virtio-gpu.rst | 94 ++++++++++++++++++++++++++++--
>>>    1 file changed, 88 insertions(+), 6 deletions(-)
>>> diff --git a/docs/system/devices/virtio-gpu.rst
>>> b/docs/system/devices/virtio-gpu.rst
>>> index f20c60016376..79af291a9316 100644
>>> --- a/docs/system/devices/virtio-gpu.rst
>>> +++ b/docs/system/devices/virtio-gpu.rst
>>> @@ -4,14 +4,96 @@
>>>    virtio-gpu
>>>    ==========
>>>    -This document explains the setup and usage of the virtio-gpu
>>> device.
>>> -The virtio-gpu device paravirtualizes the GPU and display controller.
>>> -
>>> -Linux kernel support
>>> ---------------------
>>> +The virtio-gpu device provides a GPU and display controller
>>> +paravirtualized using VirtIO. It supports a number of different modes
>>> +from simple 2D displays to fully accelerated 3D graphics.
>>> +
>>> +Dependencies
>>> +............
>>> +
>>> +.. note::
>>> +  GPU virtualisation is still an evolving field. Depending on the mode
>>> +  you are running you may need to override distribution supplied
>>> +  libraries with more recent versions or enable build options.
>>> +
>>> +Host requirements
>>> +-----------------
>>> +
>>> +Depending on the mode there are a number of requirements the host must
>>> +meet to be able to be able to support guests. For 3D acceleration QEMU
>>> +must be able to access the hosts GPU and for the best performance be
>>> +able to reliably share GPU memory with the guest.
>>> +
>>> +.. list-table:: Host Requirements
>>> +  :header-rows: 1
>>> +
>>> +  * - Mode
>>> +    - Kernel
>>> +    - Userspace
>>> +  * - virtio-gpu
>>> +    - framebuffer enabled
>>> +    - GTK or SDL display
>>> +  * - virtio-gpu-gl (OpenGL pass-through)
>>> +    - GPU enabled
>>> +    - libvirglrenderer (virgl support)
>>> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>>> +    - GPU enabled
>>> +    - aemu/rutabaga_gfx_ffi or vhost-user client with support
>>> +  * - virtio-gpu-gl (Vulkan pass-through)
>>> +    - Linux 6.13+
>>> +    - libvirglrenderer (>= 1.0.0, venus support)
>>> +  * - virtio-gpu-gl (vDRM native context/AMD)
>>> +    - Linux 6.13+
>>> +    - libvirglrenderer (>= 1.1.0, DRM renderer support)
>>> +  * - virtio-gpu-gl (vDRM native context/Freedreno)
>>> +    - Linux 6.13+
>>> +    - libvirglrenderer (>= 1.0.0, DRM renderer support)
>>> +  * - virtio-gpu-gl (vDRM native context/Intel i915)
>>> +    - Linux 6.13+
>>> +    - libvirglrenderer (`mr1384`_, DRM renderer support)
>>> +
>>> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
>>> +
>>> +Guest requirements
>>> +------------------
>>>      virtio-gpu requires a guest Linux kernel built with the
>>> -``CONFIG_DRM_VIRTIO_GPU`` option.
>>> +``CONFIG_DRM_VIRTIO_GPU`` option. Otherwise for 3D accelerations you
>>> +will need support from Mesa configured for whichever encapsulation you
>>> +need.
>>> +
>>> +.. list-table:: Guest Requirements
>>> +  :header-rows: 1
>>> +
>>> +  * - Mode
>>> +    - Mesa Version
>>> +    - Mesa build flags
>>> +  * - virtio-gpu
>>> +    - n/a
>>> +    - n/a
>>> +  * - virtio-gpu-gl (OpenGL pass-through)
>>> +    - 20.3.0+
>>> +    - -Dgallium-drivers=virgl
>>> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>>> +    - 24.3.0+
>>> +    - -Dvulkan-drivers=gfxstream
>>> +  * - virtio-gpu-gl (Vulkan pass-through)
>>> +    - 24.2+
>>> +    - -Dvulkan-drivers=virtio
>>> +  * - virtio-gpu-gl (vDRM native context/AMD)
>>> +    - 25.0.0+
>>> +    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-virtio=true
>>> +  * - virtio-gpu-gl (vDRM native context/Freedreno)
>>> +    - 23.1.0+
>>> +    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
>>> +  * - virtio-gpu-gl (vDRM native context/Intel i915)
>>> +    - `mr29870`_
>>> +    - -Dgallium-drivers=iris -Dvulkan-drivers=intel -Dintel-virtio-experimental=true
>>> +
>>> +.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
>>
>> I feel the dependency information for virglrenderer and Mesa are more
>> suited for the Mesa documentation as they are not specific to QEMU and
>> potentially useful also for e.g., libkrun and crosvm.
> 
> I think while everything is in so much flux it doesn't hurt to include
> in our docs. I don't know if mesa currently has a dedicated page for GPU
> virtualisation.

Mesa has pages for VirGL and Venus, which can be linked from the 
respective parts of this documentation. gfxstream is not documented but 
I think most people will use it only for Android anyway. A documentation 
for DRM native context will be a nice addition for Mesa. I will not 
object if you put this information to QEMU documentation though.

> 
> 
>>
>>> +
>>> +Further information
>>> +...................
>>
>> I'm not sure about putting the below sections behind "Further
>> information". Anyone who want to use this feature will need to know
>> the command line described below.
>>
>>>      QEMU virtio-gpu variants
>>>    ------------------------
> 


