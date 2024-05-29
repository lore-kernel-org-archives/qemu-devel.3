Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB95C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGy3-0004vz-5A; Wed, 29 May 2024 06:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxx-0004lt-1g
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxu-0003Jz-Jy
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngGf/SQd5QMjCLjCV3lBUt7ZAu8XYK+UDWz45TEjZKA=;
 b=TQ2CJwkHm+2+mgNScr/IMSYbpLrS1BEFXkahZvhc/UQOSA4SZGcGyoIBni86q3lbwD9ogq
 UsG6ABqOjpnGMgyyH9dNctB93fDS4h/D6jQenYwtZh+KXHQGH4D9AhULVatBNO/P6XYMHu
 5oaLtnULa7I2fpftxnlu8ZONpBvqNnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-TqatjgWWMnuH9nsLYWTR1w-1; Wed, 29 May 2024 06:55:25 -0400
X-MC-Unique: TqatjgWWMnuH9nsLYWTR1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F1C5101A525;
 Wed, 29 May 2024 10:55:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA0B0105480A;
 Wed, 29 May 2024 10:55:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 14/22] tests/tcg/s390x: Add per.S
Date: Wed, 29 May 2024 12:54:46 +0200
Message-ID: <20240529105454.1149225-15-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Add a small test to avoid regressions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240502054417.234340-15-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/per.S                   | 82 +++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tests/tcg/s390x/per.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 1a1f088b28..80159cccf5 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -25,6 +25,7 @@ ASM_TESTS =                                                                    \
     lpswe-early                                                                \
     lra                                                                        \
     mc                                                                         \
+    per                                                                        \
     precise-smc-softmmu                                                        \
     ssm-early                                                                  \
     stosm-early                                                                \
diff --git a/tests/tcg/s390x/per.S b/tests/tcg/s390x/per.S
new file mode 100644
index 0000000000..79e704a6ff
--- /dev/null
+++ b/tests/tcg/s390x/per.S
@@ -0,0 +1,82 @@
+	.org	0x8d
+ilc:
+	.org	0x8e
+program_interruption_code:
+	.org	0x96
+per_code:
+	.org	0x98
+per_address:
+	.org	0x150
+program_old_psw:
+	.org	0x1d0
+program_new_psw:
+	.quad	0, pgm_handler
+
+	.org	0x200			/* exit lowcore */
+
+per_on_psw:
+	.quad	0x4000000000000000, start_per
+per_on_regs:
+	.quad	0x80000000, 0, -1	/* successful-branching everywhere */
+per_off_regs:
+	.quad	0, 0 ,0
+success_psw:
+	.quad	0x2000000000000, 0xfff	/* see is_special_wait_psw() */
+failure_psw:
+	.quad	0x2000000000000, 0	/* disabled wait */
+
+	.org	0x2000			/* exit lowcore pages */
+
+	.globl _start
+_start:
+	lpswe	per_on_psw
+start_per:
+	lctlg	%c9, %c11, per_on_regs
+
+/* Test unconditional relative branch. */
+	larl	%r0, j1
+	larl	%r1, d1
+	lhi	%r2, 0
+j1:	j	d1
+	lpswe	failure_psw
+d1:
+
+/* Test unconditional indirect branch. */
+	larl	%r0, j2
+	larl	%r1, d2
+j2:	br	%r1
+	lpswe	failure_psw
+d2:
+
+/* Test conditional relative branch. */
+	larl	%r0, j3
+	larl	%r1, d3
+	clr	%r1, %r2	/* d3 != 0 */
+j3:	jne	d3
+	lpswe	failure_psw
+d3:
+
+/* Test conditional register branch. */
+	larl	%r0, j4
+	larl	%r1, d4
+	clr	%r1, %r2	/* d4 != 0 */
+j4:	bner	%r1
+	lpswe	failure_psw
+d4:
+
+/* Success! */
+	nop
+	lpswe	success_psw
+
+pgm_handler:
+	chhsi	program_interruption_code, 0x80	/* PER event? */
+	jne	fail
+	cli	per_code, 0x80		/* successful-branching event? */
+	jne	fail
+	clg	%r0, per_address	/* per_address == jump insn? */
+	jne	fail
+	clg	%r1, program_old_psw+8	/* psw.addr updated to dest? */
+	jne	fail
+	lpswe	program_old_psw
+fail:
+	lpswe	failure_psw
-- 
2.45.1


