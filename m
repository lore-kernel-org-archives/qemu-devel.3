Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B83CF07B3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 06:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syn33-00019W-HR; Thu, 10 Oct 2024 02:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1syn30-00017k-3l
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:53:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1syn2y-00040v-8a
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:53:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx44jTeQdn7OIRAA--.26034S3;
 Thu, 10 Oct 2024 14:53:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxXuTTeQdnBiAiAA--.41709S2;
 Thu, 10 Oct 2024 14:53:07 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn,
	philmd@linaro.org
Subject: [PATCH v2 0/5] LoongArch/tcg: Add hardware page table walker support
Date: Thu, 10 Oct 2024 14:35:31 +0800
Message-Id: <20241010063536.2276871-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXuTTeQdnBiAiAA--.41709S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

Loongson-3A6000 and newer processors have hardware page table walker
(PTW) support. PTW can handle all fastpaths of PIL/PIS/PIF/PIE
exceptions by hardware.

V2:
- Remove the '21' magic value, patch1;
- Add a flag is_debug for debug access, patch5;
- Use qatomic_cmpxchg to change the new pte_val, patch5.

Song Gao (5):
  target/loongarch: Add a new cpu_type la664
  target/loongarch: Add do_lddir/ldpte()
  target/loongarch: Add do_fill_tlb_entry()
  target/loongarch: Add get_random_tlb_index()
  target/loongarch/tcg: Add hardware page table walker support

 target/loongarch/cpu-csr.h        |   3 +
 target/loongarch/cpu.c            |  51 ++++--
 target/loongarch/cpu.h            |   1 +
 target/loongarch/cpu_helper.c     |  26 ++-
 target/loongarch/internals.h      |   4 +-
 target/loongarch/tcg/tlb_helper.c | 277 ++++++++++++++++++++++++------
 6 files changed, 293 insertions(+), 69 deletions(-)

-- 
2.33.0


