Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76787CCD183
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XH6-00033h-8Z; Wed, 08 Oct 2025 12:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v6XH4-00033Z-Uh
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:44:23 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v6XGw-0002aM-VK
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:44:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM+YQR+YKp8SQ4QI8MwMamq8qCQb55rl1eukQNZxWQaYXlGZJwKuEFxzgTri6f4OWm5DpTk6lqEm5JqB0FIgb+r8jf8Mpa6dg18LucBcMv+66y6cDKBkHZUt95/avYi7sU7Laa0sFEtZxTJ2QRBgamNvsJssS1goxS3QtIppFGbQJqNNaCvYbsU6nSxznYDloHeOfkhSK0b4QNWg3TCmPkbAbHHHtsrekYAikZDqBSg34k5PBerNekGkklF1U5JMUBWRv/GcZfQyv6SvbmZn9Fi8oH7IaGv5sJI0uVuqY5UdBnZAQsEsfuXbeTo4/eGuHhNSmoKUtPnbZ19PBt4wlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HjDMp1I8jOu8X348MNHw0iLDBvbsqpi03fpV2zaYeY=;
 b=leDE8s1OK4VMu272GhMX1LSubbDrcAXfi4wr9hu0WV6x3POCzksFnTfdCSn3YDa+cZAEqbcqVQQdRl8ZqTSG5U7Ilf3kYMSQku7/LwHf5zegAsOhGyAqSs6dNCCjQDFxvDDKDWGynNIE5DqvrSo+RwkYkPjYLkj6R94uyLQYAmUAGVKDmBPBfkRuxnGF4vUDbRJQlPNXwlKke/tqrTw1WBIGQSUf6gTMfeIifApTAr1rICVQGZBJbxfaBo4An8AVRzTrfZhP5JHzFq9pa6rlGSat5pwwewsCwe+MO23YZvyP95ZmN3LJDTmuEyjalFjPjmekMr/qJMNwfqjsWwBzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HjDMp1I8jOu8X348MNHw0iLDBvbsqpi03fpV2zaYeY=;
 b=bsbMVfSKY8a2cmDbJ5LUBvE5ux3tDiJ7TFYPCg93ECPMr87pLOSS3xAhuOgTc4CkLPnz4ik1AcBP+Vwl9DokNozMJk6PzUA9T7+JDWZvICw1GiNd3ZJMGAHG9zXG1R0O8vxtq/ZQmYoYlMbdbfT3SMdF0qdClyPD+rcakHlxCcg=
Received: from SN7PR04CA0103.namprd04.prod.outlook.com (2603:10b6:806:122::18)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 8 Oct
 2025 16:44:01 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::91) by SN7PR04CA0103.outlook.office365.com
 (2603:10b6:806:122::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 16:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 16:44:01 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 09:43:56 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>,
 <santosh.shukla@amd.com>, <aik@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 1/2] hw/i386/amd_iommu: Fix handling device on buses != 0
Date: Wed, 8 Oct 2025 22:13:23 +0530
Message-ID: <20251008164324.21553-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008164324.21553-1-sarunkod@amd.com>
References: <20251008164324.21553-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d07f632-93ce-4b1f-b322-08de0689e28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?shqHQq9rpu84CUXsaJ4JieNR4wR5HbtOllXI2bPV3ix/vyLeYLCD42jPxz+x?=
 =?us-ascii?Q?cbyqYpvxzlbiSfu76W/yTQs1rqN2UTeeMgrnmfGkKYQDYp/j76BGXSHaZm0t?=
 =?us-ascii?Q?9CpVeildhhwvHfa9u4QVxYJ93bkIF43mCKEspBJ8/teuGkQAyrnU+f6up4L4?=
 =?us-ascii?Q?PvzUsViedartDB7dROG+QUUpX2pzb3I4TPOczGFFTVYPsDX99CNu6nDAfQOM?=
 =?us-ascii?Q?CRk9rvwFSiChjn/p75GezFvEEVN5EqQp21uETL+yB0XhnGylnyk/RKNCT2FK?=
 =?us-ascii?Q?0gIcAxKBkNVBLKs801z1Q2AVkHBfzMXTYgn7hh3dYnsAxouMPimOV9/hizZb?=
 =?us-ascii?Q?G7fhup6RwNXFGeewbVpbNkbPZjJ/7PxuDbacBWl8nDmN/iRURJskuFaAnXGf?=
 =?us-ascii?Q?gc5SZxNSMfxsrzxNhhgpZssRZUZUhdEZXEU3FSyiNj2fFLcdRONslrla99Mo?=
 =?us-ascii?Q?vkQ2vX+DciMjMeuFjpK0lAGezi+KlEM4MSEcj7i1Gx4fhXqSRanQmrO+c/p+?=
 =?us-ascii?Q?nc+jHKSD3txr8yjO7yBzxnBpXShIeEIGUuyhQMgt4wbaHzJeUjGkjmzgbNe0?=
 =?us-ascii?Q?e9Brf/N07lqr3n6v3l0YOSRQwKReUhmigdIF4X6xay/X5CKVeyiTRLf5MVtG?=
 =?us-ascii?Q?Anm0Kj0dneZ5gU0W7N7EhFmBBhjLMZ5JPfRGvlY/m4nSv8VUluKRT+HUAFpC?=
 =?us-ascii?Q?VWOViJYHns4eEo24SurlzsLNnQm+W0nS3lx/C1sxW9Wb5ioKWJ5XyEF+80sN?=
 =?us-ascii?Q?haJT3ExnirmBvbAiuABBk9vzlD786SX4bTsR7LVksrilRJ702GwxxYbhv4u4?=
 =?us-ascii?Q?iTiVxcuYg59r9uhMl9J8GRyyhYLzGpbG+tK0LTA7Nuy0YhmEt7xYFpsS8Dop?=
 =?us-ascii?Q?psgXZuhy+DBQBmwMuH7Lg3WJ8IG0zmnSWaFl83eHdjAyMI+7wsr/eq1Ac95d?=
 =?us-ascii?Q?h0NJU9ZILlTgJ14FDH8CJIbZ6uFxJyVLw3orrqV8fDJ1Zc5bTdK22ITWQbd8?=
 =?us-ascii?Q?TL2NLWclStfDQiqOb5K7sWJr5NcwXLSQxwFKs9jUVeRBTKxsKXcsmbIJeJTL?=
 =?us-ascii?Q?sVKWVKkkezeWhA1P1VpDvxnlhIfEI+Eh21XlYfhD5D9f5jMQRRYuy1GhiZnR?=
 =?us-ascii?Q?KPDN9+QfU289dVHfEVxNDhzlZ/hYeF/eRdC4AvUEuUyEJjBo/rjS4NjBjRi+?=
 =?us-ascii?Q?YDyRrrJWz1HI5gjc9reF/6i/P+BLcE8XIDTOzW8xhDhHGsGaNOChEJu2Z1+T?=
 =?us-ascii?Q?f5QbHs1jaOYk2l0zY3ZSiQ+UhJ0nDVhnzJs06esKFudwRXlEcQAtBHHi/MCu?=
 =?us-ascii?Q?ga+voJermUVMR6vI0csiW+rYV/zXlPjietIjahJcPSlDXfA7lwm8fs/rD0bP?=
 =?us-ascii?Q?9p5LNehgc5lP0bWStSupXmaCtUrDvFa9a5mMl0ujn3YlyvHq9UtzJIdiUjox?=
 =?us-ascii?Q?J2uitePcgdciwE3e8rBEKCoNzRnQdeaR/xi9NSk5fg9cXXArv6bEaVi7o5qc?=
 =?us-ascii?Q?Csgq2R2B1af+oqOardbfLQYkN++WZWA3lEg5nMnlABS9GkpHKn95YByMhGRi?=
 =?us-ascii?Q?TJjM9Baj4O0h8eFJHn0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 16:44:01.3878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d07f632-93ce-4b1f-b322-08de0689e28e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
 hw/i386/amd_iommu.c | 127 ++++++++++++++++++++++++++------------------
 hw/i386/amd_iommu.h |   2 +-
 2 files changed, 77 insertions(+), 52 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 378e0cb55eab..0a4b4d46d885 100644
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
 
+typedef struct amdvi_as_key {
+    PCIBus *bus;
+    int devfn;
+} amdvi_as_key;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -382,6 +387,42 @@ static guint amdvi_uint64_hash(gconstpointer v)
     return (guint)*(const uint64_t *)v;
 }
 
+static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
+{
+    const struct amdvi_as_key *key1 = v1;
+    const struct amdvi_as_key *key2 = v2;
+
+    return key1->bus == key2->bus && key1->devfn == key2->devfn;
+}
+
+static guint amdvi_as_hash(gconstpointer v)
+{
+    const struct amdvi_as_key *key = v;
+    return (guint)((uint64_t)key->bus | (key->devfn << 24));
+}
+
+static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
+                                          int devfn)
+{
+    amdvi_as_key key = { .bus = bus, .devfn = devfn };
+    return g_hash_table_lookup(s->address_spaces, &key);
+}
+
+static int amdvi_find_as_by_devid(gpointer key, gpointer value,
+                                  gpointer user_data)
+{
+    amdvi_as_key *as = (struct amdvi_as_key *)key;
+    uint16_t devid = *((uint16_t *)user_data);
+
+    return devid == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
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
@@ -551,7 +592,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
 {
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIState *s = as->iommu_state;
 
     if (!amdvi_get_dte(s, devid, dte)) {
@@ -1011,25 +1052,14 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
  */
 static void amdvi_reset_address_translation_all(AMDVIState *s)
 {
-    AMDVIAddressSpace **iommu_as;
-
-    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
-
-        /* Nothing to do if there are no devices on the current bus */
-        if (!s->address_spaces[bus_num]) {
-            continue;
-        }
-        iommu_as = s->address_spaces[bus_num];
+    AMDVIAddressSpace *iommu_as;
+    GHashTableIter as_it;
 
-        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
+    g_hash_table_iter_init(&as_it, s->address_spaces);
 
-            if (!iommu_as[devfn]) {
-                continue;
-            }
-            /* Use passthrough as default mode after reset */
-            iommu_as[devfn]->addr_translation = false;
-            amdvi_switch_address_space(iommu_as[devfn]);
-        }
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
+        iommu_as->addr_translation = false;
+        amdvi_switch_address_space(iommu_as);
     }
 }
 
@@ -1089,27 +1119,21 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
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
     /*
      * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
      * been allocated within AMDVIState, but must be careful to not access
      * unallocated devfn.
      */
-    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
+
+    as = amdvi_get_as_by_devid(s, devid);
+    if (!as) {
         return;
     }
-    as = s->address_spaces[bus_num][devfn];
 
     ret = amdvi_as_to_dte(as, dte);
 
@@ -1783,7 +1807,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
                                bool is_write, IOMMUTLBEntry *ret)
 {
     AMDVIState *s = as->iommu_state;
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
@@ -1858,7 +1882,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     }
 
     amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
-    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
+    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
             PCI_FUNC(as->devfn), addr, ret.translated_addr);
     return ret;
 }
@@ -2222,30 +2246,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     char name[128];
     AMDVIState *s = opaque;
-    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
-    int bus_num = pci_bus_num(bus);
+    AMDVIAddressSpace *amdvi_dev_as;
+    amdvi_as_key *key;
 
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
+        key = g_new0(amdvi_as_key, 1);
 
-        amdvi_dev_as = iommu_as[devfn];
+        amdvi_dev_as->bus = bus;
+        amdvi_dev_as->devfn = (uint8_t)devfn;
+        amdvi_dev_as->iommu_state = s;
+        amdvi_dev_as->notifier_flags = IOMMU_NONE;
+        amdvi_dev_as->iova_tree = iova_tree_new();
+        amdvi_dev_as->addr_translation = false;
+        key->bus = bus;
+        key->devfn = devfn;
+
+        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
 
         /*
          * Memory region relationships looks like (Address range shows
@@ -2288,7 +2310,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
         amdvi_switch_address_space(amdvi_dev_as);
     }
-    return &iommu_as[devfn]->as;
+    return &amdvi_dev_as->as;
 }
 
 static const PCIIOMMUOps amdvi_iommu_ops = {
@@ -2329,7 +2351,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
         error_setg_errno(errp, ENOTSUP,
             "device %02x.%02x.%x requires dma-remap=1",
-            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
         return -ENOTSUP;
     }
 
@@ -2510,6 +2532,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
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


