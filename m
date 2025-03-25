Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8E2C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOM-0004Ng-JN; Tue, 25 Mar 2025 00:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNx-0003nb-6h
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:36 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNu-0005pO-Ak
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:32 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso9479804a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878768; x=1743483568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Org2345gwISbkRqtcCIQg/RHNCRTSRlXvAPbgPEQ0IA=;
 b=hI3l+9f2JDgKmYPpXat/Ywu0gFo08Hp5tXjclUo5HgFCvfkCQUciy0I1uyTCYt09U6
 shMJ3Ssc+qWbZsTGJF7nZnm/2gj2dshNE9vlqtTtHjgaqeAMieIkRO9zpBe4jXEi+erg
 AsExOkwQlsrtBey5kOFarkopIe78fZmb4cwQ/ZIWKwXOGErh19g/ObBMPaLCxkZubfWs
 JseR9FayeGsmnn3gJATh9E9C0MgKa8VIHxZEOp6u1FCmQU0PtXdkwKBiDZsJaQQMn7nG
 ryIqPKdsDRDo10zs0pUK7GHI5H3brO5n3uhY+On0EFUFahAluwY+nZZWcwnblmBK0jS1
 GamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878768; x=1743483568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Org2345gwISbkRqtcCIQg/RHNCRTSRlXvAPbgPEQ0IA=;
 b=K0VccdLrUdt34J9E4wrzhYvD+QIMBoKW/6SynGE3jZ7b4pUExU6RoERMTm5teB+HHH
 vS3L0GuuUkGxrenwRnNwPHXDbnUNI/+2AA4+6BYa2Sj5QMDkAl7GqK3Sd6wNHIz2q5OP
 pKIy9Hm3wjuyDNiOSt3PcfjjoM7OX57tfVlJv9iXX3tVJQqTtPDW0y4liNrDX5TLA8jI
 LTyeiWMqGW05lPJUBGNv0BVyaPl+3pcs1tb28J3xdwFp8moBsQy6jRNrPR4cVS+uxNLt
 jfXVJyq1y94h1aq9QiAcgtyCEQuXWyhb5ZdYVDz3kNBpd224jTv/OC+B+DnZ9PBRQPXQ
 /aSw==
X-Gm-Message-State: AOJu0Yzc45NNUwTNHykMTl/wPkq0xfo5x5im+FJ4XBbQiPyKjpFD1IBr
 uCLkJAuIG9kP7agQF5kUETjSO3Pcx4ft+tM+3vynCp5Uqj0jrpe9YKBEeCAW1PjhV80zdNPTjil
 /
X-Gm-Gg: ASbGncvjmFVG7hR/G64bBGkKSb1WsRdExyyAn0K/oAxi0isoXsb1gQ1JUJsBGkp0BwH
 1OCktkORk4YAkNAhOwh+X5gBIIQ8ZXw7FyaLy9oCL2qiDQLYg2K2iw/x70H/X9cZVWbyaP4/gP6
 ylVupKqD8f/9nP80c65rlliSRnuqSa45o/+zARpd9vR5qrc19DJxHSR5hEeDe6CgCxgm4PvajAy
 BnISeGb6QnitfvWV+RKQ9miL/oFHHRFV5+HpZ8bnMGqVAbgjiMwiRE/3uZUONQbyCXaZnsxxQ+I
 YlgiBNgTyMxCNdfNxdr5fpXvce9dzeu5cWQBVDRynpvl
X-Google-Smtp-Source: AGHT+IHabWwVD3wJqLYVJFSCVba25yVxMopHqjmL7IhxQTtf9QY7LAVwfCCLUMQE7U74Hqiw5Bl0hw==
X-Received: by 2002:a17:90b:51cf:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-3030fe86471mr24805706a91.13.1742878767928; 
 Mon, 24 Mar 2025 21:59:27 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 07/29] exec/cpu-all: remove exec/cpu-interrupt include
Date: Mon, 24 Mar 2025 21:58:52 -0700
Message-Id: <20250325045915.994760-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h  | 1 -
 target/alpha/cpu.h      | 1 +
 target/arm/cpu.h        | 1 +
 target/avr/cpu.h        | 1 +
 target/hppa/cpu.h       | 1 +
 target/i386/cpu.h       | 1 +
 target/loongarch/cpu.h  | 1 +
 target/m68k/cpu.h       | 1 +
 target/microblaze/cpu.h | 1 +
 target/mips/cpu.h       | 1 +
 target/openrisc/cpu.h   | 1 +
 target/ppc/cpu.h        | 1 +
 target/riscv/cpu.h      | 1 +
 target/rx/cpu.h         | 1 +
 target/s390x/cpu.h      | 1 +
 target/sh4/cpu.h        | 1 +
 target/sparc/cpu.h      | 1 +
 target/xtensa/cpu.h     | 1 +
 accel/tcg/cpu-exec.c    | 1 +
 hw/alpha/typhoon.c      | 1 +
 hw/m68k/next-cube.c     | 1 +
 hw/ppc/ppc.c            | 1 +
 hw/xtensa/pic_cpu.c     | 1 +
 23 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1539574a22a..e5d852fbe2c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -20,7 +20,6 @@
 #define CPU_ALL_H
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-interrupt.h"
 #include "hw/core/cpu.h"
 
 /* page related stuff */
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 80562adfb5c..42788a6a0bc 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
 #define ICACHE_LINE_SIZE 32
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8177c6c2e8..958a921490e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -25,6 +25,7 @@
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
 #include "qapi/qapi-types-common.h"
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 06f5ae4d1b1..714c6821e2f 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -23,6 +23,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 
 #ifdef CONFIG_USER_ONLY
 #error "AVR 8-bit does not support user mode"
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index bb997d07516..986dc655fc1 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "system/memory.h"
 #include "qemu/cpu-float.h"
 #include "qemu/interval-tree.h"
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55..64706bd6e5d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "exec/memop.h"
 #include "hw/i386/topology.h"
 #include "qapi/qapi-types-common.h"
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 1916716547a..1dba8ac6a7c 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -10,6 +10,7 @@
 
 #include "qemu/int128.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
 #include "hw/registerfields.h"
 #include "qemu/timer.h"
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index ddb0f29f4a3..451644a05a3 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -22,6 +22,7 @@
 #define M68K_CPU_H
 
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 #include "cpu-qom.h"
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e44ddd53078..d29681abed4 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -23,6 +23,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
+#include "exec/cpu-interrupt.h"
 
 typedef struct CPUArchState CPUMBState;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 9ef72a95d71..29362498ec4 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -3,6 +3,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/memory.h"
 #endif
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b97d2ffdd26..c153823b629 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
 
 /**
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3ee83517dcd..7489ba95648 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -23,6 +23,7 @@
 #include "qemu/int128.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "cpu-qom.h"
 #include "qom/object.h"
 #include "hw/registerfields.h"
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03dec..556eda57e94 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -24,6 +24,7 @@
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
 #include "qemu/cpu-float.h"
 #include "qom/object.h"
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 349d61c4e40..5f2fcb66563 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5b7992deda6..0a32ad4c613 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -28,6 +28,7 @@
 #include "cpu-qom.h"
 #include "cpu_models.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 #include "qapi/qapi-types-machine-common.h"
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d536d5d7154..18557d8c386 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
 /* CPU Subtypes */
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 462bcb6c0e6..923836f47c8 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -4,6 +4,7 @@
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
 #if !defined(TARGET_SPARC64)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 8d70bfc0cd4..66846314786 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -31,6 +31,7 @@
 #include "cpu-qom.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "hw/clock.h"
 #include "xtensa-isa.h"
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 034c2ded6b1..207416e0212 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -26,6 +26,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/cpu-common.h"
+#include "exec/cpu-interrupt.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "exec/translation-block.h"
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index e8711ae16a3..9718e1a579c 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "exec/cpu-interrupt.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_host.h"
 #include "cpu.h"
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0570e4a76f1..4ae5668331b 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/hwaddr.h"
+#include "exec/cpu-interrupt.h"
 #include "system/system.h"
 #include "system/qtest.h"
 #include "hw/irq.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 3a80931538f..43d0d0e7553 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -27,6 +27,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc_e500.h"
 #include "qemu/timer.h"
+#include "exec/cpu-interrupt.h"
 #include "system/cpus.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index 8cef88c61bc..e3885316106 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/cpu-interrupt.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
-- 
2.39.5


