Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF519D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFayt-00071c-Tr; Mon, 25 Nov 2024 10:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaym-0006wn-DY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:24 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaye-0002Xr-Vc
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:19 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so41719895e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548375; x=1733153175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HimKTyPFtW6rFT9usgI1bgC8yYLBliDU5dFu/UuBzj8=;
 b=dwBE04r7n8Wj1UDmfrkzJ7X7XEy0N1r++iI9cx1rJ8KpFkeFYIBgteLk6HMEpItRl7
 XyxDNECVEI0vUBEZsk6BrS2rUjL5V8nQ1JyY8DKE8Wcv4tynj07QgG6djlZRbuxBh4pU
 xN33s6d29O5zAQrTjd+4wPeyJbLReYyg6LR43Rh1mAQ+GV00oM6Hk/hByrDWkBOPu3h4
 3rN7QRhWAR644kqWe3NazRlDQpw0d0k5HAhNo5cR/ql+K7/xwd8BCWaqBtgTPlzb4tsx
 qhySA1xJWNXh2fqAC0iRpT0jFhQR7zuhrrdzbfV9lCfVuk1Ob2qQmltjAb/XmBOEw9Hc
 y18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548375; x=1733153175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HimKTyPFtW6rFT9usgI1bgC8yYLBliDU5dFu/UuBzj8=;
 b=IIRx889dQ892DgDHXSWX3+hyrQXFrhCk2LSj917Zale0+/4hQEUSCbDxd8Hn5DlAeG
 qilr4vfuwUDmb4am4Fqhwrt7Qt8LGKj9oVxN4EGdNipiUQCJw0k2OTqexgjVaF75ZCa/
 1S3Us824ALIaJxx/MuBjhHyapy/srD9HElAx4LmRXmy6i0B2lARZrFVLVaEEt9jaCZ/g
 +qi7MLgP6imzambOY+iNxlXs0Tb3sd8Rb43OjHVbq2YHpAsaveq5+4xDA4cQPr/0urDn
 gnPPFJfCLK4NoSzxBst6BBNME17tfGe+xGfL7/8L/hEvmrnnEIo3x5hxT/TXkJmznQkw
 t/rg==
X-Gm-Message-State: AOJu0YySW+FggNIRoaDBPIk5uw8QtaVxQyj252yk4tV/ndyBpXD5INRm
 FpsQmb+RAL1hFuiW9w6oDSYudTUD7Jn2NYtjJXefYwSv20nScueXFrkU9NZQAQQ=
X-Gm-Gg: ASbGncvWUkcKBIbbhhDNeHXPd2e2W1opsB4vyVL+HxA9c5hPznn4rMmoM1IC3yp9AaU
 r08p7OjGE+IwHokDA0koM+qb/q40v9fJ8wIuNaBXHCpZB2JcQCWTaYcmJj5YByy01R9I7jRHINR
 qgxk2nGeqKwoK0u7rHX8MLwLnLyIayhT+RF57544GBv2DKXuc4ZZI1EqXsKIea9+o0kwwLMgBaP
 rVGQtKeyaUCL5hOfbcGivY4yyDfs1lvttg+/6zsFNoEjzgd
X-Google-Smtp-Source: AGHT+IFaSFuquoh+olNl6LuqJYp/wuU0mAlZDYGTSBou/oWQIMUMpTJ5+xYftTYYX9p9sF5v9gEpGg==
X-Received: by 2002:a05:600c:314b:b0:431:58bc:ad5e with SMTP id
 5b1f17b1804b1-433ce4a9d55mr95228775e9.28.1732548375186; 
 Mon, 25 Nov 2024 07:26:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc415asm10880068f8f.75.2024.11.25.07.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E75760B8E;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/28] tests/functional: rewrite console handling to be bytewise
Date: Mon, 25 Nov 2024 15:20:52 +0000
Message-Id: <20241125152105.2100395-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The console interaction that waits for predicted strings uses
readline(), and thus is only capable of waiting for strings
that are followed by a newline.

This is inconvenient when needing to match on some things,
particularly login prompts, or shell prompts, causing tests
to use time.sleep(...) instead, which is unreliable.

Switch to reading the console 1 byte at a time, comparing
against the success/failure messages until we see a match,
regardless of whether a newline is encountered.

The success/failure comparisons are done with the python bytes
type, rather than strings, to avoid the problem of needing to
decode partially received multibyte utf8 characters.

Heavily inspired by a patch proposed by Cédric, but written
again to work in bytes, rather than strings.

Co-developed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-16-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-16-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index f6c4e4dda1..11c8334a7c 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -78,6 +78,54 @@ def run_cmd(args):
 def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
 
+# @test: functional test to fail if @failure is seen
+# @vm: the VM whose console to process
+# @success: a non-None string to look for
+# @failure: a string to look for that triggers test failure, or None
+#
+# Read up to 1 line of text from @vm, looking for @success
+# and optionally @failure.
+#
+# If @success or @failure are seen, immediately return True,
+# even if end of line is not yet seen. ie remainder of the
+# line is left unread.
+#
+# If end of line is seen, with neither @success or @failure
+# return False
+#
+# If @failure is seen, then mark @test as failed
+def _console_read_line_until_match(test, vm, success, failure):
+    msg = bytes([])
+    done = False
+    while True:
+        c = vm.console_socket.recv(1)
+        if c is None:
+            done = True
+            test.fail(
+                f"EOF in console, expected '{success}'")
+            break
+        msg += c
+
+        if success in msg:
+            done = True
+            break
+        if failure and failure in msg:
+            done = True
+            vm.console_socket.close()
+            test.fail(
+                f"'{failure}' found in console, expected '{success}'")
+
+        if c == b'\n':
+            break
+
+    console_logger = logging.getLogger('console')
+    try:
+        console_logger.debug(msg.decode().strip())
+    except:
+        console_logger.debug(msg)
+
+    return done
+
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
     assert not keep_sending or send_string
@@ -85,11 +133,22 @@ def _console_interaction(test, success_message, failure_message,
 
     if vm is None:
         vm = test.vm
-    console = vm.console_file
-    console_logger = logging.getLogger('console')
+
     test.log.debug(
         f"Console interaction: success_msg='{success_message}' " +
         f"failure_msg='{failure_message}' send_string='{send_string}'")
+
+    # We'll process console in bytes, to avoid having to
+    # deal with unicode decode errors from receiving
+    # partial utf8 byte sequences
+    success_message_b = None
+    if success_message is not None:
+        success_message_b = success_message.encode()
+
+    failure_message_b = None
+    if failure_message is not None:
+        failure_message_b = failure_message.encode()
+
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
@@ -102,20 +161,10 @@ def _console_interaction(test, success_message, failure_message,
                 break
             continue
 
-        try:
-            msg = console.readline().decode().strip()
-        except UnicodeDecodeError:
-            msg = None
-        if not msg:
-            continue
-        console_logger.debug(msg)
-        if success_message in msg:
+        if _console_read_line_until_match(test, vm,
+                                          success_message_b,
+                                          failure_message_b):
             break
-        if failure_message and failure_message in msg:
-            console.close()
-            fail = 'Failure message found in console: "%s". Expected: "%s"' % \
-                    (failure_message, success_message)
-            test.fail(fail)
 
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
-- 
2.39.5


