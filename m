Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B2ACCFA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 06:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4h8-0006gG-T6; Wed, 12 Nov 2025 01:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vJ4gC-0006Le-M0; Wed, 12 Nov 2025 01:50:20 -0500
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vJ4g4-0001Vy-Lg; Wed, 12 Nov 2025 01:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1762930190; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=AY8KLtHZTlkzQaYZgwDho71Pdbq6NvsksHRfgZE8ibo=;
 b=Udz8GVchwCNWydl5hGj4NYceHhNG1xP0CizoXk8KTLP9j7YDREh4HeJJvpvTmeqquMct+a3lodcZEVWsqw2s0EANGCked8lMhgZC6J6zDZThsf4pMM5DyX2WBgznjvi3p0zuGZLujYbGJ/PYBQyVd0H3NDxfY3A43dT54NilLdU=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WsFCr8u_1762930188 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 12 Nov 2025 14:49:49 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH v4 0/6] target/riscv: Implement Smsdid and Smmpt extension
Date: Wed, 12 Nov 2025 14:49:39 +0800
Message-Id: <20251112064945.46533-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

This patch set introduces support for the RISC-V Smmpt (Supervisor
Memory-tracking and Protection Table) extension. Smmpt provides a
hardware mechanism for fine-grained memory protection, checked after
address translation, which is particularly useful for supervisor-level
sandboxing and security monitoring.

The rfc patch set:
https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html

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

 target/riscv/cpu.c                            |   6 +-
 target/riscv/cpu.h                            |   9 +-
 target/riscv/cpu_bits.h                       |  27 ++
 target/riscv/cpu_cfg_fields.h.inc             |   2 +
 target/riscv/cpu_helper.c                     |  81 +++++-
 target/riscv/csr.c                            |  95 ++++++
 target/riscv/insn32.decode                    |   2 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
 target/riscv/meson.build                      |   1 +
 target/riscv/pmp.h                            |   3 +
 target/riscv/riscv_smmpt.c                    | 274 ++++++++++++++++++
 target/riscv/riscv_smmpt.h                    |  36 +++
 12 files changed, 560 insertions(+), 6 deletions(-)
 create mode 100644 target/riscv/riscv_smmpt.c
 create mode 100644 target/riscv/riscv_smmpt.h

-- 
2.25.1


