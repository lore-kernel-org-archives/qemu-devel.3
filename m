Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE91EC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 15:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklYv-0004Y8-Ro; Wed, 19 Feb 2025 10:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tklYg-0004P6-Nb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:00:20 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tklYc-00013Z-DN
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:00:18 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abb81285d33so777158266b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739977212; x=1740582012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZ0Ad8q73aLBySL6ollEIfx4rPD1OsbtsagYMD1pCOs=;
 b=d4DJca9Um77NyYDruy9Ou6xpwEO/p7wMPv19eJc8eb+gDczYr5fWm7eeaMjd3Ud0nX
 KYDRNGw08z65BZzOftZFPLu9i/1m92zxgsKbLdOktKQ316dX8J8FBxu5EonfZ8vaYpQR
 4Zhxjs7OjI9aZM4HLv8xoXVPdz+DSoU+BVB7wxFMysPvIdfVkXNG4IYjazA3M5i6f59Q
 4jfppH84mfG2l+bX5cAR+MMjENIyR7w5C7lXIXLKhVk6MkAn2OVN57vqYrnH+PV1gEbQ
 tY3+luw/t+kj0F+gXSFxbrpCsN+uIq5Td9smZocdpr27rccn0Ye3AtIYEIYPrt30nd7+
 g6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739977212; x=1740582012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZ0Ad8q73aLBySL6ollEIfx4rPD1OsbtsagYMD1pCOs=;
 b=Qhh63tuvNIqV2Kxm/Ux3rm4F4QmOmqSMVIGGZaFlzKF4/0H3K10FK4PVns3HfhkWrX
 1VAz9vtlw9a7Foo/g3aRTNoJwifVucREwHUG6gpou2rgpga8xArry104zcafcqK1s+nA
 i3jq3GZ25VHnZybnQplfdsnVpUFyZbspPBUlmc8YD5pStrge/WR3xsL90AkyQmnE4QgM
 bRVdb0pu3FjpNh5fG+RItEHA5eOqhwp8gfsBqv+jL/3aCp7naM0cita+jIv8EimhPg6N
 QFk/CNstrWBInAjSk618hFVJBW2WFk5mW0tSjSGrrSEABJxLQOtZzPZEXniuoW8GPRuF
 XEag==
X-Gm-Message-State: AOJu0Ywq1K++DdTxNJn2zRf7W1Htr6QroSHuCD+c9SqtJUTjvK+E1Zc+
 DUQWKyzMMcKvcr5fEYZ9LTNYVb3opZcGcX2o4js9vpdkUmoRDvld6eUnpgZabNs=
X-Gm-Gg: ASbGncvIGyZznJI/ywjqVY/ZVKM8SwVpwPHO0qrFraP5qLNIKXvAK2nIADPOH9NWUm8
 AK2KSLky+NQNVWH0tREscbqQRVo8CPDR32pLz2e1JJUKHkvK8tvTn2DW+ngLHK9SoODLepx2qH/
 OgqGcalhRoV6TGlFmSNznAzUofIdm15YHI0YM90GvDjhQNoUXYafJTH+R+bIiovsYV3bZ7Nxl5Q
 73bXyItN7EwHeEzhe6hq+YrCwvIklzuspM4au4Dm0mX2PEYFJyVDlP+QfKGWnhKgzBq+Sai19z1
 gjQF2HOv+ZHJNdTL4g==
X-Google-Smtp-Source: AGHT+IHvAkv6fFG09NRsN/r+rHOkT01L3V4RCgy9iezjQMCFTpliYNqoQOul+kDGEEqNy2ys5EyPpA==
X-Received: by 2002:a17:906:c154:b0:aaf:74dc:5dbc with SMTP id
 a640c23a62f3a-abb70bbe128mr2133723366b.29.1739977212350; 
 Wed, 19 Feb 2025 07:00:12 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba5323202dsm1280699166b.6.2025.02.19.07.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 07:00:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4C384619BA;
 Wed, 19 Feb 2025 15:00:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] tests/functional: factor out common code in gpu test
Date: Wed, 19 Feb 2025 15:00:07 +0000
Message-Id: <20250219150009.1662688-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219150009.1662688-1-alex.bennee@linaro.org>
References: <20250219150009.1662688-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In preparation for handling more tests split out the common machine
setup details from the test specific stuff.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 30 +++++++++++------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index f21ae18392..06093c6b60 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -39,12 +39,7 @@ def wait_for_console_pattern(self, success_message, vm=None):
         'rootfs.ext4.zstd',
         '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
 
-    @skipIfMissingCommands('zstd')
-    def test_aarch64_virt_with_vulkan_gpu(self):
-        # This tests boots with a buildroot test image that contains
-        # vkmark and other GPU exercising tools. We run a headless
-        # weston that nevertheless still exercises the virtio-gpu
-        # backend.
+    def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
 
         self.set_machine('virt')
         self.require_accelerator("tcg")
@@ -62,10 +57,10 @@ def test_aarch64_virt_with_vulkan_gpu(self):
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.add_args("-smp", "2", "-m", "2048")
-        self.vm.add_args("-device",
-                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
-        self.vm.add_args("-display", "egl-headless")
-        self.vm.add_args("-display", "dbus,gl=on")
+        self.vm.add_args("-device", gpu_device)
+        for opt in ["egl-headless", "dbus,gl=on"]:
+            self.vm.add_args("-display", opt)
+
         self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
         self.vm.add_args("-blockdev",
                          "driver=raw,file.driver=file,"
@@ -91,12 +86,15 @@ def test_aarch64_virt_with_vulkan_gpu(self):
         self.wait_for_console_pattern('buildroot login:')
         exec_command(self, 'root')
         exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
-        exec_command_and_wait_for_pattern(self,
-                                          "weston -B headless "
-                                          "--renderer gl "
-                                          "--shell kiosk "
-                                          "-- vkmark -b:duration=1.0",
-                                          "vkmark Score")
+        full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {weston_cmd}"
+        exec_command_and_wait_for_pattern(self, full_cmd, weston_pattern)
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_vulkan_gpu(self):
+        gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on"
+        weston_cmd = "vkmark -b:duration=1.0"
+        weston_pattern = "vkmark Score"
+        self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


