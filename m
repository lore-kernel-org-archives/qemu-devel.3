Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF26C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgG-0007LL-Vi; Mon, 29 Jun 2026 08:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfm-0006zj-JR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:10 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfk-0007Vd-Q5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:10 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-46e4764ca48so3094189f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734467; x=1783339267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EDFZRou/PG3IEZxQk0bZnXFq3CToCUYmHAeKMV8JW0o=;
 b=KWOWYW+AizDPu2rvqMjByNgq0mGyHWX+HYaFmj6BOiyUoMPqfsnCzMsEMLe7UKM/8O
 LhFgH99qgy2QZQpsP2OHJbCRe6jDlnb630t1/7FajVvXm1Js+hM1VjDNixU92TR4mjcC
 PjQSzwwlMncGBCWKVTte3eR0jc/oh/wjT0L5CDCIyKeMjTrVC/l/xKHKd0h51iuoAuyl
 Y19TbpFdaVnnXFOLPsNZkfeAHn2lQnowtYEw27fVL7lWMuWGGhESls1bY04DHveUVSEk
 2wrmYShPfwPlVzF4Efb/4sSp5z0JyZ5nkQWeBO6FmWWmaMYREQlCwkG3cOCdyz9ZMQ/W
 qciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734467; x=1783339267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EDFZRou/PG3IEZxQk0bZnXFq3CToCUYmHAeKMV8JW0o=;
 b=RRJ+hIkxFfcZE2BamAa2H9Dj76/5XySJZ1K2SAz9g5XTX4KPbmZsxu4mLfPIbSG/j8
 pfoey1WeRAwZzCAvxDSCPKbN/ozWQS7sUkjLHzMg422FgDNaP0F6b5rYSljVb+v7XDus
 fsP21SWPXc8ESOMa3RCZ8cqjyPRSJMqoDLcFxO+9fh2nDLsJasq0b+m0d0UAiJo3U6W9
 BKOGlBo7ti2q6fZUotG8VkIzWEk/6d3QJmlwjhn/CfgffwhIhhaQFrN/C3oEyQVCIZ3O
 gfdqYf/xS9NbBiC6s6uiTO+mz2+OajuG9HsAmkLSFd1SAE8a5cbScyv9E5mJnhrjbPf/
 zbnw==
X-Gm-Message-State: AOJu0YxJESVdoA9r16DLNks+2FtL8SiSF6ZAcLyPg+EATh1rL0PxUAZh
 L7WPqJLdNw79GOi2ItmMRw+DYIySfJfoOr9OKM1qvp+NsxUonTZdDVfquF9oFkD909QqtBOcqQi
 W1K7G
X-Gm-Gg: AfdE7cns2Ak8O/SRl8gDv+gUVbRNteHtqBct1UIyk0/jh8GjO/uEjL/WfWlCUTMO5rz
 V+Utv0NnTIJDdMZrmrsNEbywYCaQDZ5YbE09RGqWXOKZ8csToa2ocDwOsY3VGHNP9PSTXxRLbvH
 hzRYT0IAdLKFmASpRG3IkIQEeRnnT7Vd6kBfI/wXRZChtrMOmHKQlMX4xkvcXbVPdm+QC4nwJ8t
 rXOqN2kygZU3qn04TcosXkzGk0WuD91xUAppXkcPuM8bqMW8LUUSaUCBDzJwH7BvfHQyl+MYaeh
 QZAnZkibnY+C2D5i3QUSKbPjGBY68rVzonvqzMnpuJP/caDo/2qWlllhUrDxn5Oin9ShC3Tl1V+
 KzJoIgppz2YV+LFeUBqm8Bl0/+LLZmr1X1bH+R3VkldRoDNQgnaW/5xMJKvHi4vIl1StxKdum5W
 0OoSeuj874Yya70/QZsTHGBk5/YF2LG/Iy1cbCMRD6hVfnAuueenMoNZriE4MGBG/2vA2gJdRJ2
 xhq61M5nXZqVcoR/vQnkQ==
X-Received: by 2002:a05:6000:2f89:b0:473:1089:1550 with SMTP id
 ffacd0b85a97d-474febcd3c9mr276205f8f.4.1782734467288; 
 Mon, 29 Jun 2026 05:01:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/54] hw/arm/sabrelite: Introduce class SabreliteMachineState
Date: Mon, 29 Jun 2026 13:00:10 +0100
Message-ID: <20260629120032.1645265-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Matyáš Bobek <matyas.bobek@gmail.com>

Create full class SabreliteMachineState extending MachineState.

Previously, Sabrelite board MachineState was declared indirectly by the
DEFINE_MACHINE_ARM macro. FslIMX6State was only instantiated in the
sabrelite_init function. For FlexCAN device, machine properties
will be used to select QEMU CAN buses. A custom class is therefore
required, so the CanBusState "connections" can then be added as fields.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-id: 115740db83cf2e5a5e7bb349130c9706934ec1f3.1782140438.git.matyas.bobek@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sabrelite.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 04484aaa14..7e036e6388 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -20,6 +20,15 @@
 #include "qemu/error-report.h"
 #include "system/qtest.h"
 
+struct SabreliteMachineState {
+    MachineState parent_obj;
+
+    FslIMX6State soc;
+};
+
+#define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
+OBJECT_DECLARE_SIMPLE_TYPE(SabreliteMachineState, SABRELITE_MACHINE)
+
 static struct arm_boot_info sabrelite_binfo = {
     /* DDR memory start */
     .loader_start = FSL_IMX6_MMDC_ADDR,
@@ -41,7 +50,7 @@ static void sabrelite_reset_secondary(ARMCPU *cpu,
 
 static void sabrelite_init(MachineState *machine)
 {
-    FslIMX6State *s;
+    SabreliteMachineState *s = SABRELITE_MACHINE(machine);
 
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > FSL_IMX6_MMDC_SIZE) {
@@ -50,13 +59,12 @@ static void sabrelite_init(MachineState *machine)
         exit(1);
     }
 
-    s = FSL_IMX6(object_new(TYPE_FSL_IMX6));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX6);
 
     /* Ethernet PHY address is 6 */
-    object_property_set_int(OBJECT(s), "fec-phy-num", 6, &error_fatal);
+    object_property_set_int(OBJECT(&s->soc), "fec-phy-num", 6, &error_fatal);
 
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 machine->ram);
@@ -70,7 +78,7 @@ static void sabrelite_init(MachineState *machine)
         /* Add the sst25vf016b NOR FLASH memory to first SPI */
         Object *spi_dev;
 
-        spi_dev = object_resolve_path_component(OBJECT(s), "spi1");
+        spi_dev = object_resolve_path_component(OBJECT(&s->soc), "spi1");
         if (spi_dev) {
             SSIBus *spi_bus;
 
@@ -89,7 +97,7 @@ static void sabrelite_init(MachineState *machine)
                 qdev_realize_and_unref(flash_dev, BUS(spi_bus), &error_fatal);
 
                 cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
-                qdev_connect_gpio_out(DEVICE(&s->gpio[2]), 19, cs_line);
+                qdev_connect_gpio_out(DEVICE(&s->soc.gpio[2]), 19, cs_line);
             }
         }
     }
@@ -100,7 +108,7 @@ static void sabrelite_init(MachineState *machine)
     sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &sabrelite_binfo);
+        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
     }
 }
 
@@ -117,10 +125,10 @@ static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo sabrelite_machine_init_typeinfo = {
-    .name          = MACHINE_TYPE_NAME("sabrelite"),
+    .name          = TYPE_SABRELITE_MACHINE,
     .parent        = TYPE_MACHINE,
     .class_init    = sabrelite_machine_class_init,
-    .instance_size = sizeof(MachineState),
+    .instance_size = sizeof(SabreliteMachineState),
     .abstract      = false,
     .interfaces    = arm_machine_interfaces,
 };
-- 
2.43.0


