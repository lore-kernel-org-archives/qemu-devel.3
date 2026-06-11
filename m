Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F45CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXcJg-0001kj-7A; Thu, 11 Jun 2026 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJa-0001ge-ME
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:10 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJY-0006zx-1n
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vq4J2eWVFbTWon6A9KY1HRCdRUKCb5Q/efgDqwe46pZdOlLLUmvSQOEpHcGRdmdWiTJ0oUcL08kxImJsON7mNAsqseOmQAL0U9ayHcCXIj5ps2ayPwfeQ1KInK55IWy8qVr23+05+nWaQkEcn7Zq4K52RHup8ES7BzFFFsB4uX8TR4dPjEHy94v/bCfIhNpz+a74B1GjmJL0+WDoNYZAXNphK8VGlpKvRVXFuZ6POD7WQEkH5NQzRUpP0eRry7NqEH9GcAVRr5kLPjJFQDKdvfvLoEeJCNc2CygfhWadWGbpOirnyw/59aF4uJhNfwDpJnAny+w/4VAYZsX42u50qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K453U82JZV4zO9LexDUGY0+vNplzTuYqsUtWbK/dT0=;
 b=YzXkB17LDMtEWaLL7//97yqYjIK+Y68VqJwqywkKCg3fbevZniFlxOJqgeBe7oDHvd7yjzwWfj8N/1nEs7WpirwaVZagM16peTSKwyCsCvX2U6AlvUaQxqn9H/SIvErT78HhlHZx6V0bmui7o/TQ+eMD/G2u1ddLmMxC2yFl6IewgHWyIAiVhvLzoFl7e4LvY8CfLtHVWBSlrZ78dlMATkZCYr+Jcju1trHgTXIoNrqRvp/9VlwbyntLe5ZDKm+QzU1FnGKJifE7XhM6Yz1kHJx95WUgbv1bbwemSeEfYwueZjXGanX2HO8irlcPpvSbLziVKoqDqRWUX4BCpRViSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K453U82JZV4zO9LexDUGY0+vNplzTuYqsUtWbK/dT0=;
 b=Fg9dgWPzLpPlmAGeHHnjfGwQPfQ5vM5Q2L5UHnDEpg0jNGPqORU+Va+/abAaKkAlsxkBDZUCWcalqzkYYgHnw9EB//zG5BsvwarkFiUwcxHBf5Daljxet07bfnpK90HxviMcDGz4jbNcymGB6fS7PuJTjP13rJ93QZZfblK4Prc=
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:07:00 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::3d) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 10:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 10:07:00 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 05:06:57 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v11 1/4] hw/mem: add sp-mem device for Specific Purpose Memory
Date: Thu, 11 Jun 2026 18:06:34 +0800
Message-ID: <20260611100637.2460507-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
References: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbc005a-e9aa-4e8a-a49c-08dec7a12dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|11063799006|56012099006|18002099003|22082099003|43062017;
X-Microsoft-Antispam-Message-Info: 7yTcG0M0bzCGw/Z1FMI1DfL3v3LgzaeK/YcdO+Um4GQnpyPeJSZIwa8Clu96qNEm/9qEiuNxyvwGf+QjHmG5g4ZcGw25xuVNRI1eVqo38Zb4Wz9Crp8CvMvJ/131Q5WshMfYicE5LQP0dGZUE9vG6Te7Ey3H1044SRlOWGW0VzBVxe1swKA0h7LsF7N8jjadGVnR64oiQ2JhvuZWkfsLr9wRoz5AJE+fYL0uvP9OXiAahCojE3Mhpvf8/mgyGmsSh25aISjigjHsWrGMEllDCWHG2J8nLducDvvbbVfc8+WSwWmYdctStAPftWHbXGFFfYuNevDpNd/+7vYVp44dWMVx1AQxab0s/5qDoQRNMXGk/SQjokwF06ADkawD7qhhmKu8AC8U7Ygg5r25hU16wUvp8+JAw2h9vW/S6fAITh2i69mZT9jd3wXNxxU3OK4BE/EV6AgkEb0SESLiuuem2bgy2HcGMRi6i3lFGCbj1wBfBf5+oFVYdLkgNa+kG7XO4X5G/LDeL5N6XTbbcKBj+UqPLheDH/FJvKGIcpNqYT0kU5LCEbQtpw+7p8z1KwFSDPrWs/ieO39q2YBf6DvVvfxz3FvxQwlku5bAnw3u/DITpBL6jSK1LDC3IvA19YCX3JJc9w7VxG9AqrA4UyWWtmSsD4hu4XX3a9LJDwapA1hA74Jci8o0h4QhkEL25OvEEwEEAopU8Itex8ZZGJNCaNGjICwpSWxS9O9VZN+MxfK0BYKx02v9urOb0uizDO4WNDF3b2wqMkGtVNkwpGHTkv4Jw26WUonzE25hn43skX8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5pVQT9v/4Cx96R7Uf1oSfYw+Vs5KruFTwjrJz6iCQ2asZSHNxlx5XxGPiWrycLY57wejIXfrQ+IhP78HypTQ+32IFFCN0ABbJ1dNkS+J1X9FnQVnz5ACmgW+c30bRACo/pU4Dd8ysgpLLlE7BzdlUz0bEZXMnF30n6teaRajjdIukArFUrZUAqX2iMguTgAmazRvLKLW/sbyhpwYchCvljcFlwcoCcIW838+7WbUZlnXiJw9mXaet2B19xgTaBNTTviWzeie0/qVtau4REUacPekKeCw8yyU6ynZghkvcdqaPslPlTDByEir0DqDAzrdQZgVso+fKYYac9SNQSHatGfJjJaC+VPWDK7fUeKMkm44qbjYEc8Le+BmQJ2yv4BOsnoU7u/tZE2tHvmHoWtCpLXy++bLNTzX7Gbo83AG/JQ6Sng37OfRNwgRPGUZu0y+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:07:00.2680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbc005a-e9aa-4e8a-a49c-08dec7a12dab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=FangSheng.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 include/hw/mem/sp-mem.h    |  35 ++++++++++
 hw/core/machine-hmp-cmds.c |  11 +++
 hw/mem/sp-mem.c            | 136 +++++++++++++++++++++++++++++++++++++
 hw/mem/Kconfig             |   4 ++
 hw/mem/meson.build         |   1 +
 6 files changed, 228 insertions(+), 2 deletions(-)
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
index 0000000000..5c0b6ec4f8
--- /dev/null
+++ b/include/hw/mem/sp-mem.h
@@ -0,0 +1,35 @@
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
+#include "hw/mem/memory-device.h"
+#include "hw/core/qdev.h"
+#include "qom/object.h"
+#include "system/hostmem.h"
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
index 0000000000..d0244a8f70
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
+        error_setg(errp, "'memdev' property must be set");
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
+/* boot-time only; no plug/unplug state to migrate */
+static const VMStateDescription vmstate_sp_mem = {
+    .name = TYPE_SP_MEM,
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


