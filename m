Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D2ECA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEow-0008JI-8D; Thu, 01 Oct 2026 07:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEou-0008Iz-UU
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEot-0006Na-33
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Xs2szZnhFfuzVD3FBjk2FpaIBSRXHGNssrjZXIwzlo=;
 b=U8D6/tSqa/biYu6TpB6n/j1XEvklZafnRUIfsi3i30QWSIqPRuHjRtZJ412VNKaGz08Zvk
 ySSDAA4HmQjGdYRFYPaOQU6fsRfDnsqudKqQGYW0R162ugkYaxvYYSGefroC7dX3l6RuDp
 xb1VpPX7WMVZFb1vGqwpw1aiuuWtkzE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-s81XP_PvPbOLSVYmPNdeLg-1; Thu,
 01 Oct 2026 07:19:18 -0400
X-MC-Unique: s81XP_PvPbOLSVYmPNdeLg-1
X-Mimecast-MFC-AGG-ID: s81XP_PvPbOLSVYmPNdeLg_1790853555
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5549C1936197; Thu,  1 Oct 2026 11:19:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79B901800446; Thu,  1 Oct 2026 11:19:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 05/13] tests/functional: add basic gdbstub test for KVM
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Song Gao <gaosong@loongson.cn>, Ani Sinha <anisinha@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260930164649.433573-6-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-6-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:51 +0400
Message-Id: <179085353196.2170790.3865077624161009164.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7433;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DdwZrP+vdJbQma0yp+jDjxBsIqYZ2g9C4Ffc3j3NmYo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGeUGNW3Qnh3kI4LGy1opc1LqGgCABh4pRfU
 JaQvM9Q4L2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5WAAD/9FJbPGjDyn05YyQgkMdJK8tsft9SbJpc0xq53MNQIQC3j4QKWn+3mfPoeXHq9DYDg3E3K
 ejQtFV5B5xJ9n9IEvaROosMvz5raqFs6JUm2XcobAkCPRmzaT+2/J59JRIRuh2Fz1STTOCxhALI
 KYx9GxqATC9S0nVETl46HI6GTEJFTFMnWw/Qt9jU2cQgjluJtjD+wkyIv0wjukehUflCUFAIH0C
 lcSCVCZVQyh3a0W32epVprpWhhjI8LkcKDMe8jDFciL6I1MxeWtKZ9pZddVAy1CNTSA21HNzuvv
 xd9FDqnXiBcT7O1COjkgBhdpN+dX1znMnrAoKbYgVrhxtH4GdyUUm7igt5LH+k8/RrxeDxxC37v
 /aUUTmr71QsDtgkwF7WbHtDl2D1xLRpUmoYuECUJPKnj0y8ji8OWz2NA0aD0d8zxz7K0+TQ/tkE
 k5yQTz9zPWrSAJwLTn8KB+tkTCwtmbQwEx5WhkaGpnXRR5e2vhRxjz/sYz8XDTHCh73SXrkPffz
 fRF7u5xWZpICVCLaHh/mh22pylyyrnr70IxmaDRZTjuJUuF5IllX1VVZLleauck+aTP7AoxDbc8
 9kzE3g0jc6vLQB+DTpXhwE53+UfVken/ojxW8mI3wJpcywdFFfLqJvI8QY5V60+affvLAHekS9Q
 QyOiKSZzcs4Atlw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> We don't really exercise the KVM bits of gdbstub very much as the TCG
> tests are TCG only and the ones in functional tests are focused on
> record/replay and reverse debugging.
> 
> Add a basic gdbstub test case which uses heuristics to single step
> through the default firmware of guests and kick the tyres and check
> things are working as expected.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Message-ID: <20260930164649.433573-6-alex.bennee@linaro.org>
>
> diff --git a/tests/functional/gdb-scripts/kvm_fw_gdb_test.py b/tests/functional/gdb-scripts/kvm_fw_gdb_test.py
> new file mode 100644
> index 000000000000..b38b874dc586
> --- /dev/null
> +++ b/tests/functional/gdb-scripts/kvm_fw_gdb_test.py
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Generic GDB script to verify gdbstub functionality on guest firmware:
> +#  - Single-stepping across VM-exits
> +#  - Placing a hardware breakpoint at a branch or ahead in disassembly
> +#  - Continuing to the breakpoint and validating that registers changed
> +#
> +# Copyright (c) 2026 Linaro Limited
> +#
> +# Author:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +
> +import gdb
> +from test_gdbstub import main, report
> +
> +def parse_registers():
> +    """Parse 'info registers' into a name -> value dictionary."""
> +    regs = {}
> +    for line in gdb.execute("info registers", to_string=True).splitlines():
> +        parts = line.split()
> +        if len(parts) >= 2:
> +            regs[parts[0]] = parts[1]
> +    return regs
> +
> +def test_single_step():
> +    """
> +    Single-step a few instructions and verify PC advances
> +    """
> +    current_pc = int(gdb.parse_and_eval("$pc"))
> +    for step in range(1, 6):
> +        gdb.execute("stepi")
> +        gdb.execute("x/3i $pc")
> +        pc = int(gdb.parse_and_eval("$pc"))
> +        report(pc != current_pc, f"single-step {step} advanced pc")
> +        current_pc = pc
> +
> +
> +def might_be_jump(asm):
> +    """
> +    Return true if the assembly string might contain a branch/jump instruction
> +    """
> +    branch_keywords = {
> +        "jmp", "b", "bl", "bx", "bne", "beq", "bgt", "blt", "bge", "ble",
> +        "call", "ret", "br", "jal", "jalr", "bc", "bctrl", "j"
> +    }


Do you plan to make this per-architecture? It doesn't cover x86 conditional jumps.

> +
> +    parts = asm.split()
> +    if not parts:
> +        return False
> +    mnemonic = parts[0].lower()
> +    return mnemonic in branch_keywords
> +
> +
> +def test_hw_bkpt():
> +    """
> +    Set a hwbkpt somewhere in the future.
> +    """
> +
> +    # FIXME - this is fragile
> +    disas = gdb.execute("x/10i $pc", to_string=True)
> +    lines = disas.strip().splitlines()
> +    insns = 0
> +    bp = None
> +
> +    for line in lines:
> +        clean = line.lstrip("=>").strip()
> +        parts = clean.split(":", 1)
> +        if len(parts) < 2 or not parts[1].strip():
> +            continue
> +        insns += 1
> +
> +        if might_be_jump(parts[1]):
> +            # jump too close, bail out?
> +            if insns < 2:
> +                report(False, "found jump far enough away")
> +                return
> +            else:
> +                addr = int(parts[0].split()[0], 16)
> +                bp = gdb.Breakpoint(f"*{hex(addr)}",
> +                                    type=gdb.BP_HARDWARE_BREAKPOINT)
> +                break
> +        elif insns == 10:
> +            addr = int(parts[0].split()[0], 16)
> +            bp = gdb.Breakpoint(f"*{hex(addr)}",
> +                                type=gdb.BP_HARDWARE_BREAKPOINT)
> +            break
> +
> +    report(bp is not None, f"set hwbkpt @ {bp.location}")

Maybe to make debugging easier:

  if bp is None:
      report(False, "failed to set hwbkpt (no suitable instruction found)")
      return
  report(True, f"set hwbkpt @ {bp.location}")

> +    gdb.execute("continue")
> +
> +    end_pc = gdb.parse_and_eval('$pc')
> +    report(bp.hit_count == 1,
> +           "break @ %s (%d hits)" % (end_pc, bp.hit_count))
> +
> +    bp.delete()
> +    return
> +
> +def test_reg_updates(regs_start):
> +    regs_end = parse_registers()
> +
> +    changed = [k for k in regs_start
> +               if k in regs_end and regs_start[k] != regs_end[k]]
> +
> +    report(len(changed) > 0, f"{len(changed)} registers changed.")
> +
> +def run_test():
> +    regs_start = parse_registers()
> +
> +    test_single_step()
> +
> +    # skip any pesky mode switching code
> +    gdb.execute("stepi 50")
> +
> +    test_hw_bkpt()
> +
> +    test_reg_updates(regs_start)
> +
> +
> +main(run_test)
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
> index 0353b2af8e1d..080e12ddef13 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -13,6 +13,7 @@ tests_x86_64_system_quick = [
>    'bad_vmstate',
>    'cpu_model_versions',
>    'cpu_queries',
> +  'kvm_gdbstub',
>    'mem_addr_space',
>    'migration',
>    'pc_cpu_hotplug_props',
> diff --git a/tests/functional/x86_64/test_kvm_gdbstub.py b/tests/functional/x86_64/test_kvm_gdbstub.py
> new file mode 100755
> index 000000000000..26876c3dc580
> --- /dev/null
> +++ b/tests/functional/x86_64/test_kvm_gdbstub.py
> @@ -0,0 +1,55 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Functional test verifying KVM gdbstub operations on firmware:
> +#  - Single-stepping across VM-exits
> +#  - Register sampling across execution steps
> +#  - Hardware breakpoint at branch destination or instruction
> +#
> +# Copyright (c) 2026 Linaro Limited
> +#
> +# Author:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +
> +import os
> +import subprocess
> +from pathlib import Path
> +from qemu_test import QemuSystemTest, skipIfMissingEnv
> +
> +
> +class KvmGdbstubTest(QemuSystemTest):
> +
> +    @skipIfMissingEnv("QEMU_TEST_GDB")
> +    def test_x86_64_kvm_fw_gdb(self):
> +        self.require_accelerator("kvm")
> +
> +        gdb_path = os.getenv("QEMU_TEST_GDB")
> +
> +        tests_dir = Path(__file__).resolve().parents[2]
> +        run_test = tests_dir / "guest-debug" / "run-test.py"
> +        gdb_script = (tests_dir / "functional" / "gdb-scripts" /
> +                      "kvm_fw_gdb_test.py")
> +
> +        qargs = "-machine pc -accel kvm -cpu host -smp 1 -m 512M -display none"
> +        cmd = [
> +            str(run_test),
> +            "--qemu", self.qemu_bin,
> +            "--qargs", qargs,
> +            "--binary", "",
> +            "--test", str(gdb_script),
> +            "--gdb", gdb_path,
> +        ]
> +
> +        res = subprocess.run(cmd, text=True,
> +                             stdout=subprocess.PIPE,
> +                             stderr=subprocess.STDOUT)
> +        if res.stdout:
> +            self.log.info('run-test.py: %s', res.stdout)
> +
> +        self.assertEqual(res.returncode, 0,
> +                         f"run-test.py failed ({res.returncode}):\n")
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


