Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7332CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 09:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyS16-000485-C5; Tue, 16 Sep 2025 05:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uyS10-00047Y-FG; Tue, 16 Sep 2025 05:30:22 -0400
Received: from [115.124.28.65] (helo=out28-65.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uyS0u-0003Lr-5C; Tue, 16 Sep 2025 05:30:22 -0400
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.egLKg5x_1758014504 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 16 Sep 2025 17:21:45 +0800
From: Chao Liu <chao.liu@zevorn.cn>
To: richard.henderson@linaro.org, paolo.savini@embecosm.com, npiggin@gmail.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v9 0/2] Generate strided vector loads/stores with tcg nodes
Date: Tue, 16 Sep 2025 17:21:36 +0800
Message-ID: <cover.1758006834.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.65 (deferred)
Received-SPF: pass client-ip=115.124.28.65; envelope-from=chao.liu@zevorn.cn;
 helo=out28-65.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hi all,

Thanks Richard for the review. In patch v9:

- Simplify the implementation of gen_check_vext_elem_mask():
  remove the `mask` argument, compute the mask directly inside the function,
  and eliminate redundant code.

- Limit the bit width to 8 bits when loading the mask from memory.

- Remove the `vreg` argument in gen_ldst_vreg().

History of changes:

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
2.51.0


