Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F82CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTw-0005nt-CU; Thu, 28 Aug 2025 08:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSH-0003of-GM
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:17 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSF-0007bk-Hj
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-771fa8e4190so678506b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383010; x=1756987810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQ8MCfzgPcpFB4Sp5HSK1NZMfg3qe4D8rF6fwIfMWoM=;
 b=Ow7DEsgU4fYhNFvMcOvc24G7xhBCPWGiYBgWMAccuXO/TioHKWuwN1HdYTWVo0kSiH
 gNP+RRtjlar9eElSqWjj9dkCuaa7NyAOBpM/0KS//0X7WQBHzMrgHKoo1gRGJLQDFYnU
 oRFbMsgt85qU32bJqzTxp+42fyUinnCUYIOOAzgzLwYkPtYWLc9jwsDWUdNJ+PEAO2X2
 I9dtrZiEaI8wNbh+32WQsLD/0IhemoONW6Iaq3Q4Ox3iRZm0oU48VHN1kbH49FVc+sHV
 6rQYOAiOJNUZyxZG9H08ocj+6McXTdUbymAEtgBO0UQoFBHkSRgeMBEIiPcPDqvmLgal
 h0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383010; x=1756987810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQ8MCfzgPcpFB4Sp5HSK1NZMfg3qe4D8rF6fwIfMWoM=;
 b=VzW72lHdijrYeZcbTe1wXdbje5WmDyK5NzFndorF7V1MsnHN1uXiDcPve9ttqpO9jD
 L7cb0rPskcEMCUslQTP0F6UWOuheADwcUnrfdGjlPJ6oYfpgIxUx4cQEA6l7SbOyoyx3
 YcYU4wbRhfoolODHAqBXgX/FkI96J0/iEDt7/+tTNsaEf+T+J0UiGpB2w0PjMTjQeb86
 G2eUo/wFqPhmVoEigO6X9NhOXsEDEz5iD8tg4KPEXqO5n9V5kPNOJH1zY7+EV7QP5ao4
 KcpypVNFyE96pcf9rJX9GhoO0GRixqh5gMVmE3vlvngoE/YEYndo5AERd02A42msodzY
 467w==
X-Gm-Message-State: AOJu0Yw/jb546RzzcJCYoBl6PoVx7BBmKliKMaa5Cio2KdlGBdBGPUg1
 tvlNJW2pyRfeEe7NSBFnV75GLHsxSOh/V0GRcgJ6/MuulsPORDk5xa/tBv3l1hSOqcMzoTZnDmB
 Eakv0GeY=
X-Gm-Gg: ASbGncsjw77A52G1YoAklMq7wcen/WYXIIJRm3sCMfc5gH7ECY+mRfw0ulSacWZdiE1
 J4evM1LrcePzRCJ9MB3nNeX+99Pfgt+uaIycEE3gWNgISMDG9BxbDH2QQlt/twsFgy0e/3BeGRy
 zhK0lf3oWZF3ZRDPgVIwbi0EZGq6fa2HPvk8Qtw5YKCsob8xiIBjPmQ89w366U+up/T+JxMdTZR
 fqS2OqPwuYPQ1YHSZUs3VykiIs4vnTMrfwSOZA0iJWLwX+i3mQqKztjK0/ZCw2a5A8Ls5x1YUyC
 fPlRoERrwZtGjUsyzDU4dlt9Vzdu7BAc0kE0ECoQzCFx25uchdDhlNMfIaRAj8hECNXcSpWyCca
 LwmLmLaykYqvJgdGn/daw61GQW76BH79Pukrd
X-Google-Smtp-Source: AGHT+IE2EfPxmQCcWQa9DYgi0N3XVD7sJr/8RIvYSReOqU/cRUchYAGU8pkoVflOh5AYqZ7MPaAquQ==
X-Received: by 2002:a05:6a20:7495:b0:243:78a:826a with SMTP id
 adf61e73a8af0-24340dca336mr36236201637.48.1756383009619; 
 Thu, 28 Aug 2025 05:10:09 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:10:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 37/87] linux-user/arm: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:46 +1000
Message-ID: <20250828120836.195358-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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

Move the target_pt_regs structure from target_syscall.h.
Replace the array with proper structure fields.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_ptrace.h  | 16 ++++++++++++++++
 linux-user/arm/target_syscall.h |  8 --------
 2 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 linux-user/arm/target_ptrace.h

diff --git a/linux-user/arm/target_ptrace.h b/linux-user/arm/target_ptrace.h
new file mode 100644
index 0000000000..1610b8e03c
--- /dev/null
+++ b/linux-user/arm/target_ptrace.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef ARM_TARGET_PTRACE_H
+#define ARM_TARGET_PTRACE_H
+
+/*
+ * See arch/arm/include/uapi/asm/ptrace.h.
+ * Instead of an array and ARM_xx defines, use proper fields.
+ */
+struct target_pt_regs {
+    abi_ulong regs[16];
+    abi_ulong cpsr;
+    abi_ulong orig_r0;
+};
+
+#endif /* ARM_TARGET_PTRACE_H */
diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index 412ad434cf..8c4ddba717 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -1,14 +1,6 @@
 #ifndef ARM_TARGET_SYSCALL_H
 #define ARM_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-/* uregs[0..15] are r0 to r15; uregs[16] is CPSR; uregs[17] is ORIG_r0 */
-struct target_pt_regs {
-    abi_long uregs[18];
-};
-
 #define ARM_SYSCALL_BASE	0x900000
 #define ARM_THUMB_SYSCALL	0
 
-- 
2.43.0


