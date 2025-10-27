Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9E9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL1x-0000zF-6f; Mon, 27 Oct 2025 07:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1n-0000pL-RH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:48 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1Q-0005i0-4S
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:43 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6d855ca585so469894466b.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563041; x=1762167841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQ3rv8bxHo1Z+FZ1pDBdGd57of56T+KuUG/sJxnyepk=;
 b=E8QbNApzRX87R78v1piAbPnvtoTxUKUGfY8RstoqmhbHAMq7zG4Y7GWcK5BXww0wBV
 u2m1G7AMGjM+Qd+TWeYyFDNHLyK9r63fH5ia3NoLkxpFs60ugkHqcy9Eh4Z74tcGtjdw
 06qClOnqQMXIbvxN7qr599xGW8DP5N6x0ftSTJV+oMmTeUfWc74XjdOaf5+uwWFsSJln
 NXKqTanJ8MnCABoIQpY043+dZD1JRc/qPtO2NiU+dccz3P5xvGKoNTmiWyOM8IGrnSp4
 KqZb4OMfMNb2PZfT9MPThVMaObS2eUU06XXZCIwoeTKSs6cDw+SVhxa3hvQgUCEnkDm/
 q++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563041; x=1762167841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQ3rv8bxHo1Z+FZ1pDBdGd57of56T+KuUG/sJxnyepk=;
 b=LUslNz28Izs+2aLON45oGxPb+//FYXsFZAtBENajWWXWHar2zMwKGOrf4ux/egNcP+
 iE8hP1n62sn7aXsxvtN8TPhZkznrC6MKZo+4PEpVpdvOhwFrAR+uEFKUtQWms+N20ifB
 6GeizwRZtsYXqmO4+QGyxPJikOEHurFFAdNyhN2C8QkWdxXKl+/VMdKi8dlBauIMBh8N
 0wG2/Z6OkWRrW6/8s4Otu88nGPqzir+Lgkzj/BA97jQY6X9p+XnQVnjn/FhHxIdpVecY
 v+YW59Qz0SxV+gnl4mIJyiYXzjXTCA4qQcLqcOsGkcj0TSo64GC8vSHUaw2uI7OIOwAm
 xQ2A==
X-Gm-Message-State: AOJu0YwYhw2LvetXN6ShsHAzwSliD1vZg2mQTbFgOGRp6+qTa1hO+Xvs
 OwNjH5o6YaOcVBfxlikT6i918P/3OgMYohlcaWQrxlMTqvIauMtt7DHKTjOO4fwjiEg=
X-Gm-Gg: ASbGncvHw6DDRceDN9ayCrgh9Dwc33sYhEeFwRsoadOudKLRMw88HYByYz5GA4AyI8f
 z2LUggm0VrXKhoT/nxGwxmO29t9R6V29uOtwjsq7uj2HDHixaWSAS2HuRqMwrt1dYIk8B0kuUy4
 h5A/GucQ1wJjAkZXLbUtFIWlo5kTEpiPE9+AuaJHzBdquLl18sSD9TOxzvsGJw14XI3+dD2qB6G
 wdv28Oudh+T1ifAgcCZLARwezdoCn2mdTeEzIeG9Y2jsumZ/N+pGGN+yqYonrpd3VlgW4Ci45mL
 1QvmgbmfkR8VRJIbz8sS5qQOtZFvyx+v1k/+XXPQWtyEokrCmitgohfgecyTvKh0KoE+scyipnh
 MqhLWkss/oqgqFAB+J7mTT7q1FzY215ri8wCNhdYa/vtCXtsS0Q06qsgpppM7/PIoVh2cJ48tAi
 s+
X-Google-Smtp-Source: AGHT+IF46Qy8yzQvt49lqS+UxN4daAAklNmAku3KZC2fFz2V0BgNH+izSW10LphrAJD0r0NqE/Josg==
X-Received: by 2002:a17:907:d1e:b0:b3e:8252:cd53 with SMTP id
 a640c23a62f3a-b64725705e5mr4937210966b.27.1761563041013; 
 Mon, 27 Oct 2025 04:04:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8535974asm716499266b.25.2025.10.27.04.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1268D6150B;
 Mon, 27 Oct 2025 11:03:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 31/35] tests: add test with interrupted memory accesses on rv64
Date: Mon, 27 Oct 2025 11:03:38 +0000
Message-ID: <20251027110344.2289945-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
 tests/tcg/riscv64/interruptedmemory.S     | 97 +++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

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


