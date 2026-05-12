Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C534FCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuUX-0007Ol-AR; Tue, 12 May 2026 17:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUQ-0006sI-8l; Tue, 12 May 2026 17:18:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUO-00073z-Gh; Tue, 12 May 2026 17:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619496; bh=/DhOdDmo58kzaSVRgr6oIR5Y2kl4p3blSN2ouY54oXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=So/Y6B9gGiy1O4QWB7cBkliSeiep5gjp5cotTF3oIcGqb2OMBMjMU/+HwsnoElvMS
 uhXcMyfA7zUC8V/LzU8CbEBLcpq8zdJIHCRCCa2q+69gue/WGDU6tc2gCA3I8qdHPY
 T4aFXxIyTPsuIwVJyZe7mX1GyNrfO0iWxvmxtyi+37db5p9mrC0ccBIPAotovzlisl
 rny1aAd9JkLIUBHn/nf7R6UK1LePx17ZfP4EhGQCEklzo126/OWLUUZ5/9DhOesulF
 IodbjHIFQ3dW18D55/nY8AsnIjpKkUPlGItrhcXKpGPFxk8XBd4uU7sERgJdqmHKIT
 f/f3v6ZqFTt7w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CD1A41AA3CC;
 Tue, 12 May 2026 23:58:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D98333ABD24;
 Tue, 12 May 2026 23:58:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Werner de Carne <werner@carne.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 01/58] serial COM: windows serial COM PollingFunc
 don't sleep
Date: Tue, 12 May 2026 23:57:22 +0300
Message-ID: <20260512205820.361821-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
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

From: Werner de Carne <werner@carne.de>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1802
Signed-off-by: Werner de Carne <werner@carne.de>
[ Marc-André - indentation fixes ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230807201443.2668-1-werner@carne.de>
(cherry picked from commit 7437b3eab6af1d31bb7fdfb3ac4e0a4de6ada50b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/chardev/char-win.c b/chardev/char-win.c
index fef45e83aa..e194242c9f 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "chardev/char-win.h"
 
-static void win_chr_read(Chardev *chr, DWORD len)
+static int win_chr_read(Chardev *chr, DWORD len)
 {
     WinChardev *s = WIN_CHARDEV(chr);
     int max_size = qemu_chr_be_can_write(chr);
@@ -40,7 +40,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
         len = max_size;
     }
     if (len == 0) {
-        return;
+        return 0;
     }
 
     ZeroMemory(&s->orecv, sizeof(s->orecv));
@@ -56,6 +56,8 @@ static void win_chr_read(Chardev *chr, DWORD len)
     if (size > 0) {
         qemu_chr_be_write(chr, buf, size);
     }
+
+    return size > 0 ? 1 : 0;
 }
 
 static int win_chr_serial_poll(void *opaque)
@@ -67,8 +69,9 @@ static int win_chr_serial_poll(void *opaque)
 
     ClearCommError(s->file, &comerr, &status);
     if (status.cbInQue > 0) {
-        win_chr_read(chr, status.cbInQue);
-        return 1;
+        if (win_chr_read(chr, status.cbInQue)) {
+            return 1;
+        }
     }
     return 0;
 }
@@ -147,8 +150,9 @@ int win_chr_pipe_poll(void *opaque)
 
     PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
     if (size > 0) {
-        win_chr_read(chr, size);
-        return 1;
+        if (win_chr_read(chr, size)) {
+            return 1;
+        }
     }
     return 0;
 }
-- 
2.47.3


