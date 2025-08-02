Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102EBC87FDA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOq-0004Es-U1; Sat, 02 Aug 2025 19:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOH-0003fm-Sz
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:52 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOG-0001n6-9t
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:49 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-619a0f2a8c9so158861eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176307; x=1754781107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V570hcmnLPaHK1q/9+XOiTmxop0MReW3DKJENlfmRzM=;
 b=FwxThJfGJzXwB5O8Tu1+Ku6PzVrBarp0+bcFhSTu+k6rXp9s8WKWHfxRLzROEPd8z+
 VN4eMVDUn8x6lgSW8HIslvx4rIJn4jjEyqp3mUrs0tXd2WRwguFKVdNG7XwKWPr+g6Uf
 XCEH2N10nFEmNDte9huV3kRIX+EBCebRtGEyamTP2nnIMBj4h8qf97Y8c4aFMTXwKEVb
 VZ2/7KguONKyMKTLpQhcXlC3IkmkhbYwdiCnRGWxzjQQp9s5sLJXtkZsO5upt4bTBxh+
 Ygm17IUe+GAfxZ6KW/Fnd6Ce2i4o94o1QSWbS3K2vWcsBqPRP36hqdHsTyLKlKyM1j0f
 LmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176307; x=1754781107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V570hcmnLPaHK1q/9+XOiTmxop0MReW3DKJENlfmRzM=;
 b=AdGton30j6t36WiHRThkajfvCQhOjF2RKArn+R3ySbwoCVpnN3qjGqcyZ3ePOiIRgx
 hYBZPp6FVF4wHWHfTS/e1XM0XrlhXGUl5PqM+itVPf6g/hxM6hJgdgWlvXY/eeuQTbAs
 mvGyQmWYliloxYhsVE3cHStJ/lNTUXT+wtg28WXpS1lvj2H7EczXRD/TyxXZh+kXEbpb
 Bz5wPqh3YuQzRkW/s55bHCRD12alGarG4YxYWxJHEYgAuhKO6WXGXS3NB7E394lRmaqQ
 dIlAAgs9HHL4rnNePq8p83R9TJ2Z+jF6pN5ug52KgBQzuAm8Rk7OgQt5fTN0Zwpf0CSt
 wx1Q==
X-Gm-Message-State: AOJu0YzLRFKth2jSRq9qaemH97PTyTIIZh1s+bYm0NOb5q+eFuBE+raC
 BgKqbvQ6HhX8nMIEadzwgCBYzC36MXPwvR5G2Bv8An1GGPG7cyeo9BqEMxL5ul/fxHTKXpphe+E
 0sdlLnnw=
X-Gm-Gg: ASbGncsNlPdA0W+gHU80lploklN0wYIk1hP9o64zzYWFyFK1razaet3zotlAQrpxqL6
 KajC5NsRLR7cfVy64rvUd4Y0cK9J+jFUpf2zRHzOm7JO5h9vOSDr49yL8vQG+goD3QB549cEjKh
 24tN4mJjFScZYjDBy8fcLq5Vs5T1mTUybVmGNlFhkq8Vg/frXlfB5rymvBC324XFHqtt577qxtL
 tKy9X9zqoOXmDRVTtw8G5LmGVTYCGAy/20KmuD4sGYVo8HfkzmMni1Ol5NUjAAqNPxWiPiWnbOJ
 xV3UQrvkfWIZ/E+xEZ40t+1ZeBE8Ol3KtQ5uBvVo/XU7VEOixIw6+M/q/K7VZHhkWL/0jPCAQgV
 uTijTSLrdMu2JQ5Bb7PGN4UQ7BAn3HH3QzA3NEBIikNcpCM98Loq6
X-Google-Smtp-Source: AGHT+IEDtyMHqgwKYSsElocLQlbUCff/tkDydM18iYqMX35zQenXz/z16jagpZbKUiYVQu+FzbbqTQ==
X-Received: by 2002:a05:6820:290a:b0:615:e61d:2de3 with SMTP id
 006d021491bc7-6198f2358c1mr3035975eaf.3.1754176307178; 
 Sat, 02 Aug 2025 16:11:47 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 61/95] linux-user: Move elf_core_copy_regs to
 xtensa/elfload.c
Date: Sun,  3 Aug 2025 09:04:25 +1000
Message-ID: <20250802230459.412251-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/xtensa/target_elf.h |  3 +++
 linux-user/elfload.c           | 35 ----------------------------------
 linux-user/xtensa/elfload.c    | 32 +++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 2c55c22e14..f84fc9e6d1 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,4 +8,7 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
+/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
+#define ELF_NREG                128
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 80f5c967da..3ac0f89931 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -523,41 +523,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
-#define ELF_NREG 128
-
-enum {
-    TARGET_REG_PC,
-    TARGET_REG_PS,
-    TARGET_REG_LBEG,
-    TARGET_REG_LEND,
-    TARGET_REG_LCOUNT,
-    TARGET_REG_SAR,
-    TARGET_REG_WINDOWSTART,
-    TARGET_REG_WINDOWBASE,
-    TARGET_REG_THREADPTR,
-    TARGET_REG_AR0 = 64,
-};
-
-void elf_core_copy_regs(target_ulong *regs, const CPUXtensaState *env)
-{
-    unsigned i;
-
-    regs[TARGET_REG_PC] = tswapl(env->pc);
-    regs[TARGET_REG_PS] = tswapl(env->sregs[PS] & ~PS_EXCM);
-    regs[TARGET_REG_LBEG] = tswapl(env->sregs[LBEG]);
-    regs[TARGET_REG_LEND] = tswapl(env->sregs[LEND]);
-    regs[TARGET_REG_LCOUNT] = tswapl(env->sregs[LCOUNT]);
-    regs[TARGET_REG_SAR] = tswapl(env->sregs[SAR]);
-    regs[TARGET_REG_WINDOWSTART] = tswapl(env->sregs[WINDOW_START]);
-    regs[TARGET_REG_WINDOWBASE] = tswapl(env->sregs[WINDOW_BASE]);
-    regs[TARGET_REG_THREADPTR] = tswapl(env->uregs[THREADPTR]);
-    xtensa_sync_phys_from_window((CPUXtensaState *)env);
-    for (i = 0; i < env->config->nareg; ++i) {
-        regs[TARGET_REG_AR0 + i] = tswapl(env->phys_regs[i]);
-    }
-}
-
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_XTENSA */
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
index e35ba69a10..e35de398da 100644
--- a/linux-user/xtensa/elfload.c
+++ b/linux-user/xtensa/elfload.c
@@ -9,3 +9,35 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return XTENSA_DEFAULT_CPU_MODEL;
 }
+
+enum {
+    TARGET_REG_PC,
+    TARGET_REG_PS,
+    TARGET_REG_LBEG,
+    TARGET_REG_LEND,
+    TARGET_REG_LCOUNT,
+    TARGET_REG_SAR,
+    TARGET_REG_WINDOWSTART,
+    TARGET_REG_WINDOWBASE,
+    TARGET_REG_THREADPTR,
+    TARGET_REG_AR0 = 64,
+};
+
+void elf_core_copy_regs(target_ulong *regs, const CPUXtensaState *env)
+{
+    unsigned i;
+
+    regs[TARGET_REG_PC] = tswapl(env->pc);
+    regs[TARGET_REG_PS] = tswapl(env->sregs[PS] & ~PS_EXCM);
+    regs[TARGET_REG_LBEG] = tswapl(env->sregs[LBEG]);
+    regs[TARGET_REG_LEND] = tswapl(env->sregs[LEND]);
+    regs[TARGET_REG_LCOUNT] = tswapl(env->sregs[LCOUNT]);
+    regs[TARGET_REG_SAR] = tswapl(env->sregs[SAR]);
+    regs[TARGET_REG_WINDOWSTART] = tswapl(env->sregs[WINDOW_START]);
+    regs[TARGET_REG_WINDOWBASE] = tswapl(env->sregs[WINDOW_BASE]);
+    regs[TARGET_REG_THREADPTR] = tswapl(env->uregs[THREADPTR]);
+    xtensa_sync_phys_from_window((CPUXtensaState *)env);
+    for (i = 0; i < env->config->nareg; ++i) {
+        regs[TARGET_REG_AR0 + i] = tswapl(env->phys_regs[i]);
+    }
+}
-- 
2.43.0


