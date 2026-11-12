Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FBB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D61CqJVr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRSM-0002IC-GB; Thu, 12 Nov 2026 04:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRY-0001mg-Lf; Thu, 12 Nov 2026 04:50:11 -0500
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRH-0002yP-LV; Thu, 12 Nov 2026 04:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794476973; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=DtF2tOxG9S2rVrSAaysv8gC4oBGU8ai6lpjArDDP9Ug=;
 b=D61CqJVreMH/tvZR6gd+5TrUJdS8z+n9XlbpXjNd9obfENT5GPW8t1R76Ogym7r07FObvAkna3FN7uwNg+18GHRAWZjZ9oyA3f8V9giqzN2UcYKmLJiEkOQ/Ea+/T9pnGT+kIXzsY6yUp73LommXGvwjiSlmLwn3h/n2AkN88hI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XEbfdbt_1794476972; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XEbfdbt_1794476972 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 12 Nov 2026 17:49:33 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 12 Nov 2026 17:49:14 +0800
Subject: [PATCH v4 08/14] target/riscv: Require Sscofpmf for non-fixed
 event overflow
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-riscv-pmu-correctness-v4-8-e9067bdf4df5@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794476967; l=4744;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=83I1TbXVkkXHWoRzNG7P38hkQ7vnyvRlTx6rQnswQmw=;
 b=6suNJPVNFDb1cqD3fYAmk+abBc2C36SUdFZ5fjy565T8P0W5hu3vC73hbVy/T6mfvVcg7FL5n
 1nQyodJd5EHB8VOQoVCzLY6wRMlxUXhM4ArBGDv6KADXKXkxFVS8RUG
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
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

riscv_pmu_incr_ctr() sets OF and LCOFIP on wrap even when Sscofpmf is
disabled. Use the shared overflow helper to require Sscofpmf and suppress
notifications while OF is set without stopping the counter.

Test DTLB overflow with Sscofpmf enabled and disabled, including
notification suppression and continued counting.

Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/tcg/pmu.c                      |   6 +-
 tests/tcg/riscv64/sscofpmf-event-overflow.S | 103 ++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build        |  15 ++++
 3 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 7b9c6cb4a9f3f8cb0ad9f9db9161b03005247c4d..7b07524361f9b175dc7e9590380e70e1d6f97098 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -448,11 +448,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
         counter = &env->pmu_ctrs[ctr_idx];
         if (counter->mhpmcounter_val == max_val) {
             counter->mhpmcounter_val = 0;
-            /* Generate interrupt only if OF bit is clear */
-            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
-                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
-            }
+            riscv_pmu_set_overflow(env, ctr_idx);
         } else {
             counter->mhpmcounter_val++;
         }
diff --git a/tests/tcg/riscv64/sscofpmf-event-overflow.S b/tests/tcg/riscv64/sscofpmf-event-overflow.S
new file mode 100644
index 0000000000000000000000000000000000000000..cce06da10f9c7c20c18c7863b58b6dd724c45182
--- /dev/null
+++ b/tests/tcg/riscv64/sscofpmf-event-overflow.S
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Non-fixed event overflow with and without Sscofpmf. */
+
+#ifndef EXPECT_SSCOFPMF
+#define EXPECT_SSCOFPMF 1
+#endif
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/* Unexpected exceptions report the current check number. */
+	li	t4, 1
+	lla	t0, exit
+	csrw	mtvec, t0
+	csrw	mie, zero
+	csrw	mip, zero
+	csrw	mcountinhibit, zero
+	csrw	mhpmevent3, zero
+	li	t0, -1
+	csrw	mhpmcounter3, t0
+	li	t0, 0x10019		/* DTLB read miss */
+	csrw	mhpmevent3, t0
+
+	/* One load after flushing the TLB must wrap the counter to zero. */
+	sfence.vma
+	lla	t0, first_page
+	lw	t1, 0(t0)
+	csrr	t0, mhpmcounter3
+	bnez	t0, exit
+
+	/* Only Sscofpmf turns that wrap into OF and LCOFIP. */
+	li	t4, 2
+	csrr	t0, mhpmevent3
+	srli	t0, t0, 63
+	li	t1, EXPECT_SSCOFPMF
+	bne	t0, t1, exit
+	li	t4, 3
+	csrr	t0, mip
+	srli	t0, t0, 13
+	andi	t0, t0, 1
+	bne	t0, t1, exit
+
+	/* Clearing LCOFIP alone must not re-enable overflow notification. */
+	li	t0, 1 << 13
+	csrc	mip, t0
+	li	t0, -1
+	csrw	mhpmcounter3, t0
+	sfence.vma
+	lla	t0, second_page
+	lw	t1, 0(t0)
+	li	t4, 4
+	csrr	t0, mhpmcounter3
+	bnez	t0, exit
+	li	t4, 5
+	csrr	t0, mhpmevent3
+	srli	t0, t0, 63
+	li	t1, EXPECT_SSCOFPMF
+	bne	t0, t1, exit
+	li	t4, 6
+	csrr	t0, mip
+	li	t1, 1 << 13
+	and	t0, t0, t1
+	bnez	t0, exit
+
+	/* Overflow notification must not stop event counting. */
+	sfence.vma
+	lla	t0, third_page
+	lw	t1, 0(t0)
+	li	t4, 7
+	csrr	t0, mhpmcounter3
+	li	t1, 1
+	bne	t0, t1, exit
+	li	t4, 0
+
+exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	t4, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	4096
+first_page:
+	.word	0
+	.balign	4096
+second_page:
+	.word	0
+	.balign	4096
+third_page:
+	.word	0
+	.balign	16
+semiargs:
+	.space	16
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index e6f13d541b1574cc40bf505df0b386cac2fa3b09..4092bab25985400a69003ec00e973aa5011e1057 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -127,6 +127,21 @@ tests += {
   },
 }
 
+tests += {
+  'sscofpmf-event-overflow.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
+tests += {
+  'sscofpmf-event-overflow.S': {
+    'exe_name': 'sscofpmf-event-overflow-off',
+    'cflags': cflags + ['-DEXPECT_SSCOFPMF=0'],
+    'qemu_args': ['-cpu', 'max,sscofpmf=false', qemu_args],
+  },
+}
+
 tests += {
   'sscofpmf-cycle-overflow.S': {
     'cflags': cflags,

-- 
2.43.0


