Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5D9C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCJ-0003B4-UG; Thu, 28 Aug 2025 13:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWf-0008F2-Ta
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWb-0008Od-3O
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:44 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2460757107bso8165725ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383279; x=1756988079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fPnYSmw0H+L9FlDEZScOlrbQhE23jpPXeeMmWAqzWT4=;
 b=SkulLYPHTR9Y6oFy1hAjtOy2jEEbF5vpCd/mnTHqZZ0bn8o1HZvp/CdUcVPF2VLWj6
 CQ9jmI4y43Nq11J0+AkmneapFYeDkFIE/b0Aa5ysW+SfmTymiZzdPVWjciZQ4o9VzNCK
 zs7FvkE6JLrsGe7tHV1bRXf83v0p9o6ZNtP9WuMxiIgKM2jnTc8gjcWFE9ExvE0Fm7nh
 SdmIhoi/HLTVtTOFQYUQpCIRPFW+ZW7e8OyNqR6ZlHafS1JX19UswplOqf2TgI2iJTNf
 3bbNzyDJtxXAOngF67K1UCaOlO9/EXhYToF6C8yfQ4de5MTzQjVDAu3WqEH0CGa0cjZs
 M9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383279; x=1756988079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPnYSmw0H+L9FlDEZScOlrbQhE23jpPXeeMmWAqzWT4=;
 b=cwJZDOYTTwyu3LGzroYWwK5sRboJWdmlEar+PlyFSNkS6KYamHdEtiA9gmbn4Cj870
 THdix2qCloMB+Hb2XPWrqceBdYXkxz1wCYLHd1uIWhC3qTnbYI7vpzN2FAFcFTO0QNk5
 ggcyo2eK7UDr9kGzqGKuGgZ9LeKTEouQTYMqAlv5BJpIxBee59j0Ul1LnQLmqUN+rd8t
 4G3IbEB1FGv7wn+ocfVKvruKGE6Ss36rLQtU24qVW0sJ+AOG3sMGuinMZdIAy9xxXokA
 zwO8M/si2sDIvrX60ctnZNiANsDpn+lI1Z/czaaPZEQqwixdyp/vrD2nFoNPo0olvJpA
 3Wig==
X-Gm-Message-State: AOJu0Yzn+YYDfFd5EVC1TQ3/RcPM0toIxZWfSRGQrL9UQszS4Mt2FdBj
 rW5LtPg09UjSWQQ2hz2jpZ1O6oujWAGYFsRed4Q/QDw4pzvX4KF1egfwzisY2C7ti6MxfSuZ6at
 OsNYtQ4M=
X-Gm-Gg: ASbGnctGE6XIsJkzZ+9nIps6CkF2PdotCSLuYX+n20YLxWjhwCFnYjOcypISD14CqO0
 lxEPsP+UA7+sx0F9T9feC85R1VhAwmSVNR/Em18/2FbmYqyes4sAgWEpzdVdS0mn0pC6cQ0YMcI
 2x5eTGhPi0Ar6afBZvBl9UHHGY+NgOsjlNyNM9Qwd01hcNrxROU1y9tmOIlgylIugAjbBSSYp89
 LuNR8Y7GU4tLV2KrSkm/GlGGHbV1qvmSYzBLosS/pP2SXf43xPcGMLxhx0av+QtpZnGgPxPSa+i
 LygBmvJoyKEehciojfK21P7LQQVeYLjxg00dfUlB+zsab1ARsFvcmZwWDz89Bmn+9aNGjQEGUcU
 d3MuDJvgmyvUdr/BFvt5yjat4XvCjkZ8qhSfq
X-Google-Smtp-Source: AGHT+IEMPXzqO7wbQofpthWDEYRb5/qf+R3XVvSihUnLAAg6O8zwX0n3LFn3N1tR20KngAIUO9K0/A==
X-Received: by 2002:a17:902:c404:b0:246:464d:1194 with SMTP id
 d9443c01a7336-246464d13f7mr377206995ad.2.1756383279267; 
 Thu, 28 Aug 2025 05:14:39 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 64/87] linux-user: Move elf parameters to {i386,
 x86_64}/target_elf.h
Date: Thu, 28 Aug 2025 22:08:13 +1000
Message-ID: <20250828120836.195358-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h   | 22 +++++++++++++++++++
 linux-user/x86_64/target_elf.h |  4 ++++
 linux-user/elfload.c           | 39 ----------------------------------
 3 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index da1e0a09bc..99a95ee45b 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -10,6 +10,11 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_386
+#define EXSTACK_DEFAULT         true
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
@@ -23,4 +28,21 @@ typedef struct target_elf_gregset_t {
     struct target_pt_regs pt;
 } target_elf_gregset_t;
 
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x)       ((x) == EM_386 || (x) == EM_486)
+
+/*
+ * i386 is the only target which supplies AT_SYSINFO for the vdso.
+ * All others only supply AT_SYSINFO_EHDR.
+ */
+#define DLINFO_ARCH_ITEMS (vdso_info != NULL)
+#define ARCH_DLINFO                                     \
+    do {                                                \
+        if (vdso_info) {                                \
+            NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);  \
+        }                                               \
+    } while (0)
+
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index f05b1d4dba..f3c09bb8da 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -10,6 +10,10 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_X86_64
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8ff9f83bb8..73ca6c681e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,45 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_I386
-
-#ifdef TARGET_X86_64
-#define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_X86_64
-
-#else
-
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(x) ( ((x) == EM_386) || ((x) == EM_486) )
-
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_386
-
-#define EXSTACK_DEFAULT true
-
-/*
- * i386 is the only target which supplies AT_SYSINFO for the vdso.
- * All others only supply AT_SYSINFO_EHDR.
- */
-#define DLINFO_ARCH_ITEMS (vdso_info != NULL)
-#define ARCH_DLINFO                                     \
-    do {                                                \
-        if (vdso_info) {                                \
-            NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);  \
-        }                                               \
-    } while (0)
-
-#endif /* TARGET_X86_64 */
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_I386 */
-
 #ifdef TARGET_ARM
 
 #ifndef TARGET_AARCH64
-- 
2.43.0


