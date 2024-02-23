Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C740CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUuP-0000HM-9y; Fri, 23 Feb 2024 07:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rdUtF-00080s-W1; Fri, 23 Feb 2024 07:42:59 -0500
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rdUtD-0003lB-9L; Fri, 23 Feb 2024 07:42:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffKB/5OS+fJvtmf/kTaEoiESISbkrFK2CpXBt+lqM29aAphN5wpCmzX/RxpTtmIO3cQttGyC7oUMnKLV+OWAW1TmV1rXmgcj9mYSoxHlT5DrV2RL1Jhs2qD8HaqAaXKFgtEbKtKmlXOhKMhVi2VV0XkeyUqvp5DFfn+4vOCpK6Kqm1iZ24d9Z7Q+Dhr/ZClRfO0Lqz7cejpS0pnA3thoKQeps2QfxBy6evLuz3B4xJVUhyXK6Xt08gmfjRdCqffdg5ygT0eMRNs82GjyMsv5lGVdKgh3KCa7bG4jV098ebs0vTZK0PPQSWMLb+eE6Y7d6eTRwZCFvm2xh/59/V6VtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNMzh/zxtyhLtnk7g247b2Dn1I4KaVnorFJq9iQ0WeQ=;
 b=OOC2+hXDMLMEqKF9Y9NgJVUu5hnJ0asQQDVfIaudfY3BBlbpkTEVA18Zvr2Y2wtHD0X+EtuY8eQ7SvZXGEw68eUKFzxde1d8uqe2kNKfnE/ihC4kGUWI7iTNgIs5MLdKygh6n577wPb5ftUSvEqm/FWDjYRaG14uD4kc7ada3AFVJOAG5TvP1Tf3wajNtOcS62/3smyA8P5jvRf3tcTC/JJaHWkyk/1NqqDIjcBKbOAlciJMVAAezSWMdN9/SxWndT25nlqdNiSHSl3NwAS0wn38gI/3zboCOdBpF3mUv0RLiIVY632fFYLx3TLnz87+Hdxp3Sn2ILyapdMSOGCqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNMzh/zxtyhLtnk7g247b2Dn1I4KaVnorFJq9iQ0WeQ=;
 b=heRDiqSJj7v/cn7UyelpAeFDnoFgV6jtUIFpHAxdEPBMX3XPI/PJfWWA3wcMg4bvzEz1LmfgTmivAAWgAEEUsaaaSwo3v5AScH77T9SjhNPPD5pjcl8a49M/Axn42vkL2pTXB1YUnosfa9XwyHzHfv6o/El6hpDG4fbwNNh97xJdM2Exg8CUTG/DHaiAR3uL4GIp2JyjEaG/kcuoLYA5ftc7e2jnSbLFS9+T2WchyYsgBdh1xeS796p+Ocw4oy6WFm0gMpOyRtJEkx5BOn2lPUj82++qMwoWDmTARRkn/HyUbwvq9UkzsMmAmnmX1MjBdQNAa8vfGCOsU+qMetBYJg==
Received: from SJ0PR13CA0167.namprd13.prod.outlook.com (2603:10b6:a03:2c7::22)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Fri, 23 Feb
 2024 12:42:47 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::3f) by SJ0PR13CA0167.outlook.office365.com
 (2603:10b6:a03:2c7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14 via Frontend
 Transport; Fri, 23 Feb 2024 12:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 12:42:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 23 Feb
 2024 04:42:26 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 23 Feb
 2024 04:42:25 -0800
Received: from localhost.nvc.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 23 Feb 2024 04:42:24 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
 <clg@redhat.com>, <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <ani@anisinha.ca>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <mst@redhat.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <david@redhat.com>, <gshan@redhat.com>,
 <Jonathan.Cameron@huawei.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <pbonzini@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <dnigam@nvidia.com>, <udhoke@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH v7 1/2] qom: new object to associate device to numa node
Date: Fri, 23 Feb 2024 12:42:22 +0000
Message-ID: <20240223124223.800078-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223124223.800078-1-ankita@nvidia.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f22f5a-2050-413c-2172-08dc346cf001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+giUW+HrwU8pDd6Iivo6IafNXCZZXVd0SBKb6c4aedzddVk4INMAJDphpsPC4zw3dP2hkt69U+iwXpm8/nd2ZXtAhd2PFUX3kwq2Prrh9ssPHeuWmINFE+ENNDRyrWRI5vV0y6RzoB+7soJtzspH/4coGjxBY/xCWBR86c/KS/t38QT7iRHVABnim0upFTQv5QVTDXPLJZkSRHss72yJ9owwGnKGuFir7IYVdHd5K7MrB8s2Hd/x0eC14weAYCcbK76XlHECy5MLntbHGn5WBSKEeDgvhBFYcZ/aacUVb9r0lU3KBjET8vGG7n2/EGlvyy5q2RO4Xqaj9Z+/GkILpBAod3FbFPzVcob+hcPR9Hc+nWKcp/8AaN8x9Hf71FeCBfs/7jVPYtJmiPQFeQDrl59DZNY7/8z2ZlvCRxJzL//+DjMDBy6qxLocCSkAqXB3NgxUs7hWCsjf7D8lO7jw3oMzZ4D0Jht3h9LggW/E5dI5ZXmjCGqZQM2fzaQQbfpRy6txBb3oNPRcIP4jHshhOIWrq1XpAu01na/V1t1JdIXcJT+I81cpWKsqUhv+9YAtSkz43GnTEC8gf6d9qLZF6d/zvjK5Pbr2f2HuNqv2ZJFys3/CCMbAD/BYpDyG/MoeP4KnMhkUYl1wtmXWhQ5iklYYyb7/XrA/8NFRovk71uEbe3xjxOfF9kS5r4agNn+zgxwQecBtxkXiux8lFRsXQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004)(921011); DIR:OUT; SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 12:42:46.6079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f22f5a-2050-413c-2172-08dc346cf001
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
Received-SPF: softfail client-ip=2a01:111:f403:2416::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ankit Agrawal <ankita@nvidia.com>

NVIDIA GPU's support MIG (Mult-Instance GPUs) feature [1], which allows
partitioning of the GPU device resources (including device memory) into
several (upto 8) isolated instances. Each of the partitioned memory needs
a dedicated NUMA node to operate. The partitions are not fixed and they
can be created/deleted at runtime.

Unfortunately Linux OS does not provide a means to dynamically create/destroy
NUMA nodes and such feature implementation is not expected to be trivial. The
nodes that OS discovers at the boot time while parsing SRAT remains fixed. So
we utilize the Generic Initiator Affinity structures that allows association
between nodes and devices. Multiple GI structures per BDF is possible,
allowing creation of multiple nodes by exposing unique PXM in each of these
structures.

Implement the mechanism to build the GI affinity structures as Qemu currently
does not. Introduce a new acpi-generic-initiator object to allow host admin
link a device with an associated NUMA node. Qemu maintains this association
and use this object to build the requisite GI Affinity Structure.

When multiple numa nodes are associated with a device, it is required to
create those many number of acpi-generic-initiator objects, each representing
a unique device:node association.

Following is one of a decoded GI affinity structure in VM ACPI SRAT.
[0C8h 0200   1]                Subtable Type : 05 [Generic Initiator Affinity]
[0C9h 0201   1]                       Length : 20

[0CAh 0202   1]                    Reserved1 : 00
[0CBh 0203   1]           Device Handle Type : 01
[0CCh 0204   4]             Proximity Domain : 00000007
[0D0h 0208  16]                Device Handle : 00 00 20 00 00 00 00 00 00 00 00
00 00 00 00 00
[0E0h 0224   4]        Flags (decoded below) : 00000001
                                     Enabled : 1
[0E4h 0228   4]                    Reserved2 : 00000000

[0E8h 0232   1]                Subtable Type : 05 [Generic Initiator Affinity]
[0E9h 0233   1]                       Length : 20

An admin can provide a range of acpi-generic-initiator objects, each
associating a device (by providing the id through pci-dev argument)
to the desired numa node (using the node argument). Currently, only PCI
device is supported.

For the grace hopper system, create a range of 8 nodes and associate that
with the device using the acpi-generic-initiator object. While a configuration
of less than 8 nodes per device is allowed, such configuration will prevent
utilization of the feature to the fullest. The following sample creates 8
nodes per PCI device for a VM with 2 PCI devices and link them to the
respecitve PCI device using acpi-generic-initiator objects:

-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
-numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
-numa node,nodeid=8 -numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
-object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
-object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
-object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
-object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
-object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
-object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
-object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \

-numa node,nodeid=10 -numa node,nodeid=11 -numa node,nodeid=12 \
-numa node,nodeid=13 -numa node,nodeid=14 -numa node,nodeid=15 \
-numa node,nodeid=16 -numa node,nodeid=17 \
-device vfio-pci-nohotplug,host=0009:01:01.0,bus=pcie.0,addr=05.0,rombar=0,id=dev1 \
-object acpi-generic-initiator,id=gi8,pci-dev=dev1,node=10 \
-object acpi-generic-initiator,id=gi9,pci-dev=dev1,node=11 \
-object acpi-generic-initiator,id=gi10,pci-dev=dev1,node=12 \
-object acpi-generic-initiator,id=gi11,pci-dev=dev1,node=13 \
-object acpi-generic-initiator,id=gi12,pci-dev=dev1,node=14 \
-object acpi-generic-initiator,id=gi13,pci-dev=dev1,node=15 \
-object acpi-generic-initiator,id=gi14,pci-dev=dev1,node=16 \
-object acpi-generic-initiator,id=gi15,pci-dev=dev1,node=17 \

The performance benefits can be realized by providing the NUMA node distances
appropriately (through libvirt tags or Qemu params). The admin can get the
distance among nodes in hardware using `numactl -H`.

[1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi-generic-initiator.c         | 70 ++++++++++++++++++++++++
 hw/acpi/meson.build                      |  1 +
 include/hw/acpi/acpi-generic-initiator.h | 32 +++++++++++
 qapi/qom.json                            | 17 ++++++
 4 files changed, 120 insertions(+)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
new file mode 100644
index 0000000000..1ade2f723f
--- /dev/null
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi-generic-initiator.h"
+#include "hw/pci/pci_device.h"
+#include "qapi/error.h"
+#include "qapi/qapi-builtin-visit.h"
+#include "qapi/visitor.h"
+#include "qemu/error-report.h"
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
+                   ACPI_GENERIC_INITIATOR, OBJECT,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
+
+static void acpi_generic_initiator_init(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->node = MAX_NODES;
+    gi->pci_dev = NULL;
+}
+
+static void acpi_generic_initiator_finalize(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    g_free(gi->pci_dev);
+}
+
+static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
+                                                  Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->pci_dev = g_strdup(val);
+}
+
+static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value >= MAX_NODES) {
+        error_printf("%s: Invalid NUMA node specified\n",
+                     TYPE_ACPI_GENERIC_INITIATOR);
+        exit(1);
+    }
+
+    gi->node = value;
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_initiator_set_pci_device);
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_initiator_set_node, NULL, NULL);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fc1b952379..2268589519 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,5 +1,6 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
+  'acpi-generic-initiator.c',
   'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
new file mode 100644
index 0000000000..2f183b029a
--- /dev/null
+++ b/include/hw/acpi/acpi-generic-initiator.h
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#ifndef ACPI_GENERIC_INITIATOR_H
+#define ACPI_GENERIC_INITIATOR_H
+
+#include "hw/mem/pc-dimm.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/aml-build.h"
+#include "sysemu/numa.h"
+#include "qemu/uuid.h"
+#include "qom/object.h"
+#include "qom/object_interfaces.h"
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+typedef struct AcpiGenericInitiator {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *pci_dev;
+    uint16_t node;
+} AcpiGenericInitiator;
+
+typedef struct AcpiGenericInitiatorClass {
+        ObjectClass parent_class;
+} AcpiGenericInitiatorClass;
+
+#endif
diff --git a/qapi/qom.json b/qapi/qom.json
index c53ef978ff..7efa0e14f6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -794,6 +794,21 @@
 { 'struct': 'VfioUserServerProperties',
   'data': { 'socket': 'SocketAddress', 'device': 'str' } }
 
+##
+# @AcpiGenericInitiatorProperties:
+#
+# Properties for acpi-generic-initiator objects.
+#
+# @pci-dev: PCI device ID to be associated with the node
+#
+# @node: numa node associated with the PCI device
+#
+# Since: 9.0
+##
+{ 'struct': 'AcpiGenericInitiatorProperties',
+  'data': { 'pci-dev': 'str',
+            'node': 'uint32' } }
+
 ##
 # @RngProperties:
 #
@@ -911,6 +926,7 @@
 ##
 { 'enum': 'ObjectType',
   'data': [
+    'acpi-generic-initiator',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -981,6 +997,7 @@
             'id': 'str' },
   'discriminator': 'qom-type',
   'data': {
+      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
-- 
2.34.1


