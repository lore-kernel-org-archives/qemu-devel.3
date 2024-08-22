Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87F5C5321D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5HK-0003Nj-Hk; Thu, 22 Aug 2024 06:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5HJ-0003Mk-0T
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:42:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5HH-00019q-CN
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:42:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-429da8b5feaso5881415e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724323369; x=1724928169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tf5HkEASfWzSVkOHOTgGoEk72uRFvrW6k14mphVk1H0=;
 b=ANf96sQMZBvQbIiGnmhb96fuw2QP3naQWMHOEnzHZxZzHdlYVabA5PtjW9tEf5HIDU
 Ppl8C50j37JMlIA0GnywSoqfOWMn0sQ5ouB497Ok7YIvHyEsJ+AzBCp7q0uiRcsgIMbT
 do04FxUMGDrkHfKKkZh//OU7N0XpKPboZaK4PKMEYfvfqCJ9TeW4Vflt7mdwLzZgomt/
 d7ofp88qOJcZK74zg2Q8TEqkth56I/E1mp7XO3alpD4F4CalHPsswNJBc/b6hMqgeJ0h
 DFBkXDbFxQFb7U4I1S+fGp+c6Hm7t+Ds+jnQJptNJ/qMrSJEaVHhftl0SKUzF3xJ0isE
 ic+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724323369; x=1724928169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tf5HkEASfWzSVkOHOTgGoEk72uRFvrW6k14mphVk1H0=;
 b=LPujlFdlQrmlDe6PAlMggYnNkakBZCnanj2IYs+EOJ5N3QeHCsDRXUpXjQth05K9J1
 +4TztJlMXAreC3/8t3QSBWt1xjefRIzD9GTqxLzDQb5G9EcwbtMXXIb80dj6oxVhzWUy
 GXgtL/1c0dk3aAb3DcCJ6xOBdVCgW0B7feFpMhxXqJy4gwfA2nwMl6CfPiudyxyeZxy0
 i4SHBNDawUDIm6SYo1XKRNLofAbcPoTZ+Mhj9Q5T2CfzHKlRfLJ2U1y1tvdg4gBp4J//
 dP1Wv7V1g5vEE6Y4zS4tbktFIyfPcfjqOnRCZpcWf0l4AUSAXsGJgE6YBlE2uA/E0Yv5
 1LFQ==
X-Gm-Message-State: AOJu0YzM+ZEYa9PTBJlQJ7f4qH4tTa1PHmUWkza3EgD2wRDuTkhi8jHy
 4uBA+KI3xzPQAwIoYM2EyWyU553KXxNo9ib44DK44Sw8lTKj0NiCpQzPPQdd0KWfQnzOZjwmiFU
 s
X-Google-Smtp-Source: AGHT+IGkmIw0oBJY7sc/5az8852481Gnh6aba4tZdmtjwKNv7+On97E4XkPs+vguyUWlzMRyVVyQsw==
X-Received: by 2002:a05:600c:1e8f:b0:426:5e8e:aa48 with SMTP id
 5b1f17b1804b1-42ac55dfe1cmr13537755e9.22.1724323369120; 
 Thu, 22 Aug 2024 03:42:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac500e119sm20623675e9.0.2024.08.22.03.42.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 03:42:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 1/3] tests/functional: Add QemuUserTest class
Date: Thu, 22 Aug 2024 12:42:36 +0200
Message-ID: <20240822104238.75045-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822104238.75045-1-philmd@linaro.org>
References: <20240822104238.75045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Per commit 5334df4822 ("tests/avocado: Introduce
QemuUserTest base class"):

  Similarly to the 'System' Test base class with methods
  for testing system emulation, the QemuUserTest class
  contains methods useful to test user-mode emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/qemu_test/__init__.py |  2 +-
 tests/functional/qemu_test/testcase.py | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index db05c8f412..6e9b017264 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -11,4 +11,4 @@
 from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
     exec_command, exec_command_and_wait_for_pattern
-from .testcase import QemuSystemTest, QemuBaseTest
+from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 18314be9d1..aa0146265a 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -13,6 +13,7 @@
 
 import logging
 import os
+import subprocess
 import pycotap
 import sys
 import unittest
@@ -70,6 +71,22 @@ def main():
         unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
 
 
+class QemuUserTest(QemuBaseTest):
+
+    def setUp(self):
+        super().setUp('qemu-')
+        self._ldpath = []
+
+    def add_ldpath(self, ldpath):
+        self._ldpath.append(os.path.abspath(ldpath))
+
+    def run_cmd(self, bin_path, args=[]):
+        return subprocess.run([self.qemu_bin]
+                              + ["-L %s" % ldpath for ldpath in self._ldpath]
+                              + [bin_path]
+                              + args,
+                              text=True, capture_output=True)
+
 class QemuSystemTest(QemuBaseTest):
     """Facilitates system emulation tests."""
 
-- 
2.45.2


