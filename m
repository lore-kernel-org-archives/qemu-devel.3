Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8FFCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 02:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ev7-0002zg-Rx; Tue, 23 Sep 2025 22:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ev5-0002z3-S0
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:07:48 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ev1-0002bu-1D
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:07:47 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-32326e2f0b3so5388128a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 19:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758679661; x=1759284461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7jBToDckL+9WdyOpUrdDydxCn382Hk4iBNUg68buw0=;
 b=qjYW/6aRdIx6y3ggZqh7mfvUk4MlFNsKY/fKnh3KXKucVsaLGWgzt8X82OXI3NKKEM
 PKMUVn1PUSD616t4Qpx6O8p/GjXkdcgjWR0J4NoCWxoPeRzddCr8isFwm/fu1Rerc1TP
 pLsUahaBBy0tm5rmJxnSWGLw/AaortCh4nBiZ7fbw3UER0gK1Nz7FljRyptrJlo6uIFO
 gyGLmZuBkJBDTTQiDkcQNOIbzlq9O845dkUbr/kLWgAua8mEi03hPLOv0ViBmiZAfBYv
 d9Lvqm04dlP3JIBmrH6YO3jyfHRJHsXc7wDBxLKOrvhL36DhhLPovjNS12SHRfdA/h9L
 6L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758679661; x=1759284461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7jBToDckL+9WdyOpUrdDydxCn382Hk4iBNUg68buw0=;
 b=K7ieVGHCLYcDZ1GMqW1nLJ3mX5ryga3ddjr82Dw65Qmlb+Yd+F+5niqBNIWrc5QUFW
 kAbP/4u/ic1OlcJaMI569O6Nl7KQHS+C4pSMZbhJMvqQ5c6pTqMHKOprM+TwW4ZaEtBV
 P9aox57htLpb12dP3M1stBKhq7RyiqU2fbRMTQEhIUklTrW+1Oj0Abc+2apOKJzx895x
 rKsYLua/YWqrBuagamgvkBc2sRleUn3hfRdRmYv75MoMpUykUtUrxJeOKO5Kh2JMYJIn
 JShtu8KVjX7yobkOt2SvEWf1WNzEKn88BMrvd63VAy7HuaLX+LJsvsDXcQo1rkaWXq09
 WTfQ==
X-Gm-Message-State: AOJu0Ywz85tvHruo1pq4MPzEXW7CrpNPL/mZV1syFBY9mEQYRNUkue7x
 SASSDEkOb59EI1X8dyU7tOHbWafjs6HfRiyOSD5v73b8u4RNTlywW+6mbnGX0RGgMFcieaxKVuT
 mNp5C
X-Gm-Gg: ASbGncsfstknzS7wWWHEQH5e5mM3jlTZ1w82B6wLd87P0Mxz+vqWH7f6qWwGWn31DIh
 4+ZeN+sDnY49m+Kf/c9GTwRA5KMa+irFaaW6twYiy4iotUokOdaDBruIIzv9bfGqeQklguJcCG4
 Ol3VbDkxF87DLamFwkNjlm1jWW/gG6eHexxafYRRhM5QOqSUbCNbJcGt7twi7UIhnjm7C7XIvZk
 l1YUS8+dOSH5wYwN/YWmKVpBoeZxAaY04Y6JMMYGbLPPcK0c+8CxtWxVi067+yA3flNGdKBNIYh
 ONyRGIAeXynZ/Jfl0qbR4FFBCOAdKpnkW0g+QB2aaH4TaLJ1Olan0jm7s7y99PeEEniaudeIM0a
 pE7FRZpc27QGKnqACxYjhgqGr/+7h
X-Google-Smtp-Source: AGHT+IHZ3FQuinlKS2Fe6eVclEaZuS++WO6bhj8ERA9KXKXcpkvZBCc8qVR90RtQUTD8rCxNyVxe+g==
X-Received: by 2002:a17:90a:f944:b0:32e:87fa:d96a with SMTP id
 98e67ed59e1d1-332a95e2926mr5451175a91.26.1758679660692; 
 Tue, 23 Sep 2025 19:07:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bcd9afbsm565664a91.0.2025.09.23.19.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 19:07:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jonwilson030981@googlemail.com,
 =?UTF-8?q?=E6=9D=8E=E5=A8=81=E5=A8=81?= <liweiwei@kubuds.cn>
Subject: [PATCH] accel/tcg: Properly unlink a TB linked to itself
Date: Tue, 23 Sep 2025 19:07:34 -0700
Message-ID: <20250924020735.3909216-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924020735.3909216-1-richard.henderson@linaro.org>
References: <20250924020735.3909216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

When we remove dest from orig's links, we lose the link
that we rely on later to reset links.  This can lead to
failure to release from spinlock with self-modifying code.

Reported-by: 李威威 <liweiwei@kubuds.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c              |  8 +++++
 tests/tcg/riscv64/tb-link.c       | 60 +++++++++++++++++++++++++++++++
 tests/tcg/riscv64/Makefile.target |  1 +
 3 files changed, 69 insertions(+)
 create mode 100644 tests/tcg/riscv64/tb-link.c

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0048316f99..e6d45c9c12 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -836,6 +836,14 @@ static inline void tb_remove_from_jmp_list(TranslationBlock *orig, int n_orig)
      * We first acquired the lock, and since the destination pointer matches,
      * we know for sure that @orig is in the jmp list.
      */
+    if (dest == orig) {
+        /*
+         * In the case of a TB that links to itself, removing the entry
+         * from the list means that it won't be present later during
+         * tb_jmp_unlink -- unlink now.
+         */
+        tb_reset_jump(orig, n_orig);
+    }
     pprev = &dest->jmp_list_head;
     TB_FOR_EACH_JMP(dest, tb, n) {
         if (tb == orig && n == n_orig) {
diff --git a/tests/tcg/riscv64/tb-link.c b/tests/tcg/riscv64/tb-link.c
new file mode 100644
index 0000000000..b6fcca8668
--- /dev/null
+++ b/tests/tcg/riscv64/tb-link.c
@@ -0,0 +1,60 @@
+#include <assert.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <unistd.h>
+
+
+int main()
+{
+    /*
+     * ## 1. RISC-V machine code.
+     * Assembly:
+     *   L: j L          ; Jump to self (spin).
+     *   li a0, 42       ; Place 42 into the return value register a0.
+     *   ret             ; Return to caller.
+     */
+    static const uint32_t machine_code[] = {
+        0x0000006f, /* jal zero, #0 */
+        0x02a00513, /* addi a0, zero, 42 */
+        0x00008067  /* jalr zero, ra, 0 */
+    };
+    size_t code_size = sizeof(machine_code);
+    int tmp;
+    pthread_t thread_id;
+    void *thread_return_value;
+    uint32_t *buffer;
+
+    /* ## 2. Allocate executable memory. */
+    buffer = mmap(
+        NULL,
+        code_size,
+        PROT_READ | PROT_WRITE | PROT_EXEC,
+        MAP_PRIVATE | MAP_ANONYMOUS,
+        -1, 0
+    );
+    assert(buffer != MAP_FAILED);
+
+    /* ## 3. Copy machine code into buffer. */
+    memcpy(buffer, machine_code, code_size);
+
+    /* ## 4. Execute the code in a separate thread. */
+    tmp = pthread_create(&thread_id, NULL, (void *(*)(void *))buffer, NULL);
+    assert(tmp == 0);
+
+    /*
+     * Wait a second and then try to patch the generated code to get the
+     * runner thread to get unstuck by patching the spin jump.
+     */
+    sleep(1);
+    buffer[0] = 0x00000013;  /* nop */
+    __builtin___clear_cache((char *)buffer, (char *)(buffer + 1));
+
+    tmp = pthread_join(thread_id, &thread_return_value);
+    assert(tmp == 0);
+
+    tmp = (intptr_t)thread_return_value;
+    assert(tmp == 42);
+    return 0;
+}
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b3..ba684616fd 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -4,6 +4,7 @@
 VPATH += $(SRC_PATH)/tests/tcg/riscv64
 TESTS += test-div
 TESTS += noexec
+TESTS += tb-link
 
 # Disable compressed instructions for test-noc
 TESTS += test-noc
-- 
2.43.0


