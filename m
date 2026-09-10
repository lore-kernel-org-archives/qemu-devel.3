Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE99C79FB6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 02:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4UvA-0004yi-QE; Wed, 09 Sep 2026 22:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x4Uv8-0004xp-GJ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 22:53:50 -0400
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x4Uv6-0004sA-Is
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 22:53:50 -0400
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-398a384b5f7so3322255a91.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 19:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789008827; x=1789613627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AEVGhYqwGrzulJMUlmWgmgfud7e3dtHN+uPsiqNA/mk=;
 b=S4OBJYjC/4pS4tuIki+fMstELDSGI76oBeKGA6y6ZBjqlIONXFmAEfSSfMQdhS97Dq
 lWXNoy1eKCdIlwmGeljlDkTujrXXYFrrQ4ko5WR6eulsvVLzw9nXU0JzLMRh/l4Q19Hc
 tqyJzl0t8ndXjwKpAQRYivQpnDzNTumXOEScaNkiLNWd1J+ifoCfqZyJQ2uLyclEfWW4
 cG3Ve33rHe5Ac8PLFSWuSKej6SqDWvzFlHUI606SPRtSj3t48Cb9ryociRoa9mAkXtDS
 nqqBLWxHgxiiS00ub1XZRGv8fBGPQp549KH0HrKMPsEYMTv6rbFUVBTuRbN/+AKPeQID
 14Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789008827; x=1789613627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AEVGhYqwGrzulJMUlmWgmgfud7e3dtHN+uPsiqNA/mk=;
 b=XX2uOOFxKDHBLYu8M7cvgIb8CeUY9pOrwzBETf84uoNWo3vaIwMkrfkYpcILJt/H6Z
 0ZiY45nnD2RclUKf3tJ5sGcg+YKxlW0CMkDtdgBbRNFFzQHOLqcB+HHgkCr+5vSPoHyk
 AUHGKD/82wm23LbrjwaImbmTuPA5CZVac/iP5X/2UtMhppPmeHvz+zVw/S5aewmL8q/A
 upTp7JycYf/PxqoVxC1mtM6a8MgrOhIcuIEd9jasyU35Bc3/Wpxp5ZGQ+YsL9hG3AJ53
 sBz8mmm6kQlQR1Z3DC9T1eL1dHe/BB9EFpDpj0hAsoqz6Vt7t/oreOp3DcVTFJfN8CF3
 0NWQ==
X-Gm-Message-State: AFuF++nkdHVY47o2rSplgSdnkugslVWGttR0egj5M8Qt1jP8WA3hOozg
 b5WmtZCtbkQR5l15fswOureKV10kpdoy2oCrTwdnn9h5vc3xTBZlTvh+QtCRqRMA
X-Gm-Gg: AYBFou1QIIkw5ZKwMR9Arst7bVlDQbuR95f3Zy/B6cYN8YyqBk6o+ihW9w8FNFDEhu7
 fmTDpwyXYj3EmylhEeVMRJOc6u3EhmsH6wPWwxJ46b2aS4XcAMutb2dbnZbm95O8xlHKH7s0ek4
 kdFPgTfvYqYKRvJUurK8nhdTybOZLigvZR1bBUcyksWGEYPdzRMyVss1v/X88CvPSn6JdfcGYHx
 dcSa4ZxK/IJydOMXci0d1oRnXJEvdOKhg4P/rPuDLddjDowKEL6Ng/QPVXDnr0Fo4ocODYOrq91
 zRRjZoXj3fLxmkNCHfQicBRkiTk2e+i5kdXp+LL9pG7QBQ4bSNRVDxbM8q9dNLlFEJU4lUUXoGm
 frMi++SxmUEQjf0RResn2pzonBtGNn3TXzcfP6h3jZkssJtsNc0qgSqucZv3fDvhrQCivwsWAPG
 lRt2RRWdadw9FFomwz9mDpP+Ze0le2shTBVY7YLozIyFA06CbtkzQ86LFy1mY+lnJa34Q8kxXOw
 MeNzYNpfJI1YmL7EvhQZ+Attncul73qIrJhs0U=
X-Received: by 2002:a17:90a:d005:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39bac4571c4mr15355321a91.24.1789008826096; 
 Wed, 09 Sep 2026 19:53:46 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([103.190.179.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d84fdbae4sm30186a91.14.2026.09.09.19.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 19:53:45 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v2] target/riscv: stop translating after WFI
Date: Thu, 10 Sep 2026 10:53:24 +0800
Message-ID: <20260910025324.54990-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x0b.google.com
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

helper_wfi() never returns to translated code: it either raises an
exception or exits the CPU loop after marking the CPU as halted. However,
trans_wfi() leaves the translation state as DISAS_NEXT, so instructions
following WFI can be included in the same TB.

With icount enabled, this makes the following instruction part of the TB's
instruction count when WFI exits, causing minstret to be incremented once
too many. Set DISAS_NORETURN after emitting the helper.

Add a TCG test for both reported cases: WFI waking for a locally enabled
pending interrupt with mstatus.MIE clear, and WFI taking a timer interrupt.

Fixes: 55c2a12cbcd3 ("RISC-V TCG Code Generation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4230
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>

---
Changes in v2:
- Register test-minstret-wfi.S with the Meson TCG test framework so
  check-tcg executes it.

diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index a8eaccef67..ebbbb01179 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -145,6 +145,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
     decode_save_opc(ctx, 0);
     gen_update_pc(ctx, ctx->cur_insn_len);
     gen_helper_wfi(tcg_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 #else
     return false;
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 8604c2a45a..2aca68e078 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -23,6 +23,7 @@ tests += {
   'test-mepc-masking.S': setup,
   'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
   'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
+  'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
 }
 
diff --git a/tests/tcg/riscv64/test-minstret-wfi.S b/tests/tcg/riscv64/test-minstret-wfi.S
new file mode 100644
index 0000000000..0fd0158d5b
--- /dev/null
+++ b/tests/tcg/riscv64/test-minstret-wfi.S
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+	li	s3, 0
+
+	/*
+	 * A pending, locally enabled interrupt wakes WFI even with MIE
+	 * clear.
+	 */
+	li	t0, 0x8		/* MIE_MSIE */
+	csrw	mie, t0
+	csrci	mstatus, 0x8	/* MSTATUS_MIE */
+	li	t0, 0x2000000	/* MSIP0 */
+	li	t1, 1
+	sw	t1, 0(t0)
+
+	/*
+	 * The first CSR read and WFI retire before the second read obtains s1,
+	 * so the expected difference is two.
+	 */
+	csrr	s0, minstret
+	wfi
+	csrr	s1, minstret
+	sub	s1, s1, s0
+	li	t1, 2
+	beq	s1, t1, 1f
+	ori	s3, s3, 1
+1:
+
+	/* Clear the software interrupt before testing the trap path. */
+	sw	zero, 0(t0)
+	csrw	mie, zero
+
+	/* Schedule a timer interrupt far enough ahead to reach WFI first. */
+	li	t0, 0x200bff8	/* MTIME */
+	ld	t1, 0(t0)
+	addi	t1, t1, 100
+	li	t0, 0x2004000	/* MTIMECMP0 */
+	sd	t1, 0(t0)
+	li	t0, 0x80		/* MIE_MTIE */
+	csrw	mie, t0
+	csrsi	mstatus, 0x8	/* MSTATUS_MIE */
+
+	/*
+	 * The first CSR read and WFI retire before the trap handler obtains s1,
+	 * so the expected difference is again two.
+	 */
+	li	s2, 1
+	csrr	s0, minstret
+	wfi
+	beqz	s2, 1f
+	ori	s3, s3, 2
+1:
+	bnez	s3, fail
+	li	a0, 0
+	j	_exit
+
+fail:
+	mv	a0, s3
+
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
+	.balign	4
+trap:
+	/* Read minstret before retiring an instruction in the handler. */
+	csrr	s1, minstret
+	sub	s1, s1, s0
+	addi	s1, s1, -2
+	snez	s2, s1
+
+	/* Disable the timer interrupt before returning past WFI. */
+	li	t0, 0x2004000	/* MTIMECMP0 */
+	li	t1, -1
+	sd	t1, 0(t0)
+	li	t0, 0x80		/* MIE_MTIE */
+	csrc	mie, t0
+	mret
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.43.0

