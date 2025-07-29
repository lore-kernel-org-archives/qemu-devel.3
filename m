Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E025EC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucq-0000JL-9q; Tue, 29 Jul 2025 20:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJH-0004qT-Dn
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJF-0004gC-6F
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso5675335b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833880; x=1754438680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5eZ8C15sPWJhyjb6gKj/Ku2hIeU/HidEd1w9ZOXgGX8=;
 b=EKWL8MLdxjMESVkD6gpbLEeHXF1TB+5XiFldFYNDMkF9j9R+YZmOD292QO0okcuH19
 YxX2qjvUJrO5q+hQqF1tsCve7J++skV5PeyE6a7yQ5JoRP+95aAkuKIw+zCc1WOJrXTR
 WxQb/hpeI8R/Bd9CA9J+kZ3wxUEtK+jjvUCAv7T4dO5Mnus0oeg3n80Ag969MWAq/ljO
 1grCreFTv2j+Zmk5wkJgY0A4OVs5rrwm8zSMEPbWCDk8Rf/4xlgbktOAJ+teYksOyG1B
 7V4kgt2wWIjpDak6ctFNdTsaoWRq3wUBsjAzWl5H9WBVhBW55dpYAMki9rYMpp4IXyUp
 4y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833880; x=1754438680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eZ8C15sPWJhyjb6gKj/Ku2hIeU/HidEd1w9ZOXgGX8=;
 b=Y+flBK9GAMQJG45FFOWHVBuQ9XkBYd4BZKBOn4lDTX4dH/LOCLfVPSpKotZdqS9vsN
 sDCXfmRjNYelpUogX6d25/4dJNdqwb9+yvCRClXE/S75uIAHJSc9EeFRgxnQCoPfNRXW
 ddIUjTLTPJhbTc8/NAU+ZcGsHlfZ/PUOiT4ZpGlRR4o5rfah2ha2iUfKLx42IHrF8SWk
 11B9Vg7CcWVBcoSjejvjqF7JsAS7z7eLPO4tU2va9OxxN4dTKEanUDooJv5XU1BRV7om
 0ipwnTMI91r5j6HfXpibU1f5ljpVtm90Dc63UBaGdKJY7WE0/UF6EYmiJR8TF8bhVLxl
 eISg==
X-Gm-Message-State: AOJu0YwoisSn6++N6VuQ9G+gCx/EbXUArU89YmMi1LaXJ2cwKzUWJhAc
 OuGubm9RramN1nRGfDvPQo4C3/uzG5TdIn2Akkjp+Bs7SRLEF62GlZqO4K/9RF2RHEDScZLbv6/
 k9Xci
X-Gm-Gg: ASbGnctGmM6JMJSU2K059CVFbyy6V9qfQu+tsdh23czfvpmXxADuVlMSDZlI78DY05X
 GrSmHJXe6xDMfQi5tpG5JqW5AD5NlLqrMOoCrnQHPxfMa6LDLz+XNPSmfEQbtVLoe6xuxsGbBa2
 8QK9oSK93R94DiX2wos67sk5hF+GFh5phaxq0clFOaQH+6e2DkDXj298W27rd/rLhR0fPh0sP+a
 MowlCFR6Ft1YoJI+rnFy2DuMnO3++ay3zI2ZOlm3UCwjrA5ln4+4Vfl9YQpBLyTzmp+ghPixh+E
 d9Mxf9qnGMrdxHS97lgHm2USrECuXAwhZrEz3FSo1awfg4OnkBI03jsVFQlmV8GA34uoth2shXG
 EApdTTu3m/MiCkBO2iM8kbZIKv2KnCieuGhzBhPiGFKoEFyAGqVfdPrO8iHGsP7/ywFSvh2pIpf
 6e7VlJAeWZkQ==
X-Google-Smtp-Source: AGHT+IGk3wQCCgfDClvRpbzfZFFF1kdBxfvSlRpmUZgaEHZ0A2aLR96x5xMbbkW/ZVLvH7Qv5a7vYw==
X-Received: by 2002:a05:6a00:398b:b0:757:ca2b:48a3 with SMTP id
 d2e1a72fcca58-76ab161afcbmr1837932b3a.9.1753833879779; 
 Tue, 29 Jul 2025 17:04:39 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 65/89] linux-user: Move elf parameters to sparc/target_elf.h
Date: Tue, 29 Jul 2025 13:59:38 -1000
Message-ID: <20250730000003.599084-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 linux-user/sparc/target_elf.h | 11 +++++++++++
 linux-user/elfload.c          | 15 ---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 7e46748d26..8bd6e3e427 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -8,4 +8,15 @@
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
 
+#ifndef TARGET_SPARC64
+# define ELF_CLASS              ELFCLASS32
+# define ELF_ARCH               EM_SPARC
+#elif defined(TARGET_ABI32)
+# define ELF_CLASS              ELFCLASS32
+# define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
+#else
+# define ELF_CLASS              ELFCLASS64
+# define ELF_ARCH               EM_SPARCV9
+#endif
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index dec27496ff..429d343adc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,21 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_SPARC
-
-#ifndef TARGET_SPARC64
-# define ELF_CLASS  ELFCLASS32
-# define ELF_ARCH   EM_SPARC
-#elif defined(TARGET_ABI32)
-# define ELF_CLASS  ELFCLASS32
-# define elf_check_arch(x) ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
-#else
-# define ELF_CLASS  ELFCLASS64
-# define ELF_ARCH   EM_SPARCV9
-#endif
-
-#endif /* TARGET_SPARC */
-
 #ifdef TARGET_PPC
 
 #define ELF_MACHINE    PPC_ELF_MACHINE
-- 
2.43.0


