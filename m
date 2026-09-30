Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790A8CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSi-0001Sy-JG; Wed, 30 Sep 2026 12:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSR-0001Bb-9G
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:04 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSN-00032m-Ez
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:02 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so33213385e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786818; x=1791391618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GUHPSL0CAZKtb0o+SF8uVME6KydXoNbBvhH5/7wJ/pA=;
 b=xXZhNeRMadYt6mkHwxvMaioMXQbvbxE9ADqjNTjMFo8RoWdWypvGF1CkETLIABdYHX
 06bxej1MyJDVRgux4X84+u2RBx2IexV+tbimz5yYsK4mlw/tMswIUQK9m404OlRaLjkA
 H64q0pbQWkBP+ZNDjoSeZzwJzT0kVNlvLEcQEO7Az7bNWWD97+htoyEWM8O12MD3RnSc
 nv++CzrWfjXLxyDZJRjWYr+PpPsFMDCkrGJXB5FJfrdPtaK9lMZOT3jIvJT6I2GQsrtY
 0w/smzBlhuNqlcW/MCt5bdishRUagBsPqCd4ddxN06pLqp2C8ev68T49rBgJz158qCwA
 99nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786818; x=1791391618;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GUHPSL0CAZKtb0o+SF8uVME6KydXoNbBvhH5/7wJ/pA=;
 b=sdE02MC5y79FRlP+YaFAx7jk2RvFyfNvjhbaaa8N7iOBEStlhR/PtjE00Gf0kyOMrO
 fqi8Zh+PzI22oXPTsd+HwuqNVi4TYKJbTFTpN9quVs1NL+OdL+7w/NLFkvQgK9ltcFa6
 cmK45EVeLE5eSrvw4b/2dlj5PNXzLKVC9xYMNZNTjjXEYIbzFGyqPgEF5yPdm3Q/mXxH
 QhEOZqx4j9nsdQIQfaxmAzQLUejp9SBlUwnqp/CK1HaURFG+DYXfm/KhVPJi6+q+TeRH
 aXY9Y5IidLNczUrCNHKvb6H/5upbgUGLJO/+1y/2pI7jkqRq2W16bZGr62o1K7fLwqzY
 oIjg==
X-Gm-Message-State: AFuF++m3AVKU7ZiwuVtASTBQRvmkkgwJNYpEMuSYxtABpEaJng+UEnSt
 nT3QGH1lZJc5xvDWILYrmzbXvxXdEhQ3s5XGWWl/aFxYF9w1QZSAUnJY8Wh85FV2psU=
X-Gm-Gg: AYBFou0jhGP4aFOyC5pHL7dWUBqLdiynG3D//LN7SbkzIXuSHK08RJ7Bt3EFYnN1vKQ
 GeRMSezVYTbNj2Y631IlipLAhXplCsyy1NhgCWb4hL/QEdoW8W1XlOp1l6vC46dq39JDhh9SF3I
 TSsHbkHasd5+o9JfiRRkGmENgVt/mfkQC46XAnv4UuFGD9uDZ4rdsj6O1IPScXdqROJoTlFk085
 ULCdEyUun32WOh2OAqE/YyEr3GkMrpUWBXeuKb+q8Oahaibiy5ib7dzUBW8xgYwHRBP43hUlk5h
 kLLb/IJbmu2ZbbUsc4bFpAvGWgO1CcySO5VnZv1T44aktMrViLZ0R7vrei3AbXrUYg75+OFiTjt
 X42zmIiEPrUsOySXYPqoxC05qCGml1d+KdMdJS2K+XJOPVw8Vhm81vyY5XicW8ilX22+8BJNEqa
 UxPL3E0KS8hGcmP2YN8f3hakW7e5V87m1IQaO2CSPDTSg7VpSwbpXUAC6wmSt0/pTOu+qsQw==
X-Received: by 2002:a05:600c:4454:b0:4a0:8b1:f5c with SMTP id
 5b1f17b1804b1-4a01b00f607mr35482605e9.22.1790786817965; 
 Wed, 30 Sep 2026 09:46:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb8372dsm3815315e9.14.2026.09.30.09.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C0CA5F9D3;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/13] tests/functional: add basic gdbstub test for KVM
Date: Wed, 30 Sep 2026 17:46:41 +0100
Message-ID: <20260930164649.433573-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We don't really exercise the KVM bits of gdbstub very much as the TCG
tests are TCG only and the ones in functional tests are focused on
record/replay and reverse debugging.

Add a basic gdbstub test case which uses heuristics to single step
through the default firmware of guests and kick the tyres and check
things are working as expected.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
vAJB:
  - rewrote to use gdb run-test.py framework
  - simplified subprocess code
---
 .../functional/gdb-scripts/kvm_fw_gdb_test.py | 119 ++++++++++++++++++
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_kvm_gdbstub.py   |  55 ++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 tests/functional/gdb-scripts/kvm_fw_gdb_test.py
 create mode 100755 tests/functional/x86_64/test_kvm_gdbstub.py

diff --git a/tests/functional/gdb-scripts/kvm_fw_gdb_test.py b/tests/functional/gdb-scripts/kvm_fw_gdb_test.py
new file mode 100644
index 00000000000..b38b874dc58
--- /dev/null
+++ b/tests/functional/gdb-scripts/kvm_fw_gdb_test.py
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Generic GDB script to verify gdbstub functionality on guest firmware:
+#  - Single-stepping across VM-exits
+#  - Placing a hardware breakpoint at a branch or ahead in disassembly
+#  - Continuing to the breakpoint and validating that registers changed
+#
+# Copyright (c) 2026 Linaro Limited
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+
+import gdb
+from test_gdbstub import main, report
+
+def parse_registers():
+    """Parse 'info registers' into a name -> value dictionary."""
+    regs = {}
+    for line in gdb.execute("info registers", to_string=True).splitlines():
+        parts = line.split()
+        if len(parts) >= 2:
+            regs[parts[0]] = parts[1]
+    return regs
+
+def test_single_step():
+    """
+    Single-step a few instructions and verify PC advances
+    """
+    current_pc = int(gdb.parse_and_eval("$pc"))
+    for step in range(1, 6):
+        gdb.execute("stepi")
+        gdb.execute("x/3i $pc")
+        pc = int(gdb.parse_and_eval("$pc"))
+        report(pc != current_pc, f"single-step {step} advanced pc")
+        current_pc = pc
+
+
+def might_be_jump(asm):
+    """
+    Return true if the assembly string might contain a branch/jump instruction
+    """
+    branch_keywords = {
+        "jmp", "b", "bl", "bx", "bne", "beq", "bgt", "blt", "bge", "ble",
+        "call", "ret", "br", "jal", "jalr", "bc", "bctrl", "j"
+    }
+
+    parts = asm.split()
+    if not parts:
+        return False
+    mnemonic = parts[0].lower()
+    return mnemonic in branch_keywords
+
+
+def test_hw_bkpt():
+    """
+    Set a hwbkpt somewhere in the future.
+    """
+
+    # FIXME - this is fragile
+    disas = gdb.execute("x/10i $pc", to_string=True)
+    lines = disas.strip().splitlines()
+    insns = 0
+    bp = None
+
+    for line in lines:
+        clean = line.lstrip("=>").strip()
+        parts = clean.split(":", 1)
+        if len(parts) < 2 or not parts[1].strip():
+            continue
+        insns += 1
+
+        if might_be_jump(parts[1]):
+            # jump too close, bail out?
+            if insns < 2:
+                report(False, "found jump far enough away")
+                return
+            else:
+                addr = int(parts[0].split()[0], 16)
+                bp = gdb.Breakpoint(f"*{hex(addr)}",
+                                    type=gdb.BP_HARDWARE_BREAKPOINT)
+                break
+        elif insns == 10:
+            addr = int(parts[0].split()[0], 16)
+            bp = gdb.Breakpoint(f"*{hex(addr)}",
+                                type=gdb.BP_HARDWARE_BREAKPOINT)
+            break
+
+    report(bp is not None, f"set hwbkpt @ {bp.location}")
+    gdb.execute("continue")
+
+    end_pc = gdb.parse_and_eval('$pc')
+    report(bp.hit_count == 1,
+           "break @ %s (%d hits)" % (end_pc, bp.hit_count))
+
+    bp.delete()
+    return
+
+def test_reg_updates(regs_start):
+    regs_end = parse_registers()
+
+    changed = [k for k in regs_start
+               if k in regs_end and regs_start[k] != regs_end[k]]
+
+    report(len(changed) > 0, f"{len(changed)} registers changed.")
+
+def run_test():
+    regs_start = parse_registers()
+
+    test_single_step()
+
+    # skip any pesky mode switching code
+    gdb.execute("stepi 50")
+
+    test_hw_bkpt()
+
+    test_reg_updates(regs_start)
+
+
+main(run_test)
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e1..080e12ddef1 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -13,6 +13,7 @@ tests_x86_64_system_quick = [
   'bad_vmstate',
   'cpu_model_versions',
   'cpu_queries',
+  'kvm_gdbstub',
   'mem_addr_space',
   'migration',
   'pc_cpu_hotplug_props',
diff --git a/tests/functional/x86_64/test_kvm_gdbstub.py b/tests/functional/x86_64/test_kvm_gdbstub.py
new file mode 100755
index 00000000000..26876c3dc58
--- /dev/null
+++ b/tests/functional/x86_64/test_kvm_gdbstub.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Functional test verifying KVM gdbstub operations on firmware:
+#  - Single-stepping across VM-exits
+#  - Register sampling across execution steps
+#  - Hardware breakpoint at branch destination or instruction
+#
+# Copyright (c) 2026 Linaro Limited
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+
+import os
+import subprocess
+from pathlib import Path
+from qemu_test import QemuSystemTest, skipIfMissingEnv
+
+
+class KvmGdbstubTest(QemuSystemTest):
+
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def test_x86_64_kvm_fw_gdb(self):
+        self.require_accelerator("kvm")
+
+        gdb_path = os.getenv("QEMU_TEST_GDB")
+
+        tests_dir = Path(__file__).resolve().parents[2]
+        run_test = tests_dir / "guest-debug" / "run-test.py"
+        gdb_script = (tests_dir / "functional" / "gdb-scripts" /
+                      "kvm_fw_gdb_test.py")
+
+        qargs = "-machine pc -accel kvm -cpu host -smp 1 -m 512M -display none"
+        cmd = [
+            str(run_test),
+            "--qemu", self.qemu_bin,
+            "--qargs", qargs,
+            "--binary", "",
+            "--test", str(gdb_script),
+            "--gdb", gdb_path,
+        ]
+
+        res = subprocess.run(cmd, text=True,
+                             stdout=subprocess.PIPE,
+                             stderr=subprocess.STDOUT)
+        if res.stdout:
+            self.log.info('run-test.py: %s', res.stdout)
+
+        self.assertEqual(res.returncode, 0,
+                         f"run-test.py failed ({res.returncode}):\n")
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.47.3


