Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F30C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Cfb-0002y6-TL; Wed, 09 Sep 2026 03:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x4CfZ-0002xL-42
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:24:33 -0400
Received: from mail-pj2-x08.google.com ([2607:f8b0:4864:39::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x4CfU-0002ht-W6
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:24:32 -0400
Received: by mail-pj2-x08.google.com with SMTP id
 d9443c01a7336-2db33361b2fso22645315ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788938667; x=1789543467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+uU2gXfS1myt7enjNIVdCj8KJ86abQ0iiAxL4qdzD74=;
 b=maxfMCruYsJEIqts2CYTiXwedCCgExYYdYSNc29y/rDJFwHBTLG8mwzEQblkFejegw
 fqDvJe6rH3gnXKKN/cGPgYDJpvChiVIizGZBhkDWkZZ5NO/pJfCdFTfuku7d1fPkzWdf
 4X2+ywM7k+YgOi7WesUmmxYdG//ibF67LTOT6Gv2J3tzsnz2mj8FH1t9+Ez6PSv0Y6Ov
 JuUdju0AOU2NcEwbVXYeUm4oKYrmYN+D1rOtFNRPdPJdI8D8yZ30HyvwLkyb0945b2fm
 fHsli1LI7BWyAxaNlCvom2ZYxPTfTFW8KDkKfMil1HrkfApbvNPPkHGwaQe9932i/bTJ
 yESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938667; x=1789543467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+uU2gXfS1myt7enjNIVdCj8KJ86abQ0iiAxL4qdzD74=;
 b=ZIKKHnOuDSfIGA55LjTZI/F8eCEYyMO7xEOf9sgTTpQfoSQsj3uUBGeAnE1B/Ytnrk
 fcMe9BJzvpcPpTrgTGUbAnEYQSjxufEsL7jdXvF+TRWr0LyzI+aIQQ2ncFYn+85z5InI
 1w3hC2gjg0960fEn4Xtgz9qsLu4ysgBT6/8an2+8v+B75TRVkRk8G7BC3+EYEreHLLQ+
 W22Sj9NVCLf/lWmYPfSJTHZk0kxZdCYkqoz9/Zr7bwpScnyyuOsnnmN+2MAnfIdtcLLO
 VRcmZyS19Vc9BzB8Gvloaccs9tiKB43FOfT9X4fw+uKKSn9xAWa9w2MzyiPyTZ/yEj8s
 7X6g==
X-Gm-Message-State: AFuF++n40i1GPtaPcCXoywFGnF7NQlmcMOS77759n0kMRuvzmRYBCnOt
 GZrgpia5VMUKhFNBcZyCYW+NbKg0ArlwEylZmJRHR53Dlio25MznkHMP0huXykhH
X-Gm-Gg: AYBFou1IRpz3WzBGp77Asw7j/R5mUCYIQoaV/EBVPGsXSew9IfWnU1sl8H2DKYhpRLF
 z0onjnfHaE5nWmLjGKsvtmzvhJks/rwolMWftwHEVywoqAqkgsKuHCHqvaFVuOPZlOr5hT9blYO
 D4/plQ+ceRsttJyqjpd9vVAoPvaq1G/1UQOtj5QKdsH050yH1di6l+0XX+4hswQ0mgYk5UA3R2K
 im4BYQjzBbpy3In4XbbMkQxn3po0p2fkKhMTLrwQ0IeABosUhJjisgcqHNtKfcGjXd0mPl6jwGd
 XKO5WLCGZ3M3ampVPL1Kbyt01773rR0a4GjOhESdfiSRJlxkBEZRSbjp8+NmklDVrZyc7Aj6OJz
 dRyrEMo2o52mbdT3JlMt49bCen/MXGWoRwSNbmOiZC8//FQhyX3s0xir7nw+aXDQE1ngrEiHnI0
 EEuvZrg828uDw1wL6Ij7ZXdKdGcIe1ykbW6OgG5Kpf/kAaFpFlcdqQxc3DfbNNSGswTpYneOjNX
 Bp4JdkgEhGraRlA+ohASohkHYvM
X-Received: by 2002:a05:6a21:3a44:b0:3cc:8344:1213 with SMTP id
 adf61e73a8af0-3da39e68250mr52821620637.8.1788938666784; 
 Wed, 09 Sep 2026 00:24:26 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([103.190.179.27])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc45c62012bsm5949351a12.4.2026.09.09.00.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:24:26 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-stable@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, alex.bennee@linaro.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v2] target/riscv: fix RV32 fixed counter accesses
Date: Wed,  9 Sep 2026 15:23:55 +0800
Message-ID: <20260909072356.42784-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::8;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x08.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

---
Changes in v2:
- Move the test to a new tests/tcg/riscv32 directory.
- Convert the test registration to the Meson TCG test framework.
- Add RV32 TCG cross-compiler options and cover the test directory in
  MAINTAINERS.
- Add a riscv32-local semihosting linker script.

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..5f75b2684f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -377,6 +377,7 @@ F: include/hw/riscv/
 F: common-user/host/riscv*
 F: tests/functional/riscv32
 F: tests/functional/riscv64
+F: tests/tcg/riscv32/
 F: tests/tcg/riscv64/
 F: tests/qtest/iommu-riscv-test.c
 
diff --git a/meson_options.txt b/meson_options.txt
index 292625af08..2ceebe7a44 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -452,6 +452,10 @@ option('tcg_tests_cross_cc_ppc64le', type: 'string',
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
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index bd4b6dc114..65985efb22 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1337,23 +1337,23 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
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
@@ -1363,20 +1363,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
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
@@ -1407,12 +1409,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
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
@@ -1431,7 +1432,8 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
         uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
-                                                             ctr_prev + ctr_val;
+                        counter->mhpmcounter_prev +
+                        counter->mhpmcounter_val;
         *val = extract64(cntr, start, length);
     } else {
         *val = ctr_val;
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d41a228fb3..60b5ce2529 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -169,6 +169,7 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
+subdir('riscv32')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
diff --git a/tests/tcg/riscv32/meson.build b/tests/tcg/riscv32/meson.build
new file mode 100644
index 0000000000..c08dfd772d
--- /dev/null
+++ b/tests/tcg/riscv32/meson.build
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+cc = 'riscv64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
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
index 0000000000..16f9a06c94
--- /dev/null
+++ b/tests/tcg/riscv32/system/meson.build
@@ -0,0 +1,37 @@
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
+      'cc_docker_host_arch': cc_docker_host_arch,
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
2.43.0

