Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DE9CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX8t-0004iC-VM; Fri, 19 Jun 2026 07:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8q-0004gu-Rr
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:08 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8o-0001qx-Lp
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsfj7DP4l5sq5e4gF5uw4Uvw3zFtHCQSmU2xSaK0V3D0cbQklrtMnU3PdX0A2EekdPB2M4sMGJ1gD5al46HejqtePCI8XWtrLPiNjoaEjIXcp+ag3ul3wVEwtHYXz1I3B/rbGGrRrochyMwTQ7SDgwlIL17+TbcQYzsw0t6HuuD59VNvo/bemHE7CK+eIjxRSLbxsLR0+LMLswVi1qnx93jLTxqddlU0LHTKbx4LXRXf8DYq19p8bF4x2LqZmNotE9/s2Ju3btC/ZOsutWJQN7v8UT34815E7donhBJMVgUn60XAwUIDfFrIq4N7y7UKujwyWtlBopf9kizNX4k6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKCQs4NYHM1PFcUthhhLXTl5gJEA3qCy3umH3P7nM4A=;
 b=kwXQqWlc+4I2fSBdNpj/XY57cQ8tbH0xRzcDYgK5VfG3tPHQIfdi4I3z8nXYIclZT+ZAEGZzbYePVTdYb970Q5Y96ryeWYhL9IJwHp6rl1AmzKQDYfK21OcexthsWeXN79Q99NrGtB6s2mpABtPl/CDOH/7wnmiHQ5uljzOmnShtwdHC2ow51d4joOcbux4nDIh2JC2nivAEaUcnSQ2O16HZyoSrfkvTqYoMzs46EiEGa+9b1El+oQ6pqGYDWuwv2jgBEK5Lkl7lQInNtOAdiEnK9DJN1PBfj9kesDw0a5S7KClWZRmc1vQ3ep2kADxWFjlvt6mp27j5TrNV47IM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKCQs4NYHM1PFcUthhhLXTl5gJEA3qCy3umH3P7nM4A=;
 b=c7wnGYQUzimwAdYsptdgsYwGkhPzbv/qVMwpjjjc7Ntt3B9mggbgYpeuVVtmhy3z3DIyMSp47+3DtxRGCGERboQmKJ8R/6kYtvPwF/SYfgEQR14PBajhylMODLVH01x0wpX4FiEeMu62XMy/faifq2onra7D3cTSK9i4JydAx3s=
Received: from SJ0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:a03:33e::20)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 11:11:58 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::89) by SJ0PR03CA0045.outlook.office365.com
 (2603:10b6:a03:33e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 11:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:11:58 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:11:55 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 01/10] hw/mem: add sp-mem device for Specific Purpose
 Memory
Date: Fri, 19 Jun 2026 19:11:27 +0800
Message-ID: <20260619111136.3481329-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: c0474ba2-5306-4430-270a-08decdf394a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|22082099003|18002099003|11063799006|56012099006|6133799003|43062017;
X-Microsoft-Antispam-Message-Info: 6QNxbc/wYJNwU+/MVg7daRNbKHffCRjgkGbG9ECnNZhZ7NmdNaLRxK5Yj+wN+FNenBnBeyzYW2LzVe2VkVnX5HPku8bz7nWEW2cO8MhGkl1Qp9IiH0H0ZsUWO959+rRGv7qPqCRUJ5bdbONvtAQH8OwRWE2R8tfyAZ6LCIR1x6Nr7fg+zSH67/YjO5gu3evFUfGmQZPtMw05zdi9I+BcGNoMZzBYccSvuL9UEBkOBuqm4z7S33dm66q4dzYW5CCEs4PbUk7rMRw5bMOjHlIlqIH2/NdjqhlQ4hjLpyPLs8Wcf/RHgvKyBArVnIRhiU9ZviryanFV6O+o1p9ehEhL/3I20DIvHi3nKD/mn98GGYvKwYZd8002X3n+QwNjtpZ2BwqbayRBHbLc3trF/ut5MPnKXs9ThnBcU6ncNak5BGSq3cAP9ZftPMgAjOv/ZnnUa+D8P37HZInjDDrcM5g2J7S2cxRZt3pxwRBfqeabqzlNZH2l0LGO9Y1eRQ0KJmFiki6CagXidn1yQjVZQQeIlc7dIP/t/qlh1Oq4oGRCcdkFc+LK60mSBEqkH0turmIU1wCZU9Uvb3ZHZ3Fkuk1lyXvXujWNihAFFtXo4CUXTkeGsout8PbS/HpofOd/C0ClXpkd4HsdobDyWkUZ0h6+oPPsT1rFQAmZSB6yyuKJV8gJb8Hk/jVZyzDtVLHubO5FSOOha3WOwIpABiyVA4HBhYhDXwGsJIMHEW4/sTdxQKEZZ+bBTOVDTsbGQls2Q53S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wY4tO5oNYzS3J5Ne2k0UTTMhHEIZsqcrRBgRteygsQjvJ4hPBDFhZdDYa6RTAo+hDklil4qAbhVOjV99bO+MwVR6H7D0XxYW0lv5vRnHy4in4ZCLCyy4tQlNczP2+EnaQ1cKcL2YyxtOnWpCGE5s5zsxtG8q0tKlbJAdXgznQzX+pcRIJFv2oQQqO8zDSrimtYs+k3NXMGvQsNsi6kNX0Dl7NKQ6WiNjEEWfd2Dub4gZ7Yvq/t/l5oNSPbipM9pzQhB8J+36I7B1yYF/VaiLy1yvvrxg7L1j8jcYd0OCKNRsiuKMKioRDQUBNc6VNCmX2YWHY0cCPkZ20hzmjx+lADwY2Til2paary8Nx5M9VWirjDQ6X/NGbeOzOxJuD52MzrnL1+m1kQaS9zBR2lmQKAOfXED3992RsPipYpvE5XYXaBStRWAC+dvGRbSi3UT/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:11:58.6319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0474ba2-5306-4430-270a-08decdf394a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 include/hw/mem/sp-mem.h |  33 ++++++++++++
 hw/mem/sp-mem.c         | 109 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/Kconfig          |   4 ++
 hw/mem/meson.build      |   1 +
 4 files changed, 147 insertions(+)
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/mem/sp-mem.c

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
diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
new file mode 100644
index 0000000000..d088222f54
--- /dev/null
+++ b/hw/mem/sp-mem.c
@@ -0,0 +1,109 @@
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
+static void sp_mem_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
+
+    dc->desc = "SPM (Specific Purpose Memory) device";
+    dc->hotpluggable = false;
+    dc->realize = sp_mem_realize;
+    dc->unrealize = sp_mem_unrealize;
+    device_class_set_props(dc, sp_mem_properties);
+
+    mdc->get_addr            = sp_mem_get_addr;
+    mdc->set_addr            = sp_mem_set_addr;
+    mdc->get_memory_region   = sp_mem_get_memory_region;
+    mdc->get_plugged_size    = memory_device_get_region_size;
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


