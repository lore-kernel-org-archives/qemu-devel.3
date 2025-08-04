Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83798C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 04:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uimLu-0000SQ-FM; Sun, 03 Aug 2025 23:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uimLq-0000K1-6h
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 23:59:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uimLm-00014q-Cq
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 23:59:05 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxmnH9L5BoYx04AQ--.45219S3;
 Mon, 04 Aug 2025 11:58:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxQ+T5L5BoVP40AA--.64718S2;
 Mon, 04 Aug 2025 11:58:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/6] target/loongarch: MMU enhancement about TLB search
Date: Mon,  4 Aug 2025 11:58:43 +0800
Message-Id: <20250804035849.1305498-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+T5L5BoVP40AA--.64718S2
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

This patch set is continuous MMU enhancement, it is focused on TLB
search, especially on function helper_invtlb_page_asid() and function
helper_invtlb_page_asid_or_g(). The code is similiar with function
loongarch_tlb_search(), one common API loongarch_tlb_search_cb() is
added for these functions.

Also there is optimization with qemu TLB flush, invalidate_tlb_entry()
is used to flush one TLB entry rather than flush all TLB entries.

This patchset is based on patch sent at
  https://lore.kernel.org/qemu-devel/20250730030202.3425934-1-maobibo@loongson.cn/

Bibo Mao (6):
  target/loongarch: Add tlb search callback in loongarch_tlb_search()
  target/loongarch: Add common API loongarch_tlb_search_cb()
  target/loongarch: Use loongarch_tlb_search_cb in
    helper_invtlb_page_asid_or_g
  target/loongarch: Use loongarch_tlb_search_cb in
    helper_invtlb_page_asid
  target/loongarch: Only flush one TLB entry in
    helper_invtlb_page_asid_or_g
  target/loongarch: Only flush one TLB entry in helper_invtlb_page_asid

 target/loongarch/tcg/tlb_helper.c | 115 +++++++++++++++++-------------
 1 file changed, 64 insertions(+), 51 deletions(-)


base-commit: e5859141b9b6aec9e0a14dacedc9f02fe2f15844
-- 
2.39.3


