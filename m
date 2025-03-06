Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B222BC28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTn-00019H-CI; Thu, 06 Mar 2025 10:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSh-00089Y-7Z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSd-0006IC-9f
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bc0b8520cso5452355e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276113; x=1741880913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6V3f5QHEPkzjza/e5OPie9IBCs6hpy/raWDVhSFQ+F0=;
 b=aOry+8HQvSu0w8WByH0HPQV4CAkNl6ksZ3eu1f7tPxmlLGCI60dGsjZZAfv5LiMYot
 ePJ8zMrJgfQBiM/QEJiBt/CPibCifVyVBKl1g7CPcd3+bgNIIIb4m9en9tTVlmFXFGlP
 HGpaDEwAWPX0/NUJ6+n1FAlsPmM3zWj2dr2GlEPDiPBFwPLHpQxu286B/ewl+3ObyDM+
 fIiJUbR5IVE/p12uhxaULGYJq1C9K4TcD7IvDevyES9kZGLWEHy9ex1JY6Ng5VBwL9sk
 xGn4cEeI1zIpmwQb0dhCwz5H63ZT0Kux37XIouE96+QEtb9PLWJfSHhmYhrAkIFRNysU
 b8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276113; x=1741880913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6V3f5QHEPkzjza/e5OPie9IBCs6hpy/raWDVhSFQ+F0=;
 b=dPPnn21QnVUNggC50VtA3zZlKxNd254cKpBWzkcEOYkfB21jncp15kIVcNTVs0vFdi
 QAdVXfXaWKGEuZJUmyjTqn4TRk6Dd9NVXhT1zj9BcwqedL1u0oe6gs44K2jnX+jImvAL
 oIqySO3VK8Ari9NBDgCCauXSIoZ/+JhTV8pW2A8XlgtqcHkVYenBYYH/KDtT0DpYuD+T
 nsv4z2YtvU0kJyO+6pv8wwG7W8JXVzmtRrMg4RrNDoN2CocD6FWP4/qg/y70qaUNsnN8
 XlTM3JWIq+YcYSDdYDkHguPs/CBrgyH+q4VUv7UWhI/NcxMYFI2oaZF+sXN5Iv+bEODc
 3t8g==
X-Gm-Message-State: AOJu0Yxw0fg2Y2bbBkUQBpyWExjjBgsmesdOw6rdd5+A4KmO1R3wos3y
 G4+srAWeVSnWyyzKuaBgIf30pyalCg+xteHHjSiY0h0rVHocRRkMDR5/+6PoPq9rAakhkC0qmOR
 fvic=
X-Gm-Gg: ASbGncuRlFsiY/kBCBDB+hZzW91u1oJGr6sf+MX1heA4bbkpPNjKNcFK6GuMEi3yxyX
 KIeEM2rYS6QFHy8ZP+nXPRmhAjJuspYV6mRfI0FyiL1kCqCojOh12z9OAKUZuHRrA/idhZAhV3n
 ty8a4kXjgsx3LoXIqaXFzmY3nSotJbj/tbyWw9nQcdH6ekPcFKHuvpUgvr80A6MGQBH/9oNK483
 ZCYTMMoS5rA0xKL9gboIU2LjHfFMUHSSXeb3IszGrYMlnoFR2Dey5bnAyWjwxdcl1AFYdQCJDfr
 qs1vHttGL/vx8Icu7U39gGfj5yzlClUFnwWaVcU0EBFuXtRt6CjaCEzxi+pjjWQ4BhY7tuS6O99
 0n/+TdNU76WLlQ24Qcdc=
X-Google-Smtp-Source: AGHT+IEdDhOsbggPmUoAGRfUucEMvniJs/o90eYCYagtw6g6e3O6lUKdc4nP/+ICtzQKyEz6wtFUSA==
X-Received: by 2002:a05:6000:1fa8:b0:390:fb37:1ca with SMTP id
 ffacd0b85a97d-3911f7d33b4mr5738986f8f.53.1741276112550; 
 Thu, 06 Mar 2025 07:48:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfe0004sm2358411f8f.40.2025.03.06.07.48.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/54] accel: Rename 'hw/core/accel-cpu.h' ->
 'accel/accel-cpu-target.h'
Date: Thu,  6 Mar 2025 16:46:54 +0100
Message-ID: <20250306154737.70886-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

AccelCPUClass is for accelerator to initialize target specific
features of a vCPU. Not really related to hardware emulation,
rename "hw/core/accel-cpu.h" as "accel/accel-cpu-target.h"
(using the explicit -target suffix).

More importantly, target specific header often access the
target specific definitions which are in each target/FOO/cpu.h
header, usually included generically as "cpu.h" relative to
target/FOO/. However, there is already a "cpu.h" in hw/core/
which takes precedence. This change allows "accel-cpu-target.h"
to include a target "cpu.h".

Mechanical change doing:

 $  git mv include/hw/core/accel-cpu.h \
           include/accel/accel-cpu-target.h
 $  sed -i -e 's,hw/core/accel-cpu.h,accel/accel-cpu-target.h,' \
   $(git grep -l hw/core/accel-cpu.h)

and renaming header guard 'ACCEL_CPU_TARGET_H'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-12-philmd@linaro.org>
---
 MAINTAINERS                                               | 2 +-
 include/{hw/core/accel-cpu.h => accel/accel-cpu-target.h} | 4 ++--
 accel/accel-target.c                                      | 2 +-
 cpu-target.c                                              | 2 +-
 target/i386/hvf/hvf-cpu.c                                 | 2 +-
 target/i386/kvm/kvm-cpu.c                                 | 2 +-
 target/i386/tcg/tcg-cpu.c                                 | 2 +-
 target/ppc/kvm.c                                          | 2 +-
 target/riscv/kvm/kvm-cpu.c                                | 2 +-
 target/riscv/tcg/tcg-cpu.c                                | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)
 rename include/{hw/core/accel-cpu.h => accel/accel-cpu-target.h} (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d9ba810851..a0e462d03ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -499,7 +499,7 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/qemu/accel.h
 F: include/system/accel-*.h
-F: include/hw/core/accel-cpu.h
+F: include/accel/accel-cpu-target.h
 F: accel/accel-*.c
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
diff --git a/include/hw/core/accel-cpu.h b/include/accel/accel-cpu-target.h
similarity index 95%
rename from include/hw/core/accel-cpu.h
rename to include/accel/accel-cpu-target.h
index 24dad45ab9e..0a8e518600d 100644
--- a/include/hw/core/accel-cpu.h
+++ b/include/accel/accel-cpu-target.h
@@ -8,8 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef ACCEL_CPU_H
-#define ACCEL_CPU_H
+#ifndef ACCEL_CPU_TARGET_H
+#define ACCEL_CPU_TARGET_H
 
 /*
  * This header is used to define new accelerator-specific target-specific
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 3236d6335b1..83587274626 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -27,7 +27,7 @@
 #include "qemu/accel.h"
 
 #include "cpu.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 
 #ifndef CONFIG_USER_ONLY
 #include "accel-system.h"
diff --git a/cpu-target.c b/cpu-target.c
index 75501a909df..f97f3a14751 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -44,7 +44,7 @@
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
 
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 560b5a05940..b5f4c80028f 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -14,7 +14,7 @@
 #include "system/system.h"
 #include "hw/boards.h"
 #include "system/hvf.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "hvf-i386.h"
 
 static void hvf_cpu_max_instance_init(X86CPU *cpu)
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 1bda403f88b..6269fa80452 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -15,7 +15,7 @@
 #include "hw/boards.h"
 
 #include "kvm_i386.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 
 static void kvm_set_guest_phys_bits(CPUState *cs)
 {
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index f09ee813ac9..b8aff825eec 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "helper-tcg.h"
 #include "qemu/accel.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "exec/translation-block.h"
 
 #include "tcg-cpu.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 966c2c65723..216638dee40 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,7 +49,7 @@
 #include "elf.h"
 #include "system/kvm_int.h"
 #include "system/kvm.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 
 #include CONFIG_DEVICES
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 7f3b59cb72c..4ffeeaa1c95 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -32,7 +32,7 @@
 #include "system/kvm_int.h"
 #include "cpu.h"
 #include "trace.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 70f4c7984aa..5aef9eef366 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -30,7 +30,7 @@
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


