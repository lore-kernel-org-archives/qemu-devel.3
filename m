Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBB3C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMW-0004rn-2k; Mon, 29 Apr 2024 11:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMI-0004YO-6M
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMF-0005Fq-V6
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:01 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmjvS006702; Mon, 29 Apr 2024 15:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=on/dHn8yh7blYwmWHlzbl2iCCZvcPBO2UbSOSMfAHcA=;
 b=oWbd01wxZhY6xNw9wFmx+eC0UImOeKSeyNplXNmhZSjkzlT84bY7OvowHaTBtAs3TrrE
 KzR107f/gBiMh3OfmfxElfqWo6kzBTixjUsxklZOTRt38DalCKbodlKyi9e2eG8fp+iH
 Zh0hh6QrZIH5XG8SNAnatPQEvKE1mNiSztR2r9WUx7Owq8L0p/lu4ckp3X4q2CVfnluJ
 kkoIkj1LnpXuoB6M+LeIwcQdQddvm6L9l0ISS4csrCNphrAJ6OrWkNLTse+Cycrx+Dvq
 RRksrnyWROV472UeXbOHQf/o8omzSIL37oOrZ01L7UJNq1tU0nq0VBet8zxn392eujeS NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdejwn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:47 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEj25e011398; Mon, 29 Apr 2024 15:55:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGs034442;
 Mon, 29 Apr 2024 15:55:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-14; Mon, 29 Apr 2024 15:55:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 13/26] physmem: ram_block_create
Date: Mon, 29 Apr 2024 08:55:22 -0700
Message-Id: <1714406135-451286-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-GUID: D80zV2ykTrJXFl01qh9wWugF3uyURfRn
X-Proofpoint-ORIG-GUID: D80zV2ykTrJXFl01qh9wWugF3uyURfRn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create a common subroutine to allocate a RAMBlock, de-duping the code to
populate its common fields.  Add a trace point for good measure.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c    | 47 ++++++++++++++++++++++++++---------------------
 system/trace-events |  3 +++
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c3d04ca..6216b14 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -52,6 +52,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace/trace-root.h"
+#include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
 #include <linux/falloc.h>
@@ -1918,11 +1919,29 @@ out_free:
     }
 }
 
+static RAMBlock *ram_block_create(MemoryRegion *mr, ram_addr_t size,
+                                  ram_addr_t max_size, uint32_t ram_flags)
+{
+    RAMBlock *rb = g_malloc0(sizeof(*rb));
+
+    rb->used_length = size;
+    rb->max_length = max_size;
+    rb->fd = -1;
+    rb->flags = ram_flags;
+    rb->page_size = qemu_real_host_page_size();
+    rb->mr = mr;
+    rb->guest_memfd = -1;
+    trace_ram_block_create(rb->idstr, rb->flags, rb->fd, rb->used_length,
+                           rb->max_length, mr->align);
+    return rb;
+}
+
 #ifdef CONFIG_POSIX
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
                                  Error **errp)
 {
+    void *host;
     RAMBlock *new_block;
     Error *local_err = NULL;
     int64_t file_size, file_align;
@@ -1962,19 +1981,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    new_block = g_malloc0(sizeof(*new_block));
-    new_block->mr = mr;
-    new_block->used_length = size;
-    new_block->max_length = size;
-    new_block->flags = ram_flags;
-    new_block->guest_memfd = -1;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
-                                     errp);
-    if (!new_block->host) {
+    new_block = ram_block_create(mr, size, size, ram_flags);
+    host = file_ram_alloc(new_block, size, fd, !file_size, offset, errp);
+    if (!host) {
         g_free(new_block);
         return NULL;
     }
 
+    new_block->host = host;
     ram_block_add(new_block, &local_err);
     if (local_err) {
         g_free(new_block);
@@ -1982,7 +1996,6 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
     return new_block;
-
 }
 
 
@@ -2054,18 +2067,10 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     align = MAX(align, TARGET_PAGE_SIZE);
     size = ROUND_UP(size, align);
     max_size = ROUND_UP(max_size, align);
-
-    new_block = g_malloc0(sizeof(*new_block));
-    new_block->mr = mr;
-    new_block->resized = resized;
-    new_block->used_length = size;
-    new_block->max_length = max_size;
     assert(max_size >= size);
-    new_block->fd = -1;
-    new_block->guest_memfd = -1;
-    new_block->page_size = qemu_real_host_page_size();
-    new_block->host = host;
-    new_block->flags = ram_flags;
+    new_block = ram_block_create(mr, size, max_size, ram_flags);
+    new_block->resized = resized;
+
     ram_block_add(new_block, &local_err);
     if (local_err) {
         g_free(new_block);
diff --git a/system/trace-events b/system/trace-events
index 69c9044..f0a80ba 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -38,3 +38,6 @@ dirtylimit_state_finalize(void)
 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
+
+# physmem.c
+ram_block_create(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length, size_t align) "%s, flags %u, fd %d, len %lu, maxlen %lu, align %lu"
-- 
1.8.3.1


