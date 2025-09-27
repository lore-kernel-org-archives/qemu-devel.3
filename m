Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DF2CAC5BD
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Qqo-00045z-OV; Sat, 27 Sep 2025 05:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qqi-000454-V5; Sat, 27 Sep 2025 05:04:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qqe-0006rO-EV; Sat, 27 Sep 2025 05:04:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5BE05158559;
 Sat, 27 Sep 2025 12:03:02 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3AC8E291576;
 Sat, 27 Sep 2025 12:03:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yuxue Liu <yuxue.liu@jaguarmicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 04/16] vhost-user-test: no set non-blocking for cal fd
 less than 0.
Date: Sat, 27 Sep 2025 12:02:48 +0300
Message-ID: <20250927090304.2901324-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
References: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

In the scenario where vhost-user sets eventfd to -1,
qemu_chr_fe_get_msgfds retrieves fd as -1. When vhost_user_read
receives, it does not perform blocking operations on the descriptor
with fd=-1, so non-blocking operations should not be performed here
either.This is a normal use case. Calling g_unix_set_fd_nonblocking
at this point will cause the test to interrupt.

When vhost_user_write sets the call fd to -1, it sets the number of
fds to 0, so the fds obtained by qemu_chr_fe_get_msgfds will also
be 0.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Message-Id: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit f72fc16910c8f44edf052f52672e0e63bbbc773c)
(Mjt: pick this trivial focused change up for 7.2.x so that subsequent change(s) in this area apply cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index e4f95b2858..6d9e53ff07 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -456,7 +456,10 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_KICK:
     case VHOST_USER_SET_VRING_CALL:
         /* consume the fd */
-        qemu_chr_fe_get_msgfds(chr, &fd, 1);
+        if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
+            qos_printf("call fd: %d, do not set non-blocking\n", fd);
+            break;
+        }
         /*
          * This is a non-blocking eventfd.
          * The receive function forces it to be blocking,
-- 
2.47.3


