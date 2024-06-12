Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5136BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 21:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHVXy-0001ln-1N; Wed, 12 Jun 2024 17:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVXw-0001ef-7G
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:30:20 -0400
Received: from mail-bn8nam11on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62f]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVXs-0002oy-MO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:30:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFw9SN1BIKokmLnFX9JHEjukOBvTp3o234YaYCFt9JPgsacj4STqCsoPHvWo4IkVvtjpHVsb5CZq8KZKTuRwpD/65eY8gdLSuH5bZ7+aLrHhw1sBRMzjsM2b0/sv4g9GSRYNokfHBNHNRuFhjPQSh9lQ8Y7sL2ZuLFRLuqQytyMJ+3pC8yln+pV6snCZw6fhMnaRv4hgWz/eM+KcT8NOk0tmt0K8zyEJzOYypAsVngNptj+dovKn+njtytgOTR6Oi93wsBvcs4ba2O10P2wvJLM6ICFVMX8dwgoiMBhl7wzs9AvYb5LIjzFx66rbjHLFlGA2P1C3GqBIAb05x2uwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaUS6wQGlVOTWcB9MLN8ydEe5uuQPHXEXiwY+daGi78=;
 b=bGXgmRRsYoIVkcWY0KUdTzDPLTiRxHPyYxIBhwQ7HpUo/cjlOfwsp+J6yegtS0lDBrJzboWvB5DKnOoFs25GlXGsT30QnInc/hrXTyiSIvR2jrOnc3dGT6X87xYu81/VkIBzuwYz4giUqKUCVtn7+u0C10f+joG6XloaliDRs7MVj+0dHuSG0HoneeSyO9cIdMmdxEgeoH3P+SlX9HRkFc9xM+fiKyc3jaHwvOqSG9TpyBWPltAPnDC4/ZCWXWPsfcMHf4KFTUGop1s+SCC30P70D/D6IF1vFO3CF7mDSWar+j3hrXUX1i0Pv2UsAMjZMf6N2lqmRfoGWNFcOu9xCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaUS6wQGlVOTWcB9MLN8ydEe5uuQPHXEXiwY+daGi78=;
 b=t16xynhym4JfXtIx78s+OyHiKCzoRSDQudzMK7GnwGMtcSnIP3vOL6CachPMOdI8SZHzvF42/Y+FfYmYdtW5WMpnWqOuqKDY5DfVcIVcq12Hzz2RITF8yoIWnkY3xBL4DxB56/8qTF4mR6gUD53NlmIddx/p8ecECKX0n1t/m2k=
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 21:30:08 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::c8) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 21:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:30:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 16:30:06 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Jun 2024 16:30:00 -0500
From: Stefano Stabellini <stefano.stabellini@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>, <peter.maydell@linaro.org>,
 <sstabellini@kernel.org>, <Edgar.Iglesias@amd.com>, "Edgar E. Iglesias"
 <edgar.iglesias@amd.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: [PULL 4/5] xen: mapcache: Add support for grant mappings
Date: Wed, 12 Jun 2024 16:29:39 -0500
Message-ID: <20240612212940.2178248-4-stefano.stabellini@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: stefano.stabellini@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d79c9e7-5f26-4794-36a5-08dc8b26d514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IVw50FSbg6DdODPYSOiW5Nr2iXDaqrMk5Kon5J1g5+y5njSEO/eLX8cmuVN8?=
 =?us-ascii?Q?QWJ6M09/KvCkCuEovXe12Mgu/l/n2r5SvsdKToEqZ4WSMdpW2SlQnIpMgkaS?=
 =?us-ascii?Q?WegkLMahaU1nvDMXseepRJK/gBSx9bUo5qR39UBnv/whlqUO769YiLMdZHEl?=
 =?us-ascii?Q?nlmPRabR2qxKigwvz9YEZ7VhRbkajAk/1eGeac0L1dNCFHIDIJO4FQXRCL7l?=
 =?us-ascii?Q?/ZO2W+z/TMoQTLhJlRKSojWaW9zgSUqlvM6aGZ/Usv3hxCrvlq4t2VyzS7Kz?=
 =?us-ascii?Q?CHoAd182n3qAlU5YgSJRMf+R6ybFIQubN25Bozc3XdTI5ChohslU1zyePRdl?=
 =?us-ascii?Q?bEWm88RPTFqKK2LpQrljqgGsGV2/ovlVuq7U/3XcdFeJ55vNPFZPgmq2W8Pe?=
 =?us-ascii?Q?hTAlsJjNtEn5dhMdg0QjJTVaaS5fNY1iBWqQFyWrmwb2bE23fuW0i1mrZVBp?=
 =?us-ascii?Q?89g2GdPNH59v3dvjx1NEe4Xk767+S74MgynqPikHEdbQy0PAZlUyCssy1T7Q?=
 =?us-ascii?Q?EMf/Z8/B3+A17F9qz2ueX+R8QrTKwKbDDrwF3vdLorVXQdTHL4o0qTdye8wT?=
 =?us-ascii?Q?gUtFCkrb2Z9pebluZUlw3PD38f8S8qtGBqyL/MJamdO233zkbixZnglULqti?=
 =?us-ascii?Q?I0NAMzkIF3vRrleJsd9jY2Du0eZjN6bxONrm2DH3zQoso5fWA/as8Czoce1p?=
 =?us-ascii?Q?hKqlla9LoXKzvonMFqlfJXwFkQMbCTgzXV9Fx3QvQqyQOqCqzdKdq2YLi41q?=
 =?us-ascii?Q?f+MWKnQTICQ4vF/oMjOS4tZpj1Og+Ls6u664yR+PvfFEbdFvwoSk5ZUd5GUC?=
 =?us-ascii?Q?fJSjJPHzYz25P8uvcOz9N9tZSmvbbo245SoQW5crB3YDyg5YHNwoRMgxAkQ/?=
 =?us-ascii?Q?FyUdeCBuAup3SET3EyWcGvy5yb7mC/YFOPmJh9hdn1Zgpokx+bMZ/9hhMksH?=
 =?us-ascii?Q?4mXTUd+qHYIQIjmQEDw3XkxIHfI1uWoCjxhvnefdVHp3dv4Y/LklnRujW4no?=
 =?us-ascii?Q?tICKWqDFMN7fT6ANqHqzBUzVDSHUpWyRuuvkLe2GJ9TdPB7yAuxRe/ABwq0y?=
 =?us-ascii?Q?qsAGLGU9Up46omE4Z3pYcL3M5KLURiSRLSTgJOnHPNxgdMmFsC7dGZbfg+nT?=
 =?us-ascii?Q?pGC7ogEl/MNVrhYReuYOzMt8F8RMwjYYmrpbad7OjzwEH3pEhN00DTwVgRg/?=
 =?us-ascii?Q?sXw78Zx8HqlssrkopHIo9nhUPcoTSXX8fzfUHwDayzJW8IaGvJaYwKagQPuu?=
 =?us-ascii?Q?aJZ351DD8kFD4o7KK2+v9rXrvTQDqIKT8IRR/jo+fCV9EKpMme6iEKphqGwV?=
 =?us-ascii?Q?O2NKBmwDtZZRzHWtsAcjZGVb5sHafFVm0iHzlEU1/dKUYMLmgoP9EVCySjd8?=
 =?us-ascii?Q?3QZHHdb+ncr8hX9vKz4ophuFxRwcpUDyZcGhNnFwDxSEwn6FnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:30:07.6220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d79c9e7-5f26-4794-36a5-08dc8b26d514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
Received-SPF: permerror client-ip=2a01:111:f403:2414::62f;
 envelope-from=stefano.stabellini@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add a second mapcache for grant mappings. The mapcache for
grants needs to work with XC_PAGE_SIZE granularity since
we can't map larger ranges than what has been granted to us.

Like with foreign mappings (xen_memory), machines using grants
are expected to initialize the xen_grants MR and map it
into their address-map accordingly.

CC: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-hvm-common.c         |  12 ++-
 hw/xen/xen-mapcache.c           | 165 +++++++++++++++++++++++++-------
 include/hw/xen/xen-hvm-common.h |   3 +
 include/sysemu/xen.h            |   1 +
 4 files changed, 144 insertions(+), 37 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index a0a0252da0..b8ace1c368 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -10,12 +10,18 @@
 #include "hw/boards.h"
 #include "hw/xen/arch_hvm.h"
 
-MemoryRegion xen_memory;
+MemoryRegion xen_memory, xen_grants;
 
-/* Check for xen memory.  */
+/* Check for any kind of xen memory, foreign mappings or grants.  */
 bool xen_mr_is_memory(MemoryRegion *mr)
 {
-    return mr == &xen_memory;
+    return mr == &xen_memory || mr == &xen_grants;
+}
+
+/* Check specifically for grants.  */
+bool xen_mr_is_grants(MemoryRegion *mr)
+{
+    return mr == &xen_grants;
 }
 
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index a07c47b0b1..5f23b0adbe 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -14,6 +14,7 @@
 
 #include <sys/resource.h>
 
+#include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/xen_native.h"
 #include "qemu/bitmap.h"
 
@@ -21,6 +22,8 @@
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
 
+#include <xenevtchn.h>
+#include <xengnttab.h>
 
 #if HOST_LONG_BITS == 32
 #  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
@@ -41,6 +44,7 @@ typedef struct MapCacheEntry {
     unsigned long *valid_mapping;
     uint32_t lock;
 #define XEN_MAPCACHE_ENTRY_DUMMY (1 << 0)
+#define XEN_MAPCACHE_ENTRY_GRANT (1 << 1)
     uint8_t flags;
     hwaddr size;
     struct MapCacheEntry *next;
@@ -71,6 +75,8 @@ typedef struct MapCache {
 } MapCache;
 
 static MapCache *mapcache;
+static MapCache *mapcache_grants;
+static xengnttab_handle *xen_region_gnttabdev;
 
 static inline void mapcache_lock(MapCache *mc)
 {
@@ -131,6 +137,12 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
     unsigned long max_mcache_size;
     unsigned int bucket_shift;
 
+    xen_region_gnttabdev = xengnttab_open(NULL, 0);
+    if (xen_region_gnttabdev == NULL) {
+        error_report("mapcache: Failed to open gnttab device");
+        exit(EXIT_FAILURE);
+    }
+
     if (HOST_LONG_BITS == 32) {
         bucket_shift = 16;
     } else {
@@ -159,6 +171,15 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
     mapcache = xen_map_cache_init_single(f, opaque,
                                          bucket_shift,
                                          max_mcache_size);
+
+    /*
+     * Grant mappings must use XC_PAGE_SIZE granularity since we can't
+     * map anything beyond the number of pages granted to us.
+     */
+    mapcache_grants = xen_map_cache_init_single(f, opaque,
+                                                XC_PAGE_SHIFT,
+                                                max_mcache_size);
+
     setrlimit(RLIMIT_AS, &rlimit_as);
 }
 
@@ -168,17 +189,24 @@ static void xen_remap_bucket(MapCache *mc,
                              hwaddr size,
                              hwaddr address_index,
                              bool dummy,
+                             bool grant,
+                             bool is_write,
                              ram_addr_t ram_offset)
 {
     uint8_t *vaddr_base;
-    xen_pfn_t *pfns;
-    int *err;
+    g_autofree uint32_t *refs = NULL;
+    g_autofree xen_pfn_t *pfns = NULL;
+    g_autofree int *err;
     unsigned int i;
     hwaddr nb_pfn = size >> XC_PAGE_SHIFT;
 
     trace_xen_remap_bucket(address_index);
 
-    pfns = g_new0(xen_pfn_t, nb_pfn);
+    if (grant) {
+        refs = g_new0(uint32_t, nb_pfn);
+    } else {
+        pfns = g_new0(xen_pfn_t, nb_pfn);
+    }
     err = g_new0(int, nb_pfn);
 
     if (entry->vaddr_base != NULL) {
@@ -207,21 +235,51 @@ static void xen_remap_bucket(MapCache *mc,
     g_free(entry->valid_mapping);
     entry->valid_mapping = NULL;
 
-    for (i = 0; i < nb_pfn; i++) {
-        pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
+    if (grant) {
+        hwaddr grant_base = address_index - (ram_offset >> XC_PAGE_SHIFT);
+
+        for (i = 0; i < nb_pfn; i++) {
+            refs[i] = grant_base + i;
+        }
+    } else {
+        for (i = 0; i < nb_pfn; i++) {
+            pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
+        }
     }
 
-    /*
-     * If the caller has requested the mapping at a specific address use
-     * MAP_FIXED to make sure it's honored.
-     */
+    entry->flags &= ~XEN_MAPCACHE_ENTRY_GRANT;
+
     if (!dummy) {
-        vaddr_base = xenforeignmemory_map2(xen_fmem, xen_domid, vaddr,
-                                           PROT_READ | PROT_WRITE,
-                                           vaddr ? MAP_FIXED : 0,
-                                           nb_pfn, pfns, err);
+        if (grant) {
+            int prot = PROT_READ;
+
+            if (is_write) {
+                prot |= PROT_WRITE;
+            }
+
+            entry->flags |= XEN_MAPCACHE_ENTRY_GRANT;
+            assert(vaddr == NULL);
+            vaddr_base = xengnttab_map_domain_grant_refs(xen_region_gnttabdev,
+                                                         nb_pfn,
+                                                         xen_domid, refs,
+                                                         prot);
+        } else {
+            /*
+             * If the caller has requested the mapping at a specific address use
+             * MAP_FIXED to make sure it's honored.
+             *
+             * We don't yet support upgrading mappings from RO to RW, to handle
+             * models using ordinary address_space_rw(), foreign mappings ignore
+             * is_write and are always mapped RW.
+             */
+            vaddr_base = xenforeignmemory_map2(xen_fmem, xen_domid, vaddr,
+                                               PROT_READ | PROT_WRITE,
+                                               vaddr ? MAP_FIXED : 0,
+                                               nb_pfn, pfns, err);
+        }
         if (vaddr_base == NULL) {
-            perror("xenforeignmemory_map2");
+            perror(grant ? "xengnttab_map_domain_grant_refs"
+                           : "xenforeignmemory_map2");
             exit(-1);
         }
     } else {
@@ -260,15 +318,13 @@ static void xen_remap_bucket(MapCache *mc,
             bitmap_set(entry->valid_mapping, i, 1);
         }
     }
-
-    g_free(pfns);
-    g_free(err);
 }
 
 static uint8_t *xen_map_cache_unlocked(MapCache *mc,
                                        hwaddr phys_addr, hwaddr size,
                                        ram_addr_t ram_offset,
-                                       uint8_t lock, bool dma, bool is_write)
+                                       uint8_t lock, bool dma,
+                                       bool grant, bool is_write)
 {
     MapCacheEntry *entry, *pentry = NULL,
                   *free_entry = NULL, *free_pentry = NULL;
@@ -340,7 +396,7 @@ tryagain:
         entry = g_new0(MapCacheEntry, 1);
         pentry->next = entry;
         xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
-                         ram_offset);
+                         grant, is_write, ram_offset);
     } else if (!entry->lock) {
         if (!entry->vaddr_base || entry->paddr_index != address_index ||
                 entry->size != cache_size ||
@@ -348,7 +404,7 @@ tryagain:
                     test_bit_size >> XC_PAGE_SHIFT,
                     entry->valid_mapping)) {
             xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
-                             ram_offset);
+                             grant, is_write, ram_offset);
         }
     }
 
@@ -399,12 +455,26 @@ uint8_t *xen_map_cache(MemoryRegion *mr,
                        uint8_t lock, bool dma,
                        bool is_write)
 {
+    bool grant = xen_mr_is_grants(mr);
+    MapCache *mc = grant ? mapcache_grants : mapcache;
     uint8_t *p;
 
-    mapcache_lock(mapcache);
-    p = xen_map_cache_unlocked(mapcache, phys_addr, size, ram_addr_offset,
-                               lock, dma, is_write);
-    mapcache_unlock(mapcache);
+    if (grant && !lock) {
+        /*
+         * Grants are only supported via address_space_map(). Anything
+         * else is considered a user/guest error.
+         *
+         * QEMU generally doesn't expect these mappings to ever fail, so
+         * if this happens we report an error message and abort().
+         */
+        error_report("Tried to access a grant reference without mapping it.");
+        abort();
+    }
+
+    mapcache_lock(mc);
+    p = xen_map_cache_unlocked(mc, phys_addr, size, ram_addr_offset,
+                               lock, dma, grant, is_write);
+    mapcache_unlock(mc);
     return p;
 }
 
@@ -449,7 +519,14 @@ static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
 
 ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
 {
-    return xen_ram_addr_from_mapcache_single(mapcache, ptr);
+    ram_addr_t addr;
+
+    addr = xen_ram_addr_from_mapcache_single(mapcache, ptr);
+    if (addr == RAM_ADDR_INVALID) {
+        addr = xen_ram_addr_from_mapcache_single(mapcache_grants, ptr);
+    }
+
+    return addr;
 }
 
 static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
@@ -460,6 +537,7 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
     hwaddr paddr_index;
     hwaddr size;
     int found = 0;
+    int rc;
 
     QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
         if (reventry->vaddr_req == buffer) {
@@ -502,7 +580,14 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
     }
 
     ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
-    if (munmap(entry->vaddr_base, entry->size) != 0) {
+    if (entry->flags & XEN_MAPCACHE_ENTRY_GRANT) {
+        rc = xengnttab_unmap(xen_region_gnttabdev, entry->vaddr_base,
+                             entry->size >> mc->bucket_shift);
+    } else {
+        rc = munmap(entry->vaddr_base, entry->size);
+    }
+
+    if (rc) {
         perror("unmap fails");
         exit(-1);
     }
@@ -521,14 +606,24 @@ typedef struct XenMapCacheData {
     uint8_t *buffer;
 } XenMapCacheData;
 
+static void xen_invalidate_map_cache_entry_single(MapCache *mc, uint8_t *buffer)
+{
+    mapcache_lock(mc);
+    xen_invalidate_map_cache_entry_unlocked(mc, buffer);
+    mapcache_unlock(mc);
+}
+
+static void xen_invalidate_map_cache_entry_all(uint8_t *buffer)
+{
+    xen_invalidate_map_cache_entry_single(mapcache, buffer);
+    xen_invalidate_map_cache_entry_single(mapcache_grants, buffer);
+}
+
 static void xen_invalidate_map_cache_entry_bh(void *opaque)
 {
     XenMapCacheData *data = opaque;
 
-    mapcache_lock(mapcache);
-    xen_invalidate_map_cache_entry_unlocked(mapcache, data->buffer);
-    mapcache_unlock(mapcache);
-
+    xen_invalidate_map_cache_entry_all(data->buffer);
     aio_co_wake(data->co);
 }
 
@@ -543,9 +638,7 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
                                 xen_invalidate_map_cache_entry_bh, &data);
         qemu_coroutine_yield();
     } else {
-        mapcache_lock(mapcache);
-        xen_invalidate_map_cache_entry_unlocked(mapcache, buffer);
-        mapcache_unlock(mapcache);
+        xen_invalidate_map_cache_entry_all(buffer);
     }
 }
 
@@ -597,6 +690,7 @@ void xen_invalidate_map_cache(void)
     bdrv_drain_all();
 
     xen_invalidate_map_cache_single(mapcache);
+    xen_invalidate_map_cache_single(mapcache_grants);
 }
 
 static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
@@ -632,13 +726,16 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
         return NULL;
     }
 
+    assert((entry->flags & XEN_MAPCACHE_ENTRY_GRANT) == 0);
+
     address_index  = new_phys_addr >> mc->bucket_shift;
     address_offset = new_phys_addr & (mc->bucket_size - 1);
 
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
     xen_remap_bucket(mc, entry, entry->vaddr_base,
-                     cache_size, address_index, false, old_phys_addr);
+                     cache_size, address_index, false,
+                     false, false, old_phys_addr);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 65a51aac2e..3d796235dc 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -16,6 +16,7 @@
 #include <xen/hvm/ioreq.h>
 
 extern MemoryRegion xen_memory;
+extern MemoryRegion xen_grants;
 extern MemoryListener xen_io_listener;
 extern DeviceListener xen_device_listener;
 
@@ -29,6 +30,8 @@ extern DeviceListener xen_device_listener;
     do { } while (0)
 #endif
 
+#define XEN_GRANT_ADDR_OFF (1ULL << 63)
+
 static inline uint32_t xen_vcpu_eport(shared_iopage_t *shared_page, int i)
 {
     return shared_page->vcpu_ioreq[i].vp_eport;
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 3445888e39..d70eacfbe2 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -50,4 +50,5 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
 bool xen_mr_is_memory(MemoryRegion *mr);
+bool xen_mr_is_grants(MemoryRegion *mr);
 #endif
-- 
2.25.1


