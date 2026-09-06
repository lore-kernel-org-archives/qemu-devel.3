Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8E4C79FA0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GPA-00042d-VZ; Sun, 06 Sep 2026 13:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GP3-0003u4-M6
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GP1-0000Fx-C7
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zng3yvZnvGkqWtEbC93m6nc/2z4AtNb3koJD//ggOk8=;
 b=i4bE6iZCi69PmZi48Z36NBTzo+D87DAXhKn9y7sLUfBAriTbeJaxEGrVNNt20m6jKIvxMN
 hgLGNg/zY6Gym1wZ4HTpGzWAYeikEHG2T+skH9yWcA/w0MsApwyTcPc9DRTLw5yALdY+jg
 mHfTNNc5tMFvJHFmJLkdFSVP4ST9ckA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-mrSHEe2tPUmhqKgPLDn9Zg-1; Sun,
 06 Sep 2026 13:11:33 -0400
X-MC-Unique: mrSHEe2tPUmhqKgPLDn9Zg-1
X-Mimecast-MFC-AGG-ID: mrSHEe2tPUmhqKgPLDn9Zg_1788714692
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 297481954120; Sun,  6 Sep 2026 17:11:32 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC8131955F06; Sun,  6 Sep 2026 17:11:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/40] hw/sensor: tmp105: add TMP75, TMP175 and LM75B variants
Date: Sun,  6 Sep 2026 19:10:12 +0200
Message-ID: <20260906171021.26568-32-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

The TI TMP75/TMP175 and the NXP LM75B share the TMP105 register map and
control semantics, differing only in a few details. Model them as
variants of the TMP105, parameterised by a small per-type class
descriptor covering the fault-queue depths, the writable config bits,
the converter resolution, the set-point masks and the TMP75's
alert-clear on thermostat-mode change.

The variant is class data, not migrated state, so the wire format is
unchanged and all variants share the existing vmstate.

While here, align the shared shutdown handling with the hardware:
entering shutdown now clears the ALERT/OS output in interrupt mode,
correcting the base TMP105 as well.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-7-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/sensor/tmp105.h |   6 +-
 hw/sensor/tmp105.c         | 172 ++++++++++++++++++++++++++++++-------
 2 files changed, 146 insertions(+), 32 deletions(-)

diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h
index daece592e9bc..0698aeead78c 100644
--- a/include/hw/sensor/tmp105.h
+++ b/include/hw/sensor/tmp105.h
@@ -1,5 +1,5 @@
 /*
- * Texas Instruments TMP105 Temperature Sensor
+ * Texas Instruments TMP105/TMP75/TMP175/LM75B Temperature Sensor
  *
  * Browse the data sheet:
  *
@@ -14,6 +14,10 @@
 #ifndef HW_SENSOR_TMP105_H
 #define HW_SENSOR_TMP105_H
 
+/* TMP75, TMP175 and NXP LM75B are register-compatible with TMP105. */
 #define TYPE_TMP105 "tmp105"
+#define TYPE_TMP175 "tmp175"
+#define TYPE_TMP75  "tmp75"
+#define TYPE_LM75B  "lm75b"
 
 #endif
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index fefa66171170..ece0650d703f 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -1,5 +1,5 @@
 /*
- * Texas Instruments TMP105 temperature sensor.
+ * Texas Instruments TMP105/TMP75/TMP175/LM75B temperature sensor.
  *
  * Copyright (C) 2008 Nokia Corporation
  * Written by Andrzej Zaborowski <andrew@openedhand.com>
@@ -16,6 +16,13 @@
  *
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Limitations:
+ * - The SMBus Alert Response Address protocol and the general-call commands
+ *   are not implemented.
+ * - The over-limit comparison uses the full 8.8 fixed-point temperature and a
+ *   ">=" boundary for every variant. The LM75B's 9-bit comparison quantisation
+ *   and strict-exceed boundary are therefore only approximated.
  */
 
 #include "qemu/osdep.h"
@@ -31,15 +38,8 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
+OBJECT_DECLARE_TYPE(TMP105State, TMP105Class, TMP105)
 
-/**
- * TMP105State:
- * @config: Bits 5 and 6 (value 32 and 64) determine the precision of the
- * temperature. See Table 8 in the data sheet.
- *
- * @see_also: http://www.ti.com/lit/gpn/tmp105
- */
 struct TMP105State {
     /*< private >*/
     I2CSlave parent_obj;
@@ -53,7 +53,7 @@ struct TMP105State {
     uint8_t config;
     int16_t temperature;
     int16_t limit[2];
-    int faults;
+    uint8_t faults;
     uint8_t fault_count;
     uint8_t alarm;
     /*
@@ -65,6 +65,27 @@ struct TMP105State {
     bool detect_falling;
 };
 
+/*
+ * Per-device-model parameters. The TMP105, TMP75, TMP175 and LM75B share the
+ * same register map and control semantics; they differ only in a handful of
+ * details captured here.
+ *
+ * @faultq: fault-queue length table selected by Config bits
+ * @config_wmask: writable Config bits. The LM75B has no resolution (R1:R0) or
+ * one-shot (OS) bits.
+ * @fixed_res: converter resolution field pinned by the device, or -1 when it is
+ * software-selectable.
+ * @limit_lsb_mask: low-byte mask applied to the T_LOW/T_HIGH limit registers.
+ */
+struct TMP105Class {
+    I2CSlaveClass parent_class;
+    const uint8_t *faultq;
+    uint8_t config_wmask;
+    int8_t fixed_res;
+    uint8_t limit_lsb_mask;
+    bool tm_change_clears_alert;
+};
+
 FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
 FIELD(CONFIG, THERMOSTAT_MODE,      1, 1)
 FIELD(CONFIG, POLARITY,             2, 1)
@@ -152,10 +173,11 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
     tmp105_alarm_update(s, false);
 }
 
-static const int tmp105_faultq[4] = { 1, 2, 4, 6 };
-
 static void tmp105_read(TMP105State *s)
 {
+    const TMP105Class *tc = TMP105_GET_CLASS(s);
+    int res;
+
     s->len = 0;
 
     if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
@@ -165,9 +187,11 @@ static void tmp105_read(TMP105State *s)
 
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
+        res = tc->fixed_res >= 0 ? tc->fixed_res :
+              FIELD_EX8(s->config, CONFIG, CONVERTER_RESOLUTION);
         s->buf[s->len++] = (((uint16_t) s->temperature) >> 8);
         s->buf[s->len++] = (((uint16_t) s->temperature) >> 0) &
-                (0xf0 << (FIELD_EX8(~s->config, CONFIG, CONVERTER_RESOLUTION)));
+                (0xf0 << (3 - res));
         break;
 
     case TMP105_REG_CONFIG:
@@ -190,6 +214,10 @@ static void tmp105_read(TMP105State *s)
 
 static void tmp105_write(TMP105State *s)
 {
+    const TMP105Class *tc = TMP105_GET_CLASS(s);
+    uint8_t config, one_shot;
+    bool waking;
+
     trace_tmp105_write(s->parent_obj.address, s->pointer);
 
     switch (s->pointer & 3) {
@@ -197,14 +225,27 @@ static void tmp105_write(TMP105State *s)
         break;
 
     case TMP105_REG_CONFIG:
-        if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
+        config = s->buf[0] & tc->config_wmask;
+        if (FIELD_EX8(config & ~s->config, CONFIG, SHUTDOWN_MODE)) {
             trace_tmp105_write_shutdown(s->parent_obj.address);
+            if (FIELD_EX8(config, CONFIG, THERMOSTAT_MODE)) {
+                s->alarm = 0;
+            }
+        }
+        if (tc->tm_change_clears_alert &&
+            FIELD_EX8(config ^ s->config, CONFIG, THERMOSTAT_MODE)) {
+            s->alarm = 0;
+            s->fault_count = 0;
+            s->detect_falling = false;
         }
-        s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
-        s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
-        if (FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT) &&
-            FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
+        waking = FIELD_EX8(s->config & ~config, CONFIG, SHUTDOWN_MODE);
+        one_shot = FIELD_EX8(config, CONFIG, ONE_SHOT);
+        s->config = FIELD_DP8(config, CONFIG, ONE_SHOT, 0);
+        s->faults = tc->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
+        if (one_shot && FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
             tmp105_alarm_update(s, true);
+        } else if (waking) {
+            tmp105_alarm_update(s, false);
         } else {
             tmp105_interrupt_update(s);
         }
@@ -214,7 +255,8 @@ static void tmp105_write(TMP105State *s)
     case TMP105_REG_T_HIGH:
         if (s->len >= 3) {
             s->limit[s->pointer & 1] = (int16_t)
-                    ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
+                    ((((uint16_t) s->buf[0]) << 8) |
+                     (s->buf[1] & tc->limit_lsb_mask));
         }
         tmp105_interrupt_update(s);
         break;
@@ -265,8 +307,9 @@ static int tmp105_event(I2CSlave *i2c, enum i2c_event event)
 static int tmp105_post_load(void *opaque, int version_id)
 {
     TMP105State *s = opaque;
+    const TMP105Class *tc = TMP105_GET_CLASS(s);
 
-    s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
+    s->faults = tc->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
 
     tmp105_interrupt_update(s);
     return 0;
@@ -339,11 +382,12 @@ static const VMStateDescription vmstate_tmp105 = {
 static void tmp105_reset_hold(Object *obj, ResetType type)
 {
     TMP105State *s = TMP105(obj);
+    const TMP105Class *tc = TMP105_GET_CLASS(s);
 
     s->temperature = 0;
     s->pointer = 0;
     s->config = 0;
-    s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
+    s->faults = tc->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
     s->fault_count = 0;
     s->alarm = 0;
     s->detect_falling = false;
@@ -371,11 +415,25 @@ static void tmp105_initfn(Object *obj)
                                     "Temperature, in millidegrees Celsius");
 }
 
+/*
+ * Fault-queue length selected by Config F1:F0. Row 0 (1/2/4/6) is used by the
+ * TMP105, TMP175 and LM75B; row 1 (1/2/3/4) by the TMP75.
+ */
+static const uint8_t tmp105_faultq[][4] = {
+    { 1, 2, 4, 6 },
+    { 1, 2, 3, 4 },
+};
+
+/* The F1:F0 field must never index past a fault-queue table row. */
+QEMU_BUILD_BUG_ON((1 << R_CONFIG_FAULT_QUEUE_LENGTH) - 1 >=
+                  ARRAY_SIZE(tmp105_faultq[0]));
+
 static void tmp105_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TMP105Class *tc = TMP105_CLASS(klass);
 
     dc->realize = tmp105_realize;
     k->event = tmp105_event;
@@ -383,19 +441,71 @@ static void tmp105_class_init(ObjectClass *klass, const void *data)
     k->send = tmp105_tx;
     rc->phases.hold = tmp105_reset_hold;
     dc->vmsd = &vmstate_tmp105;
+
+    tc->faultq = tmp105_faultq[0];
+    tc->config_wmask = 0xff;
+    tc->fixed_res = -1;
+    tc->limit_lsb_mask = 0xf0;
+    tc->tm_change_clears_alert = false;
 }
 
-static const TypeInfo tmp105_info = {
-    .name          = TYPE_TMP105,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(TMP105State),
-    .instance_init = tmp105_initfn,
-    .class_init    = tmp105_class_init,
-};
+static void tmp175_class_init(ObjectClass *klass, const void *data)
+{
+    TMP105Class *tc = TMP105_CLASS(klass);
 
-static void tmp105_register_types(void)
+    tc->faultq = tmp105_faultq[0];
+    tc->config_wmask = 0xff;
+    tc->fixed_res = -1;
+    tc->limit_lsb_mask = 0xf0;
+    tc->tm_change_clears_alert = false;
+}
+
+static void tmp75_class_init(ObjectClass *klass, const void *data)
 {
-    type_register_static(&tmp105_info);
+    TMP105Class *tc = TMP105_CLASS(klass);
+
+    tc->faultq = tmp105_faultq[1];
+    tc->config_wmask = 0xff;
+    tc->fixed_res = -1;
+    tc->limit_lsb_mask = 0xf0;
+    tc->tm_change_clears_alert = true;
 }
 
-type_init(tmp105_register_types)
+static void lm75b_class_init(ObjectClass *klass, const void *data)
+{
+    TMP105Class *tc = TMP105_CLASS(klass);
+
+    tc->faultq = tmp105_faultq[0];
+    tc->config_wmask = 0x1f;
+    tc->fixed_res = 2;
+    tc->limit_lsb_mask = 0x80;
+    tc->tm_change_clears_alert = false;
+}
+
+static const TypeInfo tmp105_types[] = {
+    {
+        .name          = TYPE_TMP105,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(TMP105State),
+        .class_size    = sizeof(TMP105Class),
+        .instance_init = tmp105_initfn,
+        .class_init    = tmp105_class_init,
+    },
+    {
+        .name          = TYPE_TMP175,
+        .parent        = TYPE_TMP105,
+        .class_init    = tmp175_class_init,
+    },
+    {
+        .name          = TYPE_TMP75,
+        .parent        = TYPE_TMP105,
+        .class_init    = tmp75_class_init,
+    },
+    {
+        .name          = TYPE_LM75B,
+        .parent        = TYPE_TMP105,
+        .class_init    = lm75b_class_init,
+    },
+};
+
+DEFINE_TYPES(tmp105_types)
-- 
2.55.0


