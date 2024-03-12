Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6A6C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0GU-0002x8-UI; Tue, 12 Mar 2024 07:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GQ-0002vD-Hv
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GI-0000jX-IE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e92b3b5c9so2538711f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242737; x=1710847537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RL1O4Lp3d7j6GCqnIwmXbv0EOOi1576XfsojTQsANsw=;
 b=HKxvVWlioJ9pPdmhf/k+1CdsFVqqAOIJBFp7CtYVJPSW4H0U2WxNUlHaKkHf0VOE8Y
 QuF7MuX81VWym4dB5+TC61DQBArGtNE23oReByB/qHu7urQXQnS92gLV1fM2xKo3dQaX
 0042pLMh494tkDI2wIIVvn5I2W4uZoYeZeF5XbjUdHk5r0KKJLXxfGdtl5I7LZJlTvm9
 7PRSwGiwYlcRKYqH4RsCCzpT0VucS1xqgnS1MTy1vhoWsjFoyEVIFpePGcTgyM36W/Ec
 Jl9ZzsFa8xhFHfOD4GB1wmNIPrfpU3mC0ouRCQ6gpx03ZEcICtj7dSQ0x3HeK32Brcl3
 PIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242737; x=1710847537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RL1O4Lp3d7j6GCqnIwmXbv0EOOi1576XfsojTQsANsw=;
 b=I+zmX8eCgVvFuqiUR4s7C5IOlySPf1PMf/zh4bU4mM7BNxSXX4dNmuErWeGXeD/Duy
 8AF8OMTmmgcWNRn5gPXLeFlQi5Qj4AacslBCfXwIWFdSSr2Oqweo5jIVhh0baOxklWmG
 Wtmujd7kWkUpuIxDu+pPQOT0xybHo5Hsv4T+fFV7AW3oapZu453a1rNQci9EBMvzSpWB
 xoFmzimLqNc5R/V3CNSQrEbAkb7C6jyQgJiFEkBpKILSIUGgKj+c7cIzaxQOkYz5MzWm
 3FxzXQl7lEz4g5/NpW5YZHlNlQUXx2wCGfvpPli1cGg4OEjrc3MHjGkgOIu6v2GlQk4u
 YpYw==
X-Gm-Message-State: AOJu0YwFzhJiRj8936SvlYW5//LTzaJNXv9cZfM/1yms9TpOkmQAXpXW
 Fs/MBtiezGgDaBFdgu42OeNcnHqHxWS4k7++Z47KeA5P2OMBQq9vFBZcLa/sSOw=
X-Google-Smtp-Source: AGHT+IE8xXIFL8vEh61SET/opvgR0DrA+hFVa8LcUkZAzhnRuYfDO1kRRSlACIAxRiRkSkSPiObXfQ==
X-Received: by 2002:a5d:464b:0:b0:33e:9f81:4a3f with SMTP id
 j11-20020a5d464b000000b0033e9f814a3fmr2348707wrs.0.1710242736817; 
 Tue, 12 Mar 2024 04:25:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c17-20020a5d5291000000b0033d2ae84fafsm8773498wrv.52.2024.03.12.04.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 54C845F8E3;
 Tue, 12 Mar 2024 11:25:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/8] tests/tcg: Add multiarch test for Xfer:siginfo:read stub
Date: Tue, 12 Mar 2024 11:25:31 +0000
Message-Id: <20240312112532.1558319-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add multiarch test for testing if Xfer:siginfo:read query is properly
handled by gdbstub.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240309030901.1726211-6-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/segfault.c b/tests/tcg/multiarch/segfault.c
new file mode 100644
index 0000000000..e6c8ff31ca
--- /dev/null
+++ b/tests/tcg/multiarch/segfault.c
@@ -0,0 +1,14 @@
+#include <stdio.h>
+#include <string.h>
+
+/* Cause a segfault for testing purposes. */
+
+int main(int argc, char *argv[])
+{
+    int *ptr = (void *)0xdeadbeef;
+
+    if (argc == 2 && strcmp(argv[1], "-s") == 0) {
+        /* Cause segfault. */
+        printf("%d\n", *ptr);
+    }
+}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 979a0dd1bc..5e3391ec9d 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -71,6 +71,13 @@ run-gdbstub-qxfer-auxv-read: sha1
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
 	basic gdbstub qXfer:auxv:read support)
 
+run-gdbstub-qxfer-siginfo-read: segfault
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin "$< -s" --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-siginfo-read.py, \
+	basic gdbstub qXfer:siginfo:read support)
+
 run-gdbstub-proc-mappings: sha1
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(GDB) \
@@ -128,7 +135,8 @@ EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
-	      run-gdbstub-follow-fork-mode-parent
+	      run-gdbstub-follow-fork-mode-parent \
+	      run-gdbstub-qxfer-siginfo-read
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
new file mode 100644
index 0000000000..862596b07a
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
@@ -0,0 +1,26 @@
+from __future__ import print_function
+#
+# Test gdbstub Xfer:siginfo:read stub.
+#
+# The test runs a binary that causes a SIGSEGV and then looks for additional
+# info about the signal through printing GDB's '$_siginfo' special variable,
+# which sends a Xfer:siginfo:read query to the gdbstub.
+#
+# The binary causes a SIGSEGV at dereferencing a pointer with value 0xdeadbeef,
+# so the test looks for and checks if this address is correctly reported by the
+# gdbstub.
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+from test_gdbstub import main, report
+
+def run_test():
+    "Run through the test"
+
+    gdb.execute("continue", False, True)
+    resp = gdb.execute("print/x $_siginfo", False, True)
+    report(resp.find("si_addr = 0xdeadbeef"), "Found fault address.")
+
+main(run_test)
-- 
2.39.2


