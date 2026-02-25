Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9764CF55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv62l-0005LG-0o; Tue, 24 Feb 2026 22:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62j-0005Ay-IU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62h-0001k2-P1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48069a48629so63033605e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991910; x=1772596710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDJ5oHwDTFTnvPyF5W9FqXaNWmX1XA5vkYpeXUcd/XE=;
 b=WHo06NClfBAJmFaMFWt/4be22Y+VDIKPQ1lRqITMbqibdQEeaxnCplD+q8IeaU/UGw
 SJGtx/IiTZtRw0kuCj2geN3nkDxq2tnCyZNZcRnbAuyIg9BhS7SmISeIPUjAW0YlpL0l
 +Zz7lKRbS1m++yT09NW+4VLZ1VzD7IF45DsX3h3c9M2nt5Rm4XZRoI8ETuRjtvgFBUo+
 55Lb+Xc8Vlt9lvEWk/7WDmUGwBNVZ9aEpoYgrTu2kvaSKpyebZbJKD0eZiz5EmZxxo9Q
 A5+Y7JIP5misHHnSljbNngWWTCXmIesQnsd4quNCLIewviCU9FgL/qDcQmMCBZMDglcL
 bDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991910; x=1772596710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HDJ5oHwDTFTnvPyF5W9FqXaNWmX1XA5vkYpeXUcd/XE=;
 b=DW9kkdkPHBlw+OVNEu79t+NbCh4vtXpWACf+jxf7E7vxbKk8PEoOxPwLrjy5tiYdAk
 cE+M8X/L81O2FhGlJf2TiDafRRY3Jz6L1wZ3sHiIeSLSmzlfKzBTR1/ZK01g0m0gMN+O
 h4J0/oxS6QVAIJTJHPYfQXUPxqVjCkolNkQayc/nWiBMj69DMQ/HUoVbpPj3bdZWYz1V
 yJrr7V98wabOvegodKSJIhTsjgDHES3nmvbOQ02OI9lM8WEGxYyeflL/z+8TuBEQltAY
 xELbFD9hT3Ru2EmfoIFpSfkiTf6AIiA0Jalaf3VCyFXK/gavaDF6/7Q4oaqKATWM16eZ
 mIug==
X-Gm-Message-State: AOJu0YwQS4RKEcUOl+5OhZ3hSHQHK/1ddAywMTqL0pyazwbI1vqjqLhM
 frp7cvnI62VWDJpNRE7uu+JY7NIqUA4C4Oaiy9Pb9W7DjuUbipgZhmA5BjAQ9NZh15ghWNN9hi7
 acr0WiC4=
X-Gm-Gg: ATEYQzzHrYoxaGNYZYmqyhOikZVgI+FGqIHJEO0TEdK+DJojU44HkYyuaM/Gx5CWqCo
 YSmX7Bjngm8MsimTqcK9RBQGtEuVcRkZdlnkzgsCMj+nge4ZtKLi2EIhGcuBihECmnZ3iORDfmx
 qzZpttIV0I0sYvIrPa5yHA3dPBuQegEvL107mHCXFYvkQe+3FHNVPhNnIeqwvgime+aecE2NxR2
 S4OxPL12JVcJE6T+ll0IJhXOWaX19Gs5I3u07hYKRLHHTSUUnJR8IjBl/hE0Dkjl4I9vPm2rg25
 QQeAMnm1GuYGQhzue203yMBCnL3qnlwknviefhZizNCUupBO4hE2n6i71WEPzvEqDU7uPYaQB31
 /O3t+cNCkSFWIfDJJH4ZeF4J3oVHp/bo2V6hLhGMMwrpbZ/Nd0/L7yRSz9ZzTKf2aCZqPncUS+P
 Aq+dX9uvwgvvBodADnlYVDgbSEzC5ojgUjjJgULIDEpagLI86wrfk4r/+WuVUYkjXjB/kxLNVp
X-Received: by 2002:a05:600c:1e28:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483a95fe96bmr212018145e9.32.1771991909793; 
 Tue, 24 Feb 2026 19:58:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19d6sm42005695e9.2.2026.02.24.19.58.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/11] hw/display: Build stubs once
Date: Wed, 25 Feb 2026 04:57:35 +0100
Message-ID: <20260225035739.42848-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/display/acpi-vga-stub.c |  1 +
 hw/display/meson.build     | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/display/acpi-vga-stub.c b/hw/display/acpi-vga-stub.c
index a9b0ecf76d0..ee0fbf8175d 100644
--- a/hw/display/acpi-vga-stub.c
+++ b/hw/display/acpi-vga-stub.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#undef CONFIG_PIXMAN
 #include "hw/acpi/acpi_aml_interface.h"
 #include "vga_int.h"
 
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 90e6c041bdb..e730c289b15 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -3,7 +3,8 @@ hw_display_modules = {}
 system_ss.add(when: 'CONFIG_DDC', if_true: files('i2c-ddc.c'))
 system_ss.add(when: 'CONFIG_EDID', if_true: files('edid-generate.c', 'edid-region.c'))
 
-system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'), if_false: files('ramfb-stubs.c'))
+system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'))
+stub_ss.add(files('ramfb-stubs.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb-standalone.c'))
 
 system_ss.add(when: 'CONFIG_VGA_CIRRUS', if_true: files('cirrus_vga.c'))
@@ -36,21 +37,20 @@ system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
 system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
 
+stub_ss.add([files('acpi-vga-stub.c'), pixman])
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
     config_all_devices.has_key('CONFIG_VGA_PCI') or
     config_all_devices.has_key('CONFIG_VMWARE_VGA') or
     config_all_devices.has_key('CONFIG_ATI_VGA')
    )
-  system_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                      if_false: files('acpi-vga-stub.c'))
+  system_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
 endif
 
 if config_all_devices.has_key('CONFIG_QXL')
   qxl_ss = ss.source_set()
   qxl_ss.add(when: 'CONFIG_QXL', if_true: [files('qxl.c', 'qxl-logger.c', 'qxl-render.c'),
                                            pixman, spice])
-  qxl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                  if_false: files('acpi-vga-stub.c'))
+  qxl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
   hw_display_modules += {'qxl': qxl_ss}
 endif
 
@@ -119,16 +119,14 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
                     if_true: [files('virtio-vga.c'), pixman])
   virtio_vga_ss.add(when: 'CONFIG_VHOST_USER_VGA',
                     if_true: files('vhost-user-vga.c'))
-  virtio_vga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                         if_false: files('acpi-vga-stub.c'))
+  virtio_vga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
   hw_display_modules += {'virtio-vga': virtio_vga_ss}
 
   if virgl.found() and opengl.found()
     virtio_vga_gl_ss = ss.source_set()
     virtio_vga_gl_ss.add(when: ['CONFIG_VIRTIO_VGA', virgl, opengl],
                          if_true: [files('virtio-vga-gl.c'), pixman])
-    virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                              if_false: files('acpi-vga-stub.c'))
+    virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
     hw_display_modules += {'virtio-vga-gl': virtio_vga_gl_ss}
   endif
 
@@ -136,8 +134,7 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
     virtio_vga_rutabaga_ss = ss.source_set()
     virtio_vga_rutabaga_ss.add(when: ['CONFIG_VIRTIO_VGA', rutabaga],
                                if_true: [files('virtio-vga-rutabaga.c'), pixman])
-    virtio_vga_rutabaga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                                    if_false: files('acpi-vga-stub.c'))
+    virtio_vga_rutabaga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
     hw_display_modules += {'virtio-vga-rutabaga': virtio_vga_rutabaga_ss}
   endif
 endif
-- 
2.52.0


