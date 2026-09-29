Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D74CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhgT-000050-TV; Tue, 29 Sep 2026 19:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhgR-0008UD-6A
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:56:27 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhgO-00087Q-VC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oda93RUVZWR5yhuir91r2azzdJVppbw1mz3FQSvNV6W2c2MWETKauYGOY5IFYKykoNyPWM9YmPURPmLSy/Wzh4cYxhV/6xeMepVqrzhoMg+5P6i6f5+EG83VEJvTzAvq2q2kQCIHoiA7qxnkwml3Ov+SRyT6xFXB8Pf8GNXDok0MvOAQdqLOytbBKreWzpI4KTUFWxU20MHQ3bNjrGWIANephYzkcMEqp4lIVhF7W7KFEqTWls2oNyVBFG+OxTgIWNFQr+42CPxFwtqox3ibUYHhBZhUSEBZ4U9889sZOt2tViOfqDu8wnBRw1BaWpG94u3+rfyG6mkVXvgM/oTC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwSrhALBYFI6TSXx0eAuRhvNGbLQwWtRVuS4xOl3fLA=;
 b=ULl2qLnmnrOj+1R7mvTEf1B8So+0BvYtuLHJer76hsk18hXdGjU28t9Ml2KxpAfvcxJYTRdT74+G0Z8T4e8NoiXRF1gGlZM6DgGjwa26ZIq6wCwVCth+zpu8w1kWlDba+TJ50tUooHGOHjOb5zXgWXFKZiZ2HgsMCRoprX3R37RO1QTRkCKI3LOalL7jGjXnz3FVYnt6BCXSDIS38vjYRslvQLzA8PfltHqG9vJ08zCibEkr7JLatSVNSLrfAHWX3jXs2JauvXILA1Ms30S00nmVzTrbY/OMxNqSzp/02ZBJ1iGgBl8ohz+ad8w0xYjTIQkiRcanVNfYJyxc5HdrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwSrhALBYFI6TSXx0eAuRhvNGbLQwWtRVuS4xOl3fLA=;
 b=hVoaKRixbJWwx06XmdouQsXj/sECH8Pr6q6dQJONscPtrukOtuSOi+n4mLXo9ruTlEDNXUCI4PiTBFKpmxdFLIwanVb1qVswAIkjUlbecGlyyaoxtfScgCZsreKGALNBl3wwj1+j+EQvEKOARAQqarvCiaKLd/tX1i7IOel6bA4=
Received: from BN8PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:d4::12)
 by CY1PR12MB9652.namprd12.prod.outlook.com (2603:10b6:930:106::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 23:56:20 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::86) by BN8PR04CA0038.outlook.office365.com
 (2603:10b6:408:d4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 23:56:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:56:19 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:56:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v7 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
Date: Tue, 29 Sep 2026 18:50:11 -0500
Message-ID: <20260929235109.1398509-6-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|CY1PR12MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: c2561eb3-0dc4-470c-737c-08df1e85422a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iKvS9nNrmB+BdVJYVAqTq0qtZrP8jD1fk4aHUH80VmKs3Afx+UGewz6mPbGXnxkPIyEcQAlwkOnH/x3P14qJW0GZnIQyQVZ2Stj0WUOmCOTwSJ7uVcdkDW1q1cYMIYaIgBD/0tcw6C93pQU7nf2w7IBDBEnxWlp93uTCG2Blll7we7NbtHxXt+aHCRtP28Pi06Y+BIU72Af4RcnWHXqIDWfVlBw6sjL7N6v2NTqiRBUH6A3D9tDUmrSk9dgitb6LHORQc2XXyQfKEtq2kW+NKiRF7liFxtf/oLXVRg9FuZMKxglvIw259z7xQqr5o/tii1UjXEL7haSUyOogF8idS39LMxdihPWb+Tn951ObkGtNBTdX17w/oa/BtizdGuonLBP9acih5tpOHALVrpI3HLLwXAeGtiylqkPBfDbaMAt+4MZK4p61L4sp0MjyqTZXi/EkdfbdquVGcwxbRKGDikGU+3jNYZCFMyRXwK8ivcC7aeHrxvA3uZrILPPW+7HJNwJOb1Hl/jbtPKsWcowWnZUeeIH5H5mvx3rSJwq81anQZroepAqg5HBEepTjfUDVM7TBjHbdFfBZXIgeZLZ2/b3MOC/NEu3zKpAlwMl5BJW7zD+odqpGhzljTsUcedqC6FPLJ1qxO1bCPuRsuZ6Ee98k6u98S2Ra7uUzTio+Qd83eDFf5iX98IhellaXKvvABmcpnLu7pHVey0NW03sS/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WNBZhRzSU0gsOojuDg0hKSRz79pTwpat9RF/LRSVxcYVZ+MAqiY2KKlyhXmqJ80GBJzi2HN2s7Z286xNERcfPmKgnL6/ejARD2zt8xSmTEA5aBnR3cOMAT+wzZLw2vvAZJY0yaNBPLCnRR1yO4DRSXvFyWivzialeTXPDsOvrSGm2n8GQpMmedTlI2/Ml95WKETzWOywJ7nZudJeSklxp9POoScntjmlw3/QWLY+v6Pve2fHKM/3IFLjR/vKBXvUOjOD4HxCJk6hgiXHRHgPpqw3kxgaENWw2eUHU6OB0YPkQVRKvnMj9hROR5oeb0b6iXqlE92FmGEFmRLJgm5Ky+t8tw9R53zrePa/WAqkbHLDbCPUxvFc/qfel/mt4cvLNUk/FYClifQ1s/+X6YfDMcRj/+J3Ba+B/sBsdg0E78pFtvutJdpCx/7G9W4IDi9Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:56:19.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2561eb3-0dc4-470c-737c-08df1e85422a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9652
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Michael.Roth@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

This name is too generic, and can conflict with support for using
guest-memfd for shared memory. Add a _PRIVATE suffix to show what it
really means: it is using guest_memfd specifically for private memory;
whether or not guest_memfd is being used for shared memory is something
to be configured/determined separately.

This also paves way for in-place guest-memfd, which means we can have a
ramblock that allocates pages completely from guest-memfd (private or
shared).

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-file.c   |  2 +-
 backends/hostmem-memfd.c  |  2 +-
 backends/hostmem-ram.c    |  2 +-
 backends/hostmem-shm.c    |  2 +-
 include/system/memory.h   |  8 ++++----
 include/system/ramblock.h |  2 +-
 system/memory.c           |  2 +-
 system/physmem.c          | 10 +++++-----
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 8cf27ad67e..bb7323d2bf 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index e21c5a3f2e..d917a94d73 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -60,7 +60,7 @@ have_fd:
     backend->aligned = true;
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 062b1abb11..96ad29112d 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
                                                   name, backend->size,
                                                   ram_flags, errp);
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 806e2670e0..e86fb2e0aa 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -54,7 +54,7 @@ have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
 
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                               backend_name, backend->size,
diff --git a/include/system/memory.h b/include/system/memory.h
index aef555af80..932072c631 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -262,7 +262,7 @@ typedef struct IOMMUTLBEvent {
 #define RAM_READONLY_FD (1 << 11)
 
 /* RAM can be private that has kvm guest memfd backend */
-#define RAM_GUEST_MEMFD   (1 << 12)
+#define RAM_GUEST_MEMFD_PRIVATE   (1 << 12)
 
 /*
  * In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
@@ -1119,7 +1119,7 @@ void memory_region_init_io(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
- *             RAM_GUEST_MEMFD.
+ *             RAM_GUEST_MEMFD_PRIVATE.
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Note that this function does not do anything to cause the data in the
@@ -1181,7 +1181,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *         (getpagesize()) will be used.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  * @path: the path in which to allocate the RAM.
  * @offset: offset within the file referenced by path
  * @errp: pointer to Error*, to store an error if it happens.
@@ -1212,7 +1212,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  * @fd: the fd to mmap.
  * @offset: offset within the file referenced by fd
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 0388d6cc6b..1352ec1603 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -257,7 +257,7 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
  *  @resized: callback after calls to qemu_ram_resize
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *              RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *              RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
  *  @grow: extend file if necessary (but an empty file is always extended).
diff --git a/system/memory.c b/system/memory.c
index b07d5dc542..96e42beb2e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3597,7 +3597,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
                                         Error **errp)
 {
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD, errp)) {
+                                                RAM_GUEST_MEMFD_PRIVATE, errp)) {
         return false;
     }
     memory_region_register_ram(mr, owner);
diff --git a/system/physmem.c b/system/physmem.c
index 156853c8db..db3dda563d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2184,7 +2184,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    if (new_block->flags & RAM_GUEST_MEMFD) {
+    if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
         int ret;
 
         if (!kvm_enabled()) {
@@ -2322,7 +2322,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_RESIZEABLE)) == 0);
     assert(max_size >= size);
 
@@ -2479,7 +2479,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
@@ -2562,7 +2562,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_PRIVATE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
@@ -2838,7 +2838,7 @@ int ram_block_rebind(Error **errp)
     qemu_mutex_lock_ramlist();
 
     RAMBLOCK_FOREACH(block) {
-        if (block->flags & RAM_GUEST_MEMFD) {
+        if (block->flags & RAM_GUEST_MEMFD_PRIVATE) {
             if (block->guest_memfd_private >= 0) {
                 close(block->guest_memfd_private);
             }
-- 
2.43.0


