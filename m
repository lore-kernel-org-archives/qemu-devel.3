Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F3ED78799
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAfz-0005CR-U6; Thu, 21 Nov 2024 12:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdw-0000p0-J5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:07:01 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdX-0001gk-CR
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:07:00 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so9532285e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208793; x=1732813593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUv3cBNBzhQbXwOzZFuKXMqW5Ms3TH+C7tVVsyL8z3E=;
 b=GNwPzxiNkSGl39NCmnRT42wk/ETCQGsfAXfDoKtroHGGdjR48oXaiY54uD/QCQBL/Q
 Uxz2XV3CT7t7aQho7UGPo3hlleE+Cd7RIsMjQhuQVAb6w4LLELRML4L8Rs09XbPy6Zu7
 ppd8a7gP9J52OAezO2LAfGax2adsbM23wN6S+MMZcYtGrlJsOeBGEQ92/ULVL952bek5
 raGQFq7TUcI0BlMz5jXnVrvSm6GdCDP/LGlpn2vyrUjg5PYIksOc1k9DykciHycDcd09
 sFRRarwn0d6KIX+XvRegXcRIrLeo1vHdaKkRm34DRbna+On18zJrvasDLb/MkmLTBToK
 YLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208793; x=1732813593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUv3cBNBzhQbXwOzZFuKXMqW5Ms3TH+C7tVVsyL8z3E=;
 b=TjJy39I7QWlrIs8P4nrHgyqVXy85UsxcoNU4hc4U1CHnBa829Z3srJcTJ499FwLbLw
 6sR5mLuDw3IQFCSwNEB4zytB4jI41vF/0Ak5X82eIJfD1lbzUxoe8p/8GFYlaH7/Iv0R
 lX7RAPN8+rjSQi4S/0g9IC1InF+PTlO9RmVpG5VvhWOiFkSg67O1E4ckMGDnuqQljcPf
 N78zArkrZqfytpXWbOeiS2NZh3z4LD+639aDmuzoh0auTZQbDwN1cnfOKy0OiyajuGna
 SpBJV9SEwIzM1Q7I7IGlxpdBNNCrEpCmP9wKxUod5CdQxlZyX1fduulBvOVpqyxt+XPi
 K6eA==
X-Gm-Message-State: AOJu0Yy3c/yxxQmJ+ftei86jIcYSuEBjGoeS/jRkTlFAfKZuMTMTKjcF
 +6KB3vhHcK7wZNNBP1vRO2uWJcmV2Wr9dsHCmmChiqL4p//A05iTH3P3YQL0Qlo=
X-Gm-Gg: ASbGncsA4Pz9Sy+QwYlarFbQhRRuKm+pwgqxcb9S6iMIvUbJ1oMh3wzbS8rXkPuvrQI
 HgUOwJXH3nsghRrGRpeJL78NHCKoRRiJeK6fQdpwiEpT6mANMF8eLx77htdZ72TXaa2/G2oqjim
 xSRqiSZ0UtCWbqYQI4MCUgH6vDW2YOeGVF/CKnrd2TgTEpmPF/Jx2SomzOzzAk4MCgNvaUsVI7S
 SNna6E8vOdkmho6JGiQaTFL8Fjteh3ihWxNWE/YXQZZqPnF
X-Google-Smtp-Source: AGHT+IHHK9w5ibEGzKJSTEMd78FCN2jsgy4PL6OrIOq6OeKJPCDeMmOkU9vJ2eOrihfPErrA9ANNXw==
X-Received: by 2002:a05:600c:4e94:b0:431:60ac:9aef with SMTP id
 5b1f17b1804b1-4334f02123bmr62233425e9.29.1732208792014; 
 Thu, 21 Nov 2024 09:06:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbee043sm33245f8f.104.2024.11.21.09.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB893603DB;
 Thu, 21 Nov 2024 16:58:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 15/39] tests/functional: rewrite console handling to be
 bytewise
Date: Thu, 21 Nov 2024 16:57:42 +0000
Message-Id: <20241121165806.476008-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
---
 tests/functional/qemu_test/cmd.py | 79 +++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 15 deletions(-)

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


