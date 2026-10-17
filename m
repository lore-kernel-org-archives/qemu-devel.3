Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CAECCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIAuK-0003TA-FH; Sat, 17 Oct 2026 16:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samm@net-art.cz>)
 id 1xIAsE-000342-LV; Sat, 17 Oct 2026 16:19:22 -0400
Received: from reindeer.net-art.cz ([2001:1468:9000:1:1::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samm@net-art.cz>)
 id 1xIAsC-0003BK-8r; Sat, 17 Oct 2026 16:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=net-art.cz;
 s=netart; t=1792268353;
 bh=4nouQlyc+S6Tkqh6tsjVaAC+KhJ5UR7bGIHH+i2voPc=;
 h=From:To:Cc:Subject:Date;
 b=JD45cU1BCj+5VOdqMIxL4VM4c3GZrTVzeimU3anLiEOm8+jAIp+Pp1wtPwA1i1HT/
 986yzHMcFlAEo3MkehVFq5yA+nCueEKHyC4kFtkHKzaRK15c2pHVUFe8xyUsu9Hxcl
 MFGOduQwO1bfaSEMP9t+wysLZKGcXKlDx7jW7r1y+iudqwOZc7c9bfVdLpFL9vFSTu
 8Vem/ZYtl/nTblVBczqztkVx7naIUpm31GMHr86UTMTmo2NZ05eChVbR4OvQi2W+LS
 32MqFaoCt3xfOBn1pdCkr9VH3oYNSFEMRYJQpyXi0DqqFpoO6flOxR58oAfIMiHT1Z
 Lv3o6yJl00UMg==
Received: by reindeer.net-art.cz (Postfix, from userid 65534)
 id 323CA3F0B0; Sat, 17 Oct 2026 20:19:13 +0000 (UTC)
Received: from owl.net-art.cz (owl.net-art.cz [IPv6:2a03:6920:0:10::101])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "owl.net-art.cz", Issuer "YR2" (not verified))
 by reindeer.net-art.cz (Postfix) with ESMTPS id BDB2D3F04F;
 Sat, 17 Oct 2026 20:19:12 +0000 (UTC)
Received: from [185.71.233.107] (account samm@net-art.cz HELO
 localhost.localdomain)
 by owl.net-art.cz (CommuniGate Pro SMTP 6.1.20)
 with ESMTPSA id 3724075; Sat, 17 Oct 2026 22:19:12 +0200
From: Oleksij Samorukov <samm@net-art.cz>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Alex Samorukov <samm@net-art.cz>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-stable@nongnu.org
Subject: [PATCH] qga: set FreeBSD virtio-serial channel to raw mode
Date: Sat, 17 Oct 2026 22:19:05 +0200
Message-ID: <20261017201905.12211-1-samm@net-art.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:1468:9000:1:1::15;
 envelope-from=samm@net-art.cz; helo=reindeer.net-art.cz
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 17 Oct 2026 16:21:26 -0400
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

On FreeBSD the virtio-console port is a tty, unlike Linux's
/dev/virtio-ports which is a character device.  It defaults to canonical
mode with echo and software flow control enabled, so the QGA stream
protocol does not work: the initial guest-sync handshake is held in the
line discipline and the host eventually times out.

The existing FreeBSD-specific code only clears ECHO.  Configure the port
the same way as the ISA serial path: disable canonical mode, echo and
software flow control, and set VMIN/VTIME.  Use TCSANOW instead of
TCSAFLUSH so a handshake that arrives between open() and tcsetattr() is
not discarded.

Tested on FreeBSD 15.1 aarch64 under UTM/QEMU.  Before the change
utmctl ip-address timed out and the guest received zero bytes; after the
change QGA commands and guest-set-time work.

Cc: qemu-stable@nongnu.org
Fixes: c6cd588bb3a29a831c862780631a7d2145ade5de ("qga: Add initial FreeBSD support")
Signed-off-by: Oleksij Samorukov <samm@net-art.cz>
---
 qga/channel-posix.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 9ccc8b7..c6dfb2d 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -156,9 +156,10 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
 #endif
 #ifdef __FreeBSD__
         /*
-         * In the default state channel sends echo of every command to a
-         * client. The client program doesn't expect this and raises an
-         * error. Suppress echo by resetting ECHO terminal flag.
+         * FreeBSD's virtio-console port is a tty (unlike Linux's
+         * /dev/virtio-ports, which is a character device) and defaults to
+         * canonical mode with echo and software flow control enabled.
+         * QGA uses a raw stream protocol, so put the port in raw mode.
          */
         struct termios tio;
         if (tcgetattr(fd, &tio) < 0) {
@@ -166,8 +167,19 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
             close(fd);
             return false;
         }
-        tio.c_lflag &= ~ECHO;
-        if (tcsetattr(fd, TCSAFLUSH, &tio) < 0) {
+        tio.c_iflag &= ~(IGNBRK | BRKINT | IGNPAR | PARMRK | INPCK | ISTRIP |
+                         INLCR | IGNCR | ICRNL | IXON | IXOFF | IXANY |
+                         IMAXBEL);
+        tio.c_oflag = 0;
+        tio.c_lflag = 0;
+        tio.c_cflag |= CLOCAL | CREAD;
+        tio.c_cc[VMIN] = 1;
+        tio.c_cc[VTIME] = 0;
+        /*
+         * Use TCSANOW rather than TCSAFLUSH: the host may already have sent
+         * the initial handshake between open() and tcsetattr().
+         */
+        if (tcsetattr(fd, TCSANOW, &tio) < 0) {
             error_setg_errno(errp, errno, "error setting channel termios attrs");
             close(fd);
             return false;
-- 
2.54.0 (Apple Git-157)


