Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B62C87FD1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEw8-0008Dw-To; Fri, 25 Jul 2025 05:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEw0-0007zO-1o
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:49 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvx-0006Od-2a
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:47 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae0bc7aa21bso381424266b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753436504; x=1754041304; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MypPh5tWMN+S2SCsIb0uToDST9X7A/yBEEXT6W5D7OM=;
 b=eNT+wphlkNkxwqCTzh0Fg5/VU5Zm6JB6wEYaw110uL2UQKidnEF5IrAlMaTWFSHpBf
 jwCcfy6b/jSoNHJl5umwqmVyeqMvreO1Gl6vaVxWP7ggUhWlhg4tXH6m+dHysTxmUbbC
 w6ieDu7DZUeweNNHd/dGdwAR3uxyDffmIGz/4QvK1HrzkHHsg+ssfvihK1+yu6F9pWak
 Y6m9PKqx4nk9ayLe+prM6zN8xrCP+hmYVFnwNAxOr6H7+n28VVb9j2/iTvLavAgws08b
 6Whj17+MtZXKi5/EJ2jZ/JCpg3hIecj3DvLftmfqINS32Kwg2zA2+yanLQbeg6TlD2CX
 1xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753436504; x=1754041304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MypPh5tWMN+S2SCsIb0uToDST9X7A/yBEEXT6W5D7OM=;
 b=Jlvwvo/HAbBsu0BWYUw8lp/QeWd1ahDEEvH0ynnMUZTRNjhGU4ibv7pOkGdcU6wyQm
 AigYQPJqKqYZrzQhbZCxXxOHx0/uRMAQT8Pkqk8aaw+3jR40ZcoW68BenOZ2dTv8X91l
 U+PKaEuPscpzpsbuBRREjO13AxgrSyG/9AZ6V7UGBxcUwF9qogsPNtYxMc6jhgb26smG
 va4/eIv/0v1ASw/7OjGDgiv4kFc1O4iodXNoIqvgcIUZutWY0KCrhhmoEwVCsPmVM/od
 NOE5xM2i1t2jql8MLbQaHH9E5hUzqaltI1w9ASX5Z2Of8/Xiq+Mle4YbvsYvw870wX5q
 opQA==
X-Gm-Message-State: AOJu0YyEPqrWiAKnc6DbBkfNVeWDo5YF2J6vyW82iUXxcKtWbWmR0jMd
 tYDYwEifvs5wbDp01EXyYag7z7u6i5dMwpioYsVYN+IP742sRv3WFuSGhdiK3HQ25vbSVL31uX4
 eCx/H
X-Gm-Gg: ASbGnctmzYeBF85vLdkuz8ZzG1qCEOwc1uJYqOtvix/WtrhU65NEQDLSb8i9UnW1r2h
 1xp5gWNgjdUNnqhQgzGzcZk52ZcQZ0xnve812hd7CVTBLuKv0e1S1rYqIJvq6CDLOc0c6nhZlkY
 mZWNRF4uPvHZwajtVx2DOiSVguaJSJBer8uab0icLNHVRI565X+u4WSCtNLL0XVH5A5QoBJYayV
 yiLmggE34FtdOATTZeyfrmICqYJ3PnQSbHz3EXT0nhc+rATClU+MJLPCkHCSqdS83BGdyIA+qwD
 hIKA3SK6v3qcYSEOFOCWB/nBA8UyeSkjkYH8y+6UsjvQDtfb1Px7PvPnnF79SU61Y/2VHnnhrd6
 X5r5x5PjrTmXELIRxMf0iYmBkvTlBZMxSEPy1th0gsZATBQPnOo5jGxymMgRzlDHNv8js/dzSQM
 Gg8g==
X-Google-Smtp-Source: AGHT+IGTHbyJr3iFkumqsc5ePl9evw47e7IOlw+Uhfz3ws9CrsVMYqNLQpwwUDI6xDxV8XEUTdWZ6g==
X-Received: by 2002:a17:906:c149:b0:ae6:c0a3:1606 with SMTP id
 a640c23a62f3a-af61c2b4156mr142833666b.7.1753436503510; 
 Fri, 25 Jul 2025 02:41:43 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47ff42fc5sm243280266b.143.2025.07.25.02.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 02:41:43 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Jul 2025 12:41:25 +0300
Subject: [PATCH v3 4/4] tests/functional: add -k TEST_NAME_PATTERN CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-functional_tests_debug_arg-v3-4-b89921baf810@linaro.org>
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
In-Reply-To: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2807;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=IdEewpLmVYPdyTy6Htl/RYvxDMvxHLws16hFCO1dk0A=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9nMUZQQWN3dWQ5WDJIbHVxZCtPZ2JWZ0JiamkyClFiM1E5MTdrSVArTkxnWDVy
 YmFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUlOUlR3QUt
 DUkIzS2Nkd2YzNEowSmh3RC85aGYvdEtUT05ya2VzcjJUS1RicnJBRWp5QzBvSURPaStVUlN1RQ
 pvTEp5WXRHSVhQaXJHMTc1WkdCbEVPeUZHNnhWcHlPQkFxMUhmMi9KQWUvYTd0dWhMbHNxa2RpR
 jJSZ3UwQURJClN0V084OG9lYXluVHZQNmIxWTZUT3FJcHVQZzNMSXluVjcvRktpZlZjYzNVK1J5
 VnVUb2xWMUtSamRoQzl6L3gKaXZjeFJzNjNtK2RwZzNtdjBIZFVneUZURkYyc2wxNHR5eTVDWFJ
 DUmNuSTBMNjdQYU96Ty91TzhZTTkxRDhVOAo0cWUyUnlXWGpGRHc3L0xVQVhyZ2JIOHhEczNDan
 J3KzFWT3pvWjZ4eHJ0cmQ3Ym5vVTBJdElNdm9vc1NwY3hPClBCTmRac3NnaVVBNXRMbi9LT1VZe
 Hd3eWhwZThwSE40USt0NHJuMjl2em0xR1ZidGVYRHJOU01KN2IxYVUwWi8KTVhhOHRHaXhuQkc5
 WkZuNWdxQi9IZ2pTRDh5QmNDZlBBVGJTTlpWS1o1aXpFa0t2dEljelZnZ1dKU3JwRlBWUgp3YkJ
 oZk10WkMvSlA2YXozcXRNNG85amZUTFVwQXZVWFllZXFjZGhiemlYd2RQUXdiai96Rzg5a3VIZm
 tsbmZWCmlORUlEMks3bWdhQVMwL1pOV3lHdDZYRXNHTnhxNjRHMTNFRVZRclptaWtHV0dlQzlTK
 2psRWpzR0xQbTBGbVgKUnRBSmFLUTRBcEFFcjVjOXdlam9uWFE1dnM0YmdmWkNmekxYazlCQmZo
 Z0NmL01DaFB1aGVqUWRLS2ZIdmlIWgplSngwb04xSm5RRjBiMGFoWHZBUUF2b09PNndNSVM1YmF
 Gd3JlYWJROWFYS2NsZUN5SFlWRDJRcEprNjV5WFltCnVxd0xZdz09Cj1wdGlVCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

Add a CLI argument that takes fnmatch(3)-style patterns as value and can
be specified many times. Only tests that match the pattern will be
executed. This argument is passed to unittest.main which takes the same
argument.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index ab564f873c303bcc28c3bf7bec8c8c4569fae91c..b045d82caa79d9d161fb868b0b0748ad7de453d9 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -16,6 +16,7 @@
 import os
 from pathlib import Path
 import pycotap
+import itertools
 import shutil
 from subprocess import run
 import sys
@@ -37,6 +38,7 @@ class QemuBaseTest(unittest.TestCase):
     debug: bool = False
     keep_scratch: bool = "QEMU_TEST_KEEP_SCRATCH" in os.environ
     list_tests: bool = False
+    test_name_patterns: list[str] = []
 
     """
     Class method that initializes class attributes from given command-line
@@ -67,10 +69,19 @@ def parse_args():
             action="store_true",
             help="List all tests that would be executed and exit.",
         )
+        parser.add_argument(
+            "-k",
+            dest="test_name_patterns",
+            action="append",
+            type=str,
+            help="Only run tests which match the given substring. "
+            "This argument is passed to unittest.main verbatim.",
+        )
         args = parser.parse_args()
         QemuBaseTest.debug = args.debug
         QemuBaseTest.keep_scratch |= args.keep_scratch
         QemuBaseTest.list_tests = args.list_tests
+        QemuBaseTest.test_name_patterns = args.test_name_patterns
         return
 
     '''
@@ -313,8 +324,16 @@ def main():
 
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
-        res = unittest.main(module = None, testRunner = tr, exit = False,
-                            argv=["__dummy__", path])
+        argv = ["__dummy__", path] + (
+            list(
+                itertools.chain.from_iterable(
+                    ["-k", x] for x in QemuBaseTest.test_name_patterns
+                )
+            )
+            if QemuBaseTest.test_name_patterns
+            else []
+        )
+        res = unittest.main(module=None, testRunner=tr, exit=False, argv=argv)
         for (test, message) in res.result.errors + res.result.failures:
 
             if hasattr(test, "log_filename"):

-- 
2.47.2


