Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41AEC54E49
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 19:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgrTv-00048f-Ps; Sun, 03 Mar 2024 14:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rgrTu-00048A-1E
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 14:26:42 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rgrTs-00031W-8f
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 14:26:41 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e5a232fe80so2171734b3a.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 11:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709493994; x=1710098794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9FD8yKg80ZqH9APzxpqcFIl19t8UD0rlYBITybI9/w=;
 b=a1RVfc29y8Ki5y9pAr4mRCZl93gSG3d7LIiZM0mQCXX2M4g1yTmu7/LQ98iI3GDo5G
 QhiPzwqbZZym6Hd2fk/KonV38x2LgPcsOi9xPcgd5CsjShH/vFW+fjZ7bNcp6saIOzej
 T2OShpp+KdEsYWsf2BFrFMNAPDKsAg2emsKXfeeOYuKN20ijMTZF1mbzt+aS2I/KAp+M
 RJ0n2ohqa96VNPDZ/UKWB0KiFXKLGf1GfQV9ZqjgUAZslB2p4z3jsYAXsAmB9RjuBdLP
 XpFHXCv7fn+JBgvIX/Gc45t6kGxgVocvLIg5c0FQph08Oj7b0ArcUDLC1ym7OlzskZBA
 wLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709493994; x=1710098794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9FD8yKg80ZqH9APzxpqcFIl19t8UD0rlYBITybI9/w=;
 b=uqR1IsiIEt6mYqL600CnnAybQIXAf0ZroPXkm0Rfrby7KaGAMHgqJe322O0bWaZps1
 wyZxU9H6ZhenSRkEBof7RVzN0fYQ+sqQSeJRn1rO76MQq7FAktPzw2faT5G/9KLhA3pE
 rtW/oxwaZgJ9xPPIXcujuPDnfH9jGo8K8QS7fUi8MoSl73tGWtyAzJzdo/TMd2IUpKMk
 pAz4XmNPLMROc8EmMuqVQ2pdrMuebTxx8qKy443on1EVTJc/5PCw0m91SDYT+dp/t24j
 oTduLUPyl8jZZyeSxxAnCP/sGykENSs9rRFHZLSDoYIJo/T50THoKozAAeoYnEEnlBqp
 wAvw==
X-Gm-Message-State: AOJu0Yz/5rkmA4dPvPKvXzwRIGahfNThuqNH7j+dEt+MXrCgoIsn9ckG
 4IirZ3LGgxfwt6Irb6P7fhJwQsDdPA1Ky7fJZSyk/ku01+EOQ0bkyZ+SIuvFRQegfRTMqfpTnQd
 1
X-Google-Smtp-Source: AGHT+IFJr2Ee6stNYnG2YV5JnYsoKNFeca/t/bCOkQTWgOmZJQSwSMSUb0/Ht6F4Y915pHglSgzWgw==
X-Received: by 2002:a05:6a20:2451:b0:1a0:eb43:421b with SMTP id
 t17-20020a056a20245100b001a0eb43421bmr9582679pzc.28.1709493994546; 
 Sun, 03 Mar 2024 11:26:34 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:120f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 du6-20020a056a002b4600b006e5933a0da9sm5941287pfb.165.2024.03.03.11.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 11:26:34 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 2/2] tests/tcg: Add multiarch test for Xfer:siginfo:read stub
Date: Sun,  3 Mar 2024 19:26:10 +0000
Message-Id: <20240303192610.498490-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240303192610.498490-1-gustavo.romero@linaro.org>
References: <20240303192610.498490-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x435.google.com
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

Add multiarch test for testing if Xfer:siginfo:read query is properly
handled by gdbstub.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/tcg/multiarch/Makefile.target           | 10 ++++++-
 .../gdbstub/test-qxfer-siginfo-read.py        | 26 +++++++++++++++++++
 tests/tcg/multiarch/segfault.c                | 14 ++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
 create mode 100644 tests/tcg/multiarch/segfault.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index e10951a801..61cda9640e 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -80,6 +80,13 @@ run-gdbstub-qxfer-auxv-read: sha1
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
@@ -122,7 +129,8 @@ endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
-	      run-gdbstub-catch-syscalls
+	      run-gdbstub-catch-syscalls \
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
-- 
2.34.1


