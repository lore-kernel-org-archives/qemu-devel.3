Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62025E7FDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn29h-0007Ys-Ig; Mon, 02 Feb 2026 17:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn297-0006D3-Om; Mon, 02 Feb 2026 17:11:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn296-0003MM-1X; Mon, 02 Feb 2026 17:11:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 229291852D7;
 Tue, 03 Feb 2026 01:07:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0199335B3EA;
 Tue, 03 Feb 2026 01:08:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luca Bonissi <qemu@bonslack.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 42/56] linux-user: Add termios2 support to hppa target
Date: Tue,  3 Feb 2026 01:07:47 +0300
Message-ID: <20260202220805.945271-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
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
Link: https://lore.kernel.org/qemu-devel/ccf1be5c-9e2e-46f6-b303-d29888371fb0@bonslack.org
Reviewed-by: Helge Deller <deller@gmx.de>
(cherry picked from commit edc741710acedd61011f937967b960d154794258)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index 11fd4eed62..645f17bf63 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -18,6 +18,29 @@ struct target_termios {
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
+
 /* c_iflag bits */
 #define TARGET_IGNBRK  0000001
 #define TARGET_BRKINT  0000002
@@ -190,6 +213,12 @@ struct target_termios {
 #define TARGET_TIOCSBRK         0x5427 /* BSD compatibility */
 #define TARGET_TIOCCBRK         0x5428 /* BSD compatibility */
 #define TARGET_TIOCGSID         TARGET_IOR('T', 20, int)
+#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct target_termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct target_termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct target_termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct target_termios2)
+#define TARGET_TIOCGRS485       TARGET_IOR('T', 0x2E, struct serial_rs485)
+#define TARGET_TIOCSRS485       TARGET_IOWR('T', 0x2F, struct serial_rs485)
 #define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
         /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
-- 
2.47.3


