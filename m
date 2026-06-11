Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718ABCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXcJg-0001kn-6Y; Thu, 11 Jun 2026 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJc-0001gt-1a
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:12 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXcJY-00071r-S3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QohvlXI30V+nKcFtmjI3DW6HosjnFFRP9lOZyAfozAjON1S+1qnkJ5WVJH/2eOOLWBKCpSFxyBsAnw2tUcznpwi5oDeTgCLoHdzude4OSne/L8ZBQfJDyzS0NEdJbBHQ+o6HI8o4gr85AiXKahoWT7li7zutU0bmHK/6c5jxwLRZsEa/wG/whEEIy9XPQ+jR/yySEcAz0N/zwJrBPwBoVrc/pX5CSvCUSf00iFbfk2JmPV79PzuzTlAG7QW2wZ3Ko182jJRbRjQ5EwZfwpEEsH18fS5Qrdtb7dRyI/IvLtO7crCGn2So1/SCkPd+Kmv/rWzNPAnlCqfROoevz5uX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHqu31DCMg5uLcqIE+KC1KBbRygHlagmkMo7e4N71Bs=;
 b=Oan1awhqOT8Hh+dtPpScNsIJYPmBOj+F8tCkuTzWJluKFwB8zkeP/wZEf3gp15rrpZnu0XzT2Z8J/60ABWFOLJ6oIpLWd68kp9mrhLlt84muuKsLShxDStkp4gphhF/A67sch6YCUi3siEd0mxSrFKYMPWtafT4iGaBef/IIx3u8j0+6Kg1Dk9X1EegHUTNLaJw7NBduNzwvJ/0jrvPWrnGMNVH0IVzU+CBsbz19aN0ta6JfLQ+wJuXDYl5j3UiOl0gHorYShTqxogQ3mtSyAsK1ES52TN3k6g8JYeVzcfuJPDc5EgP7pJNAEtvEW0cYWRzVLFZLFurr8UEH7nkUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHqu31DCMg5uLcqIE+KC1KBbRygHlagmkMo7e4N71Bs=;
 b=L+juw7DN76j0ArUjOd2MUrShyD8oJEMClPxrOfRhdIcwDMbw2qpdHYKdmW0gZ4bRX0EvxfBO2IRVMHqxSlK7fZ3vt+wyA8stMaEMZaI1WJm85IKt+zZpQdhuQ3aAO+L69tKKsPtgNXSiCa8iTyIvjVVCUCjsbKERCeSIyUuUkWg=
Received: from BN9PR03CA0091.namprd03.prod.outlook.com (2603:10b6:408:fd::6)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 10:07:05 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::72) by BN9PR03CA0091.outlook.office365.com
 (2603:10b6:408:fd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 10:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 10:07:04 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 05:07:02 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v11 3/4] hw/i386: hook sp-mem into the pc machine plug path
Date: Thu, 11 Jun 2026 18:06:36 +0800
Message-ID: <20260611100637.2460507-4-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cedb22-d8c0-4604-5593-08dec7a1306e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: qdrPJO311oRsGla6JudXEpnJdsyVj9AueJSWGEjX8HYnY/8Jvf8WPH4TvyjhQ8PRXaOOBH4Tt7jB7BZtPKcJHCVikg8+IDyBsfll0m5zqoIpoOSFlQoyGPgMP6uwj1+E2ibHbNZEQ12K7hqdVGj1C9lDvH2SKhCgClXWp+MRrHaQW9hKlEvQhagW8wME9r6B204s6OhgbANd/Eq/L63uV1zgynqyTXTt/0KjZKXwJ7wNEOpcQoTx6SBJWEZMLZkZvM1UD09wcfbuFp4Tdk+bnIQEUDjzILApd1o2up1pVUC3UC7w0U3drkMXdOe0FImxLbytA52LrZr8bWekS9mp2OA76dBsNOvarPex4kLjIewEmG2i1E6OI5dkP3GO9spvMKWTdey94GVz4YzYaxNDm72oZ4RHdsMCj+7h+s7N+xfFDnyT5S45/mdppo/LZuOMKUqIOEzodKo3ww0j7GAM2fjXSWQ580OP4kt7d0S5q7iD0rDPAlmaeJ8clikGl0TyDZMQDwlXGSwwMG1E9osoOwspRJ01Nllnme6OvJWpSACPydCYOJ/ZhI+5lYVVexzAIvM3sxJEBVxD7n6NfL256kCfkii7E6afq2CaDfL4YjW58EVvf+nJIYyAcBIjSlk33lJ4V3GoIukXhs05PXKhKCbsT75ULMOPQNV6HahI9HgqCARO8vDnSVUAhZTbOm7YlU33YfO5UY4f1zLaY3Q9ewdswQgxoa9NF2lbPqbUsEs7PEN/XJ5YobQiHc1Z7hwTfbe+ztyHrgM0cRpLNCMK9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GnyGezJ2jHUEscT5SN11C5XNKAqibWaWrxlZ2kgEyUBxDVdyuKqx6Hor7prQwzfXImUEJiJ0VDEllB53i3ETRk9e9Ymde+638KrUTTqnWQBK/7fYwkK1RPC+QdhIWxdXVSp+y8SO0MzEEAAE+PjPG0tKRxQOVbGwyaQlwb3C2nkYO7dGEp3WopnCMsYnxY5BYHgcinvZxCw1NtLfWPklchmqVPyvsFcH4FQpak4fUriogvGsG0rid3A4OfK1eBIw0bFooK5oqYHZA1K5il2wE/B5+8jZ3mi72JPz0Sn5XM+aBBRWit0dDbw5tDzXpwL63FiuxJvkk1OIgc7ZyIUSrL8Msg04pF5Ima6MlDfTcPnKh0VIN6cbiZTQauhU02t3ghZ4GMc+yOMm+HpbbMnY+0oZ2PF0dH4D4CFfaKWX+fgW2MiKSg82Ky4d+kZi5vbR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:07:04.8946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cedb22-d8c0-4604-5593-08dec7a1306e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the pc machine hookup for TYPE_SP_MEM so each sp-mem instance is
placed by the memory-device framework and reported to the guest as
E820_SOFT_RESERVED.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
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
index 7b6ad97e5a..ec3459389b 100644
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
@@ -1283,11 +1284,43 @@ static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
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
@@ -1324,6 +1357,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
+        pc_sp_mem_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -1368,6 +1403,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
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


