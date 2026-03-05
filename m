Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F585F33A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9Wl-00084h-Vt; Thu, 05 Mar 2026 09:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vy9Wi-00084L-HM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:18:08 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vy9Wf-0000to-PN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:18:07 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8B822596DAA;
 Thu, 05 Mar 2026 15:18:04 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ub7Hx2MBFEx0; Thu,  5 Mar 2026 15:18:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8C62B596DA6; Thu, 05 Mar 2026 15:18:02 +0100 (CET)
Message-ID: <1ff1fb62e8b4e261d7c4670d55b4b0373eb991f4.1772719690.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772719690.git.balaton@eik.bme.hu>
References: <cover.1772719690.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 7/9] memory: Add internal memory_region_register_ram
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
Date: Thu, 05 Mar 2026 15:18:02 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Factor out common operation from memory_region_init_{ram,rom}
functions to register the region for migration. This avoids
duplicating the long comment in several functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
--
 system/memory.c | 76 ++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 55 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 8246743d54..dfbb4b85df 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3653,18 +3653,10 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
     }
 }
 
-bool memory_region_init_ram(MemoryRegion *mr,
-                            Object *owner,
-                            const char *name,
-                            uint64_t size,
-                            Error **errp)
+static void memory_region_register_ram(MemoryRegion *mr, Object *owner)
 {
     DeviceState *owner_dev;
 
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                size, 0, errp)) {
-        return false;
-    }
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
      * unique name for migration. TODO: Ideally we should implement
@@ -3673,68 +3665,50 @@ bool memory_region_init_ram(MemoryRegion *mr,
      */
     owner_dev = DEVICE(owner);
     vmstate_register_ram(mr, owner_dev);
+}
 
+bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
+                            const char *name, uint64_t size,
+                            Error **errp)
+{
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                                0, errp)) {
+        return false;
+    }
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
-                                        Object *owner,
-                                        const char *name,
-                                        uint64_t size,
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
+                                        const char *name, uint64_t size,
                                         Error **errp)
 {
-    DeviceState *owner_dev;
-
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
                                                 RAM_GUEST_MEMFD, errp)) {
         return false;
     }
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_rom(MemoryRegion *mr,
-                            Object *owner,
-                            const char *name,
-                            uint64_t size,
+bool memory_region_init_rom(MemoryRegion *mr, Object *owner,
+                            const char *name, uint64_t size,
                             Error **errp)
 {
-    DeviceState *owner_dev;
-
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
                                                 size, 0, errp)) {
         return false;
     }
     mr->readonly = true;
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_rom_device(MemoryRegion *mr,
-                                   Object *owner,
-                                   const MemoryRegionOps *ops,
-                                   void *opaque,
-                                   const char *name,
-                                   uint64_t size,
+bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
+                                   const MemoryRegionOps *ops, void *opaque,
+                                   const char *name, uint64_t size,
                                    Error **errp)
 {
-    DeviceState *owner_dev;
     Error *err = NULL;
 
     assert(ops);
@@ -3750,15 +3724,7 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
     }
     mr->ram = false;
     mr->rom_device = true;
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-- 
2.41.3


