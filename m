Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BA2FC6160
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 15:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc3dB-0004oz-Q6; Sat, 03 Jan 2026 10:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1vc3d7-0004mi-4K
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 10:33:25 -0500
Received: from mail.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]
 helo=smtp.gentoo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1vc3d5-0002ru-1S
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 10:33:24 -0500
Received: from noumea.fritz.box
 (p200300e5cf308a00a98854cc6072a531.dip0.t-ipconnect.de
 [IPv6:2003:e5:cf30:8a00:a988:54cc:6072:a531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dilfridge@gentoo.org)
 by smtp.gentoo.org (Postfix) with ESMTPSA id C573A341E6C;
 Sat, 03 Jan 2026 15:33:19 +0000 (UTC)
From: =?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
To: qemu-devel@nongnu.org
Cc: Luca Bonissi <qemu@bonslack.org>
Subject: [PATCH 2/8] Add termios2 support to alpha target
Date: Sat,  3 Jan 2026 16:25:33 +0100
Message-ID: <20260103153239.15787-3-dilfridge@gentoo.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260103153239.15787-1-dilfridge@gentoo.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:470:ea4a:1:5054:ff:fec7:86e4;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Link: https://lore.kernel.org/qemu-devel/02dba951-1bcf-4c74-8a6a-f4f4aa5ce909@bonslack.org
---
 linux-user/alpha/termbits.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index 4a4b1e96f2..b7be23ea13 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -17,6 +17,29 @@ struct target_termios {
 	target_speed_t c_ospeed;		/* output speed */
 };
 
+struct target_termios2 {
+	target_tcflag_t c_iflag;		/* input mode flags */
+	target_tcflag_t c_oflag;		/* output mode flags */
+	target_tcflag_t c_cflag;		/* control mode flags */
+	target_tcflag_t c_lflag;		/* local mode flags */
+	target_cc_t c_cc[TARGET_NCCS];		/* control characters */
+	target_cc_t c_line;			/* line discipline (== c_cc[19]) */
+	target_speed_t c_ispeed;		/* input speed */
+	target_speed_t c_ospeed;		/* output speed */
+};
+
+struct target_ktermios {
+	target_tcflag_t c_iflag;		/* input mode flags */
+	target_tcflag_t c_oflag;		/* output mode flags */
+	target_tcflag_t c_cflag;		/* control mode flags */
+	target_tcflag_t c_lflag;		/* local mode flags */
+	target_cc_t c_cc[TARGET_NCCS];		/* control characters */
+	target_cc_t c_line;			/* line discipline (== c_cc[19]) */
+	target_speed_t c_ispeed;		/* input speed */
+	target_speed_t c_ospeed;		/* output speed */
+};
+
+
 /* c_cc characters */
 #define TARGET_VEOF 0
 #define TARGET_VEOL 1
@@ -247,6 +270,12 @@ struct target_termios {
 #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
 #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TARGET_TCGETS2		TARGET_IOR('T', 0x2A, struct target_termios2)
+#define TARGET_TCSETS2		TARGET_IOW('T', 0x2B, struct target_termios2)
+#define TARGET_TCSETSW2	TARGET_IOW('T', 0x2C, struct target_termios2)
+#define TARGET_TCSETSF2	TARGET_IOW('T', 0x2D, struct target_termios2)
+#define TARGET_TIOCGRS485	TARGET_IOR('T', 0x2E, struct serial_rs485)
+#define TARGET_TIOCSRS485	TARGET_IOWR('T', 0x2F, struct serial_rs485)
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
-- 
2.52.0


