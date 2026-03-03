Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9DAEDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXaz-0003OI-R5; Tue, 03 Mar 2026 16:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxXay-0003Nt-IN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:48:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxXav-0000FS-Mz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:48:00 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 308CF597319;
 Tue, 03 Mar 2026 22:47:56 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Y6UHhpdOKSyA; Tue,  3 Mar 2026 22:47:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2DF0859703F; Tue, 03 Mar 2026 22:47:54 +0100 (CET)
Message-ID: <c99082f66cc760ccebdf050d5a9d683d817e7bb2.1772572714.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772572714.git.balaton@eik.bme.hu>
References: <cover.1772572714.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 4/8] system/memory: Reduce
 memory_region_init_ram_nomigrate() usage
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
Date: Tue, 03 Mar 2026 22:47:54 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

This function is kept until the last two usages can be removed but
convert the last usage in memory.c and remove it from the
documentation.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/devel/memory.rst                         |  8 +++-----
 .../memory-region-housekeeping.cocci          | 19 -------------------
 system/memory.c                               |  3 ++-
 3 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 0bb5acab21..9083b18f08 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -110,11 +110,9 @@ migrated:
 
 For most devices and boards this is the correct thing. If you
 have a special case where you need to manage the migration of
-the backing memory yourself, you can call the functions:
-
-- memory_region_init_ram_nomigrate()
-
-which only initialize the MemoryRegion and leave handling
+the backing memory yourself, you can call the function
+memory_region_init_ram_flags_nomigrate()
+which only initializes the MemoryRegion and leaves handling
 migration to the caller.
 
 The functions:
diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index e45703141a..b23647a3d8 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -26,15 +26,9 @@ symbol true;
 expression E1, E2, E3, E4, E5;
 position p;
 @@
-(
   memory_region_init_ram@p(E1, E2, E3, E4, E5);
   ...
   memory_region_set_readonly(E1, true);
-|
-  memory_region_init_ram_nomigrate@p(E1, E2, E3, E4, E5);
-  ...
-  memory_region_set_readonly(E1, true);
-)
 @script:python@
 p << possible_memory_region_init_rom.p;
 @@
@@ -52,23 +46,10 @@ expression ALIAS, E5, E6, E7, E8;
 -  memory_region_set_readonly(ALIAS, true);
 
 
-// Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
-// code sequences with use of the new memory_region_init_ram function.
-// Similarly for the _rom and _rom_device functions.
 // We don't try to replace sequences with a non-NULL owner, because
 // there are none in the tree that can be automatically converted
 // (and only a handful that can be manually converted).
 @@
-expression MR;
-expression NAME;
-expression SIZE;
-expression ERRP;
-@@
--memory_region_init_ram_nomigrate(MR, NULL, NAME, SIZE, ERRP);
-+memory_region_init_ram(MR, NULL, NAME, SIZE, ERRP);
- ...
--vmstate_register_ram_global(MR);
-@@
 typedef DeviceState;
 identifier device_fn, dev, obj;
 expression E1, E2, E3, E4, E5;
diff --git a/system/memory.c b/system/memory.c
index 65042bd9fa..e8c4912a60 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3695,7 +3695,8 @@ bool memory_region_init_ram(MemoryRegion *mr,
 {
     DeviceState *owner_dev;
 
-    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
+                                                size, 0, errp)) {
         return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.41.3


