Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDA4C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 03:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5GIP-0000pR-Uw; Wed, 16 Apr 2025 23:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u5GIC-0000n1-Qn
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 23:52:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u5GI8-00071E-Jy
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 23:52:00 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxG6zRegBoybHAAA--.24727S3;
 Thu, 17 Apr 2025 11:51:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxrhvPegBohl+HAA--.20757S2;
 Thu, 17 Apr 2025 11:51:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] target/loongarch: Code cleanup with function
 loongarch_map_address
Date: Thu, 17 Apr 2025 11:51:37 +0800
Message-Id: <20250417035143.268248-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhvPegBohl+HAA--.20757S2
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

Get physical address from virtual address is important for qmp command to
dump memory content. In TCG mode, it searches TLB tables firstly and
then do page table walker. In KVM mode, there are no TLB tables and page
table walker is used directly.

Here TLB tables searching is moved to directory tcg, and code about page
table walker is put in the common part so that it can be used in KVM mode
also.

---
v1 ... v2:
  1. Remove CONFIG_TCG macro with file helper.h in patch 1
  2. Refresh spelling issues in patch 5
  3. Split original patch 4 into existing patch 4 and patch 5
  4. Add !kvm_enabled() in function loongarch_map_address(), tlb entries
     will not be searched in kvm mode
---
Bibo Mao (6):
  target/loongarch: Move header file helper.h to directory tcg
  target/loongarch: Add function loongarch_get_addr_from_tlb
  target/loongarch: Move function get_dir_base_width to common directory
  target/loongarch: Add stub function loongarch_get_addr_from_tlb
  target/loongarch: Set function loongarch_map_address() with common
    code
  target/loongarch: Move function loongarch_tlb_search to directory tcg

 target/loongarch/cpu_helper.c     | 176 ++------
 target/loongarch/helper.h         | 720 +----------------------------
 target/loongarch/internals.h      |  14 +-
 target/loongarch/tcg/helper.h     | 722 ++++++++++++++++++++++++++++++
 target/loongarch/tcg/tlb_helper.c | 172 +++++--
 5 files changed, 915 insertions(+), 889 deletions(-)
 create mode 100644 target/loongarch/tcg/helper.h


base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
-- 
2.39.3


