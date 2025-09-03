Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB15CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2Z-000699-NQ; Wed, 03 Sep 2025 05:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2S-00064z-FI; Wed, 03 Sep 2025 05:44:24 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2Q-0007v4-Cn; Wed, 03 Sep 2025 05:44:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BF0A98078F;
 Wed, 03 Sep 2025 12:44:19 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-lPCqMY01; Wed, 03 Sep 2025 12:44:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892659;
 bh=fkLGyCbDw3KY+wvM5vQPHxrSIbDb3U7juq+tFywxqw8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=JA4nSTMGJJsYSqM6i2/e159fuyGuraJUhdh8ORBisls/ZDxHiR2nuzVidrgGvyn9H
 SgZMzrLmZEdXeBZ/8XtcsFjJjdv1QjyedG7honDK9Jb2Y9h/hE/Z4fMC/EJO6EiobN
 KjgVPVAO2j30q/yQ5eByaU6X5ASQJ5ppKlEAm0rw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH 06/10] util: drop qemu_socket_set_block()
Date: Wed,  3 Sep 2025 12:44:06 +0300
Message-ID: <20250903094411.1029449-7-vsementsov@yandex-team.ru>
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

Now we can use qemu_set_blocking() and stop ignore errors in
these case.

Just crash on error for now, as we'll rework it in following commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/qemu/sockets.h | 1 -
 io/channel-socket.c    | 3 ++-
 util/oslib-posix.c     | 6 ------
 util/oslib-win32.c     | 7 -------
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 9512fec514..be351d85f7 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -46,7 +46,6 @@ ssize_t qemu_send_full(int s, const void *buf, size_t count)
     G_GNUC_WARN_UNUSED_RESULT;
 int socket_set_cork(int fd, int v);
 int socket_set_nodelay(int fd);
-void qemu_socket_set_block(int fd);
 int socket_set_fast_reuse(int fd);
 
 #ifdef WIN32
diff --git a/io/channel-socket.c b/io/channel-socket.c
index e77602a22e..4f7e86f72f 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -498,7 +498,8 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
             }
 
             /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-            qemu_socket_set_block(fd);
+            /* TODO: don't crash on error, just handle it! */
+            qemu_set_blocking(fd, true, &error_abort);
 
 #ifndef MSG_CMSG_CLOEXEC
             qemu_set_cloexec(fd);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 51f16d57ff..8891d82db0 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -262,12 +262,6 @@ bool qemu_set_blocking(int fd, bool block, Error **errp)
     return true;
 }
 
-void qemu_socket_set_block(int fd)
-{
-    g_unix_set_fd_nonblocking(fd, false, NULL);
-}
-
-
 int socket_set_fast_reuse(int fd)
 {
     int val = 1, ret;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index bf5d478c5c..b9ce2f96ee 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -195,13 +195,6 @@ bool qemu_set_blocking(int fd, bool block, Error **errp)
     return true;
 }
 
-void qemu_socket_set_block(int fd)
-{
-    unsigned long opt = 0;
-    qemu_socket_unselect(fd, NULL);
-    ioctlsocket(fd, FIONBIO, &opt);
-}
-
 int socket_set_fast_reuse(int fd)
 {
     /* Enabling the reuse of an endpoint that was used by a socket still in
-- 
2.48.1


