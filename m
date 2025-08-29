Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A82CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNk7-0000KC-Nu; Sat, 30 Aug 2025 11:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bW-0004Ue-Ce
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:54 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bQ-0003dq-Q9
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:54 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7723cf6e4b6so124029b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506587; x=1757111387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3onby7ODl2TCu42msIZ4L7gUXb7Wcm8sz19Cp/OMZ60=;
 b=gzi7wQsX+trfK73h6ZkLAKMjrUAvXJ2ujQdTzxDluT/Ey6ulVerEvOaozRGFjEMAZY
 PjuignkV/2Q+TWcdymayRdy2ErCQrNYO/e3sadAqQ4vGU9h0fAPiPCPMOJidnmnY5lc9
 pok3HY2xouLVVjwowD+/t9/Thtx7yuqwGQEtBlk9snGtb6HN58uiRtgxuEZH2ZDasmsc
 VUQBVIygP6x0pTe8JIXvB6mdzvOBxZWk+TYDmfLd+tnRNH3k9vUZn3sODFteY+ajsPLk
 +CIWF5sLYNFkJFS+RmuNHa9Dd5kBFcA3xXMJMDhVJSCdwRMIT6/jOUXsnS8HwVpxG7Rk
 EnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506587; x=1757111387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3onby7ODl2TCu42msIZ4L7gUXb7Wcm8sz19Cp/OMZ60=;
 b=FhjFSEI98ShMqWeLldrFpzTu6ZcviW63Nvk4ZyFn5acEPKRhkAlL6vfkg7rPewcftc
 I5VocoI2aKyzYqi3Lf8uh82jsHkzHFh/oXchRzcT8J7OB8n5MqH2Rd/SIZAIsmJFszn1
 mlCBfoXGObSlEyOkeJvBkBjuK+mKBNuetm3HLkg6fuTH7E8dOeEYFMht+a+NCDdJ5oSh
 KmEq1ksSPzhw71ofRCbUT9+nk2wIgnKXLIom/MO8gIcvhTcr7AjDdkFZiojFuL0C/zJe
 6tv2502sZBVvb0wip+aRBqOz/XEsLl83kWYecS00nvYIJx2vkKNNwH6bWHy3DrvgNwqG
 lVGQ==
X-Gm-Message-State: AOJu0YyQ5oXgQ+0sYgo8pKs2ejwKW9+9R2tI/HpfOIpuZWahO6VxEvEw
 rN2PqpKnD4xRsGAzYNKbXUkrsZ7ZQY22ai12eI462rZlXnaepCRU1QhqIHMflPqMdmektZ3aYN3
 /v9tkW1I=
X-Gm-Gg: ASbGncup9pOA83JoMZgKvOKUGWRzwyJKIvNAbxUNFc8w5wb+xUQSujoSrvdKIceVn4C
 x3Sn2ekxzw0QwS8GwrAFjpBYD+varJX6NzVTLrCx9fWdIC0FDqiye5uT4wIFAksZpM+J7eY11Bk
 K3VHtKkFIM95sP91BqSP4Pik9iDYCKHkE02/H6XvcAUOXt+l2ETkHb/p2QA9EwUKr31Wmvb7fpc
 WoG1w6ubGbdqJepIWIAZWmARcwJsEPtC3OgLgO+2JHXq9CbhhrgyNN+wdtUxb6rlGkklf6/lq8N
 dTrTSSBPW0/4rWOVObCjxDOoIxZyD7HOyDVwgk6g/locmgQr+r7BbwBesuVdUcfLoNzH4xgDsjk
 m/xQ/67lnqMlzxW8aMwcxxTYUuRSDHGb544CTq1ct8hpE+CPh8xF80/cRTy+lhhGi6srLvp7KLg
 ==
X-Google-Smtp-Source: AGHT+IGe2431O6pHDl5KA933x5Avz1pR5Zn940gDknHMBnfvEebVlzWxw+t4iYKJiTCHCfn7klo+HA==
X-Received: by 2002:a05:6a20:72a8:b0:243:78a:82a4 with SMTP id
 adf61e73a8af0-243d6f7e69cmr317879637.58.1756506587363; 
 Fri, 29 Aug 2025 15:29:47 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 55/91] linux-user/s390x: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:51 +1000
Message-ID: <20250829222427.289668-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Move target_psw_t to target_ptrace.h.  Note that abi_ulong already
has an attribute for 8-byte alignment, so there's no need to carry
another on target_psw_t.

Remove the target_pt_regs; add target_s390x_reg to target_ptrace.h,
which matches what is actually used.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/target_ptrace.h  | 18 ++++++++++++++++++
 linux-user/s390x/target_syscall.h | 22 ----------------------
 linux-user/s390x/signal.c         |  1 +
 3 files changed, 19 insertions(+), 22 deletions(-)
 create mode 100644 linux-user/s390x/target_ptrace.h

diff --git a/linux-user/s390x/target_ptrace.h b/linux-user/s390x/target_ptrace.h
new file mode 100644
index 0000000000..a5ceb75a74
--- /dev/null
+++ b/linux-user/s390x/target_ptrace.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef S390X_TARGET_PTRACE_H
+#define S390X_TARGET_PTRACE_H
+
+typedef struct {
+    abi_ulong mask;
+    abi_ulong addr;
+} target_psw_t;
+
+struct target_s390_regs {
+    target_psw_t psw;
+    abi_ulong gprs[16];
+    abi_uint acrs[16];
+    abi_ulong orig_gpr2;
+};
+
+#endif /* S390X_TARGET_PTRACE_H */
diff --git a/linux-user/s390x/target_syscall.h b/linux-user/s390x/target_syscall.h
index 4018988a25..f01f9a0baa 100644
--- a/linux-user/s390x/target_syscall.h
+++ b/linux-user/s390x/target_syscall.h
@@ -1,28 +1,6 @@
 #ifndef S390X_TARGET_SYSCALL_H
 #define S390X_TARGET_SYSCALL_H
 
-/* this typedef defines how a Program Status Word looks like */
-typedef struct {
-    abi_ulong mask;
-    abi_ulong addr;
-} __attribute__ ((aligned(8))) target_psw_t;
-
-/*
- * The pt_regs struct defines the way the registers are stored on
- * the stack during a system call.
- */
-
-#define TARGET_NUM_GPRS        16
-
-struct target_pt_regs {
-    abi_ulong args[1];
-    target_psw_t psw;
-    abi_ulong gprs[TARGET_NUM_GPRS];
-    abi_ulong orig_gpr2;
-    unsigned short ilen;
-    unsigned short trap;
-};
-
 #define UNAME_MACHINE "s390x"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index df49c24708..96d1c8d11c 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -22,6 +22,7 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 #include "vdso-asmoffset.h"
+#include "target_ptrace.h"
 
 #define __NUM_GPRS 16
 #define __NUM_FPRS 16
-- 
2.43.0


