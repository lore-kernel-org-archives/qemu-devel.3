Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789E7CA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNl3-00041b-Th; Sat, 30 Aug 2025 11:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bD-0004Nj-Dt
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:35 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bB-0003aY-3r
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:34 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7723cf6e4b6so123900b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506571; x=1757111371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sa3b2TMivSD6XM1tsMuoQHxNMdNW+gXzNJQ+o4QofYU=;
 b=TjGjwO87K6+IEaBvP1dugeIOtl3VXDnuLMGhkTNfKmqiHlT1+tcoSH8CamnMFbmQY1
 tdCluo2RzARwNnlNFyR+Yy43S43V3EYBDzIhof/FIGSR9j1O6yu+LMg5EgsjRi9kWPAO
 eGgiqprkpWZ06KttX7zMdBuWD6AosPBHIC3T2fI850zFve9w1widaAa6X3YQHGWtP+fN
 RbJN/f6k/2q4HdNMf0q/QsOLozGqsLTEGw8R/ggv69pWgzQ0F6lUcOA+vZAmJDlvkvb2
 PS14QEdWH+giabeC6Vzga7oBtMVhrAODs+wPUcwwUFVK9DwJ6vuBRmYrGk51/VSUpUMW
 xYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506571; x=1757111371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sa3b2TMivSD6XM1tsMuoQHxNMdNW+gXzNJQ+o4QofYU=;
 b=SXV6Eq7frXW8MuufyW00F2vO28Vc0lSDTcvh2+T3zddjPnf0uRkpu4C3s+edJnr43K
 kzT7PW0exPIj+YCgGYVpNiHfnx1oGIEamfJt4eWXJm648+jFD5tYRmiYVaYaYyL/+nUh
 GF8RBdB6FXCqXyfjHUiSIf0a/k7y9S/nOSTtC3tj39Yw8BhDSII3E+jNhy8j2k7eC47W
 NE3himMqFNocvN/wtPeRrxriU7vb9gc7/OGzAozbJ03wERk/D2/rZkYO3RTMuEHdSYOL
 WyC0SvxaOFQsez9PjOftJjEe5a9ztpPaRqqkZX3ljfOGNwm5cLSFmASL8Uh2TwONfvF6
 ZcMg==
X-Gm-Message-State: AOJu0YwA4FFKBEjPBedEmlkrmCko0S1SM6ElMFBeJ9mt3laj72hOp+Qn
 5QojNJHXg704fjv9hYgmP6wS5Xium73L8IJQqkDeBTdnq8qD6AQ0gt0dNufqrThKStaUWRiuS6l
 a43zp3vg=
X-Gm-Gg: ASbGncv9xcWISrHisJlHrOiW6E0Tgo66XN57D61Ppg5N+a2hm/mYHtzIt6Usqrao/+T
 WWhQEwiV1N9shTjKY+iSbZZ+J6Lhw8Oc7oYWLxzYPyEgBP0ng72169RSo9XXiiGJfU7850CsjGo
 h+2+WKmemLWplEHn0cU10vE1+ITDepxrjnCbhj9b1r4m1rsvq4GY5T2q/JHC1Wj5qB4gu8VykJn
 cacPKW6woQRdNSHbj4xFdb/BuXSJPpu1AH8FPXkvVw3OgfaJxR25YKOz1tNHFwUO7LnPpXGdyAb
 u8Yf6hxFoBHPtoc6ZdhQMffNC+r0uVl3s1rYDikCh5vGbRzJmN4Srl1QiVvfWlIXQ99ghGLO7b4
 LfDx/UrU1yesm6JZaZxFBp1EVMk0hSr35Pr+Z6SsX6Zr9AhzFLIoNBUfN+JooG5A=
X-Google-Smtp-Source: AGHT+IFjL7GGVQWYbRsmQQvFaR0YcRM55PYADd6V8BiFEPpKZ1A7UT1PsubbI67GMXtDZxxv+Y29Uw==
X-Received: by 2002:a05:6a20:42a3:b0:243:d471:51e1 with SMTP id
 adf61e73a8af0-243d6f37f73mr284392637.42.1756506570826; 
 Fri, 29 Aug 2025 15:29:30 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 48/91] linux-user/microblaze: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:44 +1000
Message-ID: <20250829222427.289668-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


