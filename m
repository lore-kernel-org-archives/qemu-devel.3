Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF999D216A5
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRBTx-0006Tv-2S; Thu, 04 Dec 2025 10:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRBTm-0006R8-AG
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:42:51 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRBTj-0007F4-IX
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:42:50 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E067680771;
 Thu, 04 Dec 2025 18:42:45 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id agnhnW0F9Gk0-M5vImUFU; Thu, 04 Dec 2025 18:42:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764862965;
 bh=QEF7AKFuJmnyk85mUPCxeEPGdXymBb7vQLej3LTUu5A=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=w9ad2q8Dd5M/yYj48/xg5HRqapMUSbYho0Z7WVPm5pVv1k0PLyFv2QPdi9dZccOMT
 ddF4dOENVd6mHzuk7Mvjzm03NpMCn6GCRwYNYdHKts9CgVYi+LZDHBKsTVqzFk+ecz
 rfX1zPwFkFrn0MRRpZwkX/fX7gERb2gqx0dr0TxQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v2 07/10] chardev/char-pty: store pty_name into PtyChardev
 state
Date: Thu,  4 Dec 2025 18:42:31 +0300
Message-ID: <20251204154235.149575-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251204154235.149575-1-vsementsov@yandex-team.ru>
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

We'll use it in following commit.

Note the bonus: stop use blind strcpy().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-pty.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 9e26e97baf..a582aa7bc7 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -43,6 +43,7 @@ struct PtyChardev {
     int connected;
     GSource *timer_src;
     char *path;
+    char *pty_name;
 };
 typedef struct PtyChardev PtyChardev;
 
@@ -303,7 +304,7 @@ static void cfmakeraw (struct termios *termios_p)
 #endif
 
 /* like openpty() but also makes it raw; return master fd */
-static int qemu_openpty_raw(int *aslave, char *pty_name)
+static int qemu_openpty_raw(int *aslave, char **pty_name)
 {
     int amaster;
     struct termios tty;
@@ -324,9 +325,7 @@ static int qemu_openpty_raw(int *aslave, char *pty_name)
     cfmakeraw(&tty);
     tcsetattr(*aslave, TCSAFLUSH, &tty);
 
-    if (pty_name) {
-        strcpy(pty_name, q_ptsname(amaster));
-    }
+    *pty_name = g_strdup(q_ptsname(amaster));
 
     return amaster;
 }
@@ -335,11 +334,12 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     PtyChardev *s;
     int master_fd, slave_fd;
-    char pty_name[PATH_MAX];
     char *name;
     char *path = backend->u.pty.data->path;
 
-    master_fd = qemu_openpty_raw(&slave_fd, pty_name);
+    s = PTY_CHARDEV(chr);
+
+    master_fd = qemu_openpty_raw(&slave_fd, &s->pty_name);
     if (master_fd < 0) {
         error_setg_errno(errp, errno, "Failed to create PTY");
         return false;
@@ -351,11 +351,10 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         return false;
     }
 
-    chr->filename = g_strdup_printf("pty:%s", pty_name);
+    chr->filename = g_strdup_printf("pty:%s", s->pty_name);
     qemu_printf("char device redirected to %s (label %s)\n",
-                pty_name, chr->label);
+                s->pty_name, chr->label);
 
-    s = PTY_CHARDEV(chr);
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name = g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(s->ioc, name);
@@ -364,7 +363,7 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     /* create symbolic link */
     if (path) {
-        int res = symlink(pty_name, path);
+        int res = symlink(s->pty_name, path);
 
         if (res != 0) {
             error_setg_errno(errp, errno, "Failed to create PTY symlink");
-- 
2.48.1


