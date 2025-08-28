Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2C9CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFj-000211-UD; Thu, 28 Aug 2025 13:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVg-0007df-RG
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVd-0008D2-4P
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:42 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2489c65330aso8535265ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383219; x=1756988019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxZ146uoWLbzcq7GV0ARwloQB6KyoHpZe1NQNrxqKfg=;
 b=EqNdAhnXsJbw5kEpSo2GfNoGBsy5UJwRfd9S4HC03vo26f7TaZHCc0x9EfL3b0xz3J
 6eBNAfck6YlkUJl4RjSG4B64VGZ8q9+Vs5u8dmtrOkMo4138Leh8mJwKeV2AERi4J4wy
 jKZZOKjA53XeYktlUC08gOI4u9Ul982Q8ikl6gzdRDXAHptUr1VLfmjlzoMrGzm1Xeg5
 Nc3PW9B4F+MKULv0nDmje26Ei2ioE+OnaMLMitI98is2IpuezZIxfKnosFNyKeE+NlfE
 nDP3A5GysRUg1zoVnj4uM6nM0IXgVETYlirEqOUm39hu3b7IbGKfbnnDycMELX8aYrHZ
 UK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383219; x=1756988019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gxZ146uoWLbzcq7GV0ARwloQB6KyoHpZe1NQNrxqKfg=;
 b=tmUahlr9GlSGBdkc9z7Irxw5Lnes/Rj1lRDqC1AszFOYb28JrWpx6vmfGFhMJ+In5L
 zyBBYwARwdNIjLLGxClFg3s2iveCduOJW93ojhqLBLM9o0M5xYVTSlHPXPz/lf6QZX90
 MueivMMCXCKbSvoPigF+HgqIF6JsBlCQsE+AxdyrS+N5SAIySCdWhypaxK9FwYBOx5xG
 Q84if63XgSt8q/iuHcwj0/7KaylunqT7xseODW5nKv6TAA9IIy79xqnisf7AZ2vjPTry
 fWGfv8i6iI7zcQID3APt3bc5CyPwXCUkKzqr3HlUCh4VenMnTB+EhHEHZS8jbplC7RrD
 EnuQ==
X-Gm-Message-State: AOJu0YwQWHFapYs4TxMP0xmFBzbI3ELg0PF17Istz0QvN2jV24yWoXDv
 6m8ixPuqCNhf+kQbC8xmtHvAjvzKjuzIAMWEKBfceTLUjcmV59LW44W1YciYG0c8qwodhw9+o9a
 JLWQtqNU=
X-Gm-Gg: ASbGncsEjLydRc2+3BfsuwVQYoXBJ5pxbXtWPDEZwjgNGWLJIGLCvxfY9DdbwKzWUbA
 QoxV8QhIOwDpDpD0E3kUM0enzdtLsviIzoh3d3J9I/fpYWFQUWjAPW7coiFOTM4PK3108qUTGq4
 BLU/CRfUElK++WJJhyLo8hkmj8yhPc92N3DLpjGTEoawH9C7BsrNnVL4517MalFeHEB5O1OeurV
 gM0xk9OO4rtNXKTpcxlIpmxdFBNxf8/r0f76NBG7gb4q9pGRSVWu81lpL2w39/0S4lujxwzVjJp
 Z4rwkqbONSQT7BJXJEHG+26Jt1OXQNNEoljP+F8dsDR7nNARmrMsxV5bTkUfBDtyAggtG5u7jCc
 sDkVlKuzJ1aFOnvuIhqDFn7PAPIjyav8IcXOh
X-Google-Smtp-Source: AGHT+IFWo2ty1BndtontY0M31/O/8YKB1bwECb9tFfF/+fFhw/4a6weyR9Aqjknzn4iZy5ESVYLLzg==
X-Received: by 2002:a17:902:ecc6:b0:244:5cde:d384 with SMTP id
 d9443c01a7336-2462eeb4090mr332794745ad.31.1756383219089; 
 Thu, 28 Aug 2025 05:13:39 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 44/87] linux-user/microblaze: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:53 +1000
Message-ID: <20250828120836.195358-45-richard.henderson@linaro.org>
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_elf.h | 11 +++++++----
 linux-user/microblaze/elfload.c    | 14 +++++---------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index cc5cc0477e..56de77d4f3 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -8,13 +8,16 @@
 #ifndef MICROBLAZE_TARGET_ELF_H
 #define MICROBLAZE_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-#define ELF_NREG                38
+/*
+ * See linux kernel: arch/microblaze/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct pt_regs via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
index 89250dbd63..7eb1b26d17 100644
--- a/linux-user/microblaze/elfload.c
+++ b/linux-user/microblaze/elfload.c
@@ -11,18 +11,14 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "any";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
 {
     for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(env->regs[i]);
+        r->pt.r[i] = tswapal(env->regs[i]);
     }
 
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(mb_cpu_read_msr(env));
-    r->regs[34] = 0;
-    r->regs[35] = tswapreg(env->ear);
-    r->regs[36] = 0;
-    r->regs[37] = tswapreg(env->esr);
+    r->pt.pc = tswapal(env->pc);
+    r->pt.msr = tswapal(mb_cpu_read_msr(env));
+    r->pt.ear = tswapal(env->ear);
+    r->pt.esr = tswapal(env->esr);
 }
-- 
2.43.0


