Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4911CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOKi-00049h-2e; Sat, 30 Aug 2025 12:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1usLVY-0002en-Q4
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 09:20:40 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1usLVX-0003ft-2y
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 09:20:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 1C03D24342E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1756560038;
 bh=SEZilLHq4QbqNQI+IiMOldiliACziPiHJF3zIYJJwGM=;
 h=Date:From:Subject:To:Cc;
 b=4jt6P4OEoIgnW63ioDJN/df1mZkrYkbgrRTlZy+M0Ux9n2qq0wwkLK56IqUKNDIMh
 O6sukMj+fxyZ5wusdAlDJwem7THT95TgZT7Lqy1zhfXYEnxiHQoW/9/cCQgH/gdT3z
 5t9xVgsKBH/mSJiKjqX5467Pb3LSMHNe0DOzKPkE=
Received: from [10.0.0.70] (ip190-129-198-217.pool-bba.aruba.it
 [217.198.129.190])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 1C03D24342E;
 Sat, 30 Aug 2025 15:20:38 +0200 (CEST)
Message-ID: <f058dae2-299b-49d0-8ae3-7f1b44a952f8@bonslack.org>
Date: Sat, 30 Aug 2025 15:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luca Bonissi <qemu@bonslack.org>
Subject: [PATCH 7/7] Add termios2 support to sparc target
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Content-Language: it
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From 982f2ab1346c2b89007521f57b10e57dded29274 Mon Sep 17 00:00:00 2001
From: Luca Bonissi <qemu@bonslack.org>
Date: Sat, 30 Aug 2025 14:52:56 +0200
Subject: [PATCH 7/7] Add termios2 support to sparc target

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
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
2.50.1



