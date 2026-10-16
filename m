Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CF3CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 03:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHYva-0000zH-G9; Thu, 15 Oct 2026 23:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHYvX-0000yw-JX; Thu, 15 Oct 2026 23:48:15 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHYvU-0001Py-73; Thu, 15 Oct 2026 23:48:15 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowACne+9untFqwwMBCw--.14381S2;
 Fri, 16 Oct 2026 11:47:59 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 alex.bennee@linaro.org, pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4] target/riscv: normalize Zcmt jvt.mode on writes
Date: Fri, 16 Oct 2026 11:47:59 +0800
Message-ID: <20261016034759.54-1-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qwCowACne+9untFqwwMBCw--.14381S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XryxGry5Kw4kZr1kAw1kKrg_yoWxZF45pw
 4UGwnIkrWfXF1xtw13GF17GF4rWw4ru3W5A397Cw4rZrW7JryUZFnxK3y7tr13JFWj9ryS
 93Za9r1Fkr4UJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
 Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
 FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r48Mx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUyAnYDUUUU
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Only jvt.mode=3D0 is implemented, and jvt.mode is a WARL field, so a
software write of a reserved mode encoding must read back with the
implemented mode. write_jvt() currently stores the raw value, so a
subsequent cm.jt traps. Mask the written value with JVT_BASE.

Add TCG system tests for normalized readback and cm.jt dispatch on
RV32 and RV64.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4408
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
---
Changes since v3:=0D
  - Add actual cm.jt dispatch coverage after the WARL readback check.=0D
  - Add RV32 system-mode tests alongside the RV64 test.=0D
=0D
 MAINTAINERS                          |  2 ++
 target/riscv/tcg/csr.c               |  6 +++-
 tests/tcg/meson.build                |  1 +
 tests/tcg/riscv32/meson.build        |  5 +++
 tests/tcg/riscv32/system/meson.build | 38 +++++++++++++++++++++
 tests/tcg/riscv32/test-jvt-warl.S    | 49 ++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-jvt-warl.S    | 49 ++++++++++++++++++++++++++++
 8 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/riscv32/meson.build
 create mode 100644 tests/tcg/riscv32/system/meson.build
 create mode 100644 tests/tcg/riscv32/test-jvt-warl.S
 create mode 100644 tests/tcg/riscv64/test-jvt-warl.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ee661cc23..4f2b6e882d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -377,6 +377,7 @@ F: include/hw/riscv/
 F: common-user/host/riscv*
 F: tests/functional/riscv32
 F: tests/functional/riscv64
+F: tests/tcg/riscv32/
 F: tests/tcg/riscv64/
 F: tests/qtest/iommu-riscv-test.c
=20
@@ -1786,6 +1787,7 @@ F: include/hw/riscv/opentitan.h
 F: include/hw/*/ibex_*.h
 F: target/riscv/insn_trans/trans_xthead.c.inc
 F: target/riscv/xlrbr.decode
+F: tests/tcg/riscv32/
 F: tests/tcg/riscv64/test-crc32.S
=20
 Microchip PolarFire SoC Icicle Kit
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9db77..d16c9cd3c7 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5904,7 +5904,11 @@ static RISCVException read_jvt(CPURISCVState *env, i=
nt csrno,
 static RISCVException write_jvt(CPURISCVState *env, int csrno,
                                 target_ulong val, uintptr_t ra)
 {
-    env->jvt =3D val;
+    /*
+     * jvt.mode is WARL and only mode 0 is implemented, so drop the
+     * reserved mode encodings instead of storing them.
+     */
+    env->jvt =3D val & JVT_BASE;
     return RISCV_EXCP_NONE;
 }
=20
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
index 0000000000..5557157c34
--- /dev/null
+++ b/tests/tcg/riscv32/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+cc =3D 'riscv64-linux-gnu-gcc'
+cc_dockerfile =3D 'debian-all-test-cross'
+subdir('system')
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/syste=
m/meson.build
new file mode 100644
index 0000000000..2ea397b3a2
--- /dev/null
+++ b/tests/tcg/riscv32/system/meson.build
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests =3D []
+
+link_script =3D files('../../riscv64/semihost.ld')[0]
+cflags =3D ['-march=3Drv32i_zicsr',
+          '-mabi=3Dilp32',
+          '-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-Wl,-T', link_script]
+qemu_args =3D ['-M', 'virt',
+             '-display', 'none',
+             '-serial', 'stdio',
+             '-semihosting',
+             '-bios']
+
+tests +=3D {
+  'test-jvt-warl.S': {
+    'cflags': cflags,
+    'qemu_args': [
+      '-cpu', 'rv32i,h=3Dfalse,zcd=3Dfalse,zca=3Dtrue,zcmt=3Dtrue,zicsr=3D=
true', qemu_args,
+    ],
+  },
+}
+
+if 'qemu-system-riscv32' in emulators
+  tcg_tests +=3D {
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
diff --git a/tests/tcg/riscv32/test-jvt-warl.S b/tests/tcg/riscv32/test-jvt=
-warl.S
new file mode 100644
index 0000000000..b9e42bc7a0
--- /dev/null
+++ b/tests/tcg/riscv32/test-jvt-warl.S
@@ -0,0 +1,49 @@
+/*
+ * Verify jvt.mode WARL normalization and cm.jt dispatch.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option norvc
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+	lla	t0, jvt_table
+	ori	t1, t0, 0x3f
+	csrw	0x017, t1
+	csrr	t2, 0x017
+	bne	t0, t2, fail
+	.2byte	0xa002		/* cm.jt index 0 */
+
+fail:
+	li	a0, 1
+	j	_exit
+
+target:
+	li	a0, 0
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sw	t0, 0(a1)
+	sw	a0, 4(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+trap:
+	li	a0, 1
+	j	_exit
+
+	.balign	64
+jvt_table:
+	.word	target
+
+	.data
+	.balign	8
+semiargs:
+	.space	8
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/syste=
m/meson.build
index c2d7d09887..62f0ffe1ea 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -26,6 +26,13 @@ tests +=3D {
   'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=3Dtrue,c=
=3Dtrue,v=3Dtrue', qemu_args]},
 }
=20
+tests +=3D {
+  'test-jvt-warl.S': {
+    'cflags': cflags + ['-march=3Drv64gc_zicsr'],
+    'qemu_args': ['-cpu', 'rv64,zcmt=3Dtrue,zcd=3Dfalse', qemu_args],
+  }
+}
+
 tests +=3D {
   'test-rv128-mstatus.S': {
     'cflags': cflags,
diff --git a/tests/tcg/riscv64/test-jvt-warl.S b/tests/tcg/riscv64/test-jvt=
-warl.S
new file mode 100644
index 0000000000..2ac28e6951
--- /dev/null
+++ b/tests/tcg/riscv64/test-jvt-warl.S
@@ -0,0 +1,49 @@
+/*
+ * Verify jvt.mode WARL normalization and cm.jt dispatch.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option norvc
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+	lla	t0, jvt_table
+	ori	t1, t0, 0x3f
+	csrw	0x017, t1
+	csrr	t2, 0x017
+	bne	t0, t2, fail
+	.2byte	0xa002		/* cm.jt index 0 */
+
+fail:
+	li	a0, 1
+	j	_exit
+
+target:
+	li	a0, 0
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+trap:
+	li	a0, 1
+	j	_exit
+
+	.balign	64
+jvt_table:
+	.dword	target
+
+	.data
+	.balign	16
+semiargs:
+	.space	16

base-commit: 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269
--=20
2.55.0.windows.2


