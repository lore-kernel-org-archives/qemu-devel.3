Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E55C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlVSy-00084k-F7; Fri, 21 Feb 2025 11:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tlVSr-00084E-RJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:01:21 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tlVSp-0005Jw-If
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:01:21 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso4277701a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740153677; x=1740758477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xw1vF6AihJVoV0FmpHkYX7ZZTVv19ZySa0bAvebARUg=;
 b=cskcN4kB51tgHXGh2kAor6ixZkwPVn6T2WAN7XmbqSnajoBJlbc7z/boSY6DXHGdJD
 w05ApdzBfzpMvp+kCHUyJM+yHuqrkjIBxIvV0zr/3GkOrqGwxc/ORpvkBV3w8mE2KT3y
 xIu3UrC07crnmKfUcHDzQ8Rcny8wJL96XCYqSaPzu/qJ7J+qeiyWX8ab+Iw/TMOwH4PV
 ZcAsL7Mx42vU6ACCM0+/QLKltnQ5IOOrc61GjbwdDnP6cCxD+6dcZAQ/3TydmmxBEkBE
 R24RBdJU5TMdMRpfc8gDiZ+yzuXK2Kqb8Usj2KLXABIJewl1uZ7nOVEzb9nujbZmNCrV
 hkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740153677; x=1740758477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xw1vF6AihJVoV0FmpHkYX7ZZTVv19ZySa0bAvebARUg=;
 b=qbwb8lrngF3Toxi+CnG2OZrQsQi3wMewMKGnIYHCtpOs26A0Ats79FzGoynU4q0qjK
 Xi5pIGjn211snviA9aIB9UmFRvvDtSSWR0VUUoLhwo2LIBanpn7WCt7hEbm9KbDEcQDp
 zYHf49pDV9hKz1/+vt424/2chdbF1in9GE3Hjw4+NdD/bcyDaXzXV4IEKS/lGCtdz5DQ
 ZuUSD32+gvkuC69QHhI2ZT2L2eCROZJ1oTsgB0Rp0j0RGUcBaa9u6sMh8TN428QJs3Kd
 m5jNPq1UShvZJV3xw973YjqmYLHrrUgUMIyz5Cx18+yABg804iJwL+lZAuc3zX7CVIfk
 CgaA==
X-Gm-Message-State: AOJu0YwHglcMCpPCpvzqnCePrqaCr8KMnd5yE+87MKM1QwteC/vfXu3O
 EVCWeXK4CuvUStGnQI/JPHQoZpdxmhSlqzYa/cWsA6O01ZiEiVlD9jQvQv35K8Q=
X-Gm-Gg: ASbGncsIL9FmGXTu0qoW3lCoXDiCxmbzPuwKzfQNkdKb1gIlLeJDf7TKJLB7lPzvhp8
 rGuQk5hRl+L3/a7ZnmC6jNN1/R9J3YQp3maa9yYFctoGjXNNrmDx7iRtoQdasR9QqA6bxPIBAtc
 xa158k2LwakAeepilv8hOD1B8OPHbTuauSHmeJ0LUP/khd/j8VTynSKdscWTMbdN3ALlnUm5FXN
 4MPX2IN5Ajb4S0Hz1TodI8WDLmGXxmvbWYDP6Pbtdfe0O55MihJSBWm4kfb6YAOyxepTKSyczil
 L0yH9VMRZTCj2cqmZeher7d+ea8R
X-Google-Smtp-Source: AGHT+IHx98+H9nn8ri5dkOmfp79xmTQmFqKesMbkEXOQ6i9x1L7qkSI9Lorz+z8S87a+J/wN77oY9w==
X-Received: by 2002:a05:6402:4606:b0:5dc:cf9b:b033 with SMTP id
 4fb4d7f45d1cf-5e0b70bc283mr3016960a12.5.1740153673203; 
 Fri, 21 Feb 2025 08:01:13 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1b4e8dsm13773040a12.14.2025.02.21.08.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 08:01:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CEA395F8C8;
 Fri, 21 Feb 2025 16:01:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] hw/display: add blocklist for known bad drivers
Date: Fri, 21 Feb 2025 16:01:01 +0000
Message-Id: <20250221160101.2318357-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

While running the new GPU tests it was noted that the proprietary
nVidia driver barfed when run under the sanitiser:

  2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
  EOTF mode SDR and colorimetry mode default.
  2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
  profile: stock sRGB color profile

  and that's the last thing it outputs.

  The sanitizer reports that when the framework sends the SIGTERM
  because of the timeout we get a write to a NULL pointer (but
  interesting not this time in an atexit callback):

  UndefinedBehaviorSanitizer:DEADLYSIGNAL
  ==471863==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address
  0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
  T471863)
  ==471863==The signal is caused by a WRITE memory access.
  ==471863==Hint: address points to the zero page.
      #0 0x7a18ceaafe80
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #1 0x7a18ce9e72c0
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #2 0x7a18ce9f11bb
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #3 0x7a18ce6dc9d1
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #4 0x7a18e7d15326 in vrend_renderer_create_fence
  /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vrend_renderer.c:10883:26
      #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd

The #dri-devel channel confirmed:

  <digetx> stsquad: nv driver is known to not work with venus, don't use
      it for testing

So lets implement a blocklist to stop users starting a known bad
setup.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 meson.build                               |   4 +
 include/qemu/host-gpu.h                   |  23 +++++
 hw/display/virtio-gpu.c                   |   4 +
 stubs/host-gpu.c                          |  17 ++++
 util/host-gpu.c                           | 102 ++++++++++++++++++++++
 stubs/meson.build                         |   4 +
 tests/functional/test_aarch64_virt_gpu.py |   2 +
 util/meson.build                          |   2 +
 8 files changed, 158 insertions(+)
 create mode 100644 include/qemu/host-gpu.h
 create mode 100644 stubs/host-gpu.c
 create mode 100644 util/host-gpu.c

diff --git a/meson.build b/meson.build
index 4588bfd864..8f4a431445 100644
--- a/meson.build
+++ b/meson.build
@@ -1373,12 +1373,16 @@ if not get_option('qatzip').auto() or have_system
 endif
 
 virgl = not_found
+vulkan = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
 if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
   virgl = dependency('virglrenderer',
                      method: 'pkg-config',
                      required: get_option('virglrenderer'))
+  vulkan = dependency('vulkan',
+                      method: 'pkg-config',
+                      required: get_option('virglrenderer'))
 endif
 rutabaga = not_found
 if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
diff --git a/include/qemu/host-gpu.h b/include/qemu/host-gpu.h
new file mode 100644
index 0000000000..45053c2f77
--- /dev/null
+++ b/include/qemu/host-gpu.h
@@ -0,0 +1,23 @@
+/*
+ * Utility functions to probe host GPU
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HOST_GPU_H
+#define HOST_GPU_H
+
+#include "qapi/error.h"
+
+/**
+ * validate_vulkan_backend() - verify working backend
+ *
+ * errp: error pointer
+ *
+ * If the system vulkan implementation is known to not work return
+ * false otherwise true.
+ */
+bool validate_vulkan_backend(Error **errp);
+
+#endif /* HOST_GPU_H */
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 11a7a85750..816eedf838 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -32,6 +32,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/host-gpu.h"
 
 #define VIRTIO_GPU_VM_VERSION 1
 
@@ -1498,6 +1499,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
             error_setg(errp, "venus requires enabled blob and hostmem options");
             return;
         }
+        if (!validate_vulkan_backend(errp)) {
+            return;
+        }
     #else
         error_setg(errp, "old virglrenderer, venus unsupported");
         return;
diff --git a/stubs/host-gpu.c b/stubs/host-gpu.c
new file mode 100644
index 0000000000..7bf76ee4f6
--- /dev/null
+++ b/stubs/host-gpu.c
@@ -0,0 +1,17 @@
+/*
+ * Stub of utility functions to probe host GPU
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/host-gpu.h"
+
+bool validate_vulkan_backend(Error **errp)
+{
+    error_setg(errp, "No vulkan library present");
+    return false;
+}
diff --git a/util/host-gpu.c b/util/host-gpu.c
new file mode 100644
index 0000000000..5e7bf2557c
--- /dev/null
+++ b/util/host-gpu.c
@@ -0,0 +1,102 @@
+/*
+ * Utility functions to probe host GPU
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/host-gpu.h"
+
+#include <vulkan/vulkan.h>
+
+const char *extensions[] = {
+    /* needed to query the driver details */
+    "VK_KHR_get_physical_device_properties2",
+};
+
+/*
+ * Info for known broken drivers. Sadly driver version info tends to
+ * be in the driverInfo text field which is free form so tricky to
+ * parse.
+ */
+struct VkDriverBlockList {
+    VkDriverId id;
+    const char *reason;
+};
+
+struct VkDriverBlockList vulkan_blocklist[] = {
+    /* at least 535.183.01 is reported to SEGV in libnvidia-eglcore.so */
+    { VK_DRIVER_ID_NVIDIA_PROPRIETARY, "proprietary nVidia driver is broken" },
+};
+
+static bool is_driver_blocked(VkPhysicalDevice dev, Error **errp)
+{
+    VkPhysicalDeviceDriverProperties driverProperties = {
+        .sType = VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_DRIVER_PROPERTIES,
+        .pNext = NULL
+    };
+    VkPhysicalDeviceProperties2 deviceProperties2 = {
+        .sType = VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2,
+        .pNext = &driverProperties
+    };
+    VkPhysicalDeviceProperties *deviceProperties = &deviceProperties2.properties;
+
+    vkGetPhysicalDeviceProperties2(dev, &deviceProperties2);
+
+    for (int i = 0; i < ARRAY_SIZE(vulkan_blocklist); i++) {
+        if (driverProperties.driverID == vulkan_blocklist[i].id) {
+            error_setg(errp, "Blocked GPU %s because %s",
+                       deviceProperties->deviceName,
+                       vulkan_blocklist[i].reason);
+            return true;
+        }
+    }
+
+    return false;
+}
+
+bool validate_vulkan_backend(Error **errp)
+{
+    VkInstanceCreateInfo instance_info = {
+        VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
+        NULL, /* pNext extension */
+        0,    /* VkInstanceCreateFlags */
+        NULL, /* Application Info */
+        0, NULL, /* no Enabled Layers */
+        ARRAY_SIZE(extensions), extensions, /* Extensions */
+    };
+
+    VkInstance inst;
+    VkResult res;
+
+    res = vkCreateInstance(&instance_info, NULL, &inst);
+
+    if ( res == VK_SUCCESS ) {
+        uint32_t count;
+        VkPhysicalDevice *devices;
+
+        /* Do the enumeration two-step */
+        vkEnumeratePhysicalDevices(inst, &count, NULL);
+        devices = g_new0(VkPhysicalDevice, count);
+        vkEnumeratePhysicalDevices(inst, &count, devices);
+
+        for (int i = 0; i  < count; i++) {
+            if (is_driver_blocked(devices[i], errp)) {
+                return false;
+            }
+        }
+    } else {
+        error_setg(errp, "Could not initialise a Vulkan instance");
+        return false;
+    }
+
+    /*
+     * It would be nice to g_autofree the instance, but returning
+     * false will abort start-up anyway.
+     */
+    vkDestroyInstance(inst, NULL);
+    return true;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index b0fee37e05..c18501aa6d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -89,3 +89,7 @@ if have_system or have_user
   stub_ss.add(files('hotplug-stubs.c'))
   stub_ss.add(files('sysbus.c'))
 endif
+
+if not vulkan.found()
+  stubs_ss.add(files('host-gpu.c'))
+endif
diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 7a8471d1ca..9a0e694049 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -79,6 +79,8 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
                 self.skipTest("Can't access host DRM render node")
             elif "'type' does not accept value 'egl-headless'" in excp.output:
                 self.skipTest("egl-headless support is not available")
+            elif "Blocked GPU" in excp.output:
+                self.skipTest("GPU is in block list")
             else:
                 self.log.info(f"unhandled launch failure: {excp.output}")
                 raise excp
diff --git a/util/meson.build b/util/meson.build
index 780b5977a8..7c6cc36e07 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -132,3 +132,5 @@ elif cpu in ['ppc', 'ppc64']
 elif cpu in ['riscv32', 'riscv64']
   util_ss.add(files('cpuinfo-riscv.c'))
 endif
+
+util_ss.add(when: vulkan, if_true: files('host-gpu.c'))
-- 
2.39.5


