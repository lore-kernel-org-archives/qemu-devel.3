Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3848CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvv4-0006EK-OD; Tue, 23 Jun 2026 03:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvv1-0006Dp-Aw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:39 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvuz-0000gt-26
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFhLu2aMuR4zdXIWO0uxXjQE2PQzQiGeiXdodwgucg5cdRZExLb34fZGI/ohA+OMAaVbgjUzemi015DeGn4brUvoGoCLrCH8rPJTEeF40twxZoujG7oWB40bYQjnun0aR90rG1pgecsMj4550A5LgbDJt6SBziJaYtQKh11n4erHzrtFjW+1dWpRlPlhABKwt0jAUqHYkYsSUwfM+b/ANHId8dz8zXULgd6sJSHqZEfSUs575Fmolz8ILpyaGj9W8Lzlxmo3ZT5oXYo67DkfOtj9D+C5gICZka5plfyhGsgYgGPnqagarVUTZH3iFH5UN7C7z02OtTzKe50vH8J1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZiUKhlw28P2R4J8k9wGBtIjsAUsm9jxlr7Am36IpPg=;
 b=otoAdVekThfFdomZ+bjNAjPhCHhslX8K0fbRuz0VnHfH/tvIXdBkbZ3RQN5c6O4Agwmw2o/8SghFjhE8xImjKU6MEhrdT3Z6+60jW/2g6MPzU4eUtSUnx5KhA4dlk+V6rGxitXkJfvQvxShYsq76q6ncvWSYNFUohCHS+h14bSqhv4PRhAGrQPqvc8naTp+YQbNdyrJ5xicHL9zYSpXvib0XbGyI2X0EdaMZgzcq8IwjH5hhc2M4JoxMdj0rV/OFdXoWPg3X+9psZevl7cbVnneCCUUWE9dmvGRyuvUD9TSTN1cxOVrrn7uwz9lKD0hb1oQj3bdkSZtor0ffAh9nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZiUKhlw28P2R4J8k9wGBtIjsAUsm9jxlr7Am36IpPg=;
 b=3j+pQHVnIUTXwZ/BkWjeocwtmRGTTP2Z5Wy6GDZZFSumwwuZpan6REIkV1J5RfaizkRF+LdMy1KZTy1b176E1gb72RjKfoiatRV0wkW3CCaUGjrc/AGU/KUgDbHr0qcMxqa1ftrF+9Eve0JvW8wFtYxQEdBH2wDQabOM3ArXJKg=
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:51:30 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::26) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 07:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:29 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:25 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 01/10] hw/mem: add sp-mem device for Specific Purpose
 Memory
Date: Tue, 23 Jun 2026 15:50:42 +0800
Message-ID: <20260623075051.3797975-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: eddca42d-5684-4397-600c-08ded0fc3c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: rG5Me0GmekhMcEinIEAq5MKSbCHWKu0b/Yzl82TgWvdLCbPJaRW8SqS9l4P21cRzpSPaP3Ah8ZsJjOg8yvRL61LEd5/yBoTZqIYU4heoCY6RsADk9ZGvISYlTabUO38ONRQ7Wxd5Y628Ei1uxGzm+2rt4IMIDaVHn13C3dpfqr7tW8IiPznzocQC7OuP7iVzad+O4KdumK6z0hNaV1Rc77MuwN3AsXHnllijDt/z7W4aJqnxgqyDNAAW6gA7WJCceI+H7Dxpn0BKjsvxlWcLv6+xnDLUtzud0I1LMFuqZvOjtUT1y3A7sek+ruPAcNBSKQ+3DSI3U7Ys/1TDjjeof6C37J77eFE9zJPADZJisr4N/1q0Xmqn1FUygPcIH3TpuOo7zpHiIgVnhjRxoKKQDuoioBx1AbNBtJwJacUjvbIr+lxysshrFlq63pm4eBpcU8B2DUNipxnXha+BfdEBF/73wpXIhYsxpsdqp/mWSl07T9jbRgSruFLpOjzPdnIcKUzXj7b1qN7aHo6YncNKVixj9DB2CowFe/PDBaBgqqyIwBz4PC5JZB74hXjeO9XJ6VrqeLVgdFxSXDg+oT8hjaMWHOCpnSfA9rd9GYAWMvpYbW3DHfs2VS8lqoKsFaRhEYGStagGEibsySkKpajLljZSV9425eGMPDRBfq6wQ7CMl4veP20ZQgEW0yX0LpELwilJmDseCXOxp94jcdxedyIIOOmlSEdHA+o0Oq2TBYo8QEpEFThjPkMhIkRqCTOU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CXhzfXXks47WTv0dNDVRDCCzhLDP3McBmiHl3ZITM2ru3ZV0bJNqn+CIm377P22LARTWvzxX4ummO/2HVIfAerRS8dRjwve1xJ3E8jVDAfdH1KlFycJoYB+yvHi+4bzVFpQkMbLtuc5chcPuh06PVlu6PekfmBJgsUi3x80ZUDKiPxi3ose8KbCRDW7yt2pm6+g9o+b/mzyTG6b+OV9pdil1t1tE2ECR+8qdFAKmtowd4jedZqTVGAdQqosPQaIjvumeIyN85MHkcy0W5SxBgMfVQ5vku4mr3GInfkjJMhOsmsQuoXke0GDHVEriAeIgKSO8tkXqpvI5Vx8Fj8GhPrjjh/jt5wLr7QA1RzA0lZ2Yj7aJUsP9tCgfr6bF7Y737dx65ltgF71VCGzvsVYe2st0bhAntUhQagPuqtDS8J3DEw6t+6fkkkra8nLoLRD4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:29.2134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddca42d-5684-4397-600c-08ded0fc3c31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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


