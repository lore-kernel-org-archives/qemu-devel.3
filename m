Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4F8E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmuvZ-0003TO-5u; Mon, 02 Feb 2026 09:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vmuuh-0003Fa-3p
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:28:28 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vmuub-0006YO-Vw
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:28:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6E0D3596A0A;
 Mon, 02 Feb 2026 15:28:18 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id UQoEcoo8u-xG; Mon,  2 Feb 2026 15:28:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 56E29596EA5; Mon, 02 Feb 2026 15:28:16 +0100 (CET)
Message-ID: <25045c95c083e31c6773521ecfe41900738b7bb5.1770042013.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770042013.git.balaton@eik.bme.hu>
References: <cover.1770042013.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 5/7] memory: Add internal memory_region_set_ops helper
 function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 02 Feb 2026 15:28:16 +0100 (CET)
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

This is a common operation used at multiple places, add a helper
function for it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 921e96554b..e15f931a8a 100644
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
 
 bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
@@ -1700,10 +1707,8 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
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
@@ -3758,9 +3763,7 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
 
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


