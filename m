Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57386E63CAC
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 18:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk4wH-0006kC-Md; Sun, 25 Jan 2026 13:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk4wD-0006en-IJ
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 13:34:17 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk4wA-0002nQ-H8
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 13:34:17 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 077995974D7;
 Sun, 25 Jan 2026 19:34:12 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 00wLJb8PK9Nr; Sun, 25 Jan 2026 19:34:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 953F45974BC; Sun, 25 Jan 2026 18:50:56 +0100 (CET)
Message-ID: <107f31d3312c79f46c9f4baeb247ac5120a6c6aa.1769362313.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1769362313.git.balaton@eik.bme.hu>
References: <cover.1769362313.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 01/10] memory: Add internal memory_region_set_ops helper
 function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sun, 25 Jan 2026 18:50:56 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a common operation used at multiple places, add a helper
function for it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4bf00d82bc..86742557a1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1559,6 +1559,15 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
     }
 }
 
+static void memory_region_set_ops(MemoryRegion *mr,
+                                  const MemoryRegionOps *ops,
+                                  void *opaque)
+{
+    mr->ops = ops ?: &unassigned_mem_ops;
+    mr->opaque = opaque;
+    mr->terminates = true;
+}
+
 void memory_region_init_io(MemoryRegion *mr,
                            Object *owner,
                            const MemoryRegionOps *ops,
@@ -1567,9 +1576,7 @@ void memory_region_init_io(MemoryRegion *mr,
                            uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
-    mr->ops = ops ? ops : &unassigned_mem_ops;
-    mr->opaque = opaque;
-    mr->terminates = true;
+    memory_region_set_ops(mr, ops, opaque);
 }
 
 bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
@@ -1710,10 +1717,8 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
 {
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
-    mr->terminates = true;
     mr->ram_device = true;
-    mr->ops = &ram_device_mem_ops;
-    mr->opaque = mr;
+    memory_region_set_ops(mr, &ram_device_mem_ops, mr);
     mr->destructor = memory_region_destructor_ram;
 
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
@@ -1759,9 +1764,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     Error *err = NULL;
     assert(ops);
     memory_region_init(mr, owner, name, size);
-    mr->ops = ops;
-    mr->opaque = opaque;
-    mr->terminates = true;
+    memory_region_set_ops(mr, ops, opaque);
     mr->rom_device = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-- 
2.41.3


