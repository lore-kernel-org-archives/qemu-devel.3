Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D92EC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugudj-0002TZ-OI; Tue, 29 Jul 2025 20:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJK-0004sQ-RF
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJJ-0004gq-97
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5934235b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833884; x=1754438684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ACTPDzjgFM8M0mjF0F8qeqd+i/BH+25wG7KoNivcYas=;
 b=lBBqK7t3rtpDmX3+wZoXjW5Vuxi/3EgfdXYwVxxu0uwA/A5EKnT43bAQAkbhNr/EPm
 7US/81ucXpADhsiqV4WJAHUr9hp7xgocLvfCtYO8lqAP4/9f1C3IV40+5cA1y8YlMJxq
 gBoLq5a9ItqL+WopZiLyqWKRn16DEM3EDks7f0DUIynSyROMS+H3AWM6MsY4PremuZAR
 VMSmPOpYovUz7dXUcR+gJ5kFmRwYq61xJMMWltLHC53xAnUjHzEQZlhKmgnh/OS3+e6t
 232C/8aR+QhScATUh+IeT7lAGQ5EpLKlp7mKwq94dwpJU49bSLEpKjMJmc3Gz6gnmHX1
 +4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833884; x=1754438684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ACTPDzjgFM8M0mjF0F8qeqd+i/BH+25wG7KoNivcYas=;
 b=Q12CaI0d1Mh+caxuwyZHRFmY0EVM10D43d9JiaV6Hg4vRP3DDsBdLxdez7r4S4RpNM
 zqep0xiVebiKM1tNa6/ugBa9WovGje3U7bn5plkQ5/QQKRbgTtiINkKvCTMjRpQfkHGg
 tnWKdwmaxTY7a9AKIZcGNo+tw8GJHXJrWb1HvXp0Ol3OdS5dkk3iwB/Qv2UlvQzGAIhw
 uxsKH6i9cC8tK0qLziqNXeOWGSR1fyb7oXXae2PWTcQQzhObi8UWp1IOZL+G69cjC9V2
 QkAR7DALJxp3Cjcm8f7rxA7du2Ivxtg20+X1nmjGsw0zQJiAdf5a3yOgQJurLaeYUP7L
 nXvA==
X-Gm-Message-State: AOJu0YzJ9EYDrjBWnYYe4aF+4HP8Qsf8uRqOuvOqSjTJkagB1AS4NAx+
 VFAMrGnjqXdgbLxTq3LhuBnD8Q4N+rkD964Tj3/OC32ZE2Q+oNa8wP3huseAhgGYQ62wVTGof/x
 RZ+3k
X-Gm-Gg: ASbGncvjJzcjsdni5hWT7ctghS5rpCvi+mrIqkxUKWW4t0LxPSkx6qhg7PfHNBrDkm0
 I54eggyEp+f/t9Vypk8gMKZfRZfo7RSWMVO/elYoeYmLuZL5ISpmRloiC1+aNN0ujTcCzjgsX1E
 RmDkEXya1QHIaiTc8iCpvO3J9Q6i9RzZPNWRGfd/BuLwHJv1a/kE95CzdCuSddgSFD/B7sPk14F
 Jib8YuZmIDlNR9wd2CfE+sKtYCRAlHnspz2oBXjabkg1n6J4Kz9s36785dc5d0E7tArIB8q3tSC
 rrzv3JYZM3vz5wdDPE+8u361NWqj+FxsHTBmUuqywdcUDpUQH+0W4aZoI+mbG3/VfjxFE+QH6dH
 O0E281Ine+QH+LEDrW5O9QdZ+VXplK8pCuqjZJYw0sciZemAhDwWOjlf4/9FwUQ1rq4UGTtK4Hf
 PXM1GQm1mi0Zek5WCUKgx3
X-Google-Smtp-Source: AGHT+IGeOFqIN593tLV9TZbcSlmvPYEFcZjQsrFlGGqoL8ingwzSvbhK6Q0Ao79OF5mARyfVY0ER5g==
X-Received: by 2002:a05:6a00:2347:b0:74e:a560:dd23 with SMTP id
 d2e1a72fcca58-76ab30c553dmr2238588b3a.21.1753833883869; 
 Tue, 29 Jul 2025 17:04:43 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 68/89] linux-user: Move elf parameters to {mips,
 mips64}/target_elf.h
Date: Tue, 29 Jul 2025 13:59:41 -1000
Message-ID: <20250730000003.599084-69-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mips/target_elf.h   |  5 +++++
 linux-user/mips64/target_elf.h | 12 ++++++++++++
 linux-user/elfload.c           | 20 --------------------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index febf710c7a..850a6d83cc 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -8,4 +8,9 @@
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_MIPS
+#define EXSTACK_DEFAULT         true
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 02e6d14840..77f3b4685a 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -8,4 +8,16 @@
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_MIPS
+#define EXSTACK_DEFAULT         true
+
+#ifdef TARGET_ABI_MIPSN32
+#define elf_check_abi(x)        ((x) & EF_MIPS_ABI2)
+#else
+#define elf_check_abi(x)        (!((x) & EF_MIPS_ABI2))
+#endif
+
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 49fd098067..609e9b99b5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,26 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_MIPS
-
-#ifdef TARGET_MIPS64
-#define ELF_CLASS   ELFCLASS64
-#else
-#define ELF_CLASS   ELFCLASS32
-#endif
-#define ELF_ARCH    EM_MIPS
-#define EXSTACK_DEFAULT true
-
-#ifdef TARGET_ABI_MIPSN32
-#define elf_check_abi(x) ((x) & EF_MIPS_ABI2)
-#else
-#define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
-#endif
-
-#define USE_ELF_CORE_DUMP
-
-#endif /* TARGET_MIPS */
-
 #ifdef TARGET_MICROBLAZE
 
 #define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
-- 
2.43.0


