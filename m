Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CB606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=xPNcD+MW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp91-0001qS-Cc; Fri, 27 Nov 2026 01:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7F-00063r-2m; Fri, 27 Nov 2026 01:07:25 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7D-0004Hk-45; Fri, 27 Nov 2026 01:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=wesWU/kU52fo1IL7Py6uiHo2NbRDJQHY+4zCP0aQHBI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xPNcD+MWBzEBZarq49P5yfOAaMZRBewAccpYD1XSmyXaOY3Ul2cMyfH8I4mj3Ds6F
 fzL4Q5afguamZCVLA07cs86v8YsOT9NftZvzQnyQGkkZuIx/0e3vzp2V5E+KyhblYV
 6Vq3cFCw9DEzKjlEcmMn67IIEngzTKErDVDpvp1uPFBWBvcvJkiy8jMtLasM6iTd5O
 fNVaiMrr9YQZdlwAoM/Vmz6nqlq3qfCgmrABKayQuusV7USCbYF3EIf7jUNyQ/oRjH
 YxQmJhS4Qas7sfAFDnp6NdSmCmeCxo2nf4CI93NWGm6QWaaXKKqEx9wicY33CCCgch
 LjI7Cg8NroRJw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 09C221EA362;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0797546998D;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EB564CF312; Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 112/152] tests/tcg: fix load/restore for test-avx
 and test-mmx
Date: Fri, 27 Nov 2026 08:54:10 +0300
Message-ID: <20261127055709.39630-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Paolo Bonzini <pbonzini@redhat.com>

If "r"(&result) uses %rsp, which GCC16 seems eager to do,
the comparison fails because run_test()'s assembly block
moves %rsp below the red zone.  Use fixed registers instead.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 75b2b67e6a950f731fb7c44ff1f48a7ebd455e89)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index 80fe363cfc2..bb37f7953d0 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -150,9 +150,10 @@ static void run_test(const TestDef *t)
             "push rbx\n\t"
             "push rcx\n\t"
             "push rdx\n\t"
-            "push %1\n\t"
-            "push %2\n\t"
-            "mov rax, %0\n\t"
+            "push rsi\n\t"
+            "push rdi\n\t"
+            "push rsi\n\t" // result
+            "push rdi\n\t" // fn
             "pushf\n\t"
             "pop rbx\n\t"
             "shr rbx, 8\n\t"
@@ -165,19 +166,21 @@ static void run_test(const TestDef *t)
             REG(LOADREG)
             "mov rax, 0x240[rax]\n\t"
             "call [rsp]\n\t"
-            "mov [rsp], rax\n\t"
-            "mov rax, 8[rsp]\n\t"
+            "mov [rsp], rax\n\t" // save rax
+            "mov rax, 8[rsp]\n\t" // get back result
             REG(STOREREG)
             "mov rbx, [rsp]\n\t"
-            "mov 0x240[rax], rbx\n\t"
+            "mov 0x240[rax], rbx\n\t"  // rax
             "mov rbx, 0\n\t"
-            "mov 0x270[rax], rbx\n\t"
-            "mov 0x278[rax], rbx\n\t"
+            "mov 0x270[rax], rbx\n\t"  // rsp
+            "mov 0x278[rax], rbx\n\t"  // rbp
             "pushf\n\t"
             "pop rbx\n\t"
             "and rbx, 0xff\n\t"
             "mov 0x2c0[rax], rbx\n\t"
             "add rsp, 16\n\t"
+            "pop rdi\n\t"
+            "pop rsi\n\t"
             "pop rdx\n\t"
             "pop rcx\n\t"
             "pop rbx\n\t"
@@ -185,9 +188,8 @@ static void run_test(const TestDef *t)
             "add rsp, 128\n\t"
             MMREG(STOREMM)
             YMMREG(STOREYMM)
-            : : "r"(init), "r"(&result), "r"(t->fn)
+            : : "a"(init), "S"(&result), "D"(t->fn)
             : "memory", "cc",
-            "rsi", "rdi",
             "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
             "mm0", "mm1", "mm2", "mm3", "mm4", "mm5", "mm6", "mm7",
             "ymm0", "ymm1", "ymm2", "ymm3", "ymm4", "ymm5",
diff --git a/tests/tcg/i386/test-mmx.c b/tests/tcg/i386/test-mmx.c
index 09e5d583ffd..1a640f8bbbf 100644
--- a/tests/tcg/i386/test-mmx.c
+++ b/tests/tcg/i386/test-mmx.c
@@ -154,9 +154,10 @@ static void run_test(const TestDef *t)
             "push rbx\n\t"
             "push rcx\n\t"
             "push rdx\n\t"
-            "push %1\n\t"
-            "push %2\n\t"
-            "mov rax, %0\n\t"
+            "push rsi\n\t"
+            "push rdi\n\t"
+            "push rsi\n\t" // result
+            "push rdi\n\t" // fn
             "pushf\n\t"
             "pop rbx\n\t"
             "shr rbx, 8\n\t"
@@ -169,19 +170,21 @@ static void run_test(const TestDef *t)
             REG(LOADREG)
             "mov rax, 0xc0[rax]\n\t"
             "call [rsp]\n\t"
-            "mov [rsp], rax\n\t"
-            "mov rax, 8[rsp]\n\t"
+            "mov [rsp], rax\n\t" // save rax
+            "mov rax, 8[rsp]\n\t" // get back result
             REG(STOREREG)
             "mov rbx, [rsp]\n\t"
-            "mov 0xc0[rax], rbx\n\t"
+            "mov 0xc0[rax], rbx\n\t"  // rax
             "mov rbx, 0\n\t"
-            "mov 0xf0[rax], rbx\n\t"
-            "mov 0xf8[rax], rbx\n\t"
+            "mov 0xf0[rax], rbx\n\t"  // rsp
+            "mov 0xf8[rax], rbx\n\t"  // rbp
             "pushf\n\t"
             "pop rbx\n\t"
             "and rbx, 0xff\n\t"
             "mov 0x140[rax], rbx\n\t"
             "add rsp, 16\n\t"
+            "pop rdi\n\t"
+            "pop rsi\n\t"
             "pop rdx\n\t"
             "pop rcx\n\t"
             "pop rbx\n\t"
@@ -190,9 +193,8 @@ static void run_test(const TestDef *t)
             MMREG(STOREMM)
 	    EMMS "\n\t"
             XMMREG(STOREXMM)
-            : : "r"(init), "r"(&result), "r"(t->fn)
+            : : "a"(init), "S"(&result), "D"(t->fn)
             : "memory", "cc",
-            "rsi", "rdi",
             "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
             "mm0", "mm1", "mm2", "mm3", "mm4", "mm5", "mm6", "mm7",
             "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5",
-- 
2.47.3


