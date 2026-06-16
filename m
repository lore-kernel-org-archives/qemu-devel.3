Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAA8CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPmu-0002Kb-4J; Tue, 16 Jun 2026 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPmr-0002Jx-TF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:08:49 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPmq-0004Oj-26
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZKmLtTzlMxPNMiUuTiwc7F8RJwRMJb6iFo8Y/fxk0kjpewVf1zboLBh2sFFmVJk2gFa7i2hMb0mLDvV9zkXy+OKZYY6hHAmxghgttZfGrUOpmlRfr08IcHwkzPKZ++4LoNIsnwnh4K9+UYuCYYnBpziIjZTCzuSVRa51XSpkT+ANVGRPBQTOZD3h5/If4pMwQVZTTs/2lg1dUoS8UtN1gTsyVRtCf+hB09zKM+P2HBd1mSm5Rwa9DzrJtQr5hZws9FUFfLxY4MerIDoOMmXfUVj81UkaPQQTiiCpu/8HOX0hXJa4VvgLctwK4gQ/e2nZl8ye1qYB+8ahuyBCK5e+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHqu31DCMg5uLcqIE+KC1KBbRygHlagmkMo7e4N71Bs=;
 b=RUtHJwaHww9Ah1YtC4Pbsq6/qUJA61T+Hx8l/5TpalJ8eBsBU5fdTk4H/AL2ejvBY+GvpkBOLl/PoABTl0TWZztYzgAbOql/LE0yAn88U8FgSKjWLKupLGfshF1Fq9rsCEV9bq6tVy732xtMgla+uiuya/dbjewF0q2Jqvfl9iPwq6QjNyGs4NW67PnPCRX9Hj2iTMYVlm+0+OdtEHOxAX9IoTfBHpVlQ4IAulm9rSKHaNw+TeiqG7Ycbca0Ikx0vYI/+HrBxVC8hxTKwbE0cKkPV5JsPz1cVO2kHlBq5ROiCHTXu3Qwll5DUY2lYfvzGPIPe519SgGAeYWsLMHzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHqu31DCMg5uLcqIE+KC1KBbRygHlagmkMo7e4N71Bs=;
 b=R+d242VJYfylOfMjA5WK90Iy+DCEeqFGFIJq1ZOiuaRn3PeVApZPCzyWY+4LtxoVbCpGZUq6oI4lWsKmf/j/dimsht2vHRTfckHpkbVy88AbqxT32nhqeMvbikqsFEnTbJDO1Cn0AhN2M43uApV4nw9sTwSwDDp971A8CnGJxKg=
Received: from DM6PR06CA0077.namprd06.prod.outlook.com (2603:10b6:5:336::10)
 by MW9PR12MB999210.namprd12.prod.outlook.com (2603:10b6:303:301::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 16 Jun
 2026 09:08:39 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::31) by DM6PR06CA0077.outlook.office365.com
 (2603:10b6:5:336::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:08:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:08:39 -0500
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 02:08:37 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v12 3/4] hw/i386: hook sp-mem into the pc machine plug path
Date: Tue, 16 Jun 2026 17:08:07 +0800
Message-ID: <20260616090808.3047939-4-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MW9PR12MB999210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc35f0a-e3f6-483d-b950-08decb86db21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: vQaJ4SQKuANZEVdgiJEApbeW3REn3xHg4UAj4e/kicpQAPMVDCkWM9ZfiHFR9eUmwA7VZC3asIQkyxKWcXS7ln75Rgql2o0sd9y9twXdBadiyctENjPdsEcrHnxj8ms/XeEWdXJQdVbx9guPeupIMJ0dh9KYlqQDD0w5FHM+M3p+nwsTeSsgi1rHZESN1AFU8aMtPHS35ckPFH4EEhERItfW4nMDOXUqfx3jeUYgtweGkFxm0McYTKOguS7/dfYpKiyiIqtiSTSwDmNc01Q0pLlcy0kQmpTeZCfbwBQxVkBDdMdX/Y2tjfU4LSmA+f6J5SejYIVWK64zjDok+f0uGKXd9kGIuICWylPySl11W9w/w1DNhwmf0si100LYzCXk3Xxbn6KezVN+Cf825m5mAWwBKGDW81wHUihYakHZ4R7NjUWNE6kvlv1DcMgCUsBfHHP3et9Sk3ZmlYc0v1ODOcatRtzWoi34k5GL202HQAKykV9ZGe3VTBjjXoQi7YaxNhQ1wSA4M4IL5CpDroceZym3GsPTTJT6VSMjJkGXIOGCFig8TtcTAHLDLQkOIuDmUwXPN7rblLBxwEd8pHosYQI4wPoip0rh4SYIvsmK1Bg98LkbQFT3ccxoT264smjxKv1k1UKVV3b75QfVhHUmPX9+3uUTTTJnSiB0YG44yBcvRcCp7Kp/8AoapzLIWvezmuwQKC0d1adPn2ahG+ZTmMFiNSV+MRnIIN7diOl/folgVes7cozJNkUH03Z3059YiSi7HjdPZu9+cUfxS+CWaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LKiH0lsgTYG5trUvt98pHwB3QnQfJ+31J674R6TeXjziUYBkjszm6Ro1VVJzHHK/ZtVMkLAhB2Hre4Xvp+ZzsYQuOyCU0mvAll6QaD+aBUssgXjb5KiFZgkMhML4XOHAzRg6UHJzoJUi6tGVgWuqpI1ev3VNjp5FndwbBMFm4i6RH59ezZlOiqpRpQXBxNLq5vFN6HlZj3SWes2GzUtc08W/nBghPhwYGXZ8d7qY2Bym7Br9PbGXFoRDZlZueUosVlmnRP2jJl/AhmainaHT8OJ2WzaOool29TRz/vxldXQefAgX+/JUqddcAWiYLy6XxQ7fCbU0EcSjTC4FXMkNZemmZlPQJ6a7NShK9NnXgiwhfpWC/hbZnxGCM325zcLIg+UQ1uUF+g2BFeY7o1CPqOZRS26zfUzYmZ6klx7ajrAGmkLGYHJHphHrPGonTVHB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:08:39.5211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc35f0a-e3f6-483d-b950-08decb86db21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999210
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


