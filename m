Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F1DCA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSS-0002WV-NS; Wed, 27 Aug 2025 19:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSN-0002Hs-SR
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSK-0004Fb-J7
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:31 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3253f2a7679so409802a91.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336887; x=1756941687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfuwnnEEyqUMF25GcyoStR/Yo1BlGQIDbA+75LEtDk0=;
 b=NDvXxkR6kq/tf7kg5sfEaS4a4oObUt6YgZbCmOUDRxGZDshH9gcIhHxH0FCP5IukMC
 iWeceUUhiKvVVu5Yf+LRhkJfz2E5TjAR9HKGM5Qj0p7pgCq85vGBf4S5XXnNS6Qy8nzl
 8CsLOBiZq5CMoeB3OsGWaZJyUelgru+3nAkm1RN9o8RYx8Na6gH6zASUzfjfxyT83gQw
 5fs1QSA64wlqeNYi1ThSr15nKWqU5QlF8AGEgfjdl02OrBGVbOeGzEr2/jDWRm2DTGFC
 BD0CEq+42Q+AdlMUAsaFsGrGyP1XlcXRiPkHODVqKycHznU2tv2RX3KSs2yke+f1UsBm
 zLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336887; x=1756941687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfuwnnEEyqUMF25GcyoStR/Yo1BlGQIDbA+75LEtDk0=;
 b=nx0gI/rx/WnD+gzdDwSul/Z2ui2YkmcL1jQ2Gt7FOP0wrmtarv5YCLwLrqkQhhSm+Q
 CygE1nhrLnDI+AOHQMJ1/IUb4jRXynhsEEO4CXgJKg9vwtZk3SI/4I/hvy0IYeu6oA3N
 xLZG5N3JR+IjzNSvrZmM4pvdktKkXkOPqHVxYbf1CPWyBNIpxOAfsIoBEGJrYFbuTJha
 6Cy9aLd2w4IY11qQykFukciIdJPhS41YfzyAYetk9CNrUe8xDpRCfw4ml5+vCRqoii9J
 MEmL/Kj/LpQVF3w9/ZHmpnUruKMyLjask0zN+1l3rnZduMJtw7QcEQGkDpRWi49FNZWg
 UDrQ==
X-Gm-Message-State: AOJu0YycMPbpP2arl5O6uvKt/GzSEzfXg6GMmFmioclWVUWsKfMOrCMR
 qMwmwf3X2djBnclJSsGnunutXg+XqZ0V7nr5ptRYjlPNlrgimrFa1XXw/MA+aw/xJhICMZHruHD
 OIlcWShM=
X-Gm-Gg: ASbGncsz3J5j/JL/dd+5/cyb+qJsez66y3x/wbfaMczehc81u+7E9BUgYu22pMJdBUS
 vniiZimxQZkXmGWVPx9JX/Gqyc4fkHXPCAY2XRBwAyu4I4ohqh7zl6C6IgftgfJTbAuWVraAi75
 VarHH7dVMZUvAq+/zwaOd5wvAlnYV/UHrX0UIydvzikHoQh5KAxmQKIJqPvQoiWJK0lzRKMH7Gf
 mgUtJ6P1ONIrEyVHzc5iW8bNzDM0hLTpeCLZqRrdw7+vqtAMh+pl/L9zgarukFPyauEMRN+T0AV
 10meXYDkjB99w6MMZrvI9X5ZITr0hKSes6rYy5mzIqecENDu4y4bpej0ijJEel69wDIjFvgd4v8
 eNsCyaOm+Io9lPV3bsf/Mz3ObBg==
X-Google-Smtp-Source: AGHT+IFQ/galYt9SMfA5SxrQBzv1JUiw1zaRvrIKJqDY5/GrlOariQD++9c2L/biJNWhQU3vGzFduw==
X-Received: by 2002:a17:90b:5823:b0:327:50b2:8007 with SMTP id
 98e67ed59e1d1-32750b28118mr8260592a91.32.1756336886610; 
 Wed, 27 Aug 2025 16:21:26 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/46] linux-user: Move get_elf_platform to arm/elfload.c
Date: Thu, 28 Aug 2025 09:19:56 +1000
Message-ID: <20250827232023.50398-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Move the aarch32 get_elf_platform to arm/elfload.c; pass in CPUState.
Create a simple version in aarch64/elfload.c, which we must do at the
same time because of the ifdef dependency between TARGET_AARCH64
and TARGET_ARM.

Since all versions of get_elf_platform now have the same
signature, remove the ifdef from the declaration in loader.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h |  1 +
 linux-user/arm/target_elf.h     |  1 +
 linux-user/loader.h             |  2 --
 linux-user/aarch64/elfload.c    |  5 +++++
 linux-user/arm/elfload.c        | 29 +++++++++++++++++++++++++
 linux-user/elfload.c            | 38 ++-------------------------------
 6 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 77108f3cb0..dee79ce0c6 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -10,5 +10,6 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
+#define HAVE_ELF_PLATFORM       1
 
 #endif
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 90470bd87b..856ca41b16 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -10,5 +10,6 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
+#define HAVE_ELF_PLATFORM       1
 
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 44bb4cbfd3..440871466c 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,8 +105,6 @@ abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
-#if defined(TARGET_I386)
 const char *get_elf_platform(CPUState *cs);
-#endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 92c8ea62c6..1030cb8094 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -342,3 +342,8 @@ const char *elf_hwcap2_str(uint32_t bit)
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
+}
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index c7561b005b..7de1f13f4b 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -170,3 +170,32 @@ const char *elf_hwcap2_str(uint32_t bit)
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    CPUARMState *env = cpu_env(cs);
+
+#if TARGET_BIG_ENDIAN
+# define END  "b"
+#else
+# define END  "l"
+#endif
+
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        return "v8" END;
+    } else if (arm_feature(env, ARM_FEATURE_V7)) {
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            return "v7m" END;
+        } else {
+            return "v7" END;
+        }
+    } else if (arm_feature(env, ARM_FEATURE_V6)) {
+        return "v6" END;
+    } else if (arm_feature(env, ARM_FEATURE_V5)) {
+        return "v5" END;
+    } else {
+        return "v4" END;
+    }
+
+#undef END
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e6e509c0a6..0e41737cf1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -309,6 +309,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 
 #ifdef TARGET_ARM
 
+#define ELF_PLATFORM get_elf_platform(thread_cpu)
+
 #ifndef TARGET_AARCH64
 /* 32 bit ARM definitions */
 
@@ -434,37 +436,6 @@ static bool init_guest_commpage(void)
     return true;
 }
 
-#define ELF_PLATFORM get_elf_platform()
-
-static const char *get_elf_platform(void)
-{
-    CPUARMState *env = cpu_env(thread_cpu);
-
-#if TARGET_BIG_ENDIAN
-# define END  "b"
-#else
-# define END  "l"
-#endif
-
-    if (arm_feature(env, ARM_FEATURE_V8)) {
-        return "v8" END;
-    } else if (arm_feature(env, ARM_FEATURE_V7)) {
-        if (arm_feature(env, ARM_FEATURE_M)) {
-            return "v7m" END;
-        } else {
-            return "v7" END;
-        }
-    } else if (arm_feature(env, ARM_FEATURE_V6)) {
-        return "v6" END;
-    } else if (arm_feature(env, ARM_FEATURE_V5)) {
-        return "v5" END;
-    } else {
-        return "v4" END;
-    }
-
-#undef END
-}
-
 #if TARGET_BIG_ENDIAN
 #include "elf.h"
 #include "vdso-be8.c.inc"
@@ -487,11 +458,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
-#if TARGET_BIG_ENDIAN
-# define ELF_PLATFORM    "aarch64_be"
-#else
-# define ELF_PLATFORM    "aarch64"
-#endif
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
-- 
2.43.0


