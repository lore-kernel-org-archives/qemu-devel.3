Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E2CC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIA-0006Gm-BS; Thu, 28 Aug 2025 13:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWf-0008Dk-Bm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWU-0008NH-TU
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77033293ed8so802457b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383273; x=1756988073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suVoDXWExnW7HRwC1OURW6XQc8WcncInBLooRnaEt8k=;
 b=uPwG9mvoCWRV8345Y5FXQyrIhpYIntknmXlRohqPSxL7fxq8yrwhbE4RcI9CdOCi0P
 6QuJClAmmkgmldpWAheWmjFMAhQGmiUmIxDdxwLkHaGwZwFiiDMXAVLQN2gQ51YLnA7U
 eH/+sqHxSNsW9TDNhiPKxr3AsLJ1aRs+A04zC/7XsrrSEXoCOIaC8ExTutoCeA5V+ZIy
 S27KpO1574nADsLnVs7NKrH+MeGBVntrCJUjkZXggPijVHbHmmOLEw4sdEM5hPsGhgsU
 tu0J8Hq3wUq61jtaqDjEetQgjGtHQxKqVwgZDjVrsuY8wQDUE5mwKqpYKemzIEZcVai4
 sIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383273; x=1756988073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suVoDXWExnW7HRwC1OURW6XQc8WcncInBLooRnaEt8k=;
 b=PKhPcdYl0pr71R2oCio6oUkYjUiVe8ibPWSvonPf7/Na/gwbYWBEszePgpdKRpGpLO
 L3+8M0uLGPJANmjPlQ9AccFMATtYB8oFjj85wXGnHigPaVqJedTDTvoNyALOFXov18oz
 wdxDmEFwipGDzIawGZflNJpT94DBTrNbO2vwSHEprLrrH31wKG22aEwNKt+hCES1AItU
 AgFZD8q7lkZ9kDyBy10X61FyCmqxiCU8EvxgijjMhoimWaiFpJpj7Ss+62KDo+J2AgV7
 Dd9Rc/v3+voV7DhhtX9RW+mrMfN38YE3n2hw18IINXE2ybbJQaO3ovzcr9Mgon2hMA7E
 OvCg==
X-Gm-Message-State: AOJu0YxXXhYekJIuK0+GFFFBYtQwB3A/KW2hlc+aK5RiB4KJQ9vGRGNF
 qL11SipTCNrnYBbNIwvYKHyHDClcSy4/NlVpkRCR2/CoopVhVjuRiK4x+1OmK17LveOgvASyluy
 wxevgc5o=
X-Gm-Gg: ASbGncueNKWyQQGLoPq19USDWOLvkuFdfuuMn4DQVL0daR8tip5VEv7U0KYq/BPtgOJ
 TeFtudcl+M6z4bcLhCUQW86+VvZSDS933Qka46MCC7m24JbnmPjvqjLrIrp0D+OKVWs9idNTb9J
 a4tx2WkZ6ZvgoPAe/z7ubfaQ7/PN84xgjux3IQIrfjGpktG2UxWxV0LqmnYCsxJq/lq2szGdtev
 gtzW/QeMlXzpj/6FtUzV9yUJe3zy5kWvBqhPvKon7ohgZVRwRlPs4s5waeQGufUretsKXmLjAKE
 xYCbxAGdgGnPcqcoNa4sZz9TTBxaThd7109EDdJDBgFsWwofYYdITK7NXp/WentY7SHBO9NPocH
 jqXImqzLFHGKk+j/uw08WXzcHlYveHkVkgq35
X-Google-Smtp-Source: AGHT+IGn4+ohQyxoU0IYhTxcXxtDJzz4nBlvZbSFDlz30QzsnUNMeVFTFcVUWZ2/XhWeSftktIENRQ==
X-Received: by 2002:a17:902:e78c:b0:248:a18e:200a with SMTP id
 d9443c01a7336-248a19d6483mr64186535ad.10.1756383273010; 
 Thu, 28 Aug 2025 05:14:33 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 62/87] linux-user: Remove ELF_EXEC_PAGESIZE
Date: Thu, 28 Aug 2025 22:08:11 +1000
Message-ID: <20250828120836.195358-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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


