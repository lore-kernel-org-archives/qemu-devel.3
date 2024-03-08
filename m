Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C691C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribdl-0002zE-Po; Fri, 08 Mar 2024 09:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ribdV-0002qL-No; Fri, 08 Mar 2024 09:55:52 -0500
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ribdT-0005GL-E9; Fri, 08 Mar 2024 09:55:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVHd72ioXeZyLYa2wT4NSHwEFMOqubdlSz5n3nkaklNUzHX0RFL/XEYQdCcYpzdfFot+HIKTJst0FavkMedfju82hBdlQn0glqZyxKkGfx+7bDSjNnytmownk4IQvhJgmVtLQp4FY96wm6ergEIE67hLP5WmDHKPGjnS+FobVJqLjDV6IjWp4hvqjgPZznj3gNzbr2FhUQCh+bNqwMd0ug3jPB2sgBWMqi/oJbGNytdlhRD7GVtJsUISI6q2JhtUJ36KyH/bg7TAp9jSrv0syQEKHpY4XQdpd+jff+xETA8gJrxqFfoWiVwtxs2QdwASyDG++v74onYpCvTY45l1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGmgSxq6TNQBYjYu+WNFcbEr7nGnqIQQnoVPHZz6jIg=;
 b=aAOtquiK+sSVgC5xa2AciD28JVb1dIRTF2RfF6zppfmapnptIWFgLaWe6C63EzTPSlY37tiwalRYacttXmY7YA4gpIOOyo8GLhEaygD5ygvsmk5kXiuvBgbhbZIWQhs9WQw+QUqaXKQQ7T0cuaNl+qEDzSRN4KKja4sFQjgWWviCXb6NlFanwoeon//a9VyK7y4wY3oX7aCoBpfMAJNSRBismycHVId8tlEA0UUNppj2qzHtwo6k8e/Nf+2HaMA4h/1Ewux7bVb+q/6XYADbMJNskw/iQfGzK8wE4VKp8XWP/VkHBfQ4iYE16LLcQAMku6um2nXSqz59lCOaXOKeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGmgSxq6TNQBYjYu+WNFcbEr7nGnqIQQnoVPHZz6jIg=;
 b=udCzSrl1VO6IBzMjHf4XYoIyJZwlYyWpVXtuy6XZh8+aZHTj/WOYxpPdOdpR/7LwMns21+Fl3j3BLmfC8ejiY67lDTiWt+hNA3eau3PDfXOvH4eKiOFpMOL87SumGhiDQ+tgboDye1+obLNgfU78HR6GiQZTDYPBJ4Pk65p0LJ7v9fwi2Y3bPHQrWcFt3iZcr5TBFy7ZlJfN9Owel1AyZxEvwzMpjI0zWbJPm+Jy4v7O+20ll9imxmeCV8yXX5Vwu0pWbL6a7TBLyUTOIn+ur3um3BzcEfvOZaPEY4EnrXJG9748uCOgJFws+yX5PGqS14Q6XtvKE8jKJwYxT1Unfw==
Received: from MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24) by
 IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 14:55:40 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:907:0:cafe::2b) by MW2PR16CA0011.outlook.office365.com
 (2603:10b6:907::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40 via Frontend
 Transport; Fri, 8 Mar 2024 14:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 14:55:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 06:55:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 8 Mar 2024 06:55:26 -0800
Received: from host-10-63-191-31.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 8 Mar 2024 06:55:26 -0800
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
 <mochs@nvidia.com>, <dnigam@nvidia.com>, <udhoke@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v9 2/3] hw/acpi: Implement the SRAT GI affinity structure
Date: Fri, 8 Mar 2024 14:55:24 +0000
Message-ID: <20240308145525.10886-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308145525.10886-1-ankita@nvidia.com>
References: <20240308145525.10886-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: a67b0b2b-7ca0-4679-19ea-08dc3f7fd230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDeQ3cKhydEuhYMejZg7+eAqEeadcIZmjNZFfj3q+OXq6CmRk/PbX8eBa8HZV2SeQrXJCfOrkCAR6e1ehRGmZdta73GxXxvr7DZsKKQpMuO90eVWN3TJW2dPEgodEwPDucJPI+5rN9JZpmSczoRcSQ33Sl5CbxWNy01btI3xt5U+eur5D82KRpajQT6gtY6Hj05gTmnln2AA2CqhlikPQ2YiiIsXveoz4zhvAUMO8CxVoRPH4NuBoRdrGKCqdSFsRITW1ngKwOOFcherhhS1/T8W6j2b1Z/ct/JVfMg9s+1V+FAnl9+NtViH18eJTE5itcsobGUKkFC3zfjw2sXrW/A1PyUcgIVWLHnmcZeI1LN51OU3whJzY300aWosbp13A6+3O9f7BMbDzSYNVLvpT+QsJDXL6owW3aIglY0KdQ2lJakX6NuUsxzVWUhBcemRV9AoMAB6oYdffIlmyolg16L0OciiBP4FkEPUz8D/zkfRyBmUW2B+kJmzwIg1d9NxnJWEiujI1A2CGmAu+mB/b3tF8itOEfhQqC1YeONWSQt4HhiMYK2D+6xY5HKgj5LF9baqgvEFQ1x+v4aBnB3KIMJW+vx6sPwDzUN3iEWGOFkWnt0ZMrnHxtrXHApENQaumhLnaeXvS+dNLPngnRm/wThaL73a94pFrkk8lDPSk9DdzDMWkDGpgobFTcOyOix7q2eDYOk21iL0HLQpKyMf3uVQO5eGbkkohVvglXwp8SqWsvP9/0tEb9jStJmNM4Xcdr9xlak9DPHUOYM72wBTwg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005)(7416005)(921011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:55:39.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67b0b2b-7ca0-4679-19ea-08dc3f7fd230
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi_generic_initiator.c         | 77 ++++++++++++++++++++++++
 hw/acpi/hmat.c                           |  2 +-
 hw/arm/virt-acpi-build.c                 |  3 +
 hw/core/numa.c                           |  3 +-
 include/hw/acpi/acpi_generic_initiator.h | 25 ++++++++
 include/sysemu/numa.h                    |  1 +
 6 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 130d6ae8c1..17b9a052f5 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -5,7 +5,9 @@
 
 #include "qemu/osdep.h"
 #include "hw/acpi/acpi_generic_initiator.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/boards.h"
+#include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
 typedef struct AcpiGenericInitiatorClass {
@@ -47,6 +49,7 @@ static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
                                             Error **errp)
 {
     AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    MachineState *ms = MACHINE(qdev_get_machine());
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, errp)) {
@@ -60,6 +63,7 @@ static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
     }
 
     gi->node = value;
+    ms->numa_state->nodes[gi->node].has_gi = true;
 }
 
 static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
@@ -69,3 +73,76 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
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
index 16de1d3d80..a304bad73e 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -19,4 +19,29 @@ typedef struct AcpiGenericInitiator {
     uint16_t node;
 } AcpiGenericInitiator;
 
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
-- 
2.34.1


