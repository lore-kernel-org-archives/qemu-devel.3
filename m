Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EFACCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWPb-0005n4-35; Thu, 15 Oct 2026 21:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNk-0002FM-Rs
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNh-0004e6-UD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e831e86ebfso15719645ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112709; x=1792717509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lf+jb6VogAWfUE1O1lmhO4WbMHdXBmkstdbWnLc1Sc0=;
 b=gfqr1ACFxKf0oKcDTulva+iciZbVwTaswvYR4yC9UQ4xnchzLqIYzqvwOBeW+XsZC/
 D8ms2uSsPfOK3j9oGDwqJLFWpxdSXLeClzdtFkowKUFn+6/YuZ6G8nj5liTM629q1PuX
 Fw7pnuEtdfEorCUj4acgbVPcGSCrQ/TzfaxahondcYNT3lmr4kMlwPBwYJ4VFJIPH2Zs
 t13TrMv4SYGtmC/vIaUm2MBQfyzljCMwT5HGymdiGkcV/lQCBjpeo3n4ZOxsMfNR/2Qa
 YHU6Skxvhtdq/qClmCVOthWl7pdX/yvuoz17ffZi6m9Q1QKeSZrkz0cw32FfZfO5FMzu
 131w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112709; x=1792717509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lf+jb6VogAWfUE1O1lmhO4WbMHdXBmkstdbWnLc1Sc0=;
 b=H3aFWhf05pAtPwtQGp5cPTozTEYfxUwTB0atO+A3egxgX5POhaKJ2xp/01+33HA+Ct
 FdakVCajE9yn4z8yuimWI2Kxt3BvLUmtkRm7FOrvEdqlSCaY8D/JgC8SrkCJYS+iNZBP
 ijSQAGbQY6CEqPn4XjX2JZtXIhLyEOymcv96Ut6duZVuovh91hCkb621QHwqajxjgDm3
 4u8AqafQASvjK7XYAVxhu602L0Dhk+ylEIhaljAO/gJ5Uf9tZX2aUoy2YIv7cqs50Hjj
 l2purzFE9tq+QuPY8FPKqauTL+Pv6+iLfv9tWicKeX4U2HBakjMhtptr5J6LC9ZDQbWh
 1UPw==
X-Gm-Message-State: AFq9FYLq0P6XH4X2Pn+iPiioesJMyba9cs84IOM+efog43PXNAJxbACH
 soxX398spKZQ0/OlV0hcuHNPCPdoJZ8YQPggvL8UYMhs0cskP860e7X2QTYJTA==
X-Gm-Gg: AYBFou13esQP1HpAM+pp1TteUHtD1gKMLjKWWvLO1ne/L3hI6JUrpmsTy2YVFQ8yOAT
 RQWb8JK78otTan3wTXvCHPBqWmfpuek6rX/hemB97cakNFYje5dDI/OGCTj1vn5F4C6qNYCdJTu
 WDZcXcZEak0cCkCKFCXdiFiazXVxqtDMs0HAUlFWy7zjDWIyzG+CDmaC9lpCIFlqjEpRKRuLv4v
 LP6LWcnqfwz4IQdPX5nxj3YZR0HxwDcU57Lx7awrAR5q00An8S4umNIVEucv8O3AQnkcDIyRb91
 N96IfpgYMqdTjS7Mrp1KCiD118Zh0V57oxC/HdeoAlZ2wzZeFU4TFrKsGL8AZ0aB8JCu9OYxtFM
 B7IMCni8L2wRHPwt4XX8UQHN9tULZPjKdW0QWQ7anMD2gOS8ASB6Urn8Ybtd8pLM34q4JwFGPlV
 UJyJ+ACBoL3pjn6jqcFxUsRc2yXeWqARcWCjDek8Zobq0qtBEM7weFXENLZV1AJ71hO0dYrYOCb
 z8EKFTqYL7M6kQl
X-Received: by 2002:a17:903:903:b0:2df:8b09:93bb with SMTP id
 d9443c01a7336-2e842aaca0emr169150605ad.10.1792112708522; 
 Thu, 15 Oct 2026 18:05:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:05:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 48/50] target/riscv: fix RV32 fixed counter accesses
Date: Fri, 16 Oct 2026 11:02:35 +1000
Message-ID: <20261016010237.1102834-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Zephyr Li <fritchleybohrer@gmail.com>

Since commit cfc96df65e01, riscv_pmu_ctr_get_fixed_counters_val()
returns the complete 64-bit fixed-counter value. The RV32 counter
access paths, however, still perform parts of the offset calculation
on separately extracted 32-bit halves.

In particular, riscv_pmu_write_ctrh() deposits the low 32 bits of the
complete fixed-counter value into the high half of mhpmcounter_prev.
riscv_pmu_read_ctr() also subtracts a 32-bit half of the previous value
from the complete 64-bit fixed-counter value. Consequently, writes to
mcycleh can be lost and carries between the low and high halves are not
handled correctly.

Keep the fixed-counter offset calculation entirely in 64 bits. Before
a running counter is partially written, materialize its current
architectural value and reset the fixed-counter baseline. On reads,
calculate the complete 64-bit counter value before extracting the half
requested by RV32.

Register RV32 system TCG tests with the Meson build. Add a test for
high-half writes, low-to-high carry, and preserving the carried high
half across a subsequent low-half write.

Fixes: cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4219
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20261008035150.2223-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                          |  1 +
 target/riscv/tcg/csr.c               | 32 ++++++++++----------
 meson_options.txt                    |  4 +++
 scripts/meson-buildoptions.sh        |  2 ++
 tests/tcg/meson.build                |  1 +
 tests/tcg/riscv32/meson.build        |  6 ++++
 tests/tcg/riscv32/semihost.ld        | 23 ++++++++++++++
 tests/tcg/riscv32/system/meson.build | 36 ++++++++++++++++++++++
 tests/tcg/riscv32/test-mcycle.S      | 45 ++++++++++++++++++++++++++++
 9 files changed, 135 insertions(+), 15 deletions(-)
 create mode 100644 tests/tcg/riscv32/meson.build
 create mode 100644 tests/tcg/riscv32/semihost.ld
 create mode 100644 tests/tcg/riscv32/system/meson.build
 create mode 100644 tests/tcg/riscv32/test-mcycle.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 0455e8e6b9..b3ed343e17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -377,6 +377,7 @@ F: include/hw/riscv/
 F: common-user/host/riscv*
 F: tests/functional/riscv32
 F: tests/functional/riscv64
+F: tests/tcg/riscv32/
 F: tests/tcg/riscv64/
 F: tests/qtest/iommu-riscv-test.c
 
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 2ad66239ae..64be8ca309 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1340,23 +1340,23 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
     int deposit_size = rv32 ? 32 : 64;
     uint64_t ctr;
 
-    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                         0, deposit_size, val);
-
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                              0, deposit_size, ctr);
+        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             0, deposit_size, val);
+        counter->mhpmcounter_prev = ctr;
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
      } else {
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             0, deposit_size, val);
         /* Other counters can keep incrementing from the given value */
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               0, deposit_size, val);
-
     }
 
     return RISCV_EXCP_NONE;
@@ -1366,20 +1366,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t ctrh;
+    uint64_t ctr;
 
-    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                         32, 32, val);
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                              32, 32, ctrh);
+        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
+        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             32, 32, val);
+        counter->mhpmcounter_prev = ctr;
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
     } else {
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             32, 32, val);
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               32, 32, val);
     }
@@ -1410,12 +1412,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
     int start = upper_half ? 32 : 0;
     int length = rv32 ? 32 : 64;
-    uint64_t ctr_prev, ctr_val;
+    uint64_t ctr_val;
 
     /* Ensure upper_half is only set for XLEN == 32 */
     g_assert(rv32 || !upper_half);
 
-    ctr_prev = extract64(counter->mhpmcounter_prev, start, length);
     ctr_val  = extract64(counter->mhpmcounter_val, start, length);
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
@@ -1434,7 +1435,8 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
         uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
-                                                             ctr_prev + ctr_val;
+                        counter->mhpmcounter_prev +
+                        counter->mhpmcounter_val;
         *val = extract64(cntr, start, length);
     } else {
         *val = ctr_val;
diff --git a/meson_options.txt b/meson_options.txt
index c9247e9de1..895c6e63c2 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -473,6 +473,10 @@ option('tcg_tests_cross_cc_ppc64le', type: 'string',
        description: 'cc for ppc64le tcg tests')
 option('tcg_tests_cross_cflags_ppc64le', type: 'string',
        description: 'cflags for ppc64le tcg tests')
+option('tcg_tests_cross_cc_riscv32', type: 'string',
+       description: 'cc for riscv32 tcg tests')
+option('tcg_tests_cross_cflags_riscv32', type: 'string',
+       description: 'cflags for riscv32 tcg tests')
 option('tcg_tests_cross_cc_riscv64', type: 'string',
        description: 'cc for riscv64 tcg tests')
 option('tcg_tests_cross_cflags_riscv64', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 064e1429a4..14990966d3 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -547,6 +547,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
     --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
     --tcg-tests-cross-cc-ppc64le=*) quote_sh "-Dtcg_tests_cross_cc_ppc64le=$2" ;;
+    --tcg-tests-cross-cc-riscv32=*) quote_sh "-Dtcg_tests_cross_cc_riscv32=$2" ;;
     --tcg-tests-cross-cc-riscv64=*) quote_sh "-Dtcg_tests_cross_cc_riscv64=$2" ;;
     --tcg-tests-cross-cc-s390x=*) quote_sh "-Dtcg_tests_cross_cc_s390x=$2" ;;
     --tcg-tests-cross-cc-sh4=*) quote_sh "-Dtcg_tests_cross_cc_sh4=$2" ;;
@@ -573,6 +574,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
     --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
     --tcg-tests-cross-cflags-ppc64le=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64le=$2" ;;
+    --tcg-tests-cross-cflags-riscv32=*) quote_sh "-Dtcg_tests_cross_cflags_riscv32=$2" ;;
     --tcg-tests-cross-cflags-riscv64=*) quote_sh "-Dtcg_tests_cross_cflags_riscv64=$2" ;;
     --tcg-tests-cross-cflags-s390x=*) quote_sh "-Dtcg_tests_cross_cflags_s390x=$2" ;;
     --tcg-tests-cross-cflags-sh4=*) quote_sh "-Dtcg_tests_cross_cflags_sh4=$2" ;;
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4c0e30756d..184edcdbbc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -186,6 +186,7 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
+subdir('riscv32')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
diff --git a/tests/tcg/riscv32/meson.build b/tests/tcg/riscv32/meson.build
new file mode 100644
index 0000000000..862f1349c2
--- /dev/null
+++ b/tests/tcg/riscv32/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+cc = 'riscv64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+
+subdir('system')
diff --git a/tests/tcg/riscv32/semihost.ld b/tests/tcg/riscv32/semihost.ld
new file mode 100644
index 0000000000..874838a865
--- /dev/null
+++ b/tests/tcg/riscv32/semihost.ld
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+ENTRY(_start)
+
+SECTIONS
+{
+    /* virt machine, RAM starts at 2gb */
+    . = 0x80000000;
+    .text : {
+        *(.text)
+    }
+    .rodata : {
+        *(.rodata)
+    }
+    /* align r/w section to next 2mb */
+    . = ALIGN(1 << 21);
+    .data : {
+        *(.data)
+    }
+    .bss : {
+        *(.bss)
+    }
+}
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
new file mode 100644
index 0000000000..f8e55ad3d4
--- /dev/null
+++ b/tests/tcg/riscv32/system/meson.build
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests = []
+
+link_script = files('../semihost.ld')[0]
+cflags = ['-march=rv32im_zicsr',
+          '-mabi=ilp32',
+          '-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-Wl,-T', link_script]
+qemu_args = ['-M', 'virt',
+             '-display', 'none',
+             '-serial', 'stdio',
+             '-semihosting',
+             '-bios']
+
+tests += {
+  'test-mcycle.S': {
+    'cflags': cflags,
+    'qemu_args': ['-icount', 'shift=1', qemu_args],
+  },
+}
+
+if 'qemu-system-riscv32' in emulators
+  tcg_tests += {
+    'riscv32-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'folder': 'riscv32',
+      'gdb_arch': 'riscv32',
+      'qemu': emulators['qemu-system-riscv32'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/riscv32/test-mcycle.S b/tests/tcg/riscv32/test-mcycle.S
new file mode 100644
index 0000000000..189d1e13a2
--- /dev/null
+++ b/tests/tcg/riscv32/test-mcycle.S
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	/* Exercise writes while mcycle is running. */
+	csrw	mcountinhibit, zero
+	csrw	mcycle, zero
+
+	/* A write to the high half must be immediately observable. */
+	li	s0, 0x1234ffff
+	csrw	mcycleh, s0
+	csrr	t0, mcycleh
+	bne	t0, s0, fail
+
+	/* Check carry from the low half into the high half. */
+	li	s0, 0x12345678
+	csrw	mcycleh, s0
+	li	t0, 0xfffffff0
+	csrw	mcycle, t0
+	.rept	32
+	nop
+	.endr
+	csrr	t0, mcycleh
+	addi	s0, s0, 1
+	bne	t0, s0, fail
+
+	/* A low-half write must preserve the carried high half. */
+	li	t0, 0x22222222
+	csrw	mcycle, t0
+	csrr	t0, mcycleh
+	bne	t0, s0, fail
+
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
-- 
2.55.0


