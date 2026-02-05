Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64775EA794C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnnw7-0002dt-BV; Wed, 04 Feb 2026 20:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnnw4-0002cN-CI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:13:33 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnnw2-00030n-TL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:13:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 99B61596EB9;
 Thu, 05 Feb 2026 02:13:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id fgxNwnRSQHa5; Thu,  5 Feb 2026 02:13:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A11C5596E8E; Thu, 05 Feb 2026 02:13:26 +0100 (CET)
Message-ID: <0272d72ab16837fcf22b29f287c2d81e43e43b51.1770253186.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770253186.git.balaton@eik.bme.hu>
References: <cover.1770253186.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 8/8] memory: Factor out more common ram region
 initialization
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
Date: Thu, 05 Feb 2026 02:13:26 +0100 (CET)
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

Introduce internal memory_region_setup_ram_ptr() function to remove
duplicated code from different memory_region_init_ram_*ptr functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 492bf51f48..fa3e19e1fd 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1660,25 +1660,28 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
 }
 #endif
 
-void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
-                                const char *name, uint64_t size, void *ptr)
+static void memory_region_setup_ram_ptr(MemoryRegion *mr, uint64_t size,
+                                        void *ptr)
 {
-    memory_region_init(mr, owner, name, size);
     memory_region_setup_ram(mr);
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
     mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
 }
 
+void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
+                                const char *name, uint64_t size, void *ptr)
+{
+    memory_region_init(mr, owner, name, size);
+    memory_region_setup_ram_ptr(mr, size, ptr);
+}
+
 void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        const char *name, uint64_t size,
                                        void *ptr)
 {
     memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
-    memory_region_setup_ram(mr);
-    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
-    assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    memory_region_setup_ram_ptr(mr, size, ptr);
     mr->ram_device = true;
 }
 
-- 
2.41.3


