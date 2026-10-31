Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3C606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BC2G+Ore
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35h-0007Qu-8w; Sat, 31 Oct 2026 03:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN34H-0003Pk-DW
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN34F-0002zW-I7
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTAQH2JAsr1teBYXLPYG0HwaZpmyK7N6NRvRatA5XZM=;
 b=BC2G+Ore3XK3Mc17qZD7tmdmKTJqBezQ9+SIDy6J3m9Xu9C8y52uE0SLmWJtzL8QTW8U83
 v9jaFDpHWgUt46CiFKYDgVtbySXsu9OD4f8D3/abJN/cLXRhPAy0K/YoG6iFb08fzUg167
 8Z4G7ciEOIbRaXRF3QtmXmnIfHLO8gY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-vw6A9PmuP96kCz5cy697Gw-1; Sat,
 31 Oct 2026 02:59:44 -0400
X-MC-Unique: vw6A9PmuP96kCz5cy697Gw-1
X-Mimecast-MFC-AGG-ID: vw6A9PmuP96kCz5cy697Gw_1793429983
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 886A7195609E; Sat, 31 Oct 2026 06:59:43 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D42381803A40; Sat, 31 Oct 2026 06:59:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/34] hw/rtc: ds1338: parameterise the register map via a
 device class
Date: Sat, 31 Oct 2026 07:58:23 +0100
Message-ID: <20261031065823.191966-35-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Emmanuel Blot <emmanuel.blot@free.fr>

In preparation for a register-compatible variant, refactor DS1338
register map. Introduce DS1338Class, carrying the register-pointer wrap
boundary and the control/OSF register location and masks, and drive
inc_regptr() and the control-register handling.

The control-register power-on value is parameterised along with them,
so the part comes up holding the contents its datasheet specifies
rather than zero, and its oscillator-stop flag now reads set at
power-on.

Encode the year register modulo 100 (tm_year % 100) instead of
tm_year - 100.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20261015-bmc-minerva-v3-12-7d50c8a108e5@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/rtc/ds1338.c | 71 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 1755a3a37c1d..7eaa6631137a 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -30,7 +30,14 @@
 #define HOURS_PM   0x20
 #define CTRL_OSF   0x20
 
-OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
+/* DS1338 register map */
+#define DS1338_NUM_REGS    NVRAM_SIZE   /* 0x00..0x3f, then wraps */
+#define DS1338_CONTROL     0x07
+#define DS1338_CTRL_MASK   0xb3         /* bits 2, 3 and 6 read back as zero */
+/* POR: OUT, OSF, SQWE and both rate-select bits come up set. */
+#define DS1338_CTRL_RESET  0xb3
+
+OBJECT_DECLARE_TYPE(DS1338State, DS1338Class, DS1338)
 
 struct DS1338State {
     I2CSlave parent_obj;
@@ -42,6 +49,17 @@ struct DS1338State {
     bool addr_byte;
 };
 
+struct DS1338Class {
+    I2CSlaveClass parent_class;
+
+    uint8_t num_regs;       /* register-pointer wrap boundary */
+    uint8_t ctrl_addr;      /* control register address */
+    uint8_t ctrl_mask;      /* writable/read-back bits of the control reg */
+    uint8_t osf_addr;       /* register holding the OSF flag */
+    uint8_t osf_mask;       /* OSF bit within osf_addr */
+    uint8_t ctrl_reset;     /* control-register power-on value */
+};
+
 static const VMStateDescription vmstate_ds1338 = {
     .name = "ds1338",
     .version_id = 2,
@@ -82,16 +100,19 @@ static void ds1338_capture_current_time(DS1338State *s)
     s->nvram[3] = (now.tm_wday + s->wday_offset) % 7 + 1;
     s->nvram[4] = to_bcd(now.tm_mday);
     s->nvram[5] = to_bcd(now.tm_mon + 1);
-    s->nvram[6] = to_bcd(now.tm_year - 100);
+    s->nvram[6] = to_bcd(now.tm_year % 100);
 }
 
 static void ds1338_inc_regptr(DS1338State *s)
 {
-    /* The register pointer wraps around after 0x3F; wraparound
-     * causes the current time/date to be retransferred into
-     * the secondary registers.
+    DS1338Class *k = DS1338_GET_CLASS(s);
+
+    /*
+     * The register pointer wraps around after the last register; wraparound
+     * causes the current time/date to be retransferred into the secondary
+     * registers.
      */
-    s->ptr = (s->ptr + 1) & (NVRAM_SIZE - 1);
+    s->ptr = (s->ptr + 1) % k->num_regs;
     if (!s->ptr) {
         ds1338_capture_current_time(s);
     }
@@ -136,11 +157,12 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
 static int ds1338_send(I2CSlave *i2c, uint8_t data)
 {
     DS1338State *s = DS1338(i2c);
+    DS1338Class *k = DS1338_GET_CLASS(i2c);
 
     trace_ds1338_send(s->ptr, data);
 
     if (s->addr_byte) {
-        s->ptr = data & (NVRAM_SIZE - 1);
+        s->ptr = data % k->num_regs;
         s->addr_byte = false;
         return 0;
     }
@@ -190,18 +212,19 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
             break;
         }
         s->offset = qemu_timedate_diff(&now);
-    } else if (s->ptr == 7) {
-        /* Control register. */
-
-        /* Ensure bits 2, 3 and 6 will read back as zero. */
-        data &= 0xB3;
-
-        /* Attempting to write the OSF flag to logic 1 leaves the
-           value unchanged. */
-        data = (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OSF);
-
-        s->nvram[s->ptr] = data;
     } else {
+        if (s->ptr == k->ctrl_addr) {
+            /* Control register: reserved bits read back as zero. */
+            data &= k->ctrl_mask;
+        }
+        if (s->ptr == k->osf_addr) {
+            /*
+             * Attempting to write the OSF flag to logic 1 leaves the
+             * value unchanged.
+             */
+            data = (data & ~k->osf_mask) |
+                   (data & s->nvram[s->ptr] & k->osf_mask);
+        }
         s->nvram[s->ptr] = data;
     }
     ds1338_inc_regptr(s);
@@ -211,11 +234,13 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
 static void ds1338_reset_hold(Object *obj, ResetType type)
 {
     DS1338State *s = DS1338(obj);
+    DS1338Class *k = DS1338_GET_CLASS(s);
 
     /* The clock is running and synchronized with the host */
     s->offset = 0;
     s->wday_offset = 0;
     memset(s->nvram, 0, NVRAM_SIZE);
+    s->nvram[k->ctrl_addr] = k->ctrl_reset;
     s->ptr = 0;
     s->addr_byte = false;
 }
@@ -225,12 +250,21 @@ static void ds1338_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DS1338Class *dsc = DS1338_CLASS(klass);
 
     k->event = ds1338_event;
     k->recv = ds1338_recv;
     k->send = ds1338_send;
     rc->phases.hold = ds1338_reset_hold;
+    dc->desc = "DS1338 I2C RTC with 56-byte NV RAM";
     dc->vmsd = &vmstate_ds1338;
+
+    dsc->num_regs   = DS1338_NUM_REGS;
+    dsc->ctrl_addr  = DS1338_CONTROL;
+    dsc->ctrl_mask  = DS1338_CTRL_MASK;
+    dsc->osf_addr   = DS1338_CONTROL;
+    dsc->osf_mask   = CTRL_OSF;
+    dsc->ctrl_reset = DS1338_CTRL_RESET;
 }
 
 static const TypeInfo ds1338_types[] = {
@@ -238,6 +272,7 @@ static const TypeInfo ds1338_types[] = {
         .name          = TYPE_DS1338,
         .parent        = TYPE_I2C_SLAVE,
         .instance_size = sizeof(DS1338State),
+        .class_size    = sizeof(DS1338Class),
         .class_init    = ds1338_class_init,
     },
 };
-- 
2.56.0


