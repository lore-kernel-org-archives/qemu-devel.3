Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AA3C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifoV-0003SP-As; Sat, 11 Jul 2026 18:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifoT-0003Pk-FF; Sat, 11 Jul 2026 18:04:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifoR-0000Id-OK; Sat, 11 Jul 2026 18:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=x+PfetWz0JUn+OwM6oI/vUJA8aiYexVFJ80TaWlBdP0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TTLLA3ubOu1E4oAYgK9L0PR60QDRqxIUBL9tGayqj54KJ+BQfbo4J9vhiy9lDhmGd
 byMy5BG9qbXlE+cUlqe94H72Wn/PXYhYAMWlTm2+fGpZe+ZqHYG8Ab1dXmvsoJEsCz
 6SRvWJpH8QTz2C3uLybsR7YxdhlBb0p/20V+vhj7UeuscCjpdWfGdanUSuh9y7HNeM
 UEwPV+8fKnePV2Lf1VkwmwmlsNhpc8VL9v880/wo+1eaVU0JUeiwm4Ht5nf45wLuTV
 rLructXuwZMtJ50Mr+ZJWWIsp8i2xqxF8do5VB8tx7uDLE3zcajFbdl8wE/yncx3CP
 /vq3XauCiGC9Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F17B1C0ABF;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0699C3EAF4A;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B49651334B; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 52/81] hw/display/qxl: Fix mono cursor validation that
 can read past a cursor chunk
Date: Sun, 12 Jul 2026 00:58:30 +0300
Message-ID: <20260711215904.3757-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: Thomas Huth <thuth@redhat.com>

qxl_render_cursor() maps the guest-provided QXLCursor object using the
guest-controlled cursor->chunk.data_size.
For a mono cursor, qxl_cursor() then validates the expected bitmap size
against cursor->data_size, but it does not validate that the first chunk
actually contains that many bytes.
A guest could set cursor->data_size to the correct full mono cursor size
while setting cursor->chunk.data_size to zero. In that case, cursor_set_mono()
reads the AND/XOR masks starting at cursor->chunk.data. If the cursor object
is placed at the end of the QXL RAM BAR, those reads cross the mapped RAM
region and could crash the QEMU process (e.g. under ASan).

Fix it by double-checking cursor->chunk.data_size for the correct size.

This patch is based on the suggested changes by the reporter in the bug
ticket.

Reported-by: huntr bubble
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3646
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260630101022.379057-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 0e51b71c7b7706923536c1f7923cace82877932b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index c6a9ac1da10..1fe63b6f5ca 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -272,9 +272,11 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
     case SPICE_CURSOR_TYPE_MONO:
         /* Assume that the full cursor is available in a single chunk. */
         size = 2 * cursor_get_mono_bpl(c) * c->height;
-        if (size != cursor->data_size) {
-            fprintf(stderr, "%s: bad monochrome cursor %ux%u with size %u\n",
-                    __func__, c->width, c->height, cursor->data_size);
+        if (size != cursor->data_size || cursor->chunk.data_size < size) {
+            qxl_set_guest_bug(qxl, "%s: bad monochrome cursor %ux%u"
+                              " data_size %u chunk_size %u",
+                              __func__, c->width, c->height,
+                              cursor->data_size, cursor->chunk.data_size);
             goto fail;
         }
         and_mask = cursor->chunk.data;
-- 
2.47.3


