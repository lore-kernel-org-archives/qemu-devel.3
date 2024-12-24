Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D37E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7b3-00035G-MY; Tue, 24 Dec 2024 11:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7az-000328-FF
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7aw-0003A3-Is
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:21 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfYEW008033;
 Tue, 24 Dec 2024 16:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=Equ7yWwJew/wnUf+aFBVQlXJgRrN4ZaJSEDL86opA/4=; b=
 MLW57bLwCZAODCvD1XFl710L8bra4HVIEIffi4G1hEbzrNGHOWs8TuMhFC/7zDvz
 hYl6eY1hVbPQdOpL5mnKwjU4NHPZvxWWKp1dG6PVzAVnapnntDmryhqa/3xbDmU3
 imtHg82VYuVED2+E7M6dVB0bz8/+e+m9u58YRiKP6DLP2jp2YKIveSJoEG+AuCZJ
 uJwqqJV49+irrGW49HK4LKrdBVRLpgLwQUubqd/M74HX5tJuqvH3fCDuHtlKjKcf
 iPd7WTUGVVVnsSdh3wwbr1goo3tj6Yb+minM+KvE149hULt0ayUbqvnFx2IOkNXy
 FyUhdE1GJdKW9Q+cnbIAuw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq56vh07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BOElcEZ023252; Tue, 24 Dec 2024 16:17:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9XU021973;
 Tue, 24 Dec 2024 16:17:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-8; Tue, 24 Dec 2024 16:17:14 +0000
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
Subject: [PATCH V5 07/23] physmem: preserve ram blocks for cpr
Date: Tue, 24 Dec 2024 08:16:52 -0800
Message-Id: <1735057028-308595-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-GUID: 9Vdr4AOT5z1g30K42YZLYoG_GTnSQEcu
X-Proofpoint-ORIG-GUID: 9Vdr4AOT5z1g30K42YZLYoG_GTnSQEcu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Save the memfd for ramblocks in CPR state, along with a name that
uniquely identifies it.  The block's idstr is not yet set, so it
cannot be used for this purpose.  Find the saved memfd in new QEMU when
creating a block.  If size of a resizable block is larger in new QEMU,
extend it via the file_ram_alloc truncate parameter, and the extra space
will be usable after a guest reset.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 0e629ee..7a6d832 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -70,6 +70,7 @@
 
 #include "qemu/pmem.h"
 
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1661,6 +1662,18 @@ void qemu_ram_unset_idstr(RAMBlock *block)
     }
 }
 
+static char *cpr_name(MemoryRegion *mr)
+{
+    const char *mr_name = memory_region_name(mr);
+    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
+
+    if (id) {
+        return g_strdup_printf("%s/%s", id, mr_name);
+    } else {
+        return g_strdup(mr_name);
+    }
+}
+
 size_t qemu_ram_pagesize(RAMBlock *rb)
 {
     return rb->page_size;
@@ -2078,15 +2091,25 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
  * shared with another process if CPR is being used.  Use memfd if available
  * because it has no size limits, else use POSIX shm.
  */
-static int qemu_ram_get_shared_fd(const char *name, Error **errp)
+static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
 {
-    int fd;
+    int fd = cpr_find_fd(name, 0);
+
+    if (fd >= 0) {
+        *reused = true;
+        return fd;
+    }
 
     if (qemu_memfd_check(0)) {
         fd = qemu_memfd_create(name, 0, 0, 0, 0, errp);
     } else {
         fd = qemu_shm_alloc(0, errp);
     }
+
+    if (fd >= 0) {
+        cpr_save_fd(name, 0, fd);
+    }
+    *reused = false;
     return fd;
 }
 #endif
@@ -2116,8 +2139,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
             ram_flags |= RAM_SHARED;
         }
         if (ram_flags & RAM_SHARED) {
-            const char *name = memory_region_name(mr);
-            int fd = qemu_ram_get_shared_fd(name, errp);
+            bool reused;
+            g_autofree char *name = cpr_name(mr);
+            int fd = qemu_ram_get_shared_fd(name, &reused, errp);
 
             if (fd < 0) {
                 return NULL;
@@ -2131,9 +2155,14 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
              * fd is not supported, but previous QEMU versions that called
              * qemu_anon_ram_alloc for anonymous shared memory could have
              * succeeded.  Quietly fail and fall back.
+             *
+             * After cpr-transfer, new QEMU could create a memory region
+             * with a larger max size than old, so pass reused to grow the
+             * region if necessary.  The extra space will be usable after a
+             * guest reset.
              */
             new_block = qemu_ram_alloc_from_fd(size, max_size, resized, mr,
-                                               ram_flags, fd, 0, false, NULL);
+                                               ram_flags, fd, 0, reused, NULL);
             if (new_block) {
                 trace_qemu_ram_alloc_shared(name, new_block->used_length,
                                             new_block->max_length, fd,
@@ -2141,6 +2170,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                 return new_block;
             }
 
+            cpr_delete_fd(name, 0);
             close(fd);
             /* fall back to anon allocation */
         }
@@ -2219,6 +2249,8 @@ static void reclaim_ramblock(RAMBlock *block)
 
 void qemu_ram_free(RAMBlock *block)
 {
+    g_autofree char *name = NULL;
+
     if (!block) {
         return;
     }
@@ -2229,6 +2261,8 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     qemu_mutex_lock_ramlist();
+    name = cpr_name(block->mr);
+    cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
     /* Write list before version */
-- 
1.8.3.1


