Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43770F8D761
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDPyj-0006BO-Qz; Thu, 16 Apr 2026 12:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDPyi-0006As-Ex
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDPyg-0007vL-OU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0046078so80401075e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776358445; x=1776963245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEvZ7lrKLdAgMPjxUR6yVusIcpnHSNVLRW4q8x7Iv2s=;
 b=SDz5089kQrFyqbadZZoWfAEnOn9cqid7Upa4VQbj6/ocGJfJUVp1hEUmoCG2ifj9G4
 T7vLvGulxnHJcEdLsJu23PFboL5XHi632SEf/YOQjxMX+Psat0NDVFFG/7IFrOXpEwZw
 U9yq0eIv0uQclB7T3u7zx2O0Ft5fuwFitfxNqYwDUaRQ76DuSnkv4WojQoUNDZ2zQPJK
 U9nV+QOF0/wD72ro7VRE0jyX5RYjKrzloMajUoEQRiLVkq6H8Qqn2hVSDld+MJjSIVmC
 emmG3zGTYpq6ilwXT6UafgoePKCjbxIbCsFi9IAzaVdEFZVtP8FkvuTTHmOto+v3wlnE
 M6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776358445; x=1776963245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aEvZ7lrKLdAgMPjxUR6yVusIcpnHSNVLRW4q8x7Iv2s=;
 b=SJUT3js1w0zPOPjp84JhJxg8Vdv0ymdQ5j/ClJB1oReio9/Gn/WmJtVKThY9MFFJ6A
 8xQx6opip9Pz0iomZHbOCCWj0JLTvyn5M9A4P1AlwcaAvvOjZVAYXGplVL24kDyBwAeq
 RBu7Xi5VPieGojDUvtOC54EGs2mI2VKQbp56kkaOGEEZ/pAlAxFyiF28yRic8xy/vPU7
 hFvqjNbKGL0jR/OV+ZLia/1w/hrRUdzGjOlqdpn5PamWUiRydOWL+0UjlLso7oJ7+9tV
 +kJHOyNyYwx27fMRowjG+nLIpwIjfbITn1hiXEirq0W/vonSz+50BFKjSdCOYARzykhh
 uHFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TN0InivtCBsUDK5ySO3IbmeE35xEEjHuS1L9K+h/gz8auu9MDaLmVp9ZT2GFlVxl7w0NxoCY5QuHW@nongnu.org
X-Gm-Message-State: AOJu0YxNXIX8FvVlILWTpsaB38iXf92L4GB4u8w8iMfqBeqwLUdX1wBY
 Mm8kRg+v3ZeYFz7H+bb3fqmjQthp6dTAJ885WOk53FeVY3ZFEzm4J8gBcHsFk0HNprc=
X-Gm-Gg: AeBDietVI9Pkja7QTPy+APrJkGsFfgHcpUFCg0uxhGtNytGEIBCW9plFq5HYZSkGSge
 mbARiskZJp7e2NAMsor1wYmrvFazO9eOsD+w8cnFcZEGKNwli4tPrTYgDIpWtI4dmB/CBhChwpp
 RLhneJ1spZhS11+hIgDPk/GzJwVoWKzgxVmz0W+emT6JoDNK5sjgVXx4NJ0auc8hMnMH/iCN/Md
 TagecyQ2f1wjtRbKDPgeqPADMRI7HGAoTrIVvww/IQJqvciMTOZ2LZIdCgpZoYmWS+VaT006ugg
 t7cmoiZ2OeRfm1BgDXj+F+NQnyOjtXWLUjO5tzi4LAbgt9D+ocRDeLZytwID1RhZPGGiD1TrT2W
 EgkVlM1AEhIznoGPDVqMyftVKUeDRJnWgCUbkvt75uYh0mBk4KUtN5iPEhYyCPnAiv7+rjfUTsl
 M72TukQfG0QL3pI74ndb/T+rDd2g1oMVaJ1pl2IAIDUrxJ+LqLSKEZ7ABmtj09GPFDzL1IA4Z4u
 p67D1VXQQM5a9x53mg09NoDva0i+4AvKgUCZmfcug==
X-Received: by 2002:a05:600c:3b24:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-488d687adb3mr388987975e9.24.1776358445122; 
 Thu, 16 Apr 2026 09:54:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fa79d476sm473035e9.1.2026.04.16.09.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:54:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 3/3] tests/functional/aarch64: Add basic test of TCG
 aarch64=off
Date: Thu, 16 Apr 2026 17:53:53 +0100
Message-ID: <20260416165353.589569-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416165353.589569-1-peter.maydell@linaro.org>
References: <20260416165353.589569-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a basic test of the TCG 'aarch64=off' functionality; this is the
same as our existing arm/test_virt test, but it runs the AArch32
guest kernel on qemu-system-aarch64 with -cpu max,aarch64=off.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/meson.build          |  1 +
 .../aarch64/test_virt_aarch64_off.py          | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/functional/aarch64/test_virt_aarch64_off.py

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 7ea8c22b04..de6f3ad5e6 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -45,6 +45,7 @@ tests_aarch64_system_thorough = [
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


