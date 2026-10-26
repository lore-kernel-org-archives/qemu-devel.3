Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLAff-0006dE-7a; Sun, 25 Oct 2026 22:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLAfY-0006bK-UB; Sun, 25 Oct 2026 22:42:41 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLAfW-0002No-BG; Sun, 25 Oct 2026 22:42:40 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4jCdFV3wKRz55y1Z;
 Mon, 26 Oct 2026 10:42:22 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl1.zte.com.cn with SMTP id 69Q2fpXG085165;
 Mon, 26 Oct 2026 10:42:15 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Mon, 26 Oct 2026 10:42:16 +0800
X-Zmail-TransId: 3e816adebe07027-00c52
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
Subject: [PATCH v5 0/4] riscv: AIA: Add in-kernel irqchips save and restore
 function support
Date: Mon, 26 Oct 2026 10:40:39 +0800
Message-ID: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69Q2fpXG085165
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 26 Oct 2026 10:42:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ADEBE0E.000/4jCdFV3wKRz55y1Z
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for in-kernel AIA irqchip save and restore
on RISC-V.

Changes in v5:
- Fix typos in the patch descriptions.
- Split the non-RISC-V-specific changes into a separate patch (patch 03).
- Drop the TCG vmstate debug fix from this series.
- Link to v4: https://lore.kernel.org/qemu-devel/20261023021237.486091-1-wang.yechao255@zte.com.cn/

Changes in v4:
- Fix build issues in the TCG-only configuration.
- Rename several functions to make them more readable.
- Fix the missing section footer problem.
- Add patch 04, which fixes an assertion failure during save on
  --disable-tcg builds.

- Link to v3: https://lore.kernel.org/qemu-devel/20260602142930300qtONy7P2DkDM40BX_T3_A@zte.com.cn/
 
Changes in v3:
- Removed unnecessary changes in bitops.h
- Link to v2: https://lore.kernel.org/qemu-devel/20260305171729291ZzfxmqZ48P2Tbz9TGCtST@zte.com.cn/

Changes in v2:
- Added the BITS_TO_U64S macro
- Added the nr_eix field and dynamically allocated the eie/eip arrays
- Replaced the CONFIG_32BIT macro with is_32bit boolean flag
- Link to v1: https://lore.kernel.org/qemu-devel/20260227180104794YvW9Rb2I_kAGzUruZL11Q@zte.com.cn/


Wang Yechao (1):
  include/qemu/bitops: Move BITS_TO_U64S to bitops.h

Xuemei Liu (3):
  target/riscv/kvm: create kvm_riscv_aia_access_reg
  hw/intc/riscv_aplic: Add in-kernel aplic save and restore function
  hw/intc/imsic: Add in-kernel imsic save and restore function

 hw/intc/riscv_aplic.c         | 201 +++++++++++++++++++++++++++++-----
 hw/intc/riscv_imsic.c         | 180 +++++++++++++++++++++++++++---
 include/hw/intc/riscv_aplic.h |   4 +
 include/hw/intc/riscv_imsic.h |   3 +
 include/qemu/bitops.h         |   1 +
 migration/vmstate-types.c     |   3 +-
 target/riscv/kvm/kvm-cpu.c    |   7 +-
 target/riscv/kvm/kvm_riscv.h  |   1 +
 8 files changed, 357 insertions(+), 43 deletions(-)

-- 
2.47.3


