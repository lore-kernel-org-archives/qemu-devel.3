Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0342C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ty3-0005U6-Ip; Mon, 13 May 2024 07:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Txp-0005JQ-Cx
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:35:30 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Txk-0001RE-CL
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:35:29 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51f1bf83f06so5162319e87.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715600121; x=1716204921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwAfCWJvmUAGzEmOykyRdNZT3QAGaq1DLOi5VTUI8GE=;
 b=m5TcLArgU2T4dvBGN9dtSV1kQK7WjzjpLuWMN83RW5WOkYqvX17qwYkjn/On3+8ZH3
 0IPnJghfzIqbayOupD/ZOTWUKn1r/7R26O7SqodM/PWw6lfjwp85CjpACW2zR5SDTykx
 fGBUy3WkhZVi1liD9tr78h116LHeDBhBv8Jt1WjEaBjdN/tTlH7QwskBXZtND3hcHrbJ
 YENX3nSGhl8md12wvaGrxmJL6A4nzdXg21KSW4/m1pJCplzzar7BJdQ65likDri1nFEA
 Ho/f85BTnmioWXmbeSWLe+c+1vhNI+QHxJB+/SHd1Rx3+tCLdpR8sMThgioHLOJyFuuR
 VSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600121; x=1716204921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FwAfCWJvmUAGzEmOykyRdNZT3QAGaq1DLOi5VTUI8GE=;
 b=F7pfIZRPPnMf2DtpSj+fSZ1yjDfwkq0dWIzAyiGnPuUXnoRDiNtbQax4EK00o7YOUe
 nsK/XcfU3WlohX9db5v2lhDu7ZSahPahDtx1IyAxbTXDc9Fnx+Zu6wir6i9ku+6qmJVT
 cEDKKGcTC/Echku0d8rlvjS9T6cOpNWgwnVA2OY4I0gvpExHu0G8862l+r2+kq6sGdlU
 0aJMAlIOiOQSb93BrA/fn/BKMDO3wyQCwDbeGOSYjuFPP6I855HNAARzwHGY3WyE9f9g
 CUd1FgXVnw6F2nYS8zd3HlAT+7Owrxfl9kzjfyMy4iagcfotw1dw+DhvlntBR3Do6z25
 lRVA==
X-Gm-Message-State: AOJu0YxrtsqJueaDDuRGwGKVgL+0oszc/wkaXH2+bMpEAmzp56Qc9hxL
 8XlBRd2scpUuog8tajqFJOIl9XoufDAICasheFY1sJ3LJWWa2D6+9uWzG1XGo1+55shzMVd6njg
 Y
X-Google-Smtp-Source: AGHT+IG1G1Jwhq3akS3T006hNy2cNaNyrvZX978MOX935dxLmtmGazSb0zO4fIiXGNS0dtlLqzhKRg==
X-Received: by 2002:a05:6512:158e:b0:51d:68fb:5d73 with SMTP id
 2adb3069b0e04-5220fb768fcmr8585591e87.8.1715600119547; 
 Mon, 13 May 2024 04:35:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad0absm10869226f8f.69.2024.05.13.04.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 04:35:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 77DE85FA17;
 Mon, 13 May 2024 12:35:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Semihosting Tests PATCH 3/3] add SYS_GET_CMDLINE test
Date: Mon, 13 May 2024 12:35:13 +0100
Message-Id: <20240513113513.640007-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513113513.640007-1-alex.bennee@linaro.org>
References: <20240513113513.640007-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We actually had the stubs to implement this. The main pain is getting
the binary name into the program so we can validate the result.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile   | 22 +++++++++++-----------
 usertest.c | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 11 deletions(-)

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
index 5df95f3..268a9d9 100644
--- a/usertest.c
+++ b/usertest.c
@@ -315,6 +315,26 @@ static int test_feature_detect(void)
     return 0;
 }
 
+static int test_cmdline(void)
+{
+    char cmdline[256];
+    int actual;
+    const char *s, *c;
+
+    if (semi_get_cmdline(&cmdline[0], sizeof(cmdline), &actual)) {
+        semi_write0("FAIL could recover command line\n");
+        return 1;
+    }
+
+    if (strcmp(&cmdline[0], BINARY_NAME) != 0) {
+        semi_write0("FAIL unexpected command line:");
+        semi_write0(&cmdline[0]);
+    }
+
+    semi_write0("PASS command line test\n");
+    return 0;
+}
+
 int main(void)
 {
     void *bufp;
@@ -366,6 +386,10 @@ int main(void)
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


