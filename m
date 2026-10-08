Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB5BCA600A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEi8Q-0006JD-AB; Thu, 08 Oct 2026 03:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xEi7u-0006Aq-QB; Thu, 08 Oct 2026 03:01:20 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xEi7p-0004Gt-Ps; Thu, 08 Oct 2026 03:01:12 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j0gr75Yn1z8Xrrl;
 Thu, 08 Oct 2026 15:00:55 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 69870lH9075779;
 Thu, 8 Oct 2026 15:00:47 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Thu, 8 Oct 2026 15:00:49 +0800
X-Zmail-TransId: 3e816ac73fa0022-6783a
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: daniel.barboza@oss.qualcomm.com, richard.henderson@linaro.org,
 tgamblin@baylibre.com
Cc: alistair.francis@wdc.com, chao.liu@processmission.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: Re: [PATCH v2 0/2] target: riscv: support TLB page flush for
 sfence.vma
Date: Thu,  8 Oct 2026 15:00:25 +0800
Message-ID: <20261008070029.20239-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <d4535ac9-449b-4829-a0d1-1eabcfc2c08e@oss.qualcomm.com>
References: <d4535ac9-449b-4829-a0d1-1eabcfc2c08e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69870lH9075779
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 08 Oct 2026 15:00:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AC73FA7.002/4j0gr75Yn1z8Xrrl
Received-SPF: pass client-ip=160.30.148.35;
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

Hi all,

Patch 1 decides whether to use tlb_flush_page based on whether rs1
is 0. This is similar to a patch I submitted last year [1]. Under
normal circumstances this works fine, but it can leave stale TLB
entries when the guest kernel uses THP.

The reason is that with THP, the guest's mapping is at the PMD level.
When flushing the TLB, the guest executes sfence.vma only once for the
whole huge page, rather than 512 times to flush each individual 4K page.
Patch 1 does not account for this: it only flushes the single 4K page
corresponding to the address in rs1, leaving the other 511 pages of the
huge page with stale entries. As a result, guest memory access faults
can occur after Patch 1 is merged, unless huge-page TLB support is added
for the RISC-V TCG case.

Please correct me if I've misunderstood anything.

[1] https://lore.kernel.org/qemu-devel/20250930174849833XG1Q1ETbNvg66WU2UVBTV@zte.com.cn/

Yechao,
Regards

