Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797FBCA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2Z-00069B-RV; Wed, 03 Sep 2025 05:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2U-000664-5t; Wed, 03 Sep 2025 05:44:26 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2S-0007vp-CM; Wed, 03 Sep 2025 05:44:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9A5C6807BA;
 Wed, 03 Sep 2025 12:44:22 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-YKtgi2yn; Wed, 03 Sep 2025 12:44:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892662;
 bh=cxz7Rx52Pf9R/0jZg6IJzKm0KNpYmtuSsQhLIkTbvH0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=KrEBzLb2iZbbeHCBq1kOgvxsAnIc6Pwuq/aImZWpIpum2za7aDey3Z4/l74GVE5Bg
 ebERmwAItE93ols4nuRiF2x+fQqlfDwMzAKM4tNpQLEKcGu7kI0kumNs4unGy9XYKf
 l9UxlpcoX1Y+LsI3sWIEMAHkxY5+zPXRTDFXUkSQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 08/10] oslib-posix: add qemu_fds_set_blocking() helper
Date: Wed,  3 Sep 2025 12:44:08 +0300
Message-ID: <20250903094411.1029449-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
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

And use it in io/channel-socket.c. This simplifies the following
commit, which will move this functionality from io/channel-socket.c
to the callers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/qemu/osdep.h |  7 +++++++
 io/channel-socket.c  | 24 +++++++++++++-----------
 util/oslib-posix.c   | 12 ++++++++++++
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1b38cb7e45..dde98d588c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -689,6 +689,13 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
 void qemu_set_cloexec(int fd);
 bool qemu_set_blocking(int fd, bool block, Error **errp);
 
+/*
+ * qemu_fds_set_blockinging:
+ * Call qemu_socket_set_block() on several fds.
+ * When @nfds = 0, does nothing, @fds is not touched.
+ */
+bool qemu_fds_set_blockinging(int *fds, int nfds, bool block, Error **errp);
+
 /* Return a dynamically allocated directory path that is appropriate for storing
  * local state.
  *
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 4f7e86f72f..96098b5bcc 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -472,8 +472,11 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
     *fds = NULL;
 
     for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
-        int fd_size, i;
+        int fd_size;
         int gotfds;
+#ifndef MSG_CMSG_CLOEXEC
+        int i;
+#endif
 
         if (cmsg->cmsg_len < CMSG_LEN(sizeof(int)) ||
             cmsg->cmsg_level != SOL_SOCKET ||
@@ -491,20 +494,19 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
         *fds = g_renew(int, *fds, *nfds + gotfds);
         memcpy(*fds + *nfds, CMSG_DATA(cmsg), fd_size);
 
+        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
+        /* TODO: don't crash on error, just handle it! */
+        qemu_fds_set_blockinging(*fds + *nfds, gotfds, true, &error_abort);
+
+#ifndef MSG_CMSG_CLOEXEC
         for (i = 0; i < gotfds; i++) {
             int fd = (*fds)[*nfds + i];
-            if (fd < 0) {
-                continue;
+            if (fd >= 0) {
+                qemu_set_cloexec(fd);
             }
-
-            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-            /* TODO: don't crash on error, just handle it! */
-            qemu_set_blocking(fd, true, &error_abort);
-
-#ifndef MSG_CMSG_CLOEXEC
-            qemu_set_cloexec(fd);
-#endif
         }
+#endif
+
         *nfds += gotfds;
     }
 }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 8891d82db0..8589ff21ec 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -262,6 +262,18 @@ bool qemu_set_blocking(int fd, bool block, Error **errp)
     return true;
 }
 
+bool qemu_fds_set_blockinging(int *fds, int nfds, bool block, Error **errp)
+{
+    int i;
+    for (i = 0; i < nfds; i++) {
+        if (fds[i] >= 0 && !qemu_set_blocking(fds[i], block, errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 int socket_set_fast_reuse(int fd)
 {
     int val = 1, ret;
-- 
2.48.1


