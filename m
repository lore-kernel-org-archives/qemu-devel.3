Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238FCCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEp8I-0002Ts-I3; Fri, 31 Oct 2025 09:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1vEp7y-0002Ql-Di
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:25:23 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1vEp7t-0004uK-5g
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:25:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it E95E32647C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1761917099;
 bh=2EATXud+1br7JAfpW8uN9ktKjGkS4/xBRQsAncWrqbI=;
 h=Date:From:Subject:To:Cc;
 b=W1Wqu7UVKJmSs/dpQEeXCBN23KpCItoT4nqfUoiPeW7r5sKc9xFdzlwjNH8LorPga
 NWF7CuxfIxRy7zr/anrNrgYIGiywpQ2jsGoeCKDvmlIZRU4Sca5HpSAsTBwKqlbV6I
 btCVOvwdyrlHUuHTef3uSFWhNEE7NBS41zChqTcQ=
Received: from [10.0.0.70] (dynamic-adsl-84-220-72-247.clienti.tiscali.it
 [84.220.72.247])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id E95E32647C7;
 Fri, 31 Oct 2025 14:24:58 +0100 (CET)
Message-ID: <ccf1be5c-9e2e-46f6-b303-d29888371fb0@bonslack.org>
Date: Fri, 31 Oct 2025 14:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luca Bonissi <qemu@bonslack.org>
Subject: [PATCH 3/7] Add termios2 support to hppa target
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

From 45577ce13cb67488065b84f30d51368e19c6c9f7 Mon Sep 17 00:00:00 2001
From: Luca Bonissi <qemu@bonslack.org>
Date: Fri, 31 Oct 2025 13:30:48 +0100
Subject: [PATCH 3/7] Add termios2 support to hppa target

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
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
2.50.1


