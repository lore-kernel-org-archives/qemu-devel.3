Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610B7CCF9ED
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDI1J-0006K4-Sh; Mon, 27 Oct 2025 03:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vDI1G-0006JG-Nx
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:51:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vDI1E-0002fN-2A
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:51:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59QLr6Ta920648; Mon, 27 Oct 2025 07:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t82880nxsZOVaG9NK9ol8K59zYLiUXZt+O7GjvGE2NQ=; b=fu59pT0e6NDcF7o2
 lhtmzcisTY01Lvze9C4+M9EYupEOuIf3t29B0iY1DK9YBehZWa9ABAhkUZ4e7W7Q
 l7hxNYHWlvwh2f9mFaowM/hBkeJIECnOtXMbHlDn50H0++jvV7hqoUUZohjS8Wpz
 Okku9YV5b6hPLdjHRCyshfapi++PTRVYqweWdomf7xtiqER+d5wR0NFWzBuFo1bF
 wQSN2tviggwX/OLvZpMEoP/Se8kT8nKpo6fM3YxSb0xIVvXT5+vpqZ1vBdqOhpE4
 4a9YqvKWkCCpYNVLAx7O5GhDz3RkpPqzZusJzltmHoFOZiv1ZLvBrcNTyHzK4d6J
 Z4j3iA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p2q3qhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 07:51:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59R7pqLB011404
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 07:51:52 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 27 Oct 2025 00:51:49 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <alex.bennee@linaro.org>, <viresh.kumar@linaro.org>,
 <quic_tsoni@quicinc.com>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <zhiqiang.tu@oss.qualcomm.com>
CC: Haixu Cui <quic_haixcui@quicinc.com>
Subject: [PATCH v1 3/3] virtio-spi: Add vhost-user-spi device support
Date: Mon, 27 Oct 2025 15:51:23 +0800
Message-ID: <20251027075123.2237914-4-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027075123.2237914-1-quic_haixcui@quicinc.com>
References: <20251027075123.2237914-1-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=QvpTHFyd c=1 sm=1 tr=0 ts=68ff2498 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=i0EeH86SAAAA:8
 a=V6sQ2tzMW6r_q-Xi4HUA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA3MiBTYWx0ZWRfXyQ1EJdnQ4Os+
 bHKF0sPz549llx1eBPzadqVh02Y8NYqvU+I36heAZPiCdP9mFIyMxY2bWY6vkz9c6qbNKyrNFen
 pocmbDS0OTtcwBUnQIEGSm4Q3fwCLY/U/ZSqFIbFPLbOn8QPOf26Rbh64RJHFCCCpoX9e35i4F+
 DHgJvCWTG/sRLqwCyfcKCnQaVWbVk7Lqg2OanlNYiPwfIN3ZA4NfS/6l49wJUGLw6qJiEzLdMch
 ySG1vUwQNqp/uC89kQeoO9ziq93BmrFqIKPM3hS3yPiYY0NYg4PkahdrEiZjxd8L2Lhc3ZmxBOH
 Ba6A6yakXd7tt4UCZitz8810AFGPYKaBm7386O7dHTKWhh8PyfVjhNmbUtj3oQsbvnbMgDRmcYv
 5ZYMuy+5REM8XU+GUInHfwd1Qxs0Tg==
X-Proofpoint-GUID: bEI7RRzzAsEc0AzUXeUY1yxPLib6542p
X-Proofpoint-ORIG-GUID: bEI7RRzzAsEc0AzUXeUY1yxPLib6542p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0a-0031df01.pphosted.com
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
---
 MAINTAINERS                        |  6 +++
 hw/virtio/Kconfig                  |  5 +++
 hw/virtio/meson.build              |  3 ++
 hw/virtio/vhost-user-spi-pci.c     | 69 ++++++++++++++++++++++++++++++
 hw/virtio/vhost-user-spi.c         | 65 ++++++++++++++++++++++++++++
 hw/virtio/virtio.c                 |  4 +-
 include/hw/virtio/vhost-user-spi.h | 25 +++++++++++
 7 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/vhost-user-spi-pci.c
 create mode 100644 hw/virtio/vhost-user-spi.c
 create mode 100644 include/hw/virtio/vhost-user-spi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f33f95ceea..9ce2e16140 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2520,6 +2520,12 @@ F: hw/virtio/vhost-user-scmi*
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
index 153ee0a0cf..242b95e702 100644
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


