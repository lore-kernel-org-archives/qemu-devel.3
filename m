Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACE5D778B1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 20:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjO9D-0000Xu-QM; Fri, 23 Jan 2026 15:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO9C-0000WX-7C
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:50 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO9A-0006yr-DU
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:49 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 32F7E437CE;
 Fri, 23 Jan 2026 20:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BE7C4CEF1;
 Fri, 23 Jan 2026 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769201567;
 bh=IhcnnJG82vq62iLC9P9fOM/4G5vyl9jq7hkTC4Tm5U0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FiD6zTxsWOp6SIZoHn4Lb1Utc7zlJbJ0mBvsroy6P7idj1EpZmqgLnY7E2MvBHKJT
 NNgAvvvkva8Fjm+copHnMJHsEF+N4wTbJ7XMdexLq9lYQ8aEMyvVp8UKScVgHTbTIQ
 URbXJwIrSyNIiMhm7+YQJjJrpdW7C4bqAMWoKveOILf9H7YO2BzwwiY0yIn1oBhRW5
 i62Cmsq6RunmqEsdA25HHm5mJeEnIEW+ihtBq5UbZC0Gf1dBUkFdCvdP9dPOPykYWP
 pzLHJjreNbO4jRUa1ABpf1pDPz79Woa9HKmzdjBt0uEJO3OrjvIAhSTKifSoUYa6EM
 hQcXdOqxvhEhA==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/11] linux-user: Add termios2 support to sparc target
Date: Fri, 23 Jan 2026 21:52:26 +0100
Message-ID: <20260123205230.33541-8-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123205230.33541-1-deller@kernel.org>
References: <20260123205230.33541-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


