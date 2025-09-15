Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB544CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 19:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyEvx-00020j-OI; Mon, 15 Sep 2025 15:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEvk-0001rE-3m; Mon, 15 Sep 2025 15:32:04 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEvO-0001wa-NI; Mon, 15 Sep 2025 15:32:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 05006809BC;
 Mon, 15 Sep 2025 22:31:22 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:184::1:6])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AVVVql1FrOs0-xDAS6Xfu; Mon, 15 Sep 2025 22:31:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757964681;
 bh=hUqfmUSn/mZjfZQ9QHFz6axFHBATGjxge6kva+qLpew=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=jpp2ZGBJOMuJyRkg9nkJnnBhQz9ls5e7h5wjfLqapZI3oxFHUXgRo0pCNkBFjr7DH
 1SIoGQiPNyTbjLiwcd1UBlPFODE/v5zuC3OfRIW1obtw6GYycvaoGZ+0Z1rsqPavvC
 Axuo3OT8y69X9ryYN3QAb1G5LOhPO6k3+BUXa2OI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 11/12] chardev: qemu_chr_open_fd(): add errp
Date: Mon, 15 Sep 2025 22:31:03 +0300
Message-ID: <20250915193105.230085-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915193105.230085-1-vsementsov@yandex-team.ru>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Every caller already support errp, let's go further.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-fd.c         | 12 ++++++++----
 chardev/char-file.c       |  6 +++++-
 chardev/char-pipe.c       |  9 ++++++++-
 chardev/char-serial.c     |  5 ++++-
 chardev/char-stdio.c      |  7 +++++--
 include/chardev/char-fd.h |  2 +-
 6 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 739dc68c36..4ee286f323 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -206,14 +206,16 @@ int qmp_chardev_open_file_source(char *src, int flags, Error **errp)
 }
 
 /* open a character device to a unix fd */
-void qemu_chr_open_fd(Chardev *chr,
-                      int fd_in, int fd_out)
+bool qemu_chr_open_fd(Chardev *chr,
+                      int fd_in, int fd_out, Error **errp)
 {
     FDChardev *s = FD_CHARDEV(chr);
     g_autofree char *name = NULL;
 
     if (fd_out >= 0) {
-        qemu_set_blocking(fd_out, false, &error_abort);
+        if (!qemu_set_blocking(fd_out, false, errp)) {
+            return false;
+        }
     }
 
     if (fd_out == fd_in && fd_in >= 0) {
@@ -221,7 +223,7 @@ void qemu_chr_open_fd(Chardev *chr,
         name = g_strdup_printf("chardev-file-%s", chr->label);
         qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
         s->ioc_out = QIO_CHANNEL(object_ref(s->ioc_in));
-        return;
+        return true;
     }
 
     if (fd_in >= 0) {
@@ -236,6 +238,8 @@ void qemu_chr_open_fd(Chardev *chr,
         name = g_strdup_printf("chardev-file-out-%s", chr->label);
         qio_channel_set_name(QIO_CHANNEL(s->ioc_out), name);
     }
+
+    return true;
 }
 
 static void char_fd_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-file.c b/chardev/char-file.c
index a9e8c5e0d7..89e9cb849c 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -92,7 +92,11 @@ static void qmp_chardev_open_file(Chardev *chr,
         }
     }
 
-    qemu_chr_open_fd(chr, in, out);
+    if (!qemu_chr_open_fd(chr, in, out, errp)) {
+        qemu_close(out);
+        qemu_close(in);
+        return;
+    }
 #endif
 }
 
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 3d1b0ce2d2..e9f3bb8290 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -150,7 +150,14 @@ static void qemu_chr_open_pipe(Chardev *chr,
             return;
         }
     }
-    qemu_chr_open_fd(chr, fd_in, fd_out);
+
+    if (!qemu_chr_open_fd(chr, fd_in, fd_out, errp)) {
+        close(fd_in);
+        if (fd_out != fd_in) {
+            close(fd_out);
+        }
+        return;
+    }
 }
 
 #endif /* !_WIN32 */
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 1ff31dcde3..c622d758db 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -276,7 +276,10 @@ static void qmp_chardev_open_serial(Chardev *chr,
     }
     tty_serial_init(fd, 115200, 'N', 8, 1);
 
-    qemu_chr_open_fd(chr, fd, fd);
+    if (!qemu_chr_open_fd(chr, fd, fd, errp)) {
+        close(fd);
+        return;
+    }
 }
 #endif /* __linux__ || __sun__ */
 
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 193727e807..2568164a10 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -110,14 +110,17 @@ static void qemu_chr_open_stdio(Chardev *chr,
     if (!qemu_set_blocking(0, false, errp)) {
         return;
     }
+
+    if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
+        return;
+    }
+
     atexit(term_exit);
 
     memset(&act, 0, sizeof(act));
     act.sa_handler = term_stdio_handler;
     sigaction(SIGCONT, &act, NULL);
 
-    qemu_chr_open_fd(chr, 0, 1);
-
     stdio_allow_signal = !opts->has_signal || opts->signal;
     qemu_chr_set_echo_stdio(chr, false);
 }
diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
index 9de0e440de..6fe43062ca 100644
--- a/include/chardev/char-fd.h
+++ b/include/chardev/char-fd.h
@@ -41,7 +41,7 @@ typedef struct FDChardev FDChardev;
 DECLARE_INSTANCE_CHECKER(FDChardev, FD_CHARDEV,
                          TYPE_CHARDEV_FD)
 
-void qemu_chr_open_fd(Chardev *chr, int fd_in, int fd_out);
+bool qemu_chr_open_fd(Chardev *chr, int fd_in, int fd_out, Error **errp);
 int qmp_chardev_open_file_source(char *src, int flags, Error **errp);
 
 #endif /* CHAR_FD_H */
-- 
2.48.1


