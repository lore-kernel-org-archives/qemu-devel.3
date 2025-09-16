Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7CFCAC59F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVWH-0005UA-H5; Tue, 16 Sep 2025 09:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVVk-0005L9-LF; Tue, 16 Sep 2025 09:14:20 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVVg-0006Y0-0g; Tue, 16 Sep 2025 09:14:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 97A69C024C;
 Tue, 16 Sep 2025 16:14:07 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5EQRob1Gj0U0-v85a1l34; Tue, 16 Sep 2025 16:14:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758028447;
 bh=wsoWvxGRkjhfwaoMYAfFW+x0chbESno/XD13mprGv/0=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=DD2dJG772MCy1AY90CLFjl7hn++eg3O7HWPoEy+gdpqunpS1AVNi10WDstJod+Pyj
 QXAuQORNMQvGFpCxivyD/6qRU93fPlKSRdgJGgfNE+vpAJ/lVyvMlhyrWY4gIZ232u
 Oc+3HK0MP/ShvrFmmtLiWP/+WB//dgvrpDYtTuc0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 01/13] char-socket: tcp_chr_recv(): drop extra _set_(block,
 cloexec)
Date: Tue, 16 Sep 2025 16:13:50 +0300
Message-ID: <20250916131403.368343-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916131403.368343-1-vsementsov@yandex-team.ru>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


