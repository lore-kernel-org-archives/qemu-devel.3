Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951CACD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVS4j-00029w-Nj; Fri, 05 Jun 2026 06:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4h-00029o-Mz
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:51 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4f-0004Ui-Pn
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl1c+F52egEadQksIE7uPCY3LI9VP96/EjyLgCvwPA+zs81ol5G5fYIVf014Z3kky7ECXRUmIdWMZeEOl2K/7fks/cLBor+tsqwcfZR73kqEoPZ8zCP9yKLEmBCIqBlpBlp/J53OF8tiQr0rq7K54SawGL/rcogXPM5iZWryjHMCtqkoRP3Ui2ubdNJ73P8PgNWEsmCUz0GPKG3kBPkn9owpgzRcpWKypMxgKMhbFiO7uAs+cpB/D3Uba9XcG332odpMcbrbicA4XnaCawUciuucTlNYv18EYCKAl4SZtmpO3eY0JTsL8x5IR6nOdtu2zGiYf5mqvR8/7PkSQYGi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfHcmFIqfwxoTCMOKA7Gs6NZSYhNpaHk/0AML+vEE4o=;
 b=fWYkYIfZF9e/eYFFA2NkgbEJ3w5x3gB0tLh6HT2GNzgGI7ucZlSUZssIhraidp4vKMJNAixt48KGnmqYdr64McuhSGDZv9XI0RAZj23v78eIPQyl1SyvjV7ef1TRcEDZ0o2YMrks7wypQCjwF5nnetUNKq5/WBbMQ2kpusAlEePzwL4eKJhusvSILP3l0dR68MFljD09Q/AwI6QUmmOXyha3EBZlbBDi9laoDdmDfiKCAbtq4eMmLN8eUnziMZnySr1IW6SCkQfRCk55A63xC0OTv32ARQdHV9+nvCOcipMWmr+nx7lzBmL3IepZM3ks6he2rtAyFVjaCNa5Hb8rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfHcmFIqfwxoTCMOKA7Gs6NZSYhNpaHk/0AML+vEE4o=;
 b=1XzUOPmQJaSzlUqO7htZgf8NM4NV79RD1A2oiIusOpL+3WF7TXUy+UxnkrCxHa20HL3VH7RgaO1nfONKjf9Bqb0XAdPhxBfOmaUZ3SVqpDWS1MhcMoTVd7zB5YkpUApIItUVA5/LBOXVU2NOtcun5Eq9yOHMsV397GIQscs/Zkc=
Received: from MW4PR03CA0349.namprd03.prod.outlook.com (2603:10b6:303:dc::24)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 10:46:38 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::59) by MW4PR03CA0349.outlook.office365.com
 (2603:10b6:303:dc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 10:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:46:37 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:46:34 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v10 3/4] hw/i386: hook sp-mem into the pc machine plug path
Date: Fri, 5 Jun 2026 18:46:08 +0800
Message-ID: <20260605104609.1739911-4-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: b0257c40-a69e-4190-f3be-08dec2efb7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|56012099006|22082099003|18002099003|43062017;
X-Microsoft-Antispam-Message-Info: B7ZmeA+RjCEQ6/pjBNzkzB3ydWyVGYzD2NMxX5vLM8V/YGC9iy9v9NLmTRQULcs+Cz8Or2ZJNtKvzWXoVJW4ZMKeGZjbheNiBdN1WSzQucEmEAO61Ecml3SefXlYiZo88ZLf7QvN2HIrrF4JFUc9f+nDrbD3CrHYiAFIUEkC4xkWfeWGgi+TJGZjMynTi/FQAcgJmq/xuIXHEgiG7q7pgbAwiWk9YZlPowXBFFT+CKsoyLeb8f5M6XSEtZeLlS1LHkWFI++o7giCpZSD4h4cN0p7MlOmWGRiDxriGa/kZbSIW5pE6gXXL7Y1uVAkfAJG+j3YXQoR0kK2xtX6ZJcdsExLsqFmgCPEBs1xHsknIZxdGkGqD16Sug7pVINApua9grKJRIxlKaPyus3rq1+/Sm/f3Vse5AhmPRXC/fYrTzO80X8/HsQ/PTOYAifnBit9gv+rG2yl0TbemEfFbUvOqNz+tkemFYZsTEGAkjhu+tuWNpPtQubkhr3BLiLpCNtDC+tnTXC1yFPMl+37k7DrSYpkD+8qe1vkePhdk7JO1zzkjN09W65YhDUWIsSIFTR4HcgoMChR1guMRuAbR0RQ537hs71/iEupDoUB/XDGY5NYJFEYEghKcAHokkyxmga1XmwIcDh98mPnJYJnpXdYVEGEzHcicXx+x7NFFClipzdOMUrmiKIHr9jkYKUPMGc5A+oameRybCFVP20k5a/Z+URaKmXqvf0B7pBr8dDzAPYBLYicaxQX4697crM6tVUu0UalQnykzh8biilQzntr6SjayrPAsjyfOHA2gy+DQgw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yEzDqU7pJbWKP69HLripM5ONKpIaykqSByQJ8Gc6w3SdJDa6alPA4xvttg0VpQSI17D0caPsdRSQwz41kNPQufRJy8wvKyJQRESd3joAh2owtQGLbIGpD5XxISKEOGp3DN7GHbrlNpWACRQ2E8tcGqkimVMFaeVPGGzCT9vhugdQkdmhsnQYffoEMOqchotHfWQizQIVn+SUXd7KZfTnkt7mFcP4u1ZXxZ2D4URcoe9e6Ni+bUJi4frBXeqqH6XPSPw5bXsf3xdsBS2GOxBwR5lpRYk+gtyAudJeKvDQ0rx68RoOnXtArO5T2kfUsk6ygHe9ZEfNelgLpsUMKlSkc+EOD1G88eXlvhTGpw2F+qPQ22NTKzkMuWrj1pj2Yn1GH4N9a1volRZzNgfPejeaJ31KEbexihLhmAEkgeAyv6DjJuzEAzcybbxRFOQZellW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:46:37.0126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0257c40-a69e-4190-f3be-08dec2efb7e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Add the pc machine hookup for TYPE_SP_MEM so each sp-mem instance is
placed by the memory-device framework and reported to the guest as
E820_SOFT_RESERVED.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 hw/i386/e820_memory_layout.h | 11 +++++-----
 hw/i386/pc.c                 | 42 ++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig              |  2 ++
 3 files changed, 50 insertions(+), 5 deletions(-)

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
index 2ecad3c503..b538f49f23 100644
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
@@ -1283,11 +1284,49 @@ static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
     memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
 }
 
+static void pc_sp_mem_pre_plug(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(hotplug_dev);
+    SpMemDevice *spm = SP_MEM(dev);
+
+    if (host_memory_backend_is_mapped(spm->hostmem)) {
+        error_setg(errp, "memory backend '%s' is already in use",
+                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
+        return;
+    }
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
+    host_memory_backend_set_mapped(spm->hostmem, true);
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
@@ -1324,6 +1363,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
+        pc_sp_mem_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -1368,6 +1409,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
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


