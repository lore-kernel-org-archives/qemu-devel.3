Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7410C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFVH-0002ol-90; Wed, 12 Aug 2026 16:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFV8-0002na-AY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:24:39 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFV5-0007Uw-WE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSnanTkkxfZZ97tjqvTLZwsU5vqq9CqApuRE8I4S/EC9R9fcSUGVX18V0dAzl2mThVc4CCUVA7Yi//G49A/T6UTTXvc+VWXJsyQD9s0fkQZ5TVJz2u+GfCsRZx0vsNHroxAL40/MbE6s/I4NAGVvhCQBOX0k91MSSZYIdpjTRpKStsTvqt2gbuAjPac44YIzq/EHfKyM0SDDH6CW3LZ/jveKR6yPhStcjM7xPULicGJCTHMkIMwHLd3c4DQWhtsTpZum2JzXWMt+1IQ3kI41nwdbIMwxhL19/+msBtDToM09A11gZRfxZqprajevO4Mkgufvk6O3xpWyJjTsWqgG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueFaFGi2Tjduu4z3TYgh8q8yn7Kv3cK8T2FNmvEAhoc=;
 b=IlJ4jw4Oh/pt11yvKXwk/EeUF+hC63VzrcGtOCWjRilibAni5JjWYlxBxICdK/MjI9x92WoKSVdAy8V3FNfZvFlx+5DXFq+9QUirDJ09BQn2Krz03mrOmd3WYNpb/kCBEZRwwPWRvKDw5Y5IxvtmlXud2cDgH4ZW5Aq9rXNS/ZOraz4SN5DXlDtn+PrQj04DG+f4/Wti8uAy7u//bTOqlvje36/zNMeTjebsohWmXKEa9B8ZkCYC0LTxIucFW2+oDTg10QeeN0nVDY6e9Td7tjnKfIVUtGWLiy1h7l+kB8rho23xEHcSYBnXSvOXDqef0TF3Z2iObDw6ycocO1p8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueFaFGi2Tjduu4z3TYgh8q8yn7Kv3cK8T2FNmvEAhoc=;
 b=aNj0ZOKDPGJiJeJ+x+Gd4VJRr7FADzLLdlIIoEcwTJhqvJEgiHjo5CWyW9y/58KMsm6pIMC8p5nOfXzNz68C661H27l4ssLHORzUh3hrIprWTte7nQ+4fCMjqV57Vhj5jPHWxPVuTxtWq4Lkk8u1qmUpGBnV1UZykRk+xzXDQH0=
Received: from DS7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::14) by
 PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 20:24:27 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:259:cafe::73) by DS7P220CA0084.outlook.office365.com
 (2603:10b6:8:259::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 20:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:24:27 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:24:27 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
Date: Wed, 12 Aug 2026 15:16:43 -0500
Message-ID: <20260812201938.198915-6-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc1adf9-2df1-4c76-fe9b-08def8afb54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: nYLtffIaKLkNXrfGvWF9nDYo3zj4WWUxoh1s0SspiEzVl/5OPClMX7CY1W7ZGg7rpjb9pRNBA8MWKo4+PK4lKrBDEsCJYITNUUKMtIr6sLkdXbHBlLIPWq3TeLzAxL4WX4ohNnqqIVYJM3pCfIPRpppAViRrpW5ytTi6lFYLoH7+/LoP3ibo8RRHQnrsgGXA7eXx1wGgKsH7+BkHWjgsXbfplZM3YUcSIJyUaAACXlyXT3uV6K5/dX3VsrlJlo7UXqlBkTg+hRJuiBNp8F6S/aB13zK8tzVRU6Wv+jNgMTiStfzw23+NZvNJc2g0JxPviXlEahl1yMsC+3HwyCdpH145ZHjNap8w1DMq/0XvXm5NhVOIwGKsncBBqhol1k4n7zOfIBaZTV1DEKNN8jp+lgCrRh/KLqV0Y48g0UDbUD79v4BqNfjnik9kyS7wHcNTahvAYn4bREdvFdGdgP3gtTNpMmRyU+2F6R+fDtM3W6KfwLKwqWSQjwxGI3eR/1hTqOrTM1Zlq5+xZR8mPmwJaeLy6Ni/b5PbwHOuGU3o3rhwZ6tWlOwD5CmHK8b3h2Bw/stb1Qx8BccZX/F9ywWNBidqpUA1qkxuF3VhaqmKbshzkqkNIe3MAG64vYZ1wY6yDLrBM1YDiKATrV05xov8NrJJqDYinKAMW09v40vAmAjEL7HRzB6gIJguYcjFIk3ArVpljnX1OT0941OoIURcWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GOizrCXrxOGNSjZm+rcAdZ2Qr6n3PMDE7rc5RvjUug7JSBZ9Z8lIKenjNRbQgAowahtg5D+UFHgUXlz8f8+FZ8syEcIcv3c7V5Br/CK3sabtM5+biBKPF+RjQWBamZ9zj7dVdvfMIuOAVbuy1mvI0TWdUUAAJl+BzghAD1EDQ7+mWQ2k163XCanI9nlrDIDU8+kUWj0YZvDERdZpa73iSh6Jxfq3W6rKvn+DZvFQHqnTlXI7ow+fOHWy2xYM9VKkKYpuNI78leRWr+h8wHvKBQTOHJsLDlR+G+uOx+oMKndl2ktkiGQMbrK8YdNeRwV/LclKc3wvoBztqDwEeJwWa1PXWK0c3c8ujGNakaVh3H9JP7+WZtiD5mcbErPL95zX92uupC4trIBzJKuLlxwBC0GKE7229HEcDMFL3qzRPr74JsJUU3mdmSfrSyId2sUs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:24:27.7001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc1adf9-2df1-4c76-fe9b-08def8afb54b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
index 96b0a0a444..e960738af5 100644
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
index 8ed5e10710..4550a19a3f 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -251,7 +251,7 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
  *  @resized: callback after calls to qemu_ram_resize
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *              RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *              RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
  *  @grow: extend file if necessary (but an empty file is always extended).
diff --git a/system/memory.c b/system/memory.c
index 4e6d54148e..84dcd9954e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3660,7 +3660,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
                                         Error **errp)
 {
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD, errp)) {
+                                                RAM_GUEST_MEMFD_PRIVATE, errp)) {
         return false;
     }
     memory_region_register_ram(mr, owner);
diff --git a/system/physmem.c b/system/physmem.c
index b979518bf6..3a7a1a8b16 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2184,7 +2184,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    if (new_block->flags & RAM_GUEST_MEMFD) {
+    if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
         int ret;
 
         if (!kvm_enabled()) {
@@ -2321,7 +2321,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_RESIZEABLE)) == 0);
     assert(max_size >= size);
 
@@ -2478,7 +2478,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
@@ -2561,7 +2561,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE |
                           RAM_PRIVATE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
@@ -2837,7 +2837,7 @@ int ram_block_rebind(Error **errp)
     qemu_mutex_lock_ramlist();
 
     RAMBLOCK_FOREACH(block) {
-        if (block->flags & RAM_GUEST_MEMFD) {
+        if (block->flags & RAM_GUEST_MEMFD_PRIVATE) {
             if (block->guest_memfd_private >= 0) {
                 close(block->guest_memfd_private);
             }
-- 
2.43.0


