Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8E6CD128A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKag-00056k-LG; Fri, 29 Mar 2024 18:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKaf-00056J-IG
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:49 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKae-0001pR-0Y
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:49 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-229b7ada9e8so980647fac.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711750846; x=1712355646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqnAymu0Pceh1YCimgMze24poYMrVWuaKl+QjHlACqk=;
 b=c7dTs2JwE0gy2Q8yHxazYc7sPPaBgrCh2EDRtBJdHAwRz3zTnOi0N6yUzE3g8N4bm7
 TBJE6tryTOBnknZyYihdFhq5k454FUefOst9YxtBQ991Q1yQaTT/x5vCr6j2esiFswo1
 DAysLqzti4QsxFgewjO7m1lhGXubFHBU6+z/r0FOHV6y+CNNQyaEeWF+PCEBhVqRSjQ7
 UJf6bnC2NArSZUJt+k5RBZZal6D0rY2s2zNdi9gViBc2xgGOX/0c7OydCfOFw3ZQDFSc
 Uw7cKspc6L/A3XWEsVukN6EkVNLXrjIcZxnLxAhwgZK2y4aqXGvf83M1lgWKyXwkDrtj
 yfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711750846; x=1712355646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqnAymu0Pceh1YCimgMze24poYMrVWuaKl+QjHlACqk=;
 b=Is5hau9MXInH+WK40584xk9QpbV6y3/E5cGEsZv8g1NjJXGGVMUkJlH0+8d9T/Gudl
 fDzw81Xh2flTCprDVAFcAGdQG5ETYUQst/qrFLGoEEFdHkSNTv5vjVWrRfU0RTVbTMoK
 BwW6H2TsmJp8ylDwXD1AAVkfHr0XmRYFFVs8nCydcTjiCfIJlQ3Z0raCo8rCxcNhGokO
 2LLrwQ4kqTGWyKhhhpDYUxCXT4t6/xLz4ddBBz4ia/MmJ3dt4BTKTDOggrTrVcewqB+s
 wbZ1XnZo/9/xUVxgt+uRPDF4m3NsH97j3xsS9RGBHT+OLbJ9ptQaGkn8aniGkElCDqBz
 Xkeg==
X-Gm-Message-State: AOJu0YzV/+i2nck+OS1Q+FmIDHMfH/jaStrCirfCHFuGqbac4wCGs8UZ
 sl9lwBHPfKdN5dK71edNTC5RV8ljwoXo8l2D9PPXIJiZqpQuyl4fWoZTBtRkLLJXFAabl0bQSSV
 G
X-Google-Smtp-Source: AGHT+IFlXXXhM1VOpGgvpAkX18QsqI+8kcCxlj6jIUPjXxQJqrVMqthFhTV6DCMkhjgSuHjRcBdsOQ==
X-Received: by 2002:a05:6871:340c:b0:22a:551c:3170 with SMTP id
 nh12-20020a056871340c00b0022a551c3170mr3672097oac.23.1711750846598; 
 Fri, 29 Mar 2024 15:20:46 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lc24-20020a056a004f5800b006eaacc63435sm3579811pfb.173.2024.03.29.15.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:20:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 4/7] tests/tcg: Test shmat(NULL)
Date: Fri, 29 Mar 2024 12:20:34 -1000
Message-Id: <20240329222037.1735350-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329222037.1735350-1-richard.henderson@linaro.org>
References: <20240329222037.1735350-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a small test to prevent regressions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240325192436.561154-5-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux/linux-shmat-null.c | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-null.c

diff --git a/tests/tcg/multiarch/linux/linux-shmat-null.c b/tests/tcg/multiarch/linux/linux-shmat-null.c
new file mode 100644
index 0000000000..94eaaec371
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-shmat-null.c
@@ -0,0 +1,38 @@
+/*
+ * Test shmat(NULL).
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+
+int main(void)
+{
+    int shmid;
+    char *p;
+    int err;
+
+    /* Create, attach and intialize shared memory. */
+    shmid = shmget(IPC_PRIVATE, 1, IPC_CREAT | 0600);
+    assert(shmid != -1);
+    p = shmat(shmid, NULL, 0);
+    assert(p != (void *)-1);
+    *p = 42;
+
+    /* Reattach, check that the value is still there. */
+    err = shmdt(p);
+    assert(err == 0);
+    p = shmat(shmid, NULL, 0);
+    assert(p != (void *)-1);
+    assert(*p == 42);
+
+    /* Detach. */
+    err = shmdt(p);
+    assert(err == 0);
+    err = shmctl(shmid, IPC_RMID, NULL);
+    assert(err == 0);
+
+    return EXIT_SUCCESS;
+}
-- 
2.34.1


