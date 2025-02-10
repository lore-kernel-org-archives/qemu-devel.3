Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11612C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWSi-0000Ke-Fi; Mon, 10 Feb 2025 11:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWRD-0004U8-9v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:15 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR8-0001Xl-TE
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:10 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5de64873d18so3488465a12.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204105; x=1739808905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irCLni2uqvi4DVHX26aA8cLaSUYGRaTtdMKZFKQjhYQ=;
 b=eeIWCLIbZYZP7VANEE6D9i1FIplfioH7SMGxJ8GsArRqBRi0xTbWYakxX4qr2GdBwh
 5t6IZ9r1viGxlFKpKtOsA7ATM4BvLYiAYyW/KzR+4nDhKZgXkfSTJpKnzfvUnAweHnU0
 uoG5abpsr6lFXlI9wzmDLnikkKAxn8XjmhApYmQBmpEovetRAeZ4a7C4Ax+Ty5jzX0Jf
 7gGYIXffu/c9vm3b0dKViZ4UgcwaFgYCchYwAiixX9odSFllFn5xj0BYwClLfXl+ndRV
 qrNUwGXDTJR2SLc3H1VnJU8Wcd5h/PWriVagkF9k4qKmanq+T4cOG6Ci4+d4pIwYW8vP
 SYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204105; x=1739808905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irCLni2uqvi4DVHX26aA8cLaSUYGRaTtdMKZFKQjhYQ=;
 b=v0OLZVryB+I0XmpiQckC0Db/w2xqepIPCgxYGUwHJ3GCQrCDJoooh+tWzdNUZJQ2q1
 UIebIppYZYfRW+AFC8g/ay1ytAdMyglX1WvlLX5hsUX2M5f/Xc3uADV0esekatjJUt7p
 s3P42CRi0i+lMt/vq6OFad0PQuoxOe0Ghq1gpeaI3HLryA0KDaQGfx9XkJtN8GAt0XS/
 JJPrjUXRuGnRusurvGxYaiNLXdK3Bfn7/kgtrszCFGtdbsTK1P/M8qhj92mARLVv1iDj
 7Y8+ayHWzLxDoRuG75DghSgu67fHEpZh7koFJJYq6WH5NGbI0KUiMgdL9pi3RrAYs+if
 bj1A==
X-Gm-Message-State: AOJu0YxYVAPcDhsj1/OWBnFdhNHly+G4+BFmAu1Kvv3Y6TVDWbY/v6AA
 B5H9GzCNJKSLYuvDZA+z+10JfB71KqFZBfwCPnE9F0QdnYHg+yrUcbNJ+X0xr/k=
X-Gm-Gg: ASbGncuH2mzkzvdr1Fbb5pYhLj+QxsRz2Nzl6QIkLdXfgEUbA71Tw41vEBFfoLaVBJh
 ZkkOkBrQNkIwtZZmbZE82UeWbQwQ0ossYc0UrQ+Fthjux2ge69TC61KfyaZWEhjKUufqQ1C73Ng
 +KSm5F6cGft0Yp3K7m6yDpC9HU4SWqxyEwNBwGan1rGlTVQv7yyA8PTDkpghUpW49R3tPEOumi/
 BlnR/ZVaLraLuNkrF3dpC7Eh2s0Q87EV5CnxbcRM2Ey+Z2XEGtp+Du4xWqirtCz6eny/ThiVglO
 cj5xNp9vnK0UFs8Kpw==
X-Google-Smtp-Source: AGHT+IFvx53ntGlE8W/NwcXg0rZrU26Q/07wvwxvEPAnvMwFILOHEzCnEz2mtgKbo9yeVlVCzkXItQ==
X-Received: by 2002:a17:907:360c:b0:ab7:63fa:e4a8 with SMTP id
 a640c23a62f3a-ab7897b37ffmr1280999766b.0.1739204105176; 
 Mon, 10 Feb 2025 08:15:05 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7bb9cc85esm298532266b.67.2025.02.10.08.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:15:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 539DB603A4;
 Mon, 10 Feb 2025 16:14:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/17] tests/tcg: Add late gdbstub attach test
Date: Mon, 10 Feb 2025 16:14:51 +0000
Message-Id: <20250210161451.3273284-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a small test to prevent regressions.
Make sure that host_interrupt_signal is not visible to the guest.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-9-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-18-alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/late-attach.c b/tests/tcg/multiarch/late-attach.c
new file mode 100644
index 0000000000..20a364034b
--- /dev/null
+++ b/tests/tcg/multiarch/late-attach.c
@@ -0,0 +1,41 @@
+/*
+ * Test attaching GDB to a running process.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static const char *phase = "start";
+
+int main(void)
+{
+    sigset_t set;
+    int sig;
+
+    assert(sigfillset(&set) == 0);
+    assert(sigprocmask(SIG_BLOCK, &set, NULL) == 0);
+
+    /* Let GDB know it can send SIGUSR1. */
+    phase = "sigwait";
+    if (getenv("LATE_ATTACH_PY")) {
+        assert(sigwait(&set, &sig) == 0);
+        if (sig != SIGUSR1) {
+            fprintf(stderr, "Unexpected signal %d\n", sig);
+            return EXIT_FAILURE;
+        }
+    }
+
+    /* Check that the guest does not see host_interrupt_signal. */
+    assert(sigpending(&set) == 0);
+    for (sig = 1; sig < NSIG; sig++) {
+        if (sigismember(&set, sig)) {
+            fprintf(stderr, "Unexpected signal %d\n", sig);
+            return EXIT_FAILURE;
+        }
+    }
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 5a091db8be..75e9c92e03 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -36,6 +36,8 @@ def get_args():
     parser.add_argument("--gdb-args", help="Additional gdb arguments")
     parser.add_argument("--output", help="A file to redirect output to")
     parser.add_argument("--stderr", help="A file to redirect stderr to")
+    parser.add_argument("--no-suspend", action="store_true",
+                        help="Ask the binary to not wait for GDB connection")
 
     return parser.parse_args()
 
@@ -73,10 +75,19 @@ def log(output, msg):
 
     # Launch QEMU with binary
     if "system" in args.qemu:
+        if args.no_suspend:
+            suspend = ''
+        else:
+            suspend = ' -S'
         cmd = f'{args.qemu} {args.qargs} {args.binary}' \
-            f' -S -gdb unix:path={socket_name},server=on'
+            f'{suspend} -gdb unix:path={socket_name},server=on'
     else:
-        cmd = f'{args.qemu} {args.qargs} -g {socket_name} {args.binary}'
+        if args.no_suspend:
+            suspend = ',suspend=n'
+        else:
+            suspend = ''
+        cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
+            f' {args.binary}'
 
     log(output, "QEMU CMD: %s" % (cmd))
     inferior = subprocess.Popen(shlex.split(cmd))
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 18d3cf4ae0..688a6be203 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -130,6 +130,13 @@ run-gdbstub-follow-fork-mode-parent: follow-fork-mode
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-parent.py, \
 	following parents on fork)
 
+run-gdbstub-late-attach: late-attach
+	$(call run-test, $@, env LATE_ATTACH_PY=1 $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" --no-suspend \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/late-attach.py, \
+	attaching to a running process)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
@@ -139,7 +146,7 @@ EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
 	      run-gdbstub-follow-fork-mode-parent \
-	      run-gdbstub-qxfer-siginfo-read
+	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/late-attach.py b/tests/tcg/multiarch/gdbstub/late-attach.py
new file mode 100644
index 0000000000..1d40efb5ec
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/late-attach.py
@@ -0,0 +1,28 @@
+"""Test attaching GDB to a running process.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    try:
+        phase = gdb.parse_and_eval("phase").string()
+    except gdb.error:
+        # Assume the guest did not reach main().
+        phase = "start"
+
+    if phase == "start":
+        gdb.execute("break sigwait")
+        gdb.execute("continue")
+        phase = gdb.parse_and_eval("phase").string()
+    report(phase == "sigwait", "{} == \"sigwait\"".format(phase))
+
+    gdb.execute("signal SIGUSR1")
+
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
-- 
2.39.5


