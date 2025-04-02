Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1360DC3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05I4-0000zr-5j; Wed, 02 Apr 2025 17:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Hs-00080G-4Y
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Hp-0006mX-Sl
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so210335f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627971; x=1744232771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9LUrWk9nsQjuOPMRf1Z7eqrIELlsMdm2VOyUXDR8gOM=;
 b=zaKbffQN2gTG7pFauC6qmCCGRUg2tH2qdbpe6vqK0RdDUEaetw03OWtfy1GPZshCcU
 1lT/z34irpmnle8ih16/LYksXdrTGC0bVfScp50ILjnbr+uSA4joOqTZkudluyd4rjX0
 tPLwQlTKtIlWD3ANj6DJXMsOuzmAFM1GmJL/l4/UmPXaE4lcM1nBwO+2LeASsIAJtpiL
 7GadZJ00Cbo+FTt+9qMGrJl/Y9no9olyiJLv8nJcBSZIXK6smVmyhaCI4X19C7KYj3eS
 0cna81BQ+vDhqJrG5G390dDJFnaHJeQimAbm2YqUU8jwlGvHdEAfw6hCpb2BckrwlrFa
 9GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627971; x=1744232771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LUrWk9nsQjuOPMRf1Z7eqrIELlsMdm2VOyUXDR8gOM=;
 b=CA3S6XBPCM+Lao9b0/BUS9VAdwFS9V66LHkGINq783Xomuyco3jELkmSfB7R0c+d27
 HwmT+e7U9u9FZAY3vqPQsxzn2tMkiYNBPu9iHXH2KwjqMVng9fZvdhdMmalFDypLoqqY
 Fv8vRU7q/INXm42NKEPHIIQouROFrIMuqcZIFpOo7jnGfy+XKrhBGUjjziu8s5P/LG/E
 AjFTAvVhjfJNHvzle+llZJMXblcSxoPEHCiVfRBN8aMTXQNf1cwyCYZ60fpjCOw+F5Hd
 Z5XB/R3Ayn7kV81f4YhtI3ZSOr3bzeYcun7x6xBWOoDYypU1/vJxS45rjSsfjVAJBfs8
 75ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo6Nn4NzD53RW0OYQoLVqEfbmR+PFFb4Yp8gjaSP/BzbbKwM4yWO4nPShQTDqGdyZlc4FPJC42Q8w3@nongnu.org
X-Gm-Message-State: AOJu0YxBaaGsh5N8rVlnV24N2LcUqx5x7w6CUAkbO2BjmKBHM2O9jyt6
 B4oQ7w5GJXr39xR2Ic9XyBcITK0d3jkOKxuGifPG2IpIKQZAhGgxqKG5MZBokulSBf3UGFQQhmk
 O
X-Gm-Gg: ASbGncudkvSrRbOIMAr4649ih7GlHY8+Cd4548wtpfirn0z8xX8IkkAROzY1rOCWltV
 KyTvlsMVVBjYKlYqQtXey+tr/Ca9TbV/2dNx0AipCB2MOcnMtBuVCgfKpoIvfxTMQhrTj7kpajk
 XK99wmObztWGzlvRYeQOKP806GpcSdEwuIYOLtQgjWGgzBHI9PvlvB5lfT0mtkr9FW94JVrAdDZ
 DIiaSjUwBIS9OVKV61fyxIyJIztdL7cyP48CnRHszAlzVAuU3liKShCjbVzbRJSHM50disCNpSx
 3iLBo++uNzHGHHcuS9pE9NQicBa24ilHInZWrAfjGbtYlZSrOCACtixt+t7g4jgz0RKiV2cDrH2
 wKPlkq3DGfK6fyPq5KhM=
X-Google-Smtp-Source: AGHT+IGUeeeXPO+A3hDFzx0y1ndiMpGC0gAgdFzyEWEi/ooz7i+H7jHYpEcXjY/Mo+6cpgzSJx3deg==
X-Received: by 2002:a05:6000:270d:b0:39c:1257:cd40 with SMTP id
 ffacd0b85a97d-39c1257d4e5mr10434089f8f.58.1743627971169; 
 Wed, 02 Apr 2025 14:06:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658ac5sm17571881f8f.1.2025.04.02.14.06.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 33/43] tcg: Define guest_default_memory_order in
 TCGCPUOps
Date: Wed,  2 Apr 2025 23:03:18 +0200
Message-ID: <20250402210328.52897-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
 target/ppc/cpu_init.c       | 2 ++
 target/riscv/tcg/tcg-cpu.c  | 2 ++
 target/rx/cpu.c             | 2 ++
 target/s390x/cpu.c          | 2 ++
 target/sh4/cpu.c            | 2 ++
 target/sparc/cpu.c          | 2 ++
 target/tricore/cpu.c        | 1 +
 target/xtensa/cpu.c         | 2 ++
 21 files changed, 44 insertions(+)

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
index 766b6786511..576a2e4b8af 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -320,6 +320,7 @@ static void hexagon_cpu_init(Object *obj)
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
index 30238e9a223..1c451021ad8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7483,6 +7483,8 @@ static const TCGCPUOps ppc_tcg_ops = {
   .restore_state_to_opc = ppc_restore_state_to_opc,
   .mmu_index = ppc_cpu_mmu_index,
 
+  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
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
index 320ace67198..b1417eb1d89 100644
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


