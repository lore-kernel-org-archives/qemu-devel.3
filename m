Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2C4C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiS-00073L-QU; Tue, 04 Mar 2025 17:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah3-0005Q6-MZ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:59 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah1-0006Wn-Hz
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:53 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaec111762bso1130210066b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127090; x=1741731890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1m7U5T2uale0lc0uqyyH6LsGapDRMZw5OtaQwPrcJTg=;
 b=jt0/O/CJKSS1ZPibu2DkN1vh4YyEXnJyv/ceyw3/aaFW4f/SEGXCzjZv3s/+G9RkDW
 ZcmK6KmYGzo7P7V/kGZ0vA9LVoJF9eBC3uZL5Dd7PlxdlMEMqjUsALOgqZkFQX/NOHpw
 ZruesjTGuBN/gF3ReQMcjjw14qacXeQTuczdp5g7bipF9ZMBNOXHYB9Kp6RvHGyeQdM7
 JeSFEJl/DoJNAUNJVzbpmRLX1tRIiHLMGcaX4rtmvyo/oi3ykHaUnDFosHzJkAHlwG4c
 B6dntzOgxGKk/SEumK3z9u5UfryQQZKpWmAVjLV/avhFiC2FveSJApHpmCl3h80c39/P
 8tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127090; x=1741731890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1m7U5T2uale0lc0uqyyH6LsGapDRMZw5OtaQwPrcJTg=;
 b=CvE51kTAsnBX52U/ugl5N6vEu3nqX2EvdtKn65FZs8TN+Yi+mb1Y4bpGU+2AV3U3AB
 nIUcsYG4sKGBaRplhxTn+0xXD8SyEz0/gEY1Rd+j14KYxz0vh7wWA0A8tZgadaAEBKsP
 Q41rgPjDg0D9LBVUZnPcO91I66TTzDCyUELPyv8FnZsi/FMfCWq5H0OX84RqoqLv3djn
 bzb+Z4Yyxhv+3hY6K+xSL06XLAgKulI+kT3qnO3+xdtK1bupZpHoTAYK9CKQETErYFPj
 IIPlRCbU2wnbDNjR432f2EEb17iGHIHB3muIFT9knGr9MweRoq0Bqtb/8hL7pbD/s9E9
 6g/g==
X-Gm-Message-State: AOJu0YzsRJfqXxIUPib/RVUqvJ++iINODxAa0gxoMCkqeA3IRGbZfCnG
 7trqK/Q5gKDZUZfmawAnUzXnYsgWjnaqu8uxTxEY0OPOV5A1oDtyY1CvGracQXM=
X-Gm-Gg: ASbGnctM39iS765xD1WoDp/6R0FO1eNOjOKbdfWVkCNePshdNegTgebklkxYng+20b7
 SetfhNMq1gmQ7dFWiXoptbYg1J/7sZKUSoWCCGdiTCr+VmgXc3gHFDCgVidHVdo5Gm4gEWzR0N0
 9Sr/Ck5bv8ftGdiBVubnjSW+/N76l75cXr0qFGAWRgdcA4ovsnw2hs9/U7pbBzWcSlI9rlhM31A
 I8m2nohFj7raGrJPZG8PayqTDzolgzrTqnyWGQ5gF+j6cY/rZ/0nVdtxpkCySFzNc4XoMAUxgLw
 y1VZUczwum06E1KTvbhoBTNqKhgMdVAaAg237tW94fKVFPE=
X-Google-Smtp-Source: AGHT+IEuMR7Wd7JAxrWkuqD1t6ByZlhYjg78nYqXd4BXh0YARSLQVx4IS0+QDcAy4mScCVqyWNahJg==
X-Received: by 2002:a17:907:7f8e:b0:abf:6a53:2cd5 with SMTP id
 a640c23a62f3a-ac20dafc718mr72673666b.48.1741127089633; 
 Tue, 04 Mar 2025 14:24:49 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac165223834sm342885866b.165.2025.03.04.14.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5873F5FD7E;
 Tue,  4 Mar 2025 22:24:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 10/32] tests/functional: Allow running TCG plugins tests on
 non-Linux/BSD hosts
Date: Tue,  4 Mar 2025 22:24:17 +0000
Message-Id: <20250304222439.2035603-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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
[AJB: moved plugin_file into testcase.py]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - move the plugin_file helper to testcase.py with the other path helpers
---
 tests/functional/qemu_test/testcase.py       | 12 +++++++++++-
 tests/functional/test_aarch64_tcg_plugins.py |  5 +++--
 2 files changed, 14 insertions(+), 3 deletions(-)

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


