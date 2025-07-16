Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B491C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwes-0007J1-Ua; Wed, 16 Jul 2025 03:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwer-0007Cp-F6
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:34:29 -0400
Received: from mail-dm6nam12on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2417::630]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubweo-0000n4-Fd
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:34:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0MB0KXhfjav6No76gL0rSoyFmMWrjPOxGHisLmgGD/w/W6o0SGu8MJJmFwXo7DrEBY8hZQcGoMkE1CfsyNvhwFDAdBrBiDpYOP1TxG/L5p7R8RxwLDpFk0lMMaVj3kKvf8s1ivMkDjeEwJmjtHrm2QtRl/KAP6PBk67DItZoFOUuPK3SfAcYJfoBnk4ADokf51VJSoNyjQnkPJSmArCFjwzwmCzJzMSMvRXiboFX6lJga3tEKUtAT52aQF+XhN7dI3vydMOCW5DArkO5on/+hCui8tganzE3We71q6kA3pkjEAeW5lfL2gHXY0IiCHTKWU8TN3sDb582wPrlawjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6RRUFaRtYaLJtIc0WFz+rCvfOmoEeLDqJcKIOUZhFE=;
 b=d8fPTiYVlwmtcB9Clb3e43Uz1TS2RZs2QK6XPXfx59altwSuGas+HLL1gWFWZTLgfkHe6lyURV9GO7cBeW+oXGbrAiE4DxqZNfIzGB8rFQ8S6RtfQWZswxwEKCIQukWRyAmg5iWCLTCP16dCAqG2sPG39yiO8124ewr/w8d0Ulw6juorcF2pNISa8km0OjOReYqGJjoNvdBkV7ayK697He1jC2JriCEva4/OVrv9DmbRvsULN/7EteIF3kO/aE0Kv+eXK05kNbta+T3afS9y1J/OmXhSI5pwptkEYDp0kTc72+RpBMIPc8KiSPqWD/WmwxAT/ErWCGUS2enP1ybIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6RRUFaRtYaLJtIc0WFz+rCvfOmoEeLDqJcKIOUZhFE=;
 b=xoMI355x2vNOBieUkuU/MLuTTNiLtcGb553FXDW2UKj4hiY9vdZ7jIVVmzmUaxx8SBr4olPqFy1PAWe1VrA0ujYy+PSrj4vYk0B+Ejhp7o6EUn79K/S6MuAyHlQBNxQ8/rchYznY2dunm9M8SNAD37FbnZMtbBTWSSBoNGzoBhQ=
Received: from BN9P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::10)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 07:34:18 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::6e) by BN9P221CA0028.outlook.office365.com
 (2603:10b6:408:10a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 07:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:34:17 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 02:34:14 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 7/7] hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
Date: Wed, 16 Jul 2025 13:01:45 +0530
Message-ID: <20250716073145.915-8-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1a17cd-d4b4-43c5-8737-08ddc43b2c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jN+H47JsO8nO/TCGE2O4I7AAaTl/xj+r7oy1N7CDgPpg3ahDrqBwv5jVF+iF?=
 =?us-ascii?Q?BFdgk0H4Vqo3Z214QhJ1ZnJ/Xlx0dR9RBGfEXw7NjyD1OFY6Le8bGNbYFqeY?=
 =?us-ascii?Q?y0fh9XUs0l/eUdbOQQYZr7svC/0EqfYb8TclzpfkReY19jpMmRxnOghVNyjl?=
 =?us-ascii?Q?Jrg8Y9lhiQgeleJoY7nX6hDj1kT8HL2ynBmZHLGMAwaLtiSAHSQ3dp0CnMB+?=
 =?us-ascii?Q?2rxrN2g3TC5SzW+etAteHaCPQkkQ8wJkXXepso6XK75Klbhrlqi0ZkH9XU21?=
 =?us-ascii?Q?krg7KYKgpk9OUMdj5jtY14ysXqGLDXeHyPebJcFOOar4fI3ng1Wazpi2NFa3?=
 =?us-ascii?Q?V9pmtCi8VXp6Ij/O7ufmUYrS9RDLjK2I1P8JMYIPPsJ6WJ0dEmFyFv/R+Q1p?=
 =?us-ascii?Q?i75oj5mZe3eq4hBrKoUCv1fD/luK1DAk4QNFJL9PRyW55imkNIuPYWhXHXI1?=
 =?us-ascii?Q?KMm9tXIMCbKRpbwQrT6OKeuORbhSAkZvOluqY5hflNpgV5Nwv25GLNX95nZ3?=
 =?us-ascii?Q?Ll9w/X8ld0H3EuTU49+o7VTmmtXwYONYiSBP3RiN1yK+EW+QFYO358ryTXKb?=
 =?us-ascii?Q?8tiIxJpWrWVfko8oJP/XWXQAjHmETCrm3QUz5BWsqe6wc87LPgAeBOWcYv01?=
 =?us-ascii?Q?cqUeCcrK4QokfhRQ9t8ZGXRPcw2z6Rq412se5PwYlYQJIckFhglVIfafucV1?=
 =?us-ascii?Q?M7bSRzUPTVWUc4gnnbBCDR4V3r93v7X0cWZkK/MwlGxkMX3qUZRnSVXdpKb0?=
 =?us-ascii?Q?2Gn6k+vU+dNyKDiTz1S1zTwACzAjrTK7tMnFst+U7HlP8BJLzdKcNe8rhCrP?=
 =?us-ascii?Q?T/EBGewjowDcHnndrt/GFHNZGhNoUC24OfCEq5oKNPf4oQ2gUNnlTZaFNolV?=
 =?us-ascii?Q?z1luUgVZv7kKm48gTy6DA0YMf6X7Ua0Hxz+ezAS0o0fHi3I+JpSR00r4paTT?=
 =?us-ascii?Q?3rxlNJ9jY8v+ZL2dXTYOx4iR4H6U8zBnULWe3GW6gpQVO7odjHBgOl7zSMGT?=
 =?us-ascii?Q?pqQkTNoWP/B9SAREVuVAzpL87YKupTQMd4QioV8wCzgvGnNRfmpxwzDIXnD4?=
 =?us-ascii?Q?9by4EVo7zO4E8YXeqNrT/Y1oq9VEJ+w//N6HcMnxTtxcIDB2Wd77slaVPzdn?=
 =?us-ascii?Q?0ChEXW4q/r64+Yt6oLv/fssB4OCHPgzpl1xFUAbtNDoiQRYiGPoa6dEzUCy5?=
 =?us-ascii?Q?i9oX45VWTgPKRHMW6rWadJqufac3LoOrj1UEl3z+IAp7Dq0EFAi05rcHJmvO?=
 =?us-ascii?Q?3sTE8694KSFoxJ6L52JYMH1Pc3uFIkyhJy2AQOcdUtRx4DcFPMOdVOgDSb7M?=
 =?us-ascii?Q?cIk7c+t66ycachwkJSe5ExxQut6/csn9o8hVJGcwlPFOhfDBbiWVtr+BRDoX?=
 =?us-ascii?Q?k8J8QJUyzhY0htsrACdoJ8L4iyJjJf8Z7D4D307+V4f3Ob/ZnvRwUfYU2Gz8?=
 =?us-ascii?Q?LRgPAUzfm5YmuWMitceQ4vV5HP0xY51cu2flC6rOJMiqahUsVjmsuRcGSORT?=
 =?us-ascii?Q?szeESco1JJuiNBalYk9yk+z6lHOF2eLEX/6R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:34:17.8756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1a17cd-d4b4-43c5-8737-08ddc43b2c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284
Received-SPF: permerror client-ip=2a01:111:f403:2417::630;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Physical AMD IOMMU supports upto 64 bits of DMA address. When device tries
to read or write from the given DMA address, IOMMU translates the address
using page table assigned to that device. Since IOMMU uses per device page
tables, the emulated IOMMU should use the cache tag of 68 bits
(64 bit address - 12 bit page alignment + 16 device ID).

Current emulated AMD IOMMU uses GLib hash table to create software iotlb
and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
to 60 bits. This cause failure while setting up the device when guest is
booted with "iommu.forcedac=1". One example of the failure is when there are
two virtio ethernet devices attached to the guest with

    -netdev user,id=USER0 \
    -netdev user,id=USER1 \
    -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 \
    -device virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER1 \

In this case dhclient fails for second device with following dmesg

[   24.802644] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5664000 usecs ago
[   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 59: transmit queue 0 timed out 10720 ms
[   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 10720000 usecs ago

To solve this problem, define `struct amdvi_iotlb_key` which uses 64 bit
IOVA and 16 bit devid as key to store and lookup IOTLB entry.

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 51 ++++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h |  5 +++--
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 33916b458611..a2a2c0f0be23 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
     int devfn;
 } amdvi_as_key;
 
+typedef struct amdvi_iotlb_key {
+    uint64_t gfn;
+    uint16_t devid;
+} amdvi_iotlb_key;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -355,16 +360,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
              PCI_STATUS_SIG_TARGET_ABORT);
 }
 
-static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
-{
-    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
-}
-
-static guint amdvi_uint64_hash(gconstpointer v)
-{
-    return (guint)*(const uint64_t *)v;
-}
-
 static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
 {
     const struct amdvi_as_key *key1 = v1;
@@ -401,11 +396,27 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
                              amdvi_find_as_by_devid, &devid);
 }
 
+static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
+{
+    const amdvi_iotlb_key *key1 = v1;
+    const amdvi_iotlb_key *key2 = v2;
+
+    return key1->devid == key2->devid && key1->gfn == key2->gfn;
+}
+
+static guint amdvi_iotlb_hash(gconstpointer v)
+{
+    const amdvi_iotlb_key *key = v;
+    /* Use GPA and DEVID to find the bucket */
+    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
+                   (key->devid & ~AMDVI_PAGE_MASK_4K));
+}
+
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};
     return g_hash_table_lookup(s->iotlb, &key);
 }
 
@@ -427,8 +438,7 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
 static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
                                     uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};
     g_hash_table_remove(s->iotlb, &key);
 }
 
@@ -439,8 +449,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
         AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-        uint64_t *key = g_new(uint64_t, 1);
-        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+        amdvi_iotlb_key *key = g_new(amdvi_iotlb_key, 1);
+
+        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
+        key->devid = devid;
 
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
@@ -453,7 +465,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
         entry->perms = to_cache.perm;
         entry->translated_addr = to_cache.translated_addr;
         entry->page_mask = to_cache.addr_mask;
-        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+        entry->devid = devid;
+
         g_hash_table_replace(s->iotlb, key, entry);
     }
 }
@@ -2373,8 +2386,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *bus = pcms->pcibus;
 
-    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
-                                     amdvi_uint64_equal, g_free, g_free);
+    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
+                                     amdvi_iotlb_equal, g_free, g_free);
 
     s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
                                      amdvi_as_equal, g_free, g_free);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 37a57c4dd553..04d48d23bce6 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -218,8 +218,9 @@
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
 
 /* IOTLB */
-#define AMDVI_IOTLB_MAX_SIZE 1024
-#define AMDVI_DEVID_SHIFT    36
+#define AMDVI_IOTLB_MAX_SIZE        1024
+#define AMDVI_IOTLB_DEVID_SHIFT     48
+#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
-- 
2.34.1


