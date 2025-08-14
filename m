Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD10CA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 10:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umVSf-0003FM-I4; Thu, 14 Aug 2025 06:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1umVSc-0003Eq-JQ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:45:30 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1umVSW-0008Ti-8G
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:45:30 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 89F06233B2;
 Thu, 14 Aug 2025 13:45:13 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] target/hppa: prevent overflow in BTLB entry size calculation
Date: Thu, 14 Aug 2025 13:43:22 +0300
Message-ID: <20250814104511.12823-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
In-Reply-To: <5ab2be93-2551-4c82-886d-3cdf47360322@linaro.org>
References: <5ab2be93-2551-4c82-886d-3cdf47360322@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

1) I’m not entirely sure why using long long is considered “always wrong,”
especially since just a few lines above there’s a similar usage here:

qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_INSERT "
                    "0x%08llx-0x%08llx: vpage 0x%llx for phys page 0x%04x len %d "
                    "into slot %d\n",
                    (long long) virt_page << TARGET_PAGE_BITS,
                    (long long) (virt_page + len) << TARGET_PAGE_BITS,
                    (long long) virt_page, phys_page, len, slot);

That said, I do agree that using long long here might not be the best approach, and I’ll fix it.

2) If len can approach INT32_MAX, why wouldn’t the calculation len * TARGET_PAGE_SIZE cause an overflow?
This operation is done between an unsigned int and a constant, and uses 32-bit arithmetic.
I agree this patch likely doesn’t affect real scenarios — when running the Debian image
I saw only values where len <= 2048 and TARGET_PAGE_SIZE = 4096, so no overflow would occur.
However, as I understand it, these values come from outside and are not validated anywhere,
so theoretically they could be arbitrary.

