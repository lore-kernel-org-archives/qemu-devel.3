Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A6CC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRT-0001us-O6; Tue, 29 Jul 2025 20:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFD-0001es-A3
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFB-00042o-F6
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso5672476b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833628; x=1754438428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gmsTdoWMgR5epgRbxoItIZV+Xb1TV36z0k7LZn5QEVI=;
 b=Mp/iC+ZmqvMAr1t77wA4nZLXHgC397eyze5CWVsG3VuWRLqDfONf82FSAMSbg7lslv
 UvXbIRAmg/sJj5D+jmwcnInICBLKuOywTrUpcOqkOIlYz9yTQ1jzhibFY6r5fFlD3IcJ
 cCSnCOgLYKngZ87GAtUptwD/n073MDvQmzqJv0vGZFJ/b6pC9i9OCSdNpoMqJriMkz5X
 6W2n9mmzk+wb9PFvZbYWebaxd8TVUefjDUzKyiCcjTkSKa4ARiYEr3dh/nRd9IerYdda
 vvMXqPuoAhWaFvNGJpCRQJ7HmfiIcMxCwzNwNmLPlcK36VOPVwREgnIHjFfVOMvR/NcA
 ttoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833628; x=1754438428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmsTdoWMgR5epgRbxoItIZV+Xb1TV36z0k7LZn5QEVI=;
 b=iQ7JPtU/yAcbcIfMT4YZQ1XFuyioCm0KdJJlG0T2u1BlhxEWdFKZzIawuA3fWmPIRc
 AeEIdXBausWGn1t8h8szgTOoFDD/KsF4Q3G0mM0iJkdBvN4erRRysg6h2rfYDuk9Z5ht
 3SB1Vo8nYyuuV2ZAswsPY5WrDL5p8wCGyeq76oaN4zZbgrEcogGLUimFpnaPh/Un0m89
 k+3QKrT0P4vVcKmQYetJWznMUAIEZQhYv3YDBRNnbTJJASE3YsDKjspvKCLJza7Nvqq0
 okVB8/pGE/qvUcp7wE5OjeiuA1u1dOD1CHVPKND42DMfcu0YIWZK29YDWQcw7o4yRtVU
 x+KQ==
X-Gm-Message-State: AOJu0YxBIr+Tl3bDvrh56cYrBD48Q0XqPC913IkRm4GBAq/YFlzC7A5q
 agfw3NY03xSJ32qRXjlhhEFYZMG0IW0k34neCMesvMPAc04Qfg1KlMAID6WFflwOXp29YPbpfLz
 i/19+
X-Gm-Gg: ASbGncvtsyIzLvKo44C2lgEtJbT2HNu0R6+SRofi24IjeQWTibrF6smLGhA9rydvQJw
 CY56HiVKLLhoIX2L2OZmhojCIlYEtZh+121oObHy7pTb00JidcAQG0xgQVesMsIzVKUch2NKhJv
 ZYOllCw5qLzFZyDuEg/3PrrM4K+tbCkxOcnlDF2vIk7rbMpp1Q6K/vSLpsK2b0+ygeGPCyc7FQn
 8NiIDSKc8xIbuTvEFIj5IQHRCuzFdyxbUwN5ejkda5YJvGVdUOz1ZUdOv64z/D0fQtNoRCSorOC
 Gko0+vPSsdW9GGogaSEdfT4/K23synyjMsfto1ujPCQ8/QiLqeGG8JVWJQPXA3S2Z7nWDf+Vrq7
 jppMLWJoC3jjit+qmbEHlLL7F09bIZllIbFlDjb2hNlJPhDs2FQw5+MZj/5KqNozoQgXuD1/IXQ
 sIpFi58GFqWQ==
X-Google-Smtp-Source: AGHT+IGG/ER7vyVP2iygVuBjHrJVxm7obbutiJGvskO/RdNXM2G4AsI1CItlMTf42LKgxfTIBLdt3A==
X-Received: by 2002:a05:6a00:17a2:b0:748:3385:a4a with SMTP id
 d2e1a72fcca58-76ab330e62amr1611006b3a.23.1753833627515; 
 Tue, 29 Jul 2025 17:00:27 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/89] linux-user: Move get_elf_platform to {i386,
 x86_64}/elfload.c
Date: Tue, 29 Jul 2025 13:58:46 -1000
Message-ID: <20250730000003.599084-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Move get_elf_platform to i386/elfload.c; pass in CPUState.
Create a simple get_elf_platform for x86_64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h         |  3 +++
 linux-user/elfload.c        | 18 ++----------------
 linux-user/i386/elfload.c   | 13 +++++++++++++
 linux-user/x86_64/elfload.c |  5 +++++
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 484d20aecd..3bfe47ef22 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -102,5 +102,8 @@ abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
+#if defined(TARGET_I386)
+const char *get_elf_platform(CPUState *cs);
+#endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 54413bf651..6cbbee6608 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -156,12 +156,12 @@ typedef abi_int         target_pid_t;
 
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
@@ -244,22 +244,8 @@ static bool init_guest_commpage(void)
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
index df171d896a..cc75b4f2d9 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -9,3 +9,16 @@ abi_ulong get_elf_hwcap(CPUState *cs)
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
index df171d896a..bc40ed8c5b 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -9,3 +9,8 @@ abi_ulong get_elf_hwcap(CPUState *cs)
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


