Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F52C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkkzs-00065G-It; Wed, 19 Feb 2025 09:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkkzr-00064q-AV
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 09:24:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkkzp-0001sY-LC
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 09:24:19 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38f325ddbc2so3560062f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739975055; x=1740579855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2bXM2FM3uqWtmWOWElh2OEI9PyZko/TrtNoyq1yEV7A=;
 b=r75P7itkBtAeng5E/MY6GtW05ZtK+59r/GRZ+9IAjKp27xHYMag4Huk+HW/UPy68ft
 YGR5OfRmf/D5eppM/6EoLHsz82TW/px//1FIZgLPaao7hAysibw899KyLzBJcWc+XHzi
 8a21AC+0RLu2sJ30+4FplgbEHJiP+WaUqVUqGODNlB8r1oa0OGVaaWddpk0ao0E6Vej+
 wTeXenS16jlu35GKHDrEiBvWb19kLHJ1QllWxYAWRAjC33VrS/mxo8KQD/f/kfN6bWug
 cTRS+3OibbgYY8ybi9z5UMbUa8XIhJ8sePgombEIHZuN2kas3CsJ53/O2HaSm612hWHS
 XwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739975055; x=1740579855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bXM2FM3uqWtmWOWElh2OEI9PyZko/TrtNoyq1yEV7A=;
 b=d/+Fp+X0j8KLvT0+qBPre4R/dX+5zYBwqseARulksMjs/gLObUxncr8AuKBfBFSYjZ
 MRRwFPxXXmaGB5RQV8SABdZA7PAZoJJjNDElp1XCJykISKIUzrXJ44y1EoBLyzZFCkWl
 tyExmHiTaxxvUbAw3VJ376nKR3RK5C1NhWEu+RldyqnwXGLzFN6g1VUZxYenXGBaIpan
 jeblgZ5j+xl4WBCctXLJG932hYs+dfEbmGlYSvS2n+WnBYvKUxBAntGfBmi0V9BFF5N8
 XSeeoA6pJpaKirRY3k5cUGvrabKcb9ItScUaBOTUm6DDVUC2bvLQ5i6ksM07QDUkd83N
 x7Nw==
X-Gm-Message-State: AOJu0YzmXdDa/Mq+GtYKdwK3t2FyELQSlxoUa24TIpTVUjvH+WNrO30Y
 XZAB8GNfJ5mHAN2uls7hXTL7BQntYBMx3iFG0Xz8SxMr8YZYZs6by4EXrXPU+oQXlW1SrURLLQg
 ZTeQ=
X-Gm-Gg: ASbGncvNK4CzRTGJpwInF2Qc0hGksicFCfaVA5kBb2rXPItgbDs7Wh+wtQjrTu4W4aH
 4Sa/leUk5zP8VMTu6MRiE+b0LqdrW77FlhaH6m6Duzys/NUTs4WEw83mP88uktrAZKYJfe3p+bR
 mE3Lj+jPCTYG+O9Gkw3+ZaRo2oicE11tjw3z35fJeqBNx6bHM2LozFA1rL1Y+zGNbXIgpIpBOY2
 U8p4uawbFTIEMbtQOpvZMDygTGZVs4Oy4nyMj8if5pbaNLgEg1l1TNucbTdykJNwITOozssfxvB
 ByJx2tMzUFzAll+UyeTQak52VwAKNtbzayCoc+tpRMDN9Ad3uGAFJdo/KRs5ZMV6hg==
X-Google-Smtp-Source: AGHT+IH2mIeEyEDNzSmMKUzcoIIO10ZgIHVAabz05fRr9/XBi5aY1cEVgmc+n5ZJs4XpwHEsZVU5dw==
X-Received: by 2002:a5d:64a3:0:b0:38f:50bd:ad11 with SMTP id
 ffacd0b85a97d-38f50bdadd5mr6329613f8f.5.1739975054947; 
 Wed, 19 Feb 2025 06:24:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f2591570esm18217888f8f.59.2025.02.19.06.24.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 06:24:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH] tests/functional: Generic method to check required
 devices availability
Date: Wed, 19 Feb 2025 15:24:12 +0100
Message-ID: <20250219142412.77536-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Not all binaries contain the same set of devices. Since some
tests depend on specific devices, we need to check their
availability in the binary.

QemuSystemTest::require_device() allows for system tests to
explicitly check for a particular device. Add a similar
check_required_devices() method which check all devices
requested on the command line. If a device is missing, the
test is skipped.

Example running test_aarch64_virt.py on macOS:

  ok 1 test_aarch64_virt.Aarch64VirtMachine.test_aarch64_virt_with_gpu # SKIP no support for device virtio-gpu-gl-pci

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Just an idea to see if we can avoid manual require_device() calls.
However not having a device in binary might also be a bug, so RFC...
---
 python/qemu/machine/machine.py         | 10 ++++++++++
 tests/functional/qemu_test/testcase.py |  8 ++++++++
 tests/functional/test_aarch64_virt.py  |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index ebb58d5b68c..ff1ff066823 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -468,6 +468,16 @@ def launch(self) -> None:
             # that exception. However, we still want to clean up.
             raise
 
+    def get_command_arguments(self, command) -> List[str]:
+        """
+        Return a list of arguments used with one kind of command
+        """
+        args = []
+        for index, element in enumerate(self._args):
+            if element == command:
+                args += [self._args[index + 1]]
+        return args
+
     def _launch(self) -> None:
         """
         Launch the VM and establish a QMP connection
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 869f3949fe9..7e3288f452c 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -335,6 +335,14 @@ def require_device(self, devicename):
         if help.find(devicename) < 0:
             self.skipTest('no support for device ' + devicename)
 
+    def check_required_devices(self):
+        """
+        Check the devices requested on the command line are available
+        in the binary. To be used before the VM launch() call.
+        """
+        for device in self.vm.get_command_arguments('-device'):
+            self.require_device(device.split(',')[0])
+
     def _new_vm(self, name, *args):
         vm = QEMUMachine(self.qemu_bin,
                          name=name,
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 95f5ce8b4c0..589680a44c5 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -180,6 +180,8 @@ def test_aarch64_virt_with_gpu(self):
                          f"file.filename={image_path}")
         self.vm.add_args("-snapshot")
 
+        self.check_required_devices()
+
         try:
             self.vm.launch()
         except VMLaunchFailure as excp:
-- 
2.47.1


