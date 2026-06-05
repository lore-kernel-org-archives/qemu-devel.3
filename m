Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A166FCD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVS4b-00028M-6n; Fri, 05 Jun 2026 06:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4Y-00027W-To
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:42 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4W-0004Ti-HA
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu86Bj5LxymJS5w8IYWAQMsv6dCy+bMnaNCR9tCCL0R9lSp551Y4zq91G0HxWPqvLj34DZDcgduGKDfFfKdSMrhbF9RHdoz8lG1zVnWITohPnRH7sCWFDWed+Hlt5odRZ/UBi0xUv9eyGlql7/2BKZFX/SmY/fUY0nYcJ4tp/YVSFIiEH69FZniABqakkhETjtfhaDezxstcZBYz58v8got7NIfTKPaPf9/x0MfQzXNfyRKIjRynhH57xdVrp7LsqPujuiljnW4frwvELFcx65iVzL7r6OkdRMSsxfK3QflUmnHQXwGMFm+7oIQ0hBg+I986lngJOiW+6WkhlzadEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozsTOAvXx4e7HGxaQk5y2RGCnZd/ViGM9GWOSiGQ+nE=;
 b=OcLE3sQNz2Ou6utwhp7FA8D3M5QK33e5SCf4ZpOfXMElIo49wsH4o9UK3Ys7lKSJHjwPPWIZhayTPIP7dBj3RGs8cOguaTVTtVIYUc6Ujla5wfVb6woqBsCbtg0EUX0jOkieq7+piobHPDm0sfoOn5o6eRebo9sjIf4uqoJf7aWNpKOg7hat6IYDN3448IZ822En7f8BK1q79oCYXoLWnF+V08fq+5xwZZlPg6g4ercXfeM9TXxS1Lfj99mFlLqSE6E550YiU+NV3zkPtvP5rDCHMvxiPt+bc2bteF2mirpJcbLX1Eq3yfCVo3Y8U/nbrtqIK6ehOa/WkuBb/mczhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozsTOAvXx4e7HGxaQk5y2RGCnZd/ViGM9GWOSiGQ+nE=;
 b=gSuNv0SJQjDtNUHD3zJv112w9KG7ntY3/fwgbj77So/oLOh0r2JiktvKSxav7PYBcyE290UHzFKBrY4C5ZTQWPAsO9/42oj+YjGtIPeJFa2ZfzRWvWx4cZUQ8vmbdQeeqw6MmARVqe2jX3kruXNNcw0KO3jPvXEX8ItbIUkPT/w=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:46:32 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::2f) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 10:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:46:32 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:46:29 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v10 1/4] hw/mem: add sp-mem device for Specific Purpose Memory
Date: Fri, 5 Jun 2026 18:46:06 +0800
Message-ID: <20260605104609.1739911-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f7fc3b-9a5c-4381-5155-08dec2efb50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799006|56012099006|18002099003|22082099003|6133799003|43062017;
X-Microsoft-Antispam-Message-Info: 3b+IKpuIHZoKf2ysUaSQYC0R/bwAJxAMcWnzD3xLnBQaWtakovGzOI/w+taOOMonwGqEPwD+yslKQnhNESuazc175vUcKOZwlW4GVsZ+NdnmzQ1qTg4R70qE/f18dwV/kqO5dBPq4ImLgXRo+rCG4RP34F1E4SaoN+wV1ZeY8bcIJVT6CYfwntBFfLVygp8VT4K1hGQWfd6ruflyZaMbbZxLGgZ38JKQxsBf5LodbEVoeGHWC3YExnnHmA9zKqYhcKGqTEtBsNw5i/BGtB85GlVqUGk6FrFcOF5DHLgvA6RcVLJhexqVdwe/8gqWR8bQkvhLSd+cL051hRzb/j7lsDZAHPZz3kLQuTs5ungGTBZeHpKGuBT1qFNsNYfFg+ISDKnanyYvKXkLlKEeH/0e0OYCOmFBgN/H58o1WAgGSUk3EYzsx0/eYW/sOw8je8NGG2dDmlKH76GR4xpkWQFa9gq6CdkPBe69zpAIwPwXvohsU6VfALLkSiNoBDM15+IXVBglpWImzBnhTY1PhkZj8yQN7JbP8tUtMFearoRdI4hXW86IUNHTxJbbQM/pN308GirmMPjOOON3Qk1yAyjkraMnUp2YRsczSsIi3/Fv8jEPhU2qAOH6s8MrRxxiT6w6V7ruAVsz22/ZFCxSKx4Dm/PGukKxe+KJyNp6orD12QZ8UXDO7iVHklgJXbkuegtL5E8Ekn/K2HGuIjX8Vi4V9/vm4dMaCSziBHLRJiBkwBisE3/fBCPWisaGFiIcVRAvjGmQLHS9ZOSebtzBaF6cOw1OIcOySIKo0HsYcTytZMM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h/hiIcI7SLOatskLIndo6PyAiSyfxNvQontrPUABOxBHSQ6Ex1a9xW8rL1bJYC4YCWHIhFOhGh3AXmEBQI6gIP7LiVkHIE40pbYYTyzwIY/myJJIe22cJJPfKBqM2xYpsrgegIO9DFSUHA/Yvp4+FtKeCYKOcW9PmVa01QwJdM7Kju0kyILALqEC0McLoJwBuMTl+rZIfLEw72KynC6cQ7x3BrAzx+U1r7+Qk2/9A4BUCpe6si2c1GotwGEjfKH1vjeZfplbwk7ffHH7yUNcHYVviVeCn05PYPDYj/i3uwqtlw6y11b5s8hLH9Z3L/acAaajqcbUb6NtiWkaBPJPTnA7Wte4gxJ/joiLPXEDNVD5yydSLz8+mwS/kmZEW2FRgWGthT5RD6MmU+FKRfGRdiVA/LKDLejoepErOOrFw1n0duEj9KxK3Hhkk73Dgs6L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:46:32.2216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f7fc3b-9a5c-4381-5155-08dec2efb50b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
 qapi/machine.json       |  43 ++++++++++++-
 include/hw/mem/sp-mem.h |  35 +++++++++++
 hw/mem/sp-mem.c         | 130 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/Kconfig          |   4 ++
 hw/mem/meson.build      |   1 +
 5 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/mem/sp-mem.c

diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b8..41cc3a188a 100644
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
+# @memaddr: physical address in memory, where device is mapped
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
+            'memaddr': 'size',
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
diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
new file mode 100644
index 0000000000..f6ba9a6d7c
--- /dev/null
+++ b/hw/mem/sp-mem.c
@@ -0,0 +1,130 @@
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
+    return SP_MEM(md)->addr;
+}
+
+static void sp_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
+                            Error **errp)
+{
+    SP_MEM(md)->addr = addr;
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
+static uint64_t sp_mem_get_plugged_size(const MemoryDeviceState *md,
+                                        Error **errp)
+{
+    SpMemDevice *spm = SP_MEM(md);
+    return spm->hostmem ?
+        memory_region_size(host_memory_backend_get_memory(spm->hostmem)) : 0;
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
+    di->memaddr = spm->addr;
+    di->size = spm->hostmem ? memory_region_size(
+                   host_memory_backend_get_memory(spm->hostmem)) : 0;
+    di->node = spm->node;
+    di->memdev = spm->hostmem ?
+                 object_get_canonical_path(OBJECT(spm->hostmem)) : NULL;
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
+    dc->vmsd = &vmstate_sp_mem;
+    device_class_set_props(dc, sp_mem_properties);
+
+    mdc->get_addr            = sp_mem_get_addr;
+    mdc->set_addr            = sp_mem_set_addr;
+    mdc->get_memory_region   = sp_mem_get_memory_region;
+    mdc->get_plugged_size    = sp_mem_get_plugged_size;
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


