Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1294C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucj-0008G1-Vo; Tue, 29 Jul 2025 20:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ2-0004fJ-5O
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ0-0004dV-8X
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-769a21bd4d5so1284452b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833865; x=1754438665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bfiIb00hzzMnfP+JG6ux4d2vmSlRDe73ZiSeXXSVVZ4=;
 b=scEnPwEO6LfPoNRDYEF+t+ARSKxvgBt64J6EGieC8nfdjXvhnjygcXleDhEt2aZMp2
 k54/iqlPWFylElpzg9Q1Ln5TFsLWkmQz9sQjixrpcywK5h+KSz6QcXpwceCO2xum3knH
 fbyLevPV2yIqAppWwQFYbkES6v0TYxgTvTBBZuSKR69jtovMF4D0Uyk5E4oHMelghFYZ
 Uc4CDrNWoK4IaUXaPQx0V/Ar189j4U+0YnxrcNzWjwABL2aKBqddzMFtV/+qzFZi5Ial
 OxorxA/ZDB+hqjjpx7V+Lx8DhXxrYcibMe7lzlr1xs3RbdMsE3wUZtJjCAtY+3buwk8J
 g4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833865; x=1754438665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfiIb00hzzMnfP+JG6ux4d2vmSlRDe73ZiSeXXSVVZ4=;
 b=sszvpkSj+gkaxWJBFZeCtUd+VpaqyjKrOYvulyckYxaWJOwn36aR3OpFxFbXkMyoo1
 9Dlbxn3W9zu6uCzlE9gf5SML/jX7DmHkrYwSRoZwILRxC5jRX3tHNixYiZlwIJoJKWBO
 ezWZTBWi9+/Lj+3kUWAq737gSwlK6FFnN2LckRUAylEmJrpZlK1Fx0V4tYWF+aflI/oP
 r16GEb+8tqLA04d/fLVMY2x/Avymj7zD+tuZx9FvXh9qyMAg0Qpja6IEJcDQ8IKY+XID
 41z/U0sJyW6KkVGlwIUicREIfQgh38S5MQ1rg4kUqaWCeKphuSatmTwJwQSffsFql6s6
 nkpg==
X-Gm-Message-State: AOJu0YyeqyqleHJzM31jpideqrJAWSjNhtTIKIv/6LIbTrFOGucAdXUH
 VFCgCvaBWDy4NyiiwElZ2OxhQr5Wjo03Pg4ElRTJknrHjyIdh+02QSUd0d1lfZ8WaRmoPfL6v2m
 Xs/oC
X-Gm-Gg: ASbGncuZtkhieN/SHP6k3W+2I9G5lOMG7a1ZsawysZM+gWvBVUuRI1bWwBPqsmeMxoe
 8tEH2psUfLKKHuDsR54VR3cDsn8QskYqE3Em1QEyzBX+ZiWlgesD5cHlAFJgsNUpXcrBzpL9jEm
 8lD+/hgqq+ucuc2P1i7JILXHd/VDEyqghkRTu3rrQ7SmypWqJ/ogDiZyZE4We+w0PJo2DqgSHu6
 WvsJPbTVD2U6KghZMQ9/HzRL6Ia7ZXJ8uYAOK+v23czDQ5BIj0z7hikAriKWnojCqDaiI6PrqQw
 +3JPSpFTHAdTUha2h6XVJpZLtK7MNjoaST7IQdOeTD6EPpQkBjlZQxkuEYP3v+zGmuMtJX3Wl23
 bgVB3hAX8XadZGvW/7GI9Eechn8WXylP5LIWL/TJCeir8n9UK+SwjIA6F71EFhXi/6Z4iXEzM/7
 NL/7EUt8kDkw==
X-Google-Smtp-Source: AGHT+IG2XKkUA+DW3SxlCPlS9QuTfZ+laXJtZCfH8Kg9yTsYyOiBf4JmrpnAIsmbvA1O1yyFlOhy9w==
X-Received: by 2002:aa7:8891:0:b0:75f:98b8:5f62 with SMTP id
 d2e1a72fcca58-76ab3301f30mr2131324b3a.24.1753833864688; 
 Tue, 29 Jul 2025 17:04:24 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/89] linux-user: Unify the include of target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:27 -1000
Message-ID: <20250730000003.599084-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Now that all target_coredump.c.inc files have been created,
USE_ELF_CORE_DUMP signals that it is available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 347af3202c..6feab68a52 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -159,8 +159,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#include "target_coredump.c.inc"
-
 #if ULONG_MAX > UINT32_MAX
 #define INIT_GUEST_COMMPAGE
 static bool init_guest_commpage(void)
@@ -197,8 +195,6 @@ static bool init_guest_commpage(void)
 
 #define EXSTACK_DEFAULT true
 
-#include "target_coredump.c.inc"
-
 /*
  * i386 is the only target which supplies AT_SYSINFO for the vdso.
  * All others only supply AT_SYSINFO_EHDR.
@@ -229,7 +225,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
@@ -304,7 +299,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
@@ -376,7 +370,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
@@ -400,7 +393,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
@@ -422,7 +414,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
@@ -437,7 +428,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_EXEC_PAGESIZE        4096
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #endif /* TARGET_MICROBLAZE */
 
@@ -447,7 +437,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
 
@@ -458,7 +447,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
@@ -469,7 +457,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       8192
 
@@ -490,7 +477,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 4096
 
@@ -562,7 +548,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
@@ -2502,6 +2487,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 }
 
 #ifdef USE_ELF_CORE_DUMP
+#include "target_coredump.c.inc"
 
 /*
  * Definitions to generate Intel SVR4-like core files.
-- 
2.43.0


