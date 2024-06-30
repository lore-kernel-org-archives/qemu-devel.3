Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8460C30653
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0QH-0000EZ-9V; Sun, 30 Jun 2024 15:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pu-0008SC-Ed
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Po-0004OF-6w
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJdPwI028776;
 Sun, 30 Jun 2024 19:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=LIBmEiC+D9GTXCGgocbHmU9iP3J5h3etyy3WxDqWsM8=; b=
 T/nc/yS0j9+J3xWkCXKvnA8AhFCbDMmDGs3RNBmvY4/JOpJbQSC9nE0TavUSv2qd
 7JyH+vY67FDO7lwoK+UarT2rTo7wh8YRjxLus6Vk4zYzc2MaNqY+yamSjaxKA/jP
 Diz/dWxUiAkTy1tWQQi7tq0OEljdyH1LycY5fUoF4fMjHGhm2FGQLZ6pEbHQuB7T
 s/WuOHzh8BELQ4gQyTKTU6s3gxSH4QaqKWo4/z5G6462CVtMeZiegWOMu6W3Eg0v
 WvqM9Hk/L6bktpwCKULRHbtD0LJbZw7t1rvZbWU0GGSsXaKOWXulS67WyyNnyt+V
 ZXeLkX3AdK+u+jqDt0jU8g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a591erd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UEU59V018387; Sun, 30 Jun 2024 19:40:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:43 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSY014044;
 Sun, 30 Jun 2024 19:40:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-6; Sun, 30 Jun 2024 19:40:42 +0000
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
Subject: [PATCH V2 05/11] physmem: preserve ram blocks for cpr
Date: Sun, 30 Jun 2024 12:40:28 -0700
Message-Id: <1719776434-435013-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300157
X-Proofpoint-GUID: 3RMlwOa6TIJr3HL8RT4KpdnV9-266g-2
X-Proofpoint-ORIG-GUID: 3RMlwOa6TIJr3HL8RT4KpdnV9-266g-2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Save the memfd for anonymous ramblocks in CPR state, along with a name
that uniquely identifies it.  The block's idstr is not yet set, so it
cannot be used for this purpose.  Find the saved memfd in new QEMU when
creating a block.  QEMU hard-codes the length of some internally-created
blocks, so to guard against that length changing, use lseek to get the
actual length of an incoming memfd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index efe95ff..e37352e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -73,6 +73,7 @@
 
 #include "qapi/qapi-types-migration.h"
 #include "migration/options.h"
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1641,6 +1642,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
     }
 }
 
+static char *cpr_name(RAMBlock *block)
+{
+    MemoryRegion *mr = block->mr;
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
@@ -1836,13 +1850,17 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         } else if (new_block->flags & RAM_SHARED) {
             size_t max_length = new_block->max_length;
             MemoryRegion *mr = new_block->mr;
-            const char *name = memory_region_name(mr);
+            g_autofree char *name = cpr_name(new_block);
 
             new_block->mr->align = QEMU_VMALLOC_ALIGN;
+            new_block->fd = cpr_find_fd(name, 0);
 
             if (new_block->fd == -1) {
                 new_block->fd = qemu_memfd_create(name, max_length + mr->align,
                                                   0, 0, 0, errp);
+                cpr_save_fd(name, 0, new_block->fd);
+            } else {
+                new_block->max_length = lseek(new_block->fd, 0, SEEK_END);
             }
 
             if (new_block->fd >= 0) {
@@ -1852,6 +1870,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                                                  false, 0, errp);
             }
             if (!new_block->host) {
+                cpr_delete_fd(name, 0);
                 qemu_mutex_unlock_ramlist();
                 return;
             }
@@ -2162,6 +2181,8 @@ static void reclaim_ramblock(RAMBlock *block)
 
 void qemu_ram_free(RAMBlock *block)
 {
+    g_autofree char *name = NULL;
+
     if (!block) {
         return;
     }
@@ -2172,6 +2193,8 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     qemu_mutex_lock_ramlist();
+    name = cpr_name(block);
+    cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
     /* Write list before version */
-- 
1.8.3.1


