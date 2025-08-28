Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73255CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHb-0005Ra-Ft; Thu, 28 Aug 2025 13:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVf-0007cv-2A
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:45 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVX-0008CK-SC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2489c65330aso8534775ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383214; x=1756988014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9aPcmtBMNORt6gmFP2dhBOnn0gYGPdCmjOMx0sPWOA=;
 b=k+VzjfD/yPLq7BONZIbhE6fi7H1I+vYIn/qVOwB1cE0498EVRQdoxEUDFxJwnZxlaP
 8TWsWyiScYc8lOuVrcsezM2cRn4/azEGwXW/lfqVonHL3JrphadjkwvyT6Mwz4Iysz2X
 IlYX8csgdDpknxuldsJ8LhZlXY7Q5SQ+S/TYWLu5JXPqcOCuYZGX5hoytuYGFvyvYemz
 gtmEVvsUyTKOGfNCaZ6NsVxJEcwzm2MFtz10qrpgHG6vXGnCkdGDqOyu1BOkEUx0PGYa
 d/GqljcUwog3dvpwYfX1fpaQ4qtJaUkhunJjf0pyGJFWO8Z1YdfofCCdHY0r2qwfmfCj
 KRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383214; x=1756988014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9aPcmtBMNORt6gmFP2dhBOnn0gYGPdCmjOMx0sPWOA=;
 b=uFfcIXBTRpOb4h26X2FCUH8R+8iwwEXTsg0rWzoUC4zOKvGq8fxEvQC0/qe6KZ2SuI
 HvVO6nIwuA3d8P8ymhow2QSR3m9NeLDdSkPJcdQXWx6FumpxQMC/VcnLajW2EpCvhwxJ
 Wv1Lylcg9vaMndXAvJtDH0QuyUR5kV4UGm3R70HrLdi4XqxgqqyJNsDvhfXPo9dGuCB8
 x3y/wqrz/4lE2gntLnBqWRgswXpCmO3nh3UERmeSj9rp1At5YWZaaNDxDsUW3e8MDI03
 /FGv5Kwat1Rf2pOjPIinnSsfMl8RrsaoIAlDGdMXU2wVK1q5GCzpSIqzUV070wnDCG8H
 zwYA==
X-Gm-Message-State: AOJu0YwV3MsBZtOsUXML9uIkhmiuECcBDiiB+HaIPNTvRGQP9Gw6DecS
 Bbkx1s3li7JmdfDt2g1sp46jzHJJtUd9WTEEDnlt44lMLkz/ndg4OpyGTtEX+AIMJq1yMk9khqh
 SiEdIlYQ=
X-Gm-Gg: ASbGncvtQGgQ36oTHo+aPYjyq8Etrqe53ZBQ2hMovq5pub3nhKlBp0Yga1ijPNypRGv
 bhP0sQx4YKdAvghuUjkMYY95JuhZj6At5f4kJdDz6OJKTtlFexmGlH8wPSbq5lixIrMeGjPeWKi
 w8ahi/x41He9f0nvRGDu8Ka2zZTQ1RxY2qzJg0T9S0qRpMTlTYCb9rBDIwYZqW8hs0QrfO1fqaG
 SAM+3hiFxZ4W/GWog3JiXVTMLORTyZV5fOPSAe/XRxVzbV0w9RgIBVuC0O20WCNrljV41X7JhjD
 O81Zws9d5/QgnhwtKpuvP8JljykszZ+LYZstyjNPcyNel0nVYQKazl24FGRbe/TP6pzC3shl5m3
 DBqiBmyQoq2t0cFKqz/HYhz2aM0GAvOkS6agk
X-Google-Smtp-Source: AGHT+IHBgmDtCBb/LUpNKZ4l+Dn9TjgW+okM2SMJMSAR3cto0AmPcN6QZBivChxSKgiOu76LGdYb2g==
X-Received: by 2002:a17:902:c94d:b0:245:f002:d67c with SMTP id
 d9443c01a7336-2462eeb6325mr276128885ad.30.1756383214058; 
 Thu, 28 Aug 2025 05:13:34 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 42/87] linux-user/microblaze: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:51 +1000
Message-ID: <20250828120836.195358-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Move the target_pt_regs structure from target_syscall.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_ptrace.h  | 50 ++++++++++++++++++++++++++
 linux-user/microblaze/target_syscall.h | 44 -----------------------
 linux-user/microblaze/signal.c         |  1 +
 3 files changed, 51 insertions(+), 44 deletions(-)
 create mode 100644 linux-user/microblaze/target_ptrace.h

diff --git a/linux-user/microblaze/target_ptrace.h b/linux-user/microblaze/target_ptrace.h
new file mode 100644
index 0000000000..a46c8cb7bc
--- /dev/null
+++ b/linux-user/microblaze/target_ptrace.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef MICROBLAZE_TARGET_PTRACE_H
+#define MICROBLAZE_TARGET_PTRACE_H
+
+/* We use microblaze_reg_t to keep things similar to the kernel sources.  */
+typedef uint32_t microblaze_reg_t;
+
+struct target_pt_regs {
+    microblaze_reg_t r0;
+    microblaze_reg_t r1;
+    microblaze_reg_t r2;
+    microblaze_reg_t r3;
+    microblaze_reg_t r4;
+    microblaze_reg_t r5;
+    microblaze_reg_t r6;
+    microblaze_reg_t r7;
+    microblaze_reg_t r8;
+    microblaze_reg_t r9;
+    microblaze_reg_t r10;
+    microblaze_reg_t r11;
+    microblaze_reg_t r12;
+    microblaze_reg_t r13;
+    microblaze_reg_t r14;
+    microblaze_reg_t r15;
+    microblaze_reg_t r16;
+    microblaze_reg_t r17;
+    microblaze_reg_t r18;
+    microblaze_reg_t r19;
+    microblaze_reg_t r20;
+    microblaze_reg_t r21;
+    microblaze_reg_t r22;
+    microblaze_reg_t r23;
+    microblaze_reg_t r24;
+    microblaze_reg_t r25;
+    microblaze_reg_t r26;
+    microblaze_reg_t r27;
+    microblaze_reg_t r28;
+    microblaze_reg_t r29;
+    microblaze_reg_t r30;
+    microblaze_reg_t r31;
+    microblaze_reg_t pc;
+    microblaze_reg_t msr;
+    microblaze_reg_t ear;
+    microblaze_reg_t esr;
+    microblaze_reg_t fsr;
+    uint32_t kernel_mode;
+};
+
+#endif /* MICROBLAZE_TARGET_PTRACE_H */
diff --git a/linux-user/microblaze/target_syscall.h b/linux-user/microblaze/target_syscall.h
index 43362a1664..66f5a9ebe2 100644
--- a/linux-user/microblaze/target_syscall.h
+++ b/linux-user/microblaze/target_syscall.h
@@ -4,50 +4,6 @@
 #define UNAME_MACHINE "microblaze"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
-/* We use microblaze_reg_t to keep things similar to the kernel sources.  */
-typedef uint32_t microblaze_reg_t;
-
-struct target_pt_regs {
-        microblaze_reg_t r0;
-        microblaze_reg_t r1;
-        microblaze_reg_t r2;
-        microblaze_reg_t r3;
-        microblaze_reg_t r4;
-        microblaze_reg_t r5;
-        microblaze_reg_t r6;
-        microblaze_reg_t r7;
-        microblaze_reg_t r8;
-        microblaze_reg_t r9;
-        microblaze_reg_t r10;
-        microblaze_reg_t r11;
-        microblaze_reg_t r12;
-        microblaze_reg_t r13;
-        microblaze_reg_t r14;
-        microblaze_reg_t r15;
-        microblaze_reg_t r16;
-        microblaze_reg_t r17;
-        microblaze_reg_t r18;
-        microblaze_reg_t r19;
-        microblaze_reg_t r20;
-        microblaze_reg_t r21;
-        microblaze_reg_t r22;
-        microblaze_reg_t r23;
-        microblaze_reg_t r24;
-        microblaze_reg_t r25;
-        microblaze_reg_t r26;
-        microblaze_reg_t r27;
-        microblaze_reg_t r28;
-        microblaze_reg_t r29;
-        microblaze_reg_t r30;
-        microblaze_reg_t r31;
-        microblaze_reg_t pc;
-        microblaze_reg_t msr;
-        microblaze_reg_t ear;
-        microblaze_reg_t esr;
-        microblaze_reg_t fsr;
-        uint32_t kernel_mode;
-};
-
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MCL_CURRENT 1
 #define TARGET_MCL_FUTURE  2
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index f6d47d76ff..7aef781314 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target_ptrace.h"
 
 struct target_sigcontext {
     struct target_pt_regs regs;  /* needs to be first */
-- 
2.43.0


