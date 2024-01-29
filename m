Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54912C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadu-0006PM-UA; Mon, 29 Jan 2024 18:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUade-00062x-G1
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:04 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUada-0008Q5-Ce
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:01 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3be6df6bc9bso616807b6e.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569316; x=1707174116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8orTCABPFUUDzwNSDUEvK5qkKcVY4K7vUOekf3tCG7U=;
 b=s0Ix1+XUuYAvdYXNH0BnLDG6xHCo+YwC7uyoSVHcafM8DpLaxOMssDmiMiwNXF1YJW
 8+ockuTgjdmAw+dwZ3lHI2SD296fUT4R6SF0wkJcAiR9433EtLj6rgfZLR66y08cX6Ov
 ok3Lf1hSr2zr6/8/zQboxZR+O0Gd6e1n3uK+PpZECGRS2MIcqUduziRK9eAkOKrkPhkG
 DVxtPriGK2m+XxXBOl+NRRldlrqrjDQkNHCb/pL8/WUVG/vItRAHv1aNjQbARjaPrFEY
 5Ra6e4AZviuk8iLA2eIFj6t5uE3A8uYpS0JG0XnU6cqZAsP6iVJFaZCqzfGw7WJPJdZ4
 nNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569316; x=1707174116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8orTCABPFUUDzwNSDUEvK5qkKcVY4K7vUOekf3tCG7U=;
 b=aTreowmSbR4OWOw2ZsDrO95uwFTwY6i5cu/AzfPJ9dWNMcv76uMyUV9VjQyshLDvxk
 SkOJlDpJiJO0612BeZlkHDq19Cl2dXYmlloHwP2ilApFzyvv/6d4XcSefzScbnyHTHla
 xOi110YuTkTmCG46cizIFHgK5JQEDYnlwhHPXj07+mzu0YU5z0EmzW35fAYlC6LX8vM1
 lLZCPlEkJMZSWPTtbe+uc5BNStOVgZ3jTRbGVHs89C7jFXYCJwn+II6b2aErGRgPrvr8
 1VzcvcY0AZZcx79idwfrnHqI43p73cM1Qvbu2hrtyVTxL2JwkbsASjcnmrLn+fRaqgQs
 muSg==
X-Gm-Message-State: AOJu0YxmPCC7RF+9zXSAgKkcPpquXYPkcpBMDkTB3SeoDuORj5dhLbLs
 ngkjoeejgUhieeuYJ1dVSS7twKqH+LlX7tjWa/OVq1TBezghwAGwiNpcCuNaWqqxr2viadaJcP9
 TGpE=
X-Google-Smtp-Source: AGHT+IFtEk+1WQ49ELjOr1vP/DFATbDtzvQvitrY/achWWenrATrwzb03TpkFyWM09aNhCocEnwBJw==
X-Received: by 2002:a05:6358:7e50:b0:178:85dd:fb1b with SMTP id
 p16-20020a0563587e5000b0017885ddfb1bmr685018rwm.64.1706569316323; 
 Mon, 29 Jan 2024 15:01:56 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 13/31] tests/tcg: Add the PROT_NONE gdbstub test
Date: Tue, 30 Jan 2024 09:01:03 +1000
Message-Id: <20240129230121.8091-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Make sure that qemu gdbstub, like gdbserver, allows reading from and
writing to PROT_NONE pages.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240129093410.3151-4-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/prot-none.c          | 40 ++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target      |  9 +++++-
 tests/tcg/multiarch/gdbstub/prot-none.py | 36 +++++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/prot-none.c
 create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py

diff --git a/tests/tcg/multiarch/prot-none.c b/tests/tcg/multiarch/prot-none.c
new file mode 100644
index 0000000000..dc56aadb3c
--- /dev/null
+++ b/tests/tcg/multiarch/prot-none.c
@@ -0,0 +1,40 @@
+/*
+ * Test that GDB can access PROT_NONE pages.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+void break_here(void *q)
+{
+}
+
+int main(void)
+{
+    long pagesize = sysconf(_SC_PAGESIZE);
+    void *p, *q;
+    int err;
+
+    p = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
+             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    assert(p != MAP_FAILED);
+    q = p + pagesize - 1;
+    strcpy(q, "42");
+
+    err = mprotect(p, pagesize * 2, PROT_NONE);
+    assert(err == 0);
+
+    break_here(q);
+
+    err = mprotect(p, pagesize * 2, PROT_READ);
+    assert(err == 0);
+    if (getenv("PROT_NONE_PY")) {
+        assert(strcmp(q, "24") == 0);
+    }
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index d31ba8d6ae..315a2e1358 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -101,13 +101,20 @@ run-gdbstub-registers: sha512
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
 	checking register enumeration)
 
+run-gdbstub-prot-none: prot-none
+	$(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
+	accessing PROT_NONE memory)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
-	      run-gdbstub-registers
+	      run-gdbstub-registers run-gdbstub-prot-none
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
new file mode 100644
index 0000000000..e829d3ebc5
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -0,0 +1,36 @@
+"""Test that GDB can access PROT_NONE pages.
+
+This runs as a sourced script (via -x, via run-test.py).
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+import ctypes
+from test_gdbstub import main, report
+
+
+def probe_proc_self_mem():
+    buf = ctypes.create_string_buffer(b'aaa')
+    try:
+        with open("/proc/self/mem", "rb") as fp:
+            fp.seek(ctypes.addressof(buf))
+            return fp.read(3) == b'aaa'
+    except OSError:
+        return False
+
+
+def run_test():
+    """Run through the tests one by one"""
+    if not probe_proc_self_mem:
+        print("SKIP: /proc/self/mem is not usable")
+        exit(0)
+    gdb.Breakpoint("break_here")
+    gdb.execute("continue")
+    val = gdb.parse_and_eval("*(char[2] *)q").string()
+    report(val == "42", "{} == 42".format(val))
+    gdb.execute("set *(char[3] *)q = \"24\"")
+    gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
-- 
2.34.1


