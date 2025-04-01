Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E603C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWim-0001ny-ED; Tue, 01 Apr 2025 04:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWii-0001bR-EX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWig-00062p-19
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso35988345e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495096; x=1744099896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jpgz3OtVHhFfAhVmnuMWKFfUOyUSx9BejJG8YbABqHQ=;
 b=ZYfjq95W3ucs0efpW2NmZRQrGNhopLq5bfr1cjaa8mmeadJ5Ews3DR4adwiugLO5t9
 mw/YIfVzAvtPpioVv6Iys8POuOKhSJOCxzbizbdI0TZaWvdlm+pyjLpoyKA5Xaj2wuEg
 OBlbBC1xilU88uppjJeVS0/3PjKORGxvqMgKO3tTbRmIhAqLONOVSxGm1hI8B8RZv21v
 pnaUcYA5saYsuMR2xQJHJgrwGcNRk6Rh4hmf+x/PdxONJobF2lOPt9pkvLYcfOMh8eZe
 fSFuYrBzwUZeJFto/BKxDlVXuodBcek0TbZkwpE7qY7Pu47RKS02JrCMIAaS6oRp7vHt
 Lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495096; x=1744099896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jpgz3OtVHhFfAhVmnuMWKFfUOyUSx9BejJG8YbABqHQ=;
 b=AiasVwK0XGv7GVZax2jIqoCTLRBLZWAylLYPQp/GoniKFl9C9sx7FfuR4SqU8Zg0sD
 x8OnY48jr2U07wY8L3HJQeoae7obBeOYylk7aazbNgNk1Pj+m50SsKsJQO1ldHOt1hV9
 eo18Yae15xrgsNMmOuq1NANuqNMa0v+aeWqdBrgDa3YnjBLpr9krp+AD6meNbgoFJj1F
 2rs+vaCIqFzq7mR1eeWCvhhN+99dqJxrdQBCQ2+PtNWtLsbUjx7uw+ZQhnjfbhJ9GXd/
 34OVK53vJx34Jd507ySs6DALIjbtnisW4mRNOFCuwOiS94AsIppQxltiDtULcoUkR+dX
 zndQ==
X-Gm-Message-State: AOJu0YwxBeUYCjyxLqE6fL3Fk0cFdVZBD6f0p/Rpe5znosmIcOheh+Rt
 lUadr4XVBFhMaWuqNBfdhcjjea+Jo12AqWEx0ttTwo7YxPpKjLNBIxftAdKseGqWyvuukN0Q/A6
 M
X-Gm-Gg: ASbGncse5T/13MLk4DtW45PozAliIleKGDIpl/F6WsWdp7c7ucSz6+FXqYXg4Wm8i5Q
 GYrN088CmK2jvPuDjL2FptFeweTM9FpiF4fXohhCWPlmYQ+F+9h9VcLlVw+5Cp/S/0XCO0zhEHb
 uZeWy14NzrWZupsf6kOfrgleENV3n6+4fjxZBi7mswlT94Zl9GqbsvTFMbswDYQ2/nssbEaVnta
 z7Xu2duCTnOVzSqjxMQvCnvPg11Y16+7C0XzFpfezJh2yHxuHNeKbQv3zpITkfF4FM1O8oIz9p+
 VlczkjJGaHPSnVQ68efQWb77Dl6hw6EzrIZTqi2Iga+Z/eNO/yt1lZ+Lm46Adq2F/+WsW7k50DD
 4ZMyO1S0A/fFJP6vjcoI=
X-Google-Smtp-Source: AGHT+IEsTs/6SP4nf96AndpQmmjvW5e4nF/nEZrmwB67o8vXqk5MehUQWUd4FZa5JtFwoAb5dmK1CQ==
X-Received: by 2002:a05:600c:34ce:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-43dabe23634mr120719515e9.0.1743495095890; 
 Tue, 01 Apr 2025 01:11:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba3ef1sm153088175e9.2.2025.04.01.01.11.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:11:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 24/24] exec: Restrict cpu-mmu-index.h to accel/tcg/
Date: Tue,  1 Apr 2025 10:09:37 +0200
Message-ID: <20250401080938.32278-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/{exec => accel/tcg}/cpu-mmu-index.h | 6 +++---
 include/exec/cpu_ldst.h                     | 2 +-
 accel/tcg/translator.c                      | 2 +-
 semihosting/uaccess.c                       | 2 +-
 target/arm/gdbstub64.c                      | 2 +-
 target/hppa/mem_helper.c                    | 2 +-
 target/i386/tcg/translate.c                 | 2 +-
 target/loongarch/cpu_helper.c               | 2 +-
 target/microblaze/helper.c                  | 2 +-
 target/microblaze/mmu.c                     | 2 +-
 target/openrisc/translate.c                 | 2 +-
 target/sparc/cpu.c                          | 2 +-
 target/sparc/mmu_helper.c                   | 2 +-
 target/tricore/helper.c                     | 2 +-
 target/xtensa/mmu_helper.c                  | 2 +-
 15 files changed, 17 insertions(+), 17 deletions(-)
 rename include/{exec => accel/tcg}/cpu-mmu-index.h (87%)

diff --git a/include/exec/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
similarity index 87%
rename from include/exec/cpu-mmu-index.h
rename to include/accel/tcg/cpu-mmu-index.h
index a87b6f7c4b7..3699c18b4cb 100644
--- a/include/exec/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef EXEC_CPU_MMU_INDEX_H
-#define EXEC_CPU_MMU_INDEX_H
+#ifndef ACCEL_TCG_CPU_MMU_INDEX_H
+#define ACCEL_TCG_CPU_MMU_INDEX_H
 
 #include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
@@ -37,4 +37,4 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
     return ret;
 }
 
-#endif /* EXEC_CPU_MMU_INDEX_H */
+#endif /* ACCEL_TCG_CPU_MMU_INDEX_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 313100fcda1..63847f6e618 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -68,7 +68,7 @@
 
 #include "exec/cpu-common.h"
 #include "exec/cpu-ldst-common.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 36a6a9e0408..c53bbdef99f 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,7 +12,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-ldst-common.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 92b2421dce5..81ffecaaba4 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 3bbca4cbb98..64ee9b3b567 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -28,7 +28,7 @@
 #include "mte_user_helper.h"
 #endif
 #ifdef CONFIG_TCG
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #endif
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index df4e35f4de6..554d7bf4d14 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/helper-proto.h"
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7e6d1ef9379..ca49f8d6dcb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -20,7 +20,7 @@
 
 #include "qemu/host-utils.h"
 #include "cpu.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 4597e29b153..bb343078bf7 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "internals.h"
 #include "cpu-csr.h"
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 9e6969ccc9a..92031924830 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "qemu/host-utils.h"
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 7f20c4e4c69..95a12e16f8e 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 4a8e203cf88..d4ce60188bd 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 072d5da5736..af3cec43e78 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "hw/qdev-properties.h"
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index b3351eebd0a..217580a4d8c 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index a5ae5bcb619..e4c53d453dd 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -20,7 +20,7 @@
 #include "hw/registerfields.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "fpu/softfloat-helpers.h"
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 45601a4b850..a7dd8100555 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -33,7 +33,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/cputlb.h"
-#include "exec/cpu-mmu-index.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-- 
2.47.1


