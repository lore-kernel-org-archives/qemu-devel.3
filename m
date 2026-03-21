Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59024109448A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3yXy-00038I-Bn; Sat, 21 Mar 2026 11:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXw-000371-KW; Sat, 21 Mar 2026 11:47:28 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXr-0003JS-Mr; Sat, 21 Mar 2026 11:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cx
 21vK8P1BNjV2qDbmfSpzwVgQiFgi6UJDWSGIOBAAo=; b=NKL45L+qOzDPS4QZNW
 auWZeMvUGsSJEhDbEtNCfjR5+gMVAzTW5LoPUx6+lPlux2ZRJiImGs63/3YnwYbp
 No0zDOtYXPTwvssl9599Z8KmxDQ+PzCLgDnhof9qHjokiHtijsyuhIeflvy/F4/6
 XATsxpQ3jYQXWq/v/vRI0Lb0U=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAH9XF2vb5p1YbwTQ--.2111S7;
 Sat, 21 Mar 2026 23:47:05 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 5/5] PL080 add transfer memory and peripheral
Date: Sat, 21 Mar 2026 23:47:00 +0800
Message-ID: <6ade608e668d8fb9e720639333a48120bb814d41.1774099044.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1774099044.git.dingtao0430@163.com>
References: <cover.1774099044.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAH9XF2vb5p1YbwTQ--.2111S7
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFWkWFWUXF45Zryktr4ruFg_yoW7KFW5pF
 ZxGr1Syr1aqFn3Jrs3tw4FqFn8Ja1vg347WrW3KwnxAws0yry5ZF1kJ347Ar4Ygrs3Za15
 Ca95GFWUuw42vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3PEhUUUUU=
X-Originating-IP: [101.204.36.117]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4RmX1Wm+vXmNsQAA3V
Received-SPF: pass client-ip=220.197.31.3; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On the interface, 0~15 represents single request, 16~31 represents burst request.
Access peripheral data based on the validity of the request. For the convenience, 
we only respond to single requests. The number of data read from the source and written 
to the destination is always equal, with a value of max(swidth, dwidth).

Due to the lack of data preparation by the peripheral, it is necessary to cache data separately 
for each channel until the peripheral is ready for processing.

The width of peripherals perhaps not possible to process all data at once, 
so continuous processing is required. Read from source is achieved through "continue", 
while writing to destination is achieved through "goto".

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/dma/pl080.c         | 105 +++++++++++++++++++++++++++++++++++------
 include/hw/dma/pl080.h |   4 ++
 2 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 3596739854..c40364de44 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -88,6 +88,13 @@ static void pl080_update(PL080State *s)
     qemu_set_irq(s->irq, errlevel || tclevel);
 }
 
+static void pl080_clr_req(PL080State *s, int req_index)
+{
+    s->req_single &= ~(1 << req_index);
+    s->req_burst &= ~(1 << req_index);
+    qemu_set_irq(s->clear_req_irq[req_index], 1);
+}
+
 static void pl080_run(PL080State *s)
 {
     int c;
@@ -100,7 +107,7 @@ static void pl080_run(PL080State *s)
     int src_id;
     int dest_id;
     int size;
-    uint8_t buff[4];
+    uint8_t *buff;
     uint32_t req;
     uint32_t next_lli;
 
@@ -125,6 +132,7 @@ static void pl080_run(PL080State *s)
     while (s->running) {
         for (c = 0; c < s->nchannels; c++) {
             ch = &s->chan[c];
+            buff = ch->buff;
 again:
             /* Test if thiws channel has any pending DMA requests.  */
             if ((ch->conf & (PL080_CCONF_H | PL080_CCONF_E))
@@ -179,23 +187,64 @@ again:
                               c, extract32(ch->ctrl, 21, 3));
                 continue;
             }
+            xsize = MAX(swidth, dwidth);
+            if (ch->continue_write) {
+                goto continue_write;
+            }
 
-            for (n = 0; n < dwidth; n+= swidth) {
-                address_space_read(&s->downstream_as, ch->src,
-                                   MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
-                if (ch->ctrl & PL080_CCTRL_SI)
-                    ch->src += swidth;
+            if (flow & (1 << 1)) { /*source is peripheral*/
+                if (s->req_single & (1 << src_id)) {
+                    address_space_read(&s->downstream_as, ch->src,
+                            MEMTXATTRS_UNSPECIFIED, buff + ch->buff_remain, swidth);
+                    if (ch->ctrl & PL080_CCTRL_SI) {
+                        ch->src += swidth;
+                    }
+                    ch->buff_remain += swidth;
+                    pl080_clr_req(s, src_id);
+                }
+            } else { /*source is memory*/
+                for (n = 0; n < xsize; n += swidth) {
+                    address_space_read(&s->downstream_as, ch->src,
+                            MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
+                    if (ch->ctrl & PL080_CCTRL_SI) {
+                        ch->src += swidth;
+                    }
+                }
+                ch->buff_remain += xsize;
             }
-            xsize = (dwidth < swidth) ? swidth : dwidth;
-            /* ??? This may pad the value incorrectly for dwidth < 32.  */
-            for (n = 0; n < xsize; n += dwidth) {
-                address_space_write(&s->downstream_as, ch->dest + n,
-                                    MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
-                if (ch->ctrl & PL080_CCTRL_DI)
-                    ch->dest += swidth;
+            if (ch->buff_remain != xsize) {
+                continue;
+            }
+
+continue_write:
+            if (flow & 1) { /*destination is peripheral*/
+                if (s->req_single & (1 << dest_id)) {
+                    address_space_write(&s->downstream_as, ch->dest,
+                        MEMTXATTRS_UNSPECIFIED, buff + xsize - ch->buff_remain, dwidth);
+                    if (ch->ctrl & PL080_CCTRL_DI) {
+                        ch->dest += dwidth;
+                    }
+                    ch->buff_remain -= dwidth;
+                    pl080_clr_req(s, dest_id);
+                }
+            } else { /*destination is memory*/
+                for (n = 0; n < xsize; n += dwidth) {
+                    address_space_write(&s->downstream_as, ch->dest,
+                                        MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
+                    if (ch->ctrl & PL080_CCTRL_DI) {
+                        ch->dest += dwidth;
+                    }
+                }
+                ch->buff_remain -= xsize;
+            }
+            if (ch->buff_remain != 0) {
+                ch->continue_write = true;
+                continue;
+            } else {
+                ch->continue_write = false;
             }
 
-            size--;
+            size -= xsize / swidth;
             ch->ctrl = (ch->ctrl & 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
@@ -370,6 +419,27 @@ static void pl080_write(void *opaque, hwaddr offset,
     pl080_update(s);
 }
 
+static void pl080_dma_request_handler(void *opaque, int n, int level)
+{
+    PL080State *s = PL080(opaque);
+    if (level == 0) {
+        if (n < 16) {
+            s->req_single &= ~(1 << n);
+        } else {
+            s->req_burst &= ~(1 << (n - 16));
+        }
+    } else {
+        if (n < 16 && (s->req_single & (1 << n)) == 0) {
+            s->req_single |= (1 << n);
+            qemu_bh_schedule(s->bh);
+        }
+        if (n >= 16 && (s->req_burst & (1 << (n - 16)))) {
+            s->req_burst |= (1 << (n - 16));
+            qemu_bh_schedule(s->bh);
+        }
+    }
+}
+
 static const MemoryRegionOps pl080_ops = {
     .read = pl080_read,
     .write = pl080_write,
@@ -397,6 +467,8 @@ static void pl080_reset(DeviceState *dev)
         s->chan[i].lli = 0;
         s->chan[i].ctrl = 0;
         s->chan[i].conf = 0;
+        s->chan[i].buff_remain = 0;
+        s->chan[i].continue_write = false;
     }
 }
 
@@ -404,12 +476,17 @@ static void pl080_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PL080State *s = PL080(obj);
+    int i;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &pl080_ops, s, "pl080", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
     sysbus_init_irq(sbd, &s->interr);
     sysbus_init_irq(sbd, &s->inttc);
+    for (i = 0; i < ARRAY_SIZE(s->clear_req_irq); i++) {
+        sysbus_init_irq(sbd, &s->clear_req_irq[i]);
+    }
+    qdev_init_gpio_in(DEVICE(obj), pl080_dma_request_handler, 32);
     s->nchannels = 8;
     s->bh = qemu_bh_new(pl080_run_cb, s);
 }
diff --git a/include/hw/dma/pl080.h b/include/hw/dma/pl080.h
index 397417aa06..4511b92900 100644
--- a/include/hw/dma/pl080.h
+++ b/include/hw/dma/pl080.h
@@ -41,6 +41,9 @@ typedef struct {
     uint32_t lli;
     uint32_t ctrl;
     uint32_t conf;
+    uint32_t buff_remain;
+    bool continue_write;
+    uint8_t buff[4];
 } pl080_channel;
 
 #define TYPE_PL080 "pl080"
@@ -66,6 +69,7 @@ struct PL080State {
     qemu_irq irq;
     qemu_irq interr;
     qemu_irq inttc;
+    qemu_irq clear_req_irq[16];
 
     MemoryRegion *downstream;
     AddressSpace downstream_as;
-- 
2.43.0


