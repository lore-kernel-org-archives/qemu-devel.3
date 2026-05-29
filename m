Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CD0CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 02:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSmja-0005nL-4T; Thu, 28 May 2026 22:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSmjT-0005ms-6B
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:13:56 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSmjM-0002k1-Nz
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780020806; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=jV6PANJnCuwqY9U2HbdFBmiX9pxLJwyq2i3etcRWIqA=;
 b=wzfORV4EiMUONtERJwQywZsqxVfXTrSqbQJCW/O8Q7Vzo8AukX+CZRPX4xQr/I5ES0VdTVWAP2wYrTTuA5DLBj4rp8fYePd8Tx4Kk+ZgIgvzHnXC4s6KZ31IrtCpUQWFCil5U+QSzJx4BNlHaxZhGEv1aPUu8Z9yuTPvcX3apU4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---0X3nuJhJ_1780020805; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X3nuJhJ_1780020805 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 29 May 2026 10:13:25 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [PATCH] io/channel-socket: move cmsg memset into fd-passing branches
Date: Fri, 29 May 2026 10:13:24 +0800
Message-ID: <20260529021324.52124-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

In qio_channel_socket_readv() and qio_channel_socket_writev(), the
control message buffer is unconditionally zeroed on every call, even
when no file descriptors are being transferred.  The memset touches
CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS) bytes -- typically 80 bytes
on x86-64 -- on every I/O operation.

Move the memset into the conditional branches that actually set up
msg_control, so the common fast path (no fd passing) avoids the
unnecessary zeroing.  Also narrow the scope of fdsize and cmsg in
writev() to the branch that uses them.

No functional change for paths that transfer file descriptors.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 io/channel-socket.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3053b35ad8..d19c73cacc 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -562,11 +562,10 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     char control[CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS)];
     int sflags = 0;
 
-    memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
-
     msg.msg_iov = (struct iovec *)iov;
     msg.msg_iovlen = niov;
     if (fds && nfds) {
+        memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
         msg.msg_control = control;
         msg.msg_controllen = sizeof(control);
 #ifdef MSG_CMSG_CLOEXEC
@@ -622,20 +621,19 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
     ssize_t ret;
     struct msghdr msg = { NULL, };
     char control[CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS)];
-    size_t fdsize = sizeof(int) * nfds;
-    struct cmsghdr *cmsg;
     int sflags = 0;
 #ifdef QEMU_MSG_ZEROCOPY
     bool blocking = sioc->blocking;
     bool zerocopy_flushed_once = false;
 #endif
 
-    memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
-
     msg.msg_iov = (struct iovec *)iov;
     msg.msg_iovlen = niov;
 
     if (nfds) {
+        size_t fdsize = sizeof(int) * nfds;
+        struct cmsghdr *cmsg;
+
         if (nfds > SOCKET_MAX_FDS) {
             error_setg_errno(errp, EINVAL,
                              "Only %d FDs can be sent, got %zu",
@@ -643,6 +641,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
             return -1;
         }
 
+        memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
         msg.msg_control = control;
         msg.msg_controllen = CMSG_SPACE(sizeof(int) * nfds);
 
-- 
2.50.1 (Apple Git-155)


