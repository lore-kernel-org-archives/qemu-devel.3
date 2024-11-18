Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81478D591B2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 20:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD8Ys-0001U9-62; Mon, 18 Nov 2024 15:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Yq-0001Tq-F1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:28 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Yo-0002NO-Hi
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:28 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cfcb7183deso2202391a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731962484; x=1732567284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHplRik/YcnR60UB43A7Gp9H2sYINST0OAHvGPPuMSA=;
 b=acvYzKnbD+BXmYCUeI1WBKGIMbq0Bwzf7Yc3d8JtV1raLgYx97VNXeOpWj6JiJaYeH
 C7b/dcbuYBGfOtfgPFTV+WrRpvA6CCBBzKgpABzUYIj8t7RhQZISRmrHtAL7lGmT72JS
 bYa0bWvBBSsKMUK7C+K8D9DxDLfOVWkq9sT5pzdzc0oqDnFVcuMuUuSD+k+xT648TB2k
 gBzVA1HRx+bqVYDmPu5e5grGaC2NYRXn/OTo/mh4P6M7guc2X12fJO/E5LhpzUfOcFFW
 pO7ldWovVvyriHR3MexccP91y2ZLDfqFeJQ90LKlUDRur/N67vMqpj3kP/byHfr5LN9x
 +WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731962484; x=1732567284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eHplRik/YcnR60UB43A7Gp9H2sYINST0OAHvGPPuMSA=;
 b=UR86IOkPYbggMCVLPkwEZCXKvmrSop6QJ3AVbD1zMUkmsPUaxTCs4bz6grrQFNucTg
 GIo/7SDwKkcK/U8S7RCHUGVqqgBCIyv5nWxCkOjjXYood2Qe6mRk1LvVXNhLNCElxRjH
 InH57YTvey8dCojyANedNQDyLUFQe5x/EGek4g6vud9t5wTPhZIlv9ysk+9/3dIt2JjK
 5GPHJRguoDuI1Bx+KG3WW/ZVrYpbfnFwxx14oE4GA7NFA+wU0er09iw1lKpRXuSMPfVa
 VDK01L1pWFg7P4idexJV9QMQRoV39BWBxZLP/GNIHABbSkL89UnQH7jOMizFwuQjSCoZ
 DM5g==
X-Gm-Message-State: AOJu0Yxi8mLAXXplyJ0f8Nh2R7BfDH8b6kCM975Ry5+elWuNJojfMFPP
 i4kd/FrjQ4sDeop0raXktVj7R9lfqvxgtIlNfubIYi16/uMAgyffAtKHuhaDbeo=
X-Google-Smtp-Source: AGHT+IHSZTPpMD1xwncPVNmStBGMBG/0LbJF37QW2VIFds0Bat3Vr/oKbEdnHgtRKiu0KWTRsRGQQA==
X-Received: by 2002:a17:906:4fcb:b0:a9e:eee8:4947 with SMTP id
 a640c23a62f3a-aa4c7e256fbmr67195166b.9.1731962484533; 
 Mon, 18 Nov 2024 12:41:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df56b1esm574306066b.71.2024.11.18.12.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 12:41:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37DDB5F8E9;
 Mon, 18 Nov 2024 20:41:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/4] tests/tcg: Stop using exit() in the gdbstub testcases
Date: Mon, 18 Nov 2024 20:41:20 +0000
Message-Id: <20241118204123.3083310-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118204123.3083310-1-alex.bennee@linaro.org>
References: <20241118204123.3083310-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

GDB 15 does not like exit() anymore:

    (gdb) python exit(0)
    Python Exception <class 'SystemExit'>: 0
    Error occurred in Python: 0

Use the GDB's own exit command, like it's already done in a couple
places, everywhere. This is the same fix as commit 93a3048dcf45
("tests: Gently exit from GDB when tests complete"), but applied to
more places.

Acked-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20241022113939.19989-1-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
index a715c0e3f5..4f08089e6a 100644
--- a/tests/guest-debug/test_gdbstub.py
+++ b/tests/guest-debug/test_gdbstub.py
@@ -10,10 +10,16 @@
 
 fail_count = 0
 
+
+def gdb_exit(status):
+    gdb.execute(f"exit {status}")
+
+
 class arg_parser(argparse.ArgumentParser):
     def exit(self, status=None, message=""):
         print("Wrong GDB script test argument! " + message)
-        gdb.execute("exit 1")
+        gdb_exit(1)
+
 
 def report(cond, msg):
     """Report success/fail of a test"""
@@ -38,11 +44,11 @@ def main(test, expected_arch=None):
                    "connected to {}".format(expected_arch))
     except (gdb.error, AttributeError):
         print("SKIP: not connected")
-        exit(0)
+        gdb_exit(0)
 
     if gdb.parse_and_eval("$pc") == 0:
         print("SKIP: PC not set")
-        exit(0)
+        gdb_exit(0)
 
     try:
         test()
@@ -62,4 +68,4 @@ def main(test, expected_arch=None):
         pass
 
     print("All tests complete: {} failures".format(fail_count))
-    gdb.execute(f"exit {fail_count}")
+    gdb_exit(fail_count)
diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiarch/gdbstub/interrupt.py
index 90a45b5140..2d5654d154 100644
--- a/tests/tcg/multiarch/gdbstub/interrupt.py
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -8,7 +8,7 @@
 #
 
 import gdb
-from test_gdbstub import main, report
+from test_gdbstub import gdb_exit, main, report
 
 
 def check_interrupt(thread):
@@ -49,7 +49,7 @@ def run_test():
     """
     if len(gdb.selected_inferior().threads()) == 1:
         print("SKIP: set to run on a single thread")
-        exit(0)
+        gdb_exit(0)
 
     gdb.execute("set scheduler-locking on")
     for thread in gdb.selected_inferior().threads():
diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index 7e264589cb..51082a30e4 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -5,7 +5,7 @@
 SPDX-License-Identifier: GPL-2.0-or-later
 """
 import ctypes
-from test_gdbstub import main, report
+from test_gdbstub import gdb_exit, main, report
 
 
 def probe_proc_self_mem():
@@ -22,7 +22,7 @@ def run_test():
     """Run through the tests one by one"""
     if not probe_proc_self_mem():
         print("SKIP: /proc/self/mem is not usable")
-        exit(0)
+        gdb_exit(0)
     gdb.Breakpoint("break_here")
     gdb.execute("continue")
     val = gdb.parse_and_eval("*(char[2] *)q").string()
diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 0f687f3284..6eb6ebf7b1 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -3,7 +3,7 @@
 This runs as a sourced script (via -x, via run-test.py)."""
 from __future__ import print_function
 import gdb
-from test_gdbstub import main, report
+from test_gdbstub import gdb_exit, main, report
 
 
 def run_test():
@@ -12,7 +12,7 @@ def run_test():
         # m68k GDB supports only GDB_OSABI_SVR4, but GDB_OSABI_LINUX is
         # required for the info proc support (see set_gdbarch_info_proc()).
         print("SKIP: m68k GDB does not support GDB_OSABI_LINUX")
-        exit(0)
+        gdb_exit(0)
     mappings = gdb.execute("info proc mappings", False, True)
     report(isinstance(mappings, str), "Fetched the mappings from the inferior")
     # Broken with host page size > guest page size
-- 
2.39.5


