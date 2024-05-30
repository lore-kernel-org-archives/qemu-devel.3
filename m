Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02729C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdsl-00053e-2g; Thu, 30 May 2024 07:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCdsj-0004yu-LS
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:23:41 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCdsf-0002gH-Sq
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:23:41 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-579cd80450fso1781684a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717068214; x=1717673014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUuBTVNvgV45jAw2FZGNm/bzWVNk+iprBbeI4k7zOec=;
 b=b/0VfhQop0ABwzUOeN37WtqewZD7Ng/MdOvCY1DgpJ758/LRA+ksylUh6J3gqKAlZT
 2wWZbbIEDLO1xdNnbNIn/xY/y7J18d7EdBr/skvnyih1PhAuTPOt/sUgdq9QBMttLPuF
 UP6XYdsYjFHXIN9Y4cDx08DpJFbHEbxx1ELZ9X9oKIRwwGgXGkKMFmZ4X0/smC6PRrmJ
 O0Lg5xk88zoKVikbBfYsS66eVshMcBJ7ZwVBdH68jL++9ad4icJMZ+1H5+yoRJaoCQ+U
 yrJ7OxQNoT5EIQNaJ7XOQ77273Mqxgeire4Z3KUTm9jnSpNw9JiylFVpiwZ+16lTdm0Q
 OpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717068214; x=1717673014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUuBTVNvgV45jAw2FZGNm/bzWVNk+iprBbeI4k7zOec=;
 b=Gq6qQQtGwdfRzfp/5Tj9+JRfHdiY/Sv4++0kl51z2bS+0xsgB5/X007J3a3DFF2l0j
 0asx2EbCQ31k6eNBXfRglcgnLLnIlMf9NYV4SE9U2Jwbk0xR9Qk1p07KIvYXN44Jd+Pt
 d1BoEXtTGmz0jH2rB0J3s7TdOaxfEtHPm3DuQL0Frs9knyVEWtpBsE4QmmVfObcYvr3q
 d/AQd8nrwt6xva0n3VhgTtNy2eEr4BOku2LYQFIL8ka0J09gjhM21VT/BM28cBUMxuei
 IlJFrvfqGoOw+qgVKxJb22V68RMrzBTvvin8zYnnj7+OdssjQsltqHyJzdezP4drgCFJ
 ESKQ==
X-Gm-Message-State: AOJu0Yw9wAUqp+UEN/J2st6vIqlOrsUgAg11VR8Ys1ifIzU34VbVA/fL
 Qt/Lye58WKo1GdsrxqXoAr6KHhER+710s9hLIHaYloteYxlhwcC5neEPqg0fI4s=
X-Google-Smtp-Source: AGHT+IE5JlisWqE5qyrd+TDLIeC43UX5znM6qP91fDIfF4PIgEpDa0/52gBC/PVNObXbvb7tv105Cg==
X-Received: by 2002:a17:906:1c41:b0:a5a:8cc0:8c23 with SMTP id
 a640c23a62f3a-a65f0bd69cemr132733966b.27.1717068214174; 
 Thu, 30 May 2024 04:23:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a667bf48673sm27419066b.60.2024.05.30.04.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 04:23:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCD1B5F8E5;
 Thu, 30 May 2024 12:23:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Semihosting Tests PATCH v2 3/3] add SYS_GET_CMDLINE test
Date: Thu, 30 May 2024 12:23:32 +0100
Message-Id: <20240530112332.1439238-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530112332.1439238-1-alex.bennee@linaro.org>
References: <20240530112332.1439238-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Adds a new test case for the semihosting SYS_GET_CMDLINE call. We can
use the existing previously unused semi_get_cmdline helper and we then
verify:

 - the call succeeds
 - the call returns the expected length string
 - the call returns the expected binary name as arg0

The most fiddly bit was exposing the binary name into the program so
we can validate the result.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add return leg on failing test
  - check returned length is sane
  - s/could/couldn't/
  - just let array reference decay to the pointer
  - rewrite the commit message to be less terse
---
 Makefile   | 22 +++++++++++-----------
 usertest.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 59fd831..f77665f 100644
--- a/Makefile
+++ b/Makefile
@@ -85,37 +85,37 @@ systest-srcs = start.S string.c $(usertest-srcs)
 microbit-systest-srcs = start-microbit.S string.c $(usertest-srcs)
 
 usertest-a32: $(usertest-srcs)
-	$(A32GCC) --static -o $@ $^
+	$(A32GCC) -DBINARY_NAME="\"$@\"" --static -o $@ $^
 
 usertest-t32: $(usertest-srcs)
-	$(T32GCC) --static -o $@ $^
+	$(T32GCC) -DBINARY_NAME="\"$@\"" --static -o $@ $^
 
 usertest-a32-hlt: $(usertest-srcs)
-	$(A32GCC) -DUSE_HLT --static -o $@ $^
+	$(A32GCC) -DBINARY_NAME="\"$@\"" -DUSE_HLT --static -o $@ $^
 
 usertest-t32-hlt: $(usertest-srcs)
-	$(T32GCC) -DUSE_HLT --static -o $@ $^
+	$(T32GCC) -DBINARY_NAME="\"$@\"" -DUSE_HLT --static -o $@ $^
 
 usertest-a64: $(usertest-srcs)
-	$(A64GCC) --static -o $@ $^
+	$(A64GCC) -DBINARY_NAME="\"$@\"" --static -o $@ $^
 
 systest-a32.axf: $(systest-srcs)
-	$(A32GCC) -o $@ $^ $(A32LINKOPTS)
+	$(A32GCC) -DBINARY_NAME="\"$@\"" -o $@ $^ $(A32LINKOPTS)
 
 systest-t32.axf: $(systest-srcs)
-	$(T32GCC) -o $@ $^ $(A32LINKOPTS)
+	$(T32GCC) -DBINARY_NAME="\"$@\"" -o $@ $^ $(A32LINKOPTS)
 
 systest-a32-hlt.axf: $(systest-srcs)
-	$(A32GCC) -DUSE_HLT -o $@ $^ $(A32LINKOPTS)
+	$(A32GCC) -DBINARY_NAME="\"$@\"" -DUSE_HLT -o $@ $^ $(A32LINKOPTS)
 
 systest-t32-hlt.axf: $(systest-srcs)
-	$(T32GCC) -DUSE_HLT -o $@ $^ $(A32LINKOPTS)
+	$(T32GCC) -DBINARY_NAME="\"$@\"" -DUSE_HLT -o $@ $^ $(A32LINKOPTS)
 
 systest-t32-bkpt.axf: $(microbit-systest-srcs)
-	$(V7MGCC) -DUSE_BKPT -o $@ $^ $(AV7MLINKOPTS)
+	$(V7MGCC) -DBINARY_NAME="\"$@\"" -DUSE_BKPT -o $@ $^ $(AV7MLINKOPTS)
 
 systest-a64.axf: $(systest-srcs)
-	$(A64GCC) -nostdlib -o $@ $^ $(A64LINKOPTS)
+	$(A64GCC) -DBINARY_NAME="\"$@\"" -nostdlib -o $@ $^ $(A64LINKOPTS)
 
 run-usertest-a32: usertest-a32
 	$(QEMU_ARM) usertest-a32
diff --git a/usertest.c b/usertest.c
index 5df95f3..7a12896 100644
--- a/usertest.c
+++ b/usertest.c
@@ -315,6 +315,33 @@ static int test_feature_detect(void)
     return 0;
 }
 
+static int test_cmdline(void)
+{
+    char cmdline[256];
+    int actual;
+    const char *s, *c;
+
+    if (semi_get_cmdline(cmdline, sizeof(cmdline), &actual)) {
+        semi_write0("FAIL couldn't recover command line\n");
+        return 1;
+    }
+
+    if (strlen(BINARY_NAME) != actual) {
+        semi_write0("FAIL cmdline length not what expected: ");
+        semi_write0(cmdline);
+        return 1;
+    }
+
+    if (strcmp(cmdline, BINARY_NAME) != 0) {
+        semi_write0("FAIL unexpected command line: ");
+        semi_write0(cmdline);
+        return 1;
+    }
+
+    semi_write0("PASS command line test\n");
+    return 0;
+}
+
 int main(void)
 {
     void *bufp;
@@ -366,6 +393,10 @@ int main(void)
         return 1;
     }
 
+    if (test_cmdline()) {
+        return 1;
+    }
+
     semi_write0("ALL TESTS PASSED\n");
 
     /* If we have EXIT_EXTENDED then use it */
-- 
2.39.2


