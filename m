Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0683AC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf62f-00050l-IP; Tue, 27 Feb 2024 17:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62e-00050H-7g
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:16 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62b-0002a7-Vp
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNkGdTpq4mOcI6s0v5uOOXjqQk7yjs4ceNE+401QBpouUakJ56Y1A7hDuqEnzqSslC7H3OQTlsD3pWkOYaUoVItYio5NTnxbWA16GBP5TCAQOEn3EKKJ1S5TS7G7Hajn3auARhreT0/eronl4nKDaFMDWS/zoF2YtMzf7uTzVsHZD6fSQ797439vZj5xKZAvFqyeeLxVm5puKIFyydeCyLk6hhwiVSUM899kxuttTTuvgvP+DPiIM7sF0J+5iey+W8ZVpKk/Ou+ETbM0+2kAUx6AhzbXDDBohGXi1j7sAgm63XIVUh0hmMbH3lbVZ6wqKuzcyrCPKPBx1UupKj70PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q791cF6GA8d6F2oGognOVh2s9YFO/NpyQ1CcNhKOZRI=;
 b=QIm90RTZCwD8PKKjnZsk7QB7/kU50z6wtefufGf5RMF3Jq1V/Ws2I2xJiYEAvwJZDMn1BLFCDiqVTAdgHNgljhXCTt3S5ZMT2ItDJU+IV9/01x3ndHxvkNiPld7Zd0+aVctsQDTKOZiEIB3QWrp1ON/ASCSB/xlGR84q5xZ/Vrh1m7YBnZJQ6PStdDLQZCNSpV/84oa6zpq/a4LUN3PwSUlQxUZYJ0bg4vk0epPvdafKEdhEjBG8BwNBn8G0Ix54wzqyb6LYncfs+A3hEJztryNOLWLlUGk7crq2p/gFP2HKUhIV8DZVn1O6lnH+ijuZJH0yLKW98ILWuLpN1W6VMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q791cF6GA8d6F2oGognOVh2s9YFO/NpyQ1CcNhKOZRI=;
 b=iYXjovZwOrcfwWf61bLbpzFMWdsCVSGRNZ+KYKQtDYwpWxcE8AbQAwABWZ74dtFoB/WKYcHeZvdWt6+IvLiOrdWNbrkGq07CytLwh9xHAG4pAX7oD3bRaQ2i6xEHvgZSnte7sjTaE1ugGKuFaSafjcU0q0KPyMjHhC3n+wBat88=
Received: from BN0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:408:ea::15)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 22:35:10 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::59) by BN0PR04CA0070.outlook.office365.com
 (2603:10b6:408:ea::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 22:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 22:35:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 16:35:07 -0600
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 16:35:07 -0600
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "open list:X86 Xen CPUs"
 <xen-devel@lists.xenproject.org>
Subject: [QEMU][PATCH v3 2/7] xen: add pseudo RAM region for grant mappings
Date: Tue, 27 Feb 2024 14:34:56 -0800
Message-ID: <20240227223501.28475-3-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227223501.28475-1-vikram.garhwal@amd.com>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vikram.garhwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 7551176a-e61d-47ca-558e-08dc37e45b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WoNnATOV76Ns0xdkiLkepu0ykyJmiUe37sILWm+XYzpTfXhqkE/3LDmmdZlyJnT3RpkAqyb9WDN/VlzA9933f8wlDZ4HYRuqvNSvr+BykqLwr/gfGcokiKl7g7UXybObN+GUW4j6794TvadSBW7sx2YmKol+MomtElGEyrHr4M4dpydDfyb/6eVWhD01rLN/SyloBEC5wmExkKcJ/UOTe2oSHbfJtGscEie5V5OU/fw7lH03j0Hw+Y3hvJOn0rrElGRbf9Rl7e96M/0teTnFOE4R7LSxnpr8O1Bcii+sMltrhMSbdgXcGkvzmj6qj3A4OUgOHRWZtDycfw6j1EYhuBuinozHUHsxgYkiSC4TkJ0xs9gl0Ju8KqsZb3nv5bHK9HnA15luNz/czr0r8WapHCFu0/aTV5SK4IlyTCbPu+iZiemYEXN9Oxpsv+RjZaiulTvyZiOVO1Bs00JNflgJI6i5H1eaU4Ch8KAnM0y/Qb+lvv02I59YDptmFeUgHfn1IWeXWcHpPOsFwE7LhrJNNiBq/KQycYoag+C4B9jz5P6M0LdN6tbVPCNxR1w6OyE5Sc+R6/lQVuhQ8/RuikbuUjgcqyaUPhdl8XydGhOy2nwt6Bksg11IFGrUuu7Wf4o8d9qenjvEqPFGejQQhuCUzPrGYxMZnWKmhv17vtz1AzXZnGrWWH/ePOwucrIRzkndHWtZrNvFwI6iq/kC6a7AnJ05YCTJbPLekFSjIrUn93sZXuy5KmakgoS+A32YBpW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:35:09.9036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7551176a-e61d-47ca-558e-08dc37e45b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
Received-SPF: softfail client-ip=2a01:111:f403:2414::600;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

From: Juergen Gross <jgross@suse.com>

Add a memory region which can be used to automatically map granted
memory. It is starting at 0x8000000000000000ULL in order to be able to
distinguish it from normal RAM.

For this reason the xen.ram memory region is expanded, which has no
further impact as it is used just as a container of the real RAM
regions and now the grant region.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen-hvm.c           |  3 +++
 hw/xen/xen-hvm-common.c         |  4 ++--
 hw/xen/xen-mapcache.c           | 27 +++++++++++++++++++++++++++
 include/hw/xen/xen-hvm-common.h |  2 ++
 include/hw/xen/xen_pvdev.h      |  3 +++
 include/sysemu/xen-mapcache.h   |  3 +++
 6 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f42621e674..67a55558a6 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -172,6 +172,9 @@ static void xen_ram_init(PCMachineState *pcms,
                                  x86ms->above_4g_mem_size);
         memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
     }
+
+    /* Add grant mappings as a pseudo RAM region. */
+    ram_grants = *xen_init_grant_ram();
 }
 
 static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index baa1adb9f2..6e53d3bf81 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -9,7 +9,7 @@
 #include "hw/boards.h"
 #include "hw/xen/arch_hvm.h"
 
-MemoryRegion ram_memory;
+MemoryRegion ram_memory, ram_grants;
 
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
@@ -26,7 +26,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
         return;
     }
 
-    if (mr == &ram_memory) {
+    if (mr == &ram_memory || mr == &ram_grants) {
         return;
     }
 
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 4f956d048e..dfc412d138 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -14,7 +14,9 @@
 
 #include <sys/resource.h>
 
+#include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/xen_native.h"
+#include "hw/xen/xen_pvdev.h"
 #include "qemu/bitmap.h"
 
 #include "sysemu/runstate.h"
@@ -590,3 +592,28 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
     mapcache_unlock();
     return p;
 }
+
+MemoryRegion *xen_init_grant_ram(void)
+{
+    RAMBlock *block;
+
+    memory_region_init(&ram_grants, NULL, "xen.grants",
+                       XEN_MAX_VIRTIO_GRANTS * XC_PAGE_SIZE);
+    block = g_malloc0(sizeof(*block));
+    block->mr = &ram_grants;
+    block->used_length = XEN_MAX_VIRTIO_GRANTS * XC_PAGE_SIZE;
+    block->max_length = XEN_MAX_VIRTIO_GRANTS * XC_PAGE_SIZE;
+    block->fd = -1;
+    block->page_size = XC_PAGE_SIZE;
+    block->host = (void *)XEN_GRANT_ADDR_OFF;
+    block->offset = XEN_GRANT_ADDR_OFF;
+    block->flags = RAM_PREALLOC;
+    ram_grants.ram_block = block;
+    ram_grants.ram = true;
+    ram_grants.terminates = true;
+    ram_block_add_list(block);
+    memory_region_add_subregion(get_system_memory(), XEN_GRANT_ADDR_OFF,
+                                &ram_grants);
+
+    return &ram_grants;
+}
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 4b1d728f35..8deeff6bcf 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -16,6 +16,8 @@
 #include <xen/hvm/ioreq.h>
 
 extern MemoryRegion ram_memory;
+
+extern MemoryRegion ram_grants;
 extern MemoryListener xen_io_listener;
 extern DeviceListener xen_device_listener;
 
diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index ddad4b9f36..0f1b5edfa9 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -80,4 +80,7 @@ int xen_pv_send_notify(struct XenLegacyDevice *xendev);
 void xen_pv_printf(struct XenLegacyDevice *xendev, int msg_level,
                    const char *fmt, ...)  G_GNUC_PRINTF(3, 4);
 
+#define XEN_GRANT_ADDR_OFF    0x8000000000000000ULL
+#define XEN_MAX_VIRTIO_GRANTS 65536
+
 #endif /* QEMU_HW_XEN_PVDEV_H */
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index c8e7c2f6cf..f4bedb1c11 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -10,6 +10,7 @@
 #define XEN_MAPCACHE_H
 
 #include "exec/cpu-common.h"
+#include "exec/ram_addr.h"
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
@@ -25,6 +26,8 @@ void xen_invalidate_map_cache(void);
 uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
                                  hwaddr new_phys_addr,
                                  hwaddr size);
+MemoryRegion *xen_init_grant_ram(void);
+
 #else
 
 static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
-- 
2.17.1


