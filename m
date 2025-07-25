Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5BAC87FD1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcb-0003lD-VG; Fri, 25 Jul 2025 11:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc9-0003PQ-G0
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:45 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc6-0002WL-Ay
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:40 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae36dc91dc7so365106666b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458335; x=1754063135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRnkauUSUZiBGHEJzQ8OoL56djZh0Rp7k2gsR3adJGs=;
 b=o7lSNHgCnJqR/yGNxNUaJz3ZmD3B+30LpBnBWJdCW9wLcJiLgULtAxf/XDzpcoYrgC
 Zbvmxue94jBVlC6MzJ9qU56/yKJBnEZxmd4nAoQrpLCNfdc5PVj3IovaggnWJX3pd5RU
 8tDoqTY0Zqt5dVfVrzXyzfdgY8zm0/UHunZn64jckaHZ1ZPY8pFWq3CgIJ8CkcS/1h7S
 TFyC0UW+BUDrQe3YqQ8fJjWy7cf1wPBrgKJGzmLttnbRx3bTuUBPj40tFzPDAw2gWaQk
 Cwm2Q1AYSnE19jeRT7WjeY3fyDpAww9UyLcqUjp+xzHrWcRwVnuvZs4dY3lJvK/pUI7C
 dvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458335; x=1754063135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRnkauUSUZiBGHEJzQ8OoL56djZh0Rp7k2gsR3adJGs=;
 b=fDA6fj9LXekHbLzgMzpRBSvycqvp9at5NlTPKliZSISuQhFR5DHe/6edYc+SbcYBpc
 aFDbOp3iWEDY7gLvzh6lQvokrXSmR7KOzryuBwZ6LeL1cNgRVQgi1q0Uv6n7mDXagU5D
 q2w1kgdfEBAYkqDNzg8mDOkL78rrJeP+y3ZzAQ3OBzLIbnGabPWgoSmthyxu+3CdpIKt
 Sv705nHvnfPBxAbZ9rhu3T7U3/PI5bkpgcrWXAAGYxQemfIk9ZYKxEjs0MIdI70DJ1sF
 Kc8c0tujuluDlN+gjg7elr/8DnShgDECxjonLnlI70K/+uLUs7ivjKmKvFePLNvl53Mn
 4auw==
X-Gm-Message-State: AOJu0YyHvQBYpbaX8ohTd7wH1mP2EhM6DXsqJTS9k5tW4yWBsPOMJ8jp
 GBpNKwtH32rmP4Eron4P/cWxfXp2PnRsPezrryUdnDIqkwzOBcUyUySvgXFmB5avbVw=
X-Gm-Gg: ASbGncsGn/rRyemfTy8TTDl9BWOw85NFGB830k7FXvO1t1sgXYaD+XPguooOoMN8E84
 4ZvgjuIhOZj5XjZcIWgpJ9CD3rYByNKxs2J7ct6Wcr2dHJhkMj8pm5YRA/wYHLRNg2K3SBTR7Pk
 DNxYKXzXBg7+BFYvPAhDTI90+qu0D+w34E9fu9EQDhSDnvG4TAAtwaCQ7gGAkSC7lcA4nuWJzqT
 wu+p+HWtAo7+zmvVlcKwGzwU1Dx/ztaJdUIx6joMj9AozMn/lMctAknkRUxvFmuwHdTVJosiPoz
 5SSkWGj8Wqhpv5lVBO5ycH/mdJYeDm/eZd0BVdAb1M+PLla+/9KaVrQ+0kkpD2KBxkvjsdAjD/g
 /IyySGUv6lR8DT/BTdrMy3i4=
X-Google-Smtp-Source: AGHT+IEl/y8NmmCCInVAZnu59MLJJo7FEdlvtI/VlYR3CRfgvntS2fa/kLIkMfIqFgaXMzlYJ5GQhQ==
X-Received: by 2002:a17:906:794c:b0:ae3:60fb:1b3b with SMTP id
 a640c23a62f3a-af61e92250bmr306113366b.58.1753458335324; 
 Fri, 25 Jul 2025 08:45:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af63585ff72sm10393066b.20.2025.07.25.08.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 249205F8F6;
 Fri, 25 Jul 2025 16:45:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for 10.1 v2 14/14] tests/functional: expose sys.argv to
 unittest.main
Date: Fri, 25 Jul 2025 16:45:17 +0100
Message-ID: <20250725154517.3523095-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

With this we can call the supported we can take advantage of the
argument the module supports:

  env PYTHONPATH=/home/alex/lsrc/qemu.git/python:/home/alex/lsrc/qemu.git/tests/functional ./pyvenv/bin/python /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_kvm.py --help
  usage: test_aarch64_kvm.py [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b] [-k TESTNAMEPATTERNS] [tests ...]

  positional arguments:
    tests                a list of any number of test modules, classes and test methods.

  options:
    -h, --help           show this help message and exit
    -v, --verbose        Verbose output
    -q, --quiet          Quiet output
    --locals             Show local variables in tracebacks
    --durations N        Show the N slowest test cases (N=0 for all)
    -f, --failfast       Stop on first fail or error
    -c, --catch          Catch Ctrl-C and display results so far
    -b, --buffer         Buffer stdout and stderr during tests
    -k TESTNAMEPATTERNS  Only run tests which match the given substring

  Examples:
    test_aarch64_kvm.py test_module               - run tests from test_module
    test_aarch64_kvm.py module.TestClass          - run tests from module.TestClass
    test_aarch64_kvm.py module.Class.test_method  - run specified test method
    test_aarch64_kvm.py path/to/test_file.py      - run tests from test_file.py

  usage: test_aarch64_kvm.py discover [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b] [-k TESTNAMEPATTERNS] [-s START] [-p PATTERN] [-t TOP]

  options:
    -h, --help            show this help message and exit
    -v, --verbose         Verbose output
    -q, --quiet           Quiet output
    --locals              Show local variables in tracebacks
    --durations N         Show the N slowest test cases (N=0 for all)
    -f, --failfast        Stop on first fail or error
    -c, --catch           Catch Ctrl-C and display results so far
    -b, --buffer          Buffer stdout and stderr during tests
    -k TESTNAMEPATTERNS   Only run tests which match the given substring
    -s, --start-directory START
                          Directory to start discovery ('.' default)
    -p, --pattern PATTERN
                          Pattern to match tests ('test*.py' default)
    -t, --top-level-directory TOP
                          Top level directory of project (defaults to start directory)

  For test discovery all test modules must be importable from the top level directory of the project.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2a78e735f16..5caf7b13fe3 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -249,7 +249,7 @@ def main():
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
         res = unittest.main(module = None, testRunner = tr, exit = False,
-                            argv=["__dummy__", path])
+                            argv=[sys.argv[0], path] + sys.argv[1:])
         for (test, message) in res.result.errors + res.result.failures:
 
             if hasattr(test, "log_filename"):
-- 
2.47.2


