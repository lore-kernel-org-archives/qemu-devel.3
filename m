Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F49CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5nG-0004wc-KS; Sat, 17 Oct 2026 10:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xI5mb-0004qo-CE; Sat, 17 Oct 2026 10:53:13 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xI5mX-0006fj-4h; Sat, 17 Oct 2026 10:53:13 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j6Ptc5zqdz5BNRf;
 Sat, 17 Oct 2026 22:52:56 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl1.zte.com.cn with SMTP id 69HEqm4o051258;
 Sat, 17 Oct 2026 22:52:48 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Sat, 17 Oct 2026 22:52:51 +0800
X-Zmail-TransId: 3e816ad38bc3024-fb147
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
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH 0/3] target/riscv/kvm: Add SBI STA register sync and migration
 support
Date: Sat, 17 Oct 2026 22:51:44 +0800
Message-ID: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69HEqm4o051258
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 17 Oct 2026 22:52:56 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD38BC8.000/4j6Ptc5zqdz5BNRf
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Wang Yechao (3):
  target/riscv/kvm: Detect SBI STA extension support
  target/riscv/kvm: Sync SBI STA shmem registers with KVM
  target/riscv: Add SBI STA state to vmstate

 target/riscv/cpu.h         |   6 ++
 target/riscv/kvm/kvm-cpu.c | 117 +++++++++++++++++++++++++++++++++++++
 target/riscv/machine.c     |  18 ++++++
 3 files changed, 141 insertions(+)

-- 
2.27.0


