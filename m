Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33D4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLO-0007Ye-Dq; Thu, 02 Jul 2026 14:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLL-0007MX-Mq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLF-0005Wr-7V
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493ba701891so14441815e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783017652; x=1783622452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OwV5rRTMWe4Omy4mwhdJpkwhc6qPEwhj2gk7idJkQvU=;
 b=UcnosZKxD40ha815hu+E8A0p5LLy6pXylksFfirjHZrwOcGlb56/NWmiVHZtB4RNTb
 t5657Ch6cQCB4rpzhEZ+Me5mDbC2y7JxuxD3Srw+QnQk6bJOTg+Fkfj2briiqg1gLNIS
 ljhDxq4sMQaVaO+03EO/y5BWQw1Qb4PPEPYE0LRxHd06xYkNUY0CSyvIXFd17apQYv+t
 ZU0FUKuF5EAo8wGiwoRNI4wVuo9lvjVcLO50CpQwLvYoBy+IqIgtrCcbKhWq9G8/vOIk
 K4EYyTWE8E6t9uJX6BvvVhM/HqVsD9jXlj/rDetKMT29Bx2g81fY5+uoXOTfY+77a9tq
 9ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017652; x=1783622452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OwV5rRTMWe4Omy4mwhdJpkwhc6qPEwhj2gk7idJkQvU=;
 b=mPAfidP+8WyTBxwnPWhnK2it0RcrXzmACBQK38Vyr1NGPBXRHUIezmS/MZ3ZzoszRe
 bXpQzcTWCi9sLJf3xSQIqzmWJGRomb4FKVBjgDxxv7q0cILvb4K/a2xQgmOQUtim0gAE
 Va8jP4Ux/xKij7Y4LfrNl3Em3c35a162kqEEuI+61WB4qDHOs+l8zr39MjiOZ1BQJLZt
 lkczsgIyRwaSLpE1Gqg9LUNA0vKwoWCMBaBZvDp1DRPtlZPy6wXeBlQglTL/P017rWRB
 jOGrBwnWNXN5z3HBsNMbhiz2f5ZzUFjUj6neizU3tqb2IvOTQVAFoQCEk+mi01cTTyJA
 gZsg==
X-Gm-Message-State: AOJu0YwWnCOECj7v51FwJK9faMGJ5wvH309p8+Kpy1HhGUwp9ktxidzg
 LtUUopkDbg/qIp4lpWO4gzTjEY08mzZPbm48KIQz05nteHHKNh3RkHZDnvELsQ==
X-Gm-Gg: AfdE7cntrfkkJw/Lbm5aHz0uSN1XaebB/zDf5AacMtcxgQWxDFfzetSS70KM5jB0VGM
 mwBllZVPCt39jt/SSARUfKKQMsax7fvk5VarHInJUTc4gl0H5+2FJioDlnRJw65FwCqSGNMwOns
 7tOnzk6raUtpxffffKYgAcxJvCSohG1YoXlla7HaGEqtMQnpiYizUs8G1KfkV+Yd40C++R5KFHc
 Y/LAS7THxgyzWuooJFOdje+Ig8abHRLJdtAL3FbJeRekWCfSbKk4BIYJ94nkwlvy+lQnJg8UUpC
 UVIKyi/D4HzmWeJFtZFeF71lJt12eCH637PiOCw3XXnXXGBiCv4/StMa/+3/wQIJBgEnqLNySoS
 LLouEhlqa3x40+c3OfLi2FdyspfAbF0+tRQEgWtaOLSoiXm8uS/ED8ECBrWxTJCgrKOHjKyQxHS
 jQQfnqjX9+/WzFRZOgLklZzHbgVIgAKH2I+knVRn6EVkqDFX1tcCHpIZVlmnRBf6TADtM2ShZfj
 ZP9xGa+4FJw13rvc+mQ7H+t1PFPopoOuG59nV/SUYlkRZ4=
X-Received: by 2002:a05:600c:34c8:b0:493:92c9:1e6d with SMTP id
 5b1f17b1804b1-493c3cfb237mr95034735e9.33.1783017651334; 
 Thu, 02 Jul 2026 11:40:51 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-25c8-8a00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:25c8:8a00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm120271225e9.1.2026.07.02.11.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:50 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH v2 2/5] hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
Date: Thu,  2 Jul 2026 20:40:35 +0200
Message-ID: <20260702184038.178196-3-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702184038.178196-1-shentey@gmail.com>
References: <20260702184038.178196-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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

Subclass TYPE_CAN_FLEXCAN, yielding TYPE_CAN_FLEXCAN2 and
TYPE_CAN_FLEXCAN3.
Since TYPE_CAN_FLEXCAN is now abstract, TYPE_FSL_IMX6 needs to use
TYPE_CAN_FLEXCAN2. TYPE_CAN_FLEXCAN3 will be used in TYPE_FSL_IMX8MP.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/flexcan.h |  4 ++-
 hw/arm/fsl-imx6.c        |  2 +-
 hw/net/can/flexcan.c     | 78 ++++++++++++++++++++++++++++++++--------
 3 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index 153afc1e03..32de7b904a 100644
--- a/include/hw/net/flexcan.h
+++ b/include/hw/net/flexcan.h
@@ -139,7 +139,9 @@ typedef struct FlexcanState {
 } FlexcanState;
 
 #define TYPE_CAN_FLEXCAN "flexcan"
-
 OBJECT_DECLARE_SIMPLE_TYPE(FlexcanState, CAN_FLEXCAN);
 
+#define TYPE_CAN_FLEXCAN2 "flexcan2"
+#define TYPE_CAN_FLEXCAN3 "flexcan3"
+
 #endif
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 585c935b89..eec9673c6f 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -92,7 +92,7 @@ static void fsl_imx6_init(Object *obj)
     }
     for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
         snprintf(name, NAME_SIZE, "flexcan%d", i + 1);
-        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN);
+        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN2);
     }
     for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
         snprintf(name, NAME_SIZE, "wdt%d", i);
diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 8f3f066ef5..da36d10bd3 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -1290,7 +1290,7 @@ static bool flexcan_mem_accepts(void *opaque, hwaddr addr,
     return true;
 }
 
-static const struct MemoryRegionOps flexcan_ops = {
+static const struct MemoryRegionOps flexcan2_ops = {
     .read = flexcan_mem_read,
     .write = flexcan_mem_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
@@ -1307,6 +1307,23 @@ static const struct MemoryRegionOps flexcan_ops = {
     },
 };
 
+static const struct MemoryRegionOps flexcan3_ops = {
+    .read = flexcan_mem_read,
+    .write = flexcan_mem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+        .accepts = flexcan_mem_accepts
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+};
+
 static CanBusClientInfo flexcan_bus_client_info = {
     .can_receive = flexcan_can_receive,
     .receive = flexcan_receive,
@@ -1322,16 +1339,26 @@ static int flexcan_connect_to_bus(FlexcanState *s, CanBusState *bus)
     return 0;
 }
 
-static void flexcan_init(Object *obj)
+static void flexcan2_init(Object *obj)
 {
     FlexcanState *s = CAN_FLEXCAN(obj);
 
     memory_region_init_io(
-        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN,
+        &s->iomem, obj, &flexcan2_ops, s, TYPE_CAN_FLEXCAN2,
         offsetof(FlexcanRegs, _reserved6)
     );
 }
 
+static void flexcan3_init(Object *obj)
+{
+    FlexcanState *s = CAN_FLEXCAN(obj);
+
+    memory_region_init_io(
+        &s->iomem, obj, &flexcan3_ops, s, TYPE_CAN_FLEXCAN3,
+        sizeof(FlexcanRegs)
+    );
+}
+
 static void flexcan_realize(DeviceState *dev, Error **errp)
 {
     FlexcanState *s = CAN_FLEXCAN(dev);
@@ -1384,19 +1411,42 @@ static void flexcan_class_init(ObjectClass *klass, const void *data)
     dc->realize = flexcan_realize;
     device_class_set_props(dc, flexcan_properties);
     dc->vmsd = &vmstate_can;
-    dc->desc = "i.MX FLEXCAN Controller";
 }
 
-static const TypeInfo flexcan_info = {
-    .name          = TYPE_CAN_FLEXCAN,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(FlexcanState),
-    .class_init    = flexcan_class_init,
-    .instance_init = flexcan_init,
-};
+static void flexcan2_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "i.MX FlexCAN 2 Controller";
+}
 
-static void can_register_types(void)
+static void flexcan3_class_init(ObjectClass *klass, const void *data)
 {
-    type_register_static(&flexcan_info);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "i.MX FlexCAN 3 Controller";
 }
-type_init(can_register_types)
+
+static const TypeInfo flexcan_types[] = {
+    {
+        .name          = TYPE_CAN_FLEXCAN,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FlexcanState),
+        .class_init    = flexcan_class_init,
+        .abstract      = true,
+    },
+    {
+        .name          = TYPE_CAN_FLEXCAN2,
+        .parent        = TYPE_CAN_FLEXCAN,
+        .class_init    = flexcan2_class_init,
+        .instance_init = flexcan2_init,
+    },
+    {
+        .name          = TYPE_CAN_FLEXCAN3,
+        .parent        = TYPE_CAN_FLEXCAN,
+        .class_init    = flexcan3_class_init,
+        .instance_init = flexcan3_init,
+    },
+};
+
+DEFINE_TYPES(flexcan_types)
-- 
2.55.0


