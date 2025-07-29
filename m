Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A40C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguoQ-0002H3-Uy; Tue, 29 Jul 2025 20:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMV-0006my-7L
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMS-00057e-QM
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:02 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-315f6b20cf9so6727992a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834079; x=1754438879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lgGEqtm67CSxG8kcjLYn+s9ezHdinYD/rh9GJNXU2vs=;
 b=sYObtRNz7QrI+bSYkbpVhWchGCmfAwHDJUWWKCmnyqJqrwfQYG/21WtoZ40GKE5LQ6
 B1J+kgGv2rtfTsLOl1720fd/StgfM66nbW/HsmTK5tZcwSvxLE0lPfhWDcMq5A48LE5O
 nWfEgOy0QF68ywwg6IK+t4hA9tgI55/QwFCw+ewN2q+4zpqDNTx1eUeyoYxTsp+gyhTl
 9eHd8FBVdjaOt8dRU3UKJ14LW+83z4CsPhoZc59hk67m2+rwvTUpbZBSYOolhFMdIMwA
 Loy5+JiTxn8byBjhgEcYtLoimM9xi0tdoX42jb4t4WHytCy4m9bi5ILkTKIMBqLUY5jB
 z4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834079; x=1754438879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgGEqtm67CSxG8kcjLYn+s9ezHdinYD/rh9GJNXU2vs=;
 b=FfZsV2KNr+HZgYnJIPUXxzhZgw0VutXrP8OgGLYUUW4MAomE4UXWcVJWklKXjqAWHE
 TZ1tS3JR/wURGa6Rq3r36+E9x2ySO0l8UT0lO6/7WwNE106z6Ecc+3DYzR4Romy4EWSr
 86rWAML3sdWJqF0zs7vsLWOnu/1onxm4EqDyGs2RP59/1MlEjGDLSjXbWwYUIo+RUoXK
 Koak6kYKST+AuZEt9XtkuytjlR3ANNvH9k4e707JeegRJ+mXvS7RYMZkeQ3v9Xx+saZe
 b9LJ2R6PbFz9/2zo9RyD3ntTSY4OCNOlbZYEgBPfI+A3BuboIpgUAe3NRqGikDdFCked
 94Rw==
X-Gm-Message-State: AOJu0YxbKOb5CllxQEURoDLVTXFoFJubC4IZsl9CswTunZFdQ/Uwh1g7
 iAB+dE/MngM7vQhAULSbqZzBzzXzxrK6zovnEONurp56eVrPpH0Js95myrJcuG68+/UDqqulwbi
 IoI4Y
X-Gm-Gg: ASbGnct3geae507c0qBrUbCmJR2Xh5ZDS9KyrUjB2U7j26T63hJosEklElMN9PIoGF1
 rh+5bBypCZz0lFkQJaHxnJgpnsjWgLVJyGk7d3s5g12SSzqhIhWq3vSGp6YHvb3mPVVVh0KaJZV
 GISKly4T9TRfrfmWxJno8I/aYEpPcl4Jv+7c+8YgpAuaxYQ5t0bV9TODScU9oJ2O7snXEc5cUPB
 IEtS+h9IAjBP+uP+k028lZ8vljEKYb+GX3JQRuam913ZRUGtZbQ/IEwhx/lPA3RjqEQOKDgrg38
 TEDbIY74JULs2xhfC6bAnodyn4zHuPLPUzpwSgQ9UKsdfbdARuubXrWD7WuSybo82wrwHrVVTsu
 32yzUlDfrZlXcHVyOYS4dr7iaSTRX/TRv5wnsdBEwsYH2X7KgpERBzUxYUgL2iGYGhiwgc/v/LU
 gNpACLAnwTvg==
X-Google-Smtp-Source: AGHT+IFMxcRmOoy0Zbn3lLtkVHb45LRjoZHll9jLzWlcqYsKFQFenAh1j0eOLNSd1JObvXNj5yv/oQ==
X-Received: by 2002:a17:90b:39c5:b0:311:c1ec:7d12 with SMTP id
 98e67ed59e1d1-31f5deb8759mr1656022a91.23.1753834079182; 
 Tue, 29 Jul 2025 17:07:59 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.07.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:07:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 80/89] linux-user: Rename elf_check_arch
Date: Tue, 29 Jul 2025 13:59:53 -1000
Message-ID: <20250730000003.599084-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Rename to elf_check_machine to match ELF_MACHINE.
Remove the unnecessary definition for loongarch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h        | 2 +-
 linux-user/loongarch64/target_elf.h | 1 -
 linux-user/microblaze/target_elf.h  | 2 +-
 linux-user/sparc/target_elf.h       | 2 +-
 linux-user/elfload.c                | 6 +++---
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index f5eeb36b31..510fd53cd8 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -17,7 +17,7 @@
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ( ((x) == EM_386) || ((x) == EM_486) )
+#define elf_check_machine(x)    ((x) == EM_386 || (x) == EM_486)
 
 /*
  * i386 is the only target which supplies AT_SYSINFO for the vdso.
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index a76aa9f56c..5f6c1c2808 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -9,7 +9,6 @@
 #define ELF_CLASS               ELFCLASS64
 #define ELF_MACHINE             EM_LOONGARCH
 #define EXSTACK_DEFAULT         true
-#define elf_check_arch(x)       ((x) == EM_LOONGARCH)
 #define VDSO_HEADER             "vdso.c.inc"
 #define USE_ELF_CORE_DUMP
 
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 037ff595b6..ecf163d7e6 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -10,7 +10,7 @@
 
 #define ELF_CLASS           ELFCLASS32
 #define ELF_MACHINE         EM_MICROBLAZE
-#define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
+#define elf_check_machine(x) ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
 #define USE_ELF_CORE_DUMP
 
 #endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 8071638e18..3fa5d12e34 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -13,7 +13,7 @@
 # define ELF_MACHINE            EM_SPARC
 #elif defined(TARGET_ABI32)
 # define ELF_CLASS              ELFCLASS32
-# define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
+# define elf_check_machine(x)   ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
 #else
 # define ELF_CLASS              ELFCLASS64
 # define ELF_MACHINE            EM_SPARCV9
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 41f022569b..5185c84e58 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,8 +138,8 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifndef elf_check_arch
-#define elf_check_arch(x) ((x) == ELF_MACHINE)
+#ifndef elf_check_machine
+#define elf_check_machine(x) ((x) == ELF_MACHINE)
 #endif
 
 #ifndef elf_check_abi
@@ -364,7 +364,7 @@ static bool elf_check_ident(struct elfhdr *ehdr)
    This has to wait until after bswapping the header.  */
 static bool elf_check_ehdr(struct elfhdr *ehdr)
 {
-    return (elf_check_arch(ehdr->e_machine)
+    return (elf_check_machine(ehdr->e_machine)
             && elf_check_abi(ehdr->e_flags)
             && ehdr->e_ehsize == sizeof(struct elfhdr)
             && ehdr->e_phentsize == sizeof(struct elf_phdr)
-- 
2.43.0


