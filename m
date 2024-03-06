Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B117C54E55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 12:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqSr-0007kb-5O; Wed, 06 Mar 2024 07:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhqSp-0007js-6m; Wed, 06 Mar 2024 07:33:39 -0500
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhqSl-0002uO-RC; Wed, 06 Mar 2024 07:33:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMt2gBkKTsTWdh580xONArn4Dl6uYYqw8ow+CFeHg3HFtOEkGRmyDQeuu1Pwi7k20KjLrissvgjXBnYXKn8lw/UXGuOwJrQ5x3KKC/mZ92XYN4O29Bkmy4ZgH7/ub11kRt9NHZCZZy18c0KfKEXliMF78C59/E95raB0wnF9MBhS0qa3MSizIjPBpc9r1MJBteLRqy5FbECn1Gap82laIRXRm/kzqvI/ykfmQD19ENE42y+9zXDDPuBaSEoa8Xe6Iv5BwgE49rQLwsba+vo/yMALGbJ4XybH6Z1lh15AnkVqPh0xxNSraWbq82vt3WYGL71s2r2m30njYIrUymY9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEL1vtLpI25aT5cjVy9lYU91m2CGz2cI2c775BXZpBk=;
 b=YUiRVZmJQQLJ/8zwtq9QRTgXrRXoZvFiLUKP/UkMa2to7+U2G4EsWnZd8q8soT2Ggpuu1c8bwqdAMIkiiIbvOIOsAwcSkHfvhMZD0pmsUabae0WWFbiif5QkGbMoYKNSFyTkyzU+bMVNYZOj0SunffDjoORPxhC/ImSeARPQCOSGgc+41lgbpCUfN4jIgQk4uBDfa/kaLhxsENSeguQlVcXq2bl8tJ4GOeNjHg6xPoewq0Re82CefuwjkP6W+3C12smemqRiio2axoQK47FoCwtIIWBa4zyO1AJy4om3iQGYNPQYjq2sy8XGeue3Lw3b9aDBFCxsKqY80UUpAJlBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEL1vtLpI25aT5cjVy9lYU91m2CGz2cI2c775BXZpBk=;
 b=DgC3OopQ6M0mqOuP4wuIynHJdzHIKNdJTVFDMh9bHSQFOBxIm+5SZsRy1KTM9TCoPwfKx2R6RE6o+soYeFjm72usplmEeoawav/KAwv2UD2ekA6tj5D/vr6KOk5Zeg7vVEeecbxIILJR4MRj/jmFc8BVOda0jMXEZJQSfOekGoHNIHaCrgdkCo99zTFde0c6eyzVv6NY/Nzc9RZFGBchJw9p8GZGJ8rF2JrI+GXc01kkLVPVyPUMgWpVWPaLefY4jnGoNKPy8tWLkzH4XjTQ1v48bFl1rSj2/5R26VC5C9yYKXsl5Chf5Sieetxg6fhvcp8/WOKltcyLBmPjrA8Ccg==
Received: from BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31) by
 DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Wed, 6 Mar 2024 12:33:29 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::90) by BL0PR01CA0018.outlook.office365.com
 (2603:10b6:208:71::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 12:33:28 +0000
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
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:33:28 +0000
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
 Transport; Wed, 6 Mar 2024 04:33:18 -0800
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
Subject: [PATCH v8 2/2] hw/acpi: Implement the SRAT GI affinity structure
Date: Wed, 6 Mar 2024 12:33:17 +0000
Message-ID: <20240306123317.4691-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306123317.4691-1-ankita@nvidia.com>
References: <20240306123317.4691-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 759d1b74-d9b6-49d1-3eb5-08dc3dd9a07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ERHUQeUXAp0ssXTWw6tQN1A/1dHXxjm+P9lMhnVXJMQaxTPML1N7Z0mrsXokOZMLD9VIdd90lejilGeYb7QSv8YwUttHvY/yx/pvExSfbaghHk+Uzn1ebElnjSoiQrU5Ujz9LNX1vcXser/MdLbRaxUiJsaAfQwim9CcFErLsLobBChh6dExthcjlID94DWB20qfUYHcn8fvRzWgsb/SXZwFpcRgD1g+CUQl7zmL/SA872TgHsYeJR1/vM0ZqXCz7rwxZ3Csgu/pp+zlFjXpK9zDVe9nO0zOtixvgT4oGvAjVQAoopS8Dg9J3/1c8YiC4L/sHitc5A+0ke+rIRt6TsprEtfpeu73cgh3ihXRsK/8lHXO+JN+mrsz/5Q8CBwza2ock15QNxHkmyRHBDiRbBN5F0OccZRm4+GtkUhh2AVBuETGAI9Y2RLB5sSKsl+1uXaYyJYKEpQlRiGK+JoQe1c8S8J0LyCGLbD9VmGQwHnyhxA0oj4mG34HkWLQm+zveBTNNRVrw75ndjjDZSNvqPhAIQ3F1fOkcOqPJDQ/0V1KDZakG7BWLdVtOfRZWb64oWu3UOvOksu3VUz3cO6J5YpnIVX7W6Rvq3gvTsgDHO1QcpV/LYDQFZioLcfRO28uGWuwzU/p31VqrdvmGL0q0oX+DPSZhPcDI+ITZPP8dAt88HCq0H6xsZnNY9brSnJGREAykl6m2MUkY7Xp70LF2ZXSfbxU1FFe9hiYahHXcl639N68tLrw25ox3o+LsQmYwXCxFUnF5tIc0e9gAyltQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(921011); DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:33:28.7365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759d1b74-d9b6-49d1-3eb5-08dc3dd9a07b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

ACPI spec provides a scheme to associate "Generic Initiators" [1]
(e.g. heterogeneous processors and accelerators, GPUs, and I/O devices with
integrated compute or DMA engines GPUs) with Proximity Domains. This is
achieved using Generic Initiator Affinity Structure in SRAT. During bootup,
Linux kernel parse the ACPI SRAT to determine the PXM ids and create a NUMA
node for each unique PXM ID encountered. Qemu currently do not implement
these structures while building SRAT.

Add GI structures while building VM ACPI SRAT. The association between
device and node are stored using acpi-generic-initiator object. Lookup
presence of all such objects and use them to build these structures.

The structure needs a PCI device handle [2] that consists of the device BDF.
The vfio-pci device corresponding to the acpi-generic-initiator object is
located to determine the BDF.

[1] ACPI Spec 6.3, Section 5.2.16.6
[2] ACPI Spec 6.3, Table 5.80

Cc: Jonathan Cameron <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cedric Le Goater <clg@redhat.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi_generic_initiator.c         | 73 ++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c                 |  3 +
 include/hw/acpi/acpi_generic_initiator.h | 25 ++++++++
 3 files changed, 101 insertions(+)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index f57b3c8984..5a7d15363e 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -71,3 +71,76 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
     object_class_property_add(oc, "node", "int", NULL,
         acpi_generic_initiator_set_node, NULL, NULL);
 }
+
+/*
+ * ACPI 6.3:
+ * Table 5-78 Generic Initiator Affinity Structure
+ */
+static void
+build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
+                                          PCIDeviceHandle *handle)
+{
+    uint8_t index;
+
+    build_append_int_noprefix(table_data, 5, 1);  /* Type */
+    build_append_int_noprefix(table_data, 32, 1); /* Length */
+    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
+    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
+    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
+
+    /* Device Handle - PCI */
+    build_append_int_noprefix(table_data, handle->segment, 2);
+    build_append_int_noprefix(table_data, handle->bdf, 2);
+    for (index = 0; index < 12; index++) {
+        build_append_int_noprefix(table_data, 0, 1);
+    }
+
+    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
+    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
+}
+
+static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    AcpiGenericInitiator *gi;
+    GArray *table_data = opaque;
+    PCIDeviceHandle dev_handle;
+    PCIDevice *pci_dev;
+    Object *o;
+
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        return 0;
+    }
+
+    gi = ACPI_GENERIC_INITIATOR(obj);
+    if (gi->node >= ms->numa_state->num_nodes) {
+        error_printf("%s: Specified node %d is invalid.\n",
+                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
+        exit(1);
+    }
+
+    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
+    if (!o) {
+        error_printf("%s: Specified device must be a PCI device.\n",
+                     TYPE_ACPI_GENERIC_INITIATOR);
+        exit(1);
+    }
+
+    pci_dev = PCI_DEVICE(o);
+
+    dev_handle.segment = 0;
+    dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
+                                               pci_dev->devfn);
+
+    build_srat_generic_pci_initiator_affinity(table_data,
+                                              gi->node, &dev_handle);
+
+    return 0;
+}
+
+void build_srat_generic_pci_initiator(GArray *table_data)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   build_all_acpi_generic_initiators,
+                                   table_data);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bc35a483c..a2b3a2eb25 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -58,6 +58,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
+#include "hw/acpi/acpi_generic_initiator.h"
 
 #define ARM_SPI_BASE 32
 
@@ -558,6 +559,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
+    build_srat_generic_pci_initiator(table_data);
+
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_srat(table_data);
     }
diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index 23d0b591c6..4bebe119ee 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -29,4 +29,29 @@ typedef struct AcpiGenericInitiatorClass {
     ObjectClass parent_class;
 } AcpiGenericInitiatorClass;
 
+/*
+ * ACPI 6.3:
+ * Table 5-81 Flags – Generic Initiator Affinity Structure
+ */
+typedef enum {
+    /*
+     * If clear, the OSPM ignores the contents of the Generic
+     * Initiator/Port Affinity Structure. This allows system firmware
+     * to populate the SRAT with a static number of structures, but only
+     * enable them as necessary.
+     */
+    GEN_AFFINITY_ENABLED = (1 << 0),
+} GenericAffinityFlags;
+
+/*
+ * ACPI 6.3:
+ * Table 5-80 Device Handle - PCI
+ */
+typedef struct PCIDeviceHandle {
+    uint16_t segment;
+    uint16_t bdf;
+} PCIDeviceHandle;
+
+void build_srat_generic_pci_initiator(GArray *table_data);
+
 #endif
-- 
2.34.1


