Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A7ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNlG-0004PS-40; Sat, 30 Aug 2025 11:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fj-00063i-JN
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:15 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fh-0004pj-QT
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:15 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-771ff6f117aso2308275b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506852; x=1757111652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2EBPaDljgDIO9u5Mh4leNghXkurvR/xAf8Yp62jKtQ=;
 b=aQDuF3DywjbHHh5exFzlowafr2QSFPtlS8QQK6UhC61A/U+mmmlMSMeuz7qxPKRijN
 xt9rAU9yZwPcd7zRrlAYlgMgrZDJh1BRZE2bWm+gwjEb5D7dTZj/9kg0wPSuiyU/tWNY
 loOOc/aMFZGttFlVBu/cI53/T/g0kOAB9Gy1bRLN4BRBrGIzb0xi9t56QCJFSeQCWZ7W
 fjKcYyQ3FftPvgn+D2zV+Doy7GBo/ZFlEunJs5Q9yF80MpDOhKWzB1Jjd6tIt99IbLbQ
 ycz/ta3FxsoS6JcGtEwnccfYQAPy3wUInnnqNRImh5rm7bu68zzJ1Q7rmuNWPSnhnGdl
 WkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506852; x=1757111652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2EBPaDljgDIO9u5Mh4leNghXkurvR/xAf8Yp62jKtQ=;
 b=LR5ksayJMgyV5zfFe/Oq2IF+TmMwzBWUS7adCFbys+g1K1gYrYEmktyz+dLVp+n3DA
 AXMgq0jnZkHy4Tu+YHzNeylVbOHUsx1VUWB/NjqjL9F5ME8b2i6NOD6Ak45kjW2kQlEz
 2EPfiHGsLu40RFjj+KaI/tCFh4RGXhlZxg5IdAOVDKpEALtULlXC/wVEPEKZm5VcRD1q
 GbhhVaXw3d4quc+N77YlV/8+xwVDxijeAGLRvz0qG/kwiGXeuePVw95FOFs57/YHBaW6
 z+BjiWywHno5j/Ls+LB7FnXGmAOMophxVmlVG5NkTRP4zj0fSYsaCNwt4wgWl60iJ8C0
 SLjg==
X-Gm-Message-State: AOJu0Yz3R+JZNI6bhWtafvgVLJcswCtRfFn5K98uCIC0vbYUYgFNjCj+
 vLn7m9mgQ1avieRnD32Jm58+kyy9KJmdUFBg85D5Z8H1BPgDVRbNtU7+liPJNSOuPDGSotajTN3
 eGox1c/s=
X-Gm-Gg: ASbGncvmVoj0LqXWrByQfhT0a4B9ZYgkgwX9DfYvmKifgQnHMXWTFdwF/YClAoRjZ1V
 ytOrCYC14RrIXldDytIv99g+1jx7dXuQ4reRufrDast5RhaHYWXpXUpYgNInpbI+pPah5dltzGL
 XejjZsOT7UQ9uWCkpZREMG/bu8v5IRnBi2Spx1a8vGTlMeSzAyhXSySqoXitdfJAvzKZPt1JJ9z
 8Mx4/94EXEhdq+P9UdJM9iy5UVjgYqyp9fevXTdX4sWjAnW7M7yiHfkoF5uLTP84pAN3J3vjtXb
 PE5irHQpLenPBYGyOUvGg1KwyCcGvroo5m8cPHVKOYnq3m9JaoayMGiSrEOVQfHtScyEbzx782S
 byRLz/63K7ZUUISf681tcsZC92/GysmmWuOpdryn4ewZE5F61B2Qkzmj0vsPh
X-Google-Smtp-Source: AGHT+IG4PtpAVcmQHSTWx1FlxByOrpw/xNmmo9wZJGBUd1NCA7s6Q0E6TuZeEnvH4JvJqx9bqG0Vww==
X-Received: by 2002:a05:6a20:3d07:b0:243:9587:a75c with SMTP id
 adf61e73a8af0-243d6f7ec6cmr305660637.59.1756506852280; 
 Fri, 29 Aug 2025 15:34:12 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:34:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 90/91] linux-user/sparc: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:24:26 +1000
Message-ID: <20250829222427.289668-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Move target_pt_regs to target_ptrace.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_ptrace.h  | 24 ++++++++++++++++++++++++
 linux-user/sparc/target_syscall.h | 19 -------------------
 linux-user/sparc/signal.c         |  2 ++
 3 files changed, 26 insertions(+), 19 deletions(-)
 create mode 100644 linux-user/sparc/target_ptrace.h

diff --git a/linux-user/sparc/target_ptrace.h b/linux-user/sparc/target_ptrace.h
new file mode 100644
index 0000000000..a4d5416c1f
--- /dev/null
+++ b/linux-user/sparc/target_ptrace.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef SPARC_TARGET_PTRACE_H
+#define SPARC_TARGET_PTRACE_H
+
+/* See arch/sparc/include/uapi/asm/ptrace.h. */
+struct target_pt_regs {
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+    abi_ulong u_regs[16];
+    abi_ulong tstate;
+    abi_ulong pc;
+    abi_ulong npc;
+    uint32_t y;
+    uint32_t magic;
+#else
+    abi_ulong psr;
+    abi_ulong pc;
+    abi_ulong npc;
+    abi_ulong y;
+    abi_ulong u_regs[16];
+#endif
+};
+
+#endif /* SPARC_TARGET_PTRACE_H */
diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index e421165357..a90ed2983a 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -1,25 +1,6 @@
 #ifndef SPARC_TARGET_SYSCALL_H
 #define SPARC_TARGET_SYSCALL_H
 
-#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-struct target_pt_regs {
-    abi_ulong u_regs[16];
-    abi_ulong tstate;
-    abi_ulong pc;
-    abi_ulong npc;
-    uint32_t y;
-    uint32_t magic;
-};
-#else
-struct target_pt_regs {
-    abi_ulong psr;
-    abi_ulong pc;
-    abi_ulong npc;
-    abi_ulong y;
-    abi_ulong u_regs[16];
-};
-#endif
-
 #ifdef TARGET_SPARC64
 # define UNAME_MACHINE "sparc64"
 #else
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 8181b8b92c..d339f89928 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -21,6 +21,8 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target_ptrace.h"
+
 
 /* A Sparc register window */
 struct target_reg_window {
-- 
2.43.0


