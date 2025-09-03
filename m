Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8A8CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnyU-000774-Fe; Wed, 03 Sep 2025 09:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1utnyS-00075s-5j; Wed, 03 Sep 2025 09:56:32 -0400
Received: from [115.124.28.43] (helo=out28-43.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1utnyN-0002MV-KI; Wed, 03 Sep 2025 09:56:31 -0400
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.eWfK6Qp_1756907526 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 03 Sep 2025 21:52:07 +0800
From: Chao Liu <chao.liu@zevorn.cn>
To: richard.henderson@linaro.org, paolo.savini@embecosm.com, npiggin@gmail.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v6 0/2] Generate strided vector loads/stores with tcg nodes
Date: Wed,  3 Sep 2025 21:52:00 +0800
Message-ID: <cover.1756906528.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.43 (deferred)
Received-SPF: pass client-ip=115.124.28.43; envelope-from=chao.liu@zevorn.cn;
 helo=out28-43.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Thanks Nick for the review. In patch v6, I merge Nick's changes:

1. If a strided vector memory access instruction has non-zero vstart, 
   check it through vlse/vsse helpers function.

   An implementation is permitted to cause an illegal instruction
   if vstart is not 0 and it is set to a value that can not be
   produced implicitly by the implementation, but memory accesses
   will generally always need to deal with page faults.

2. Adjust the tcg test Makefile, use a separate qemu-option for
   vlsseg8e32 case to avoid affect other cases.

see:
https://lore.kernel.org/qemu-riscv/6bqmz4ejwvp4vaj2vve7scqwsvrnjzm657htie7xcvciy54gw6@nbz6hvbombui/


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


Thanks,
Chao

Chao Liu (2):
  target/riscv: Generate strided vector loads/stores with tcg nodes.
  tests/tcg/riscv64: Add test for vlsseg8e32 instruction

 target/riscv/insn_trans/trans_rvv.c.inc   | 321 +++++++++++++++++++---
 tests/tcg/riscv64/Makefile.softmmu-target |   7 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 107 ++++++++
 3 files changed, 396 insertions(+), 39 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

-- 
2.50.1


