Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15DFC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pd-0002NQ-KM; Mon, 17 Feb 2025 14:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6pA-0001zI-9u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p4-0008Qc-W6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:35 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-221057b6ac4so35459595ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820629; x=1740425429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHMuLXwDxnjUgeWyF7p2JwNyxJ+JG8MBxC5p4lqjmmU=;
 b=M2TbGyVqByrMAPdFmU0O3AnVvQ03Dzje6c+i5JeQI0162kx2zgPp3zLyk0tKNVlKlN
 xLuSXmSh7QkZoqM6u6UC67bygeBs1Bq07nGUBEZH/V5Ya24PDgEEjwvoG99dQRVqbkye
 PUGrY4NEP6YqSJWK6vbXpy3XuO6GcwdPiAvWuapi+PR55xrE98qEt2TDvA5GTgUyystd
 RdXBaP0RwtQAsPLB6en8rkTHns7G9X/X6EBPLkaxSMV0YBVU55j7+H68wqjzsdIDxHzc
 z1PbX1bmh8OIyiPiZt126ET4vLWBb2JeqCb+xRdAC6QXuzaBYQBPEDsjsQZePoq+OMXU
 cE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820629; x=1740425429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHMuLXwDxnjUgeWyF7p2JwNyxJ+JG8MBxC5p4lqjmmU=;
 b=M2p8zCrpcOH89x5NecgVBd21KCCb4/TK0gOAziFO/ezNvm1MRIcIjjJDbjg95zIsXc
 oz1kFp3FRMS020ciRynJ24K5KgTe7tpekIV0tBr8PYQwwU6ACQ4lqQ3QsTSZrYsVAhl/
 JTzMuyGqKkh/s5jjsiqA/T102Vg7eAxjYoAPcPY2VXhs2acchOEUmFL1UOf9SlIvIpKE
 80UmHtRAAkCgEvarMs6IEn0zPjYEqLELXJv+TOn4MKu9RHd/PZbKDYTy8MO9DID0Hig5
 JuFEwzp1KGOeahqVqZl20AG/dfojrEvvgBDJPjKgM8xM99lgenHO0cLqPaSzUbxvVyif
 2o3A==
X-Gm-Message-State: AOJu0YwuYjcWVHfm20IAnm14HviJArinbGAIkors38Mcyv5DRNMLD83m
 52Vd5g/AZa+tYUZ8Z4YsP5BxZmWa0vLavfrJLBQNeIAmUFwuHWIAOSQAxz9GQyTpSogH3/Gt69i
 p
X-Gm-Gg: ASbGncuELQavz8EZUxKahheagvb/3P8WsXH8zZUMrD6pC6HIRbWlhBNETGFUuuS8m2E
 jvCyc2Dqvn2v7PPumCiUrYVWf5aXXAEJsljxPBBiVQcvtqJZbqhGmTiFyptj7wf4cnJYD7IY+Wa
 sb+DoLV/RFGurPP9wChf1Hw9hgO5Ss877Tuiy9ZFvr1gitAMjYYeulGknwffYojzLEs3f3vpSJu
 eyH606qIeChBSdiQwwrTTdQI5T69I9hUAD6IFoELYy2BG+es8BepiWqnr/3DIyYqkJhDe1KCrkN
 UbbhfTYyhPIt20/Rj4vihXC7lnklwE52RvkkaOyUQDwihmg=
X-Google-Smtp-Source: AGHT+IG94vzbvEHWGOidmQNMPMDGV3/gbnz6FIX3I1lAeE8pprdPVc0NNx+AxvgBxZPi3poTVwcSjw==
X-Received: by 2002:a05:6a00:cc9:b0:730:937f:e838 with SMTP id
 d2e1a72fcca58-732618f5724mr14202731b3a.22.1739820628926; 
 Mon, 17 Feb 2025 11:30:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PULL v2 22/27] linux-user: Move TARGET_SA_RESTORER out of
 generic/signal.h
Date: Mon, 17 Feb 2025 11:30:03 -0800
Message-ID: <20250217193009.2873875-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


