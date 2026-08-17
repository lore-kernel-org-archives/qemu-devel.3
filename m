Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542B7C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyvw-0004D1-6I; Mon, 17 Aug 2026 11:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vvisaev@gmail.com>) id 1wvyvu-0004AN-Os
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:07:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vvisaev@gmail.com>) id 1wvyvs-0007PF-QZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:07:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so287135b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786979243; x=1787584043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PD375gm/XTL7dFZJE8PXseM45sYMLiJNdxxsddeEhu0=;
 b=Nq/KL1G2qqDMb23FokDPti8A+nH/JyodKmbD9aghWiFhTvdfm6C3DwWDGuKoQpJILm
 0uOxm0tyL91RmPG8defOi+tzscrGTMjcXIRWRIqx+WYZoq3b3SJ0heYlMD2ax/MvISKf
 5esRHsq2paJuWh3JQHt+YFSNeZ42eVoeRqs3CIqosHfRV5E7KN5Qb5wpt5dTny3F++II
 YB/4xXnV6ASWOJE5HFPiClMeHfaajbzfxaBnaHN/xuTIMLThDvp9xjJtkPY9WGR2qelS
 npuryabHOxXgBs++2O96Du3KLeeuPoM7dNfrcLcidjZSS79wlHX432WmmdPZKML2Ft28
 x60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979243; x=1787584043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PD375gm/XTL7dFZJE8PXseM45sYMLiJNdxxsddeEhu0=;
 b=ChXYVnoQ8lOkCx671c50AhB1we4aNfAoRJRdf/oiqgJ8XBuJO8lP41FUGjv38Jg1Ly
 doZC5t2dnslF4a2v4zPARR1DHSfBOMGGqxmskQkGJlIOqzInT8TFhDWLp3JeGfULbCc+
 gbbzEc3toPMWuaZLh/LIYQ5VOmrttprGQoJh7167qDCf4MYH3zufIcXFV56q+FzfHaBm
 a2jKaZV9bM6NLiKhajlU0C7IshFYdVAMs0DUS38SWXi/p3GcpGJkMv2VJd0wPXKkhDap
 D1av8kAuO9TK3l8LWMlZ7dq8BlSUfWJSlBVOML8qbXY8v6Pz+ET8+zDycUqheN3FueMt
 iZ/A==
X-Gm-Message-State: AOJu0YwZfPko+WZ7pNBNnHwjyd9bDE02cIBUEWAMnfLDdAdEDpp2zwGx
 P+XJnUFzEaMe8Cg5XRfZ7GE6COOmpKxYbFwAYkrYNUWWb6/SnLEbJTG7S2xcNjoU
X-Gm-Gg: AR+sD13K5TruTqLF7MkE8gq0q0Ryy9IVcrhDBEi/fuj1HwSO4oy3XYZX3YZg0fOILE+
 DiBwkhsVwOFpGuh2GqcYa1sQZpg8U7cobVx/2tJFis6cjA3EgtlWMgO1OaQGlvnyu0h2t+oEGf9
 z6ladxFjlK3LfJQVOKSZ3VsvgOkBD6jLb35xR/AqSb6dJxMhcWs+mhj43KH2IZ2vPl8BiKJwTkW
 yNxGr/iqnBHZTSDBtdAsM63eYv3i4v/pKYDTyiUJVl8ATf5DvWsQYZ/Wt+8kImom5MA1yD/zt/1
 Wf5GfjXzTRDiGhXCB7fB31kIEh21gRLmKp1s+X0JhKSqEh+v/h3itJjGSqjmtMb3JSb08xXnlLm
 cYa1BZkCPYszYlZcNp4s/DhvJdq3N8DWeq4amG2CSN4gAUJARkNdwlwf4didQE7pOKoPHQeSIEg
 a3771YUlq1rmv3NKjHESApaaagdl/GMNKbC6Em1dQe/Ox6
X-Received: by 2002:a05:6a00:1f03:b0:846:bc81:3e29 with SMTP id
 d2e1a72fcca58-84fde365255mr26772033b3a.2.1786979243206; 
 Mon, 17 Aug 2026 08:07:23 -0700 (PDT)
Received: from X1 ([178.66.48.90]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc13bf05584sm900775a12.4.2026.08.17.08.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:07:22 -0700 (PDT)
From: Vladimir Isaev <vvisaev@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, joel@jms.id.au,
 npiggin@gmail.com, Vladimir Isaev <vvisaev@gmail.com>
Subject: [PATCH v2 2/2] tests/tcg/riscv64: add misa write test
Date: Mon, 17 Aug 2026 18:06:38 +0300
Message-ID: <20260817150653.40357-3-vvisaev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817150653.40357-1-vvisaev@gmail.com>
References: <20260817150653.40357-1-vvisaev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=vvisaev@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Link: https://lore.kernel.org/r/20260321144554.606417-2-npiggin@gmail.com
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
 tests/tcg/riscv64/test-misa-w.S           | 88 +++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-misa-w.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 82be8a2c91..2c7f00976c 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -41,5 +41,9 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-misa-w
+run-test-misa-w: test-misa-w
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-w=true$(comma)c=true$(comma)v=true $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-misa-w.S b/tests/tcg/riscv64/test-misa-w.S
new file mode 100644
index 0000000000..7f1eb30023
--- /dev/null
+++ b/tests/tcg/riscv64/test-misa-w.S
@@ -0,0 +1,88 @@
+/*
+ * Test for MISA changing C and related IALIGN alignment cases
+ *
+ * This test verifies that the "C" extension can be cleared and set in MISA,
+ * that a branch to 2-byte aligned instructions can be executed when "C" is
+ * enabled, and that a write to MISA which would increase IALIGN and cause
+ * the next instruction to be unaligned is ignored.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define RVC (1 << ('C'-'A'))
+#define RVV (1 << ('V'-'A'))
+
+.option norvc
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	csrr	t0, misa
+	li	t1, RVC
+	not	t1, t1
+	and	t0, t0, t1
+	csrw	misa, t0
+	csrr	t1, misa
+	li	a0, 2 # fail code
+	bne	t0, t1, _exit # Could not clear RVC in MISA
+
+	li	t1, RVC
+	or	t0, t0, t1
+	csrw	misa, t0
+	csrr	t1, misa
+	li	a0, 3 # fail code
+	bne	t0, t1, _exit # Could not set RVC in MISA
+
+	j	unalign
+. = . + 2
+unalign:
+
+	li	t1, RVC
+	not	t1, t1
+	and	t0, t0, t1
+	csrw	misa, t0
+	csrr	t1, misa
+	li	a0, 4 # fail code
+	beq	t0, t1, _exit # Was able to clear RVC in MISA
+
+	li	t0, (RVC|RVV)
+	not	t0, t0
+	and	t0, t0, t1
+	csrw	misa, t0
+	csrr	t0, misa
+	li	a0, 5 # fail code
+	bne	t0, t1, _exit # MISA write was not ignored (RVV was cleared)
+
+	j	realign
+. = . + 2
+realign:
+
+	# Success!
+	li	a0, 0
+	j	_exit
+
+trap:
+	# Any trap is a fail code 1
+	li	a0, 1
+
+# Exit code in a0
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


