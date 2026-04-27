Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349BFFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLTy-00059r-VQ; Mon, 27 Apr 2026 08:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNq-00086F-P1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNi-0005fs-Qz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso111450295e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294087; x=1777898887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gdC+YZDzna/r0rWQv2DL4f+RV4Dhxm4LmelNu8GSqFE=;
 b=Yp4y4uwlFVJ1M0AjA6TPYBBgDXBaD3z3sB+Hli4UdkK8BG7DktxPDSKINp0CUFmu6a
 Q3AoydWErh1jrbHs5H8q8A2Oe0KZQ1viX1XTZyk/1WZjGo6Jl/YvBRuHkYWJmzeN5O7n
 lReeQLc4XLFejDk4uhGZxuQbc1X67NyfU98V3DhywYDIcPrZ1CmWepVqeM1QZ/tCm7bM
 +0WhGCEvM6HWI7NGMJsXaKR3nnLFao2YSbcHTPYfV5XNke1z2mxP4mclk+Ymk06C44C3
 Ghw1/8MTL+NI/YeCRMjA0fQcXQllq/mVi6leXWXeqXi2h4jBUevjYLK7V1J8CNZ0krno
 Z3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294087; x=1777898887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gdC+YZDzna/r0rWQv2DL4f+RV4Dhxm4LmelNu8GSqFE=;
 b=mvT2oZ2RzT05PyY+2e1ucUBAanShhnF6+BClr41uQxFktulB2EX+2GUWQkUP4B3S93
 4uhG6xdDgRd67WQ7IPyNIBbJdW4xgL4SqVmgt92jSosZDjJSXJHnsvrs++dlww0srAw4
 VZcezQUQlU0DjER5ROIoSm5UGmdSEBXBRED7zql9vi57CnHv3GsykfEHUcQN6I7xMh4N
 KwQQmNOMYi39aQ28x/9kixoUhLdsicrF3YaoKGPkY6wDNPcMzr0Z4DQvt69J8mtMCzd8
 eY4eHv/n0FmYOSOId7pdfRBL1MNmQ3V/sT21oRImhXQPjxTduW6/O2XEtgNoKNtsKshx
 JGsg==
X-Gm-Message-State: AOJu0Yz3Yn1CvljyAzXphdMAu/dGptwRUrR6Eh49mY1MebVIS47pddjD
 d357c+Jtc3HvyfGcCIwJTLDAMA/BoglzCF2QpDUGwOGwCmLs6kMVc7c4sbEznKw9IiXGn+Ym/nq
 HM0vr
X-Gm-Gg: AeBDiesgLreV6NHMRSwe9thQzpjB0TKJn7Dnl72IRc3IWsat3Ft+56K0yFrxbPfWFo8
 HMtaI/ZeYaRaF4axqd7npxftDTzdSIahFmzShYdjCdZ6Lz69HiKBp4AKYtmVeX3NVmc6MoO94fC
 rDWWYZP3kyEQOoIlz+vyjaDrLW+7YdnakbqZEcEevbThf58syE2yrH4t96cT1kW7oVS82mu9qmx
 OsPMq7fMalSDezphO8VAyRAYnKwQa6G4XIKX9DrOZvhQVka1lehpu2rga8mNmVofBIiQxDdP4fd
 nTebpg87ba3EVMeHWxSiZmnkK8KctaNO3qXhO8NVWg0aQBk/h2V7lVTRLypzWLGQtl8ON2GEIQJ
 qPKFYIKWHb0f6KQzmlZgzPhgLXD8VkxlFfyBsFdcL8mTpPu7n7PmaCs9Z1HeF0hJPL1/9z+0Hxm
 7wA35OKVsMUb4R+yem8LCxhwywds5tOjhJ5QAGN2UsUlS5jdQyiMW1Aj3Ce6XSk/0js7190e6/H
 uJ4cx5yYFtokRwqv4jFCU73uzQkkv0NULCWjIMKEEIspwullfJd
X-Received: by 2002:a05:600c:3412:b0:489:284:44ab with SMTP id
 5b1f17b1804b1-489028446fbmr302648205e9.12.1777294087183; 
 Mon, 27 Apr 2026 05:48:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/63] tests/functional/aarch64: Add basic test of TCG
 aarch64=off
Date: Mon, 27 Apr 2026 13:47:04 +0100
Message-ID: <20260427124738.966578-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Add a basic test of the TCG 'aarch64=off' functionality; this is the
same as our existing arm/test_virt test, but it runs the AArch32
guest kernel on qemu-system-aarch64 with -cpu max,aarch64=off.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260416165353.589569-4-peter.maydell@linaro.org
---
 tests/functional/aarch64/meson.build          |  1 +
 .../aarch64/test_virt_aarch64_off.py          | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/functional/aarch64/test_virt_aarch64_off.py

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 1067f181f2..9803f66299 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -47,6 +47,7 @@ tests_aarch64_system_thorough = [
   'tcg_plugins',
   'tuxrun',
   'virt',
+  'virt_aarch64_off',
   'virt_gpu',
   'virt_vbsa',
   'xen',
diff --git a/tests/functional/aarch64/test_virt_aarch64_off.py b/tests/functional/aarch64/test_virt_aarch64_off.py
new file mode 100755
index 0000000000..13d8b73b0d
--- /dev/null
+++ b/tests/functional/aarch64/test_virt_aarch64_off.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots an AArch32 Linux kernel and checks the console
+# on a TCG aarch64 CPU with aarch64=off. This is the same image etc
+# as we use in tests/functional/arm/test_virt.py.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+class ArmVirtMachine(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/29/Everything/armhfp/os/images/pxeboot/vmlinuz'),
+        '18dd5f1a9a28bd539f9d047f7c0677211bae528e8712b40ca5a229a4ad8e2591')
+
+    def test_arm_virt(self):
+        self.set_machine('virt')
+        # KVM aarch64=off requires a host CPU that supports it, so
+        # restrict the test to TCG only
+        self.require_accelerator('tcg')
+        self.vm.add_args('-cpu', 'max,aarch64=off')
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.43.0


