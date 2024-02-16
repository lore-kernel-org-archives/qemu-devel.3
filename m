Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E824BC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razSo-0005Qs-Sk; Fri, 16 Feb 2024 09:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razSn-0005Q5-2I
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:17 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razSl-0005Ok-1h
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:16 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3ddc13bbb3so127387866b.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708094713; x=1708699513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLPMc5ylkP6y7icrClH7VZ3g7ncvDegsosg9by30Ht4=;
 b=tkyh++ZV+vSLYWsg8ynvYvD2WzZj08Icf3jnW/YJVdS+sZTWSgUyccSz3Emy05AD8n
 FygbGIUQs9bpaxZku/7eiy5JkkynBmSG8tgAdnu70SkaxbJQJKvxxOaZZmGlm+F5aZHL
 J5yDIrozOgKCtQpjkbfj1bxB5VYhaqJ8tJLJY4wJ+hfSE26FNenNBgJ1uoMrDRyHBbyp
 lZUk44EiZi5iqAA5ysK9+DcqMjUNpfjXHM9kR6vICtCBQX6UKA/sxUHjk6sw1XkbYhW9
 ey9JtRp89lQQN3P2QarKghbIx3B+Cp1bOhNLC+mnvf8bQDMoXBbCTy314LNwb5qVqcpr
 WWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708094713; x=1708699513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLPMc5ylkP6y7icrClH7VZ3g7ncvDegsosg9by30Ht4=;
 b=IrNtN/IWRVKFtKeuWZm0iqEH5GwlVpRDuxtP2lwDuzBslfaFj0FxRZAjJnBL5JJkd2
 ckKLE1oiDdPXUq1PDkrlpNbMghf67hTzXxtC1Zs6DfzP/3yKtS7VzUXZvTENncABUkvB
 NF0Hjvqh3K8KgMK75qCTRbEqfMwuvYW5KyANiN8juhtcWLzpGX5UME2PDWrZNHyFVgz7
 Npv+JGcoTq2XH98fJshdFFaYlcYgddWUT9p2qCv2cROtFQpg3vsrnBQyj/pAEe8gYM8R
 KABFESRsn9ngAnHPThE8Q9JbqZMzi5slQxBZtQh2E4nZlorkElET1wekrWR6pxmGPcBW
 BWBA==
X-Gm-Message-State: AOJu0YymJAsZfU6bbPLYNs2tAtuNaUfY6GhxSRrr7AZcaYcN9y6dTfnT
 r3OJnTGmQL8jtvzt4q22gKcJ8k119sNVkDphim9qVJ6j6vuvwXtqjpAVFZ6qzS7Vyj6eCQn1uEY
 E
X-Google-Smtp-Source: AGHT+IFPUHD/KZzIm373ceIUJP/l8ije2dVq+LH3+SJGk7jZz6TMdfiu6n1dN9N6nzYmTn4BA9YiEA==
X-Received: by 2002:a17:906:5f84:b0:a3c:1e4d:725a with SMTP id
 a4-20020a1709065f8400b00a3c1e4d725amr6398239eju.37.1708094712236; 
 Fri, 16 Feb 2024 06:45:12 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 lu15-20020a170906facf00b00a3d1c0a3d5dsm2653ejb.63.2024.02.16.06.45.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 06:45:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anton Kochkov <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/6] hw/misc/ivshmem-flat: Allow device to wire itself on
 sysbus
Date: Fri, 16 Feb 2024 15:44:52 +0100
Message-ID: <20240216144456.34992-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216144456.34992-1-philmd@linaro.org>
References: <20240216144456.34992-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

The following is an example on how to create the ivshmem-flat device on
a Stellaris machine:

$ qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nographic
                  -net none -chardev stdio,id=con,mux=on
                  -serial chardev:con -mon chardev=con,mode=readline
                  -chardev socket,path=/tmp/ivshmem_socket,id=ivf
                  -device ivshmem-flat,x-irq-qompath=/machine/unattached/device[1]/nvic/unnamed-gpio-in[0],x-bus-qompath="/sysbus",chardev=ivf
                  -kernel zephyr_qemu.elf

The IRQ QOM path for the target machine can be determined by creating
the VM without the ivshmem-flat device, going to the QEMU console and
listing the QOM nodes with 'info qom-tree'. In the Stellaris example
above the input IRQ is in the NVIC IC.

The MMRs for status and control (notification) are mapped to the MMIO
region at 0x400FF000 (default), whilst the shared memory region start
is mapped at addr. 0x40100000 (default), but both addresses can be set
when creating the device by using 'x-bus-address-{mmr,shmem}' options,
respectively.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20231127052024.435743-2-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/devices/ivshmem-flat.rst | 56 +++++++++++++++++++++++++
 include/hw/misc/ivshmem-flat.h       |  9 ++++
 hw/core/sysbus-fdt.c                 |  2 +
 hw/misc/ivshmem-flat.c               | 63 ++++++++++++++++++++++++++--
 4 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/ivshmem-flat.rst b/docs/system/devices/ivshmem-flat.rst
index 1f97052804..a10446a18f 100644
--- a/docs/system/devices/ivshmem-flat.rst
+++ b/docs/system/devices/ivshmem-flat.rst
@@ -31,3 +31,59 @@ the IRQ mechanism is disabled). The shared memory region is always present.
 The MMRs (INTRMASK, INTRSTATUS, IVPOSITION, and DOORBELL registers) offsets at
 the MMR region, and their functions, follow the ivshmem spec, so they work
 exactly as in the ivshmem PCI device (see ./specs/ivshmem-spec.txt).
+
+
+Device Options
+--------------
+
+The only required options to create an ivshmem-flat device are: (a) the UNIX
+socket where the ivshmem server is listening, usually ``/tmp/ivshmem_socket``;
+and (b) the bus type to be used by the device, which currently only supports
+"/sysbus" bus type.
+
+Example:
+
+.. parsed-literal::
+
+    |qemu-system-arm| -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem_flat -device ivshmem-flat,x-bus-qompath="/sysbus",chardev=ivshmem_flat
+
+The other options are for fine tuning the device.
+
+``x-irq-qompath``. Used to inform the device which IRQ input line it can attach
+to enable the notification mechanism (IRQ). The ivshmem-flat device currently
+only supports notification via vector 0, ignoring other vectors.
+
+Two examples for different machines follow.
+
+Stellaris machine (``- machine lm3s6965evb``):
+
+::
+
+    x-irq-qompath=/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]
+
+Arm mps2-an385 machine (``-machine mps2-an385``):
+
+::
+
+    x-irq-qompath=/machine/armv7m/nvic/unnamed-gpio-in[0]
+
+The available IRQ input lines on a given VM that the ivshmem-flat device can be
+attached to can be inspected from the QEMU monitor (Ctrl-a + c) with:
+
+(qemu) info qom-tree
+
+``x-bus-address-mmr``. Allows changing the address where the MMRs are mapped
+into the VM memory layout. Default is 0x400FF000, but this address might be
+already taken on some VMs, hence it's  necessary to adjust the MMR location on
+some VMs.
+
+ ``x-bus-address-shmem``. Allows changing the address where the shared memory
+region is mapped into the VM memory layout. Default is 0x40100000, but this
+address might be already taken on some VMs, hence it's necessary to adjust the
+shared memory location.
+
+``shmem-size``. Allows changing the size (in bytes) of shared memroy region.
+Default is 4 MiB, which is the same default value used by the ivshmem server, so
+usually it's not necessary to change it. The  size must match the size of the
+shared memory reserverd and informed by the ivshmem server, otherwise device
+creation fails.
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
index 998c78a5ee..433a47c8d3 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -421,16 +421,75 @@ static bool ivshmem_flat_connect_server(DeviceState *dev, Error **errp)
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
+    }
+    if (s->x_sysbus_shmem_addr != UINT64_MAX) {
+        trace_ivshmem_flat_shmem_map(s->x_sysbus_shmem_addr);
+        sysbus_mmio_map(sbd, 1, s->x_sysbus_shmem_addr);
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
 
@@ -439,13 +498,11 @@ static void ivshmem_flat_class_init(ObjectClass *klass, void *data)
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
-- 
2.41.0


