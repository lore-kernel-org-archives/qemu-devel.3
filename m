Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9206FCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20p0-0004nn-Tt; Fri, 26 Sep 2025 01:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20ou-0004lM-5U
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20oi-00060O-2g
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-27d69771e3eso15166115ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758863777; x=1759468577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmMZ8OavtJPqXFVQhgzCSfktwxUsbE5ixRVmorJ3R6E=;
 b=JVJsKNYs+rb99/2j+xBjBX+BIyrdsm1S//8gaXce3axo6pFjAkarkRHTMKufnecNWH
 4yjIq/HwMYpMdIR0Mtf4aLIKWvb2se2JaQqkYtfHwoPGeoc4kfx/xqfpErVtKaSYlHbM
 QQlkEbdLP/cl2lqGE/5Uty8GFJQxo7B2uVgefifECehbcPP0xAez5iKBxjDCHEmV1YmH
 VBhYloqHM67FjY1/JpBu0J55kybXRFLdoxbokFSovgfVOQf6GzyCR625SU7loE/DWOAg
 I15KP7n4NX63hzJbbJUYvOTr/c++DMaQZzzBdSJ4PVY77tyztruSLwW16v9MqcoAZy0+
 A/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758863777; x=1759468577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmMZ8OavtJPqXFVQhgzCSfktwxUsbE5ixRVmorJ3R6E=;
 b=a2q6iFPBcImoSZG1O2bAml1uZwxHwSPy5BTxrsyaKS9loyhXZr5XZ28vmSXS9f3xnG
 6ojj5Zrq68a03fs3KsnSDzTbmETdZM1vvfWNXVB9J2cDbqTn8Q9cmpLgEs6LapTjTdMx
 hh1YjJSIlw1TLZ/ro15SjSSOzcSP86/hzXPY++lMpJVKIZ/RMV/zLJu/idbwOuWMKs8Y
 tl5flTAOZ65kLPn1J2iq72grbZzb53Ke7uG3DQ/1quuFqIu0TXVpIzToaOD8oqAu70EJ
 unGoJ6078fQJ5jJvGFRLGJ3qXudhame1TvX1SSLKKW8I6cd2TAOxdxldV/XqcL1Ew5SD
 N1oQ==
X-Gm-Message-State: AOJu0YxxLgZeNHQ9TEYaDFQ2/Z5YEsjLkf5QBIf1TRyyJ0iP1/Obxvpi
 hiCu9LK3WGhGnCRJGbM3c3IfZXHO+uacJLJYPUI6MwFUGp7ZBUOKE1kwv35gLXUmJ5rrpeVOHVu
 djBRJ
X-Gm-Gg: ASbGncu59SMN0DhMRQmAlFMfVQWNquXvTPoX1PYef2ERB/Mf0M50SnvbjPsZsstxEL/
 +0pWeK0QWGJDrtS5CuwNImLlZDSdkKWAl6JwqBmJ6zx6KuoN+UG3QIIY+txBiZoYerGqTzgyFmE
 sHC/Oxsm2e8iXdQmBsWC5DtzO4ciTCNx23HymSjDeF6gYM7gkxx9BwO2n6XOC/5q/55wjJEbTUI
 py8tNRxq0t3tWmE/4mWekbnTkW+JxUCFqHKS9j47Y/XDIDu7EWAcOyMGTL5CBxx+1YoX5hYdhrJ
 ER2miuVnD9N+DAupOLfh8rQ2KnHEIzlaA5JLIOD7VsclkO4ADAQiGFr4qKZzI02SxHtFFyzYJdZ
 6aJPE0p4pZNkHjt5cZoEonnnNUOc/63pV7qA0jWoCOIPCheBx35fX2vXcGA==
X-Google-Smtp-Source: AGHT+IGz4CBWZEb5vkf9iuGypfPBXgcL/HApohmU/5SkQ2nu/NBWVYVaPmgYZwfxo/lXEN08sDH5tg==
X-Received: by 2002:a17:902:d60d:b0:269:8edf:67f8 with SMTP id
 d9443c01a7336-27ed4ab6084mr65626315ad.52.1758863777412; 
 Thu, 25 Sep 2025 22:16:17 -0700 (PDT)
Received: from gromero0.. (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed672a51fsm42160085ad.63.2025.09.25.22.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 22:16:17 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v4 4/9] tests/functional: Add GDB class
Date: Fri, 26 Sep 2025 05:15:37 +0000
Message-Id: <20250926051542.104432-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926051542.104432-1-gustavo.romero@linaro.org>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add GDB class, which provides methods to run and capture GDB command
output. The GDB class is a wrapper around the pygdbmi module and
interacts with GDB via GDB's machine interface (MI).

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/qemu_test/__init__.py |  1 +
 tests/functional/qemu_test/gdb.py      | 85 ++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tests/functional/qemu_test/gdb.py

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 6e666a059f..60d19891bf 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -18,3 +18,4 @@
     skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
 from .archive import archive_extract
 from .uncompress import uncompress
+from .gdb import GDB
diff --git a/tests/functional/qemu_test/gdb.py b/tests/functional/qemu_test/gdb.py
new file mode 100644
index 0000000000..15eb5eca18
--- /dev/null
+++ b/tests/functional/qemu_test/gdb.py
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# A simple interface module built around pygdbmi for handling GDB commands.
+#
+# Copyright (c) 2025 Linaro Limited
+#
+# Author:
+#  Gustavo Romero <gustavo.romero@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import re
+from pygdbmi.gdbcontroller import GdbController
+
+
+class GDB:
+    """Provides methods to run and capture GDB command output."""
+
+
+    def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
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
+    def cli(self, cmd, timeout=4.0):
+        self.response = self.gdbmi.write(cmd, timeout_sec=timeout)
+        self.cmd_output = self.get_payload(self.response, "console")
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
2.34.1


