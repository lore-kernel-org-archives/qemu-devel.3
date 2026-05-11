Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E346CCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ3G-0007e5-SC; Mon, 11 May 2026 08:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMQ2x-0007Zl-0w; Mon, 11 May 2026 08:47:43 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMQ2s-0008OU-Np; Mon, 11 May 2026 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778503639; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=X9qWgw5PnHMzFEJ6dY176PQAvfAbBguWQUeZs/OwKfE=;
 b=KK4zaVjbw1sbB+0wYTicUXWsT3MGrvPrGiZvSNZ7JIHiIHoaxBCtdzSeCC78+8uquS0E1XnIDYQ9H77QXB5S2OE4+Fc56S7N33aXyOb1JOCRbH6hmZyDkhZJGgiMkVOE5vgT+wEBOYoqVQxeJDDPSUDvLcnoWiL9wZ1hmDlRR4Y=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X2jPzLl_1778503637; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X2jPzLl_1778503637 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 11 May 2026 20:47:18 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v6 0/6] target/riscv: Implement Smsdid and Smmpt extension 
Date: Mon, 11 May 2026 20:46:59 +0800
Message-Id: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch set introduces support for the RISC-V Smmpt (Supervisor
Memory-tracking and Protection Table) extension
v0.3.4(https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
Smmpt provides a hardware mechanism for fine-grained memory protection,
checked after address translation, which is particularly useful for
supervisor-level sandboxing and security monitoring.

The rfc patch set:
https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html

v5->v6:
    1. Use explicitly bit fields extract instead of mpte_union_t.
    2. Use the same exception behavior for MPT valiation as PMP
       valiation.
    3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
    4. Use address_space_*_le instead of address_space_* for SMMPT.
    5. Only print SMMPT address check log when SMMPT is enabled.
    6. Add implied rule for SMMPT as it depends on SMSDID.
    7. Rebase to master.

v4->v5:
    1. Rebase to master.
v3->v4:
    1. Add missing review tags.
v2->v3:
    1. Fix build error in patch 2.
    2. Rebase to master.

rfc->v2:
    1. When ext_smmpt is false or BARE mode, make other fields in mmpt
       CSR zero.
    2. Add patch 5 to fix smrnmi ISA string order.
    3. Fix patch 6 smmpt and smsdid ISA string order.
    4. Make smmpt and smsdid experiment extensions.
    5. Add review tags.

LIU Zhiwei (6):
  target/riscv: Add basic definitions and CSRs for SMMPT
  target/riscv: Implement core SMMPT lookup logic
  target/riscv: Integrate SMMPT checks into MMU and TLB fill
  target/riscv: Implement SMMPT fence instructions
  target/riscv: Fix smrnmi isa alphabetical order
  target/riscv: Enable SMMPT extension

 target/riscv/cpu.c                            |  17 +-
 target/riscv/cpu.h                            |   9 +-
 target/riscv/cpu_bits.h                       |  18 ++
 target/riscv/cpu_cfg_fields.h.inc             |   2 +
 target/riscv/cpu_helper.c                     | 117 +++++++--
 target/riscv/csr.c                            |  95 ++++++++
 target/riscv/insn32.decode                    |   2 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  30 +++
 target/riscv/meson.build                      |   1 +
 target/riscv/pmp.h                            |   3 +
 target/riscv/riscv_smmpt.c                    | 227 ++++++++++++++++++
 target/riscv/riscv_smmpt.h                    |  26 ++
 12 files changed, 528 insertions(+), 19 deletions(-)
 create mode 100644 target/riscv/riscv_smmpt.c
 create mode 100644 target/riscv/riscv_smmpt.h

-- 
2.43.0


