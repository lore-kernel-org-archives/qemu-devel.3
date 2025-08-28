Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393AECA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTk-000521-7d; Thu, 28 Aug 2025 08:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRa-0002bs-9b
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:31 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRX-0007FK-Et
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so733901b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382966; x=1756987766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3laHqYMdhPtHS/EPyIfDpviVzwevLC06XVpJpqY5Kc0=;
 b=ZIhJJunadgBN/M8mWLl8E6Yt3snPYpoLqM2OrqbSpo0TpGyk5ph6oOzZLnaakVnFc8
 ljNfIu7iVi19Mcfr7B6WvgynItM+YQogiq8J+VRbWeR1lpDRYGIROdStWDBIkv4FRI+N
 koNG5jsepx3aK/j5E5KcgEFTyXKNyWVsgCXzWhc8r0z+DE6tba9bo3qjDPAFu9UNkLDK
 KdbjtuV9f1vWoAOHZZHhNH1aUmd2WuOjkPRNVCEye91RvVnT8kX8KibNZuFgAj5oRlNm
 lZfBZ5Pl8OES8d0sNYd+woG9i35JjQTepJXzt/umyVnsvd7HwDQAH4DeChL2ZNVjHUBi
 ze9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382966; x=1756987766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3laHqYMdhPtHS/EPyIfDpviVzwevLC06XVpJpqY5Kc0=;
 b=HTvN6eRMTz5X3ZHrPO8U8+6qDUkwt6DHBHfDGbOiBCVuGJa6t2M5uoTT8zktP/LY7x
 tVaOaDFzStKaE04dwOSYc72KjAFdb9F/Y9/D/rcbJNJDyDcJm5/qZVa9WoZRXxgcDM+1
 cSesH2PBdx/uw696Pt9Y8S4VoPSYBwNlVeHzEsS4jN1v/I3OZOe5+W46k5w6IoJ+Zn+1
 plybV4KBAlZzybZFVlx4g1+MuOhDf2iGrOTn2BwzBm2yhQWicwkNbmpXaRVYlsRqnLHu
 Qf5i9NGS/4Aun8R+QoCS3uY8Axs44LgtTIeqzypywsuEqld73GqEvjpnI9TS55Jl0SZZ
 2CcA==
X-Gm-Message-State: AOJu0YxDqM+gs9uGhS4grR5DAjwUc1XaGmuIfhQg7H6v/xNhNhgDK2Kk
 +pFr77rL3aNw3io/0swHKjkcQa0jucqgiuBhEKNQDzjLV29fI8NlXe1IxRCYFC/fpZzip6nZ0Nf
 HwKwdlAA=
X-Gm-Gg: ASbGncthLLGOaIuWMXL2PxwIT/2IFNaQAFOl3oHU65hzdb3MwFyX7v16/9YFiZa3c3T
 weL7na2MWmjEa3il7C/j6Na8zX9PZ6A3RUYprFLb0UrzIKilzNnPotlwr1ZHUriPhAX5uZKIMeR
 8WpfKM/mknjugykklE5UcVYg0uS9FcKtW5hqdhy6npNo5kvg377BWerPCRrNP/fhdAjXvgvA3f3
 FnYoJrIwyW99eNS8kheAYPspx+OfHR0dXCON4lJGsaLah3vrTKzuAvgnyDFNbsDCYjo3/TjqEJC
 PY4P+FPx3MkekwXqGKmyvTPrzgWQBQ/z4li5IbWdEkwkcDOATktXLbaiiWM/iJAwoPH5RG8KRzU
 0jaY+aZ3iY8wXq1d4XbWW2rEhiQ==
X-Google-Smtp-Source: AGHT+IHmptig2elKG3k5GHu4A5RomhtuDFIaQoNXBgHpeoxW33NXRieLJivQTBDpQSpmCgp5jXwK8w==
X-Received: by 2002:a05:6a20:6a0f:b0:243:a9b6:de9c with SMTP id
 adf61e73a8af0-243a9b6e0a5mr4807869637.24.1756382966044; 
 Thu, 28 Aug 2025 05:09:26 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 18/87] linux-user: Move elf_core_copy_regs to arm/elfload.c
Date: Thu, 28 Aug 2025 22:07:27 +1000
Message-ID: <20250828120836.195358-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h |  8 ++++++++
 linux-user/arm/elfload.c    | 12 ++++++++++++
 linux-user/elfload.c        | 15 ---------------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 856ca41b16..94db3738e8 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -11,5 +11,13 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+#define ELF_NREG                18
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 7de1f13f4b..47fe16a1a6 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -4,6 +4,7 @@
 #include "qemu.h"
 #include "loader.h"
 #include "target/arm/cpu-features.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -199,3 +200,14 @@ const char *get_elf_platform(CPUState *cs)
 
 #undef END
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
+{
+    for (int i = 0; i < 16; ++i) {
+        r->regs[i] = tswapreg(env->regs[i]);
+    }
+    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
+    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e4f821f8c8..72a291e51f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -218,21 +218,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#define ELF_NREG    18
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
-{
-    for (int i = 0; i < 16; ++i) {
-        r->regs[i] = tswapreg(env->regs[i]);
-    }
-    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
-    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 /* The commpage only exists for 32 bit kernels */
-- 
2.43.0


