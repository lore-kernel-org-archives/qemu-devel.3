Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95D1E9E2F9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9NA-0000HI-J5; Wed, 11 Feb 2026 07:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq9N8-0000Ar-9L
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq9N6-0000F3-Id
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770813067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47+h7KsUk4pIeVRSrl5x3R/+mYPfTcUJPXIJdzZh/Nw=;
 b=MFaYlZbAwjD3Wk5zykf1DRFQ3U3spCBoJv+qMv9A7nwWIJR/q8TFqxVYtsbcOAn2giBMqN
 rRBtNIrO0yZEQ7qc/zukPoOZBAf+9MOHmn4Pa3pTK+DluZ2K2EPVxrwYHAa5y9U6j/GmCI
 995Z6fm+sOu6AYSz1HT8/3xjU/wJqjI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-pzo26kLgOTqOlnqtBd77Iw-1; Wed,
 11 Feb 2026 07:31:04 -0500
X-MC-Unique: pzo26kLgOTqOlnqtBd77Iw-1
X-Mimecast-MFC-AGG-ID: pzo26kLgOTqOlnqtBd77Iw_1770813062
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4B261800282; Wed, 11 Feb 2026 12:31:01 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A08C1956056; Wed, 11 Feb 2026 12:30:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, Eric Blake <eblake@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 08/14] chardev/char-pty: store pty_name into PtyChardev state
Date: Wed, 11 Feb 2026 16:29:55 +0400
Message-ID: <20260211123007.3569932-9-marcandre.lureau@redhat.com>
In-Reply-To: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
References: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We'll use it in following commit.

Note the bonus: stop use blind strcpy().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260115144606.233252-8-vsementsov@yandex-team.ru>
---
 chardev/char-pty.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 9e26e97baf5..a582aa7bc73 100644
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
2.52.0


