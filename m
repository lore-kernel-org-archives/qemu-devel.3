Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B30C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBw9-0003xJ-9H; Mon, 16 Dec 2024 09:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBw6-0003vF-Jq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:02 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBw4-0000CH-Fz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:02 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so3551838b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358739; x=1734963539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qi8EZZuZhyaL/yFJbVrcptaHouF/D/HSpATmwYA9Dwg=;
 b=SbFQtwGjhf4cveIwDLs7rDM9hVP3Ia2wnoXFiQMAPWaQOKymO4uLVu5CejAtMW3Ptm
 nuYJPWvMyQkLrYqzP/+iTXEYraMvxfyW74bsn99DqVuC2u7TMFscdhVW6vfw07QGBWqF
 c5lLv+euLB1I2+CRpNbgMNRrRgWRt9/u7SOTaPmYmz9wJJq8rkNyj2eJ2hI0esvrzOg1
 SxCt++3xgclfTOTJahvLnPeB++zgK8rTEBJO6aHx7gXNM+gbTYYOmq+Q7SYcAaq73cB8
 6mayJTJYHlI9P1HQKuY5sgNsT8EdD8XD1uhos7ks6BpjPEuawPF1Iyg8ti1Yj7SHPUtf
 crkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358739; x=1734963539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qi8EZZuZhyaL/yFJbVrcptaHouF/D/HSpATmwYA9Dwg=;
 b=p4vZRnu7Z0DNOLg89PfSGJVFY1I4skCttzsVkH7r2ljdijQa1jJc58q1h0hkRgKz+T
 BA5taltdK4SbxYgeZfU4f/YYVtZTwHnDh9WnhVVbiyIGCVImzZVHGTzs1nEqxnZ1/QjA
 fw6W8CzAzWrvrmwHbkMWwgLuXfvl7UqzzlQjbmw+YhWoIrmbHokFgMTM6fyLn5cCEOWD
 x/dky9BC5NNIMbMhTO1CIl7F8HqtEXRk+NX0zvabuTxqrjiAS6GD8/P4+u+hKHv6LC8j
 v6yKK/2ndO+a8k2btKAALyiPH8JC3zEA2ovmW4OPprO/z0gHpnxAZSgnrBljOdalDQPi
 KZNQ==
X-Gm-Message-State: AOJu0YztTi7soW4L2hzjzFWMtxNggnP0/kaY8a8d3m23QR6HHmd3hou3
 oJjwjXs5Fy7gHyj3ht/K6cqpHhf+t6FGI755kLEZhA++16L5ZYU/y4Vkl4Iu78Oz8aYNKfztZjm
 d
X-Gm-Gg: ASbGncsK6Ctn2bKu02F6n9rT5sjvLvOyjQ5NANHvMNWGRWxqlwoEsyGeBX6o7x4CvCG
 8Nv05lIMtWuAj7jNjKgpQpBeJfmM8U5cPbpe7bOv2bVbYy96tpx1m1ji4P45sl9oAfX4TkiQK3C
 Ny/HSFkW5DAAgofD9QRIVf5aweQLbg4fstU4LnTHdbPDGTn8t4dOIOr+9NjPqzQeTFWWFEp80T2
 7J96/xUKvwD8NzGqzZzu+6ljwrNFsHEEURs53QWAEmwvfFOTV3zgtt5KnDtfSo=
X-Google-Smtp-Source: AGHT+IH8pPDZ/5TGr56TeQJ6mls6zBwqtAVxXKJNEPLtzi/Krap7xQF4MYDexJJsm9ZObo8JpHjiiA==
X-Received: by 2002:a05:6a00:238c:b0:728:e2cc:bfd6 with SMTP id
 d2e1a72fcca58-7290c22e8a5mr16605242b3a.18.1734358738580; 
 Mon, 16 Dec 2024 06:18:58 -0800 (PST)
Received: from gromero0.. ([177.189.100.90]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bad8acsm4948815b3a.146.2024.12.16.06.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:18:58 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org,
 alex.bennee@linaro.org, thuth@redhat.com, armbru@redhat.com
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 2/7] hw/misc/ivshmem-flat: Allow device to wire itself on
 sysbus
Date: Mon, 16 Dec 2024 14:18:13 +0000
Message-Id: <20241216141818.111255-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216141818.111255-1-gustavo.romero@linaro.org>
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42d.google.com
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

This commit enables the ivshmem-flat device to wire itself on sysbus. It
maps the device's Memory-Mapped Registers (MMRs) and shared memory
(shmem) into the VM's memory layout and also allows connection to an
input IRQ so that the device can trigger an interrupt for notification.

Three device options are introduced to control how this is done:
x-bus-address-iomem, x-bus-address-shmem, and x-irq-qompath.

The following is an example on how to create the ivshmem-flat device on
a Stellaris machine:

$ qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nographic
                  -net none -chardev stdio,id=con,mux=on
                  -serial chardev:con -mon chardev=con,mode=readline
                  -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem_flat
                  -device ivshmem-flat,chardev=ivshmem_flat,x-irq-qompath='/machine/soc/v7m/nvic/unnamed-gpio-in[0]',x-bus-address-iomem=0x400FF000,x-bus-address-shmem=0x40100000
                  -kernel zephyr_kernel.elf

The IRQ QOM path option for the target machine can be determined by
creating the VM without the ivshmem-flat device, going to the QEMU
monitor and listing the QOM nodes with 'info qom-tree'. In the Stellaris
example above the input IRQ is in the machine's NVIC Interrupt
Controller.

If 'x-irq-qompath' is not provided the device won't be able to be
interrupted by other VMs (peers) and only the shared memory (shmem)
feature will be supported.

The MMRs for status and control (notification) are mapped to the MMIO
region at 'x-bus-address-iomem', whilst the shared memory region start
is mapped at address specified by 'x-bus-address-shmem'.

Message-ID: <20231127052024.435743-2-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/devices/ivshmem-flat.rst | 57 +++++++++++++++++++++
 hw/core/sysbus-fdt.c                 |  2 +
 hw/misc/ivshmem-flat.c               | 74 ++++++++++++++++++++++++++--
 include/hw/misc/ivshmem-flat.h       |  9 ++++
 4 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/ivshmem-flat.rst b/docs/system/devices/ivshmem-flat.rst
index 1f97052804..abc67870de 100644
--- a/docs/system/devices/ivshmem-flat.rst
+++ b/docs/system/devices/ivshmem-flat.rst
@@ -31,3 +31,60 @@ the IRQ mechanism is disabled). The shared memory region is always present.
 The MMRs (INTRMASK, INTRSTATUS, IVPOSITION, and DOORBELL registers) offsets at
 the MMR region, and their functions, follow the ivshmem spec, so they work
 exactly as in the ivshmem PCI device (see ./specs/ivshmem-spec.txt).
+
+
+Device Options
+--------------
+
+The required options to create an ivshmem-flat device are: (a) the UNIX
+socket where the ivshmem server is listening, usually ``/tmp/ivshmem_socket``;
+(b) the address where to map the MMRs (``x-bus-address-iomem=``) in the VM
+memory layout; and (c) the address where to map the shared memory in the VM
+memory layout (``x-bus-address-shmem=``). Both (a) and (b) depend on the VM
+being used, as the MMRs and shmem must be mapped to a region not previously
+occupied in the VM.
+
+Example:
+
+.. parsed-literal::
+
+    |qemu-system-arm| -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem_flat -device ivshmem-flat,chardev=ivshmem_flat,x-irq-qompath='/machine/soc/v7m/nvic/unnamed-gpio-in[0]',x-bus-address-iomem=0x400FF000,x-bus-address-shmem=0x40100000
+
+The other option, ``x-irq-qompath=``, is not required if the user doesn't want
+the device supporting notifications.
+
+``x-irq-qompath``. Used to inform the device what IRQ input line it can attach
+to to enable the notification mechanism (IRQ). The ivshmem-flat device currently
+only supports notification via vector 0. Notification via other vectors are
+ignored. (optional)
+
+Two examples for different machines follow.
+
+Stellaris machine (``-machine lm3s6965evb``):
+
+::
+
+    x-irq-qompath=/machine/soc/v7m/nvic/unnamed-gpio-in[0]
+
+Arm mps2-an385 machine (``-machine mps2-an385``):
+
+::
+
+    x-irq-qompath=/machine/armv7m/nvic/unnamed-gpio-in[0]
+
+The available IRQ input lines on a given VM that the ivshmem-flat device can be
+attached should be found using the QEMU monitor (Ctrl-a + c) with:
+
+(qemu) info qom-tree
+
+``x-bus-address-iomem``. Allows changing the address where the MMRs are mapped
+into the VM memory layout. (required)
+
+ ``x-bus-address-shmem``. Allows changing the address where the shared memory
+region is mapped into the VM memory layout. (required)
+
+``shmem-size``. Allows changing the size (in bytes) of shared memory region.
+Default is 4 MiB, which is the same default used by the ivshmem server, so
+usually it's not necessary to change it. The size must match the size of the
+shared memory reserved and informed by the ivshmem server, otherwise the device
+creation fails. (optional)
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index eebcd28f9a..40d7356cae 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/tpm.h"
+#include "hw/misc/ivshmem-flat.h"
 #include "hw/platform-bus.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
@@ -495,6 +496,7 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
 #endif
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
+    TYPE_BINDING(TYPE_IVSHMEM_FLAT, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index 833ee2fefb..972281ca57 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -420,16 +420,86 @@ static bool ivshmem_flat_connect_server(DeviceState *dev, Error **errp)
     return true;
 }
 
+static bool ivshmem_flat_sysbus_wire(DeviceState *dev, Error **errp)
+{
+    IvshmemFTState *s = IVSHMEM_FLAT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (s->x_sysbus_mmio_addr != UINT64_MAX) {
+        trace_ivshmem_flat_mmio_map(s->x_sysbus_mmio_addr);
+        sysbus_mmio_map(sbd, 0, s->x_sysbus_mmio_addr);
+    } else {
+        error_setg(errp, "No address for iomem (MMRs) specified. Can't create"
+                         " ivshmem-flat device. Use 'x-bus-address-iomem'"
+                         " option.");
+        return false;
+    }
+
+    if (s->x_sysbus_shmem_addr != UINT64_MAX) {
+        trace_ivshmem_flat_shmem_map(s->x_sysbus_shmem_addr);
+        sysbus_mmio_map(sbd, 1, s->x_sysbus_shmem_addr);
+    } else {
+        error_setg(errp, "No address for shmem specified. Can't create"
+                         " ivshmem-flat device. Use 'x-bus-address-shmem'"
+                         " option.");
+        return false;
+    }
+
+    /* Check for input IRQ line, if it's provided, connect it. */
+    if (s->x_sysbus_irq_qompath) {
+        Object *oirq;
+        bool ambiguous = false;
+        qemu_irq irq;
+
+        oirq = object_resolve_path_type(s->x_sysbus_irq_qompath, TYPE_IRQ,
+                                        &ambiguous);
+        if (ambiguous) {
+            error_setg(errp, "Specified IRQ is ambiguous. Can't create"
+                             " ivshmem-flat device.");
+            return false;
+        }
+
+        if (!oirq) {
+            error_setg(errp, "Can't resolve IRQ QOM path.");
+            return false;
+        }
+        irq = (qemu_irq)oirq;
+        trace_ivshmem_flat_irq_resolved(s->x_sysbus_irq_qompath);
+
+        /*
+         * Connect device out irq line to interrupt controller input irq line.
+         */
+        sysbus_connect_irq(sbd, 0, irq);
+    } else {
+       /*
+        * If input IRQ is not provided, warn user the device won't be able
+        * to trigger any interrupts.
+        */
+        warn_report("Input IRQ not specified, device won't be able"
+                    " to handle IRQs!");
+    }
+
+    return true;
+}
+
 static void ivshmem_flat_realize(DeviceState *dev, Error **errp)
 {
     if (!ivshmem_flat_connect_server(dev, errp)) {
         return;
     }
+    if (!ivshmem_flat_sysbus_wire(dev, errp)) {
+        return;
+    }
 }
 
 static Property ivshmem_flat_props[] = {
     DEFINE_PROP_CHR("chardev", IvshmemFTState, server_chr),
     DEFINE_PROP_UINT32("shmem-size", IvshmemFTState, shmem_size, 4 * MiB),
+    DEFINE_PROP_STRING("x-irq-qompath", IvshmemFTState, x_sysbus_irq_qompath),
+    DEFINE_PROP_UINT64("x-bus-address-iomem", IvshmemFTState,
+                       x_sysbus_mmio_addr, UINT64_MAX),
+    DEFINE_PROP_UINT64("x-bus-address-shmem", IvshmemFTState,
+                       x_sysbus_shmem_addr, UINT64_MAX),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -438,13 +508,11 @@ static void ivshmem_flat_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->hotpluggable = true;
+    dc->user_creatable = true;
     dc->realize = ivshmem_flat_realize;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     device_class_set_props(dc, ivshmem_flat_props);
-
-    /* Reason: Must be wired up in code (sysbus MRs and IRQ) */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo ivshmem_flat_info = {
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
index 97ca0ddce6..d5b6d99ae4 100644
--- a/include/hw/misc/ivshmem-flat.h
+++ b/include/hw/misc/ivshmem-flat.h
@@ -25,6 +25,12 @@
  *    socket
  *  + QOM property "shmem-size" sets the size of the RAM region shared between
  *    the device and the ivshmem server
+ *  + QOM property "x-bus-address-iomem" is the base address of the I/O region
+ *    on the main system bus
+ *  + QOM property "x-bus-address-shmem" is the base address of the shared RAM
+ *    region on the main system bus
+ *  + QOM property "x-irq-qompath" is the QOM path of the interrupt being
+ *    notified
  *  + sysbus MMIO region 0: device I/O mapped registers
  *  + sysbus MMIO region 1: shared memory with ivshmem server
  *  + sysbus IRQ 0: single output interrupt
@@ -68,9 +74,11 @@ struct IvshmemFTState {
 
     /* IRQ */
     qemu_irq irq;
+    char *x_sysbus_irq_qompath;
 
     /* I/O registers */
     MemoryRegion iomem;
+    uint64_t x_sysbus_mmio_addr;
     uint32_t intmask;
     uint32_t intstatus;
     uint32_t ivposition;
@@ -80,6 +88,7 @@ struct IvshmemFTState {
     MemoryRegion shmem;
     int shmem_fd;
     uint32_t shmem_size;
+    uint64_t x_sysbus_shmem_addr;
 };
 
 #endif /* IVSHMEM_FLAT_H */
-- 
2.34.1


