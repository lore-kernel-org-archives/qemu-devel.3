Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E319F436B5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkW6-0005oK-32; Fri, 17 Apr 2026 10:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDkW3-0005Xw-Gy
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:49:55 -0400
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDkW1-0007JC-Fx
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:49:55 -0400
Received: by mail-vk1-xa42.google.com with SMTP id
 71dfb90a1353d-5674d8be45eso261730e0c.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776437392; x=1777042192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LGiZOmd5qc8W7roUFwF4hqXN40Se0zUW8OOKu9bU4NQ=;
 b=PXZorjOhwj9d6CBEJDVW3GpH6xGb0zoW4x0mOgW3g295Ia4NUqr8mzpgqLLAaRVXV2
 2LepgaPTlQMczr/za7xyhpjg3za5xjclq4n9e7SofVk5wdSq1MpReOmTrmEXjuHR0urg
 CpVhLfwzb7Rvx2tA1KHMKdCryAuoi+aykeaLLe0yCnu2qCX8W6cKAATFGBqMDfLuPVnC
 Ru2M/bogI0eEmd0UFydO+IrDHMtr4m+tA3MJnUCPNi+yNa7YjzYCz6HbtLeojxIoyn6E
 opaA68FeuY0gPp0EHKH+3E3//+0ygw1j4YKiKtpmzqT66MTj6bnVHBBPdjPqY6GbGPgX
 OOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776437392; x=1777042192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGiZOmd5qc8W7roUFwF4hqXN40Se0zUW8OOKu9bU4NQ=;
 b=kK3aZhR33FyLVglscz6BLEdssnTKKbN//v/mwdsaAw5Z0t/vhbRURnsmXuTpHrKGR4
 +X1HWsodcPevZFWr6TkfTy2GhWXuA95gWLOU0BN/j7H3xS1tJjwkaPoBZpoPwrKkcSOy
 OaqTH1x/C/Lz7WIDNOcfqRHxZEIHr6pkRLMvoVUFhyFzZRJLWYaxxzWie7d57GaxRadz
 vinxRkGmsTVN8meOvq835btQEf4av1dL0JtppVMwFlLB/J4cY/fyJrNTOfO1wPaPNS88
 TGk/X5nkvNShXTj83gyEnUOxyzlRpLLUgURKGCrBy6nSxYuRPlsAci5pzD/ULvukaMoW
 +/+g==
X-Gm-Message-State: AOJu0YwWExaN8ptV7uVzXns1X2yIbm2QePOOiNkaM8BRI1T7vrCQ4VL/
 lByeAJ8mtCG04wB3nR1pSwXBlLuOlzqRxjqC8XOiE1i9yfi79RTqWG55
X-Gm-Gg: AeBDieu08wyK+wGzyFDgA+I7bMGW9qtLVTDOufifNpan7ToTs5q/teSgCqssS3Us5rB
 Zvqd2PHa7721G2KaM2wAJmSHFqlKdYJr3soXJOE99UC8HpZShLllZvAU1XmAOxrDrHYFnffRklo
 cDVrNzUSdG+OCdRFZf777tvlxSHXk4XinDtMfnoXGFZipWbpbxa8sXwJFE2p1nOBwM5ziWMhQIA
 xm17o91d7+kgzBCiHsmcbrHZGIVRtRW12T9zvTJ/zU2wXo5dC4IS1vFnDPkoqcyiFWDMbATx2+2
 cgxSHomsAokcKV8zJGWPHn1TMfgxS0CTba7cMoyJfH/nzbgKusV3t4bFPf/+V1VcNEAQF2Q2+hS
 OKUSdowAYeoQ3ZPOU0ilcXbkJD17icOLPQjS7DAeisoTGRnOsgnnsSfLpXhIGYqGBhfuM5sCJ6y
 XB4+rSf/TLXGlOG+8lCBZECygfWASwiezVGmplCwZYT7q2sosuqJ48zh/gbeLlU8LOeZtlkfs4U
 AYRisM=
X-Received: by 2002:a05:6122:8b10:b0:56b:5e7e:d3fa with SMTP id
 71dfb90a1353d-56fa58c1168mr1532040e0c.7.1776437391957; 
 Fri, 17 Apr 2026 07:49:51 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa92f21bbsm954365e0c.11.2026.04.17.07.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 07:49:51 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v10 0/2] Generate strided vector loads/stores with tcg nodes
Date: Fri, 17 Apr 2026 22:49:30 +0800
Message-ID: <cover.1776437127.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a42;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vk1-xa42.google.com
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

Hi Alistair,

In patch v10:

- Update the email address of the patch submitter.
- Rebase on the latest riscv-to-apply.next branch.

History of changes:

patch v9:
- Simplify the implementation of gen_check_vext_elem_mask():
  remove the `mask` argument, compute the mask directly inside the function,
  and eliminate redundant code.
- Limit the bit width to 8 bits when loading the mask from memory.
- Remove the `vreg` argument in gen_ldst_vreg().
  https://lore.kernel.org/qemu-devel/cover.1758006834.git.chao.liu@zevorn.cn/

patch v8:
- Use the right TCGv type for each variable — for example, make mask_elem
  type TCGv_i64.
- Use tcg_gen_trunc_i64_ptr() to change TCGv types — don't use C-style
  casting.
- Use TCG_COND_TSTNE, not TCG_COND_NE in tcg_gen_brcond_i64() to represent:
  if (vext_elem_mask(v0, i) != 0)
  https://lore.kernel.org/qemu-devel/cover.1757690407.git.chao.liu@zevorn.cn/

patch v7:
- Standardize the subject line of patch 1 and remove the trailing period.
- Split into sub-functions to improve the patch's code readability and
  facilitate review.
- Use more faster TCG ops, use tcg_gen_andi_tl() instead of tcg_gen_rem_tl().
- Add a tested-by signature for patch 2, as Eric has already tested it.
  https://lore.kernel.org/qemu-devel/cover.1756975571.git.chao.liu@zevorn.cn/

patch v6:
- If a strided vector memory access instruction has non-zero vstart,
  check it through vlse/vsse helpers function.
- Adjust the tcg test Makefile.
  https://lore.kernel.org/qemu-devel/cover.1756906528.git.chao.liu@zevorn.cn/

Patch v5:
- Removed the redundant call to mark_vs_dirty(s) within the
  gen_ldst_stride_main_loop() function.
  https://lore.kernel.org/qemu-riscv/cover.1755609029.git.chao.liu@zevorn.cn/

Patch v4:
- Use ctz32() replace to for-loop
  https://lore.kernel.org/qemu-devel/cover.1755333616.git.chao.liu@yeah.net/

Patch v3:
- Fix the get_log2() function:
  https://lore.kernel.org/qemu-riscv/cover.1755287531.git.chao.liu@yeah.net/T/#t
- Add test for vlsseg8e32 instruction.
- Rebase on top of the latest master.

Patch v2:
- Split the TCG node emulation of the complex strided load/store operation into
  two separate functions to simplify the implementation:
  https://lore.kernel.org/qemu-riscv/20250312155547.289642-1-paolo.savini@embecosm.com/

Patch v1:
- Paolo submitted the initial version of the patch.
  https://lore.kernel.org/qemu-devel/20250211182056.412867-1-paolo.savini@embecosm.com/


Thanks,
Chao

Chao Liu (2):
  target/riscv: Use tcg nodes for strided vector ld/st generation
  tests/tcg/riscv64: Add test for vlsseg8e32 instruction

 target/riscv/insn_trans/trans_rvv.c.inc   | 354 ++++++++++++++++++++--
 tests/tcg/riscv64/Makefile.softmmu-target |   7 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 107 +++++++
 3 files changed, 450 insertions(+), 18 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

--
2.53.0


