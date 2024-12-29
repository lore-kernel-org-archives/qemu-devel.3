Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A5EE7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhY-0006Zz-NU; Sun, 29 Dec 2024 02:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhW-0006ZV-SP
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:02 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhV-0002AN-Ak
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:02 -0500
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so14962948a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457220; x=1736062020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugCxO5yyfagZMYJJ0uCQVVshXi6/5tCw+NNyfH9jYgU=;
 b=Tie90xGxCM2P1xRO3U+uTJ7KwFLM9/87bWQbd/OXjP1dTmDzYNG/sCpSa1qlef/5W0
 JjvHg0hm5G9gW2yLz9PKrlodeQT1GOiqdQHiOUs6T1RlV/oSrX6ngrEoXuUjIDCMM2gK
 XeCWr0kfJszzO26rtuvXA/r6nVG7h7QOagyND3oj5vNqyGU48GPSzEHlwXRdjKEychfh
 IVLLZLTfB9c2+s8c6I+QGmWID300Kh9jzIsvoXHzKZE3LfvLw/DCWnShpCy/Xr5o0qrq
 dlKqLl2fVMQs5Y7tvouKneuc94N9cS0VbhKwTYF+hH+WdM+u7osUfCmL7XtG+Du6eAcw
 ogLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5hXIzlLLfEy8JJE8slbtA9d8p5Lulmt3nvp8ADH9qYOEaW7tfTflVEV7vl8hNWZr41ZsVHgUkPEzR@nongnu.org
X-Gm-Message-State: AOJu0YxLxG5nIBDj/xOkvx4kL4SRQRx9sjtqArbMDsSOtKdEG3Qm1cAh
 EDNoM6dYYtwz48n9vKLtDWwYAmDHGCrJgxvPgpOgbeLjGOu896Vu
X-Gm-Gg: ASbGnct6/WB1ldV2edAA2b3i0vZTKAiA8FDepY0AZDujt7NiQQrasnLDb86teL8xNYt
 vOzfFS6kUqMXb2FM2GIWQLkhSoaKbYyRj3UMTWzYye4Yq+ePD7HLtf2TdTzi/PNxUnVzuy/anVY
 HHtZMUaGxwi6kRTWerXS4OVg40Z+n6gnQa6a6P/37sP8vPMXmSIZqlQzWnngUW91B5oRWhUCkcd
 3pI/6QtG5W/ETM/OebKUzWyj86JsaTAUtPAi3P15N44M2zHQAUmoHwgLcQpeSfkVH4UnWHTCr2R
 CvM=
X-Google-Smtp-Source: AGHT+IHTlG2ku5V9n8ZwEEieZpP4YxaEaTl9G3h/EkOCzB2Crmqi8XkXCn7RpBVj90ubZg0r1kCtxQ==
X-Received: by 2002:a17:907:c1d:b0:aae:ccbe:993d with SMTP id
 a640c23a62f3a-aaeccbe9ac9mr2240794266b.35.1735457219550; 
 Sat, 28 Dec 2024 23:26:59 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:58 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 14/35] next-cube: move timer MMIO to separate memory region on
 next-pc device
Date: Sun, 29 Dec 2024 08:25:05 +0100
Message-ID: <20241229072526.166555-15-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.53; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f53.google.com
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

Move the timer MMIO accesses to a separate memory region on the next-pc device
instead of being part of the next.scr MMIO memory region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241222130012.1013374-13-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 63 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9f49c33bdd..ba468ce922 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -109,6 +109,7 @@ struct NeXTPC {
     M68kCPU *cpu;
 
     MemoryRegion floppy_mem;
+    MemoryRegion timer_mem;
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
 
@@ -371,17 +372,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    /*
-     * These 4 registers are the hardware timer, not sure which register
-     * is the latch instead of data, but no problems so far.
-     *
-     * Hack: We need to have the LSB change consistently to make it work
-     */
-    case 0x1a000 ... 0x1a003:
-        val = extract32(clock(), (4 - (addr - 0x1a000) - size) << 3,
-                        size << 3);
-        break;
-
     /* For now return dummy byte to allow the Ethernet test to timeout */
     case 0x6000:
         val = 0xff;
@@ -400,8 +390,6 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size)
 {
     switch (addr) {
-    /* Hardware timer latch - not implemented yet */
-    case 0x1a000:
     default:
         DPRINTF("BMAP Write @ 0x%x with 0x%"PRIx64 " size %u\n",
                 (unsigned int)addr, val, size);
@@ -980,6 +968,50 @@ static const MemoryRegionOps next_floppy_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_timer_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    switch (addr) {
+    case 0 ... 3:
+        /* Hardware timer latch - not implemented yet */
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t next_timer_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+
+    switch (addr) {
+    case 0 ... 3:
+        /*
+         * These 4 registers are the hardware timer, not sure which register
+         * is the latch instead of data, but no problems so far.
+         *
+         * Hack: We need to have the LSB change consistently to make it work
+         */
+        val = extract32(clock(), (4 - addr - size) << 3,
+                        size << 3);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return val;
+}
+
+static const MemoryRegionOps next_timer_ops = {
+    .read = next_timer_read,
+    .write = next_timer_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void next_pc_reset(DeviceState *dev)
 {
     NeXTPC *s = NEXT_PC(dev);
@@ -1042,6 +1074,8 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->scrmem, 0x18000,
                                 sysbus_mmio_get_region(sbd, 0));
 
+    /* Timer */
+    memory_region_add_subregion(&s->scrmem, 0x1a000, &s->timer_mem);
 }
 
 static void next_pc_init(Object *obj)
@@ -1065,6 +1099,9 @@ static void next_pc_init(Object *obj)
                           "next.floppy", 4);
 
     object_initialize_child(obj, "escc", &s->escc, TYPE_ESCC);
+
+    memory_region_init_io(&s->timer_mem, OBJECT(s), &next_timer_ops, s,
+                          "next.timer", 4);
 }
 
 /*
-- 
2.47.1


