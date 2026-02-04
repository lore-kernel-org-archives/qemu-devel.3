Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1E8EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAs-000295-Bc; Wed, 04 Feb 2026 14:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAp-0001zw-HN
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAn-00087v-4A
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pjB3ypqsjtokcsdC8OAdmK6JNoWynQqNyg6cMGB1Ruw=;
 b=KrDCnAEmj8Y37/OKDHSBj5K/ETgDx1FvIcIrlf+QuoYbS0+ep/U5i/KWJYvBDYPTYXJjLV
 VgG1m3Hnt570W4fpPOLqJfMhujLPQG2OCNqJPCjh/VhQy0mHmmks7PyKlA/0sVp2jJI/wg
 ie0KAXl5tPp6zfk+2AJTu2r0zq77lC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-Unb3y9N4MgSoh2QtOeFIkw-1; Wed, 04 Feb 2026 14:04:18 -0500
X-MC-Unique: Unb3y9N4MgSoh2QtOeFIkw-1
X-Mimecast-MFC-AGG-ID: Unb3y9N4MgSoh2QtOeFIkw_1770231858
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso140528f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231857; x=1770836657; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pjB3ypqsjtokcsdC8OAdmK6JNoWynQqNyg6cMGB1Ruw=;
 b=Slu6q5XqF7+gnaegFHRvb3VdsmXqPVuAYvL9GhRztncmarf7ZLye8XqF3hSDZpiJew
 eYvWL7TKCfG20indQ0gQJCgc72YmFl1ZAcFJDgqiwai6bA/v5tKogM/svMV4gsWoFqlt
 lV8VRHKBY6wSZX6fA6TStEZ0gTcJS9j3YJPc3fsOpOtJ7soUPhiefCFJMBwE46VLrWKZ
 smDVx29DZEfjqgg24Crx1tSMeNj/Yo3CnCgnKO07r+ubgQvkaFv6Sk+1UhtgM/44vEEg
 A929B+2VakKiB9e1ZKcGg63ojC0H+f9lkDn5EEDs+CkwNRxaMjLjAN567GtmLC1hAK82
 Gbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231857; x=1770836657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjB3ypqsjtokcsdC8OAdmK6JNoWynQqNyg6cMGB1Ruw=;
 b=aZgHYv9A4Pxrr2lZ1A4fspxUcaFqwb/aa8bs//xXKNxgyQ5eoxKx54tZ1bc7ebotdR
 hhxZXYW7d2gs19I3OKo/F+wEBragwjRpYbWUk/RjlMwVhMA1W5G4PF8fAeyLj8bub4vn
 ZNuJkMbIcj5nTvM3df9c7H2Z7dtbGeg4CDhl5qDsUH99Gqc4+0rxBURDpZUPqzuDKTWp
 QzG+LlEhS1DdB6Gv8fiNtgSZFKNwL+sAnYZ50XmofrwKw2qi4ePo9AkL4XG/Jfp/SRYu
 des3RskkF7pqiCqNYiWYUppwjFXyJAD47yN7CvJn2gNck85ujxI728otmJQPpS4O10Ia
 meeg==
X-Gm-Message-State: AOJu0Yx5CYu0hRNBq8irYtnU/xn4zvbtcEF/pL2qm/UacfTf/uPX8iCd
 MttyS65ACXzb46XbhyJhEx/KGzhB7JvZn6hmbfezbqwDm8+SfaCEemx/hbLRiZI0P8zOOLnfyv2
 5Q1A0owoyolYD98QKKwpFP4nG1H7HTOBVJIrvp0iiq65btr27fBVSIrSOEg48LjsGzkefqHQWuB
 85wCGaIMHNu9Tkkf/VWSgpz0338D8tjry4Dg==
X-Gm-Gg: AZuq6aK1UdjhHxyWHhWzf0/F+3kCWJepbhGMQJlgC4X40zQu3Ad4uOniIey15KCzow/
 pNSyxt/UADDC3HAnaUUd8dSNgqeqVGzhSWvv1JXIzulTSaMO9ARcReV1PLOFE74669NwD4UIFxN
 zYZpJFVcz+xPuxtxoNAcbW840eXw1+qEMs5Z8V+5xp9iJTQoImt+Uwjefg1OcCJiMtC4iwaLnU5
 6rUxoQEDqxqU3XJGRrtcl03WMqgAogsMbkexFW27rf/+aMdcC9qPgYxCHsD5C/tNGR4AxBtc55g
 CwA6B3zBMfjiWRcB/B6p5f+Gf3xkjtnWtmobVekqlG50rEFp6eqVQtBtqhAaQz2aBQE9Db0GZXe
 f4BoIY6sFf7L36o/ru6d5r4BR7ffautxzIQ==
X-Received: by 2002:a05:600c:4513:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-4830e932591mr56879435e9.11.1770231857083; 
 Wed, 04 Feb 2026 11:04:17 -0800 (PST)
X-Received: by 2002:a05:600c:4513:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-4830e932591mr56878815e9.11.1770231856494; 
 Wed, 04 Feb 2026 11:04:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d4b2a6sm3178905e9.12.2026.02.04.11.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:16 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 37/51] virtio-spi: Add vhost-user-spi device support
Message-ID: <e1b29c10dc2ef106c5aa75252cc8cb5a1265d818.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Haixu Cui <quic_haixcui@quicinc.com>

This patch introduces support for vhost-user-spi and vhost-user-spi-pci
devices in QEMU, enabling virtio-based SPI communication via the vhost-user
protocol.

The implementation follows the virtio-spi specification and leverages
the upstream virtio-spi driver in Linux. Relevant references:

- Virtio SPI specification:
  https://github.com/oasis-tcs/virtio-spec/tree/master/device-types/spi
- Linux virtio-spi driver:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-virtio.c?h=v6.18-rc3
- vhost-user-spi daemon:
  https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-spi

Example usage with rust-vmm vhost-user-spi daemon:

Start the vhost-user-spi daemon:
    vhost-device-spi --socket-path=vspi.sock --socket-count=1 \
        --device "/dev/spidev0.0"

Launch QEMU with:
    qemu-system-aarch64 -m 1G \
        -chardev socket,path=/home/root/vspi.sock0,id=vspi \
        -device vhost-user-spi-device,chardev=vspi,id=spi \
        -object memory-backend-file,id=mem,size=1G,mem-path=/dev/shm,share=on \
        -numa node,memdev=mem

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251216032122.1316684-3-quic_haixcui@quicinc.com>
---
 MAINTAINERS                               |  6 ++
 docs/system/devices/virtio/vhost-user.rst |  3 +
 hw/virtio/Kconfig                         |  5 ++
 hw/virtio/meson.build                     |  3 +
 hw/virtio/vhost-user-spi-pci.c            | 69 +++++++++++++++++++++++
 hw/virtio/vhost-user-spi.c                | 65 +++++++++++++++++++++
 hw/virtio/virtio.c                        |  4 +-
 include/hw/virtio/vhost-user-spi.h        | 25 ++++++++
 8 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/vhost-user-spi-pci.c
 create mode 100644 hw/virtio/vhost-user-spi.c
 create mode 100644 include/hw/virtio/vhost-user-spi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b7ed4fccb..d049270777 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2556,6 +2556,12 @@ F: hw/virtio/vhost-user-scmi*
 F: include/hw/virtio/vhost-user-scmi.h
 F: tests/qtest/libqos/virtio-scmi.*
 
+vhost-user-spi
+M: Haixu Cui <quic_haixcui@quicinc.com>
+S: Maintained
+F: include/hw/virtio/vhost-user-spi.h
+F: hw/virtio/vhost-user-spi*
+
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
 S: Supported
diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devices/virtio/vhost-user.rst
index f556a840e9..2806d81ca2 100644
--- a/docs/system/devices/virtio/vhost-user.rst
+++ b/docs/system/devices/virtio/vhost-user.rst
@@ -58,6 +58,9 @@ platform details for what sort of virtio bus to use.
   * - vhost-user-vsock
     - Socket based communication
     - `vhost-device-vsock <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock>`_
+  * - vhost-user-spi
+    - Proxy spi devices to host
+    - `vhost-device-spi <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-spi>`_
 
 The referenced *daemons* are not exhaustive, any conforming backend
 implementing the device and using the vhost-user protocol should work.
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 10f5c53ac0..8895682c61 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -127,6 +127,11 @@ config VHOST_USER_SCMI
     default y
     depends on VIRTIO && VHOST_USER && ARM
 
+config VHOST_USER_SPI
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
+
 config VHOST_USER_TEST
     bool
     default y
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index affd66887d..6675b63ce6 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -28,6 +28,7 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files('vhost-user-spi.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_TEST'],
@@ -42,6 +43,8 @@ if have_vhost
                          if_true: files('vhost-user-snd-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_INPUT'],
                          if_true: files('vhost-user-input-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
+                         if_true: files('vhost-user-spi-pci.c'))
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
diff --git a/hw/virtio/vhost-user-spi-pci.c b/hw/virtio/vhost-user-spi-pci.c
new file mode 100644
index 0000000000..f813b824b6
--- /dev/null
+++ b/hw/virtio/vhost-user-spi-pci.c
@@ -0,0 +1,69 @@
+/*
+ * Vhost-user spi virtio device PCI glue
+ *
+ * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/virtio/vhost-user-spi.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserSPIPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserSPI vdev;
+};
+
+typedef struct VHostUserSPIPCI VHostUserSPIPCI;
+
+#define TYPE_VHOST_USER_SPI_PCI "vhost-user-spi-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserSPIPCI, VHOST_USER_SPI_PCI,
+                         TYPE_VHOST_USER_SPI_PCI)
+
+static void vhost_user_spi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserSPIPCI *dev = VHOST_USER_SPI_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    vpci_dev->nvectors = 1;
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_spi_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_spi_pci_realize;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void vhost_user_spi_pci_instance_init(Object *obj)
+{
+    VHostUserSPIPCI *dev = VHOST_USER_SPI_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_SPI);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_spi_pci_info = {
+    .base_name = TYPE_VHOST_USER_SPI_PCI,
+    .non_transitional_name = "vhost-user-spi-pci",
+    .instance_size = sizeof(VHostUserSPIPCI),
+    .instance_init = vhost_user_spi_pci_instance_init,
+    .class_init = vhost_user_spi_pci_class_init,
+};
+
+static void vhost_user_spi_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_spi_pci_info);
+}
+
+type_init(vhost_user_spi_pci_register);
diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
new file mode 100644
index 0000000000..707f96c250
--- /dev/null
+++ b/hw/virtio/vhost-user-spi.c
@@ -0,0 +1,65 @@
+/*
+ * Vhost-user spi virtio device
+ *
+ * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user-spi.h"
+#include "qemu/error-report.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_spi.h"
+
+static const Property vspi_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+};
+
+static void vspi_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
+
+    /* Fixed for SPI */
+    vub->virtio_id = VIRTIO_ID_SPI;
+    vub->num_vqs = 1;
+    vub->vq_size = 4;
+    vub->config_size = sizeof(struct virtio_spi_config);
+
+    vubc->parent_realize(dev, errp);
+}
+
+static const VMStateDescription vu_spi_vmstate = {
+    .name = "vhost-user-spi",
+    .unmigratable = 1,
+};
+
+static void vu_spi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
+
+    dc->vmsd = &vu_spi_vmstate;
+    device_class_set_props(dc, vspi_properties);
+    device_class_set_parent_realize(dc, vspi_realize,
+                                    &vubc->parent_realize);
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static const TypeInfo vu_spi_info = {
+    .name = TYPE_VHOST_USER_SPI,
+    .parent = TYPE_VHOST_USER_BASE,
+    .instance_size = sizeof(VHostUserSPI),
+    .class_init = vu_spi_class_init,
+};
+
+static void vu_spi_register_types(void)
+{
+    type_register_static(&vu_spi_info);
+}
+
+type_init(vu_spi_register_types)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3dc9423eae..77ca54e520 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -48,6 +48,7 @@
 #include "standard-headers/linux/virtio_iommu.h"
 #include "standard-headers/linux/virtio_mem.h"
 #include "standard-headers/linux/virtio_vsock.h"
+#include "standard-headers/linux/virtio_spi.h"
 
 /*
  * Maximum size of virtio device config space
@@ -196,7 +197,8 @@ const char *virtio_device_names[] = {
     [VIRTIO_ID_PARAM_SERV] = "virtio-param-serv",
     [VIRTIO_ID_AUDIO_POLICY] = "virtio-audio-pol",
     [VIRTIO_ID_BT] = "virtio-bluetooth",
-    [VIRTIO_ID_GPIO] = "virtio-gpio"
+    [VIRTIO_ID_GPIO] = "virtio-gpio",
+    [VIRTIO_ID_SPI] = "virtio-spi"
 };
 
 static const char *virtio_id_to_name(uint16_t device_id)
diff --git a/include/hw/virtio/vhost-user-spi.h b/include/hw/virtio/vhost-user-spi.h
new file mode 100644
index 0000000000..a1a65820cd
--- /dev/null
+++ b/include/hw/virtio/vhost-user-spi.h
@@ -0,0 +1,25 @@
+/*
+ * Vhost-user spi virtio device
+ *
+ * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_SPI_H
+#define QEMU_VHOST_USER_SPI_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-base.h"
+
+#define TYPE_VHOST_USER_SPI "vhost-user-spi-device"
+
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSPI, VHOST_USER_SPI)
+
+struct VHostUserSPI {
+    VHostUserBase parent_obj;
+};
+
+#endif /* QEMU_VHOST_USER_SPI_H */
-- 
MST


