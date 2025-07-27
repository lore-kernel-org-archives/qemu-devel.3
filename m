Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D37C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwp9-0002A9-EK; Sun, 27 Jul 2025 04:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwop-0001ra-1k
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:19 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwon-0000DY-2O
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:18 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6150be62be4so1405873a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605189; x=1754209989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aJNsoz12Jzz1cfgiLb5ioOc3GXXwlv67s51A2mnpiA=;
 b=wlY/U85x+oI95m1UxJSsrArYvgzpxAzg4pUUjJs7VvliG36NvzmqS7SdG1pBpHTWA+
 ABS4aLT96sylNscCJSlDz/8D9ST/mnfytsVxp/7D71kTKl1Vmu78/n0jOlfQWGjZGlPI
 Lv/9m1rfaevBAGIVHV3biVkLSWP51YKtTWEghAy8hkTWN8MRZ69uBy+GILG0S9cPeARY
 +5i1hY4oQQKMAgATQkmW/oMcyPRkO6kSpDJ0+DpVe+VgNedZpfRUUAAD31O5ypZobJsU
 y65WkjcWs0GkPmW712oyKY+lQQk7kHIUZH6rFDiIFip6DVTrJ9nOBDfwGYmX0j3CMF88
 mlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605189; x=1754209989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+aJNsoz12Jzz1cfgiLb5ioOc3GXXwlv67s51A2mnpiA=;
 b=D0jQEYzRYQSwigcFN1ZEMa8cmY1PBBC61CCtcFp2FhnilfPgW8JDQLbEXKzua0pfql
 qug8/EvOPztzB5IFYuqhYPPli/X1fBsEn7Gp3iT+ILVXR/kug5dHd9ZxnLQ39rDvnSX9
 JD/XEUF/olRH8EM3u63N7ECXSb2Vb1yMgqpooWgauMF5Z2iFyi8ELZPN/5+fr5XEJ7gs
 hI8K6CuG9m2006ja1dWn0Rg0F0AWoPhDoJxubIuoWKCnAmSArj+IruF+HtiBQ5jAvP6g
 EIgpvG+M339OaQtkbfs7O43NPkLh2tdu1de+M14IwXDJaLJbFeVtvsc/CHdyvFgL1fYG
 yNfQ==
X-Gm-Message-State: AOJu0YwQEgpBhCP9mfizDButkZPw3ripPz+oZKM1yJ0WOxSZ6EUFgxWN
 eTshc8QxrekYLPiBfVBcbuhWkkGlhtEitknZhd+gry98XNcp5bAGT3KAl0ybWsy5QWE=
X-Gm-Gg: ASbGnctSLiW0+n2LMLtphF4V8E33dZNZHssI1lnzIq/XNjihrVopmrGoXNhiDE2vK2t
 gOFuyUXjMkK8t82c3wj+CnyDQ0s/lfycpB8tRkmpbVfvp5mO0YKdwCsNZ6IYXvl/HzlSD5OghDT
 t6aR54kOHx3XNXGT7aS/stwJYZRsZdwNdPYtMzMLAFUgkFJjmEQARgZ7bW892vX9cVpYl7WIWxS
 HzupIekT1Kb1X1eQUhTBHddUHgjxVWTTJuMJjdxMjD61F9w5o5bSu6213EwZiy28RUejuw3a3ld
 dqolf6goLETGuv+u0hO1TePXUf2BHR2eZqRcXAbf9k4PkqfODoLf2IeE313eQdGkt3FhortFpZr
 22YIV10npZX2GW6grvq9XJ0U=
X-Google-Smtp-Source: AGHT+IFryohGXqcs4rxsENZoQU1TZK/75vwXh8Dzr7PB+FssbNcKAIROrsPghGGWbcZxsAilSvPxrQ==
X-Received: by 2002:a05:6402:350e:b0:60c:3f77:3f4a with SMTP id
 4fb4d7f45d1cf-614f1d197f6mr7557780a12.4.1753605188823; 
 Sun, 27 Jul 2025 01:33:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6153ae1e86fsm64522a12.40.2025.07.27.01.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:33:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C2FD5F8F6;
 Sun, 27 Jul 2025 09:32:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/14] tests/functional: expose sys.argv to unittest.main
Date: Sun, 27 Jul 2025 09:32:53 +0100
Message-ID: <20250727083254.3826585-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-15-alex.bennee@linaro.org>

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


