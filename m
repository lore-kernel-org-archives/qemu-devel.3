Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEE3C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 10:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmVP9-0008O7-Ln; Mon, 24 Feb 2025 05:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmVP3-0008NX-Or
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmVOw-0005Nq-6r
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740391762;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g65477UWME0sYTgeMq+nmZ9ckc7est2IwBukxg9u6dE=;
 b=iN+i4AqwJPeAxpwakf3kgOf6rAC84gim7S6ZkfPRdTJgf9X3AxyKGWSq+Xc5DCCOmEbtZc
 upID/YnwWqW66SbxVJcmbMdyKdAxlYarNN7Y/dN8qbQ28cNGX9LUaZGLD9E5gQGBpparfN
 6w0OZCpLvCi3TcstjZ4NA5BgFSvQkLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-8stL-y1rPhKlKRgGjMMJvg-1; Mon,
 24 Feb 2025 05:09:19 -0500
X-MC-Unique: 8stL-y1rPhKlKRgGjMMJvg-1
X-Mimecast-MFC-AGG-ID: 8stL-y1rPhKlKRgGjMMJvg_1740391758
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A63D019783B7; Mon, 24 Feb 2025 10:09:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.119])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5781800374; Mon, 24 Feb 2025 10:09:10 +0000 (UTC)
Date: Mon, 24 Feb 2025 10:09:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] hw/display: add blocklist for known bad drivers
Message-ID: <Z7xFQ4bHwBEo8aQw@redhat.com>
References: <20250221160101.2318357-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221160101.2318357-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 21, 2025 at 04:01:01PM +0000, Alex Bennée wrote:
> While running the new GPU tests it was noted that the proprietary
> nVidia driver barfed when run under the sanitiser:
> 
>   2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
>   EOTF mode SDR and colorimetry mode default.
>   2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
>   profile: stock sRGB color profile
> 
>   and that's the last thing it outputs.
> 
>   The sanitizer reports that when the framework sends the SIGTERM
>   because of the timeout we get a write to a NULL pointer (but
>   interesting not this time in an atexit callback):
> 
>   UndefinedBehaviorSanitizer:DEADLYSIGNAL
>   ==471863==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address
>   0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
>   T471863)
>   ==471863==The signal is caused by a WRITE memory access.
>   ==471863==Hint: address points to the zero page.
>       #0 0x7a18ceaafe80
>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>       #1 0x7a18ce9e72c0
>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>       #2 0x7a18ce9f11bb
>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>       #3 0x7a18ce6dc9d1
>   (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
>   (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>       #4 0x7a18e7d15326 in vrend_renderer_create_fence
>   /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vrend_renderer.c:10883:26
>       #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd
> 
> The #dri-devel channel confirmed:
> 
>   <digetx> stsquad: nv driver is known to not work with venus, don't use
>       it for testing
> 
> So lets implement a blocklist to stop users starting a known bad
> setup.

I don't much like the conceptual idea of blocking usage of QEMU itself
based on current point-in-time bugs in the host OS driver stack, because
it is making an assertion that all future versions of the driver will
also be broken and that's not generally valid.

If the user chose to use a dodgy graphics driver, they can deal with
the consequences of their choice.

Skipping only the functional test, without any qemu-system code changes
though is more palettable as that's not a hard block on usage.

> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  meson.build                               |   4 +
>  include/qemu/host-gpu.h                   |  23 +++++
>  hw/display/virtio-gpu.c                   |   4 +
>  stubs/host-gpu.c                          |  17 ++++
>  util/host-gpu.c                           | 102 ++++++++++++++++++++++
>  stubs/meson.build                         |   4 +
>  tests/functional/test_aarch64_virt_gpu.py |   2 +
>  util/meson.build                          |   2 +
>  8 files changed, 158 insertions(+)
>  create mode 100644 include/qemu/host-gpu.h
>  create mode 100644 stubs/host-gpu.c
>  create mode 100644 util/host-gpu.c
> 
> diff --git a/meson.build b/meson.build
> index 4588bfd864..8f4a431445 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1373,12 +1373,16 @@ if not get_option('qatzip').auto() or have_system
>  endif
>  
>  virgl = not_found
> +vulkan = not_found
>  
>  have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
>  if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>    virgl = dependency('virglrenderer',
>                       method: 'pkg-config',
>                       required: get_option('virglrenderer'))
> +  vulkan = dependency('vulkan',
> +                      method: 'pkg-config',
> +                      required: get_option('virglrenderer'))
>  endif
>  rutabaga = not_found
>  if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
> diff --git a/include/qemu/host-gpu.h b/include/qemu/host-gpu.h
> new file mode 100644
> index 0000000000..45053c2f77
> --- /dev/null
> +++ b/include/qemu/host-gpu.h
> @@ -0,0 +1,23 @@
> +/*
> + * Utility functions to probe host GPU
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef HOST_GPU_H
> +#define HOST_GPU_H
> +
> +#include "qapi/error.h"
> +
> +/**
> + * validate_vulkan_backend() - verify working backend
> + *
> + * errp: error pointer
> + *
> + * If the system vulkan implementation is known to not work return
> + * false otherwise true.
> + */
> +bool validate_vulkan_backend(Error **errp);
> +
> +#endif /* HOST_GPU_H */
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 11a7a85750..816eedf838 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -32,6 +32,7 @@
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "qemu/host-gpu.h"
>  
>  #define VIRTIO_GPU_VM_VERSION 1
>  
> @@ -1498,6 +1499,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>              error_setg(errp, "venus requires enabled blob and hostmem options");
>              return;
>          }
> +        if (!validate_vulkan_backend(errp)) {
> +            return;
> +        }
>      #else
>          error_setg(errp, "old virglrenderer, venus unsupported");
>          return;
> diff --git a/stubs/host-gpu.c b/stubs/host-gpu.c
> new file mode 100644
> index 0000000000..7bf76ee4f6
> --- /dev/null
> +++ b/stubs/host-gpu.c
> @@ -0,0 +1,17 @@
> +/*
> + * Stub of utility functions to probe host GPU
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/host-gpu.h"
> +
> +bool validate_vulkan_backend(Error **errp)
> +{
> +    error_setg(errp, "No vulkan library present");
> +    return false;
> +}
> diff --git a/util/host-gpu.c b/util/host-gpu.c
> new file mode 100644
> index 0000000000..5e7bf2557c
> --- /dev/null
> +++ b/util/host-gpu.c
> @@ -0,0 +1,102 @@
> +/*
> + * Utility functions to probe host GPU
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/host-gpu.h"
> +
> +#include <vulkan/vulkan.h>
> +
> +const char *extensions[] = {
> +    /* needed to query the driver details */
> +    "VK_KHR_get_physical_device_properties2",
> +};
> +
> +/*
> + * Info for known broken drivers. Sadly driver version info tends to
> + * be in the driverInfo text field which is free form so tricky to
> + * parse.
> + */
> +struct VkDriverBlockList {
> +    VkDriverId id;
> +    const char *reason;
> +};
> +
> +struct VkDriverBlockList vulkan_blocklist[] = {
> +    /* at least 535.183.01 is reported to SEGV in libnvidia-eglcore.so */
> +    { VK_DRIVER_ID_NVIDIA_PROPRIETARY, "proprietary nVidia driver is broken" },
> +};
> +
> +static bool is_driver_blocked(VkPhysicalDevice dev, Error **errp)
> +{
> +    VkPhysicalDeviceDriverProperties driverProperties = {
> +        .sType = VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_DRIVER_PROPERTIES,
> +        .pNext = NULL
> +    };
> +    VkPhysicalDeviceProperties2 deviceProperties2 = {
> +        .sType = VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2,
> +        .pNext = &driverProperties
> +    };
> +    VkPhysicalDeviceProperties *deviceProperties = &deviceProperties2.properties;
> +
> +    vkGetPhysicalDeviceProperties2(dev, &deviceProperties2);
> +
> +    for (int i = 0; i < ARRAY_SIZE(vulkan_blocklist); i++) {
> +        if (driverProperties.driverID == vulkan_blocklist[i].id) {
> +            error_setg(errp, "Blocked GPU %s because %s",
> +                       deviceProperties->deviceName,
> +                       vulkan_blocklist[i].reason);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +bool validate_vulkan_backend(Error **errp)
> +{
> +    VkInstanceCreateInfo instance_info = {
> +        VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
> +        NULL, /* pNext extension */
> +        0,    /* VkInstanceCreateFlags */
> +        NULL, /* Application Info */
> +        0, NULL, /* no Enabled Layers */
> +        ARRAY_SIZE(extensions), extensions, /* Extensions */
> +    };
> +
> +    VkInstance inst;
> +    VkResult res;
> +
> +    res = vkCreateInstance(&instance_info, NULL, &inst);
> +
> +    if ( res == VK_SUCCESS ) {
> +        uint32_t count;
> +        VkPhysicalDevice *devices;
> +
> +        /* Do the enumeration two-step */
> +        vkEnumeratePhysicalDevices(inst, &count, NULL);
> +        devices = g_new0(VkPhysicalDevice, count);
> +        vkEnumeratePhysicalDevices(inst, &count, devices);
> +
> +        for (int i = 0; i  < count; i++) {
> +            if (is_driver_blocked(devices[i], errp)) {
> +                return false;
> +            }
> +        }
> +    } else {
> +        error_setg(errp, "Could not initialise a Vulkan instance");
> +        return false;
> +    }
> +
> +    /*
> +     * It would be nice to g_autofree the instance, but returning
> +     * false will abort start-up anyway.
> +     */
> +    vkDestroyInstance(inst, NULL);
> +    return true;
> +}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index b0fee37e05..c18501aa6d 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -89,3 +89,7 @@ if have_system or have_user
>    stub_ss.add(files('hotplug-stubs.c'))
>    stub_ss.add(files('sysbus.c'))
>  endif
> +
> +if not vulkan.found()
> +  stubs_ss.add(files('host-gpu.c'))
> +endif
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> index 7a8471d1ca..9a0e694049 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -79,6 +79,8 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
>                  self.skipTest("Can't access host DRM render node")
>              elif "'type' does not accept value 'egl-headless'" in excp.output:
>                  self.skipTest("egl-headless support is not available")
> +            elif "Blocked GPU" in excp.output:
> +                self.skipTest("GPU is in block list")
>              else:
>                  self.log.info(f"unhandled launch failure: {excp.output}")
>                  raise excp
> diff --git a/util/meson.build b/util/meson.build
> index 780b5977a8..7c6cc36e07 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -132,3 +132,5 @@ elif cpu in ['ppc', 'ppc64']
>  elif cpu in ['riscv32', 'riscv64']
>    util_ss.add(files('cpuinfo-riscv.c'))
>  endif
> +
> +util_ss.add(when: vulkan, if_true: files('host-gpu.c'))
> -- 
> 2.39.5
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


