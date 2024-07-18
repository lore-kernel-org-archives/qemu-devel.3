Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E32C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNho-00042z-9f; Thu, 18 Jul 2024 05:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhm-0003uM-Gk
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:42 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhg-0007fc-9Y
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:42 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso60828566b.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295935; x=1721900735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQ57eYhV+4NmhOZrvCDoI18cEKYxHnDZEqAzqcJTJWw=;
 b=A9OwHH+OVNAENWVCNcYlM9gWl6SLB51nXpJ4u8b9ebdGxdycL2RfZ6BFZzixZCBQHy
 ScId/NLb/d9mC9QbxooccQU+7Ht4HCe5MCz85fRyW1iafuLXTpkoY1NMoFrWCvfr178f
 R5V/6bfMa+SnZRXZItBe4L/OUijt6oF1Cj40BOWDV7BKFnu7HB94UFf88xE+jwnaMyPB
 GMAWoWRC4HMisj6RW3/WCl3h8GMmqSBigSr7+UNjAcMEZ1L5gJUkjJHbVqrWSzWFil3Q
 7A1um8lCQcAP9sBG+Yt7ZYGUOeRpTLsGvPtXs6EKsBnCqfQkzbv07V/3WIPQYwbFd1bc
 G4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295935; x=1721900735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQ57eYhV+4NmhOZrvCDoI18cEKYxHnDZEqAzqcJTJWw=;
 b=Ti4q3TAL1FZmbj25uB1Iz3NDAEYqzzErG4JJTfcCcgAJcu/euUtX5QBvd3c9Hp3nEF
 hQdHirNyL7+Sy8Fkm7r7w2W4M7VF6rO51bgV7XwGgWT9WhkfIRZT0PKR2k14Y4g12heM
 LvSaOf+6Bkcs9fDcP/7f1zdRDWlvB1bD2PxcQa8FvuUm0aUzdD5wiqxKaNGL10Dc23wa
 kTYTc7uTCCOjnO8jUQeHzAsLhRw6PNWNSz3P8BSvVaxvV1iHy7ZBH+lThVd7VfhKcrRo
 rSSJ8HLQ5xpcuSgadPmCTyzDjOcBbOAMDlz3aUIUP0NZ8CCAerINOwBLHsVz4+Vm6fzv
 S4WA==
X-Gm-Message-State: AOJu0YxmTKwR+pu4XII/QLbhyW1uxhZCYrI0DdBZY3ScoVSKVejwq8ua
 bQPjx2dHt1/urNn1/TEaVHvhZC7dxEyAw4PukI4KiExhqNFR+wF2Itsv9Mtcznz33PiGwpVwEDT
 U
X-Google-Smtp-Source: AGHT+IGH6KNCQsoyabbIy37ZHkLFX8rcTzuQg7uXgDMlgIfrSmTs7K3pnena3+PnZDKMNyTgRQTPiA==
X-Received: by 2002:a17:907:b9ca:b0:a77:daa9:401 with SMTP id
 a640c23a62f3a-a7a0119df30mr259401266b.35.1721295934214; 
 Thu, 18 Jul 2024 02:45:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b4f87sm537915366b.48.2024.07.18.02.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1C575FA43;
 Thu, 18 Jul 2024 10:45:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 10/15] target/mips: Add semihosting stub
Date: Thu, 18 Jul 2024 10:45:18 +0100
Message-Id: <20240718094523.1198645-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since the SEMIHOSTING feature is optional, we need
a stub to link when it is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/tcg/sysemu/semihosting-stub.c | 15 +++++++++++++++
 target/mips/tcg/sysemu/meson.build        |  6 ++++--
 2 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 target/mips/tcg/sysemu/semihosting-stub.c

diff --git a/target/mips/tcg/sysemu/semihosting-stub.c b/target/mips/tcg/sysemu/semihosting-stub.c
new file mode 100644
index 0000000000..7ae27d746f
--- /dev/null
+++ b/target/mips/tcg/sysemu/semihosting-stub.c
@@ -0,0 +1,15 @@
+/*
+ *  MIPS semihosting stub
+ *
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "internal.h"
+
+void mips_semihosting(CPUMIPSState *env)
+{
+    g_assert_not_reached();
+}
diff --git a/target/mips/tcg/sysemu/meson.build b/target/mips/tcg/sysemu/meson.build
index ec665a4b1e..911341ac37 100644
--- a/target/mips/tcg/sysemu/meson.build
+++ b/target/mips/tcg/sysemu/meson.build
@@ -1,10 +1,12 @@
 mips_system_ss.add(files(
   'cp0_helper.c',
-  'mips-semi.c',
   'special_helper.c',
   'tlb_helper.c',
 ))
-
+mips_system_ss.add(when: ['CONFIG_SEMIHOSTING'],
+  if_true: files('mips-semi.c'),
+  if_false: files('semihosting-stub.c')
+)
 mips_system_ss.add(when: 'TARGET_MIPS64', if_true: files(
   'lcsr_helper.c',
 ))
-- 
2.39.2


