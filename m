Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484E6C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXST-0008Jx-Sd; Thu, 18 Apr 2024 15:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQg-0002eb-RA
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:19 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQe-0007kE-R1
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:18 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56fe7dc7f58so1268271a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468495; x=1714073295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdGtqepmHp/hs0/Z1yrPy9JbSuxwne+2qc6kJd/9zb0=;
 b=aYkuFhDxu0z/m0eHlNwToFwvxtSqdEXlxcHuIiK5otrmQjPGhTtAn5uj/VhCGOoAFd
 0b1F7y7r8gYIAf6mr+WvgPr/NlzXWNuy30NsHxh/VyzrROg1smcjh8cd3MqKzRn1VPe0
 LPExxJsgnvhtuKyGlhz1CfRgSXERxp//6YB93ZNdp+Xjo7CTDAceu16R/VPs7o+XLAI3
 BRTgxNlUfsh87FpY5C6dgv8ScTAchndt4Hz5/HbakoIRSVIoDhCCqS6sAhhF/9BXGVsn
 +dnEQaeL4m0IcuMH5dPuItZcLQjkYhF2EyRTqUHN0kH797Z/RWTxsDkU8c5wiosKFZ/7
 0+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468495; x=1714073295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZdGtqepmHp/hs0/Z1yrPy9JbSuxwne+2qc6kJd/9zb0=;
 b=SBLnVCnW0TsLDqo4wQNsBclIyRSmYvFe3/Mz/PHk0z2cVYo6l7LIXosi67TQWJZRx1
 PFbZP1CEkeYjjWHzVmBYXUbf12ATpzJvgVGBUwZ5nKkniFNDgm0pHzVim6WurQ2fSbdL
 Jz1dwkHpL4kzCZflPIBFfBF6ewzKrYO4Nie6CCo5AN/cA70NNADbAjx8nTkeZ2wmkMfy
 JegO5yMu4/egQfPBxbbhbAc9bJAQXj+IVDz/4B0Tb9J8aXSenbc90hMxTfnhzDrZjQJI
 SCEJAyOaCfWCIbAoWlauumddcG4lZSP+rNmlFPt0kmDtpGRBYT3H42nLdDzoaRtbGcPW
 SQAA==
X-Gm-Message-State: AOJu0Ywle3Lt1lhnw21GI8yYvDsTUTlX61QOVUDiu77CsGUFsWL4baXP
 LgE1aVtm1HhZzsU06Ve7xTK7IgM4Qpc4aEsNnQrC/Xw4Wpet4yLALm6LbejvOqHEzBz9P4OnuMX
 8
X-Google-Smtp-Source: AGHT+IFOIY5gAThTWZwjM0+HF7s5tNrh3iGimgDUj1yFPdFdyFFdGwZS1SuNu7kuksfDMB5GlMY4Wg==
X-Received: by 2002:a17:906:f0d9:b0:a51:b666:b372 with SMTP id
 dk25-20020a170906f0d900b00a51b666b372mr61046ejb.27.1713468495043; 
 Thu, 18 Apr 2024 12:28:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 jp4-20020a170906f74400b00a4734125fd2sm1265134ejb.31.2024.04.18.12.28.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:28:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 22/24] exec: Remove 'exec/tswap.h' from 'exec/cpu-all.h'
Date: Thu, 18 Apr 2024 21:25:21 +0200
Message-ID: <20240418192525.97451-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

"exec/cpu-all.h" doesn't require "exec/tswap.h". Remove it,
including it in the sources when required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/bootparam.h       | 1 +
 include/exec/cpu-all.h      | 1 -
 accel/tcg/translator.c      | 1 +
 hw/arm/boot.c               | 1 +
 hw/arm/npcm7xx.c            | 1 +
 hw/mips/fuloong2e.c         | 1 +
 hw/mips/malta.c             | 1 +
 hw/ppc/sam460ex.c           | 1 +
 hw/ppc/spapr.c              | 1 +
 hw/ppc/virtex_ml507.c       | 1 +
 hw/sh4/r2d.c                | 1 +
 target/arm/gdbstub.c        | 1 +
 target/xtensa/xtensa-semi.c | 1 +
 13 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
index f57ff850bc..e1d47b503c 100644
--- a/hw/xtensa/bootparam.h
+++ b/hw/xtensa/bootparam.h
@@ -1,6 +1,7 @@
 #ifndef HW_XTENSA_BOOTPARAM_H
 #define HW_XTENSA_BOOTPARAM_H
 
+#include "exec/tswap.h"
 #include "exec/cpu-common.h"
 
 #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 554b937ddb..cfbf51822c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,7 +21,6 @@
 
 #include "exec/cpu-common.h"
 #include "exec/memory.h"
-#include "exec/tswap.h"
 #include "hw/core/cpu.h"
 
 /* some important defines:
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 6832e55135..85950377d9 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
+#include "exec/tswap.h"
 #include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 84ea6a807a..93945a1a15 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -22,6 +22,7 @@
 #include "sysemu/reset.h"
 #include "hw/loader.h"
 #include "elf.h"
+#include "exec/tswap.h"
 #include "sysemu/device_tree.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index cc68b5d8f1..1ef303415b 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -27,6 +27,7 @@
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"
 #include "target/arm/cpu-qom.h"
+#include "exec/tswap.h"
 
 /*
  * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index a45aac368c..1d0613a76f 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -40,6 +40,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "exec/tswap.h"
 
 #define ENVP_PADDR              0x2000
 #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index af74008c82..3dca0f100c 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -56,6 +56,7 @@
 #include "semihosting/semihost.h"
 #include "hw/mips/cps.h"
 #include "hw/qdev-clock.h"
+#include "exec/tswap.h"
 #include "target/mips/internal.h"
 #include "trace.h"
 #include "cpu.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index d42b677898..abc02f0817 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -24,6 +24,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "exec/memory.h"
+#include "exec/tswap.h"
 #include "ppc440.h"
 #include "hw/pci-host/ppc4xx.h"
 #include "hw/block/flash.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e9bc97fee0..b4b1f43983 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -74,6 +74,7 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost-scsi-common.h"
 
+#include "exec/tswap.h"
 #include "exec/ram_addr.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index d02f330650..fd23afebf5 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -38,6 +38,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "exec/tswap.h"
 
 #include "hw/intc/ppc-uic.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e5ac6751bd..5f4420f534 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -43,6 +43,7 @@
 #include "hw/loader.h"
 #include "hw/usb.h"
 #include "hw/block/flash.h"
+#include "exec/tswap.h"
 
 #define FLASH_BASE 0x00000000
 #define FLASH_SIZE (16 * MiB)
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index a3bb73cfa7..f2b001afdd 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
+#include "exec/tswap.h"
 #include "gdbstub/helpers.h"
 #include "sysemu/tcg.h"
 #include "internals.h"
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index fa21b7e11f..dbc42d1587 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #include "chardev/char-fe.h"
 #include "exec/helper-proto.h"
+#include "exec/tswap.h"
 #include "semihosting/semihost.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-- 
2.41.0


