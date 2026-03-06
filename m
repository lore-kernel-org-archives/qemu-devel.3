Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175FFF513EB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 01:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyKBd-0008KW-75; Thu, 05 Mar 2026 20:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyKBb-0008Jj-GD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:41:03 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyKBZ-0006FH-WB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:41:03 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CC22F596DAA;
 Fri, 06 Mar 2026 02:41:00 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 3Z2062atl8va; Fri,  6 Mar 2026 02:40:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C85B8596DA2; Fri, 06 Mar 2026 02:40:58 +0100 (CET)
Message-ID: <9ffe7b34f51328dc6cf2e15c49931ef87a07e8cd.1772760714.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772760714.git.balaton@eik.bme.hu>
References: <cover.1772760714.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v8 6/8] memory: Shorten memory_region_init_ram_device_ptr and
 memory_region_init_rom_device
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
Date: Fri, 06 Mar 2026 02:40:58 +0100 (CET)
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

We can reuse memory_region_init_io in these functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index e15f931a8a..13d4e3314b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1705,10 +1705,9 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                        uint64_t size,
                                        void *ptr)
 {
-    memory_region_init(mr, owner, name, size);
+    memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
     mr->ram = true;
     mr->ram_device = true;
-    memory_region_set_ops(mr, &ram_device_mem_ops, mr);
     mr->destructor = memory_region_destructor_ram;
 
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
@@ -3762,8 +3761,7 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
     Error *err = NULL;
 
     assert(ops);
-    memory_region_init(mr, owner, name, size);
-    memory_region_set_ops(mr, ops, opaque);
+    memory_region_init_io(mr, owner, ops, opaque, name, size);
     mr->rom_device = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-- 
2.41.3


