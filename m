Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C7C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 02:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHvgg-0001gI-7t; Wed, 21 May 2025 22:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uHvgS-0001fi-Fg; Wed, 21 May 2025 22:29:25 -0400
Received: from out28-49.mail.aliyun.com ([115.124.28.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uHvgP-0000Hx-QN; Wed, 21 May 2025 22:29:24 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.cx8bo2S_1747880943 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 22 May 2025 10:29:07 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: palmer@dabbelt.com,
	alistair23@gmail.com
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, zhangtj@tecorigin.com,
 lc00631@tecorigin.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v4 0/1] fix the way riscv_plic_hart_config_string() gets the
 CPUState
Date: Thu, 22 May 2025 10:28:58 +0800
Message-ID: <cover.1747878772.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.49; envelope-from=lc00631@tecorigin.com;
 helo=out28-49.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: "Chao Liu" <lc00631@tecorigin.com>

Hi, all:

Thanks to Alistair for the review~

PATCH v4:

Rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

PATCH v3:

Use cpu_by_arch_id() instead of qemu_get_cpu(), when registering gpio in
sifive_plic_create().

PATCH v2:

During plic initialization, CPUSate is obtained by traversing qemu_get_cpu(),
which was an early design flaw (see PATCH v1 reviewed).

A better approach is to use riscv's hartid for indexing via the cpu_by_arch_id()
interface.

PATCH v1 (Reviewed):
https://lore.kernel.org/qemu-riscv/416e68f4-bf12-4218-ae2d-0246cc8ea8ec@linaro.org/T/#u

--
Regards,
Chao

Chao Liu (1):
  hw/riscv: fix PLIC hart topology configuration string when not getting
    CPUState correctly

 hw/intc/sifive_plic.c      | 4 ++--
 hw/riscv/boot.c            | 4 ++--
 hw/riscv/microchip_pfsoc.c | 2 +-
 hw/riscv/sifive_u.c        | 5 +++--
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/boot.h    | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.48.1


