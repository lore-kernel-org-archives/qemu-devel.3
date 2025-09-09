Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AEECA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvyRT-0005U8-US; Tue, 09 Sep 2025 09:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uvyRQ-0005T5-NZ; Tue, 09 Sep 2025 09:31:24 -0400
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uvyRC-0000rM-HB; Tue, 09 Sep 2025 09:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1757424655; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=M38N77yjscC2ED8PhgySGSkqZ6uJLmcFTAHu52UxuUg=;
 b=YAGZAJ/zrizFzP+nIXqs6sYc0CRU+TsLcZ951R0vrm4edegbnfl2GWQaf3c32eJctYu66xABy+SEmSRBrfj4Ixtb3dAp6KDKFt9tWSmHqfuaPumThk9EbpehySp3sIFbAGldmswCtwQ0SczliO0eDSERKdG8WbXUBNludNJpiZs=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WneAkZm_1757424340 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 09 Sep 2025 21:25:42 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [RFC PATCH 0/5]  target/riscv: Implement SMSDID and SMMPT extension
Date: Tue,  9 Sep 2025 21:25:28 +0800
Message-Id: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
Domain Access Protection) extension. It only includes two sub-extensions:
SMSDID and SMMPT.

This patch set implements the v0.3.4 version of Smmpt
(https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).

As there are newer SMMPT specification versions, this patch set is
not intend for merging.

The implementation is broken down into a series of logical steps:

Patch 1 adds the fundamental definitions for the Smmpt extension,
including
new CSRs (mmpt, msdcfg), their bit-field layouts, and the corresponding
CPU
configuration flags (ext_smmpt, ext_smsdid).

Patch 2 introduces the core logic for Memory Protection Table (MPT)
lookups.
It includes a new file, riscv_smmpt.c, which implements the multi-level
table walk to determine permissions for a given physical address.

Patch 3 integrates the MPT permission checks into the main MMU and TLB
handling pathways. This ensures that both page table walks and final
data accesses are subject to Smmpt protection rules.

Patch 4 adds support for the new fence instructions defined by the Smmpt
extension, specifically `mfence.spa` and `minval.spa`.

Patch 5 enables smmpt and smsdia extendion.

With this series, QEMU can now model systems that utilize the Smmpt
extension for enhanced memory security.

LIU Zhiwei (5):
  target/riscv: Add basic definitions and CSRs for SMMPT
  target/riscv: Implement core SMMPT lookup logic
  target/riscv: Integrate SMMPT checks into MMU and TLB fill
  target/riscv: Implement SMMPT fence instructions
  target/riscv: Enable SMMPT extension

 target/riscv/cpu.c                            |   4 +
 target/riscv/cpu.h                            |   9 +-
 target/riscv/cpu_bits.h                       |  27 ++
 target/riscv/cpu_cfg_fields.h.inc             |   2 +
 target/riscv/cpu_helper.c                     |  81 +++++-
 target/riscv/csr.c                            |  83 ++++++
 target/riscv/insn32.decode                    |   2 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
 target/riscv/meson.build                      |   1 +
 target/riscv/pmp.h                            |   3 +
 target/riscv/riscv_smmpt.c                    | 273 ++++++++++++++++++
 target/riscv/riscv_smmpt.h                    |  38 +++
 12 files changed, 548 insertions(+), 5 deletions(-)
 create mode 100644 target/riscv/riscv_smmpt.c
 create mode 100644 target/riscv/riscv_smmpt.h

-- 
2.25.1


