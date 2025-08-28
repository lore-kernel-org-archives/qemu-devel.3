Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D39CA1000
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgDn-0004ne-2G; Thu, 28 Aug 2025 13:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb1-00077H-Ki
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbay-0000qY-I7
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:15 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2445824dc27so7555115ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383551; x=1756988351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAlclsw7NdwMNzDXXMYCt62TrsWhB1wwPrwu4zLwNMI=;
 b=nsQAxRWa9n6rjSHR65//BJAxuwPSNCwzRnSC90i7r66i/olWoljDUto/ZE8eTYlMZE
 +sJkXTujj1qmf5XYNFYmkxUh6BtlIrHGaFoCc6MtjApAOHQo2PI86eRr9vUQSzOi1THn
 tz0nFyShLYv13PXTJdou/SGZjwNTM4btNE9vD8bMM+umuGMg2XbawIg/WNGqug2P+WVa
 ckdzbAxiRKefwrDAVWbf5L17Hup27wzXvp1lhG5ljeVZuf2CkbZprvjKdRGQp7Lxbd9e
 UO2mk/5MNGx3I2DY7CHQOMD2VZiMKUxe8p9tt1UPbwfEJi8udL5y6p6bR6c+DSFoca91
 TH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383551; x=1756988351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAlclsw7NdwMNzDXXMYCt62TrsWhB1wwPrwu4zLwNMI=;
 b=wx98p+5DFZ6SY8gQhIVkYQyD3c3NEBccX1NsJnGDzkIEsVHxgnN8L4lRPUqb3qiudB
 U7tLDbYpEePSSpuTCYYo2eqaHstiDxSu9MCnMe/ZeAVBK15VB6s+K3TgS/vsVm7ixC8T
 JkAyB4zUuUrgqW6X2okY5IMjss7ct+Q9AgekUPmpy+ONrr9nDY2+hKEvCiNRoCWUhpnv
 H0yD/R9SseS/gXq6xcgIkOhas51/V7rWy5sOWWsWU6LvdT0lM0wDxKuhBuKNfJM21thN
 4K6aWYYHfcNikN5zMe8PCL9M4aNEpvjrgcOnhuJOsZvJ5O84UkicDlr2XNyvLvkQjL09
 p02w==
X-Gm-Message-State: AOJu0YyigTm82w1z2P86XIX88Q9mWAzzO5PGG1zeD+3QOTplR+xn4k/K
 0K1LEcKiiylUOlYizUKulhDCK9nqz8sVcHS/cjT686O8SuCXlWfOM8OzPTwm3aavBIaBMqjJBhM
 7JQqBfW8=
X-Gm-Gg: ASbGnctzMFDg26K/1p8shI0dut2FnyFrtl4QSLAQ3FW8CYJw2SpnSxulmTW7d/7OGGX
 Bo02IL8HPejf62quu+d7PYVPFPtpWNQIWUyerGHZd5q60sZpaegEiPb0e8AtEdC2q2APUykVFcM
 z8OozjrbA1miSFIrwI1fACkNFDYnh2smqLY2GxOxdrqCCI1O54Pj07OJZBc7TzYATJbFmqNMYsD
 MTMLx++JvIuGTJRvlUHR7yBh8H/hiIkpF6FAANIxcHIGRIexjHgXBSc6n2v9T9EfrfI7ESvyRoX
 D3DnjCiy1oOs0SGrXKHtHFW/NCwuG4E6t25cUyoHzMgHw9s01pKMYy+Kn76ZeS0E6tcAy03vIVf
 tvEeasNCmooXtTZl6yw5jm48VwzI57MgYyOKV
X-Google-Smtp-Source: AGHT+IGVsvquWZuAjmSFsGt4kxATy4qBiX8HDexAI0tWopd6VxhG1Ts9eOISN2V7/qNHexAkAIJVbQ==
X-Received: by 2002:a17:903:244b:b0:246:cc56:39e5 with SMTP id
 d9443c01a7336-246cc563f19mr197661145ad.17.1756383551031; 
 Thu, 28 Aug 2025 05:19:11 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248953dc1f4sm48898735ad.30.2025.08.28.05.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:19:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 84/87] linux-user: Move arch_parse_elf_property to
 aarch64/elfload.c
Date: Thu, 28 Aug 2025 22:08:33 +1000
Message-ID: <20250828120836.195358-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


