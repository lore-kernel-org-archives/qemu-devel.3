Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCDDCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoRtd-0004ep-OG; Tue, 19 Aug 2025 15:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uoRtb-0004eB-Pt
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:21:23 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uoRtW-0004rW-Qt
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:21:23 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-afcb7a0442bso840007866b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755631276; x=1756236076; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HzK+T55OsSyRkBZov6ffk0VBOqix/EogK4ulDOtwgsg=;
 b=cI1h+lM3yRVG/hH2Tdyvmtzyk/Ki6v1HAm5X+72kX7Jo0mfszX0cIMVDvx9zr2Bays
 OJbOilCUTigVbsgb9V0nTUWnMG8mZdBU/pk0WDmxAk09dfUp+iXKpZFrl9muIbEM1iLZ
 Hc1xxY7yBMy2cu2/37BRiOkqWZfQhMznV1YPRknusde6jSuSPicu/MELBb6CTDk04zXU
 0bLT+MEDaDGWbmtJ14hom+4r4nQNLOutxZMt4+KsFo/+p2tjB2Dciulmwm3QsxQR5EIF
 RSoF2UHxDtQebK2OloV83+pk3Gt5/17DVvDg6GeCAcTG59RvZNRM3fuuvBvwfMbNQIE4
 HZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755631276; x=1756236076;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzK+T55OsSyRkBZov6ffk0VBOqix/EogK4ulDOtwgsg=;
 b=ZHjxe4JuJhlgF22G7mohIEvLtibuoGVWTGV5npCbKFpTvq84wR3dH9c990wuWN1QhM
 +YHHeRytDSNvvhZZ3XgKWk0p+oPCB87x9UN5q/XsH32KiZkQF+6Bf3McSjmq6y+CZ78c
 o+xW68geKxX2buNWBxZXaFNrpUveDmNwvdTFSoK5dF6DXguRU8fOrFCnz/aff8+6Ga5R
 Egi92eCIHrvYLI5Mqj/20fQri4sqOahMEZ/9Flp7YkOpIXrbrR8piZZjiHEE8LVH4EhT
 YJAxDMe2sR2RZdu6HVCqPQitJTEt3Y9bCn33k9nKTrxeq5xFaKyxugppcf4mIF2PTBOw
 mWjA==
X-Gm-Message-State: AOJu0YymlWuoM9Io/zfP5Bgyjsexc9mdIXCxDj9XFtcxr7uU156C6rFi
 csehWHTB5AOvxO8dHG8gBJ7+4pGte9NFtagKZZv8WBB0rDbFEhIasEp5dyQtRRFCiBA=
X-Gm-Gg: ASbGncsonroNVoJhSDT+dnda5FD6OZqjhfA6NRKiBtE9rjSrBcHsQdQPfOoslh2wJ27
 vCBaeJER103RvqhrL3oKUruHew9Oi2jd/b1/2JDcblBwOLlWX9Td+XSqyJghXotpKgN6nIcDiSs
 0i0GXVIqPuRmDVVtX40U4fAHoiMFK9VlMyXxiMCMRJgGhRLxcV+IdYzZI2cYHAYgwDUvxtCJ3yN
 3A1Yzh0BREd1AZxuzrHX3jPDKB0tJibHu+Z9xwF7xD/ZyY9eECVbDvn0lunlINaOS9sk1pjS8lA
 QljnTAJrGLvGrBmURuM/1/DegNc6V4I8PNuyxJJn2rmM6LmeE9M8ssybRtZYqztf6jzHEqtPB6u
 toJul+k2RfpVNhEO1z9MLKWOj8t8RQaXmXeITB92zllcnZHyDny5d6tGC/5ZIWyMlLPVXtHkjRv
 ZUDTo=
X-Google-Smtp-Source: AGHT+IErquXx+G3FqpY9DJUsDOGBrALDmN1ktvWB/zUy7mV1LETr3ON4fkhG9kx+iUUkAQm9rL1brw==
X-Received: by 2002:a17:907:1c25:b0:af9:10c7:59b6 with SMTP id
 a640c23a62f3a-afdf01c527cmr7089766b.32.1755631275437; 
 Tue, 19 Aug 2025 12:21:15 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441256.home.otenet.gr. [79.129.180.152])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afded4c9931sm36159466b.85.2025.08.19.12.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:21:14 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 19 Aug 2025 22:20:19 +0300
Subject: [PATCH RFC WIP] Add checkpatch.py
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250819-checkpatch-py-v1-1-99de8bb733db@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHLOpGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwMz3eSM1OTsgsSS5Azdgkpdy9QUI8MUQ4tkS8tUJaCegqLUtMwKsHn
 RSkFuzgrhngFKsbW1AFl7Y4BoAAAA
X-Change-ID: 20250806-checkpatch-py-9ed21d18c99e
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=58259;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=xmC28BzrcxXYNOPPduzD1B34TJXWhJy6TXSytc9QMQY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9wTTZwTzVXUmRpbCtHYmgwWlAvbzdJejE1SC9FClhNNGg5aDJlSmE2YXovcVBT
 MmVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUtUT3FRQUt
 DUkIzS2Nkd2YzNEowTFAzRC8wY2xKNFM1K2hRc1ArdGpRcjRLU01hYnBoSHFBSFdQS3lLVzc3Zw
 pmdENaTWlIcTg4cHJzZDA1Uit2NVF1bDhuMnRqVkxZWmR5bkRRN3g0d3dFUUpRVnNjRGk0aW0rV
 EtVUVR2ajlhCkwxbU1OTmZPSVRNL0JabWk5WkVsRnB3NEZuczg0Mi95R0tFa0RNelNqeWkxWS8v
 d1lnb0V2eVBJTlhuYmxJcUMKbDNqUHZ0TUdqdFhEV2htRERZcjA0eUxwQU1hczZIT1FNUTFPa2Z
 MUklpN2w1QkxXNzJRUEExWVNLbWRvNzE1Zwo4RENEY2VnWWR6WmxHRnZIOE1oT1hybzBpQ2dJUm
 l6SnA5U1RpUlQ4Q2srTTQ4QzV1SnhaZ25oY3ZUNi9HSE1WCmE1ak5UNmJYZ0hjTWFBdVNOWDNrT
 2JBYmFudEN2WDN2dlVWcWRaTUMrT0tydlNqeVpHRXo1dTAveHF1b1VsYjEKT1g1UnRDbkJjN0sx
 aFRDd2ZRQTFOQUR2OUFJUTk0SEIwdGJmSm81VWh4MVg1YTc4bmxVd3hDcTF0eTRQbjAvLwpRQm5
 wZzJXeW44UU1PcE1YZW9WbnFLRStsaDRKdWd6TXV5R2RPbjJTOGdSMnA3SEhHM0l1RzgzWDhQTX
 Z2L2dlCnFZOFpFUnQ0NUdmYStuMzNjRW9ESkI3eVFSSWd4OTdEcVdhaUx2QVJCeHl6emhVZUR0W
 EJWU2ErYlcwVCtQcWwKaXUwM2xqTFdEdmhZaXh1ZUZGZ3VyVmNMTC95OENSLzI3SUxpSGlCZnYz
 Nmpab1lTeEZ2OFF2SnFBdDhLanVZQQozV0lMeDZvSUkzWUNGQy8vQVdwNnNRZEQzcDZtMWRKOC9
 pbUE0M09QTG1ldWZVUWh1ZzBxSXlzcDdlNUdwMFVkCldCcDVvQT09Cj03YjBICi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Peter recently posted a series to update the kernel-doc perl script with
the new python one from the upstream kernel tree. I mentioned on IRC I
had a personal/private checkpatch python script and was encouraged to
post this here on the list.

While there's nothing immediately wrong with checkpatch.pl, its design
makes it harder to implement new checks, refactor code, and because of
its custom nature it's been nigh impossible for years to sync it with
the kernel's original implementation. So there's no particular
attachment to staying with a perl script of many thousands of lines.

This patch introduces a script/checkpatch.py script that uses a
script/libcheckpatch python library that doesn't use any dependencies.

There's a proof of concept for unittests:

  python3 -m unittest -v scripts/libcheckpatch/tests.py

The CLI use is/should be identical to checkpatch.pl; just substitute the
filename extension in your invocations. The output format(s) are also
identical.

All checks that are in the original perl script and are missing are
annotated with a # TODO comment. A grep TODO | wc -l says it's about 60
at the time of writing.

This is an incomplete replacement for checkpatch.pl, so for this RFC I
look forward to high-level architecture and design comments.

NB: Python's import resolution logic makes it difficult to split checks for
different kinds of files into separate modules, unfortunately. I hit
"circular import" errors a lot.
---
 .b4-config                        |   4 +-
 MAINTAINERS                       |   2 +-
 scripts/checkpatch.py             |   9 +
 scripts/libcheckpatch/__init__.py | 388 +++++++++++++++++++++++++++
 scripts/libcheckpatch/checks.py   | 535 ++++++++++++++++++++++++++++++++++++++
 scripts/libcheckpatch/output.py   |  89 +++++++
 scripts/libcheckpatch/patch.py    | 330 +++++++++++++++++++++++
 scripts/libcheckpatch/tests.py    | 277 ++++++++++++++++++++
 8 files changed, 1631 insertions(+), 3 deletions(-)

diff --git a/.b4-config b/.b4-config
index 126f503ded743473a3218bcbedf0721942b58585..81ff36b554359cb1a999957d2c1afd10709e5ad8 100644
--- a/.b4-config
+++ b/.b4-config
@@ -7,7 +7,7 @@
     send-series-to = qemu-devel@nongnu.org
     send-auto-to-cmd = echo
     send-auto-cc-cmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback
-    am-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
-    prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
+    am-perpatch-check-cmd = scripts/checkpatch.py -q --terse --no-summary --mailback -
+    prep-perpatch-check-cmd = scripts/checkpatch.py -q --terse --no-summary --mailback -
     searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
     linkmask = https://lore.kernel.org/qemu-devel/%s
diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76213e3a204bbbf3a83137f1487e4b65..24456ade19b684662bc521c92282117fbd5c79c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3585,7 +3585,7 @@ F: include/system/spdm-socket.h
 
 Checkpatch
 S: Odd Fixes
-F: scripts/checkpatch.pl
+F: scripts/checkpatch.p[ly]
 
 Migration
 M: Peter Xu <peterx@redhat.com>
diff --git a/scripts/checkpatch.py b/scripts/checkpatch.py
new file mode 100755
index 0000000000000000000000000000000000000000..09fd002b5ce3814370ad805c64554ef63b85a10a
--- /dev/null
+++ b/scripts/checkpatch.py
@@ -0,0 +1,9 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+
+from libcheckpatch import main
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/scripts/libcheckpatch/__init__.py b/scripts/libcheckpatch/__init__.py
new file mode 100755
index 0000000000000000000000000000000000000000..ac612b5cc3128e56577349f36e3c69a88d800da3
--- /dev/null
+++ b/scripts/libcheckpatch/__init__.py
@@ -0,0 +1,388 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""
+
+Check patches for submission.
+
+Copyright (c) 2025 Linaro Ltd.
+
+Authors:
+ Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+
+History
+=======
+
+This file has been adapted from the Perl script checkpatch.pl included in the
+QEMU tree, which was in turn imported verbatim from the Linux kernel tree in
+2011. Over the years it was adapted for QEMU-specific checks.
+
+Design / How to implement new checks
+====================================
+
+This script tries to detect the format of each file changed in a patch
+according to its filename suffix and/or file path. Then, it performs checks
+specific to the file format.
+
+Each file format corresponds to a class that inherits from `FileFormat` class.
+Each staticmethod whose name starts with `check_` is automatically executed for
+each file diff (i.e. collection of hunks) for each patch.
+
+To add new checks, simply add a new `check_DESCRIPTIVE_CHECK_NAME` staticmethod
+in the class of the appropriate file format.
+
+To "throw" a warning or an error, this script (ab)uses Python's warnings
+feature. Warnings can be thrown freely by default by creating an `Error` or
+`Warn` instance and collected using a context manager without breaking
+execution of tests:
+
+    # Throw error
+    Error("line over 90 characters")
+    # Or warn
+    # Warn("line over 80 characters")
+
+"""
+
+# pylint: disable=pointless-exception-statement
+
+import argparse
+import os
+import pathlib
+import subprocess
+import sys
+import warnings
+
+from .patch import *
+from .checks import *
+from .output import *
+
+
+def top_of_kernel_tree(path: pathlib.Path) -> bool:
+    """Verify path is the root directory of project"""
+    for item in [
+        "COPYING",
+        "MAINTAINERS",
+        "Makefile",
+        "README.rst",
+        "docs",
+        "VERSION",
+        "linux-user",
+        "system",
+    ]:
+        if not (path / item).exists():
+            return False
+    return True
+
+
+def main():
+    """
+    Read CLI arguments and print result to stdout
+    """
+    parser = argparse.ArgumentParser(prog="checkpatch.py")
+    parser.add_argument(
+        "FILE", type=argparse.FileType("r"), action="extend", nargs="*"
+    )
+    parser.add_argument("--version", action="version", version="%(prog)s 1.0")
+    parser.add_argument("-q", "--quiet", action="store_true")
+    parser.add_argument(
+        "--no-tree", action="store_true", help="run without a qemu tree"
+    )
+    parser.add_argument(
+        "--no-signoff",
+        dest="signoff",
+        action="store_false",
+        help="do not check for 'Signed-off-by' line",
+    )
+    # TODO:
+    # parser.add_argument(
+    #     "--emacs", action="store_true", help="emacs compile window format"
+    # )
+    parser.add_argument(
+        "--terse", action="store_true", help="one line per report"
+    )
+    parser.add_argument(
+        "--strict", action="store_true", help="fail if only warnings are found"
+    )
+    # TODO:
+    parser.add_argument(
+        "--root", type=pathlib.Path, help="PATH to the qemu tree root"
+    )
+    parser.add_argument(
+        "--no-summary",
+        action="store_true",
+        help="suppress the per-file summary",
+    )
+    parser.add_argument(
+        "--mailback",
+        action="store_true",
+        help="only produce a report in case of warnings/errors",
+    )
+    parser.add_argument(
+        "--summary-file",
+        action="store_true",
+        default=False,
+        help="include the filename in summary",
+    )
+    # TODO:
+    # parser.add_argument(
+    #     "--debug",
+    #     action="store_true",
+    #     help=(
+    #         "KEY=[0|1]turn on/off debugging of KEY, where KEY is one of"
+    #         " 'values', 'possible', 'type', and 'attr' (default is all off)"
+    #     ),
+    # )
+    parser.add_argument(
+        "--test-only",
+        type=str,
+        metavar="WORD",
+        help="report only warnings/errors containing WORD literally",
+    )
+
+    # TODO:
+    # parser.add_argument(
+    #     "--codespell",
+    #     action="store_true",
+    #     help=(
+    #         "Use the codespell dictionary for spelling/typos (default:"
+    #         " $codespellfile)"
+    #     ),
+    # )
+    # parser.add_argument(
+    #     "--codespellfile",
+    #     action="store_true",
+    #     help="Use this codespell dictionary",
+    # )
+    def parse_color(s: str) -> bool | None:
+        if s == "always":
+            return True
+        if s == "never":
+            return False
+        if s == "auto":
+            return None
+        raise ValueError("always,never,auto")
+
+    parser.register("type", "color", parse_color)
+    parser.add_argument(
+        "--color",
+        type="color",
+        metavar="WHEN",
+        default=None,
+        help=(
+            "Use colors 'always', 'never', or only when output is a terminal"
+            " ('auto'). Default is 'auto'."
+        ),
+    )
+    argtype_group = parser.add_mutually_exclusive_group(required=False)
+    argtype_group.add_argument(
+        "-f,",
+        "--file",
+        action="store_true",
+        default=True,
+        help="treat FILE as regular source file",
+    )
+    argtype_group.add_argument(
+        "--branch", nargs="+", help="treat args as GIT revision list"
+    )
+    argtype_group.add_argument(
+        "--patch", action="store_true", help="treat FILE as patchfile"
+    )
+    args = parser.parse_args()
+
+    if args.color is None:
+        args.color = sys.stdout.isatty()
+
+    if not args.no_tree:
+        if args.root:
+            root = pathlib.Path(args.root)
+            if not top_of_kernel_tree(root):
+                print("--root does not point at a valid tree")
+        else:
+            if top_of_kernel_tree(pathlib.Path(os.getcwd())):
+                root = pathlib.Path(os.getcwd())
+            else:
+                root = (pathlib.Path(sys.argv[0]) / ".." / "..").resolve()
+        if not top_of_kernel_tree(root):
+            print("Must be run from the top-level dir. of a qemu tree")
+            sys.exit(2)
+    else:
+        root = None
+
+    configuration = Configuration(signoff=args.signoff, root=root)
+
+    any_error = 0
+
+    patches = []
+
+    if args.branch:
+        git_env = {
+            "GIT_CONFIG_GLOBAL": "",
+            "GIT_CONFIG_SYSTEM": "",
+            "GIT_CONFIG_NOSYSTEM": "1",
+        }
+        if args.FILE:
+            parser.error(
+                "positional FILE argument cannot be used with --branch"
+            )
+        for revlist in args.branch:
+            hashes = subprocess.run(
+                ["git", "rev-list", "--reverse", revlist],
+                capture_output=True,
+                check=False,
+                env=os.environ | git_env,
+            )
+            if hashes.returncode != 0:
+                if hashes.stderr:
+                    print("git-rev-list:", hashes.stderr.decode("utf-8"))
+                parser.error(
+                    f"Revision list {revlist} could not be parsed: git"
+                    f" rev-list exited with {hashes.returncode}"
+                )
+            hashes = hashes.stdout.decode("utf-8").splitlines()
+            for commit_sha in hashes:
+                patch_text = subprocess.run(
+                    [
+                        "git",
+                        "-c",
+                        "diff.renamelimit=0",
+                        "-c",
+                        "diff.renames=True",
+                        "-c",
+                        "diff.algorithm=histogram",
+                        "format-patch",
+                        "--subject-prefix",
+                        "",
+                        "--patch-with-stat",
+                        "--stdout",
+                        f"{commit_sha}^..{commit_sha}",
+                    ],
+                    capture_output=True,
+                    check=False,
+                    env=os.environ | git_env,
+                )
+                if patch_text.returncode != 0:
+                    if patch_text.stderr:
+                        print(
+                            "git-format-patch:",
+                            patch_text.stderr.decode("utf-8"),
+                        )
+                    parser.error(
+                        f"Revision {commit_sha} could not be parsed: git"
+                        f" format-patch exited with {patch_text.returncode}"
+                    )
+                patches.append(
+                    Patch(
+                        configuration,
+                        patch_text.stdout.decode("utf-8"),
+                        sha=commit_sha,
+                    )
+                )
+    else:
+        for file in args.FILE:
+            filename = file.name
+            patches.append(
+                Patch(configuration, file.read(), filename=filename)
+            )
+
+    for p in patches:
+        output = []
+        errors_no = 0
+        warnings_no = 0
+        lines_no = 0
+
+        filename = p.filename or ""
+
+        lines_no += len(p.raw_string.splitlines())
+        with warnings.catch_warnings(record=True) as w:
+            p.check()
+            if args.strict:
+                for i in w:
+                    if isinstance(i.message, Warn):
+                        i.message = i.message.into_error()
+            output += [w.message for w in w]
+
+        if args.test_only:
+            output = [o for o in output if args.test_only in o.msg]
+
+        for o in output:
+            if isinstance(o, Warn):
+                warnings_no += 1
+            else:
+                errors_no += 1
+        any_error = errors_no
+        for o in output:
+
+            class Colors:
+                WARNING = "\033[35m" if args.color else ""
+                ERROR = "\033[91m" if args.color else ""
+                ENDC = "\033[0m" if args.color else ""
+                BOLD = "\033[1m" if args.color else ""
+
+            if args.terse:
+                print(
+                    f"{Colors.BOLD}{filename}:"
+                    f"{o.patch_line_no or ''}{Colors.ENDC}: ",
+                    end="",
+                )
+
+            if isinstance(o, Warn):
+                print(
+                    f"{Colors.WARNING}{Colors.BOLD}WARNING:{Colors.ENDC} ",
+                    end="",
+                )
+            else:
+                print(
+                    f"{Colors.ERROR}{Colors.BOLD}ERROR:{Colors.ENDC} ",
+                    end="",
+                )
+            print(o.msg)
+            if not args.terse and o.file_diff:
+                print(
+                    f"#{o.patch_line_no or ''}: FILE:"
+                    f" {o.file_diff.filename_b}:{o.line_no or ''}"
+                )
+                if o.patch_line_no:
+                    line = p.raw_string.splitlines()[o.patch_line_no - 1]
+
+                    print(
+                        line.translate(
+                            str.maketrans(
+                                {
+                                    "\000": r"\0",
+                                    "\011": r"^I",
+                                }
+                            )
+                        )
+                    )
+            if not args.terse:
+                print()
+
+        if not (args.mailback and (errors_no, warnings_no) == (0, 0)):
+            if args.summary_file:
+                print(f"{filename} ", end="")
+            print(
+                f"total: {errors_no} error{'s'[:errors_no^1]},"
+                f" {warnings_no} warning{'s'[:warnings_no^1]},"
+                f" {lines_no} line{'s'[:lines_no^1]} checked"
+            )
+
+            if not args.no_summary and not args.terse:
+                print()
+                if errors_no == 0:
+                    print(
+                        filename,
+                        "has no obvious style problems and is ready for"
+                        " submission.",
+                    )
+                else:
+                    print(
+                        filename,
+                        "has style problems, please review.  If any of these"
+                        " errors\nare false positives report them to the"
+                        " maintainer, see\nCHECKPATCH in MAINTAINERS.",
+                    )
+    return any_error
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/scripts/libcheckpatch/checks.py b/scripts/libcheckpatch/checks.py
new file mode 100644
index 0000000000000000000000000000000000000000..8ffc1c1eef54f34d20c1ea8797a3b989d00ff6d3
--- /dev/null
+++ b/scripts/libcheckpatch/checks.py
@@ -0,0 +1,535 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from collections.abc import Callable
+import re
+
+from . import patch
+from .output import Error, Warn
+
+type FileDiffTy = "FileDiff"
+type Check = Callable[
+    [
+        FileDiffTy,
+    ],
+    None,
+]
+
+
+class FileFormat:
+    """
+    Base class for a file format and appropriate checks
+
+    All @staticmethods that start with `check_` are collected as tests
+    applicable for this format.
+
+    If a file format is not detectable by filename suffix, its class should
+    override the `is_of` classmethod.
+    """
+
+    suffixes: list[str]
+    checks: dict[str, Check]
+    is_source_file: bool = False
+    is_executable_source_file: bool = False
+
+    def __new__(cls):
+        checks = {}
+        suffixes = []
+        for c in set([FileFormat, cls]):
+            for k, v in c.__dict__.items():
+                if isinstance(v, staticmethod) and k.startswith("check_"):
+                    checks[k] = v
+                elif k == "suffixes":
+                    suffixes += v
+        val = super().__new__(cls)
+        val.checks = checks
+        val.suffixes = suffixes
+        return val
+
+    @classmethod
+    def is_of(cls, path: str) -> bool:
+        """
+        Returns `True` if path suffix matches this format
+        """
+        for suf in cls.suffixes:
+            if path.endswith(f".{suf}"):
+                return True
+        return False
+
+    @staticmethod
+    def check_trailing_whitespace(file_diff: FileDiffTy):
+        """
+        Checks newly added lines for trailing whitespace
+        """
+        # ignore files that are being periodically imported from Linux
+        if file_diff.filename_b.startswith(
+            "linux-headers"
+        ) or file_diff.filename_b.startswith("include/standard-headers"):
+            return
+
+        if re.search(
+            r"^docs\/.+\.(?:(?:txt)|(?:md)|(?:rst))", file_diff.filename_a
+        ):
+            # TODO
+            # "code blocks in documentation should have empty lines with
+            # exactly 4 columns of whitespace
+            pass
+
+        for hunk in file_diff.hunks:
+            hunk.find_matches(
+                r"^\+.*\015", file_diff, Error, lambda _: "DOS line endings"
+            )
+            hunk.find_matches(
+                r"^\+.*\S+[ ]+$",
+                file_diff,
+                Error,
+                lambda _: "trailing whitespace",
+            )
+
+    @staticmethod
+    def check_column_limit(file_diff: FileDiffTy):
+        """
+        Checks column widths
+        """
+        if not file_diff.format.is_source_file:
+            return
+        # FIXME: exempt URLs
+        for hunk in file_diff.hunks:
+            for line in hunk.contents.splitlines():
+                if not line.startswith("+"):
+                    continue
+                if len(line) > 91:
+                    Error(
+                        "line over 90 characters",
+                        file_diff=file_diff,
+                        match=line,
+                        hunk=hunk,
+                    )
+                elif len(line) > 81:
+                    Warn(
+                        "line over 80 characters",
+                        file_diff=file_diff,
+                        match=line,
+                        hunk=hunk,
+                    )
+
+    @staticmethod
+    def check_eof_newline(file_diff: FileDiffTy):
+        """
+        Require newline at end of file
+        """
+        # TODO: adding a line without newline at end of file
+
+    @staticmethod
+    def check_tabs(file_diff: FileDiffTy):
+        """
+        Reject indentation with tab character
+        """
+        # tabs are only allowed in assembly source code, and in
+        # some scripts we imported from other projects.
+        if isinstance(
+            file_diff.format, (AssemblyFileFormat | PerlFileFormat)
+        ) or file_diff.filename_b.startswith("target/hexagon/imported"):
+            return
+
+        file_diff.find_matches(
+            r"^\+.*\t",
+            Error,
+            lambda _: "code indent should never use tabs",
+        )
+
+    @staticmethod
+    def check_spdx_header(file_diff: FileDiffTy):
+        """
+        Check SPDX-License-Identifier exists and references a permitted license
+        """
+        # TODO: Check for spdx header
+
+        # Imported Linux headers probably have SPDX tags, but if they
+        # don't we're not requiring contributors to fix this, as these
+        # files are not expected to be modified locally in QEMU.
+        # Also don't accidentally detect own checking code.
+        if file_diff.filename_b.startswith(
+            "include/standard-headers"
+        ) or file_diff.filename_b.startswith("linux-headers"):
+            return
+
+    @staticmethod
+    def check_license_boilerplates(file_diff: FileDiffTy):
+        """
+        Checks for new files with license boilerplate
+        """
+
+        if (
+            not file_diff.action is patch.FileAction.NEW
+            or file_diff.filename_b.startswith("scripts/libcheckpatch")
+        ):
+            return
+
+        boilerplate_re = r"^\+.*" + "|".join(
+            [
+                "licensed under the terms of the GNU GPL",
+                "under the terms of the GNU General Public License",
+                "under the terms of the GNU Lesser General Public",
+                "Permission is hereby granted, free of charge",
+                "GNU GPL, version 2 or later",
+                "See the COPYING file",
+            ]
+        )
+        # FIXME: shows only first match for compatibility with checkpatch.pl
+        file_diff.find_match(
+            boilerplate_re,
+            Error,
+            lambda _: (
+                f"New file '{file_diff.filename_b}' must "
+                "not have license boilerplate header text, only "
+                "the SPDX-License-Identifier, unless this file was "
+                "copied from existing code already having such text."
+            ),
+        )
+
+    @staticmethod
+    def check_qemu(file_diff: FileDiffTy):
+        """
+        QEMU specific tests
+        """
+        # FIXME: check only C files for compatibility with checkpatch.pl
+        if not isinstance(file_diff.format, CFileFormat):
+            return
+        file_diff.find_matches(
+            r"^\+.*\b(?:Qemu|QEmu)\b",
+            Error,
+            lambda _: "use QEMU instead of Qemu or QEmu",
+        )
+
+    @staticmethod
+    def check_file_permissions(fd: FileDiffTy):
+        """
+        Check for incorrect file permissions
+        """
+        if (
+            fd.format.is_source_file
+            and not fd.format.is_executable_source_file
+            and fd.mode
+            and fd.mode & 0o0111 > 0
+        ):
+            Error("do not set execute permissions for source files")
+
+    @staticmethod
+    def check_maintainers(file_diff: FileDiffTy):
+        """
+        Checks if MAINTAINERS must be updated when adding, moving or deleting
+        files
+        """
+
+        if file_diff.action is patch.FileAction.MODIFIED:
+            return
+
+        # TODO: WARN("added, moved or deleted file(s):"
+
+
+class PythonFileFormat(FileFormat):
+    """
+    Python file format
+    """
+
+    is_source_file = True
+    is_executable_source_file = True
+    suffixes = ["py"]
+
+    @staticmethod
+    def check_python_interp(file_diff: FileDiffTy):
+        """
+        Only allow Python 3 interpreter
+        """
+        interp_re = r"^\+#![ ]*[/]usr[/]bin[/](?:env )?python\n"
+        for h in file_diff.hunks:
+            if h.line_no == 1 and re.search(
+                interp_re, h.contents.partition("\n")[2]
+            ):
+                h.find_match(
+                    interp_re,
+                    file_diff,
+                    Error,
+                    lambda _: "please use python3 interpreter",
+                )
+
+
+class AssemblyFileFormat(FileFormat):
+    """
+    Assembly file format
+    """
+
+    is_source_file = True
+    suffixes = ["s", "S"]
+
+
+class PerlFileFormat(FileFormat):
+    """
+    Perl file format
+    """
+
+    is_source_file = True
+    is_executable_source_file = True
+    suffixes = ["pl"]
+
+
+class MesonFileFormat(FileFormat):
+    """
+    Meson build file format
+    """
+
+    is_source_file = False
+    suffixes = ["build"]
+
+
+class ShellFileFormat(FileFormat):
+    """
+    Shell script file format
+    """
+
+    is_source_file = True
+    is_executable_source_file = True
+    suffixes = ["sh"]
+
+
+class TraceEventFileFormat(FileFormat):
+    """
+    trace-events file format
+    """
+
+    suffixes = []
+
+    @classmethod
+    def is_of(cls, path: str) -> bool:
+        return path.endswith("trace-events")
+
+    @staticmethod
+    def check_hex_specifier(file_diff: FileDiffTy):
+        """
+        Reject %# format specifier
+        """
+        # TODO: Don't use '#' flag of printf format ('%#') in trace-events, use
+        # '0x' prefix instead
+
+    @staticmethod
+    def check_hex_prefix(file_diff: FileDiffTy):
+        """
+        Require 0x prefix for hex numbers
+        """
+        # TODO: Hex numbers must be prefixed with '0x'
+
+
+class CFileFormat(FileFormat):
+    """
+    C file format
+    """
+
+    is_source_file = True
+    suffixes = ["c", "h", "c.inc"]
+
+    @staticmethod
+    def check_non_portable_libc_calls(file_diff: FileDiffTy):
+        """
+        Check for non-portable libc calls that have portable alternatives in
+        QEMU
+        """
+        replacements = {
+            r"\bffs\(": "ctz32",
+            r"\bffsl\(": "ctz32() or ctz64",
+            r"\bffsll\(": "ctz64",
+            r"\bbzero\(": "memset",
+            r"\bsysconf\(_SC_PAGESIZE\)": "qemu_real_host_page_size",
+            r"\b(?:g_)?assert\(0\)": "g_assert_not_reached",
+            r"\b(:?g_)?assert\(false\)": "g_assert_not_reached",
+            r"\bstrerrorname_np\(": "strerror",
+        }
+        non_exit_glib_asserts_re = r"^\+.*" + (
+            r"g_assert_cmpstr"
+            r"|g_assert_cmpint|g_assert_cmpuint"
+            r"|g_assert_cmphex|g_assert_cmpfloat"
+            r"|g_assert_true|g_assert_false|g_assert_nonnull"
+            r"|g_assert_null|g_assert_no_error|g_assert_error"
+            r"|g_test_assert_expected_messages|g_test_trap_assert_passed"
+            r"|g_test_trap_assert_stdout|g_test_trap_assert_stdout_unmatched"
+            r"|g_test_trap_assert_stderr|g_test_trap_assert_stderr_unmatched"
+        )
+
+        for hunk in file_diff.hunks:
+            for r, w in replacements.items():
+                hunk.find_matches(
+                    r"^\+.*" + r,
+                    file_diff,
+                    Error,
+                    lambda match: f"use {w}() instead of {match.group()}",
+                )
+            hunk.find_matches(
+                non_exit_glib_asserts_re,
+                file_diff,
+                Error,
+                lambda m: (
+                    "Use g_assert or g_assert_not_reached instead of"
+                    f" {m.group()}"
+                ),
+            )
+
+    @staticmethod
+    def check_qemu_error_functions(_: FileDiffTy):
+        """
+        QEMU error function tests
+        """
+        # TODO: Find newlines in error messages
+        error_funcs_re = (
+            r"error_setg|"
+            r"error_setg_errno|"
+            r"error_setg_win32|"
+            r"error_setg_file_open|"
+            r"error_set|"
+            r"error_prepend|"
+            r"warn_reportf_err|"
+            r"error_reportf_err|"
+            r"error_vreport|"
+            r"warn_vreport|"
+            r"info_vreport|"
+            r"error_report|"
+            r"warn_report|"
+            r"info_report|"
+            r"g_test_message"
+        )
+
+    @staticmethod
+    def check_ops_structs_are_const(file_diff: FileDiffTy):
+        """check for various ops structs, ensure they are const."""
+        # TODO
+
+    @staticmethod
+    def check_comments(file_diff: FileDiffTy):
+        for hunk in file_diff.hunks:
+            hunk.find_matches(
+                r"^\+.*?[/][/](?! SPDX-License-Identifier:)",
+                file_diff,
+                Error,
+                lambda _: "do not use C99 // comments",
+            )
+
+        for hunk in file_diff.hunks:
+            hunk.find_matches(
+                r"^\+\s*[/]\s*[*][ \t]*\S+",
+                file_diff,
+                Warn,
+                lambda _: "Block comments use a leading /* on a separate line",
+            )
+            # TODO: WARN("Block comments use * on subsequent lines
+            # FIXME: Check comment context for trailing */
+            hunk.find_matches(
+                r"^\+\s*[*][ \t]*\S+\s*[*][/]$",
+                file_diff,
+                Warn,
+                lambda _: (
+                    "Block comments use a trailing */ on a separate line"
+                ),
+            )
+        # TODO: WARN("Block comments should align the * on each line
+
+    # unimplemented:
+
+    # TODO: switch and case should be at the same indent
+    # TODO: that open brace { should be on the previous line
+    # TODO: trailing semicolon indicates no statements, indent implies
+    # otherwise
+    # TODO: suspicious ; after while (0)
+    # TODO: superfluous trailing semicolon
+    # TODO: suspect code indent for conditional statements ($indent, $sindent)
+    # TODO: \"(foo$from)\" should be \"(foo$to)\"
+    # TODO: \"foo${from}bar\" should be \"foo${to}bar\"
+    # TODO: open brace '{' following function declarations go on the next line
+    # TODO: missing space after $1 definition
+    # TODO: check for malformed paths in #include statements
+    # TODO: check for global initialisers.
+    # TODO: check for static initialisers.
+    # TODO: * goes on variable not on type
+    # TODO: function brace can't be on same line, except for #defines of do
+    # while, or if closed on same line
+    # TODO: open braces for enum, union and struct go on the same line.
+    # TODO: missing space after union, struct or enum definition
+    # TODO: check for spacing round square brackets; allowed:
+    #  1. with a type on the left -- int [] a;
+    #  2. at the beginning of a line for slice initialisers -- [0...10] = 5,
+    #  3. inside a curly brace -- = { [0...10] = 5 }
+    #  4. after a comma -- [1] = 5, [2] = 6
+    #  5. in a macro definition -- #define abc(x) [x] = y
+    # TODO: check for spaces between functions and their parentheses.
+    # TODO: Check operator spacing.
+    # TODO: need space before brace following if, while, etc
+    # TODO: closing brace should have a space following it when it has anything
+    # on the line
+    # TODO: check spacing on square brackets
+    # TODO: check spacing on parentheses
+    # TODO: Return is not a function.
+    # TODO: Return of what appears to be an errno should normally be -'ve
+    # TODO: Need a space before open parenthesis after if, while etc
+    # TODO: Check for illegal assignment in if conditional -- and check for
+    # trailing statements after the conditional.
+    # TODO: Check for bitwise tests written as boolean
+    # TODO: if and else should not have general statements after it
+    # TODO: if should not continue a brace
+    # case and default should not have general statements after them
+    # TODO: no spaces allowed after \ in define
+    # TODO: multi-statement macros should be enclosed in a do while loop, grab
+    # the first statement and ensure its the whole macro if its not enclosed
+    # in a known good container
+    # TODO: check for missing bracing around if etc
+    # TODO: no volatiles please
+    # TODO: warn about #if 0
+    # TODO: check for needless g_free() checks
+    # TODO: warn about spacing in #ifdefs
+    # TODO: check for memory barriers without a comment.
+    # TODO: check of hardware specific defines
+    # we have e.g. CONFIG_LINUX and CONFIG_WIN32 for common cases
+    # where they might be necessary.
+    # TODO: Check that the storage class is at the beginning of a declaration
+    # TODO: check the location of the inline attribute, that it is between
+    # storage class and type.
+    # TODO: check for sizeof(&)
+    # TODO: check for new externs in .c files.
+    # TODO: check for pointless casting of g_malloc return
+    @staticmethod
+    def check_misc_recommends(file_diff: FileDiffTy):
+        # check for gcc specific __FUNCTION__
+        file_diff.find_matches(
+            r"^\+.*__FUNCTION__",
+            Error,
+            lambda _: (
+                "__func__ should be used instead of gcc specific __FUNCTION__"
+            ),
+        )
+
+        # recommend g_path_get_* over g_strdup(basename/dirname(...))
+        file_diff.find_matches(
+            r"^\+.*\bg_strdup\s*\(\s*(basename|dirname)\s*\(",
+            Warn,
+            lambda m: (
+                "consider using g_path_get_{m.group(1)}() in preference to"
+                " g_strdup({m.group(1)}())"
+            ),
+        )
+        # enforce g_memdup2() over g_memdup()
+        file_diff.find_matches(
+            r"^\+.*\bg_memdup\s*\(",
+            Error,
+            lambda _: "use g_memdup2() instead of unsafe g_memdup()",
+        )
+        # TODO: recommend qemu_strto* over strto* for numeric conversions
+        # TODO: recommend sigaction over signal for portability, when
+        # establishing a handler
+        # TODO: recommend qemu_bh_new_guarded instead of qemu_bh_new
+        # TODO: recommend aio_bh_new_guarded instead of aio_bh_new
+        # check for module_init(), use category-specific init macros
+        # explicitly please
+        file_diff.find_matches(
+            r"^\+.*\bmodule_init\(",
+            Error,
+            lambda _: (
+                "please use block_init(), type_init() etc. instead of"
+                " module_init()"
+            ),
+        )
diff --git a/scripts/libcheckpatch/output.py b/scripts/libcheckpatch/output.py
new file mode 100644
index 0000000000000000000000000000000000000000..3f4dc73d2ccf8d8f82677fbec935fb88fd8c216a
--- /dev/null
+++ b/scripts/libcheckpatch/output.py
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import re
+import warnings
+
+type FileDiffTy = "FileDiff"
+type HunkTy = "Hunk"
+
+
+class Output(UserWarning):
+    """
+    Base class for checkpatch output items (error or warn)
+    """
+
+    # FIXME: Receive patch, hunk in constructor to calculate line numbers right
+    # away?
+    def __init__(
+        self,
+        msg: str,
+        /,
+        *args,
+        file_diff: FileDiffTy | None = None,
+        match: str | re.Match | None = None,
+        hunk: HunkTy | None = None,
+        **kwargs,
+    ):
+
+        super().__init__(*args, **kwargs)
+        self.msg = msg
+        self.line_no = 0
+        self.file_diff = file_diff
+        self.match = match
+        self.hunk = hunk
+        if file_diff and hunk and match:
+            if isinstance(match, str):
+                hunk_offset = hunk.contents.find(match)
+            elif isinstance(match, re.Match):
+                hunk_offset = match.start()
+            self.line_no = hunk.find_line(match)
+            patch_offset = hunk.offset + hunk_offset
+            self.patch_line_no = 1 + file_diff.patch.raw_string.count(
+                "\n", 0, patch_offset
+            )
+        else:
+            self.line_no = None
+            self.patch_line_no = None
+        warnings.warn(self)
+
+    def __str__(self):
+        # Needs a unique __str__ value otherwise warnings will be deduplicated
+        ret = self.msg
+        if self.patch_line_no:
+            ret = f"{self.patch_line_no} {ret}"
+        if self.file_diff:
+            ret = f"{ret} {self.file_diff.filename_b}"
+            if self.line_no:
+                ret = f"{ret}:{self.line_no}"
+        return ret
+
+    def __repr__(self):
+        ret = f"{repr(self.msg)}"
+        ret += f":{repr(self.patch_line_no)}"
+        ret += f":{repr(self.file_diff.filename_b)}"
+        ret += f":{repr(self.line_no)}"
+        ret += f":{repr(isinstance(self, Warn))}"
+        return ret
+
+
+class Error(Output):
+    """
+    A checkpatch error
+    """
+
+
+class Warn(Output):
+    """
+    A checkpatch warning
+    """
+
+    def into_error(self) -> Error:
+        """
+        Convert warning into error
+        """
+        return Error(
+            self.msg,
+            file_diff=self.file_diff,
+            hunk=self.hunk,
+            match=self.match,
+        )
diff --git a/scripts/libcheckpatch/patch.py b/scripts/libcheckpatch/patch.py
new file mode 100644
index 0000000000000000000000000000000000000000..e815e128d6c40a3a72e099e7f952f3cae1aebed8
--- /dev/null
+++ b/scripts/libcheckpatch/patch.py
@@ -0,0 +1,330 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from collections.abc import Callable
+from email import message_from_string
+from functools import cached_property
+import enum
+import itertools
+import pathlib
+import re
+
+from . import checks
+from .output import Output, Error
+
+type PatchTy = "Patch"
+type FileDiffTy = "FileDiff"
+
+
+class Configuration:
+    def __init__(
+        self, /, signoff: bool = True, root: pathlib.Path | None = None
+    ):
+        self.signoff = signoff
+        self.root = root
+
+
+class Hunk:
+    """
+    A single diff hunk
+    """
+
+    def __init__(self, offset: int, line_no: int, contents: str):
+        self.offset = offset
+        self.line_no = line_no
+        self.contents = contents
+
+    def __repr__(self):
+        return self.contents
+
+    def find_match(
+        self,
+        regex: str,
+        file_diff: FileDiffTy,
+        category: type[Output],
+        cb: Callable[[re.Match], None],
+    ) -> bool:
+        assert regex.startswith(r"^\+")
+        match = re.search(regex, self.contents, re.MULTILINE)
+        if match:
+            category(
+                cb(match),
+                file_diff=file_diff,
+                match=match,
+                hunk=self,
+            )
+        return match is not None
+
+    def find_matches(
+        self,
+        regex: str,
+        file_diff: FileDiffTy,
+        category: type[Output],
+        cb: Callable[[re.Match], None],
+    ):
+        assert regex.startswith(r"^\+")
+        for match in re.finditer(regex, self.contents, re.MULTILINE):
+            category(
+                cb(match),
+                file_diff=file_diff,
+                match=match,
+                hunk=self,
+            )
+
+    def find_line(self, match: str | re.Match) -> int:
+        # skip control line ("@@")
+        control_line, contents = self.contents.split("\n", 1)
+        if isinstance(match, str):
+            offset = contents.find(match)
+        elif isinstance(match, re.Match):
+            offset = match.start() - len(control_line) - 1
+        line_no = self.line_no + len(
+            [
+                l
+                for l in contents[:offset].splitlines()
+                if not l.startswith("-")
+            ]
+        )
+
+        return line_no
+
+
+class FileAction(enum.Enum):
+    MODIFIED = 1
+    NEW = enum.auto()
+    DELETED = enum.auto()
+    RENAMED = enum.auto()
+
+
+class FileDiff:
+    """
+    Representation of a batch of diff hunks for a single file in a patch/diff
+    """
+
+    def __init__(
+        self,
+        patch_offset: int,
+        patch: PatchTy,
+        filename_a: str,
+        filename_b: str,
+        hunks: list[Hunk],
+        mode: int | None = None,
+        action: FileAction = FileAction.MODIFIED,
+    ):
+        self.patch_offset = patch_offset
+        self.patch = patch
+        self.filename_a = filename_a
+        self.filename_b = filename_b
+        self.hunks = hunks
+        self.mode = mode
+        self.action = action
+
+    def find_match(
+        self,
+        regex: str,
+        category: type[Output],
+        cb: Callable[[re.Match], None],
+    ) -> bool:
+        for h in self.hunks:
+            if h.find_match(regex, self, category, cb):
+                return True
+        return False
+
+    def find_matches(
+        self,
+        regex: str,
+        category: type[Output],
+        cb: Callable[[re.Match], None],
+    ):
+        for h in self.hunks:
+            h.find_matches(regex, self, category, cb)
+
+    def __repr__(self):
+        return f"{self.filename_a} {len(self.hunks)} hunks"
+
+    @cached_property
+    def format(self) -> checks.FileFormat:
+        """
+        Returns the detected file format for this file diff
+        """
+
+        # Hack(?): discover all subclasses of FileFormat by calling the
+        # __subclasses__ method. Classes that might have not been
+        # imported/parsed will not appear, but we assume that this code is
+        # called after everything has been loaded.
+        for subclass in checks.FileFormat.__subclasses__():
+            if subclass.is_of(self.filename_b):
+                return subclass()
+        return checks.FileFormat()
+
+
+class Patch:
+    """
+    Representation of a patch/diff
+    """
+
+    def __init__(
+        self,
+        configuration: Configuration,
+        raw_string: str,
+        filename: str | None = None,
+        sha: str | None = None,
+    ):
+        """Attempt to parse `raw_string` as a patch"""
+
+        self.raw_string = raw_string
+        self.configuration = configuration
+        self.filename = filename
+        self.sha = sha
+        self.msg = None
+        self.description = None
+        self.body = None
+        self.file_diffs = []
+        self.parse_exception = None
+
+        self.msg = message_from_string(raw_string)
+        if self.msg.is_multipart():
+            self.parse_exception = ValueError("multipart")
+            return
+        try:
+            split = self.msg.get_payload().split("\n---\n", maxsplit=1)
+            if len(split) == 2:
+                self.description, self.body = split
+            else:
+                self.description = split[0]
+                self.body = ""
+        except ValueError as exc:
+            self.parse_exception = ValueError(
+                "Does not appear to be a unified-diff format patch"
+            ).with_traceback(exc.__traceback__)
+            return
+        if not self.filename and self.sha:
+            try:
+                subject = self.msg.get_all("Subject")[0]
+                self.filename = f"Commit {self.sha} ({subject})"
+            except TypeError:
+                self.filename = f"Commit {self.sha}"
+
+        body_offset = raw_string.find(self.body)
+        files = []
+        prev = None
+        for match in re.finditer(r"^diff --git ", self.body, re.MULTILINE):
+            if prev is not None:
+                files.append(
+                    (body_offset + prev, self.body[prev : match.start()])
+                )
+            prev = match.start()
+
+        if prev is not None:
+            files.append((body_offset + prev, self.body[prev:]))
+
+        self.file_diffs = []
+        for offset, f in files:
+            matches = re.search(
+                r"^diff --git a\/(?P<filename_a>[^ ]+) b\/(?P<filename_b>[^"
+                r" ]+)$",
+                f,
+                re.MULTILINE,
+            )
+            if not matches:
+                self.parse_exception = ValueError(
+                    "Does not appear to be a unified-diff format patch"
+                )
+                return
+            filename_a = matches.groups("filename_a")[0]
+            filename_b = matches.groups("filename_b")[0]
+            hunks: list[Hunk] = []
+            prev = None
+            for match in re.finditer(
+                r"^@@ [-]\d+(?:,\d+)? [+](?P<line_no>\d+)(?:,\d+)? @@",
+                f,
+                re.MULTILINE,
+            ):
+                if prev is not None:
+                    hunks.append(
+                        Hunk(
+                            offset + prev[0],
+                            prev[1],
+                            f[prev[0] : match.start()],
+                        )
+                    )
+                prev = (match.start(), int(match.group("line_no")))
+
+            if prev is not None:
+                hunks.append(Hunk(offset + prev[0], prev[1], f[prev[0] :]))
+
+            action = None
+            matches = re.search(
+                r"^new (?:file )?mode\s+([0-7]+)$",
+                f[: hunks[0].offset],
+                re.MULTILINE,
+            )
+            if matches:
+                mode = int(matches.group(1), 8)
+                action = FileAction.NEW
+            else:
+                mode = None
+            self.file_diffs.append(
+                FileDiff(
+                    offset,
+                    self,
+                    filename_a,
+                    filename_b,
+                    hunks,
+                    mode=mode,
+                    action=action,
+                )
+            )
+
+    def check_author_address(self):
+        """Check for invalid author address"""
+        if self.parse_exception:
+            return
+        regex = r".*? via .*?<qemu-\w+@nongnu\.org>"
+
+        authors = itertools.chain(
+            self.msg.get_all("From") or [], self.msg.get_all("Author") or []
+        )
+        for val in authors:
+            if re.search(regex, val):
+                Error(
+                    "Author email address is mangled by the mailing list",
+                )
+
+    def check_signoff(self):
+        """Check patch for valid signoff (DCO)"""
+        if self.parse_exception:
+            return
+        for match in re.finditer(
+            r"^\s*signed-off-by",
+            self.description,
+            re.MULTILINE | re.IGNORECASE,
+        ):
+            match_start = self.description[match.start() :]
+            if not re.search(
+                r"^\s*Signed-off-by:.*$", match_start, re.MULTILINE
+            ):
+                Error(
+                    'The correct form is "Signed-off-by" found'
+                    f" {match_start=}",
+                )
+            if re.search(r"\s*signed-off-by:\S", match_start):
+                Error(
+                    "Space required after Signed-off-by:",
+                )
+            break
+        else:
+            Error(
+                "Missing Signed-off-by: line(s)",
+            )
+
+    def check(self):
+        """Check patch and all files in patch according to their file format"""
+        if self.parse_exception:
+            Error(str(self.parse_exception))
+            return
+        self.check_author_address()
+        if self.configuration.signoff:
+            self.check_signoff()
+        for f in self.file_diffs:
+            for v in f.format.checks.values():
+                v(f)
diff --git a/scripts/libcheckpatch/tests.py b/scripts/libcheckpatch/tests.py
new file mode 100644
index 0000000000000000000000000000000000000000..8cdb537900f8a9b0908c212c00cc4cc598731b28
--- /dev/null
+++ b/scripts/libcheckpatch/tests.py
@@ -0,0 +1,277 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import difflib
+import unittest
+import warnings
+
+from . import patch
+from .output import Warn, Output
+
+
+class ExpectedOutput:
+    def __init__(
+        self,
+        /,
+        msg: str,
+        patch_line_no: int,
+        filename: str,
+        line_no: int,
+        is_warning: bool = False,
+    ):
+        self.msg = msg
+        self.patch_line_no = patch_line_no
+        self.filename = filename
+        self.line_no = line_no
+        self.is_warning = is_warning
+
+    def __repr__(self):
+        ret = f"{repr(self.msg)}"
+        ret += f":{repr(self.patch_line_no)}"
+        ret += f":{repr(self.filename)}"
+        ret += f":{repr(self.line_no)}"
+        ret += f":{repr(self.is_warning)}"
+        return ret
+
+    def __eq__(self, other) -> bool:
+        if isinstance(other, Output):
+            return (
+                other.msg,
+                other.patch_line_no,
+                other.file_diff.filename_b,
+                other.line_no,
+                isinstance(other, Warn),
+            ) == (
+                self.msg,
+                self.patch_line_no,
+                self.filename,
+                self.line_no,
+                self.is_warning,
+            )
+        raise ValueError(f"unexpected type {type(other)=}")
+
+
+class PatchBuilder:
+    """
+    Helper class to generate a patch for testing
+    """
+
+    def __init__(self):
+        self.files = {}
+
+    def add_file(self, fromfile: str, tofile: str | None = None):
+        """
+        Pre-declare a file to be included in the patch
+        """
+        if tofile is None:
+            tofile = fromfile
+        self.files[fromfile] = (tofile, [])
+
+    def add_change(self, file: str, change: list[(str, str)]):
+        if file not in self.files:
+            self.add_file(file)
+        for before, after in change:
+            self.files[file][1].append(
+                (
+                    before.splitlines(keepends=True),
+                    after.splitlines(keepends=True),
+                )
+            )
+
+    def __str__(self):
+        ret = (
+            "From 83eb8eddd14847d7b7555d8594b256be350910ec "
+            "Mon Sep 17 00:00:00 2001\n"
+            + """From: Developer <developer@example.com>
+Date: Tue, 12 Aug 2025 14:08:44 +0300
+Subject: [PATCH] Subject
+
+Signed-off-by: Developer <developer@example.com>
+---
+"""
+        )
+        for f, v in self.files.items():
+            fromname = f
+            toname = v[0]
+            ret += f"diff --git a/{fromname} b/{toname}\n"
+            ret += "index b120a1f69e..6150a95f2e 100644\n"
+            for a, b in v[1]:
+                for l in difflib.unified_diff(
+                    a, b, f"a/{fromname}", f"b/{toname}", lineterm="\n"
+                ):
+                    ret += l
+        return ret
+
+
+class TestCheckpatch(unittest.TestCase):
+    configuration = patch.Configuration(signoff=True)
+
+    def assertOutput(
+        self, ptext: PatchBuilder, expected: list[ExpectedOutput]
+    ):
+        p = patch.Patch(self.configuration, str(ptext))
+        with warnings.catch_warnings(record=True) as w:
+            p.check()
+            w = [w.message for w in w]
+            self.assertEqual(len(w), len(expected))
+            for w, e in zip(w, expected):
+                self.assertEqual(w, e)
+
+    def test_trailing_ws(self):
+        ptext = PatchBuilder()
+        ptext.add_change(
+            "README.rst",
+            [
+                (
+                    "For version history and release notes, please visit\n",
+                    "For version history and release notes, please visit\x20\n",
+                )
+            ],
+        )
+        ptext.add_change(
+            "README.rst",
+            [
+                (
+                    (
+                        "QEMU is capable of emulating a complete machine in"
+                        " software without any\n"
+                    ),
+                    (
+                        "QEMU is capable of emulating a complete machine in"
+                        " software without any\r\n"
+                    ),
+                )
+            ],
+        )
+        self.assertOutput(
+            ptext,
+            [
+                ExpectedOutput(
+                    msg="trailing whitespace",
+                    patch_line_no=14,
+                    filename="README.rst",
+                    line_no=1,
+                ),
+                ExpectedOutput(
+                    msg="DOS line endings",
+                    patch_line_no=19,
+                    filename="README.rst",
+                    line_no=1,
+                ),
+            ],
+        )
+
+    def test_tabs(self):
+        ptext = PatchBuilder()
+        ptext.add_change(
+            "README.rst",
+            [
+                (
+                    "For version history and release notes, please visit\n",
+                    "\tFor version history and release notes, please visit\n",
+                )
+            ],
+        )
+        self.assertOutput(
+            ptext,
+            [
+                ExpectedOutput(
+                    msg="code indent should never use tabs",
+                    patch_line_no=14,
+                    filename="README.rst",
+                    line_no=1,
+                ),
+            ],
+        )
+
+    def test_column_limit(self):
+        # non-source files are not checked for column limits
+        ptext = PatchBuilder()
+        ptext.add_change(
+            "README.rst",
+            [
+                (
+                    (
+                        "QEMU is capable of emulating a complete machine in"
+                        " software without any\n"
+                    ),
+                    (
+                        "QEMU is capable of emulating a complete machine in"
+                        " software without any need for hardware virtualization"
+                        " support. By using dynamic translation,\n"
+                    ),
+                )
+            ],
+        )
+        self.assertOutput(
+            ptext,
+            [],
+        )
+        # Line over 80 chars produces a warning
+        ptext = PatchBuilder()
+        ptext.add_change(
+            "file.c",
+            [
+                (
+                    "static int long_function_name(const char *arg)\n",
+                    (
+                        "static int long_function_name(const char *many, const"
+                        " char *more, const char *args)\n"
+                    ),
+                )
+            ],
+        )
+        self.assertOutput(
+            ptext,
+            [
+                ExpectedOutput(
+                    msg="line over 80 characters",
+                    patch_line_no=14,
+                    filename="file.c",
+                    line_no=1,
+                    is_warning=True,
+                ),
+            ],
+        )
+        # Line over 90 chars produces an error
+        ptext = PatchBuilder()
+        ptext.add_change(
+            "file.c",
+            [
+                (
+                    "static int long_function_name(const char *arg)\n",
+                    (
+                        "static int long_function_name(const char *many1, const"
+                        " char *many2, const char *more, const char *args)\n"
+                    ),
+                )
+            ],
+        )
+        self.assertOutput(
+            ptext,
+            [
+                ExpectedOutput(
+                    msg="line over 90 characters",
+                    patch_line_no=14,
+                    filename="file.c",
+                    line_no=1,
+                ),
+            ],
+        )
+
+    def test_python(self):
+        ptext = PatchBuilder()
+        ptext.add_change(
+            "script.py",
+            [("", "#!/usr/bin/env python\n")],
+        )
+        self.assertOutput(
+            ptext,
+            [
+                ExpectedOutput(
+                    msg="please use python3 interpreter",
+                    patch_line_no=13,
+                    filename="script.py",
+                    line_no=1,
+                ),
+            ],
+        )

---
base-commit: 5836af0783213b9355a6bbf85d9e6bc4c9c9363f
change-id: 20250806-checkpatch-py-9ed21d18c99e

--
γαῖα πυρί μιχθήτω


