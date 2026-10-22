Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CB606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJiWB-0001Hw-Td; Wed, 21 Oct 2026 22:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xJiW9-0001G3-2F; Wed, 21 Oct 2026 22:26:57 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xJiW6-0003St-UM; Wed, 21 Oct 2026 22:26:56 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4j995H3dHQz5B0lT;
 Thu, 22 Oct 2026 10:26:43 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 69M2Qcl5023886;
 Thu, 22 Oct 2026 10:26:38 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Thu, 22 Oct 2026 10:26:39 +0800
X-Zmail-TransId: 3e816ad9745e026-1c193
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH v2 0/3] target/riscv/kvm: Add SBI STA register sync and
 migration support
Date: Thu, 22 Oct 2026 10:25:23 +0800
Message-ID: <20261022022535.437892-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69M2Qcl5023886
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 22 Oct 2026 10:26:43 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD97463.000/4j995H3dHQz5B0lT
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KVM already exposes the SBI STA extension and its shmem address through
the one-reg interface, but QEMU does not consume it. As a result, the
guest-configured shmem address is not kept in sync between KVM and QEMU,
and is lost on migration, breaking STA for the guest after live
migration.

This series probes for SBI STA support via get-reg-list, synchronizes
the shmem address (shmem_lo/shmem_hi) between KVM and QEMU (skipping the
put at reset, since the address is configured by the guest), and saves
the address in vmstate so STA keeps working after live migration. Only
the STA shmem address is saved for now; other SBI state can be appended
to kvm_sbi_state later.

Changes in v2:
 - patch03, only save the sbi sta state if kvm sbi sta supported.
 - rebase on riscv-to-apply.next.

 - Link to v1:
 https://lore.kernel.org/qemu-devel/20261017145211.219258-1-wang.yechao255@zte.com.cn/

Wang Yechao (3):
  target/riscv/kvm: Detect SBI STA extension support
  target/riscv/kvm: Sync SBI STA shmem registers with KVM
  target/riscv: Add SBI STA state to vmstate

 target/riscv/cpu.h           |   6 ++
 target/riscv/kvm/kvm-cpu.c   | 122 +++++++++++++++++++++++++++++++++++
 target/riscv/kvm/kvm_riscv.h |   1 +
 target/riscv/machine.c       |  18 ++++++
 4 files changed, 147 insertions(+)

-- 
2.27.0


