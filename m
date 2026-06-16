Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5944CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPmp-0002JR-FI; Tue, 16 Jun 2026 05:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPmn-0002Iy-FE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:08:45 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPmk-0004O1-NV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dS8sL8+hHxqGUkLGA/ObZ54BYhdAWbLtgTzAlB/oPz1tAV4dQaN1eKkqZmxcNJ5ftr4BSFYVdopmWj41WeFnaOLUA78S2z3uB3JdycI5sfxxhPhFzsrbQGSfVLFor4CMohEcrsQ0FTNE40grk9MICGWqD+/RubwcFXcgBDNQKzQGha/9xNd2jz1waIJlne6jDqj1R0vxvYvD/v5UT/rnRkjJmtYB1fAaGp9iXd2MAFITGEm6IMrdD8+N3DrkxlnlNDJzEJc9qZL5iOxvIxJMV2G7VwzlH7vvf5/5xuDBX0ZfLmu4CjfIvPipaN0zEXSYlci/Bql/J1PBOlZ0+9uhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF1CcG6m0SEEkGPYfX0jhMBdhEke1TMSrqlpHrhl7yo=;
 b=v73DrPHlRwUowVtRiPU99zLMeE8JwyVM45W4wnwme+A200RiCzazPtqoFQFHmZRC/3m/ll0BZokiimo3Dfz51WZPZRPYTlAnoGwRPXHbI/jdol9o1llW65zp9y3euRjcfJDtaII6+1q2iIBXf7eHMhqTrtopWMl+lK8d5FExee1U2RhYH0IHqCQzJv0MB91wWk+iXfjc/v0YrQcmqMOmaDur6lWbcVPF8G8P27rRpAqn2yp6Zw9/o5RzZlLiWQwQwBPCiYPRYUjNBpeMRE7Cd/4rY/fSf4ybHQ59FLssD2ow8pDG9mEmehiXfCnFw+B7qHgW4IfyvVwZdrFEB2bf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF1CcG6m0SEEkGPYfX0jhMBdhEke1TMSrqlpHrhl7yo=;
 b=fjmghyGh3kxX+QxU1+tYaowsi7EVhBK8BinYkutn/zIQRS16mB0Nnq7Sk4DLNh4VLAeg88DRVJh2LAdkgv16eKmS85RDOqpu8M/DST/Rd5q1W1VyOyw7Q3Rp3CB7kaQI69Kuh/mD+r0nqv492unGIxdoKo7f01zNTTwoRcLJnMY=
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:08:35 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::8d) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:08:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:08:34 -0500
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 02:08:32 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v12 1/4] hw/mem: add sp-mem device for Specific Purpose Memory
Date: Tue, 16 Jun 2026 17:08:05 +0800
Message-ID: <20260616090808.3047939-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
References: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ea4e22-57d5-42e5-377b-08decb86d85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|11063799006|56012099006|6133799003|43062017;
X-Microsoft-Antispam-Message-Info: DSquOvaRy/gx9h/2kaA4oayfzHvhKDFeWohtRyaO2o6pxiuuETMIpNiimxhMMDAbWMBO5tlHF5J4vdm2cFE/R3mMSqwFkZXNMOhXII7NDYyOY7xbYjqQaBwDFwZ/hRSy7atgC8rQgynDDVLpsJbiIuX5Z/Adj46rUSBMo8UImgaaI2LqJby4ixOtEctFQ3L9C7y9qLy1KrMc+ZX8VR0VPjFbzNCGvP2H7j3EAP72oqLaE6M+oBP4zvEheHRhfBNlPScYWNyhFhUhm2MexJsf4DZChGySQ7lhz5/27K/jOTmo/vgE6IDub+/m8qMJGUsfYueCYmksyck88lxlMamP2a3Er6gCfc1chG9PoNI7JG1SAtFLq8WkvOA23k9oA8lq62WRDSAm50aOzoHumtPe50OiWj7TrM6+F09xlEjJ5MB80XNHHhojMjU6t3ez09fkIkXiN/ddeJU7aI3AY1tZdHGttAf38z+WqP3SKkTk/OARVsKpVQkeW2v6grRr+XX3PWD3rzcS1zdqCMtJlDr/6D0lxOFgyHFgjDhv2JMBSQYhYztQx/+M+hTPjyKwx7VHSJ6NEHblD+ZA7TMA/5rzBPSoXRszD24T9vjOYDk6yWZqJKXrLaLlc5O0lyr/RwML9l3HpJ+Nh5Mcb21Qsa1oMmBxMFnrVB7g/mSulhGqRnHPGStmSKMwe61MfYu8mikzEKuXP4qD3XU0FRvntMTdGeB7//gJBsOFalYxtRRSuvgzO2Hz3XD/gunQ8yj1fvd/es+yuYURUDw54/GsVShCJa2n7glFisU/IQQB3IonH1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i/ue76foo5y1Oc2ncUENcZiaqkeC0FG/l6o1JPhsNkhJACQcTwRz6WYF8F+wv7sbcIg5PWjgYquZ/rBpGHd7E+czMBtvz46o3+9neSAV3zdzDsikLJr2nHYpff+kH8E9jKbdoO3T8aogOah07YVDLAb0djoE+BpXw1HPS+F5oKzAvV1uhDtDqFnFVqufMwgUbsjUlvBtXm6+d15OekmeD6X2rkEx76kWBSYhgprB4V/z1Cb6kwyRXSUGBYvnLz7fziTBun779+em+b6KpmpC6mFR9hYFSGhs0YRIOr3hQa+F1JaXX9x44IAO/QFnlCQEM//yv0dNIziRPBLLFJ4j5925mH0K01/t1eGFjHRXiQ2ed6XI3XTW2v4vGdmvC4LNIo022Ut5MiGcY/9Flg2zSj19DbXNC4rMvy7V47jmAP1wqfV43Ebtq5e8fAy7zL1H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:08:34.8716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ea4e22-57d5-42e5-377b-08decb86d85b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=FangSheng.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
SOFT_RESERVED memory exposed to the guest with a per-device NUMA
proximity domain.

The device targets accelerator memory (HBM and similar) that the
firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
in the guest -- rather than the kernel's general allocator -- owns
the range.

Usage:

    -object memory-backend-ram,id=spm0,size=$SIZE
    -numa node,nodeid=$N
    -device sp-mem,id=dev0,memdev=spm0,node=$N[,addr=$GPA]

The device is boot-time only (no hotplug).

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 qapi/machine.json          |  43 +++++++++++-
 include/hw/mem/sp-mem.h    |  33 +++++++++
 hw/core/machine-hmp-cmds.c |  11 +++
 hw/mem/sp-mem.c            | 136 +++++++++++++++++++++++++++++++++++++
 hw/mem/Kconfig             |   4 ++
 hw/mem/meson.build         |   1 +
 6 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/mem/sp-mem.c

diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b8..777cfc81e1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1413,6 +1413,32 @@
           }
 }
 
+##
+# @SpMemDeviceInfo:
+#
+# sp-mem device state information
+#
+# @id: device's ID
+#
+# @addr: physical address, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @node: NUMA proximity domain to which the device is assigned
+#
+# @memdev: memory backend linked with device
+#
+# Since: 11.1
+##
+{ 'struct': 'SpMemDeviceInfo',
+  'data': { '*id': 'str',
+            'addr': 'size',
+            'size': 'size',
+            'node': 'int',
+            'memdev': 'str'
+          }
+}
+
 ##
 # @MemoryDeviceInfoKind:
 #
@@ -1426,11 +1452,13 @@
 #
 # @hv-balloon: since 8.2.
 #
+# @sp-mem: since 11.1.
+#
 # Since: 2.1
 ##
 { 'enum': 'MemoryDeviceInfoKind',
   'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
-            'hv-balloon' ] }
+            'hv-balloon', 'sp-mem' ] }
 
 ##
 # @PCDIMMDeviceInfoWrapper:
@@ -1482,6 +1510,16 @@
 { 'struct': 'HvBalloonDeviceInfoWrapper',
   'data': { 'data': 'HvBalloonDeviceInfo' } }
 
+##
+# @SpMemDeviceInfoWrapper:
+#
+# @data: sp-mem device state information
+#
+# Since: 11.1
+##
+{ 'struct': 'SpMemDeviceInfoWrapper',
+  'data': { 'data': 'SpMemDeviceInfo' } }
+
 ##
 # @MemoryDeviceInfo:
 #
@@ -1499,7 +1537,8 @@
             'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
             'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
             'sgx-epc': 'SgxEPCDeviceInfoWrapper',
-            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
+            'hv-balloon': 'HvBalloonDeviceInfoWrapper',
+            'sp-mem': 'SpMemDeviceInfoWrapper'
           }
 }
 
diff --git a/include/hw/mem/sp-mem.h b/include/hw/mem/sp-mem.h
new file mode 100644
index 0000000000..a8951b49e6
--- /dev/null
+++ b/include/hw/mem/sp-mem.h
@@ -0,0 +1,33 @@
+/*
+ * Specific Purpose Memory (SPM) device
+ *
+ * TYPE_MEMORY_DEVICE subclass for boot-time-only memory exposed to the
+ * guest as an E820 SOFT_RESERVED range with a SRAT memory-affinity entry.
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * Authors:
+ *  FangSheng Huang <FangSheng.Huang@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_SP_MEM_H
+#define QEMU_SP_MEM_H
+
+#include "hw/core/qdev.h"
+#include "qom/object.h"
+
+#define TYPE_SP_MEM "sp-mem"
+
+OBJECT_DECLARE_SIMPLE_TYPE(SpMemDevice, SP_MEM)
+
+struct SpMemDevice {
+    DeviceState parent_obj;
+
+    HostMemoryBackend *hostmem;
+    uint32_t node;
+    uint64_t addr;
+};
+
+#endif /* QEMU_SP_MEM_H */
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 46846f741a..686304bafa 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -279,6 +279,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     PCDIMMDeviceInfo *di;
     SgxEPCDeviceInfo *se;
     HvBalloonDeviceInfo *hi;
+    SpMemDeviceInfo *spmi;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
@@ -350,6 +351,16 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                     monitor_printf(mon, "  memdev: %s\n", hi->memdev);
                 }
                 break;
+            case MEMORY_DEVICE_INFO_KIND_SP_MEM:
+                spmi = value->u.sp_mem.data;
+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
+                               MemoryDeviceInfoKind_str(value->type),
+                               spmi->id ? spmi->id : "");
+                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", spmi->addr);
+                monitor_printf(mon, "  node: %" PRId64 "\n", spmi->node);
+                monitor_printf(mon, "  size: %" PRIu64 "\n", spmi->size);
+                monitor_printf(mon, "  memdev: %s\n", spmi->memdev);
+                break;
             default:
                 g_assert_not_reached();
             }
diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
new file mode 100644
index 0000000000..3b46cabc46
--- /dev/null
+++ b/hw/mem/sp-mem.c
@@ -0,0 +1,136 @@
+/*
+ * Specific Purpose Memory (SPM) device
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * Authors:
+ *  FangSheng Huang <FangSheng.Huang@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev.h"
+#include "hw/mem/sp-mem.h"
+#include "hw/mem/memory-device.h"
+#include "migration/vmstate.h"
+#include "system/hostmem.h"
+
+#define SP_MEM_MEMDEV_PROP    "memdev"
+#define SP_MEM_NODE_PROP      "node"
+#define SP_MEM_ADDR_PROP      "addr"
+
+static const Property sp_mem_properties[] = {
+    DEFINE_PROP_LINK(SP_MEM_MEMDEV_PROP, SpMemDevice, hostmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_UINT32(SP_MEM_NODE_PROP, SpMemDevice, node, 0),
+    DEFINE_PROP_UINT64(SP_MEM_ADDR_PROP, SpMemDevice, addr, 0),
+};
+
+static uint64_t sp_mem_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), SP_MEM_ADDR_PROP,
+                                    &error_abort);
+}
+
+static void sp_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
+                            Error **errp)
+{
+    object_property_set_uint(OBJECT(md), SP_MEM_ADDR_PROP, addr, errp);
+}
+
+static MemoryRegion *sp_mem_get_memory_region(MemoryDeviceState *md,
+                                              Error **errp)
+{
+    SpMemDevice *spm = SP_MEM(md);
+
+    if (!spm->hostmem) {
+        error_setg(errp, "'%s' property must be set", SP_MEM_MEMDEV_PROP);
+        return NULL;
+    }
+    return host_memory_backend_get_memory(spm->hostmem);
+}
+
+static void sp_mem_fill_device_info(const MemoryDeviceState *md,
+                                    MemoryDeviceInfo *info)
+{
+    SpMemDeviceInfo *di = g_new0(SpMemDeviceInfo, 1);
+    SpMemDevice *spm = SP_MEM(md);
+    DeviceState *dev = DEVICE(md);
+
+    di->id = dev->id ? g_strdup(dev->id) : NULL;
+    di->addr = spm->addr;
+    di->size = memory_region_size(
+                   host_memory_backend_get_memory(spm->hostmem));
+    di->node = spm->node;
+    di->memdev = object_get_canonical_path(OBJECT(spm->hostmem));
+
+    info->u.sp_mem.data = di;
+    info->type = MEMORY_DEVICE_INFO_KIND_SP_MEM;
+}
+
+static void sp_mem_realize(DeviceState *dev, Error **errp)
+{
+    SpMemDevice *spm = SP_MEM(dev);
+
+    if (!spm->hostmem) {
+        error_setg(errp, "'%s' property is required", SP_MEM_MEMDEV_PROP);
+        return;
+    }
+    if (host_memory_backend_is_mapped(spm->hostmem)) {
+        error_setg(errp, "memory backend '%s' is already in use",
+                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
+        return;
+    }
+    host_memory_backend_set_mapped(spm->hostmem, true);
+}
+
+static void sp_mem_unrealize(DeviceState *dev)
+{
+    SpMemDevice *spm = SP_MEM(dev);
+
+    host_memory_backend_set_mapped(spm->hostmem, false);
+}
+
+static const VMStateDescription vmstate_sp_mem = {
+    .name = TYPE_SP_MEM,
+    /* boot-time only; no plug/unplug state to migrate */
+    .unmigratable = 1,
+};
+
+static void sp_mem_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
+
+    dc->desc = "SPM (Specific Purpose Memory) device";
+    dc->hotpluggable = false;
+    dc->realize = sp_mem_realize;
+    dc->unrealize = sp_mem_unrealize;
+    dc->vmsd = &vmstate_sp_mem;
+    device_class_set_props(dc, sp_mem_properties);
+
+    mdc->get_addr            = sp_mem_get_addr;
+    mdc->set_addr            = sp_mem_set_addr;
+    mdc->get_memory_region   = sp_mem_get_memory_region;
+    mdc->get_plugged_size    = memory_device_get_region_size;
+    mdc->fill_device_info    = sp_mem_fill_device_info;
+}
+
+static const TypeInfo sp_mem_types[] = {
+    {
+        .name          = TYPE_SP_MEM,
+        .parent        = TYPE_DEVICE,
+        .class_init    = sp_mem_class_init,
+        .instance_size = sizeof(SpMemDevice),
+        .interfaces    = (InterfaceInfo[]) {
+            { TYPE_MEMORY_DEVICE },
+            { }
+        },
+    },
+};
+
+DEFINE_TYPES(sp_mem_types)
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 73c5ae8ad9..39ddb36710 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -16,3 +16,7 @@ config CXL_MEM_DEVICE
     bool
     default y if CXL
     select MEM_DEVICE
+
+config SP_MEM
+    bool
+    select MEM_DEVICE
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 8c2beeb7d4..f410d75475 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
+mem_ss.add(when: 'CONFIG_SP_MEM', if_true: files('sp-mem.c'))
 stub_ss.add(files('cxl_type3_stubs.c'))
 
 stub_ss.add(files('memory-device-stubs.c'))
-- 
2.34.1


