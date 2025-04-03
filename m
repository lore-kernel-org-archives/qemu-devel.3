Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343A5C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0SgY-00004u-Fr; Thu, 03 Apr 2025 18:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgV-0008KX-As
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgS-0003yJ-TH
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so9295745e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717911; x=1744322711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzvvKD67dGmGHSwnMZ3wOcfLPFevPnPtS38dzad8SEI=;
 b=dv6U8MHWwbGztLE4eUAAgT7dD86gmtX31Vum9t5Wmlp9HiPCeh9jwHUaQ2aBK/a6EP
 S0kUdaOp5wHFvm3SZNQJMetlazxhFN8Oh/0fbbQV5rgOXqqhQek3Hu6cvBZuOuE7LPGp
 SCOfuSEd0J2MrmwpO1MrlBTDVWbsFxvGfNvgV25aklAWAxLXexngD7Fokf19av+3iIjT
 9h0X02K72vTzpQFzvKLnO2ILeWnporW/gbrqIjt5mSfOtjz91CYLuukNlWEFumQakkTD
 z+VtzdSXiQwtjEzEKIxZl7DPhKRTqYGePrgBq28JcTQe5teyw/tKgKWYQ+3dFiWJGKID
 AIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717911; x=1744322711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzvvKD67dGmGHSwnMZ3wOcfLPFevPnPtS38dzad8SEI=;
 b=fU8tIIkhV8iVYmHe/mfOX+t+f/xioFMvqig5+4rOACC81QYDjt7EaYXGNjXPolQXFp
 3+2Ww6MobpGMUGnGtnwOk1+970HpYtjTAaWCD9h2SH1ZGryzK75P5hleINPdp2scJCIS
 tCIj59Gh+V6QVSik49seAJcyzyN8zFDt8qwTLGB4KUJrBbGAVak+p/w/1j6H0vMrdZsC
 AQOGsl9ozzXkImxiS/b81TH6DeAPYRn0dsrjmH7wjYBgZD+dMxQRG6qV1+2WQNU+rVyo
 mS9z3HiSAvFW3ABdgcz5In6wH29but8ETRdHQUC9LWCO/IItw3n8B2kcizY8igJunZLs
 sWxw==
X-Gm-Message-State: AOJu0YwhkH6KWHRd1+ZV/CbJ42TAUC0/QqCQ/Br+DqN8xN77H3myYQtO
 1+O/efzFXZd/g/IeMKpET61mMPUQexhRBoOvt2bhDjy3aXpZrGBB0ygFrfIiilpbjTWWrqmhFKp
 7
X-Gm-Gg: ASbGncs43K5IFfxnpRI+FLJv46sn2yguNfA/iKS982cagnZKsfTi//+kwRL6pnQpm/W
 +VgAveB6rJVkL26/IwS1pfQ0+SVntaw3rf9G6Blj3ZMWGPTMVZwD/hBlxGTFl0HquUvbSrh+0gB
 3C/e3ChOen6zCPKx0UgH7lEB8Ba0mIdpLohE6Z3FITfcbKWuW5vbnZK2ARQ0C1DHhDou6X4BfHs
 kba/LsqKhLG26H4Zm1kIyNj3Jr2qjgV01IHzsFigDb209hoV8yEvRgKh0CK3e4YfavUdvz+iGRo
 4FjZRp4y+/ze1wQgvQ/xAqVk5wReQEqv2xnFAh0loElE8iWPVJ2WyvfJ+LA9xgwVL5ElvvOR8aX
 rj64Llh+48qxIEiKeWFSHkAyn
X-Google-Smtp-Source: AGHT+IHm6pvXCInltCGuAi8vvUFUrcDEyAF6iZy9RYL+Q/rGsAY1rUJpadvpffi6njSJQY8juo5Usg==
X-Received: by 2002:a05:600c:468b:b0:43d:7413:cb3f with SMTP id
 5b1f17b1804b1-43ecf83ffe9mr3587815e9.5.1743717910844; 
 Thu, 03 Apr 2025 15:05:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d980sm2840084f8f.61.2025.04.03.15.05.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 10/19] tcg: Define guest_default_memory_order in
 TCGCPUOps
Date: Fri,  4 Apr 2025 00:04:10 +0200
Message-ID: <20250403220420.78937-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
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

Add the TCGCPUOps::guest_default_memory_order field and have
each target initialize it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 8 ++++++++
 target/alpha/cpu.c          | 2 ++
 target/arm/cpu.c            | 2 ++
 target/arm/tcg/cpu-v7m.c    | 2 ++
 target/avr/cpu.c            | 1 +
 target/hexagon/cpu.c        | 1 +
 target/hppa/cpu.c           | 2 ++
 target/i386/tcg/tcg-cpu.c   | 1 +
 target/loongarch/cpu.c      | 2 ++
 target/m68k/cpu.c           | 2 ++
 target/microblaze/cpu.c     | 2 ++
 target/mips/cpu.c           | 2 ++
 target/openrisc/cpu.c       | 2 ++
 target/ppc/cpu_init.c       | 1 +
 target/riscv/tcg/tcg-cpu.c  | 2 ++
 target/rx/cpu.c             | 2 ++
 target/s390x/cpu.c          | 2 ++
 target/sh4/cpu.c            | 2 ++
 target/sparc/cpu.c          | 2 ++
 target/tricore/cpu.c        | 1 +
 target/xtensa/cpu.c         | 2 ++
 21 files changed, 43 insertions(+)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 106a0688da8..a4932fc5d7c 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -16,8 +16,16 @@
 #include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
+#include "tcg/tcg-mo.h"
 
 struct TCGCPUOps {
+
+    /**
+     * @guest_default_memory_order: default barrier that is required
+     *                              for the guest memory ordering.
+     */
+    TCGBar guest_default_memory_order;
+
     /**
      * @initialize: Initialize TCG state
      *
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 99d839a2792..6f931117a25 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -235,6 +235,8 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps alpha_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = alpha_translate_init,
     .translate_code = alpha_translate_code,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c9e043bc9b5..3f20e258fd0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2671,6 +2671,8 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 
 #ifdef CONFIG_TCG
 static const TCGCPUOps arm_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 1a913faa50f..4553fe9de07 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -232,6 +232,8 @@ static void cortex_m55_initfn(Object *obj)
 }
 
 static const TCGCPUOps arm_v7m_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index feb73e722b3..67918684faf 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -224,6 +224,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps avr_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
     .initialize = avr_cpu_tcg_init,
     .translate_code = avr_cpu_translate_code,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index ad1f303fbcf..b12e0dccd09 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -325,6 +325,7 @@ static void hexagon_cpu_init(Object *obj)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
     .initialize = hexagon_translate_init,
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 51bff0c5d62..ac4560febea 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -253,6 +253,8 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hppa_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = hppa_translate_init,
     .translate_code = hppa_translate_code,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 35b17f2b183..3e1b315340c 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -125,6 +125,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 4cc8e02f70b..ee74509a664 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -864,6 +864,8 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps loongarch_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = loongarch_translate_init,
     .translate_code = loongarch_translate_code,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 4409d8941ce..bfde9b85948 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -589,6 +589,8 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps m68k_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d10ae0702ad..e46863574c6 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -427,6 +427,8 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps mb_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = mb_tcg_init,
     .translate_code = mb_translate_code,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 269d3d69bd5..860ec398229 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -550,6 +550,8 @@ static const Property mips_cpu_properties[] = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 static const TCGCPUOps mips_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index dc55594a7de..e62c698a407 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -243,6 +243,8 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps openrisc_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = openrisc_translate_init,
     .translate_code = openrisc_translate_code,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 740d8b92c0b..57565c9a2f2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7478,6 +7478,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
+  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5d0429b4d00..ded2d68ad78 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -140,6 +140,8 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = riscv_translate_init,
     .translate_code = riscv_translate_code,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index e14d9cbef93..d7eac551fd4 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -204,6 +204,8 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps rx_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = rx_translate_init,
     .translate_code = rx_translate_code,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d15b1943e0e..f232d82fa34 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -345,6 +345,8 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 }
 
 static const TCGCPUOps s390_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
     .restore_state_to_opc = s390x_restore_state_to_opc,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index df093988cb1..29f4be7ba9c 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -262,6 +262,8 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps superh_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = sh4_translate_init,
     .translate_code = sh4_translate_code,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index af3cec43e78..ef04efcb183 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1001,6 +1001,8 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps sparc_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = sparc_tcg_init,
     .translate_code = sparc_translate_code,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 833a93d37af..3bf399335ac 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -172,6 +172,7 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps tricore_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
     .initialize = tricore_tcg_init,
     .translate_code = tricore_translate_code,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 51f9ee9e89a..23471064957 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -232,6 +232,8 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps xtensa_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = xtensa_translate_init,
     .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
-- 
2.47.1


