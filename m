Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FB0C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8dY-0007G9-F3; Wed, 15 Jan 2025 14:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dU-0007ED-50
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dS-0005bt-5z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:03 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtkPP008408;
 Wed, 15 Jan 2025 19:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=bTbRZ0lOL1adHfUHHwrFkeZpGff4obp6NVKETfMxoIQ=; b=
 BJNxcEvKLLhc7tqHSY2DJwyzAMiq5uiNhK9OpiPa1l6VKgiyjws4UI7STPEhLCgy
 CIFUGmGa/8Pp+ONiS5jtrub3bN0y6ppEPdB8vqI9rtv2To83GkyhcOdPh8ZAhcKX
 JpokO4mPdZgWet0RWH+5AELeEAlbCeKxVEraGU8jgpu3cvDWc5BWBxSgiqrHfDMY
 78Im3RSqnbSR7FiqxBFaWoszMsR3HUZ9ubgP0qBN72pik0qLlqHfHXGdDkT0pi1h
 70T2zrBMuR9s+K05mkWHSi+iTQOsDRCy6AucZteuWyWQuTOdmAxBgb4DJr/42woW
 tj0TpsI+y+5kOi7E0mDe8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f2c0r1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FHcjZY034966; Wed, 15 Jan 2025 19:00:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39ur35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:57 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0pe9016497;
 Wed, 15 Jan 2025 19:00:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-9; Wed, 15 Jan 2025 19:00:57 +0000
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
Subject: [PATCH V7 08/24] physmem: preserve ram blocks for cpr
Date: Wed, 15 Jan 2025 11:00:34 -0800
Message-Id: <1736967650-129648-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: mhcTnEoiVv20Y5-m7xKJK64tzT97YvaH
X-Proofpoint-GUID: mhcTnEoiVv20Y5-m7xKJK64tzT97YvaH
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index cb80ce3..67c9db9 100644
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
@@ -2080,15 +2093,25 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
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
@@ -2118,8 +2141,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
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
@@ -2133,9 +2157,14 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
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
@@ -2143,6 +2172,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                 return new_block;
             }
 
+            cpr_delete_fd(name, 0);
             close(fd);
             /* fall back to anon allocation */
         }
@@ -2221,6 +2251,8 @@ static void reclaim_ramblock(RAMBlock *block)
 
 void qemu_ram_free(RAMBlock *block)
 {
+    g_autofree char *name = NULL;
+
     if (!block) {
         return;
     }
@@ -2231,6 +2263,8 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     qemu_mutex_lock_ramlist();
+    name = cpr_name(block->mr);
+    cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
     /* Write list before version */
-- 
1.8.3.1


