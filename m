Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C74DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmT-0007WQ-E3; Sat, 30 Aug 2025 11:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c7-0004xq-6M
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:31 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c5-0003zu-34
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-771fa8e4190so1832833b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506628; x=1757111428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82O/q6SOg6fPNxHum5GoY4Fkyit9vffS6lSAVI/TIpA=;
 b=QP1zGj03SnNl6D4dVbIfKq9Cqud4Kcpgz8jF4C4timX9GnOUh2sw/BSiCjeK6uPm6z
 OwlgWJ2kLLm7gKiiosdRsazShNX+3HpkOE/JRVQR76AZNxemUPbr2OOYC8irsG3hJPjL
 2cv400EDTglEBRDe7Hu0Hn3LdYt/p7ML/EoTEt/Z0R3ICyAiffztzuykAdrat8BnWtgQ
 Kc//e2yb7ZZSrhWf/MbpQ3CGYOUZPoVnNa0HXyuxufu35V3kZZb1ToGzz9p5Wve0LNns
 bvDCH1R02Q6II8Zj6tWTCIJ+R51b3d6kb56qTh5ZwVfvf7c4XGlrXH+io1t1PRPCLKw2
 xR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506628; x=1757111428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82O/q6SOg6fPNxHum5GoY4Fkyit9vffS6lSAVI/TIpA=;
 b=stVm3B6AFSQpP/2/S616CxEHXsTEfvW7vQf3SMIfj1dv4b8Ml3F7LHL5CV01bUixIJ
 xLV94xUj5G+vs9QbDzuAgp/LVSAKVegHYLg8JNTD/0/43Mjkk4T1PpiYriptogt+KrBW
 BVoPJN73W9rYO60qMMActDwEk4IcYyBGoYfDV/Wt1WN2f+oWX3HRk5K5TcSNuDjiPwyU
 V9DM/a6UJSfNTy49wAW7gOftQ4b6V8+gNqVJ5Mut1y5lurTk2RlA/O7G8cjUjhfwf80C
 LuXzUgFknZV5vYkjLM/6sxmIE18i+wriyL+E2cNawdk9QRlfbeL4h5Hh2QYbBHuCCtnd
 mgKA==
X-Gm-Message-State: AOJu0Yy3XlcfV4PAVR3lfL7L8b6PkfyXXkvMzFEKSB28GsX4evQD6btn
 FbYRnKKnUzsJX8dS0YG+YxsM8GMDxpPMsb+SEgfNlgu0+pKgkUpdso5dzLYUo/mUxyc7bTsHd4R
 9xk8VQrA=
X-Gm-Gg: ASbGncsOcgVAS/wDJMh9j7gGRe0qhMVmmXPaM+jAI/9nigsLNPViSD65TJJ2tloS6Np
 duxtTrYlI5w56dAvreW9MkOGc3cOUvZXCq3oze6Df8KuPgh9syFwXAKvdI8FXbrEU8rwtsqveZe
 0droO767tMu6FW0D7dz66Ra6o6FzENbP5rRXOEYKKhL5obKZ7Zbk2/2+wljYs4EoFhpp5MY0Miz
 Sez7phnovSgjBuSrljEiixAlrA6pU3DDceulgCIGBFxh/jpWoU29Uf78Y+Zjqfaa9q0LAJB9EyY
 SWCqQ0Bt8om0+IWZE/0Uf3hfaByctOSz0HDydK2Ivg1XrdUeGJjHmXxInW8OjIKMLeLPeh0X7en
 Hf96CQjfzYmnMuxhDkrtiu018fdX7jnu5HUW50Bn9S8l6pu06qkP56ULsQuFfB/k=
X-Google-Smtp-Source: AGHT+IEgIMv6fEAd21ssiPotE6tubmy3PZRphl3JuVYabGuWJJP+i4okyLcLBPb/Ej9sYkd/4jvUZw==
X-Received: by 2002:a05:6a20:244c:b0:243:c23c:85cc with SMTP id
 adf61e73a8af0-243d6ddb139mr365963637.7.1756506627675; 
 Fri, 29 Aug 2025 15:30:27 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 72/91] linux-user: Move elf parameters to
 loongarch64/target_elf.h
Date: Sat, 30 Aug 2025 08:24:08 +1000
Message-ID: <20250829222427.289668-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 linux-user/loongarch64/target_elf.h |  6 ++++++
 linux-user/elfload.c                | 12 ------------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 1f40419af2..47bf51a41c 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -8,6 +8,12 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_LOONGARCH
+#define EXSTACK_DEFAULT         true
+#define elf_check_arch(x)       ((x) == EM_LOONGARCH)
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 526c90e2c1..a4005c44ef 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,18 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_LOONGARCH64
-
-#define ELF_CLASS   ELFCLASS64
-#define ELF_ARCH    EM_LOONGARCH
-#define EXSTACK_DEFAULT true
-
-#define elf_check_arch(x) ((x) == EM_LOONGARCH)
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_LOONGARCH64 */
-
 #ifdef TARGET_MIPS
 
 #ifdef TARGET_MIPS64
-- 
2.43.0


