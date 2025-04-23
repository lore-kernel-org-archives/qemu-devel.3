Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4697CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7V5y-00029y-8F; Wed, 23 Apr 2025 04:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u7V5t-00026e-2q
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:04:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u7V5p-00063J-Kb
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:04:32 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxrOIFnwhoSoTEAA--.24382S3;
 Wed, 23 Apr 2025 16:04:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn8UCnwhofGaRAA--.35702S2;
 Wed, 23 Apr 2025 16:04:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v4 0/9] target/loongarch: Code cleanup with function
 loongarch_map_address
Date: Wed, 23 Apr 2025 16:04:08 +0800
Message-Id: <20250423080417.3739809-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8UCnwhofGaRAA--.35702S2
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
v3 ... v4:
  1. Remove stub definition with function loongarch_get_addr_from_tlb()
  2. Use tcg_enable() when calling tcg specified function, stub definition
     is not necessary for tcg specified function.

v2 ... v3:
  1. Split patch 6 into two three small patches
  2. Define tcg specified function from header file internals.h to
     tcg/tcg_loongarch.h

v1 ... v2:
  1. Remove CONFIG_TCG macro with file helper.h in patch 1
  2. Refresh spelling issues in patch 5
  3. Split original patch 4 into existing patch 4 and patch 5
  4. Add !kvm_enabled() in function loongarch_map_address(), tlb entries
     will not be searched in kvm mode
---
Bibo Mao (9):
  target/loongarch: Move header file helper.h to directory tcg
  target/loongarch: Add function loongarch_get_addr_from_tlb
  target/loongarch: Move function get_dir_base_width to common directory
  target/loongarch: Add stub function loongarch_get_addr_from_tlb
  target/loongarch: Set function loongarch_map_address() with common
    code
  target/loongarch: Define function loongarch_get_addr_from_tlb()
    non-static
  target/loongarch: Move function loongarch_tlb_search to directory tcg
  target/loongarch: Add static definition with function
    loongarch_tlb_search()
  target/loongarch: Move definition of TCG specified function to tcg
    directory

 target/loongarch/cpu.c               |   1 +
 target/loongarch/cpu_helper.c        | 177 ++-----
 target/loongarch/helper.h            | 720 +-------------------------
 target/loongarch/internals.h         |   7 -
 target/loongarch/tcg/helper.h        | 722 +++++++++++++++++++++++++++
 target/loongarch/tcg/tcg_loongarch.h |   9 +
 target/loongarch/tcg/tlb_helper.c    | 173 +++++--
 7 files changed, 915 insertions(+), 894 deletions(-)
 create mode 100644 target/loongarch/tcg/helper.h


base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
-- 
2.39.3


