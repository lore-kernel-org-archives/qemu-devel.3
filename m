Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63505E7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn16Z-00053u-MP; Mon, 02 Feb 2026 16:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn16X-00050a-IT; Mon, 02 Feb 2026 16:05:05 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn16V-0004vg-TV; Mon, 02 Feb 2026 16:05:05 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A53821851CC;
 Mon, 02 Feb 2026 23:57:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6F70635B343;
 Mon, 02 Feb 2026 23:58:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luca Bonissi <qemu@bonslack.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 64/74] linux-user: Add termios2 support to sparc target
Date: Mon,  2 Feb 2026 23:58:15 +0300
Message-ID: <20260202205833.941615-64-mjt@tls.msk.ru>
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
Link: https://lore.kernel.org/qemu-devel/909d9d68-c6fe-4368-825c-6aa8fdbd3bbc@bonslack.org
Reviewed-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 947b971cad90375040f399899909a3f1f32b483f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index 704bee1c42..588d7e8dcd 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
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
 #define TARGET_VINTR    0
@@ -251,6 +273,12 @@ struct target_termios {
 #define TARGET_TIOCGPGRP	TARGET_IOR('t', 131, int)
 #define TARGET_TIOCSCTTY	TARGET_IO('t', 132)
 #define TARGET_TIOCGSID	TARGET_IOR('t', 133, int)
+#define TARGET_TCGETS2		TARGET_IOR('T', 12, struct target_termios2)
+#define TARGET_TCSETS2		TARGET_IOW('T', 13, struct target_termios2)
+#define TARGET_TCSETSW2	TARGET_IOW('T', 14, struct target_termios2)
+#define TARGET_TCSETSF2	TARGET_IOW('T', 15, struct target_termios2)
+#define TARGET_TIOCGRS485	TARGET_IOR('T', 0x41, struct serial_rs485)
+#define TARGET_TIOCSRS485	TARGET_IOWR('T', 0x42, struct serial_rs485)
 /* Get minor device of a pty master's FD -- Solaris equiv is ISPTM */
 #define TARGET_TIOCGPTN	TARGET_IOR('t', 134, unsigned int) /* Get Pty Number */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('t', 135, int) /* Lock/unlock PTY */
-- 
2.47.3


