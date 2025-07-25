Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0350FC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 14:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufJcj-0001KD-3T; Fri, 25 Jul 2025 10:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufJcO-0000iP-V5
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:41:56 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufJcN-0003N7-3H
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:41:52 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ae360b6249fso371141266b.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753454507; x=1754059307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fp3rANB6e3UZ3QZOsP6Ardf9/Q9yTTpkKQjzaSnZXuw=;
 b=hdBTvnhIH+4Wb/tsXwog6L7dvkMvrb4mzZHgBY+zkOMIAxL/sfDWwIndunsbqTPO/x
 ThlhJleNN65dQc46RE5KV+ADoJVhFe23tmNVDQoz7xwRU/s5Q/fxjLsrl1oFsvtszZVC
 Sw3W0xPYPBTsNJKvgztUV6vXam/ACo7/8lr95TfRVQHtWugXCJEU/SLGDmx/IOjJQjuC
 aVgJlozRJueZLDFHxMP636a8mh9PehJ4tXQH9mfZW/FPLFmBk5KFI7tmtPL4Hwr4GbPX
 +fwwxCaebElj9J9d9r9WrD37dTIF+FtPhCzprpg2zJ135XKaanearPhz/JiqQw3oYO0O
 saKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753454507; x=1754059307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fp3rANB6e3UZ3QZOsP6Ardf9/Q9yTTpkKQjzaSnZXuw=;
 b=w2CCVSodKkpSVRZiVcL/PAcTVFuBhV0KxhXfnC+cB9r7mai/C9GtfoXYYHQwP0+t/x
 A/77vRKs3gMSjetvUTQ8c36IjbzZ2komieV/3NgAF13mSlKWJD7pwMzEASaPHGHBrp5B
 6Wi1x3TGiD+HAmovAGod7h0j1AOaY/YWVYIsYD6SH+Rq0hFLMpUyKyrilsHEfDiUuWDr
 NGgoIoV6CysZFIgWpwqUdumvfIerDBmd+p1KEQoFqUW1B9d3+pJ9cdetX8y1tJJH10OT
 nCXyaf8RzaSVcFNs4VAJHODEtL7Shg19IIBiZ6MSzbtigjolgLw4LRPE3Wah0OOXNvH+
 YRhw==
X-Gm-Message-State: AOJu0YxB43ElqWu9fM9mONWQ3Ynm1+b1vnoNb5sQiZNK7sh0Bt4NxhCx
 Srf4EFe5168RLeY2bHgQnYiN3ROK6sk38T052vmTkzi7vr/RhJYHN+a6YRRedHY9XLQ=
X-Gm-Gg: ASbGnctVh/lMWtqdJtdUPZj5Gumuk4Cb06941ipV/8L4kfqOeyd3xsH8VItfWz+Sqr/
 xyz2LNmpwoIcQScwP2vJYl4/zlMpyQ9KuL26m81YnB1+0aq3ILNyjGg1U+Xl5YprV+yv/RHfOxV
 Yt5tJDAwdwpTEOIvO23Y4iUlmFoQcKS2yWMvdkXZXkaiokeso+NfR912PIKH82n1SX3N5pBZAO2
 VNJjU4Gqvu2lcss8Onw4gH4+bycRT3T/nrXvsOyx/oHCEiCCTVc0DirIDukOlIr7WpAKg1QXirk
 wRBtZOXdPiUBkWoaAlURczJo0nrpx2NbGx2gmAOesqAx2qu/RYesY/Jk0+eVHLx2TUKFdIYrDgZ
 YW2D+aer/9pxJJG9gmEt4YPs=
X-Google-Smtp-Source: AGHT+IFzzSZSdZHWo9NKMx8xAx4WePZ05RZUYPDXVmdHYIDHVbw9U91KRQRS/tbvB8WGQLquj9vHXw==
X-Received: by 2002:a17:906:c14a:b0:ae3:6705:8918 with SMTP id
 a640c23a62f3a-af61e637c4bmr263629066b.49.1753454507066; 
 Fri, 25 Jul 2025 07:41:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635aa21fcsm2100566b.95.2025.07.25.07.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:41:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 807CC5F7EE;
 Fri, 25 Jul 2025 15:41:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] tests/functional: expose sys.argv to unittest.main
Date: Fri, 25 Jul 2025 15:41:42 +0100
Message-ID: <20250725144142.3041931-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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


