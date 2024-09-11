Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F22BEE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH80-0000rf-KA; Wed, 11 Sep 2024 02:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7x-0000fq-NA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:57 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7t-0004Pq-Cu
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:56 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so7935239a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037212; x=1726642012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzjhDYaJi6Bnx+rLU77Ms8m0/GdXNL2aorzkrS+8+qs=;
 b=ggWc88S4TLgPMssw31kRcBbi7/yzQvlSEEVGHMv+qL9TB8jyxDwbVQtmQUPwExvjwi
 h/Zhcyd2fJnSftkEpH6aFUdlCRofcLP311RsvA/cSK/VQjBCfIDLpBch4FY+xPTc0T15
 zXDlK5affWYyEr6n0F3s5WIdo5IrhZJxbVj1BT/40dOPITrmnFBt21ceCGixzzG2Shld
 AGeg0XM3kbu6tngNl0TRFoA62mFPqCxR9y6TfXIVudAeKM09etAMiS0NN+Y5FfgZqRaQ
 uDhF6q2lkZ7yq3Y1jNe1fgGp2Sj2lyvvahqhdsuYZcpUIg9xgBpCPa+8oj+stiuhujMi
 IiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037212; x=1726642012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzjhDYaJi6Bnx+rLU77Ms8m0/GdXNL2aorzkrS+8+qs=;
 b=Jhk1EpiqF3KJUfDqZDUiNQSEX1lCexL4ohHdFT5tuujWFgxNEunW3NesOijWJlgYNz
 5lnE+/evm13CHlK+fpe3EjSX1YRdRDaBuN8D7TDJ8yuLCy8OyCQUTOBd/cuJ1ExWE6Xx
 kqa0g4LNklsOq+l13MBpeWZJqAzluI6xj78aeINTayJIqptZQE8AOzsNZiiDq80ynIjp
 V0Ohmk0XGVDNbLy0F4rAGdavFGG/psMR40Ig+eFzwPktq/3GKdyB/aLzWI3dwsUS0FWx
 3HfHk3xpBDisVtYYMe2X20WxBt/+9mGfSGBRs24IM6VTe46FQ6SjJavppVHrTifqXgSo
 UUSA==
X-Gm-Message-State: AOJu0Yx1ZRqER7bi0nHRTMqGyvSvv0L9C92UlfvfKIf1g+s6btPvVLYw
 GzJjwldYE9i0tYHp9DAb55Xhq1LF8XQaP5P9l4KU3ijTPp2jQJOG/fnLUumkIlA=
X-Google-Smtp-Source: AGHT+IGcmCj7jveK0/ak9Q85GIWKFR6kDN+E9KzmH6G4/HZrTDwdtKtBo1GQ0OAubIjevbtk5AJSwg==
X-Received: by 2002:a05:6402:4312:b0:5c2:5c77:3321 with SMTP id
 4fb4d7f45d1cf-5c3e9533529mr14238861a12.3.1726037211614; 
 Tue, 10 Sep 2024 23:46:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8adaasm5350300a12.80.2024.09.10.23.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C39665FA18;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/10] tests/guest-debug: Support passing arguments to the GDB
 test script
Date: Wed, 11 Sep 2024 07:46:43 +0100
Message-Id: <20240911064645.357592-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
References: <20240911064645.357592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

This commit adds support for passing arguments to the GDB test scripts
so it's possible to parse the args in an "argparse way" in the test
scripts launched by the runner. The arguments should be preceded by --
when passed to the runner. For example, passing "--help" arg to the
GDB_TEST_SCRIPT:

run-test.py [...] --test <GDB_TEST_SCRIPT> -- --help

The test script should not use the argparse module directly but import
arg_parser from test_gdbstub module. arg_parser then can be used just
like the argparse.ArgumentParser class:

from test_gdbstub import arg_parser

p = arg_parser(prog="test-mytest.py", description="My test.")
p.add_argument("--vowel", help="Select vowel",
               required=True, choices=['a','e','i','o','u'])
[...]

The arg_parser allows a smooth and informative exit if, for instance,
the caller of the runner script passes an invalid argument or misses a
required argument by the test script.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240906143316.657436-4-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-9-alex.bennee@linaro.org>

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 368ff8a890..5a091db8be 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -27,6 +27,10 @@ def get_args():
     parser.add_argument("--binary", help="Binary to debug",
                         required=True)
     parser.add_argument("--test", help="GDB test script")
+    parser.add_argument('test_args', nargs='*',
+                        help="Additional args for GDB test script. "
+                        "The args should be preceded by -- to avoid confusion "
+                        "with flags for runner script")
     parser.add_argument("--gdb", help="The gdb binary to use",
                         default=None)
     parser.add_argument("--gdb-args", help="Additional gdb arguments")
@@ -91,6 +95,8 @@ def log(output, msg):
     gdb_cmd += " -ex 'target remote %s'" % (socket_name)
     # finally the test script itself
     if args.test:
+        if args.test_args:
+            gdb_cmd += f" -ex \"py sys.argv={args.test_args}\""
         gdb_cmd += " -x %s" % (args.test)
 
 
diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
index 46fbf98f0c..a715c0e3f5 100644
--- a/tests/guest-debug/test_gdbstub.py
+++ b/tests/guest-debug/test_gdbstub.py
@@ -2,6 +2,7 @@
 
 """
 from __future__ import print_function
+import argparse
 import gdb
 import os
 import sys
@@ -9,6 +10,10 @@
 
 fail_count = 0
 
+class arg_parser(argparse.ArgumentParser):
+    def exit(self, status=None, message=""):
+        print("Wrong GDB script test argument! " + message)
+        gdb.execute("exit 1")
 
 def report(cond, msg):
     """Report success/fail of a test"""
-- 
2.39.2


