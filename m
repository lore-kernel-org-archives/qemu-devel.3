Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61990C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JTB-0006di-Bu; Tue, 22 Apr 2025 15:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSI-0004BY-8s
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSF-0007MF-6d
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22c3407a87aso84292335ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350729; x=1745955529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daDsqIY3JqZY3gWJRoer5Pq3HW0D1tA51SVXkh4oP34=;
 b=cziVlss2CKx7YMt4mkwLUysInhrcSfLMVDTTfQkp/DLkJDUNVd2szhxdvBuZIs0Qiq
 fXUtEEmxfzH25eixF57LO10DjsJdXy8uTaoiIBqGlr3OmdWJK64Ue6lHLd9jQ3RZyaYY
 vCohyYqTOfN+nLADKMSXywrpXTzpDwnC0S0+nErB+AuVKiGrPoSGCEey0srxb0LhaDQJ
 WiBFWUGFjXSorpaj8HXYivGPnu+F/N8iY+KFr6s7PhljFOPOP2kLR068uvxGR8VVzd8U
 yed1M6srXY2e4d/qHqb7adpVd8JYVv/DjtppifjBL1ERGhxUxk1xt4haYiZPil1+18p2
 0L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350729; x=1745955529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daDsqIY3JqZY3gWJRoer5Pq3HW0D1tA51SVXkh4oP34=;
 b=b/ltPW2wOOqKfBAKsheKj5UXIEHhuolQXKEtj3hgthxF672bh0SPz0kNhe0qE90tda
 l48NFRYOFzCTWixsh7QRm7Hm7hlQwsXmX20UpH26yG3JFvTDyDJ6REWN09f7DEhF0jFU
 E4CanRNTJrO9ao6FYPUN0KP9cy1LFX0jwW2cu0Nr0d688iTqhK5wWpfUQxnrMYeURHVR
 sVV/Ix94vbykoPM9in87tawz8L2PU/13Xrq5Wm8/kx3uPv17nVoCxtH1RCtWNu2kCgZj
 AZdQaU25z31qGrGaRAAqnEykzRvGjk4ZEg09+VC6T2B+yoKxZlyvEBmLB/znQacvXs2Y
 /5tA==
X-Gm-Message-State: AOJu0YydxhD5EehY6BJ1+sEKuTO6qZUp6qysO8mGvTyzKBtV9VZvilDb
 I7QdyBro+hq1UgoeM14h5imvnndtI5eVmzRPp4J9HzJyVeAYsfRK4W/6DYa5GIOuu6oNzUch3Qa
 y
X-Gm-Gg: ASbGnctxw/Ojty/51ex+tTZ0Y5sL/lTNsBI6o07sDg2dfX9REbMt29MSGV+OyNVcbyo
 V5IJN7GHbXZjdB0C8DTcTnXQyzNJm8wecmjNSfxSnBG6VMhZz84tqiThVmKZpLNO3JQjd1FEQwT
 wqavNMA3ndXuz1H0ASfWrP34HvYqTNDy1xrAyEul4EpseIwgoJwd9R/QmsDMWQI76s1GqV6r7Ov
 X4VycgyGkxgUVFuVK70+5YaQ5tAshHwbRom8mGuC+up9d4qFISYooH0DjboL8CD9/hhlyCXMvsk
 vgmI/d2NU61D4G3BjsLaqhheZ2vv76D/Mu/nnCNylTYjSnoxvxTKsD1JuG50lg8R7jA5GijgVSk
 =
X-Google-Smtp-Source: AGHT+IFBmz53arONzZlfENM+1tYf2MgRBrsdQiDq10vBD6ULHE/Fq8q9ns9GQDrceh1OqAm/VMCUhA==
X-Received: by 2002:a17:902:d4c9:b0:223:f7ec:f834 with SMTP id
 d9443c01a7336-22c535b094amr235274625ad.31.1745350729453; 
 Tue, 22 Apr 2025 12:38:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 134/147] tcg: Define guest_default_memory_order in TCGCPUOps
Date: Tue, 22 Apr 2025 12:28:03 -0700
Message-ID: <20250422192819.302784-135-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Add the TCGCPUOps::guest_default_memory_order field and have
each target initialize it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index 106a0688da..a4932fc5d7 100644
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
index 99d839a279..6f931117a2 100644
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
index c9e043bc9b..3f20e258fd 100644
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
index 1a913faa50..4553fe9de0 100644
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
index feb73e722b..67918684fa 100644
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
index ad1f303fbc..b12e0dccd0 100644
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
index 51bff0c5d6..ac4560febe 100644
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
index 35b17f2b18..3e1b315340 100644
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
index 4cc8e02f70..ee74509a66 100644
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
index 4409d8941c..bfde9b8594 100644
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
index d10ae0702a..e46863574c 100644
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
index cb0d6dde0e..67a8550cc1 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -551,6 +551,8 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 }
 
 static const TCGCPUOps mips_tcg_ops = {
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index dc55594a7d..e62c698a40 100644
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
index fd8c42069e..1cf18e0dae 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7479,6 +7479,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
+  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5d0429b4d0..ded2d68ad7 100644
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
index e14d9cbef9..d7eac551fd 100644
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
index d15b1943e0..f232d82fa3 100644
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
index df093988cb..29f4be7ba9 100644
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
index af3cec43e7..ef04efcb18 100644
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
index 833a93d37a..3bf399335a 100644
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
index 51f9ee9e89..2347106495 100644
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
2.43.0


