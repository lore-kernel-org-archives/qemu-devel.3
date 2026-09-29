Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BF8CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhg9-00082u-Va; Tue, 29 Sep 2026 19:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhg8-00082g-Sk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:56:08 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhg6-00086w-F6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:56:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdj1DKUtUaXL9bT4QedvJTImupv0N246jTnh9ND2H8SaPGop//+Pezu4n3DxrN1iYnwa5Uf7LPjPoeboqYxNjHBdT65jtzXnL5SlRFquRP0vq5te30CF4Dnf33S9M9Ag8CCvlNw6PDC+L7m4ibOvQWCPktYZMkJ/rhVnH5kEDVziXY12d6BFJmiKJuItbLL2MdgVlYiVSapLVHIIUR47BHOP8KmZPyqfgBqiFVjGZaUW8DK+bG/6HHVbi8ynFES7FdIGKI09AZOUOJp/HjkyMs/yVXS757CJyR3QXLSWGWewMFboNkCr+mcuWOdHKUTHoE3AW0n+j5d5ggpalWY/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zVhRQe4wMp+VSD4ASdc6w5Uv239UOO8FT66sySDnn8=;
 b=ZkJ8rGEDboiVX+ded7HNQwmhmwknvGvFP2vxwvaY4yST4PTe3s51Y7U+HtxxrbzMxhmJ65rieibRTjLFedbxpkx0McPZ7P1h4Y7962HRC/2Cu3y3zaYyZpi66qpCcTH6cmAG1VdTy7wRzrqSwb4AqBMCoUcvqJqZEny0gPwi4BEw52hHawOQZxEvwwfXnXCKVg3OCGBBmffnTWSUNVS8C1z4u1nNUELHf7OqbzmzSzedGC03hAIPwpaw6jzOMR0sj33Qpx4oU3hgjrO0GDFk/TsMmdRrDMaA/0hQOY8XyqA+V30nL3oqr8J7DYf7/l/gsNcx0cprGtRgSEOMozIf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zVhRQe4wMp+VSD4ASdc6w5Uv239UOO8FT66sySDnn8=;
 b=qaSjmDCvQ1MySk9JSkck8ZLvz0DG8mIh55y9FYF83q4v+TpscwzMXXh8v0vaM5JpSH8vKtzDf49KFg/5EY4w2khZpyjhKvvc592aaaFUj3l94R3lefNt8+kUUXyvDJAnh3jTv3NW2G3cmbPWRv3jZXdO6m+X3JWSvBqPQji81NI=
Received: from BN0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:141::11)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 23:56:00 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::c) by BN0PR07CA0029.outlook.office365.com
 (2603:10b6:408:141::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 23:56:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:56:00 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:55:58 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v7 04/12] ramblock: Rename guest_memfd to guest_memfd_private
Date: Tue, 29 Sep 2026 18:50:10 -0500
Message-ID: <20260929235109.1398509-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929235109.1398509-1-michael.roth@amd.com>
References: <20260929235109.1398509-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db1ac11-7ceb-4883-5b94-08df1e853683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C1b0iZPSQc/B83gBt6zSW6Nfbb+u8rz+7BOsVxAa4ndfczqNvzfX+rD2HqMIIZFTTD3UbkucHh2EmjfIABNNCszUDJ5BqBhDn8gJuMqTS3TcZezPHJ6rnkDHElqQYtZhWVR6GuqdKBBTLBsT2A7jpl/vVatHel4c1LPDlYUuzKvAF8aNWbIGbK4OiHo5TBA6w3K6GajuX5/fEcfcpPqsASkwy9p4DhUglfA0nLkZJShvRwb/JA7mBKiIihcu7dfttb4k7qZgmzjWIMHiCAwdpRFhR8Hqo0i6CqlE84Nmgktmencf4tgo922MHMnz2EtN8Qv0aAF/vevzeLJB3v2hJYOfGM05Q8fou3Rt247qIt2VWs3VJgepOectdUBisYVc5JBHw8DgUDHLXU/75dcNRL2L9ONeQH8vggyvt01a/GIDW1/m9YJDjZCzyZlw+cwClxSw+NCMvfBN6NRX0B7yoVreE41O1iHdqpiqGG0z8HrTFA9pkUFQnR8HWHZOxEWlFLSm0s2DF4IvpO6qebsGWejG3Ajtt/MjcJCLyrZbimGtwHlb2LxM6udKBaGdBohNG92rUvkTDa4TtajKbGLkmK/1YZAdJb024RPCTg3CrnAKv8VJY5YbPgfRz2VrOz7fgIk85+fw8haoQ9HYTgUejb1ImPBsT3G0ETL796SWpxZfTvWLa1m6hdvo7kH1qisXwgfXZ6SbBm9G0ZzNes+WMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TLTu8wn5eO/ceKr5//mWie9boOPiMqIE9QBiBBLKfQ6kqda/j4rPmqEq8nvxfe4RYn48eCcCjD8RiJbeL1LXpRVer2b/q5WT8gZE4kKivoK3fK6dtLI4GyXeTdhwiHM+sya6NWZSQoDBfO+frhpA+c/aGHA/DOVMLvcJHDAK1fE7d00zyTgwN06buL2HZer65q0VUgkNvsSdBQAtu5C2daBWg60RR8duKyKHF98xQp2WC0y8ZrypMJAV+w2nnUq4OEn9YFvswbLokFWZccPED3V/GOBXswESk2r86xDeYbEc4Bs8fGJTmcdLYAoz7DtL95494/0XPxeD5FpJFL6b94ckR3i+OplFzGcCc2cBKrHi+LLPd9Orn8zcSW0/SWfcsnXWeBmUVvDlXK71zhGEDXAkp8FwCH6nNNED6UuArS8cDggR6IIww40IPmxzht3I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:56:00.3542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db1ac11-7ceb-4883-5b94-08df1e853683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c       |  2 +-
 include/system/memory.h   |  7 ++++---
 include/system/ramblock.h |  7 ++++++-
 system/memory.c           |  2 +-
 system/physmem.c          | 33 +++++++++++++++++----------------
 5 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0b1407e4ea..a29b1d7a3c 100644
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
index a7e03fc3e7..aef555af80 100644
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
index 84624aca2c..0388d6cc6b 100644
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
index 264dc90c0a..b07d5dc542 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1780,7 +1780,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
 
 bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
-    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+    return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
 
 uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 1b3f327ed5..156853c8db 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2201,7 +2201,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        assert(new_block->guest_memfd < 0);
+        assert(new_block->guest_memfd_private < 0);
 
         ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
@@ -2211,9 +2211,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
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
@@ -2230,7 +2230,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         new_block->attributes = ram_block_attributes_create(new_block);
         if (!new_block->attributes) {
             error_setg(errp, "Failed to create ram block attribute");
-            close(new_block->guest_memfd);
+            close(new_block->guest_memfd_private);
             ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2366,7 +2366,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     new_block->resized = resized;
     new_block->flags = ram_flags;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);
@@ -2539,7 +2539,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->used_length = size;
     new_block->max_length = max_size;
     new_block->fd = -1;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2590,8 +2590,8 @@ static void reclaim_ramblock(RAMBlock *block)
         qemu_anon_ram_free(block->host, block->max_length);
     }
 
-    if (block->guest_memfd >= 0) {
-        close(block->guest_memfd);
+    if (block->guest_memfd_private >= 0) {
+        close(block->guest_memfd_private);
         ram_block_coordinated_discard_require(false);
     }
 
@@ -2839,12 +2839,12 @@ int ram_block_rebind(Error **errp)
 
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
@@ -4272,7 +4272,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
         return ret;
     }
 
-    if (rb->guest_memfd >= 0) {
+    if (rb->guest_memfd_private >= 0) {
         ret = ram_block_discard_guest_memfd_range(rb, offset, length);
     }
 
@@ -4286,7 +4286,8 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
-    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+    ret = fallocate(rb->guest_memfd_private,
+                    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     offset, length);
 
     if (ret) {
-- 
2.43.0


