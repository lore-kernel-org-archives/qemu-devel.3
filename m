Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB421C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lro-0006OT-Up; Mon, 21 Sep 2026 17:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrn-0006Lc-EJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:03 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrl-0000If-FK
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:03 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so18039885e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027270; x=1790632070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ljR86Ogn1pTIjM5VRsg2z81z+XkuaXzg3tx6lmKPiqc=;
 b=NgHXcPsj6wLTQZbjBXTHGyjQXvGL3XEoZlyGZ04nZKwWA2w1slNC6uo0KanfVHJOBG
 eNg0B0rkMhZ8MV/POl9b+4ZBr5xq3atCZLKg1MkhQv0qws1NO8/5pTioK6FcuisxTnJf
 4uhisnRTEY6R12+RwlnAJCp4sCgr85mSGE1ZWRkO4PhkjFL0hmrd3shr5yA0qNrzSDST
 yzMhvK26cnNiOmUcNCpqScvA4QjDOfI9rNMXLddvk5WGf4XoagSAs0sP49Mqq8vJ4OrJ
 fr4yghYmx4q6HGM7pTaviyCM2u+LoN0LzkmZkvGaJL8++LVXkG5fdf0hjqXCZwCmCAkc
 XndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027270; x=1790632070;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ljR86Ogn1pTIjM5VRsg2z81z+XkuaXzg3tx6lmKPiqc=;
 b=OXLUKC/3xV4IFNKeE3yZm96sQ0hHN8dWgunwBSSv1Kj73DmNoG+s4z5HEjmnX6jd0Z
 +UxrdKx8XVjjCJBj6hkHqOa+xu05GLwZ6wnE/XV/AgHpJnz1vlasfcgzOyWt7SN6JyEQ
 XNZIywzOHkBl3f9G937ZHZ+ZIMVbKLyGdSz8E6vIJhUE5tFgOI/ZeGVakPt/T9RimCuE
 JCjEzPFjTqCTTtqM4JQWy9wQp7u7bXmv5n5SHn9pCRGzif+xuIZ3xgW6939gQ/LrVvTq
 q7C1kPsptr2ygHBewIrveF27vdnkNku0zeYfu8FtRYd6jK0kBP555D871th6wWYRa1sb
 IJCg==
X-Gm-Message-State: AFuF++l2thM3lHEKVD1HEpu3/nXReiunHO5VUWBFyuqCRfZIVln+xMA8
 4sDYW9fcGRx6eKRrTHTyAomf7EVp4jvPIZ9l1RWpBQkBTOYdGMnn7goJuttkAg==
X-Gm-Gg: AYBFou0WvgSiyLt/WbfhN/cRF/kdVrY6bXqfgxL1g6CtyzYp6Xrs+tm09I7w1aPhCAX
 3GoFfM8+RuOxqwAP5NFt0p5KhITs17si7hVx1TsyYZmojsWoxsE1Jnu/OaY5AFsrdDBcrZIYcEN
 qLz2/pq5cnp5fGSzDL3boLi3d8CPD1cA9aOzhOzquVqJ+JYxKbvSJMlzIGA74yvCBAt6xx2qnwY
 m8y17VOuJLE2N80H09y1uRHFRou2cm4WRoUCXCDngMvq3gCmTvQDPT6Cc5MX/qY/XL1Iozmhl8u
 kr1y4Y0iGGTWofMCmXeRJWDSyi/FnIYnN2cconPcAAZpsLxX/UooVCP3EMnWkmTfy6Cl+uQFxdl
 kjaIz0/ni36yc15nQuxoTsNpl0iHVS0f9oOJ5kRY0TICJvdvsodzJYX76nUjJWjCU5i+HbKxeMt
 AraxINxZj3i3EWCPZxBuR40fX2xheI6ihYtDLet/47pUbOMz1RLYOdJ7jUa21OEt9DSTqR720Wf
 ANjVXNR7X01laPKCBnkL0UYW/4Wz0ZLCRv+d718xWMEmZBYMIGwUpNEgY64R3OWYX0Zn4Dk8IE2
 Ywg=
X-Received: by 2002:a05:600c:620f:b0:49e:8222:3451 with SMTP id
 5b1f17b1804b1-49fd8a6cdb7mr12212775e9.14.1790027270048; 
 Mon, 21 Sep 2026 14:47:50 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 17/42] hw/timer/imx_epit: Wire clock control module via link
 property
Date: Mon, 21 Sep 2026 23:46:45 +0200
Message-ID: <20260921214710.29422-18-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When wiring struct IMXEPITState to the clock control module, it is
currently necessary to reach into its private data. Moreover, when
forgetting to wire the clock control module, QEMU will crash after the
guest has already started. Fix both by letting struct IMXEPITState
expose a link property which is checked at realize time.

Inspired-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/fsl-imx25.c  |  3 ++-
 hw/arm/fsl-imx31.c  |  3 ++-
 hw/arm/fsl-imx6.c   |  3 ++-
 hw/arm/fsl-imx6ul.c |  3 ++-
 hw/timer/imx_epit.c | 14 ++++++++++++++
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 0840c2d86a..a8745d5d1a 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -160,7 +160,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_EPIT2_ADDR, FSL_IMX25_EPIT2_IRQ }
         };
 
-        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->epit[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index b440ad6e28..79e2f7f795 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -126,7 +126,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
             { FSL_IMX31_EPIT2_ADDR, FSL_IMX31_EPIT2_IRQ },
         };
 
-        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->epit[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 22deb72496..5bb828fbb6 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -225,7 +225,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_EPIT2_ADDR, FSL_IMX6_EPIT2_IRQ },
         };
 
-        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->epit[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 2786889bda..f72121e23d 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -270,7 +270,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_EPIT2_IRQ,
         };
 
-        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->epit[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0,
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index 374ec7d324..e1050b51d8 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -17,7 +17,9 @@
 #include "hw/timer/imx_epit.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/imx_ccm.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -386,6 +388,12 @@ static void imx_epit_realize(DeviceState *dev, Error **errp)
     IMXEPITState *s = IMX_EPIT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    if (!s->ccm) {
+        error_setg(errp, "%s 'clock-control-module' link property not set",
+                   dev->canonical_path);
+        return;
+    }
+
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &imx_epit_ops, s, TYPE_IMX_EPIT,
                           0x00001000);
@@ -412,12 +420,18 @@ static void imx_epit_dev_reset(DeviceState *dev)
     imx_epit_reset(s, true);
 }
 
+static const Property imx_timer_epit_properties[] = {
+    DEFINE_PROP_LINK("clock-control-module", IMXEPITState, ccm, TYPE_IMX_CCM,
+                     IMXCCMState *),
+};
+
 static void imx_epit_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc  = DEVICE_CLASS(klass);
 
     dc->realize = imx_epit_realize;
     device_class_set_legacy_reset(dc, imx_epit_dev_reset);
+    device_class_set_props(dc, imx_timer_epit_properties);
     dc->vmsd = &vmstate_imx_timer_epit;
     dc->desc = "i.MX periodic timer";
 }
-- 
2.55.0


