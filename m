Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE9CCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUuMX-0002MG-7v; Wed, 03 Jun 2026 18:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wUuAt-0000Gk-TT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:34:59 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wUuAr-00077O-SK
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:34:59 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1370417c01cso71308c88.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780526096; x=1781130896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4hH/Thy1WXYsnNwkP96gh2PbXzlmRplzMWu7Xzp3fk=;
 b=nN9h7IVXtlWoPx1USav/VPMKDK1lGTTEOj9VSVwCWL6XatXMeQEYCAN5hu/jmwFJfI
 WgauWzYWEF4wNxKnf8nFKXqTNgUtHvXtYSUSPAgHzvR9GjhzwLtcoSxX5Z5B8jp3lX04
 B9ul+6yYjKlCCDt8/AnScjIdaRhFLmp6cjWD/PGN5Xl8Q/d9V9q61uizwj3VVBJUQver
 2s0djhUIrm18UBZCb8cHxey/SzGs7MgEWjN4/wR9NWG86nmT9gIBajQmxWuP7l2X3AJx
 8LshwI0nsNYCKpQ6WYZagFaWnQhu6UyDNuaj+QAW2FXmoXEGZScs1z/6kARhxyMm3x8f
 ZpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780526096; x=1781130896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4hH/Thy1WXYsnNwkP96gh2PbXzlmRplzMWu7Xzp3fk=;
 b=Y9wd8f9HohYRQz5Wk6Z6kthqZQp1rQ2sTGsAVFHgKWuhZHIks0JQ4va9K9ngcZBTRc
 G30WEzeGAtF1yRG+cXnqJTS16Z/mLC2vCk+OrosTQIDKnOIV08BH6DlIrqtsc6JJX1cR
 nC/RdzMAMTWzyIlwiWz8Gm7JaWv/4H/GNOVw7KZQZDgQ9AE2qsbjB1A9VOvlSm6AaJ1z
 fkQ0myXzyTGVZJTzTl5PdmTYZFAbXNx45sh8681gf9qof0lNy8wQRFX0/wUbm0TTl1G2
 2NpEYnIoBkYNdw+v97Mj2IvIP8KQ1E4vx1uRr7UuLMOiFRCi6SIbRgyIZJUX7k0cCdZy
 mNkg==
X-Gm-Message-State: AOJu0YyBQevsJUsQ7dYincOQePaWEzWcZpwgbAm7vtMwfigDf+jlyhEZ
 XKSWUFk/+2GrelTGp8JSp19lMJdA1wfu6yUUSRyiW1P/t99A6jUKeINumqpq3ojv
X-Gm-Gg: Acq92OF3uqLokyOtagUzwIGQU+FucEX51LFVi4vuEAYlDOztPxIAMvXzUwWsWgKQXkB
 kBBjXlY8yDWKrr5iqYAzeX1L72tLLUFimSWDBVkZuAdecjCuSSKVMoaRmgmDEZD1avD7x5gGKGV
 kjXTAMfAhbXcT+3JDpUgNSeXdEMZjWeBen7DwvQdqKOcRh4AjVfAurXKfRiDEqs+9i/UA4KmCHl
 p45DYG5V9d17lX7gYQJCCyKokwgJgvtDZ3PzlQNb1eO2EEdWjyHFMyERD9QoQqMewU1VSsw3BFQ
 rp24vhpGF8tI5H74wexHxF16wHIHmv2YeeJlBK7ErdDkhNLXMSi2rXJ7s13B3xdWqlsIR8kQ2fx
 GGdZI9lFJ6UK4IDCcfZ2i22MZIf42DPZdBb/EIesTb5m3T8lt2L0APfzG2VmruiDHP/fhWYWjCU
 WWwHSNcET+05FYeFW8ua43BBwBMno7qcqFb2HM+yLQUIDz6ozbt4ofMi9igT0=
X-Received: by 2002:a05:7301:4592:b0:304:d788:ac5 with SMTP id
 5a478bee46e88-3074fcb2470mr2864813eec.35.1780526096089; 
 Wed, 03 Jun 2026 15:34:56 -0700 (PDT)
Received: from MacLin.attlocal.net ([2600:1700:e140:14d0:fad:648b:d3db:b403])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df349d8sm3492027eec.22.2026.06.03.15.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 15:34:55 -0700 (PDT)
From: ConKite <connorkite@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	hreitz@redhat.com,
	ConKite <connorkite@gmail.com>
Subject: [PATCH 1/2] vhost-user: Consolidate chardev property definitions
Date: Wed,  3 Jun 2026 15:33:54 -0700
Message-ID: <20260603223430.3311916-2-connorkite@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603223430.3311916-1-connorkite@gmail.com>
References: <20260603223430.3311916-1-connorkite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=connorkite@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Jun 2026 18:47:00 -0400
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

Move chardev qdev property definitions from children into
VHostUserBase. This reduces code duplication and allows children
to simply inherit the property during initialization.

Signed-off-by: Connor Kite <connorkite@gmail.com>

---
 hw/virtio/vhost-user-base.c        | 9 +++++++++
 hw/virtio/vhost-user-gpio.c        | 4 ----
 hw/virtio/vhost-user-i2c.c         | 5 -----
 hw/virtio/vhost-user-input.c       | 5 -----
 hw/virtio/vhost-user-rng.c         | 5 -----
 hw/virtio/vhost-user-rtc.c         | 4 ----
 hw/virtio/vhost-user-snd.c         | 1 -
 hw/virtio/vhost-user-spi.c         | 5 -----
 hw/virtio/vhost-user-test-device.c | 1 -
 9 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 01ab9ca56b..a3d5a9cd99 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -353,9 +353,16 @@ static void vub_device_unrealize(DeviceState *dev)
     do_vhost_user_cleanup(vdev, vub);
 }
 
+/*Define common qdev properties.  Inherited by all children*/
+static const Property vub_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
+};
+
+
 static void vub_class_init(ObjectClass *klass, const void *data)
 {
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     vdc->realize = vub_device_realize;
     vdc->unrealize = vub_device_unrealize;
@@ -363,6 +370,8 @@ static void vub_class_init(ObjectClass *klass, const void *data)
     vdc->get_config = vub_get_config;
     vdc->set_config = vub_set_config;
     vdc->set_status = vub_set_status;
+
+    device_class_set_props(dc, vub_properties);
 }
 
 static const TypeInfo vub_types[] = {
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index d473f87077..33b8752282 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -14,9 +14,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_gpio.h"
 
-static const Property vgpio_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
 
 static void vgpio_realize(DeviceState *dev, Error **errp)
 {
@@ -42,7 +39,6 @@ static void vu_gpio_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_gpio_vmstate;
-    device_class_set_props(dc, vgpio_properties);
     device_class_set_parent_realize(dc, vgpio_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index 152b1f6740..3f5427b5b2 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -14,10 +14,6 @@
 #include "qemu/error-report.h"
 #include "standard-headers/linux/virtio_ids.h"
 
-static const Property vi2c_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vi2c_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -42,7 +38,6 @@ static void vu_i2c_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_i2c_vmstate;
-    device_class_set_props(dc, vi2c_properties);
     device_class_set_parent_realize(dc, vi2c_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index 5cfc5bbb56..8fe6349ffc 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -7,10 +7,6 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio-input.h"
 
-static const Property vinput_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vinput_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -36,7 +32,6 @@ static void vhost_input_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_vhost_input;
-    device_class_set_props(dc, vinput_properties);
     device_class_set_parent_realize(dc, vinput_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 106c8f211a..664aee403d 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -20,10 +20,6 @@ static const VMStateDescription vu_rng_vmstate = {
     .unmigratable = 1,
 };
 
-static const Property vrng_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vu_rng_base_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -43,7 +39,6 @@ static void vu_rng_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_rng_vmstate;
-    device_class_set_props(dc, vrng_properties);
     device_class_set_parent_realize(dc, vu_rng_base_realize,
                                     &vubc->parent_realize);
 
diff --git a/hw/virtio/vhost-user-rtc.c b/hw/virtio/vhost-user-rtc.c
index 88b0c70b90..6d80cb6263 100644
--- a/hw/virtio/vhost-user-rtc.c
+++ b/hw/virtio/vhost-user-rtc.c
@@ -19,9 +19,6 @@ static const VMStateDescription vu_rtc_vmstate = {
     .unmigratable = 1,
 };
 
-static const Property vrtc_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
 
 static void vu_rtc_base_realize(DeviceState *dev, Error **errp)
 {
@@ -42,7 +39,6 @@ static void vu_rtc_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_rtc_vmstate;
-    device_class_set_props(dc, vrtc_properties);
     device_class_set_parent_realize(dc, vu_rtc_base_realize,
                                     &vubc->parent_realize);
 
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 7129b77d9c..3663450aed 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -34,7 +34,6 @@ static const VMStateDescription vu_snd_vmstate = {
 };
 
 static const Property vsnd_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_BIT64("controls", VHostUserBase,
                       parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
 };
diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
index 707f96c250..fb6168d391 100644
--- a/hw/virtio/vhost-user-spi.c
+++ b/hw/virtio/vhost-user-spi.c
@@ -15,10 +15,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_spi.h"
 
-static const Property vspi_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-};
-
 static void vspi_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
@@ -44,7 +40,6 @@ static void vu_spi_class_init(ObjectClass *klass, const void *data)
     VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
     dc->vmsd = &vu_spi_vmstate;
-    device_class_set_props(dc, vspi_properties);
     device_class_set_parent_realize(dc, vspi_realize,
                                     &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/virtio/vhost-user-test-device.c b/hw/virtio/vhost-user-test-device.c
index a2f963fdf6..91e23bf07a 100644
--- a/hw/virtio/vhost-user-test-device.c
+++ b/hw/virtio/vhost-user-test-device.c
@@ -30,7 +30,6 @@ static const VMStateDescription vud_vmstate = {
 };
 
 static const Property vud_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
     DEFINE_PROP_UINT32("vq_size", VHostUserBase, vq_size, 64),
     DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
-- 
2.43.0


