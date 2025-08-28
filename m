Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC04C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHZ-0005NQ-Rm; Thu, 28 Aug 2025 13:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXF-0000ce-S1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXD-0000GC-FO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-246648f833aso5456595ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383318; x=1756988118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82O/q6SOg6fPNxHum5GoY4Fkyit9vffS6lSAVI/TIpA=;
 b=l6YzfdWq8+1yNSmTAxJvM9wkLDeCW3V19ir86KutyxYTDD+7XRKoD544IAAlC9lhkK
 m6dca3w0x+zOrifz8BrH6D6TNfTv/wrsbjYfZraLqhhRyFfpK9b9T4TtmTQjVHm5H0pz
 pd9MKADTPWaPikNZNPEMu1z7WK5FYWUZBbkfVRE1m8/4hL9DnhPRnVXB1Tv+y79w6cYz
 LpueBk545Hfb+chcXjAiB47u6luwxG3rtwdarS3M6Nx8mb2pkYS05XIZoKi0OTleg7X7
 JIrtc+3xA8oAf6J01bcGLMZN0p6PP3azV39N90U9yNI3pX7uk3hFvwOLXuWE5nkaye9b
 Ur+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383318; x=1756988118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82O/q6SOg6fPNxHum5GoY4Fkyit9vffS6lSAVI/TIpA=;
 b=eZTolJztmhPsIEiBwCjtPrupdI6OOsXmBJFFn/BwoFAz+eL6dD5c9DwvBAtoIX1kez
 siv3b9ajj+pXnDvVB4+sU8ElFSv/dIZ4XaNucg05tMoCzPafPCkupg6ScchApnFDz3H5
 zLy95a1M6nDhOO/gBxLt15cQAt9GFknjJ8QVxCTnoJAh3egc1mJYv8fUJtXeh8UuGtVO
 BmDJ4kcSEoVnqfPat0Nvz+EXu/fwAPPRQJfYhnK2xeIKCDvZ/F/mcOrITXalNBJm+MYJ
 pKpKUrYuqiSgKxiMFhnuWRaES2PLbw3KDJrliA+i2+GrM29zqZn+g1djrWtu6lgugNty
 m/4g==
X-Gm-Message-State: AOJu0Yx1ptOePTE6IN+0SxjSfeBKekQQorifl64I2MGH3gYuOqzNpxu3
 IuQDWoFSKuDdyxvSgd0C4uRLEb3ABHbZagMnKONni2aEDxDE83AWqHgJqtlu1BibFfU1vBtAYtx
 oJ1qeGP8=
X-Gm-Gg: ASbGncsiEwSJk1NiWpa/2QCA7/xPWbmNIDiZZtn5XNaGKm5eoOSW/tadsB94Cavh0PG
 3DO4w2DatuK+EHDC7AAl2zuulZit+ZXXZoOd2kmYvhDGp67KKd5ALKS9ZdsPUXtvFVh3tZjnvqx
 RxSZru0M+6eDAfrOvaceVQJED4B0UXEfmo4F+Ny872k0JEy5XeG1BKLMGQ/YLCl2aA2IjSOPbQ7
 +1YVTpgoXp2tXU46ufVoTesxoxMmamX8dG91agl89o4bykV60GPFXwEi+kBXTLiW0e1alfgZIKS
 yk5508IP8xRtTBbPHES2QdygfMHDRkkGuFG5vFJ/MweMqBOgTrm9lVCAbEXNM4DuMzyju964abE
 2+dIQbk5C7yg7Fq8C2BvbQ0NWwDTDZCbhjjgA+FkiD13a7Ro=
X-Google-Smtp-Source: AGHT+IGcTfpYI314VSql2jMLeZ2dnT8BgjDvsDW6HS9Q2JR2ERKjVHSCNThUh9ZtvPfPaXVVU1/Pmg==
X-Received: by 2002:a17:902:d512:b0:248:95cd:525b with SMTP id
 d9443c01a7336-24895cd5bdamr85462885ad.48.1756383317614; 
 Thu, 28 Aug 2025 05:15:17 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 68/87] linux-user: Move elf parameters to
 loongarch64/target_elf.h
Date: Thu, 28 Aug 2025 22:08:17 +1000
Message-ID: <20250828120836.195358-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


