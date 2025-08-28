Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C78C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgD7-0003rM-Tm; Thu, 28 Aug 2025 13:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWp-0008If-Gf
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:56 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWe-0008PH-Fm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-248e3ef1641so3008355ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383283; x=1756988083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aA1CZlBtF0AEUKR5am9ISxGmf8nS3Sm9ZoDdoUGF74o=;
 b=vENxvKGQ3QLHGNpFmmQFG8tVyhOgZngF7rW/y05bPGgoJbY915P5Ntttgsds81E2sC
 1mFtBYiQsZp1z0ZA65BM6zkWLuq5Eu3aYfTcanbvEthID2tU3+Hwbrap2HEb2f7p6/B1
 rBOlpVskSZ+kf6HHlZvCu31g/9TGn4XJuCT66Wg2VdfkhQVr9ygs8nZQLCYzaf6AErF0
 Aq2CVMteyrK0nmJuEaUA1jeG4aj1RMVm0h0lzrKu4FDXyjJvjROvb9/26U0gTiIhcSrb
 6Chn32EdtouHcRnXKHLWtcZIMRoZgS3mqf+63ZpA2GfVXnNcnBFcwnwbryxY4aGvC8X7
 ZL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383283; x=1756988083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aA1CZlBtF0AEUKR5am9ISxGmf8nS3Sm9ZoDdoUGF74o=;
 b=nQiHNCTwIcT0a9pPPO6OcFN1YKiOEI5JQYWvZG64gA7hXHXP2pQ2F/R2hjC91z7tt3
 zTR9Mb63ckKcRe6BfhJUeprlyLetaydTR98RGHBTEUm3/At75pjrLMxh1k8lSXh0LnmZ
 zjGcC9yDJsRV6yYV38vFYnESXJdtLfH3/X8M3tYYgBZZXATdOS6JA90Fc2Vy2+GWuquI
 eyc1AzhfEsdEfOY4f76A/5tF2sRR6yplwxT6PbVbTror+dXSquWN9RuNlZqy3rBvBkbF
 GSXyB9HGSjyY+Bu9kAv5KsKeUzIZ8CpPf0GdVg6ETJt3HN31JqsnqodgJfUyx78XFcOl
 PNLQ==
X-Gm-Message-State: AOJu0YwqC6gFOHyLin2tMoWJhtnjQ2hbxFLGqa/HBS5mLujf0auKMNlI
 izaOsDJjT5lgMKQbFmOPyeItBxJroqb4DX/TPj9n1qsBIjXTc5qIVx52Y5LhkTXyj+RziL2xM+h
 iA5anXF4=
X-Gm-Gg: ASbGncs3KHjsUqq3WzoqGzXfCQAl3b5kkI8vS4L+9DQ5C7WIAxxr3NPl91DucIToCl1
 8g3MZDNdU0uaDHUI/CyzK/PM14/cS2ueHc5q/QbT1+g/J1rEEvB9fzOE/oisA9RLGhkVQlJghRg
 NFd0fyFGoi3HBn4lArJVA/MlGTKzr3BzWNoL0dO0mb95PpC9WSYud1gZ6aLm3lPATKadxh4kOrp
 O2pVIziPcnuIyw6T99DtCv30zpCWc2iVN/hjI2nxPyg1BObRBYPJ8qGwQK+RtrD6FlIQwRSo42D
 UyXlTNc33QJyvxRefkS2zCbCIy/0IpE/kYvfS5caPPqpQJ+bWJFKyC5AhBrNJKDKYUbB4A1Y/a/
 BdrufQxxxRizf2lI1AGR6s5+BccWElNH9WP62
X-Google-Smtp-Source: AGHT+IGgC8vC57Ngmy3dJwXz4EutY/+Kw4aau6VfjO7mZKgW+1I+KhCsJgjLbHiAV7olxGREVsNEkQ==
X-Received: by 2002:a17:903:f85:b0:244:6a96:6912 with SMTP id
 d9443c01a7336-2462ee7b50bmr300196035ad.20.1756383283058; 
 Thu, 28 Aug 2025 05:14:43 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 65/87] linux-user: Move elf parameters to {arm,
 aarch64}/target_elf.h
Date: Thu, 28 Aug 2025 22:08:14 +1000
Message-ID: <20250828120836.195358-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


