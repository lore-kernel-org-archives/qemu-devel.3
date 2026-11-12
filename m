Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010660A2607
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WXQgAF6V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRSI-00029o-Qy; Thu, 12 Nov 2026 04:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRV-0001la-PJ; Thu, 12 Nov 2026 04:50:05 -0500
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRH-0002yM-5y; Thu, 12 Nov 2026 04:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794476971; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=L18+lG+33ZkDRISFrG2gVPe/KsUSSe5K/NpXvSy3cjU=;
 b=WXQgAF6VZHfHDT0BFjaEjNBwfQG4EsWGkeC7KGiuLTRF409avvfo+v3QMPijyuT1t0lmhi+uLzbwM9tGDXlmorAjya5McfqneYZ9g4flHRsfVTTxDkMfNDY4tn6BdKEvKrlLWiMh1zimDJZJ5CdQH3buWMxs4o9UEfI6Hgp1mMo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XEbfdaf_1794476970; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XEbfdaf_1794476970 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 12 Nov 2026 17:49:31 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 12 Nov 2026 17:49:11 +0800
Subject: [PATCH v4 05/14] target/riscv: Preserve minstretcfgh on RV32
 minstretcfg writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-riscv-pmu-correctness-v4-5-e9067bdf4df5@linux.alibaba.com>
References: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
In-Reply-To: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794476967; l=3417;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=Gqz2+1fSkqzFiX2iZbI0LG1w00iOSpJ83sPkDQJUqrs=;
 b=xEK/vEVxYAtjNwy2yA2gjtuIn+++OqA8zwH1v9SKuMemrHZc8XZIPr7TDqP/IRo8QDdRhjSAo
 eOZz6U+VhfyBuTcKfT//e496mbT98IjLuKm4o0igxmDTOr6fGrijTQH
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RV32 write_minstretcfg() replaces the full 64-bit register, clearing
minstretcfgh and its privilege-inhibit bits.

Replace only bits 31:0, as write_mcyclecfg() does. Test that a low-half
write preserves both set and clear xINH bits in minstretcfgh.

Fixes: b54a84c15e38 ("target/riscv: Add cycle & instret privilege mode filtering support")
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/tcg/csr.c                   |  2 +-
 tests/tcg/riscv32/pmu-minstretcfg-rv32.S | 52 ++++++++++++++++++++++++++++++++
 tests/tcg/riscv32/system/meson.build     |  7 +++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index f11b912d38df9c9588827878b3601f672fc8f65e..93f49fdab80677ab13c924ea6c969b689ccbe502 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1170,7 +1170,7 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->minstretcfg = val;
+        env->minstretcfg = deposit64(env->minstretcfg, 0, 32, val);
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MINSTRETCFG_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFG_BIT_UINH : 0;
diff --git a/tests/tcg/riscv32/pmu-minstretcfg-rv32.S b/tests/tcg/riscv32/pmu-minstretcfg-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..59ee516cea9d09d0945033a77e788e4387cd684f
--- /dev/null
+++ b/tests/tcg/riscv32/pmu-minstretcfg-rv32.S
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* CSR numbers for older assemblers. */
+#define CSR_MINSTRETCFG      0x322
+#define CSR_MINSTRETCFGH     0x722
+
+/* RV32 writes to minstretcfg must preserve minstretcfgh. */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/*
+	 * Use complementary patterns to check both set and clear xINH bits.
+	 * All fields in the low half are WPRI, so write zero there.
+	 * Exit status 1 or 2 identifies the pattern that was not preserved.
+	 */
+	li	t4, 1
+	li	t0, 0x54000000		/* MINH, UINH, VUINH */
+	csrw	CSR_MINSTRETCFGH, t0
+	csrw	CSR_MINSTRETCFG, zero
+	csrr	t1, CSR_MINSTRETCFGH
+	bne	t0, t1, exit
+
+	li	t4, 2
+	li	t0, 0x28000000		/* SINH, VSINH */
+	csrw	CSR_MINSTRETCFGH, t0
+	csrw	CSR_MINSTRETCFG, zero
+	csrr	t1, CSR_MINSTRETCFGH
+	bne	t0, t1, exit
+	li	t4, 0
+
+exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sw	t0, 0(a1)
+	sw	t4, 4(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	8
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index 7364b625c02b05987af848c7f3bfcc91192e5129..6a24561607dabd261246e905583b7c8a9022cd37 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -29,6 +29,13 @@ tests += {
   },
 }
 
+tests += {
+  'pmu-minstretcfg-rv32.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {

-- 
2.43.0


