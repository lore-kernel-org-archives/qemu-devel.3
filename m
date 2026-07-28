Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CFDC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyA-0005Lw-SX; Tue, 28 Jul 2026 08:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy7-0005JS-KW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy4-0002zB-Ay
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2118641f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241891; x=1785846691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eHJg2TI8NW97mO+REE/Db1uHVBK+LSsko2hTZNzs3wo=;
 b=eqMkxaqjdwqTfojIQYF507DePMRD762GYzqcTa3+1u4SE+UExNLMkYU9JMbWFtVLQp
 hhL/lLzJwV6pZBhBGFoUGVXYd/lPJXSiThsG+8TzDM2LtouODa5Ix5YNH22gboYqXy8W
 GiX5J5JLuDYhGAAVAYuDEHfq3hFUDIrQedTHHFLwKkeXEnOUsSnxDp5xNIIAU35RgH8I
 96b6bgDPaW2gydasDxx6GosgEYMK84L3tPCjReTfs3JorCdv0kO8UKCF5zFHgv2glSrs
 gz3RufMKbBS8kKV/wJs5B8PuTnB1ZsHQg8sigxPuL/yhynaAk5r6VgIDPyHezPgWp0cS
 JQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241891; x=1785846691;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eHJg2TI8NW97mO+REE/Db1uHVBK+LSsko2hTZNzs3wo=;
 b=XXQoYRk1Z+ffjgqjhfgOmK8+LyC19AnQ8NhR+EoQpmxRuODD8ii722TVAxcn2Q4m4f
 GFizQ+dJ0lWdpeccePEhTl0u9GO5gwB0Bg4/Es7CMwjpZClIgTIAtQVF04TVuPQlSiQo
 6hT3Z359afibWpbP5QFe63s46qYttnNzAvY2HkeXVLdt8TbfZGSRfMS7k4XtWwQdjsMv
 w3p9i52UHj4SvBfWhKT215roP7z1anzRdkyEe3I8MxHLSk3Zg8SUVev6rm8bUzy1xnoU
 KrR9hRqj3cSPBrDHtIz0386SI9QJJ88iEnx80jIl2M6ZwPI4BHRM8qRMZ9FcWM5aE2cT
 JEnQ==
X-Gm-Message-State: AOJu0Yw5dYItVk3d/5ZM3ER6TYygSeIrO3Sos20HBrb+wHeWEedpeO4k
 BFIImgc/KAARA3y66La9xhZA9D6eaTNtyCMSWHkM55FofN+imZXPgEPLBjzJg6H4h21hRhRkyzd
 JgYIy
X-Gm-Gg: AR+sD12K1TMwpSEN7USiUSF/pv/rIdBe+y/a5x3YVpoQuc6xfEVk/lKgwEKXCDOuHtw
 acj4uDnAiExR7ZogUx0rg2M5IGYauRvqCq5tPIVPgYHYxoot0l8u9pmyDcf7gw5+B98z0PJqRyo
 pLcL7186Uu14aGPNloJgLmyLNLlS3zCYF/Tv5e+yG8Va5BDtrcl1PojlJj2vQyInAQE1rGLp7bF
 NunT6QWF57qpbu+WTVERBUDZtOSVWP9r4JaaLdWNKGvmq7dpxvBpVGIJ30Prqpt1bb/uYyt8WcC
 GjcXGKT5yZaRuoO35WZuQPFndBiYWkqyVREi/Muhh+hAL2FGh2I7jgUeQBgRvTqrZt0LZMK59rG
 eYv8YpqBmcyZlQ4Jmtf8MjWtn6wOom/LDLCbUXRvCjctNqwPuibV0rllN+hNjrDlu+zMjrdZGFZ
 HMDXt9uFpGcMCGWgHBvwvO/3U7t/3f4M9EY0UxLtcDDOlOZ0/lcEn/zuSBfFCr3zQOu7ELDjdUu
 tTXKI8x8cN2TFSeS/KeSw==
X-Received: by 2002:a05:6000:1865:b0:47f:8abb:7476 with SMTP id
 ffacd0b85a97d-47fb1e72377mr2568128f8f.19.1785241890715; 
 Tue, 28 Jul 2026 05:31:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] target/arm: Add stub for define_gicv5_cpuif_regs()
Date: Tue, 28 Jul 2026 13:31:09 +0100
Message-ID: <20260728123127.1711653-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

The common helper.c file calls define_gicv5_cpuif_regs() which
is only defined when TCG is built:

  $ git grep -w define_gicv5_cpuif_regs
  target/arm/internals.h:1885:void define_gicv5_cpuif_regs(ARMCPU *cpu);
  target/arm/helper.c:6334:        define_gicv5_cpuif_regs(cpu);
  target/arm/tcg/gicv5-cpuif.c:923:void define_gicv5_cpuif_regs(ARMCPU *cpu)

This fixes when building on macOS with --disable-tcg:

  Undefined symbols for architecture arm64:
    "_define_gicv5_cpuif_regs", referenced from:
        _register_cp_regs_for_features in target_arm_helper.c.o

Define the GICv5 stubs in their own compilation unit, otherwise
we get the following error:

  duplicate symbol '_raise_exception_ra' in:
    libsystem_arm.a.p/target_arm_tcg_op_helper.c.o
    libstubs_arm.a[4](target_arm_tcg-stubs.c.o)

Fixes: ee0f1ce00db ("target/arm: GICv5 cpuif: Initial skeleton and GSB barrier insns")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260721122135.6288-3-philmd@oss.qualcomm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/gicv5-stubs.c | 17 +++++++++++++++++
 target/arm/meson.build   |  1 +
 target/arm/tcg-stubs.c   |  4 ----
 3 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/gicv5-stubs.c

diff --git a/target/arm/gicv5-stubs.c b/target/arm/gicv5-stubs.c
new file mode 100644
index 00000000000..845626d7c6b
--- /dev/null
+++ b/target/arm/gicv5-stubs.c
@@ -0,0 +1,17 @@
+/*
+ * QEMU ARM stubs for GICv5 TCG helper functions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "internals.h"
+
+void define_gicv5_cpuif_regs(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
+{
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 4412fde065f..f6ae8934d1b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -37,6 +37,7 @@ arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 arm_user_ss.add(files('cpu.c'))
 arm_stubs_ss.add(files(
   'cpu32-stubs.c',
+  'gicv5-stubs.c',
   'kvm-stub.c'
 ))
 arm_user_ss.add(files(
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 8d97449cfc6..aeeede80661 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -43,7 +43,3 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env)
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 {
 }
-
-void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
-{
-}
-- 
2.43.0


