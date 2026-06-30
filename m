Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42946C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaBD-0002hq-2C; Tue, 30 Jun 2026 11:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBB-0002hQ-Iq
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBA-00009s-1R
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mH95uiYQHo8tm7+fISIlOPe/DC6AeHMmY7RDCPduhbU=;
 b=HNhWO9iDtQ+8G/eYw9+uCoIWRqMIAFK1fu0E9aX4Qw4btc4ednlJlvffSia9vJ0MplRpvu
 OZNG/ysrthew3eeb+naXuB6BRVCSYX4PMMpdZHUn8c1inOau+BuXwvoxHhxM0z/TQv0Ocw
 L/hwQi6i8rJIIvliOmWIhbt95HDqt/I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-t3uH312xNjKwefK-HP9eOg-1; Tue,
 30 Jun 2026 11:15:13 -0400
X-MC-Unique: t3uH312xNjKwefK-HP9eOg-1
X-Mimecast-MFC-AGG-ID: t3uH312xNjKwefK-HP9eOg_1782832513
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C14191954B39
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:15:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E76B1800744; Tue, 30 Jun 2026 15:15:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 19:13:19 +0400
Subject: [GIT PULL 4/8] dump: make win_dump_available() check vmcoreinfo
 for a Windows dump header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-dump-v1-4-7df3087dffc9@redhat.com>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3217;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=j+4A5jhhHYk2Y2kikeINl7pteWMLi44zfKnvifvvdtI=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGpD3Wegy7zDTbTKwP/xRYelw0HJqqe7fIV3INYCdPu+vt/5D
 okCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqQ91nAAoJENro4Ql1lpzlyLIP/i34
 UplpGdXF1D14HHMY36PG/R8JW4qQR4mhBYXfP9Mj3Fe2ILqOY7KJ2BwB0KFlN9PG1eyShmi/WCF
 9R+Gtnr6s+Ojj2Qy3hSQUj62Kj+B94LrEXAQzjZ3Cb5/lxUANwl3YlHB7U0N5CTk98shsqnkyUS
 hGHH51u40jh/zCm7FIHHAqdkb5pwWGWtL0GmufukrLf3BwQM1VIOqZzZZrJ0DQOrSxqhCp/stGO
 k/h7mkH5x2A5J6FzGw5AnG+UX0eT62plQhyIzuC8kIPqWDkBrhQUNCmAuIR633i1AIrTrEx+AeD
 ou7Dx4eda0OcRYOuiAUe2gzPz+Ssaq+LKz6gnZ9klSaUCOlipmn/OnVmjZRvgwlCzmCoufOXecH
 7s2AqICX6qFhw15LRl/NxK9THKEmW9TvxFUmbykjBLQZJVdxn7gIaO+o9qBeSw2cRJyAToD+0Ol
 stOc3A+m53TnDfkAfZtp6qtRsTjU0HNDazBcVwSUgCQVZAq88+6cgcgw9YQH4hODSqGP/MCTE0R
 L8KOjUGMnTu/ZpuKRZWC3gLQbfX/sAN8/Amj0vMRvO7MSTfcG/lKqgz5EvFM6C4Miizh/Q5qXOT
 nOSKJX5GEDmZ6VtPxpr7CYKOc2IqsRsvwhirSptHSQao6BpRpHhi/pKf/oeb1IpjkeTXAd3sCsL
 I9Qc/
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

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
[ MA - changed physical_memory_read() call ]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260619101834.228432-5-den@openvz.org>
---
 dump/win_dump-x86.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/dump/win_dump-x86.c b/dump/win_dump-x86.c
index 8848c8bfca3..0dd0c503c56 100644
--- a/dump/win_dump-x86.c
+++ b/dump/win_dump-x86.c
@@ -18,11 +18,10 @@
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
@@ -404,6 +403,46 @@ static void restore_context(WinDumpHeader *h, bool x64,
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
+    physical_memory_read(le64_to_cpu(vmci->vmcoreinfo.paddr), note, size);
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
2.54.0


