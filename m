Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E646C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9gA-0007hj-VK; Tue, 04 Aug 2026 03:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wr9g7-0007hN-Dv; Tue, 04 Aug 2026 03:35:11 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wr9g1-0002XS-LT; Tue, 04 Aug 2026 03:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785828888; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=ghYyasCtF8FEQCbtw+bhe9K0ie0uWwUdVzgB8nhIMt4=;
 b=Jvur6lQND80tFPB9eirgCuT1bjh1PJ/yUYap5aFsajHcI8CYGNqzeorLngAW92DJcHjKvas06atpVg4U9GhWBnI0ECT/PiRg1Ky5X/ilvW79LRAlC7uuyNPGxXEBuF1h0H52aiRqeMGIMTFl4oJngH5MGyByKQbAw4w9NiZdYU0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X8N7IzC_1785828886; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X8N7IzC_1785828886 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 04 Aug 2026 15:34:47 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/intc/loongarch_pch_pic: Validate htmsi_vector before
 indexing parent_irq
Date: Tue,  4 Aug 2026 15:34:45 +0800
Message-ID: <20260804073445.55612-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

pch_pic_update_irq() used the guest-writable htmsi_vector[irq] value as an
index into parent_irq[] without checking bounds.  A value >= irq_num (64 in
the array, but only 32 are used by the virt machine) causes an out-of-bounds
read and a guest-triggerable QEMU crash.

Validate the vector before calling qemu_set_irq() in both the raise and lower
paths and log a guest error if it is out of range.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4114
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/intc/loongarch_pch_pic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 82e16be391..e87c7497c1 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -19,13 +19,21 @@ static void pch_pic_update_irq(LoongArchPICCommonState *s, uint64_t mask,
 {
     uint64_t val;
     int irq;
+    uint8_t vector;
 
     if (level) {
         val = mask & s->intirr & ~s->int_mask;
         if (val) {
             irq = ctz64(val);
+            vector = s->htmsi_vector[irq];
+            if (vector >= s->irq_num) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: htmsi_vector[%d]=%u out of range\n",
+                              __func__, irq, vector);
+                return;
+            }
             s->intisr |= MAKE_64BIT_MASK(irq, 1);
-            qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 1);
+            qemu_set_irq(s->parent_irq[vector], 1);
         }
     } else {
         /*
@@ -35,8 +43,15 @@ static void pch_pic_update_irq(LoongArchPICCommonState *s, uint64_t mask,
         val = mask & s->intisr & ~s->intirr;
         if (val) {
             irq = ctz64(val);
+            vector = s->htmsi_vector[irq];
+            if (vector >= s->irq_num) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: htmsi_vector[%d]=%u out of range\n",
+                              __func__, irq, vector);
+                return;
+            }
             s->intisr &= ~MAKE_64BIT_MASK(irq, 1);
-            qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 0);
+            qemu_set_irq(s->parent_irq[vector], 0);
         }
     }
 }
-- 
2.50.1 (Apple Git-155)


