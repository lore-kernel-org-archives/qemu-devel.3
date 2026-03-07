Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FECF55121
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 23:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz0iz-0006he-WE; Sat, 07 Mar 2026 18:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz0iq-0006a9-TD
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:06:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz0ip-0002y1-52
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:06:12 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EFDCA596DA7;
 Sun, 08 Mar 2026 00:06:09 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Keg7WeAmYCpF; Sun,  8 Mar 2026 00:06:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 02E7B596D94; Sun, 08 Mar 2026 00:06:08 +0100 (CET)
Message-ID: <7c5a31fc2202e6927437ed57cb9ce08a224f2a50.1772924151.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772924151.git.balaton@eik.bme.hu>
References: <cover.1772924151.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v10 9/9] memory: Factor out common ram ptr initialization
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
Date: Sun, 08 Mar 2026 00:06:08 +0100 (CET)
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

Introduce internal helper function to remove duplicated code from
different memory_region_init_ram_*ptr functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 2cda814bd6..f1db72eb42 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1649,31 +1649,30 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
 }
 #endif
 
+static void memory_region_set_ram_ptr(MemoryRegion *mr, uint64_t size,
+                                      void *ptr)
+{
+    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
+    assert(ptr != NULL);
+    RAMBlock *rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    memory_region_set_ram_block(mr, rb);
+}
+
 void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
                                 const char *name, uint64_t size,
                                 void *ptr)
 {
-    RAMBlock *rb;
-
     memory_region_init(mr, owner, name, size);
-    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
-    assert(ptr != NULL);
-    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
-    memory_region_set_ram_block(mr, rb);
+    memory_region_set_ram_ptr(mr, size, ptr);
 }
 
 void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        const char *name, uint64_t size,
                                        void *ptr)
 {
-    RAMBlock *rb;
-
     memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
     mr->ram_device = true;
-    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
-    assert(ptr != NULL);
-    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
-    memory_region_set_ram_block(mr, rb);
+    memory_region_set_ram_ptr(mr, size, ptr);
 }
 
 void memory_region_init_alias(MemoryRegion *mr, Object *owner,
-- 
2.41.3


