Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09957C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lbP-0008Nd-U4; Wed, 16 Sep 2026 05:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lbO-0008N2-4H; Wed, 16 Sep 2026 05:06:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lbM-00071K-Ci; Wed, 16 Sep 2026 05:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=dNUYf1O8coHjm8GVvyg01qdESgJDFVLQ13nYIzbVYnI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=t/9JggIqHqy67LXMX/TF0ALMKp1t8Mq8C2eHPuEZwMZFGeEP026QVfd7dfeMDtOzD
 Cz4d1+eN/KVgTRLYHEz1gZ7fvkusKU+3pp+X//qdeCOD08aNoLaj/ZfZ7v8iGdvZhx
 ORV09BXyZlvwBQEan+DA+tMZCHy29G1JY8D8T9Q/OqU6dAw6zHjRMMcO9+AtsQYOd6
 NaL/iWVBWuFnWMsp56rs0XtVZ8LdjT1PfiVH8lgNL+LOOSaBb/e8W3xOOfLMTEu6zX
 RWMgPKMzUbtJIweNMYAs1g/b38z5ET8gxDxtELmX6nY6TiNvQhyFVLXKVn+WP51C+R
 fZH1XiVceyGEg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 79CF31D56B8;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 259B7429E00;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0C76C5A761; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 04/57] chardev: Don't unregister yank upon async path
 connection failure
Date: Wed, 16 Sep 2026 12:03:28 +0300
Message-ID: <20260916090516.677749-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Commit 5c102ac9 ("chardev: Consolidate yank registration") has moved
yank registration in the tcp_chr_connect_client_async() path to after
the connection is successful. If qio_channel_socket_connect_sync()
fails early, there will be no yank registered to be unregistered in
the error path, leading to assert.

Remove the now-extraneous unregister.

Cc: qemu-stable@nongnu.org
Fixes: 5c102ac9 ("chardev: Consolidate yank registration")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3528
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260603141137.1108963-1-farosas@suse.de>
(cherry picked from commit ddf5738503e2ba6adb74359abf3b6e7aa81af420)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e064b105c50..99e01a4875a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1128,11 +1128,6 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 
     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
-        if (s->registered_yank) {
-            yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
-                                     char_socket_yank_iochannel,
-                                     QIO_CHANNEL(sioc));
-        }
         check_report_connect_error(chr, err);
         goto cleanup;
     }
-- 
2.47.3


