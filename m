Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA86CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkK-0001le-Iy; Sat, 30 Aug 2025 11:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c0-0004vG-6r
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:24 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7by-0003xo-Bf
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:23 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7722c8d2846so952164b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506620; x=1757111420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aA1CZlBtF0AEUKR5am9ISxGmf8nS3Sm9ZoDdoUGF74o=;
 b=RiE5iJx87Q2MXw26Fknc49p6RE9hjqbb3eDWybETgbz4OnDQhJoaZbdiNvAON3wMCb
 IreBVZWUiJaup1VENMuhOXIxK8vc3PkA6qIObyuRpZVSBXqHkPqYiuwn4sKZV+usNeCi
 eK+K4z3oEVf4A2AjRwasgLVcSf259NbeAq6PVpitW1sBIZuKd3wePNpxoHksZ/E6PN8F
 ZZeV9ULO+70es35GE+k0GvWlBgjVjBdl/wFmddRjErW5tj2GCqpyVT6LZqnWqdiaq5G9
 8Zcb/4Iv35yCNXQrbBoqKfsBPLLGvBW+pHmNQihCQr8yMcDEkCT81nQqFXOGcs1uH/b4
 h1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506620; x=1757111420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aA1CZlBtF0AEUKR5am9ISxGmf8nS3Sm9ZoDdoUGF74o=;
 b=RZlFipUb1oGzF1V/fQdlA4QHfXO6rWhGG0mTZNyKHKTrWz6PcYgf8k6i57A5BPjoAj
 oEJVvv3ce+M3X1f+Zic2TOELHsdQseYg+Ks3LU5epjfGaccQQlWYuXycQ4fpSM7WdLdW
 StP5+PNd3MittlCVvt9NdL/zmaFqYRR6YREb5BHYJYLtXnGGtLNc0IF4oWKT7D5XlgTn
 ZH7FKmHA0cs8yUHfsEHrOwD553OeMTf8v6SikMbb+rW+JaWW/FVuqMdgqTIC+ceItDb0
 YI9SBOyJ9OWZKhDVvmyn+SHxzRGDyYFT41O3zCKtT+t/VtCwYGs83c7GMO3LYvEAMgjr
 yEMw==
X-Gm-Message-State: AOJu0YwEcZ9Aw1ZHn4W2ALcQA4HwJmGYQ3mzxXNV8VhkMx0tt8QmAeid
 eEPcWvIkvY7wiPgA7VUQpXg2uPa0EB7fdnhZsyLFwt0gjPnX481Ay/rZvUlfCNcbfnHjPXYC93T
 6k69XTco=
X-Gm-Gg: ASbGncuUMpMeSrPu+dB2HlZ5UtEX9en7LluOgV8nEU4+tvrX+CEnTU+YoHhqhOInHE7
 n8WR1v85ggc1vA3qhQYMI2pPn19X1fP/i9bEJxi5TYhyu2/USibKnzt/k9GbhbNsl1Sv1WsKwpM
 AEeh6wI3E5DVWAvINghvyKBrx+93YRpL1r3zNZGsfeA6Ap/mT4iLXv78ibd+8cBQIoaww4TkxAN
 pkeJbSSU7kuarSqeaGJvbZSWdGeGrk66zLEntMbywVC75E2xc77UnpMAxUDzhsDu+0rk5SFCHei
 94D5Dr8x4CLE7mPH5R8oDOgD61Bc1GE2b8yd8mYsiJ+pfF0RgwYPqh3wU7thNT8O11Y5YyK2Pdi
 JGkQ87QhMPpBm92g3kz4EfYckINVTSwf1iX+8IrAYoQxmcnVewSTb+LAeWpa91O8=
X-Google-Smtp-Source: AGHT+IGXdP/ZiBMTkhhhoNqqiQu2fjiDWTqvmfSpmyjMpBg07qA0aH4FjpStiygm6M2IInJCzWKiUg==
X-Received: by 2002:a05:6a00:1746:b0:772:bdb:276c with SMTP id
 d2e1a72fcca58-7723e3949e9mr273014b3a.25.1756506620515; 
 Fri, 29 Aug 2025 15:30:20 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 69/91] linux-user: Move elf parameters to {arm,
 aarch64}/target_elf.h
Date: Sat, 30 Aug 2025 08:24:05 +1000
Message-ID: <20250829222427.289668-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h |  9 +++++++++
 linux-user/arm/target_elf.h     |  4 ++++
 linux-user/elfload.c            | 25 -------------------------
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 9eb8bb547e..3c9fef9378 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -10,6 +10,9 @@
 
 #include "target_ptrace.h"
 
+#define ELF_ARCH                EM_AARCH64
+#define ELF_CLASS               ELFCLASS64
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
@@ -23,4 +26,10 @@ typedef struct target_elf_gregset_t {
     struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
+#if TARGET_BIG_ENDIAN
+# define VDSO_HEADER            "vdso-be.c.inc"
+#else
+# define VDSO_HEADER            "vdso-le.c.inc"
+#endif
+
 #endif
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 19fdfa2f2c..d871d6d665 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -10,6 +10,10 @@
 
 #include "target_ptrace.h"
 
+#define ELF_ARCH                EM_ARM
+#define ELF_CLASS               ELFCLASS32
+#define EXSTACK_DEFAULT         true
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 73ca6c681e..838d7199a6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,31 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_ARM
-
-#ifndef TARGET_AARCH64
-/* 32 bit ARM definitions */
-
-#define ELF_ARCH        EM_ARM
-#define ELF_CLASS       ELFCLASS32
-#define EXSTACK_DEFAULT true
-
-#else
-/* 64 bit ARM definitions */
-
-#define ELF_ARCH        EM_AARCH64
-#define ELF_CLASS       ELFCLASS64
-
-#if TARGET_BIG_ENDIAN
-# define VDSO_HEADER  "vdso-be.c.inc"
-#else
-# define VDSO_HEADER  "vdso-le.c.inc"
-#endif
-
-#endif /* not TARGET_AARCH64 */
-
-#endif /* TARGET_ARM */
-
 #ifdef TARGET_SPARC
 
 #ifndef TARGET_SPARC64
-- 
2.43.0


