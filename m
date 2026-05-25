Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB86ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXX7-00037y-6V; Mon, 25 May 2026 11:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRXX0-00035p-Pn
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:47:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRXWw-0006bx-RO
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:47:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C238596945;
 Mon, 25 May 2026 17:47:47 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id n0MVAcNiGBnx; Mon, 25 May 2026 17:47:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2AB82596946; Mon, 25 May 2026 17:47:45 +0200 (CEST)
Message-ID: <d6fff532607b5153094cd6c72f78a2de5672aaec.1779723483.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1779723483.git.balaton@eik.bme.hu>
References: <cover.1779723483.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 1/7] memory: Export memory_region_set_ops()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 25 May 2026 17:47:45 +0200 (CEST)
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make memory_region_set_ops() function public. In some cases such as
when devices have configurable endianness or different behaviour based
on settings it is necessary to change the ops callback after the
memory region is created. Export memory_region_set_ops() function for
this.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/system/memory.h | 13 +++++++++++++
 system/memory.c         |  7 +++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..da07b52885 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1343,6 +1343,19 @@ void memory_region_ref(MemoryRegion *mr);
  */
 void memory_region_unref(MemoryRegion *mr);
 
+/**
+ * memory_region_set_ops: Set ops of an I/O memory region.
+ *
+ * Accesses into the region will cause the callbacks in @ops to be called.
+ *
+ * @mr: the #MemoryRegion to be changed.
+ * @ops: a structure containing read and write callbacks to be used when
+ *       I/O is performed on the region.
+ * @opaque: passed to the read and write callbacks of the @ops structure.
+ */
+void memory_region_set_ops(MemoryRegion *mr, const MemoryRegionOps *ops,
+                           void *opaque);
+
 /**
  * memory_region_init_io: Initialize an I/O memory region.
  *
diff --git a/system/memory.c b/system/memory.c
index 739ba11da6..edcdf91d48 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1560,10 +1560,10 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
     }
 }
 
-static void memory_region_set_ops(MemoryRegion *mr,
-                                  const MemoryRegionOps *ops,
-                                  void *opaque)
+void memory_region_set_ops(MemoryRegion *mr, const MemoryRegionOps *ops,
+                           void *opaque)
 {
+    g_assert(!ops || !(ops->impl.unaligned && !ops->valid.unaligned));
     mr->ops = ops ?: &unassigned_mem_ops;
     mr->opaque = opaque;
     mr->terminates = true;
@@ -1573,7 +1573,6 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
                            const MemoryRegionOps *ops, void *opaque,
                            const char *name, uint64_t size)
 {
-    g_assert(!ops || !(ops->impl.unaligned && !ops->valid.unaligned));
     memory_region_init(mr, owner, name, size);
     memory_region_set_ops(mr, ops, opaque);
 }
-- 
2.41.3


