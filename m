Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1434AC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJE-0002BF-Pi; Sat, 02 Aug 2025 19:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJB-00020l-LV
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:34 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJ9-0001A7-Rm
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:33 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-433fa926cb9so459933b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175990; x=1754780790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cj6OR7jxnjd+ksnwoLgD5O63MHYjLxFz3WB/EhhsQU=;
 b=PutmeoIbT76ffclzFlo2QoSnFuIgOpU1HJStmJuWQdjNHFc28apyiTM445Sqzuq0jJ
 2pLnyCQalF1XHfu1QSXqRiF5TiPYWA2sBnr7J4GG57sa/qjqyoid7ywetyqVzutP/utu
 D9hgpqC+BuP5uxjsTH7aQeZYb5y9D1t751jcUuoBD57WJHTNepX2RXKEc1EnzeGmMSo+
 Ye3Y0+fyVN5xvqetZJ9plQQWgGC3ns3su+8oKR1Ag9lxk189L9Hp7IrPov06g/ecQga/
 HpVA0IfJ9h/fUF7QYgRSXmnn22Z+jhVp/xCsRrWHDD9iwCPu7DOKKPh4i/MbJcC/uv9J
 OfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175990; x=1754780790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cj6OR7jxnjd+ksnwoLgD5O63MHYjLxFz3WB/EhhsQU=;
 b=UCVRzaNZdWUrDf3I8/mmhm+SP2DmdK47zPgWaB+QEa3nH3R8Bx2x8q4vm9EUuDnBP0
 oVb28lJZ7uFN/mmBkKDhuIgS0v5/i2pkRon0wLgONJU1jWAe14s7njDNIbtFkg+Fu1RS
 21sZvtNUwNCCUSLyHJOCBTXcN5V4T77Fzv3v0olKCEZObue0ckruhmBiuPCGYlct+iWj
 FINRqQ3+Ya362V0QnUHzqcTYEP1YirJHQXFBYZhA0Rr+tRu1zsD7clxdkNMQINFGENpB
 K/ANFTGDcieRc9MtwRcrWcFrHxKTeAQhdAgMkElbqackVBDrEkj4FNeBwsR2gHlrpnBT
 MSdg==
X-Gm-Message-State: AOJu0Yx+IBiouvpxKhYVCIKsTovWStmtsKIFmZx7ifdMKqchJoG+FiAu
 Q1VW66uB4Yb/DXMnqUwKC6FbsVS4EVnV6X/oL797GKfTbSWyLzgiHdseUFGYVlBjI/K7oAYzmPc
 3/nxxzxI=
X-Gm-Gg: ASbGncu30O4X/S/7zFjTmgfXCWcKQZ7KSNdrsGKBwQHDNYXrDb9juYIUNu0MFABLLUR
 uFCnRaqV2Pwa6GRL+Cmr9qlbMBo1VJ7RM5ntWbKixiB0anKfpddTRpR6az3dpMSYBosAWP777aY
 Ngf0y8deMX/F1mf+N098AAWcvU1V253subL0CPqLpD2ZdM/1Wkm2FJCiX48rRWZFJszNWZQoXbw
 NGAgCSScINeL+IOkGlZ9VrYP7+b/+5/8Q8MdPqevcRp3p/gXXAx+pczRu5L05IwWeCxAvxd0n9y
 iPQ1O+ce1xU5thIxBSyqeXkVYzjOKAw+DLIsIB3DZ5xgnKKUI/1XCfxgr3lR/KnmPfwz2LYU3Do
 jw9oeqIbNAShD/72myLx6KKlGF6sGsYry+7FQJMDA74KulBbNNl0MyELHod1ScBU=
X-Google-Smtp-Source: AGHT+IEBiAe1HaqFUuWBjoUI7kWFK33FPyJvCl4v1q1uuXnqrwGUUVvg6qXZrsfqaRgVeLNQP1CM3g==
X-Received: by 2002:a05:6808:3509:b0:406:7af5:30f2 with SMTP id
 5614622812f47-433f0363587mr3550042b6e.34.1754175990613; 
 Sat, 02 Aug 2025 16:06:30 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 22/95] linux-user: Remove ELF_PLATFORM
Date: Sun,  3 Aug 2025 09:03:46 +1000
Message-ID: <20250802230459.412251-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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


