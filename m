Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D151CCF9F7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SR-0004aP-LC; Wed, 29 Oct 2025 11:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SM-0004Wc-NG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:26 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S1-0002uY-7t
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:26 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso11446001a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753061; x=1762357861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64uzFuglk4bHde6NA01qGjQHIOCA617Oktb15rTiY1Q=;
 b=qGJuFfr8XGefrgBpVNGSBBlTy1wDvDE3FRcb9WV8An6b4To7KUYlGqcK6Q136CBdju
 UlDSEmmATWl0aKAMhLm2ZFtb/Kjkw6pfdDHufPjlPo+zqBs/ZEotzk814AkieQhCmhBs
 AId2HAdC9KLGnhJo8ASk5xYdSt6RDx1PDFfGt2x7xXsZtbE65fC8kbt8t5Jwdp0uZh65
 4VvyDHoqe5kUuphYO3zJqKYCGxlYF8TlGJo7nhsUHSQNM28srnUZowbejRxdxVku4TJU
 I3HzcsViobjqTfaFX0Gl1daTIP0+UEmaXTtKaXTHJlGWjnwXUeOW5RNU0ClKJgUjXWuk
 ZzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753061; x=1762357861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64uzFuglk4bHde6NA01qGjQHIOCA617Oktb15rTiY1Q=;
 b=dUd/DMZT35DT212WXboMsG6qW353qnneeLCwV/L2F7fWHc+zUTKERQeuYV/anMqRnv
 PZ9eJIewz8qkq6HJlt0yvsKXhy1NfGBqYKEiVPP1576QR52HDdUbhqKplc9n334+gbQH
 hj5U8/OcJ/PpTOW10mN1mIQeZK6ZzeBuFkvburVxJ3Zc45WFGaOfrKaeSkmJSW5EuxYU
 QsAe6J6fkkoxdffdefOVHTXEglL9ySF46aIku1lDe2JhDqttfSqY2/4GNezkJXf0yhUD
 ILD/gagC3m4BKFwJAS2/7OSU0E6RmRlverhLCD4hIzsQzIdjKhgIMmGE455i5itipU2/
 rIsQ==
X-Gm-Message-State: AOJu0YzKXWljgCwfmQ/1Rb7trl53+2kqJncx81NKTD3LqPutlX4wuitI
 1Ur6RloXHKO3HNuBHCJQTY+LpCXB4PnxWsotThJGK+4QCzg9q3xRzquSxE3ATAIY9FM=
X-Gm-Gg: ASbGncvwM2qJBY6vsE0dqPUhq5IzLFyDG5WSWq/wmxt6jpZaTFJcNTWalScdT2Yh99Q
 tgtzYFCixGDU07BxxiWZdKdFqO9qfIDLdoHZY4sgV6c4+muiaCjTvB86V0NE4qpxL2o9xXVptRS
 sZmcqiqSZDNtO3+HopDSTEiMY08QvQcIKk3qc17at0aYELnE+STl+PCkIUTz7zmytW3+KlpchEj
 VPOLaA3M3uT/bdqyhntpOMS4my2KbPvCCD+CRP8Pyq0gfGVPvpIBN41U2negl6OnU6qBG9MiLu1
 Ln67scMnpjBQySdBlRSKHK+CgqQv+XGyqaZhIp0G9QjcCTKEVl1lrQK0cZL/XN3uab7elcF53e9
 bS2LxvF+MBfnZ1EZeZUOU44CrB04lyHyffXoeEeLCzfeGCWPl70BDGXedmoWIkYxkhsi4WqajuE
 Q9
X-Google-Smtp-Source: AGHT+IGz4z6aiC4cMd00DKOxniMT1FGr/nDAki9jLYLnKjqPv3EKQsCigv+sIV99S9BDqtfKy7lyRQ==
X-Received: by 2002:a17:907:3f21:b0:b6d:5363:88a9 with SMTP id
 a640c23a62f3a-b703d2dc7ebmr309686566b.9.1761753061457; 
 Wed, 29 Oct 2025 08:51:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85ba3798sm1472546166b.39.2025.10.29.08.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E673B61208;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 31/35] tests: add test with interrupted memory accesses on rv64
Date: Wed, 29 Oct 2025 15:50:40 +0000
Message-ID: <20251029155045.257802-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Julian Ganz <neither@nut.email>

This test aims at catching API misbehaviour w.r.t. the interaction
between interrupts and memory accesses, such as the bug fixed in

    27f347e6a1d269c533633c812321cabb249eada8
    (accel/tcg: also suppress asynchronous IRQs for cpu_io_recompile)

Because the condition for triggering misbehaviour may not be
deterministic and the cross-section between memory accesses and
interrupt handlers may be small, we have to place our trust in large
numbers. Instead of guessing/trying an arbitrary, fixed loop-bound, we
decided to loop for a fixed amount of real-time. This avoids the test
running into a time-out on slower machines while enabling a high number
of possible interactions on faster machines.

The test program sends a single '.' per 1000000 loads/stores over the
serial. This output is not captured, but may be used by developers to
gauge the number of possible interactions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-32-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index d9c0036eb4b..eb1ce6504a0 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -30,5 +30,11 @@ run-plugin-doubletrap: doubletrap
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
 	  $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-plugin-interruptedmemory
+run-plugin-interruptedmemory: interruptedmemory
+	$(call run-test, $<, \
+	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
+	  $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/interruptedmemory.S
new file mode 100644
index 00000000000..cd9073ee314
--- /dev/null
+++ b/tests/tcg/riscv64/interruptedmemory.S
@@ -0,0 +1,97 @@
+	.option norvc
+
+	.text
+	.global _start
+_start:
+	# Set up trap vector
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	# Set up timer
+	lui	t1, 0x02004
+	sd	zero, 0(t1) # MTIMECMP0
+
+	# Enable timer interrupts
+	li	t0, 0x80
+	csrrs	zero, mie, t0
+	csrrsi	zero, mstatus, 0x8
+
+	# Set up UART
+	lui	t1, 0x10000
+	li	a0, 0x80	# DLAB=1
+	sb	a0, 3(t1)
+	li	a0, 1		# Full speed
+	sw	a0, 0(t1)
+	li	a0, 0x03	# 8N1, DLAB=0
+	sb	a0, 3(t1)
+
+	# Run test for around 60s
+	call	rtc_get
+	li	t0, 30
+	slli	t0, t0, 30 # Approx. 10e9 ns
+	add	t0, t0, a0
+0:
+	# Tight loop with memory accesses
+	li	a1, 1000000
+	la	a2, semiargs
+1:
+	ld	a0, 0(a2)
+	sd	a0, 0(a2)
+	addi	a1, a1, -1
+	bnez	a1, 1b
+
+	li	a0, '.'
+	call	send_byte
+	call	rtc_get
+	bltu	a0, t0, 0b
+
+	li	a0, '\n'
+	call	send_byte
+
+	# Exit
+	li	a0, 0
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+
+	j	.
+
+rtc_get:
+	# Get current time from the goldfish RTC
+	lui	t3, 0x0101
+	lw	a0, 0(t3)
+	lw	t3, 4(t3)
+	slli	t3, t3, 32
+	add	a0, a0, t3
+	ret
+
+send_byte:
+	# Send a single byte over the serial
+	lui	t3, 0x10000
+	lb	a1, 5(t3)
+	andi	a1, a1, 0x20
+	beqz	a1, send_byte
+	sb	a0, 0(t3)
+	ret
+
+	.balign 4
+trap:
+	lui	t5, 0x0200c
+	ld	t6, -0x8(t5) # MTIME
+	addi	t6, t6, 100
+	lui	t5, 0x02004
+	sd	t6, 0(t5) # MTIMECMP
+	mret
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.47.3


