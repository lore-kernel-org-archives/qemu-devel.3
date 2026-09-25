Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2786C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vFG-0002sb-J4; Thu, 24 Sep 2026 22:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vFC-0002dO-Cu
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:00:58 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vF9-0006iA-SX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:00:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EM/9bkWmDDwg1mQIG/BSKresHS67hLuTUCipO3vcT4vT85J8jVFdAUX+d3vWuj6cRTKV97QcNw9qesE2hd2XhiboBGpndlV27da3wBZEibfxRdsxbOBNOCqreVDECqnaxWiaJp70K6h6NNfjc9JMH/Qbo1+r9UscOjBFmsGvZVY2OWp9pjcYrH06lEADpmcP1U/bBRA1vbnYyLnz9IUAO08wefj9RKpqdf88PtxHLWk4q2Q7fZgkT19JhHPreOu/lZboeFD7CggCGHX4QG1VYIWK1oR+QK/vAL2TqYh05kbq+2h8hkFqZ/HsHULoNYmAF2rjBl6n+Q5uUKF1vE5rVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwSrhALBYFI6TSXx0eAuRhvNGbLQwWtRVuS4xOl3fLA=;
 b=G8jdTRLSgcqDVhLmRNsZ50jl5XgV+E/7EW0c1lrdKXkKowEKen7uvAwPvVXhe8gI3rmHmNV2rZdcCvy+52RCRF/y8XlZTo0S9xiF7OTwbixzYUWiRpFndCxuUUgQxTVNB7pgxxhnx2uG0vcAs1Q5P/prcF/P6bgpZxelZqDOzXDoac/l/Mo6hIVffrXThY32tjoIiiM/obC3W4OlM+gB5VotN5ITEdBc6jEHSz8F6tsAptIR/Yi9ZT0T0nBGnHnf0kckvRnupSzrviZrdut29N0ChIX6NQ3GJm8qt6YyHe03f2IzJmDUQiuYdzTUtIaIdAfUTB4pMyFkgypYCzdG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwSrhALBYFI6TSXx0eAuRhvNGbLQwWtRVuS4xOl3fLA=;
 b=PRTs6RKsljW8G1MEsgwzNgjECPstLkuQZaWgRrzKe/k5UHOQjAc1/CQeZ/QmLTgDh4HoOVJdyZLctMa3MDs2bPXSOjgGXnMV9DKuHUTkCJqxTR3zVsFU31LHBvUN9w25ZfLSmlXG1qGAq1gqXolAXC25Al8CMIk8cfVVYAHY33c=
Received: from SJ0PR03CA0178.namprd03.prod.outlook.com (2603:10b6:a03:338::33)
 by DSVPR12MB922022.namprd12.prod.outlook.com (2603:10b6:8:3e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 02:00:45 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::17) by SJ0PR03CA0178.outlook.office365.com
 (2603:10b6:a03:338::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Fri, 25
 Sep 2026 02:00:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 02:00:45 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 21:00:43 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>
Subject: [PATCH v6 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
Date: Thu, 24 Sep 2026 20:43:11 -0500
Message-ID: <20260925015700.1260501-6-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925015700.1260501-1-michael.roth@amd.com>
References: <20260925015700.1260501-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DSVPR12MB922022:EE_
X-MS-Office365-Filtering-Correlation-Id: c96a01ae-6ecb-46a9-af90-08df1aa8cfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jOneiZYGc4jPkQ6/+Di4quV+oXxsdh+3MAcptRysfvSNB8I6B8RaTF24BD9W9sf+pyHVyHeRkACZRindQIbIV6ftqTnR2uvd0iwAlpoTtu6WA/UfE8RpAh5w7mddl4dq9ELL/M9hVx+gjOSO1F+ss3UCM0rFMPbHm+YovLqnXsSVHtIGRyOc6OBF4bwzaLZRzzFWHTJ6FUCh3GG/gDC1DBknJhDpTBK8sSn5ybKEs3pF9s0IOYEV2eWsobuWFk0YuAXZYkze6WCS6uKjUj6QPzovExGjmMbIuxC+rnlt2/u286Xa6Qp5UAJOaVZzi+LNG60tPDbOlDovv1z1dA7hWvqqE2af25+EFSZcWk/s9mIQrsCTBrehq3FRT+6pAsWRCcaH92LAbVqSs/Q70JoR5Z4JnI8evIODomu5cJA/pDAKiLORSIMoIQRn0N8vo0MFzyVvrZmDmiYoUx7JO7+h03aXOWtlVOzpj3/B39IwEDtr7dY6iEmDb9IdQLOoOZbk3V/ASfkDIYzgll0ttjof1zqas4usjW2/1cYn57/FjbBg+qCQn6J/WhPwuSCoMPpndqooljV1a9al+7JmdZRjdyBr4od+jwsyxJJ3xqvWbVBwqeLxn5Hyz0KpxRyXfFrQqnJ7n1G65N3XP8ACeiI+WM+H8WhRb+O4cwuM63jDDGcsZsLJcEw9pSEz3coYKGKOdpy1YPxG+9EGPz7+4jfe1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5KKw1jHM0+dUf7T/zsZtUI7GPuBtOh2Tjbf1Az8kHllVxRhnZylYxJKSvwjX161YW+qr53jLTnrfKf61bIHvOJtojIEWM+MbcYj2PSe1Qzco6JO9umKibj7jKWsUvy2JE/nIsGUDRwM9O08Yh1c32Civ4Fpg5DOg3534Oi8zK6OYgTEI5NM88AjJUxNXOF3/Gmyxmkd0bCzi2WjWY57mo7lFeUQr7EPqI7sGLEJmYtN3E3HZ6rJaESLGvKRBxpP76njbCRTPdCRW+7OEh+ZeWWqoWitaAowbxVQTyIxwygqh9BNV8M9jhUhbZ9TvDh+dupHOdM8j1kMhUW5YADuerMw0rXwRNozS7OrMp4goT5PjRa3Y5DWhEfUUuDpHqu0N0aScusjbai8SlePEc99yhto0eQdgVjXgZDzeRs1T0+6FKeoA5Es+0nIR/2Ib3lz+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 02:00:45.1013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96a01ae-6ecb-46a9-af90-08df1aa8cfc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB922022
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


