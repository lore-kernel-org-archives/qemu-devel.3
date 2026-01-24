Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A08D715D6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 08:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjZOb-00020R-LA; Sat, 24 Jan 2026 03:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOa-0001yx-3B
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:28 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOY-0002Rp-60
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:27 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B84260018;
 Sat, 24 Jan 2026 08:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF96BC116D0;
 Sat, 24 Jan 2026 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769244805;
 bh=QCwGGotsfawej6sv67GPxBRWy67+eMcA3Dy0OptWceE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OAmBq5nyL+5I3Q8+Qo/2IxOlCnZtHfEQEwsjtMvE6VNsbb//ar+fxlZEJxK0kOyqF
 BN+iOGQRDRH5LW6lThM/3MQQc1X+Kb/tOwK6h7DICNAUYGrcv9esyKL4UDUHll9buq
 dZWdj3JfL2RxCuwE5E7pslKDNuPIVUb4qyD/uG9Rvnbv+gJzW/Y17x1oBkX1jRr3+U
 JGti7jbShXWBLOiv2JDu3Fzotr38G53hmtARc3Uk1WBZVomBiLXWBVJE8vVS19QrMe
 OTWlaIMFVMS5UbGxVpkkefwaAnu+fOnsYhP1qFVAUfBcMPLUefNIQESvROwfyzJJNI
 9kE96OXkjifag==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 08/11] linux-user: Add missing termios baud rates
Date: Sat, 24 Jan 2026 09:53:03 +0100
Message-ID: <20260124085306.3996-9-deller@kernel.org>
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

From: Vivian Wang <wangruikang@iscas.ac.cn>

Add several missing baud rates and inputs baud rates in cflag_tbl.

Add these missing definitions in termbits.h:

- TARGET_BOTHER for alpha, hppa, ppc, sh4, sparc
- TARGET_IBSHIFT for hppa, mips, ppc, sh4, sparc
- Missing standard baud rates for hppa

These are required for the glibc test tst-termios-linux.

Link: https://lore.kernel.org/qemu-devel/20251203-linux-user-higher-baud-rates-v2-1-e45b35224437@iscas.ac.cn
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 linux-user/alpha/termbits.h   |  1 +
 linux-user/generic/termbits.h |  2 +-
 linux-user/hppa/termbits.h    | 16 ++++++-
 linux-user/mips/termbits.h    |  4 +-
 linux-user/ppc/termbits.h     |  1 +
 linux-user/sh4/termbits.h     |  5 ++-
 linux-user/sparc/termbits.h   |  5 ++-
 linux-user/syscall.c          | 83 ++++++++++++++++++++++++++---------
 8 files changed, 92 insertions(+), 25 deletions(-)

diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index b7be23ea13..50cff34f3c 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -149,6 +149,7 @@ struct target_ktermios {
 #define TARGET_B3000000  00034
 #define TARGET_B3500000  00035
 #define TARGET_B4000000  00036
+#define TARGET_BOTHER    00037
 
 #define TARGET_CSIZE	00001400
 #define   TARGET_CS5	00000000
diff --git a/linux-user/generic/termbits.h b/linux-user/generic/termbits.h
index 6675e0d1ab..6cc5995981 100644
--- a/linux-user/generic/termbits.h
+++ b/linux-user/generic/termbits.h
@@ -157,7 +157,7 @@ struct target_ktermios {
 #define  TARGET_B3000000  0010015
 #define  TARGET_B3500000  0010016
 #define  TARGET_B4000000  0010017
-#define TARGET_CIBAUD     002003600000  /* input baud rate (not used) */
+#define TARGET_CIBAUD     002003600000  /* input baud rate */
 #define TARGET_CMSPAR     010000000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS    020000000000  /* flow control */
 
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index 645f17bf63..9d1d1a1d12 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -123,14 +123,28 @@ struct target_ktermios {
 #define TARGET_HUPCL   0002000
 #define TARGET_CLOCAL  0004000
 #define TARGET_CBAUDEX 0010000
+#define  TARGET_BOTHER  0010000
 #define  TARGET_B57600  0010001
 #define  TARGET_B115200 0010002
 #define  TARGET_B230400 0010003
 #define  TARGET_B460800 0010004
-#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
+#define  TARGET_B500000 0010005
+#define  TARGET_B576000 0010006
+#define  TARGET_B921600 0010007
+#define  TARGET_B1000000 0010010
+#define  TARGET_B1152000 0010011
+#define  TARGET_B1500000 0010012
+#define  TARGET_B2000000 0010013
+#define  TARGET_B2500000 0010014
+#define  TARGET_B3000000 0010015
+#define  TARGET_B3500000 0010016
+#define  TARGET_B4000000 0010017
+#define TARGET_CIBAUD    002003600000  /* input baud rate */
 #define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS   020000000000  /* flow control */
 
+#define TARGET_IBSHIFT   16            /* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define TARGET_ISIG    0000001
 #define TARGET_ICANON  0000002
diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index 27610f7c4d..56b17441ee 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -139,10 +139,12 @@ struct target_ktermios {
 #define  TARGET_B3000000 0010015
 #define  TARGET_B3500000 0010016
 #define  TARGET_B4000000 0010017
-#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
+#define TARGET_CIBAUD    002003600000  /* input baud rate */
 #define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS   020000000000  /* flow control */
 
+#define TARGET_IBSHIFT   16            /* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define TARGET_ISIG    0000001
 #define TARGET_ICANON  0000002
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index eb226e0999..71b398c83a 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -129,6 +129,7 @@ struct target_termios {
 #define TARGET_B3000000  00034
 #define TARGET_B3500000  00035
 #define TARGET_B4000000  00036
+#define TARGET_BOTHER    00037
 
 #define TARGET_CSIZE	00001400
 #define   TARGET_CS5	00000000
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index cab6b1299e..861f861f6d 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -142,6 +142,7 @@ struct target_ktermios {
 #define TARGET_HUPCL   0002000
 #define TARGET_CLOCAL  0004000
 #define TARGET_CBAUDEX 0010000
+#define TARGET_BOTHER 0010000
 #define TARGET_B57600 0010001
 #define TARGET_B115200 0010002
 #define TARGET_B230400 0010003
@@ -157,10 +158,12 @@ struct target_ktermios {
 #define TARGET_B3000000 0010015
 #define TARGET_B3500000 0010016
 #define TARGET_B4000000 0010017
-#define TARGET_CIBAUD    002003600000 /* input baud rate (not used) */
+#define TARGET_CIBAUD    002003600000 /* input baud rate */
 #define TARGET_CMSPAR    010000000000 /* mark or space (stick) parity */
 #define TARGET_CRTSCTS   020000000000 /* flow control */
 
+#define TARGET_IBSHIFT   16           /* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define TARGET_ISIG     0000001
 #define TARGET_ICANON   0000002
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index 588d7e8dcd..f64ea87d97 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
@@ -150,6 +150,7 @@ struct target_ktermios {
 #define TARGET_HUPCL	  0x00000400
 #define TARGET_CLOCAL	  0x00000800
 #define TARGET_CBAUDEX   0x00001000
+#define  TARGET_BOTHER   0x00001000
 /* We'll never see these speeds with the Zilogs, but for completeness... */
 #define  TARGET_B57600   0x00001001
 #define  TARGET_B115200  0x00001002
@@ -176,10 +177,12 @@ struct target_ktermios {
 #define B3000000  0x00001011
 #define B3500000  0x00001012
 #define B4000000  0x00001013  */
-#define TARGET_CIBAUD	  0x100f0000  /* input baud rate (not used) */
+#define TARGET_CIBAUD	  0x100f0000  /* input baud rate */
 #define TARGET_CMSPAR	  0x40000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS	  0x80000000  /* flow control */
 
+#define TARGET_IBSHIFT	  16          /* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define TARGET_ISIG	0x00000001
 #define TARGET_ICANON	0x00000002
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d80d3ded7b..9443eb3a17 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5762,27 +5762,70 @@ static const bitmask_transtbl oflag_tbl[] = {
 	{ TARGET_FFDLY, TARGET_FF1, FFDLY, FF1 },
 };
 
+#if defined(TARGET_CIBAUD) && defined(CIBAUD)
+
+# define BAUD_TRANSTBL(baud) \
+    { TARGET_CBAUD, TARGET_##baud, CBAUD, baud }, \
+    { TARGET_CIBAUD, TARGET_##baud << TARGET_IBSHIFT, CIBAUD, baud << IBSHIFT },
+
+#else
+
+/* Alpha in particular does not have CIBAUD/IBSHIFT */
+
+# define BAUD_TRANSTBL(baud) \
+    { TARGET_CBAUD, TARGET_##baud, CBAUD, baud },
+
+#endif
+
 static const bitmask_transtbl cflag_tbl[] = {
-	{ TARGET_CBAUD, TARGET_B0, CBAUD, B0 },
-	{ TARGET_CBAUD, TARGET_B50, CBAUD, B50 },
-	{ TARGET_CBAUD, TARGET_B75, CBAUD, B75 },
-	{ TARGET_CBAUD, TARGET_B110, CBAUD, B110 },
-	{ TARGET_CBAUD, TARGET_B134, CBAUD, B134 },
-	{ TARGET_CBAUD, TARGET_B150, CBAUD, B150 },
-	{ TARGET_CBAUD, TARGET_B200, CBAUD, B200 },
-	{ TARGET_CBAUD, TARGET_B300, CBAUD, B300 },
-	{ TARGET_CBAUD, TARGET_B600, CBAUD, B600 },
-	{ TARGET_CBAUD, TARGET_B1200, CBAUD, B1200 },
-	{ TARGET_CBAUD, TARGET_B1800, CBAUD, B1800 },
-	{ TARGET_CBAUD, TARGET_B2400, CBAUD, B2400 },
-	{ TARGET_CBAUD, TARGET_B4800, CBAUD, B4800 },
-	{ TARGET_CBAUD, TARGET_B9600, CBAUD, B9600 },
-	{ TARGET_CBAUD, TARGET_B19200, CBAUD, B19200 },
-	{ TARGET_CBAUD, TARGET_B38400, CBAUD, B38400 },
-	{ TARGET_CBAUD, TARGET_B57600, CBAUD, B57600 },
-	{ TARGET_CBAUD, TARGET_B115200, CBAUD, B115200 },
-	{ TARGET_CBAUD, TARGET_B230400, CBAUD, B230400 },
-	{ TARGET_CBAUD, TARGET_B460800, CBAUD, B460800 },
+	BAUD_TRANSTBL(B0)
+	BAUD_TRANSTBL(B50)
+	BAUD_TRANSTBL(B75)
+	BAUD_TRANSTBL(B110)
+	BAUD_TRANSTBL(B134)
+	BAUD_TRANSTBL(B150)
+	BAUD_TRANSTBL(B200)
+	BAUD_TRANSTBL(B300)
+	BAUD_TRANSTBL(B600)
+	BAUD_TRANSTBL(B1200)
+	BAUD_TRANSTBL(B1800)
+	BAUD_TRANSTBL(B2400)
+	BAUD_TRANSTBL(B4800)
+	BAUD_TRANSTBL(B9600)
+	BAUD_TRANSTBL(B19200)
+	BAUD_TRANSTBL(B38400)
+	BAUD_TRANSTBL(B57600)
+	BAUD_TRANSTBL(B115200)
+	BAUD_TRANSTBL(B230400)
+	BAUD_TRANSTBL(B460800)
+	BAUD_TRANSTBL(B500000)
+	BAUD_TRANSTBL(B576000)
+	BAUD_TRANSTBL(B921600)
+	BAUD_TRANSTBL(B1000000)
+	BAUD_TRANSTBL(B1152000)
+	BAUD_TRANSTBL(B1500000)
+	BAUD_TRANSTBL(B2000000)
+
+	BAUD_TRANSTBL(BOTHER)
+
+	/* SPARC in particular is missing these higher baud rates */
+
+#if defined(TARGET_B2500000) && defined(B2500000)
+	BAUD_TRANSTBL(B2500000)
+#endif
+
+#if defined(TARGET_B3000000) && defined(B3000000)
+	BAUD_TRANSTBL(B3000000)
+#endif
+
+#if defined(TARGET_B3500000) && defined(B3500000)
+	BAUD_TRANSTBL(B3500000)
+#endif
+
+#if defined(TARGET_B4000000) && defined(B4000000)
+	BAUD_TRANSTBL(B4000000)
+#endif
+
 	{ TARGET_CSIZE, TARGET_CS5, CSIZE, CS5 },
 	{ TARGET_CSIZE, TARGET_CS6, CSIZE, CS6 },
 	{ TARGET_CSIZE, TARGET_CS7, CSIZE, CS7 },
-- 
2.52.0


