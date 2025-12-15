Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8886D5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEoU-0000vk-Ni; Mon, 15 Dec 2025 15:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEoT-0000vW-Iu
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:04:57 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEoR-000811-P4
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:04:57 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso39349845e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765829094; x=1766433894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MizUUlNpjXIbwqKxnq224wGapMpxwlfA17G+ANK60nc=;
 b=TXA5y8GIzLoYrBBg1mKG9lUlhjTc785XzDo8DRgcaagZsn0Dme1Q2sKquZ/Dq1+ZKQ
 2lRdIGxKTuwbT8y+/wwaxEi5AgG4J5eT5DNbiqPVFiGPBZXH4HHdwdI5Gh2NqlMKoZCO
 mgcsAWmRyxkd/RwGLXl7qS1jVXN1r8Uh9gNNQceL/FlfQiV/Xhj4x7Yr2FizUQLyy0Xn
 +kwRs4wKGgHAYhfH6/wfOGywwlsReiP23GgnBY0/CXA7eg0Dzgi9Vx962c45XkML0zy+
 7lOBNjNNXU+k0TDuNyxbjo4k34b4GYJC+AWUV/Vsiy0+wpji/0iqtNtiYxZKTF2fkDbK
 ozgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765829094; x=1766433894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MizUUlNpjXIbwqKxnq224wGapMpxwlfA17G+ANK60nc=;
 b=YQX7peD6UU7rOZL+J5594XaoMquMayA/Ae6Q6SeHp5TKA4jbr1VGhPQe6zJUo541K2
 73vE36xagczXkxm45VLSTpqOe248IzcQD+AZsoDYAdAmShtWWIRHGgW5GKhkmw0K5Bf0
 EYY2MxyYg7Ft4N1d0WYQIuGZVE5/4Bngr4QaM4/ipVkb0SwSExLTAeS9e6fFiRU8mDhp
 4ceovGX1AkHwFcXqj5d3rfQoKsFVUTEAEDQNjUZU6oECJ8J5lv8CRmKmU+yzOM5tP1vN
 9MLO2RagVT07J2Rhalq8lvLLPIgMTi8h2AAIXwrM5PI1o3CsGOiFC70M+U9QWqUutW67
 Pwsg==
X-Gm-Message-State: AOJu0Yz8CN/lVbzR5lg6tklRiLFopNhkO2c36Q6nEmxtnyx9yEdkPLh+
 vHGw+sb1QvHR7ICxKuTwdH+7CBYqN3ff69zHHmeb7p312VmTLvrX1Da7YtVNjO50
X-Gm-Gg: AY/fxX5EXwBnzzvvpfR09/0ZUaFgiamsubPxjk7Ew4poslj/zz+ITXRFnKVHwPfMU/G
 Rc9ryzg4Zqe24Wwqd+AeGYO1mX4EqJK0DJdIivpVuP4gbyKqPkTR7iLWEsBqhb8hd3Aa2doiWi5
 Y9dRpnyU8Wubaqfk8YjdAelnmTgqAtAJKWJIibR1cI4eHXH859h1ZNR4MhNGA6oZHJzznsMVKkt
 SXXLaBG2ddDHCPo3oBD3oCcehmBRpJwOBoZ4ue0fC0/Y+Mtxxzbw0f5odnHee1aUzDyjZslhRQd
 Ds8N7MpH7NzFMruosjU/cjQlQjxiLIQnWRMy+exwlYCfGDUmVMM2n3X4dCV2pbWxQvo2j57IYVg
 geLjHbhxPTY8aHtr+2fVmV0n4MS9NsJiW6ZpibsmepzO6qoqkEfKr0EUKe6RtjOC7JjZRO6UUOt
 DieZtW70RGxODO0qePaPTFLaC5l0uzmYaIz1NVZAtBhw==
X-Google-Smtp-Source: AGHT+IExba6SPXoagxav5/xRmbJklcXvqVmknCIdGWDZwJxrozrm/rBOTXhJNd/MfY9pQbg14GJWWA==
X-Received: by 2002:a05:600d:486:20b0:477:991c:a17c with SMTP id
 5b1f17b1804b1-47a89da4685mr127957215e9.6.1765829094118; 
 Mon, 15 Dec 2025 12:04:54 -0800 (PST)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f703efesm72603235e9.16.2025.12.15.12.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:04:53 -0800 (PST)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v1 1/6] hw/arm/sabrelite: Convert machine to full class
Date: Mon, 15 Dec 2025 21:03:10 +0100
Message-ID: <4bece01078549fe0565af4cd28df46da97a372fb.1765826753.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765826753.git.matyas.bobek@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x344.google.com
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

Define SABRELITE_MACHINE manually instead of
DEFINE_MACHINE_ARM to allow "canbus*" machine
properties to be added later.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
---
 hw/arm/sabrelite.c | 54 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 5b4ab7d77a..29418af190 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -20,6 +20,16 @@
 #include "qemu/error-report.h"
 #include "system/qtest.h"
 
+typedef struct SabreliteMachineState {
+    MachineState parent_obj;
+    FslIMX6State soc;
+
+    struct arm_boot_info binfo;
+} Sabrelite;
+
+#define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
+OBJECT_DECLARE_SIMPLE_TYPE(SabreliteMachineState, SABRELITE_MACHINE)
+
 static struct arm_boot_info sabrelite_binfo = {
     /* DDR memory start */
     .loader_start = FSL_IMX6_MMDC_ADDR,
@@ -41,7 +51,7 @@ static void sabrelite_reset_secondary(ARMCPU *cpu,
 
 static void sabrelite_init(MachineState *machine)
 {
-    FslIMX6State *s;
+    Sabrelite *s = SABRELITE_MACHINE(machine);
 
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > FSL_IMX6_MMDC_SIZE) {
@@ -50,13 +60,12 @@ static void sabrelite_init(MachineState *machine)
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
@@ -70,7 +79,7 @@ static void sabrelite_init(MachineState *machine)
         /* Add the sst25vf016b NOR FLASH memory to first SPI */
         Object *spi_dev;
 
-        spi_dev = object_resolve_path_component(OBJECT(s), "spi1");
+        spi_dev = object_resolve_path_component(OBJECT(&s->soc), "spi1");
         if (spi_dev) {
             SSIBus *spi_bus;
 
@@ -89,23 +98,33 @@ static void sabrelite_init(MachineState *machine)
                 qdev_realize_and_unref(flash_dev, BUS(spi_bus), &error_fatal);
 
                 cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
-                qdev_connect_gpio_out(DEVICE(&s->gpio[2]), 19, cs_line);
+                qdev_connect_gpio_out(DEVICE(&s->soc.gpio[2]), 19, cs_line);
             }
         }
     }
 
+
     sabrelite_binfo.ram_size = machine->ram_size;
     sabrelite_binfo.secure_boot = true;
     sabrelite_binfo.write_secondary_boot = sabrelite_write_secondary;
     sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &sabrelite_binfo);
+        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
     }
 }
 
-static void sabrelite_machine_init(MachineClass *mc)
+static void sabrelite_machine_instance_init(Object *obj)
 {
+    Sabrelite *s = SABRELITE_MACHINE(obj);
+
+    (void)s;
+}
+
+static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
     mc->init = sabrelite_init;
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
@@ -114,4 +133,19 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("sabrelite", sabrelite_machine_init)
+static const TypeInfo sabrelite_machine_init_typeinfo = {
+    .name       = TYPE_SABRELITE_MACHINE,
+    .parent     = TYPE_MACHINE,
+    .class_init = sabrelite_machine_class_init,
+    .instance_init = sabrelite_machine_instance_init,
+    .instance_size = sizeof(Sabrelite),
+    .abstract   = false,
+    .interfaces = arm_machine_interfaces,
+};
+
+static void sabrelite_machine_init_register_types(void)
+{
+    type_register_static(&sabrelite_machine_init_typeinfo);
+}
+
+type_init(sabrelite_machine_init_register_types)
-- 
2.52.0


