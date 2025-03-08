Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F7C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr274-0003JD-6R; Sat, 08 Mar 2025 16:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr270-0003GN-5A
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:38 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26y-0000vj-2H
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:37 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so1581303f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470814; x=1742075614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bx+oIRZTzQSfOA5NYqkM6PIAwaVGgxdotXJe0o6oYIE=;
 b=gSCYxwhDzn/LapZFii909z48hl3XdqxVvSBhZarbaEYj7qM1EZNNlUN+M5qp4Ee2Th
 gvetwp34HerhD27wFb0PHxcWXsy/I8myVnDFYlwTlHvrFTBCCkSwwAkU9EBrAoz0eh2v
 0mFJ8TDqD1uKahg8bIxO0iA3K2/fmhSKh+0WOpCnfan6e7NXM2T8cRcWyAV8JdhaxwDC
 k+RDi+su2ZsbCodI0oY/zk7DW9oRzK8gGufm9GjDYiUscv9puCJVdanPo0AJ1e94MSan
 8sJh8axWOyrExJx2dXPXB0nJbgiGSO4odr8IzJFDwx989bsBk3ZdsHoq8GhfriLvTILx
 FpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470814; x=1742075614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bx+oIRZTzQSfOA5NYqkM6PIAwaVGgxdotXJe0o6oYIE=;
 b=ZlaxgmvquO8yfgZsERcpwjGHfS8Dhx2Y4CA3V10sYX0wWF4pp2e503I0dLGa2Q8fo3
 SdvWyOnxW2tn62a+I69Ot67BnVcT+ygpnAmC+AUbywV96TIFtFdaZZa5+L/BOqPqImVp
 E/S/xFe4X+5Jdq+zGlpVcK9ttBgyGJglaW8ly8DTfOmRg5q/nSK1sZCzVeiNbvvOnp90
 6PBPm+S4qucl1EcMy4nm3o826sMB2Op3aXtVEYkjsOlbItvsJT/D8IDlLIQo+syssW9s
 6la1Ye9N4GQm5q8Nyq4qLKM7jXjrSEgt95CL7BTBeEpZpFGa1Jv2hoEjg6MFjmGYOjJX
 JPZw==
X-Gm-Message-State: AOJu0YzseRrdOMEswiaQcd5dW87mFtovekAvuMsd4LSztUPANJxtNpJN
 /L5bEwNkMItAxzojgleYIMJMWNBnsQDawWx1GeX/D511tW9Bq849GvcKiPxa7Ns=
X-Gm-Gg: ASbGnct2jXk6LE2m0DCCAk+kUWSYD+pUETnSADpCalXGIesT8cRqVFqMTbqy7+PHRsV
 UJw3jhr0zrZHsh5VM66x2jQAGe7XSUa9Nk8Y42C2MBrjH5Y24fJEK6NIa7aJsOFZkpAUUBZYNmJ
 a8UAyMb5EquffykaXia8EB4hnGYTEtgcl5N7m4YegHjbaYt3P6tIm7tOlzjwDPht03R50ZNzqTY
 PulPYwd4ihSO3+3KrUf+yrjw2TRodMNt2aoqZoUEd7TJUqZhM6pH1E0S/WhG0yTtVE8bi9OxFLX
 29ti6TNEDKLZji8nrEbEkj6isn0KwhAlRCRytcRIxkh+/a0=
X-Google-Smtp-Source: AGHT+IHfCo2He5JEAGesCW01Dx4OtdGKnW0hvnnB8y5WkHGKMfOOdyLaeTpLmvKy8ZmQehcDCvp+og==
X-Received: by 2002:a05:6000:1545:b0:390:f9d0:5e4 with SMTP id
 ffacd0b85a97d-39132d513c9mr7170501f8f.21.1741470814355; 
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42b7245sm125155525e9.17.2025.03.08.13.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 77E18603EA;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 10/31] tests/functional: Allow running TCG plugins tests on
 non-Linux/BSD hosts
Date: Sat,  8 Mar 2025 21:53:05 +0000
Message-Id: <20250308215326.2907828-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
[AJB: moved plugin_file into testcase.py]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-11-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 869f3949fe..9e1839586b 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -27,7 +27,7 @@
 
 from .archive import archive_extract
 from .asset import Asset
-from .config import BUILD_DIR
+from .config import BUILD_DIR, dso_suffix
 from .uncompress import uncompress
 
 
@@ -184,6 +184,16 @@ def scratch_file(self, *args):
     def log_file(self, *args):
         return str(Path(self.outputdir, *args))
 
+    '''
+    @params plugin name
+
+    Return the full path to the plugin taking into account any host OS
+    specific suffixes.
+    '''
+    def plugin_file(self, plugin_name):
+        sfx = dso_suffix()
+        return os.path.join('tests', 'tcg', 'plugins', f'{plugin_name}.{sfx}')
+
     def assets_available(self):
         for name, asset in vars(self.__class__).items():
             if name.startswith("ASSET_") and type(asset) == Asset:
diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
index 7e8beacc83..4ea71f5f88 100755
--- a/tests/functional/test_aarch64_tcg_plugins.py
+++ b/tests/functional/test_aarch64_tcg_plugins.py
@@ -13,6 +13,7 @@
 
 import tempfile
 import mmap
+import os
 import re
 
 from qemu.machine.machine import VMLaunchFailure
@@ -74,7 +75,7 @@ def test_aarch64_virt_insn(self):
                                                  suffix=".log")
 
         self.run_vm(kernel_path, kernel_command_line,
-                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
+                    self.plugin_file('libinsn'), plugin_log.name,
                     console_pattern)
 
         with plugin_log as lf, \
@@ -100,7 +101,7 @@ def test_aarch64_virt_insn_icount(self):
                                                  suffix=".log")
 
         self.run_vm(kernel_path, kernel_command_line,
-                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
+                    self.plugin_file('libinsn'), plugin_log.name,
                     console_pattern,
                     args=('-icount', 'shift=1'))
 
-- 
2.39.5


