Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D2ECAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 19:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyEvo-0001sC-3g; Mon, 15 Sep 2025 15:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEvK-0001jB-8x; Mon, 15 Sep 2025 15:31:39 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEv6-0001tj-PN; Mon, 15 Sep 2025 15:31:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6B2D78099F;
 Mon, 15 Sep 2025 22:31:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:184::1:6])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AVVVql1FrOs0-2fR8Dfoi; Mon, 15 Sep 2025 22:31:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757964673;
 bh=wsoWvxGRkjhfwaoMYAfFW+x0chbESno/XD13mprGv/0=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=woAgGvQKjU+r3q8R4+1Cr3ehaGK5fpZnkQlddtyyMTd5Ktcgq7NOklYPJfqNO8R/t
 XCbhKj/zzm1eRJHBi1RBI3Tkx8st3MtvPCiZ8INd12zKZRNG3T0hjw00yOZvKtTmIF
 PSl6nEPm8zQfk7+VEjaQy+oaN3BI5qh6ZDl4i3nA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 01/12] char-socket: tcp_chr_recv(): drop extra _set_(block,
 cloexec)
Date: Mon, 15 Sep 2025 22:30:53 +0300
Message-ID: <20250915193105.230085-2-vsementsov@yandex-team.ru>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


