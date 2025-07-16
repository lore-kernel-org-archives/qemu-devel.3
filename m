Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB42C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwej-0006K3-SG; Wed, 16 Jul 2025 03:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwee-0005rW-9o
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:34:16 -0400
Received: from mail-mw2nam12on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubweY-0000km-66
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:34:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL2qifzMDAvJ61EOe6GkSRaek4hxoLVANMEpws0qq1Lakgt6NOA6EJy4pqSZBMQUcnrMa6jDDQX3psRcivF8DqG0o1+AbFXMPlR9EgzN318dYMyTq0EC/DT3s8LXJJk9lXs7xT1IYSAJzhPyLS/8cgf3obKh9j/agIj16e1PM3DF1v1TAO0wIMPGVqeMfY1WqaIkTT1DnyzQuGNmdjbCS1KfDLfgsF1MNQIhDrAwj+rT8dMH0Zi747gvKPfWmo+VrOHI/1kpJiqwEca696UAVo0uau0oYFiGxYVjXP3c7k44SHJUV9v8GZOhV6wIOBrgQTlGiBExZgJSka+ChjoxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGBKKQr3LNZab0Sv6LDKUb+Xm7hNpg8a6l1Zqp8oMC8=;
 b=W1PxINOr7+vUyYEUSUcma7G4Xi7s9UMd1gmON1lCypwyUbat1shfxwqeFKOd7n7gVCbgrpz7HesMjyyoZzu+y9AErq6WXXj8ZOHZzvDbB8OyCtrgpNuH73qZMzt9kZNRsa4fUtc4jeDQ01ep4QOPCWEMlJHpmh6UpHKAkNj1VXDY5GuDXFzpmE2rxWaLzv5CV5XUiiDqNhjl8ajgD6HwdzLhhUSkr40CEzVsboJ9gNx4C0yps9H7jPEy3jMe6+yXnzXorcYiJXZuq9l+DjGkdfGclOiNxmlaLRKiAPp9K4oaBVN+tl6ZSbpb2mFe4JZ8gugE+wCgHvNGfNTO+S5Yaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGBKKQr3LNZab0Sv6LDKUb+Xm7hNpg8a6l1Zqp8oMC8=;
 b=CDEJ8YVfLKv/kJWLy6CPREdzT3s2YtYCrDcjZqsONeVD18+ZAERob7ZyGdpWyQyubGv1vFBXX47nET6hZWiEW0hWnSsbVH0yg7QyHCtwq2aAJvucQqgzLIIZBhrWIx9t4nnYso13U104SX51Ore2tchYT8eHKfIVvFL4ylTgXGo=
Received: from MN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:52d::34)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:34:02 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::af) by MN0PR04CA0029.outlook.office365.com
 (2603:10b6:208:52d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 07:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:34:01 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 02:33:58 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Alexey
 Kardashevskiy" <aik@amd.com>
Subject: [PATCH 6/7] hw/i386/amd_iommu: Fix handling device on buses != 0
Date: Wed, 16 Jul 2025 13:01:44 +0530
Message-ID: <20250716073145.915-7-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073145.915-1-sarunkod@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d76d1f-650b-4862-faf1-08ddc43b2292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l99Kbe4TEm+ZDaQkB5A1uLEycVXkzq/NtXRTnwCcB2cvXlM2JJXggEU4Pg+0?=
 =?us-ascii?Q?fwXfVmHrshI2H6COYhyG8PwrX+4IM3wIV30I5l47iM2p0hHCH07l1qkRaAvH?=
 =?us-ascii?Q?1oxUrPyj8pGdSFqr1yihM+oMxxgAhnLQ8iYPMKi5uD51l/MrRvoBNI8vVq9H?=
 =?us-ascii?Q?1gQ6dMxmDK5cE4ckbFxXhN4onrC8uRsq8fGn3NXOLKY9a1RTHEH1YtyYB4LT?=
 =?us-ascii?Q?cysYNBML1RcidbTIetgUquw4JuyXGtXzvQn9Iy9xupkgmunLDzrk12VZooY1?=
 =?us-ascii?Q?Nc65INTwNHnaa0zDJl07CbzTdTxi0TQV9H3vhWqWZj0j0fsAAbU5el65JqrH?=
 =?us-ascii?Q?NwvvrclZDJhAoXk1ZVu/xAEAycql2wxQQVWvoZaI2IHTN284iDE1xARdAPqs?=
 =?us-ascii?Q?3wzQZ2u+Bv80rpr4w0YPvwZwjiZ41ZB7gLOWXbGFKEt0yIEZsTOmgDRWFHGp?=
 =?us-ascii?Q?AGqmP0//TjmaPI09AL3Ow61dx1ssv/XTSaSmPsGclz/q2/iZ2snKLS6D4pfW?=
 =?us-ascii?Q?Ek/vYCDYN3wGsr2TEMU3pbvc/kQ+4KWxRnOOFQm/tjdq9bI8fhlted2x4Sy4?=
 =?us-ascii?Q?BlOsAhbutyoLJC4L/mVQqKt/ngwI3w5LmnM+mYJu1TdlEenIs+AinK8tx5B5?=
 =?us-ascii?Q?KG3jEqHghn5jIUodpUBH0a5hABVh0WAqw+NemjuPYPqZ4w3p5qu4sFZiEekP?=
 =?us-ascii?Q?zV7qCtYCazjqHJ/t82aRG1O4RidUP+oB3T3tbkgnr+StHK/pEQIlfi8duwfI?=
 =?us-ascii?Q?De4ErgCnfCujc9VPfmru9/mXcaL5RSib0R7j+lkasJqccLYCPZdO28Q9mWa1?=
 =?us-ascii?Q?5LIU1Ji8Cg+ZTZ/mESXIz5SzQPWTEY1RTgu5ojVcmBwRNJB1wZVcrq9xQx7x?=
 =?us-ascii?Q?2tj0ioNS5eN91VwFbmoVEHQ/D11LOU1kTEP6xtvqU2Esk8AQSvXSQxEwPc3C?=
 =?us-ascii?Q?m7sBtuAZoQlAjnF8lGUsQSiev6RXcz22Rrvf2X/b2rh/EawlBOr73wBqYAFN?=
 =?us-ascii?Q?S/ctU+slf42wc9bYW/n6VAlRXNr0tTYeVMeCGikPHiaCl+g32FSg4NY+Yao7?=
 =?us-ascii?Q?vTEEu5elEdxlmEKSZiwUw2L/nbXZM8VirKYBODZFQPAwLCK4idEu0h8+Q2rv?=
 =?us-ascii?Q?guOuzl0Zl+z0e2eLoJ2yikNOYGzC+tsBr6ibQH7EUOEktVHKaoq19nmlPtdB?=
 =?us-ascii?Q?y9AOrEvGF1/Gi2CXwvWRYvutGiR+LgvJfXCvulJRorWoyaUq825QbCKnbe4J?=
 =?us-ascii?Q?pwpHrAHcMELomOx8YYUgMkJWXOYsJ9D07K530sSG5imJqCBSFmkaflGelVAn?=
 =?us-ascii?Q?FfJl1LOAytiQMw0e6zDCoq/lMy/N0uaA1Z6rEkS7zzcOI8cVgm/lMq/HU6re?=
 =?us-ascii?Q?euPXfsBK1IfUmgaJtBJ5jwNXReVqq41p0PCydS9qXEFiCzQ70XOa85Pwo5Se?=
 =?us-ascii?Q?CrpDlvgfBYTdHF/7L1EFAeV5pSyrASbljq3NzvoVg2UQltCqszCYku8iZ4UH?=
 =?us-ascii?Q?4GZ+R0WY2ooyrJrVvwYNHa4qNgn9vsGSRJeN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:34:01.8211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d76d1f-650b-4862-faf1-08ddc43b2292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
Received-SPF: permerror client-ip=2a01:111:f403:200a::60a;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
 hw/i386/amd_iommu.c | 124 +++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h |   2 +-
 2 files changed, 76 insertions(+), 50 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index a34062153194..33916b458611 100644
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
@@ -360,6 +365,42 @@ static guint amdvi_uint64_hash(gconstpointer v)
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
@@ -530,7 +571,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
 {
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIState *s = as->iommu_state;
 
     if (!amdvi_get_dte(s, devid, dte)) {
@@ -983,23 +1024,13 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
  */
 static void amdvi_switch_address_space_all(AMDVIState *s)
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
-            amdvi_switch_address_space(iommu_as[devfn]);
-        }
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
+            amdvi_switch_address_space(iommu_as);
     }
 }
 
@@ -1012,28 +1043,22 @@ static void amdvi_switch_address_space_all(AMDVIState *s)
  */
 static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
 {
-    uint8_t bus_num, devfn, dte_mode;
+    uint8_t dte_mode;
     AMDVIAddressSpace *as;
     uint64_t dte[4] = { 0 };
     IOMMUNotifier *n;
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
 
@@ -1699,7 +1724,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
                                bool is_write, IOMMUTLBEntry *ret)
 {
     AMDVIState *s = as->iommu_state;
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
@@ -1773,7 +1798,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     }
 
     amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
-    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
+    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
             PCI_FUNC(as->devfn), addr, ret.translated_addr);
     return ret;
 }
@@ -2137,30 +2162,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
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
-        iommu_as[devfn]->notifier_flags = IOMMU_NONE;
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
@@ -2203,7 +2226,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
         amdvi_switch_address_space(amdvi_dev_as);
     }
-    return &iommu_as[devfn]->as;
+    return &amdvi_dev_as->as;
 }
 
 static const PCIIOMMUOps amdvi_iommu_ops = {
@@ -2244,7 +2267,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
         error_setg_errno(errp, ENOTSUP,
                 "device %02x.%02x.%x requires dma-remap=1",
-                as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+                pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
         return -ENOTSUP;
     }
 
@@ -2353,6 +2376,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
+    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
+                                     amdvi_as_equal, g_free, g_free);
+
     /* This device should take care of IOMMU PCI properties */
     if (!qdev_realize(DEVICE(&s->pci), &bus->qbus, errp)) {
         return;
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 3dd4e7e3e8b8..37a57c4dd553 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -409,7 +409,7 @@ struct AMDVIState {
     bool mmio_enabled;
 
     /* for each served device */
-    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
+    GHashTable *address_spaces;
 
     /* list of address spaces with registered notifiers */
     QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
-- 
2.34.1


