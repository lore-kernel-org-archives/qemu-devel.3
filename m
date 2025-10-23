Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2271CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjh-0004u6-NM; Thu, 23 Oct 2025 10:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjg-0004sj-Oh
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjf-0005ap-1A
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso13233285e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231373; x=1761836173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bE/XAE9VbTeD/8marqOlL9DMLLUUC/0huKhP50Lqb/8=;
 b=qAqsbJQDt3tAzLUnaxd8n1lfv7rCuIfzMBOlIDKOc2lR4ih0QNMjbAbP8xjXdnmfgj
 HtIv3Qeoi8RclvpDbBYf0WHTgJVfGlRFqYYL9uBv6z46aef/1O6wNy7NwAs4Zx9nxKfn
 FFyXYmRy5+r06iroiW7AHGduB0dScqN6oOobvWSSckMPDx4sZEnewzmetRhwIFfHAWoR
 pBlMmMngD7wbHNVSrUCVr+W/05vDaiD6q4m8nsRTzPgXuOvkkkuWm2jSIpk6c1Z6QbVe
 v6gS11rNFOFEjFL4whqtVRVQI5FcBp5DICXrHjJpyFFobKCuYw0SW66VpOJD1rNAZ/4I
 PCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231373; x=1761836173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bE/XAE9VbTeD/8marqOlL9DMLLUUC/0huKhP50Lqb/8=;
 b=SjZmVfiJVjR2ZvNRN2NlOQaIJ2H1ZSYlYwOd1PZcnwaF4ZvyhMr06MK9+KcrYXwEac
 Nm5pM+lQ8GcNZC6uCyKwUsINmrrUo3+YxlQ6Xs4AfIjrX6gsPaBJBELhftZcO1e23yV/
 e3dlcy/YmtsOoZ2lbTRxs07zId45lUgM6OvpT4N+xabS+DmqJeJ6uk4ZHloyzKXEJsCw
 wLAwShMRBCaHaPjjmWY1msluFVlpMXbDHfccJrg1tpi87a7WT56hZZvBm7gLeWcMlW7y
 PiDkbzmEhTKKUyRFgEDDdhXNo/VnK9MmFH+mfoSHsLT7I/cpoFg/CQVIjghtVw7Dtw5s
 NuSg==
X-Gm-Message-State: AOJu0Ywgzd/vcPNuqsc3p8QQfHZ/qzU2wsu57Wx1zXxN1udbH7xJDi+R
 oZSPOUWzbkixEW2nmeGta2TNjQOzn75yPY+sG+NrMNq3hszFhVQU0fXqUrHeKA1Cnra1QH/VYSO
 XbQ2X
X-Gm-Gg: ASbGnctzuvyFNLPRj+2xD7LxL2tUaEU364CEPsjxTfR9JRTRwf0HdHDgYAwz/LDuAxG
 m7rKCT/SGrn8Zn3c9LeODo0SvY4hRzLqd02QMpRWoSGjSNbGRltb3L9F3a6+fn1eu5YdRbkzt5S
 sqKCGql07FEY6SmWnFx3HTKPDVYmGHjcOd9ZHSc5lssBb/DC8jt4RVK6xgKaTcKTUCOvFIevCSA
 cHUNrqgD3oBhLZlt98aW3AyEZeVUyee47UaLqMr+eqqlsuH/aoiqeQD5qIRtsXGx9QtCwa601vh
 HaN9hBjyCto+dZa5y9Pg4p3lYbcUJVUOvEChbIvyx5eM3cO/yjMXGDRgkoZpM6Kcvh8reuAjuxa
 4FKkZKE1aWxn+AW+/16CGe9mR8DZSAQrW+2D+hb3Ceq9Jj6HQ84NthZ7nwVhGUe07aihxE7QeXg
 X3JVgtRQd2Rm8kFK3D
X-Google-Smtp-Source: AGHT+IHsAEZMoDUSjznmqPioCQldxA9g6TM7+OMHIV9W1+ds0s+FOdFlY4i/dj8ttTwWC+uC/sWNIg==
X-Received: by 2002:a05:6000:186a:b0:3ff:17ac:a347 with SMTP id
 ffacd0b85a97d-42704d7be45mr20534226f8f.27.1761231373025; 
 Thu, 23 Oct 2025 07:56:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] tests/tcg/aarch64: Add test case for SME2 gdbstub
 registers
Date: Thu, 23 Oct 2025 15:55:53 +0100
Message-ID: <20251023145554.2062752-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Test the SME2 register exposure over gdbstub, in the same way
we already do for SME.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251017153027.969016-4-peter.maydell@linaro.org
---
 tests/tcg/aarch64/Makefile.target      |  9 ++++++-
 tests/tcg/aarch64/gdbstub/test-sme2.py | 36 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme2.py

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 55ce34e45ee..9fa86874534 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -164,7 +164,14 @@ run-gdbstub-sysregs-sme-tile-slice: sysregs
 	"selected gdb ($(GDB)) does not support SME ZA tile slices")
 endif
 
-EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice
+run-gdbstub-sysregs-sme2: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme2.py, \
+	gdbstub SME ZA tile slice support)
+
+EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice run-gdbstub-sysregs-sme2
 
 endif
 
diff --git a/tests/tcg/aarch64/gdbstub/test-sme2.py b/tests/tcg/aarch64/gdbstub/test-sme2.py
new file mode 100644
index 00000000000..74a045febf5
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sme2.py
@@ -0,0 +1,36 @@
+#
+# Copyright (C) 2025 Linaro Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+#
+# Test the SME2 registers are visible and changeable via gdbstub
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Test reads and writes of the SME2 registers"""
+    frame = gdb.selected_frame()
+    rname = "zt0"
+    zt0 = frame.read_register(rname)
+    report(True, "Reading %s" % rname)
+
+    # Writing to the ZT0 register, byte by byte.
+    for i in range(0, 64):
+        cmd = "set $zt0[%d] = 0x01" % (i)
+        gdb.execute(cmd)
+        report(True, "%s" % cmd)
+
+    # Reading from the ZT0 register, byte by byte.
+    for i in range(0, 64):
+        reg = "$zt0[%d]" % (i)
+        v = gdb.parse_and_eval(reg)
+        report(str(v.type) == "uint8_t", "size of %s" % (reg))
+        report(v == 0x1, "%s is 0x%x" % (reg, 0x1))
+
+main(run_test, expected_arch="aarch64")
-- 
2.43.0


