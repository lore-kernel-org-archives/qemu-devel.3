Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C62C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW2-0004dY-5I; Wed, 12 Mar 2025 23:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVz-0004bR-5s
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVt-0007ma-Tn
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2255003f4c6so9403415ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837539; x=1742442339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9rWucwh9z67Kr9MnN83qBMGuAsfQno38cRmjhXBoaI=;
 b=oCFy1vs6jn1x8rE3dRQMOiCv8JykVYMaQ6vMPyW0TDELiiwhj9V2gWkRlIF/gtb3QB
 D+D9qy7KW7Ozx8YLr+8JX8u0Fr9cwqD/REsJJO5qU6c8R3rVFLF6k4fwqqY/JAJTZKRU
 FmY61Mkn1AwR1F+rW/KwERU+pESmozmnFmctVI0uP/KnMiMgsoHfu/aMBb09ykSFK5/1
 dRQy2Wm/mfLquH3pp3PcykjVTDJWfa3bvIs2UCFY2dTtv3VfqyoBCFU/wTyuIh9YHJPf
 FeT+b8cC1Z02gh4gas9+JbYkmXm20TL351G96vt1YqwbvzRGMGFTJ6In9wrcmOmY/LJC
 TQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837539; x=1742442339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m9rWucwh9z67Kr9MnN83qBMGuAsfQno38cRmjhXBoaI=;
 b=Lmk8Yp+x4JCZpryD9DdHMoRdHIVb4OlmGfpLbENznCLR5xnUPOPgfLlg28x3xB0pe+
 eotXa0A7voI3YFv9SFOtByE8oJ4ZIIBCsBuWOaZQWTXGoaS+AfEAMP/M5BWdEbeDGp9w
 b7KmftKR1/nc62yWwZP7lDmzcx+NO6kQsAish4350YvRqlnFOaO6wMd/BoBdRKGqfFcd
 wEpgzjvBpZM6ZDniDTPzVpD72EohakWPray1C7whJPKECTO9Acly5GbQIoju4GJey4xi
 DQLi9s6lhYPIbTfg8oznJiCeiyZqlQWCCBGdtt32/Wdmo13MMj2WVdcP93Ns46DTKR/9
 KUXA==
X-Gm-Message-State: AOJu0YxyuIXXBl/kXKYFa2kVx90vy/ZwZUAWNcFm4xjDNKRcMMz+ekU+
 JeutQUEUl/GLJvYgn9x6bUu6s40CtzRZvnhLmeWCTR/5mixsd6aaTEfyoEdLSiVpWP1/1C9MR4X
 6
X-Gm-Gg: ASbGncvIHwk8xCLG8fviJofHaYWzOyZam3yX0692Ep0xwwVd/ie251ybyhVLB3Fx5mg
 N3mOIpkBkqwtCz/JrRHCupczEvlv6sAGTq8zYTTxV61rqS76uL2NSs9x+tx8EY9V4DXQq+C9S97
 HZl374X5Tap/fVwbkVsCkg3Nhpos6dkYCm+ZLTnih82+Zy3BPL1T5ZWYRrLv3EsfafLe1vnzZJi
 WIMVDKCskNBdm2we84FBOeckjsFdF1vO2xIfWFx2hYMNMjMVNJIQpk3nCxIBniEqn7ITrwskC/+
 zUweBGWmD0QKy33p1qp298rxIz5ZenmDvGGtkh2tmMjok8ZjJ8+ZGyJI4sl/0tPs1Kzt0vbeeZ7
 K
X-Google-Smtp-Source: AGHT+IEXgNJ931p8iIitkzZbpeVZELHucz5lfkYsIOzSVp/I1X4f8wp9b+lfcU7PT3WeG2AUrcloaw==
X-Received: by 2002:a05:6a00:88f:b0:736:7270:4d18 with SMTP id
 d2e1a72fcca58-736eb7efd4amr12373658b3a.14.1741837539158; 
 Wed, 12 Mar 2025 20:45:39 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 16/37] include/system: Move exec/ioport.h to system/ioport.h
Date: Wed, 12 Mar 2025 20:44:56 -0700
Message-ID: <20250313034524.3069690-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Convert the existing includes with sed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/display/vga_int.h              | 2 +-
 include/hw/char/parallel-isa.h    | 2 +-
 include/hw/dma/i8257.h            | 2 +-
 include/hw/ide/ide-bus.h          | 2 +-
 include/hw/isa/isa.h              | 2 +-
 include/{exec => system}/ioport.h | 6 ++----
 hw/block/fdc-isa.c                | 2 +-
 monitor/hmp-cmds.c                | 2 +-
 system/ioport.c                   | 2 +-
 system/physmem.c                  | 2 +-
 system/qtest.c                    | 2 +-
 target/i386/nvmm/nvmm-all.c       | 2 +-
 target/i386/whpx/whpx-all.c       | 2 +-
 tests/qtest/fuzz/qtest_wrappers.c | 2 +-
 MAINTAINERS                       | 2 +-
 15 files changed, 16 insertions(+), 18 deletions(-)
 rename include/{exec => system}/ioport.h (97%)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 60ad26e03e..747b5cc6cf 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -26,7 +26,7 @@
 #define HW_VGA_INT_H
 
 #include "ui/console.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "system/memory.h"
 
 #include "hw/display/bochs-vbe.h"
diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
index 5284b2ffec..3edaf9dbe4 100644
--- a/include/hw/char/parallel-isa.h
+++ b/include/hw/char/parallel-isa.h
@@ -12,7 +12,7 @@
 
 #include "parallel.h"
 
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
 
diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index 4342e4a91e..33b6286d5a 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -2,7 +2,7 @@
 #define HW_I8257_H
 
 #include "hw/isa/isa.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "qom/object.h"
 
 #define TYPE_I8257 "i8257"
diff --git a/include/hw/ide/ide-bus.h b/include/hw/ide/ide-bus.h
index 4841a7dcd6..121b455fcd 100644
--- a/include/hw/ide/ide-bus.h
+++ b/include/hw/ide/ide-bus.h
@@ -1,7 +1,7 @@
 #ifndef HW_IDE_BUS_H
 #define HW_IDE_BUS_H
 
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "hw/ide/ide-dev.h"
 #include "hw/ide/ide-dma.h"
 
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 1d852011b3..a82c5f1004 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -4,7 +4,7 @@
 /* ISA bus */
 
 #include "system/memory.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
diff --git a/include/exec/ioport.h b/include/system/ioport.h
similarity index 97%
rename from include/exec/ioport.h
rename to include/system/ioport.h
index ecea3575bc..780ea5a676 100644
--- a/include/exec/ioport.h
+++ b/include/system/ioport.h
@@ -21,8 +21,8 @@
  * IO ports API
  */
 
-#ifndef IOPORT_H
-#define IOPORT_H
+#ifndef SYSTEM_IOPORT_H
+#define SYSTEM_IOPORT_H
 
 #include "system/memory.h"
 
@@ -39,9 +39,7 @@ typedef struct MemoryRegionPortio {
 
 #define PORTIO_END_OF_LIST() { }
 
-#ifndef CONFIG_USER_ONLY
 extern const MemoryRegionOps unassigned_io_ops;
-#endif
 
 void cpu_outb(uint32_t addr, uint8_t val);
 void cpu_outw(uint32_t addr, uint16_t val);
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index a10c24aab1..561cfa47c1 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -42,7 +42,7 @@
 #include "system/block-backend.h"
 #include "system/blockdev.h"
 #include "system/system.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 8ddcdd76c1..74a0f56566 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "system/address-spaces.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/enums.h"
 #include "monitor/hmp.h"
diff --git a/system/ioport.c b/system/ioport.c
index 2bc14bdcfa..ec5c586cf8 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
 #include "trace.h"
diff --git a/system/physmem.c b/system/physmem.c
index be92969a4a..2850e14780 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -51,7 +51,7 @@
 #include "qemu/memalign.h"
 #include "qemu/memfd.h"
 #include "system/memory.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "system/dma.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
diff --git a/system/qtest.c b/system/qtest.c
index 5407289154..523a047995 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -16,7 +16,7 @@
 #include "system/qtest.h"
 #include "system/runstate.h"
 #include "chardev/char-fe.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "system/memory.h"
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 91f0e32366..17394d073d 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "system/address-spaces.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "qemu/accel.h"
 #include "system/nvmm.h"
 #include "system/cpus.h"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d58cb11cee..b64852e13e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "system/address-spaces.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "gdbstub/helpers.h"
 #include "qemu/accel.h"
 #include "system/whpx.h"
diff --git a/tests/qtest/fuzz/qtest_wrappers.c b/tests/qtest/fuzz/qtest_wrappers.c
index 0580f8df86..d7adcbe3fd 100644
--- a/tests/qtest/fuzz/qtest_wrappers.c
+++ b/tests/qtest/fuzz/qtest_wrappers.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/cpu.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 
 #include "fuzz.h"
 
diff --git a/MAINTAINERS b/MAINTAINERS
index b5f1e81771..751d611613 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3107,7 +3107,7 @@ M: Peter Xu <peterx@redhat.com>
 M: David Hildenbrand <david@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
-F: include/exec/ioport.h
+F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/memory.h
 F: include/exec/ram_addr.h
-- 
2.43.0


