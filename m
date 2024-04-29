Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E914C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMQ-0004d3-Ii; Mon, 29 Apr 2024 11:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMJ-0004aF-Ra
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMG-0005Kc-4W
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFnajp028150; Mon, 29 Apr 2024 15:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=VUgeGOjkH5xIbS4LS0QSaGY+st+ceFJUGTwLpgJtyIk=;
 b=ZmamR6ZdtEuYc2LtZ0Bap9lt2OKIpRknZoBFjuIoUXyhXQdJYuLey21cvWkrEX/8dM+G
 tGCRVvb91nOH+j0GbseR5lVpTmlKYpG22/M2eBi54Wk6i/Gd7ow/hSQsixDGQtCeiZq3
 WnX18WSL55V4bpuEjJqiVzndg67TMFpRLzek5uDDEr2QmCJ7717bx1R4AwFp6UUHlHkl
 45uP+YKBkLWRvzt9EizBP1G93q06Mq4VcVWF/8Xy5CyqL5zl1CqFkw0jXEju4VtEP0FK
 RarNd3FSGmmJdq/+MDWyfH6W1anFjioJwlBhHyHkbku1ezovxDiw3PYg4sxdBNt5KQau 2w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvjxse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:56 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEt9Hk011467; Mon, 29 Apr 2024 15:55:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6nt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:55 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaHI034442;
 Mon, 29 Apr 2024 15:55:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-26; Mon, 29 Apr 2024 15:55:54 +0000
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
Subject: [PATCH V1 25/26] migration: fix mismatched GPAs during cpr-exec
Date: Mon, 29 Apr 2024 08:55:34 -0700
Message-Id: <1714406135-451286-26-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 2M02lCBcA8F4cIOqPH-NyC-H1zDq86Gl
X-Proofpoint-ORIG-GUID: 2M02lCBcA8F4cIOqPH-NyC-H1zDq86Gl
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

For cpr-exec mode, ramblock_is_ignored is always true, and the address of
each migrated memory region must match the address of the statically
initialized region on the target.  However, for a PCI rom block, the region
address is set when the guest writes to a BAR on the source, which does not
occur on the target, causing a "Mismatched GPAs" error during cpr-exec
migration.

To fix, unconditionally set the target's address to the source's address
if the region does not have an address yet.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/exec/memory.h | 12 ++++++++++++
 migration/ram.c       | 15 +++++++++------
 system/memory.c       | 10 ++++++++--
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d337737..4f654b0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -801,6 +801,7 @@ struct MemoryRegion {
     bool unmergeable;
     uint8_t dirty_log_mask;
     bool is_iommu;
+    bool has_addr;
     RAMBlock *ram_block;
     Object *owner;
     /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */
@@ -2402,6 +2403,17 @@ void memory_region_set_enabled(MemoryRegion *mr, bool enabled);
 void memory_region_set_address(MemoryRegion *mr, hwaddr addr);
 
 /*
+ * memory_region_set_address_only: set the address of a region.
+ *
+ * Same as memory_region_set_address, but without causing transaction side
+ * effects.
+ *
+ * @mr: the region to be updated
+ * @addr: new address, relative to container region
+ */
+void memory_region_set_address_only(MemoryRegion *mr, hwaddr addr);
+
+/*
  * memory_region_set_size: dynamically update the size of a region.
  *
  * Dynamically updates the size of a region.
diff --git a/migration/ram.c b/migration/ram.c
index add285b..7b8d7f6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4196,12 +4196,15 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
     }
     if (migrate_ignore_shared()) {
         hwaddr addr = qemu_get_be64(f);
-        if (migrate_ram_is_ignored(block) &&
-            block->mr->addr != addr) {
-            error_report("Mismatched GPAs for block %s "
-                         "%" PRId64 "!= %" PRId64, block->idstr,
-                         (uint64_t)addr, (uint64_t)block->mr->addr);
-            return -EINVAL;
+        if (migrate_ram_is_ignored(block)) {
+            if (!block->mr->has_addr) {
+                memory_region_set_address_only(block->mr, addr);
+            } else if (block->mr->addr != addr) {
+                error_report("Mismatched GPAs for block %s "
+                             "%" PRId64 "!= %" PRId64, block->idstr,
+                             (uint64_t)addr, (uint64_t)block->mr->addr);
+                return -EINVAL;
+            }
         }
     }
     ret = rdma_block_notification_handle(f, block->idstr);
diff --git a/system/memory.c b/system/memory.c
index ca04a0e..3c72504 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2665,7 +2665,7 @@ static void memory_region_add_subregion_common(MemoryRegion *mr,
     for (alias = subregion->alias; alias; alias = alias->alias) {
         alias->mapped_via_alias++;
     }
-    subregion->addr = offset;
+    memory_region_set_address_only(subregion, offset);
     memory_region_update_container_subregions(subregion);
 }
 
@@ -2745,10 +2745,16 @@ static void memory_region_readd_subregion(MemoryRegion *mr)
     }
 }
 
+void memory_region_set_address_only(MemoryRegion *mr, hwaddr addr)
+{
+    mr->addr = addr;
+    mr->has_addr = true;
+}
+
 void memory_region_set_address(MemoryRegion *mr, hwaddr addr)
 {
     if (addr != mr->addr) {
-        mr->addr = addr;
+        memory_region_set_address_only(mr, addr);
         memory_region_readd_subregion(mr);
     }
 }
-- 
1.8.3.1


