Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9533CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWJ9-0006JB-My; Fri, 19 Jun 2026 06:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ8-0006I9-0H
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:42 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ5-0000ew-E6
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=wBrE6v3lVOCEPIWG8+1Ll7UvgIVXe4mtnOov3hTw8o4=; b=H8RXn7yqXEU9
 be4SEGfn6lmKXpOojIK1KB2MEWqV+TPb+XueD8qvSbCz+3zhw4zr0PZQUxyQLrC8zVw9GVqeRnOis
 yeDAmH+bpXUq31fh76UNkJ07nsvBA/qoNYEjxeHJ5z7EAlNyQjBFRnZwIUwGUpHOlhfh2atqy25DX
 HdYLJMMo/+3CNmsybiJCWTsM/U1sDLdPxm8plI5D9tyyluLekLlQIwjAQmsd6Y0g5g+F/1RB318AJ
 dGS+Uuhg0Sl9RwCXBJLaVAWneBFxN2msbCJAQwle4Lv1hV5ae8tcVtKzf+EfgncJgUWxbJCK09U4W
 vWYCU++GeOqf3LMZE6e7Wg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waWIT-006QLJ-39;
 Fri, 19 Jun 2026 12:18:33 +0200
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v5 3/7] system/cpus: refuse memsave/pmemsave while guest RAM
 is being migrated
Date: Fri, 19 Jun 2026 12:18:30 +0200
Message-ID: <20260619101834.228432-4-den@openvz.org>
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

memsave and pmemsave read guest memory and write it to a file, with no
guard at all. They run on the main thread with the BQL held, so on a
postcopy destination touching a not-yet-received page deadlocks: the
thread blocks on the userfault while the postcopy incoming path waits for
the BQL to install that page. During precopy the read returns incomplete
state instead.

Refuse both while guest RAM is still being received, using the same
migration_guest_ram_loading() check as dump-guest-memory.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 system/cpus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/system/cpus.c b/system/cpus.c
index bded87feb1..ba9da4ee06 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -42,6 +42,7 @@
 #include "hw/core/nmi.h"
 #include "system/replay.h"
 #include "system/runstate.h"
+#include "migration/misc.h"
 #include "system/cpu-timers.h"
 #include "system/whpx.h"
 #include "hw/core/boards.h"
@@ -841,6 +842,11 @@ void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
     uint8_t buf[1024];
     uint64_t orig_addr = addr, orig_size = size;
 
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "Guest memory access not allowed during migration");
+        return;
+    }
+
     if (!has_cpu) {
         cpu_index = 0;
     }
@@ -887,6 +893,11 @@ void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
     uint64_t l;
     uint8_t buf[1024];
 
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "Guest memory access not allowed during migration");
+        return;
+    }
+
     f = fopen(filename, "wb");
     if (!f) {
         error_setg_file_open(errp, errno, filename);
-- 
2.53.0


