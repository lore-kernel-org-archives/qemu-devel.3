Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDEACAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9Aw-0001zd-RL; Mon, 15 Sep 2025 09:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AS-0001k8-NC; Mon, 15 Sep 2025 09:22:53 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AA-0006xo-BT; Mon, 15 Sep 2025 09:22:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 08743807BD;
 Mon, 15 Sep 2025 16:22:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:130::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GMPC4o1FuGk0-ynJLw6UQ; Mon, 15 Sep 2025 16:22:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757942539;
 bh=WvzQDHe9ns7kfUBciD1JZDDf4ABJmycTS10fI1l005c=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=KaOABvh4zOHIguIeZo8Xs4iJ/xqcVuvxccuhtY8qJqkLzaz5XLAj1LTfU5YtpFTzj
 mvB9zXOHFT2fxKK4gPMTJKNy9VoPxCfHFqyGNbAGUpjW3YkXi3N4psdD3BKes5GFyH
 5E/8wyG4wjDHPnpK2QEX/TVAdcB/HlV8Fc/WN/fw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v3 03/13] util: add qemu_set_blocking() function
Date: Mon, 15 Sep 2025 16:22:00 +0300
Message-ID: <20250915132211.135095-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915132211.135095-1-vsementsov@yandex-team.ru>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In generic code we have qio_channel_set_blocking(), which takes
bool parameter, and qemu_file_set_blocking(), which as well takes
bool parameter.

At lower fd-layer we have a mess of functions:

- enough direct calls to Unix-specific g_unix_set_fd_nonblocking()
(of course, all calls are out of Windows-compatible code), which
is glib specific with GError, which we can't use, and have to
handle error-reporting by hand after the call.

and several platform-agnostic qemu_* helpers:

- qemu_socket_set_nonblock(), which asserts success for posix (still,
  in most cases we can handle the error in better way) and ignores
  error for win32 realization

- qemu_socket_try_set_nonblock(), providing and error, but not errp,
so we have to handle it after the call

- qemu_socket_set_block(), which simply ignores an error

Note, that *_socket_* word in original API, which we are going
to substitute was intended, because Windows support these operations
only for sockets. What leads to solution of dropping it again?

1. Having a QEMU-native wrapper with errp parameter
for g_unix_set_fd_nonblocking() for non-socket fds worth doing,
at least to unify error handling.

2. So, if try to keep _socket_ vs _file_ words, we'll have two
actually duplicated functions for Linux, which actually will
be executed successfully on any (good enough) fds, and nothing
prevent using them improperly except for the name. That doesn't
look good.

3. Naming helped us in the world where we crash on errors or
ignore them. Now, with errp parameter, callers are intended to
proper error checking. And for places where we really OK with
crash-on-error semantics (like tests), we have an explicit
&error_abort.

So, this commit starts a series, which will effectively revert
commit ff5927baa7ffb9 "util: rename qemu_*block() socket functions"
(which in turn was reverting f9e8cacc5557e43
"oslib-posix: rename socket_set_nonblock() to qemu_set_nonblock()",
so that's a long story).
Now we don't simply rename, instead we provide the new API and
update all the callers.

This commit only introduces a new fd-layer wrapper. Next commits
will replace old API calls with it, and finally remove old API.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h |  1 +
 util/oslib-posix.c   | 15 +++++++++++++++
 util/oslib-win32.c   | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index be3460b32f..1b38cb7e45 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -687,6 +687,7 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
     G_GNUC_WARN_UNUSED_RESULT;
 
 void qemu_set_cloexec(int fd);
+bool qemu_set_blocking(int fd, bool block, Error **errp);
 
 /* Return a dynamically allocated directory path that is appropriate for storing
  * local state.
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4ff577e5de..c737701075 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -250,6 +250,21 @@ void qemu_anon_ram_free(void *ptr, size_t size)
 #endif
 }
 
+bool qemu_set_blocking(int fd, bool block, Error **errp)
+{
+    g_autoptr(GError) err = NULL;
+
+    if (!g_unix_set_fd_nonblocking(fd, !block, &err)) {
+        error_setg_errno(errp, errno,
+                         "Can't set file descriptor %d %s: %s", fd,
+                         block ? "blocking" : "non-blocking",
+                         err->message);
+        return false;
+    }
+
+    return true;
+}
+
 void qemu_socket_set_block(int fd)
 {
     g_unix_set_fd_nonblocking(fd, false, NULL);
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b7351634ec..03044f5b59 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -177,6 +177,24 @@ static int socket_error(void)
     }
 }
 
+bool qemu_set_blocking(int fd, bool block, Error **errp)
+{
+    unsigned long opt = block ? 0 : 1;
+
+    if (block) {
+        qemu_socket_unselect(fd, NULL);
+    }
+
+    if (ioctlsocket(fd, FIONBIO, &opt) != NO_ERROR) {
+        error_setg_errno(errp, socket_error(),
+                         "Can't set file descriptor %d %s", fd,
+                         block ? "blocking" : "non-blocking");
+        return false;
+    }
+
+    return true;
+}
+
 void qemu_socket_set_block(int fd)
 {
     unsigned long opt = 0;
-- 
2.48.1


