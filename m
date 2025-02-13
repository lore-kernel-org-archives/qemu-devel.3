Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFA6C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 10:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiWUU-0002U1-Li; Thu, 13 Feb 2025 05:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tiWUS-0002Tc-Vw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:30:41 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tiWUP-0002Rh-Oa
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:30:40 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220d132f16dso9379835ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 02:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739442636; x=1740047436;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h8SJSwmdAl6vLdd5uTE+sw7Ekkckm1EojG5I5Zk9reE=;
 b=z1c3XIoce9K2cpL3ZDlvVFVVRDt1QLg1H5piARrjZY48rX7eUvVvXwtwvuJul+LvaE
 ftiliR/j5GWON7BsW2yUjA+8CZAg2rbgfE91NlEKBsV1YG4nmJ6DekbMpppEKhvaIQy/
 v6QPD5GUJD4hY/c3/uwBc79NZU91/etsz+jguWd1MDQpwJ6kcyvBw2MdNB2Gw/LtXkxK
 +fNx2QSK2QpMYmjktKgN5bsDuM0ntCGz0JLel2oDNCxkJLX1RXpyz4oX8sA2PlUxlsYU
 VrFmrYUW+JBnnMfTBiHNcrtwpfAOSWhS897VUPvajW12rxzPgscy0CFMmFdk2yOA6Dfh
 1DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739442636; x=1740047436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h8SJSwmdAl6vLdd5uTE+sw7Ekkckm1EojG5I5Zk9reE=;
 b=AfQYfX3vq/19RzFGwz00oQ4FyQa25LPoHE4JZuLz+xyy54p3Z9x82UOsnYasjfhMuG
 zKQdSvpEpUW44edd62rhS5kJUaP+235xEageb33RWuN6I0P9fPjRAmCuqahj8wvqVV70
 6exTLUNuIHyletCN8maIW5YsvDBFMij7LSUfSIkCxIHdx3GeMeu3RiAkpkdPRgj1FCHY
 Ef6MQjt/onzFP4sL3UMWUVqqyLuLwvSAQyndo4+6uIvIrg7lzkkkMdoDnWUGk1/CCLsk
 V3aZ0zl07D7eerQzsVEj9+2IYntNjYTbvu6aGWoPhsjKCQG0vg/aM2QwZdYm9Mmfzdha
 22vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1kcNHtiYMWWhyDxfEeB/vKNl4mD4AEZam87Ulro9N86+SmoWmKCJAp1DBSFjkDFULEcPo1pJJ2x/G@nongnu.org
X-Gm-Message-State: AOJu0YxXCr/ghrTndjLT8BnLKOf6QzUlKZA1fwjLku4cwLyqm20Yy6JS
 lrwf1hCdzPdU+Gg0PF6FfIRVw8phpowigM14Jg0KJMebPURdOc3oihWlPPIYBLM=
X-Gm-Gg: ASbGncuSyb7rlv6WesKisw64/NoZwsvW18pJlHAAl+wqRgZDuJxGoY7uQiK6MC5PErw
 LDkuSjE3pzZS4PrboZg/16WTkCOFD/N4qHpgdgfnmJAMLJ4Nl3n7wCf8IO4dC+ADYoHYlnkkJwE
 A5e6PPqlMK98Temcbqchl6z0AARGU2jdAPhvHgKtJkl/bkN9Ks7F8ec2SO/Sgw1HDMmG+uX/cxW
 L3jsFrio/iS0qGHIbOtFaruVn55aSX8mFLoO4dPmSrCdUHnpYL2mDSQ/l7vQXQ6gqWXc1jWoDv4
 sdP1LLHoHHhiyKViDOWBRuxd4olf
X-Google-Smtp-Source: AGHT+IGXvfLVzvtDZIWFQZIb6YlhAyRN/jqjMr1CZ9rfOt+cgqwfafQPORZSmVDIGgK2FaNFoGPBwg==
X-Received: by 2002:a17:902:db01:b0:220:c34c:5760 with SMTP id
 d9443c01a7336-220c34c5af5mr70490265ad.51.1739442635886; 
 Thu, 13 Feb 2025 02:30:35 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536439bsm9613485ad.81.2025.02.13.02.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 02:30:35 -0800 (PST)
Message-ID: <c35022bb-c5cb-4d79-b699-d72a85448949@daynix.com>
Date: Thu, 13 Feb 2025 19:30:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250209165649.544005-1-dmitry.osipenko@collabora.com>
 <20250209165649.544005-11-dmitry.osipenko@collabora.com>
 <c3fe5de2-8e16-406b-9f27-c7ad88201222@daynix.com>
 <87cyfmqha3.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87cyfmqha3.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2025/02/13 19:18, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/02/10 1:56, Dmitry Osipenko wrote:
>>> From: Alex Bennée <alex.bennee@linaro.org>
>>> This attempts to tidy up the VirtIO GPU documentation to make the
>>> list
>>> of requirements clearer. There are still a lot of moving parts and the
>>> distros have some catching up to do before this is all handled
>>> automatically.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> [dmitry.osipenko@collabora.com: Extended and corrected doc]
>>> ---
>>>    docs/system/devices/virtio-gpu.rst | 106 ++++++++++++++++++++++++++++-
>>>    1 file changed, 104 insertions(+), 2 deletions(-)
>>> diff --git a/docs/system/devices/virtio-gpu.rst
>>> b/docs/system/devices/virtio-gpu.rst
>>> index ea3eb052df3c..664fc4000fa9 100644
>>> --- a/docs/system/devices/virtio-gpu.rst
>>> +++ b/docs/system/devices/virtio-gpu.rst
>>> @@ -5,14 +5,34 @@ virtio-gpu
>>>    ==========
>>>      This document explains the setup and usage of the virtio-gpu
>>> device.
>>> -The virtio-gpu device paravirtualizes the GPU and display controller.
>>> +The virtio-gpu device provides a GPU and display controller
>>> +paravirtualized using VirtIO. It supports a number of different modes
>>> +from simple 2D displays to fully accelerated 3D graphics.
>>> +
>>> +virtio-gpu requirements
>>> +-----------------------
>>>      Linux kernel support
>>> ---------------------
>>> +^^^^^^^^^^^^^^^^^^^^
>>>      virtio-gpu requires a guest Linux kernel built with the
>>>    ``CONFIG_DRM_VIRTIO_GPU`` option.
>>>    +Host Linux kernel requirements vary depending on a used
>>> virtio-gpu
>>> +capabilities. See further sections for a detailed descriptions.
>>
>> The section for 3D acceleration follows so let's defer the description
>> for the host requirements to that section.
> 
> But this is a requirement for all virtio-gpu cases, not just the 3D ones.

I referred to the statement starting "host Linux kernel requirements 
vary". Sorry, I was not clear.

> 
>> Perhaps the section title may be changed to clarify that it only
>> describes the guest Linux kernel requirement to exclude the host Linux
>> kernel requirement as well as guest Mesa.
> 
> 3D is a little weird compared to most QEMU requirements as it not a
> binary but provides various levels of backends depending on the version.
> However I don't think there are any the host kernel requirements other
> than support for the underlying HW that will be doing the rendering.

We can avoid mentioning the host kernel requirement at all by renaming 
the the section of title to e.g., "guest Linux kernel", and, if needed, 
stating that there are specific host Linux kernel requirement in the "3D 
acceleration" section as host Linux kernel requirements are specific to 
3D acceleration.

Regards,
Akihiko Odaki

> 
>>
>>> +
>>> +3D acceleration
>>> +^^^^^^^^^^^^^^^
>>> +
>>> +3D acceleration of a virtualized GPU is still an evolving field.
>>> +Depending on the 3D mode you are running you may need to override
>>> +distribution supplied libraries with more recent versions or enable
>>> +build options. There are a number of requirements the host must meet
>>> +to be able to be able to support guests. QEMU must be able to access the
>>> +host's GPU and for the best performance be able to reliably share GPU
>>> +memory with the guest. Details of 3D acceleration requirements are
>>> +described in a further sections.
>>> +
>>>    QEMU virtio-gpu variants
>>>    ------------------------
>>>    @@ -65,8 +85,14 @@ intermediate representation is communicated to
>>> the host and the
>>>    `virglrenderer`_ library on the host translates the intermediate
>>>    representation back to OpenGL API calls.
>>>    +By default OpenGL version on guest is limited to 4.3. In order to
>>> enable
>>> +OpenGL 4.6 support, virtio-gpu host blobs feature (``hostmem`` and ``blob``
>>> +fields) should be enabled.  The ``hostmem`` field specifies the size of
>>> +virtio-gpu host memory window. This is typically between 256M and 8G.
>>> +
>>>    .. parsed-literal::
>>>        -device virtio-gpu-gl
>>> +    -device virtio-gpu-gl,hostmem=8G,blob=true
>>>      .. _virgl: https://docs.mesa3d.org/drivers/virgl.html
>>>    .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
>>> @@ -94,6 +120,62 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
>>>      .. _drm:
>>> https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
>>>    +.. list-table:: Linux Host Requirements
>>> +  :header-rows: 1
>>> +
>>> +  * - Capability
>>> +    - Kernel
>>> +    - virglrenderer build flags
>>> +  * - OpenGL pass-through
>>> +    - Any Linux version compatible with QEMU if not using host blobs feature,
>>> +      Linux 6.13+ otherwise
>>> +    - N/A
>>> +  * - Vulkan pass-through
>>> +    - Linux 6.13+
>>> +    - -Dvenus=true -Drender-server=true
>>> +  * - AMDGPU DRM native context
>>> +    - Linux 6.13+
>>> +    - -Ddrm-renderers=amdgpu-experimental
>>> +  * - Freedreno DRM native context
>>> +    - Linux 6.4+
>>> +    - -Ddrm-renderers=msm
>>> +  * - Intel i915 DRM native context
>>> +    - Linux 6.13+
>>> +    - -Ddrm-renderers=i915-experimental `mr1384`_
>>> +  * - Asahi DRM native context
>>> +    - Downstream version of Asahi Linux kernel
>>> +    - -Ddrm-renderers=asahi-experimental `mr1274`_
>>> +
>>> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
>>> +.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274
>>> +
>>> +.. list-table:: Linux Guest Requirements
>>> +  :header-rows: 1
>>> +
>>> +  * - Capability
>>> +    - Mesa Version
>>> +    - Mesa build flags
>>> +  * - OpenGL pass-through
>>> +    - 16.0.0+
>>> +    - -Dgallium-drivers=virgl
>>> +  * - Vulkan pass-through
>>> +    - 24.2.0+
>>> +    - -Dvulkan-drivers=virtio
>>> +  * - AMDGPU DRM native context
>>> +    - 25.0.0+
>>> +    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-virtio=true
>>> +  * - Freedreno DRM native context
>>> +    - 23.1.0+
>>> +    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
>>> +  * - Intel i915 DRM native context
>>> +    - `mr29870`_
>>> +    - -Dgallium-drivers=iris -Dvulkan-drivers=intel -Dintel-virtio-experimental=true
>>> +  * - Asahi DRM native context
>>> +    - 24.2.0+
>>> +    - -Dgallium-drivers=asahi -Dvulkan-drivers=asahi
>>> +
>>> +.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
>>> +
>>>    virtio-gpu rutabaga
>>>    -------------------
>>>    @@ -133,3 +215,23 @@ Surfaceless is the default if ``wsi`` is not
>>> specified.
>>>    .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
>>>    .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
>>>    .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>>> +
>>> +.. list-table:: Linux Host Requirements
>>> +  :header-rows: 1
>>> +
>>> +  * - Capability
>>> +    - Kernel
>>> +    - Rutabaga build flags
>>> +  * - Vulkan+Wayland pass-through
>>> +    - Linux 6.13+
>>> +    - Follow `gfxstream-enabled rutabaga`_ build instructions
>>
>> It is odd that the column header says "build flags", and this cell
>> says "Follow `gfxstream-enabled rutabaga`_ build instructions".
>>
>> I think you can simply remove this column. This section already says
>> it leverages Rutabaga and the crosvm book provides build instructions.
>>
>> Regards,
>> Akihiko Odaki
>>
>>> +
>>> +.. list-table:: Linux Guest Requirements
>>> +  :header-rows: 1
>>> +
>>> +  * - Capability
>>> +    - Mesa Version
>>> +    - Mesa build flags
>>> +  * - Vulkan pass-through
>>> +    - 24.3.0+
>>> +    - -Dvulkan-drivers=gfxstream
> 


