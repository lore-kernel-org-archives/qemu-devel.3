Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2F3CF8872
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 07:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swytW-0001Fy-Uj; Sat, 05 Oct 2024 03:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1swytV-0001Fo-2S
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 03:08:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1swytT-0006d6-Bf
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 03:08:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C5279579B;
 Sat,  5 Oct 2024 10:07:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5FE6914DDB4;
 Sat,  5 Oct 2024 10:07:54 +0300 (MSK)
Received: (nullmailer pid 1328093 invoked by uid 1000);
 Sat, 05 Oct 2024 07:07:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] net/slirp: introduce slirp_os_socket to stay compatible with
 libslirp past 4.8.0
Date: Sat,  5 Oct 2024 10:07:53 +0300
Message-Id: <20241005070753.1328079-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

libslirp introduced new typedef after 4.8.0, slirp_os_socket, which
is defined to SOCKET on windows, which, in turn, is a 64bit number.
qemu uses int, so callback function prorotypes changed.  Introduce
slirp_os_socket locally if SLIRP_INVALID_SOCKET is not defined (this
define has been introduced together wiht slirp_os_socket type), for
libslirp <= 4.8.0, and use it in callback function definitions.

Link: https://gitlab.freedesktop.org/slirp/libslirp/-/commit/72f85005a2307fd0961543e3cea861ad7a4d201e
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2603
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 net/slirp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index eb9a456ed4..fa07268cf4 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -98,6 +98,10 @@ typedef struct SlirpState {
     GSList *fwd;
 } SlirpState;
 
+#ifndef SLIRP_INVALID_SOCKET /* after 4.8.0 */
+typedef int slirp_os_socket;
+#endif
+
 static struct slirp_config_str *slirp_configs;
 static QTAILQ_HEAD(, SlirpState) slirp_stacks =
     QTAILQ_HEAD_INITIALIZER(slirp_stacks);
@@ -247,7 +251,7 @@ static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
     timer_mod(&t->timer, expire_timer);
 }
 
-static void net_slirp_register_poll_fd(int fd, void *opaque)
+static void net_slirp_register_poll_fd(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
     AioContext *ctxt = qemu_get_aio_context();
@@ -260,7 +264,7 @@ static void net_slirp_register_poll_fd(int fd, void *opaque)
 #endif
 }
 
-static void net_slirp_unregister_poll_fd(int fd, void *opaque)
+static void net_slirp_unregister_poll_fd(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
     if (WSAEventSelect(fd, NULL, 0) != 0) {
@@ -314,7 +318,7 @@ static int slirp_poll_to_gio(int events)
     return ret;
 }
 
-static int net_slirp_add_poll(int fd, int events, void *opaque)
+static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
 {
     GArray *pollfds = opaque;
     GPollFD pfd = {
-- 
2.39.5


