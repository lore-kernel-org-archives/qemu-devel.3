Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A682C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vzS-0004td-6O; Tue, 08 Sep 2026 09:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vzP-0004oU-U9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:56 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vzE-0006OL-SZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdwFsAJmjFyw0DL0RjVXnw8Pb+O5lRmuqfNuCwYEoZJnneKaTE1Ju0rFIgNbXIlpymdlAMSDTv/YjpA4cSulBh62ws1BQSzwfruQ8xCqsFcuD3BpEVUdAodLsVza4PrtPs+aER84/Sgq8gzjfVlqd1Axi3aiqgLHH92bZagyObIK4uIOOMmWdZOBd4GKQn39p0vQnJucO6U0ZkMQfOZ6xwB9dzd2UZ3MY1VQJ4EsjOv+Yg6g6URzDULw9D32kY5m+Jrh1nBbm6rewuDAvrjtqj/KItlQpeiKw2wmg8UhFeRlWaTXRuoSMVL/SoPN9vJhy6gXxaiEJEKJyMdeDd3w9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI1C/cMiyoMzLhrfhjMVmiB5Al0dSSDHI3H7WMhrxsk=;
 b=zWDfb9IDFB0f7AXBWjm5yEZWwj95QPi/uvGvNbFNeTe6kb1KjGfP9d2wvUuqjeXgrvTeaVYzu3vGONiGcRPreveQVceCvWbNdDDV5rxXqGwngvtn1bA1/FEEtvH/KE1dJM42MHWuaHN0NpoK+Bkc0zHjL9Ts6GZD8+vGjbkp9bTyF+QGzJhRUHBmNcJj62kk6lQIVXPVgF/oAKJbTwd52Rcx/rpas1GJ9Rh7qg7/EjRzAf1iGfjK8DZZW+p1WAeb6JqwzneZOlH5q0KYl+5THdFW6fhQrzgU3/SAtrJDXx/+suhZIgh7zYSqxFHZYBeexA/dwle70PRtgW4AP16oDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI1C/cMiyoMzLhrfhjMVmiB5Al0dSSDHI3H7WMhrxsk=;
 b=I23MgDAoWcH2ySttgFJ76UdCBP95zAkqVAjrcnDIbDsd8Ys2WOdxtYoypGBWbFQEBroplvqfmKpMv4PruwqGYtVwsYHK1fubIvSAsSDbC9Stxv7xgICr716nFZMi4K282bIGhRte+gW15OUPGdJc4YtmQNw6q/dOtgHkuS37tKA=
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Tue, 8 Sep
 2026 13:35:36 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::3b) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:35:34 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:35:33 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>
Subject: [PATCH v5 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
Date: Tue, 8 Sep 2026 08:30:55 -0500
Message-ID: <20260908133151.836685-6-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: ca009aab-1c5f-4ecf-9e79-08df0dae0f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|6133799003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: kv+gYqAtafwhxcLxucKcIVit0em9TiLQgiwZT3XBYTteEiBnFOv//bJvUfX2JeHjeeRhGFR1T5Ucxzc41NfwZjkcweUR6IYIiiM7IzSdN4luQzQxCoOri3i+9v1YOPWLanCW1V6esbhVixkcrcfOZxkVPtAFHVX/ShpK/ZeEBKRKCnB9ro4qHSvk8rBirZJpTJXjTNP4XQInjvNhndF9SPmEafckxKdlukE43sr2h4ObRKAwCPndjXn0bXHoFyZ8IPRjhKc4zsR77woNHI2Vhiq2AhdoIlEk6Ma41GsYucxUFihdnh5F+PUlIyLueOmwFehHucVPHqN0X1Gx7Zdn9O2b+iXgifEDw0cZ3iEuUWB3PyV4Biqi3NM/dNG4Bh5X+glhkIKzF1WAVm4YP4chMkawvu1Op3NCM6a0O9T/qSvV7Mw4XW9EVrNtRh+cDQBgVJ9KUtxG0AFQo8gs5fGFsBAwHir1hhTKGvUVEIR3uJs/ufBBh672FYD13ZgT/diDfQLgql9VtY1Juj+carjcfEvpmzx/UUvE58N3glTsMg7pz0Qdw8NA70c1rz2Uo7s45TCAs6sF8pKMoIRMf+HGgNAinKg5+q85SfWp394+1wWchHZZ71EJEyO3ybLeT8uxpMWTPj8myzQZE488/k+PNOURDaWlUfedM570iETEl7K10kmx1uWQvu9klo/tE/9oPWyuay9VqxfhPGZJElo8OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9Zvw2uouVrYh2UuA6nVV1ElOZq49nwoji9KdBBJokrR5EkirB6GW1oQXHG4sF4Tt9G2ASXfRrRVJ6LKKSxTCc+s7CPI5LJN9yoX8SsMci/mmVO3IV7FGwdo3yFYvwXdMuh8/sXuUoHQ5vMai5UmnYaYcEZ6KoLzcx+mlFKg37L963HkbUaxEILyKzWGsFmnPVRZovorFEmt+qwTlCE11ZcQVGaRZWzJI2qWQ17uIZCJeyTHS8OiLMuY2QOQ9JNcLoOleCXgX3vgpFMsbfXF1+4BtBDNf0wnuBJnMCq2J7itFhl7lf6L1I4Z5dDSBluM2mYvMgDXIwHL6KN14qJpCK2z048oUoSnY2HclY37MOLC8N8fxMgZL3MYTKesrMM2Y17ydGhgq9fNMkGfGRS4tzPr33GONmrPI6l9TSoX3px2UT7bX/4fuZ5NiXoyw57QW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:35:34.0165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca009aab-1c5f-4ecf-9e79-08df0dae0f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
index 8e3219c061..1f20cd8fd6 100644
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
index 923239f9cf..3f3e485709 100644
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
index bd9e22ab7e..e2f0bd6928 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3622,7 +3622,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
                                         Error **errp)
 {
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD, errp)) {
+                                                RAM_GUEST_MEMFD_PRIVATE, errp)) {
         return false;
     }
     memory_region_register_ram(mr, owner);
diff --git a/system/physmem.c b/system/physmem.c
index 305a3febca..f6dff18bbb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2182,7 +2182,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    if (new_block->flags & RAM_GUEST_MEMFD) {
+    if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
         int ret;
 
         if (!kvm_enabled()) {
@@ -2319,7 +2319,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_RESIZEABLE)) == 0);
     assert(max_size >= size);
 
@@ -2476,7 +2476,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
@@ -2559,7 +2559,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_PRIVATE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
@@ -2835,7 +2835,7 @@ int ram_block_rebind(Error **errp)
     qemu_mutex_lock_ramlist();
 
     RAMBLOCK_FOREACH(block) {
-        if (block->flags & RAM_GUEST_MEMFD) {
+        if (block->flags & RAM_GUEST_MEMFD_PRIVATE) {
             if (block->guest_memfd_private >= 0) {
                 close(block->guest_memfd_private);
             }
-- 
2.43.0


