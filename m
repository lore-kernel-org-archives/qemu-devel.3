Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B24C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 21:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x436V-0003Lr-V8; Tue, 08 Sep 2026 17:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=gK2s=HA=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1x436P-0003LQ-EZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 17:11:38 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=gK2s=HA=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1x436N-0001M6-H3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 17:11:37 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id E94ECA1CE7;
 Tue,  8 Sep 2026 23:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1788901890; bh=QBFMfNP5LYG0Z7Yhy6tmRXxmOozuBAzbbB9jh5KLdMc=;
 h=From:To:Cc:Subject:Date:From;
 b=QJ4IOudB5FD4i3EHRkzCS+c/B3K1P39BfnO9ewGWl7LkdIf/7IgwwtpMEg5ZpXwYZ
 QSZIzXvefFpj6b3K7NeH6y2b8zM0ZRPSXkgQQD6cNQgpwVAwLeO+Ui9ntJWhthdX7c
 gcPUn258lUUHPKnqucd0ppMNqi15Z7wk1L9BrOwSM5LZkvo28l2nUyxDZYDp5U1hMI
 +fijIdKoZnOwj20C8QInGeKldoRa4N8BpsoRuKM9vOAMP3F/xLGLXFOI3gJUd/CHvF
 SOEW1SEjUh4n1CmE40RbHKtVATuywBgNeYN/2+fcb0T9v3l6V/90/XUoDF0OCw9Zh1
 b3RovGhiA/0dw==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jsd_dMMzQzSs; Tue,  8 Sep 2026 23:11:30 +0200 (CEST)
Received: from end (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 4515DA1C43;
 Tue,  8 Sep 2026 23:11:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1788901890; bh=QBFMfNP5LYG0Z7Yhy6tmRXxmOozuBAzbbB9jh5KLdMc=;
 h=From:To:Cc:Subject:Date:From;
 b=QJ4IOudB5FD4i3EHRkzCS+c/B3K1P39BfnO9ewGWl7LkdIf/7IgwwtpMEg5ZpXwYZ
 QSZIzXvefFpj6b3K7NeH6y2b8zM0ZRPSXkgQQD6cNQgpwVAwLeO+Ui9ntJWhthdX7c
 gcPUn258lUUHPKnqucd0ppMNqi15Z7wk1L9BrOwSM5LZkvo28l2nUyxDZYDp5U1hMI
 +fijIdKoZnOwj20C8QInGeKldoRa4N8BpsoRuKM9vOAMP3F/xLGLXFOI3gJUd/CHvF
 SOEW1SEjUh4n1CmE40RbHKtVATuywBgNeYN/2+fcb0T9v3l6V/90/XUoDF0OCw9Zh1
 b3RovGhiA/0dw==
Received: from samy by end with local (Exim 4.100)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1x436G-00000001btj-3O35; Tue, 08 Sep 2026 23:11:28 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org
Cc: Hongyan Xu <getshell@seu.edu.cn>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] chardev/baum: unregister the brlapi fd handler on finalize
Date: Tue,  8 Sep 2026 23:11:26 +0200
Message-ID: <20260908211126.383996-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=gK2s=HA=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Hongyan Xu <getshell@seu.edu.cn>

baum_chr_open() registers baum->brlapi_fd with the main loop through a
raw qemu_set_fd_handler() call.  The chardev base class does not know
about this handler, and char_braille_finalize() only closes the brlapi
connection and frees the handle; it never removes the fd handler.

When the chardev is removed at runtime (QMP chardev-remove /
object_unparent), BaumChardev is finalized and freed while the main loop
still holds an fd handler whose opaque points to the freed object.  The
next time brlapi_fd becomes readable (or the connection drops) the loop
calls baum_chr_read() with a dangling opaque, dereferencing freed
memory -> host use-after-free.

Unregister the handler in char_braille_finalize() before tearing the
connection down, using the same descriptor that baum_chr_open()
registered, and NULL the handle afterwards as a belt-and-braces guard.
Only do so while baum->brlapi is valid: baum_chr_open() sets
baum->brlapi_fd from brlapi__openConnection(), which is
BRLAPI_INVALID_FILE_DESCRIPTOR on failure, and that error path already
g_free()s the handle and returns before any handler is installed.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-ID: <20260904033055.413-1-getshell@seu.edu.cn>
---
 chardev/baum.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/chardev/baum.c b/chardev/baum.c
index ac1e535ba8..166d6f2f09 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -659,6 +659,7 @@ static void baum_chr_read(void *opaque)
     }
     if (ret == -1 && (brlapi_errno != BRLAPI_ERROR_LIBCERR || errno != EINTR)) {
         brlapi_perror("baum: brlapi_readKey");
+        qemu_set_fd_handler(baum->brlapi_fd, NULL, NULL, NULL);
         brlapi__closeConnection(baum->brlapi);
         g_free(baum->brlapi);
         baum->brlapi = NULL;
@@ -671,8 +672,16 @@ static void char_braille_finalize(Object *obj)
 
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
+        /*
+         * baum_chr_open() registered brlapi_fd with the main loop via
+         * qemu_set_fd_handler(); unregister it before tearing the
+         * connection down so a later chardev-remove cannot dispatch
+         * baum_chr_read() with a dangling opaque.
+         */
+        qemu_set_fd_handler(baum->brlapi_fd, NULL, NULL, NULL);
         brlapi__closeConnection(baum->brlapi);
         g_free(baum->brlapi);
+        baum->brlapi = NULL;
     }
 }
 
-- 
2.53.0


