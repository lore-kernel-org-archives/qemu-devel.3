Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3666CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSg-0003cu-TG; Wed, 27 Aug 2025 19:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSb-0003Ma-Ny
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSV-0004Gk-3P
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-771e4378263so349893b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336897; x=1756941697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cj6OR7jxnjd+ksnwoLgD5O63MHYjLxFz3WB/EhhsQU=;
 b=H5nhsHWBSh4QeBVqRzNgoz60cQZ7QAEn9ppRA46PDbaH8Hcme0kkQgrTQET7MlRuXW
 27A1OnItUdJxMXQ8RNfVtAPCQTvlzWOtrOJfrGvUqm6ksw0AZ8Gb/RSN/kOjQyL27iCy
 mDtRCn2T1FCnXVVgpB8JE/8ywtqTsLRNqv6vkWBL1j/S1UX6d/TseohUuv0LfZTYAreA
 KFB7Ki7YdZ8XcCIQwOOBzrrG7xCIhrvkdj9l3pj5h/shDIPRd7dSpPa/X39qvTXBZLx9
 4VZ7hxjKvbeAlxAQLxp/l7g8lnyE2mEIe8bJqf8lIIo2BYc9yUet8rZa0Y9a26Mdj4At
 phGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336897; x=1756941697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cj6OR7jxnjd+ksnwoLgD5O63MHYjLxFz3WB/EhhsQU=;
 b=hhbxzqqzNI84JvFku61HxD+mVVUZ81oJEihzJTrqMcHtkMpKMs6SZIKX4t/UjgBF4Q
 Oehn0jMuTUgfIymy8Bf5E9Gu9PMIkk0zhR9K0goHSKdYE40eDwnn6ahyQLxUy8hP0tXa
 d7A7+/CFGtKv5IxLsFuhdMHrct2aFd9j0Gicldk6Qwt7QsM2URzN4PBKTTDAOAfn8620
 4p3rvBHCFbSB1XbIYiNKCvjN6c+GS6FrjF5NHIKJG6V3BfttI6zPVpMjor+wpZSLUr6A
 Z8YX+hURBfJ+63PKkLRF3d/Fmuk2cDy1oyB6bdNwL1BcD33p2H0fOmcm8qB1A75WcHUA
 r2/Q==
X-Gm-Message-State: AOJu0YyXuHmQplcRinBLkzl1o24sTmxOGMlCTlgn1nUL6n0+hiWhWHZp
 pN6I+z5dh+pw968IQecmeueOxHHg87gI7GSPcxXNKBJeLFzpklyZmETFwlcuKJiXKuSl5jpZL0I
 7WAypw98=
X-Gm-Gg: ASbGncsREkolKl+wbtE1dXOt+7mbZ6FwSqqepg4+T9RIi8YTRT68Ls8kLbkJ4VhOanN
 aH4d4O9TYiTbCEmeMlMF+u5/bX1DoeBx4vBs7hmUa8gChAdGFr4hZetDXspr6ruUYY8E6XgUSKr
 5wI3zNqPrkVUxwCFiHZBKT8MCrJAGPwk0t0JrcyV6f+Pbsbxy3S31YXfO3JmDUjeo5XPXfKbWvD
 q04yYjyH79g/jO8dObNjWb9OxVH/442WxcPA9SUhh5ugylQYZRIsZbtpBQ1Elwa/07GmWzhoFRV
 06jQ4DX/q31ung2GZKUjJeIUbXddRe8w1Yeoj1RKIeikK9LjosFQDg/Mq5eYUHWW+eqZTd6sTVJ
 URQrwRg1BotOyLaX/0A0+nJloUXOWnlrol267
X-Google-Smtp-Source: AGHT+IFqWb+a3TrmDpxl+6Hp2g/GSZYg9yrlB5gVn0+aI/2IwRyNMyP3X77XHKpRq0/abZN1PtZpxg==
X-Received: by 2002:a05:6a00:13a8:b0:770:59c2:e9e9 with SMTP id
 d2e1a72fcca58-77059c2ebe0mr14736125b3a.11.1756336897374; 
 Wed, 27 Aug 2025 16:21:37 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/46] linux-user: Remove ELF_PLATFORM
Date: Thu, 28 Aug 2025 09:19:59 +1000
Message-ID: <20250827232023.50398-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

All real definitions of ELF_PLATFORM are now identical, and the stub
definitions are NULL.  Use HAVE_ELF_PLATFORM and provide a stub as a
fallback definition of get_elf_platform.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 83cb6731ec..d2d73b06fc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -149,8 +149,6 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
-#define ELF_PLATFORM get_elf_platform(thread_cpu)
-
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
@@ -309,8 +307,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 
 #ifdef TARGET_ARM
 
-#define ELF_PLATFORM get_elf_platform(thread_cpu)
-
 #ifndef TARGET_AARCH64
 /* 32 bit ARM definitions */
 
@@ -665,8 +661,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_PLATFORM get_elf_platform(thread_cpu)
-
 #endif /* TARGET_LOONGARCH64 */
 
 #ifdef TARGET_MIPS
@@ -846,8 +840,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     (*regs)[33] = tswapreg(cpu_get_sr(env));
 }
 
-#define ELF_PLATFORM NULL
-
 #endif /* TARGET_OPENRISC */
 
 #ifdef TARGET_SH4
@@ -1046,7 +1038,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_PARISC
-#define ELF_PLATFORM    get_elf_platform(thread_cpu)
 #define STACK_GROWS_DOWN 0
 #define STACK_ALIGNMENT  64
 
@@ -1182,10 +1173,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_BASE_PLATFORM (NULL)
 #endif
 
-#ifndef ELF_PLATFORM
-#define ELF_PLATFORM (NULL)
-#endif
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
@@ -1229,6 +1216,9 @@ abi_ulong get_elf_hwcap(CPUState *cs) { return 0; }
 abi_ulong get_elf_hwcap2(CPUState *cs) { g_assert_not_reached(); }
 #define HAVE_ELF_HWCAP2 0
 #endif
+#ifndef HAVE_ELF_PLATFORM
+const char *get_elf_platform(CPUState *cs) { return NULL; }
+#endif
 
 #include "elf.h"
 
@@ -1699,7 +1689,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     u_platform = 0;
-    k_platform = ELF_PLATFORM;
+    k_platform = get_elf_platform(thread_cpu);
     if (k_platform) {
         size_t len = strlen(k_platform) + 1;
         if (STACK_GROWS_DOWN) {
-- 
2.43.0


