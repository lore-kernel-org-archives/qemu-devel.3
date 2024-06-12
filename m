Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2258C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 21:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHVcQ-0006ge-3b; Wed, 12 Jun 2024 17:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVcO-0006gS-LA
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:34:56 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com
 ([40.107.94.71] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVcM-0003oF-Hh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/fgsgFE8JBsc9yQZGX59NotLq0hADlBIVKD0IJrKDvoxGg8K8x7Mn+3M3+73VuJqkyY4fgvlo+RQUxdF+2CzcQNlow+oHXxhFO2ZxMYwVyKfczVqFsjubBkfMULF3rQ6tZIX0IwQPC+VluvzV3mlHOOWQHxqkbAf3L77iC29GrFR2Yf55zdM/2IC6s+mJaHjwoNWjE73ySxAeFI/pJ/HCIb8rar5gMzyPuFMzWvR4NSRkvi8C20w3trBBY3nftQ/wObqm2LPi2nY+gumo3NE7nhKu9jfMdKi0CqiscUNwjfnJfCj2l/wcaZTFfJRkobHNn13GnH0z6bhPvzN3KPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jO4UHVrqZMP3djoXDVI4YZ6oy2MK9x1fZiqbu8aBG/Y=;
 b=W2rAZHEqYIgDJgCYFjBzfCBgoXQvUcxDiTtnOcM6lhgIXsJBTmJEf8hyBMW7MK2IWtJ+OLcdJFt3nlcOrD5H/URAI7zeaKZLDaCiemCMjaclXUHvqnv5nf7wyMoN0uxg1gO3WfAGIqMPXT1NkKJq2eAfvuGd/DSuw5vHAH+GVK63jLJofG78dWeUFqYjObZSVNRNzDJczaZBv8zLcFh94KybL5WCXyle17MjR9zoploKBjguztwyBMY4KSpImYCeNSjIUknZwNySWzbfKdZImrTXisMktXu1o9KTtwDTTR8Pmddzt8M2jdLxWl0Wafmq+mQuWL3I5dirdjl17TwYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO4UHVrqZMP3djoXDVI4YZ6oy2MK9x1fZiqbu8aBG/Y=;
 b=hoX5PMgVYcAkjC3mjUipzJ1t/mQkY108f2zFYO+lSvetnHUCP1eX+e8bJQEmQcKhtZPDHoHBlcgL/pje2ITfcVaN609K/7m0o4Bl1yBqX2VUnN40pUq3jtLZNGIP84Tlgu4aIhjt2/Dc5LuYinR+Dtug9zwNyFiDKG8qYuBEfjk=
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 21:29:49 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::6b) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 21:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:29:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 16:29:47 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Jun 2024 16:29:41 -0500
From: Stefano Stabellini <stefano.stabellini@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>, <peter.maydell@linaro.org>,
 <sstabellini@kernel.org>, <Edgar.Iglesias@amd.com>, "Edgar E. Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PULL 1/5] xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime
 configurable
Date: Wed, 12 Jun 2024 16:29:36 -0500
Message-ID: <20240612212940.2178248-1-stefano.stabellini@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: stefano.stabellini@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecc0ff9-e20b-44a1-1ee2-08dc8b26c9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azJtOE1MNEl2enU0MDFjdjdWOEJRSWpOYzd5T29IUnRTRTIraDNKVTl6U2ZL?=
 =?utf-8?B?dDE3d2RHNFBHK0RuOEVCRHlCUytwQXZucFpvVm96NVMyMVRtaHloT3MzM2pJ?=
 =?utf-8?B?bjJQbCtBMWQ4RFQwK25yV1M0amJnYnkzSkFlWnJJb1lUSVZOeThLZW92dzEv?=
 =?utf-8?B?amtsUFozTk41NGdTWVV1WjZtdGw4aUY0elpmY3lQdVlsQnBKUThTYVVXS3BC?=
 =?utf-8?B?U0ZYMXkzaGIwTXIxWStPTDRIZnl2aWN4bUFrMStwTjlPV0F2NDlXQ2tRYUQv?=
 =?utf-8?B?VkFRRE9TVnk3aXRtd2NqeFV3Z0h4eXRXbzFheHlNQkI3ZUpwTU9lK0dUV242?=
 =?utf-8?B?dW9kSm9tMmIzVHNlSExkWndvMm4xMGRDTWZXZkVneTU5MURLU01sUEkwZTNS?=
 =?utf-8?B?REorS2VIaXVMNlJQRURnNno2QnkwSjNsWXBQdngxN0JVWndEcTU2bktmRXJP?=
 =?utf-8?B?QzcvZ2N6cjEzTk9ZYS9ja0drdTRQMEZKb3J5L2ZDNm8yRlAvZXBJeWZqblB4?=
 =?utf-8?B?Z29yUzZqRGZxM0FLUk9MRXJBaHhTNzFwcmcyUVlZVnpQZXhIR3dUNkErb2Np?=
 =?utf-8?B?d2Y3NzJKVjZkcHJoa21oaEUrTjdTeHlkeG9ISXBkUGVYUlcvQ0lwY2N1YjJp?=
 =?utf-8?B?NENFa01CRlptZFFRN3BDdnVTbXU0UERjTG5SVXJuRlZMSkluMVhUbkJNRnNU?=
 =?utf-8?B?WlNaZDBaMytuR1F6VHhoUHlLSWU5Qlk2RnU5cm42N1N1U0Q2eCtkOHdsamNs?=
 =?utf-8?B?aWdUS0t0TG0rQ0lnUHYvL2FDZk5zQ0VXVGcxN0ZWeVVPRlhrSXYxNnpuNW1m?=
 =?utf-8?B?NnRHb0plM0YyUzRtRVlYTEpRenRpYjNsTXdPQ1NYdjFJZVF4dmd6OEZHNmx1?=
 =?utf-8?B?aDFsY1p1b2prRVErRmhwNU1mY0lDYTkzT01xOVZkTzZDK3NUNHk4WlRDTCt4?=
 =?utf-8?B?cEs1TVpNY3lIMTJscE1pM1l5bVMvd3lOaitscFpqdm54UExJQzJDRHc1Q3BN?=
 =?utf-8?B?ZkZZQks0L0VlSENrU2owazBKclVDc2hQb0lickFHU0hSSGVaNXZ5NmpEQTJi?=
 =?utf-8?B?TWsyaUtGNHdKRFI1aWxnYUtYUEJXNVBiYXBhNUtxTnB6TkdaRnNTcUxPVzZC?=
 =?utf-8?B?VEhBd3JMdzROR0JnMEo3OWdBYnRCZ1g3bkM1N2lpSmdXdEZTZ3doSGRSc2dx?=
 =?utf-8?B?S2pvYTRQcUVSTC8rME1IMlp6RUlzWXROVkYydE5YWmMrN1ZEZVQwdzIwZU12?=
 =?utf-8?B?c2tReGlOb2xtL0Rvc3JHd2FyaHR3SmNJL1NFZFBmdjQ2MXhISW0vRmV0ekx6?=
 =?utf-8?B?MlVjWjRySEc1M0gzeVhhei9FbElDdERMamN5TklSZEs5dnN4b0h0aHpXZTJB?=
 =?utf-8?B?UFY5MXRiVjRFdUVENjVHb0NhZFlESUxrcFg2b2oybk5zVitFSGRsRG5VRFh5?=
 =?utf-8?B?K3RjK2dmeTNrWWZNTEswcXo2TEFUN3R1QVc2QitqK09TbENUZ2dJRUdJYW9E?=
 =?utf-8?B?R1VHYWEvVCtDK2JBdmJYZjZhQVk4YWY2c2lUaDJZWTFxUnFHTHdnUlFXMFB3?=
 =?utf-8?B?QTdnRjRRUlRKRzc4RDAzcmJYWThzRkFlenNoTlRiNk10ZldWVGhNcEF6d0J3?=
 =?utf-8?B?TFV3OENpVW8vZVpLNmVFRlpya08xWVM3dXZIRVZ1dmViVjlJYmhXT3FEMWEv?=
 =?utf-8?B?SGJFLzdaTG9BUloxdXVHeEpkTldsSi9wU2k2bDZoNmxWVjdHN0RpOHVxZFMr?=
 =?utf-8?B?RlBlOGRLU0U2am01ZVQ1MTNOTFE1Y1ZJYkN6cUErYzJLUWVWbGQ3K24xcmh0?=
 =?utf-8?B?TFEvSHZySS81b3JBeG5jVmNRVERvem1iTkJZRjl0aCtWcElJREVtZ0FPbU8r?=
 =?utf-8?B?Qmx1U2IvZURNRG16MXkrVzFZbmxHT2tiS0wweFBMTEJwR0E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:29:48.7470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecc0ff9-e20b-44a1-1ee2-08dc8b26c9d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
Received-SPF: permerror client-ip=40.107.94.71;
 envelope-from=stefano.stabellini@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Make MCACHE_BUCKET_SHIFT runtime configurable per cache instance.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 54 ++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index fa6813b1ad..bc860f4373 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -23,13 +23,10 @@
 
 
 #if HOST_LONG_BITS == 32
-#  define MCACHE_BUCKET_SHIFT 16
 #  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
 #else
-#  define MCACHE_BUCKET_SHIFT 20
 #  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
 #endif
-#define MCACHE_BUCKET_SIZE (1UL << MCACHE_BUCKET_SHIFT)
 
 /* This is the size of the virtual address space reserve to QEMU that will not
  * be use by MapCache.
@@ -65,7 +62,8 @@ typedef struct MapCache {
     /* For most cases (>99.9%), the page address is the same. */
     MapCacheEntry *last_entry;
     unsigned long max_mcache_size;
-    unsigned int mcache_bucket_shift;
+    unsigned int bucket_shift;
+    unsigned long bucket_size;
 
     phys_offset_to_gaddr_t phys_offset_to_gaddr;
     QemuMutex lock;
@@ -95,11 +93,14 @@ static inline int test_bits(int nr, int size, const unsigned long *addr)
 
 static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
                                            void *opaque,
+                                           unsigned int bucket_shift,
                                            unsigned long max_size)
 {
     unsigned long size;
     MapCache *mc;
 
+    assert(bucket_shift >= XC_PAGE_SHIFT);
+
     mc = g_new0(MapCache, 1);
 
     mc->phys_offset_to_gaddr = f;
@@ -108,12 +109,14 @@ static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
 
     QTAILQ_INIT(&mc->locked_entries);
 
+    mc->bucket_shift = bucket_shift;
+    mc->bucket_size = 1UL << bucket_shift;
     mc->max_mcache_size = max_size;
 
     mc->nr_buckets =
         (((mc->max_mcache_size >> XC_PAGE_SHIFT) +
-          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
-         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
+          (1UL << (bucket_shift - XC_PAGE_SHIFT)) - 1) >>
+         (bucket_shift - XC_PAGE_SHIFT));
 
     size = mc->nr_buckets * sizeof(MapCacheEntry);
     size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
@@ -126,6 +129,13 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
 {
     struct rlimit rlimit_as;
     unsigned long max_mcache_size;
+    unsigned int bucket_shift;
+
+    if (HOST_LONG_BITS == 32) {
+        bucket_shift = 16;
+    } else {
+        bucket_shift = 20;
+    }
 
     if (geteuid() == 0) {
         rlimit_as.rlim_cur = RLIM_INFINITY;
@@ -146,7 +156,9 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
         }
     }
 
-    mapcache = xen_map_cache_init_single(f, opaque, max_mcache_size);
+    mapcache = xen_map_cache_init_single(f, opaque,
+                                         bucket_shift,
+                                         max_mcache_size);
     setrlimit(RLIMIT_AS, &rlimit_as);
 }
 
@@ -195,7 +207,7 @@ static void xen_remap_bucket(MapCache *mc,
     entry->valid_mapping = NULL;
 
     for (i = 0; i < nb_pfn; i++) {
-        pfns[i] = (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT)) + i;
+        pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
     }
 
     /*
@@ -266,8 +278,8 @@ static uint8_t *xen_map_cache_unlocked(MapCache *mc,
     bool dummy = false;
 
 tryagain:
-    address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
-    address_offset = phys_addr & (MCACHE_BUCKET_SIZE - 1);
+    address_index  = phys_addr >> mc->bucket_shift;
+    address_offset = phys_addr & (mc->bucket_size - 1);
 
     trace_xen_map_cache(phys_addr);
 
@@ -294,14 +306,14 @@ tryagain:
         return mc->last_entry->vaddr_base + address_offset;
     }
 
-    /* size is always a multiple of MCACHE_BUCKET_SIZE */
+    /* size is always a multiple of mc->bucket_size */
     if (size) {
         cache_size = size + address_offset;
-        if (cache_size % MCACHE_BUCKET_SIZE) {
-            cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
+        if (cache_size % mc->bucket_size) {
+            cache_size += mc->bucket_size - (cache_size % mc->bucket_size);
         }
     } else {
-        cache_size = MCACHE_BUCKET_SIZE;
+        cache_size = mc->bucket_size;
     }
 
     entry = &mc->entry[address_index % mc->nr_buckets];
@@ -422,7 +434,7 @@ static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
         trace_xen_ram_addr_from_mapcache_not_in_cache(ptr);
         raddr = RAM_ADDR_INVALID;
     } else {
-        raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
+        raddr = (reventry->paddr_index << mc->bucket_shift) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
     }
     mapcache_unlock(mc);
@@ -585,8 +597,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
     hwaddr address_index, address_offset;
     hwaddr test_bit_size, cache_size = size;
 
-    address_index  = old_phys_addr >> MCACHE_BUCKET_SHIFT;
-    address_offset = old_phys_addr & (MCACHE_BUCKET_SIZE - 1);
+    address_index  = old_phys_addr >> mc->bucket_shift;
+    address_offset = old_phys_addr & (mc->bucket_size - 1);
 
     assert(size);
     /* test_bit_size is always a multiple of XC_PAGE_SIZE */
@@ -595,8 +607,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
         test_bit_size += XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZE);
     }
     cache_size = size + address_offset;
-    if (cache_size % MCACHE_BUCKET_SIZE) {
-        cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
+    if (cache_size % mc->bucket_size) {
+        cache_size += mc->bucket_size - (cache_size % mc->bucket_size);
     }
 
     entry = &mc->entry[address_index % mc->nr_buckets];
@@ -609,8 +621,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
         return NULL;
     }
 
-    address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
-    address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
+    address_index  = new_phys_addr >> mc->bucket_shift;
+    address_offset = new_phys_addr & (mc->bucket_size - 1);
 
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
-- 
2.25.1


