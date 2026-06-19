Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F80CD98FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWJ8-0006Ik-Pt; Fri, 19 Jun 2026 06:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ6-0006Ht-P4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:40 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ5-0000ev-8J
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=vmcI1yCY/hkP/Riq4PLX8+i18bQHuqsqu1lFUgZj4/w=; b=rmUyYue+pxAY
 HMOHzMjcBStFALywTqNQMaSFIoK38VDeWOlNWqFbAvO1eePv6Dn90f+HqBDUmHssaBNQl2s1RTbPP
 xA7xzp0AIhJorEyg8XdNySDaeIl82Y3wvhgY5ysXuTttfGuXLlNglBfCDJ+sFakcFa7G6W68elLMJ
 rx2IpI7i7DgCOG0ZRZ2p6URdPhX0URVLZ6P3a3g017qcFiZlAzDoo0XZwtvPsg9sFsggL0spvZUBV
 H0ljuVrzgQ0/U4lhfBtlZJwECD9OtgBI2u4KSBt1al1ZGkEuS7EhaQm04GLNB71rOIz61G1ppncBT
 pf+jctjXcIiyQQI8ClXPVg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waWIT-006QLJ-1M;
 Fri, 19 Jun 2026 12:18:33 +0200
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v5 2/7] dump: refuse dump-guest-memory while guest RAM is
 being migrated
Date: Fri, 19 Jun 2026 12:18:29 +0200
Message-ID: <20260619101834.228432-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619101834.228432-1-den@openvz.org>
References: <20260619101834.228432-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

dump-guest-memory reads all of guest RAM. The existing guard only rejects
the dump in RUN_STATE_INMIGRATE, i.e. the precopy load phase. On a
postcopy destination the guest already runs (RUN_STATE_RUNNING) while its
pages are pulled from the source on demand.

A non-detached dump reads that RAM on the main thread with the BQL held.
Touching a not-yet-received page blocks on the userfault, and because the
postcopy incoming path itself takes the BQL to install pages, the
transfer that would satisfy the fault cannot progress: the VM deadlocks.

Use migration_guest_ram_loading(), which also covers postcopy, so the
dump is refused for the whole time the destination is still receiving
guest RAM.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 dump/dump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 1f216e74f5..47ea27f716 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -29,6 +29,7 @@
 #include "qemu/main-loop.h"
 #include "hw/misc/vmcoreinfo.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "hw/core/cpu.h"
 #include "win_dump.h"
 #include "qemu/range.h"
@@ -2079,8 +2080,8 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
     bool detach_p = false;
     bool kdump_raw = false;
 
-    if (runstate_check(RUN_STATE_INMIGRATE)) {
-        error_setg(errp, "Dump not allowed during incoming migration.");
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "Dump not allowed during migration.");
         return;
     }
 
-- 
2.53.0


