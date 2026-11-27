Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=sQDalWMb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoyd-0003Zg-ND; Fri, 27 Nov 2026 00:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyP-0003Mt-L2; Fri, 27 Nov 2026 00:58:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyN-0002cf-IO; Fri, 27 Nov 2026 00:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=6J3R5TyetDZ/ohuejbXkN/hJRl70+RBFVnxpDGJXvs0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sQDalWMbfJsgAJ65LGIOhoRLHWr7SoF28xvaoqZH55qCNaN8baPXftzBjB9YAU6Ao
 Ubpj4YSmAWr31Mn0ZWz4/uBLu4/PkIgbD5v5VeAF4AI/OitTgkzh8ZCRX1XIQ8P+G2
 kdTlhqf1rlFEsHQna7Nu0EBXFiegsaGo0KnJV6bYwuzyL/7GuCn3/cvGen/L9R+Hr4
 Plw1H6uJwOj0gTNtdYQxcHMwp0KBndm6+a85yyvZLIytq0nzZBRjJgaoh1ayPnFU+t
 bCHfv9bzTMwLjxtLNCSDsJQv/TLheecKbqB8NRGOActWn9Y4giy5A1GlTzAyKK17LH
 7wCswBuHYFoDA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C0AD91EA2F0;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BE63C46992B;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A1FAACF262; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zixin Wang <w1355457260@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 102/140] target/i386/tcg: treat ENTER's size
 operand as unsigned
Date: Fri, 27 Nov 2026 08:53:28 +0300
Message-ID: <20261127055421.39015-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zixin Wang <w1355457260@gmail.com>

The first immediate operand of ENTER is the size of the dynamic storage
area and is unsigned.  Decoding it as a signed immediate sign-extends
values with bit 15 set, moving the stack pointer in the wrong direction.

Decode it with I_unsigned and add a regression test covering 32-bit and
64-bit guests.

Tested with a minimal x86_64-linux-user build; the new test fails before
the change and passes after it.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4643
Signed-off-by: Zixin Wang <w1355457260@gmail.com>
Link: https://lore.kernel.org/r/CABG6VKODisrETOuH5thhimg_DtJLH+1wmARKL5OsoND5Qse_TA@mail.gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 40a6c128beeb72fa6d17e8c393b3d60e09ca0a69)
(Mjt: back-port tests across make->meson conversion)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d29e9a21771..378f4633674 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1845,7 +1845,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0xBE] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
     [0xBF] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
 
-    [0xC8] = X86_OP_ENTRYrr(ENTER, I,w, I,b),
+    [0xC8] = X86_OP_ENTRYrr(ENTER, I_unsigned, w, I, b),
     [0xC9] = X86_OP_ENTRY1(LEAVE, A,d64),
     [0xCA] = X86_OP_ENTRYr(RETF,  I,w),
     [0xCB] = X86_OP_ENTRY0(RETF),
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7e590ef79c4..67a972a6a0e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2148,7 +2148,7 @@ static void gen_popa(DisasContext *s)
     gen_stack_update(s, 8 * size);
 }
 
-static void gen_enter(DisasContext *s, int esp_addend, int level)
+static void gen_enter(DisasContext *s, uint16_t esp_addend, int level)
 {
     MemOp d_ot = mo_pushpop(s, s->dflag);
     MemOp a_ot = mo_stacksize(s);
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 886a9767751..e3544d27cb7 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -14,7 +14,7 @@ config-cc.mak: Makefile
 I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
 ALL_X86_TESTS=$(I386_SRCS:.c=)
 SKIP_I386_TESTS=test-i386-ssse3 test-avx test-3dnow test-mmx test-flags
-X86_64_TESTS:=$(filter test-i386-adcox test-i386-bmi2 test-idiv-overflow $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
+X86_64_TESTS:=$(filter test-i386-adcox test-i386-bmi2 test-idiv-overflow test-i386-enter $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
 
 test-i386-sse-exceptions: CFLAGS += -msse4.1 -mfpmath=sse
 run-test-i386-sse-exceptions: QEMU_OPTS += -cpu max
@@ -67,6 +67,8 @@ else
 SKIP_I386_TESTS+=test-i386-fprem
 endif
 
+test-i386-enter: CFLAGS=-O2 -fomit-frame-pointer
+
 # Update TESTS
 I386_TESTS:=$(filter-out $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
 TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
diff --git a/tests/tcg/i386/test-i386-enter.c b/tests/tcg/i386/test-i386-enter.c
new file mode 100644
index 00000000000..509740d88c9
--- /dev/null
+++ b/tests/tcg/i386/test-i386-enter.c
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * ENTER's 16-bit size operand is unsigned.  If the decoder sign-extends
+ * it, the stack pointer moves in the wrong direction.
+ */
+#include <stdio.h>
+
+static int check_enter(void)
+{
+    unsigned long before, after;
+
+#ifdef __x86_64__
+    __asm__ volatile(
+        "movq %%rsp, %0\n\t"
+        "enter $0x8000, $0\n\t"
+        "movq %%rsp, %1\n\t"
+        "leave\n\t"
+        : "=r"(before), "=r"(after)
+        :
+        : "memory");
+    return (before - after) == 0x8008 ? 0 : 1;
+#else
+    __asm__ volatile(
+        "movl %%esp, %0\n\t"
+        "enter $0x8000, $0\n\t"
+        "movl %%esp, %1\n\t"
+        "leave\n\t"
+        : "=r"(before), "=r"(after)
+        :
+        : "memory");
+    return (before - after) == 0x8004 ? 0 : 1;
+#endif
+}
+
+int main(void)
+{
+    if (check_enter()) {
+        printf("FAIL: ENTER treated the 16-bit size operand as signed\n");
+        return 1;
+    }
+    return 0;
+}
-- 
2.47.3


