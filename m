Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D77DCDDE69
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ua1-0001Ca-0B; Thu, 24 Oct 2024 05:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZk-00018a-FA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:16 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZh-0003nG-7h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:14 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fabb837ddbso10551821fa.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763771; x=1730368571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSlmWPNMrg5OrykjRnktSuC1Tqo7nH3XFa+CQSsRA/o=;
 b=vkJCjZox6QnjbAgc+oCOKa/XHsIeLGP9N/QXJnzb3m1XajE0OUDNjCX/150i7g7ka7
 /Zr5U9o9PPnqyttWTqxt1rhoRg911YEnl0BKHpjpe0dg4TwjcporDpNsKHKkvziul2/m
 OPCL6bRucpptD4TLzJgFCKI+eOk5oSfNthQD6Q5rWr63CTHIENsqz/Fsxam03+BoSZ/E
 WAr9WEmn4buJryg3GSD39tkEflE8JI9pNeSMQqqRHUZurPghg1MQUw59r+KI53QoFlbN
 dX5y/FtgUtC2GmkzBAF8FwhbD97xaRUr7XCXyAs/DwaFfE9CBQUceHB7NgAwgl9sS7vl
 o2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763771; x=1730368571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HSlmWPNMrg5OrykjRnktSuC1Tqo7nH3XFa+CQSsRA/o=;
 b=bGtZvDR6a6iFsV6dMitLpw3Yh7/GYogyWcwFVJSdSimSZUEx8grc7cTt65rM/Vtjnc
 XYdq4MOEqBjJBAh71KEO5MiWizHTqrde8HOH8zV3CY8z2Vt4ltM6bR3gAkMIrf6k6GIy
 NS3VdYe5mA8dlCCA7AacClwDznsjb5eBAlzAT20nJKU9eMphTpw/f5x0VkXBXzanJHoL
 ypwX8YWb38+9P4s22AFVjwiPa6b1ddEx59CuYFRuQ32hA5zW4uIX+3YNo6L9h/eZwrph
 0GuNll+Xn0/66YL48wlNscI2Y9VTg+QWF++byFpPpBwutbtzEVBGSzUZKXelWJZcSE6p
 7SAg==
X-Gm-Message-State: AOJu0Yxxj318ML1YuWsJMG2F3SzzYpaYsWv9KNp+ajlZa+p/sVNCUZDN
 J+/lZFn79NRXp4KLr05+64OGetG73fXegUM3zfT5iObirG3krW4pgUjSZo1g94s=
X-Google-Smtp-Source: AGHT+IG7qnQdWmi+JRqp+4Gr4qbymWp4ge/X7S+WrXxbJvveyHQLmMLTBOrfPtquIUbttLIAFs4jWw==
X-Received: by 2002:a2e:70a:0:b0:2fb:61c0:137 with SMTP id
 38308e7fff4ca-2fc9d394bfamr37878451fa.40.1729763771039; 
 Thu, 24 Oct 2024 02:56:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912edb6asm592112566b.49.2024.10.24.02.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F9425F92E;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 07/17] tests/tcg/x86_64: Add cross-modifying code test
Date: Thu, 24 Oct 2024 10:55:53 +0100
Message-Id: <20241024095603.1813285-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
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

commit f025692c992c ("accel/tcg: Clear PAGE_WRITE before translation")
fixed cross-modifying code handling, but did not add a test. The
changed code was further improved recently [1], and I was not sure
whether these modifications were safe (spoiler: they were fine).

Add a test to make sure there are no regressions.

[1] https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg00034.html

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241001150617.9977-1-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-8-alex.bennee@linaro.org>

diff --git a/tests/tcg/x86_64/cross-modifying-code.c b/tests/tcg/x86_64/cross-modifying-code.c
new file mode 100644
index 0000000000..2704df6061
--- /dev/null
+++ b/tests/tcg/x86_64/cross-modifying-code.c
@@ -0,0 +1,80 @@
+/*
+ * Test patching code, running in one thread, from another thread.
+ *
+ * Intel SDM calls this "cross-modifying code" and recommends a special
+ * sequence, which requires both threads to cooperate.
+ *
+ * Linux kernel uses a different sequence that does not require cooperation and
+ * involves patching the first byte with int3.
+ *
+ * Finally, there is user-mode software out there that simply uses atomics, and
+ * that seems to be good enough in practice. Test that QEMU has no problems
+ * with this as well.
+ */
+
+#include <assert.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdlib.h>
+
+void add1_or_nop(long *x);
+asm(".pushsection .rwx,\"awx\",@progbits\n"
+    ".globl add1_or_nop\n"
+    /* addq $0x1,(%rdi) */
+    "add1_or_nop: .byte 0x48, 0x83, 0x07, 0x01\n"
+    "ret\n"
+    ".popsection\n");
+
+#define THREAD_WAIT 0
+#define THREAD_PATCH 1
+#define THREAD_STOP 2
+
+static void *thread_func(void *arg)
+{
+    int val = 0x0026748d; /* nop */
+
+    while (true) {
+        switch (__atomic_load_n((int *)arg, __ATOMIC_SEQ_CST)) {
+        case THREAD_WAIT:
+            break;
+        case THREAD_PATCH:
+            val = __atomic_exchange_n((int *)&add1_or_nop, val,
+                                      __ATOMIC_SEQ_CST);
+            break;
+        case THREAD_STOP:
+            return NULL;
+        default:
+            assert(false);
+            __builtin_unreachable();
+        }
+    }
+}
+
+#define INITIAL 42
+#define COUNT 1000000
+
+int main(void)
+{
+    int command = THREAD_WAIT;
+    pthread_t thread;
+    long x = 0;
+    int err;
+    int i;
+
+    err = pthread_create(&thread, NULL, &thread_func, &command);
+    assert(err == 0);
+
+    __atomic_store_n(&command, THREAD_PATCH, __ATOMIC_SEQ_CST);
+    for (i = 0; i < COUNT; i++) {
+        add1_or_nop(&x);
+    }
+    __atomic_store_n(&command, THREAD_STOP, __ATOMIC_SEQ_CST);
+
+    err = pthread_join(thread, NULL);
+    assert(err == 0);
+
+    assert(x >= INITIAL);
+    assert(x <= INITIAL + COUNT);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index 783ab5b21a..d6dff559c7 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -17,6 +17,7 @@ X86_64_TESTS += cmpxchg
 X86_64_TESTS += adox
 X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
+X86_64_TESTS += cross-modifying-code
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
@@ -27,6 +28,9 @@ adox: CFLAGS=-O2
 run-test-i386-ssse3: QEMU_OPTS += -cpu max
 run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
 
+cross-modifying-code: CFLAGS+=-pthread
+cross-modifying-code: LDFLAGS+=-pthread
+
 test-x86_64: LDFLAGS+=-lm -lc
 test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
-- 
2.39.5


