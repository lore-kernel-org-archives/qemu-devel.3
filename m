Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B71C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMm-0005Gp-1c; Mon, 29 Apr 2024 11:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TML-0004bE-J2
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMI-0005G8-JD
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmnrW023173; Mon, 29 Apr 2024 15:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=36mCyWFnknwNhH0B4xYEyn7ewW0hY0bHUl96xUN213U=;
 b=dXyKY1ylWEmMxTC2H6sppI4Zoq1D6T1QQYUEOj47gwcMB/oTEmdYM9YMp7yxpKlMyxsB
 ZR5e5xt1NsYX4X7flNuKO0+hlzX3sjcLEhQwKOg8QVWPIw6vk6igDutN8znyAHfNHtoT
 pewsHh4DH+fxCqHmn2TGDh/Vxc4p/LSgFul5t4XSGuUYI8iBzFxDKJLjEENGbcRDl+e0
 Nivh0C+TNNieLaO79LWo8+iXoHQsLh6X4pBFUvsxKo/onVIgy9TfYziACx+GSkBMUFcx
 FpeIpQCyEi+nRx7REh+9J+G+Di4EAUQFDR7L42bGgyTUVkDlPYAjGdDNDO7k6weDZYek wg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv2wby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:48 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TFAtv5011379; Mon, 29 Apr 2024 15:55:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGu034442;
 Mon, 29 Apr 2024 15:55:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-15; Mon, 29 Apr 2024 15:55:46 +0000
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
Subject: [PATCH V1 14/26] physmem: hoist guest_memfd creation
Date: Mon, 29 Apr 2024 08:55:23 -0700
Message-Id: <1714406135-451286-15-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: UYhh70tNoRJsC3TSXG4YZQ9ZOG27g5_V
X-Proofpoint-ORIG-GUID: UYhh70tNoRJsC3TSXG4YZQ9ZOG27g5_V
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

Do not modify RAMBlocks in ram_block_add.  The block should be fully
formed before calling ram_block_add to add it to the block list.  This
will simplify error handling and be more modular.

Start by hoisting guest_memfd creation to the call sites.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c | 85 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 6216b14..ffcf012 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1803,13 +1803,34 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
     }
 }
 
+static int ram_block_create_guest_memfd(RAMBlock *rb, Error **errp)
+{
+    assert(kvm_enabled());
+
+    if (ram_block_discard_require(true) < 0) {
+        error_setg_errno(errp, errno,
+            "cannot set up private guest memory: discard currently blocked");
+        error_append_hint(errp, "Are you using assigned devices?\n");
+        return -1;
+    }
+
+    return kvm_create_guest_memfd(rb->max_length, 0, errp);
+}
+
+static void ram_block_destroy_guest_memfd(RAMBlock *rb)
+{
+    if (rb->guest_memfd >= 0) {
+        close(rb->guest_memfd);
+        ram_block_discard_require(false);
+    }
+}
+
 static void ram_block_add(RAMBlock *new_block, Error **errp)
 {
     const bool noreserve = qemu_ram_is_noreserve(new_block);
     const bool shared = qemu_ram_is_shared(new_block);
     RAMBlock *block;
     RAMBlock *last_block = NULL;
-    bool free_on_error = false;
     ram_addr_t old_ram_size, new_ram_size;
     Error *err = NULL;
 
@@ -1839,26 +1860,6 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                 return;
             }
             memory_try_enable_merging(new_block->host, new_block->max_length);
-            free_on_error = true;
-        }
-    }
-
-    if (new_block->flags & RAM_GUEST_MEMFD) {
-        assert(kvm_enabled());
-        assert(new_block->guest_memfd < 0);
-
-        if (ram_block_discard_require(true) < 0) {
-            error_setg_errno(errp, errno,
-                             "cannot set up private guest memory: discard currently blocked");
-            error_append_hint(errp, "Are you using assigned devices?\n");
-            goto out_free;
-        }
-
-        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
-                                                        0, errp);
-        if (new_block->guest_memfd < 0) {
-            qemu_mutex_unlock_ramlist();
-            goto out_free;
         }
     }
 
@@ -1910,17 +1911,11 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
     }
-    return;
-
-out_free:
-    if (free_on_error) {
-        qemu_anon_ram_free(new_block->host, new_block->max_length);
-        new_block->host = NULL;
-    }
 }
 
 static RAMBlock *ram_block_create(MemoryRegion *mr, ram_addr_t size,
-                                  ram_addr_t max_size, uint32_t ram_flags)
+                                  ram_addr_t max_size, uint32_t ram_flags,
+                                  Error **errp)
 {
     RAMBlock *rb = g_malloc0(sizeof(*rb));
 
@@ -1930,7 +1925,17 @@ static RAMBlock *ram_block_create(MemoryRegion *mr, ram_addr_t size,
     rb->flags = ram_flags;
     rb->page_size = qemu_real_host_page_size();
     rb->mr = mr;
-    rb->guest_memfd = -1;
+
+    if (ram_flags & RAM_GUEST_MEMFD) {
+        rb->guest_memfd = ram_block_create_guest_memfd(rb, errp);
+        if (rb->guest_memfd < 0) {
+            g_free(rb);
+            return NULL;
+        }
+    } else {
+        rb->guest_memfd = -1;
+    }
+
     trace_ram_block_create(rb->idstr, rb->flags, rb->fd, rb->used_length,
                            rb->max_length, mr->align);
     return rb;
@@ -1981,9 +1986,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    new_block = ram_block_create(mr, size, size, ram_flags);
+    new_block = ram_block_create(mr, size, size, ram_flags, errp);
+    if (!new_block) {
+        return NULL;
+    }
+
     host = file_ram_alloc(new_block, size, fd, !file_size, offset, errp);
     if (!host) {
+        ram_block_destroy_guest_memfd(new_block);
         g_free(new_block);
         return NULL;
     }
@@ -2068,11 +2078,16 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     size = ROUND_UP(size, align);
     max_size = ROUND_UP(max_size, align);
     assert(max_size >= size);
-    new_block = ram_block_create(mr, size, max_size, ram_flags);
+    new_block = ram_block_create(mr, size, max_size, ram_flags, errp);
+    if (!new_block) {
+        return NULL;
+    }
     new_block->resized = resized;
 
+    new_block->host = host;
     ram_block_add(new_block, &local_err);
     if (local_err) {
+        ram_block_destroy_guest_memfd(new_block);
         g_free(new_block);
         error_propagate(errp, local_err);
         return NULL;
@@ -2119,11 +2134,7 @@ static void reclaim_ramblock(RAMBlock *block)
         qemu_anon_ram_free(block->host, block->max_length);
     }
 
-    if (block->guest_memfd >= 0) {
-        close(block->guest_memfd);
-        ram_block_discard_require(false);
-    }
-
+    ram_block_destroy_guest_memfd(block);
     g_free(block);
 }
 
-- 
1.8.3.1


