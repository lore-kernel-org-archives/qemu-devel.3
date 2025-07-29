Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1C5C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRR-0001rr-N6; Tue, 29 Jul 2025 20:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFC-0001db-98
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFA-00042e-25
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:29 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so316238b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833626; x=1754438426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pNRMNTRt+D96aPgUPj4bwewGazZivvWAGKM28165oV0=;
 b=rfwxAtJ4p23SS/u5LtuPvEfrYsbgL5+ZkN2NeQRUyVpKsSKpFYb3t3pBHgyky66fi3
 pNZOHSqoPl9oEeWe1TpB0RT6EOpZggeiZ/bBWZJtBhwExVIhTlzC4Z1ku9OYcoHQnxYC
 r5N2FRlVBpOg/v0Xtjs2rdHNdaAdfvvyW0ZJvTZcnn1ImpcqP0LdLKLw2eEBNghBqZWF
 QKWUyhN+a4J/zRLnyr2kuWFODAYU/qblu+D7dkq0ARTDi7ZfX3WxWUW0DGmfriWoAufz
 +L5IAwimXxmnxoVr+MJVETPJEj8iU62Jh28OEwAZHbrNG71Fic6LN/QMohTL7FYImm6I
 mM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833626; x=1754438426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNRMNTRt+D96aPgUPj4bwewGazZivvWAGKM28165oV0=;
 b=E0RzuWmBWIPMxmsAJ0Pbk3TJUCJnxSIcU7OL8JiCElHeGDcWw5vqxu/ZbPOuQgnlLH
 uWRWt7YMcu2c046Lc5pQLqyhFR+Y4kUlOVMvge6D80mq+b1rpCNy4sIsCYf2U014uxGt
 bgs4xIAnNMM/zxUnoGJr+Nr3SZApY+Ox4bCdnvG84K1d3Ow8PVHOuCYvanuRRdSE9vPa
 cOc52juLm2vhWY+wlY1cQfJ4H+nBiZn08I9z5YTt5aQdxpTa0f5EhbEuV/wT+xMTA1r6
 ONq350vfVEGQPfNRi+RSDXseuap5KNBAz17WVcDFFDXUzP/0lPZp7n2WYiwOdyG9ZA06
 G88g==
X-Gm-Message-State: AOJu0YxwO4fc/cK+4FI44bjlwFEK+rKjGSmfiVJlPPPzEjDnIYXr57Cg
 X5rnt+lnv9NcSEdAax7YnznfGNfhteoZHNWqTmMTlAoVs2enSoR5dvzhg+tfd8UcvJYlCZIi+we
 ZmrZk
X-Gm-Gg: ASbGncuXgHpp/il8v7Q6TFPb3gLG5pc72qzgAUTr9xbj29cNIMOVeGDQYcGq5+N9Ldk
 0VWA7rnivlQ/KG8AT64sDIC5FmgSU/7+o2khSuY4YQMJbeCh7NlmyXK5gsjmnuYp0UaX5Wo4BFb
 gmlJX+AEh6lckxhcLTHLR1+q/5VtLv4qMs+feEZwXjtk/XTBiWaB3SS36sZOjJ0KVnUTKqnC2TL
 oOaOeeWx6IflKtxftmIvOQKf1tNz9jvlYKzzsxryt/AL/NIJnCj6nBKQSdXX/GQNpHIOlWXR2d4
 67Ku7O2OzX3xrlUg20Cd071G02uQIatYF04HjEQme5Rn0afb8gksVvezT4M8TazanEUANMwZOSA
 wbcUVBeheZT7ZGV1EwTHyxW3m+plG4iYE6YgILRYG/11HonVcQNVVAAKnNsig0IQezLqJNsywUB
 GJSsSI6Dbkqw==
X-Google-Smtp-Source: AGHT+IE3C+Jh+P8umGIVcQO6hWk0Jd/qaf6GFv1qPi/StdLwbxX4bYxN03XIqLvQmVB2G2TROrxNgQ==
X-Received: by 2002:a05:6a20:3d84:b0:21f:543f:f11c with SMTP id
 adf61e73a8af0-23dc0cf6136mr1893599637.2.1753833626260; 
 Tue, 29 Jul 2025 17:00:26 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/89] linux-user: Remove ELF_HWCAP2
Date: Tue, 29 Jul 2025 13:58:45 -1000
Message-ID: <20250730000003.599084-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

All definitions of ELF_HWCAP2 are now identical.  The only
catch is whether or not a target defines it.  Unlike the
primary AT_HWCAP, we'd like to omit AT_HWCAP2 entirely if
there is no definition for it.

Mark get_elf_hwcap2 as weak, so that the function may be omitted.
Check that the function exists before calling it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8036f902cc..54413bf651 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -38,7 +38,6 @@
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
 #undef ELF_PLATFORM
-#undef ELF_HWCAP2
 #undef ELF_CLASS
 #undef ELF_DATA
 #undef ELF_ARCH
@@ -456,8 +455,6 @@ static bool init_guest_commpage(void)
     return true;
 }
 
-#define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
-
 #define ELF_PLATFORM get_elf_platform()
 
 static const char *get_elf_platform(void)
@@ -545,8 +542,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
-#define ELF_HWCAP2  get_elf_hwcap2(thread_cpu)
-
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER  "vdso-be.c.inc"
 #else
@@ -601,8 +596,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_ARCH        EM_PPC
 
-#define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
-
 /*
  * The requirements here are:
  * - keep the final alignment of sp (sp & 0xf)
@@ -1279,6 +1272,17 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define EXSTACK_DEFAULT false
 #endif
 
+/*
+ * Locally declare get_elf_hwcap2 weak, so a target may omit it, and
+ * so that here in elfload.c we can tell that the target omitted it.
+ * The declaration in loader.h, used by the definitions in arch/hwcap.c,
+ * remains strong.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wredundant-decls"
+abi_ulong get_elf_hwcap2(CPUState *cs) __attribute__((weak));
+#pragma GCC diagnostic pop
+
 /*
  * Provide fallback definitions that the target may omit.
  */
@@ -1808,9 +1812,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #ifdef DLINFO_ARCH_ITEMS
     size += DLINFO_ARCH_ITEMS * 2;
 #endif
-#ifdef ELF_HWCAP2
-    size += 2;
-#endif
+    if (get_elf_hwcap2) {
+        size += 2;
+    }
     info->auxv_len = size * n;
 
     size += envc + argc + 2;
@@ -1870,10 +1874,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
     NEW_AUX_ENT(AT_EXECFN, info->file_string);
 
-#ifdef ELF_HWCAP2
-    NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
-#endif
-
+    if (get_elf_hwcap2) {
+        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap(thread_cpu));
+    }
     if (u_base_platform) {
         NEW_AUX_ENT(AT_BASE_PLATFORM, u_base_platform);
     }
-- 
2.43.0


