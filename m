Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CAEC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRk-0003NJ-VP; Tue, 22 Apr 2025 15:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP4-0005N4-Vs
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP2-00075a-4O
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so85258005ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350530; x=1745955330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttdQeGqlz6FXyi1jKEDuyWx8rD+7BmQ+sldNT/VJk+k=;
 b=ilQhgLfTDO67zqeyPVTIcMOKTHXlehqWdcOoRTQ17sXQ783D3a2T9FZPPEcjJ3BWBg
 E3lAXhX3omtKQ5V39URVVwMLHgBzQki/iUjcNyvSviI5bZvWwcf6Hp8pVXIrSbXkCnPf
 qsxjnnR0Leu2VLkdwkDsZVENNBuno6uEgjKy4CxPMWnBD6XgvKYpm6xZLJXUuv5w149E
 cTKwcTEa4dc6zUSdxe8lImnQ3//jzfrqJtKg9+E+GgVTVtt0dOzCYDLl0dqsiErRgoSv
 lc7pfDMSzMfPS31QEoQk3yrE4hs3il+6EynQly0vn02hqIUL+0dTNHU7XnaEMRK+DPYR
 h3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350530; x=1745955330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttdQeGqlz6FXyi1jKEDuyWx8rD+7BmQ+sldNT/VJk+k=;
 b=DDJeBOBiIomFUS7HXNf3cQY0e9gZqFrRTvWIok/5lbbLQVRo3tt0CtwZ+xG6icKUSC
 37a+1lBWpX1qllrbMtwMK8c4Jm6hD9OEKJGCfjBTuIOpvwVN6952389dDWv4ou3Zzosp
 ADWMBA+Xu1wEsUMQn9QOAmIV+3fqQydqJM+hrsgXZJ63yltDX9J2W7cMV6BzekcdXzFM
 la5qtKhs3jpsf3ZlRbzgFRSd8EqiMSkgKhwkR9joB1sp6a7xfLlTtVkJN+jitBAMq7No
 APurCS3uvvVFR8MFdA4sJjqXfIf2kiK57NY06+wEY4j71/AESHINKWqYAupAEYfG8gZ2
 S5yA==
X-Gm-Message-State: AOJu0YzlO0wrg3rSbSlD/bo8+mE7gprQdX6GSX9TplHzT0OiLh4rjNRF
 FOTpUmveUq8nmtBKitvqmtaR+SSwEgNqjW28CYiEnuEH7Ar3mKKiRAaVnwKf6TQl9VnLhYNaS+1
 m
X-Gm-Gg: ASbGnctPvtuV4kktpZEWySeF6DNfum4mjtSnEEVL6rqkqesGw/m/atBgXttOatY0UgN
 a5wLRuI64R70/DWlqVb2xZscEfRcVf++v1er7Yff/Z6uifEKaK7HHn53VI+T+KMLZYfhQ1Qruww
 3HvCD9uCgQqYOVfTZ4a6r5VtOIQNX23EZ9wxqvDoAjNPMZPuB/BI9+2gqBQK6KmVWpN50kYWgaw
 L/uIHtRSoQdwqTM6P8pkvbz09izeeDDvniLi7Vx6zE5kpM9uP6SNLUJHntfQ5whNbe9FC0j3brr
 3vF/oa9zDQbd7lqSSPYbXHQe6UQC12iY0T5liUqMm3PZVwEvuaBKQGUERhRFGH8VZX0KTUOklMy
 vGPS3OH28KQ==
X-Google-Smtp-Source: AGHT+IGPB3nnLTToTmSFRc8GGq3vKIJhpww2R+hAferLAYLu48Xjk+IwTl6hUbmo0nqNOeEgdQBnAg==
X-Received: by 2002:a17:903:410a:b0:223:536d:f67b with SMTP id
 d9443c01a7336-22c53607c21mr223841725ad.38.1745350530153; 
 Tue, 22 Apr 2025 12:35:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 106/147] exec/cpu-all: remove exec/cpu-interrupt include
Date: Tue, 22 Apr 2025 12:27:35 -0700
Message-ID: <20250422192819.302784-107-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-8-pierrick.bouvier@linaro.org>
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
index bfa039ab76..7b712b2556 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -20,7 +20,6 @@
 #define CPU_ALL_H
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-interrupt.h"
 #include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 80562adfb5..42788a6a0b 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
 #define ICACHE_LINE_SIZE 32
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8177c6c2e..958a921490 100644
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
index b0518a1f60..c2cc2daa66 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -23,6 +23,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "system/memory.h"
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f6bf068776..dab58c227f 100644
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
index 9b8b962e0a..ce55a5a654 100644
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
index 02ef6ddecb..a924aa01d7 100644
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
index ddb0f29f4a..451644a05a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -22,6 +22,7 @@
 #define M68K_CPU_H
 
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 #include "cpu-qom.h"
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e44ddd5307..d29681abed 100644
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
index 9ef72a95d7..29362498ec 100644
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
index b97d2ffdd2..c153823b62 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
 
 /**
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3ee83517dc..7489ba9564 100644
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
index 51e49e03de..556eda57e9 100644
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
index 349d61c4e4..5f2fcb6656 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5b7992deda..0a32ad4c61 100644
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
index d536d5d715..18557d8c38 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
 /* CPU Subtypes */
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 68f8c21e7c..c0aab69b61 100644
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
index 8d70bfc0cd..6684631478 100644
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
index 9e15105533..d388be83d0 100644
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
index e8711ae16a..9718e1a579 100644
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
index 0570e4a76f..4ae5668331 100644
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
index 3a80931538..43d0d0e755 100644
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
index 8cef88c61b..e388531610 100644
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
2.43.0


