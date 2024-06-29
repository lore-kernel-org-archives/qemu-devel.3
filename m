Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4AFC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTt5-00071r-8s; Sat, 29 Jun 2024 04:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTt3-0006zf-Vr
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:49 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTt2-0008HF-Bx
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:49 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-73aba5230b6so167657a12.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651407; x=1720256207;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ylf5y47KsuOATDz6a8k2IJFvXF/O3+4cLjtAT1UEAXQ=;
 b=W2vbgKTP+KqBB1S4xOAaNwRxGAOWHzuf19vd0E7fIHI7LHef+gdndYhYq1sfJWliCE
 Tjg80KuKBgVUW50Gbnx3U8HpdXi6ybLV/qBt9poXuJxYbMlfUedaKjpkryVCHRAAGLYx
 /SObmHA9KhcCkW1z+HB6xKJ91lnxGpnb8pcliNXuuTnnpJUGhPDs/ASbA//53Ks1l3f+
 wgQIyyqtSOFoMqKa8X706xaXLiIlL+KHVM3JXrC5agZzQpRZiwvePne0YW7yEs4mCtzx
 notayx9sSJaykTc2Vn26aR6lcRlYGXp1NnST/MCwtX1xUXjodtvjOGGBTuVyB9wxIw8R
 1umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651407; x=1720256207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylf5y47KsuOATDz6a8k2IJFvXF/O3+4cLjtAT1UEAXQ=;
 b=LNH7fAYwSaJzkYcxPl8UIRWEwGkWlbdxlDMHimfRcRzPZxVjZW0ox1YjTwbDx49zhE
 5GCLiRk0vflivMEm53MtVyjS92HgmU/MKiOV88sxS4DqT7N33qLj7Z/DZ6HdnV90cubN
 3I8iZiJmnKYqfnNRAbUX2++kBKnHf1z5daVzs4qVuuDVsoI1y7wLjINoXynX8towW3cB
 xQXrpCs1pynN4avSnrvy4FNOmUsigMD523FW1tmhntH2mBSadmb/6xFxsGUdtIuzJNwF
 Jo85GuJZV5a0BqImgqEfgiQyETrFa8l3zBAT6f3Ts+klgI9f+IPPI/NRNDTO4WJ1HXKj
 f+Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl8iKaZRTYgjtRZOBJW2UQikfijuR6ucyjuG9aWANSwrQ39MLRWELki0kEvjXpI9sYFhsuh2pV5JZ6nXYOutP3a0Ol+B8=
X-Gm-Message-State: AOJu0YxGGvjFjgt6kH7Lh/gi1OAazayMgvzZpDmJdLhx2elprHzVaUXy
 +TxMruZ8O+dxcAEY1biF/yLRCiyvUeD7VaQu1KpIwRLpzg6iVrI9BOn4tum6HLrLJIrjTBddTo+
 6ptI=
X-Google-Smtp-Source: AGHT+IHaDvQZvDwEp18vUZqMAo9pjfwGvenE411bhsEg58GgnjtKRbp0+obyCAfYvYiyCvaIMkabHA==
X-Received: by 2002:a17:90a:c85:b0:2c8:3e89:bbab with SMTP id
 98e67ed59e1d1-2c9281561b7mr5828065a91.22.1719651406553; 
 Sat, 29 Jun 2024 01:56:46 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c91d3ba044sm2880406a91.42.2024.06.29.01.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:56:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 17:56:30 +0900
Subject: [PATCH v3 4/7] tests/tcg/aarch64: Explicitly specify register
 width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240629-tcg-v3-4-fa57918bdf09@daynix.com>
References: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
In-Reply-To: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

clang version 18.1.6 assumes a register is 64-bit by default and
complains if a 32-bit value is given. Explicitly specify register width
when passing a 32-bit value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/bti-1.c | 6 +++---
 tests/tcg/aarch64/bti-3.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
index 99a879af23d4..1fada8108d22 100644
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
index 8c534c09d784..6a3bd037bcd6 100644
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
2.45.2


