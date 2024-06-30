Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1590CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0QB-0000Ah-Aq; Sun, 30 Jun 2024 15:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pu-0008S6-DW
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pp-0004OO-Kc
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:51 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJeY21019514;
 Sun, 30 Jun 2024 19:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=rHRV/raAz2FvaOpg5bcnOa8jzjLwVEUJugMChsrTwKY=; b=
 BUaCgZX/tkJ7r0n7WCGIv50nbcR3AFqypOAN5nHmjTDmWpd7xE+5GLffYqAN0FUd
 Go2VN4dM0UQ+bcDWqFMmC9oYDtrsvH9KQlMiOfuq8JGK2L1O0/N4j1CSbIA5jNsJ
 zIx5p55DVGxOiBkmO0Hh2hmJ3bNdnD9Q8iwe+5xNI8AwRuKy7fmWqHfVeE95s6mG
 hVaw8O4xwkTq4+iYu3fiGbL8sSVG757Hv5oSA/JgoK6xGEu9WjVoM0SF0HFpjBB+
 QCNtPEMc6VBfZ+YbYzdYW3RjtTB0Y7Mv9xFdU2QFI4FbZ0K7xE4XDid466rKjgST
 0z2qUJrtB7e/NPJKrOKTtw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296asg9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UFckWb018336; Sun, 30 Jun 2024 19:40:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16dv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSa014044;
 Sun, 30 Jun 2024 19:40:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-7; Sun, 30 Jun 2024 19:40:43 +0000
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
Subject: [PATCH V2 06/11] migration: fix mismatched GPAs during cpr
Date: Sun, 30 Jun 2024 12:40:29 -0700
Message-Id: <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: BpDX3Ai9npk0ioyPus9WVjdZe8Pf9jCv
X-Proofpoint-ORIG-GUID: BpDX3Ai9npk0ioyPus9WVjdZe8Pf9jCv
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

For new cpr modes, ramblock_is_ignored will always be true, because the
memory is preserved in place rather than copied.  However, for an ignored
block, parse_ramblock currently requires that the received address of the
block must match the address of the statically initialized region on the
target.  This fails for a PCI rom block, because the memory region address
is set when the guest writes to a BAR on the source, which does not occur
on the target, causing a "Mismatched GPAs" error during cpr migration.

To fix, unconditionally set the target's address to the source's address
if the target region does not have an address yet.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/exec/memory.h | 12 ++++++++++++
 migration/ram.c       | 15 +++++++++------
 system/memory.c       | 10 ++++++++--
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index c26ede3..227169e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -811,6 +811,7 @@ struct MemoryRegion {
     bool ram_device;
     bool enabled;
     bool warning_printed; /* For reservations */
+    bool has_addr;
     uint8_t vga_logging_count;
     MemoryRegion *alias;
     hwaddr alias_offset;
@@ -2408,6 +2409,17 @@ void memory_region_set_enabled(MemoryRegion *mr, bool enabled);
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
index edec1a2..eaf3151 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4059,12 +4059,15 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
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
index 28a837d..b7548bf 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2655,7 +2655,7 @@ static void memory_region_add_subregion_common(MemoryRegion *mr,
     for (alias = subregion->alias; alias; alias = alias->alias) {
         alias->mapped_via_alias++;
     }
-    subregion->addr = offset;
+    memory_region_set_address_only(subregion, offset);
     memory_region_update_container_subregions(subregion);
 }
 
@@ -2735,10 +2735,16 @@ static void memory_region_readd_subregion(MemoryRegion *mr)
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


