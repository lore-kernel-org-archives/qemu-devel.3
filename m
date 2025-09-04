Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C028BCA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuCBd-0004so-FN; Thu, 04 Sep 2025 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBE-0004kU-P5
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:24 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCB6-0008Hl-Ao
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:20 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-544a2339775so449060e0c.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757000824; x=1757605624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7W8AMCroqwaeXqVpYPQbxXgScT+t9hdJtgqiSQ+G30=;
 b=u+jEFJ9k551FDTzvO4nrpQgSiZrnF2GzxRqdkkG0IvmgK8Y2IXzXGVgi243a2DfaNg
 onaBSr5aJtzaY9ogo0gqMYGZL6TtoetWvB4ABdrGZzwEcahgA2hRHuYn3sPJn2i3Ey7A
 GMobxBz2cKxavpxUlVnwxMSwS1vUR2Xbz7e9Z7JNR3WNSkHN5wfRZzpttIbFgZOTUVTG
 /q4LfwIsVRpM2N+jwkO/Ebhru4h9o5Hc9coGCxoOWACwfsqW0vsHvHr0sZ5XokA54Tdb
 GBQ31rNsr+oPXpVrpMNIOeJ7JYgqA5FoPd8htkzfujh6kgWYmQ2kP5wzPkLq9Qzask7V
 qJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757000824; x=1757605624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7W8AMCroqwaeXqVpYPQbxXgScT+t9hdJtgqiSQ+G30=;
 b=IXUL0PSCt8UO0L11Qf5NWUW7MjbaEpXmhxRhy4s7QlQmdZUQ5+REuRujj88kjeTP3D
 lWyY9NHF5+u/CGCNCT98zFxm+V4EWePOCyIEIPGJpsHklmt/LE2ypfHzke9WLEF1er1a
 zFpXlrul1wyoWrplTj1wLoRP3xK4ZWSSNnujLD+XUBSEgZV6VJQP2R0xnyY6L4utbygK
 tW2Uw/iFFt9OiF2iCM1zvFjy52J6AQwUZvCU7l5Kw4BN9o6sQtTmJy3qvHCbkpBrA9Yt
 jxHuY9FNMpTfh1HgHOsv7WXU4QbE+iO5aAnOVpWKzF3cHpL1FJdoyBLeUmtIA9dg3Ouf
 RJjg==
X-Gm-Message-State: AOJu0YzQfoNFaDXiYuRWJjF3aeOID4lAqE2LFXSJDJDK3UfYtbgNwCS8
 +XZ31f2GMXAgH1uajxZiYLvMpzPDIZt/2Cx8ztIxAH1zMPmyvVFSrU6XNGnTtFLad0MWd2nWHJ7
 HCRz+mTZDfw==
X-Gm-Gg: ASbGncudTHq6mmymptTNArXWCAICuHJR/3J3x6PLqOPsj/eYwVG2pOprlAlkB3DPXoK
 AVR30l8L5ZAkfXWEE/XBzd+7N2OaWLWd1CuS6Qh7U1+UTW6sKl97qgJHDINScMs5hGWmG77Gd/0
 vSNBfJLlOjkcZJNnzolRaX02JekWvwN10RDSpwcUp0w043Jghj8c+KkZqvdehK4+gnRTnqjK9iM
 UZ2O+u3VyfKuwUtbDnYIhZ8QYdJw+RAwVSv435VqUf80oZkf6ZPwUuKOYQHTeZW4CQu6tCPutn2
 qEFevIkYNiBm1xBIjLAKSTRGcvCSdiJBIKjpucdt3YNOPsJyYbVYN5ylf/TzZYfRW2nkZT4eHpr
 Nd9PI7+e4gmAmXfYpkbF8h46aA1vC
X-Google-Smtp-Source: AGHT+IF1INOgEwi5XuzYYf8xmg/ZUfMMO6YYhiWR+h5YxK7FFBUBbVtiSECAhjpN0ymfBkDR36+qwA==
X-Received: by 2002:a05:6122:2022:b0:543:cd49:ce78 with SMTP id
 71dfb90a1353d-544a02889edmr7340174e0c.14.1757000823807; 
 Thu, 04 Sep 2025 08:47:03 -0700 (PDT)
Received: from gromero0.. ([186.215.58.133]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544a666da0csm6497022e0c.28.2025.09.04.08.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 08:47:03 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH v2 1/5] tests/guest-debug: Make QEMU optional in run-test.py
Date: Thu,  4 Sep 2025 15:46:36 +0000
Message-Id: <20250904154640.52687-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154640.52687-1-gustavo.romero@linaro.org>
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit makes QEMU optional in run-test.py, allowing it to be used
as a GDB runner, i.e., to call GDB and pass a test script to it without
launching QEMU. In this configuration, it is the test script’s duty to
configure and run the VMs that GDB connects to.

sys.argv passed via -ex now includes the full path to the test script in
addition to the script’s arguments, which allows unittest introspection
to work properly in case it is used in the test script.

The --binary option continues to be required when --qemu is passed.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/guest-debug/run-test.py | 60 +++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 75e9c92e03..d21a5dda77 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -15,6 +15,7 @@
 import subprocess
 import shutil
 import shlex
+import sys
 import os
 from time import sleep
 from tempfile import TemporaryDirectory
@@ -22,10 +23,10 @@
 def get_args():
     parser = argparse.ArgumentParser(description="A gdbstub test runner")
     parser.add_argument("--qemu", help="Qemu binary for test",
-                        required=True)
+                        required=False)
     parser.add_argument("--qargs", help="Qemu arguments for test")
     parser.add_argument("--binary", help="Binary to debug",
-                        required=True)
+                        required='--qemu' in sys.argv)
     parser.add_argument("--test", help="GDB test script")
     parser.add_argument('test_args', nargs='*',
                         help="Additional args for GDB test script. "
@@ -73,27 +74,30 @@ def log(output, msg):
     socket_dir = TemporaryDirectory("qemu-gdbstub")
     socket_name = os.path.join(socket_dir.name, "gdbstub.socket")
 
-    # Launch QEMU with binary
-    if "system" in args.qemu:
-        if args.no_suspend:
-            suspend = ''
+    if args.qemu:
+        # Launch QEMU with binary.
+        if "system" in args.qemu:
+            if args.no_suspend:
+                suspend = ''
+            else:
+                suspend = ' -S'
+            cmd = f'{args.qemu} {args.qargs} {args.binary}' \
+                f'{suspend} -gdb unix:path={socket_name},server=on'
         else:
-            suspend = ' -S'
-        cmd = f'{args.qemu} {args.qargs} {args.binary}' \
-            f'{suspend} -gdb unix:path={socket_name},server=on'
-    else:
-        if args.no_suspend:
-            suspend = ',suspend=n'
-        else:
-            suspend = ''
-        cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
-            f' {args.binary}'
+            if args.no_suspend:
+                suspend = ',suspend=n'
+            else:
+                suspend = ''
+            cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
+                f' {args.binary}'
 
-    log(output, "QEMU CMD: %s" % (cmd))
-    inferior = subprocess.Popen(shlex.split(cmd))
+        log(output, "QEMU CMD: %s" % (cmd))
+        inferior = subprocess.Popen(shlex.split(cmd))
 
     # Now launch gdb with our test and collect the result
-    gdb_cmd = "%s %s" % (args.gdb, args.binary)
+    gdb_cmd = args.gdb
+    if args.binary:
+        gdb_cmd += " %s" % (args.binary)
     if args.gdb_args:
         gdb_cmd += " %s" % (args.gdb_args)
     # run quietly and ignore .gdbinit
@@ -103,11 +107,12 @@ def log(output, msg):
     # disable prompts in case of crash
     gdb_cmd += " -ex 'set confirm off'"
     # connect to remote
-    gdb_cmd += " -ex 'target remote %s'" % (socket_name)
+    if args.qemu:
+        gdb_cmd += " -ex 'target remote %s'" % (socket_name)
     # finally the test script itself
     if args.test:
-        if args.test_args:
-            gdb_cmd += f" -ex \"py sys.argv={args.test_args}\""
+        argv = [args.test] + args.test_args
+        gdb_cmd += f" -ex \"py sys.argv={argv}\""
         gdb_cmd += " -x %s" % (args.test)
 
 
@@ -129,10 +134,11 @@ def log(output, msg):
         log(output, "GDB crashed? (%d, %d) SKIPPING" % (result, result - 128))
         exit(0)
 
-    try:
-        inferior.wait(2)
-    except subprocess.TimeoutExpired:
-        log(output, "GDB never connected? Killed guest")
-        inferior.kill()
+    if args.qemu:
+        try:
+            inferior.wait(2)
+        except subprocess.TimeoutExpired:
+            log(output, "GDB never connected? Killed guest")
+            inferior.kill()
 
     exit(result)
-- 
2.34.1


