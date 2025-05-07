Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7871C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 02:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCUa6-0002ZC-Qd; Tue, 06 May 2025 22:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uCUZy-0002Yn-8P
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:32:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uCUZv-0000o2-Ks
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:32:14 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx63EhxhpoSpvXAA--.26102S3;
 Wed, 07 May 2025 10:32:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxj8UUxhpoKeC4AA--.11788S2;
 Wed, 07 May 2025 10:31:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/16] hw/intc/loongarch_pch: Cleanup with memory region ops
Date: Wed,  7 May 2025 10:31:32 +0800
Message-Id: <20250507023148.1877287-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8UUxhpoKeC4AA--.11788S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series patchset is to clean up with memory regions of loongarch pch
pic interrupt controller. Originally there are three iomem regions:
iomem32_low, iomem8, iomem32_highm. Since these regions only support
4 bytes/1 byte/4 bytes access, it is divided into three regions.

Now it is merged into one region, this regions supports 1/2/4/8 bytes
access.

Patch 1-6 is to replace register name, no function change.
Patch 7-16 is to use unifed memory region iomem, and supports 1/2/4/8
bytes access with read/write ops for this region, and merge three
regions above into one.

---
  v3 ... v4:
    1. Use uint8_t rather than bitfield in packed structure since there is
       different definition about bitfield between gcc and MSVC.
    2. Rebase patch based on latest version.
  v2 ... v3:
    1. Set address aligned with 8 bytes in memory region function
       pch_pic_read() and pch_pic_write(), and only compare register
       base address with 8 bytes aligned one.
    2. Replace 0xff/0xffff with UCHAR_MAX/USHRT_MAX.

  v1 ... v2:
    1. Add 1/2/4/8 bytes access support with memory region read and
       write ops.
    2. Merge three memory regions iomem32_low, iomem8 and iomem32_high
       into one region iomem.
    3. Merge trace functions for ops in above three memory regions into
       one trace function
---
Bibo Mao (16):
  hw/intc/loongarch_pch: Modify name of some registers
  hw/intc/loongarch_pch: Modify register name PCH_PIC_xxx_OFFSET with
    PCH_PIC_xxx
  hw/intc/loongarch_pch: Remove some duplicate macro
  hw/intc/loongarch_pch: Set version information at initial stage
  hw/intc/loongarch_pch: Use relative address in MemoryRegionOps
  hw/intc/loongarch_pch: Discard write operation with ISR register
  hw/intc/loongarch_pch: Use generic read callback for iomem32_low
    region
  hw/intc/loongarch_pch: Use generic read callback for iomem32_high
    region
  hw/intc/loongarch_pch: Use generic read callback for iomem8 region
  hw/intc/loongarch_pch: Use generic write callback for iomem32_low
    region
  hw/intc/loongarch_pch: Use generic write callback for iomem32_high
    region
  hw/intc/loongarch_pch: Use generic write callback for iomem8 region
  hw/intc/loongarch_pch: Use unified trace event for memory region ops
  hw/intc/loongarch_pch: Rename memory region iomem32_low with iomem
  hw/intc/loongarch_pch: Set flexible memory access size with iomem
    region
  hw/intc/loongarch_pch: Merge three memory region into one

 hw/intc/loongarch_pch_pic.c            | 331 ++++++++-----------------
 hw/intc/loongarch_pic_common.c         |  13 +
 hw/intc/trace-events                   |   8 +-
 hw/loongarch/virt.c                    |   6 -
 include/hw/intc/loongarch_pic_common.h |  57 ++---
 5 files changed, 152 insertions(+), 263 deletions(-)

-- 
2.39.3


