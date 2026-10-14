Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEC9CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGrgK-0002BK-Od; Wed, 14 Oct 2026 01:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGrgF-00025H-4i
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:37:36 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGrgC-00037K-Qm
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:37:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOoI/6U41Vpx6FQXQ8YGGQxQxXjeHRxoo8vkgRylh2Z77CBo34RYdA+hFY0poELJ+XD7x7cJ0Ii8uLY7ltny0hkBYa+XvRdS5cSrWTGYJCJx+v4wB1INzJR51GyGpK1r8VdAkM/c6XeBkvQs3zQW5aptQVIt3ljqfFrJYnHx+hL0WbqOL0kT5slprzyqxjJLZVH0xrP61O62H0CAM+MHAFHV0QMM9Y08wi5nPxbe+1rV3MlpnB98QLMDJugU03/hIyu4284x++Rl1rU9DB9hetPp15FY691y0pcPuz5FIIrFQAFSlgwUaChL4xAPok8WRxfE0UdrqDstWSTPWacy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl6PPhRnOWm8On7ThO4fE5y3MWXKAEbJ38hmnjlbd2g=;
 b=f5Bl8SbKG/gQOHWsfT3f2iVQ7mBr+fELagSv1v3RpBrpPRYS2ATHDpri74M6MDlCurrQ2vhZXK9D7LeKkTZdWrdffkf8fVj8Il2MfrqJnITkKc1RvWJVKH4yYbd+6pz5slEDF3Wx+n2lIYtJBnoNGaSLODkdaM8vomAUKPbSsKMVvvfiF33fXZSX4UMG406SybqYGu5Me+OSkKytQF50VrBY/shp36yGoM5lL6hEDAe8RIQwfnq/Dunjba7FhihoEqGFYT8yY1sleM1/CUQX4jbccM3zSvEv3D1SU5umFcjCkY+D984UlNOeSR3EVHqsrME3n3ie1RnyHjJtGdkJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl6PPhRnOWm8On7ThO4fE5y3MWXKAEbJ38hmnjlbd2g=;
 b=nxqm3v1Ejbo2Aarv3v+VWKl/E1xEHiu7Lgwag3em+WX/5OQVipAJ2wmejbBYbd2KXXhsdDriv1WTs2Zk31XPkPVA/r5zkvwaFjqWWU+qqbQFlC8ybmvmt44r49XXBkFqxjyxBeyrR2kqLYqPGnIObYlFu/BoeZuN4dVsSzpkdGM=
Received: from SJ0PR05CA0120.namprd05.prod.outlook.com (2603:10b6:a03:334::35)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.26; Wed, 14 Oct
 2026 05:37:23 +0000
Received: from MW2PEPF00014673.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::72) by SJ0PR05CA0120.outlook.office365.com
 (2603:10b6:a03:334::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 05:37:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014673.mail.protection.outlook.com (10.167.249.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:37:23 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:37:12 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Jason Wang <jasowangio@gmail.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, Yi Liu <yi.l.liu@intel.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 7/8] acpi-build: Create PCI topology using amd iommu root bus
Date: Wed, 14 Oct 2026 11:04:32 +0530
Message-ID: <20261014053433.24564-8-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014053433.24564-1-sarunkod@amd.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014673:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 0612c30f-63f0-414e-a72f-08df29b53946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|7416014|376014|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EnJLZMVDLGn0aekJkJKzWm343GRzc8mWYYH+LpeN3iSdVONBBFVRGfRut1PIAj3O0++mcAfUjfXw54ea0oyzXEBJ4/OO8WvviSt/Kp7lrDS1mOBZY/LWqAGPx0Z50eZca3ujogsz2p1tsS/R6VymPcI9PrFIfOV2kMe8COnfVbUkx7KbKicEThNX7NwndUd/lC2cgoQEBsavyjyHtX8mFprlMhjD4VYZA3rijvPGA2u4H4aRhrCQ8TG3NkgXl0TL7iYempDBeBODlGyrscgdsfMs2x7d0JiFC/T6ggbiQh8wsH9KODPZEffuvrCoKJONy1ruFc2vxekIsSrkCeHi/q/HAw8QwdXmSxHnbR79RaQoSbo+u8EaDPi5O0YKQ3UYkKP3ffucs5c8CVFZQvIPmbt2kuTnbypiXCGVmYAQS5LLXARCatw7EL3jHWaqBpThFpoz1C1UVe3dbj+FMjjI/DIeeGutaA1G0ClnNJ7re7KAtAHJ3929+kb+aYQWjJiG9RV/IVZRY0eaCrL28k3sIR3I9KWKNIBGSdVAYFzA5tOQJB2bDUZ9ZXv3yUSGfDcs2xoTnI5oMY5GdTBQjf7qXDQdz95S61bCL0fMwGF9JZeSyhWAell+LaJQmzBGZrTMsUi0fnwGNLRh9Vt2g9Rm42vwwUBQacxd8kb7ujg8BUz0PW4nLYbKHfaOklVRuoXyxNwTIJVmHH/MJr11Ox6oz+VzhTvyOLr6e2Nv06XR8OsOF5buFfiy9/qfPvMEiBxu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(7416014)(376014)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 61xgZ4KVa+wtIq2rrK7iL70ThCtOhDXdXgr/IRgrjpqOjfKsrG51JCp0k1Kr8poLJhZvJaJjPuQcap61C4uylTS9LUEjpKa1wcvoC3sq8B8B/4vHebpIbndsxQv5IPfk1e+OdbU/X6cTQZZkdx+rnGC4xg+OeA+P6II4sPhN3wrvZaeQnZRJI2cBeWRUDkGt0MQtp2g4FvxB+ARecbhvJ8A5FdtbJ1fihqna8mhCmljgqL6TG6EA6Fld/m4tLskolDw/wlXf6ir3J44yvOBfhG77hjg9IFpp8zkAXydzBGK9RedgKfM+WXh7CckouQn1lXx5JPf7nrIXA1g5Mrhw+WecBmLlQD/K4Kc+i7tL+p5GWeYAaN3Blaeh1hkgNaGTqGU0pkB9O6vmoR226XZBTFwrAzfZISUY0GNhYV44XUZ2o1Oo/5c1FW3QP7lMFn23
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:37:23.5817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0612c30f-63f0-414e-a72f-08df29b53946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014673.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Sairaj.K@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Current AMD IOMMU ACPI build adds all the devices and buses under the
IVHD. In order to support the IOMMU attached on a non system bus and
serving only child devices of that bus, start exploring devices from the
child bus. Also, use child list provided by the PCIBus, instead of
iterating over all the objects in the qemu to find pci bridges.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 142 ++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 68 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8837b69687d1..ed944c819406 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1760,83 +1760,89 @@ insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
     /* "Select" IVHD entry, type 0x2 */
     entry = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn) << 8 | 0x2;
     build_append_int_noprefix(table_data, entry, 4);
+}
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
-        PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
-        uint8_t sec = pci_bus_num(sec_bus);
-        uint8_t sub = dev->config[PCI_SUBORDINATE_BUS];
-
-        if (pci_bus_is_express(sec_bus)) {
-            /*
-             * Walk the bus if there are subordinates, otherwise use a range
-             * to cover an entire leaf bus.  We could potentially also use a
-             * range for traversed buses, but we'd need to take care not to
-             * create both Select and Range entries covering the same device.
-             * This is easier and potentially more compact.
-             *
-             * An example bare metal system seems to use Select entries for
-             * root ports without a slot (ie. built-ins) and Range entries
-             * when there is a slot.  The same system also only hard-codes
-             * the alias range for an onboard PCIe-to-PCI bridge, apparently
-             * making no effort to support nested bridges.  We attempt to
-             * be more thorough here.
-             */
-            if (sec == sub) { /* leaf bus */
-                /* "Start of Range" IVHD entry, type 0x3 */
-                entry = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
-                build_append_int_noprefix(table_data, entry, 4);
-                /* "End of Range" IVHD entry, type 0x4 */
-                entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
-                build_append_int_noprefix(table_data, entry, 4);
-            } else {
-                pci_for_each_device(sec_bus, sec, insert_ivhd, table_data);
-            }
-        } else {
-            /*
-             * If the secondary bus is conventional, then we need to create an
-             * Alias range for everything downstream.  The range covers the
-             * first devfn on the secondary bus to the last devfn on the
-             * subordinate bus.  The alias target depends on legacy versus
-             * express bridges, just as in pci_device_iommu_address_space().
-             * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
-             */
-            uint16_t dev_id_a, dev_id_b;
-
-            dev_id_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
+/*
+ * Insert IVHD entry for device and recurse, insert alias, or insert range as
+ * necessary for the PCI topology.
+ */
+static void add_ivhd_entries_from_bus(PCIBus *bus, GArray *table_data)
+{
+    uint8_t sub;
+    uint32_t entry;
+    PCIBus *child_bus;
+    PCIDevice *parent_dev;
 
-            if (pci_is_express(dev) &&
-                pcie_cap_get_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
-                dev_id_b = dev_id_a;
-            } else {
-                dev_id_b = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
-            }
+    if (!bus->parent_dev) {
+        goto select_devices;
+    }
 
-            /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
-            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
-            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
+    parent_dev = bus->parent_dev;
+    sub = parent_dev->config[PCI_SUBORDINATE_BUS];
 
-            /* "End of Range" IVHD entry, type 0x4 */
-            entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
-            build_append_int_noprefix(table_data, entry, 4);
+    if (pci_bus_is_express(bus)) {
+        /*
+         * Walk the bus if there are subordinates, otherwise use a range
+         * to cover an entire leaf bus.  We could potentially also use a
+         * range for traversed buses, but we'd need to take care not to
+         * create both Select and Range entries covering the same device.
+         * This is easier and potentially more compact.
+         *
+         * An example bare metal system seems to use Select entries for
+         * root ports without a slot (ie. built-ins) and Range entries
+         * when there is a slot.  The same system also only hard-codes
+         * the alias range for an onboard PCIe-to-PCI bridge, apparently
+         * making no effort to support nested bridges.  We attempt to
+         * be more thorough here.
+         */
+        if (sub != pci_bus_num(bus)) {
+            goto select_devices;
         }
-    }
-}
+        /* "Start of Range" IVHD entry, type 0x3 */
+        entry = PCI_BUILD_BDF(sub, PCI_DEVFN(0, 0)) << 8 | 0x3;
+        build_append_int_noprefix(table_data, entry, 4);
+        /* "End of Range" IVHD entry, type 0x4 */
+        entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
+        build_append_int_noprefix(table_data, entry, 4);
 
-/* For all PCI host bridges, walk and insert IVHD entries */
-static int
-ivrs_host_bridges(Object *obj, void *opaque)
-{
-    GArray *ivhd_blob = opaque;
+        return;
+    } else {
+        /*
+         * If the secondary bus is conventional, then we need to create an
+         * Alias range for everything downstream.  The range covers the
+         * first devfn on the secondary bus to the last devfn on the
+         * subordinate bus.  The alias target depends on legacy versus
+         * express bridges, just as in pci_device_iommu_address_space().
+         * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
+         */
+        uint16_t dev_id_a, dev_id_b;
 
-    if (object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
-        PCIBus *bus = PCI_HOST_BRIDGE(obj)->bus;
+        dev_id_a = PCI_BUILD_BDF(pci_bus_num(bus), PCI_DEVFN(0, 0));
 
-        if (bus && !pci_bus_bypass_iommu(bus)) {
-            pci_for_each_device_under_bus(bus, insert_ivhd, ivhd_blob);
+        if (pci_is_express(parent_dev) &&
+            pcie_cap_get_type(parent_dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
+            dev_id_b = dev_id_a;
+        } else {
+            dev_id_b = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(parent_dev)),
+                                     parent_dev->devfn);
         }
+
+        /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
+        build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
+        build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
+
+        /* "End of Range" IVHD entry, type 0x4 */
+        entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
+        build_append_int_noprefix(table_data, entry, 4);
+        return;
     }
 
-    return 0;
+select_devices:
+    pci_for_each_device_under_bus(bus, insert_ivhd, table_data);
+
+    QLIST_FOREACH(child_bus, &bus->child, sibling) {
+        add_ivhd_entries_from_bus(child_bus, table_data);
+    }
 }
 
 static void
@@ -1867,8 +1873,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
      * blob further below.  Fall back to an entry covering all devices, which
      * is sufficient when no aliases are present.
      */
-    object_child_foreach_recursive(object_get_root(),
-                                   ivrs_host_bridges, ivhd_blob);
+    assert(s->root_bus);
+    add_ivhd_entries_from_bus(s->root_bus, ivhd_blob);
 
     if (!ivhd_blob->len) {
         /*
-- 
2.34.1


