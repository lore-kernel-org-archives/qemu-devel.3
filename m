Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8127CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9bE-0001Fl-Qa; Sat, 17 Oct 2026 14:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9b8-00014v-9L; Sat, 17 Oct 2026 14:57:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9b6-0003iT-Bt; Sat, 17 Oct 2026 14:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263381; bh=qjpDxnfEm9cJ3vEgcmHzNJu+SLJ9x9KAe7d+Nn/yIrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MIjBzDy16gf76/Eg/Baikk5TPUVcfXtU0qxNPFgkjpsVjBp0c0vpuTDqOfT9vDlxz
 le6+IMbQIlSwqkc8KPM/yAW1BM3FJOCv4pgMYrD+suIiqFSiI009TF7Ixk1jCtcDvl
 u9IGIER8jEcM4XBKeFoJgzHRyBzCxyFla2kTvIZejPwjTfobe5iAM93HU6Lw8ZMRMv
 bQ2PTmmxC1sjVI+1D+G8j/FroxC3vHZECkBanwbW6FBI0GH23oZQ7lI/KpxTFWQaRj
 JiZvQ/AYsMMBzy9HcjmPrgaxB6lpce/R+NPIzEcKl4O660Rz9V8EOwTtNwQ7EgewqS
 EAEPzMkeOVJYA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BFB1D1DE6B5;
 Sat, 17 Oct 2026 21:56:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6DEE3443380;
 Sat, 17 Oct 2026 21:56:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 21/63] hw/display/qxl: validate replayed commands in
 qxl_post_load
Date: Sat, 17 Oct 2026 21:54:37 +0300
Message-ID: <20261017185528.722197-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

On incoming migration qxl_post_load() replays the tracked cursor and
surface commands by handing their guest addresses straight to spice,
without revalidating them. Those addresses were checked when the guest
submitted them, but the guest may have freed or reused that memory
before migration, so qxl's tracked pointer can be stale. spice-server
then re-parses the command from that memory and, for a stale cursor,
reads a garbage shape pointer -- aborting the target in memslot_get_virt()
(again, spice-server function) and failing the migration.

Validate each replayed command with qxl_guest_phys2virt(report_bug=false)
before adding it to the replay list, and for a cursor also validate the
nested shape pointer. Commands that no longer resolve are skipped rather
than replayed. report_bug is false so a stale pointer is not mistaken for
a live guest error, which would needlessly disable a healthy guest's
display.

Message-ID: <20260825172051.435372-3-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
(cherry picked from commit 95bc45193bbebcb11a45fa40c5642712cd4401bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 7dc4da3d93..418c317158 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2412,6 +2412,37 @@ static void qxl_create_memslots(PCIQXLDevice *d)
     }
 }
 
+/*
+ * Validate a command tracked for loadvm replay before handing its guest
+ * address to spice-server.
+ */
+static bool qxl_loadvm_cmd_valid(PCIQXLDevice *d, QXLPHYSICAL data,
+                                 uint32_t type)
+{
+    switch (type) {
+    case QXL_CMD_SURFACE:
+        return qxl_guest_phys2virt(d, data,
+                                   sizeof(QXLSurfaceCmd), false) != NULL;
+
+    case QXL_CMD_CURSOR: {
+        QXLCursorCmd *cmd = qxl_guest_phys2virt(d, data, sizeof(QXLCursorCmd),
+                                                false);
+
+        if (!cmd) {
+            return false;
+        }
+        if (le32_to_cpu(cmd->type) == QXL_CURSOR_SET) {
+            return qxl_guest_phys2virt(d, le64_to_cpu(cmd->u.set.shape),
+                                       sizeof(QXLCursor), false) != NULL;
+        }
+        return true;
+    }
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int qxl_post_load(void *opaque, int version)
 {
     PCIQXLDevice* d = opaque;
@@ -2450,12 +2481,17 @@ static int qxl_post_load(void *opaque, int version)
             if (d->guest_surfaces.cmds[in] == 0) {
                 continue;
             }
+            if (!qxl_loadvm_cmd_valid(d, d->guest_surfaces.cmds[in],
+                                      QXL_CMD_SURFACE)) {
+                continue;
+            }
             cmds[out].cmd.data = d->guest_surfaces.cmds[in];
             cmds[out].cmd.type = QXL_CMD_SURFACE;
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;
             out++;
         }
-        if (d->guest_cursor) {
+        if (d->guest_cursor &&
+            qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
             cmds[out].cmd.data = d->guest_cursor;
             cmds[out].cmd.type = QXL_CMD_CURSOR;
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;
-- 
2.47.3


