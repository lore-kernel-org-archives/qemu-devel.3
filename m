Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F192C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 10:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmW8K-00014x-13; Mon, 24 Feb 2025 05:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmW8J-00014n-0S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:56:19 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmW8G-0005J1-3w
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:56:18 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dec996069aso6855607a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740394574; x=1740999374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ax/Q+sjs87HDmmUYMA/6BG8w5EYDdPEwniXtVJiqJuA=;
 b=g1n8AC6k1dv1dduByIG+c+F2F9dI/dRYV0DmpaJobvIsz/Ne7kci4Yk69rdApq+C6b
 Jx82G8snvBm1BnIEfkCb4pSdc88afiuYJhKIKHT2ZZZYAhskK+AaEcjf+oxuMo6AjxPo
 sDhis0hUCaASjAOdOQqiGaZdxy9gQYxngPqSHvUlwQVYRpS/FN27XsJeQfAC4kI6b5I+
 tKAUpOP3sQkCiRSX71qfvWCb4PiilgUPV+Lqjsrxr04Go7uUZ6Wh7PhSrn143STQEyka
 yO/FDnfGR8vRr81RRfeNPkSV73kmSq1XGCsjvwDMOJ78TtQtZyhfkFvAzXJici8JEPDC
 GhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740394574; x=1740999374;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ax/Q+sjs87HDmmUYMA/6BG8w5EYDdPEwniXtVJiqJuA=;
 b=Ugq1X8ISznh8YvhQ/uIZNscGbQhqWU01v3mr6hdHPQFuDoTYuT0De5y/Nw2xXrWFS1
 VwZAMm3Db+Bn7yT+7koLC7mFYdNJIHLnJpVlVX4vF5BBWLqxh+mEayUxO9X6ojCrCO4k
 CJjLwTh/nNCv/Aj6oVLoBdiUEU6a8Uq94cf2V22Y/1LIoE0VIaog60lLlr+X6VHN0yLS
 ERVOdCwclPrDmoi7oDVxOZa1HYMQlBVGiYoLClxYfscQs/kBhXcrLiQr6mr99wwV/txn
 bKm1Nx9vm71mYrz4o426qOPF5rcvb39+uzkBsnOvReHVMmugeJ68xlGCMLY22tVwJxLP
 rVQQ==
X-Gm-Message-State: AOJu0YyH4mJ8iD1P0C2MGNarBUOdouwNu9WLf/8rGmDMSPEGVU6pB5tt
 ZBCUuBjSpe+HNwbDPXklqURHghf38whep2+wa9+AT73nyXEQopWq5eJ4iW0SPgA=
X-Gm-Gg: ASbGncs6hrQwnAACeyIrjc3vnGfovSgxJEBijKZj/w1DwI2LuVzSjiI7+l+vikcTFoS
 4vkbKcGvL8H6l26GHrWcO6YKaaIkp1qfA2YyveEsk4Ac7K0TLqAqv6A6QrTcMh7rDqCyI+eye+W
 C3ebEwtzthkMg01XxL+RQsGlmD29FBePzYYzttfJAyLQfp+LswlAy5w9WaVliPDltIumj/OxpeL
 Sn9o3BNZlPRY1rfCbckHL3rojV2ApsA4KNsEx3q9X4ETPxBj8GrTqqJDa7poXi9BnCdZyr2O7r0
 hrBoc0lfxqa7RgqDHdZrhX5OuQLi
X-Google-Smtp-Source: AGHT+IGX0TMZcIVRS87ZEzoEwAR+hW27uLhIVtdCavMugZJAGNkAd5nr/aG7kvDolxeFeAiIaarMBw==
X-Received: by 2002:a05:6402:34cf:b0:5dc:94ce:42a6 with SMTP id
 4fb4d7f45d1cf-5e0b721e398mr12246349a12.22.1740394573838; 
 Mon, 24 Feb 2025 02:56:13 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1d00d9sm18034042a12.32.2025.02.24.02.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 02:56:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 277D05F77B;
 Mon, 24 Feb 2025 10:56:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-A?=
 =?utf-8?Q?ndr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH] hw/display: add blocklist for known bad drivers
In-Reply-To: <Z7xFQ4bHwBEo8aQw@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 24 Feb 2025 10:09:07 +0000")
References: <20250221160101.2318357-1-alex.bennee@linaro.org>
 <Z7xFQ4bHwBEo8aQw@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 24 Feb 2025 10:56:12 +0000
Message-ID: <87eczn8vcj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Feb 21, 2025 at 04:01:01PM +0000, Alex Benn=C3=A9e wrote:
>> While running the new GPU tests it was noted that the proprietary
>> nVidia driver barfed when run under the sanitiser:
>>=20
>>   2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
>>   EOTF mode SDR and colorimetry mode default.
>>   2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
>>   profile: stock sRGB color profile
>>=20
>>   and that's the last thing it outputs.
>>=20
>>   The sanitizer reports that when the framework sends the SIGTERM
>>   because of the timeout we get a write to a NULL pointer (but
>>   interesting not this time in an atexit callback):
>>=20
>>   UndefinedBehaviorSanitizer:DEADLYSIGNAL
>>   =3D=3D471863=3D=3DERROR: UndefinedBehaviorSanitizer: SEGV on unknown a=
ddress
>>   0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
>>   T471863)
>>   =3D=3D471863=3D=3DThe signal is caused by a WRITE memory access.
>>   =3D=3D471863=3D=3DHint: address points to the zero page.
>>       #0 0x7a18ceaafe80
>>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
>>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>       #1 0x7a18ce9e72c0
>>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
>>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>       #2 0x7a18ce9f11bb
>>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
>>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>       #3 0x7a18ce6dc9d1
>>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
>>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>>       #4 0x7a18e7d15326 in vrend_renderer_create_fence
>>   /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vren=
d_renderer.c:10883:26
>>       #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd
>>=20
>> The #dri-devel channel confirmed:
>>=20
>>   <digetx> stsquad: nv driver is known to not work with venus, don't use
>>       it for testing
>>=20
>> So lets implement a blocklist to stop users starting a known bad
>> setup.
>
> I don't much like the conceptual idea of blocking usage of QEMU itself
> based on current point-in-time bugs in the host OS driver stack, because
> it is making an assertion that all future versions of the driver will
> also be broken and that's not generally valid.
>
> If the user chose to use a dodgy graphics driver, they can deal with
> the consequences of their choice.
>
> Skipping only the functional test, without any qemu-system code changes
> though is more palettable as that's not a hard block on usage.

Well how do you do one without the other? I don't want to always skip the
vulkan testing because some developer setups have broken drivers. Unless
you are suggesting something like:

  -device virtio-vga-gl,hostmem=3D4G,blob=3Don,venus=3Don,ignore-nvidia=3Don

or something like that?

>
>>=20
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  meson.build                               |   4 +
>>  include/qemu/host-gpu.h                   |  23 +++++
>>  hw/display/virtio-gpu.c                   |   4 +
>>  stubs/host-gpu.c                          |  17 ++++
>>  util/host-gpu.c                           | 102 ++++++++++++++++++++++
>>  stubs/meson.build                         |   4 +
>>  tests/functional/test_aarch64_virt_gpu.py |   2 +
>>  util/meson.build                          |   2 +
>>  8 files changed, 158 insertions(+)
>>  create mode 100644 include/qemu/host-gpu.h
>>  create mode 100644 stubs/host-gpu.c
>>  create mode 100644 util/host-gpu.c
>>=20
>> diff --git a/meson.build b/meson.build
>> index 4588bfd864..8f4a431445 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1373,12 +1373,16 @@ if not get_option('qatzip').auto() or have_system
>>  endif
>>=20=20
>>  virgl =3D not_found
>> +vulkan =3D not_found
>>=20=20
>>  have_vhost_user_gpu =3D have_tools and host_os =3D=3D 'linux' and pixma=
n.found()
>>  if not get_option('virglrenderer').auto() or have_system or have_vhost_=
user_gpu
>>    virgl =3D dependency('virglrenderer',
>>                       method: 'pkg-config',
>>                       required: get_option('virglrenderer'))
>> +  vulkan =3D dependency('vulkan',
>> +                      method: 'pkg-config',
>> +                      required: get_option('virglrenderer'))
>>  endif
>>  rutabaga =3D not_found
>>  if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_u=
ser_gpu
>> diff --git a/include/qemu/host-gpu.h b/include/qemu/host-gpu.h
>> new file mode 100644
>> index 0000000000..45053c2f77
>> --- /dev/null
>> +++ b/include/qemu/host-gpu.h
>> @@ -0,0 +1,23 @@
>> +/*
>> + * Utility functions to probe host GPU
>> + *
>> + * Copyright (c) 2025 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef HOST_GPU_H
>> +#define HOST_GPU_H
>> +
>> +#include "qapi/error.h"
>> +
>> +/**
>> + * validate_vulkan_backend() - verify working backend
>> + *
>> + * errp: error pointer
>> + *
>> + * If the system vulkan implementation is known to not work return
>> + * false otherwise true.
>> + */
>> +bool validate_vulkan_backend(Error **errp);
>> +
>> +#endif /* HOST_GPU_H */
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 11a7a85750..816eedf838 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -32,6 +32,7 @@
>>  #include "qemu/module.h"
>>  #include "qapi/error.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/host-gpu.h"
>>=20=20
>>  #define VIRTIO_GPU_VM_VERSION 1
>>=20=20
>> @@ -1498,6 +1499,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, =
Error **errp)
>>              error_setg(errp, "venus requires enabled blob and hostmem o=
ptions");
>>              return;
>>          }
>> +        if (!validate_vulkan_backend(errp)) {
>> +            return;
>> +        }
>>      #else
>>          error_setg(errp, "old virglrenderer, venus unsupported");
>>          return;
>> diff --git a/stubs/host-gpu.c b/stubs/host-gpu.c
>> new file mode 100644
>> index 0000000000..7bf76ee4f6
>> --- /dev/null
>> +++ b/stubs/host-gpu.c
>> @@ -0,0 +1,17 @@
>> +/*
>> + * Stub of utility functions to probe host GPU
>> + *
>> + * Copyright (c) 2025 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/host-gpu.h"
>> +
>> +bool validate_vulkan_backend(Error **errp)
>> +{
>> +    error_setg(errp, "No vulkan library present");
>> +    return false;
>> +}
>> diff --git a/util/host-gpu.c b/util/host-gpu.c
>> new file mode 100644
>> index 0000000000..5e7bf2557c
>> --- /dev/null
>> +++ b/util/host-gpu.c
>> @@ -0,0 +1,102 @@
>> +/*
>> + * Utility functions to probe host GPU
>> + *
>> + * Copyright (c) 2025 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/host-gpu.h"
>> +
>> +#include <vulkan/vulkan.h>
>> +
>> +const char *extensions[] =3D {
>> +    /* needed to query the driver details */
>> +    "VK_KHR_get_physical_device_properties2",
>> +};
>> +
>> +/*
>> + * Info for known broken drivers. Sadly driver version info tends to
>> + * be in the driverInfo text field which is free form so tricky to
>> + * parse.
>> + */
>> +struct VkDriverBlockList {
>> +    VkDriverId id;
>> +    const char *reason;
>> +};
>> +
>> +struct VkDriverBlockList vulkan_blocklist[] =3D {
>> +    /* at least 535.183.01 is reported to SEGV in libnvidia-eglcore.so =
*/
>> +    { VK_DRIVER_ID_NVIDIA_PROPRIETARY, "proprietary nVidia driver is br=
oken" },
>> +};
>> +
>> +static bool is_driver_blocked(VkPhysicalDevice dev, Error **errp)
>> +{
>> +    VkPhysicalDeviceDriverProperties driverProperties =3D {
>> +        .sType =3D VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_DRIVER_PROPERTIES,
>> +        .pNext =3D NULL
>> +    };
>> +    VkPhysicalDeviceProperties2 deviceProperties2 =3D {
>> +        .sType =3D VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2,
>> +        .pNext =3D &driverProperties
>> +    };
>> +    VkPhysicalDeviceProperties *deviceProperties =3D &deviceProperties2=
.properties;
>> +
>> +    vkGetPhysicalDeviceProperties2(dev, &deviceProperties2);
>> +
>> +    for (int i =3D 0; i < ARRAY_SIZE(vulkan_blocklist); i++) {
>> +        if (driverProperties.driverID =3D=3D vulkan_blocklist[i].id) {
>> +            error_setg(errp, "Blocked GPU %s because %s",
>> +                       deviceProperties->deviceName,
>> +                       vulkan_blocklist[i].reason);
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +bool validate_vulkan_backend(Error **errp)
>> +{
>> +    VkInstanceCreateInfo instance_info =3D {
>> +        VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
>> +        NULL, /* pNext extension */
>> +        0,    /* VkInstanceCreateFlags */
>> +        NULL, /* Application Info */
>> +        0, NULL, /* no Enabled Layers */
>> +        ARRAY_SIZE(extensions), extensions, /* Extensions */
>> +    };
>> +
>> +    VkInstance inst;
>> +    VkResult res;
>> +
>> +    res =3D vkCreateInstance(&instance_info, NULL, &inst);
>> +
>> +    if ( res =3D=3D VK_SUCCESS ) {
>> +        uint32_t count;
>> +        VkPhysicalDevice *devices;
>> +
>> +        /* Do the enumeration two-step */
>> +        vkEnumeratePhysicalDevices(inst, &count, NULL);
>> +        devices =3D g_new0(VkPhysicalDevice, count);
>> +        vkEnumeratePhysicalDevices(inst, &count, devices);
>> +
>> +        for (int i =3D 0; i  < count; i++) {
>> +            if (is_driver_blocked(devices[i], errp)) {
>> +                return false;
>> +            }
>> +        }
>> +    } else {
>> +        error_setg(errp, "Could not initialise a Vulkan instance");
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * It would be nice to g_autofree the instance, but returning
>> +     * false will abort start-up anyway.
>> +     */
>> +    vkDestroyInstance(inst, NULL);
>> +    return true;
>> +}
>> diff --git a/stubs/meson.build b/stubs/meson.build
>> index b0fee37e05..c18501aa6d 100644
>> --- a/stubs/meson.build
>> +++ b/stubs/meson.build
>> @@ -89,3 +89,7 @@ if have_system or have_user
>>    stub_ss.add(files('hotplug-stubs.c'))
>>    stub_ss.add(files('sysbus.c'))
>>  endif
>> +
>> +if not vulkan.found()
>> +  stubs_ss.add(files('host-gpu.c'))
>> +endif
>> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functiona=
l/test_aarch64_virt_gpu.py
>> index 7a8471d1ca..9a0e694049 100755
>> --- a/tests/functional/test_aarch64_virt_gpu.py
>> +++ b/tests/functional/test_aarch64_virt_gpu.py
>> @@ -79,6 +79,8 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, =
weston_pattern):
>>                  self.skipTest("Can't access host DRM render node")
>>              elif "'type' does not accept value 'egl-headless'" in excp.=
output:
>>                  self.skipTest("egl-headless support is not available")
>> +            elif "Blocked GPU" in excp.output:
>> +                self.skipTest("GPU is in block list")
>>              else:
>>                  self.log.info(f"unhandled launch failure: {excp.output}=
")
>>                  raise excp
>> diff --git a/util/meson.build b/util/meson.build
>> index 780b5977a8..7c6cc36e07 100644
>> --- a/util/meson.build
>> +++ b/util/meson.build
>> @@ -132,3 +132,5 @@ elif cpu in ['ppc', 'ppc64']
>>  elif cpu in ['riscv32', 'riscv64']
>>    util_ss.add(files('cpuinfo-riscv.c'))
>>  endif
>> +
>> +util_ss.add(when: vulkan, if_true: files('host-gpu.c'))
>> --=20
>> 2.39.5
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

