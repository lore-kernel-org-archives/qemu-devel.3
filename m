Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1572AC71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUQ-00018y-FF; Mon, 16 Jun 2025 10:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATw-00015H-ST
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:41 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATs-0003zI-NE
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so3868148f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082795; x=1750687595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jixPME6Y9feGFUr2gudtz74NxDsb7swpzH58eMF9CFw=;
 b=c4BvAI3aP+DZb0/5fFLkm6i3Ja/8D4yj9bDWC0/mbJCrUVLD6uEjaoSj41kMf+hdTz
 zePK2otMHDGfeNum9uAz/WZVKmWD6kMTkTGJk01frq7wJxBkZnguR3bCAnosjdtichtA
 3C9NXaqybj4fNn+1GGRPttTCJSglbJW81hdhh1mWQpWqsxuulm6tEzVFUkyqjtZfgHmL
 /FR6BXvnQ2tuOWLIb18Pk5VvSYerZOQCfuidAYcAWljDNi+i2zVCi8JYwmUM53a7BLax
 U+/iAIiIpR7lhCOS0/Oo+r0NKuGKOT9XoU3K41tbzSCleePoulBCu8qIp5WTDTQX4itn
 z7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082795; x=1750687595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jixPME6Y9feGFUr2gudtz74NxDsb7swpzH58eMF9CFw=;
 b=n0oMu7mFRzjHH2jDBTZp6mzS4hahhTMzkmIf7in82J9LBL2c+UlKPTNm/Vb/R+7qc9
 Hok0MdKv6kvlqKGB5fT5FJlNO3ef3Dz3+mCqnrZhL/HsO9dXpmRVX7mgv5s/TD7k5XQy
 Y/jrgUryEioMhTSadjwBx9enmXcYo7UYD3aPwM7Pjtvjvp+/j1jv5+7bfLEkV8LNgDc+
 Lp0r1W6me7pZ2wZHfotpqs+wf9KSj0/DmHY10H4TeUK3YjboNAh2uUUkvBXW4iMfmFwI
 85VCVf75a8BY8aCZhfj+HTSnGrzSzKVVVmnkjQU4nhr70R5gyYopTDpmys93nSufK4gX
 kFtA==
X-Gm-Message-State: AOJu0Yw59s4mhBCX9cKzprE7NwQP320M+erWAjB7i5gOkktvsDXSqwhq
 SnggYgVwhAS+qhF3iaA8CYnxO79hgbFdVSu7zaycCWRRKzfnACX5JtG0T8pNXSSWV2ndMBcdfDO
 1lybH
X-Gm-Gg: ASbGncsNq8UGFoJ2Ry6jNMBlquVX+B1NRnDrvNio3R9d8VppD5qzptGOTcuBd3KELUu
 LzCL+JubtOllwT1UM83C0fGBqqcCWGaN31fnYFHab1BaZtJqRsRpB7lSNEzA3/czuT/AEtivILs
 rgjD+uGe3RqJyXCAjfSgeGlwBVumEP8LlyJaCgVDiTg16W8FfB+muw1X4JucOqBhxae19R1BGya
 ZOKIQ+SGi2ADr3Nq3yQOGTfTu6qYdET8fFMQEnp38P3HMBEHot7iIazhcVMNSD3R5W2IqxwR/Lm
 EZz8WsWo/XQLKhahghAxD6lhFMOoTdd1zKHYgkCMWjj8SKr277wpQ8cDAHAgDOLXJk48
X-Google-Smtp-Source: AGHT+IFhLI+YgZ1RBnSwN49Bl/7SRvER3Q1cJSWUy1baxCQ2fSYShSn6YHYQ3RLAO7kSFQNaEak1Yg==
X-Received: by 2002:a05:6000:653:b0:3a5:783f:5289 with SMTP id
 ffacd0b85a97d-3a5783f5758mr6080641f8f.49.1750082794556; 
 Mon, 16 Jun 2025 07:06:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] tests/functional: Add a test for the realview-eb-mpcore
 machine
Date: Mon, 16 Jun 2025 15:06:23 +0100
Message-ID: <20250616140630.2273870-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Thomas Huth <thuth@redhat.com>

Check that we can boot a Linux kernel here and that we can at
least send one ping network packet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250603101526.21217-1-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                           |  1 +
 tests/functional/meson.build          |  1 +
 tests/functional/test_arm_realview.py | 47 +++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tests/functional/test_arm_realview.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 28b3dd2684b..84cfef835eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -955,6 +955,7 @@ F: hw/cpu/realview_mpcore.c
 F: hw/intc/realview_gic.c
 F: include/hw/intc/realview_gic.h
 F: docs/system/arm/realview.rst
+F: tests/functional/test_arm_realview.py
 
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7faa2b6e3c0..e7e051ef3c8 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -135,6 +135,7 @@ tests_arm_system_thorough = [
   'arm_orangepi',
   'arm_quanta_gsj',
   'arm_raspi2',
+  'arm_realview',
   'arm_replay',
   'arm_smdkc210',
   'arm_stellaris',
diff --git a/tests/functional/test_arm_realview.py b/tests/functional/test_arm_realview.py
new file mode 100755
index 00000000000..82cc964333e
--- /dev/null
+++ b/tests/functional/test_arm_realview.py
@@ -0,0 +1,47 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a realview arm machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
+from qemu_test import Asset
+
+
+class RealviewMachine(LinuxKernelTest):
+
+    ASSET_REALVIEW_MPCORE = Asset(
+        ('https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/'
+         'openwrt-15.05.1-realview-vmlinux-initramfs.elf'),
+        'd3a01037f33e7512d46d50975588d5c3a0e0cbf25f37afab44775c2a2be523e6')
+
+    def test_realview_ep_mpcore(self):
+        self.require_netdev('user')
+        self.set_machine('realview-eb-mpcore')
+        kernel_path = self.ASSET_REALVIEW_MPCORE.fetch()
+        self.vm.set_console()
+        kernel_param = 'console=ttyAMA0 mem=128M quiet'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_param)
+        self.vm.launch()
+        self.wait_for_console_pattern('Please press Enter to activate')
+        prompt = ':/#'
+        exec_command_and_wait_for_pattern(self, '', prompt)
+        exec_command_and_wait_for_pattern(self, 'dmesg', kernel_param)
+        self.wait_for_console_pattern(prompt)
+        exec_command_and_wait_for_pattern(self,
+                ('while ! dmesg | grep "br-lan: port 1(eth0) entered" ;'
+                 ' do sleep 1 ; done'),
+                'entered forwarding state')
+        self.wait_for_console_pattern(prompt)
+        exec_command_and_wait_for_pattern(self,
+                'while ! ifconfig | grep "10.0.2.15" ; do sleep 1 ; done',
+                'addr:10.0.2.15')
+        self.wait_for_console_pattern(prompt)
+        exec_command_and_wait_for_pattern(self, 'ping -c 1 10.0.2.2',
+                                          '1 packets received, 0% packet loss')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.43.0


