Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7548CFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 16:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxURh-000608-B7; Sun, 06 Oct 2024 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxURe-0005zS-QP
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 12:49:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxURc-0008At-DM
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 12:49:22 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6B46D4E6001;
 Sun, 06 Oct 2024 18:49:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YdPnJhRLz9Ie; Sun,  6 Oct 2024 18:49:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 75D804E6004; Sun, 06 Oct 2024 18:49:13 +0200 (CEST)
Message-Id: <59dd3361ca8ede93122e87752c7d66a304b05c0f.1728232526.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1728232526.git.balaton@eik.bme.hu>
References: <cover.1728232526.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/2] log: Add separate debug option for logging invalid memory
 accesses
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Date: Sun, 06 Oct 2024 18:49:13 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Currently -d guest_errors enables logging of different invalid actions
by the guest such as misusing hardware, accessing missing features or
invalid memory areas. The memory access logging can be quite verbose
which obscures the other messages enabled by this debug switch so
separate it by adding a new -d memaccess option to make it possible to
control it independently of other guest error logs.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/qemu/log.h | 1 +
 system/memory.c    | 6 +++---
 system/physmem.c   | 2 +-
 util/log.c         | 2 ++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index e10e24cd4f..6122e34bdd 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -37,6 +37,7 @@ bool qemu_log_separate(void);
 #define LOG_PER_THREAD     (1 << 20)
 #define CPU_LOG_TB_VPU     (1 << 21)
 #define LOG_TB_OP_PLUGIN   (1 << 22)
+#define LOG_MEM_ACCESS     (1 << 23)
 
 /* Lock/unlock output. */
 
diff --git a/system/memory.c b/system/memory.c
index f6f6fee6d8..e35a473248 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1380,7 +1380,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
 {
     if (mr->ops->valid.accepts
         && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid %s at addr 0x%" HWADDR_PRIX
+        qemu_log_mask(LOG_MEM_ACCESS, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: rejected\n",
                       is_write ? "write" : "read",
                       addr, size, memory_region_name(mr));
@@ -1388,7 +1388,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
     }
 
     if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid %s at addr 0x%" HWADDR_PRIX
+        qemu_log_mask(LOG_MEM_ACCESS, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: unaligned\n",
                       is_write ? "write" : "read",
                       addr, size, memory_region_name(mr));
@@ -1402,7 +1402,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
 
     if (size > mr->ops->valid.max_access_size
         || size < mr->ops->valid.min_access_size) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid %s at addr 0x%" HWADDR_PRIX
+        qemu_log_mask(LOG_MEM_ACCESS, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: invalid size "
                       "(min:%u max:%u)\n",
                       is_write ? "write" : "read",
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..0f0e8f3bed 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2745,7 +2745,7 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
     if (memory_region_is_ram(mr)) {
         return true;
     }
-    qemu_log_mask(LOG_GUEST_ERROR,
+    qemu_log_mask(LOG_MEM_ACCESS,
                   "Invalid access to non-RAM device at "
                   "addr 0x%" HWADDR_PRIX ", size %" HWADDR_PRIu ", "
                   "region '%s'\n", addr, len, memory_region_name(mr));
diff --git a/util/log.c b/util/log.c
index 6219819855..1aa7396277 100644
--- a/util/log.c
+++ b/util/log.c
@@ -503,6 +503,8 @@ const QEMULogItem qemu_log_items[] = {
       "open a separate log file per thread; filename must contain '%d'" },
     { CPU_LOG_TB_VPU, "vpu",
       "include VPU registers in the 'cpu' logging" },
+    { LOG_MEM_ACCESS, "memaccess",
+      "log invalid memory accesses" },
     { 0, NULL, NULL },
 };
 
-- 
2.30.9


