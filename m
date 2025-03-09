Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB712C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKJQ-0004NQ-Je; Sun, 09 Mar 2025 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trKJM-0004Mr-8i
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:19:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trKJG-00065P-Ty
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:19:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso5145505e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741540764; x=1742145564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zd7sNYltQbDeg8BujY3Oc2Qj273T+OtyPIpGg6jTeE8=;
 b=x2DeQbp+MBa2ShcJmHToA2WY8fiRG2I+YcpQhdK87ivxBview6S/xUwRNBJ3WsbGI+
 UCee8SoDWg3jZNq2lfRPqKN7COObTgykyGUqMEkM1uGUqDm3wMzRD0kemsmSmJc9UPNa
 /zoJhL1OUuWpSI2zngq0MtgheyX7Z57CW7a8AtJ2mDvt6IxuLsIPvrApwkL4VGXTaw+T
 7jdJ/kSU8D9xcGkvlcsvsLCioEd6fyx6j6Bmx5Hl7aUFdrZ+EP1TVlXmFJbbVLF59TRY
 YHdjWrdVmBhX7H3AdOCWnUpqXfrZ08VNTw0EYLlAoKnWZ7Z8pU0bD6qSe3XNuaGLZ8wk
 zt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741540764; x=1742145564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zd7sNYltQbDeg8BujY3Oc2Qj273T+OtyPIpGg6jTeE8=;
 b=V8gcpz4FfKSnNPHgwSNXC/gMHNNTpehan1Mj3DBxLsb7f0ShxT0mSuPLaX1UU/u7Wd
 IuhK2yZzHcrsTyZeOsSquiHz2ilpfZGDkx2TSceBRyjCyWiIGWNwWo9DyCR6Q2DkBhUA
 IbX1jpfUXajXMb36cP7mM3K0mw9cxs+ut+RF9Qh6ZKJdeTL7RlHMYuIhN3eP4Q2QqJoh
 Pir2SITQmcLv6CGk5izHsKYlANoMj9pwtD+LMpUYnk0HNYbMZfpRbQ7oYasPtTrImdJF
 sqkcqsZODyydlB5Ry9mb80X9dhQfXbxcsS3RlnHz2IBhHDcg3+LIHD1+PtleJBFB00ba
 EUDg==
X-Gm-Message-State: AOJu0YxSXAHUR4aroipb/Ph+Gta3Mq6JD31NlAzrVmgKVs0zfsFSS+J+
 Cdtb0/c0/nZ2j/F+p5AEdBi0UXEAoeE95aCsKZqwyVf2k384E/vpQxL9OCZtGMQ=
X-Gm-Gg: ASbGncvj1AvQNsofWM41vntTat503hZyAPji26AaAuNLIZa7qcOohfO7f/0qf4xrZnJ
 IRu9381SvLaCJf7q+Q6JFU+Wgs6pEHAzhhyk89vstQA33c8wFOUwMS6xnwaCIKBjQ1WRsUIYzni
 IlazEuOk4cIdp50wSEg2d5xwHMni/UI2eQQjTMAnN4o4VyFrzNOY1iCF3DzWfBgSPNKOpugglcO
 wJNtgMxRwAVcbyoJxvm3ySrZBpZmeTKKZkN+jmW8sp8qBKnkGhb302n2t3aiKM2ph78MapYTaWu
 zRag7UGqYZG5UYmL5maw8/qU7gyENCEkkf58vdFfv2ne4xk=
X-Google-Smtp-Source: AGHT+IF8hxC0WCiX90/U94HguDJJ6TLVR6V59946wXqubqcBlC71Ms1lv8P5bPV1eKAm3wuXGZ/50g==
X-Received: by 2002:a05:600c:1c04:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-43cf62969f2mr10963505e9.0.1741540763684; 
 Sun, 09 Mar 2025 10:19:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce3d5a0e2sm67265395e9.12.2025.03.09.10.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 10:19:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EA645F9DA;
 Sun,  9 Mar 2025 17:19:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/functional: skip vulkan tests when not configured
Date: Sun,  9 Mar 2025 17:19:08 +0000
Message-Id: <20250309171908.3087067-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

The CI images don't have the vulkan drivers for the non-existent
hardware even if they can't see the DRI devices. Skip the test early
in this case. While at it fix the missing logging which doesn't seem
to like f-strings.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index c6f7738e93..f19a47f8b6 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -18,7 +18,7 @@
 from qemu_test.linuxkernel import LinuxKernelTest
 
 from re import search
-from subprocess import check_output
+from subprocess import check_output, CalledProcessError
 
 class Aarch64VirtGPUMachine(LinuxKernelTest):
 
@@ -75,7 +75,7 @@ def _launch_virt_gpu(self, gpu_device):
             elif "'type' does not accept value 'egl-headless'" in excp.output:
                 self.skipTest("egl-headless support is not available")
             else:
-                self.log.info(f"unhandled launch failure: {excp.output}")
+                self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
 
         self.wait_for_console_pattern('buildroot login:')
@@ -119,7 +119,11 @@ def test_aarch64_virt_with_vulkan_gpu(self):
 
         self.require_device('virtio-gpu-gl-pci')
 
-        vk_info = check_output(["vulkaninfo", "--summary"], encoding="utf-8")
+        try:
+            vk_info = check_output(["vulkaninfo", "--summary"],
+                                   encoding="utf-8")
+        except CalledProcessError as excp:
+            self.skipTest(f"Miss-configured host Vulkan: {excp.output}")
 
         if search(r"driverID\s+=\s+DRIVER_ID_NVIDIA_PROPRIETARY", vk_info):
             self.skipTest("Test skipped on NVIDIA proprietary driver")
-- 
2.39.5


