Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A31ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X2-0007qT-B0; Tue, 10 Sep 2024 10:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wz-0007cv-5u
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:45 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wv-0006VB-J6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:44 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso7302336a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977260; x=1726582060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gsP/ANf70RJH0KlgA0KWCypst2Oh4Yb8PQcZ6VG+qU=;
 b=vUealY35jhI7MWFnRiYrGw4zqYgA5C5aH33YO/McliGEmZDQDG8nf+4m0apq9oQ/vK
 y3o5oJTYnCsc1t4cXKjnzBZxtz2hz9Bgs4hIL6I/ERuWLLuejMPzdOK4UUoHlcxxBWJh
 0fwpKAp9tziIAtmGnc+JwCvcQ+DOo6VJ4HFjMsP/bZH8B2ITqKZgXy6aNo/92FhspAR6
 2M1CMsanQa2zK94SvNoFnnJT7qawFZX1vmTSGsU6tmqtEqEyuyB/r0VNvwn+qPRR7H07
 miiN5kNcjV0axG42VfnfzcofjR8EEKkcVTlR4aK4zQbIz/0aUd4akPoqjDB10wpjJBRt
 qneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977260; x=1726582060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gsP/ANf70RJH0KlgA0KWCypst2Oh4Yb8PQcZ6VG+qU=;
 b=nDbonY+lrbFXR87gcfYRe456HYiQbgl3bdxeMbsAPFZwiKDU4QNWxSZNwkgHjOSXd6
 vO22ceg5p0LoA1XfGgDmv1wKYXbCvC+gPzIP/FnSKxsbV0D58PNFdicze5hiUqrMFcl7
 /KFW4CsJQVkBIEebweIspuB+DFvg8xIlVYN9hVk7XCvRr+CQZ6ZlSM6o2pZlK6rg+ksg
 DCwLo9B6SFL9Hc0cB9GeO7MeOEILXBRBVMKT+MXmAaovrYJegC4L4ceXa38wwHDtEeNS
 rEuaLNIWJZCtQNuVmsSAjsk5MUAFBmx5y1nbhLNsaiaYugWHe29EFZF5ZH/AVdA422Ns
 OXng==
X-Gm-Message-State: AOJu0YwhYeMgUMjZv1+Zfcpb4tccGWyOG52WGUEECcIM/8UR5j+xZ/xF
 hqkumOIjQXQgC29sYVKxVWVwc3j+xgphbd2dMJWTjnc57cB9sLBd1f6HqvbucrY=
X-Google-Smtp-Source: AGHT+IFjXyaFYA+dR/GiFQ0leb2lapksUx3adB5TZ9WCr/rcjU4CyFAL3XLlLXQoKDeTSGh4w5Esfg==
X-Received: by 2002:a05:6402:40cd:b0:5be:f1a7:c2cd with SMTP id
 4fb4d7f45d1cf-5c3e974b43fmr11967582a12.31.1725977259898; 
 Tue, 10 Sep 2024 07:07:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd424dasm4338661a12.9.2024.09.10.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5342A5FA0E;
 Tue, 10 Sep 2024 15:07:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 07/26] tests/guest-debug: Support passing arguments to the GDB
 test script
Date: Tue, 10 Sep 2024 15:07:14 +0100
Message-Id: <20240910140733.4007719-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
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
---
 tests/guest-debug/run-test.py     | 6 ++++++
 tests/guest-debug/test_gdbstub.py | 5 +++++
 2 files changed, 11 insertions(+)

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


