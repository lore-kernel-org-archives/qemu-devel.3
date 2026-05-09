Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99044CD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 02:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLXi6-0007ti-9F; Fri, 08 May 2026 22:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wLXhj-0007sW-R8
 for qemu-devel@nongnu.org; Fri, 08 May 2026 22:46:16 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wLXhg-0003Cp-T7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 22:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778294761; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=bOHocsDjBbGwePHYMHf0XP/MmULd8FxzUFtMETBjpTg=;
 b=mhlyFTt7mQJTflIDK6VsjxnLBHECPgoegRyHOayuazip2kIf2i01YWdl0gByYce3xJSdgbRigkPwCdNGXVPBJQxR2YGNsZWr68kNQqHhTXZGpeMBrF9pSKywddCB0wxivLblgzWFS7Ce4lf/NwVEREIvpBejhPAruqr0JEoZn/4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X2Z4CJH_1778294755; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X2Z4CJH_1778294755 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 09 May 2026 10:46:01 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org
Subject: [PATCH 2/2] kvm: fix kvm_irqchip_release_virq loop after swap-remove
Date: Sat,  9 May 2026 10:45:39 +0800
Message-ID: <20260509024539.90998-3-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260509024539.90998-1-guobin@linux.alibaba.com>
References: <20260509024539.90998-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=guobin@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
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

In kvm_irqchip_release_virq(), when an entry matching the target GSI is
found, the code removes it by swapping in the last entry:

    s->irq_routes->nr--;
    *e = s->irq_routes->entries[s->irq_routes->nr];

However, the loop then increments `i` unconditionally, which means the
newly-swapped entry at position `i` is never re-checked. If that entry
also has `gsi == virq`, it will be skipped and left in the routing
table.

Fix this by decrementing `i` after the swap, so the same index is
re-examined in the next iteration.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 70bc2c86a2..3c5b62c97e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2278,6 +2278,7 @@ void kvm_irqchip_release_virq(KVMState *s, int virq)
         if (e->gsi == virq) {
             s->irq_routes->nr--;
             *e = s->irq_routes->entries[s->irq_routes->nr];
+            i--;
         }
     }
     clear_gsi(s, virq);
-- 
2.50.1 (Apple Git-155)


