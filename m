Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD431CCA472
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66IT-0002XY-6b; Tue, 07 Oct 2025 07:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IH-0002Wd-98
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I8-0001JN-0S
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:48 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so47833315e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838134; x=1760442934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOYws5ztIvDTyeWr9H4GMoPFZs+WHiESwz7nO5pdJNo=;
 b=DDjualMESd+Y2ZOuSHLL65aMOm6DJ+eoE7Eafexo8nh33AigTjgYdiXaBwToj5C+7K
 PVkQDHHYwGSlYdm7y5vnVUVQQ4X2ztVQed2otlW39cw44npy7unvIfPWIalHAl8zRA3f
 sl/knoLyrC9Zh3lO6x9+MC+FfSqZa2QRrKcHHNkbxaQ+6QObhI+SDTvyZoIIjz+aC6l+
 u4ueoY8VTTpKTRzH62RGwMQd5OJJc1cVgmI3k/Bikl8oTSTf/eKz3590zIh2WvIDu9WS
 se7F6MbDJTA1pRPdfMsWtXLnMxkOGrtyk9Ik4gkpjhmTYv4j0pLO9SZ4bh3/AU+OUp8a
 jvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838134; x=1760442934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOYws5ztIvDTyeWr9H4GMoPFZs+WHiESwz7nO5pdJNo=;
 b=DUPQ5cdonAMM6NMYesCwITXnH0CjF9ltBqFwkAo70pSAx/GHsZnYwb0n0Xqngj3H+z
 JEwRFESCp0P0l4WgeRg2DzxU1j+qJqQM02RDjuKcIpxXQB8rS9uvytF9lpT3ifoHaeNg
 BPybjD0qOqLl0DubhkHcDn9WINWZkPm5S7wWTn7v0netHxXwNc/VZ5+wJz5bW3cyBVvo
 QSA1RdG/4Hp5FJAzI/9NGYDSg209GMCdIlG4wUj5UXGLxnuzEbY8jrdzvh369B59AlVb
 6bJyn8h6JVTi4BUSABmPjLttrtffRZxGiZ8qxZ8UTrWEyOUIgb3BCgQG2lxQrY0hzSEx
 /jtQ==
X-Gm-Message-State: AOJu0YwLyIN6G/O1477dxCewNOJ5bynxhYiKX9+3+I2rkZJ4jJY2qVzV
 xmSTTDBofeyuIfhjk8vbDpC+KJILNYtvZuEmafUr8MN0CP7snVXLHXhiMigfDKKE5nxQPE6zbcw
 1yFSh
X-Gm-Gg: ASbGncuRCaDVYG+YGOfg7eDJDiixusbGcJeUTWfnjrSB//0rCCen3qdcj2l4izu7nnP
 BpO4JCSRckn9HUASWzU6RnHyn++zuTUVa8K1IAyMBLsqxpqdUKHaKg7iYPoTKaUAXScFRwDOjXR
 bvQ/9UH42nbSb2O+O1exQFzJr0eb1eylWQ1q9RoPS4MQBHkUTfSThwru3xYvz/q+UwmYo4KpLvA
 hI2AlquEZGWZZD4HX9I9uJBho3g7rNmHMFcLv7vxP1gVRoy2eZJvBD/GRKJ4VCNlJC7AZiSrbwC
 FSzZtV335cS5PBBQp4HorwrZAdo4pjkR10QLmBiPA/0EWLoHqssnrWLxndnLH0BCmKAeG/7OkHJ
 hjTjno05vyze24Vk3ICjnGV7gE0nJBVTCdCwEhO5zLwhSsax/0tE=
X-Google-Smtp-Source: AGHT+IEuImiC1lFGxOxnzNMYUUyG3NjqOE6G2cztgRSxISQgSJjgqlJARhKH8qfBOCb5JZj9Q7pKNA==
X-Received: by 2002:a05:600c:34ce:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-46e711408b5mr114773115e9.18.1759838134355; 
 Tue, 07 Oct 2025 04:55:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6b23d4c5sm241800745e9.17.2025.10.07.04.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E901F60376;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/17] tests/functional: Add GDB class
Date: Tue,  7 Oct 2025 12:55:19 +0100
Message-ID: <20251007115525.1998643-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add GDB class, which provides methods to run GDB commands and capture
their output. The GDB class is a wrapper around the pygdbmi module and
interacts with GDB via GDB's machine interface (MI).

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20251003141820.85278-5-gustavo.romero@linaro.org>
[AJB: trimmed excess license text]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 6e666a059fc..60d19891bfc 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -18,3 +18,4 @@
     skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
 from .archive import archive_extract
 from .uncompress import uncompress
+from .gdb import GDB
diff --git a/tests/functional/qemu_test/gdb.py b/tests/functional/qemu_test/gdb.py
new file mode 100644
index 00000000000..558d476a682
--- /dev/null
+++ b/tests/functional/qemu_test/gdb.py
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# A simple interface module built around pygdbmi for handling GDB commands.
+#
+# Copyright (c) 2025 Linaro Limited
+#
+# Author:
+#  Gustavo Romero <gustavo.romero@linaro.org>
+#
+
+import re
+
+
+class GDB:
+    """Provides methods to run and capture GDB command output."""
+
+
+    def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
+        from pygdbmi.gdbcontroller import GdbController
+        from pygdbmi.constants import GdbTimeoutError
+        type(self).TimeoutError = GdbTimeoutError
+
+        gdb_cmd = [gdb_path, "-q", "--interpreter=mi2"]
+        self.gdbmi = GdbController(gdb_cmd)
+        self.echo = echo
+        self.suffix = suffix
+        self.prompt = prompt
+        self.response = None
+        self.cmd_output = None
+
+
+    def get_payload(self, response, kind):
+        output = []
+        for o in response:
+            # Unpack payloads of the same type.
+            _type, _, payload, *_ = o.values()
+            if _type == kind:
+                output += [payload]
+
+        # Some output lines do not end with \n but begin with it,
+        # so remove the leading \n and merge them with the next line
+        # that ends with \n.
+        lines = [line.lstrip('\n') for line in output]
+        lines = "".join(lines)
+        lines = lines.splitlines(keepends=True)
+
+        return lines
+
+
+    def cli(self, cmd, timeout=32.0):
+        self.response = self.gdbmi.write(cmd, timeout_sec=timeout)
+        self.cmd_output = self.get_payload(self.response, kind="console")
+        if self.echo:
+            print(self.suffix + self.prompt + cmd)
+
+            if len(self.cmd_output) > 0:
+                cmd_output = self.suffix.join(self.cmd_output)
+                print(self.suffix + cmd_output, end="")
+
+        return self
+
+
+    def get_addr(self):
+        address_pattern = r"0x[0-9A-Fa-f]+"
+        cmd_output = "".join(self.cmd_output) # Concat output lines.
+
+        match = re.search(address_pattern, cmd_output)
+
+        return int(match[0], 16) if match else None
+
+
+    def get_log(self):
+        r = self.get_payload(self.response, kind="log")
+        r = "".join(r)
+
+        return r
+
+
+    def get_console(self):
+        r = "".join(self.cmd_output)
+
+        return r
+
+
+    def exit(self):
+        self.gdbmi.exit()
-- 
2.47.3


