Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4087C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf62p-00052n-0r; Tue, 27 Feb 2024 17:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62m-00052A-EX
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:24 -0500
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62k-0002dV-C4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3B9HCDjTXI7RptZzXRo/5RlnAJnDGqjXyLmGo+GTflFLVncjFl/s5WK3RL7h8pjPr/+Sj/WQxBB3om42REb5MittKiWiKBBr4yYYWSUBoOznirffhFGyfNdtg+lrH6tAcxSbUwDELO+7697XhlwKeGXbakrUPc62tdIeMmJFrE+k70xZumxMIRH/+XGJrR+QpStjpeE4zNWXTAKzsUFX4dXgOShMVl1qqB9Z+j/xV+y8b5vr6i9j/tD58QIco6MjcSc7diDSo73h+KzByc9sm+RCaa4f0QbgW1quxQsPc3KhJ9zQGZ2DHVT3pfd/CiG+//KPUOABUNQIJp/j+ACPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywRbNIaOSIi3xJLRh7SPDJn8OPNWshY45MbNupHElYI=;
 b=gHUfS+xrSa3eSGRUifOxRY5lzmNyn7LcoS8NuEXa0s5Uusl0DF/HGtehOUyKbEeTj07evcx+og5V5hdQuqvQSyrx4K2KI75ofVp6hTx6QbgS9OMN+tWXaYT4yoIJf/s7pxda835l2At6ROPXwUEx47s6UusG9C6DfpMRLgNnUgdJg9kW6ljNE6Gvkd4wrsiIwKiIHUA6LcKYCfDgAI1qqeM5gpAxqnL7rThOWMiGGpbjXcn3AQ/igOSbKBpqS6+39fzLH9ifDqx+cQoZMjD49NN8nhvPPe6+dSE33CG4GlUYkqS8Ylap5Qo7/NZQqHMAh+JEn79lbVOfijohm337+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywRbNIaOSIi3xJLRh7SPDJn8OPNWshY45MbNupHElYI=;
 b=LBBej4Mr+kTuOmNbdAE+Pc6W8+gapUf97Uuih26UZ3XOqGEe/JTkda190CrslS4pkFcq2dL7qdZN/n57pCfJclCNNY826dQshEvfQ0P1yxpHrxp0UBumhJ+k9YWFPzaisd1LF6loq5E3jWkisbTzO2ednyHcFBAkJ3bjRk/Yxkw=
Received: from DM5PR08CA0060.namprd08.prod.outlook.com (2603:10b6:4:60::49) by
 MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 22:35:19 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::45) by DM5PR08CA0060.outlook.office365.com
 (2603:10b6:4:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Tue, 27 Feb 2024 22:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 22:35:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 16:35:08 -0600
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 16:35:08 -0600
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [QEMU][PATCH v3 3/7] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
Date: Tue, 27 Feb 2024 14:34:57 -0800
Message-ID: <20240227223501.28475-4-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227223501.28475-1-vikram.garhwal@amd.com>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vikram.garhwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 940aeee4-4f26-42ad-2f91-08dc37e46049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKApwZ/jg/9r24qnqmBjoD9KO/W5SRR49ViFF9fV75LhZ4S162YsZz+OCQSGqHHQ7oqQdD6hb9A3eoDPMqCHBVBEtSAtlYJEVOtOyDhxxTxWii2H1oK6r83ddDWaB2A9bT8EfQOv4V8pDwmvLbynrrg4Cw4IBX1VCgIp2PrIBxdbqrpxoOaJe3Ma61n6xAh9qXtGQsWj9XVT/rw8YVLuxyxcnlwmZoMakR0Nn7h6vUcfFwQX5F4qqxO1578JImmRCl3iyFmVkS4G+Qp1N0dpiuo7P0hn7bX8WubgQ+R7VzfqsYSbitjk8GkYCUHz/OEGcT/AOn3X/pcmZRxyOUMrJ5ehcOn4UnoU85zxwIL1dvQV7TtsR8Flj3yfaaqF2P1ZiLBWIVcZBiPHXdrBpckqQ4YdqwdTb1RCRki0yL56nUr1uTjYk0tyH76f1yDpvsIH/wFKHfB7Y16NSvgKkiKv820HjnNiHhq1KmJWXYTp360OP4/9dbJ0zkfhqWBzjHXDjmxdY1Zr6L7woRs8uAzTetxOXspZvm8zo85FG0Sr+NZ1gAzizB4IBiVNvEUn8h0VSq08Ikitd0yvjSsM1Rl7+Mrf1ZwpcloyQYqkEFjw2NLjaWM8QjbDoxMHMae7907ZbVw0ygb65Zr4dxxhnVBTHjVNoGHDcVIoTLWH/CMe1JodFJ2CxYHIx6ssMMiRCDfb2p0jSon5qUc2uLTudh88fZXX7uze++B4mU6XN9eJ8fv/AJ82uWS7tVyAvo4jmEFO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:35:18.6310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940aeee4-4f26-42ad-2f91-08dc37e46049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
modify qemu_ram_ptr_length() a little bit and use it for
qemu_map_ram_ptr(), too.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 system/physmem.c | 56 ++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 84f3022099..949dcb20ba 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2163,43 +2163,17 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
 }
 #endif /* !_WIN32 */
 
-/* Return a host pointer to ram allocated with qemu_ram_alloc.
- * This should not be used for general purpose DMA.  Use address_space_map
- * or address_space_rw instead. For local memory (e.g. video ram) that the
- * device owns, use memory_region_get_ram_ptr.
- *
- * Called within RCU critical section.
- */
-void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)
-{
-    if (block == NULL) {
-        block = qemu_get_ram_block(addr);
-        addr -= block->offset;
-    }
-
-    if (xen_enabled() && block->host == NULL) {
-        /* We need to check if the requested address is in the RAM
-         * because we don't want to map the entire memory in QEMU.
-         * In that case just map until the end of the page.
-         */
-        if (block->offset == 0) {
-            return xen_map_cache(addr, 0, 0, false);
-        }
-
-        block->host = xen_map_cache(block->offset, block->max_length, 1, false);
-    }
-    return ramblock_ptr(block, addr);
-}
-
-/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
- * but takes a size argument.
+/*
+ * Return a host pointer to guest's ram.
  *
  * Called within RCU critical section.
  */
 static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
                                  hwaddr *size, bool lock)
 {
-    if (*size == 0) {
+    hwaddr len = 0;
+
+    if (size && *size == 0) {
         return NULL;
     }
 
@@ -2207,7 +2181,10 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
         block = qemu_get_ram_block(addr);
         addr -= block->offset;
     }
-    *size = MIN(*size, block->max_length - addr);
+    if (size) {
+        *size = MIN(*size, block->max_length - addr);
+        len = *size;
+    }
 
     if (xen_enabled() && block->host == NULL) {
         /* We need to check if the requested address is in the RAM
@@ -2215,7 +2192,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(addr, *size, lock, lock);
+            return xen_map_cache(addr, len, lock, lock);
         }
 
         block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
@@ -2224,6 +2201,19 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
     return ramblock_ptr(block, addr);
 }
 
+/*
+ * Return a host pointer to ram allocated with qemu_ram_alloc.
+ * This should not be used for general purpose DMA.  Use address_space_map
+ * or address_space_rw instead. For local memory (e.g. video ram) that the
+ * device owns, use memory_region_get_ram_ptr.
+ *
+ * Called within RCU critical section.
+ */
+void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
+{
+    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
+}
+
 /* Return the offset of a hostpointer within a ramblock */
 ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
 {
-- 
2.17.1


