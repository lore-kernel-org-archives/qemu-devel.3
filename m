Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39521D778B0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 20:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjO97-0000SP-Hn; Fri, 23 Jan 2026 15:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO96-0000Ri-9d
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:44 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO94-0006y8-Ly
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:44 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B954A600C4;
 Fri, 23 Jan 2026 20:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C2AC4CEF1;
 Fri, 23 Jan 2026 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769201561;
 bh=2DPbdaJU6UDf5C6vyomBjWuc5uRYEy2/lrhRQR3D+Ak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WBfdzgxfeORGhV7P6Xo/y78mz+KPWlfW6pLDBSbVIZYJfecykTx0poBEwkh10/1ZV
 tTPKIwdFr4lVFOZPt5qoiKxb7LATbEe5pJhyJRtSKi4ArYK8bC8OIyJPw1LAzaLj1w
 FbKeeuwbCZr95T8sthqWaCNOLGyJwCEZdUaYb3U+1Aoav71bVnKe552ze3A1DKJwVD
 aonWs5ENQPnoJZwpF4W5Jk15SLz1hRgazB+rdfYI/2ih2s5xEFY78SQ/x8vGmlQOGk
 sQ/UvReRhaOO6sQG9JwT3Z4dK0SdnZ2+exYEStkFGnVVhelgGImw5bBDePa0GaTdu3
 kVkvbvM7itjBQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/11] linux-user: Add termios2 support to hppa target
Date: Fri, 23 Jan 2026 21:52:23 +0100
Message-ID: <20260123205230.33541-5-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123205230.33541-1-deller@kernel.org>
References: <20260123205230.33541-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 linux-user/hppa/termbits.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

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
2.52.0


