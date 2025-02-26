Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50757C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI16-0001Ab-Dv; Wed, 26 Feb 2025 09:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0y-0000yc-Ek
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0u-0005g0-9q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:55 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390d6426f1bso445167f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578630; x=1741183430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4T7qADBX2s2Fmrza40t6zH7uyjAjt7nMEfkiyQvl/EM=;
 b=jiIuGRQUdwjvryEmr4ySts6LfmGPW+bnZasa90VZ4zRXSwLanBNy4eM4JW0By3XK5b
 lKTyJnjFf2WsZujGweuDmgc0emxN2s6TJYJfrwRV/mSJgPffxPjYEQIOIQQ6oRPNcJhg
 AcGFb6m7Xf4rFYREDoTd8H81d5eB1ehSXvQRnQJTdL6i9tnQdJDy5bCaUlqWWM87yIpF
 YG+cJXodxWqLQYgBwjdJygjDQ5BxLBYz4DHKF7GA554LFYG7np0oMh5w8MUVPfaynG4b
 F0mb3IBwK+tEJaJsdXQWCMr+ms/wtN9+OQ1WYVJFqNB7OMZvadIl8ibHPb9krnvE9cls
 7DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578630; x=1741183430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4T7qADBX2s2Fmrza40t6zH7uyjAjt7nMEfkiyQvl/EM=;
 b=IbtYyrUOrnXH5ixVgo1RW+5I1vMbPWYnuZfrY4mTIsB0ete7REa++4+7zV9PXOUSL1
 3uB1J3E11eCk/icumgw+Cw6GEjsHZMW2z+RJ3VEOpFm36QFy8NIsnxNH4Jnavhu5rLGw
 iF/1BstpxHXP0ZF5WSZnVt82bbYsCgIvNYoQnwMLVQz2zA8rAJALgr4+QSz0CtpRRytt
 i7xoQcb6bqDRc7a1IjY15i2e7Iyr4DaNC4uw8bfOIetbCw+EAybBjlYUz6qp17UiElgx
 yt5T10IDj/xn77ZqufIOJWWs4HSehBE+UhiaaaKqM4wCzbzZm0jdYi8IP0aG7/K3u3ml
 nZjw==
X-Gm-Message-State: AOJu0Yx4g8BytfU+cwHftbU9ElYqAWHRG1oM271GRsoulwVRRhLdI5M+
 E96Dg5YATg5HIy5GfA91y41Gnu5dCbsaDp+AbDH7pOi7Al1ThBnB+IwW1SLVQWw=
X-Gm-Gg: ASbGnct9WBmgueyNRPzz2KNixEtB9BNNUU8+/nh8okipoRHXei1j4ucvhvXBd/D/hMh
 5AwIhFjxktqRHmq5f8ZUFU8mtR1xaA6MQhhax/1iAFsQpiog1MVsJVi8krTJ9GOvzlApdxcxuah
 fQwiAH04MPCIicZ84zpJesDIM3IEgD2O2rDc/MCo6z7hwCtr6RQoS1kJ/kTXXHabVixiHBcRx9t
 My+hpYO5wQ+9rtm9cL0yAOmScG25UxbsCEKZm7YM5hqaMMhq0f57rqpoci0r+mgEW4S4MbOFX/Z
 eaE1qsnH/9w9xI3oUNKF9EYJ2DJ2
X-Google-Smtp-Source: AGHT+IFFq+LDR3XWqvLyK0Evpdgpb9outaHj8uJEofpK5TlLiFPf6u5Lnu3bfO5KEcvXCmqaFV1OGg==
X-Received: by 2002:a5d:6d0a:0:b0:38d:dd70:d70d with SMTP id
 ffacd0b85a97d-38f6e947399mr19918943f8f.18.1740578630071; 
 Wed, 26 Feb 2025 06:03:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fbcabsm5610553f8f.86.2025.02.26.06.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C5AB60342;
 Wed, 26 Feb 2025 14:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 07/25] tests/functional: Allow running TCG plugins tests on
 non-Linux/BSD hosts
Date: Wed, 26 Feb 2025 14:03:25 +0000
Message-Id: <20250226140343.3907080-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Not all platforms use the '.so' suffix for shared libraries,
which is how plugins are built. Use the recently introduced
dso_suffix() helper to get the proper host suffix.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2804
Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250220080215.49165-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_tcg_plugins.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
index 7e8beacc83..5736b60545 100755
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
2.39.5


