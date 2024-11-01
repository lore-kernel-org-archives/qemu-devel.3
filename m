Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BCEE6B27C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s0x-00047i-Cy; Fri, 01 Nov 2024 09:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0v-00041J-9Q
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0t-0002GS-KF
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:33 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Dfe4L029184;
 Fri, 1 Nov 2024 13:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=mFMfP6A/2uG91S8VBhFG+/Sw+haZOLY6FbviW3+2dlA=; b=
 Xkjq477PkrTMqoIGhfTu1iNJuSs1WK9DmXPg3p6brdPJRLtNGpuu5unztgloDxUS
 ayrAyLYyS7h6ChebNVmYqnsFuJGRqbkxRjqNANvrFkqTFRU8xhBL3Hd6zIc6jxv7
 4zA8prOJO0GE1uPxdXjEPJKblPCXk/Jc4LAbqnp07FrOhJrIuImeFYzfkKUf9u3C
 EteREzTQPEx9De5GYCULsKkhF1twtM4m3P+doXDTPt/kT+akjvFan18LwH2Wt0Z7
 r7SS7Kpxsf/8qyXYG4pApYforqoFLB9YfextbNDGG2mPJL5lbCNbfJKprjRQ8U2M
 6yMJMFPYccgVsTmg3W5iUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxv9w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1Cc7Pq009727; Fri, 1 Nov 2024 13:48:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91pt6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuO6006031;
 Fri, 1 Nov 2024 13:47:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-4; Fri, 01 Nov 2024 13:47:58 +0000
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
Subject: [PATCH V3 03/16] physmem: preserve ram blocks for cpr
Date: Fri,  1 Nov 2024 06:47:42 -0700
Message-Id: <1730468875-249970-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010100
X-Proofpoint-GUID: aLkqzbqR9b80TzF8Loqc2HyedvLR15Hh
X-Proofpoint-ORIG-GUID: aLkqzbqR9b80TzF8Loqc2HyedvLR15Hh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Save the memfd for anonymous ramblocks in CPR state, along with a name
that uniquely identifies it.  The block's idstr is not yet set, so it
cannot be used for this purpose.  Find the saved memfd in new QEMU when
creating a block.  QEMU hard-codes the length of some internally-created
blocks, so to guard against that length changing, use lseek to get the
actual length of an incoming memfd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 174f7e0..cd468eb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -72,6 +72,7 @@
 
 #include "qapi/qapi-types-migration.h"
 #include "migration/options.h"
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1663,6 +1664,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
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
@@ -1858,14 +1872,23 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                                         TYPE_MEMORY_BACKEND)) {
             size_t max_length = new_block->max_length;
             MemoryRegion *mr = new_block->mr;
-            const char *name = memory_region_name(mr);
+            g_autofree char *name = cpr_name(new_block);
 
             new_block->mr->align = QEMU_VMALLOC_ALIGN;
             new_block->flags |= RAM_SHARED;
+            new_block->fd = cpr_find_fd(name, 0);
 
             if (new_block->fd == -1) {
                 new_block->fd = qemu_memfd_create(name, max_length + mr->align,
                                                   0, 0, 0, errp);
+                cpr_save_fd(name, 0, new_block->fd);
+            } else if (lseek(new_block->fd, 0, SEEK_END) < max_length &&
+                       ftruncate(new_block->fd, max_length)) {
+                error_setg_errno(errp, errno,
+                                 "cannot grow ram block %s fd %d to %ld bytes",
+                                 name, new_block->fd, max_length);
+                qemu_mutex_unlock_ramlist();
+                return;
             }
 
             if (new_block->fd >= 0) {
@@ -1875,6 +1898,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                                                  false, 0, errp);
             }
             if (!new_block->host) {
+                cpr_delete_fd(name, 0);
                 qemu_mutex_unlock_ramlist();
                 return;
             }
@@ -2182,6 +2206,8 @@ static void reclaim_ramblock(RAMBlock *block)
 
 void qemu_ram_free(RAMBlock *block)
 {
+    g_autofree char *name = NULL;
+
     if (!block) {
         return;
     }
@@ -2192,6 +2218,8 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     qemu_mutex_lock_ramlist();
+    name = cpr_name(block);
+    cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
     /* Write list before version */
-- 
1.8.3.1


