Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0084C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpIN-0001e9-Bp; Fri, 19 Jul 2024 11:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpIM-0001dA-6u
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:13:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpIJ-0005QQ-SD
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:13:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-427d8f1f363so3976475e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721401994; x=1722006794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gZJPW/lvXGtYKm7JzNSmEVgcUOEegBQAD673Jp3vZ2I=;
 b=dNNfDLX/3wQaOwjhKBiFMWN1HOHAqHQ/sE/u9zowhZkUT5yo4asdy4LiKEF97QkTo4
 RGhNCU/d/Eh2cYt1peEVTQWWZoso9VGdcE9xHf4pgJQwl8AU853iqFhoydk9sqcclKDE
 nvO7W7kBx8W3Rv4MYuImH2LI5/JZ/k4RYV2ZHE7o+9/+9MpS3tZavQcLivj5e/sQIQ40
 SYblEwMXzUt3RF+bjleH5HijG0lR4nSzY1d21woPp1ggJEvWzeodnuZ6gh51+6eaBKP2
 RnCXD09NvpRKoFEIuRfejK1j3O307RulIrtyWs3iGhPndjUQDPyTDMfjzWCvo+8TlTtO
 9PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401994; x=1722006794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gZJPW/lvXGtYKm7JzNSmEVgcUOEegBQAD673Jp3vZ2I=;
 b=p9MJiLZwH8Hn9XdVmPRM/WGmzoD+HBu9aFflxrEMRjX9Get5TI2gHhfsxbHk0/Lwq9
 dAIdLBykBlVbnVqkODagNkdCtwYEyjC//VwP110zE5cwpFX/Z2rA08QGrFBzURabhaWc
 glNrARenr1wljyTelcuDaDaOs5E7hg8V0fWiwDQodS0yXs4xpdLYT6IYxfyZHt1mu/ea
 h4dsp8bZ7nk/CjIsbvCDp8QzW38isfJVpuiSBd0ZQsmBgm0MwjRaFGBE2Tcr2zVqnJqz
 ofk03ou5t4r1Pum40jULGHtBxEiaaEqoXbIjcAs+QrxNea3EZ46LWeZZ3pbga3etV+9S
 d3Nw==
X-Gm-Message-State: AOJu0Yw2Y2t5BH7TCJpKMr9mR3VMUgsrR4zYCxjNoRP7yrA4e6abYRtA
 KktMYT75R63fgYjwDMoKRgpgoPjrHrfdxZYYuKZbUuvPJgyvPaYIyKNG4JuXJSHxwMmhZJKJwgw
 k
X-Google-Smtp-Source: AGHT+IESeXH/Mh0Ju9h79sZHOOcqzY9meTEXV8chKrcyDp9BhTXOoy81d7jNHDyeSrG6KxrFTxZZqw==
X-Received: by 2002:adf:eb46:0:b0:35f:2030:d42c with SMTP id
 ffacd0b85a97d-36831608a1cmr5276461f8f.17.1721401993942; 
 Fri, 19 Jul 2024 08:13:13 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b26dsm1830017f8f.34.2024.07.19.08.13.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 08:13:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/avocado: Move common Avocado tags to class
Date: Fri, 19 Jul 2024 17:13:10 +0200
Message-ID: <20240719151310.45927-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

When Avocado tags apply to all tests in a class,
we can define them once in the class: they will
be applied to all test methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux.py           |  2 +-
 tests/avocado/boot_xen.py             | 17 +----------------
 tests/avocado/machine_aarch64_virt.py | 10 ++++------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index cdce4cbcba..df6cf209ef 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -64,12 +64,12 @@ def test_pc_q35_kvm(self):
 class BootLinuxAarch64(LinuxTest):
     """
     :avocado: tags=arch:aarch64
-    :avocado: tags=machine:virt
     """
     timeout = 720
 
     def test_virt_kvm(self):
         """
+        :avocado: tags=machine:virt
         :avocado: tags=accel:kvm
         :avocado: tags=cpu:host
         """
diff --git a/tests/avocado/boot_xen.py b/tests/avocado/boot_xen.py
index fc2faeedb5..93bfb0c161 100644
--- a/tests/avocado/boot_xen.py
+++ b/tests/avocado/boot_xen.py
@@ -61,8 +61,6 @@ def launch_xen(self, xen_path):
 
 
 class BootXen(BootXenBase):
-
-    def test_arm64_xen_411_and_dom0(self):
         """
         :avocado: tags=arch:aarch64
         :avocado: tags=accel:tcg
@@ -70,6 +68,7 @@ def test_arm64_xen_411_and_dom0(self):
         :avocado: tags=machine:virt
         """
 
+    def test_arm64_xen_411_and_dom0(self):
         # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
         xen_url = ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
                    'download?path=%2F&files='
@@ -81,13 +80,6 @@ def test_arm64_xen_411_and_dom0(self):
         self.launch_xen(xen_path)
 
     def test_arm64_xen_414_and_dom0(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=accel:tcg
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=machine:virt
-        """
-
         # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
         xen_url = ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
                    'download?path=%2F&files='
@@ -99,13 +91,6 @@ def test_arm64_xen_414_and_dom0(self):
         self.launch_xen(xen_path)
 
     def test_arm64_xen_415_and_dom0(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=accel:tcg
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=machine:virt
-        """
-
         xen_url = ('https://fileserver.linaro.org/'
                    's/JSsewXGZ6mqxPr5/download'
                    '?path=%2F&files=xen-upstream-4.15-unstable.deb')
diff --git a/tests/avocado/machine_aarch64_virt.py b/tests/avocado/machine_aarch64_virt.py
index a90dc6ff4b..0ef6df4b0d 100644
--- a/tests/avocado/machine_aarch64_virt.py
+++ b/tests/avocado/machine_aarch64_virt.py
@@ -20,6 +20,10 @@
 from avocado.utils.path import find_command
 
 class Aarch64VirtMachine(QemuSystemTest):
+    """
+    :avocado: tags=arch:aarch64
+    :avocado: tags=machine:virt
+    """
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
     timeout = 360
 
@@ -33,8 +37,6 @@ def wait_for_console_pattern(self, success_message, vm=None):
     # Other test profiles should use more minimal boots
     def test_alpine_virt_tcg_gic_max(self):
         """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:virt
         :avocado: tags=accel:tcg
         """
         iso_url = ('https://dl-cdn.alpinelinux.org/'
@@ -129,8 +131,6 @@ def common_aarch64_virt(self, machine):
 
     def test_aarch64_virt_gicv3(self):
         """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:virt
         :avocado: tags=accel:tcg
         :avocado: tags=cpu:max
         """
@@ -138,8 +138,6 @@ def test_aarch64_virt_gicv3(self):
 
     def test_aarch64_virt_gicv2(self):
         """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:virt
         :avocado: tags=accel:tcg
         :avocado: tags=cpu:max
         """
-- 
2.41.0


