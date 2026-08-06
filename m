Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34775C5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzGh-00084S-Me; Thu, 06 Aug 2026 10:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vvisaev@gmail.com>) id 1wryIc-0002iR-Uk
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 09:38:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vvisaev@gmail.com>) id 1wryIb-0005zw-FX
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 09:38:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1571748f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786023496; x=1786628296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ucI+7FLfJDqBwa9PDtU7PU10APxqI5TAvUdZP+nYAQg=;
 b=P+mAoXQbSeGlQ0YJHz3ov+DhvjYxmSOuPXF/xBmPGJpGKocsAp5oXYxLfT+Ics0K8t
 GyHP+rYzWurrEuNq7VMvq/R7V1yOAWXDK12Dnv6xUNldbwQ9PQmInEI5DED0hqMipFLK
 77ixpsc1IF/6JASyfiNMm4xWW73r+63csAj+vOgjlDkDaJjcnnlejsgxU48Um1XH4twd
 L6p5O8T7a7dtWAx1PfYXY/O5N2fZP+oxZpZd3qbbvQt8RlnbAILLrlsLuKnZLkQct2vo
 +Vr1ybXuLtpwAOgYL+zzUXJ4uxUZUX9YHUQQGiQTkG63271stmRciK+taY3yzxL9CN4w
 LLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786023496; x=1786628296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ucI+7FLfJDqBwa9PDtU7PU10APxqI5TAvUdZP+nYAQg=;
 b=kpZND9vSuZiF+xnSpJoXj3XOWiSIDNPAqwhq1EODzZS1FzVi1WLUaCMqu16pU+5HIQ
 Cg+eBkQIC42AhH7EX2AeB0YC9C6859IbmgoeGLVMlNhDnyeHAjJg+iL4DPqSfXafJFdt
 veUrs8F43ZH7QGIp8eCksJ6ZdySjc1+j/11Rb30Lq6yvjDNtnhdz604vhyl+ncBA0SOn
 UXf9H2K28A3jQCqtaqhEX5uTdcqZWVNXAI26eHDeL7Ni2RNjED7G+rlkihvRQDXAU09R
 3S3LJ5UY3XoIY8SVILw8LpP3uV7MCoCOBVJodzuSeJb2MpDnY8ocKd0zSOYF3dYgofEF
 pCeg==
X-Gm-Message-State: AOJu0YzHlU7ZdO7c38IAGL2smXFYqPMlMFbQk+JhdqAQVqYXBe0ZPvbg
 zKI95VGB42rqxDIIFvo8J/dnru+iXytZGFIwQnDCJ1jGUYmB8BSQ55g3urSl6iX7dJA=
X-Gm-Gg: AR+sD13YXMlW+ASWVbqgACc5d756VTfOKNhjP7oDtxF65Wzq2ht0qn6wnN3A/9GpzOt
 wyVexy+6rhzFmMaww4sZpHHrUILi81O+FMwAoxWy5ESIUImFlYH1DocPAn1sNHcQ9CiyhjSnoLL
 rkdl/kcsMn9gCA3AUQjNGCCrkD0zpg5viiu1OZkQEigLG2XNOCAPkui56HPUk8n6IWpORVwKRpV
 9Agy9m5AUz4OvdRjUCOvj5Z9zdi7f89koXHMDwyE68xu2hjJBdWeY+pUm7r5sP7qCcynVXI2e49
 6phKJ0i/FNehsBWPwlhHExsN662SfoHDnoZ8xNhbpUhzjBboFWr33cbWG+bmzBFj52OnorvqIl/
 NSD7pmUD45iXs31ASnNc3ujof3vyo9TzwMk4vofQmLHEoWwNUiiQ5xY2k2qXSsDD0ItYaY65kC7
 vR1RTTNs9dWsoKdaFoitKMU/2cFC5p91AkZuf+vzhppTg=
X-Received: by 2002:a05:6000:4796:b0:47f:86af:8fdd with SMTP id
 ffacd0b85a97d-47fec4e73b3mr18818584f8f.3.1786023496029; 
 Thu, 06 Aug 2026 06:38:16 -0700 (PDT)
Received: from X1 ([178.66.48.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff79a7f07sm6837422f8f.8.2026.08.06.06.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:38:15 -0700 (PDT)
From: Vladimir Isaev <vvisaev@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org,
 Vladimir Isaev <vvisaev@gmail.com>
Subject: [PATCH 2/2] tests/tcg/riscv64: add misa write test
Date: Thu,  6 Aug 2026 16:37:47 +0300
Message-ID: <20260806133755.45924-2-vvisaev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806133755.45924-1-vvisaev@gmail.com>
References: <20260806133755.45924-1-vvisaev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=vvisaev@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 06 Aug 2026 10:40:22 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add test to check that writing misa before compact instruction doesn't
drop any bits.

Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
 tests/tcg/riscv64/test-misa-w.S           | 46 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-misa-w.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 82be8a2c91..e7d052909f 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -41,5 +41,9 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-misa-w
+run-test-misa-w: test-misa-w
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-w=true$(comma)c=true $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-misa-w.S b/tests/tcg/riscv64/test-misa-w.S
new file mode 100644
index 0000000000..22cba98b8c
--- /dev/null
+++ b/tests/tcg/riscv64/test-misa-w.S
@@ -0,0 +1,46 @@
+#define MISA_C (1<<2)
+
+	.text
+	.globl _start
+	.balign 4
+_start:
+	.option norvc
+	lla t0, trap
+	csrw mtvec, t0
+
+	# Fail if misa after write is not the same as before
+	csrr t0, misa
+	.option rvc
+	c.nop
+	csrw misa, t0
+	c.nop
+	csrr t1, misa
+	bne t0, t1, fail
+
+	li a0, 0
+	j  _exit
+
+
+	.balign 4
+	.option norvc
+trap:
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
2.55.0


