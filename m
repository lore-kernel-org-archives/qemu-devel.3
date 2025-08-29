Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F4CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjJ-0006dE-Vq; Sat, 30 Aug 2025 11:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7b1-0004IX-9q
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:23 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7ay-0003Ya-Ui
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:22 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1101894b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506559; x=1757111359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3bbg5AFbtq7L124G12DBzxKL6BZSQnnF4rpCn0+fQQ=;
 b=DMXgba/Y32nvdowNn85vQdT++nRmNTiwUALWdkF0CabDCufV/XqTIlHaGFTUKJfwHB
 J6APvuNtMFQXznKEfgEXfTTzjtW46m9nRDYxirq/c9YOymjdTFzfu/BJ1OfUDtXg0tr/
 S1Uun8EuNKfCoLUEVf6nSBgu0GQ0OyEVR7TgKdkWMLEFGyrhdO3fSDX+APEwieNF8+4Q
 tplkWrCJCfw8EwedZu08rGQ4JApD+w7ct6xXKq6e6hQXIniH4Ghs5TpLntxpOmHVlUyE
 IJHRU1vhPeVDjjZP5UC1VSXM8IUqYpjWIjJXXcKR8BP1Ot14rnj9nAMvXKbjOaorwCEq
 zInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506559; x=1757111359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3bbg5AFbtq7L124G12DBzxKL6BZSQnnF4rpCn0+fQQ=;
 b=bu4huavl88Nz9eug6NpeFo52Aj5Y2aTsmTyt3J/dZpo7USiYufB5p+ckmnBu35Kpyd
 2Kfse7pKPpr4lqXx+b00elf+tBrAuASTE+QKNr1BnlN0ugvBkAA8/swsuWZIa5PEEfN3
 stsurGDjBA3rzE9rBxXYZ0RHq+ZyHAvVR08NsCnxKQcY8q+qXPLeBXEt4ZIeOCbTp57N
 IWCKynWBFDIYrMqoKAhR+zHtH1qkS1nNNKCIjpmuZb8yD8+YO6u0Ly6kFWLX1GPmlE18
 L62Mc4QLpwzE/gNH6QiuuT1VpweHlnO3XS931g0sjClXzWnm39CUl/Wj3sUXuEgJ16EK
 pCvg==
X-Gm-Message-State: AOJu0YxhTExXCdMdIY9AyTy/lKfNebmBlODU0oA2eMRKhObjDB1hEZbp
 XysIcsk2j3/vxZt8dvacc+wYEp/o0/wozXTVvKZU0FmmU8YYUfrXRmS5QEl9PeZOKxGIbHVBi6b
 bGWcyER0=
X-Gm-Gg: ASbGncukv48EKO0RbGSj965vcLUuYv8CRhwim8/ZN88lA09hd8sIPyV+5xYLEZsYc5v
 h2nkkpUruqyIZsiSIqJZq6vnV2uNmRN86z6LV+6cd6VFLv9ZDApWpuvtG+5bf6ymNT49wAbIYKU
 LyRYOCV4g7jTJ1IzXu3PQr5UExN9TWUgRltmCZ0DXInuNXxCKxfR9L6vT1KSvxijexqAg4ylDc4
 +PA4tMM1KM97NPoxe6ktdUx7IQRdWG/lAha8oViuCriVs+PHwA7buqOTJlXCH2DMfIhKdr95i18
 8QWfrXDYHYeR+5U250NJkG9CRrDJ3FtgPCQzUzhK3ywdohmLNIOEemPhPMnwpw49OasC1G8yCrq
 NbbE2In1/75RRsl+G/aIrHl16k7bAHg4xuX6BMQzoDrFuPCRRdK1CkbGB2n8BF7UIZh5zGqkGRQ
 ==
X-Google-Smtp-Source: AGHT+IHZH9yj4SO2nAArUVD5Zzc5trfglirqg9hnQu/xVYDW05WmMa4JJ8bupAaqQ/WTqiHbWJHZvQ==
X-Received: by 2002:a05:6a00:138e:b0:76e:7ab9:a239 with SMTP id
 d2e1a72fcca58-7723c5c841bmr974296b3a.16.1756506559445; 
 Fri, 29 Aug 2025 15:29:19 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 43/91] linux-user/loongarch64: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:39 +1000
Message-ID: <20250829222427.289668-44-richard.henderson@linaro.org>
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

Remove the target_pt_regs structure from target_syscall.h.
Add target_user_pt_regs to target_ptrace.h, which matches
what is actually used on loongarch64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/target_ptrace.h  | 15 +++++++++++++++
 linux-user/loongarch64/target_syscall.h | 23 -----------------------
 2 files changed, 15 insertions(+), 23 deletions(-)
 create mode 100644 linux-user/loongarch64/target_ptrace.h

diff --git a/linux-user/loongarch64/target_ptrace.h b/linux-user/loongarch64/target_ptrace.h
new file mode 100644
index 0000000000..2578e09207
--- /dev/null
+++ b/linux-user/loongarch64/target_ptrace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef LOONGARCH64_TARGET_PTRACE_H
+#define LOONGARCH64_TARGET_PTRACE_H
+
+/* See arch/loongarch/include/uapi/asm/ptrace.h. */
+struct target_user_pt_regs {
+    abi_ulong regs[32];
+    abi_ulong orig_a0;
+    abi_ulong csr_era;
+    abi_ulong csr_badv;
+    abi_ulong reserved[10];
+};
+
+#endif /* LOONGARCH64_TARGET_PTRACE_H */
diff --git a/linux-user/loongarch64/target_syscall.h b/linux-user/loongarch64/target_syscall.h
index 39f229bb9c..f7ced7b2be 100644
--- a/linux-user/loongarch64/target_syscall.h
+++ b/linux-user/loongarch64/target_syscall.h
@@ -8,29 +8,6 @@
 
 #include "qemu/units.h"
 
-/*
- * this struct defines the way the registers are stored on the
- * stack during a system call.
- */
-
-struct target_pt_regs {
-    /* Saved main processor registers. */
-    target_ulong regs[32];
-
-    /* Saved special registers. */
-    struct {
-        target_ulong era;
-        target_ulong badv;
-        target_ulong crmd;
-        target_ulong prmd;
-        target_ulong euen;
-        target_ulong ecfg;
-        target_ulong estat;
-    } csr;
-    target_ulong orig_a0;
-    target_ulong __last[0];
-};
-
 #define UNAME_MACHINE "loongarch64"
 #define UNAME_MINIMUM_RELEASE "5.19.0"
 
-- 
2.43.0


