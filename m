Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0C0C3DA41
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku2-0005j1-P8; Fri, 05 Jul 2024 11:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku0-0005ht-RM
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktt-0000Qg-WF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:12 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so2433805a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193464; x=1720798264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=it+TebEWAUdyZUulzklPipDIOEzwrfquC83Yceo5Vww=;
 b=UvMC0qDbELTp+dHAjvkZk0o/GXMViFml59c2pjH5nd2uZYyzgxkEX67qLMMvb8LhTQ
 oBYAgFaKQ9cbeH8hnNOgpUVXd8RUsT4whPKpkWbv0qR2+Jb5KPI7HML1JaQjSpZ6U3g8
 FRmDg3VivaPo+ON2yW0U+mL4f4f2oYvETSe29kzXtZ6A+UZtqdtsi5QEda+WNy/xVPQg
 Ov5b1MwtQ0hA4z/bTr3mJruzCnZKD2fm+luG8PkB9bWIS/MeiAtlAGGwD/Y5zzHxIuQn
 MQUB9cc76z4IkwfuFnVbCyeaVOgW8mVZJyKZIh/Dvi9E4J4iw1O2HhoRU/xrIfDiZy5V
 66vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193464; x=1720798264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=it+TebEWAUdyZUulzklPipDIOEzwrfquC83Yceo5Vww=;
 b=kZ8w9ptyE2WEbuhS9RRoEbaB3ml1Vn9XHdf7wdrukSCm/KlqIJ2KV8srO7Kn9Y81BI
 kz98hk2sWpRhYeeLxwMf1TpEZWEiqha4DrW93xhtayqH0mb5uVioaabDLxdL2hHKPyLt
 X4IwDnMGJqFApMzxuZesuPj/O8FdhES5pIfDQ/E1HIXahaVFCZMS3JD/DMitOqiBeHRq
 3Ro9Au9tzFUiw+OPOXwMunUqcoRyhVQjx6gDPXMGLF9WedLAIdUJicf1SIaZRvkNGfml
 VOkKPQoE1W3G//+kOe9Yk7+MnQ7zq6nYHOWQ3AJ+Vrjjqa2T6BtJk9RjrM/mleJAM9fL
 XNKg==
X-Gm-Message-State: AOJu0YwJKKZ7mm6ubVdwqqi4xIvRUzGQkLvcREwI+ixcOhjtdhbumIJT
 sNMU1xwMHPei9VLRhwVYbfZEsnRVJ64vsbB2riIbS/CBjgMoAz0pqIt/gKztUHBsBq1ChK39HD3
 d
X-Google-Smtp-Source: AGHT+IGlhsrSTkQISMGkr2BGHBBb/YXVcSAXq5i6vJUG3AR9IRKMZAUWGk2wGaKosIc4NAUMd70Kfw==
X-Received: by 2002:a17:906:1355:b0:a77:ddce:e9b8 with SMTP id
 a640c23a62f3a-a77ddceec07mr38506966b.75.1720193464024; 
 Fri, 05 Jul 2024 08:31:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77b226b1bcsm172178166b.88.2024.07.05.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3C5E620ED;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 09/40] tests/tcg/aarch64: Explicitly specify register width
Date: Fri,  5 Jul 2024 16:30:21 +0100
Message-Id: <20240705153052.1219696-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

clang version 18.1.6 assumes a register is 64-bit by default and
complains if a 32-bit value is given. Explicitly specify register width
when passing a 32-bit value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240627-tcg-v2-3-1690a813348e@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-5-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-10-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
index 99a879af23..1fada8108d 100644
--- a/tests/tcg/aarch64/bti-1.c
+++ b/tests/tcg/aarch64/bti-1.c
@@ -17,15 +17,15 @@ static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
 #define BTI_JC    "hint #38"
 
 #define BTYPE_1(DEST) \
-    asm("mov %0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x16")
 
 #define BTYPE_2(DEST) \
-    asm("mov %0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_3(DEST) \
-    asm("mov %0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %0,#0" \
+    asm("mov %w0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %w0,#0" \
         : "=r"(skipped) : : "x15")
 
 #define TEST(WHICH, DEST, EXPECT) \
diff --git a/tests/tcg/aarch64/bti-3.c b/tests/tcg/aarch64/bti-3.c
index 8c534c09d7..6a3bd037bc 100644
--- a/tests/tcg/aarch64/bti-3.c
+++ b/tests/tcg/aarch64/bti-3.c
@@ -11,15 +11,15 @@ static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
 }
 
 #define BTYPE_1() \
-    asm("mov %0,#1; adr x16, 1f; br x16; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; br x16; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_2() \
-    asm("mov %0,#1; adr x16, 1f; blr x16; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x16, 1f; blr x16; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x16", "x30")
 
 #define BTYPE_3() \
-    asm("mov %0,#1; adr x15, 1f; br x15; 1: hint #25; mov %0,#0" \
+    asm("mov %w0,#1; adr x15, 1f; br x15; 1: hint #25; mov %w0,#0" \
         : "=r"(skipped) : : "x15", "x30")
 
 #define TEST(WHICH, EXPECT) \
-- 
2.39.2


