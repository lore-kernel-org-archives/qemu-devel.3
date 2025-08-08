Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7968BC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukM1P-0008L5-WC; Fri, 08 Aug 2025 08:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1ukM1N-0008Hy-No
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:16:29 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1ukM1J-0001En-MX
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:16:29 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 1DAD5230FBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1754655371;
 bh=7dKGwCWlnpYC7OaP1o+M7c+B+2KzCNiRVoMSWyLbvWA=;
 h=Date:To:Cc:From:Subject;
 b=DU8nF00Y3lOi20jOY9UU1e1JQA4vJNLreoC4xVa/NWMo4MhjYLmdHr/S2AVQYycre
 gE+AVrMa+lRMi5/X5XugaL5FmrudfH22M5MEYvDO2Lac9VoO6MZZiakf3LgnjaaQ4u
 KLaSQvHnkw8rVmJCHQ11+NesF6KVIGPg6ZlvQkWA=
Received: from [10.0.0.70] (dynamic-adsl-84-220-72-247.clienti.tiscali.it
 [84.220.72.247])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 1DAD5230FBE;
 Fri,  8 Aug 2025 14:16:11 +0200 (CEST)
Message-ID: <e18add5b-c75a-4547-8ae0-01d9924883dd@bonslack.org>
Date: Fri, 8 Aug 2025 14:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: it
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
From: Luca Bonissi <qemu@bonslack.org>
Subject: [PATCH] Adding termios2 support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Luca Bonissi <qemu@bonslack.org>
Date: Fri, 8 Aug 2025 13:30:19 +0200
Subject: [PATCH] Adding termios2 support

glibc 2.42 switched on some architectures (mips*, sh4, or1k) to termios2 
ioctl syscalls (TCGETS2, TCSETS2, TCSETSW2, TCSETSF2).
This patch add support to termios2 structure and releated ioctls.

Fixed also wrong TC*2 definition on mips (missing "target_" from "struct 
termios2").

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
---
  linux-user/alpha/termbits.h | 29 ++++++++++++++
  linux-user/hppa/termbits.h  | 29 ++++++++++++++
  linux-user/ioctls.h         |  6 +++
  linux-user/mips/termbits.h  | 31 ++++++++++++--
  linux-user/ppc/termbits.h   | 24 +++++++++++
  linux-user/sh4/termbits.h   | 46 +++++++++++++++------
  linux-user/sparc/termbits.h | 28 +++++++++++++
  linux-user/strace.c         | 63 +++++++++++++++++++++++++++++
  linux-user/syscall.c        | 80 +++++++++++++++++++++++++++++++++++++
  linux-user/syscall_types.h  |  3 ++
  linux-user/user-internals.h |  3 ++
  11 files changed, 326 insertions(+), 16 deletions(-)

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
  #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty 
Number (of pty-mux device) */
  #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
  #define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open 
the slave */
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
+#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct 
target_termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct 
target_termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct 
target_termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct 
target_termios2)
+#define TARGET_TIOCGRS485       TARGET_IOR('T', 0x2E, struct serial_rs485)
+#define TARGET_TIOCSRS485       TARGET_IOWR('T', 0x2F, struct serial_rs485)
  #define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
          /* Get Pty Number (of pty-mux device) */
  #define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3b41128fd7..0b2deb2824 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -1,5 +1,11 @@
       /* emulated ioctl list */

+#ifdef TARGET_TCGETS2
+     IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
+     IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
+     IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
+     IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
+#endif
       IOCTL(TCGETS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios)))
       IOCTL(TCSETS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
       IOCTL(TCSETSF, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
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
+#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct 
target_termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct 
target_termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct 
target_termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct 
target_termios2)
  #define TARGET_TIOCGRS485       TARGET_IOR('T', 0x2E, struct serial_rs485)
  #define TARGET_TIOCSRS485       TARGET_IOWR('T', 0x2F, struct 
serial_rs485)
  #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty 
Number (of pty-mux device) */
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index eb226e0999..ae6ee8897c 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -20,6 +20,28 @@ struct target_termios {
      target_speed_t c_ospeed;               /* output speed */
  };

+struct target_termios2 {
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
+    target_cc_t c_line;                    /* line discipline */
+    target_speed_t c_ispeed;               /* input speed */
+    target_speed_t c_ospeed;               /* output speed */
+};
+
+struct target_ktermios {
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
+    target_cc_t c_line;                    /* line discipline */
+    target_speed_t c_ispeed;               /* input speed */
+    target_speed_t c_ospeed;               /* output speed */
+};
+
  /* c_cc character offsets */
  #define TARGET_VINTR 	0
  #define TARGET_VQUIT 	1
@@ -225,6 +247,8 @@ struct target_termios {
  #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
  #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
  #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TARGET_TIOCGRS485	0x542e
+#define TARGET_TIOCSRS485	0x542f
  #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty 
Number (of pty-mux device) */
  #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
  #define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open 
the slave */
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index 28e79f2c9a..cab6b1299e 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
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
  #define TARGET_VINTR 0
@@ -251,14 +273,17 @@ struct target_termios {
  #define TARGET_TIOCNOTTY       TARGET_IO('T', 34) /* 0x5422 */
  #define TARGET_TIOCSETD        TARGET_IOW('T', 35, int) /* 0x5423 */
  #define TARGET_TIOCGETD        TARGET_IOR('T', 36, int) /* 0x5424 */
-#define TARGET_TCSBRKP         TARGET_IOW('T', 37, int) /* 0x5425 */ /* 
Needed for POSIX tcse
-ndbreak() */
+#define TARGET_TCSBRKP         TARGET_IOW('T', 37, int) /* 0x5425 */ /* 
Needed for POSIX tcsendbreak() */
  #define TARGET_TIOCSBRK        TARGET_IO('T', 39) /* 0x5427 */ /* BSD 
compatibility */
  #define TARGET_TIOCCBRK        TARGET_IO('T', 40) /* 0x5428 */ /* BSD 
compatibility */
-#define TARGET_TIOCGSID        TARGET_IOR('T', 41, pid_t) /* 0x5429 */ 
/* Return the session
-ID of FD */
-#define TARGET_TIOCGPTN        TARGET_IOR('T',0x30, unsigned int) /* 
Get Pty Number (of pty-m
-ux device) */
+#define TARGET_TIOCGSID        TARGET_IOR('T', 41, pid_t) /* 0x5429 */ 
/* Return the session ID of FD */
+#define TARGET_TCGETS2         TARGET_IOR('T', 0x2A, struct 
target_termios2)
+#define TARGET_TCSETS2         TARGET_IOW('T', 0x2B, struct 
target_termios2)
+#define TARGET_TCSETSW2        TARGET_IOW('T', 0x2C, struct 
target_termios2)
+#define TARGET_TCSETSF2        TARGET_IOW('T', 0x2D, struct 
target_termios2)
+#define TARGET_TIOCGRS485      TARGET_IOR('T', 0x2E, struct serial_rs485)
+#define TARGET_TIOCSRS485      TARGET_IOWR('T', 0x2F, struct serial_rs485)
+#define TARGET_TIOCGPTN        TARGET_IOR('T',0x30, unsigned int) /* 
Get Pty Number (of pty-mux device) */
  #define TARGET_TIOCSPTLCK      TARGET_IOW('T',0x31, int)  /* 
Lock/unlock Pty */
  #define TARGET_TIOCGPTPEER     TARGET_IO('T', 0x41) /* Safely open the 
slave */

@@ -270,8 +295,7 @@ ux device) */
  #define TARGET_TIOCSLCKTRMIOS  0x5457
  #define TARGET_TIOCSERGSTRUCT  TARGET_IOR('T', 88, int) /* 0x5458 */ 
/* For d
  ebugging only */
-#define TARGET_TIOCSERGETLSR   TARGET_IOR('T', 89, unsigned int) /* 
0x5459 */ /* Get line sta
-tus register */
+#define TARGET_TIOCSERGETLSR   TARGET_IOR('T', 89, unsigned int) /* 
0x5459 */ /* Get line status register */
    /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
  # define TARGET_TIOCSER_TEMT   0x01   /* Transmitter physically empty */
  #define TARGET_TIOCSERGETMULTI TARGET_IOR('T', 90, int) /* 0x545A
@@ -279,9 +303,7 @@ tus register */
  #define TARGET_TIOCSERSETMULTI TARGET_IOW('T', 91, int) /* 0x545B
  */ /* Set multiport config */

-#define TARGET_TIOCMIWAIT      TARGET_IO('T', 92) /* 0x545C */       /* 
wait for a change on
-serial input line(s) */
-#define TARGET_TIOCGICOUNT     TARGET_IOR('T', 93, int) /* 0x545D */ /* 
read
-serial port inline interrupt counts */
+#define TARGET_TIOCMIWAIT      TARGET_IO('T', 92) /* 0x545C */       /* 
wait for a change on serial input line(s) */
+#define TARGET_TIOCGICOUNT     TARGET_IOR('T', 93, int) /* 0x545D */ /* 
read serial port inline interrupt counts */

  #endif
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
  #define TARGET_TIOCGPTN	TARGET_IOR('t', 134, unsigned int) /* Get Pty 
Number */
  #define TARGET_TIOCSPTLCK	TARGET_IOW('t', 135, int) /* Lock/unlock PTY */
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3b744ccd4a..aa7556a802 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1929,6 +1929,69 @@ print_termios(void *arg)
      qemu_log("}");
  }

+#ifdef TARGET_TCGETS2
+void
+print_termios2(void *arg)
+{
+    const struct target_termios2 *target = arg;
+
+    target_tcflag_t iflags = tswap32(target->c_iflag);
+    target_tcflag_t oflags = tswap32(target->c_oflag);
+    target_tcflag_t cflags = tswap32(target->c_cflag);
+    target_tcflag_t lflags = tswap32(target->c_lflag);
+
+    qemu_log("{");
+
+    qemu_log("c_iflag = ");
+    print_flags(termios_iflags, iflags, 0);
+
+    qemu_log("c_oflag = ");
+    target_tcflag_t oflags_clean =  oflags & ~(TARGET_NLDLY | 
TARGET_CRDLY |
+                                               TARGET_TABDLY | 
TARGET_BSDLY |
+                                               TARGET_VTDLY | 
TARGET_FFDLY);
+    print_flags(termios_oflags, oflags_clean, 0);
+    if (oflags & TARGET_NLDLY) {
+        print_enums(termios_oflags_NLDLY, oflags & TARGET_NLDLY, 0);
+    }
+    if (oflags & TARGET_CRDLY) {
+        print_enums(termios_oflags_CRDLY, oflags & TARGET_CRDLY, 0);
+    }
+    if (oflags & TARGET_TABDLY) {
+        print_enums(termios_oflags_TABDLY, oflags & TARGET_TABDLY, 0);
+    }
+    if (oflags & TARGET_BSDLY) {
+        print_enums(termios_oflags_BSDLY, oflags & TARGET_BSDLY, 0);
+    }
+    if (oflags & TARGET_VTDLY) {
+        print_enums(termios_oflags_VTDLY, oflags & TARGET_VTDLY, 0);
+    }
+    if (oflags & TARGET_FFDLY) {
+        print_enums(termios_oflags_FFDLY, oflags & TARGET_FFDLY, 0);
+    }
+
+    qemu_log("c_cflag = ");
+    if (cflags & TARGET_CBAUD) {
+        print_enums(termios_cflags_CBAUD, cflags & TARGET_CBAUD, 0);
+    }
+    if (cflags & TARGET_CSIZE) {
+        print_enums(termios_cflags_CSIZE, cflags & TARGET_CSIZE, 0);
+    }
+    target_tcflag_t cflags_clean = cflags & ~(TARGET_CBAUD | TARGET_CSIZE);
+    print_flags(termios_cflags, cflags_clean, 0);
+
+    qemu_log("c_lflag = ");
+    print_flags(termios_lflags, lflags, 0);
+
+    qemu_log("c_cc = ");
+    qemu_log("\"%s\",", target->c_cc);
+
+    qemu_log("c_line = ");
+    print_raw_param("\'%c\'", target->c_line, 1);
+
+    qemu_log("}");
+}
+#endif
+
  #undef UNUSED

  #ifdef TARGET_NR_accept
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..41ef690e52 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -88,6 +88,7 @@
  #endif

  #define termios host_termios
+#define termios2 host_termios2
  #define winsize host_winsize
  #define termio host_termio
  #define sgttyb host_sgttyb /* same as target */
@@ -5887,6 +5888,85 @@ static const StructEntry struct_termios_def = {
      .print = print_termios,
  };

+#ifdef TARGET_TCGETS2
+static void target_to_host_termios2 (void *dst, const void *src)
+{
+    struct host_termios2 *host = dst;
+    const struct target_termios2 *target = src;
+
+    host->c_iflag =
+        target_to_host_bitmask(tswap32(target->c_iflag), iflag_tbl);
+    host->c_oflag =
+        target_to_host_bitmask(tswap32(target->c_oflag), oflag_tbl);
+    host->c_cflag =
+        target_to_host_bitmask(tswap32(target->c_cflag), cflag_tbl);
+    host->c_lflag =
+        target_to_host_bitmask(tswap32(target->c_lflag), lflag_tbl);
+    host->c_line = target->c_line;
+
+    memset(host->c_cc, 0, sizeof(host->c_cc));
+    host->c_cc[VINTR] = target->c_cc[TARGET_VINTR];
+    host->c_cc[VQUIT] = target->c_cc[TARGET_VQUIT];
+    host->c_cc[VERASE] = target->c_cc[TARGET_VERASE];
+    host->c_cc[VKILL] = target->c_cc[TARGET_VKILL];
+    host->c_cc[VEOF] = target->c_cc[TARGET_VEOF];
+    host->c_cc[VTIME] = target->c_cc[TARGET_VTIME];
+    host->c_cc[VMIN] = target->c_cc[TARGET_VMIN];
+    host->c_cc[VSWTC] = target->c_cc[TARGET_VSWTC];
+    host->c_cc[VSTART] = target->c_cc[TARGET_VSTART];
+    host->c_cc[VSTOP] = target->c_cc[TARGET_VSTOP];
+    host->c_cc[VSUSP] = target->c_cc[TARGET_VSUSP];
+    host->c_cc[VEOL] = target->c_cc[TARGET_VEOL];
+    host->c_cc[VREPRINT] = target->c_cc[TARGET_VREPRINT];
+    host->c_cc[VDISCARD] = target->c_cc[TARGET_VDISCARD];
+    host->c_cc[VWERASE] = target->c_cc[TARGET_VWERASE];
+    host->c_cc[VLNEXT] = target->c_cc[TARGET_VLNEXT];
+    host->c_cc[VEOL2] = target->c_cc[TARGET_VEOL2];
+}
+
+static void host_to_target_termios2 (void *dst, const void *src)
+{
+    struct target_termios2 *target = dst;
+    const struct host_termios2 *host = src;
+
+    target->c_iflag =
+        tswap32(host_to_target_bitmask(host->c_iflag, iflag_tbl));
+    target->c_oflag =
+        tswap32(host_to_target_bitmask(host->c_oflag, oflag_tbl));
+    target->c_cflag =
+        tswap32(host_to_target_bitmask(host->c_cflag, cflag_tbl));
+    target->c_lflag =
+        tswap32(host_to_target_bitmask(host->c_lflag, lflag_tbl));
+    target->c_line = host->c_line;
+
+    memset(target->c_cc, 0, sizeof(target->c_cc));
+    target->c_cc[TARGET_VINTR] = host->c_cc[VINTR];
+    target->c_cc[TARGET_VQUIT] = host->c_cc[VQUIT];
+    target->c_cc[TARGET_VERASE] = host->c_cc[VERASE];
+    target->c_cc[TARGET_VKILL] = host->c_cc[VKILL];
+    target->c_cc[TARGET_VEOF] = host->c_cc[VEOF];
+    target->c_cc[TARGET_VTIME] = host->c_cc[VTIME];
+    target->c_cc[TARGET_VMIN] = host->c_cc[VMIN];
+    target->c_cc[TARGET_VSWTC] = host->c_cc[VSWTC];
+    target->c_cc[TARGET_VSTART] = host->c_cc[VSTART];
+    target->c_cc[TARGET_VSTOP] = host->c_cc[VSTOP];
+    target->c_cc[TARGET_VSUSP] = host->c_cc[VSUSP];
+    target->c_cc[TARGET_VEOL] = host->c_cc[VEOL];
+    target->c_cc[TARGET_VREPRINT] = host->c_cc[VREPRINT];
+    target->c_cc[TARGET_VDISCARD] = host->c_cc[VDISCARD];
+    target->c_cc[TARGET_VWERASE] = host->c_cc[VWERASE];
+    target->c_cc[TARGET_VLNEXT] = host->c_cc[VLNEXT];
+    target->c_cc[TARGET_VEOL2] = host->c_cc[VEOL2];
+}
+
+static const StructEntry struct_termios2_def = {
+    .convert = { host_to_target_termios2, target_to_host_termios2 },
+    .size = { sizeof(struct target_termios2), sizeof(struct 
host_termios2) },
+    .align = { __alignof__(struct target_termios2), __alignof__(struct 
host_termios2) },
+    .print = print_termios2,
+};
+#endif
+
  /* If the host does not provide these bits, they may be safely 
discarded. */
  #ifndef MAP_SYNC
  #define MAP_SYNC 0
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 6dd7a80ce5..ac45705acf 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -1,4 +1,7 @@
  STRUCT_SPECIAL(termios)
+#ifdef TARGET_TCGETS2
+STRUCT_SPECIAL(termios2)
+#endif

  STRUCT(winsize,
         TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT)
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 691b9a1775..191e01c3a8 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -127,6 +127,9 @@ static inline uint64_t target_offset64(uint64_t 
word0, uint64_t word1)
  #endif /* TARGET_ABI_BITS != 32 */

  void print_termios(void *arg);
+#ifdef TARGET_TCGETS2
+void print_termios2(void *arg);
+#endif

  /* ARM EABI and MIPS expect 64bit types aligned even on pairs or 
registers */
  #ifdef TARGET_ARM
-- 
2.50.1



