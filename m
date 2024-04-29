Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF833C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMm-0005OV-UY; Mon, 29 Apr 2024 11:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TML-0004bI-Uk
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMJ-0005IG-Ra
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:05 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmsuF024847; Mon, 29 Apr 2024 15:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=OyrHtB4q6XpnHj4/tkIq+24vCmQ0KEnKiUVp8HEQSEg=;
 b=RZFbV41TtymB0DJSa0KNlb8BXdfbfII7YxBXcGZrzPHbek5f1QIz0gA1IoZ08bE9hjre
 kARwfpzvsZSchwkaUgxxB6dFmfnUaPTMLsvgmefo+L3IVFIh4KC6Z8cXe0NorO60oTzu
 LrbeNVU+t+wrU9M0ylR+8uxQweKRXtD6nD91FBSER2VG+gc04ZV1+QSVIMEjgcB1N4Uj
 bOorxr3jbu1f+eObQM5D2fN/5Xw0dlhwyHr5Cknv8SRrReC2MtCfejdFA9l0K7gcqmJ6
 +3HSvAyuDdb2jA4TzJVYKbe/Sm8U3xlLJDb9Ku47XzPwmvzRGB3MTgFTViPFpFR56ftq ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsetx43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:49 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEcwOZ011335; Mon, 29 Apr 2024 15:55:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:48 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaH0034442;
 Mon, 29 Apr 2024 15:55:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-17; Mon, 29 Apr 2024 15:55:48 +0000
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
Subject: [PATCH V1 16/26] physmem: set ram block idstr earlier
Date: Mon, 29 Apr 2024 08:55:25 -0700
Message-Id: <1714406135-451286-17-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: ezm-HSnNG4XBA-we7_0HH0YveZ9ZQI8i
X-Proofpoint-GUID: ezm-HSnNG4XBA-we7_0HH0YveZ9ZQI8i
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

Set the idstr for a ram block earlier, prior to calling ram_block_add,
so it can be used in a subsequent patch to find CPR attributes for the
block before it is created.

The id depends on the block's device path and its mr.  As as sanity check,
verify that the id has not changed (due to these dependencies changing)
by the time vmstate_register_ram is called (where the id was previously
assigned).

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/exec/cpu-common.h |  3 +--
 migration/savevm.c        |  4 +---
 system/physmem.c          | 46 +++++++++++++++++++++++-----------------------
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6d53188..ffab5d9 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -82,8 +82,7 @@ RAMBlock *qemu_ram_block_by_name(const char *name);
 RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
                                    ram_addr_t *offset);
 ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
-void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
-void qemu_ram_unset_idstr(RAMBlock *block);
+void qemu_ram_verify_idstr(RAMBlock *block, DeviceState *dev);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
 void *qemu_ram_get_host_addr(RAMBlock *rb);
 ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
diff --git a/migration/savevm.c b/migration/savevm.c
index 01ed78c..8463ddf 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3566,14 +3566,12 @@ bool delete_snapshot(const char *name, bool has_devices,
 
 void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
 {
-    qemu_ram_set_idstr(mr->ram_block,
-                       memory_region_name(mr), dev);
+    qemu_ram_verify_idstr(mr->ram_block, dev);
     qemu_ram_set_migratable(mr->ram_block);
 }
 
 void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
 {
-    qemu_ram_unset_idstr(mr->ram_block);
     qemu_ram_unset_migratable(mr->ram_block);
 }
 
diff --git a/system/physmem.c b/system/physmem.c
index b57462d..c736af5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1597,35 +1597,20 @@ int qemu_ram_get_fd(RAMBlock *rb)
 }
 
 /* Called with the BQL held.  */
-void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState *dev)
+static void qemu_ram_set_idstr(char *idstr, MemoryRegion *mr, DeviceState *dev)
 {
-    RAMBlock *block;
+    const char *name = memory_region_name(mr);
+    g_autofree char *id = dev ? qdev_get_dev_path(dev) : NULL;
 
-    assert(new_block);
-    assert(!new_block->idstr[0]);
-
-    if (dev) {
-        char *id = qdev_get_dev_path(dev);
-        if (id) {
-            snprintf(new_block->idstr, sizeof(new_block->idstr), "%s/", id);
-            g_free(id);
-        }
-    }
-    pstrcat(new_block->idstr, sizeof(new_block->idstr), name);
-
-    RCU_READ_LOCK_GUARD();
-    RAMBLOCK_FOREACH(block) {
-        if (block != new_block &&
-            !strcmp(block->idstr, new_block->idstr)) {
-            fprintf(stderr, "RAMBlock \"%s\" already registered, abort!\n",
-                    new_block->idstr);
-            abort();
-        }
+    if (id) {
+        snprintf(idstr, sizeof(VMStateId), "%s/%s", id, name);
+    } else {
+        pstrcpy(idstr, sizeof(VMStateId), name);
     }
 }
 
 /* Called with the BQL held.  */
-void qemu_ram_unset_idstr(RAMBlock *block)
+static void qemu_ram_unset_idstr(RAMBlock *block)
 {
     /* FIXME: arch_init.c assumes that this is not called throughout
      * migration.  Ignore the problem since hot-unplug during migration
@@ -1636,6 +1621,13 @@ void qemu_ram_unset_idstr(RAMBlock *block)
     }
 }
 
+void qemu_ram_verify_idstr(RAMBlock *new_block, DeviceState *dev)
+{
+    VMStateId idstr;
+    qemu_ram_set_idstr(idstr, new_block->mr, dev);
+    assert(!strcmp(new_block->idstr, idstr));
+}
+
 size_t qemu_ram_pagesize(RAMBlock *rb)
 {
     return rb->page_size;
@@ -1869,6 +1861,12 @@ static void ram_block_add(RAMBlock *new_block)
      * tail, so save the last element in last_block.
      */
     RAMBLOCK_FOREACH(block) {
+        if (!strcmp(block->idstr, new_block->idstr)) {
+            fprintf(stderr, "RAMBlock \"%s\" already added, abort!\n",
+                    new_block->idstr);
+            abort();
+        }
+
         last_block = block;
         if (block->max_length < new_block->max_length) {
             break;
@@ -1915,6 +1913,7 @@ static RAMBlock *ram_block_create(MemoryRegion *mr, ram_addr_t size,
 {
     RAMBlock *rb = g_malloc0(sizeof(*rb));
 
+    qemu_ram_set_idstr(rb->idstr, mr, mr->dev);
     rb->used_length = size;
     rb->max_length = max_size;
     rb->fd = -1;
@@ -2142,6 +2141,7 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     qemu_mutex_lock_ramlist();
+    qemu_ram_unset_idstr(block);
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
     /* Write list before version */
-- 
1.8.3.1


