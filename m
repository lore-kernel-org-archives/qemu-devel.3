Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03129CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX8z-0004m7-JQ; Fri, 19 Jun 2026 07:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8x-0004j1-Uj
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:15 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8w-0001sG-10
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mha2YBb7TYIXI5oUNRgo9k+P0gcKz8pYdSlzebHwkgO58HJMMyLZnQXwc+L+9la41PqHIjkoYwY6DkjzMu+mk7earfQrhQMMdNWbYO6Ebq+WAc57M6J4iM9fvak23eQX7EBRocR+4agRL0yC4a/mGN7+f0mIuNZ7cibOFTE0NLB3QxIsirmfNaaAT3tj7V2RO7qwamSfVzGrhvEJQGh89Kk9Gxt8hG1slxvhlM+LrbaEJi0sMvUwAH7zbjsYnXaZs1ZcbSswxp+E5Bmylxlj2WpsK4lppHCBQlnF9y9YZC768KHcekuYAVbJMPpr2Axz7zHECa95B5njPLVEEovapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NJ1+CVrk5KoSUSyP/uv0wIOPnr1GJDzfpxGJ1Cf+eg=;
 b=GyjA1rnVT7eiOP1Y+O2W5MOag4Yozy32/7sOXTW007My49B4QmYtvxQ+/VtiT662YEG+G3FDa3LkEauilkhM4uRrQJlBCrR0pwukB27+fj11vo2cGDHI4hr2RtOsdnIL3YTlVtp8MYqPkRUIjzy6FHOgMAywskt+aNsxAVb8cXspSskCJOKewnkt8uFwdCPkQ83AQACNkL6aDZkmwBKHShyve3nBSmi+sAodGTtYYzGAIloYJt0GnZIRjCqfxHsbvPGT6NFtaarTj4xz4ciel8dbMlUGBORB7nouM5JzJRWyQO31vip2okAK2+Nn4miTntv/1td4q6dmT+ZHdJVIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NJ1+CVrk5KoSUSyP/uv0wIOPnr1GJDzfpxGJ1Cf+eg=;
 b=eI2AsN4BU1tor5ZqEJSGo8JZ9vCFaWwtPlcpNiHMrvJPsBm14NNK1n9AdwCKDD22i0tTjwiuijBQZDkGTz+t44IecVHeusjRBymDAsmS71oxFgT/xrlO9ucWNIMmZn98n/G++dx+2Xhn0geeeKlvX/XuImpSS16jWHbR0CViZDk=
Received: from BY3PR10CA0010.namprd10.prod.outlook.com (2603:10b6:a03:255::15)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 11:12:07 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::af) by BY3PR10CA0010.outlook.office365.com
 (2603:10b6:a03:255::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 11:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:07 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:12:03 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 04/10] hw/i386: hook sp-mem into the pc machine plug path
Date: Fri, 19 Jun 2026 19:11:30 +0800
Message-ID: <20260619111136.3481329-5-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 445bb355-aaf5-4791-e9c4-08decdf399dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|18002099003|22082099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: Dtucn1zd/cjNc7tLSGe4RkhPJnmkuG+306UmFcSmS3+6ekW6GBH7NdpQ+4MKu77K9zcjGBHPdv1edYtdZ7Aoki+u+7azzd7w8i01mMu5SymmGImGMBKRJRFiKo4hBx6fdhRfmiJkUKU5fwYk48kjbkIUSGZKrTYBU+cmSbPdt8G1apWHJN7R+/TMJJpmF+BOFD+hO7GfArsJzWPIgpzZzngOvk/mKq4WvmVG6vynhz3BHYb/J7/bzhXkpztNOJfAcDQ+MUykI4ODeq3bu4M9TyrAMfo23aR0NCubmwLFHWccKEttixdQOglfZfPT2vcuYmo05lvjgLXeTfM7LpyFBh7my6wiu3MSlJgQ7RIS6UFS74Uuvyv9HnH5gk6c706xmeNWNssjzqrFmYj3F83Ufu2FjfM398AMF+tybR6X/XVq51aoOT2vtlNev7vjeSW9BjAO2bsp88jlIDMP/AEpvyeY7lFaormOIQlMHQ9YHhnNtbr24PXw0nX47S1rQlNRhuC51eNktGR7u2CEJeWHF9dlvi5DEgYFhzJcWuoX+4Qm8t+gXPKXUSxdUCaD8pI/fgSLfFDYPCVv+3UMYOLSEY8lp4CUjhXgpI/zcXiUPJHbIScico7UW2QjvTLvmAZE0UHKncvuKwmPHtG5c7FPK5xz4rznY3jHZoK04IYPePKs200dTJ7xNgvu6yLSgga3SWDVJ+4uJhLiwcXX0lX/pyr6TwFqNpkGfAlhFvjni3eLspvrNmQbQ/5zCmk2HYQ2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8wRdPt4+YEAN1vxh5OZYo72EoaLevmdAsTAr6YZPbXkGPiiHlebdiltHcJWH+62HOqe+X9CG3PO9qz2ERhpIBKPD8oBLIPJxzJpxXFQGdmHPhFKUV6+3jzaEb4jh1HW4V218hhxNelBJwkdS3vNwRhGiLyIkdKIJ5OM8Xrq9cB1l02jH7g7njmuCjz+RLUPyK7JA4LwKMm+Ve4a16M88v29dd3cvKW8wckyUn4Rl0k3GWUJ6JfVxDWRT9+9P+CbD6XyRnspeLX+PcVjnsIMEAWn/8En+3dfEaysC3h4qTRvQxCb+tyiH3MeQ5Df+SH/xoF//7r22LcSIkSF/gYKLk8TdxqlPb/6S9gomgh7qWLli/ONIhigDoTs+xgR6BACsKBQLiEix3N2mlljQQ+gu88U5dBaMSKm4k/op8mMR8gophlzXjI4HLWOOH5Du1QYO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:07.4059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445bb355-aaf5-4791-e9c4-08decdf399dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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

Add the pc machine hookup for TYPE_SP_MEM so each sp-mem instance is
placed by the memory-device framework and reported to the guest as
E820_SOFT_RESERVED.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/e820_memory_layout.h | 11 ++++++-----
 hw/i386/pc.c                 | 36 ++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig              |  2 ++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index b50acfa201..6ef169db9c 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -10,11 +10,12 @@
 #define HW_I386_E820_MEMORY_LAYOUT_H
 
 /* e820 types */
-#define E820_RAM        1
-#define E820_RESERVED   2
-#define E820_ACPI       3
-#define E820_NVS        4
-#define E820_UNUSABLE   5
+#define E820_RAM           1
+#define E820_RESERVED      2
+#define E820_ACPI          3
+#define E820_NVS           4
+#define E820_UNUSABLE      5
+#define E820_SOFT_RESERVED 0xefffffff
 
 struct e820_entry {
     uint64_t address;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73a625327c..782122f7be 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -63,6 +63,7 @@
 #include "hw/i386/kvm/xen_gnttab.h"
 #include "hw/i386/kvm/xen_xenstore.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/sp-mem.h"
 #include "e820_memory_layout.h"
 #include "trace.h"
 #include "sev.h"
@@ -1285,11 +1286,43 @@ static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
     memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
 }
 
+static void pc_sp_mem_pre_plug(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(hotplug_dev);
+    SpMemDevice *spm = SP_MEM(dev);
+
+    if (ms->numa_state && spm->node >= ms->numa_state->num_nodes) {
+        error_setg(errp,
+                   "'node' property value %" PRIu32
+                   " exceeds the number of NUMA nodes (%d)",
+                   spm->node, ms->numa_state->num_nodes);
+        return;
+    }
+    memory_device_pre_plug(MEMORY_DEVICE(dev), ms, errp);
+}
+
+static void pc_sp_mem_plug(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    SpMemDevice *spm = SP_MEM(dev);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(dev));
+    uint64_t addr, size;
+
+    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+
+    addr = mdc->get_addr(MEMORY_DEVICE(dev));
+    size = memory_region_size(host_memory_backend_get_memory(spm->hostmem));
+    e820_add_entry(addr, size, E820_SOFT_RESERVED);
+}
+
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
+        pc_sp_mem_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -1326,6 +1359,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
+        pc_sp_mem_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -1370,6 +1405,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 12473acaa7..e27d8816e5 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -84,6 +84,7 @@ config I440FX
     select PCI_I440FX
     select PIIX
     select DIMM
+    select SP_MEM
     select SMBIOS
     select SMBIOS_LEGACY
     select FW_CFG_DMA
@@ -113,6 +114,7 @@ config Q35
     select LPC_ICH9
     select AHCI_ICH9
     select DIMM
+    select SP_MEM
     select SMBIOS
     select FW_CFG_DMA
 
-- 
2.34.1


