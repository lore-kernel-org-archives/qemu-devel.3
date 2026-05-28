Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A124CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSclM-0002MS-U9; Thu, 28 May 2026 11:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wSclE-0002HE-GD
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wScl9-0007cQ-0Y
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so82285685e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982497; x=1780587297; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R47ETFkpUinfbo9RvN6bpCCw4WgWULyDux1sJeKS25E=;
 b=BODTab0tm38kdgTi4Oq9y9RZNv/f/cB7vb6Bcp5rnBchWc9yQLuJca3geFtKglg97k
 XqnywK61WBgqoF5DSATO9tXGCyauXeUGif6bVFx65lGAwaKY6ZGOplYtvuJc8NRfGcl1
 jrynXXynCYSkDyPyD/XGlv8QktchZ7m+ANM/ECPeaZhG9z6HI01u8Qh8P9mJmT4ITLuL
 YxqXnNpSbMwrgC1vE5LvtjAXMU/ih/YLKmt6oL5hATEQu5fV+ZuHSHCz/ouhlgm1OdLs
 PMuOzyVvyi0jeyQJAVtsYeejMrguOqMzmhbScQ/uxjMtbfsMpr8d8nFQryIbWznn1sOZ
 0XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982497; x=1780587297;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R47ETFkpUinfbo9RvN6bpCCw4WgWULyDux1sJeKS25E=;
 b=W4G+Yi8eXHFa30FTvalQgWUgFidqYmqTq5YzdzsbeL0PaNcCKiFps+z42OUKp3ucY/
 rXoVZdEPO7iEnHL7vNX/ko5ojWanNEnH7hG8DVdRdNQaxTjd5oFtwsW3wFtOsKRvCAXE
 cBWzThbLKosG8sl0i4bPXr+8IUjswFEKvZK6AQIEDsxXDIRFzNCNsHshxCOevJxJAtuH
 j2biXLyWMGh4ZaJxbMiq/+Rst5zcJ85czrES2Wx7vCpskw8Zg0Nd4gRbP9IRiluL9hrA
 QLcw8DNTH3vapomGLoGcFStY9lOdabJAyRO1p7FB7PrFahlzeZXi17UlBYl3w+iyHaNf
 f86g==
X-Gm-Message-State: AOJu0YyBFJE/XaM5zEpANO4ANIie8xc5OQtJMnTvjhwpUZjtv32Z0j4K
 jCDd4skg4/yZXeiBoWUqsrsJzSBEk7fAs4WGcm087MK034DEMvN41RNkftcXngMwQkA=
X-Gm-Gg: Acq92OEuAQSsoMbwDcGMkTIbme2tAe01a5prVoZvjobOLAPk54mqJ2wlYGQdOj87OOL
 7kMEVw2D1XfqtjKXggCZY+rQr9XIN2i+++RvPC27ztLdFLt1Ua25kFTd8D7i/nckpm6gxjYpPGb
 pyPmyx81eUki3RxXYQAtMmSj1AsRR84vkJ8VZkZkjgTX+Yoc9USWqakpFVPZS9tb7DKgZ4q18y0
 5n4NI3zjWvLwPukXKamMzFMbTnbcpBGLSD6t4yLF5efrkko+NN3HOlmIshHlkMKKOc15fjas0CF
 80M1MVPwZCfOyRgnmup6w+2KRTJIOTYY3g82VHXOO+b/+cjoQv3Eww1B+OVP4bJxaQjm8vdkN8f
 a8sqq+jzZ0mNK+34o76hTbxSINjKMcSUKORj4n3P5OyqnzVEmXB1P9QCq+74nvdhHcvGLosucGc
 Ua6Dd/njaBGZ5oSYnBhvIUQ14x0ZPFM9aIspFnqQ==
X-Received: by 2002:a05:600c:4510:b0:48f:e230:c3fa with SMTP id
 5b1f17b1804b1-490428ddc9fmr437822465e9.32.1779982497431; 
 Thu, 28 May 2026 08:34:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:f5a7:372a:ab8b:3c01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909298d41bsm46514785e9.11.2026.05.28.08.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:34:57 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 28 May 2026 16:34:40 +0100
Subject: [PATCH 5/5] tests/tcg/aarch64/system/gpc-test.c: Basic test for
 granule protection check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-jmac-gpc3b-v1-5-d34c46c5069f@linaro.org>
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
In-Reply-To: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32d.google.com
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

* Sets up granule protection tables
* Enables GPC and bypass windows
* Performs memory accesses in the protected region to
  check for allowed and disallowed reads.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target |  11 +-
 tests/tcg/aarch64/system/gpc-test.c       | 160 ++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 47b32968fb..d76ca52e63 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -53,7 +53,10 @@ memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 
 memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
 
-TESTS+=memory-sve
+gpc-test: gpc-test.c $(LINK_SCRIPT) altboot.o $(MINILIB_OBJS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) altboot.o
+
+TESTS+=memory-sve gpc-test
 
 # Running
 QEMU_BASE_MACHINE=-M virt -cpu max -display none
@@ -74,6 +77,12 @@ QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -
 QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
 run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
 
+# gpc tests need EL3 and RME
+QEMU_EL3_MACHINE=-machine virt,virtualization=on,secure=on,gic-version=3 -cpu max,x-rme=on
+QEMU_EL3_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="3"
+run-gpc-test:  QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
+run-gpc3-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
+
 # Simple Record/Replay Test
 .PHONY: memory-record
 run-memory-record: memory-record memory
diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
new file mode 100644
index 0000000000..06b25d2787
--- /dev/null
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <minilib.h>
+#include "boot.h"
+
+#define ID_AA64PFR0_EL1 "S3_0_C0_C4_0"
+
+#define GPTBR_EL3 "S3_6_C2_C1_4"
+#define GPCBW_EL3 "S3_6_C2_C1_5"
+#define GPCCR_EL3 "S3_6_C2_C1_6"
+#define VBAR_EL3 "S3_6_C12_C0_0"
+
+#define get_sys_reg(register_name, dest) \
+        asm("mrs %[reg], " register_name "\n\t" : [reg] "=r" (dest))
+#define set_sys_reg(register_name, value) \
+        asm("msr " register_name ", %[reg]\n\r" : : [reg] "r" (value))
+
+const uint32_t gpc_granule_size = 4096;
+const uint32_t gpis_per_64_bits = 16;
+
+int main(uint64_t sp)
+{
+    uint64_t out;
+    uint64_t pfr0;
+    uint64_t gpt_base;
+    uint64_t rme_status;
+    uint64_t currentel_raw;
+    uint64_t currentel;
+    uint64_t gpcbw;
+    uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
+    uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
+
+    /* Mask is FNG1, FNG0, and A2 */
+    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
+    const uint64_t in = feature_mask;
+
+    get_sys_reg("CurrentEL", currentel_raw);
+    currentel = (currentel_raw >> 2) & 0x3;
+
+    if (currentel < 3) {
+        ml_printf("FAIL: Test must be run at EL3 (it is %d)\n", currentel);
+        return 1;
+    }
+
+    get_sys_reg(ID_AA64PFR0_EL1, pfr0);
+
+    /* rme_status is 1 for RME, 2 for RME + GPC2, 3 for RME+GPC3 */
+    rme_status = (pfr0 >> 52) & 0xF;
+    ml_printf("RME is %ld\n", rme_status);
+    if (rme_status < 1) {
+        ml_printf("SKIP: System does not support GPC (RME=%ld)\n", rme_status);
+        return 0;
+    }
+
+    /* Configure the level 0 table for the first 4GB of memory */
+    realms_gpt0[0] = gpt_table1_addr | 0x3; /* Covers GB 0; table descriptor */
+    realms_gpt0[1] = 0xf1; /* Covers GB 1; full access */
+    realms_gpt0[2] = 0xf1; /* Covers GB 2; full access */
+    realms_gpt0[3] = 0xf1; /* Covers GB 3; full access */
+
+    /* Pick a random location to read inside the first 1GB. */
+    uint64_t fault_location = 0x10202008;
+    uint32_t gpi_index = fault_location / gpc_granule_size;
+    realms_gpt1[gpi_index / gpis_per_64_bits] = 0;
+
+    gpt_base = gpt_table0_addr >> 12;
+    set_sys_reg(GPTBR_EL3, gpt_base);
+
+    /*
+     * Default values:
+     * PPS=0:     GPC table 0 protects 4GB.
+     * RLPAD=0:   Realm physical address spaces are normal
+     * NSPAD=0:   Non-secure physical address spaces are normal
+     * SPAD=0:    Secure physical address spaces are normal
+     * IRGN=0:    Inner non-cacheable
+     * ORGN=0:    Outer non-cacheable
+     * PGS=0:     Physical granule size is 4KB.
+     * GPCP=0:    All GPC faults reported
+     * TBGPCP=0:  Trace buffer rejects trace
+     * L0GPTSZ=0: Each entry in table 0 protects 1GB.
+     * APPSAA=0:  Accesses above 4GB must be to Non-secure PAs
+     * GPCBW=0:   Bypass windows disabled.
+     * NA6, NA7, NSP, SA, NSO are all reserved values for GPI.
+     */
+    uint64_t gpccr = 0;
+
+    /* Switch on granule protection check */
+    gpccr |= 1 << 16; /* GPC enabled. */
+    gpccr |= 0b10 << 12; /* SH = Outer shareable */
+    set_sys_reg(GPCCR_EL3, gpccr);
+
+    /* Access some memory outside the GPC forbidden region */
+    uint64_t x = *(unsigned int *) (fault_location + 4096 * 16);
+    ml_printf("Fault address: %lx\n", exception_fault_address);
+    if (exception_fault_address != 0) {
+        ml_printf("FAIL: Memory access was blocked by GPC, "
+                  "and should not have been\n");
+        return 1;
+    }
+
+    /* Access the GPC forbidden region */
+    x = *(unsigned int *) fault_location;
+
+    ml_printf("Fault address: %lx\n", exception_fault_address);
+    if (exception_fault_address != fault_location) {
+        ml_printf("FAIL: Memory access was not blocked by GPC, "
+                  "and should have been\n");
+        return 1;
+    }
+
+    /* Clear the exception record */
+    exception_fault_address = 0;
+
+    /* Enable bypass windows */
+    gpccr |= 1 << 29; /* GPC Bypass windows enabled */
+    set_sys_reg(GPCCR_EL3, gpccr);
+
+    gpcbw = 0; /* Base 0GB, Size 1GB, Stride 1TB */
+    set_sys_reg(GPCBW_EL3, gpcbw);
+    ml_printf("GPCBW configured\n");
+
+    /* Access the GPC forbidden region again */
+    x = *(unsigned int *) fault_location;
+
+    ml_printf("Fault address: %lx\n", exception_fault_address);
+    if (exception_fault_address != 0) {
+        ml_printf("FAIL: [3] Memory access was blocked by GPC, "
+                  "and should have been allowed by bypass window. code=%lx\n",
+                  exception_type_code);
+        return 1;
+    }
+
+    /* Clear the exception record */
+    exception_fault_address = 0;
+    /* Reconfigure GPCBW to 1GB start */
+    gpcbw = 1; /* Base 1GB, Size 1GB, Stride 1TB */
+    set_sys_reg(GPCBW_EL3, gpcbw);
+    ml_printf("GPCBW reconfigured for 1GB start\n");
+
+    /* Access the GPC forbidden region again */
+    x = *(unsigned int *) fault_location;
+
+    ml_printf("Fault address: %lx\n", exception_fault_address);
+    if (exception_fault_address != fault_location) {
+        ml_printf("FAIL: [4] Memory access was allowed by GPC, "
+                  "and should not have been allowed by bypass window. log=%lx\n",
+                  exception_type_code);
+        return 1;
+    }
+
+    return 0;
+}

-- 
2.43.0


