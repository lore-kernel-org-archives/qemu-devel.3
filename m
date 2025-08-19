Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCC4CA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoJVq-0001Ml-Cr; Tue, 19 Aug 2025 06:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoJVp-0001Mc-Gc
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:24:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoJVn-0006PB-5d
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:24:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a1b00797dso34214105e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755599052; x=1756203852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D9qnMtEWxDnol/yTO5+KE2jWpCXB4W0LlhbHWnzYIJs=;
 b=NBSp48NxLGL0oWC3K8v8ywf19+6hRJ3kY/X2b3a+jhUPsR3NzE5RHJ106GuhbsVqCi
 ucEuMje9YyQsQHIpaLUgMpMri7jvXtYXEfYTnpqiB5oDUlLosRIpgrA5ZZivrHtFN9D8
 oiVaS7Q1nKC49CDusbWfOfkRL/ySspHOxemvF6ufpOE0J2xX94iaF2+6SpBRIG4ASjrF
 NlboImqM0+Q8PTZ31H75rDBGYPb4YROrSQnn//VOqg73TG6LH6WalsgwymYHlaDo7Wum
 Bc6WBLvsIPzQS1oIeF7GvB7zh8worl4JxJLSK20aK3VInwaURnH0ilxlmkoQVJl7a6M/
 BZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755599052; x=1756203852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9qnMtEWxDnol/yTO5+KE2jWpCXB4W0LlhbHWnzYIJs=;
 b=Tp5Y+g3cm33W+5tfmYzSqIl3bofOJI0oGWPX3091ULEw9FCLDXHMd+TK47AS8SZuUp
 5m+AYxFmzHzupS3lb+hp2ufaMigc1TN91TTtJZHl7cSXprNHmuK+6hxCjgT+UxSGNjeg
 vnQMqaKVA1DXUT9zlCPai3qqzZigSkjWVW9HOu2ACB5zs6g+F6nCOtqF1X7UR2D46lML
 99kr1MZfuaINqs6AXtDcRCAcqQMsfcIJ9jMURymTVCYAImjsvOa5xpzOvHaIitNz/R+K
 XEOTSRIZQVAEG7wH//8BOASrOR70wm8J2qVg+9fTqzjKnjUM9aAmDLvJnpbjmeFGg8rc
 a7Ow==
X-Gm-Message-State: AOJu0Yxl1sB9DB1hyK8CETISvUu7bf51k5YBMIqWzfyH/4HCfaYtm1HJ
 HS++1PbEbxCZ6hCWttNp6OH1T0bz3oLEi9AZ4tLgEUPDnn3IWuHIJiKAxBhcDa1yWlRShDEkN0H
 Bh76E
X-Gm-Gg: ASbGnctxORUwza9iPx6zzGK9bi4lkJpPfuqXkRbT0sZpGHWwDah2VzZMkyAp8RmG8mL
 vC4f56FW5DIIEG5mE6YTs+UlRHwitsEtTc3xIIIgpsXsloZg1kBaRkGwIB/yEEZs2ShrueCL7b3
 bfNVSG57wRLiHlOTIWqEkROET5VzmA5oe4B2kRycwWkyB+c07edeU2Pftzcc4S12WoJuFk6nOCy
 eW7YFpPXMFiGlNyeVZ65kPVlV4hSgOyGlZ6GxpK8JqRSD0sVQa2v24gJey98gZlOqr3kyb9s5+8
 FkmfkgJoEUa4Qdw396ooWK7Pyhz4AUUWI/ArEmnyf7tzoouPP1Aa2txC8BG1qXxYBxsZnCZKPxt
 97aVyYK1HVsaC3dnykEGRTwh8Peuu
X-Google-Smtp-Source: AGHT+IHZYHAegUy89ACpQLxNF1T1x62a1shaZXFZJQ0+oVhC9FhU8La/WuybH8b/3tEYl7147gjA2A==
X-Received: by 2002:a05:600c:3d97:b0:459:d9a2:e952 with SMTP id
 5b1f17b1804b1-45b461465acmr4272965e9.1.1755599052231; 
 Tue, 19 Aug 2025 03:24:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b42a908d3sm37101355e9.22.2025.08.19.03.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 03:24:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests, scripts: Don't import print_function from __future__
Date: Tue, 19 Aug 2025 11:24:09 +0100
Message-ID: <20250819102409.2117969-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Some of our Python scripts still include the line
  from __future__ import print_function

which is intended to allow a Python 2 to handle the Python 3 print()
syntax. This particular part of the future arrived many years ago,
and our minimum Python version is 3.9, so we don't need to keep
this line around.

NB: the scripts in tests/tcg/*/gdbstub/ are run with whatever Python
gdb was built against, but we can safely assume that that was a
Python 3 because our supported distros are all on Python 3.  In any
case these are only run as part of "make check-tcg", not by
end-users.

Commit created with:

 sed -i -e '/import print_function/d' $(git grep -l 'from __future__')

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/userfaultfd-wrlat.py                           | 1 -
 tests/guest-debug/test_gdbstub.py                      | 1 -
 tests/tcg/aarch64/gdbstub/test-mte.py                  | 1 -
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py            | 1 -
 tests/tcg/aarch64/gdbstub/test-sve.py                  | 1 -
 tests/tcg/multiarch/gdbstub/interrupt.py               | 1 -
 tests/tcg/multiarch/gdbstub/memory.py                  | 1 -
 tests/tcg/multiarch/gdbstub/sha1.py                    | 1 -
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py      | 1 -
 tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py    | 1 -
 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py | 1 -
 tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py  | 1 -
 tests/tcg/s390x/gdbstub/test-signals-s390x.py          | 1 -
 tests/tcg/s390x/gdbstub/test-svc.py                    | 1 -
 14 files changed, 14 deletions(-)

diff --git a/scripts/userfaultfd-wrlat.py b/scripts/userfaultfd-wrlat.py
index 0684be4e044..a61a9abbfcb 100755
--- a/scripts/userfaultfd-wrlat.py
+++ b/scripts/userfaultfd-wrlat.py
@@ -17,7 +17,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from __future__ import print_function
 from bcc import BPF
 from ctypes import c_ushort, c_int, c_ulonglong
 from time import sleep
diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
index 4f08089e6a9..e017ccb55d7 100644
--- a/tests/guest-debug/test_gdbstub.py
+++ b/tests/guest-debug/test_gdbstub.py
@@ -1,7 +1,6 @@
 """Helper functions for gdbstub testing
 
 """
-from __future__ import print_function
 import argparse
 import gdb
 import os
diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
index 9ad98e7a54c..f4a7d7b4465 100644
--- a/tests/tcg/aarch64/gdbstub/test-mte.py
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Test GDB memory-tag commands that exercise the stubs for the qIsAddressTagged,
 # qMemTag, and QMemTag packets, which are used for manipulating allocation tags.
diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
index a78a3a2514d..2c5c2180319 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Test the SVE ZReg reports the right amount of data. It uses the
 # sve-ioctl test and examines the register data each time the
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index 84cdcd4a32e..7b0489a622b 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Test the SVE registers are visible and changeable via gdbstub
 #
diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiarch/gdbstub/interrupt.py
index 2d5654d1540..4eccdb41b97 100644
--- a/tests/tcg/multiarch/gdbstub/interrupt.py
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Test some of the system debug features with the multiarch memory
 # test. It is a port of the original vmlinux focused test case but
diff --git a/tests/tcg/multiarch/gdbstub/memory.py b/tests/tcg/multiarch/gdbstub/memory.py
index 532b92e7fb3..76d75e52512 100644
--- a/tests/tcg/multiarch/gdbstub/memory.py
+++ b/tests/tcg/multiarch/gdbstub/memory.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Test some of the system debug features with the multiarch memory
 # test. It is a port of the original vmlinux focused test case but
diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gdbstub/sha1.py
index 1ce711a402c..3403b82fd4a 100644
--- a/tests/tcg/multiarch/gdbstub/sha1.py
+++ b/tests/tcg/multiarch/gdbstub/sha1.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # A very simple smoke test for debugging the SHA1 userspace test on
 # each target.
diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 6eb6ebf7b17..796dca75f0c 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -1,7 +1,6 @@
 """Test that gdbstub has access to proc mappings.
 
 This runs as a sourced script (via -x, via run-test.py)."""
-from __future__ import print_function
 import gdb
 from test_gdbstub import gdb_exit, main, report
 
diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
index 00c26ab4a95..fa36c943d66 100644
--- a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
+++ b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Test auxiliary vector is loaded via gdbstub
 #
diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
index 862596b07a7..b18fa1234fb 100644
--- a/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
+++ b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Test gdbstub Xfer:siginfo:read stub.
 #
diff --git a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
index 4d6b6b9fbe7..49cbc3548f6 100644
--- a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
+++ b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Test auxiliary vector is loaded via gdbstub
 #
diff --git a/tests/tcg/s390x/gdbstub/test-signals-s390x.py b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
index b6b7b39fc46..398ad534ebf 100644
--- a/tests/tcg/s390x/gdbstub/test-signals-s390x.py
+++ b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 
 #
 # Test that signals and debugging mix well together on s390x.
diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstub/test-svc.py
index 17210b4e020..29a0aa0ede4 100644
--- a/tests/tcg/s390x/gdbstub/test-svc.py
+++ b/tests/tcg/s390x/gdbstub/test-svc.py
@@ -1,7 +1,6 @@
 """Test single-stepping SVC.
 
 This runs as a sourced script (via -x, via run-test.py)."""
-from __future__ import print_function
 import gdb
 from test_gdbstub import main, report
 
-- 
2.43.0


