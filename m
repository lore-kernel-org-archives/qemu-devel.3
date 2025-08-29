Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7447CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkw-0003aY-CG; Sat, 30 Aug 2025 11:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7b8-0004Ld-33
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:30 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7b6-0003Zi-00
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7723cf6e4b6so123868b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506566; x=1757111366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlDgwUU7iro35Dw3IbxLfzqVXXSRk7ljNX2J//jX8Lk=;
 b=pQfBJOaWVyce8wnBgUNMPY2ZgIXrmfSLZMjdmdtjDbMsusYjf2SiUpjhvh8azluuSV
 umjWQ08rlJqb9GUiO+JPSZ4xQOvo93x7gUMdIguSla9Rg2WyB/MhvM6iy6DzNOCw90vI
 tpifIH4nmipjMKfpaqgUTsLBsKO+mXqeODKHIkSCSguTOXmKWut6CGqi80APSST1OhN/
 0DybEjP5SW4EIgzQ563wRgUWfBDYXnRS9/GR82mTnmjF8f7633sRiTWUpL+h0cZIxBAE
 olD0tJbFGcSfoJni6MjY1T/ihLyUym4YQDKIWvaV6TsY5xEdy4FMxBmavjxAcvc2WQfT
 4jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506566; x=1757111366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlDgwUU7iro35Dw3IbxLfzqVXXSRk7ljNX2J//jX8Lk=;
 b=a5etd0Wz1FpSPqP4D9uA5S8SdQby6o0qfyuE7XXfTzl8SdnKbEwa7ooeR6Jn4TMzT+
 UzsgZo4LT8OLoKAaiuyBoz7n+WukPm9P2Eq0jJVkk7lP6PUajopDgIawq02E2w+1UzX4
 o6ElvzsRC+tkkwYFHgQKFn/KwHySJn0DTQKkxCOdjO9dQ1YRhGVHfiMAw4nnDbu+PoHH
 6O3ZwzSxJoes6D+Ixxm2Pl4PffjyO671mvk5fNXfUxnIMjxge2IhSoQFwKUthU7Ua6gU
 KEJ8HPdcpAkO48e8LP/cclObdmErm3APsZKl0BwIv9LK1bya5scFvdKs9AKBc5s3JG82
 lxjw==
X-Gm-Message-State: AOJu0YwRRbvDc0ZUGCs7dQATQQ6MAgyvvp5TOHnGB3VC5JiU7IhXK3IZ
 0vfaRimmBw7zxqi4BQ7C5O9gJaGqmcQBKWa5uwYU5e7V488G6yzJNKpQaidtJJhZSRXFj3hPGy8
 U851bh7M=
X-Gm-Gg: ASbGnctMRuCNBCjgKUJzJpPpCzo6zw1quXlVYqmXjjYoWMOo+NFq10jbEG83VysLD+V
 jgW+588OOlN+7w1BK1kDo+DeBWBsSzdwrpHjSUiuLxUJKCYaPDy/V/OmyEiLNCAW0GRsXmbLzTb
 9m4FIUaFhMDEt9JbeSrQX2tApKDTKMH2n17VQO4VGnTS4imWgXqit1SSbcChk9ckcHET9owDV19
 xMfEvCHZs0mAIsbha7EHSf10WB0lRAsLSp5gZYF/dmvNuubbbtoAv4aUDgQYqjiYUe7cejQTW6K
 TF1hYKzWZMrCh4Tj1VPhg43i1AceYdPlZLrEikYN6hJJy9jGM0y9mmCufdg/xRCBXyOWzbWxVgR
 SVfLcW/jh/MUKAEHrWTi8BWt/KMoj/bQuBqNTV7mbojbLxCycA+17H1uXC3xfgSs=
X-Google-Smtp-Source: AGHT+IEiRtXICVGlbnYgCvBpAY9E3iqUaHqBIwhX1IEZLctmfAtdBySfTc5xasB/Dr3lGp9FYWJQgg==
X-Received: by 2002:a05:6a20:3944:b0:243:be7c:2d62 with SMTP id
 adf61e73a8af0-243d6dd4decmr299835637.11.1756506566221; 
 Fri, 29 Aug 2025 15:29:26 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 46/91] linux-user/microblaze: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:42 +1000
Message-ID: <20250829222427.289668-47-richard.henderson@linaro.org>
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

Move the target_pt_regs structure from target_syscall.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


