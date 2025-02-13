Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EA4C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 10:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiWJ3-0006in-Pm; Thu, 13 Feb 2025 05:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tiWJ1-0006iX-I5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:18:51 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tiWIz-0007xO-4a
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:18:51 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab7c81b8681so138636466b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 02:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739441927; x=1740046727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9YtsRVGVJuPUkXk3oyXuFh/r31Rtxqr14bpoUbvIUM=;
 b=W5IJu7m7uA+f1SITzNsUBWUdREGYT4uNT52zFgq4SVoYa/bnnVajZ8iWL/Qcb6uvMU
 B6vhXsBVCTuNVmjGyjzwPAkXssTv4tpHrL15gqazTWrM/+7mYscNBcVPl5HQWoqzl0FJ
 BRtGMcY20WKqO9eBn7borae1xFka0yPvr1/jVhkJtFOiyZn08nLB22yXGQann5SWbeaW
 8VwVPWuk7gxZ2L3WTG+EvDh/zireVtHx4XSCBavBfkckIeo1IWZNqy9zcCnoPxv+csTu
 tmG+YfwDV4+K6rIaQHXmtnR3dhr3QH5VcGwgEjuvimnBhejx4cs7BnB/Y8gcL7dqwXYI
 gDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739441927; x=1740046727;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9YtsRVGVJuPUkXk3oyXuFh/r31Rtxqr14bpoUbvIUM=;
 b=tAdy/wZt6tDBkqWdeTy2xE43FiiWHD70JOb71hBDN0GhdYh1eyL91Au5oPZ71jlSm4
 b4lH/r7C4k6/dDFwc2n1yJZVpb28M9l1HREgbsoL5keUghLYQOJfX8KJvZYxA1fcW+Gz
 ixQ2FTGFCzGWLXMcEghZdAdB9qiEdANafq177cnP/nFcjbKixJJikah61CXLhuot/t8r
 dXlAdDFCuXki3WN1CQT4Uafr86PJ1o+2TBQYrYUg7v+ksy6h0G0CKDw/wdmE9DmEFrNi
 xIvubFGxauk4A2cX1Z1/4ozxfzTy5xcP/yMlZlAjMus5ScRDIl7K7Gd1xSoD675+efhM
 AS+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq3CiNacX01OjbAGNLBSIxVJk/dxDNHlwJ6c5gMlgoHYX5O3mIgvvp0XukMLKPpmAlDL8SQC3X4LpK@nongnu.org
X-Gm-Message-State: AOJu0YzT8vJdSYItC8cbUG3u7TLQ/jELeeGwbm3YbBEyYFzarLQ4aH+s
 h61XHcgDF0jautO65nC9RWOdOwVoDtI0Pr6soDpwwtWaSYYRE5PryqfEWBmxHbA=
X-Gm-Gg: ASbGncvPNEN99uqZaxcSfb7WgJxQJcCvk6fgySB6d/SHpwxrSC6sfwjihwc5SL2kY0s
 WIl+/si43LjrTCFnM96dt/X4zd3hXu2M3/1MpZxtKWD/X6bJXjxINTUwSDm/KzeKzpGGep4chh3
 2ue5foQ/OmP2C2mRB19adk+azKDw6YBDM7Okcnu+AvmEOpLoVL7gFP40lLhOhhuhO8bGcsaMFmR
 ed3VwAS9U/T+G8ayZyAPorQacjrVqnK8oXmTx+0WQaKTrN3YiKSGbmqJr9qxtvaZWBzkI9wW4ME
 ArNZQo+xkEyiYYgaow==
X-Google-Smtp-Source: AGHT+IEsRX5CMWn+iHKtmPboq77Sz7djaC65bcVI3c75EKdPZmUfUtf8ygLyBXhUSYGIRcwjj8ozvQ==
X-Received: by 2002:a17:907:7288:b0:ab7:6369:83fa with SMTP id
 a640c23a62f3a-ab7f3787c2dmr592342566b.33.1739441926404; 
 Thu, 13 Feb 2025 02:18:46 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba53376953sm102514266b.101.2025.02.13.02.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 02:18:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CFF555F7DE;
 Thu, 13 Feb 2025 10:18:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Yiwei Zhang <zzyiwei@chromium.org>,  Sergio Lopez
 Pascual <slp@redhat.com>
Subject: Re: [PATCH v8 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
In-Reply-To: <c3fe5de2-8e16-406b-9f27-c7ad88201222@daynix.com> (Akihiko
 Odaki's message of "Thu, 13 Feb 2025 13:47:20 +0900")
References: <20250209165649.544005-1-dmitry.osipenko@collabora.com>
 <20250209165649.544005-11-dmitry.osipenko@collabora.com>
 <c3fe5de2-8e16-406b-9f27-c7ad88201222@daynix.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 13 Feb 2025 10:18:44 +0000
Message-ID: <87cyfmqha3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

> On 2025/02/10 1:56, Dmitry Osipenko wrote:
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> This attempts to tidy up the VirtIO GPU documentation to make the
>> list
>> of requirements clearer. There are still a lot of moving parts and the
>> distros have some catching up to do before this is all handled
>> automatically.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> [dmitry.osipenko@collabora.com: Extended and corrected doc]
>> ---
>>   docs/system/devices/virtio-gpu.rst | 106 ++++++++++++++++++++++++++++-
>>   1 file changed, 104 insertions(+), 2 deletions(-)
>> diff --git a/docs/system/devices/virtio-gpu.rst
>> b/docs/system/devices/virtio-gpu.rst
>> index ea3eb052df3c..664fc4000fa9 100644
>> --- a/docs/system/devices/virtio-gpu.rst
>> +++ b/docs/system/devices/virtio-gpu.rst
>> @@ -5,14 +5,34 @@ virtio-gpu
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>     This document explains the setup and usage of the virtio-gpu
>> device.
>> -The virtio-gpu device paravirtualizes the GPU and display controller.
>> +The virtio-gpu device provides a GPU and display controller
>> +paravirtualized using VirtIO. It supports a number of different modes
>> +from simple 2D displays to fully accelerated 3D graphics.
>> +
>> +virtio-gpu requirements
>> +-----------------------
>>     Linux kernel support
>> ---------------------
>> +^^^^^^^^^^^^^^^^^^^^
>>     virtio-gpu requires a guest Linux kernel built with the
>>   ``CONFIG_DRM_VIRTIO_GPU`` option.
>>   +Host Linux kernel requirements vary depending on a used
>> virtio-gpu
>> +capabilities. See further sections for a detailed descriptions.
>
> The section for 3D acceleration follows so let's defer the description
> for the host requirements to that section.

But this is a requirement for all virtio-gpu cases, not just the 3D ones.

> Perhaps the section title may be changed to clarify that it only
> describes the guest Linux kernel requirement to exclude the host Linux
> kernel requirement as well as guest Mesa.

3D is a little weird compared to most QEMU requirements as it not a
binary but provides various levels of backends depending on the version.
However I don't think there are any the host kernel requirements other
than support for the underlying HW that will be doing the rendering.

>
>> +
>> +3D acceleration
>> +^^^^^^^^^^^^^^^
>> +
>> +3D acceleration of a virtualized GPU is still an evolving field.
>> +Depending on the 3D mode you are running you may need to override
>> +distribution supplied libraries with more recent versions or enable
>> +build options. There are a number of requirements the host must meet
>> +to be able to be able to support guests. QEMU must be able to access the
>> +host's GPU and for the best performance be able to reliably share GPU
>> +memory with the guest. Details of 3D acceleration requirements are
>> +described in a further sections.
>> +
>>   QEMU virtio-gpu variants
>>   ------------------------
>>   @@ -65,8 +85,14 @@ intermediate representation is communicated to
>> the host and the
>>   `virglrenderer`_ library on the host translates the intermediate
>>   representation back to OpenGL API calls.
>>   +By default OpenGL version on guest is limited to 4.3. In order to
>> enable
>> +OpenGL 4.6 support, virtio-gpu host blobs feature (``hostmem`` and ``bl=
ob``
>> +fields) should be enabled.  The ``hostmem`` field specifies the size of
>> +virtio-gpu host memory window. This is typically between 256M and 8G.
>> +
>>   .. parsed-literal::
>>       -device virtio-gpu-gl
>> +    -device virtio-gpu-gl,hostmem=3D8G,blob=3Dtrue
>>     .. _virgl: https://docs.mesa3d.org/drivers/virgl.html
>>   .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
>> @@ -94,6 +120,62 @@ of virtio-gpu host memory window. This is typically =
between 256M and 8G.
>>     .. _drm:
>> https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
>>   +.. list-table:: Linux Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Capability
>> +    - Kernel
>> +    - virglrenderer build flags
>> +  * - OpenGL pass-through
>> +    - Any Linux version compatible with QEMU if not using host blobs fe=
ature,
>> +      Linux 6.13+ otherwise
>> +    - N/A
>> +  * - Vulkan pass-through
>> +    - Linux 6.13+
>> +    - -Dvenus=3Dtrue -Drender-server=3Dtrue
>> +  * - AMDGPU DRM native context
>> +    - Linux 6.13+
>> +    - -Ddrm-renderers=3Damdgpu-experimental
>> +  * - Freedreno DRM native context
>> +    - Linux 6.4+
>> +    - -Ddrm-renderers=3Dmsm
>> +  * - Intel i915 DRM native context
>> +    - Linux 6.13+
>> +    - -Ddrm-renderers=3Di915-experimental `mr1384`_
>> +  * - Asahi DRM native context
>> +    - Downstream version of Asahi Linux kernel
>> +    - -Ddrm-renderers=3Dasahi-experimental `mr1274`_
>> +
>> +.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_=
requests/1384
>> +.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_=
requests/1274
>> +
>> +.. list-table:: Linux Guest Requirements
>> +  :header-rows: 1
>> +
>> +  * - Capability
>> +    - Mesa Version
>> +    - Mesa build flags
>> +  * - OpenGL pass-through
>> +    - 16.0.0+
>> +    - -Dgallium-drivers=3Dvirgl
>> +  * - Vulkan pass-through
>> +    - 24.2.0+
>> +    - -Dvulkan-drivers=3Dvirtio
>> +  * - AMDGPU DRM native context
>> +    - 25.0.0+
>> +    - -Dgallium-drivers=3Dradeonsi -Dvulkan-drivers=3Damd -Damdgpu-virt=
io=3Dtrue
>> +  * - Freedreno DRM native context
>> +    - 23.1.0+
>> +    - -Dgallium-drivers=3Dfreedreno -Dvulkan-drivers=3Dfreedreno
>> +  * - Intel i915 DRM native context
>> +    - `mr29870`_
>> +    - -Dgallium-drivers=3Diris -Dvulkan-drivers=3Dintel -Dintel-virtio-=
experimental=3Dtrue
>> +  * - Asahi DRM native context
>> +    - 24.2.0+
>> +    - -Dgallium-drivers=3Dasahi -Dvulkan-drivers=3Dasahi
>> +
>> +.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/=
29870
>> +
>>   virtio-gpu rutabaga
>>   -------------------
>>   @@ -133,3 +215,23 @@ Surfaceless is the default if ``wsi`` is not
>> specified.
>>   .. _Wayland display passthrough: https://www.youtube.com/watch?v=3DOZJ=
iHMtIQ2M
>>   .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutab=
aga_gfx.html
>>   .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>> +
>> +.. list-table:: Linux Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Capability
>> +    - Kernel
>> +    - Rutabaga build flags
>> +  * - Vulkan+Wayland pass-through
>> +    - Linux 6.13+
>> +    - Follow `gfxstream-enabled rutabaga`_ build instructions
>
> It is odd that the column header says "build flags", and this cell
> says "Follow `gfxstream-enabled rutabaga`_ build instructions".
>
> I think you can simply remove this column. This section already says
> it leverages Rutabaga and the crosvm book provides build instructions.
>
> Regards,
> Akihiko Odaki
>
>> +
>> +.. list-table:: Linux Guest Requirements
>> +  :header-rows: 1
>> +
>> +  * - Capability
>> +    - Mesa Version
>> +    - Mesa build flags
>> +  * - Vulkan pass-through
>> +    - 24.3.0+
>> +    - -Dvulkan-drivers=3Dgfxstream

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

