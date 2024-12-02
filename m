Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FFED78322
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Zl-0004iO-NM; Mon, 02 Dec 2024 08:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Li-0007yC-Uf
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lc-0005gI-DT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:23 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26XML9013787;
 Mon, 2 Dec 2024 13:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=KAIQZpXnGy6pVdwuvfo7Shh7bliaiotYtNJFyvqtlhM=; b=
 ouFiaGvmIbBMCYjUKCScmUKpvMuyzuCn6s2ICf8q95ZC6QQk/cyNPO15xrHPgMbg
 IB7tgg+kYGyXqrHyIDYtm4w7IuC7AnJkvXwD/OclnzrvarIfOd7SrCt7jaYdJ/p0
 HDwXS9lLFeYmDKDYsMNCADcrmHLqgwx0ODhRj5523qZ6Vqpk/XOqO506JdZnl6Pp
 9VT+3f75Ij34LVoiGX9mvoMP3JoOq8o0YcaBSynM8HK7uTjdvoSxC/R2ZO5w8xOg
 DddRiOM7Z//fBwGO0YMheXNqCaVLMah7Qsqv0NL3FHFIClqnOuDeSjCTk+eZibUp
 QbwS84yxN89kSEL6sT4Tiw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c333t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2CEJ7T032829; Mon, 2 Dec 2024 13:20:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCEb032806;
 Mon, 2 Dec 2024 13:20:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-3; Mon, 02 Dec 2024 13:20:13 +0000
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
Subject: [PATCH V4 02/19] physmem: fd-based shared memory
Date: Mon,  2 Dec 2024 05:19:54 -0800
Message-Id: <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-ORIG-GUID: _grpuIs03P-XbjUKAO7KEPnM8ztbpaEw
X-Proofpoint-GUID: _grpuIs03P-XbjUKAO7KEPnM8ztbpaEw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Create MAP_SHARED RAMBlocks by mmap'ing a file descriptor rather than using
MAP_ANON, so the memory can be accessed in another process by passing and
mmap'ing the fd.  This will allow CPR to support memory-backend-ram and
memory-backend-shm objects, provided the user creates them with share=on.

Use memfd_create if available because it has no constraints.  If not, use
POSIX shm_open.  However, this may fail if the shm mount size is too small,
even if the system has free memory, so for backwards compatibility fall
back to qemu_anon_ram_alloc/MAP_ANON on shm_open failure.

For backwards compatibility on Windows, always use MAP_ANON.  share=on has
no purpose there, but the syntax is accepted, and must continue to work.

Exclude Xen.  Xen ignores RAM_SHARED and does its own allocation.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c    | 85 +++++++++++++++++++++++++++++++++++++++++++++++++----
 system/trace-events |  1 +
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a..b0c4b22 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -47,6 +47,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
+#include "qemu/memfd.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
@@ -2057,6 +2058,70 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 }
 #endif
 
+static bool qemu_memfd_available(void)
+{
+    static int has_memfd = -1;
+
+    if (has_memfd < 0) {
+        has_memfd = qemu_memfd_check(0);
+    }
+    return has_memfd;
+}
+
+/*
+ * We want anonymous shared memory, similar to MAP_SHARED|MAP_ANON, but
+ * some users want the fd.  Allocate shm explicitly to get an fd.
+ */
+static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
+{
+    size_t max_length = new_block->max_length;
+    MemoryRegion *mr = new_block->mr;
+    const char *name = memory_region_name(mr);
+    int fd;
+
+    if (qemu_memfd_available()) {
+        fd = qemu_memfd_create(name, max_length + mr->align, 0, 0, 0, errp);
+        if (fd < 0) {
+            return false;
+        }
+    } else if (!qemu_shm_available()) {
+        /*
+         * Backwards compatibility for Windows.  The user may specify a
+         * memory backend with shared=on, and Windows ignores shared.
+         * Fall back to qemu_anon_ram_alloc.
+         */
+        return true;
+    } else {
+        Error *local_err = NULL;
+
+        fd = qemu_shm_alloc(max_length, &local_err);
+        if (fd < 0) {
+            /*
+             * Backwards compatibility in case the shm mount size is too small.
+             * Previous QEMU versions called qemu_anon_ram_alloc for anonymous
+             * shared memory, which could succeed.
+             */
+            error_prepend(&local_err,
+                          "Retrying using MAP_ANON|MAP_SHARED because: ");
+            warn_report_err(local_err);
+            return true;
+        }
+    }
+
+    new_block->mr->align = QEMU_VMALLOC_ALIGN;
+    new_block->host = file_ram_alloc(new_block, max_length, fd, false, 0, errp);
+
+    if (new_block->host) {
+        qemu_set_cloexec(fd);
+        new_block->fd = fd;
+        trace_qemu_ram_alloc_shared(name, max_length, fd, new_block->host);
+        return true;
+    }
+
+    close(fd);
+    return false;
+}
+
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   void (*resized)(const char*,
@@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
+
+    if (!host && !xen_enabled()) {
+        if ((new_block->flags & RAM_SHARED) &&
+            !qemu_ram_alloc_shared(new_block, &local_err)) {
+            goto err;
+        }
+    }
+
     ram_block_add(new_block, &local_err);
-    if (local_err) {
-        g_free(new_block);
-        error_propagate(errp, local_err);
-        return NULL;
+    if (!local_err) {
+        return new_block;
     }
-    return new_block;
+
+err:
+    g_free(new_block);
+    error_propagate(errp, local_err);
+    return NULL;
 }
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
diff --git a/system/trace-events b/system/trace-events
index 5bbc3fb..831a60c 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -33,6 +33,7 @@ address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+qemu_ram_alloc_shared(const char *name, size_t max_length, int fd, void *host) "%s size %zu fd %d host %p"
 
 # cpus.c
 vm_stop_flush_all(int ret) "ret %d"
-- 
1.8.3.1


