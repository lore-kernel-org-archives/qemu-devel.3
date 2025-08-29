Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA0CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNm5-0005iD-Oq; Sat, 30 Aug 2025 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bZ-0004Vt-VJ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bY-0003fR-40
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77201f3d389so2807539b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506594; x=1757111394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG/u4gMgVdHuU3y+QT/1m5OPOu2oxTo9ZF2y570v/1o=;
 b=SExUCg2+f7sWtgpG/v8IYa1aLCmN3+zVlfPCrAtn5gekeuGZPmgdIRdQJJRFqs7npV
 StGlrwtH37twlGRxSFyXSKm8cHRQM94zh1lczULwPiSo4+ZOEGpozruih4p+qB1lu6+Q
 LrKbWeVGK9jjMsZ1yzzxdM7Kba1PBUd3TGDIwwlUumUhPHUe2N0FAc6pN3B9EliGmbVI
 Hm7/Fg5l0srFIWhMfy7ij9Yokmo/qUfDh8xVsfp4UcFdBoSWTw8L98Hfkzq9WdNMDmYO
 mxGbhr0pYT36iZty0MCNKj8+F8JdD0DrNAoibWBy7Pk7jpBKwHbJhofFdtkeU0g83FzY
 /SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506594; x=1757111394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tG/u4gMgVdHuU3y+QT/1m5OPOu2oxTo9ZF2y570v/1o=;
 b=FCezxlKaOke1kX7b1+aENkB4QoZbW/b5WVrcKjf1sLaPcZZ8C1iOjCDWVr89rUUtRf
 qBwItB3gmrxki++wGzpdWP5z2foYsFgiazjTvGIiGsMtRD8poS960+qBuAwuXbav32yI
 N83y9mCYwLX1tAh4RUINSXkw3QCpWj6HgLZQW7C9FsVuRhIDLXo6P4/gcjEX3wI1cpor
 Z3nW0ISFYFCV1QFtqFpuwQhajJEXIuXDCwDwFfCuQESR4gdKbgJJoSJbYLLjbdhyTuTC
 1BUZgSVtK+ue32ii5W+nStBJEpIyDa4/5CTlSFdU0PjqbsaBRmtfkVTqvTVIP7U8mr/F
 bg+Q==
X-Gm-Message-State: AOJu0YxAchStZTOMP59FZpoF4akCB4GVk/eFxh05WWCYbIXRpSfpqoDH
 QAAPOtjg+eafVQapG9PeM5Bg8uKvhmeB1TmH26ESHDopVsNwW3SSu9Ux2Y3TWXC1RhBxfeF2xUM
 mw5rjdpc=
X-Gm-Gg: ASbGncv4myS53pvmb/hcwY4nXxGX9+HM1/uNF6uckuTQuI4HAmlGDnxcGOSVf6EmUeo
 LCuD3FiG411osaLub+Zcb5i8ANsrJ9D/OgDjYXbegdpnmLD2SGOx9TO6aZnRsfIqPpAQP1lb5b5
 x2oWQYpUflOaSTZRRD1dpYCSoV49X5p4/Qw5slcSKLgyO2x9Pms/3Q01dbEq8/QUEtfOJiAkd+M
 wwlpbeFPKrfzX8nq7VLxnFyWjYNpbfiJzIHDrIGb2recG0FI8nVVD5+Wz7VmR2ZeMwudwc5F6Gi
 7xzn0TozYg03JezsuHJD+FxFw4nVn2dcKeH/yZlkvccjhDU4uBgo5JGD51IkYAIjmQAboNh+voh
 7tx3cUG5C6o6KxzOqS4DPYviRrhMg1sEffMBBzjnrrbYgrtAuafs7Fo6YKJfjTzY=
X-Google-Smtp-Source: AGHT+IH4WC17JZ8g/4tacjLrv4oy5oVbmLdhDNOARtFHS/wAqQFsADX2KBry4HxlAze4gf2flqg5oA==
X-Received: by 2002:a05:6a00:c95:b0:771:f4d4:24fa with SMTP id
 d2e1a72fcca58-7723e3390c8mr321978b3a.18.1756506594628; 
 Fri, 29 Aug 2025 15:29:54 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 58/91] linux-user/sh4: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:54 +1000
Message-ID: <20250829222427.289668-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/target_elf.h | 12 +++++++-----
 linux-user/sh4/elfload.c    | 28 +++++++---------------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index f7443ddbac..fd3ae68a01 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -8,15 +8,17 @@
 #ifndef SH4_TARGET_ELF_H
 #define SH4_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/sh/include/asm/elf.h.  */
-#define ELF_NREG                23
+/*
+ * See linux kernel: arch/sh/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct pt_regs via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 71cae9703e..ddf2aaaed7 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -38,30 +38,16 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     return hwcap;
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
-/* See linux kernel: arch/sh/include/asm/ptrace.h.  */
-enum {
-    TARGET_REG_PC = 16,
-    TARGET_REG_PR = 17,
-    TARGET_REG_SR = 18,
-    TARGET_REG_GBR = 19,
-    TARGET_REG_MACH = 20,
-    TARGET_REG_MACL = 21,
-    TARGET_REG_SYSCALL = 22
-};
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 {
     for (int i = 0; i < 16; i++) {
-        r->regs[i] = tswapreg(env->gregs[i]);
+        r->pt.regs[i] = tswapal(env->gregs[i]);
     }
 
-    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
-    r->regs[TARGET_REG_PR] = tswapreg(env->pr);
-    r->regs[TARGET_REG_SR] = tswapreg(env->sr);
-    r->regs[TARGET_REG_GBR] = tswapreg(env->gbr);
-    r->regs[TARGET_REG_MACH] = tswapreg(env->mach);
-    r->regs[TARGET_REG_MACL] = tswapreg(env->macl);
-    r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
+    r->pt.pc = tswapal(env->pc);
+    r->pt.pr = tswapal(env->pr);
+    r->pt.sr = tswapal(env->sr);
+    r->pt.gbr = tswapal(env->gbr);
+    r->pt.mach = tswapal(env->mach);
+    r->pt.macl = tswapal(env->macl);
 }
-- 
2.43.0


