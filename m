Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E3BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMV-0004oZ-5B; Mon, 29 Apr 2024 11:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMN-0004c5-Dg
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TML-0005Io-Bk
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmuqt024941; Mon, 29 Apr 2024 15:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=fLoc8RsqqC4/VvEU3N//EHt3MAKOJS/axPmHtsZ0S2I=;
 b=LKS6ViAh+M0O36nGKTlxhC4JVUgjUzJEamKT++giIj4LCE+kykzjXSZpxKZIHq0A/c4l
 cxuS0YHwaRaURMsuTT9x/VzpQl/RS6g4ymyiMLYbm1s2t1mdyRmFJgLFa0ETLlBOn/WV
 MuQOFIem3p3sRzdTreGuKJDntHuzTPFe7WiuccruIwtg0fw9crBZYKPGy/J4syuhk7yV
 n8C0+gRx8fiusjYhom7SRZm3NfvFP+vGMo84tZZT+R6tfFcJdoxBFiTWludtJu1W7Uq+
 UJuwhHy9sE7/kAUYNFKOR8FKdtGzgPBKIohlwh3DQDwzCyZf2YKbhwlni08WregQCYoD jQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsetx4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:52 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TF0rU7011374; Mon, 29 Apr 2024 15:55:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6hj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:51 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaH6034442;
 Mon, 29 Apr 2024 15:55:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-20; Mon, 29 Apr 2024 15:55:50 +0000
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
Subject: [PATCH V1 19/26] physmem: preserve ram blocks for cpr
Date: Mon, 29 Apr 2024 08:55:28 -0700
Message-Id: <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: w77k14UptVokYNFo1CGRDQLveHdVRrra
X-Proofpoint-GUID: w77k14UptVokYNFo1CGRDQLveHdVRrra
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

Preserve fields of RAMBlocks that allocate their host memory during CPR so
the RAM allocation can be recovered.  Mirror the mr->align field in the
RAMBlock to simplify the vmstate.  Preserve the old host address, even
though it is immediately discarded, as it will be needed in the future for
CPR with iommufd.  Preserve guest_memfd, even though CPR does not yet
support it, to maintain vmstate compatibility when it becomes supported.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/exec/ramblock.h |  6 ++++++
 system/physmem.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 61deefe..b492d89 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -44,6 +44,7 @@ struct RAMBlock {
     uint64_t fd_offset;
     int guest_memfd;
     size_t page_size;
+    uint64_t align;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
 
@@ -91,5 +92,10 @@ struct RAMBlock {
      */
     ram_addr_t postcopy_length;
 };
+
+#define RAM_BLOCK "RAMBlock"
+
+extern const VMStateDescription vmstate_ram_block;
+
 #endif
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index 36d97ec..3019284 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1398,6 +1398,7 @@ static void *file_ram_alloc(RAMBlock *block,
         block->mr->align = MAX(block->mr->align, QEMU_VMALLOC_ALIGN);
     }
 #endif
+    block->align = block->mr->align;
 
     if (memory < block->page_size) {
         error_setg(errp, "memory size 0x" RAM_ADDR_FMT " must be equal to "
@@ -1848,6 +1849,7 @@ static void *ram_block_alloc_host(RAMBlock *rb, Error **errp)
                              rb->idstr);
         }
     }
+    rb->align = mr->align;
 
     if (host) {
         memory_try_enable_merging(host, rb->max_length);
@@ -1934,6 +1936,7 @@ static RAMBlock *ram_block_create(MemoryRegion *mr, ram_addr_t size,
     rb->flags = ram_flags;
     rb->page_size = qemu_real_host_page_size();
     rb->mr = mr;
+    rb->align = mr->align;
 
     if (ram_flags & RAM_GUEST_MEMFD) {
         rb->guest_memfd = ram_block_create_guest_memfd(rb, errp);
@@ -2060,6 +2063,26 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 }
 #endif
 
+const VMStateDescription vmstate_ram_block = {
+    .name = RAM_BLOCK,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .precreate = true,
+    .factory = true,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(align, RAMBlock),
+        VMSTATE_VOID_PTR(host, RAMBlock),
+        VMSTATE_INT32(fd, RAMBlock),
+        VMSTATE_INT32(guest_memfd, RAMBlock),
+        VMSTATE_UINT32(flags, RAMBlock),
+        VMSTATE_UINT64(used_length, RAMBlock),
+        VMSTATE_UINT64(max_length, RAMBlock),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+vmstate_register_init_factory(vmstate_ram_block, RAMBlock);
+
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   void (*resized)(const char*,
@@ -2070,6 +2093,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 {
     RAMBlock *new_block;
     int align;
+    g_autofree RAMBlock *preserved = NULL;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
@@ -2086,6 +2110,17 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     }
     new_block->resized = resized;
 
+    preserved = vmstate_claim_factory_object(RAM_BLOCK, new_block->idstr, 0);
+    if (preserved) {
+        assert(mr->align <= preserved->align);
+        mr->align = mr->align ?: preserved->align;
+        new_block->align = preserved->align;
+        new_block->fd = preserved->fd;
+        new_block->flags = preserved->flags;
+        new_block->used_length = preserved->used_length;
+        new_block->max_length = preserved->max_length;
+    }
+
     if (!host) {
         host = ram_block_alloc_host(new_block, errp);
         if (!host) {
@@ -2093,6 +2128,10 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
             g_free(new_block);
             return NULL;
         }
+        if (!(ram_flags & RAM_GUEST_MEMFD)) {
+            vmstate_register_named(new_block->idstr, 0, &vmstate_ram_block,
+                                   new_block);
+        }
     }
 
     new_block->host = host;
@@ -2157,6 +2196,7 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     qemu_mutex_lock_ramlist();
+    vmstate_unregister_named(RAM_BLOCK, block->idstr, 0);
     qemu_ram_unset_idstr(block);
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
-- 
1.8.3.1


