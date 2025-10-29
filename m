Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DA3CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8ZI-0005zE-Lk; Wed, 29 Oct 2025 11:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ys-0005nT-4m
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:11 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003YG-UK
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:03 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b6d70df0851so6120666b.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753454; x=1762358254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObwLZIKrEvZcuWDrp2icwNOmPKMnNUeUMaIT0Oe14hw=;
 b=lFa5LO6S14+n9X61QWEXoV1RQ36YkRyPXaANP5ywXS0Cr/sPM/fCSRG9jDpDk5BBJy
 1k5iHjJdHj/hwb6o0IbTHXTwy47v+L/Br6TQ3AejZhmwJN2s5jAt1aqXqXtmO+Z/d3OE
 M0kiWj7n7MI3z8oyKuLabTHloje6HsrBqtKalPjSG4PvW7ejxjyRps+KsK6NgYUwscLT
 aCDVYt7QPI+HnG7qGbAsgdM4tjY/XNAO4OgbV6NV1nV63DJouqj4NnU4cfswJZ8dJVWy
 ydGaqh73lD/km43a00Yk4ERpf7e5PsjRAoY1QNDFY/bjTavpamnLse9x3jm8vrnojrE/
 ELPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753454; x=1762358254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObwLZIKrEvZcuWDrp2icwNOmPKMnNUeUMaIT0Oe14hw=;
 b=jFUVAif+8AcT6xhifptUDpLah1KV8To4AwEabXbful4FUgilKN9yq6y5FeQq3vc0lF
 4AaehzfPdqS+zjXrCEU97xe7K/1FIKegYAU4KLsZjYlk/Y2MplVtPOsyml/nqUb58JQL
 nIGUA3+mDW75gyMwNeGkk5Z7bM5uZZGKoM3M+lzspIUiUfOtrkWqzpwbueH5tdZRALF2
 MOBDJD7bKPNN4soEh5Mc+Qgp4PgHUhf2hUK0pQKBcphtB7VklNTGRWRQHhD6Yd7tP/Ba
 q3E+vT8W1fQqoNrAB8uE8sG0ZCfjmI4lTCJzSt/bVqXSiIqk7q0LT64pSxF5pCziDvBd
 buPA==
X-Gm-Message-State: AOJu0Yyg2dB0UhyeKrVyTcc7Zd2ZkRaJadZi2G3zp705sBq+4nX+upRm
 hJ5nuQ2fzP+1rewrSWkyKW1otnCPDa59eHPSuvXpWPWpWoZJmeW8KtpCs9DovDe+z9ZTWfxJ0Gg
 HR7zreFw=
X-Gm-Gg: ASbGncs1pqbOQVhCcGm1k5LsSvMLFBu/sPrOCfnNaSzXj7n9mLOLZJwtlsC/eZRvbyh
 7GIMgy1i7CENRIgh89g278whtZGoLG3MU98lSiMB8g5WwW9QHLXEQipMuadV45UbGwe3efgx3IH
 MKKCUeRtFUWqFJpkBnGzo/8uC7RJ4L72J6D2aeNAGXD+/dir6xMIL6lavr8Ww7dXO3dxHq3jEt1
 0G+XcHRLSscQ97L1VJ+2bFvrbECg0r14tK96XOHsZa+jZxqKq8311YOfdLeZWVEqgJAZJ5uLI9/
 6pFIyK7U6rm4oZ0U2yrpaRDSEnp/RkBkCNu6B2adF6lw2Kvrv7oq8SlUjttNmKHQYvhdQOyxf+l
 p1xl32kF8N/wO24sZHE8sp66B75HC81IUl5Q12JK4yAhV7C+3WwJI8ruvERU2UdXVsHD53dUpu8
 HB
X-Google-Smtp-Source: AGHT+IFy2mD1I+kh3rUvLv8rKFFdvHT/VpfbJVaiwtXxxx3DiZkZDvOIgps5s+pl/0LsPaayx1gDJQ==
X-Received: by 2002:a17:907:94c3:b0:b0e:d477:4972 with SMTP id
 a640c23a62f3a-b703d3840dcmr341769366b.25.1761753454030; 
 Wed, 29 Oct 2025 08:57:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85369697sm1510782666b.26.2025.10.29.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC1D060F82;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 30/35] tests: add test for double-traps on rv64
Date: Wed, 29 Oct 2025 15:50:39 +0000
Message-ID: <20251029155045.257802-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

We do have a number of test-case for various architectures exercising
their interrupt/exception logic. However, for the recently introduced
trap API we also want to exercise the logic for double traps on at least
one architecture.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-31-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 3ca595335dd..d9c0036eb4b 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -24,5 +24,11 @@ EXTRA_RUNS += run-test-mepc-masking
 run-test-mepc-masking: test-mepc-masking
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-plugin-doubletrap
+run-plugin-doubletrap: doubletrap
+	$(call run-test, $<, \
+	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
+	  $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/doubletrap.S b/tests/tcg/riscv64/doubletrap.S
new file mode 100644
index 00000000000..b61089c9c1c
--- /dev/null
+++ b/tests/tcg/riscv64/doubletrap.S
@@ -0,0 +1,73 @@
+	.option norvc
+
+	.text
+	.global _start
+_start:
+	# Set up vectored interrupts
+	lla	t0, trap
+	add	t0, t0, 1
+	csrw	mtvec, t0
+
+	# Enable sw interrupts
+	csrrsi	zero, mie, 0x8
+	csrrsi	zero, mstatus, 0x8
+
+	# Engage the double trap: we trigger an machine-level software
+	# interrupt, which will trap to an illegal instruction
+	lui	t1, 0x02000
+	li	t0, 1
+	sw	t0, 0(t1)
+
+	# If we still not went out via the software interrupt route after a
+	# short while, we failed the test.
+	lui	t0, 0x1
+0:
+	addi	t0, t0, -1
+	bnez	t0, 0b
+	j	fail
+
+trap:
+	j	illegal_insn # Exceptions
+	j	fail # Supervisor software interrupt
+	j	fail
+	.insn	i CUSTOM_0, 0, x0, x0, 0 # Machine software interrupt
+	j	fail
+	j	fail # Supervisor timer interrupt
+	j	fail
+	j	fail # Machine timer interrupt
+	j	fail
+	j	fail # Supervisor external interrupt
+	j	fail
+	j	fail # Machine external interrupt
+	j	fail
+	j	fail # Counter overflow interrupt
+	j	fail
+	j	fail
+
+illegal_insn:
+	# Check whether we really got an illegal instruction
+	csrr	t0, mcause
+	li	t1, 2
+	bne	t0, t1, fail
+	li	a0, 0
+	j	_exit
+fail:
+	li	a0, 1
+_exit:
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
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.47.3


