Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4DEC021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1W3-0005nK-AX; Thu, 20 Feb 2025 03:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1W1-0005mx-Uf
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:02:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1Vz-00051U-Mx
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:02:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439a88f1ac3so554755e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740038554; x=1740643354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4DV4bwYDzD/6WGFZCg3Abji/qGxRMmfgA7ru0ZFgPo=;
 b=rajXhVzIBTdEsUjD91hc/g4CN0N1k8KoxlG22cRYW07d5d1nbJ84ul0s5XnS4acnfe
 2eF9/RKQD047EvQ/dHF6Sw/nUMMVSYUEwql9rdbV6b301Mfp1uxcRbqv97Wt280mH9xK
 f9HH3esjLKFpjMPo8OSmdv0Ensur3XWrw5qlRCShNZU+YAin0pxEOSiSuPxm/Ot1VqBE
 zhJhj19c41I5OfkVOQqAT/dYfh+xv0sgcp87SpFCGfHDr3zTwyc5YgKevs9VFLUmIb2a
 iXn+sKtJM7Mb9ZplyFp8vEf8puf6wp5S9DjmyrX/1vp8bPR2o/N7omkBNDCUHoQ7Dqix
 4T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038554; x=1740643354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4DV4bwYDzD/6WGFZCg3Abji/qGxRMmfgA7ru0ZFgPo=;
 b=c0Mx6oYhPHsrefPcyr+yoGlPLyPe1YRq7qPvVNNvx4KVElYHnCILECizwMqfYd5nGG
 8auQPzTEeccdP0TqjXpeCe+p81H2BKm6mgUjCCZDkB5r0D/hWdevuIFrc9jfdKVnH0x0
 Nr2y2vGhD8lIuVwfj7aao7y5cupowQlm3fZ+mkGcwlA0yVKVIgualwPyUewj/JQPRECP
 kg+GRCdfVg00/2K1K4aN7Pad9dgqOgBNo5NhKfDZ2A9UfTl05dXQaUUsAdvV4VJtF/8G
 Z9FZA5rdsCVrO/7YCFDKCMjAXvhdNmeuuooyc4hXktg5vstJX9LnuJCyTBuUB/KHdSVp
 GVyQ==
X-Gm-Message-State: AOJu0YzUw+shTXKeKzdwmVureW6B3+5vAVbogEF4kDqTc1W8/UOBBwY8
 hsM7bhtZx/ZC2KtvKeQaQZcAO4vCvMt5ADSnw4W/WO5gJ7pYcDtpUUnt6Q4E26GSi49JMI6VzfB
 mh7k=
X-Gm-Gg: ASbGncudwrLkrWZnQewzLIJbQ5VJASkyCHaqbSeqlojBQcpVDYO5pJ8allWpsRwZP0p
 dhN38C2ltuIrV4VBWdMeov3Zcn+ChjMb3J8m7463YrgPLeLESv6nvPEwTTXMhEGKi7thc5xVHFU
 uVbwbyLuUtM/rlKp/cHDw69BFHCfXozx9/zajc++zskF8Uu/XDGUy+FQ4xccJySBzXT4yfxsMf8
 CWm+KrjFFmZJXnhmbxYdQVq2AofYL4mmyRUoHdTXjtV/Zf1PLbTfoKkzfYnYP9gEeq6yUawac3J
 uMc01j756B/lk7A5DHCnNYvZljyFVFcmpPCmoYUKfxBxafr+ZAhaATM1p7f+/nluZQ==
X-Google-Smtp-Source: AGHT+IHd27ti1rt/9WvV0n+3JbvFoVxqVqgNm3kdwP2ib7RSWfPmRBKDe0n4+CcrUwDQiw4qZG6ZWA==
X-Received: by 2002:a05:600c:354f:b0:439:9f97:7d67 with SMTP id
 5b1f17b1804b1-4399f977ee1mr39770305e9.16.1740038553692; 
 Thu, 20 Feb 2025 00:02:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439872b59e9sm101938055e9.31.2025.02.20.00.02.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 00:02:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/3] tests/functional: Allow running TCG plugins tests on
 non-Linux/BSD hosts
Date: Thu, 20 Feb 2025 09:02:15 +0100
Message-ID: <20250220080215.49165-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220080215.49165-1-philmd@linaro.org>
References: <20250220080215.49165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Not all platforms use the '.so' suffix for shared libraries,
which is how plugins are built. Use the recently introduced
dso_suffix() helper to get the proper host suffix.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2804
Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/test_aarch64_tcg_plugins.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
index 7e8beacc833..5736b60545a 100755
--- a/tests/functional/test_aarch64_tcg_plugins.py
+++ b/tests/functional/test_aarch64_tcg_plugins.py
@@ -13,10 +13,11 @@
 
 import tempfile
 import mmap
+import os
 import re
 
 from qemu.machine.machine import VMLaunchFailure
-from qemu_test import LinuxKernelTest, Asset
+from qemu_test import LinuxKernelTest, Asset, dso_suffix
 
 
 class PluginKernelBase(LinuxKernelTest):
@@ -62,6 +63,10 @@ class PluginKernelNormal(PluginKernelBase):
         ('https://storage.tuxboot.com/20230331/arm64/Image'),
         'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
 
+    def plugin_file(self, plugin_name):
+        sfx = dso_suffix()
+        return os.path.join('tests', 'tcg', 'plugins', f'{plugin_name}.{sfx}')
+
     def test_aarch64_virt_insn(self):
         self.set_machine('virt')
         self.cpu='cortex-a53'
@@ -74,7 +79,7 @@ def test_aarch64_virt_insn(self):
                                                  suffix=".log")
 
         self.run_vm(kernel_path, kernel_command_line,
-                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
+                    self.plugin_file('libinsn'), plugin_log.name,
                     console_pattern)
 
         with plugin_log as lf, \
@@ -100,7 +105,7 @@ def test_aarch64_virt_insn_icount(self):
                                                  suffix=".log")
 
         self.run_vm(kernel_path, kernel_command_line,
-                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
+                    self.plugin_file('libinsn'), plugin_log.name,
                     console_pattern,
                     args=('-icount', 'shift=1'))
 
-- 
2.47.1


