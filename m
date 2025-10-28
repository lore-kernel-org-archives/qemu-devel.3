Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4934CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlYm-0007bW-0N; Tue, 28 Oct 2025 11:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYj-0007Zo-4p
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:29 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYU-0001Nw-5V
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:28 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-378cffe5e1aso64731761fa.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761665049; x=1762269849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3787ZzKPC69u3XicXj5Ql4IT5h8lzUyYkiWykTMcPY=;
 b=fGBQlB6AHQr3MCpZxh06C2/v3+TKB4MmzpbA8RQ5aZhtK8lgVOGt2n+yIG7LEcXVQe
 vaA70ppnw3bwhYo4GOSG6SzXhyFh5DVn4AjO43AfDkj0DMKRhk/rlJsBB28I/nrn5BQr
 +wZLmE4ugvx4eunX/a9BJt0dBqjI1rM9fYXXmfP67Q+WkLRxjycGMBYoI2bGCkOICP1/
 8CMfqwpVFfRKp3c1c38MSgRhG8pRIAzw05SJvlM+twQ5N0CIML4uM7c8NFnGkWMZqMwt
 iOjISjUztE9VX/EYa4/dPgRsrUKkHlEyEHqISWN2xFYkyjZBbjRvGzIfYIFSMZ+5gEG2
 yeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665049; x=1762269849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3787ZzKPC69u3XicXj5Ql4IT5h8lzUyYkiWykTMcPY=;
 b=b74ubbYhCEsAAafvvLHUgSmjopZudMSYUjY2ZLm22At7zSJnzvbKTZs9OuJ2uoAe1R
 2P6+sTquiyUiyrNd0EPmxR4WZEKdmrbSWpH0pTfxR+zCPOIIYh9EAeS1lweW84jxXb1g
 GlNkr1Btricleua9ODFH8GuJF6FV9R6fzCzzn2yuavpinXmIwL6NhYQp7AMSaecJpdAZ
 BNF4eC3ZF8iYv5Aq79grD4+ufI3rMqFQCU0VrPtkMO2OD2Hxx/DdZ2UvcX7zK4ajcNEC
 xQJQ6/5ECuX4S6Ochxtua2vGdknChDhvpfm+aWIUZksj/Xnimo/TbW5H41gWAIZfylVv
 65RA==
X-Gm-Message-State: AOJu0Yx2Z3iwx+na5H43GDi4ftfhqHiolCPK12JNzpsWxpP0JLMLA6It
 8CTVqTcgdyBaVdkSjn9wvCfxrhF5oxr98uarDGMcB8w+I/qruURqxpH4s0z23p2VGx1Tcw==
X-Gm-Gg: ASbGnctbyEdv4lFbwpfID7o/74EEdm/W8b7FtL+08DxHfHEVUpWjBPynoFDTilwVajW
 2A1fulFM0ICzl9UJaWuHNa9lWZLwzZ2SmTRw9YQFtWeH3wYtu57I/dRDrMPlq+ridG3lf0xWxH8
 T5C3Sur5Ie1VXuYKmXj1Kj0Ukcl0Nq6vhP9jPqCqQKplrXAjCCMKUp9m8UA1jJRJb9+HQEtnPJr
 KNODxNOXeox5BZTCe101WzckPAkcXwb8LXrUPoMSytyP7jCg3uyQcbN3GjdpCqu2HPKZ/hae+1k
 E7LK8zWRJPHsMD36mMhD/Y6j/nQpfciVYT4AJVTr/X3yBAaffBE78DWsyJYhq0zC39dbp9ZTlNY
 nz/4OtZDWjoe3vIn2urvtRPisUZAr4IuwGmbAqapSNm9atljg3Hm+RnnyselFsjTXISWgyfsCPY
 bpBeZJMydjrQ5pRvfVfdHc78iQtdXsqU8ow1Vj
X-Google-Smtp-Source: AGHT+IHZPN9rqoY2eWRZHDoJ+wbh6QDPwiaF3F81fdZH2SiAzZFIN/TvUhK39amc3N2heryFEOl7Iw==
X-Received: by 2002:a05:651c:12c5:b0:36f:13c8:d8b1 with SMTP id
 38308e7fff4ca-3790769743dmr10745721fa.1.1761665048863; 
 Tue, 28 Oct 2025 08:24:08 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59301f74b9bsm3168093e87.88.2025.10.28.08.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:24:07 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: alex.bennee@linaro.org,
	bill.mills@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 4/5] hw/misc: Add generic virtio-msg AMP PCI device
Date: Tue, 28 Oct 2025 16:23:49 +0100
Message-ID: <20251028152351.1247812-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/misc/Kconfig                |   7 +
 hw/misc/meson.build            |   1 +
 hw/misc/virtio-msg-amp-pci.c   | 328 +++++++++++++++++++++++++++++++++
 include/hw/virtio/spsc_queue.h | 213 +++++++++++++++++++++
 4 files changed, 549 insertions(+)
 create mode 100644 hw/misc/virtio-msg-amp-pci.c
 create mode 100644 include/hw/virtio/spsc_queue.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24..cdc318bec2 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -25,6 +25,13 @@ config PCI_TESTDEV
     default y if TEST_DEVICES
     depends on PCI
 
+config VIRTIO_MSG_AMP_PCI
+    bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select VIRTIO
+    select VIRTIO_MSG
+
 config EDU
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..80d4886808 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -8,6 +8,7 @@ system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_COMMON', if_true: files('pvpanic.c'))
+system_ss.add(when: 'CONFIG_VIRTIO_MSG_AMP_PCI', if_true: files('virtio-msg-amp-pci.c'))
 
 # ARM devices
 system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
diff --git a/hw/misc/virtio-msg-amp-pci.c b/hw/misc/virtio-msg-amp-pci.c
new file mode 100644
index 0000000000..29fa00d931
--- /dev/null
+++ b/hw/misc/virtio-msg-amp-pci.c
@@ -0,0 +1,328 @@
+/*
+ * Model of a virtio-msg AMP capable PCI device.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/log.h"
+
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci/pci_device.h"
+#include "hw/pci/msix.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+
+#include "hw/virtio/virtio-msg.h"
+#include "hw/virtio/virtio-msg-bus.h"
+#include "hw/virtio/spsc_queue.h"
+
+#define TYPE_VMSG_AMP_PCI "virtio-msg-amp-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VmsgAmpPciState, VMSG_AMP_PCI)
+
+#define TYPE_VMSG_BUS_AMP_PCI "virtio-msg-bus-amp-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VmsgBusAmpPciState, VMSG_BUS_AMP_PCI)
+#define VMSG_BUS_AMP_PCI_GET_PARENT_CLASS(obj) \
+        OBJECT_GET_PARENT_CLASS(obj, TYPE_VMSG_BUS_AMP_PCI)
+
+REG32(VERSION,  0x00)
+REG32(FEATURES, 0x04)
+REG32(NOTIFY,   0x20)
+
+#define MAX_FIFOS 8
+
+typedef struct VmsgBusAmpPciState {
+    VirtIOMSGBusDevice parent;
+    PCIDevice *pcidev;
+    unsigned int queue_index;
+
+    struct {
+        void *va;
+        spsc_queue driver;
+        spsc_queue device;
+        unsigned int mapcount;
+    } shm;
+} VmsgBusAmpPciState;
+
+typedef struct VmsgAmpPciState {
+    PCIDevice dev;
+    MemoryRegion mr_mmio;
+    MemoryRegion mr_ram;
+
+    struct fifo_bus {
+        VmsgBusAmpPciState dev;
+        VirtIOMSGProxy proxy;
+        BusState bus;
+    } fifo[MAX_FIFOS];
+
+    struct {
+        uint32_t num_fifos;
+    } cfg;
+} VmsgAmpPciState;
+
+static void vmsg_bus_amp_pci_process(VirtIOMSGBusDevice *bd);
+
+static uint64_t vmsg_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    uint64_t r = 0;
+
+    assert(size == 4);
+
+    switch (addr) {
+    case A_VERSION:
+        /* v0.1 */
+        r = 0x0001;
+        break;
+    case A_FEATURES:
+        /* No features bit yet.  */
+        break;
+    default:
+        break;
+    }
+
+    return r;
+}
+
+static void vmsg_write(void *opaque, hwaddr addr, uint64_t val,
+                       unsigned int size)
+{
+    VmsgAmpPciState *s = VMSG_AMP_PCI(opaque);
+    unsigned int q;
+
+    assert(size == 4);
+
+    if (addr >= A_NOTIFY) {
+        q = (addr - A_NOTIFY) / 4;
+        if (q >= s->cfg.num_fifos) {
+            /* Fifo doesn't exist.  */
+            return;
+        }
+
+        vmsg_bus_amp_pci_process(VIRTIO_MSG_BUS_DEVICE(&s->fifo[q].dev));
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only reg 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+    }
+}
+
+static const MemoryRegionOps vmsg_pci_ops = {
+    .read = vmsg_read,
+    .write = vmsg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void vmsg_create_bus(VmsgAmpPciState *s, unsigned int i)
+{
+    DeviceState *dev = DEVICE(s);
+    Object *o = OBJECT(s);
+    struct fifo_bus *fifo = &s->fifo[i];
+    g_autofree char *fifo_name = g_strdup_printf("fifo%d", i);
+
+    qbus_init(&fifo->bus, sizeof(fifo->bus), TYPE_VIRTIO_MSG_OUTER_BUS,
+              dev, fifo_name);
+
+    /* Create the proxy.  */
+    object_initialize_child(o, "proxy[*]", &fifo->proxy, TYPE_VIRTIO_MSG);
+    qdev_realize(DEVICE(&fifo->proxy), BUS(&fifo->bus), &error_fatal);
+
+    object_initialize_child(o, "vmsg[*]", &fifo->dev,
+                            TYPE_VMSG_BUS_AMP_PCI);
+    qdev_realize(DEVICE(&fifo->dev), &fifo->proxy.msg_bus, &error_fatal);
+
+    msix_vector_use(PCI_DEVICE(s), i);
+
+    /* Caches for quick lookup. */
+    fifo->dev.queue_index = i;
+    fifo->dev.pcidev = PCI_DEVICE(s);
+}
+
+static void vmsg_amp_pci_realizefn(PCIDevice *dev, Error **errp)
+{
+    VmsgAmpPciState *s = VMSG_AMP_PCI(dev);
+    int i;
+
+    if (!s->cfg.num_fifos || s->cfg.num_fifos > MAX_FIFOS) {
+        error_setg(errp, "Unsupported number of FIFOs (%u)", s->cfg.num_fifos);
+        return;
+    }
+
+    memory_region_init_io(&s->mr_mmio, OBJECT(s), &vmsg_pci_ops, s,
+                          TYPE_VMSG_AMP_PCI, 16 * KiB);
+
+    /* 16KB per FIFO.  */
+    memory_region_init_ram(&s->mr_ram, OBJECT(s), "ram",
+                           s->cfg.num_fifos * 16 * KiB, &error_fatal);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mr_mmio);
+    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                             PCI_BASE_ADDRESS_MEM_PREFETCH,
+                             &s->mr_ram);
+
+    msix_init_exclusive_bar(PCI_DEVICE(s), s->cfg.num_fifos, 2, &error_fatal);
+    for (i = 0; i < s->cfg.num_fifos; i++) {
+        vmsg_create_bus(s, i);
+    }
+}
+
+static const Property vmsg_properties[] = {
+    DEFINE_PROP_UINT32("num-fifos", VmsgAmpPciState, cfg.num_fifos, 1),
+};
+
+static const VMStateDescription vmstate_vmsg_pci = {
+    .name = TYPE_VMSG_AMP_PCI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, VmsgAmpPciState),
+        /* TODO: Add all the sub-devs.  */
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void vmsg_amp_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vmsg_properties);
+
+    pc->realize = vmsg_amp_pci_realizefn;
+    pc->vendor_id = PCI_VENDOR_ID_XILINX;
+    pc->device_id = 0x9039;
+    pc->revision = 1;
+    pc->class_id = PCI_CLASS_SYSTEM_OTHER;
+    dc->vmsd = &vmstate_vmsg_pci;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static bool vmsg_bus_amp_pci_map_fifo(VmsgBusAmpPciState *s)
+{
+    VmsgAmpPciState *pci_s = VMSG_AMP_PCI(s->pcidev);
+    void *va;
+
+    if (s->shm.mapcount) {
+        s->shm.mapcount++;
+        return true;
+    }
+
+    va = memory_region_get_ram_ptr(&pci_s->mr_ram);
+    if (!va) {
+        return false;
+    }
+
+    if (!s->shm.driver.shm) {
+        int capacity = spsc_capacity(4 * KiB);
+
+        /*
+         * Layout:
+         * 0     - 4KB    Reserved
+         * 4KB   - 8KB    Driver queue
+         * 8KB   - 12KB   Device queue
+         */
+        spsc_init(&s->shm.driver, "driver", capacity, va + 4 * KiB);
+        spsc_init(&s->shm.device, "device", capacity, va + 8 * KiB);
+    }
+
+    /* Map queues.  */
+    s->shm.va = va;
+    s->shm.mapcount++;
+    return true;
+}
+
+static void vmsg_bus_amp_pci_unmap_fifo(VmsgBusAmpPciState *s)
+{
+    assert(s->shm.mapcount);
+    if (--s->shm.mapcount) {
+        return;
+    }
+
+    /* TODO: Actually unmap. */
+}
+
+static void vmsg_bus_amp_pci_process(VirtIOMSGBusDevice *bd)
+{
+    VmsgBusAmpPciState *s = VMSG_BUS_AMP_PCI(bd);
+    spsc_queue *q;
+    VirtIOMSG msg;
+    bool r;
+
+    if (!vmsg_bus_amp_pci_map_fifo(s)) {
+        return;
+    }
+
+    /*
+     * We process the opposite queue, i.e, a driver will want to receive
+     * messages on the backend queue (and send messages on the driver queue).
+     */
+    q = bd->peer->is_driver ? &s->shm.device : &s->shm.driver;
+    do {
+        r = spsc_recv(q, &msg, sizeof msg);
+        if (r) {
+            virtio_msg_bus_receive(bd, &msg);
+        }
+    } while (r);
+    vmsg_bus_amp_pci_unmap_fifo(s);
+}
+
+static int vmsg_bus_amp_pci_send(VirtIOMSGBusDevice *bd, VirtIOMSG *msg_req)
+{
+    VmsgAmpPciState *pci_s = VMSG_AMP_PCI(OBJECT(bd)->parent);
+    VmsgBusAmpPciState *s = VMSG_BUS_AMP_PCI(bd);
+
+    if (!vmsg_bus_amp_pci_map_fifo(s)) {
+        return VIRTIO_MSG_ERROR_MEMORY;
+    }
+
+    spsc_send(&s->shm.device, msg_req, sizeof *msg_req);
+
+    /* Notify.  */
+    msix_notify(PCI_DEVICE(pci_s), s->queue_index);
+
+    vmsg_bus_amp_pci_unmap_fifo(s);
+    return VIRTIO_MSG_NO_ERROR;
+}
+
+static void vmsg_bus_amp_pci_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    VirtIOMSGBusDeviceClass *bdc = VIRTIO_MSG_BUS_DEVICE_CLASS(klass);
+
+    bdc->process = vmsg_bus_amp_pci_process;
+    bdc->send = vmsg_bus_amp_pci_send;
+}
+
+static const TypeInfo vmsg_pci_info[] = {
+    {
+        .name = TYPE_VMSG_AMP_PCI,
+        .parent = TYPE_PCI_DEVICE,
+        .instance_size = sizeof(VmsgAmpPciState),
+        .class_init = vmsg_amp_pci_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { }
+        },
+    }, {
+        .name = TYPE_VMSG_BUS_AMP_PCI,
+        .parent = TYPE_VIRTIO_MSG_BUS_DEVICE,
+        .instance_size = sizeof(VmsgBusAmpPciState),
+        .class_init = vmsg_bus_amp_pci_class_init,
+    },
+};
+
+static void vmsg_pci_register_types(void)
+{
+    type_register_static_array(vmsg_pci_info, ARRAY_SIZE(vmsg_pci_info));
+}
+
+type_init(vmsg_pci_register_types);
diff --git a/include/hw/virtio/spsc_queue.h b/include/hw/virtio/spsc_queue.h
new file mode 100644
index 0000000000..3d88baab55
--- /dev/null
+++ b/include/hw/virtio/spsc_queue.h
@@ -0,0 +1,213 @@
+/*
+ * Hardened and lockless Single Producer Single Consumer Queue implemented
+ * over shared-memory.
+ *
+ * The queue implementation does not look at packet contents, it's up to upper
+ * layers to make sure data is produced and parsed safely. All data is copied
+ * in/out from/to local private buffers so the peer cannot mess with them while
+ * upper layers parse.
+ *
+ * The queue is split into a private and a shared part.
+ * The private part contains cached and sanitized versions of the indexes that
+ * indicate our position in the ring-buffer. Peers can corrupt the shared area
+ * but have no access to the private area. So whenever we copy from the shared
+ * area into the private one, we need to sanitize indexes and make sure they
+ * are within bounds.
+ *
+ * A malicious peer can send corrupt data, it can stop receiving or flood the
+ * queue causing a sort of denial of service but it can NOT cause our side
+ * to copy data in or out of buffers outside of the shared memory area.
+ *
+ * This implementation expects the SHM area to be cache-coherent or uncached.
+ * The shared area can be mapped in different ways and our peer may be anything
+ * from another thread on our same OS to an FPGA implementation on a PCI card.
+ * So local CPU cache-lines sizes, or spin-locks and things that work on a
+ * single CPU cluster are not used. Instead the implementation sticks to atomic
+ * load/stores of 32b values and to using memory-barriers to guarantee ordering.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SPSC_QUEUE_H__
+#define SPSC_QUEUE_H__
+
+#include <assert.h>
+#include "qemu/atomic.h"
+
+#define BUG_ON(x) assert(!(x))
+
+#define SPSC_QUEUE_MAX_PACKET_SIZE 64
+/*
+ * This cache-line size is used to align fields in the hope of
+ * avoiding cache-line ping-pong:ing. Since the queue layout is
+ * used across heterogenous CPU clusters and across FPGA/HW implementations,
+ * a fixed size must be used, i.e not the local CPU's cache-line size.
+ */
+#define SPSC_QUEUE_CACHE_LINE_SIZE 64
+
+typedef struct spsc_queue_shared {
+    uint32_t head __attribute__((__aligned__(SPSC_QUEUE_CACHE_LINE_SIZE)));
+    uint32_t tail __attribute__((__aligned__(SPSC_QUEUE_CACHE_LINE_SIZE)));
+    uint32_t packets[][SPSC_QUEUE_MAX_PACKET_SIZE / 4]
+        __attribute__((__aligned__(SPSC_QUEUE_CACHE_LINE_SIZE)));
+} spsc_queue_shared;
+
+typedef struct spsc_queue {
+    uint32_t cached_tail;
+    uint32_t cached_head;
+    spsc_queue_shared *shm;
+    const char *name;
+    unsigned int capacity;
+} spsc_queue;
+
+/* Atomically load and sanitize an index from the SHM area.  */
+static inline uint32_t spsc_atomic_load(spsc_queue *q, uint32_t *ptr)
+{
+    uint32_t val;
+
+    val = qatomic_read(ptr);
+    /* Make sure packet reads are done after reading the index.  */
+    smp_mb_acquire();
+
+    /* Bounds check that index is within queue size.  */
+    if (val >= q->capacity) {
+        val = val % q->capacity;
+    }
+
+    return val;
+}
+
+static inline void spsc_atomic_store(spsc_queue *q, uint32_t *ptr, uint32_t v)
+{
+    /* Make sure packet-data gets written before updating the index.  */
+    smp_mb_release();
+    qatomic_set(ptr, v);
+}
+
+/* Returns the capacity of a queue given a specific mapsize. */
+static inline unsigned int spsc_capacity(size_t mapsize)
+{
+    unsigned int capacity;
+    spsc_queue *q = NULL;
+
+    if (mapsize < sizeof(*q->shm)) {
+        return 0;
+    }
+
+    /* Start with the size of the shared area. */
+    mapsize -= sizeof(*q->shm);
+    capacity = mapsize / sizeof(q->shm->packets[0]);
+
+    if (capacity < 2) {
+        /* Capacities of less than 2 are invalid. */
+        return 0;
+    }
+
+    return capacity;
+}
+
+static inline size_t spsc_mapsize(unsigned int capacity)
+{
+    spsc_queue *q = NULL;
+    size_t mapsize;
+
+    BUG_ON(capacity < 2);
+
+    mapsize = sizeof(*q->shm);
+    mapsize += sizeof(q->shm->packets[0]) * capacity;
+
+    return mapsize;
+}
+
+static inline void spsc_init(spsc_queue *q, const char *name, size_t capacity,
+                             void *mem)
+{
+    BUG_ON(!mem);
+
+    /* Initialize private queue area to all zeroes */
+    memset(q, 0, sizeof *q);
+
+    q->shm = (spsc_queue_shared *) mem;
+    q->name = name;
+    q->capacity = capacity;
+
+    /* In case we're opening a pre-existing queue, pick up where we left off. */
+    q->cached_tail = spsc_atomic_load(q, &q->shm->tail);
+    q->cached_head = spsc_atomic_load(q, &q->shm->head);
+}
+
+static inline bool spsc_queue_is_full(spsc_queue *q)
+{
+    uint32_t next_head;
+    uint32_t head;
+
+    head = spsc_atomic_load(q, &q->shm->head);
+
+    next_head = head + 1;
+    if (next_head >= q->capacity) {
+        next_head = 0;
+    }
+
+    if (next_head == q->cached_tail) {
+        q->cached_tail = spsc_atomic_load(q, &q->shm->tail);
+        if (next_head == q->cached_tail) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline bool spsc_send(spsc_queue *q, void *buf, size_t size)
+{
+    uint32_t next_head;
+    uint32_t head;
+
+    BUG_ON(size > sizeof q->shm->packets[0]);
+    BUG_ON(size == 0);
+
+    /* Is the queue full?  */
+    if (spsc_queue_is_full(q)) {
+        return false;
+    }
+
+    head = spsc_atomic_load(q, &q->shm->head);
+    next_head = head + 1;
+    if (next_head >= q->capacity) {
+        next_head = 0;
+    }
+
+    memcpy(q->shm->packets[head], buf, size);
+
+    spsc_atomic_store(q, &q->shm->head, next_head);
+    return true;
+}
+
+static inline bool spsc_recv(spsc_queue *q, void *buf, size_t size)
+{
+    uint32_t tail;
+
+    BUG_ON(size > sizeof q->shm->packets[0]);
+    BUG_ON(size == 0);
+
+    tail = spsc_atomic_load(q, &q->shm->tail);
+
+    /* Is the queue empty?  */
+    if (tail == q->cached_head) {
+        q->cached_head = spsc_atomic_load(q, &q->shm->head);
+        if (tail == q->cached_head) {
+            return false;
+        }
+    }
+
+    memcpy(buf, q->shm->packets[tail], size);
+
+    /* Update the read pointer.  */
+    tail++;
+    if (tail >= q->capacity) {
+        tail = 0;
+    }
+
+    spsc_atomic_store(q, &q->shm->tail, tail);
+    return true;
+}
+#endif /* SPSC_QUEUE_H__ */
-- 
2.43.0


