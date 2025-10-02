Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEC2CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48ha-0006rb-IS; Wed, 01 Oct 2025 22:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48hV-0006rF-H4
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:45 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48h0-0004ri-O6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-279e2554b5fso3540185ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 19:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759370704; x=1759975504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uAT3E/Kg+tLMQ6sh6TKZYgCxOSeXpVcn46MFwOuYCs=;
 b=p7R9eEeuaKNOo9pHAeomS81x3KQNAum4TDRrzIxO+WUgotJ5y3epdI4FoI5cAKk3Lu
 +x+e6LmAdFsjKNpOdOSPg9y+fN8l/TECyv7M3WWLaR2I6h2tdd1LmDvx6IrBdmWp5oHB
 rbxRWCZ5zDv+qngBKkSYE7tk/sotS9gfGfI9vgJ59Ax+ajcXUETkMNlDHKylnos5tfn8
 nsEaSKB84aD2mh0ZcfCPaufI5ip8fCQ3sTpX/+fL312W8/863++liyewzEvKkWcotD/I
 lzlACm2NyUyZMpbCuBE6RlAoXeHm4IeYyXKe1FFfvMkc5XvJ9RtYV57rLPldwLAVSfkg
 /0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370704; x=1759975504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5uAT3E/Kg+tLMQ6sh6TKZYgCxOSeXpVcn46MFwOuYCs=;
 b=F9NEeVeHsAxp+8LzBjERJ/f6Qof/95TUL0mn+XSQJ19dz6sOvhz5F83k2s5cH6ptVF
 XZSa4sJHGc6+G8y7MOaTHFMloXKbA6iBQBgQ8klzRRO8hQvvXpBcJrjUwIO/CuKurHv/
 pNGIKwU/A40xc0MWVpSi2NJNVo7RUOF5QXX12jyUNMijP2Q2hrQCwylk+axvubwPU8f+
 E4GgPfvyK06S/S24LIRv7s9NX78srZYCFDRYmsDEqo6LmAwZDA845Qr8mUclC+hQWuj3
 smIZSfPC8UgTdHeZoY2XNb1WTc6duav08agZcmjMxJPd+9TyQpgtWZK83peN8ncpUKOn
 MNpg==
X-Gm-Message-State: AOJu0YzV1f7/KAeVDa/xfieone0cgcAsGzocaTzbJ/z3IxFXIfRxaLvA
 NyXumkbKzVUM++tWwgFnrJX91k7bAvpnzX8It/Kk/Mf2lcCId9/T4Gn46+M23VP9rA71xWx/fQq
 cFHLQ
X-Gm-Gg: ASbGncsWW8N5mLC1VhmYVYiwDhJuB4Y1hrAFy3GqvAjo23arqNvO6w2A81couDBuhte
 KSzUQJa0OeSiB/v8UXRYUtQUThOCnlnaqrdVjFB3fGoCMrvlZrHyVfWAWakgfEArhghFXWDO0OF
 nAw7A1gKNqyaw0b6cCIHvacl2uItxOqTZVQMbtNLb4ZRqKe7UAOPYgkuaWPgr2QwzSutJNfiUWS
 gNcMbljWW9JFL14ps2CmJ0P/lo/cRBQjKyZk9WuJd9RLpA/bXT+ZDZl+hqb4+Q7Banevbyok0ar
 h8COaq2L9stRtZu0TW77HfFrKJ18MKFef1RzTYrDQe61Z3mv5hFB1MKRvvOZhIvCjc2skeFV7cA
 U8WFxJS0nFE4n3Hqoial23y4LbybpS9LHlqykCFeQuZQn7pdpCvR/VJF3TX7S20ArYOo=
X-Google-Smtp-Source: AGHT+IEKosOT0oxwORek+RzgMxvBeBwXw7xTc63LUvRgecNlDLdEXpxVa9SLa1xiQO6IYkGfw/CQxg==
X-Received: by 2002:a17:903:3d05:b0:262:f975:fcba with SMTP id
 d9443c01a7336-28e8d040b78mr15780655ad.9.1759370703536; 
 Wed, 01 Oct 2025 19:05:03 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d95bdsm9476735ad.119.2025.10.01.19.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 19:05:03 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 4/9] tests/functional: Add GDB class
Date: Thu,  2 Oct 2025 02:04:27 +0000
Message-Id: <20251002020432.54443-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002020432.54443-1-gustavo.romero@linaro.org>
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add GDB class, which provides methods to run GDB commands and capture
their output. The GDB class is a wrapper around the pygdbmi module and
interacts with GDB via GDB's machine interface (MI).

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/qemu_test/__init__.py |  1 +
 tests/functional/qemu_test/gdb.py      | 88 ++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
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
index 0000000000..05e4c29c2a
--- /dev/null
+++ b/tests/functional/qemu_test/gdb.py
@@ -0,0 +1,88 @@
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
2.34.1


