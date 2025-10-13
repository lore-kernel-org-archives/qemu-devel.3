Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B225CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Age-0003t8-T5; Mon, 13 Oct 2025 01:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8Agb-0003sv-Nu
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:01:30 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8AgY-0006rQ-Sl
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXfk4JRVPuUKA0BhUi9UYLR3rT3BJnQB+oLdyGasL2dzC/EZRoXLzOTzqy/7i2zlR4zbrZHt64VLrkZ2/2dkTsSCKpLYDpuYIqOM6c1w1K4K5awrzLlhnRUpvT/yXUaq0HBAv61A41HmtmgvMnmthn9K/+47e3MwDu7Khj3IBjJn4N2LBnQiq1gNG1TIB93MS4d9IN1TGOCBICWVDgM9jcVAm9iv7s7Nl0xK9LGeC1OIEhLLOlq4+pF1uS+TpqKVXqbQrck7X8fY1rsaid58SFO+WbFCWdCnpA9uksmJ/aL76JuEbdEjpr/mbALnEPXCI718XgoYSYB1lqqqcfkHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNDOJBZtyUJw2qwZLpWDUbsyekKACEr0iZ+7tDBZCdM=;
 b=vGoVvK76IETOHVuPQDlJlvbDIVq+qLsDa3EZ9ArgxGE6qyIS6A3CgowQfL8ybjPlN2xmKgo2/bgahc49HbZVo7elT6IXVOn2uT4zl0ilc64hhVpa9KmCUKlZUyQTptQ35XjxKWQLmz0/ACsbUiyZ7BpFGCYSMAtaovVACEliCtnMOm2uzf86cU3YNtUYURTBQtjYeyqTaxNaTPztVm/MCj8ccsuIjSVFXyrCkl18SzDJwdESB/ELjWKeJXJMi8AsyryzmZouLEITG6/9xujVSv7Js2+o//H2mR7yeSWjDHLk6Hp3HWfPJgegjPrlxugiS3a996+zWpeUryEocNKacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNDOJBZtyUJw2qwZLpWDUbsyekKACEr0iZ+7tDBZCdM=;
 b=B1FJnWfIhGqr+otAjQfjKrUXTDEcbze04wLNR+BPCxkfrjXphIp3I7FbQM1BBf9ATsaVqc6wfcYZzKI1nrmurmqiITrfePeiOgN6xqyRp6LDols1Hh7BifmZGoA2BmXzvVs9SH7I9frgitbDjSxXHR44C0zhmMP6HKEqfgN7gL4=
Received: from BL1PR13CA0385.namprd13.prod.outlook.com (2603:10b6:208:2c0::30)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:01:20 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::cd) by BL1PR13CA0385.outlook.office365.com
 (2603:10b6:208:2c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.8 via Frontend Transport; Mon,
 13 Oct 2025 05:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 05:01:19 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Oct
 2025 22:01:15 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>
Subject: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
Date: Mon, 13 Oct 2025 10:30:45 +0530
Message-ID: <20251013050046.393-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013050046.393-1-sarunkod@amd.com>
References: <20251013050046.393-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: c22c71de-637d-4768-0a41-08de0a158c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V4qRiK/sj3Vp2mz8k0kKed4/WjmANmdmjTdZMXRTNrxc2tBhY7xxNgkdfKjm?=
 =?us-ascii?Q?eyY1+5UcWtwLS3MLrmxOc9Jqb4EAc0cMnFSb7CTFEt8lpqql0WTDHloHYtW3?=
 =?us-ascii?Q?0cKzFvr23nIyost4pKtcTS5D0Adt7jIO6UNSHstdpDJW8YNlmUOmg+DqIuXN?=
 =?us-ascii?Q?jVCIgtHv19UVtrhwBDJ+5PYYyZE+64cU+CmV64aIF9D6+R+/ClLjrTJWim0y?=
 =?us-ascii?Q?FPEK11+dZ1CiHLVgdRnU/I2j16RjrmfM+Cjg5RFJ/UwB7P1NRqGJX5NY592h?=
 =?us-ascii?Q?ctNzkHnnQCQMHkNu/XsJaE5gAzWOEAIwx0Og24hQlgbPpg6ClbqTGkjD+8XE?=
 =?us-ascii?Q?fk42i/Wz5QNTm7DydGuCwY+LcTqAuGu8XvzBUN48DBVmMm7tBsTsohYrj2oo?=
 =?us-ascii?Q?UESJrJs2BQ+xSf1/h+y335HVTxnQqjjdXZ+ElmUvM5slAP9m8CyxMCZ0/1Xy?=
 =?us-ascii?Q?y3G41iubjyqfdSJ7EmoZedKljRugwZNd49N2cdFXmr+qSo8DEBH1jGUyygVd?=
 =?us-ascii?Q?l3mx7EIOxl81DEmPgHNyo12TLetsU0EqazCc5vlQpuudLoc4SPGMnow7yqgm?=
 =?us-ascii?Q?ktonTVgWMakwJoydSh96T2XcJM1omfOn+6Zi2HNCWj8FvGViazLHOMBj8n0K?=
 =?us-ascii?Q?oeyUm+JWR5yDesnHmGHYBtp6QVLCqE0gEobqqvgd49+3H6bWDtUZtzBQ9F2z?=
 =?us-ascii?Q?WwSVfMVVjx2KUXKtEOSUxZen0BgueDxsa24JnXnBmMAxa86p9F5yp2ESziz8?=
 =?us-ascii?Q?xRu1HdzUpcoqyCnHxJt6yzhaSz/o4iPdHOMOFFupKTuavAGTdCXYOn9yWH4Z?=
 =?us-ascii?Q?+u46yNOexEBE45lCJTyytMI1luAJQXhfNNkKgG9FoMvvc9WMPTEu0lHxw+CR?=
 =?us-ascii?Q?9HrS0CUQg/4h0gNADilZxnkkd/8Jcy5+8CION7uTtsDiLw8ru+kadPvwuIqC?=
 =?us-ascii?Q?okrWLeeNOVVLvERJ+g5LuNskYvlihyeUGCN1EOew5EeTPE2jZMif4xThKuDM?=
 =?us-ascii?Q?F198hAk4yDGgGo6NCP/zRgh7/DZPCfD402hTmV7Hjo1ZVXteJ5OQkzumQNJ3?=
 =?us-ascii?Q?w+vJkdDjgJ8otsq2IPRAuabDIlM3Y9uAZm6JvJRhh0mSofVLogM1sZeakxKw?=
 =?us-ascii?Q?TQZ6+uaWrBPPXuFO9HZUE4bzoWczPRwnrEIdzOhUIlSS9ocxXXFDaZXOZD0c?=
 =?us-ascii?Q?i5tTRl1tr6waISEHkZKyH0Pqy+vIXCx6uZVIPRu7omGQx1LYfLpczEm1jNXx?=
 =?us-ascii?Q?52gHpTPIBqlNJcKql1Nouc92FX9sE+dLEVZ0xhHAj5W7SzCZfqi9ubYBpa24?=
 =?us-ascii?Q?xa+8zMmZDaqNMbMTcuuH6zS+DCvk7NoVsL2cJGDfdQFIYFuSmL0C+yjdbdg+?=
 =?us-ascii?Q?euxyqArk2IYHPGgiieHMlJsoHaBpl6uQePR3XK+gBQ0IJC2+MT4lct0paYY+?=
 =?us-ascii?Q?LsHanvAmCRRuyD6Hu7OU6EzAd/CvqDeilBZkMwN51wNjcmC10FuAOEPTAExV?=
 =?us-ascii?Q?FOWbOKpypf2N1K9XF739Y4bfWuQ4HT/IvBfTj/wZt5RU1mH4Z8IgOt54eFG8?=
 =?us-ascii?Q?myC3VsqobvoiwAZ/lTI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 05:01:19.6358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22c71de-637d-4768-0a41-08de0a158c40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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
index 378e0cb55eab..b194e3294dd7 100644
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
+    uint8_t devfn;
+} amdvi_as_key;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
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
+    guint bus = (guint)(uintptr_t)key->bus;
+
+    return (guint)(bus << 8 | (uint)key->devfn);
+}
+
+static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
+                                          uint8_t devfn)
+{
+    amdvi_as_key key = { .bus = bus, .devfn = devfn };
+    return g_hash_table_lookup(s->address_spaces, &key);
+}
+
+gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
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


