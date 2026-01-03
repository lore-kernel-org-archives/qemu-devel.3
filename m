Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DCAFC6175
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 15:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc3dH-0004py-Nh; Sat, 03 Jan 2026 10:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1vc3dA-0004oy-Bj
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 10:33:29 -0500
Received: from woodpecker.gentoo.org ([140.211.166.183] helo=smtp.gentoo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1vc3d8-0002yg-PO
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 10:33:28 -0500
Received: from noumea.fritz.box
 (p200300e5cf308a00a98854cc6072a531.dip0.t-ipconnect.de
 [IPv6:2003:e5:cf30:8a00:a988:54cc:6072:a531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dilfridge@gentoo.org)
 by smtp.gentoo.org (Postfix) with ESMTPSA id E26EA341710;
 Sat, 03 Jan 2026 15:33:24 +0000 (UTC)
From: =?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
To: qemu-devel@nongnu.org
Cc: Luca Bonissi <qemu@bonslack.org>
Subject: [PATCH 6/8] Add termios2 support to sparc target
Date: Sat,  3 Jan 2026 16:25:37 +0100
Message-ID: <20260103153239.15787-7-dilfridge@gentoo.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260103153239.15787-1-dilfridge@gentoo.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.211.166.183;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Luca Bonissi <qemu@bonslack.org>

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
Link: https://lore.kernel.org/qemu-devel/909d9d68-c6fe-4368-825c-6aa8fdbd3bbc@bonslack.org
---
 linux-user/sparc/termbits.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

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
2.52.0


