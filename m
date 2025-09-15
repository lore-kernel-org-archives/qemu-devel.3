Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F095CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9AE-0001c0-F5; Mon, 15 Sep 2025 09:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9A8-0001an-QQ; Mon, 15 Sep 2025 09:22:33 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9A1-0006xW-1i; Mon, 15 Sep 2025 09:22:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id AF1C0807B1;
 Mon, 15 Sep 2025 16:22:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:130::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GMPC4o1FuGk0-D6exY2sn; Mon, 15 Sep 2025 16:22:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757942538;
 bh=wsoWvxGRkjhfwaoMYAfFW+x0chbESno/XD13mprGv/0=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=U45ePps40dkKZcnTz+fF5tIhgBFoj7UYDDeI/kP1+m/rP3ueyGqqOgR8xtilEo1cV
 HE/qfzwBupfrtc+3Q6pPhN31VbIyLrlyp+ieCNelVbmbFWZSnlK8Sb0HuQujYEd7KI
 1X0APx+LYDdGecNOUM57OxsB/oSGVfB1Blo2wxB0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 01/13] char-socket: tcp_chr_recv(): drop extra _set_(block,
 cloexec)
Date: Mon, 15 Sep 2025 16:21:58 +0300
Message-ID: <20250915132211.135095-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915132211.135095-1-vsementsov@yandex-team.ru>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qio_channel_readv_full() guarantees BLOCKING and CLOEXEC states for
incoming descriptors, no reason to call extra ioctls.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1e8313915b..b1ce5d01c7 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -307,20 +307,6 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
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
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
         errno = EAGAIN;
         ret = -1;
-- 
2.48.1


