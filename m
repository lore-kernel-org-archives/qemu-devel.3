Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB382CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNn1-00021L-4z; Sat, 30 Aug 2025 11:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7ff-000620-7m
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fd-0004oO-De
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77201f3d389so2809989b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506848; x=1757111648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAlclsw7NdwMNzDXXMYCt62TrsWhB1wwPrwu4zLwNMI=;
 b=pDZZGygO90TmO0j5s4ERQ7Y8ofEN8yhCDGezzpUo/cYR1pXjPzU1+yRnuvaw5MHdpI
 JbsFPJl1A43ULaOb1RFAzwTdMkTkevIq+3Sed6nXjOmOuwVZR+MiBf3i5HYeKJjnlCEp
 +1VxKuwoNbhnj2kXm6gDjer2x0/JqcR3aM5u1vWAk0GWgzR620+nprAWAtbN7Z7AT1Ib
 KCGQkN/M44mo/hHNGo2sA9GJ1Yexg0TSkcyr3VKSh6xRQqOsr7mJhPVC+gnMyx31A+Gc
 BbOKZB+wdG2dMd9DzSdtHWNyMuggIW0u4/MDo7Qyl5ldwtpXkdJ+1OKsuo+ZO623ALO0
 H+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506848; x=1757111648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAlclsw7NdwMNzDXXMYCt62TrsWhB1wwPrwu4zLwNMI=;
 b=kjH5Ho1ZeEPdmrrG4qmOBLT57ulPy7xwiUd1ZXm92xIzbWz3R/bT3N8OUD6LPd3Si+
 wIAKqo7RnhGPni6dBOb/kPlAygSOHyx0llY+c5bmoCfIzhzVzJs+Y/ptbOaAVT1T85SF
 xoZs6oZVSqWL2bUnVdCJa75sdRk8+smLnM5CQ7/ZkW5ugmzk8GEASxZ+vjOmQjqfQsuE
 Tw/5+abML+GXy+3EdD2mXpVZfVROvAbTzNbnkBeHZLGvMrAsUN34GZHIQjCzYcWBaaLR
 dqrPQBk4Vzngbe6wVLh1xzDvWgwLwKv5b0cznpWwymBNoPPaxFHrIly+KVHwAG7L8r/y
 djcg==
X-Gm-Message-State: AOJu0YzpEtSOZ9UGKfSYYinevTyldf+5G3Vj1NReFMLlMtRJomfGGLbq
 GP6tbuDZTszg2VzFlPKN1nU6sotaZCUBL/dDCumWlqNR/OnIiB7rb2+aUwL6+37VEYtvvxM/r4f
 zOub4EXc=
X-Gm-Gg: ASbGncs5EWzHKYKpGlGOZhZEByh0Ic9Rc4p5Zw6zWSIXPRmuHkt0GBG+RCf1OVKJqtc
 xE3U29DG6NnaN7LmDJ6SAROkMqRrWm3fQo1kEcbKyhnFquxM7ZAak/MAuUfBPgg9UPZMPzQF1HY
 mH/fXa6B9VIfaDkIpkxOBwyJTSiFzmVfXxrHgP7mhBlxqdZAWE1+InzFEYxck0AFkyihU21g073
 lC48cUL0nUpfFbJvJVdW0T3rpwZmx+gAccmirTxIA1pq7F5d3mKEV5VH1AUSRNGB599KO261mxq
 9ya3cLEShbgWu1qTHJvNsOTJMQ5N7lBpv8C75S0yFkXPxxuyOFtYQGccnDgkb1vqkSiWbYQAIs8
 tpBj3MzohcSdPSbGIPvjzZqPzqH5w535WUMD96uU85HtlzopCdOAGk6BRuCEo
X-Google-Smtp-Source: AGHT+IEL2ygKto+vBNNkaZ7xM8ckllHe65N6Ft9ion7vFRJNc3DycYXoPDwmPcu3HlkGxvbvyIBP7A==
X-Received: by 2002:aa7:8895:0:b0:772:3b9d:70f0 with SMTP id
 d2e1a72fcca58-7723e21a808mr293281b3a.2.1756506847916; 
 Fri, 29 Aug 2025 15:34:07 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:34:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 88/91] linux-user: Move arch_parse_elf_property to
 aarch64/elfload.c
Date: Sat, 30 Aug 2025 08:24:24 +1000
Message-ID: <20250829222427.289668-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Rename the controlling macro to HAVE_ELF_GNU_PROPERTY to
match the other HAVE_* macros.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h |  1 +
 linux-user/loader.h             |  5 +++++
 linux-user/aarch64/elfload.c    | 18 +++++++++++++++
 linux-user/elfload.c            | 39 +++++++--------------------------
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 9ec51f6237..4cdeb64b0d 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -17,6 +17,7 @@
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_ELF_GNU_PROPERTY   1
 
 /*
  * See linux kernel: arch/arm64/include/asm/elf.h, where
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 2175dd4e0a..e42b8fa1e3 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -122,4 +122,9 @@ typedef struct {
 /* Note that both Elf32_Word and Elf64_Word are uint32_t. */
 const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags);
 
+bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
+                             const uint32_t *data,
+                             struct image_info *info,
+                             Error **errp);
+
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 07a0c3f844..8076968251 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu.h"
 #include "loader.h"
 #include "target/arm/cpu-features.h"
 #include "target_elf.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -349,6 +351,22 @@ const char *get_elf_platform(CPUState *cs)
     return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
 }
 
+bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
+                             const uint32_t *data,
+                             struct image_info *info,
+                             Error **errp)
+{
+    if (pr_type == GNU_PROPERTY_AARCH64_FEATURE_1_AND) {
+        if (pr_datasz != sizeof(uint32_t)) {
+            error_setg(errp, "Ill-formed GNU_PROPERTY_AARCH64_FEATURE_1_AND");
+            return false;
+        }
+        /* We will extract GNU_PROPERTY_AARCH64_FEATURE_1_BTI later. */
+        info->note_flags = *data;
+    }
+    return true;
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
     for (int i = 0; i < 31; i++) {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8b92fba0f0..12d4873212 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -166,41 +166,18 @@ const char *get_elf_platform(CPUState *cs) { return NULL; }
 const char *get_elf_base_platform(CPUState *cs) { return NULL; }
 #endif
 
-#include "elf.h"
-
-/* We must delay the following stanzas until after "elf.h". */
-#if defined(TARGET_AARCH64)
-
-static bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
-                                    const uint32_t *data,
-                                    struct image_info *info,
-                                    Error **errp)
-{
-    if (pr_type == GNU_PROPERTY_AARCH64_FEATURE_1_AND) {
-        if (pr_datasz != sizeof(uint32_t)) {
-            error_setg(errp, "Ill-formed GNU_PROPERTY_AARCH64_FEATURE_1_AND");
-            return false;
-        }
-        /* We will extract GNU_PROPERTY_AARCH64_FEATURE_1_BTI later. */
-        info->note_flags = *data;
-    }
-    return true;
-}
-#define ARCH_USE_GNU_PROPERTY 1
-
-#else
-
-static bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
-                                    const uint32_t *data,
-                                    struct image_info *info,
-                                    Error **errp)
+#ifndef HAVE_ELF_GNU_PROPERTY
+bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
+                             const uint32_t *data, struct image_info *info,
+                             Error **errp)
 {
     g_assert_not_reached();
 }
-#define ARCH_USE_GNU_PROPERTY 0
-
+#define HAVE_ELF_GNU_PROPERTY 0
 #endif
 
+#include "elf.h"
+
 struct exec
 {
     unsigned int a_info;   /* Use macros N_MAGIC, etc for access */
@@ -1233,7 +1210,7 @@ static bool parse_elf_properties(const ImageSource *src,
     uint32_t prev_type;
 
     /* Unless the arch requires properties, ignore them. */
-    if (!ARCH_USE_GNU_PROPERTY) {
+    if (!HAVE_ELF_GNU_PROPERTY) {
         return true;
     }
 
-- 
2.43.0


