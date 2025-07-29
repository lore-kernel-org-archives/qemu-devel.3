Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0AEC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugudg-00023J-19; Tue, 29 Jul 2025 20:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJJ-0004rr-3k
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJH-0004gO-56
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:44 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-75ce8f8a3a1so3621487b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833881; x=1754438681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wDVXMkbf8uh1k6EXf1UrVxpK6EEbwg5/xdyhEsotRYw=;
 b=XdqpIO5VGee2l09mlHiRbgWKaPrOJP6qvAZ6IeBqgsVt2stuPMgT6KA2qx7zV+5kpg
 sixiWZtWpc5l3Y8XzB9yWulvB7FcEXgwd1ggMU/Cu1JSvwZJEDyWsTgcHsN6IPjAbGZ+
 yOpKPJ/VbwMI2WCsRW3sSessaBN5N+SemBFkunqUdI472twJshrQ4VmiSIgikUJO+rOq
 uW7RYY0WWXVOU+GKxWexoCHL7EyURpkAzLeV+OHWJSOXACNCeq6cuczWyzTym3fQaJyK
 f3koxh9e9dn51Yajs9l6jer3ddIygptVe1t4yW/toZlr/ok0H9OKJRqSD3rJ/Vu+/vNb
 70KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833881; x=1754438681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDVXMkbf8uh1k6EXf1UrVxpK6EEbwg5/xdyhEsotRYw=;
 b=uTuJbS3GsC4CfBx//1p6QhlVvAn04KA3nTGa0cTpRtkcMrfBwpfTzfyV1tZgEnKli3
 wlmlCaOpotNZuiJe4sN6KOck8rdkC0V56qonmG3h1kQlIdO93D2Rvhd7CLxhltWUJTUA
 NzmyuDPRJAD/deB4Favc9tH/DA89QT/SJ/Wqp0qG0JHMYNioF0/qYTKTjGGk7NY6s2zY
 zVIYshcTdiHMSXihenca8CH5RmfNb4Ml8G6rjYZR5QbIbFciOfIvxE4nXpjtJJRE6SXn
 230xAu8ienALeoCD5Iq4mR7PBeY7qsWFAWaLhTZ/i5qt4yXx/wDcHnEE6VBtl+jcrOV3
 LnMA==
X-Gm-Message-State: AOJu0YxXkV0ifWLTKYspSLF/2j0ksqFk0NXHgrrDikKjGGPahSRk+61I
 gSdrjYaPdZGMGgrvfm9k9Pc6gTpQhU4K4J+8yiHmUrLQfEIzh8CPdX+e/aAxxOsv7tqxBt/H9iA
 JV0Gk
X-Gm-Gg: ASbGncuiwc19n/uG5DW3gYly0fPA4iR+xobhPMtLZ9U9BYT4Je5oT4RSk3ysRt2+D6Z
 x/1vHr0iDIlxSOt6MW19BItRqeGfT3QHCWTZUG/MgLNgfdhqr500pkt0wN9yrCPBe+rboVdAiUo
 Wh6AOinGSynCOJUAv9BxuLyb9igLjBjfdSxQt6tfMRi4zWDgDsYwvim+2toCT6GGcmUUzEQg72l
 uHcu4Uh/iiZVbmH3mFXef6c/AqT3SlbHBbnsRo+EwqaS19OQGMSHJextPw2d1VnPDGptKk7QdRT
 TN0Z8h8eE4BIzlYotwSC1ts26DIFKd9eE62LcoTb/fbPLgMW/TfjqBeOhvGZQZ3BmawFjNtwgYE
 J04VToI2AVT4vWfUuB44pj2igXia93EE5Tel5Lgp80xT5hJ95C42g2xX2c3ZRm+mjU5+DpHcXQ2
 NO7M+usdo/Zg==
X-Google-Smtp-Source: AGHT+IEMsnxYFKPzxwEZrCgKtgM1DyhMw+zcFXdpSPpDENClge8QnQhJaUUuX2dQRtx00JmHdJszKQ==
X-Received: by 2002:a05:6a00:8c9:b0:747:accb:773c with SMTP id
 d2e1a72fcca58-76ab2f4beabmr1843345b3a.13.1753833881279; 
 Tue, 29 Jul 2025 17:04:41 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 66/89] linux-user: Move elf parameters to ppc/target_elf.h
Date: Tue, 29 Jul 2025 13:59:39 -1000
Message-ID: <20250730000003.599084-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 linux-user/ppc/target_elf.h | 45 ++++++++++++++++++++++++++++++
 linux-user/elfload.c        | 55 -------------------------------------
 2 files changed, 45 insertions(+), 55 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 8c0a8ea431..d42b9dc9cb 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -8,4 +8,49 @@
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
 
+#define ELF_MACHINE             PPC_ELF_MACHINE
+
+#ifdef TARGET_PPC64
+# define elf_check_arch(x)      ((x) == EM_PPC64)
+# define ELF_CLASS              ELFCLASS64
+#else
+# define ELF_CLASS              ELFCLASS32
+# define EXSTACK_DEFAULT        true
+#endif
+#define ELF_ARCH                EM_PPC
+
+/*
+ * The requirements here are:
+ * - keep the final alignment of sp (sp & 0xf)
+ * - make sure the 32-bit value at the first 16 byte aligned position of
+ *   AUXV is greater than 16 for glibc compatibility.
+ *   AT_IGNOREPPC is used for that.
+ * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
+ *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
+ */
+#define DLINFO_ARCH_ITEMS       5
+#define ARCH_DLINFO                                     \
+    do {                                                \
+        PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
+        /*                                              \
+         * Handle glibc compatibility: these magic entries must \
+         * be at the lowest addresses in the final auxv.        \
+         */                                             \
+        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
+        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
+        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
+    } while (0)
+
+#define USE_ELF_CORE_DUMP
+
+#ifndef TARGET_PPC64
+# define VDSO_HEADER  "vdso-32.c.inc"
+#elif TARGET_BIG_ENDIAN
+# define VDSO_HEADER  "vdso-64.c.inc"
+#else
+# define VDSO_HEADER  "vdso-64le.c.inc"
+#endif
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 429d343adc..eae3260c9e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,61 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_PPC
-
-#define ELF_MACHINE    PPC_ELF_MACHINE
-
-#if defined(TARGET_PPC64)
-
-#define elf_check_arch(x) ( (x) == EM_PPC64 )
-
-#define ELF_CLASS       ELFCLASS64
-
-#else
-
-#define ELF_CLASS       ELFCLASS32
-#define EXSTACK_DEFAULT true
-
-#endif
-
-#define ELF_ARCH        EM_PPC
-
-/*
- * The requirements here are:
- * - keep the final alignment of sp (sp & 0xf)
- * - make sure the 32-bit value at the first 16 byte aligned position of
- *   AUXV is greater than 16 for glibc compatibility.
- *   AT_IGNOREPPC is used for that.
- * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
- *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
- */
-#define DLINFO_ARCH_ITEMS       5
-#define ARCH_DLINFO                                     \
-    do {                                                \
-        PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
-        /*                                              \
-         * Handle glibc compatibility: these magic entries must \
-         * be at the lowest addresses in the final auxv.        \
-         */                                             \
-        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
-        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
-        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
-        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
-        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
-    } while (0)
-
-#define USE_ELF_CORE_DUMP
-
-#ifndef TARGET_PPC64
-# define VDSO_HEADER  "vdso-32.c.inc"
-#elif TARGET_BIG_ENDIAN
-# define VDSO_HEADER  "vdso-64.c.inc"
-#else
-# define VDSO_HEADER  "vdso-64le.c.inc"
-#endif
-
-#endif
-
 #ifdef TARGET_LOONGARCH64
 
 #define ELF_CLASS   ELFCLASS64
-- 
2.43.0


