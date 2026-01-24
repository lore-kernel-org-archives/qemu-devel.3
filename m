Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50A6D715D9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 08:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjZOX-0001vv-7r; Sat, 24 Jan 2026 03:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOU-0001sa-99
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:22 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOS-0002Pn-BJ
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:21 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E808060018;
 Sat, 24 Jan 2026 08:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A6CC19422;
 Sat, 24 Jan 2026 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769244799;
 bh=NJv17dN8UjS2swj0/1r+JeA0+SCs4smJ1SvO5+Yv6R4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UYaGIkoXfvWyleQHgZyUXU7omsP6V3/o9nyY17fFPvGSGCeR8B+4Y3G7mRYLPg4Kw
 2rpsplFezqAaerV3vU3Cb/0sqaFpm1/xx4fWozE8cr7zXL9d4hNONRePHsGT4k+eEl
 RKLdTplrpSon60IJ7uaiYlLWge59/AHFj8cuzDsNGrLLe4h4HfecDnmYxoiHaPKIDu
 cIVSzhhddE1W4d4jo0ksBTV8Y7aL6GRTkhNpry+GEWLkLNRlweqs8wRwxyj5xFQxqh
 WHGFay/QoI16rbDLYlz63R8aMqNxmfF6TB3hU/D2GEAfOf6jRjmOrJZkC9GSqfABWm
 cRnayfAinPqCQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 05/11] linux-user: Add termios2 support to mips target
Date: Sat, 24 Jan 2026 09:53:00 +0100
Message-ID: <20260124085306.3996-6-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124085306.3996-1-deller@kernel.org>
References: <20260124085306.3996-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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
Link: https://lore.kernel.org/qemu-devel/361aa9c5-4464-4d27-8a2c-9ab767324530@bonslack.org
Reviewed-by: Helge Deller <deller@gmx.de>
---
 linux-user/mips/termbits.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index e8b4b58d87..27610f7c4d 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
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
@@ -227,10 +250,10 @@ struct target_termios {
 #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
 #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
 #define TARGET_TIOCGSID	0x7416  /* Return the session ID of FD */
-#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct termios2)
-#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct termios2)
-#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct termios2)
-#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct termios2)
+#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct target_termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct target_termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct target_termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct target_termios2)
 #define TARGET_TIOCGRS485       TARGET_IOR('T', 0x2E, struct serial_rs485)
 #define TARGET_TIOCSRS485       TARGET_IOWR('T', 0x2F, struct serial_rs485)
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
-- 
2.52.0


