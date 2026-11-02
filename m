Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1D606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S7WNvmwH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqf1-000830-TI; Mon, 02 Nov 2026 06:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xNqf0-00082L-7j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:57:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xNqey-0006Em-9c
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793620627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqDVAsbNVNJZ2Pk/cx5KIpuyUFjIk/4UyDlpFBTAQTE=;
 b=S7WNvmwHfvN1zeY0j+f+JbvsI4QLvWvIVk/ml8q3WflHWc4kfyb+Zy4U+JUMr1j3CoL8Jx
 urPnytYlw0tlFtix6xvRMG5O8/XVIO+7guIYFPAMGI3M/BBAzX/YE4dVFv3/8c6gajEO20
 zsGTYgtdvSesiuZMcCKCb32T1ZzTNbw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-c1fOdQcbNvya5K9Y8xfL2g-1; Mon,
 02 Nov 2026 06:57:04 -0500
X-MC-Unique: c1fOdQcbNvya5K9Y8xfL2g-1
X-Mimecast-MFC-AGG-ID: c1fOdQcbNvya5K9Y8xfL2g_1793620623
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBA5C1955BC6; Mon,  2 Nov 2026 11:57:02 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B305818002B7; Mon,  2 Nov 2026 11:57:01 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/1] qga: set FreeBSD virtio-serial channel to raw mode
Date: Mon,  2 Nov 2026 13:56:56 +0200
Message-ID: <20261102115657.89700-2-kkostiuk@redhat.com>
In-Reply-To: <20261102115657.89700-1-kkostiuk@redhat.com>
References: <20261102115657.89700-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
---
 qga/channel-posix.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 9ccc8b7bd1..c6dfb2df63 100644
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


