Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C906C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMM-0004bw-ME; Mon, 29 Apr 2024 11:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMG-0004XK-IV
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TME-0005KG-Ma
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFnZ1C028117; Mon, 29 Apr 2024 15:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=JnHkPIVQqTLNiTwWrVL5qrGRdbPYqitNd1sfXn89xic=;
 b=BcUp/ltegDdnTi8MOxY7B4v81QbQO00rQU8z0N/e0kLQj4C6HshcMcXWyP0ufHAIe5S8
 SU5wupBROE6nvltCAMPLp6llG/XVb7HreR06NcOP4kW2MVuh2i0aRtxBMtJTs3Y9Gy+U
 Ne0mrDf9PQR9dw93SXtAMJ4Fo/scoXkelQPlv4O4w8LUkuAuc5a9CdjWDpK9w3xqXQFB
 orJSDD4miq/PhrXKJcuc2B0u1gVohg85pxSpuAC7Y55hYUy5SR2AZTTRRVE+e1tbYiNe
 WwT9W0FLluRpBYH1XI+7jC+9dnnlTNnK7Y33/BnN6JHaeZXwH4ceByeq3lxfEhrXzdYl uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvjxs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:54 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEgDmZ011440; Mon, 29 Apr 2024 15:55:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6ku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaHC034442;
 Mon, 29 Apr 2024 15:55:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-23; Mon, 29 Apr 2024 15:55:52 +0000
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
Subject: [PATCH V1 22/26] migration: ram block cpr-exec blockers
Date: Mon, 29 Apr 2024 08:55:31 -0700
Message-Id: <1714406135-451286-23-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: j9AmfYAvp19a7BCtisg125IWA-jMyWpt
X-Proofpoint-ORIG-GUID: j9AmfYAvp19a7BCtisg125IWA-jMyWpt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Unlike cpr-reboot mode, cpr-exec mode cannot save volatile ram blocks in the
migration stream file and recreate them later, because the physical memory for
the blocks is pinned and registered for vfio.  Add an exec-mode blocker for
volatile ram blocks.

Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
sufficient for cpr-exec, but it has not been tested yet.

- Steve

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/exec/memory.h   |  3 +++
 include/exec/ramblock.h |  1 +
 migration/savevm.c      |  2 ++
 system/physmem.c        | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index dbb1bad..d337737 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3182,6 +3182,9 @@ bool ram_block_discard_is_disabled(void);
  */
 bool ram_block_discard_is_required(void);
 
+void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
+void ram_block_del_cpr_blocker(RAMBlock *rb);
+
 #endif
 
 #endif
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index b492d89..b70ec0c 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -40,6 +40,7 @@ struct RAMBlock {
     /* RCU-enabled, writes protected by the ramlist lock */
     QLIST_ENTRY(RAMBlock) next;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
+    Error *cpr_blocker;
     int fd;
     uint64_t fd_offset;
     int guest_memfd;
diff --git a/migration/savevm.c b/migration/savevm.c
index 8463ddf..6087c3a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3568,11 +3568,13 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
 {
     qemu_ram_verify_idstr(mr->ram_block, dev);
     qemu_ram_set_migratable(mr->ram_block);
+    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
 }
 
 void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
 {
     qemu_ram_unset_migratable(mr->ram_block);
+    ram_block_del_cpr_blocker(mr->ram_block);
 }
 
 void vmstate_register_ram_global(MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 87ad441..9d44b41 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -69,6 +69,7 @@
 
 #include "qemu/pmem.h"
 
+#include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/vmstate.h"
 
@@ -2130,7 +2131,14 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
             g_free(new_block);
             return NULL;
         }
-        if (!(ram_flags & RAM_GUEST_MEMFD)) {
+        if (ram_flags & RAM_GUEST_MEMFD) {
+            error_setg(&new_block->cpr_blocker,
+                       "Memory region %s uses guest_memfd, "
+                       "which is not supported with CPR.",
+                       memory_region_name(mr));
+            migrate_add_blocker_mode(&new_block->cpr_blocker, MIG_MODE_CPR_EXEC,
+                                     errp);
+        } else {
             vmstate_register_named(new_block->idstr, 0, &vmstate_ram_block,
                                    new_block);
         }
@@ -3997,3 +4005,45 @@ bool ram_block_discard_is_required(void)
     return qatomic_read(&ram_block_discard_required_cnt) ||
            qatomic_read(&ram_block_coordinated_discard_required_cnt);
 }
+
+/*
+ * Return true if ram contents would be lost during cpr for MIG_MODE_CPR_EXEC.
+ * Return false for ram_device because it is remapped after exec.  Do not
+ * exclude rom, even though it is readonly, because the rom file could change
+ * in the new qemu.  Return false for non-migratable blocks.  They are either
+ * re-created after exec, or are handled specially, or are covered by a
+ * device-level cpr blocker.  Return false for an fd, because it is visible and
+ * can be remapped in the new process.
+ */
+static bool ram_is_volatile(RAMBlock *rb)
+{
+    MemoryRegion *mr = rb->mr;
+
+    return mr &&
+        memory_region_is_ram(mr) &&
+        !memory_region_is_ram_device(mr) &&
+        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
+        qemu_ram_is_migratable(rb) &&
+        rb->fd < 0;
+}
+
+/*
+ * Add a MIG_MODE_CPR_EXEC blocker for each volatile ram block.
+ */
+void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
+{
+    if (!ram_is_volatile(rb)) {
+        return;
+    }
+
+    error_setg(&rb->cpr_blocker,
+               "Memory region %s is volatile. A memory-backend-memfd or "
+               "memory-backend-file with share=on is required.",
+               memory_region_name(rb->mr));
+    migrate_add_blocker_mode(&rb->cpr_blocker, MIG_MODE_CPR_EXEC, errp);
+}
+
+void ram_block_del_cpr_blocker(RAMBlock *rb)
+{
+    migrate_del_blocker(&rb->cpr_blocker);
+}
-- 
1.8.3.1


