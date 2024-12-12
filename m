Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF6E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoN9-0003k9-Cu; Thu, 12 Dec 2024 13:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMq-0003OC-F1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMo-0006ul-AV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:56 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso8826155ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029812; x=1734634612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxnAldCWCOu0O+NMnk+36JEDl4qw0oIa1uAJFBjrs8k=;
 b=X7EHtPW/TlEHJ2uvr2tMJ/i/9u44h9wkWXEDni4aExJt53bz9IjrjRs4WXr4SON0ph
 WtcYefDDU/Mhvm4lxEaZo89oXq1H0lF/XPgtyRahidnNmudDQkM6KXuD8OFXrCCHuKqB
 x7vUXGdyMmV/oWwrG/J2ZtQinYRYPFCJ1VVe9SPQetdFoMr3V8SFTTKyKrySpSvcEGx6
 4xcFOSyUA7BBUpOOF1tpZzJ2bRkEbf4JdzNvHlmUx1ZN7z/LcwXWBZpHBdtrNV6U7x39
 sA4Bl0n+uo5z5rZykcIndZoNbaDcPYE4iUGkZ5Wbuu7iq5j4cCv1oytsgxYoUbMLnfRW
 DGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029812; x=1734634612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxnAldCWCOu0O+NMnk+36JEDl4qw0oIa1uAJFBjrs8k=;
 b=B+JfpCFaIccBWRi6jYH+fJTUoZ9HcWFmEcdTMZe8zcE9CrUMUwwFYhZBEsfBappWo6
 3aB0fPbYcOh1GFDXdMea8JTL2Bl/KOF6OVEq9eEk+C5IhnPRiA7xKAYziVXv1IAepa3K
 TpOoux9WJ233RVCfVdHsoE10MsWwGsPUy0YdCwlXuL4M1Iuwtvu2l+GgFYTn0z6X6m0/
 KioZVVK4xFcCqUeFO4ILTxGAfrfrU2eTuWYzp4h+eESwQHDww6CRNXacJHx8nhBTuati
 JKNzPWIA0krSDXTmyYNkVhJTSJha/T7uNCOK8fbbQqFV0d0jgIq2z/lQGbhGyz05eRDj
 npTg==
X-Gm-Message-State: AOJu0Yy36p+tCG89w0ImM1RP6uEvJF7+R9pIuMhZpx+TlIYPTMl0vXhk
 yXYQuqEJ2dDmolHb4BayFTzfIW2NcDxyybAAmPUFhCU5aWzzoFXqS2924ksccgubwcY0mOCSN9S
 b
X-Gm-Gg: ASbGnctEdqGVISW3rl0xFU+EiJTmwzGOSGD2Ed/2RNNf82EZ2T7CjoXAddHmc5l67IY
 UlHDg6DVE0FGxKnTtgk7dfGWmMqclw9vk8rnmFBJ4fsBlLbSAPAS0bvjHK1Gs70Az6RHCHkHMLl
 2+SbLaNckc4LDJMj0s78YD96gy3OBzMO981YOgxu1BhQYt4q5+s5QV4HDFWzRQ320r7knm8VJVm
 dBkhhziNluEANkSMxHDvFwI7BONqk+aFPw/FJDBxya6L0+Gf9d197xvY9ZPulvbiXhMkP9/kI22
 H9qbtr1fw6WtVUJ2SGh8ARdIuEJ3S2Q=
X-Google-Smtp-Source: AGHT+IGxlnTOMDBn5XK1yLouRwAG+eqlKRuh6NafXdeDXnh5GB4tuA3jmub1t+1x65rlau/7sDfBMA==
X-Received: by 2002:a17:902:ccc5:b0:212:40e0:9562 with SMTP id
 d9443c01a7336-2178ae6c37bmr79441565ad.25.1734029811774; 
 Thu, 12 Dec 2024 10:56:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21632c4fc62sm89822805ad.194.2024.12.12.10.56.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:56:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/18] user: Move 'linux-user/cpu_loop-common.h' ->
 'user/cpu_loop.h'
Date: Thu, 12 Dec 2024 19:53:39 +0100
Message-ID: <20241212185341.2857-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
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

"linux-user/cpu_loop-common.h" is generic enough to be used by
bsd-user, so rename it as "user/cpu_loop.h".

Mechanical change running:

  $ sed -i -e 's,cpu_loop-common.h,user/cpu_loop.h,' \
                $(git grep -l cpu_loop-common.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/cpu_loop-common.h => include/user/cpu_loop.h | 4 ++--
 linux-user/aarch64/cpu_loop.c                           | 2 +-
 linux-user/alpha/cpu_loop.c                             | 2 +-
 linux-user/arm/cpu_loop.c                               | 2 +-
 linux-user/hexagon/cpu_loop.c                           | 2 +-
 linux-user/hppa/cpu_loop.c                              | 2 +-
 linux-user/i386/cpu_loop.c                              | 2 +-
 linux-user/loongarch64/cpu_loop.c                       | 2 +-
 linux-user/m68k/cpu_loop.c                              | 2 +-
 linux-user/main.c                                       | 2 +-
 linux-user/microblaze/cpu_loop.c                        | 2 +-
 linux-user/mips/cpu_loop.c                              | 2 +-
 linux-user/openrisc/cpu_loop.c                          | 2 +-
 linux-user/ppc/cpu_loop.c                               | 2 +-
 linux-user/riscv/cpu_loop.c                             | 2 +-
 linux-user/s390x/cpu_loop.c                             | 2 +-
 linux-user/sh4/cpu_loop.c                               | 2 +-
 linux-user/sparc/cpu_loop.c                             | 2 +-
 linux-user/syscall.c                                    | 2 +-
 linux-user/xtensa/cpu_loop.c                            | 2 +-
 20 files changed, 21 insertions(+), 21 deletions(-)
 rename linux-user/cpu_loop-common.h => include/user/cpu_loop.h (95%)

diff --git a/linux-user/cpu_loop-common.h b/include/user/cpu_loop.h
similarity index 95%
rename from linux-user/cpu_loop-common.h
rename to include/user/cpu_loop.h
index aca51f53238..8e2df232758 100644
--- a/linux-user/cpu_loop-common.h
+++ b/include/user/cpu_loop.h
@@ -17,8 +17,8 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef CPU_LOOP_COMMON_H
-#define CPU_LOOP_COMMON_H
+#ifndef USER_CPU_LOOP_H
+#define USER_CPU_LOOP_H
 
 #include "exec/log.h"
 #include "special-errno.h"
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 77f857a8216..c5d8a483a3f 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "qemu/guest-random.h"
 #include "semihosting/common-semi.h"
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index b5403ed0e46..80ad536c5f2 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUAlphaState *env)
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index be1f11022a7..10d8561f9b9 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu.h"
 #include "user-internals.h"
 #include "elf.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "semihosting/common-semi.h"
 #include "exec/page-protection.h"
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index a1794470113..de70f736367 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "internal.h"
 
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 503a204460e..890e758cd1c 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 static abi_ulong hppa_lws(CPUHPPAState *env)
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index e06aa23de4c..d96d5553faf 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu.h"
 #include "qemu/timer.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "user-mmap.h"
 
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 935d5bcf2c8..0614d3de224 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPULoongArchState *env)
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 69cdce95518..5da91b997ae 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUM68KState *env)
diff --git a/linux-user/main.c b/linux-user/main.c
index 06037304cb1..b97634a32dd 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -50,7 +50,7 @@
 #include "elf.h"
 #include "trace/control.h"
 #include "target_elf.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "crypto/init.h"
 #include "fd-trans.h"
 #include "signal-common.h"
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index ee4ba768691..87236c166f2 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUMBState *env)
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 1331a9a2b8d..6405806eb02 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "elf.h"
 #include "internal.h"
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 1bf9542d16a..306b4f8eb43 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUOpenRISCState *env)
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index e168f1ce947..2a0efaffcd6 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu.h"
 #include "qemu/timer.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 static inline uint64_t cpu_ppc_get_tb(CPUPPCState *env)
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index a72bc76da3d..3ac8bbfec1f 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "elf.h"
 #include "semihosting/common-semi.h"
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 42e4d24102e..c9124444ed2 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 937d9fa265d..ee9eff3428a 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUSH4State *env)
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 58a2464da9f..68f1e8ecd43 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 #define SPARC64_STACK_BIAS 2047
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c54b199b6d3..1b335688f12 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -143,7 +143,7 @@
 #include "special-errno.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index 7564e25a966..c0fcf743e70 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 static void xtensa_rfw(CPUXtensaState *env)
-- 
2.45.2


