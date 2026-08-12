Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB87C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFUw-0002jA-GG; Wed, 12 Aug 2026 16:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFUm-0002f6-LP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:24:16 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFUk-0007So-EJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:24:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhx3ZoeZ8oLeslOMEuqlebRmQesC7hpjlgqSVBY5/7a9CnAvaT0/KZc0EpapHuFGs0Bn8ZM4pHUVfMi8byXZkJiAFYumXboDVu3JlzKzuvWxG667Cc+c4Xafja9qrFDZdN5cQ4mXxsHDCBdVXEvkedoDW/A9jvistHrbnTaE3zkXHVtzW/1CqGJCIwWUI6yf4r3jG3+gJ06z4EMEc+exGsbbqlI7/ecLy/E0L4+nwj3T/YrUQX1sAN7OmILfcpO6IQMz8e60ird81pjaKPH4QDMAleOLpdqUg5JcOZQnIRi83ef30Q4fh7ocC/HivOme/H/Gq2A/8LQVAbepJ71QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe2G99J+i/mgeIG3G2qjaIi+SFwSw1VMfoKCdISxIYc=;
 b=qGp5i7rh0Y47+MCYxeRIXEsGfejX4UFc2khq1Otq84s2wrREIjXk/ByIp6ZnNZCI40+c+fEOgJRIFMRB6U6PRI0Vr0BEKZGCoEzL5HYtTV9kQE8D1DxRtG1MrO+6MfhUByXXy9vjncFkPHqL7Jx64DHEstjF/e8Nf4v/pdt03a2L243yXFwv+cazu5aqks6askUB1vAMkPO8rdFBZPINtA2pMN+uOFPhytzUK1kNnjOo86HuNMFExIJnSbOFzOE1hRM/dtumv3TH2LT3bdPNyWsEmY5LWZJPOnjwiczx2PiX/tlMTLKYT+qqfQP16ynaEbjPImkM3xk0jf/WYRT49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe2G99J+i/mgeIG3G2qjaIi+SFwSw1VMfoKCdISxIYc=;
 b=aIBoFqThur8p9IDAZGYCvBfXNkxrAV8+zEp/I0R3EQW/VJH9DpNekILCahrmKPtZZkBbz/K6oFPJa6GKKFPpk7qv4afv99rdxUclC9ccNuKSZBNsIyE5mIWJII1NDIje7Mw7eEhr8RlcMPqdCH+nV9mmK7hi3noHPOdczDrppbU=
Received: from DS7P220CA0083.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::15) by
 MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.13; Wed, 12 Aug 2026 20:24:08 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:259:cafe::32) by DS7P220CA0083.outlook.office365.com
 (2603:10b6:8:259::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 20:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:24:08 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:24:06 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 04/12] ramblock: Rename guest_memfd to guest_memfd_private
Date: Wed, 12 Aug 2026 15:16:42 -0500
Message-ID: <20260812201938.198915-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 6123b132-a742-4f83-d00a-08def8afa9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uOvDf1QzM6RAdheYzu4eaheZU/6r5wmur2Et72tBmbESY1CrvuFNDuQg0CRUEvm/tDHuglaJkKUN7D5eAiWEllARY/QUl2RuzgueEJBvfgpibQ0SsJneUNb8BoPoe5SvcdW1jodfb2gYSbtzn4KuFgtxnnLB8IoNDQL3AvWKCcTezb7H5rwYOLLAKKdRycJ81k+h93l2f8udG1MhmVlAskRV3EjgIOJOWkATecuiGGvlBIkCAJZJ1xIRMogAd6w+hKyQ2oOn5ycGrPdMZ2JAIVSsLEnwIxX1EP/Xrtl5QLrv20hrNLpNBuU8aKzgy1xYD6sOEUhg6iwaRmI1ETVOYAjOeHslitKRRGyLoKHUCmk00NVNyn6B+4E6/qzv0l0G/3jQPQ0Rif9xppMh6RcbsPJliBldwuXLrheYv03TePInBHeDe25F8vu2uudRo7ppympmJUI1Rz5A9AVGDBePSB3Lodbv7DH/jcKdnVdFJEV57d2bAg+6bex91ngkm0CspwclJ59hhpo/IDCZ6tciXz46zCFSas1z7BZmDk/fHNEocLFcUkfgeDV/eh4dty8evclrdMY6QeRPL0VxIn+5+PBsuSPX9qSgE+LCzGN237+Tl4DWyK10+VGdXv/Lx3aldHcuo0xZSDWNvFlI11Jev+5vFWFKZUYWt9DCTBGymf3OXeb+ezL+I94xGNSkgP4gXNUZ0mWYWcdRQpg6n0LoUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qMbJdYLyj7StlNKFy/L1sfAm/1sRB8jm4Uajgd1kONDCxiQEhzonD90TgSY/VmFvWYTSCOxAOeL3dGiPJ7UafWEoVOOjxcVhkmHJisuXz2WGlGlTH8mAMUR0jgsPZ2RtEVvBv+JK729k4ysgjNSS8S3drWyNaThbMHdYBT4WyBr4bhtwVIUb24mBdSn58FUlkrKmuM7S6bJdZQqik0j+zVu0WXn7pfLgMzD4VOOyxLy9mxHLQ53OD7TTu9r1AUoxyJpe96/jvBxy9ro003btfIdNOLeJgirfmuevQGInsr4MFJsvN6z2fe/MB4ccflEU4lWotJZIYike5IzeOm05DJ4C/VCv+6F7chIoBm1QRDEZS6ut/Yf34Yc89yKXaStkKsOBfkmbuQtV3IV1qjM5V9ZFRNi40islBSjYzSWwm94yb16HQ8fbRqp4d9WU+7IM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:24:08.6457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6123b132-a742-4f83-d00a-08def8afa9ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Michael.Roth@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

From: Peter Xu <peterx@redhat.com>

Rename the field to reflect the fact that the guest_memfd in this case only
backs private portion of the ramblock rather than all of it.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c       |  2 +-
 include/system/memory.h   |  7 ++++---
 include/system/ramblock.h |  7 ++++++-
 system/memory.c           |  2 +-
 system/physmem.c          | 33 +++++++++++++++++----------------
 5 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index bda2e25a66..3afe491242 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1729,7 +1729,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
-        mem->guest_memfd = mr->ram_block->guest_memfd;
+        mem->guest_memfd = mr->ram_block->guest_memfd_private;
         mem->guest_memfd_offset = mem->guest_memfd >= 0 ?
                                   (uint8_t*)ram - mr->ram_block->host : 0;
 
diff --git a/include/system/memory.h b/include/system/memory.h
index 2192fc9bdc..96b0a0a444 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1507,10 +1507,11 @@ bool memory_region_skip_iommu_map(const MemoryRegion *mr);
 void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
 
 /**
- * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
- *     associated
+ * memory_region_has_guest_memfd: check whether a memory region has
+ *     guest_memfd_private associated
  *
- * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ * Returns %true if a memory region's ram_block has valid guest_memfd_private
+ * assigned.
  *
  * @mr: the memory region being queried
  */
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index f0639287bf..8ed5e10710 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -40,7 +40,12 @@ struct RAMBlock {
     Error *cpr_blocker;
     int fd;
     uint64_t fd_offset;
-    int guest_memfd;
+    /*
+     * When RAM_GUEST_MEMFD_PRIVATE flag is set, this ramblock can have
+     * private pages backed by guest_memfd_private specified, while shared
+     * pages are backed by the ramblock on its own.
+     */
+    int guest_memfd_private;
     RamBlockAttributes *attributes;
     size_t page_size;
     /* dirty bitmap used during migration */
diff --git a/system/memory.c b/system/memory.c
index 5fc36708ec..4e6d54148e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1843,7 +1843,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
 
 bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
-    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+    return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
 
 uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 406338f165..b979518bf6 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2200,7 +2200,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        assert(new_block->guest_memfd < 0);
+        assert(new_block->guest_memfd_private < 0);
 
         ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
@@ -2210,9 +2210,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
-                                                        0, errp);
-        if (new_block->guest_memfd < 0) {
+        new_block->guest_memfd_private =
+            kvm_create_guest_memfd(new_block->max_length, 0, errp);
+        if (new_block->guest_memfd_private < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
@@ -2229,7 +2229,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         new_block->attributes = ram_block_attributes_create(new_block);
         if (!new_block->attributes) {
             error_setg(errp, "Failed to create ram block attribute");
-            close(new_block->guest_memfd);
+            close(new_block->guest_memfd_private);
             ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2365,7 +2365,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     new_block->resized = resized;
     new_block->flags = ram_flags;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);
@@ -2538,7 +2538,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->used_length = size;
     new_block->max_length = max_size;
     new_block->fd = -1;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2589,8 +2589,8 @@ static void reclaim_ramblock(RAMBlock *block)
         qemu_anon_ram_free(block->host, block->max_length);
     }
 
-    if (block->guest_memfd >= 0) {
-        close(block->guest_memfd);
+    if (block->guest_memfd_private >= 0) {
+        close(block->guest_memfd_private);
         ram_block_coordinated_discard_require(false);
     }
 
@@ -2838,12 +2838,12 @@ int ram_block_rebind(Error **errp)
 
     RAMBLOCK_FOREACH(block) {
         if (block->flags & RAM_GUEST_MEMFD) {
-            if (block->guest_memfd >= 0) {
-                close(block->guest_memfd);
+            if (block->guest_memfd_private >= 0) {
+                close(block->guest_memfd_private);
             }
-            block->guest_memfd = kvm_create_guest_memfd(block->max_length,
-                                                        0, errp);
-            if (block->guest_memfd < 0) {
+            block->guest_memfd_private = kvm_create_guest_memfd(
+                block->max_length, 0, errp);
+            if (block->guest_memfd_private < 0) {
                 qemu_mutex_unlock_ramlist();
                 return -1;
             }
@@ -4227,7 +4227,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
         return ret;
     }
 
-    if (rb->guest_memfd >= 0) {
+    if (rb->guest_memfd_private >= 0) {
         ret = ram_block_discard_guest_memfd_range(rb, offset, length);
     }
 
@@ -4241,7 +4241,8 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
-    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+    ret = fallocate(rb->guest_memfd_private,
+                    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     offset, length);
 
     if (ret) {
-- 
2.43.0


