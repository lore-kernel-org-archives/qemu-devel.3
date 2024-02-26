Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAA5C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeII-00060c-Ik; Mon, 26 Feb 2024 11:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHp-0005Zm-8m
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:05 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHZ-0007bN-Iv
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:04 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41298159608so15570835e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966608; x=1709571408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLoCVfGQA0B56KJFSLQeHKi/nYPeRXMDk6OZ3NrpqZo=;
 b=a5ZvxxCS094D6uOY89D7AdQdsEiBOZG4zGut89/a43897cpllxc4OTjXUft4ZSgHF2
 cORZ3/T3jKc3CR5AEftqIfzQJo2Mf9PUgWHNxNJzct75f8+QvX4WFFwioA2WLVt5pxD1
 aDsPfnmPDm4PunQupwrrFkEUsLWcc+6AQXgU2oR6G/OzwJbKQvrdGH1yQms0TuEnfqBi
 EdFEmu6o1BlR6MQjy7r8nZDoBTTiw+akBqcbPG+dYwhyxEqFskWvm551o1XuQy+ljd7u
 MX/dvz5wAzOyfZHd/hjQWsrgPBVKSfUR+Ifak0uJXcy4ZY/ZBQ3g2N4dddfNGcaqFtqE
 pmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966608; x=1709571408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLoCVfGQA0B56KJFSLQeHKi/nYPeRXMDk6OZ3NrpqZo=;
 b=cNJM7szEnxHah4OTTwsE6wvA3kd1DOf/TQ7pO6uAJf95ZhptUaUQQhXjbeQ6rbAeDN
 PRdqwGkBWojFMyIVyBKpClC8FAU4BKm111OndqJHOKGGs/1fjJXvgRrBtpTW71/Pt8b9
 VSVBZ/yl9L5WyfCtdeOM23cdrfa5GE5Zpx+rZt1waa20/y33HMjf2kNpkny9GfN9wtbO
 eMzULBL/B/6VRyxNwXdhnHrBOxqFf6B9Hi9FqV/HOeCNJhApHn1DcYDAWGQDYuMbwhw6
 5CjVfGch+mGYkC/WUrBNboJM7EKHsF++7gIby0o82V4i1Cv22XWvSkwuctfzGlP0Czm1
 6GWw==
X-Gm-Message-State: AOJu0YxSqpJ8MyR6sqLm6AefSQrpzcyJ+fWMiFLmg+g0EL7BiOhuuHfJ
 PPeS2TzePmOwtMCtR3+Re5UUS5p1yuC8Kv2IDLW9VMi3cr15q89xueE+KStNlRc=
X-Google-Smtp-Source: AGHT+IGmcY3Ce29dNrVQ784BjiSgBmkWenUq81DrrLQZuy7rHIWX+6TO7PAfOu6kPIMavyEPeEwXDg==
X-Received: by 2002:a05:600c:4f46:b0:412:9434:fa38 with SMTP id
 m6-20020a05600c4f4600b004129434fa38mr6089623wmq.7.1708966607691; 
 Mon, 26 Feb 2024 08:56:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 hi17-20020a05600c535100b0041290251dc2sm12252480wmb.14.2024.02.26.08.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 08:56:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C4D915F8A4;
 Mon, 26 Feb 2024 16:56:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 01/27] tests/tcg: update licenses to GPLv2 as intended
Date: Mon, 26 Feb 2024 16:56:20 +0000
Message-Id: <20240226165646.425600-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226165646.425600-1-alex.bennee@linaro.org>
References: <20240226165646.425600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

My default header template is GPLv3 but for QEMU code we really should
stick to GPLv2-or-later (allowing others to up-license it if they
wish). While this is test code we should still be consistent on the
source distribution.

I wrote all of this code so its not a problem. However there remains
one GPLv3 file left which is the crt0-tc2x.S for TriCore.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240215184036.214065-1-alex.bennee@linaro.org>
---
 tests/tcg/aarch64/semicall.h                      | 4 ++--
 tests/tcg/arm/semicall.h                          | 4 ++--
 tests/tcg/multiarch/float_helpers.h               | 4 ++--
 tests/tcg/riscv64/semicall.h                      | 4 ++--
 tests/tcg/multiarch/arm-compat-semi/semiconsole.c | 4 ++--
 tests/tcg/multiarch/arm-compat-semi/semihosting.c | 4 ++--
 tests/tcg/multiarch/float_convd.c                 | 4 ++--
 tests/tcg/multiarch/float_convs.c                 | 4 ++--
 tests/tcg/multiarch/float_madds.c                 | 4 ++--
 tests/tcg/multiarch/libs/float_helpers.c          | 4 ++--
 tests/tcg/i386/system/boot.S                      | 6 +++---
 tests/tcg/x86_64/system/boot.S                    | 6 +++---
 12 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tests/tcg/aarch64/semicall.h b/tests/tcg/aarch64/semicall.h
index 8a3fce35c5f..30d4de9a549 100644
--- a/tests/tcg/aarch64/semicall.h
+++ b/tests/tcg/aarch64/semicall.h
@@ -1,10 +1,10 @@
 /*
  * Semihosting Tests - AArch64 helper
  *
- * Copyright (c) 2019
+ * Copyright (c) 2019, 2024
  * Written by Alex Bennée <alex.bennee@linaro.org>
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
diff --git a/tests/tcg/arm/semicall.h b/tests/tcg/arm/semicall.h
index ad8ac51310b..624937c5577 100644
--- a/tests/tcg/arm/semicall.h
+++ b/tests/tcg/arm/semicall.h
@@ -1,10 +1,10 @@
 /*
  * Semihosting Tests - ARM Helper
  *
- * Copyright (c) 2019
+ * Copyright (c) 2019, 2024
  * Written by Alex Bennée <alex.bennee@linaro.org>
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
diff --git a/tests/tcg/multiarch/float_helpers.h b/tests/tcg/multiarch/float_helpers.h
index 309f3f4bf10..c42ebe64b9e 100644
--- a/tests/tcg/multiarch/float_helpers.h
+++ b/tests/tcg/multiarch/float_helpers.h
@@ -1,9 +1,9 @@
 /*
  * Common Float Helpers
  *
- * Copyright (c) 2019 Linaro
+ * Copyright (c) 2019, 2024 Linaro
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include <inttypes.h>
diff --git a/tests/tcg/riscv64/semicall.h b/tests/tcg/riscv64/semicall.h
index f8c88f32dc5..11d0650cb06 100644
--- a/tests/tcg/riscv64/semicall.h
+++ b/tests/tcg/riscv64/semicall.h
@@ -1,10 +1,10 @@
 /*
  * Semihosting Tests - RiscV64 Helper
  *
- * Copyright (c) 2021
+ * Copyright (c) 2021, 2024
  * Written by Alex Bennée <alex.bennee@linaro.org>
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
diff --git a/tests/tcg/multiarch/arm-compat-semi/semiconsole.c b/tests/tcg/multiarch/arm-compat-semi/semiconsole.c
index 1d82efc589d..1e2268f4b75 100644
--- a/tests/tcg/multiarch/arm-compat-semi/semiconsole.c
+++ b/tests/tcg/multiarch/arm-compat-semi/semiconsole.c
@@ -1,10 +1,10 @@
 /*
  * linux-user semihosting console
  *
- * Copyright (c) 2019
+ * Copyright (c) 2024
  * Written by Alex Bennée <alex.bennee@linaro.org>
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #define SYS_READC       0x07
diff --git a/tests/tcg/multiarch/arm-compat-semi/semihosting.c b/tests/tcg/multiarch/arm-compat-semi/semihosting.c
index 8627eee3cf7..f609c01341a 100644
--- a/tests/tcg/multiarch/arm-compat-semi/semihosting.c
+++ b/tests/tcg/multiarch/arm-compat-semi/semihosting.c
@@ -1,10 +1,10 @@
 /*
  * linux-user semihosting checks
  *
- * Copyright (c) 2019
+ * Copyright (c) 2019, 2024
  * Written by Alex Bennée <alex.bennee@linaro.org>
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #define SYS_WRITE0      0x04
diff --git a/tests/tcg/multiarch/float_convd.c b/tests/tcg/multiarch/float_convd.c
index 0a1f0f93dc5..58d7f8b4c58 100644
--- a/tests/tcg/multiarch/float_convd.c
+++ b/tests/tcg/multiarch/float_convd.c
@@ -1,9 +1,9 @@
 /*
  * Floating Point Convert Doubles to Various
  *
- * Copyright (c) 2019 Linaro
+ * Copyright (c) 2019, 2024 Linaro
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/multiarch/float_convs.c b/tests/tcg/multiarch/float_convs.c
index 2e4fa55324d..cb1fdd439e3 100644
--- a/tests/tcg/multiarch/float_convs.c
+++ b/tests/tcg/multiarch/float_convs.c
@@ -1,9 +1,9 @@
 /*
  * Floating Point Convert Single to Various
  *
- * Copyright (c) 2019 Linaro
+ * Copyright (c) 2019, 2024 Linaro
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/multiarch/float_madds.c b/tests/tcg/multiarch/float_madds.c
index 4888f8641f4..a692e052d5b 100644
--- a/tests/tcg/multiarch/float_madds.c
+++ b/tests/tcg/multiarch/float_madds.c
@@ -1,9 +1,9 @@
 /*
  * Fused Multiply Add (Single)
  *
- * Copyright (c) 2019 Linaro
+ * Copyright (c) 2019, 2024 Linaro
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/multiarch/libs/float_helpers.c b/tests/tcg/multiarch/libs/float_helpers.c
index 4e68d2b6598..fad5fc98933 100644
--- a/tests/tcg/multiarch/libs/float_helpers.c
+++ b/tests/tcg/multiarch/libs/float_helpers.c
@@ -5,9 +5,9 @@
  * floating point constants useful for exercising the edge cases in
  * floating point tests.
  *
- * Copyright (c) 2019 Linaro
+ * Copyright (c) 2019, 2024 Linaro
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 /* we want additional float type definitions */
diff --git a/tests/tcg/i386/system/boot.S b/tests/tcg/i386/system/boot.S
index 9e8920cbfe0..28902c400d8 100644
--- a/tests/tcg/i386/system/boot.S
+++ b/tests/tcg/i386/system/boot.S
@@ -2,12 +2,12 @@
  * i386 boot code, based on  qemu-bmibug.
  *
  * Copyright 2019 Doug Gale
- * Copyright 2019 Linaro
+ * Copyright 2019, 2024 Linaro
  *
- * This work is licensed under the terms of the GNU GPL, version 3 or later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
         .section .head
diff --git a/tests/tcg/x86_64/system/boot.S b/tests/tcg/x86_64/system/boot.S
index dac9bd534d7..7213aec63b2 100644
--- a/tests/tcg/x86_64/system/boot.S
+++ b/tests/tcg/x86_64/system/boot.S
@@ -1,16 +1,16 @@
 /*
  * x86_64 boot and support code
  *
- * Copyright 2019 Linaro
+ * Copyright 2019, 2024 Linaro
  *
- * This work is licensed under the terms of the GNU GPL, version 3 or later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  *
  * Unlike the i386 version we instead use Xen's PVHVM booting header
  * which should drop us automatically into 32 bit mode ready to go. I've
  * nabbed bits of the Linux kernel setup to achieve this.
  *
- * SPDX-License-Identifier: GPL-3.0-or-later
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
         .section .head
-- 
2.39.2


