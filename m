Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499D0C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTg-0005gC-4G; Sat, 02 Aug 2025 19:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSz-0003oR-Gj
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:41 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSw-0002eo-TC
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:40 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-741ad8d0c15so184264a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176598; x=1754781398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LaXNjGDttmGP7fojpg5HBIO968y4mIzO2OTSI4a8EsE=;
 b=tdjDL6PkCN2XILyyslFz1XMYNus4SvaW0WLZYealEHnzF8eBVwd3ObvSzc/4L9kd9L
 pq/Lj7YdOzlX0KFOzgv6b6jkQ6gVMfh+ajyfYVeGum3Wg4ZLggScGjHFOQzSicP+pCwu
 55MViTPuYy/WAelUXZj2qAF5BzyTgw4iOiJjXNk5kYE0ZUFvUPJwnlBu2e/E32UKCJYo
 L4xY3+tI8bZ/mq/7GVup/689BeTLoQUhMzhV0rDu6iSUZQ4KWqDPcVPrIRG/y/CZo/OH
 mA/yOD3ywzLyQ0wHLR2865DUlUuzeLbE3WdU0aOavJi+jvgd9Tr7X+4N4gklLxB4xl46
 t/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176598; x=1754781398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LaXNjGDttmGP7fojpg5HBIO968y4mIzO2OTSI4a8EsE=;
 b=CrSMVOeNL747gNL/VCGEudlPdjGf7Heexn/NucOsVCtLZMQhugfs2OIbuokNTt4JLG
 u0sqvQqLxsaGg2gemNvcDWDGUfuV7/3k4WPTdMnjddG+1BabMrIFrxtAWmggnfbSawoU
 GPHll8rvKp/L95Dyov+W01qEygoJKAX/XKXgsP/S77BPRLkAQfkMxOU3bZgjDQk9g6cU
 0cPvn84LgG8l7rU3yBApF6SmmbvD1VNBK3gksW/53MzaeRh+dx0Wv56akznla+SCA3M6
 DnSZPNYEei7jCugLetmmXtc1YOQNXlixiBqb4oWuzVrMjnXIOhsvei+Eh2607P2wfY7n
 dQrg==
X-Gm-Message-State: AOJu0YzJ8YLunNXpODGCcfUtJFnt3izZveMPXQAwi1Ui0uKS/CCMhVZY
 g1cAQvXSDD+Z40Xa/ET3arExvhR2TV6Ql3QqfQ7ziPxnxM4pIOOgddSJ3O/x5FFuPaBaBjpF4+0
 alxiYwdI=
X-Gm-Gg: ASbGncu++YIB1JuxJBY+r3G8xkj4HUHzrUH2eemnlh+d3OA71Jn+Pjmb5R5BVhk4ey8
 7iWF5YxRopW+Wso8guJkajFxzUecWdeonQTnAg2+hmEUokXPdloFFoCYcBc+7SImxHUQdcEXbct
 4wyG9Kfsr6fd8hFwksng7Z4su3wN4XD1DSh/0904l5D8g3wsk/emdRy+iYspqAkmqW+9My9khK8
 vGolc81lOWbhINeBdw1ZrQrotgJ3IUXPPd8CrM9KYgyQ8abUU8QvickIDG6k96Dha/MgoUA9R84
 hAS44bGB0kEfI/VSuu6fnC5S6Ij1xpCMFsYg0/4BCOCsHX8wgfJot6oTTm1DgJTm4e8wURMMACK
 omUviQW7ajgsDG53ubJm9zM2a9VBH1mjSPGHHkycrNuOiFNSBqzZo
X-Google-Smtp-Source: AGHT+IG7WkORUhv0vKi/o3LTWA/GYXdgc/GSLKxx6Oj0N3OW77a/+6VGgsjjgpTIV275q6BabSowPQ==
X-Received: by 2002:a05:6830:7195:b0:73e:8b47:a3ad with SMTP id
 46e09a7af769-7419d1483ddmr2726349a34.11.1754176597806; 
 Sat, 02 Aug 2025 16:16:37 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 89/95] linux-user: Move arch_parse_elf_property to
 aarch64/elfload.c
Date: Sun,  3 Aug 2025 09:04:53 +1000
Message-ID: <20250802230459.412251-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
index 5d41bf4ec6..79f8c6957c 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -14,6 +14,7 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_GNU_PROPERTY   1
 
 #define ELF_NREG                34
 
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 7fad9e7b4a..e17d2ed622 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -120,4 +120,9 @@ typedef struct {
 /* Note that both Elf32_Word and Elf64_Word are uint32_t. */
 const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags);
 
+bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
+                             const uint32_t *data,
+                             struct image_info *info,
+                             Error **errp);
+
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 3581b45d50..fdb40722b1 100644
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
@@ -348,6 +350,22 @@ const char *get_elf_platform(CPUState *cs)
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
 void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
 {
     int i;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ade72c7624..422414ad1d 100644
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


