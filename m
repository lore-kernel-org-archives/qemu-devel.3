Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8711AC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOn-0000Ls-N5; Fri, 04 Jul 2025 07:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeNC-00056b-3X
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeNA-0004Of-9p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-237e6963f63so6010885ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627665; x=1752232465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXLfUly98A1gi7Wq/mV90ppTT7V7dWfvuoZOQ7SK3E0=;
 b=XNZicDpm6hVECsqPbgKCGXZBT48w7484R6QJOD6QUjHtKQEwLQQcP+kQXLZhRTR2ZS
 0+62BGx7vxqBWZUPXRRWXh7tR/kW8oY0bI9zyefJMHY8tTM2+AJwea4EC+6J29SHyL0a
 3w/QNS9t192NJhqfpFQEeRYmCUkzlVv/TwdhJWf/jJAW7h9udhHadmaZptgFBUNBjIyz
 Y6ZCmCgdnkvaZienDkXSuwNGk4gAqOSappzhpk0XMxmMhdJV/v+z98geoyaxrmxgukCm
 gE1y0iYt0xpGxvGCvxgaMuVtdPHfOcmSFXQ9tBG8a+kJDzGG+BZ+cOFxdU4IfsQnKqsT
 GXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627665; x=1752232465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXLfUly98A1gi7Wq/mV90ppTT7V7dWfvuoZOQ7SK3E0=;
 b=DD6iCz+37CjTJQtsQVCUMKIqNsNuXsaxXIzyCzYBwzVQ2q+/VV6HYi1STA77FV+kEx
 oX6+VnLLPt8FWtu/M6Bte/OyDKzaPGRbGV+ACfjdjyGH8Z2ul2iACcMuEjicwsOmphk7
 tZnD4SgCEz9trzpKDZmScIQXcACzy3N7zzrfL8ZWY9LZ83fqg1j7xrm/Yt+Jgn7IAquj
 XbSlz/Xn5CvQxuZ203bv7qH6V56pQh5rDryqMdp+v96iEvCbwG+AeMsgFnYcqJh8r1+C
 DqhJG1ffJK3Xr+UYlXly3LKz9r2NLMJNT9k9Ge1qkNJ1JvuVL0im7fmhagmnRG9puMrR
 U/mw==
X-Gm-Message-State: AOJu0Yz+17rfanea299k5VP9DdAlBakIaFmA8YZfvvQCidUWUR4eYmUR
 zBChVn4R771y+dTl3QMEerZovijCO7PM7CMQEHTtdnudBjcuzGsEkcqT7SYDhg==
X-Gm-Gg: ASbGnct+Y1Ir7yeQfR9VE8yzQdw8jF7zM1XwHdnbZ7EWf7vgrw9++e37xjYc3ZnNqBa
 eAcc7lssiY69IZmxHztoVBmn0MuWNUnKlNTPVjCJckhpTIBEf+eYFkEyM8nOAwLxz0BkqASzuUl
 b67kxTzc9R0Fp/bCe6Z3re6khtpfAOVRaJ4vX7k3HbUWVIdEewH44IEfXzg+zvAg1vcSR1jW3fS
 3+b6QoEDd5o3nvFbtBcRvbV4oMutngidyoR66ieDlzlFHg7pHy0TjERnQE3xz299n31bpNnq2r6
 o4dKKsaaAzgdfk7b95hKL/K1yAc8brUatAxK1WWIpWsSO0ORfuzme9rtXMWVWRVJOJyIxlc8wm6
 756lpp8TXWodvbPpTQpEv5k3olAi1dbsiF4T47uBvGpQibMrN4iyT3W7vUJloNz3Mv6ljc7ewZZ
 JNlg==
X-Google-Smtp-Source: AGHT+IFFm7Pp2naGyzWIyCF7ipF3SqCeDNNl5dLiArGDQEPY+IQZHATd6D26qm6sjTi8H9WsPO+bpw==
X-Received: by 2002:a17:902:ce85:b0:237:ec18:eae5 with SMTP id
 d9443c01a7336-23c8754b117mr24607885ad.27.1751627664950; 
 Fri, 04 Jul 2025 04:14:24 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Charalampos Mitrodimas <charmitro@posteo.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/40] tests/tcg/riscv64: Add test for MEPC bit masking
Date: Fri,  4 Jul 2025 21:12:05 +1000
Message-ID: <20250704111207.591994-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Charalampos Mitrodimas <charmitro@posteo.net>

Add a regression test to verify that MEPC properly masks the lower
bits when an address with mode bits is written to it, as required by
the RISC-V Privileged Architecture specification.

The test sets STVEC to an address with bit 0 set (vectored mode),
triggers an illegal instruction exception, copies STVEC to MEPC in the
trap handler, and verifies that MEPC masks bits [1:0] correctly for
IALIGN=32.

Without the fix, MEPC retains the mode bits (returns non-zero/FAIL).
With the fix, MEPC clears bits [1:0] (returns 0/PASS).

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250703182157.281320-3-charmitro@posteo.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
 tests/tcg/riscv64/test-mepc-masking.S     | 73 +++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-mepc-masking.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 7c1d44d3f4..3ca595335d 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -20,5 +20,9 @@ EXTRA_RUNS += run-issue1060
 run-issue1060: issue1060
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-mepc-masking
+run-test-mepc-masking: test-mepc-masking
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-mepc-masking.S b/tests/tcg/riscv64/test-mepc-masking.S
new file mode 100644
index 0000000000..fccd2a7ac4
--- /dev/null
+++ b/tests/tcg/riscv64/test-mepc-masking.S
@@ -0,0 +1,73 @@
+/*
+ * Test for MEPC masking bug fix
+ *
+ * This test verifies that MEPC properly masks the lower bits according
+ * to the RISC-V specification when vectored mode bits from STVEC are
+ * written to MEPC.
+ */
+
+	.option	norvc
+
+	.text
+	.global _start
+_start:
+	/* Set up machine trap vector */
+	lla	t0, machine_trap_handler
+	csrw	mtvec, t0
+
+	/* Set STVEC with vectored mode (mode bits = 01) */
+	li	t0, 0x80004001
+	csrw	stvec, t0
+
+	/* Clear medeleg to handle exceptions in M-mode */
+	csrw	medeleg, zero
+
+	/* Trigger illegal instruction exception */
+	.word	0xffffffff
+
+test_completed:
+	/* Exit with result in a0 */
+	/* a0 = 0: success (bits [1:0] were masked) */
+	/* a0 != 0: failure (some bits were not masked) */
+	j	_exit
+
+machine_trap_handler:
+	/* Check if illegal instruction (mcause = 2) */
+	csrr	t0, mcause
+	li	t1, 2
+	bne	t0, t1, skip_test
+
+	/* Test: Copy STVEC (with mode bits) to MEPC */
+	csrr	t0, stvec	/* t0 = 0x80004001 */
+	csrw	mepc, t0	/* Write to MEPC */
+	csrr	t1, mepc	/* Read back MEPC */
+
+	/* Check if bits [1:0] are masked (IALIGN=32 without RVC) */
+	andi	a0, t1, 3	/* a0 = 0 if both bits masked correctly */
+
+	/* Set correct return address */
+	lla	t0, test_completed
+	csrw	mepc, t0
+
+skip_test:
+	mret
+
+/* Exit with semihosting */
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
-- 
2.50.0


