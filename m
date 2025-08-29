Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1DDCA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmC-0006Pr-KN; Sat, 30 Aug 2025 11:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bu-0004sO-N4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:18 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bs-0003vz-MU
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:18 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-32326e2f0b3so2136002a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506613; x=1757111413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suVoDXWExnW7HRwC1OURW6XQc8WcncInBLooRnaEt8k=;
 b=uaRCzHQoZ5DjNhu8BHVoXhY0w6LfdEEHxy5mZL1+e2Gmzq8SYvHi0PBDLX0NDCj4wv
 yvNzL40f38kGIwhVyV8XIyzPriucwcb/OPVu3OcWjK2ovm7YMP2hXIdk6CGmLFPga6ys
 nAUZCNT/WETa8JZNjnzZ7Yyv0Paq1da7Ecc+dZbsUxPoGLTEhxpdCi4W6gpmDht+JEbO
 V9qgdnClL9SCpYNf4fyxQfnpGnLUX3bwaUWF8J8DXD0Q5RpYOcuZ+KX6suWE4uc82/n0
 y6zkBXdWPSQq1fwHw9/34YpmbIC/9i06zXAtirJLIMvfcIaZinUXSLwz5b12gnkI2CI/
 TWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506613; x=1757111413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suVoDXWExnW7HRwC1OURW6XQc8WcncInBLooRnaEt8k=;
 b=O53t5gyf+aOyEIsSFLENlE/YTQfzaYoMp2Yb5mgCj/Qxa2CAz6ikchg6Q38icCiIMs
 zK2AsUbHVT3oYXDBjjXWV1VeSxP0xQnEz7SJsN2YspIuqmMiJcaowR0wmEO0O40jzS5A
 DaM6TVOYgPa1TkZzthPYNOnB/KoEDW4h2vrKFoKc6cqRKmPFWw2KrIaKNWpZzrNxu0Vx
 KNNvt2HK6CqnxfBff8caq3oxEf2NUs6+Qvz6Xnjt8IFQGKIMKo6shGs/nevPL406DEzw
 JdL87ddeCTrD4bJyyMuSlpJxNJZJ0sjO+6sk3ToGPFZ8Bg+/sUglWJQRuBRQT6ofL0G8
 gcTQ==
X-Gm-Message-State: AOJu0YwieuMz0swdIat6ma9Xz/Bz/Kbn4THnhlgDsn4janKVoTcGhV8K
 PtgS8bcNCdrqUbsuaq91YU+H4UuA24oFoBjx0VZskyAB/q8JwCjaXDLs6OkAapU1+0lAhp/WX5g
 63w9hBkY=
X-Gm-Gg: ASbGncuJ4zOX1soU9jPWW7GvYUm/1AcuJuWwogl8g08h+0jZDkqWnzmWe9mvyl2zK/h
 5lOY2AbBSzJBciFVNFhTf5EA+a+PdTmBe0MaeiZnl5dTh/ZVo6ALUWulZ/XuM1FdA08eMqGh4zC
 qKGs7AQBHU3htN/4zcb49AP7rd0WPaM03JYavqJuXZS3uusiClJR7j8A7dAFxrAN0uYgdN6UrDd
 5CduA+acMWm257ynzGRAa+XLPucBM47BZnR5mP/kdI+b+PCanB08Gpu8ltm26Zxm4si1iDpxkpr
 MTccJNgiNQ+R3wMz5gmqu6xjIB1tKvKn4oZjVlBlgadVIzFHaGi4qQm2IxIoq5ShPVkTIBQoBQq
 qBXMBTKG0xiQNryd3+7SGFqOVph5ZMwz36tUQgf5B2wSgn8EkX+ZKwa6l0Id4jSE=
X-Google-Smtp-Source: AGHT+IHTWlwfLuZcPbwgDHx2mkbAw9zI2JXZ+8E7s3rKZsdBH3yHNEN2AH/BV0+s2OV4HtkWM3lLew==
X-Received: by 2002:a17:90b:1b12:b0:323:7e80:8818 with SMTP id
 98e67ed59e1d1-328156e5627mr326129a91.37.1756506613530; 
 Fri, 29 Aug 2025 15:30:13 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 66/91] linux-user: Remove ELF_EXEC_PAGESIZE
Date: Sat, 30 Aug 2025 08:24:02 +1000
Message-ID: <20250829222427.289668-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index aed390ebb3..59e6605e36 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -167,8 +167,6 @@ typedef abi_int         target_pid_t;
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #endif /* TARGET_I386 */
 
 #ifdef TARGET_ARM
@@ -180,16 +178,12 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #else
 /* 64 bit ARM definitions */
 
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER  "vdso-be.c.inc"
 #else
@@ -258,8 +252,6 @@ typedef abi_int         target_pid_t;
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #ifndef TARGET_PPC64
 # define VDSO_HEADER  "vdso-32.c.inc"
 #elif TARGET_BIG_ENDIAN
@@ -280,8 +272,6 @@ typedef abi_int         target_pid_t;
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #endif /* TARGET_LOONGARCH64 */
 
 #ifdef TARGET_MIPS
@@ -300,8 +290,6 @@ typedef abi_int         target_pid_t;
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #endif /* TARGET_MIPS */
 
 #ifdef TARGET_MICROBLAZE
@@ -311,8 +299,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS   ELFCLASS32
 #define ELF_ARCH    EM_MICROBLAZE
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #endif /* TARGET_MICROBLAZE */
 
 #ifdef TARGET_OPENRISC
@@ -321,8 +307,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#define ELF_EXEC_PAGESIZE 8192
-
 #endif /* TARGET_OPENRISC */
 
 #ifdef TARGET_SH4
@@ -330,8 +314,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-#define ELF_EXEC_PAGESIZE        4096
-
 #endif
 
 #ifdef TARGET_M68K
@@ -339,8 +321,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-#define ELF_EXEC_PAGESIZE       8192
-
 #endif
 
 #ifdef TARGET_ALPHA
@@ -348,8 +328,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
-#define ELF_EXEC_PAGESIZE        8192
-
 #endif /* TARGET_ALPHA */
 
 #ifdef TARGET_S390X
@@ -358,8 +336,6 @@ typedef abi_int         target_pid_t;
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-#define ELF_EXEC_PAGESIZE 4096
-
 #define VDSO_HEADER "vdso.c.inc"
 
 #endif /* TARGET_S390X */
@@ -376,8 +352,6 @@ typedef abi_int         target_pid_t;
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define ELF_EXEC_PAGESIZE 4096
-
 #endif /* TARGET_RISCV */
 
 #ifdef TARGET_HPPA
@@ -396,8 +370,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-#define ELF_EXEC_PAGESIZE       4096
-
 #endif /* TARGET_XTENSA */
 
 #ifdef TARGET_HEXAGON
@@ -2697,7 +2669,7 @@ static int wmr_fill_region_phdr(void *opaque, vaddr start,
     phdr->p_flags = (flags & PAGE_READ ? PF_R : 0)
                   | (flags & PAGE_WRITE_ORG ? PF_W : 0)
                   | (flags & PAGE_EXEC ? PF_X : 0);
-    phdr->p_align = ELF_EXEC_PAGESIZE;
+    phdr->p_align = TARGET_PAGE_SIZE;
 
     bswap_phdr(phdr, 1);
     d->phdr = phdr + 1;
@@ -2805,7 +2777,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     offset += size_note("CORE", sizeof(struct target_elf_prpsinfo));
     offset += size_note("CORE", sizeof(struct target_elf_prstatus)) * cpus;
     note_size = offset - note_offset;
-    data_offset = ROUND_UP(offset, ELF_EXEC_PAGESIZE);
+    data_offset = TARGET_PAGE_ALIGN(offset);
 
     /* Do not dump if the corefile size exceeds the limit. */
     if (dumpsize.rlim_cur != RLIM_INFINITY
-- 
2.43.0


