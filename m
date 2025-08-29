Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D706CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkB-0000qL-QB; Sat, 30 Aug 2025 11:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XJ-00038y-8C
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XG-0002yc-QP
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1100264b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506329; x=1757111129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIvyX9Uw0MOR4o33m8mEn78tjghKzoKbIlp80HImooc=;
 b=Jb7l+JNuWYszugxGoQxvRL7rtJRJgZwLS1hx3khHrSVuZcX/fdWhSoIkVeAkWBBxsd
 gFnOfIHm9zdaEKikJLMqd4e3eoZwxijJ0HgkKCDTWKdchGty6KFstr9fV2ZzhHkGsb20
 /TjyQxVQPIeWXn8Yl565a82kCHht4q7c78wYA9g+pyz/iikfROseWH7W4+plPMpm4a8/
 VtU5mgqQOngOnzGi1C1vS9G6ZLh4CyUfwucrBiiI62a/nQ+citCUElxfmhW+Bc4qKvp7
 2raFqhyiZlVOcfWHL48NlrA+CvwvZWiPR4NA5EadWP+iXQ5iQerMk/L95DZEzWlwhg09
 LTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506329; x=1757111129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIvyX9Uw0MOR4o33m8mEn78tjghKzoKbIlp80HImooc=;
 b=TnZkebI+3DwuNeM/2MwrzDICaRBXjGzESJohl7gXR271vlQ6XPRPjQkiYQK6lZ1c0A
 Nt4aA5sk1yRbfjsU8+SCaymHubzRV6AV6MxFI3pKlWGEFKbUki18an7jTFbfgc8Zmp1U
 TCtFB7Ae+KbmGNCzXe5JUdVWFS5dF4M9sKmwUzsZbRTQeiBBr28iQiTtZhSJaXofkgJK
 gNjs09wsqYFTrP/xpZL0RGEh1cYawqT6VCzrc+WNlXhGhn6VyrWV5eDxPV0U8tTIQm1X
 DNchpR8L20KUHvCI4V9AKS+pSecP6kcZpnGEDEI4uPrHmJZnGMovS4zm2+I+k9UGFCSD
 cIOg==
X-Gm-Message-State: AOJu0Yxpq3jcGMoErCwQvD4kJUKD4YkLuJf7J3DCMEF6a48JJlCObBOZ
 dO+Ud3QDTXs2YrNcGO2aV5KyzowKJUZIj5bAZp4Ifi7J2hOck6SdaxO7JiLlWzXfEgjU71YAcNj
 5LIAqnHg=
X-Gm-Gg: ASbGncsC7d2KNLEn8ZHPSOr+7hmx7LOrueG4AMLOZ0vQFGspDpB66+EXkxm8IaQUBer
 m6q8wd1W2iZfAjmDiGnaFMxqr8hVhDzija5rreezzfmyNIqSOcSK+KrzFqWfDjkic3FrXJd+rz0
 dRS+lMHYWRMK0gq/6QEh5McjNmuTaYtRkDNA0tdumqT1equEHyN3iR05Zt9AS3QdFBf8QGuxGqY
 8m16Rc8dmCB6T+gyQtwZJk+IQVQ1U0NXMqT8VZ9qUqabV0PyuXQYSEngJGPOKOWhLzz5uMpX+gx
 1bM3qnbUhbZg0U5oI+khFceFvq/bI68BkRFFMju4QZ+i1fsjFwyFvOCWP5x41liuc/DN3d8+rtz
 LIV0uRf0ACJRVbYA9KlS68ZIyamiQvYjQEqDfuxpgC1vekkyWh/DmAWj1uUTBvQJaGWiOZUA=
X-Google-Smtp-Source: AGHT+IEwgIS+Z+e0yU+C0gZutmLeAqwiPGbgyGjRYBk+QJQcRp8QcacEMYWTE8sOV2N5lqb+UBaJRA==
X-Received: by 2002:a05:6a21:6daa:b0:243:78a:82d0 with SMTP id
 adf61e73a8af0-243d6f7eed5mr262460637.29.1756506328859; 
 Fri, 29 Aug 2025 15:25:28 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/91] linux-user: Move elf_core_copy_regs to aarch64/elfload.c
Date: Sat, 30 Aug 2025 08:23:19 +1000
Message-ID: <20250829222427.289668-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 linux-user/aarch64/target_elf.h |  8 ++++++++
 linux-user/aarch64/elfload.c    | 12 ++++++++++++
 linux-user/elfload.c            | 15 ---------------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index dee79ce0c6..b0728a1008 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -11,5 +11,13 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+#define ELF_NREG                34
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 1030cb8094..00550f9fdf 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -4,6 +4,7 @@
 #include "qemu.h"
 #include "loader.h"
 #include "target/arm/cpu-features.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -347,3 +348,14 @@ const char *get_elf_platform(CPUState *cs)
 {
     return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(env->xregs[i]);
+    }
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 72a291e51f..017346b82d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -291,21 +291,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#define ELF_NREG    34
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
-{
-    for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(env->xregs[i]);
-    }
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #if TARGET_BIG_ENDIAN
-- 
2.43.0


