Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B0C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugudg-0002Dx-KM; Tue, 29 Jul 2025 20:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJV-00054o-HL
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:59 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJT-0004j1-SA
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76858e9e48aso2362258b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833894; x=1754438694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D8c9A8gEVNrBzI7nvbSwZ/yGjMaZTzGH5x9BolyT4I0=;
 b=ixB7jLQcha+g/rKwY2+8qskMvlsjJhIjb5MekBszzQuhv3VvkeBv9k5jKC4iPPZSfv
 uohmg81X9u1jgl66tXNNh0TYzZpfJbC+1zKixbnlWYeu/9xA+d8Rn+ajk/h4hCmZNyAq
 ifANRM8jqV13sVqWDkD4ze9Dfq5aoywpGDbniQCEIqrq0pWPBZHMzliJQsMshRk6Q+tm
 hfEEpZPEl3jkKR7qgXnlZjNMpJ8js8O6he33maNWLJF1Vaex5IL6BCytVSunErKoAwhB
 eWNoBDlYVXp7OLU2RldDtkK+8J3NTfQ242o+eU+ACGgPuG7WnO8wE4gvqOao8dakctEd
 FdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833894; x=1754438694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8c9A8gEVNrBzI7nvbSwZ/yGjMaZTzGH5x9BolyT4I0=;
 b=sGn8J6QikU4byLlS2x67YgLsOutNp/HfKLI34h95JeNOs2tuaNQIQtmS898+O8X7Gd
 LZqefIJud24SPkhzmLZMCzh/ZgNyAx1WATPomWV2kiVGUnTZV/xZN3ddQSFY7dldTisQ
 SxBKMjd+f3T+2a1okAkiYMC+fREigwqZ5A4PZf/36DwbI/stvD8aJhbNMsBlrwckrk43
 yibhuoKl+n93z+bXDZsaRZWoV/YT+mGdV6VpBqjgL2xLroi8JIQ3PUc4GfPEi38W7hPd
 lyYkIOK3d2qP4FnoZzDDntYF3+DAF0q2khgONKtiWTxbkyhsLcnshu8rzm0+wQScfRDq
 opYw==
X-Gm-Message-State: AOJu0Yx16cCiu5Tnwckg0bSz3WqgE72bAXFrHKw/31HBvd7S5grDZOqr
 SMfYB7lnhfsViWEyJ3KH7xYJdkeDwB/XZhrj/wW3oPuADeB4oqzX4wONEyyDpsS26azrFyC7ZQQ
 fLXjp
X-Gm-Gg: ASbGncsQIgZTRAv7h8wrIkZ6wfqLSd4oqPfitmjU7fAtbHNaVTtgr/ETiT/cT83OQqq
 VQeyEi5r6+Lgzm8WWS6xUGEM3UObvPQJacpIf7VBT9RV7Gnm2P4Sqp5yIXn+G+nSYLyrgX/k+0U
 t4twRw5sixd1obx2pC9VkU8TVqbZBtUxpPxk5szONAwB7k8ucGAdAlpvpjKRuyI5UtphDn5sNzE
 0ZdAUzv2QnhWqiu4N+/GPgIth1tyqgI3J+ynxx/KI4aday2InbfTwdhpmzZdYfbRQWG8ohxiAQy
 wM0BPJ6dHv9N5JnBsKCQ1K/v8YuS7bXxaUBKXdXL4qRPkZHJhr/6dviE+kiKL/9V/nld4mSQELF
 3GbwfDla+fbgTmzQXTQPI1eK80A0aBn9FrjTT9uDK+MeNQGiBe0I4y2WNvU0GYAbc8fwLJrGrEq
 ElOIdhh0hyAw==
X-Google-Smtp-Source: AGHT+IEIU6acmICz0Ce1Vhp2eYsNH3HJmc3Ly+VQSNg+sEHNvZ67SEJGykFYDUO3kVbXY3j1GeSOPg==
X-Received: by 2002:a05:6a21:3294:b0:237:b53b:64dd with SMTP id
 adf61e73a8af0-23dc0dca865mr1978039637.11.1753833894426; 
 Tue, 29 Jul 2025 17:04:54 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 77/89] linux-user: Move elf parameters to xtensa/target_elf.h
Date: Tue, 29 Jul 2025 13:59:50 -1000
Message-ID: <20250730000003.599084-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 linux-user/xtensa/target_elf.h | 4 ++++
 linux-user/elfload.c           | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 2c55c22e14..cacfb6e81a 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,4 +8,8 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_XTENSA
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e6d49d982f..b67bb7deab 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,15 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_XTENSA
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_XTENSA
-
-#define USE_ELF_CORE_DUMP
-
-#endif /* TARGET_XTENSA */
-
 #ifdef TARGET_HEXAGON
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


