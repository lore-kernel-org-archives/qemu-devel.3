Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F90CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPyQ-0005Wh-ID; Mon, 11 May 2026 08:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPyP-0005WZ-4w
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:43:01 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPyM-0005L9-Lv
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIyWgadaVQHktAc5iXksPKZV5ZcqfPHSBGPlZu2v1G9TpxKNjeYEzqMVg1InbPnrxUpuD7fO95SzlzRUsG4AdkVw1/0FQtqg4pQDS2LwNbK2xDZ1jDwcjhEFflt+woBnJFnYTPHWXYEoDPf6TzLO1Sz6fva7fvgYxlNY3EH3NgHWJ+/aaRwBRxRxfzHAOByivmuUxdGjo0pLdu3H/8fAE2jnNzJxiJwmBpHbtphP1/t4O0e9q4gM8bE5Ca4pdhHVnNaYjVV7rQol8TXlHR5lQyQ9kpMy0ooYBtyu32p289z4wdPC5NAZEQufQbWZ9PdH2MZtOo8NmZhKyHFbjRWMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlBEhWgdehlHWSGxHqz+uBpOL9qP+pgs/UbEqJobcgY=;
 b=W3NvAZuBVRUZvU/AE+sLbHgfhAHiSrC8pgGzsBVRlFmICzgVE5YBr7O1E6/Cd0S+C/0p+j9zL4B4Co94/AqU+AIM4cAInsmrhIEj5UYIqzNh9oezoJgqakopJjEwCAF4rD9hd7DLtDJZ4Qi+COuPeFcKUF5BFI2vUcvAViYc8H0UevzVMRgqaYBs4L8HA+bvejoWcYuxkhVUy9suvFANoA9c1gDW+vkacB3thfhFxFpl5AruM1yjPjpLOn/e/tPxmfAUgJ/cg3Zfr00N1AvxLmrjoydwfNNW/GLC1XaD7pc/8j6nhP0y6z0Q+FvMQ07dhJHezDt6qdzxHGzbx5yHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlBEhWgdehlHWSGxHqz+uBpOL9qP+pgs/UbEqJobcgY=;
 b=Yz9Q6+mwFo900PSXWsj+T1dd6fctP7HoD+YQ4SIIQa20RSLjlDlMjK97kEK5id7IcLL3D1Ca7MrJVtclkyVAaWjue9MV8dbpSjTZO7grXfeUPLTaQ4GkdxVFvYj0aesGKouLDFZilcXpppMBe0/kx7W+E0tSYzcR9oEOpjihHPU=
Received: from SJ0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:a03:3a1::15)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:42:48 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::7e) by SJ0PR03CA0370.outlook.office365.com
 (2603:10b6:a03:3a1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 12:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:42:47 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:42:42 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 7/8] acpi_build: Cleanup AMD IOMMU IVRS building
Date: Mon, 11 May 2026 18:09:36 +0530
Message-ID: <20260511123937.32743-8-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511123937.32743-1-sarunkod@amd.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb89c50-aa11-4990-a96e-08deaf5ace58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|921020|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XjlhrXM6BBqtGgqgtL5F/v8HbXs+h+hbWIW5zMrjP9vdJpUcOzDyZaeEQyqL98jc8ytjKIWcXE97Xu3wXpIqutcNlYGsMLmDnKd3br3ymU8/VqS56S3POcqxFZOKc9OUbjFOZYlM4O6djrctn8d6usB6J6HveTnrSH4ioFtJsG6Lqaw7/+HqTNaPmlraMCohHesSTAav+ZI/tWi7J42jrG4EDzK3Z7h6zXr8M5tQmOpkFpzYhb6xxeXdR9sniMAdjWhBA5SJIgcxWtVrGJtHY4w0wDbz1g6tgQVl0i20q/29fxyTGrZfr1Z63MB4sGiEzFs0IoWh6Rxv71yHlwya6O3RjlOUEI86Bexkm6bBaVKPUCSNea44MnMXS59sk/NgRc0ZLqVxUZ3FMq8HpvCiJWxP2tOhLdiPOo0VL7n8sK5bQRfR06+YeYXtDRnB+KKLUMUI0L2t4UIoY/DF5WkUL/J80ahvzGtP5ZgL/KYCuCaqUy4aAusT4oXcowN816KcDaks1gdt2iPpoC+WSU/HweXbBlLlKDMy13jTVfNVpDaZ3qgMrOaGF0V4sws2xMawfYEpVxtRv6+iRyFyG9++eWLPa6BeCXClMNt0+9mGbkAOe4IIl0sZCUg0wayYmVnzsPFUF5+pkj3oKrBpYPtYlaxwrikBWuVS9rwTXWbdkiontY569FRgzC0aSA2idxkQW5HUvE1/S8B9IWGDnjshsjehQ+NBDnStqqqNXnH8STWPTamb8VsSeCrmg/lMNK6sNA5FyXS/7LlFOnJg+Cbrog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(921020)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UYraqvPVY+teNVK7sdhw6rFokUl4wqnAewL2+9PRRsJ9TVHwe6UIiK+8SzztAxDwNEee3X9R95J2IkVx8BYsES0CCcIXxRJVI2WQdq9p0qLl7Ja0r68ExzyZjsJ2Fww7LsE10sM9h1jUoD0v1/YjEjDfQISJmol4AmiwlBJy+wVxYvqJSF6UViQ7mtq7bgVZPjofzVoAo2co2gMpBT6VNJn1ii02mLCdo6UeFHxh9JPLln+nxjEbm9IeGs0b6mrQMz0IK8mpR2TV3hqEK+JfEn1XTiBCoI51b4+GVsTuQsK08v9zSiYBksTQZM5wjsIB/wzfvD1J38dKx1ptlvYKDEhW/iQ4CtgfNkBuP+8/OwX/MU0/BWlhqoTuzpASSGyQIC8cEvmmF/Y65Xze7G1pu8Khc6WxOhRKukoBOgcpaEHqB2B2kMAowBfTTFcvrvEs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:42:47.5690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb89c50-aa11-4990-a96e-08deaf5ace58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Sairaj.K@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Use structs and macros to improve the readability and maintainability of
the the code. 

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 149 +++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 90 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 82208e06e155..e18c9be801a2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1663,11 +1663,13 @@ static void
 insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
 {
     GArray *table_data = opaque;
-    uint32_t entry;
+    AmdIvhdDeviceEntry entry = {};
 
     /* "Select" IVHD entry, type 0x2 */
-    entry = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn) << 8 | 0x2;
-    build_append_int_noprefix(table_data, entry, 4);
+    entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_SELECT;
+    entry.devid = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
+
+    g_array_append_vals(table_data, &entry, sizeof(entry));
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
@@ -1691,11 +1693,14 @@ insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
              */
             if (sec == sub) { /* leaf bus */
                 /* "Start of Range" IVHD entry, type 0x3 */
-                entry = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
-                build_append_int_noprefix(table_data, entry, 4);
+                entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_START_RANGE;
+                entry.devid = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
+                g_array_append_vals(table_data, &entry, sizeof(entry));
+
                 /* "End of Range" IVHD entry, type 0x4 */
-                entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
-                build_append_int_noprefix(table_data, entry, 4);
+                entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE;
+                entry.devid = PCI_BUILD_BDF(sub, PCI_DEVFN_MAX - 1);
+                g_array_append_vals(table_data, &entry, sizeof(entry));
             } else {
                 pci_for_each_device(sec_bus, sec, insert_ivhd, table_data);
             }
@@ -1708,24 +1713,26 @@ insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
              * express bridges, just as in pci_device_iommu_address_space().
              * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
              */
-            uint16_t dev_id_a, dev_id_b;
+            AmdIvhdDeviceEntryExt entry_ext = {};
 
-            dev_id_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
+            entry_ext.type = AMD_IVHD_DEVICE_ENTRY_TYPE_ALIAS_START_RANGE;
+            entry_ext.devid_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
 
             if (pci_is_express(dev) &&
                 pcie_cap_get_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
-                dev_id_b = dev_id_a;
+                entry_ext.devid_b = entry_ext.devid_a;
             } else {
-                dev_id_b = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
+                entry_ext.devid_b = PCI_BUILD_BDF(pci_bus_num(bus),
+                                                  dev->devfn);
             }
 
             /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
-            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
-            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
+            g_array_append_vals(table_data, &entry_ext, sizeof(entry_ext));
 
             /* "End of Range" IVHD entry, type 0x4 */
-            entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
-            build_append_int_noprefix(table_data, entry, 4);
+            entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE;
+            entry.devid = PCI_BUILD_BDF(sub, PCI_DEVFN_MAX - 1);
+            g_array_append_vals(table_data, &entry, sizeof(entry));
         }
     }
 }
@@ -1786,20 +1793,20 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     GArray *ivhd_blob = g_array_new(false, true, 1);
     AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
-    uint64_t feature_report;
     int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
     uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
+    AmdIvrsVendorHdr ivrs_hdr = {};
+    AmdIvhdHdr10 ivhd10 = {};
+    AmdIvhdHdr11 ivhd11 = {};
 
     acpi_table_begin(&table, table_data);
     /* IVinfo - IO virtualization information common to all
      * IOMMU units in a system
      */
-    build_append_int_noprefix(table_data,
-                             (1UL << 0) | /* EFRSup */
-                             AMDVI_PA_SIZE_52,
-                             4);
-    /* reserved */
-    build_append_int_noprefix(table_data, 0, 8);
+    ivrs_hdr.ivinfo = AMD_IVINFO_EFR_SUP | AMDVI_GVA_SIZE_48 |
+                      AMDVI_PA_SIZE_52 | AMDVI_VA_SIZE_64;
+
+    g_array_append_vals(table_data, &ivrs_hdr, sizeof(ivrs_hdr));
 
     /*
      * A PCI bus walk, for each PCI host bridge, is necessary to create a
@@ -1817,7 +1824,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
          *   These are 4-byte device entries currently reporting the range of
          *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
          */
-        build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
+        AmdIvhdDeviceEntry entry = { .type = AMD_IVHD_DEVICE_ENTRY_TYPE_ALL };
+        g_array_append_vals(ivhd_blob, &entry, sizeof(entry));
     }
 
     /*
@@ -1829,76 +1837,37 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
      * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
      */
     if (x86_iommu_ir_supported(x86_iommu_get_default())) {
-        build_append_int_noprefix(ivhd_blob,
-                                 (0x1ull << 56) |           /* type IOAPIC */
-                                 (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devid */
-                                 0x48,                      /* special device */
-                                 8);
-    }
-
-    /* IVHD definition - type 10h */
-    build_append_int_noprefix(table_data, 0x10, 1);
-    /* virtualization flags */
-    build_append_int_noprefix(table_data,
-                             (1UL << 0) | /* HtTunEn      */
-                             (1UL << 4) | /* iotblSup     */
-                             (1UL << 6) | /* PrefSup      */
-                             (1UL << 7),  /* PPRSup       */
-                             1);
-
-    /* IVHD length */
-    build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
-    /* DeviceID */
-    build_append_int_noprefix(table_data, iommu_devid, 2);
-    /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
-    /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
-    /* PCI Segment Group */
-    build_append_int_noprefix(table_data, 0, 2);
-    /* IOMMU info */
-    build_append_int_noprefix(table_data, 0, 2);
-    /* IOMMU Feature Reporting */
-    feature_report = get_amd_ivhd_feature_report(s);
-    build_append_int_noprefix(table_data, feature_report, 4);
-
+        AmdIvhdDeviceEntryExt entry_ext = {
+                    .type = AMD_IVHD_DEVICE_ENTRY_TYPE_SPECIAL_DEVICE,
+                    .devid_b = IOAPIC_SB_DEVID,
+                    .variety = IVHD_VARIETY_IOAPIC
+                };
+
+        g_array_append_vals(ivhd_blob, &entry_ext, sizeof(entry_ext));
+    }
+
+    ivhd10.type = 0x10;
+    ivhd10.flags = AMD_IVHD_FLAG_HT_TUN_EN | AMD_IVHD_FLAG_IOTLB_SUP |
+                   AMD_IVHD_FLAG_PREF_SUP  | AMD_IVHD_FLAG_PPR_SUP;
+    ivhd10.length = ivhd_blob->len + sizeof(ivhd10);
+    ivhd10.devid = iommu_devid;
+    ivhd10.capab_offset = s->pci->capab_offset;
+    ivhd10.base_addr = s->mr_mmio.addr;
+    ivhd10.iommu_feature_report = get_amd_ivhd_feature_report(s);
+    g_array_append_vals(table_data, &ivhd10, sizeof(ivhd10));
     /* IVHD entries as found above */
     g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
 
-   /* IVHD definition - type 11h */
-    build_append_int_noprefix(table_data, 0x11, 1);
-    /* virtualization flags */
-    build_append_int_noprefix(table_data,
-                             (1UL << 0) | /* HtTunEn      */
-                             (1UL << 4),  /* iotblSup     */
-                             1);
-
-    /* IVHD length */
-    build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
-
-    /* DeviceID */
-    build_append_int_noprefix(table_data, iommu_devid, 2);
-    /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
-    /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
-    /* PCI Segment Group */
-    build_append_int_noprefix(table_data, 0, 2);
-    /* IOMMU info */
-    build_append_int_noprefix(table_data, 0, 2);
-    /* IOMMU Attributes */
-    if (!s->iommu.dma_translation) {
-        build_append_int_noprefix(table_data, (1UL << 0) /* HATDis */, 4);
-    } else {
-        build_append_int_noprefix(table_data, 0, 4);
-    }
-    /* EFR Register Image */
-    build_append_int_noprefix(table_data,
-                              amdvi_extended_feature_register(s),
-                              8);
-    /* EFR Register Image 2 */
-    build_append_int_noprefix(table_data, 0, 8);
-
+    ivhd11.type = 0x11;
+    ivhd11.flags = AMD_IVHD_FLAG_HT_TUN_EN | AMD_IVHD_FLAG_IOTLB_SUP;
+    ivhd11.length = ivhd_blob->len + sizeof(ivhd11);
+    ivhd11.devid = iommu_devid;
+    ivhd11.capab_offset = s->pci->capab_offset;
+    ivhd11.base_addr = s->mr_mmio.addr;
+    ivhd11.iommu_attributes = !s->iommu.dma_translation <<
+                              AMD_IVHD_ATTRIBUTES_HATDIS_SHIFT;
+    ivhd11.efr = amdvi_extended_feature_register(s);
+    g_array_append_vals(table_data, &ivhd11, sizeof(ivhd11));
     /* IVHD entries as found above */
     g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
 
-- 
2.34.1


