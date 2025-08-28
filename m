Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0DEC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTw-0005kB-3L; Thu, 28 Aug 2025 08:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbS5-0003GG-1M
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbS1-0007Lk-Vk
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77057c4d88bso802848b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382995; x=1756987795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5o+NPIq0hlx8Dl2K6/MYJXUMPiwU96+d4UnYzAmv86s=;
 b=ekUC6/oHOZako/YcSEz3Jxg+r/v6738DR9FZdWZKoQDDkcL9CPzMM1cm05AZV3TfjU
 TSt9RG/l+SKMt8/k6PRgyA//cB0linZDBJmOxF/utDOQwAh1Wx1cliMbBrFF/qjXnZUm
 cwgYkfJ/MgKG17b85UL0RdOAQOwadnKR7zsLd0cPE9R0+FBoWpdDJ7AYFJfrFtiOdK46
 aUcuL/PqxyzKo9eQOEoytJ2zR3ZZzbGTU1J5PvTOP/BtPWV7Hb2Ov8I6w7XLSaEcmIBO
 WTBlqpa1gatR+KnPig6L13w7GNc7eEfYvXmI7PrvF2jXb0/gU2RRjDCvnrM8kTbpgNOY
 DfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382995; x=1756987795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5o+NPIq0hlx8Dl2K6/MYJXUMPiwU96+d4UnYzAmv86s=;
 b=NL7nJtZSXzYHeWBr9+9r1uu4I9JcQddaj/8SkwO0qh6qA7D0MeZ7urL9DbStUdToav
 oPgPh4E1PX624wbn1ujGqN99oQe0FUrHB9aWkTuRv6m3qZidjf/JVOocSJ7g3nYWTMd2
 UJvbf5q4qiQSJ7b4Lp/oTZJxl5t89MmzLipLyEcSLmTSZ4oy7wdz4vuHFKew2s4c1/FJ
 ziLx7hfJd3i2HKDLQimoFecW+aPXUBnqxWqnwAKXVPSrKHKpABDYwg0OxY3v+QqCRqqA
 ItQF4D4inDIr6o7R9z3HmV2mkqt2EoOdVEi912ffcfzxJ17Pk8E8Fo3xbaXWg1QhKSCr
 Aaww==
X-Gm-Message-State: AOJu0YzrI9DBatEtdORyA7XJc7Uk4trGbRd1qoSqpYuxBLbhra2+wkhj
 Y/+78tuzDZ/IuVGRkR82UIihCELuvIZZLo4VtPWjWciER/GZCgpQ2gocSL4/N+cTiTueExEywrj
 pmRvE08k=
X-Gm-Gg: ASbGnctmpIw2tm5DLaUM8PQWj22PuIDVGbuhUDR2QsleysJWjGbcENKN6IMSHfHX2AV
 jX0PwqcGUDonj0p2IAF5WJ+qzu+OGMuiJIvyaFBOcvTzaoNM7ZhU3PBBrQJndRlSYIByq6tolMg
 rg20cRcNYPNtAeVIR+w+jmY/ofucoGZFhiyEtJPIjVpQsKshg0awRZPepDQJluJfC+CiEHURNbw
 YwCApdO5bkfDhhGo7PL+/A1EeAlUavpmHMkAqWwVs27rwlRUJop1doGgnnChXNOJ2KWgVEGtpr5
 kZ/eEA6dfN9jupJVw+YHjOntYH9JS3m493pqjycmjY12mjTh0LEmzmBIx3OSNT/n2lnYG/uUmpI
 LWSjGSjbOONdJpWlUeCNJEbVwWA==
X-Google-Smtp-Source: AGHT+IEMfRk42H3N1mCpr0qffmjrlgFbqQFj5/pfjvTOYp4juAtgsf7IBiPhBsX4sFzt00DND49fqQ==
X-Received: by 2002:a05:6a21:339c:b0:237:b53b:64dd with SMTP id
 adf61e73a8af0-24340b8daa4mr30851025637.11.1756382995254; 
 Thu, 28 Aug 2025 05:09:55 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 31/87] linux-user/i386: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:40 +1000
Message-ID: <20250828120836.195358-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The comment re ELF_NREG is incorrect or out-of-date.
Make use of the fact that target_elf_gregset_t is a
proper structure by using target_pt_regs.

Drop target_elf_greg_t and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h | 15 ++++++---------
 linux-user/i386/elfload.c    | 36 +++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index eb286868e1..da1e0a09bc 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -8,22 +8,19 @@
 #ifndef I386_TARGET_ELF_H
 #define I386_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
- * Note that ELF_NREG should be 19 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
+ * See linux kernel: arch/x86/include/asm/elf.h, where elf_gregset_t
+ * is mapped to struct user_regs_struct via sizeof, and that the
+ * definitions of user_regs_struct and pt_regs is identical.
  */
-#define ELF_NREG                17
-
-typedef abi_ulong target_elf_greg_t;
-
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 279aeb8116..26b12001a3 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -25,25 +25,23 @@ const char *get_elf_platform(CPUState *cs)
     return elf_platform[family - 3];
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
-    r->regs[0] = tswapreg(env->regs[R_EBX]);
-    r->regs[1] = tswapreg(env->regs[R_ECX]);
-    r->regs[2] = tswapreg(env->regs[R_EDX]);
-    r->regs[3] = tswapreg(env->regs[R_ESI]);
-    r->regs[4] = tswapreg(env->regs[R_EDI]);
-    r->regs[5] = tswapreg(env->regs[R_EBP]);
-    r->regs[6] = tswapreg(env->regs[R_EAX]);
-    r->regs[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    r->regs[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    r->regs[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    r->regs[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    r->regs[12] = tswapreg(env->eip);
-    r->regs[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    r->regs[14] = tswapreg(env->eflags);
-    r->regs[15] = tswapreg(env->regs[R_ESP]);
-    r->regs[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    r->pt.bx = tswapal(env->regs[R_EBX]);
+    r->pt.cx = tswapal(env->regs[R_ECX]);
+    r->pt.dx = tswapal(env->regs[R_EDX]);
+    r->pt.si = tswapal(env->regs[R_ESI]);
+    r->pt.di = tswapal(env->regs[R_EDI]);
+    r->pt.bp = tswapal(env->regs[R_EBP]);
+    r->pt.ax = tswapal(env->regs[R_EAX]);
+    r->pt.ds = tswapal(env->segs[R_DS].selector & 0xffff);
+    r->pt.es = tswapal(env->segs[R_ES].selector & 0xffff);
+    r->pt.fs = tswapal(env->segs[R_FS].selector & 0xffff);
+    r->pt.gs = tswapal(env->segs[R_GS].selector & 0xffff);
+    r->pt.orig_ax = tswapal(get_task_state(env_cpu_const(env))->orig_ax);
+    r->pt.ip = tswapal(env->eip);
+    r->pt.cs = tswapal(env->segs[R_CS].selector & 0xffff);
+    r->pt.flags = tswapal(env->eflags);
+    r->pt.sp = tswapal(env->regs[R_ESP]);
+    r->pt.ss = tswapal(env->segs[R_SS].selector & 0xffff);
 }
-- 
2.43.0


