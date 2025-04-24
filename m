Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B046C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kp5-0007q3-JP; Wed, 23 Apr 2025 20:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kn7-0005eu-2b
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmy-0004Oy-MY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso385272b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455802; x=1746060602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLjtkdVg3jxGT84stBTwdpl7UMQktBniBef0Jy8HlE4=;
 b=CHnVEVBZObq5Wy+O3h/zlmtOoov+ScVcCGh/1yLvKpipiRHW8a7j+PwHH6i2PODhzR
 g3nzroKqYRXh4tFEfAYMm1AsGsPVSWanidfIwiz8h9H7Z1FRZW1CKtGKp24zeaU7cD4T
 /9+xWx5xbu78YLHnC3BRj7SQfKa+TH08rVKcePMMhzCs7WHdRiqPsum+Yqca/7XQF98i
 uv350TSS358qf/GmJk+kADJvLXDGTV5cCdT8SawQo7iA6WOkAgrMVmdjsEux+wgWq8mM
 vqnrrYsJvyaNJNp6ilJNGFCZlaA0vthSKbCmMeI5Jd0yFBMHBfQ557+wQEGIOappb5Oi
 iiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455802; x=1746060602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLjtkdVg3jxGT84stBTwdpl7UMQktBniBef0Jy8HlE4=;
 b=JTuyf/TcBwk9UK1blsqrCVPWIOT7TsxwFcPrTRCplxFzjqFnAxF4sYelND2PMoxV9Z
 gaw6PINq8h6IX745g62M0VBULTxiC7DxBwbCWk3TEAMHSfnGlvVlptF4XEt97m/d53wD
 W7LlYCR1tEBmxo9fhPcnqvONLYIeInad83IF0jw4gl0+l8Pp7zk2uH/gxs1wL9rq69bp
 JSysRtwzSaz4aa33wkBMLgCCwF1QGNWoUkRjn6PzZnJByWpUAJDYD8atXE0WmfD+EO9W
 7xDSBm60ZZE4oxLC8CkOzX2iL6H7B0G5ggQwOqiBlYXBahBcRkQWWqVdWerZLQgK+4pJ
 2/Yw==
X-Gm-Message-State: AOJu0Yx/55TckfOt37txhdry/Fbb8cKkPCMMEetXskhhN4IwXqYclOnb
 mtjNclErC84aVbMR2TWt7Qj6mzEFGH6/C/SrikqWf2b8OXe3T1nTDl4QDPGmwJwv/VcswLMNKwm
 5
X-Gm-Gg: ASbGncsdGGmsEfhPVg/iRuw42f+p/EYU8Cry35dPVPp4cIEyIdOr2abJ90XZ/C0mrqi
 uNjuqfgH00lLtb8603e3FRD46aMXtpAvNmqOGi9zsmeXVmhSbrJ24k2V+CXi+XUKlSYC2HWACeX
 XXQAe8r8uvQSsNPXLq61Z/TWLgbqf6Qvp8kGvv3VOtfcFw00dc7lhRyj0JlyzU1eszNi5C4FC66
 1XnWf/Dww6KcIul7ax8pGuLXhzFeHOKB7h1frtXmsHqhTEAP+9MV3II64RJHcaPQviZQ9J2kDZ7
 r8/cVk4Dwpew/4HJFtjvNWC+HK5xikviNAIPnOWjTSM3fkMCDDCnaeoEfJT5Tx2Ln3k30DiJW0M
 =
X-Google-Smtp-Source: AGHT+IEyBmFFFYYs8pP55izjXbFQEvpqmDuLln4mDOmyHCgwN/2o2MVpBpqhKxsF8DjdAV00FWi1bw==
X-Received: by 2002:a05:6a20:e18a:b0:201:4061:bd94 with SMTP id
 adf61e73a8af0-20444ebdf33mr828001637.19.1745455802142; 
 Wed, 23 Apr 2025 17:50:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:50:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 036/148] include/system: Move exec/ioport.h to system/ioport.h
Date: Wed, 23 Apr 2025 17:47:41 -0700
Message-ID: <20250424004934.598783-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 5300716464..4f96e9119f 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/ioport.h"
+#include "system/ioport.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
 #include "trace.h"
diff --git a/system/physmem.c b/system/physmem.c
index e61fea41b5..234e489199 100644
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
index 5d391cfaa7..9a96cc1b5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3118,7 +3118,7 @@ M: Peter Xu <peterx@redhat.com>
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


