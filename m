Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E33D5C0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 03:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVLdM-000461-75; Mon, 15 Dec 2025 22:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vVLdK-00045T-Dk
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 22:21:54 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vVLdI-0002Ry-8e
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 22:21:54 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BFJxehN1290627; Tue, 16 Dec 2025 03:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vGH4T7L8XEnEgK3icxBm8TFgLTzmV9FLSR3nKVfquv0=; b=H1Hq7KyBW/Y/VmZE
 84oXnOVuo1cwJewPoXapNmuPuxd6y3Ayzm2wv2cHjMIjEqe8xcV0Bc6d3oZO0dzT
 J4BDRB/Z8rj8BldiJkRIRC483W+v8mw59zgXhT5HWTHom+OBYVN392bVHrZCwL5S
 OiP3+mYNSPPc3paxzEikcq2Pz6eiir3R6A1BUNPy2MvbAx5JNJ5F717qDC4AAoSx
 eUmwL8lYXDG6LXVhQjRXoirsFAJse7SP4f22U39vpK0OXBiw12tUSxRDXaSz8JGe
 B3R8+guDmoA2PI6Vuh7xosZAN3f4ue1VzGCDUirARFsxmyWj0PoGgZtOIowY3BVx
 GzQNeQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2hgatry3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 03:21:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5BG3LnGK016520
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 03:21:49 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Dec 2025 19:21:46 -0800
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <manos.pitsidianakis@linaro.org>, <alex.bennee@linaro.org>,
 <viresh.kumar@linaro.org>, <quic_tsoni@quicinc.com>,
 <qemu-devel@nongnu.org>, <mst@redhat.com>, <zhiqiang.tu@oss.qualcomm.com>
CC: Haixu Cui <quic_haixcui@quicinc.com>
Subject: [PATCH v3 2/2] virtio-spi: Add vhost-user-spi device support
Date: Tue, 16 Dec 2025 11:21:22 +0800
Message-ID: <20251216032122.1316684-3-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216032122.1316684-1-quic_haixcui@quicinc.com>
References: <20251216032122.1316684-1-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: lnHUr9JBR5a_IqHplgb6acUQvWqEtDWd
X-Proofpoint-ORIG-GUID: lnHUr9JBR5a_IqHplgb6acUQvWqEtDWd
X-Authority-Analysis: v=2.4 cv=GpxPO01C c=1 sm=1 tr=0 ts=6940d04e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=i0EeH86SAAAA:8 a=8x0lwGbhQW9GwtfvS4EA:9 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDAyNiBTYWx0ZWRfX8fvPe5I2Sqnt
 a37Tlsc0LW1bA2UCi+qOMVMLnPTOMKmAE0ulMO1c8n15bQg3Ksiy18MfkAGSBsSvtm7zGvuM0R9
 IHdBh3ZxkrbeLdhNGRx3T8PuKQUmhYF5h+wN1Nk1b2ohG39S2yC9L1hRgFyUe5SaSYdRrIsVcun
 dzwN0oo2zh7zUeXXBfS1YOogqy9QxzsFboM3qHmk7uDdN2rBxbxAfpTKeI/OoN/wIzbG5jwOLCu
 DWJ1S2BwJPNSU52PnG2ANRJi0216CV98Lb498BrxkF/dNmAwID5j9OaJxv2rLGWRUDkwcftxtP6
 URievl60pKji5eo2A344sRpNbAVC6KgHkHoHMJ+TRChMtLs+vPJcVYDZB41p59O0nj8aMMKyQwV
 z8+MJb1GGIBu4+gW6Nyzp68noVP5Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160026
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
index 63e9ba521b..790607b557 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2525,6 +2525,12 @@ F: hw/virtio/vhost-user-scmi*
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
index 0000000000..095aba5760
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
+#include "hw/qdev-properties.h"
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
index 0000000000..0d44dec46a
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
+#include "hw/qdev-properties.h"
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
index 257cda506a..d2ff634b14 100644
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
2.34.1


