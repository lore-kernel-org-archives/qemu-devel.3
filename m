Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374ECC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugufE-0004cE-31; Tue, 29 Jul 2025 20:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMY-0006ps-Cm
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:06 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMW-00058B-7h
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:06 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b34a71d9208so4702955a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834083; x=1754438883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qSjnwPeDWDBrNlNB24iCT3wnvDV5JdCbq4vVQKGP1nQ=;
 b=WPRE2JwNUSYKkOUnquoGjlsncD7f4SDcyJJojEE7EKTbgqwNlfB5e1GJoBac9AuGB0
 06lYuKAGEE1CHI9fB2zyeuniD51Xn+NRQewH9WmrUpI3H1KIaVPUTKEiqeFNXbM0I2bI
 nja9yWYThMBEHEzcbxSgoy4nLAXMGNuFdxWbItpmPP2Kw+r5qjOEHtNMXwS9FEAmpXmg
 VXZR+pnQT5KgWpq7/F0imgOC+5d2cprfC/jW134SDIYgobm48O/FWQNPKK25HGloxp4E
 9psCoB46pjFjNtjoYBwSuOBLsOMdwj0YunDf2XtCMuqeMkfcwve7uFcb4k0gdB7jnY5h
 E1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834083; x=1754438883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSjnwPeDWDBrNlNB24iCT3wnvDV5JdCbq4vVQKGP1nQ=;
 b=RPPVCkID62K4E4JuVkMkVVjpOpIHuTzSTp/YxoM3ZSmG1ix2uWWfkWdxQYH+PMSskE
 61pr+wxYSG8Ugq+T3z01jwFaOgInF38TNRXQnA554nIAxdLNBQR6tqmGPeqSxo22FaQY
 0DHbarTzyKHNbMc49pvoxWFm5C4SNZi3Nlc8y5oN9EQSB+jJtLNa97xSresjY+viLukH
 GpAd87Xu3xHIUSH5Or8MEXDVN5EY7LV0YvLCgnA5J2mR2Q0b+jo2fEX7ipgtKsiczRgQ
 DNbhswOWcyZ8zLSndBGYpI53IWX0HJiMg/O3faNlhY+Oq9afrH5KocTTbhViA345kdJu
 XrIA==
X-Gm-Message-State: AOJu0Yz6s8XKNJvkwBNJCOTqMhhkdfJbItdv7CM+68XcF+AJJVxMBl8N
 ZfsK5Lxf2WGSMcRDMgmewGesyKa6KUK9LpxNRC/uZyhBXsvBe6jLSQhmO8p+FOTXyAFYHvmcRqZ
 uzMbm
X-Gm-Gg: ASbGncvu3FMgPK9o1DU82xB6FVk1yMZpx7t5CQTuvWYMPsRZUxY0mkXjDqBVMpvwCge
 oUNYz1mAJhl+sgx/esGe98FweNi+Tf9TdYG7rI1UKjI8oYen88agnLBhfdAu5BHEBtNGihRxVK7
 J7I4P46Ic584glmtpPWo9afhy4pG9rbAvUjkb/rtbvlvFgxpztA/WSG+Akz9AR/I1Q3k/x5bgD1
 +Tg7S30MtNoqILxZC9aAzmIgHdE517CKzu+W7yCZZeXo8knylPicu/uzbHP21BOynZdAvAIobS8
 ZAsxRLUcyeU4phIUDHK6LfOmEXzgtAEjoNTFL7NoDUqX9FYPWmzWsyAfUik990EunI7/2q4V5JG
 +ZRMtT339z2cOaviTA9JFw3wD9DGngnl8U1jqWrMBnjZxT0zZYLACckgbiUvjZVDjsc1xme+91Y
 /CcVSU8NrtCg==
X-Google-Smtp-Source: AGHT+IFc3p1IG1BerogQy/5kybjqgSGeyUfWId8O0KmNGxi3y6/fcvreXHJXQvuNUPx4MDHLRkpR4A==
X-Received: by 2002:a17:90b:5103:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-31f5dd9bc9amr1749078a91.12.1753834082651; 
 Tue, 29 Jul 2025 17:08:02 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.08.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:08:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 83/89] linux-user: Move arch_parse_elf_property to
 aarch64/elfload.c
Date: Tue, 29 Jul 2025 13:59:56 -1000
Message-ID: <20250730000003.599084-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h |  1 +
 linux-user/loader.h             |  5 +++++
 linux-user/aarch64/elfload.c    | 18 +++++++++++++++++
 linux-user/elfload.c            | 35 ++++++---------------------------
 4 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 16acf6d47f..2d396ad11a 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -11,6 +11,7 @@
 #define ELF_MACHINE             EM_AARCH64
 #define ELF_CLASS               ELFCLASS64
 #define USE_ELF_CORE_DUMP
+#define ARCH_USE_GNU_PROPERTY   1
 
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER            "vdso-be.c.inc"
diff --git a/linux-user/loader.h b/linux-user/loader.h
index a4178ce2c1..95cbeed5d4 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -117,4 +117,9 @@ typedef struct {
 /* Note that both Elf32_Word and Elf64_Word are uint32_t. */
 const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags);
 
+bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
+                             const uint32_t *data,
+                             struct image_info *info,
+                             Error **errp);
+
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 1030cb8094..d186b4685c 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -1,9 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu.h"
 #include "loader.h"
 #include "target/arm/cpu-features.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -347,3 +349,19 @@ const char *get_elf_platform(CPUState *cs)
 {
     return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
 }
+
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
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 14d4502b3c..54ea9221d9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -184,41 +184,18 @@ const char * __attribute__((weak)) get_elf_base_platform(CPUState *cs)
     return NULL;
 }
 
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
+#ifndef ARCH_USE_GNU_PROPERTY
+bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
+                             const uint32_t *data, struct image_info *info,
+                             Error **errp)
 {
     g_assert_not_reached();
 }
 #define ARCH_USE_GNU_PROPERTY 0
-
 #endif
 
+#include "elf.h"
+
 struct exec
 {
     unsigned int a_info;   /* Use macros N_MAGIC, etc for access */
-- 
2.43.0


