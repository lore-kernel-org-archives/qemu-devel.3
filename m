Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE9BCD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr01-0005Dn-DB; Wed, 04 Sep 2024 10:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slqzy-00059j-RB; Wed, 04 Sep 2024 10:28:42 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slqzw-0002n0-06; Wed, 04 Sep 2024 10:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725460109; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=8OcrRNWQAPV6R7+OnPdsmWhRlfgMAe8czjXwsjfyiZg=;
 b=B7aiGrA4CNZgx1p1M61XxMwvS8I3tfkK6vyosfJtpbHHYbq6SifgydwA8v6ary38FtJVeKFA7XQE9RfHpZ44a2PCVLo4abC+Uj4BbergSu24x2CnaWEzIgzPeoj1mBEc8fPjAaLD1csdjoiAohBnLzcmYgyEsykBw1IILk+aSgc=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEHwosp_1725460106) by smtp.aliyun-inc.com;
 Wed, 04 Sep 2024 22:28:27 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v3 00/14] Add support for vector
Date: Wed,  4 Sep 2024 22:27:25 +0800
Message-Id: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

This patch set introduces support for the RISC-V vector extension
in TCG backend for RISC-V targets.

v3:
  1. Use the .insn form in cpuinfo probing.
  
  2. Use reserved_regs to constrain the register group index instead of using constrain.
  
  3. Avoid using macros to implement functions whenever possible.
  
  4. Rename vtypei to vtype.
  
  5. Move the __thread prev_vtype variable to TCGContext.
  
  6. Support fractional LMUL setting, but since MF2 has a minimum ELEN of 32,
    restrict fractional LMUL to cases where SEW < 64.
  
  7. Handle vector load/store imm12 split in a different function.
  
  8. Remove compare vx and implement INDEX_op_cmpsel_vec for INDEX_op_cmp_vec in a more concise way.

  9. Move the implementation of shi_vec from tcg_expand_vec_op to tcg_out_vec_op.
  
  10. Address some formatting issues.

v2:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00679.html

v1:
  https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00205.html

Swung0x48 (1):
  tcg/riscv: Add basic support for vector

TANG Tiancheng (13):
  tcg/op-gvec: Fix iteration step in 32-bit operation
  util: Add RISC-V vector extension probe in cpuinfo
  tcg/riscv: Add riscv vset{i}vli support
  tcg/riscv: Implement vector load/store
  tcg/riscv: Implement vector mov/dup{m/i}
  tcg/riscv: Add support for basic vector opcodes
  tcg/riscv: Implement vector cmp ops
  tcg/riscv: Implement vector neg ops
  tcg/riscv: Implement vector sat/mul ops
  tcg/riscv: Implement vector min/max ops
  tcg/riscv: Implement vector shs/v ops
  tcg/riscv: Implement vector roti/v/x shi ops
  tcg/riscv: Enable native vector support for TCG host

 host/include/riscv/host/cpuinfo.h |    3 +
 include/tcg/tcg.h                 |    3 +
 tcg/riscv/tcg-target-con-set.h    |    7 +
 tcg/riscv/tcg-target-con-str.h    |    3 +
 tcg/riscv/tcg-target.c.inc        | 1047 ++++++++++++++++++++++++++---
 tcg/riscv/tcg-target.h            |   80 ++-
 tcg/riscv/tcg-target.opc.h        |   12 +
 tcg/tcg-internal.h                |    2 +
 tcg/tcg-op-gvec.c                 |    2 +-
 tcg/tcg-op-vec.c                  |    2 +-
 util/cpuinfo-riscv.c              |   26 +-
 11 files changed, 1062 insertions(+), 125 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

-- 
2.43.0


