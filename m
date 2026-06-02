Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6872FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKlF-00038Y-3Q; Tue, 02 Jun 2026 04:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKlC-000374-Pe
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:07 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKl8-0004Ou-AX
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL3b8K5tC9PMphC8KULAwrMAt47g3CYZPudq1cCEWhB0pcI+R03b26/DNZSXGENEkBI5LtbMRXRJ4NsZXs6e+suVf6ejhmD8cCSjSs0suxlS1es+A4haPz7zRldDoZDbSNfl24AMCun8hLmFHzPWxnR79Vk5zLOEKEOtd5BbW2L9yyW8ie9J6jFaO2tBtitN3wQ61JYj/TY6ftUj+SeOYEe0sHuUoFnam6WkgsHozfF0fuuCEi4X11gJEsIjP2gBHABjzdxvyY5nExVA3oecnFmpvosf7Yh4bjK27v6ywkoOoy1JDNHA6RU9/z7ykmapgdIBj5zZ3aJ34sAt+17njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7UFl+n3oowdFksQjukEAOhfhPQuxPIskcoyPV6YVLY=;
 b=XmHCtUlXkgoy0XbFYiiU2eNBt1dxgnMZjsR2M8kiOhuPmVT38DgxmohktoPGoR2PtFzXL0WpT20n3wLX/h0ewPuxNB+YmF3cnSlfXe1QZpvctajJfH4Gti8wFKw8Qilg80q0c9IvNreLiHrtwa9NjMzhujtbgrcquDpmlKVMnCp7dQmLdjBtetbXeuiKHH+W8hKDKtXPumrgAnZTeON4aP+aEuLDqF/yaMMXUfdeLdq9dkGLkq04xk1u+e+2t03GoQzfkGtJKBtFJQwD4jHXehtNMfxaMW3dDtK8rFN+WBLl+gnEy/yF1HRnjZh9bhdnf81lIU/UirYsaV917r2hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7UFl+n3oowdFksQjukEAOhfhPQuxPIskcoyPV6YVLY=;
 b=qWqpLKdu/Jh7+R6Nlc8WiosG8L2Bxa5PvLq4ca9xtAQLDOVA1fZTmxackxIbECV5Gv+cxkubMLeCn4G4p2RreresaR6znYqy4P9dRCYmx5CT7Wp2F9rLNAd5c7Nx496rTXIyHbG6YxwDAKp4Ko3QJn7dmt06UEO2mQosKDG5sX0=
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 08:45:51 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::56) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 08:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 08:45:50 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:45:48 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v9 1/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
Date: Tue, 2 Jun 2026 16:44:44 +0800
Message-ID: <20260602084447.1100554-2-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c908c2-fcb3-443d-e028-08dec08359a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|6133799003|22082099003|18002099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: CKo2lfzclgfiBSAkFgrvRlRX97GDZpeCjNjl6PBlx5IY7RcewWaiWoFjUY1jxrGDZW9/3XavtgSBmj/lqiiGmyEM6BW79ARmNMz+GmBzL/NTTDiPxKOEzhPY3hc2kElaX5pJGSbAEgADPK7/eBxiieDebpgPIOOzFD48rqOjZOyFkDj9O+PFqFPxK9WD2IJAQ8m8/0+Aw/BJdG5OOGnU41YxBTXbsIy0LeUImpMn31Y5fcxNGGAOT3Sz62jAUUBIhQBIdN+J1MJphKf8q/En5dU+rOv6zCkPiqrjZSn/VyTyD8PZtUj6pKmeS/QUD1+XkvzGFa+qRhQmIwjukyjsSSVFAn4nD1PsSMoU69n2G3biLUM4gdFwJ9O9ZZMYKUdUIfvUFi+d+Qv33X2ijVOknXaK0yeHaJct3YRl2ZGtS9+ejS2YJ5kQSUpk7JYHxX+2aL5HLaGPkWfAzmvbvGHJ5HKlI7oMsWgwM7w1vguRs1Ph3ffkpVx4HlHd8jBIJIBgCQu6GCym0+5OQubn0WIY0lHaZ6Cwmc8n2O7cWVTsS5aliElCEO9m4QDDSg/dmGCQVwdmPVkw587VodbdGhWkYOQg+0xTb+iLbtjCGvjzCsu62eI3etTicv0YyK8GQCYC/8nTKeC/CrMk3VfbNWRXQ5QSNHHBgYHsiexFIJo+cTHMwmluyitTGhZcSdGsQPsCVvtJtQrKfeC9I7qXOJiv+y9wBp1D2NmuAMSS3RiWYwdL9bzAsozzE7JqtR3HqtaeP0arK6pOoyV5xZvBoanwxn/5b0D7pAwRsKvD2Bdqozk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S5KHfNojvi1UxSRBtq+ww9e9zafnUNByRl1XspUAsTpNPFaQ6DMlhTOK8tjyEiPy3na3ImCriP8lHSop6dMz12nTv8bJzUIJ2S+rOHNUgaIGLGzOEqyjD65RLfwvYkY/PmgaDjKfexrjb/JaOwe9vXgLAIqKZm3sRnRcRxUqYji3vJdztcYHMSYM0c30ebcxeK/Eak3S4yh/+9QIhKNCc2M0WrSUnex3enZt8UlWKIUUqHisZ3jIyjUmMrrnG4qQ8RJC9l7eqZMDYjc2ycSzHVh/IdmTWTs38KSCj3VBr4lj+YspYkuShZS/7c5KSH7ECBRV0j20XfHJZgsJ+gpQFMlRVNG3Xht6L1g1rV4bXxymevVm5FTVg0mV+qa/aNqr/nBgl9AMH8WIP+k4Z3LwzmgvqnRry9lGuRemGYwuNXU3EiAv/RiyPR3OVHdrDGez
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:45:50.9798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c908c2-fcb3-443d-e028-08dec08359a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

Introduce a TYPE_MEMORY_DEVICE subclass `spm-memory` for boot-time
SOFT_RESERVED memory exposed to the guest with a per-device NUMA
proximity domain.

The device targets accelerator memory (HBM and similar) that the
firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
in the guest -- rather than the kernel's general allocator -- owns
the range.

Usage:

    -object memory-backend-ram,id=spm0,size=$SIZE
    -numa node,nodeid=$N
    -device spm-memory,id=dev0,memdev=spm0,node=$N[,addr=$GPA]

The device is boot-time only (no hotplug).

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 hw/i386/Kconfig             |   2 +
 hw/mem/Kconfig              |   4 ++
 hw/mem/meson.build          |   1 +
 hw/mem/spm-memory.c         | 133 ++++++++++++++++++++++++++++++++++++
 include/hw/mem/spm-memory.h |  42 ++++++++++++
 qapi/machine.json           |  43 +++++++++++-
 6 files changed, 223 insertions(+), 2 deletions(-)
 create mode 100644 hw/mem/spm-memory.c
 create mode 100644 include/hw/mem/spm-memory.h

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 12473acaa7..e31a25b634 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -84,6 +84,7 @@ config I440FX
     select PCI_I440FX
     select PIIX
     select DIMM
+    select SPM_MEMORY
     select SMBIOS
     select SMBIOS_LEGACY
     select FW_CFG_DMA
@@ -113,6 +114,7 @@ config Q35
     select LPC_ICH9
     select AHCI_ICH9
     select DIMM
+    select SPM_MEMORY
     select SMBIOS
     select FW_CFG_DMA
 
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 73c5ae8ad9..4145870881 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -16,3 +16,7 @@ config CXL_MEM_DEVICE
     bool
     default y if CXL
     select MEM_DEVICE
+
+config SPM_MEMORY
+    bool
+    select MEM_DEVICE
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 8c2beeb7d4..2c28104282 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
+mem_ss.add(when: 'CONFIG_SPM_MEMORY', if_true: files('spm-memory.c'))
 stub_ss.add(files('cxl_type3_stubs.c'))
 
 stub_ss.add(files('memory-device-stubs.c'))
diff --git a/hw/mem/spm-memory.c b/hw/mem/spm-memory.c
new file mode 100644
index 0000000000..e3942c6a3a
--- /dev/null
+++ b/hw/mem/spm-memory.c
@@ -0,0 +1,133 @@
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
+#include "hw/mem/spm-memory.h"
+#include "hw/mem/memory-device.h"
+#include "migration/vmstate.h"
+#include "system/hostmem.h"
+
+#define SPM_MEMORY_MEMDEV_PROP    "memdev"
+#define SPM_MEMORY_NODE_PROP      "node"
+#define SPM_MEMORY_ADDR_PROP      "addr"
+
+static const Property spm_memory_properties[] = {
+    DEFINE_PROP_LINK(SPM_MEMORY_MEMDEV_PROP, SpmMemoryDevice, hostmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_UINT32(SPM_MEMORY_NODE_PROP, SpmMemoryDevice, node, 0),
+    DEFINE_PROP_UINT64(SPM_MEMORY_ADDR_PROP, SpmMemoryDevice, addr, 0),
+};
+
+static uint64_t spm_memory_md_get_addr(const MemoryDeviceState *md)
+{
+    return SPM_MEMORY(md)->addr;
+}
+
+static void spm_memory_md_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                   Error **errp)
+{
+    SPM_MEMORY(md)->addr = addr;
+}
+
+static MemoryRegion *spm_memory_md_get_memory_region(MemoryDeviceState *md,
+                                                    Error **errp)
+{
+    SpmMemoryDevice *spm = SPM_MEMORY(md);
+
+    if (!spm->hostmem) {
+        error_setg(errp, "'memdev' property must be set");
+        return NULL;
+    }
+    return host_memory_backend_get_memory(spm->hostmem);
+}
+
+static uint64_t spm_memory_md_get_plugged_size(const MemoryDeviceState *md,
+                                               Error **errp)
+{
+    SpmMemoryDevice *spm = SPM_MEMORY(md);
+    return spm->hostmem ?
+        memory_region_size(host_memory_backend_get_memory(spm->hostmem)) : 0;
+}
+
+static void spm_memory_md_fill_device_info(const MemoryDeviceState *md,
+                                           MemoryDeviceInfo *info)
+{
+    SpmMemoryDeviceInfo *di = g_new0(SpmMemoryDeviceInfo, 1);
+    SpmMemoryDevice *spm = SPM_MEMORY(md);
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
+    info->u.spm_memory.data = di;
+    info->type = MEMORY_DEVICE_INFO_KIND_SPM_MEMORY;
+}
+
+static void spm_memory_realize(DeviceState *dev, Error **errp)
+{
+    SpmMemoryDevice *spm = SPM_MEMORY(dev);
+
+    if (!spm->hostmem) {
+        error_setg(errp, "'%s' property is required", SPM_MEMORY_MEMDEV_PROP);
+        return;
+    }
+}
+
+static const VMStateDescription vmstate_spm_memory = {
+    .name = TYPE_SPM_MEMORY,
+    .unmigratable = 1,
+};
+
+static void spm_memory_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
+
+    dc->desc = "SPM (Specific Purpose Memory) device";
+    dc->hotpluggable = false;
+    dc->realize = spm_memory_realize;
+    dc->vmsd = &vmstate_spm_memory;
+    device_class_set_props(dc, spm_memory_properties);
+
+    mdc->get_addr            = spm_memory_md_get_addr;
+    mdc->set_addr            = spm_memory_md_set_addr;
+    mdc->get_memory_region   = spm_memory_md_get_memory_region;
+    mdc->get_plugged_size    = spm_memory_md_get_plugged_size;
+    mdc->fill_device_info    = spm_memory_md_fill_device_info;
+}
+
+static const TypeInfo spm_memory_info = {
+    .name          = TYPE_SPM_MEMORY,
+    .parent        = TYPE_DEVICE,
+    .class_size    = sizeof(SpmMemoryDeviceClass),
+    .class_init    = spm_memory_class_init,
+    .instance_size = sizeof(SpmMemoryDevice),
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
+};
+
+static void spm_memory_register_types(void)
+{
+    type_register_static(&spm_memory_info);
+}
+
+type_init(spm_memory_register_types)
diff --git a/include/hw/mem/spm-memory.h b/include/hw/mem/spm-memory.h
new file mode 100644
index 0000000000..b56aa3cd12
--- /dev/null
+++ b/include/hw/mem/spm-memory.h
@@ -0,0 +1,42 @@
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
+#ifndef QEMU_SPM_MEMORY_H
+#define QEMU_SPM_MEMORY_H
+
+#include "hw/mem/memory-device.h"
+#include "hw/core/qdev.h"
+#include "qom/object.h"
+#include "system/hostmem.h"
+
+#define TYPE_SPM_MEMORY "spm-memory"
+
+OBJECT_DECLARE_TYPE(SpmMemoryDevice, SpmMemoryDeviceClass, SPM_MEMORY)
+
+struct SpmMemoryDevice {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    HostMemoryBackend *hostmem;    /* memdev= backend */
+    uint32_t node;                 /* NUMA proximity domain (node=) */
+    uint64_t addr;                 /* GPA (from addr= or framework-assigned) */
+};
+
+struct SpmMemoryDeviceClass {
+    /*< private >*/
+    DeviceClass parent_class;
+};
+
+#endif /* QEMU_SPM_MEMORY_H */
diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b8..51b06d7cba 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1413,6 +1413,32 @@
           }
 }
 
+##
+# @SpmMemoryDeviceInfo:
+#
+# spm-memory device state information
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
+{ 'struct': 'SpmMemoryDeviceInfo',
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
+# @spm-memory: since 11.1.
+#
 # Since: 2.1
 ##
 { 'enum': 'MemoryDeviceInfoKind',
   'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
-            'hv-balloon' ] }
+            'hv-balloon', 'spm-memory' ] }
 
 ##
 # @PCDIMMDeviceInfoWrapper:
@@ -1482,6 +1510,16 @@
 { 'struct': 'HvBalloonDeviceInfoWrapper',
   'data': { 'data': 'HvBalloonDeviceInfo' } }
 
+##
+# @SpmMemoryDeviceInfoWrapper:
+#
+# @data: spm-memory device state information
+#
+# Since: 11.1
+##
+{ 'struct': 'SpmMemoryDeviceInfoWrapper',
+  'data': { 'data': 'SpmMemoryDeviceInfo' } }
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
+            'spm-memory': 'SpmMemoryDeviceInfoWrapper'
           }
 }
 
-- 
2.34.1


