Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D27CCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 08:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwGX4-0001eo-UU; Wed, 10 Sep 2025 04:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uwGX3-0001ea-OV
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 04:50:25 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uwGWy-0002PB-MF
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 04:50:24 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5B33B807DF;
 Wed, 10 Sep 2025 11:50:16 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6bf:8080:d5b::1:32])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8oFbEc6Gm0U0-jwN6V2ir; Wed, 10 Sep 2025 11:50:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757494216;
 bh=QNPAI9/iKPu3p5pzEiqqurtjrk0S3jrcC5pY7aAVp4I=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=gcvriyb78EQK5lFtf639EnB9SLe2KTICBK32OISQOyEew6mS75TuCm31g1f+hPjUy
 7cKZvk77/v5dsAo7diZ6p1s86HSzRlq4K3zjAZpL5cCerGM7b37yftfoWjcoCQqpw5
 yVCd0okARW6DxewGpSZ98K0GKgEIORvaS/IBbfv4=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v1] io/channel-socket: abort socket reads after a force
 shutdown request
Date: Wed, 10 Sep 2025 11:50:06 +0300
Message-Id: <20250910085006.69790-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

When a user chooses to force shutdown QEMU by pressing ^C or sending a
SIGINT otherwise, we want to shutdown as soon as possible, and entering
a blocking read which happens in the main thread seems like the opposite
of that.

This may seem like a rare case, but it is actually not when using
vhost-user devices, which usually have the control plane working via
UNIX sockets.

The way the code is currently written, all vhost-user devices are
serviced in the main thread and thus block each other, as well as other
things that happen in the QEMU's main thread, including QMP, and even
network devices that are not vhost-net.

In case the vhost-user backend servicing a device decides to hang for
whatever reason, any control plane request in QEMU will also hang the
main loop until the backend either dies or ends up replying.

Ideally the vhost-user handling code should be rewritten to work
asynchronously, or to support io-threads or similar, but that seems like
a giant undertaking and we would like to at least be able to make QEMU
shutdown no matter if a vhost-user backend is currently able to service
the control plane or not.

Luckily for us, SIGINT or similar causes the kernel to cancel (almost)
all blocking syscalls with EINTR, which we can utilize to check whether
a shutdown was requested while we were blocked in the syscall, which is
what this commit does. The check is performed even on the first attempt,
not only retries after EINTR. This is intentional to avoid race
conditions where QEMU may decide to perform a control plane request
before the shutdown event is checked for thus forcing the user to send
SIGINT at least 2 times.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
v0 -> v1:
- Fix code alignment
- Fix included header
---
 io/channel-socket.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3b7ca924ff..74238b511a 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -26,10 +26,20 @@
 #include "io/channel-watch.h"
 #include "trace.h"
 #include "qapi/clone-visitor.h"
+#include "system/runstate.h"
 #ifdef CONFIG_LINUX
 #include <linux/errqueue.h>
 #include <sys/socket.h>
 
+/*
+ * This function is not available when io links against qemu-img etc.,
+ * in this case just pretend it always returns false.
+ */
+__attribute__((weak)) bool qemu_force_shutdown_requested(void)
+{
+    return false;
+}
+
 #if (defined(MSG_ZEROCOPY) && defined(SO_ZEROCOPY))
 #define QEMU_MSG_ZEROCOPY
 #endif
@@ -541,6 +551,12 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     }
 
  retry:
+    if (qemu_force_shutdown_requested()) {
+        error_setg_errno(errp, ECANCELED,
+                         "Socket read aborted due to force shutdown");
+        return -1;
+    }
+
     ret = recvmsg(sioc->fd, &msg, sflags);
     if (ret < 0) {
         if (errno == EAGAIN) {
-- 
2.34.1


