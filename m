Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCDCC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6d-0007kL-Gk; Sat, 15 Feb 2025 19:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6L-0007fh-SC
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:37 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6I-0006IL-5X
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:37 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fbfa8c73a6so6105073a91.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664087; x=1740268887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHMuLXwDxnjUgeWyF7p2JwNyxJ+JG8MBxC5p4lqjmmU=;
 b=qrA5O42a2L2yJmd4NdJIRNq9ZDFnSrmdKPXflGH7CELNLUvgjIKSIgb1uHmaqBQZrn
 Zqgn+MKfumyCR7oppzY0SPh71cL5DHnnwkJrgUiPa7qx8cCzAaqsj4CQIDPchC4bX0ls
 VHfUBIQxG98a5RFFyo7DugJFy+xebhGRad0N6gtU3gE5oFM0dq0dTap/bz6Rp4ytP2H7
 MrZAu5nlFrDYNChTp+ThvQidOZBsBnpl2f1VxygbvzeXvyyK8MdMWQs/4s2icZ2AZCq5
 imGbDbAbRB0Z9/mp8r69ghDJtphOR12u0TOSLXjLym0AT+J4FnRNRQnwOqt7+h7P3kHt
 y6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664087; x=1740268887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHMuLXwDxnjUgeWyF7p2JwNyxJ+JG8MBxC5p4lqjmmU=;
 b=ewsdW/xJmlyjYC4t5OT9yuwqAonLTHHdjsBKoAXjfDs1D4kuUNN15dGI4Jhq/px8Dd
 pVTrYWwyP2THSdY4Ng7yjBlo7Lla7SsDpueIntFqYsHRrnxiF3xvCNl8TN3NoundwCFT
 eI1SYVVhgjlrex362mO76LwGCzzU0TyhhlEfoHpst+h5ssZgvlxE1R6TUJMqjeVkP/Jn
 ARSaY+ROoXd6NzV+pmN92y3H8p7kgdPNe5PgCyRBhxfHrTxFG3zkqRfNplhqKGfGvZHa
 32vYUCiOxUUrjsdacGkCjsbeEJ6LRjSg4IkQYVgmadD0xvZIQS7AHYRFp8ziX9slh/1T
 Jrlg==
X-Gm-Message-State: AOJu0Yw15Nn3QVGh1DR6jG3mn6PelG7wbN6BCWvEhkkjGvhqanPHgaG6
 k/XRr3E5cfQh/MkdhscyGrq92Ohjw3hWnHm9ANmGuf00kLEqGTh0k3l/pFwmpki3C6F3ve7vsDn
 o
X-Gm-Gg: ASbGncsAUO9/jNbHvpglqQzB1Fx+Aejot/SpfNiOz1VYYzxs6oHkFRAarx0qG9454E3
 zt0RZX0aTa2rnN9XYbc4tDSGZKkmjOGh13jdfyGwKjtpXc/WQGXw9vRCk8jCHzj1Ehx/p4URWpV
 usFbP0cW0MZiNsiKYuZsE6Wq6e1DhVrohGnks72nU2ktqMoArKzo21rOm22G/2yvFOwQlkRPEkf
 sO8L38jQx/ALoEAwm7PWeULzmDr9R/5rJV3sBJ297Dk2kxSVURAtJ5H02AmuyXB8AodziLHl8D5
 KkqYyWmK2WO0lQOkV/7+zrQLzqPKY5SEczkc/ILp6ulpVlA=
X-Google-Smtp-Source: AGHT+IH63vR5vjT1605TlOQm5MtggkDS9t/+4busfoWLMstKovdyccV38xPmpQb8KqE29zreVY7cTQ==
X-Received: by 2002:a17:90b:1e02:b0:2ee:c4f2:a76d with SMTP id
 98e67ed59e1d1-2fc40f21e2cmr6199252a91.21.1739664086911; 
 Sat, 15 Feb 2025 16:01:26 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PULL 21/24] linux-user: Move TARGET_SA_RESTORER out of
 generic/signal.h
Date: Sat, 15 Feb 2025 16:01:05 -0800
Message-ID: <20250216000109.2606518-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andreas Schwab <schwab@suse.de>

SA_RESTORER and the associated sa_restorer field of struct sigaction are
an obsolete feature, not expected to be used by future architectures.
They are also absent on RISC-V, LoongArch, Hexagon and OpenRISC, but
defined due to their use of generic/signal.h.  This leads to corrupted
data and out-of-bounds accesses.

Move the definition of TARGET_SA_RESTORER out of generic/signal.h into the
target_signal.h files that need it.  Note that m68k has the sa_restorer
field, but does not use it and does not define SA_RESTORER.

Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <mvmed060xc9.fsf@suse.de>
---
 linux-user/aarch64/target_signal.h    | 2 ++
 linux-user/arm/target_signal.h        | 2 ++
 linux-user/generic/signal.h           | 1 -
 linux-user/i386/target_signal.h       | 2 ++
 linux-user/m68k/target_signal.h       | 1 +
 linux-user/microblaze/target_signal.h | 2 ++
 linux-user/ppc/target_signal.h        | 2 ++
 linux-user/s390x/target_signal.h      | 2 ++
 linux-user/sh4/target_signal.h        | 2 ++
 linux-user/x86_64/target_signal.h     | 2 ++
 linux-user/xtensa/target_signal.h     | 2 ++
 11 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 40e399d990..6f66a50bfd 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
 
diff --git a/linux-user/arm/target_signal.h b/linux-user/arm/target_signal.h
index 0e6351d9f7..ff1810b1fe 100644
--- a/linux-user/arm/target_signal.h
+++ b/linux-user/arm/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/generic/signal.h b/linux-user/generic/signal.h
index 6fd05b77bb..b34740258e 100644
--- a/linux-user/generic/signal.h
+++ b/linux-user/generic/signal.h
@@ -15,7 +15,6 @@
 #define TARGET_SA_RESTART       0x10000000
 #define TARGET_SA_NODEFER       0x40000000
 #define TARGET_SA_RESETHAND     0x80000000
-#define TARGET_SA_RESTORER      0x04000000
 
 #define TARGET_SIGHUP            1
 #define TARGET_SIGINT            2
diff --git a/linux-user/i386/target_signal.h b/linux-user/i386/target_signal.h
index 9315cba241..eee792ef63 100644
--- a/linux-user/i386/target_signal.h
+++ b/linux-user/i386/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/m68k/target_signal.h b/linux-user/m68k/target_signal.h
index 6e0f4b74e3..b05b9303b0 100644
--- a/linux-user/m68k/target_signal.h
+++ b/linux-user/m68k/target_signal.h
@@ -3,6 +3,7 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_ARCH_HAS_SA_RESTORER 1
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index 7dc5c45f00..ffe4442213 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
 #endif /* MICROBLAZE_TARGET_SIGNAL_H */
diff --git a/linux-user/ppc/target_signal.h b/linux-user/ppc/target_signal.h
index 5be24e152b..53fae473f3 100644
--- a/linux-user/ppc/target_signal.h
+++ b/linux-user/ppc/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #if !defined(TARGET_PPC64)
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif
diff --git a/linux-user/s390x/target_signal.h b/linux-user/s390x/target_signal.h
index 41e0e34a55..738e0673f4 100644
--- a/linux-user/s390x/target_signal.h
+++ b/linux-user/s390x/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index eee6a1a7cd..0bde417fd1 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
diff --git a/linux-user/x86_64/target_signal.h b/linux-user/x86_64/target_signal.h
index 9d9717406f..0af100c661 100644
--- a/linux-user/x86_64/target_signal.h
+++ b/linux-user/x86_64/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 /* For x86_64, use of SA_RESTORER is mandatory. */
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
 
diff --git a/linux-user/xtensa/target_signal.h b/linux-user/xtensa/target_signal.h
index e4b1bea5cb..8a198bf8ac 100644
--- a/linux-user/xtensa/target_signal.h
+++ b/linux-user/xtensa/target_signal.h
@@ -3,6 +3,8 @@
 
 #include "../generic/signal.h"
 
+#define TARGET_SA_RESTORER      0x04000000
+
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
 
 #endif
-- 
2.43.0


