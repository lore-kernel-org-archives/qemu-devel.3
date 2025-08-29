Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BC4CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNj4-0005ZS-Uy; Sat, 30 Aug 2025 11:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xr-0003LX-GO
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:07 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xn-000352-DZ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:07 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-771f69fd6feso2996523b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506357; x=1757111157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=raLliw9+6K/4QAn0lcXOMniTQTtlGTsbPtgysxv1u4Q=;
 b=Mroq0OuUJ7XQYXzk5ysU611Nroc9hfRjbQuhXxnxBzsAygGOH06HQRwN8qj9gRtfTJ
 k6xSQ1GGHMJUHYQktEZGpamFzlZ4rP6ier92D9UkNhqCfer7j3pbo0z/VpAdwuHLSUYc
 eo0ADAHyHi+RpHfNoIwqDAv91JL3YkVsdiYOb0ls9r1DRKn75TsSLd/D5qjGgU4Uynpe
 I9S08NOcMxiolCw5iTEi9zTGFmTR//VfwC/9h8thwFaECgdBzw7O0M/6HWtiIV49oC2N
 /mGre95bzQ6YELmunNS85Yfj9I8WlUNk9ui2bq44ie695r4AF7Fjk1xveA10HYjsrLUv
 2WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506357; x=1757111157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=raLliw9+6K/4QAn0lcXOMniTQTtlGTsbPtgysxv1u4Q=;
 b=aWgAuv2oObfQruVE5rQIgKGaoWboJJAyBKE6TzdjHFUvfAy0j6GX+OhotlewJJrtFE
 SE7QhwpeYLpSDYLv8OWK7qHVKcbp7KkU40xjYbMW+KqBmiVbFv5u5ut1Q/JLFFHtjsid
 KgWOWzkwAOVTShsBNcBWdTZQOMhV9B43GV7NYZr2pQzyBp2f5MbovnwBVnb/Gh2EgqFM
 1a/pT+dmdtw0FLqG4sg56wPZH0RHnC0IDctH/v/wZoffBNmSbTfwM97Yr2dH9zTJyHpD
 Sq5fMhmRO22lnLDBJ4Yss8ii1fpEdYO7yJAk9Hm1lOKV+AhEoGC6v0qQnNa6+VYXOn7/
 567A==
X-Gm-Message-State: AOJu0YxBEaehevApgFnzqDfDntOXbzmQMgxF0579vF6fQuB1NvFTbpfw
 d9Cl362IvInt7oprO4rwDgSJITTTjSHWZ19lVzzBfdDWGe5AWUxuucDbBsNBW9lTGy1RbilitGW
 gL7MQIEY=
X-Gm-Gg: ASbGnctV5sRdmgRGr2qNUS9IVC3s9uBrNF7Te/NLFJEwHBWorDWgF3NiGGxAci6E4w4
 RUkwgbeNCD5V8KU+X5JTLgrbkNUlyK5WbzHjV5NoqHVQn+WTzTpiQ3oyjanYuuxc4SRKwBQWFMX
 THbsOS9uf1bVUx3O7+7Iw4ZkMJ0gKYwylJebZBr8f+CQXgptXJsSD1ES/ZAgy6xOO6nLoQWxVWb
 g8atD4ksZDECQJN4CXStW+JHFIyw1q/0mVnQF5QnusVE4W5y6YUrRK3egiXKu0u+ctyB6zkRi/G
 EgDe1dW29W9EGohT8m3M4jX16MMkBSQ2d58ywf6avkOF/4kY671SCnsfMmxm23/+gmQzlpqqeuA
 Ol5G+TWV++xm6BWAEc6UuqlAvqSfdAJSzT3XONPsdnSy1ssQC+1/GiLwHh7FsX+a/kAHmeto=
X-Google-Smtp-Source: AGHT+IFv0TRP/oTPWigSWCkLJeqaag+vDaGGpqbLjAO1j4WlMCOsU++LG8ghzJ2al8806xpq8h5SQg==
X-Received: by 2002:a05:6a00:188f:b0:76c:2ef8:7536 with SMTP id
 d2e1a72fcca58-7723e21f752mr244025b3a.5.1756506357533; 
 Fri, 29 Aug 2025 15:25:57 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 35/91] linux-user/i386: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:31 +1000
Message-ID: <20250829222427.289668-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
proper structure by using target_user_regs_struct.

Drop target_elf_greg_t and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h | 14 +++++---------
 linux-user/i386/elfload.c    | 36 +++++++++++++++++-------------------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index eb286868e1..f89ac0b611 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -8,22 +8,18 @@
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
+ * is mapped to struct user_regs_struct via sizeof.
  */
-#define ELF_NREG                17
-
-typedef abi_ulong target_elf_greg_t;
-
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_regs_struct pt;
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


