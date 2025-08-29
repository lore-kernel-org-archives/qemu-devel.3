Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DECCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkL-0001tl-WA; Sat, 30 Aug 2025 11:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XS-0003CY-Lp
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:42 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XQ-00030p-OF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:42 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b47173749dbso1933650a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506338; x=1757111138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+Vi/O4BRs2S0eMYdKKxaAFZ166C21NyMikDLosj6Q0=;
 b=VJCKqbitnjyiT8NkSAagmrS75ZZZRDRuQyZdzmR7LqhxYI34T65fSPKPaMsQlDYhvU
 IbkfkTuTu3DGh/gLxQY/ms/nm8rqpMcesmRRqzOIsEcF7VPoTegxzCx9UNvJuEZi0G1R
 aEHF75Fl2URHifE08nluh7nV8V+Oj2OCLXNh8hm9ZB08zpXXyTNhgvOP2eEhF4QdfQLb
 /AcAdvXz7AM7se0I+H8A4SmikBkkr3XrOXlxqqshjguwwLIvt5oaHSHNgbPIW2R1JaE4
 Ks/l2b7LWAUV9qEpSyGBCji5RNy953mk3DcmmZ7nfxsWE6UGT4pZJtqWgQspUTJngAK4
 cQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506338; x=1757111138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+Vi/O4BRs2S0eMYdKKxaAFZ166C21NyMikDLosj6Q0=;
 b=Q1YimQsxY1fGpi1DgfLLy87UzxKBrlZyDzyXC2TVyUuKUZ2vDDtDVNWCi8ugcut/RU
 Y+jnumQO4T1SQRZbj1eb2YhErGK7906ph6Gguzuvwdf+jXKeKrtE6SK9RIp+XhMEJA5H
 2GiPlIuIdIcJfJCltLZ/p0GZg9omEgcMzJv98q/HPl0GJ3dyaym/yxNLmjPA5IXz5yjr
 /gNEsb3TWRZF48aljBeZ6MbNwwz+fXJtRfLf4rQi6V6DealFY4akBcFwkett9mzSY1NM
 6M/zOEIFVnQ6keYsiiHK/6LI77IJPVQlmnneKoVwkupx1Zm8tI5cG8SXR88fTdkbIEVV
 wGgQ==
X-Gm-Message-State: AOJu0YyRdhP6Chy0AiwNC5z/tFENIQPvyf+ZBhdXt+jPeBMukmAQl4lL
 ZzJMhmHs3BamYr6plG7QLVEv8AxjF/D/gBdO12OaOfkptFOjLQyeyJIy7iUJLbDlNltarD2cm7W
 Ja3KK4Q8=
X-Gm-Gg: ASbGncvL73M7S2QUkNOhWoXKU4qwBKupoV0JCyWVU0pUvOTuxdMoRRsMYXB3hBeqqOr
 4PhudftDiAa2cMwNOZcL8isFhi6fYzJy96Cjodn7ok7HJl2deZzshpsrH76PMl9M42nayHO2Yl8
 xdpdaU05GF19wWA7r4dFr6+as4foWmqcNJ9hHaB1pTk4SX9PxoC9aIWyVKAs/t4ms+SC16w6dma
 33QA8aMxse7TxPVknharA0/MfNToxMo9fB9SV4obh8fn9r/a2gUtlhSo7/cCEUSbzziK+SZsa9c
 gEcDVl4QD/SYFhydlig5elYGcZXKsIAN58pc4pFEurbUvTV9rnCjGt+SCvW5M+U56eCITj5zN9j
 Y3qzfMUSGukUH8p0wUCpVQtw/N44ZJfTTQd17jx5DeWcTu3HG59eqrdrqYqK5NExyO3M3D5U=
X-Google-Smtp-Source: AGHT+IHWKwz+92sPbVmaHEBS2hVGhK2jZAOyLxfLYHn2SaIHkNZqoMdpDQIdJCA3AvPtZsdemi2Z7g==
X-Received: by 2002:a05:6a21:9989:b0:243:78a:8280 with SMTP id
 adf61e73a8af0-243d6f8e6e2mr285357637.56.1756506338512; 
 Fri, 29 Aug 2025 15:25:38 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 27/91] linux-user: Move elf_core_copy_regs to
 microblaze/elfload.c
Date: Sat, 30 Aug 2025 08:23:23 +1000
Message-ID: <20250829222427.289668-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_elf.h |  9 +++++++++
 linux-user/elfload.c               | 21 ---------------------
 linux-user/microblaze/elfload.c    | 17 +++++++++++++++++
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index bfe2997fd2..cc5cc0477e 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -8,4 +8,13 @@
 #ifndef MICROBLAZE_TARGET_ELF_H
 #define MICROBLAZE_TARGET_ELF_H
 
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+#define ELF_NREG                38
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5a3a5cfc39..96ed6b6515 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -416,27 +416,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_EXEC_PAGESIZE        4096
 
-#define HAVE_ELF_CORE_DUMP
-#define ELF_NREG 38
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
-{
-    for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(env->regs[i]);
-    }
-
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(mb_cpu_read_msr(env));
-    r->regs[34] = 0;
-    r->regs[35] = tswapreg(env->ear);
-    r->regs[36] = 0;
-    r->regs[37] = tswapreg(env->esr);
-}
-
 #endif /* TARGET_MICROBLAZE */
 
 #ifdef TARGET_OPENRISC
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
index b92442dfeb..89250dbd63 100644
--- a/linux-user/microblaze/elfload.c
+++ b/linux-user/microblaze/elfload.c
@@ -3,9 +3,26 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "any";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(env->regs[i]);
+    }
+
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(mb_cpu_read_msr(env));
+    r->regs[34] = 0;
+    r->regs[35] = tswapreg(env->ear);
+    r->regs[36] = 0;
+    r->regs[37] = tswapreg(env->esr);
+}
-- 
2.43.0


