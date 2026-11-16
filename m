Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B5606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=HZFThudq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Cf-0008VD-6B; Mon, 16 Nov 2026 15:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3C6-0007wg-J0; Mon, 16 Nov 2026 15:20:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3C3-0001h9-Lo; Mon, 16 Nov 2026 15:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=T0TgWYW99xixJGfQZ4CT/0IAX37UCVvxeqPkLac/2JA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HZFThudq/Ti7aIQAs2g08l6z9WDNpR3Z11gca86oq6/dXQFneSXx5F7mD4JaGFT1r
 kDupM4xxFbnHkrjtrlwL5hi9IYkBV+WpHYtQ1pHj6jTBFtfM71RSv31HyQtOsz0mJa
 e2aPq57+42NMRBbBC4I1gwU686Xi728F89lA0XImOwwieT9ebOX7UXdDi/KYRXbwaW
 IM37Zx/Ysh0zwF6k2eWOEw/X9/b/uBVHWfdReu0OWQM6aQ9ECOcIb/JC1bLWtotHpD
 zfweJbWmhSo1aeAI8HCEmns+CRckv1HIKGNynpJjh1oqeYGhhMThu7ODV7wKvrjggN
 ictgoIaohYMsA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDEF71E7148;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BA67445FB7E;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 724A9B8DF2; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Oleksij Samorukov <samm@net-art.cz>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Roman Bogorodskiy <bogorodskiy@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 18/59] qga: set FreeBSD virtio-serial channel to raw
 mode
Date: Mon, 16 Nov 2026 23:18:22 +0300
Message-ID: <20261116201922.534306-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Oleksij Samorukov <samm@net-art.cz>

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
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Tested-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261017201905.12211-1-samm@net-art.cz
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit 03efcb7cfdef40ee3124a80b2609d800ec1df1db)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 465d688ecb8..e11b5795efc 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -151,9 +151,10 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
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
@@ -161,8 +162,19 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
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
2.47.3


