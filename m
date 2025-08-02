Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71FEC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJB-0001vd-1q; Sat, 02 Aug 2025 19:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJ0-0001L4-Ay
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:23 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIy-000194-FK
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:22 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-61585dfc8f8so1027620eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175979; x=1754780779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfuwnnEEyqUMF25GcyoStR/Yo1BlGQIDbA+75LEtDk0=;
 b=O+J4heJ8wOCI3ZGa95WMOanb6uZGKK38rdQXpOmErcp2K8sLdyoX/RHLOZ8N3CHZwe
 1u1HZsCx/worgLCe6wzKTO6j+jS2VwKBhbMLEPKCewr+AEt6l9T5SAh0z+MI7WzR47Gt
 ndtf/mK/jIozYZxB1neqCUc2KDBaDVEEaueKpm4sj0MV864W5uVyVFFWzARjR8pgHxpM
 c+yVtq1JAnJKO2d7Qo4mnDArTWCwz3h+p2Qa8+iSIOBFOai7bdzqTBme4PbqIYFOJv/L
 6olMmMkbq3kDlgTrIZmBen/9CgZfLMhJC1uD0T6iGk8Txp4WCXZ8s8EvJ2dsZZh0K0Dx
 qkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175979; x=1754780779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfuwnnEEyqUMF25GcyoStR/Yo1BlGQIDbA+75LEtDk0=;
 b=GaU796Jr9v/0SHBZYVIFOR7QzgiFKgnJejXVYp8wRWxoMwMJGIX+5+eARpxpA8fb2d
 stnrMsW6N1xe+iVpkItJAmskKs+qvikUWLTR/gmO587osNGduBMB/oZr8TKzDo7prLaL
 6fGaZXB5qYLpVa/gbZ1Mj92AdE9dQ0Z8sJjkG4SKu+jpCXeUtd+LBF+ZN1PS61AEWvnS
 20jdXsslYiS53HpT4jh/SiHtyJi+F0UaxtpUNb0Q2Yoq5niAw2c+ZSGurPA8UcJs/kya
 wFhGYRPlLBFGBXL++5ynZQnCsoqyWssQ6x5hZrzat5ULpW1nfH4rrjBXPvZiUjugafOv
 ynjg==
X-Gm-Message-State: AOJu0YwIQracUJD9rWf1SDG9xigPdKa1S0AZ0EkPpROh8Fz4812ajUw4
 ui+LQ0aXOiQt90hflBmjEs8RymshCkpeH0S90YkDebejXT0L25VmyhShqZSksEdRo0MlKwqvlLk
 3CSfyvu0=
X-Gm-Gg: ASbGncs6rKnytaR9SuTjH/BHU8DyDDH2ZWfYe7LJF1PjORqHEELue8IemH4+CIa5bez
 3OtBASzE2vZCbjPr+XPD/ThP6YLjw/SKX/ERWwSoJpeHoKHSbtiRAEmixBm/FW95cAFVZ0JN2Hd
 ccDkU0A5oTlkpsG0eYK2VRQDpzdO/W5sCrEa+sE+ARplfqAcQMMjl/KvEvHyTbXssFOeUJnylaX
 TIhxhQlWP6gUkvFy120NWGzQ9WNHspl5iinlhebGu8HEXwJrfBQ2dWqzP7F/dExR9F2HN8E3Trt
 O3FyDh7FgZZ4LgN28PMwwyrahDfW1g2nMuK4cw3tQoVsrD8v0fGz+tlrhRTJcqNFqWRPkiU8wBK
 OUG9yU7D8L2mlaAV+2Z9hDOeVe0HPEXtEFCEHrUOXUG7vADDbkNhM
X-Google-Smtp-Source: AGHT+IEWjbrYIKqJG2dvSTFTk4t3zDpYsUAoo22C4w6uoJ/Lpa31ItjmOzVT4rpESwCoR1ObzDEmiw==
X-Received: by 2002:a05:6820:1a0d:b0:619:a34b:3e3c with SMTP id
 006d021491bc7-619a34b42f1mr857410eaf.6.1754175979327; 
 Sat, 02 Aug 2025 16:06:19 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 19/95] linux-user: Move get_elf_platform to arm/elfload.c
Date: Sun,  3 Aug 2025 09:03:43 +1000
Message-ID: <20250802230459.412251-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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


