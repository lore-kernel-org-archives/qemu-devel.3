Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E70C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtg1-0003cM-8L; Tue, 13 May 2025 13:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcu-0000xz-8Z
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:41:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcr-0003U2-Dc
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:41:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso38918085e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158066; x=1747762866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPgspPdCqoQQVEjmAK01XGF8m07nuW7MT8jEXvl7SIQ=;
 b=CVWLPI8T72apClAY9eF/fHR4SW55OY8/r/yLLRAobefl6EHO6mV6AUFPjwhKzHQWv7
 LY44AsiE6EMaQjePASdJeztPUcN3rp1NGiXG4G7PxsLRBYpZVdPqKeRS+7tlFTZSHDZT
 SwRtttORsnl+OQ4wHhebP3vdj/xO/P8YJxEmCPRxpWuBaxvbr28Es7yJFvKjcsmBlgJ5
 ml5Pwj/edq661zp1Vb+UdNQFevQBnqUY4MyivPmjdLkcFlnDIVvzTGFZWdxtvnc7R3xA
 N0Ntd3q+31Ft7THPWGpocg4+SJtpuW4ujJtVY+rdeM25j2J8aILJ5PvZlc7KCcFMAeQs
 IS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158066; x=1747762866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPgspPdCqoQQVEjmAK01XGF8m07nuW7MT8jEXvl7SIQ=;
 b=IOV8JP3JjE39eOkj1Ir+p/xkTHZ80GgK5DIVIwaFhkrt/Te+Ki7an4mmLZxJHbExHX
 E1e4QprKuKPSTUifQBTSqhoeoX+FiPwrhRZwgHxVnOLvZ+PEBtDmFcq2pAFrhpq2TRDR
 0FNJqFqaKLZUa8TJSk3ZY/FJXl9Omx4a1jeoLmTEQkMxkZhI9lQ7AxisK7kWS5XuxDeV
 d0wcljPqD0YdcyuR08HnyuSysz2TKPoT+rPALq7za97jcOlY6sg6/UnEUB9IJGFHX9TA
 EeDFrrvM568/DJiaP/1Xxd9Y7DOuVWsMQ+rMhQXUXgKUb8Ow5/KgTphji3D4HGkUTZs7
 f1+A==
X-Gm-Message-State: AOJu0Yy45chTBr3souP52GTng8Gf8nIF5DXR4uLYDyGhp9cMOsW2Gdn6
 lIGqqTQWAg+iyALJvLaYZ+xE2i3l62VVZ4sSuCZ0mbJB2/4qWsP1QXS8pxhKnBPoPsGB5x82Meb
 tdyg=
X-Gm-Gg: ASbGncvd2a35cGYU1KddmokvGIpg585fmGwqqi5ktD3wwlioFg1D3Ww1Lym/Wjb7/Aa
 yr11XLO0+UhSlQxS4kjl7yRsiopauhTQJBKU8I0BSrOL5+hSODXgGRF5Ul182MmHoTNKovm2kSr
 WdXKS2J4keyes+zmz4eGICAEi0YAg0QwsSZ2i3jrsK0xALIuXPawWG8sXQDEoCcdVYpJByQCX20
 7Rb5Vvl2VwH2B40ksEpfg2zuENAhKcmm84ptxR9jveCedWrugJSrfzJG4VA5gaJtYhPY/yvBtWX
 Y7VHMMEonhOLRiAnSUczo5Cvba4//lLeVJ0QTfbX9gewvGVpNS7ghSG6P8NdBnF/m9otM1KkCLJ
 6h/uhlJCpdEXkcg5+9AvwvASHklSU
X-Google-Smtp-Source: AGHT+IGVNuoZvHqJXX3VrKaYXfDdnsoVq7vNAk857hjHqmp0Ec+X4D1GbSJp5nPUfQqDYR6V0dvSsg==
X-Received: by 2002:a05:600c:1c12:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-442f20ffcc5mr2262185e9.17.1747158066257; 
 Tue, 13 May 2025 10:41:06 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb6esm222584945e9.25.2025.05.13.10.41.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:41:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/19] target/arm: Always include full path to 'cpu.h'
Date: Tue, 13 May 2025 18:39:28 +0100
Message-ID: <20250513173928.77376-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Some files include "cpu.h", others "target/arm/cpu.h".
Unify by using the latter which is more explicit.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpregs.h            | 2 +-
 target/arm/cpu-features.h      | 2 +-
 target/arm/tcg/translate.h     | 2 +-
 target/arm/arch_dump.c         | 2 +-
 target/arm/arm-powerctl.c      | 2 +-
 target/arm/arm-qmp-cmds.c      | 2 +-
 target/arm/cortex-regs.c       | 2 +-
 target/arm/cpu.c               | 2 +-
 target/arm/cpu64.c             | 2 +-
 target/arm/debug_helper.c      | 2 +-
 target/arm/gdbstub.c           | 2 +-
 target/arm/gdbstub64.c         | 2 +-
 target/arm/helper.c            | 2 +-
 target/arm/hyp_gdbstub.c       | 2 +-
 target/arm/kvm-stub.c          | 2 +-
 target/arm/kvm.c               | 2 +-
 target/arm/machine.c           | 2 +-
 target/arm/ptw.c               | 2 +-
 target/arm/tcg-stubs.c         | 2 +-
 target/arm/tcg/cpu-v7m.c       | 2 +-
 target/arm/tcg/cpu32.c         | 2 +-
 target/arm/tcg/cpu64.c         | 2 +-
 target/arm/tcg/helper-a64.c    | 2 +-
 target/arm/tcg/hflags.c        | 2 +-
 target/arm/tcg/iwmmxt_helper.c | 2 +-
 target/arm/tcg/m_helper.c      | 2 +-
 target/arm/tcg/mte_helper.c    | 2 +-
 target/arm/tcg/mve_helper.c    | 2 +-
 target/arm/tcg/neon_helper.c   | 2 +-
 target/arm/tcg/op_helper.c     | 2 +-
 target/arm/tcg/pauth_helper.c  | 2 +-
 target/arm/tcg/psci.c          | 2 +-
 target/arm/tcg/sme_helper.c    | 2 +-
 target/arm/tcg/sve_helper.c    | 2 +-
 target/arm/tcg/tlb-insns.c     | 2 +-
 target/arm/tcg/tlb_helper.c    | 2 +-
 target/arm/tcg/vec_helper.c    | 2 +-
 target/arm/tcg/vfp_helper.c    | 2 +-
 target/arm/vfp_fpscr.c         | 2 +-
 39 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index c1a7ae37356..25a7c2928ba 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -23,7 +23,7 @@
 
 #include "hw/registerfields.h"
 #include "target/arm/kvm-consts.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 
 /*
  * ARMCPRegInfo type field bits:
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4452e7c21e3..90c5efd6eac 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -22,7 +22,7 @@
 
 #include "hw/registerfields.h"
 #include "qemu/host-utils.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 
 /*
  * Naming convention for isar_feature functions:
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1bfdb0fb9bb..f8eb0d4a5a8 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -1,7 +1,7 @@
 #ifndef TARGET_ARM_TRANSLATE_H
 #define TARGET_ARM_TRANSLATE_H
 
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1dd79849c13..9c90430d1b6 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "elf.h"
 #include "system/dump.h"
 #include "cpu-features.h"
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 20c70c7d6bb..4cffe557e37 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "cpu-qom.h"
 #include "internals.h"
 #include "arm-powerctl.h"
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 930ec37413d..392887d3b48 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -30,7 +30,7 @@
 #include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 
 static GICCapability *gic_cap_new(int version)
 {
diff --git a/target/arm/cortex-regs.c b/target/arm/cortex-regs.c
index ae817b08ddf..2caa8855f02 100644
--- a/target/arm/cortex-regs.c
+++ b/target/arm/cortex-regs.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "cpregs.h"
 
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 759636a3b0e..00f06916e62 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -27,7 +27,7 @@
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #ifdef CONFIG_TCG
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 00629a5d1d1..34f43094da9 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "cpregs.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 69fb1d0d9ff..a6199a73740 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -7,7 +7,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ce4497ad7c3..d148d8434f1 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -18,7 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "gdbstub/commands.h"
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 64ee9b3b567..b6033f431d8 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -18,7 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "gdbstub/helpers.h"
 #include "gdbstub/commands.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7859729c39f..05a50c5c750 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/page-protection.h"
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index bb5969720ce..73c9a9a8333 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "gdbstub/enums.h"
 
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 34e57fab011..532018b745e 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -10,7 +10,7 @@
  *
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "kvm_arm.h"
 
 bool write_kvmstate_to_list(ARMCPU *cpu)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5969249b579..d280d08a63e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -25,7 +25,7 @@
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "kvm_arm.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "trace.h"
 #include "internals.h"
 #include "hw/pci/pci.h"
diff --git a/target/arm/machine.c b/target/arm/machine.c
index e442d485241..f0524615fe1 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 44170d831cc..03047d10d87 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -14,7 +14,7 @@
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/probe.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "idau.h"
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 5e5166c0490..672b5b01db0 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 
 void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 95b23d9b55d..9b7108d9678 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
 
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2c45b7eddda..5bf78d9240a 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
 #include "target/arm/idau.h"
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 29ab0ac79da..c95036df2a5 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 4f618ae390e..1713348a55d 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 1ccec63bbd4..d77eacb7338 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -6,7 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/translation-block.h"
diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index ba054b6b4db..3489f6d01c3 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 
-#include "cpu.h"
+#include "target/arm/cpu.h"
 
 #define HELPER_H "tcg/helper.h"
 #include "exec/helper-proto.h.inc"
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 6614719832e..5d657f5c753 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "gdbstub/helpers.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 0efc18a181e..66e90b03520 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 506d1c34757..105fc0a4b9d 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "vec_internal.h"
 #include "exec/helper-proto.h"
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 2cc8241f1e4..44f1aafd17d 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index e0f9c91450a..3a4a76e999e 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -18,7 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
 #include "internals.h"
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index c591c3052c3..0ae329710ac 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 0313cdd6ba2..05ecd647c9f 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -17,7 +17,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "exec/helper-proto.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index de0c6e54d4b..a2104b4751d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a2c363a4e17..afd110431cd 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 95c26c6d463..bc8353cdbb5 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -9,7 +9,7 @@
 #include "qemu/log.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 23c72a99f5c..ea7d0c74c88 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -6,7 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 986eaf8ffa4..9e2715e34de 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index b1324c5c0a6..ac532ef8511 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/vfp_fpscr.c b/target/arm/vfp_fpscr.c
index 92ea60ebbf2..a196bcfa803 100644
--- a/target/arm/vfp_fpscr.c
+++ b/target/arm/vfp_fpscr.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
 
-- 
2.47.1


