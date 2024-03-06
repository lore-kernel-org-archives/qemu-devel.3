Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F59CC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 12:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqT2-0007nB-44; Wed, 06 Mar 2024 07:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhqSz-0007mI-Ly; Wed, 06 Mar 2024 07:33:49 -0500
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2417::600]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhqSj-0002tl-2d; Wed, 06 Mar 2024 07:33:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx1BxIRppO9IUsnLnAoqRcCudYo3IFkw7ORmVD4M1Khcubjtg84rmDIXgIEYzXc5KUAUaxQgljO4l4ZSQrlFrR51/08R8NyqizBi3xvafPS8EJj2/fa2tScrz8ElDVGV4EEtsceMriPft0L72rTKcp/hLILna3ogZdCtu7l86TmzZQK+ZE06TAHV1NIBXclInCv2j3aSygy0/5bTRRmCzz8fCoCg13rmRORcRoQbwfnuBPn0pl0MaSjK1Ji+zCE46IqAUJoH1+/KHzBvWcG/2dTcQBCz3u2/IQyuudV07dL/X76cAOE7Jl0XWcCl6k9tSnc28ecYU0o9fywJamFAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frcPjRGZo1oRo0cPtFTuc4o2IqwRO7M2vYylEmkZ+bc=;
 b=nOfXhGZScw4Lst1UdNOwBaWqd/GPnsElg163zTax0h1S87EnOjtkEnvDNf1S0oJPGmSlOlp1OaTcuE2+loUYDvINliyOBeXYVEIezvqVxTQu1vu0AwmsGBBk15XfscS4jutI0goOPUU7SMN5U0tUPnypR4ggYO9aqn7l0f11b3U+QBwNn25nOk+ll1fKMmbnPt7dHpQ2VmjX1qT8H7ZMBOrWNOSiZca3kIhaRm0njdsR7rQ/z1YdunDWSiw9ZFG/TDy6ueVHvvJQ1i2QMnEN25TAo20xYF8GgHcCS9nbGWgnzouveJR6mf0eo02RtQ84W2xjd6vo/Bm+8v4oJcxY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frcPjRGZo1oRo0cPtFTuc4o2IqwRO7M2vYylEmkZ+bc=;
 b=JYFA+hFoA6cp9M3hgsj93klMKmriagcUG14q7s2SiOUIAyzbzRFJ1RQjwuZ8E2LZNoX0QehWQsHmmeCWtAP2yyWwv6SagXE8rWenRtp+Hm79q6sZqMbbBxRJ1jbAaeN6Z3NXXEz35ozg1dNmOjI+RsHGm69Ck2y/mdRM8Cxe/XXbAIySoR9c+jWAI7E24yVl6BjRzsgYT/eIaWe49S/+xVULwYhz/09smw0TkUKV6G7zlB90ZXtdTI9Ti1pdyGm2W8+DXh6CyvPVGcLN4g9PiU5eiZ+gssmOpYqPGFNNj/41D6jS2HdNTWeJRFRPAh9SfXet5kcd6PmHrss9+R2uIw==
Received: from BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31) by
 SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 12:33:27 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::fd) by BL0PR01CA0018.outlook.office365.com
 (2603:10b6:208:71::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 12:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:33:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:33:18 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 04:33:18 -0800
Received: from host-10-63-191-31.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 04:33:17 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, <wangyanan55@huawei.com>, <alex.williamson@redhat.com>,
 <pbonzini@redhat.com>, <clg@redhat.com>, <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>, <ani@anisinha.ca>, <berrange@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <mst@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <david@redhat.com>,
 <gshan@redhat.com>, <Jonathan.Cameron@huawei.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <dnigam@nvidia.com>, <udhoke@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH v8 1/2] qom: new object to associate device to NUMA node
Date: Wed, 6 Mar 2024 12:33:16 +0000
Message-ID: <20240306123317.4691-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306123317.4691-1-ankita@nvidia.com>
References: <20240306123317.4691-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: f76e47e7-3d8b-4572-ea25-08dc3dd99f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3zJSor2ciRm5ccwidnEgHRjpmco9u7QxBHU16swxqB4cXrnR/oB+lLlEX7S6xDFAppRpXkVFC7QDlrz34XgIQQrAnJWK48SB9EYqejtpsUlpozygufwqO5ZbDi2X0rU5ie4VVwrMwKeOom/MQ8Rgqo/QA6YyZ2bMjVt50Gp2LN3B9uVlGns5+52DRAvJUZyAHtmsVbUBNVF4Wx4LGZScuYcNvVHazk9GkN2KvFYA1Twt8PSEcjA4SBg0fg+EIT2pgZVN9WnfnaAGOODsAwmUiZXXbo8j7Ri5tVQaBzE99ViXGpymEuuxX659eMxeuCtFqZGupQW0y0cx/3SIWTG9tgX02VjmKpA82TvZXIXvfRyN8kVcD4sv43mQQe/RDIWJASlwzZGVPTxP513EthMrC41//gix454Cwyw1HHYH4F3KOvlfqnpeWnBBRcQbQaUJ+jZWWUlFkzSXFvZefnzGR6g6QkbCIok2EPlelxsXH/kX7K43P+oZBSDXiOV77wgpLNqscy2l/cy7EvjRfDYJOp5EZ+3PlfZfq3paa8eXElWxeA+8iYX6Si72+7NTp16mfx1axz1xSelMAYQtH7Jvup4ipwF7nBmsNceDHDrjZTtqx3irbc1SxalDaC90Avso33svvDCXqTLUmpURubKeJ9Sac29lO05leJr+GVw0GRA7fZZog/NnmzNIuDCHxEN/tNGBOPQYlJYskwGEauPfAct7WQv2yEEvsLLIupNxMxeUaXs6e+x0R3tF3HN8ciRN8nTqyu4gtouwDXHRkyD3g==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(921011); DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:33:26.5021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76e47e7-3d8b-4572-ea25-08dc3dd99f23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
Received-SPF: softfail client-ip=2a01:111:f403:2417::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

When multiple NUMA nodes are associated with a device, it is required to
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
to the desired NUMA node (using the node argument). Currently, only PCI
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

Link: https://www.nvidia.com/en-in/technologies/multi-instance-gpu [1]
Cc: Jonathan Cameron <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi_generic_initiator.c         | 73 ++++++++++++++++++++++++
 hw/acpi/hmat.c                           |  2 +-
 hw/acpi/meson.build                      |  1 +
 hw/core/numa.c                           |  3 +-
 include/hw/acpi/acpi_generic_initiator.h | 32 +++++++++++
 include/sysemu/numa.h                    |  1 +
 qapi/qom.json                            | 17 ++++++
 7 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 hw/acpi/acpi_generic_initiator.c
 create mode 100644 include/hw/acpi/acpi_generic_initiator.h

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
new file mode 100644
index 0000000000..f57b3c8984
--- /dev/null
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi_generic_initiator.h"
+#include "hw/boards.h"
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
+    MachineState *ms = MACHINE(qdev_get_machine());
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
+    ms->numa_state->nodes[gi->node].has_gi = true;
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_initiator_set_pci_device);
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_initiator_set_node, NULL, NULL);
+}
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3042d223c8..2242981e18 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -214,7 +214,7 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
     }
 
     for (i = 0; i < numa_state->num_nodes; i++) {
-        if (numa_state->nodes[i].has_cpu) {
+        if (numa_state->nodes[i].has_cpu || numa_state->nodes[i].has_gi) {
             initiator_list[num_initiator++] = i;
         }
     }
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fc1b952379..1424046164 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,5 +1,6 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
+  'acpi_generic_initiator.c',
   'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
diff --git a/hw/core/numa.c b/hw/core/numa.c
index f08956ddb0..58a32f1564 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -229,7 +229,8 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
                    node->target, numa_state->num_nodes);
         return;
     }
-    if (!numa_info[node->initiator].has_cpu) {
+    if (!numa_info[node->initiator].has_cpu &&
+        !numa_info[node->initiator].has_gi) {
         error_setg(errp, "Invalid initiator=%d, it isn't an "
                    "initiator proximity domain", node->initiator);
         return;
diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
new file mode 100644
index 0000000000..23d0b591c6
--- /dev/null
+++ b/include/hw/acpi/acpi_generic_initiator.h
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
+    ObjectClass parent_class;
+} AcpiGenericInitiatorClass;
+
+#endif
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 4173ef2afa..825cfe86bc 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -41,6 +41,7 @@ struct NodeInfo {
     struct HostMemoryBackend *node_memdev;
     bool present;
     bool has_cpu;
+    bool has_gi;
     uint8_t lb_info_provided;
     uint16_t initiator;
     uint8_t distance[MAX_NODES];
diff --git a/qapi/qom.json b/qapi/qom.json
index c53ef978ff..81727310b1 100644
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
+# @node: NUMA node associated with the PCI device
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


