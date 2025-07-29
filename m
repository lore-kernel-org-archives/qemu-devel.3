Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4157C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRc-00024i-Im; Tue, 29 Jul 2025 20:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFL-0001q1-IJ
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFJ-00043q-Ps
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:39 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso5672595b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833636; x=1754438436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ou0kAUGugQfCRFzNodYkOh/ttxE7MkU3L6icCkiDZak=;
 b=Uz9iRuN8cXEEo4x4LF5ZUMN6Lf6dN/M4not/cdsTWVuNk1Brk9hYBDg32FmUr3NvwG
 3P5w8znILjCJfj7kK9Bk449qhE0HkFbj9A3kTlJPb/TiKM2xfi2RIBOAUxNrZ3ge/hWH
 6j6WSqHcOW7NHWSfEt2VsSnQRliWgCeb6CwokmNPJiIJd1qxEGK8s8xbeGeQmrRdH2TS
 SldbuzRGmGwfHnp0HbUGb9BT4PyniLNO94zshvE94daeTJJi3yJM+gMTfYX0lGOsDgCq
 AytNOvIzgcn/pqOixqlhMBf/y+qJbHYqvSHlk+kwDgwixi//UpvV+asb7Rr7uq0Jh5F/
 dSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833636; x=1754438436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ou0kAUGugQfCRFzNodYkOh/ttxE7MkU3L6icCkiDZak=;
 b=JZZqFfspys6a1GOpnIkv3h+RzKNrqtjk1iXQXxfst8zAAnzpqP6BjRsQOoe8GUUFFu
 8AwR5FQoX+wzGY5MuDwyGO4SdYHHuini6Y94I6VpNSuFxi5MUJaI8z8tpUUL7hqnRwKg
 a8ya+FTOJtFFtUrL8MCaX4TftWDygQm2izvd/ST/mGHGU06zQsL5DDsAmfzj4aOpgHgT
 1STGOAAuCFK0l67pa5a/SPFJyoy2MlEC3VkJJORI96xXobNpAWLF5vGtXFpagUglS9cx
 r24euBjJqBWxOFTt62jezCkWdcc4wRcQHHtundxlk9yUfrGwgUszC9yr+yO08aWZMfC6
 hjgA==
X-Gm-Message-State: AOJu0YxYDDRu8Zb5TjiWsWQ3M/shObXf9l6mgfCYBndXczDQC0MtJzsR
 cv2rQuOB5OKOm/2gvrXNNKF24nON6uFAAQvGjeak5QWPyWhIb4gPybO6jc1LM0cY37XgKQxbcWv
 KE4Gb
X-Gm-Gg: ASbGncuDRZpfsuPuCjT++l5lyffJUcQiuDSspDTSrUXNJ0faWvOIOMyCfWg3pOP4pgV
 RV0aP/i3BWNT/+FLyWdo7L2vXgPclIhmouiAxnfL3JzxzObTX/KEcxvaIWMC5oVpAOM+L1Ion57
 Kev852duY7Fcz0AderiCiLK7WYt+oBNOmS7qmA2nroYcpSsTf8rPFEsUYdGROpjm/hcCvJyotlM
 Dk4sF64XKWeJYuce5jJlA64EwWuWpBtqO2TNq0b9VF1tHxZf7+sLLwqvH6Qw62GUMpxf6WdLEIE
 Xw0IRmP4ZAvsd4bJj2zP4aMi36F0mWbeywXm8p0+NUPrmZJ35yz9LGvLhssMKAHzt2lYCoJqF5N
 RM7JxhA6vYyak3qYazzngw4WgFktRcws1TDB2mCQDESokbw926ai0gxacBgM+IoaRPANSpHuPbd
 /EyD8Cz5EXsw==
X-Google-Smtp-Source: AGHT+IFWStu+lsZ3Lfc88xYCtlXhNEEybv7WVpUcsJOyWsKnT/UcftMd0cGzK7jsGwtO5Os3p/g0/g==
X-Received: by 2002:a05:6a00:398b:b0:757:ca2b:48a3 with SMTP id
 d2e1a72fcca58-76ab161afcbmr1818616b3a.9.1753833635200; 
 Tue, 29 Jul 2025 17:00:35 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/89] linux-user: Remove ELF_PLATFORM
Date: Tue, 29 Jul 2025 13:58:51 -1000
Message-ID: <20250730000003.599084-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
definitions are NULL.  Provide a weak stub as a fallback definition.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 58f4b642a5..7e218e8cec 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -37,7 +37,6 @@
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
-#undef ELF_PLATFORM
 #undef ELF_CLASS
 #undef ELF_DATA
 #undef ELF_ARCH
@@ -156,8 +155,6 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
-#define ELF_PLATFORM get_elf_platform(thread_cpu)
-
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
@@ -316,8 +313,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 
 #ifdef TARGET_ARM
 
-#define ELF_PLATFORM get_elf_platform(thread_cpu)
-
 #ifndef TARGET_AARCH64
 /* 32 bit ARM definitions */
 
@@ -672,8 +667,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_PLATFORM get_elf_platform(thread_cpu)
-
 #endif /* TARGET_LOONGARCH64 */
 
 #ifdef TARGET_MIPS
@@ -853,8 +846,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     (*regs)[33] = tswapreg(cpu_get_sr(env));
 }
 
-#define ELF_PLATFORM NULL
-
 #endif /* TARGET_OPENRISC */
 
 #ifdef TARGET_SH4
@@ -1053,7 +1044,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_PARISC
-#define ELF_PLATFORM    get_elf_platform(thread_cpu)
 #define STACK_GROWS_DOWN 0
 #define STACK_ALIGNMENT  64
 
@@ -1189,10 +1179,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_BASE_PLATFORM (NULL)
 #endif
 
-#ifndef ELF_PLATFORM
-#define ELF_PLATFORM (NULL)
-#endif
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
@@ -1243,6 +1229,11 @@ abi_ulong __attribute__((weak)) get_elf_hwcap(CPUState *cs)
     return 0;
 }
 
+const char * __attribute__((weak)) get_elf_platform(CPUState *cs)
+{
+    return NULL;
+}
+
 #include "elf.h"
 
 /* We must delay the following stanzas until after "elf.h". */
@@ -1712,7 +1703,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     u_platform = 0;
-    k_platform = ELF_PLATFORM;
+    k_platform = get_elf_platform(thread_cpu);
     if (k_platform) {
         size_t len = strlen(k_platform) + 1;
         if (STACK_GROWS_DOWN) {
-- 
2.43.0


