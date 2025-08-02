Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BBDC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJG-0002EL-5j; Sat, 02 Aug 2025 19:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJ7-0001o0-Oq
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:30 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJ6-00019n-9f
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:29 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ebb468cbb4so1371528fac.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175987; x=1754780787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYICAl1SaNHyJ2ii9x5dLF1fa3KYu1mSCnjRob2c0pw=;
 b=LFnItXWL1kINX9rLnDkuTGkUJaYd8oxFJL3jnP5LDw/7KRpi0vBX1HD/lnDTaEY7yX
 sTvQOrlN6H/eZ+u+z4D6mg96HDg8b6xZkCJhlihzGL2pH/AtyL5Otpa6Cn2VI3A9xp6w
 0JejwaI8Hlu4AIs7OvjixpOsy/v/Q9ZiPfLNL8R55hWjREqzE2rK5QgU0YYrxMCBCMpq
 xQJmpRx8FkDbxmZat8sX3xgbPM9eBFf8O57D5DJ5V2+ETGgIsAAbMUfNyqLxFf4pfhVw
 M8n4giaCRdHrBKuUkbIwcMkGQEn9NdGABdotmiiyS7cJGfwhxSeo1+dtvMbF6Ja0G+SG
 xPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175987; x=1754780787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYICAl1SaNHyJ2ii9x5dLF1fa3KYu1mSCnjRob2c0pw=;
 b=MfPMZJOgGaEvGe/9WKsio70oD/3T+UN8G4YCNtIWxHHXyK83ppIBy73uqLrh4sY4xD
 g+H86AUCO5xEmgqYItKb2if0g1rrBLWRoCGdMF5UkHlfTfHoCIM3Uy49zvThUiQQc1de
 Umi6CmcCzA91UYo9KrFRlRph02PhsRHE396R7mSGNA1XK8h6SdJt5ZN4DPYQtRu5L36p
 UJMeLkx0TurTIyEFZl3YQ0ue/XkXvcU38fikU+WFB0QfrlvCuFIse1E4AVW9EcCIG2js
 /uw8YjEAEEETpnVl3qSTQ4hNBoM2Sp3er/UKwFkwGwoBGJ4XNfH1EPMi7RyTho8gGXpu
 39zg==
X-Gm-Message-State: AOJu0Yx+QYIXmh7FCqVTL6AJv059Ji+z0nvFbU4aHhO2MDbaOfVEoufc
 LmQGZDKvR2UHhEaRWAh2yD9vYYmevYgvJHCSnbElf7UyGW6EIUyFc+oEi+N7+Mz2/0YTmIsfhvO
 bR82lUv8=
X-Gm-Gg: ASbGncuAsnSnPnClqkmic0mR9Zxg9phOHhyuSVfdfZZZxcPBBCz/cY7AG3GW8ytiwgw
 E9RN6i6H/Olukd9alw8In8F5KlOqbD5r0U3MIrpUHk3GUAJHs9FyLl9bEGp7MDr6jGtOi8u5suz
 0hZxp73UkpqSg9TXaWyLj4es2C/ynOB5kXlBMmN5e5EAR8f9JPkfVp5xpxbAL1TO/FdUTkfQhQm
 /YCh+Cd+pYg/OEpz2f657nmGFaki0lGcZ7pQgTBTROO7YYBLaH5dgYWgXHIoCLcKiJtsAw12eCY
 IjOz/s0jhZ+euZW8so6KjQQQpk9W8Dj83J5oq9VE7Zs616yDI1qS9lquqyXVAkXY+wfdPZBJiyL
 v+TlL/auCRKbptpCOg/XsMGm1pHJbf8B3nNeylCWZfYzXxo06ax4SXyhsSxF6sW4=
X-Google-Smtp-Source: AGHT+IEGrkroPrr4LgMo+olFlqnCoU4NWvtUAsjtWUfe0cF9S5LEYlcOLAx3sr0WSf7pzV65JCAA9Q==
X-Received: by 2002:a05:6820:2188:b0:619:85f7:692c with SMTP id
 006d021491bc7-6198f0c0064mr2640558eaf.2.1754175987017; 
 Sat, 02 Aug 2025 16:06:27 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 21/95] linux-user/hppa: Create get_elf_platform
Date: Sun,  3 Aug 2025 09:03:45 +1000
Message-ID: <20250802230459.412251-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Move the string literal to a new function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/target_elf.h | 2 ++
 linux-user/elfload.c         | 2 +-
 linux-user/hppa/elfload.c    | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 5826ca2cd2..85be00584d 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
 
+#define HAVE_ELF_PLATFORM       1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9d61feae30..83cb6731ec 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1046,7 +1046,7 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_PARISC
-#define ELF_PLATFORM    "PARISC"
+#define ELF_PLATFORM    get_elf_platform(thread_cpu)
 #define STACK_GROWS_DOWN 0
 #define STACK_ALIGNMENT  64
 
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 2274fcbde4..9dd3fe092a 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -9,3 +9,8 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "hppa";
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return "PARISC";
+}
-- 
2.43.0


