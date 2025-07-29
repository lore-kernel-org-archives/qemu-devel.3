Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EECCC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguch-00083y-FR; Tue, 29 Jul 2025 20:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ9-0004my-Iv
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ7-0004f3-Q8
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so4186034b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833872; x=1754438672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aB8lRdH7yf5aiRnNVr9D16UZuwoyOdOh75GfXw+byEc=;
 b=XJE+Vt1CCO9W0SxkW3s/459XB2b9V4IkWeiR8OUiSBi/uEn9qiA+2dcjVaYEvwbHFl
 81OUqk8QPvONo3ZUwVgj4/Y3vi/ij+JNNgYgk3wb+wRC/LcQcfCoDDx+A6P5BZXE+aMp
 ubVVnCGMzlW1tWcY0fQhWXYiGt2hSWNJ5IVOp7AT3dM0FQNzhj3s4WBlzgqevKmvLpdN
 x9fnHCh+7jzxk+ah41YWNgg2nKrfumKk6mBrIF7Yfse47VFdZTmd5axcXWZbW6UwWlFZ
 NbEvVhW8FZkw8S5VfmHyuaUb9vw+fPyGCj+rqcEpTB50PwfQjsJRmHjmPr8qY6GMeQG1
 KLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833872; x=1754438672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aB8lRdH7yf5aiRnNVr9D16UZuwoyOdOh75GfXw+byEc=;
 b=r07GlKI1YxuorSl8PJ0iOfPtgsMrvPjaPxZuy5fuTohtNG+j0qVgqNohaI80kSO9Dw
 Z4bWxOimGC+mB1BwKwVfZi83gOmwUYYrOCjtXUsDvEoYSQAsy68e7VJsXaIMQAk+VDc5
 /t6o+xhFD68BZZb4I96Zvxq8lFxHoLk1CkEVWoy9pvSgLkCXQ/lLZ4nrw4laxj+wsd69
 +Eo+RO1fkVIQDAp6A7aZFt1eBHDU2ErabdXahnAOQCYTy3Cu+wSzB9Ctg6njHlOAgx2R
 98fQYu5xPPoAfeMynXnV73dJ85Pr1751RWEJyeaCvrVA223hpzaqgzpuaKXOVIsQiqHc
 kQ7Q==
X-Gm-Message-State: AOJu0YyvBpI+3V6trmrG5so9nKwtJtiPYJ0g3WgB/PyghC+d4bfO9l08
 7tOixUro6XVzKx6t1nFLRZrMR0x+G05ipBvRe3xbnsXRzxRBTDLr+f1zoFJX1wCq6yAZOtFiq/v
 kDrAW
X-Gm-Gg: ASbGncvBagbMffhk6KlIyjPXTbePyF2H+o2MG+dx/pFAyu3Kc441eZty/hEGeyLKnvg
 KvgBwTo9le8whOgBc6LZHiKqGAFydeX4fVZGNSpHLtwq9Ky7GzZKBkYZ66qbfm8cBC2yTxA9MAi
 62+Xtyz57CDgA108Pus7qgqaWlN8o/nPpncvbZZFW7YMS/u07vznzbZ/qgJM3UJ885D5g87VP+T
 N0v4hH8pXAyWfnD+L/vX1kkXPeNFsnJ2rpzFqO5kffkhXA9HaMZxKC0n0qqAtjZoxgidXPKubiI
 rzpqn4UZKkmhy/JbCAMPIBhWX/weVOHAY//eDPmm8w3/P5YMoRW0+uKcVIDZfgMRLJmWJlJCLIY
 6gVtUTwO5Z4pk6dzd/ZSPzzlj4ANTAkwZj+qrZ/Wb7/jR0sKjvY2YXFKMuw8is/kE2S0GrMx50h
 GyaKqGqbQp0Q==
X-Google-Smtp-Source: AGHT+IFSoeSY5+AjU51sS0vdQytskPfb5+I7kwL5QyCnQCaQUrmQzKGddLrutbwUerqStbWtcrzlJw==
X-Received: by 2002:a05:6a00:1150:b0:748:e5a0:aa77 with SMTP id
 d2e1a72fcca58-76ab2938394mr1931088b3a.13.1753833872153; 
 Tue, 29 Jul 2025 17:04:32 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 60/89] linux-user: Remove ELF_EXEC_PAGESIZE
Date: Tue, 29 Jul 2025 13:59:33 -1000
Message-ID: <20250730000003.599084-61-richard.henderson@linaro.org>
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

Use TARGET_PAGE_SIZE instead.  If the target page size may vary,
using a different fixed size is wrong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 10fbe71e35..1ac3a20813 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -181,7 +181,6 @@ typedef abi_int         target_pid_t;
 #define VDSO_HEADER "vdso.c.inc"
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_I386 */
 
@@ -195,7 +194,6 @@ typedef abi_int         target_pid_t;
 #define EXSTACK_DEFAULT true
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE       4096
 
 #else
 /* 64 bit ARM definitions */
@@ -204,7 +202,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS       ELFCLASS64
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE       4096
 
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER  "vdso-be.c.inc"
@@ -275,7 +272,6 @@ typedef abi_int         target_pid_t;
     } while (0)
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE       4096
 
 #ifndef TARGET_PPC64
 # define VDSO_HEADER  "vdso-32.c.inc"
@@ -298,7 +294,6 @@ typedef abi_int         target_pid_t;
 #define VDSO_HEADER "vdso.c.inc"
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_LOONGARCH64 */
 
@@ -319,7 +314,6 @@ typedef abi_int         target_pid_t;
 #endif
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_MIPS */
 
@@ -330,8 +324,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS   ELFCLASS32
 #define ELF_ARCH    EM_MICROBLAZE
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #define USE_ELF_CORE_DUMP
 #endif /* TARGET_MICROBLAZE */
 
@@ -342,7 +334,6 @@ typedef abi_int         target_pid_t;
 #define ELF_DATA  ELFDATA2MSB
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE 8192
 
 #endif /* TARGET_OPENRISC */
 
@@ -352,7 +343,6 @@ typedef abi_int         target_pid_t;
 #define ELF_ARCH  EM_SH
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE        4096
 
 #endif
 
@@ -362,7 +352,6 @@ typedef abi_int         target_pid_t;
 #define ELF_ARCH        EM_68K
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE       8192
 
 #endif
 
@@ -371,8 +360,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
-#define ELF_EXEC_PAGESIZE        8192
-
 #endif /* TARGET_ALPHA */
 
 #ifdef TARGET_S390X
@@ -382,7 +369,6 @@ typedef abi_int         target_pid_t;
 #define ELF_ARCH	EM_S390
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE 4096
 
 #define VDSO_HEADER "vdso.c.inc"
 
@@ -400,8 +386,6 @@ typedef abi_int         target_pid_t;
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define ELF_EXEC_PAGESIZE 4096
-
 #endif /* TARGET_RISCV */
 
 #ifdef TARGET_HPPA
@@ -421,7 +405,6 @@ typedef abi_int         target_pid_t;
 #define ELF_ARCH        EM_XTENSA
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_XTENSA */
 
@@ -2743,7 +2726,7 @@ static int wmr_fill_region_phdr(void *opaque, vaddr start,
     phdr->p_flags = (flags & PAGE_READ ? PF_R : 0)
                   | (flags & PAGE_WRITE_ORG ? PF_W : 0)
                   | (flags & PAGE_EXEC ? PF_X : 0);
-    phdr->p_align = ELF_EXEC_PAGESIZE;
+    phdr->p_align = TARGET_PAGE_SIZE;
 
     bswap_phdr(phdr, 1);
     d->phdr = phdr + 1;
@@ -2851,7 +2834,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     offset += size_note("CORE", sizeof(struct target_elf_prpsinfo));
     offset += size_note("CORE", sizeof(struct target_elf_prstatus)) * cpus;
     note_size = offset - note_offset;
-    data_offset = ROUND_UP(offset, ELF_EXEC_PAGESIZE);
+    data_offset = TARGET_PAGE_ALIGN(offset);
 
     /* Do not dump if the corefile size exceeds the limit. */
     if (dumpsize.rlim_cur != RLIM_INFINITY
-- 
2.43.0


