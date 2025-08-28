Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAB6CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFp-0002WT-Uh; Thu, 28 Aug 2025 13:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW0-0007l5-BC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:04 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVm-0008Eb-Al
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:51 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2445824dc27so7513165ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383228; x=1756988028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LenyfsMZgDOHJ6FaZSy9G8+0Dpwwnso+zoZ4ErmZGVw=;
 b=c2VZthVJJiFXdxVAhAh0snqgMI61euujBMvlyWZeJ57O12+YA6L9KJRpqZckLVrmCk
 CXaM6Xxy8ma7ZrTALF/i+TEQVHWvLBmy4b78vPOdvkIC1GrYSykbhh45SR8sT5Bzahky
 H1IT2P8oFovSbBowkOFDzRStk1LS41lLUTKVrNhqxsGKEvJB0ETV9MUpuQshfuu3qJ+d
 xpljw0r6mTmdSe87hgBkameDZFzpezv9RQE7AzHzAyu+hhsWx+kSVezusL6uSQbhPm5r
 WYxAzyfK1p4cdMbZjU8XVBtvUkVNMIXtuoJNUAI3BpzE3I6FFB5JWI8qmSjzvHY2D7TK
 ttqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383228; x=1756988028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LenyfsMZgDOHJ6FaZSy9G8+0Dpwwnso+zoZ4ErmZGVw=;
 b=KbCMbYTZ8AKVz4yopxU6AZnLRpg6utUwG9vvtYeHWj2TscNl3xX2UZTeNpy5gFYyy9
 /9p2yV0x8KkJHsrACLBSdp+JtnNfbmm0bDTWpkIRTgcJ6UfnH9B/HZaQnrP8mKeBFBxn
 RyzBISYTMExBfYsfDeNKeFEQIRhrtgYMHiSi4gS9gYSMUXZ/UTFz7D2uUhPxmzV+Ybwx
 cjHJhKaT8H3z5xZjPBzmzDUa83c8K92uC2kLol6Esla7yxfot2Ab2JGwH/y/5sBwGlmT
 mNdRp1fYMbwQpcYpjguOjy2bV87a/yRhEnz9BSibQGxKuWEnewv+qm/2vnNwdHhKwes3
 Solg==
X-Gm-Message-State: AOJu0YxINiXQ87Y2mkoxQhROWGW68PLLEpQPlJLcUN1TT/CIT5+bm+RX
 4X7bKNU+onsVzn5FdhJrxWULaEjpGTdgCgPTtoeNSXBM8M/5Ajgf1i/EcoH181NC3muoK3zq6zn
 NyBcmB6E=
X-Gm-Gg: ASbGncsZrZsXjBOKR1FyvYw0QrsRjQPMAGTzPa7/sAI+0dyQGfGjAEz6YS2O/MCNSZm
 rz80y2a08LRqFGC52LXMtTbhy8229Jk82SLz/w3J7ZXuvbDvQVUuHFG/ebZIw8L8gnMY/qTAcus
 EytHB61ED/qBz0gnKPGMIsrMTE8xnoIvWhzEtgrv8LBOGIPXPLEF47xipqSTMil2cggdbXMF3fK
 +0x4xilrn6iTeFnzPK5DcxzGT4grcqPQOKxEQYLU+MFpRVq5wPWyaKbhkgzBzVfK+LTS2EhT6sY
 zgdlIOeJ9mo9xMl1XZ+A3IYgrOPy4gHN9mfUTw0pMFmGh5aaV2sxlMkZDNFD0oZam8YDfRDNmhb
 BW5nCMPpv0rwfHFyC8cVxTgyKZg==
X-Google-Smtp-Source: AGHT+IF2Gy7j7xlZX7ZcXrKTjpYDxjNeZX+PtdulebMjA+MHwQklgCeF4Mu0W343QyOKLNKU5X9zUQ==
X-Received: by 2002:a17:902:cec2:b0:245:fe27:fe80 with SMTP id
 d9443c01a7336-2462eeb004cmr320514185ad.26.1756383227678; 
 Thu, 28 Aug 2025 05:13:47 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 47/87] linux-user/openrisc: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:56 +1000
Message-ID: <20250828120836.195358-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Move the target_pt_regs structure from target_syscall.h and
rename to target_user_regs_struct, obviating the comment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_ptrace.h  | 13 +++++++++++++
 linux-user/openrisc/target_syscall.h | 11 -----------
 linux-user/openrisc/signal.c         |  3 ++-
 3 files changed, 15 insertions(+), 12 deletions(-)
 create mode 100644 linux-user/openrisc/target_ptrace.h

diff --git a/linux-user/openrisc/target_ptrace.h b/linux-user/openrisc/target_ptrace.h
new file mode 100644
index 0000000000..563c648525
--- /dev/null
+++ b/linux-user/openrisc/target_ptrace.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef OPENRISC_TARGET_PTRACE_H
+#define OPENRISC_TARGET_PTRACE_H
+
+/* See arch/openrisc/include/uapi/asm/ptrace.h. */
+struct target_user_regs_struct {
+    abi_ulong gpr[32];
+    abi_ulong pc;
+    abi_ulong sr;
+};
+
+#endif /* OPENRISC_TARGET_PTRACE_H */
diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
index 7fe5b73d3b..c8394e9dcd 100644
--- a/linux-user/openrisc/target_syscall.h
+++ b/linux-user/openrisc/target_syscall.h
@@ -1,17 +1,6 @@
 #ifndef OPENRISC_TARGET_SYSCALL_H
 #define OPENRISC_TARGET_SYSCALL_H
 
-/* Note that in linux/arch/openrisc/include/uapi/asm/ptrace.h,
- * this is called user_regs_struct.  Given that this is what
- * is used within struct sigcontext we need this definition.
- * However, elfload.c wants this name.
- */
-struct target_pt_regs {
-    abi_ulong gpr[32];
-    abi_ulong pc;
-    abi_ulong sr;
-};
-
 #define UNAME_MACHINE "openrisc"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index cb74a9fe5e..40249095f2 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -21,9 +21,10 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target_ptrace.h"
 
 typedef struct target_sigcontext {
-    struct target_pt_regs regs;
+    struct target_user_regs_struct regs;
     abi_ulong oldmask;
 } target_sigcontext;
 
-- 
2.43.0


