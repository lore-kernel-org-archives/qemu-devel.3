Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9396C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMZ-0004zT-I4; Mon, 29 Apr 2024 11:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMJ-0004aH-Ru
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMI-0005Gh-2g
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmoK9021820; Mon, 29 Apr 2024 15:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=5W3Uqi4pt3zRyBqCA3ANso+QnzCYfMdNqiQwmSxIPBU=;
 b=aPwa47nHVSwmydqNUpY5aAlBcaUI93HussR2INpO4QLt1OMnNVXlylVzYL3p4VwzMAr3
 2JGdfEIlN0sddOlTqidc2ger5xjbpXam+L+n1h+IKb1+bxl+PGbBAXTOW1zMpsFzecrm
 /RZkqjs+k2i+S+XX3r2xc34FSFx8P+/A0AMFqwUwp3LqL8JCBNU4f4JhoCPhg19c7r5C
 0x0GWbPkmNNcpecSr57PX4hWWfnCcajqsN32Oe59HbdR0Y0Fi8QtPMX40v+/IEBFpFVO
 ZjjdeGGZmh3ga59SK7norNg2R8DpSJq1orZ3brI7A84zcDwbceoRM5fd7hbpAgkqioVX cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54axt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:49 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEuHx5011355; Mon, 29 Apr 2024 15:55:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6d8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGw034442;
 Mon, 29 Apr 2024 15:55:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-16; Mon, 29 Apr 2024 15:55:47 +0000
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
Subject: [PATCH V1 15/26] physmem: hoist host memory allocation
Date: Mon, 29 Apr 2024 08:55:24 -0700
Message-Id: <1714406135-451286-16-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: pMtKRFgkojj0wtNbTsvLIjG0hCQLLpL5
X-Proofpoint-GUID: pMtKRFgkojj0wtNbTsvLIjG0hCQLLpL5
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

Hoist host memory allocation from ram_block_add.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c | 80 +++++++++++++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index ffcf012..b57462d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1825,44 +1825,40 @@ static void ram_block_destroy_guest_memfd(RAMBlock *rb)
     }
 }
 
-static void ram_block_add(RAMBlock *new_block, Error **errp)
+static void *ram_block_alloc_host(RAMBlock *rb, Error **errp)
+{
+    struct MemoryRegion *mr = rb->mr;
+    uint8_t *host = NULL;
+
+    if (xen_enabled()) {
+        xen_ram_alloc(rb->offset, rb->max_length, mr, errp);
+
+    } else {
+        host = qemu_anon_ram_alloc(rb->max_length, &mr->align,
+                                   qemu_ram_is_shared(rb),
+                                   qemu_ram_is_noreserve(rb));
+        if (!host) {
+            error_setg_errno(errp, errno, "cannot set up guest memory '%s'",
+                             rb->idstr);
+        }
+    }
+
+    if (host) {
+        memory_try_enable_merging(host, rb->max_length);
+    }
+    return host;
+}
+
+static void ram_block_add(RAMBlock *new_block)
 {
-    const bool noreserve = qemu_ram_is_noreserve(new_block);
-    const bool shared = qemu_ram_is_shared(new_block);
     RAMBlock *block;
     RAMBlock *last_block = NULL;
     ram_addr_t old_ram_size, new_ram_size;
-    Error *err = NULL;
-
     old_ram_size = last_ram_page();
 
     qemu_mutex_lock_ramlist();
     new_block->offset = find_ram_offset(new_block->max_length);
 
-    if (!new_block->host) {
-        if (xen_enabled()) {
-            xen_ram_alloc(new_block->offset, new_block->max_length,
-                          new_block->mr, &err);
-            if (err) {
-                error_propagate(errp, err);
-                qemu_mutex_unlock_ramlist();
-                return;
-            }
-        } else {
-            new_block->host = qemu_anon_ram_alloc(new_block->max_length,
-                                                  &new_block->mr->align,
-                                                  shared, noreserve);
-            if (!new_block->host) {
-                error_setg_errno(errp, errno,
-                                 "cannot set up guest memory '%s'",
-                                 memory_region_name(new_block->mr));
-                qemu_mutex_unlock_ramlist();
-                return;
-            }
-            memory_try_enable_merging(new_block->host, new_block->max_length);
-        }
-    }
-
     new_ram_size = MAX(old_ram_size,
               (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS);
     if (new_ram_size > old_ram_size) {
@@ -1948,7 +1944,6 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 {
     void *host;
     RAMBlock *new_block;
-    Error *local_err = NULL;
     int64_t file_size, file_align;
 
     /* Just support these ram flags by now. */
@@ -1999,12 +1994,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     }
 
     new_block->host = host;
-    ram_block_add(new_block, &local_err);
-    if (local_err) {
-        g_free(new_block);
-        error_propagate(errp, local_err);
-        return NULL;
-    }
+    ram_block_add(new_block);
     return new_block;
 }
 
@@ -2066,7 +2056,6 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   MemoryRegion *mr, Error **errp)
 {
     RAMBlock *new_block;
-    Error *local_err = NULL;
     int align;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
@@ -2084,14 +2073,17 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     }
     new_block->resized = resized;
 
-    new_block->host = host;
-    ram_block_add(new_block, &local_err);
-    if (local_err) {
-        ram_block_destroy_guest_memfd(new_block);
-        g_free(new_block);
-        error_propagate(errp, local_err);
-        return NULL;
+    if (!host) {
+        host = ram_block_alloc_host(new_block, errp);
+        if (!host) {
+            ram_block_destroy_guest_memfd(new_block);
+            g_free(new_block);
+            return NULL;
+        }
     }
+
+    new_block->host = host;
+    ram_block_add(new_block);
     return new_block;
 }
 
-- 
1.8.3.1


