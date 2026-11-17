Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF9606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fdm50biu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJO6-0006kE-IS; Tue, 17 Nov 2026 08:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJO3-0006iG-Tk
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJO1-0003BR-Pb
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1RqVy/lLvgOs++VfFlXNCBjmc7C28B5+SCIskKK164=;
 b=Fdm50biuhKjAMJH1/YOrl32tv55DQXg+ctZLJQHK/rCIB0SuDkNp38MDNgZDDCW9+5xGt2
 89wsKHJbplFLsJMy89/3njTFJwysaQMt9JIkvUII/8vPu1iY723J1FhmAdCp/W+HE1oPzr
 uVzQFzS6TRK9k95OcvJzWi3MQSCink0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-OJ5SyH0qMiit-Hln5ZhaEQ-1; Tue,
 17 Nov 2026 08:38:11 -0500
X-MC-Unique: OJ5SyH0qMiit-Hln5ZhaEQ-1
X-Mimecast-MFC-AGG-ID: OJ5SyH0qMiit-Hln5ZhaEQ_1794922690
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81C2B195607C; Tue, 17 Nov 2026 13:38:10 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A02FC428; Tue, 17 Nov 2026 13:38:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: z Y <w1355457260@gmail.com>
Subject: [PULL 14/15] target/i386/tcg: treat ENTER's size operand as unsigned
Date: Tue, 17 Nov 2026 14:37:49 +0100
Message-ID: <20261117133750.322253-15-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: z Y <w1355457260@gmail.com>

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
---
 target/i386/tcg/translate.c      |  2 +-
 tests/tcg/i386/test-i386-enter.c | 42 ++++++++++++++++++++++++++++++++
 target/i386/tcg/decode-new.c.inc |  2 +-
 tests/tcg/i386/meson.build       |  1 +
 tests/tcg/x86_64/meson.build     |  1 +
 5 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-enter.c

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d4ccddc33fd..719771032ff 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1989,7 +1989,7 @@ static void gen_popa(DisasContext *s)
     gen_stack_update(s, 8 * size);
 }
 
-static void gen_enter(DisasContext *s, int esp_addend, int level)
+static void gen_enter(DisasContext *s, uint16_t esp_addend, int level)
 {
     MemOp d_ot = mo_pushpop(s, s->dflag);
     MemOp a_ot = mo_stacksize(s);
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
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 19c76a12009..bd9a94b3162 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1972,7 +1972,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0xBE] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
     [0xBF] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
 
-    [0xC8] = X86_OP_ENTRYrr(ENTER, I,w, I,b),
+    [0xC8] = X86_OP_ENTRYrr(ENTER, I_unsigned, w, I, b),
     [0xC9] = X86_OP_ENTRY0(LEAVE),
     [0xCA] = X86_OP_ENTRYr(RETF,  I,w),
     [0xCB] = X86_OP_ENTRY0(RETF),
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index c912f37fab7..d2ba8410413 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -37,6 +37,7 @@ tests += {
                '-lm', '-fno-pie', '-Wl,--no-warn-rwx-segments'],
   },
   'test-idiv-overflow.c': {},
+  'test-i386-enter.c': {'cflags': ['-O2', '-fomit-frame-pointer']},
   '../multiarch/sha512.c': {
      'exe_name': 'sha512-sse',
      'cflags': ['-msse4.1', '-O3'],
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index 9738d04220b..1efb35cf2eb 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -50,6 +50,7 @@ tests += {
   '../i386/test-i386-blendv.c': {},
   '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
   '../i386/test-idiv-overflow.c': {},
+  '../i386/test-i386-enter.c': {'cflags': ['-O2', '-fomit-frame-pointer']},
 }
 
 tests += {
-- 
2.56.0



