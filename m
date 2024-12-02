Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA10D7831F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6bR-0007YR-56; Mon, 02 Dec 2024 08:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lj-0007yH-1q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lc-0005he-ND
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:23 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26XMLB013787;
 Mon, 2 Dec 2024 13:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=76RsVoAGMj38dWsNKVn+ivLB7EnCOcYrTG3VXeLBVB4=; b=
 DLU0A8jG4MEPweEjVAEWpSRkrgx7aSt888pb4+cuIEml+itdCNpRAcwqJ+qBM0qB
 iAe4Zf3hiyTMO+CoNuHU58IEQ+IQEsp1DFO/SWl7WQDkSJpS3xPhA2HhkZsI4+rl
 WywqYti7yPikUxOHTcdxMVpkG3joju4suNX4ess8C3OGggcAolyqMBrPjmMAUzUB
 QamsMWH0aeczeHcrZOnNx2fVTWYuoS0aCvuE0hCT95d4dZihTnchws5UC8xNvCAR
 V5sh7ofvjb6H8xSOia2m4oDthE3L2VTobhdEB6IXuX97byZRJMVK9kI5d56SWbz1
 AvQ5d6phpc8ODNezBf9afQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c3342-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2DIXe3032684; Mon, 2 Dec 2024 13:20:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCEj032806;
 Mon, 2 Dec 2024 13:20:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-7; Mon, 02 Dec 2024 13:20:17 +0000
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
Subject: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
Date: Mon,  2 Dec 2024 05:19:58 -0800
Message-Id: <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: HF56IY68lu2-gGBrqXRGeOzuzecSzKEX
X-Proofpoint-GUID: HF56IY68lu2-gGBrqXRGeOzuzecSzKEX
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

Save the memfd for ramblocks in CPR state, along with a name that
uniquely identifies it.  The block's idstr is not yet set, so it
cannot be used for this purpose.  Find the saved memfd in new QEMU when
creating a block.  If the block size is larger in new QEMU, extend the
block using fallocate, and the extra space will be useable after a guest
reset.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 0bcb2cc..aa095a3 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -70,6 +70,7 @@
 
 #include "qemu/pmem.h"
 
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1661,6 +1662,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
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
@@ -2080,8 +2094,18 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
 {
     size_t max_length = new_block->max_length;
     MemoryRegion *mr = new_block->mr;
-    const char *name = memory_region_name(mr);
-    int fd;
+    g_autofree char *name = cpr_name(new_block);
+    int fd = cpr_find_fd(name, 0);
+
+    if (fd >= 0) {
+        if (lseek(fd, 0, SEEK_END) < max_length && ftruncate(fd, max_length)) {
+            error_setg_errno(errp, errno,
+                             "cannot grow ram block %s fd %d to %ld bytes",
+                             name, fd, max_length);
+            goto err;
+        }
+        goto have_fd;
+    }
 
     if (qemu_memfd_available()) {
         fd = qemu_memfd_create(name, max_length + mr->align, 0, 0, 0, errp);
@@ -2111,7 +2135,9 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
             return true;
         }
     }
+    cpr_save_fd(name, 0, fd);
 
+have_fd:
     new_block->mr->align = QEMU_VMALLOC_ALIGN;
     new_block->host = file_ram_alloc(new_block, max_length, fd, false, 0, errp);
 
@@ -2122,6 +2148,8 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
         return true;
     }
 
+err:
+    cpr_delete_fd(name, 0);
     close(fd);
     return false;
 }
@@ -2234,6 +2262,8 @@ static void reclaim_ramblock(RAMBlock *block)
 
 void qemu_ram_free(RAMBlock *block)
 {
+    g_autofree char *name = NULL;
+
     if (!block) {
         return;
     }
@@ -2244,6 +2274,8 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     qemu_mutex_lock_ramlist();
+    name = cpr_name(block);
+    cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
     /* Write list before version */
-- 
1.8.3.1


