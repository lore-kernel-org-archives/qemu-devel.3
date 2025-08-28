Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F50CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgDD-0003z2-9L; Thu, 28 Aug 2025 13:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXH-0000eA-Hy
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:26 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXF-0000Gd-Oc
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:23 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2445806e03cso9498485ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383320; x=1756988120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNzxAeN5cYMiVF+TCph1Cnt9S/tSQ/8beWQa5LB/yac=;
 b=NFoGDEP+wTf7S3r+4gNiVF6cQZ7SaUzdDsoJz9ZnILPgZny0tvYbCHURADJsgNSIkj
 WivzRFEj8z7fP6v4UCglnB95KKmDahEgiPjYUuAgErTk4e05dXnlgDYydH3PajCEO8hl
 V+ClTHTPwFTmYbJU+k8BoBU+yyVvStX8dIkI6CcuCfeD05vhYuygcDuaR/n5EmmOxyah
 gvjR0VczwiTGGx9UkqjdvhO8BAtVUudBwJ9ptg4v1SxU0s3LxbysOL35M6CYuRAra9nE
 u4JgtiZjbfr/Ul2kCg9vKCgt+Gj4JHEH1JPfxL3aBKQpnp8NGkTXn6KcfHMGeZcytpUt
 +dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383320; x=1756988120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNzxAeN5cYMiVF+TCph1Cnt9S/tSQ/8beWQa5LB/yac=;
 b=LFYXvqVIDY7Ca3MPsOAGA6NsKloQro7FkRffVzMaCHVS1USg9qP1vflGwTYr3oQ/9V
 vnWvY24t5qoDyfR4oCcp13dQ7Z/vmZ+KsKrXm68tTIxWXdJh2075JhxX9agtwpZbgNnh
 XDqKx0aP5V5XVLqoGvWEDA3Vwm9aflfIPyhewSkKQk8X77e8tQ15EYB1JKeBy6vp2lF3
 5vjlZ8HUT23P8nEukJ8UqXySg75xfJu2JsLQ3HYdFxOkoYLQDl07D26aQ2oLRKkHlVN3
 N/xpFpg6luzB7ea2FpUQa0n82llF0dlrVg2jAKwj5S9DqYbiXjVE5BeE5rqQsKVCDalA
 Vfig==
X-Gm-Message-State: AOJu0YwazMXgRAsyA4h3cYslO56WJ9NnfHBOOLF/M3JycbUimQKhNxDQ
 BVxfaR2uPOBxuLUKUw34VJnB70GWV6E32P7ZD3m5WAg+XG0rQE44gqibxXa6ipcHN8FAhr+tN36
 TkFTRm4Y=
X-Gm-Gg: ASbGnctmyQIQc43zqnufqPrqJ8ONhHgyOR3Nyj839wm6zY/kAMKrvIoTz7v3kuyDE33
 cGEqjdDoRD/hlMSBceMBLieCMWKq/V+Vt2N9osPkyomz1siyo2vnLigml1hKK6S3mW0gGgQZCKC
 JGUPqPtJTvw4/Z5iLdzBLL8dsFggS4Xc0g+Vb9B1/twutMnsXfu8VwkDJugjXk5WPMfqaLlRYx7
 KGDI1mBTLhEecdkgJ7BZROBxgoNCCooNQ6NR6/w/YnUlcvAqsGKAOO40ibrS8XYkVNCewQbmdrP
 lj6WPYh4sTFJof7kcrFTLJsaG0IXkS2M0nBrfA7uJrNvKQZOU9xudAtGFstppKLEVTni9kU5Ahz
 7d2nXd26mA83OJ7tC33pABvUab8aLky5esPgOyE6CU6xD/HQ=
X-Google-Smtp-Source: AGHT+IGzFiY23efa9oltBIVU66DOoUoUODAKLgu3cyuY+jRK4efleEzogn0F263BDaiOdw2U2ceNEw==
X-Received: by 2002:a17:903:38c7:b0:242:d721:b019 with SMTP id
 d9443c01a7336-2462ef427cfmr300280025ad.38.1756383320386; 
 Thu, 28 Aug 2025 05:15:20 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 69/87] linux-user: Move elf parameters to {mips,
 mips64}/target_elf.h
Date: Thu, 28 Aug 2025 22:08:18 +1000
Message-ID: <20250828120836.195358-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 linux-user/mips/target_elf.h   |  4 ++++
 linux-user/mips64/target_elf.h | 10 ++++++++++
 linux-user/elfload.c           | 18 ------------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index a4b7fadbd6..f400bc2fdb 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -10,6 +10,10 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_MIPS
+#define EXSTACK_DEFAULT         true
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 67bc963134..c455985a76 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -10,6 +10,16 @@
 
 #include "target_ptrace.h"
 
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
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a4005c44ef..a67147d43b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,24 +130,6 @@ typedef abi_uint        target_gid_t;
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
-#endif /* TARGET_MIPS */
-
 #ifdef TARGET_MICROBLAZE
 
 #define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
-- 
2.43.0


