Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6BFC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr26x-0003EX-K4; Sat, 08 Mar 2025 16:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26u-0003DJ-Q6
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:33 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26t-0000u1-04
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:32 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so25414235e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470808; x=1742075608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sd1Rqb0eZxPQ/q4aV8APc+tkTpr19bp2JQoIjr8lN20=;
 b=DtaIKAUvHKpHRbtjsKhypSASO4Jkl7CqOVIVEbRi6ix0YPlwdc/b+RRVR/UHiZgWWN
 H446sFXDpSwmdFBGkq+AwAz0C1CMNIiPutFFizs5usJfr7jabwzpC3x5fetx78kbxBh6
 YAweyY/+MjL8LviPjwakW+66SoVAIsnwrQI189gcYLWDfuDi38Wbl/oAF3IPmbEPw3UR
 t1v+U5hbSw7buFOzS8CE0LQts6uk7APMxz31I0aKjSK1oa/J/Sh44DB/4PArc3xlGz72
 nL8JTtXemjv0nGn5t3kNEkryVAjR1uKCEnfJAwpttYoOUtn4iK2Ufyj/qkkk3bz2IELC
 AVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470808; x=1742075608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sd1Rqb0eZxPQ/q4aV8APc+tkTpr19bp2JQoIjr8lN20=;
 b=W+WTLniTmYr73BBGI5bJoqveeAmDmoa1pQ4qP98JkT5REnZDYUxYAjqw+NBicL2rFU
 4JyIyyoWuD7sYiwC2s5DwDyH+H4YbJSFsHM4R/knIAlP7wEd5wx/MAdvnhNUB8UNBUlS
 Hr2YZg5Rx6DRzdyeN8yNZOboin3QTcIl8b9fGALWbJvf1kFJ/qE03N2R9Rf4j8MkigL1
 7FTutzgfx/YHWjb5tLGkd5PrBOZaYRKUI/A+6cJC4r4CH5NfiOmf60Tlw3R6f600TgOj
 gcqyeGR4BFcLqKdiOvRSFWWWUnL+pDNqwgPEf2sRyxciU8eJzei345jpdN9y26tgYt3h
 gO7Q==
X-Gm-Message-State: AOJu0Yx6uulzfk4jJP1B3UDSrCiR3I2ZrFC5Ts2dvTF8H+atjsqJYotB
 oZEXZ2eikFODRUY4uVDIsOGz+Vvf8/8d9VRlFW2uYm6UcBfD4fl/pegp8+BUhWQ=
X-Gm-Gg: ASbGnctruYkWFeqCbwURilbWR+w+2dwcIIgWrrGwcCbJiaz57P7/bTpIefLgmwAh0b4
 6Wa16wWyHTFRj2tRiS2WkALGAG6PEuMh/v+sjR6I7+3oi0MCgXIosPnu67zBMmgjMXqZ0Q/gTlX
 rCKBlrxIYYSGSoWhUt1apm0TpV0B9VimReZ/Nv4YXufvs/hCU+oWXn1n3BsUmkFsUErKZZmhCyc
 ir+u/oPkH89ncpeRtUxNjvbGxNKX3EvViDsahjxmymCjX7Royj29Qoslt0w8tKTh+no+xHtor7A
 hzEnomINR+iss5iC2NN57J1W7AbKpyJTlnxmOKMU/tN7f4s=
X-Google-Smtp-Source: AGHT+IG8pWfUbwnXKzw8x2uh6wp6+LN0BR9MmyZFzeqKgxcdouPdLpUiB9Eh1f4dsL9SO/nNGI0cMQ==
X-Received: by 2002:a05:600c:214d:b0:439:a139:7a19 with SMTP id
 5b1f17b1804b1-43cb302205emr46732615e9.23.1741470808577; 
 Sat, 08 Mar 2025 13:53:28 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93c9b6sm95691585e9.29.2025.03.08.13.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB9595FA77;
 Sat,  8 Mar 2025 21:53:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/31] tests/functional: factor out common code in gpu test
Date: Sat,  8 Mar 2025 21:52:57 +0000
Message-Id: <20250308215326.2907828-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

In preparation for handling more tests split out the common machine
setup details from the test specific stuff and add a helper for
launching the weston test. Instead of searching for "vkmark score" we
set a custom PS1 and wait for a successful completion. This ensures we
capture the score in the console log which otherwise wouldn't log
anything.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-3-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 32af941cd5..b4679c0460 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -12,7 +12,7 @@
 from qemu.machine.machine import VMLaunchFailure
 
 from qemu_test import Asset
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
 from qemu_test import skipIfMissingCommands
 
 from qemu_test.linuxkernel import LinuxKernelTest
@@ -31,12 +31,7 @@ class Aarch64VirtGPUMachine(LinuxKernelTest):
         'rootfs.ext4.zstd',
         '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
 
-    @skipIfMissingCommands('zstd')
-    def test_aarch64_virt_with_vulkan_gpu(self):
-        # This tests boots with a buildroot test image that contains
-        # vkmark and other GPU exercising tools. We run a headless
-        # weston that nevertheless still exercises the virtio-gpu
-        # backend.
+    def _launch_virt_gpu(self, gpu_device):
 
         self.set_machine('virt')
         self.require_accelerator("tcg")
@@ -54,10 +49,10 @@ def test_aarch64_virt_with_vulkan_gpu(self):
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.add_args("-smp", "2", "-m", "2048")
-        self.vm.add_args("-device",
-                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self.vm.add_args("-device", gpu_device)
         self.vm.add_args("-display", "egl-headless")
         self.vm.add_args("-display", "dbus,gl=on")
+
         self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
         self.vm.add_args("-blockdev",
                          "driver=raw,file.driver=file,"
@@ -81,14 +76,23 @@ def test_aarch64_virt_with_vulkan_gpu(self):
                 raise excp
 
         self.wait_for_console_pattern('buildroot login:')
-        exec_command(self, 'root')
-        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
-        exec_command_and_wait_for_pattern(self,
-                                          "weston -B headless "
-                                          "--renderer gl "
-                                          "--shell kiosk "
-                                          "-- vkmark -b:duration=1.0",
-                                          "vkmark Score")
+        ec_and_wait(self, 'root', '#')
+
+    def _run_virt_weston_test(self, cmd):
+
+        # make it easier to detect successful return to shell
+        PS1 = 'RES=[$?] # '
+        OK_CMD = 'RES=[0] # '
+
+        ec_and_wait(self, 'export XDG_RUNTIME_DIR=/tmp', '#')
+        ec_and_wait(self, f"export PS1='{PS1}'", OK_CMD)
+        full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {cmd}"
+        ec_and_wait(self, full_cmd, OK_CMD)
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_vulkan_gpu(self):
+        self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self._run_virt_weston_test("vkmark -b:duration=1.0")
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.39.5


