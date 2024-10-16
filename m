Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2A4D2A555
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AMr-0005FJ-C6; Wed, 16 Oct 2024 16:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AMd-00053b-2g; Wed, 16 Oct 2024 16:11:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AMb-0000kS-FA; Wed, 16 Oct 2024 16:11:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1182798FA1;
 Wed, 16 Oct 2024 23:10:11 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4460156381;
 Wed, 16 Oct 2024 23:10:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 47/49] ui/dbus: fix leak on message filtering
Date: Wed, 16 Oct 2024 23:10:06 +0300
Message-Id: <20241016201025.256294-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

A filter function that wants to drop a message should return NULL, in
which case it must also unref the message itself.

Fixes: fa88b85de ("ui/dbus: filter out pending messages when scanout")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-4-marcandre.lureau@redhat.com>
(cherry picked from commit 244d52ff736fefc3dd364ed091720aa896af306d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index a54123acea..434bd608f2 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -1001,6 +1001,7 @@ dbus_filter(GDBusConnection *connection,
     serial = g_dbus_message_get_serial(message);
     if (serial <= ddl->out_serial_to_discard) {
         trace_dbus_filter(serial, ddl->out_serial_to_discard);
+        g_object_unref(message);
         return NULL;
     }
 
-- 
2.39.5


