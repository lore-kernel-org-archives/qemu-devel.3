Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAA8E77192
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhZ-0006a9-Bj; Sun, 29 Dec 2024 02:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhY-0006Zj-9z
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:04 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhW-0002AT-Pu
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:04 -0500
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1187748466b.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457221; x=1736062021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCDyP0HU91an/SgNVURIRYR9ahqGS4imiUg5gQkD/5Q=;
 b=dx39hVDsKi/5qkhT+B7P1UDdVUU/msb+y3X2rM5ayIbHXfD+cb5uYr/gQJVSlwPYsC
 5uW3o/YXYdNvtaHGES029OQSevasdKoUTXmv7/jNLz5Uz3+XRYrhnL/J6aHrTeYheYYc
 A0VOUawcAFZg4OPlFAiyhaFMuCsOE4lEAIORM6xOIEe4asB0AlCowtZwYMDm+mnnIeEj
 MYjlh+PBlSEtna0UmkdMcZnBnFmePB+Qr8n5CHTEzAoswWeMUkqJB68alvhl/DR8ddIU
 kPe5poQNYE1lFzSm1Zz/5UfdRAGBaFaXRGzsOWziMtyPTCaaVxMmQmAOosw5AKPyBHmG
 rfMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjOHGprI1MWy2WxHoeu6+1WJjyGTxO1ddayyL0iVpA6hZpfRsI3q6fv4Pjd23ISsinb559nbCI1hMr@nongnu.org
X-Gm-Message-State: AOJu0YxrUonqEQtJ3EKBVGcJk7zgRJTuaksH2EBPyfWA5z+Q21wfJh/Z
 WcGVL5Tn1hoIjPo71KMw3y9poMIRqDXzpbDxgCcfXL3y68TO8DPfDOHTfg==
X-Gm-Gg: ASbGncsuelZi7PY6DjbEjTPWpF9jgO0nuavu/xuOexI1L/A1D+F17ggFN2ySTmZVVkT
 GKuGgnw7+a1utvWow6gf7Oj+Fqs2OiX0Yr7rntz78RENXBVWBaHhLqPzepE5eTVUEaxnXPir+mc
 KEB7lYtUSiMva/JamGCpDmRuzDiuBtlGffb6xJyn/mTf8rtALJIoaZA0B6peoPQh3zLQyku+cBN
 sF1D5RSRtcrSG9jz5D0XLLjqC1DO7EanSjYz9DvO+xE8ZLMVt/9QvZKfiRtRMXNSZBgO43L7Bxl
 Fmw=
X-Google-Smtp-Source: AGHT+IFYeGWG/ZAMES4LwkvoOFO8eWlzW+G2WkuBc11XqDj5bj8NWcbfZLzxMX6GstxmDbWxSdREBw==
X-Received: by 2002:a17:907:96a0:b0:aa6:7feb:193f with SMTP id
 a640c23a62f3a-aac2ad81a25mr3086979766b.20.1735457221313; 
 Sat, 28 Dec 2024 23:27:01 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:00 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 15/35] next-cube: move en ethernet MMIO to separate memory
 region on next-pc device
Date: Sun, 29 Dec 2024 08:25:06 +0100
Message-ID: <20241229072526.166555-16-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Move the en ethernet MMIO accesses to a separate memory region on the next-pc
device instead of being part of the next.scr MMIO memory region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-14-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 48 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index ba468ce922..97a6f6c472 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -110,6 +110,7 @@ struct NeXTPC {
 
     MemoryRegion floppy_mem;
     MemoryRegion timer_mem;
+    MemoryRegion dummyen_mem;
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
 
@@ -372,11 +373,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    /* For now return dummy byte to allow the Ethernet test to timeout */
-    case 0x6000:
-        val = 0xff;
-        break;
-
     default:
         DPRINTF("BMAP Read @ 0x%x size %u\n", (unsigned int)addr, size);
         val = 0;
@@ -1012,6 +1008,38 @@ static const MemoryRegionOps next_timer_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_dummy_en_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    /* Do nothing */
+    return;
+}
+
+static uint64_t next_dummy_en_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+
+    switch (addr) {
+    case 0:
+        /* For now return dummy byte to allow the Ethernet test to timeout */
+        val = 0xff;
+        break;
+
+    default:
+        val = 0;
+    }
+
+    return val;
+}
+
+static const MemoryRegionOps next_dummy_en_ops = {
+    .read = next_dummy_en_read,
+    .write = next_dummy_en_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void next_pc_reset(DeviceState *dev)
 {
     NeXTPC *s = NEXT_PC(dev);
@@ -1034,6 +1062,10 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     DeviceState *d;
 
+    /* en network (dummy) */
+    memory_region_add_subregion(&s->scrmem, 0x6000,
+                                &s->dummyen_mem);
+
     /* SCSI */
     sbd = SYS_BUS_DEVICE(&s->next_scsi);
     if (!sysbus_realize(sbd, errp)) {
@@ -1093,6 +1125,9 @@ static void next_pc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
 
+    memory_region_init_io(&s->dummyen_mem, OBJECT(s), &next_dummy_en_ops, s,
+                          "next.en", 0x20);
+
     object_initialize_child(obj, "next-scsi", &s->next_scsi, TYPE_NEXT_SCSI);
 
     memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
@@ -1238,9 +1273,6 @@ static void next_cube_init(MachineState *machine)
         }
     }
 
-    /* TODO: */
-    /* Network */
-
     /* DMA */
     memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
                           "next.dma", 0x5000);
-- 
2.47.1


