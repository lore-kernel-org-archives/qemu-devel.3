Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5629D1094489
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3yY7-0003Ax-4G; Sat, 21 Mar 2026 11:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yY5-0003Ae-9F; Sat, 21 Mar 2026 11:47:37 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yY3-0003Lf-CX; Sat, 21 Mar 2026 11:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cP
 vkD9l8vo5ePWISaGJTwNeqok2VlUfjWRVPVugfjSI=; b=piT+ybwstmT2vak6Ld
 J8L52PF52ehEjQEoRbI91lWdQt46AESl4lHjl1R1kB7iLRXccHhLp74ek0IbTEG8
 JHNMD/JcQsPsYtRwQ9TIcTHs1x/vWKPwSr/HdC3q3fM2B7e9CUJLiUbj9I/hIEGb
 VOouXPg7UM9L/Ap+yCDe12iyY=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAH9XF2vb5p1YbwTQ--.2111S6;
 Sat, 21 Mar 2026 23:47:05 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 4/5] Run pl080_run in main loop
Date: Sat, 21 Mar 2026 23:46:59 +0800
Message-ID: <97fc49242d026d0784ee31816a3561dc6b316c8e.1774099044.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1774099044.git.dingtao0430@163.com>
References: <cover.1774099044.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAH9XF2vb5p1YbwTQ--.2111S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4xuw4DCrWrZr4kWw47CFg_yoW8urW8pr
 WkuF15uFWUtF1UGa90kw1xKF15Jan7WrW5ZFWfC3sayrZ0yF1kAFykX343KrWxJrZ7Zr45
 urWYqFW7GF4jvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3Ma5UUUUU=
X-Originating-IP: [101.204.36.117]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4hmX1Wm+vXnWVAAA3o
Received-SPF: pass client-ip=220.197.31.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Accessing MMIO in QEMU will trigger pl080_run. If it is a memory to memory data transfer, 
it is generally faster, so it will not significantly block vCPU. But when dealing with peripherals, 
time is uncontrollable because it is unknown when the peripherals will generate data. 
This will result in continuous blocking of vCPU. 

Due to the presence of BQL in qemu, mmio access and bh callbacks are safty.

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/dma/pl080.c         | 11 +++++++++--
 include/hw/dma/pl080.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 627ccbbd81..3596739854 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -232,6 +232,12 @@ again:
     pl080_update(s);
 }
 
+static void pl080_run_cb(void *opaque)
+{
+    PL080State *s = PL080(opaque);
+    pl080_run(s);
+}
+
 static uint64_t pl080_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -326,7 +332,7 @@ static void pl080_write(void *opaque, hwaddr offset,
             break;
         case 4: /* Configuration */
             s->chan[i].conf = value;
-            pl080_run(s);
+            qemu_bh_schedule(s->bh);
             break;
         }
         return;
@@ -351,7 +357,7 @@ static void pl080_write(void *opaque, hwaddr offset,
             qemu_log_mask(LOG_UNIMP,
                           "pl080_write: Big-endian DMA not implemented\n");
         }
-        pl080_run(s);
+        qemu_bh_schedule(s->bh);
         break;
     case 13: /* Sync */
         s->sync = value;
@@ -405,6 +411,7 @@ static void pl080_init(Object *obj)
     sysbus_init_irq(sbd, &s->interr);
     sysbus_init_irq(sbd, &s->inttc);
     s->nchannels = 8;
+    s->bh = qemu_bh_new(pl080_run_cb, s);
 }
 
 static void pl080_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/dma/pl080.h b/include/hw/dma/pl080.h
index 6635cd8e93..397417aa06 100644
--- a/include/hw/dma/pl080.h
+++ b/include/hw/dma/pl080.h
@@ -31,6 +31,7 @@
 
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
+#include "qemu/main-loop.h"
 
 #define PL080_MAX_CHANNELS 8
 
@@ -68,6 +69,8 @@ struct PL080State {
 
     MemoryRegion *downstream;
     AddressSpace downstream_as;
+
+    QEMUBH *bh;
 };
 
 #endif
-- 
2.43.0


