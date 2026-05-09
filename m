Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0A4CD37B6
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 02:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLXi2-0007th-H4; Fri, 08 May 2026 22:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wLXhj-0007sU-8M
 for qemu-devel@nongnu.org; Fri, 08 May 2026 22:46:16 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wLXhg-000399-8W
 for qemu-devel@nongnu.org; Fri, 08 May 2026 22:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778294749; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=1kQdRcri/p8eyKWTapIiOdJtELmvqsXMqJcvhnHFCu4=;
 b=qtEuaY0FDffEKtPnlRlz81CEgR8VlyKV3/cg9lorL8v5AnWPYNhYORnGWQERVq7xwPwnc942WPsJM7SepN3g0GLnF1cZSP80cP9G6TEOiPvzaNTO9vLKPD9oHuurXM32SuNfUi+sveaYN8GNrhyZhS06elEiZ3TPR9nvj0GJN7Q=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X2ZE7UY_1778294740; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X2ZE7UY_1778294740 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 09 May 2026 10:45:48 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org
Subject: [PATCH 0/2] kvm: minor cleanups in kvm_close and
 kvm_irqchip_release_virq
Date: Sat,  9 May 2026 10:45:37 +0800
Message-ID: <20260509024539.90998-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Two small cleanups in kvm-all.c:

- Patch 1 removes a redundant null/fd check in kvm_close() that
  can never be true once the early-return guard at function entry
  has already passed.

- Patch 2 fixes an off-by-one in kvm_irqchip_release_virq(): after
  a swap-remove the newly placed entry at the same index was never
  re-examined, so a duplicate GSI could be silently left in the
  routing table.

Bin Guo (2):
  kvm: remove redundant check in kvm_close
  kvm: fix kvm_irqchip_release_virq loop after swap-remove

 accel/kvm/kvm-all.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.50.1 (Apple Git-155)


