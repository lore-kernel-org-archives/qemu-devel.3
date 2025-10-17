Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA03CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9djN-00048C-0o; Fri, 17 Oct 2025 02:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v9djH-00046e-IE
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:14:19 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v9djA-0008EC-8Q
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:14:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AK9Ub6U7FzzIiyC3jbMh8LJKRVUQ/ZFLi7bJnmJwPF2T9OTiptziuFbZobsrmIwnEsiX99vXuTs2V40HY3t2guMeCexk4F5ZKw71wbQW/pmfuQAt3ExQj9EwvNfJ26tcWysiBF1PxESZFNyKGevown671n4+gBJ1XTK7gMAH6GBFQiNTG6wTziYeipwAB/PHsDw0c+2N/ywcNkoEGeLFsDDJo1GF/EVSKsVuTTaZNUdPG/Eukts5v+EM5iC3usvkSJyxiwwIuTCAAp5jr4g9+ln67NoKMvYg97G7Zf3ECjcm+69zashPJWhK36C7WAL5kGxYedxYzMCYt7hJezJQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eDHNYGps80/GWk5RXKJFTRJ/9Eprvu8TgDU8S/H3rw=;
 b=MjQb65YbPJLhnjc+dxkl7VahhrNtazv6omDkZ4MNF1t2XYEZqMEtKcFZovFTBTcqok/LZ8PrDs2lbSTRUCemGN2tm0CVlUeGP0D4KaH8QVaQya72RBJW1/BigO5N1WJehLRrbxTWFm7L0V1liyNm7tgpSFqzjjRDjDBmWaYZoU7yQAoZU7vQ0gk/OHNttd3niwKw9IhN6jdOrrRGr9pw82lZwZqAt7FhvX7GZCodLfLOeu9N6uPah+24pdkI5k2fdHpMh3f1P+MIIVvmr+zf2qDMkVBcYVfpZN3cSKLPgsJ5mZ6dqJQhc1j9Om9egeH6T7sON6G30x05JVkp+LcLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eDHNYGps80/GWk5RXKJFTRJ/9Eprvu8TgDU8S/H3rw=;
 b=czQuwptiPxB9HOjtA8pYDnPXBZR30qBR6bZu9XodgBjOLb177IbqWRLKbHadh1RCz5UlJ1IpYDu72pIG5eq+KkwvyDqYzg0tHzuUuV45ojDy8w+zkhpS3sx7cUmm97LziHj3vCJFavL4YMJEVN/cG68v4AZH9jPwP73n/sVMtcc=
Received: from CH0PR04CA0031.namprd04.prod.outlook.com (2603:10b6:610:77::6)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:14:01 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::e) by CH0PR04CA0031.outlook.office365.com
 (2603:10b6:610:77::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 06:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 06:14:01 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:13:57 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>
Subject: [PATCH v3 1/2] amd_iommu: Fix handling device on buses != 0
Date: Fri, 17 Oct 2025 11:43:21 +0530
Message-ID: <20251017061322.1584-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017061322.1584-1-sarunkod@amd.com>
References: <20251017061322.1584-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 47eaf00b-3803-4b6e-ed8a-08de0d445dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8jKA3Fzbkg2jIFoUlFPymO7qRYbYddTFsMiNDV2Kq8aeVNX869cpPqfD8XD1?=
 =?us-ascii?Q?m+iZ0WnCaJ+nrPfLaAQQmHePo+vkT51IoOeX9CJV50WjyHQNnpxTAFprB07p?=
 =?us-ascii?Q?9zl++7WS+f2I4GF3ntqQEhlsh6xW37OCZWhJO7fK56vnTWg7YnmCfnP2/UXt?=
 =?us-ascii?Q?VNlk4gBEg18AdpKIxRQqkqWpcI645sj7WKODjsOuGKCzOiKNBnw+EjAMXZYU?=
 =?us-ascii?Q?J/jJQ3SWZqe8lng77bHSZZ3eKaA6wBrgtC2C9xBVCxig75Ph7bUT8/9EiS2C?=
 =?us-ascii?Q?x0thn3NLHltxrGvRIAsMIuiPZ7mjL9jJuOF71MmEYGtcfeQHN8Wdqo44FKrQ?=
 =?us-ascii?Q?cUFnQ2kX9H/4ojWXGRUY2Blhu8hxWcR3jhrWsZnMkR26ZTfbhxmFi1vydHlX?=
 =?us-ascii?Q?hDMrhMbC4xCdNlBE9ggmw/vxM95XApVnpxkMdKcKqOaTk/+Fs9oQprASaAhC?=
 =?us-ascii?Q?YKBHhRfNQnJDkIuU7uNK80tqYk+LIFFp5gtZnqK7JVCCp7Rehm1LzxeqKt4q?=
 =?us-ascii?Q?5yxIQs6weTMSspkjYv3enpEOXZ+DmOMJyK+CoRSQOUWK0xg4qpAMJk7HqL+m?=
 =?us-ascii?Q?h500o/kTE1B2z3j0R3AoVO1SExDVP8BbPRjhNIAcFSX42DBVUT4VMQWDqWrv?=
 =?us-ascii?Q?yM1YKEfLyHV3RjBdVHiPl6Vw+j1wvs+ajUc8cY1I1p+0MH/7JvqkRAl+VK2H?=
 =?us-ascii?Q?vZq5DlbXqK4mxBKW4Ro0cGdNJtw04jkRPwEAOXU1iio/n1vnpCfC2FV2E8zk?=
 =?us-ascii?Q?W95Ycbz0VDDknvbC1HmJrioBzireVuDzT6cG19zb5EEoloxzhp87kD/lIuu/?=
 =?us-ascii?Q?RTFJOATC/eG62lSa1poLvxwnxKuOQbqkD/YErFRRvX4kd0K1UqkXIXZ5aCm8?=
 =?us-ascii?Q?dc41MUwPqrbirosaTtm6RrU+Zmc9WowhYGrvgHpo7P21iiRI+PlraRPQiz5V?=
 =?us-ascii?Q?7+nIBHptok7+dK7OHcpAM2cEkCseUTh5q0UdExQtQ4fD+3TT1oFxOCq/t4i0?=
 =?us-ascii?Q?dLE0gMoAoe5oTvr4Xr+wRepS/so1IvU65vP6aG+oQiTpK0ljsVieJwxrrOtF?=
 =?us-ascii?Q?6tmjgHt45Td4Sbp2d9Axwx8tIRUqxrcieBlIq3vKkV4n5WCn4akvLTwbRUOk?=
 =?us-ascii?Q?VYSIZX5JGm9jgmtu0ONiXg1w1jYNVFNiqSGEcNzZgH9YLEmN2CAkSR/cfx4d?=
 =?us-ascii?Q?0zQiQpsb4zSPl8L9xztKqWZME+XfgEQf6LDmb/5Ht2yUWkAj15kPlYx3hB7r?=
 =?us-ascii?Q?UbEE3J9ZmoBVUBJ1R5TJcH4Ao8dj+AcgVQePqDmTcc0fO5x6l3vZ+zb8GY+p?=
 =?us-ascii?Q?K5P24BWT1shuqCJh9CS6G9DSFx4CRP5qOC4V8keB2cG2QZjuNVNgE4KY5iZs?=
 =?us-ascii?Q?2Zzs8dR0s/kt4W23RM9uFhMuu79GkiJMFZWE5UfLlpQG9uhW2Yqu7vaVjtQA?=
 =?us-ascii?Q?RCqFsu3DZH/M8nlT+8yd+IW7H0MDmYMK2yCTcq/1bhsueFPwfJ9zSBtQR9m/?=
 =?us-ascii?Q?aeLpIDuWLai9OieFx6PLwo7Dki1p4UfFhXXZHF4cyMRApgZPCiqrzgWJUN3t?=
 =?us-ascii?Q?tJ2VtA5u7g3Ild7IwIg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:14:01.3009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47eaf00b-3803-4b6e-ed8a-08de0d445dad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
for indexing into DTE. The problem is that before the guest started,
all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
kernel will do that later) so relying on the bus number is wrong.
The immediate effect is emulated devices cannot do DMA when places on
a bus other that 0.

Replace static array of address_space with hash table which uses devfn and
PCIBus* for key as it is not going to change after the guest is booted.

Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
 hw/i386/amd_iommu.h |   2 +-
 2 files changed, 79 insertions(+), 57 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 378e0cb55eab..c2cd5213eb1b 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
 };
 
 struct AMDVIAddressSpace {
-    uint8_t bus_num;            /* bus number                           */
+    PCIBus *bus;                /* PCIBus (for bus number)              */
     uint8_t devfn;              /* device function                      */
     AMDVIState *iommu_state;    /* AMDVI - one per machine              */
     MemoryRegion root;          /* AMDVI Root memory map region         */
@@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
     AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
 } AMDVIFaultReason;
 
+typedef struct AMDVIAsKey {
+    PCIBus *bus;
+    uint8_t devfn;
+} AMDVIAsKey;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
     return (guint)*(const uint64_t *)v;
 }
 
+static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
+{
+    const AMDVIAsKey *key1 = v1;
+    const AMDVIAsKey *key2 = v2;
+
+    return key1->bus == key2->bus && key1->devfn == key2->devfn;
+}
+
+static guint amdvi_as_hash(gconstpointer v)
+{
+    const AMDVIAsKey *key = v;
+    guint bus = (guint)(uintptr_t)key->bus;
+
+    return (guint)(bus << 8 | (uint)key->devfn);
+}
+
+static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
+                                          uint8_t devfn)
+{
+    const AMDVIAsKey key = { .bus = bus, .devfn = devfn };
+    return g_hash_table_lookup(s->address_spaces, &key);
+}
+
+static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
+                                       gpointer user_data)
+{
+    const AMDVIAsKey *as = key;
+    const uint16_t *devidp = user_data;
+
+    return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+}
+
+static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
+{
+    return g_hash_table_find(s->address_spaces,
+                             amdvi_find_as_by_devid, &devid);
+}
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
@@ -551,7 +594,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
 {
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIState *s = as->iommu_state;
 
     if (!amdvi_get_dte(s, devid, dte)) {
@@ -1011,25 +1054,15 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
  */
 static void amdvi_reset_address_translation_all(AMDVIState *s)
 {
-    AMDVIAddressSpace **iommu_as;
-
-    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
+    AMDVIAddressSpace *iommu_as;
+    GHashTableIter as_it;
 
-        /* Nothing to do if there are no devices on the current bus */
-        if (!s->address_spaces[bus_num]) {
-            continue;
-        }
-        iommu_as = s->address_spaces[bus_num];
+    g_hash_table_iter_init(&as_it, s->address_spaces);
 
-        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
-
-            if (!iommu_as[devfn]) {
-                continue;
-            }
-            /* Use passthrough as default mode after reset */
-            iommu_as[devfn]->addr_translation = false;
-            amdvi_switch_address_space(iommu_as[devfn]);
-        }
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
+        /* Use passhthrough as default mode after reset */
+        iommu_as->addr_translation = false;
+        amdvi_switch_address_space(iommu_as);
     }
 }
 
@@ -1089,27 +1122,15 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
  */
 static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
 {
-    uint8_t bus_num, devfn, dte_mode;
+    uint8_t dte_mode;
     AMDVIAddressSpace *as;
     uint64_t dte[4] = { 0 };
     int ret;
 
-    /*
-     * Convert the devid encoded in the command to a bus and devfn in
-     * order to retrieve the corresponding address space.
-     */
-    bus_num = PCI_BUS_NUM(devid);
-    devfn = devid & 0xff;
-
-    /*
-     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
-     * been allocated within AMDVIState, but must be careful to not access
-     * unallocated devfn.
-     */
-    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
+    as = amdvi_get_as_by_devid(s, devid);
+    if (!as) {
         return;
     }
-    as = s->address_spaces[bus_num][devfn];
 
     ret = amdvi_as_to_dte(as, dte);
 
@@ -1783,7 +1804,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
                                bool is_write, IOMMUTLBEntry *ret)
 {
     AMDVIState *s = as->iommu_state;
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
@@ -1858,7 +1879,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     }
 
     amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
-    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
+    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
             PCI_FUNC(as->devfn), addr, ret.translated_addr);
     return ret;
 }
@@ -2222,30 +2243,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     char name[128];
     AMDVIState *s = opaque;
-    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
-    int bus_num = pci_bus_num(bus);
+    AMDVIAddressSpace *amdvi_dev_as;
+    AMDVIAsKey *key;
 
-    iommu_as = s->address_spaces[bus_num];
+    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
 
     /* allocate memory during the first run */
-    if (!iommu_as) {
-        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
-        s->address_spaces[bus_num] = iommu_as;
-    }
-
-    /* set up AMD-Vi region */
-    if (!iommu_as[devfn]) {
+    if (!amdvi_dev_as) {
         snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
 
-        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
-        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
-        iommu_as[devfn]->devfn = (uint8_t)devfn;
-        iommu_as[devfn]->iommu_state = s;
-        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
-        iommu_as[devfn]->iova_tree = iova_tree_new();
-        iommu_as[devfn]->addr_translation = false;
+        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
+        key = g_new0(AMDVIAsKey, 1);
 
-        amdvi_dev_as = iommu_as[devfn];
+        amdvi_dev_as->bus = bus;
+        amdvi_dev_as->devfn = (uint8_t)devfn;
+        amdvi_dev_as->iommu_state = s;
+        amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
+        amdvi_dev_as->iova_tree = iova_tree_new();
+        amdvi_dev_as->addr_translation = false;
+        key->bus = bus;
+        key->devfn = devfn;
+
+        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
 
         /*
          * Memory region relationships looks like (Address range shows
@@ -2288,7 +2307,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
         amdvi_switch_address_space(amdvi_dev_as);
     }
-    return &iommu_as[devfn]->as;
+    return &amdvi_dev_as->as;
 }
 
 static const PCIIOMMUOps amdvi_iommu_ops = {
@@ -2329,7 +2348,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
         error_setg_errno(errp, ENOTSUP,
             "device %02x.%02x.%x requires dma-remap=1",
-            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
         return -ENOTSUP;
     }
 
@@ -2510,6 +2529,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
+    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
+                                     amdvi_as_equal, g_free, g_free);
+
     /* set up MMIO */
     memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index daf82fc85f96..38471b95d153 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -408,7 +408,7 @@ struct AMDVIState {
     bool mmio_enabled;
 
     /* for each served device */
-    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
+    GHashTable *address_spaces;
 
     /* list of address spaces with registered notifiers */
     QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
-- 
2.34.1


