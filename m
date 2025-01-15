Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE474C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8dZ-0007Gq-3I; Wed, 15 Jan 2025 14:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dS-0007Cf-IG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dO-0005bH-QA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:02 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHu0Go028112;
 Wed, 15 Jan 2025 19:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=Y16K6/eVE5VM03T8KQdxgNL/j9U5bX5Bd/s6nllMzko=; b=
 REHgNgAyJTQzSGKk6FkU886WKtSPRpFkxeJRLyyxDUfz7TNFBBkL+x5WtoTl5HyX
 9r6DbCWL1xCuX+qwZCQzpsggZ0r2pWwTD7oDW7oV0O154yE6QvalPbFITGbi6GB+
 B9Z4cAcRuLOEzzUSBLJG9eWhjQY9rAWbSwtOhwS4RufypSHrheOJR5P4d+M3HIGB
 MW81R3Upsq2u3Mb3I9gGktaybHueyQgbIzf8zkCtNwFldzPYlZAf2wVV50y9Wzge
 JjPBzvji1EAP9j7xnuCg+DGFrJfN6jBm1OQXU3RxQ0fWBmgop1YwZH+o1mFA6nIe
 Ndy/RpW+kuvXs5miC9uNnQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446912scux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FHoAN7034817; Wed, 15 Jan 2025 19:00:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39ur01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:54 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0pdx016497;
 Wed, 15 Jan 2025 19:00:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-4; Wed, 15 Jan 2025 19:00:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 03/24] physmem: qemu_ram_alloc_from_fd extensions
Date: Wed, 15 Jan 2025 11:00:29 -0800
Message-Id: <1736967650-129648-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150138
X-Proofpoint-ORIG-GUID: D0CxDZ0ZmOD2LgCvTm05yHY6G9ta65_o
X-Proofpoint-GUID: D0CxDZ0ZmOD2LgCvTm05yHY6G9ta65_o
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend qemu_ram_alloc_from_fd to support resizable ram, and define
qemu_ram_resize_cb to clean up the API.

Add a grow parameter to extend the file if necessary.  However, if
grow is false, a zero-sized file is always extended.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/exec/ram_addr.h | 13 +++++++++----
 system/memory.c         |  4 ++--
 system/physmem.c        | 35 ++++++++++++++++++++---------------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index ff157c1..94bb3cc 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -111,23 +111,30 @@ long qemu_maxrampagesize(void);
  *
  * Parameters:
  *  @size: the size in bytes of the ram block
+ *  @max_size: the maximum size of the block after resizing
  *  @mr: the memory region where the ram block is
+ *  @resized: callback after calls to qemu_ram_resize
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
  *              RAM_READONLY_FD, RAM_GUEST_MEMFD
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
+ *  @grow: extend file if necessary (but an empty file is always extended).
  *  @errp: pointer to Error*, to store an error if it happens
  *
  * Return:
  *  On success, return a pointer to the ram block.
  *  On failure, return NULL.
  */
+typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
+
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
                                    off_t offset, Error **errp);
-RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
+                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
+                                 bool grow,
                                  Error **errp);
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
@@ -135,9 +142,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
                          Error **errp);
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
-                                    void (*resized)(const char*,
-                                                    uint64_t length,
-                                                    void *host),
+                                    qemu_ram_resize_cb resized,
                                     MemoryRegion *mr, Error **errp);
 void qemu_ram_free(RAMBlock *block);
 
diff --git a/system/memory.c b/system/memory.c
index b17b553..4c82979 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1680,8 +1680,8 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->readonly = !!(ram_flags & RAM_READONLY);
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset,
-                                           &err);
+    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
+                                           offset, false, &err);
     if (err) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
diff --git a/system/physmem.c b/system/physmem.c
index 792844d..4d13761 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1942,8 +1942,10 @@ out_free:
 }
 
 #ifdef CONFIG_POSIX
-RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
+                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
+                                 bool grow,
                                  Error **errp)
 {
     RAMBlock *new_block;
@@ -1953,7 +1955,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
+                          RAM_RESIZEABLE)) == 0);
+    assert(max_size >= size);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1968,13 +1972,15 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
     size = TARGET_PAGE_ALIGN(size);
     size = REAL_HOST_PAGE_ALIGN(size);
+    max_size = TARGET_PAGE_ALIGN(max_size);
+    max_size = REAL_HOST_PAGE_ALIGN(max_size);
 
     file_size = get_file_size(fd);
-    if (file_size && file_size < offset + size) {
+    if (file_size && file_size < offset + max_size && !grow) {
         error_setg(errp, "%s backing store size 0x%" PRIx64
                    " is too small for 'size' option 0x" RAM_ADDR_FMT
                    " plus 'offset' option 0x%" PRIx64,
-                   memory_region_name(mr), file_size, size,
+                   memory_region_name(mr), file_size, max_size,
                    (uint64_t)offset);
         return NULL;
     }
@@ -1990,11 +1996,13 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->used_length = size;
-    new_block->max_length = size;
+    new_block->max_length = max_size;
+    new_block->resized = resized;
     new_block->flags = ram_flags;
     new_block->guest_memfd = -1;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
-                                     errp);
+    new_block->host = file_ram_alloc(new_block, max_size, fd,
+                                     file_size < offset + max_size,
+                                     offset, errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
@@ -2046,7 +2054,8 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, errp);
+    block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
+                                   false, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
@@ -2061,9 +2070,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
-                                  void (*resized)(const char*,
-                                                  uint64_t length,
-                                                  void *host),
+                                  qemu_ram_resize_cb resized,
                                   void *host, uint32_t ram_flags,
                                   MemoryRegion *mr, Error **errp)
 {
@@ -2115,10 +2122,8 @@ RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
 }
 
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
-                                     void (*resized)(const char*,
-                                                     uint64_t length,
-                                                     void *host),
-                                     MemoryRegion *mr, Error **errp)
+                                    qemu_ram_resize_cb resized,
+                                    MemoryRegion *mr, Error **errp)
 {
     return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
                                    RAM_RESIZEABLE, mr, errp);
-- 
1.8.3.1


