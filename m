Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2DBC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRm-0002F0-33; Tue, 29 Jul 2025 20:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFI-0001l6-E7
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFG-00043U-L7
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:36 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76858e9e48aso2359864b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833633; x=1754438433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aYk78rxlLoht6Yc1RHDq1J3dwLCdhW9hthTdbwVX7NI=;
 b=IB/YAmmlXB5KMlXtwNf2Tm3B5boumvb1s0SvvklxlZUyeejkxOsL3s+ac3rPplBHoF
 TZnDeGEP19XatHg9tmw3L3XDX5xzhqJiG8MyYUd+DXddxzmgqQ9nvSqkwfEnFX+1ojAD
 PEZYwnybKvQc/GIRfnMMzaSbFfFXMBgrak8uetjbmhvqzvI3bwSniqX8WHSk4ZTpxTdb
 uu12+tIKhRawP0/y0NRebAq8UJNQXR0yV5ZW7pj2JwTYhd+ytJ0a+ci82tNyUeGmHKWS
 aynzdNPLtGMIKgjhusL50ZGBA5CYibqANXTZhD1qOO3aJCiE1mfZypVCjxzO9VbAyt3J
 QY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833633; x=1754438433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYk78rxlLoht6Yc1RHDq1J3dwLCdhW9hthTdbwVX7NI=;
 b=tmLtsIFeHyyJTA9jq4OA6IU4X1Vv5jl+9BWF/EkcxI7sxZAEnCkvLcVWUvouAgfGyj
 3lBxB1QgNpSzvqTJDqHwcNF51kQrJ7Ia+yZXwiwObnz9/W7ATu1rT8QmKu12cZvsL6D+
 WJPBBRVGyCkKuaT7d+wGclP/Ji9H84n5zFVDJ5F5aeiS5pA6mYI6yJ4OB+y7Z2esyOiL
 zt0L6Pvbvcct0VYJ9WTNqABEZURNXexVfAuqsfRLUnXcl0diCRDOabGNtPPCJ6fzd5uG
 F/7hvj5GLEajEDz77saX9mFVf7QKmF/NAiuFdclKM0ELxHL2CznsVSm4IfjVZXWmJz3I
 3QUw==
X-Gm-Message-State: AOJu0YyGk/T6arTEV0mMCz1BZYQFrW1NqGxD6lAXYBLZ4LHXgzuq10au
 C4UVIiQxnkWti1RlfNrvobosn4lgetIVZ/lpHRGKZiDByCrjpRDv7vt1XCJ8m3iWjy13fpMjigL
 +VA6b
X-Gm-Gg: ASbGncu8GiUKkmobEvx+fJcXbCZsesKagx7knzKGzHqSoH9E76GAcQdguu0zGTl6Gal
 chx/CJZY8y5qt73jqAAe8zCbfbYODki9ntgiSrLvi0hyOmH6DSiSggm8NUOjNF+jIOqNwc5tiAs
 2zzysL3wieUsBQnG8VuLZNVIszTcJos6BeJf50HWoKzZnEYHMPIT47QJ2iF9XlCHXEjPG4J9QU3
 k3Ztsqm1NnWy0WDktxOBv1/dfwX7/QfFNT/sDWgWIEM9ecVApAMp7TDnAUrF1cHUr7gN5qWgerb
 OcBxisE4w7SBT0GX7YxUuV95t8LidfLpJejtXDfkIJGHZH5UrtQIo0c4fso4LO790R56ddl0L/D
 XJ0GxOWEsRfzM0DOTsFZrnpCp62wZrS1NxrlwdpR28JgquPiCK85UveggJVrHkIRJkqseEBuCdT
 LzF+hA5jfcqw==
X-Google-Smtp-Source: AGHT+IEfAtYwv5ihIJdTcbfvDiRo5+TbtT/5hm59zdp3tv32yk9GsgiV+2HdhiT45s90sDqbjgCsow==
X-Received: by 2002:a05:6a00:8c9:b0:747:accb:773c with SMTP id
 d2e1a72fcca58-76ab2f4beabmr1822053b3a.13.1753833632576; 
 Tue, 29 Jul 2025 17:00:32 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/89] linux-user/loongarch64: Create get_elf_platform
Date: Tue, 29 Jul 2025 13:58:49 -1000
Message-ID: <20250730000003.599084-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Move the string literal to a new function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c             | 2 +-
 linux-user/loongarch64/elfload.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2e1c12f247..7591ec3fb6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -672,7 +672,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_PLATFORM "loongarch"
+#define ELF_PLATFORM get_elf_platform(thread_cpu)
 
 #endif /* TARGET_LOONGARCH64 */
 
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index f27992459b..450e567c72 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -51,3 +51,8 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
     return hwcaps;
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return "loongarch";
+}
-- 
2.43.0


