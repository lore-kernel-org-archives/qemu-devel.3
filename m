Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0F1C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hz-0000Wt-Dq; Wed, 02 Apr 2025 17:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HP-0006h8-Lt
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HL-0006XF-Qp
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso1421275e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627942; x=1744232742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Gb1GaYZmsu1RdbSY9Ixqzg56VogQUZiis5J/e8e3jk=;
 b=WN1EILQsNpMjXxtZKZN1xgw2uzUTcbSkOvJpYlScapGSlGL0LpZB+xwX0FTWRjBn+4
 oqvER/HBRyRvDlLKgiK2EKOrvhktuLD+65RuF0dMWA8UnEjbk7qjAA+kp+4NH1ehfMMc
 CuMQ4WjbyM3ExfuNoPFeTm3PkdzWAb2iGcD1mHCur9ubXPDEjnZS5HP6H1GKMK2Fi5vS
 fDx4E48w1ASuq6p1c2rVG+c/+2eDmSyOGEHZ+QNDrC2HQOrkVL3BZf7B+PmCMeXoEyFl
 jTcZST1iGwiVGnFSyQWA9jI03yTn3nFvSTKNcrrg5wh6juAsoe0uA1287ASbFBFhfdmy
 pISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627942; x=1744232742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Gb1GaYZmsu1RdbSY9Ixqzg56VogQUZiis5J/e8e3jk=;
 b=a1Wu4OW49rkh4KirBHo2WrCAs/boF92XagoVBzBxYHGyMsqPJSHlUkhakXxRg2pHIg
 NME2X0iy4sAU6nUBWs2uPxeq6gTbqFSKuPhot8I2NYrA7Wv927GMlpS47GcUgpLl6+PV
 +PEnXX2/MQYyauyofOJoJVUPr74p/Ru1pTL8NUJG7y3VBkowtMHRDZBdmxdd5g7Gg+t+
 OStGCr6Baqx/pQDf/HgVj0XG8gqnSm7ZYtCbkmEiDZUiMzs4O41sbs6Cm/+Nbw8YGwwj
 bPIk8Ti/U7Qixgf1aqhQnAUj2jh5L5BdbDO89hQbOJie9Mye04EDZvsqlJbj5f6YP91f
 Eq+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqIsbjSy1g4NFz0TlAfQlThVJ17uDptcwjHs4yRuWdiBUJMpK064fg0zhPNt/CmnTOV7LrchbCo7ML@nongnu.org
X-Gm-Message-State: AOJu0YzKbv9QpETrzsMapXIaGA43sgkPi/n8nqCKKhWydK2Nb270ByRT
 yKW/LewXnCD7XLs93QyhBDK9DYJB2iiV76Mas/qEy3B2fPwpyS2YZLnrKkV3r43e878aYV3XSZb
 q
X-Gm-Gg: ASbGncstUqduMq+8QbYqQRXgIIs7wLRr9mhAAdqEqmR7pqOWvSWQ0Qwk/+5gJBZZGl1
 X6nwMHZvVsUO2piW6h51fiqv4dqOblSRwpXKt7kC2d/EQZ3p0YwIp/e38dP6z0sJjCs5RVACkuf
 pXOvvbeSbHVgL+v1nvAc5h+HOOL7ZrYkzphEkORffw14AHhJzcSoro89AhgiR9r9J4oi0ICOxrO
 Ez5bgkvN6hMaLO986AO7osj8mhGHGgiIeKLz5zjBavR5Yg5PDwiIGMH3xiGt/S+1l6kU1CcliE+
 tV7UBbGqQ5TKA5M7K99DqgDydkL5iN28WSOCPuXldhnGfdquJL4bXKE/JY0RGaUmuy7hjYWIDTq
 dfo49paPckIeR010VRZw=
X-Google-Smtp-Source: AGHT+IEIwbm0Ab3BegNusN1W1ee7bDB23SGAGSD2lgHrMA2yXSh8fhpYp4E3gkPM4WufRqrjBTdQQQ==
X-Received: by 2002:a05:600c:1d1a:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-43ec14e7168mr1534625e9.33.1743627942352; 
 Wed, 02 Apr 2025 14:05:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663060sm2100155e9.14.2025.04.02.14.05.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 27/43] exec: Restrict cpu-mmu-index.h to accel/tcg/
Date: Wed,  2 Apr 2025 23:03:12 +0200
Message-ID: <20250402210328.52897-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


