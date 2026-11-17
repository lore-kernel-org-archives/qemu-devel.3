Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63370606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U1ifBrLG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJNx-0006cC-D7; Tue, 17 Nov 2026 08:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNw-0006br-AG
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNu-00039h-MC
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbPiqP84f1nbCjNsl5vAImTMLUhILof6aSiyTbFVTBM=;
 b=U1ifBrLGT1+BOSTaPxUaP5+zILrnNb5ATBpfAzgvUlBS5zwzOKV55i3pEO1NZvXVFFNH5U
 pMRIKjXTOcV0WHSwtey1IMlwbzMXGu0K+62y4O4zg9tScOrKr1K5Jgk0sPtpCyeemGvZzu
 bEEX8NJvo7D9Vkhe40hmCym2YVDNpuc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-emoUE3hQNBe5O6FtKwfY5A-1; Tue,
 17 Nov 2026 08:38:02 -0500
X-MC-Unique: emoUE3hQNBe5O6FtKwfY5A-1
X-Mimecast-MFC-AGG-ID: emoUE3hQNBe5O6FtKwfY5A_1794922681
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B357D18002C0; Tue, 17 Nov 2026 13:38:01 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D143241F; Tue, 17 Nov 2026 13:38:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/15] tests/tcg: fix load/restore for test-avx and test-mmx
Date: Tue, 17 Nov 2026 14:37:42 +0100
Message-ID: <20261117133750.322253-8-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If "r"(&result) uses %rsp, which GCC16 seems eager to do,
the comparison fails because run_test()'s assembly block
moves %rsp below the red zone.  Use fixed registers instead.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.c | 22 ++++++++++++----------
 tests/tcg/i386/test-mmx.c | 22 ++++++++++++----------
 2 files changed, 24 insertions(+), 20 deletions(-)

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
2.56.0



