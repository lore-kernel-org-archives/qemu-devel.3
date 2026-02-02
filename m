Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A9DE7FDDE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn16F-0004Bb-1N; Mon, 02 Feb 2026 16:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn16D-000425-4U; Mon, 02 Feb 2026 16:04:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn16B-0004vY-Fz; Mon, 02 Feb 2026 16:04:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 97E721851CB;
 Mon, 02 Feb 2026 23:57:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 61B7F35B342;
 Mon, 02 Feb 2026 23:58:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luca Bonissi <qemu@bonslack.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 63/74] linux-user: Add termios2 support to sh4 target
Date: Mon,  2 Feb 2026 23:58:14 +0300
Message-ID: <20260202205833.941615-63-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
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

From: Luca Bonissi <qemu@bonslack.org>

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
Link: https://lore.kernel.org/qemu-devel/642b32de-2985-45d2-bbdf-c0b2e3ea0551@bonslack.org
Reviewed-by: Helge Deller <deller@gmx.de>
(cherry picked from commit afbe0ff81c29d674b9c18a588bcaab34ddcb8a7b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index 28e79f2c9a..cab6b1299e 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -18,6 +18,28 @@ struct target_termios {
     target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+struct target_termios2 {
+    target_tcflag_t c_iflag;       /* input mode flags */
+    target_tcflag_t c_oflag;       /* output mode flags */
+    target_tcflag_t c_cflag;       /* control mode flags */
+    target_tcflag_t c_lflag;       /* local mode flags */
+    target_cc_t c_line;            /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS]; /* control characters */
+    target_speed_t c_ispeed;       /* input speed */
+    target_speed_t c_ospeed;       /* output speed */
+};
+
+struct target_ktermios {
+    target_tcflag_t c_iflag;       /* input mode flags */
+    target_tcflag_t c_oflag;       /* output mode flags */
+    target_tcflag_t c_cflag;       /* control mode flags */
+    target_tcflag_t c_lflag;       /* local mode flags */
+    target_cc_t c_line;            /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS]; /* control characters */
+    target_speed_t c_ispeed;       /* input speed */
+    target_speed_t c_ospeed;       /* output speed */
+};
+
 
 /* c_cc characters */
 #define TARGET_VINTR 0
@@ -251,14 +273,17 @@ struct target_termios {
 #define TARGET_TIOCNOTTY       TARGET_IO('T', 34) /* 0x5422 */
 #define TARGET_TIOCSETD        TARGET_IOW('T', 35, int) /* 0x5423 */
 #define TARGET_TIOCGETD        TARGET_IOR('T', 36, int) /* 0x5424 */
-#define TARGET_TCSBRKP         TARGET_IOW('T', 37, int) /* 0x5425 */ /* Needed for POSIX tcse
-ndbreak() */
+#define TARGET_TCSBRKP         TARGET_IOW('T', 37, int) /* 0x5425 */ /* Needed for POSIX tcsendbreak() */
 #define TARGET_TIOCSBRK        TARGET_IO('T', 39) /* 0x5427 */ /* BSD compatibility */
 #define TARGET_TIOCCBRK        TARGET_IO('T', 40) /* 0x5428 */ /* BSD compatibility */
-#define TARGET_TIOCGSID        TARGET_IOR('T', 41, pid_t) /* 0x5429 */ /* Return the session
-ID of FD */
-#define TARGET_TIOCGPTN        TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-m
-ux device) */
+#define TARGET_TIOCGSID        TARGET_IOR('T', 41, pid_t) /* 0x5429 */ /* Return the session ID of FD */
+#define TARGET_TCGETS2         TARGET_IOR('T', 0x2A, struct target_termios2)
+#define TARGET_TCSETS2         TARGET_IOW('T', 0x2B, struct target_termios2)
+#define TARGET_TCSETSW2        TARGET_IOW('T', 0x2C, struct target_termios2)
+#define TARGET_TCSETSF2        TARGET_IOW('T', 0x2D, struct target_termios2)
+#define TARGET_TIOCGRS485      TARGET_IOR('T', 0x2E, struct serial_rs485)
+#define TARGET_TIOCSRS485      TARGET_IOWR('T', 0x2F, struct serial_rs485)
+#define TARGET_TIOCGPTN        TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK      TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TARGET_TIOCGPTPEER     TARGET_IO('T', 0x41) /* Safely open the slave */
 
@@ -270,8 +295,7 @@ ux device) */
 #define TARGET_TIOCSLCKTRMIOS  0x5457
 #define TARGET_TIOCSERGSTRUCT  TARGET_IOR('T', 88, int) /* 0x5458 */ /* For d
 ebugging only */
-#define TARGET_TIOCSERGETLSR   TARGET_IOR('T', 89, unsigned int) /* 0x5459 */ /* Get line sta
-tus register */
+#define TARGET_TIOCSERGETLSR   TARGET_IOR('T', 89, unsigned int) /* 0x5459 */ /* Get line status register */
   /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 # define TARGET_TIOCSER_TEMT   0x01   /* Transmitter physically empty */
 #define TARGET_TIOCSERGETMULTI TARGET_IOR('T', 90, int) /* 0x545A
@@ -279,9 +303,7 @@ tus register */
 #define TARGET_TIOCSERSETMULTI TARGET_IOW('T', 91, int) /* 0x545B
 */ /* Set multiport config */
 
-#define TARGET_TIOCMIWAIT      TARGET_IO('T', 92) /* 0x545C */       /* wait for a change on
-serial input line(s) */
-#define TARGET_TIOCGICOUNT     TARGET_IOR('T', 93, int) /* 0x545D */ /* read
-serial port inline interrupt counts */
+#define TARGET_TIOCMIWAIT      TARGET_IO('T', 92) /* 0x545C */       /* wait for a change on serial input line(s) */
+#define TARGET_TIOCGICOUNT     TARGET_IOR('T', 93, int) /* 0x545D */ /* read serial port inline interrupt counts */
 
 #endif
-- 
2.47.3


