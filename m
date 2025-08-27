Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EA1CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSQ-0002KL-KC; Wed, 27 Aug 2025 19:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSC-00025N-GB
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:22 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPS9-0004DV-VB
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:19 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7720c7cc05fso310226b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336875; x=1756941675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yEeq0RZk/l844ggMKjsps45XK8zy1/6p2Ssn5uBtVg=;
 b=akYlE5ZBOIbNxve8O2F647FjCDao5wsqh5TH1OW5naxtM125/gWliLdvxftDEXPpHa
 q+dT4b38NldNY9pMUQ403M0MuU2uyFQn8J/mIH6iisSu9rc1k5/DRxKgmGP/mYh1zs9B
 346ClFq7euQtqB24c92Muk7z61Lg5Ui9erTZimHMFHwxmlxiPpSBbD46wqR1qqIICL50
 7wUCoyE9RrIxhUATFtqAN/vh13qZy7ll2cNFBq+3azUB+zSzV9S5peCe5ruDv1N6Q4eW
 jl/MZoQmRr1PlwMNf1X+zWFy8oHm+rvsAhz0MSfnVsZSK4VW4cj+aXRHoPLg3jg6RAFh
 OZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336875; x=1756941675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yEeq0RZk/l844ggMKjsps45XK8zy1/6p2Ssn5uBtVg=;
 b=MtpSGyUt5+ahusi/r2ZCrROkSKatXgMKKHfOt3um+pdow9nldnLWmOjO7LfTR1Zz7m
 /TBJ52ZEq47CJGuy4dN50tAMK95qWYBhKHFlK6hwANXLSyVN49r4HPrfgdUhyDGzdF0G
 S2LckpuzmEQsj8IYa7xBPxlkLEi4aiZVxG0sUVLSRJSfEuB7jjknF5JKcSQY8rUpz7dc
 sgtCZlGma+SxyV2DJ8IZkojsLRfIZ7G5ze2SkUQa//JLDY27qrUE3utEqLXbeWVGOCPt
 q9Lb7tF3FVrwEnSGkeAfSHEM83A/4KV7cF+dv/w+hzMxmdqhM3+jP86SZ6bEXKRbTH5X
 mIIQ==
X-Gm-Message-State: AOJu0YxMp+KFskGNwhn7wTRe5ocJ5ATzv5tDai063tgOE4bsBwybcS1Y
 GNfDNmv1kemj4rWLeZd9CkbzmXdKN5V4jSl5mRADz1xUQk+ePmYX2SL/vPp8ju7Hi6nSO3dWXfF
 E3oGpAZg=
X-Gm-Gg: ASbGncvweZl16BEEeqPHumOxzf7dGvdrF9f7dQizZHONybWHEeOMPpmpZONxw+FAyFY
 pnxvLErFCBGnjodpdjL15FrqMe7dRHS+Oip/WXOndel3n3cUxzUHU6dRkZhkIZNhTYqcjUM0JqC
 HVMhW861YJJY+hCMh7FkIkMbZcw4pf/Im/IkmsLxNaqy300Baa4DyXS2ZBU4YxY54XS3z2Xxk0o
 PpkyD3oYe/fm+69Sli1TLlHtXNTOgHTdXcLeNN6JRyn0dUjFaCDzvwBNtGBYfJshELREcNORpbh
 LQTsa1AXaZqaOYTFDsh3aQOpggb8w9hpcQaypptE7PH7EQP9QdsDXsQN9gzBP1ASYBxO/mbGAf3
 39J9qqrS1KgmMR/vNvz4ck+Vyb57wx2sHO8+S
X-Google-Smtp-Source: AGHT+IGH7/8jG+w/tHBuJAvLApcyxchbL5O2K08XB34Hn4JEH+LP5VIhhHDr3mWw4WtSVe5WCem40A==
X-Received: by 2002:a05:6a00:3495:b0:771:fcd7:ad0 with SMTP id
 d2e1a72fcca58-771fcd710b9mr9069362b3a.22.1756336875527; 
 Wed, 27 Aug 2025 16:21:15 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/46] linux-user: Move get_elf_platform to {i386,
 x86_64}/elfload.c
Date: Thu, 28 Aug 2025 09:19:54 +1000
Message-ID: <20250827232023.50398-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Move get_elf_platform to i386/elfload.c; pass in CPUState.
Create a simple get_elf_platform for x86_64.
Introduce HAVE_ELF_PLATFORM.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h   |  1 +
 linux-user/loader.h            |  3 +++
 linux-user/x86_64/target_elf.h |  1 +
 linux-user/elfload.c           | 18 ++----------------
 linux-user/i386/elfload.c      | 13 +++++++++++++
 linux-user/x86_64/elfload.c    |  5 +++++
 6 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 802395af3a..44dde1ac4a 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -9,5 +9,6 @@
 #define I386_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_PLATFORM       1
 
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 729723cc06..44bb4cbfd3 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,5 +105,8 @@ abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
+#if defined(TARGET_I386)
+const char *get_elf_platform(CPUState *cs);
+#endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 03483bad57..498c3f7e4e 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -9,5 +9,6 @@
 #define X86_64_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_PLATFORM       1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7a41917b49..e6e509c0a6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -149,12 +149,12 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
+#define ELF_PLATFORM get_elf_platform(thread_cpu)
+
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#define ELF_PLATFORM   "x86_64"
-
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
     regs->rax = 0;
@@ -237,22 +237,8 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_386
 
-#define ELF_PLATFORM get_elf_platform()
 #define EXSTACK_DEFAULT true
 
-static const char *get_elf_platform(void)
-{
-    static char elf_platform[] = "i386";
-    int family = object_property_get_int(OBJECT(thread_cpu), "family", NULL);
-    if (family > 6) {
-        family = 6;
-    }
-    if (family >= 3) {
-        elf_platform[1] = '0' + family;
-    }
-    return elf_platform;
-}
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index f99336e73c..1b759098ca 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -14,3 +14,16 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 {
     return cpu_env(cs)->features[FEAT_1_EDX];
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    static char elf_platform[] = "i386";
+    int family = object_property_get_int(OBJECT(cs), "family", NULL);
+    if (family > 6) {
+        family = 6;
+    }
+    if (family >= 3) {
+        elf_platform[1] = '0' + family;
+    }
+    return elf_platform;
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index f99336e73c..88541ea45e 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -14,3 +14,8 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 {
     return cpu_env(cs)->features[FEAT_1_EDX];
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return "x86_64";
+}
-- 
2.43.0


