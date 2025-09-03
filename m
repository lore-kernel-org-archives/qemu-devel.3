Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F130CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2Z-000692-4x; Wed, 03 Sep 2025 05:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2R-00063u-5S; Wed, 03 Sep 2025 05:44:23 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2N-0007uU-P9; Wed, 03 Sep 2025 05:44:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AD7BC806F5;
 Wed, 03 Sep 2025 12:44:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-frm9E0oN; Wed, 03 Sep 2025 12:44:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892656;
 bh=sIRk+lbn/qhf6egokX5jBbKKnrraNB0E4tHLMcdfjyg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nT4yCZVsRkiA7SMnpQ56wBrm1Cnlh9icDq5jMTo2DwmW1o9yKBbOhcS9bg6vG4/Bk
 iMD150zYxISfZOK8mqEsAkrIckHEafoa/fjBkEA2+MpCFPh0glsHwsLCprFmzIMsjX
 uVqjqnoGFQZd37dMXpuimLO0mBUclILoPxN1TRow=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 02/10] char-socket: rework tcp_chr_recv()
Date: Wed,  3 Sep 2025 12:44:02 +0300
Message-ID: <20250903094411.1029449-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

First, qio_channel_readv_full() already guarantees BLOCKING and
CLOEXEC states for incoming descriptors, no reason call extra
ioctls.

Second, current implementation calls _set_block() and _set_cloexec()
again on old descriptors on failure path - we fix this too.

Finally, handling errors exactly after qio_channel_readv_full() call
looks more readable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-socket.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1e8313915b..5b9b19ba8b 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -293,6 +293,18 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
                                      0, &err);
     }
 
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        errno = EAGAIN;
+        return -1;
+    } else if (ret == -1) {
+        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
+        error_free(err);
+        errno = EIO;
+        return -1;
+    }
+
+    assert(ret >= 0);
+
     if (msgfds_num) {
         /* close and clean read_msgfds */
         for (i = 0; i < s->read_msgfds_num; i++) {
@@ -307,30 +319,7 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
         s->read_msgfds_num = msgfds_num;
     }
 
-    for (i = 0; i < s->read_msgfds_num; i++) {
-        int fd = s->read_msgfds[i];
-        if (fd < 0) {
-            continue;
-        }
-
-        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-        qemu_socket_set_block(fd);
-
-#ifndef MSG_CMSG_CLOEXEC
-        qemu_set_cloexec(fd);
-#endif
-    }
-
-    if (ret == QIO_CHANNEL_ERR_BLOCK) {
-        errno = EAGAIN;
-        ret = -1;
-    } else if (ret == -1) {
-        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
-        error_free(err);
-        errno = EIO;
-    } else if (ret == 0) {
-        trace_chr_socket_recv_eof(chr, chr->label);
-    }
+    trace_chr_socket_recv_eof(chr, chr->label);
 
     return ret;
 }
-- 
2.48.1


