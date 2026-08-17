Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67CFC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtKY-0007Yj-15; Mon, 17 Aug 2026 05:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtJg-0004rM-Jx; Mon, 17 Aug 2026 05:07:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtJe-0001wq-TI; Mon, 17 Aug 2026 05:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=nLOBd6qmhI9qHAWdEEcaXA/9sF1TdPCH8cF+8kL5n54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XAJsQWaEe8XUvHDvIRmTkJRGI/TbVGVVGxU+ZnkiKyysmX/QigVsWDpcwS3cGi74C
 G6VE0OCd7+fB8NhKKnx0E5QAidTfzLMXDCeWTw0snUu8GImAuh7vqAnGdcEvHv5Rhg
 pDEBJnaEJ6ukYHvOo7GZTluMviWaUJxjqtrX7tHfutONmzxMqS8JOJDa2P6k/ROHoI
 feqS7vDlvpyKa+M1KxcstM0XGV37kNTH2IaIzqUfGckZFvk9krYRmfSLjqL6PcR0R0
 edOrze+GTozwZZtWKPeWTkvAQmFBtvKM8UuJFF3+S+psjYqAc56L/aO8RyYzCxSzAF
 AT9hVkpksSznA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 73CAA1CBA4F;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5328640D031;
 Mon, 17 Aug 2026 12:05:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EF7C030D16; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Guo <guobin@linux.alibaba.com>,
 Bibo Mao <maobibo@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 27/42] hw/intc/loongarch_pch_pic: Validate
 htmsi_vector before indexing parent_irq
Date: Mon, 17 Aug 2026 12:04:32 +0300
Message-ID: <20260817090453.2034156-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

pch_pic_update_irq() used the guest-writable htmsi_vector[irq] value as an
index into parent_irq[] without checking bounds.  A value >= irq_num (64 in
the array, but only 32 are used by the virt machine) causes an out-of-bounds
read and a guest-triggerable QEMU crash.

Validate the vector before calling qemu_set_irq() in both the raise and lower
paths and log a guest error if it is out of range.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4114
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
(cherry picked from commit 80776c4df92c3d58f89608b61e355092a7d524ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 82e16be3918..e87c7497c11 100644
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
2.47.3


