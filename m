Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFC5C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQR-00006Q-Jo; Tue, 22 Apr 2025 15:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP7-0005Xy-NO
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP5-00077A-2m
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so85258985ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350533; x=1745955333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmCXttkXA/8zETeaPm/LfsKfA+eIzwpHlkY8iEH6IgQ=;
 b=ay/aHw7vB1SZSzfqSMQvDAcxQUZW9Ntl4cVxN2Xu2jXbGfuaUs8Xt6sQOOq2+mScV3
 jeaJ0bALGy6SGhJcrxX2gNteuopqP7ORGUZ+u91ByRv/hNNll+MwPcMFv4J1u4X7+xGJ
 DX1Gl7sQvK5w1xCCrgp5ZapryhJDvOUFhCFpIz/zRSBQ2sAn0gc397o/FN4eC2ZIib0/
 WU7mpXERhLPP9hz/l+HfQ/4Up86EGeya08GVqcdDAzq9I6nLW2Wab51gAAXZv/C1Ebk0
 J7qGtkNgLdRRDSiwuiNtgDOITiCMbMvZF+UXM0fdwLn8AFt4kdaO49qZmbSYU2Lad61+
 K54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350533; x=1745955333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmCXttkXA/8zETeaPm/LfsKfA+eIzwpHlkY8iEH6IgQ=;
 b=vgvcNuSsAsZye9OMuLSSONyhOHRE0FQwLsaGTWBqtMGgEXVQxh1CAU4pL5yQHSYKcX
 NS/5MdxUpSTHLM3ovOMIhINomu62Q3UbDa85xSSLE2ZKOSgau6H1GP15EMRlsSVDnMw9
 V5wM0JkW5sndoh0ydPttiXWa698vyy/mIM7OF1/hT+wAsoZdzr96gd1ollubCWGp0Uck
 FTrgvOD/+4nZdQXtiBrIXpAavHcbqWWcAWh5kvgrNhVQVNsT6Q7Wj9AYjoOzIUwB+dlG
 wJ+bi7U8Kw1ws+Kk19OYZ7m/8wX93/EXFzRFRMzzRy6ZHU3H5Dn+PV4LugUg9v2od7GR
 bMsg==
X-Gm-Message-State: AOJu0YyQpmOlmMoaJcaOnVIUxh+MjL170GvufCU3ZcUo2aHQwaJQKXwH
 CZkHtFkCxvrVLrX6dL6MANlDXpYVgPPX2UPFH3k1DG3ZIxGVVUuA6EA16TH1QW39aSkjR2MsdRe
 s
X-Gm-Gg: ASbGnctTjfpGCwidvMQYbo1CF4VJk3SfSj5RwLTF1IUAeYorsAjUfHObq7uhB+hPmK2
 cuyx0430LEFZyDANIdgD8yCf4pJ2tsmCQHTSEXrnQ/yozi9CZLd143/VkYVIXBk45VPNm9jneFk
 wDSzCRiX6rtenSWwV1vXzzHAatsYVFy8gKS8uKyvtYbX5YnVya2QzFy/FsCluivm0x73jfVZjhk
 Jff7LX84N1o1bNOjExo5Jeqzen4eJDMrPMN2e2yMGRc7MhXC4pGHqKPTvhziQ1I7HL4e0MYSIoK
 wcontaFBItO2K/0Uw2KjhNfBKAdgL4wI4qjfvGaOLiGT9D+wSsIJpWzBEzOfYDfNXuifJcDGeqk
 =
X-Google-Smtp-Source: AGHT+IEjGZKAm9JY1arfsTa3h4epfXhK2P62mBfctmEIFWdkHE4W+0pCPHedcSSxtNpLO0K17HKoEg==
X-Received: by 2002:a17:90b:2752:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-3087bb519ddmr23754854a91.8.1745350533510; 
 Tue, 22 Apr 2025 12:35:33 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 111/147] exec/cpu-all: transfer exec/cpu-common include to
 cpu.h headers
Date: Tue, 22 Apr 2025 12:27:40 -0700
Message-ID: <20250422192819.302784-112-richard.henderson@linaro.org>
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
Message-ID: <20250325045915.994760-15-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h  | 1 -
 include/exec/cpu_ldst.h | 1 +
 target/alpha/cpu.h      | 1 +
 target/arm/cpu.h        | 1 +
 target/avr/cpu.h        | 1 +
 target/hexagon/cpu.h    | 1 +
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
 target/tricore/cpu.h    | 1 +
 target/xtensa/cpu.h     | 1 +
 cpu-target.c            | 1 +
 22 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e7c8b8672f..5122fdbee3 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -19,7 +19,6 @@
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
 
-#include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
 
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 77dc5ac61c..63847f6e61 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -66,6 +66,7 @@
 #error Can only include this header with TCG
 #endif
 
+#include "exec/cpu-common.h"
 #include "exec/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 42788a6a0b..fb1d63527e 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -21,6 +21,7 @@
 #define ALPHA_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 958a921490..ee92476814 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -24,6 +24,7 @@
 #include "qemu/cpu-float.h"
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index c2cc2daa66..a0fb40141a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -22,6 +22,7 @@
 #define QEMU_AVR_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "system/memory.h"
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index f78c8f9c2a..e4fc35b112 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -21,6 +21,7 @@
 #include "fpu/softfloat-types.h"
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index dab58c227f..4e72ab025b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -21,6 +21,7 @@
 #define HPPA_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "system/memory.h"
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ce55a5a654..1f30129e40 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -23,6 +23,7 @@
 #include "system/tcg.h"
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/memop.h"
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index a924aa01d7..69117c602a 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -9,6 +9,7 @@
 #define LOONGARCH_CPU_H
 
 #include "qemu/int128.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 451644a05a..5347fbe397 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -21,6 +21,7 @@
 #ifndef M68K_CPU_H
 #define M68K_CPU_H
 
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d29681abed..90d820b90c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -21,6 +21,7 @@
 #define MICROBLAZE_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-interrupt.h"
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 29362498ec..79f8041ced 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -2,6 +2,7 @@
 #define MIPS_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index c153823b62..f16a070ef6 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -21,6 +21,7 @@
 #define OPENRISC_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7489ba9564..aa5df47bda 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -22,6 +22,7 @@
 
 #include "qemu/int128.h"
 #include "qemu/cpu-float.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "cpu-qom.h"
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 556eda57e9..14a6779b4c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -23,6 +23,7 @@
 #include "hw/core/cpu.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 5f2fcb6656..e2ec78835e 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -23,6 +23,7 @@
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
 
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 0a32ad4c61..83d01d5c4e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -27,6 +27,7 @@
 
 #include "cpu-qom.h"
 #include "cpu_models.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 18557d8c38..7581f5eecb 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -21,6 +21,7 @@
 #define SH4_CPU_H
 
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index c0aab69b61..b87351a666 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -3,6 +3,7 @@
 
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index cf9dbc6df8..abb9cba136 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "hw/registerfields.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "tricore-defs.h"
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 6684631478..c5d2042de1 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -30,6 +30,7 @@
 
 #include "cpu-qom.h"
 #include "qemu/cpu-float.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "hw/clock.h"
diff --git a/cpu-target.c b/cpu-target.c
index 7f3b244ed1..14cd623bff 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -24,6 +24,7 @@
 #include "qemu/qemu-print.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
+#include "exec/cpu-common.h"
 #include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/log.h"
-- 
2.43.0


