Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60054CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWJB-0006KA-As; Fri, 19 Jun 2026 06:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ8-0006ID-6B
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:42 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ5-0000f3-Ec
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=Bpp0HI+A8jbUgs575HuTkfMJX5RZ+rbTsXttqYd67is=; b=QNGCRcaWMcME
 Gds0aw8u3xnZiDBI6QU/OtcCcr2cGCbmOp2acz2w3vh8s85/xRKb1Lkzxw+GjpgDfnJcr3dRvoZif
 E/phA8pMRy5Ip4yhiID4kF8LkVaOa2HLntT16tFX3CuSxmRHhgXjrVtCUuVW2EdLH7MCEPZhL9sar
 Op9n7eNwiu2HdC/mspZfV1lehNFwYYuGFn8XnORaU7URSRzMG9wlcscgVPmy7IUYWumQV0An3Qr8I
 QmAq3SLj5AxNWPwfLiIy78V6+ALao+S4wQOhNxkr6uyRQQcHUfdY2khZ7UEep8K88vunzoM6GP+An
 f5KcxSsEEdQLecqEAaq+Dg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waWIU-006QLJ-1Y;
 Fri, 19 Jun 2026 12:18:34 +0200
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v5 4/7] dump: make win_dump_available() check vmcoreinfo for a
 Windows dump header
Date: Fri, 19 Jun 2026 12:18:31 +0200
Message-ID: <20260619101834.228432-5-den@openvz.org>
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

QMP query-dump-guest-memory-capability reports win-dmp as available for
any x86 VM, and dump-guest-memory accepts the win-dmp format
unconditionally. Both are wrong: win-dmp only works when the guest has
published a Windows dump header through vmcoreinfo.

The guest registers that note with the vmcoreinfo device (its physical
address and size), so win_dump_available() can read it back directly and
validate the note size and the Windows dump header signature. This needs
no other guest state, so it does not stop the vCPUs.

The capability query reads the note on the main thread with the BQL held
and has no migration guard of its own, so it is skipped while a migration
destination is still receiving guest RAM: there the read would deadlock
against the postcopy load (which needs the BQL) or, in precopy, see
incomplete pages.

Based on the original work of Nikolai Barybin.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 dump/win_dump-x86.c | 49 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/dump/win_dump-x86.c b/dump/win_dump-x86.c
index d893dea7f1..6a8b2b71a7 100644
--- a/dump/win_dump-x86.c
+++ b/dump/win_dump-x86.c
@@ -17,11 +17,10 @@
 #include "qemu/win_dump_defs.h"
 #include "win_dump.h"
 #include "cpu.h"
-
-bool win_dump_available(Error **errp)
-{
-    return true;
-}
+#include "qemu/bswap.h"
+#include "hw/misc/vmcoreinfo.h"
+#include "migration/misc.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
 
 static size_t win_dump_ptr_size(bool x64)
 {
@@ -403,6 +402,46 @@ static void restore_context(WinDumpHeader *h, bool x64,
     }
 }
 
+bool win_dump_available(Error **errp)
+{
+    VMCoreInfoState *vmci = vmcoreinfo_find();
+    g_autofree uint8_t *note = NULL;
+    Error *local_err = NULL;
+    WinDumpHeader *h;
+    uint32_t size;
+    bool x64 = true;
+
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "win-dump: not available during migration");
+        return false;
+    }
+
+    if (!vmci || !vmci->has_vmcoreinfo ||
+        le16_to_cpu(vmci->vmcoreinfo.guest_format) !=
+            FW_CFG_VMCOREINFO_FORMAT_ELF) {
+        error_setg(errp, "win-dump: no vmcoreinfo note from the guest");
+        return false;
+    }
+
+    size = le32_to_cpu(vmci->vmcoreinfo.size);
+    if (size != VMCOREINFO_WIN_DUMP_NOTE_SIZE32 &&
+        size != VMCOREINFO_WIN_DUMP_NOTE_SIZE64) {
+        error_setg(errp, "win-dump: invalid vmcoreinfo note size");
+        return false;
+    }
+
+    note = g_malloc(size);
+    cpu_physical_memory_read(le64_to_cpu(vmci->vmcoreinfo.paddr), note, size);
+
+    h = (void *)(note + VMCOREINFO_ELF_NOTE_HDR_SIZE);
+    if (!check_header(h, &x64, &local_err)) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    return true;
+}
+
 void create_win_dump(DumpState *s, Error **errp)
 {
     WinDumpHeader *h = (void *)(s->guest_note + VMCOREINFO_ELF_NOTE_HDR_SIZE);
-- 
2.53.0


