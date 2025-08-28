Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982B6CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbSn-00041l-Gb; Thu, 28 Aug 2025 08:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbS6-0003K4-N5
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:02 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbS3-0007MJ-Bd
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso756304b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382998; x=1756987798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Ulz3SirsMyYujWtkTw6iUw4FJv5gccJWDEX7jaEwA0=;
 b=spDFfu+5aoUFFgkntMchOp7wFLiMuSeUq+zhD9LoOeQaB0dMvEEU2b5nNjuyoxWb56
 AUngdJYeoKPxTeuvWm+D5/rHFlAGkrLWMQsHq7aaMzgORKr+HeuChCk/2+wSHQJfU0wh
 dawaD4+ni5Brdh5CNapBF5zeqf4mC3caW9rvN+dPSBmh4VOOrQKCOhyeqKgc7EfdBJr7
 pV9F/bSdbveNx/TeoYLrRsJkF8XwjSfYQLtLYdn2a2ma7j70NKhO5tdiTj7sofx8HkCw
 VuWE9qdI+paUDosxq8DOBwwbSMY0sjPSPuQoG3iiLyVLxplDZY317FCLsFvdUXiHKtAU
 9eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382998; x=1756987798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Ulz3SirsMyYujWtkTw6iUw4FJv5gccJWDEX7jaEwA0=;
 b=goH4tfK3uDw+ojzpQVZHhpUvJThsmGr5Y/+TniS+juImANzR3OQSHYtH84kAbpi1cR
 TUrd+IyU1vmGtNaXHn8ZXIpj/HmBGg0yTRkT+XGHZ5tW2rsyPbgzGxVN0epJuvSKCZRw
 IVcQGvwWRP3WR8X9gbu00PFFrk9EMx7lQZagHDOe3pOZ9U6G56PTkVQ/qn+0YLF7hfPv
 JEcWniliQti7Lqvfgg/b5UXQ00Aoa9wePTxkF1Iz5BQyhF0/+df54Eg8Fp1ipARBQEIs
 tvIemrgLbewKutwL4hofTgqqYh6QRMRxxhDn9Hs0oeKj9ycoSaPu2teHOhMbNlajbsFz
 Zozw==
X-Gm-Message-State: AOJu0YzrYtbMrCPmWnxb+hiWpzLO6zxgFsvExUTCdshgQv4/m3UkrlfQ
 KMJz3kTTYwGyg0HBKD3cbkQ1DeZX2ccIcDQ6t0V9Arcy4rTEN+rxYbfRC/n379YJzI+2+OVwqgk
 PXqgpGL0=
X-Gm-Gg: ASbGncu8oeIxuH2nMh+CMWQRe1aHEMn0K2Q2QLCfTQwAIGDDdEe2C+e3wrbOJb/8jkA
 MgEUtOb3TAd7JiJNbGsESPAY1vo9LzT0uJg7VbQ56RMy7pUPuqtD0eBN8V9zI5SF6lRuCy5TCQJ
 cL8j6Y/5o5PuS/2bB8YKNlsXRT0J5usYkeVJhsNkbvfnMgR6fHuOOegomxO98//QJF7AD2z2Liy
 mFRkpYBu6ZzqhzueE+r65Je003SZxDjyKEdlpHxea5qX+NdksFgg65pkSXbBiELGfueR6EPivwW
 ojRDG5FP15UQZzuNW60oFRAQeJlIqPTm6A76YVe5byrelUEF0oB0RAfWDlmv4aIWlML3o8dKJny
 Ur8FyK4E4/QHkVuKlaHgSog7NgmsTpuOKsvzN
X-Google-Smtp-Source: AGHT+IGZaK9KBhMCuVKP1aUyl3KgV0YDTrrRJboXePvOObWZxfecEVmzK5QGHV+Wsc87FDZEHnw65w==
X-Received: by 2002:a05:6a20:12c2:b0:243:ada0:3f21 with SMTP id
 adf61e73a8af0-243ada0427bmr3352544637.33.1756382997748; 
 Thu, 28 Aug 2025 05:09:57 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 32/87] linux-user/x86_64: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:41 +1000
Message-ID: <20250828120836.195358-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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
Add target_user_regs_struct to target_ptrace.h, which matches
what is actually used on x86_64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/x86_64/target_ptrace.h  | 40 ++++++++++++++++++++++++++++++
 linux-user/x86_64/target_syscall.h | 28 ---------------------
 2 files changed, 40 insertions(+), 28 deletions(-)
 create mode 100644 linux-user/x86_64/target_ptrace.h

diff --git a/linux-user/x86_64/target_ptrace.h b/linux-user/x86_64/target_ptrace.h
new file mode 100644
index 0000000000..ba162569a6
--- /dev/null
+++ b/linux-user/x86_64/target_ptrace.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef X86_64_TARGET_PTRACE_H
+#define X86_64_TARGET_PTRACE_H
+
+/*
+ * The struct pt_regs in arch/x86/include/uapi/asm/ptrace.h has missing
+ * register values and is not used.  See arch/x86/include/asm/user_64.h.
+ */
+struct target_user_regs_struct {
+    abi_ulong r15;
+    abi_ulong r14;
+    abi_ulong r13;
+    abi_ulong r12;
+    abi_ulong bp;
+    abi_ulong bx;
+    abi_ulong r11;
+    abi_ulong r10;
+    abi_ulong r9;
+    abi_ulong r8;
+    abi_ulong ax;
+    abi_ulong cx;
+    abi_ulong dx;
+    abi_ulong si;
+    abi_ulong di;
+    abi_ulong orig_rax;
+    abi_ulong ip;
+    abi_ulong cs;
+    abi_ulong flags;
+    abi_ulong sp;
+    abi_ulong ss;
+    abi_ulong fs_base;
+    abi_ulong gs_base;
+    abi_ulong ds;
+    abi_ulong es;
+    abi_ulong fs;
+    abi_ulong gs;
+};
+
+#endif /* X86_64_TARGET_PTRACE_H */
diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/target_syscall.h
index fb558345d3..68f55f8e7b 100644
--- a/linux-user/x86_64/target_syscall.h
+++ b/linux-user/x86_64/target_syscall.h
@@ -4,34 +4,6 @@
 #define __USER_CS	(0x33)
 #define __USER_DS	(0x2B)
 
-struct target_pt_regs {
-	abi_ulong r15;
-	abi_ulong r14;
-	abi_ulong r13;
-	abi_ulong r12;
-	abi_ulong rbp;
-	abi_ulong rbx;
-/* arguments: non interrupts/non tracing syscalls only save up to here */
-	abi_ulong r11;
-	abi_ulong r10;
-	abi_ulong r9;
-	abi_ulong r8;
-	abi_ulong rax;
-	abi_ulong rcx;
-	abi_ulong rdx;
-	abi_ulong rsi;
-	abi_ulong rdi;
-	abi_ulong orig_rax;
-/* end of arguments */
-/* cpu exception frame or undefined */
-	abi_ulong rip;
-	abi_ulong cs;
-	abi_ulong eflags;
-	abi_ulong rsp;
-	abi_ulong ss;
-/* top of stack page */
-};
-
 /* Maximum number of LDT entries supported. */
 #define TARGET_LDT_ENTRIES	8192
 /* The size of each LDT entry. */
-- 
2.43.0


