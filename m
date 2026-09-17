Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A47C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7AhZ-0000qo-FW; Thu, 17 Sep 2026 07:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Baorui.Liu@amd.com>)
 id 1x755I-0007Oe-BD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:55:01 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Baorui.Liu@amd.com>)
 id 1x755E-0007IT-N5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioqb7X6HDIvBqgHnndvbHNCz4kUFdQI2KyoRK+CBt34ULmnmQTfNa8BFxVgcM3GSxMrVOTIwvD1jLUzfdm1/+h2QABQ3kFcpxiwcURvrs3fXhExdWC+P06/En1FkfS+1eGzWl0VHfX49+nN3HKFwIPSlZ9XJEpyLAJbWYExWdVax6l12+W5KQEMiERfKqC6JsXCcjL7FCE7H1ouFNG51FZMoWKzrkaPwQGLd/xrly5IzAhkC7+SZVJNH+goj1T8950rSdJHn1vYfn6T62y5uZofL/zPY0CF+etcqLvlnRcsa6kup1+MPopBHFNWJNJjjNRSymPRI1pZpZG7GIV3rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czxnWPTYJwsfmcJ6GNrtlMuo01bSQg+xJY+kDpE9OrQ=;
 b=bwYhIayEimqBn0f6Hb31lqM8hNkRHct7ddGENX7uQycx7hKMFIUaerTwrkoi7M8r6SoaE7UGR5jiOOY5Dqksq4F2LjDbIyLQ4zolhTWKsKv2ycpgjgY+MNOfbZex/ki8ke8RkWBFa1sdCdzsdC0VhGa4L6XQYqtLOTyraGEc4VNfl5I/Yr8Tmoe56i+ZyziHi36c5BiaIVsBe+NTsEoImW5HrsMSwK53RbjR+sNATiq5MfqyV3dG8A41WYM+j8FRpIJ+8d9+2XwnnPyXu5xFMVJqLr68ppqlIAZCFCXYzcQRBU+XRRXem9nVTJHDg0UYPO+w8tfg+yqcHil9chqf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czxnWPTYJwsfmcJ6GNrtlMuo01bSQg+xJY+kDpE9OrQ=;
 b=sAAnuGDEwU4vXxrAXRR1/C67cqFaOMfhXuES7mFamayzM0ZON0ZebUCCXnRg2E4nkhxXV9qnHpTPEsreCCN2LUVNXUv7BSliuVkjL87AasM7lm53sjhZVvQ7x8eGP5b7UwU6y/w6Ch69cgtJ6+NMdkX/K9gWxVFeDOj0omU3Tb4=
Received: from CH0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:610:e5::30)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 05:54:50 +0000
Received: from LV8PEPF00000060.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::45) by CH0PR03CA0265.outlook.office365.com
 (2603:10b6:610:e5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 05:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000060.mail.protection.outlook.com (10.167.245.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 05:54:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 00:54:49 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 00:54:48 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Meng Zhang <Meng.Zhang@amd.com>,
 Baorui.Liu <baorliu@amd.com>
Subject: [RFC PATCH 2/3] hw/virtio: add virtio-cpufreq Xen backend
Date: Thu, 17 Sep 2026 13:54:16 +0800
Message-ID: <20260917055417.495-3-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917055417.495-1-baorliu@amd.com>
References: <20260917055417.495-1-baorliu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000060:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 806bcc4d-c564-4e5f-139d-08df14802fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|22082099003|18002099003|10067099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: URjyOs/4Eeb3iyORzAMIycj8GGYF+J1WkbfTH8Pfbb5SuVs35VlbUiXbgJunhB3S2a2GeB1HO9XpcyHWHgBBnLaJw7Whjex5DtSHLLLZYF95n6ofIGZRCr8nOQqnafdEgYIip8+c2Sfco+I+go+ZGg45MjjDnZ8V1cIhooXLfxMLqJgqXRSduG5jN9hYMll6cJann19IsvdWZL+EwS6Q+2yEkl5KHvZJaojRcTCSFu8+3u+6hsqh4laFU/ByWE6AM3aJZxoJLPcBhHGQCNSm6jWk5c4JEVRvmACw6NZIE951KgcZlE4J4AH40aOAbP9jADnUTzLtnrmBVMxECZQq9IY72DaKRG4AoE8JKs6mGObqS5zJfbRSxHu8t0dfWdyqq0VRe3pmpxsZiASto3XMbjY2mO2bs3LqJ8FmnpLns8Oq+S37amox79TOG4+5YFx2dksTSlKy1sNpB4wqjkymEk47y0BJy1xEc7c9k/yNs2OrLR7yvAvDygDK+yuNqrWsUYOSfn9eNZU7sfM+Dh1ypb9K+HoDwwcxmgJPzjaUu8BIM6GufS0g63AW5QeRBt3a4N03uTLlU1NTboGqAAXtIzli/3q5OZ0xLMa4LAErb2DRNgU6rSVhuDmquVOORMx7z2TFBqjSKX1asnIue2CR7vz/GWb108XPAipI6gEmBO4GUwCX32omk0I/zd6YgvZeJ6RTte56V3qErzs8qTRMBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ik9I2538yLNatFWofw968yBV1Utv50m2hPIWsCs/Ll1ofJ9A9Ptq5F05oPNP+GcT+xKaZENu/i+8XFypB5DayHjBon0mfHpBU6lZBompBpbuc/h2k3XB4uYG1K3ck1czR14aRUvpkg56tOzEg1lKhmyktBx5iWEjrFKz5nLZ6j1IrMJbsKvwweD2Idr81KAj+4p5ocMdQauJ7Pdwphy1gWwYjDu89Yla0nwlqnHrpeWTBe/Y6pD2WxtCuCjk0sDQtfAXw95wlsaHNZNFCOW7p0SjINmA4eKKq/EN3Ojn4Rftx8zb46UZClECChLH+a7oq6le9K+RmqIpPWJV0FBQ4i73/lx3csCY6Uz4jvDQNxw+JCOTIfuK0rlqrVCLrnFx41+TfFf10LdKrnvfY17U3dLgECezpCz7O7NtEiRQBV0uGGSkH5xoZHbMmr4qpqUx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 05:54:50.0343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806bcc4d-c564-4e5f-139d-08df14802fd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000060.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Baorui.Liu@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:54:51 -0400
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

Report the host pCPU frequency of a pinned Xen vCPU to a guest
virtio-cpufreq frontend. Virtio ID 42 is experimental.

Based on the qemu-xen device by Meng Zhang.

Signed-off-by: Meng Zhang <Meng.Zhang@amd.com>
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
 MAINTAINERS                        |   7 +
 hw/virtio/Kconfig                  |   5 +
 hw/virtio/meson.build              |   2 +
 hw/virtio/virtio-cpufreq-pci.c     |  82 ++++++++++
 hw/virtio/virtio-cpufreq.c         | 242 +++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c             |   3 +
 hw/virtio/virtio-qmp.c             |   1 +
 hw/virtio/virtio.c                 |   1 +
 include/hw/virtio/virtio-cpufreq.h |  23 +++
 9 files changed, 366 insertions(+)
 create mode 100644 hw/virtio/virtio-cpufreq-pci.c
 create mode 100644 hw/virtio/virtio-cpufreq.c
 create mode 100644 include/hw/virtio/virtio-cpufreq.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9012bf476d..dc9014c2be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2702,6 +2702,13 @@ F: hw/virtio/virtio-crypto.c
 F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
 
+virtio-cpufreq
+M: Baorui Liu <baorliu@amd.com>
+S: Maintained
+F: hw/virtio/virtio-cpufreq.c
+F: hw/virtio/virtio-cpufreq-pci.c
+F: include/hw/virtio/virtio-cpufreq.h
+
 virtio based memory device
 M: David Hildenbrand <david@kernel.org>
 S: Supported
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 91cf833407..b6951f5096 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -146,3 +146,8 @@ config VHOST_USER_RTC
     bool
     default y
     depends on VIRTIO && VHOST_USER
+
+config VIRTIO_CPUFREQ
+    bool
+    default y
+    depends on VIRTIO && XEN
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index b59f455a51..03793e1a7c 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -55,6 +55,7 @@ endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RTC', if_true: files('virtio-rtc.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_CPUFREQ', if_true: files('virtio-cpufreq.c'))
 
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
@@ -79,6 +80,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RTC', if_true: files('virtio-rtc-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CPUFREQ', if_true: files('virtio-cpufreq-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm-pci.c', 'cbor-helpers.c'), libcbor])
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
diff --git a/hw/virtio/virtio-cpufreq-pci.c b/hw/virtio/virtio-cpufreq-pci.c
new file mode 100644
index 0000000000..b7066d962c
--- /dev/null
+++ b/hw/virtio/virtio-cpufreq-pci.c
@@ -0,0 +1,82 @@
+/*
+ * Virtio CPU frequency PCI bindings
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-cpufreq.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+#include "standard-headers/linux/virtio_ids.h"
+
+typedef struct VirtIOCPUFreqPCI VirtIOCPUFreqPCI;
+
+/*
+ * virtio-cpufreq-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_CPUFREQ_PCI "virtio-cpufreq-pci-base"
+DECLARE_INSTANCE_CHECKER(VirtIOCPUFreqPCI, VIRTIO_CPUFREQ_PCI,
+                         TYPE_VIRTIO_CPUFREQ_PCI)
+
+struct VirtIOCPUFreqPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOCPUFreq vdev;
+};
+
+static void virtio_cpufreq_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOCPUFreqPCI *vcpufreq = VIRTIO_CPUFREQ_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&vcpufreq->vdev);
+
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
+        return;
+    }
+}
+
+static void virtio_cpufreq_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = virtio_cpufreq_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    /*
+     * virtio 1.0 PCI device ID is 0x1040 + virtio ID. ID 42 is experimental
+     * and is not yet assigned by the virtio spec.
+     */
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_10_BASE + VIRTIO_ID_CPUFREQ;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_cpufreq_initfn(Object *obj)
+{
+    VirtIOCPUFreqPCI *dev = VIRTIO_CPUFREQ_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_CPUFREQ);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_cpufreq_pci_info = {
+    .base_name             = TYPE_VIRTIO_CPUFREQ_PCI,
+    .generic_name          = "virtio-cpufreq-pci",
+    .non_transitional_name = "virtio-cpufreq-pci-non-transitional",
+    .instance_size = sizeof(VirtIOCPUFreqPCI),
+    .instance_init = virtio_cpufreq_initfn,
+    .class_init    = virtio_cpufreq_pci_class_init,
+};
+
+static void virtio_cpufreq_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_cpufreq_pci_info);
+}
+
+type_init(virtio_cpufreq_pci_register)
diff --git a/hw/virtio/virtio-cpufreq.c b/hw/virtio/virtio-cpufreq.c
new file mode 100644
index 0000000000..c9672c901b
--- /dev/null
+++ b/hw/virtio/virtio-cpufreq.c
@@ -0,0 +1,242 @@
+/*
+ * Virtio CPU frequency backend
+ *
+ * Reports the host pCPU frequency that currently runs a Xen vCPU to a
+ * guest virtio-cpufreq frontend.
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/iov.h"
+#include "qemu/module.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-cpufreq.h"
+#include "hw/xen/xen_native.h"
+#include "migration/vmstate.h"
+#include "standard-headers/linux/virtio_ids.h"
+
+struct freq_request {
+    uint32_t cpu_id;      /* vCPU ID to query */
+    uint32_t freq_khz;    /* Returned frequency in kHz */
+} QEMU_PACKED;
+
+static bool pinning_checked;
+static bool pinning_ok;
+
+/*
+ * Each guest vCPU must be pinned to a unique pCPU so the reported
+ * frequency is meaningful.
+ */
+static bool check_cpu_pinned(void)
+{
+    uint32_t domid = xen_domid;
+    xc_cpumap_t cpumap_hard;
+    xc_domaininfo_t info;
+    int vcpu, pcpu, vcpus_num, pcpus_num;
+    bool checked_result = true;
+    int *used_pcpu;
+
+    if (!xen_xc) {
+        error_report("virtio-cpufreq: Xen interface is not available");
+        return false;
+    }
+
+    if (xc_domain_getinfo_single(xen_xc, domid, &info) < 0) {
+        error_report("virtio-cpufreq: xc_domain_getinfo_single failed");
+        return false;
+    }
+
+    vcpus_num = info.max_vcpu_id + 1;
+    pcpus_num = xc_get_max_cpus(xen_xc);
+    used_pcpu = g_new(int, pcpus_num);
+
+    cpumap_hard = xc_cpumap_alloc(xen_xc);
+    if (cpumap_hard == NULL) {
+        g_free(used_pcpu);
+        return false;
+    }
+
+    for (pcpu = 0; pcpu < pcpus_num; pcpu++) {
+        used_pcpu[pcpu] = -1;
+    }
+
+    for (vcpu = 0; vcpu < vcpus_num; vcpu++) {
+        int count = 0, pinned_pcpu = -1;
+
+        memset(cpumap_hard, 0, xc_get_cpumap_size(xen_xc));
+        if (xc_vcpu_getaffinity(xen_xc, domid, vcpu, cpumap_hard,
+                                NULL, XEN_VCPUAFFINITY_HARD)) {
+            error_report("virtio-cpufreq: xc_vcpu_getaffinity failed");
+            checked_result = false;
+            break;
+        }
+
+        for (pcpu = 0; pcpu < pcpus_num; pcpu++) {
+            if (xc_cpumap_testcpu(pcpu, cpumap_hard)) {
+                count++;
+                pinned_pcpu = pcpu;
+            }
+        }
+
+        if (count != 1) {
+            error_report("virtio-cpufreq: vCPU%d is pinned to %d pCPUs "
+                         "(expected 1)", vcpu, count);
+            checked_result = false;
+            break;
+        }
+
+        if (used_pcpu[pinned_pcpu] != -1) {
+            error_report("virtio-cpufreq: pCPU%d already used by another vCPU",
+                         pinned_pcpu);
+            checked_result = false;
+            break;
+        }
+
+        used_pcpu[pinned_pcpu] = vcpu;
+    }
+
+    free(cpumap_hard);
+    g_free(used_pcpu);
+    return checked_result;
+}
+
+static uint32_t get_host_cpu_freq(uint32_t vcpu_id)
+{
+    uint32_t pcpu_id;
+    uint32_t domid = xen_domid;
+    int cpufreq;
+    xc_vcpuinfo_t vcpu_info;
+
+    if (!xen_xc) {
+        return 0;
+    }
+
+    if (xc_vcpu_getinfo(xen_xc, domid, vcpu_id, &vcpu_info)) {
+        error_report("virtio-cpufreq: xc_vcpu_getinfo failed");
+        return 0;
+    }
+    pcpu_id = vcpu_info.cpu;
+
+    if (xc_get_cpufreq_avgfreq(xen_xc, pcpu_id, &cpufreq)) {
+        error_report("virtio-cpufreq: get freq failed");
+        return 0;
+    }
+
+    return cpufreq;
+}
+
+static void virtio_cpufreq_handle_request(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement *elem;
+    struct freq_request req;
+    size_t len;
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return;
+    }
+
+    /*
+     * out_sg: request (cpu_id)
+     * in_sg: response (freq_khz)
+     */
+    if (elem->out_num == 0 || elem->in_num == 0) {
+        error_report("virtio-cpufreq: invalid buffer configuration");
+        virtqueue_push(vq, elem, 0);
+        virtio_notify(vdev, vq);
+        g_free(elem);
+        return;
+    }
+
+    len = iov_to_buf(elem->out_sg, elem->out_num, 0, &req, sizeof(req));
+    if (len < sizeof(req)) {
+        error_report("virtio-cpufreq: invalid request size %zu (expected %zu)",
+                     len, sizeof(req));
+        virtqueue_push(vq, elem, 0);
+        virtio_notify(vdev, vq);
+        g_free(elem);
+        return;
+    }
+
+    if (!pinning_checked) {
+        pinning_ok = check_cpu_pinned();
+        pinning_checked = true;
+    }
+
+    if (!pinning_ok) {
+        req.freq_khz = 0;
+    } else {
+        req.freq_khz = get_host_cpu_freq(req.cpu_id);
+    }
+
+    len = iov_from_buf(elem->in_sg, elem->in_num, 0, &req, sizeof(req));
+
+    virtqueue_push(vq, elem, len);
+    virtio_notify(vdev, vq);
+    g_free(elem);
+}
+
+static uint64_t virtio_cpufreq_get_features(VirtIODevice *vdev,
+                                            uint64_t features,
+                                            Error **errp)
+{
+    return features;
+}
+
+static void virtio_cpufreq_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOCPUFreq *vcpufreq = VIRTIO_CPUFREQ(dev);
+
+    virtio_init(vdev, VIRTIO_ID_CPUFREQ, 0);
+    vcpufreq->vq = virtio_add_queue(vdev, 128, virtio_cpufreq_handle_request);
+}
+
+static void virtio_cpufreq_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    virtio_del_queue(vdev, 0);
+    virtio_cleanup(vdev);
+}
+
+static const VMStateDescription vmstate_virtio_cpufreq = {
+    .name = "virtio-cpufreq",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void virtio_cpufreq_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_virtio_cpufreq;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = virtio_cpufreq_device_realize;
+    vdc->unrealize = virtio_cpufreq_device_unrealize;
+    vdc->get_features = virtio_cpufreq_get_features;
+}
+
+static const TypeInfo virtio_cpufreq_info = {
+    .name = TYPE_VIRTIO_CPUFREQ,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIOCPUFreq),
+    .class_init = virtio_cpufreq_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_cpufreq_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c73f1f546c..fa677c730a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -312,6 +312,9 @@ static const VirtIOPCIIDInfo virtio_pci_id_info[] = {
         .vdev_id = VIRTIO_ID_RNG,
         .trans_devid = PCI_DEVICE_ID_VIRTIO_RNG,
         .class_id = PCI_CLASS_OTHERS,
+    }, {
+        .vdev_id = VIRTIO_ID_CPUFREQ,
+        .class_id = PCI_CLASS_OTHERS,
     },
 };
 
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 5aaeebdd96..c9ef4786b1 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -643,6 +643,7 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
     case VIRTIO_ID_DMABUF:
     case VIRTIO_ID_PARAM_SERV:
     case VIRTIO_ID_AUDIO_POLICY:
+    case VIRTIO_ID_CPUFREQ:
         break;
     default:
         g_assert_not_reached();
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c9f9e5b511..5edd7bf766 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -198,6 +198,7 @@ const char *virtio_device_names[] = {
     [VIRTIO_ID_AUDIO_POLICY] = "virtio-audio-pol",
     [VIRTIO_ID_BT] = "virtio-bluetooth",
     [VIRTIO_ID_GPIO] = "virtio-gpio",
+    [VIRTIO_ID_CPUFREQ] = "virtio-cpufreq",
     [VIRTIO_ID_SPI] = "virtio-spi",
     [VIRTIO_ID_MEDIA] = "virtio-media",
 };
diff --git a/include/hw/virtio/virtio-cpufreq.h b/include/hw/virtio/virtio-cpufreq.h
new file mode 100644
index 0000000000..25d151d7e6
--- /dev/null
+++ b/include/hw/virtio/virtio-cpufreq.h
@@ -0,0 +1,23 @@
+/*
+ * Virtio CPU frequency backend (Xen)
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VIRTIO_CPUFREQ_H
+#define QEMU_VIRTIO_CPUFREQ_H
+
+#include "hw/virtio/virtio.h"
+#include "qom/object.h"
+
+#define TYPE_VIRTIO_CPUFREQ "virtio-cpufreq-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOCPUFreq, VIRTIO_CPUFREQ)
+
+struct VirtIOCPUFreq {
+    VirtIODevice parent_obj;
+    VirtQueue *vq;
+};
+
+#endif /* QEMU_VIRTIO_CPUFREQ_H */
-- 
2.34.1


