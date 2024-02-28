Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34970C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIOU-00067d-Pp; Wed, 28 Feb 2024 06:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rfIO6-0005sr-7g; Wed, 28 Feb 2024 06:46:19 -0500
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rfIO1-0002AK-8I; Wed, 28 Feb 2024 06:46:13 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 529B380660;
 Wed, 28 Feb 2024 12:46:04 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 9AwgNAgKPdLk; Wed, 28 Feb 2024 12:46:03 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 86024805D9;
 Wed, 28 Feb 2024 12:46:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 86024805D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709120763;
 bh=j1OLjRXz8cKZbnXoeuqFRRV9nutmUnwXbF7aVzmCyuQ=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=khpGOPMtVp5SHLHc2nyuqpLKJgr24LyMxMElUZRDMU6KgOtDQmRivyItioKXQ1qc2
 SelS0vMRnZwxpFJLEfXmknQcFJFHKBW1ly5teYU3nbdRMYYjKcjqsVxehlRuvOmXFz
 KkPUW7r1QTVaZeQ2vYPPyfN43s42bkDwqoRBI+LI=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id P5Go5bxz67PF; Wed, 28 Feb 2024 12:46:03 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id DA8C48065C;
 Wed, 28 Feb 2024 12:46:02 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 3/5] hw/arm : Create Bl475eMachineState
Date: Wed, 28 Feb 2024 12:32:01 +0100
Message-ID: <20240228114555.192175-4-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228114555.192175-1-ines.varhol@telecom-paris.fr>
References: <20240228114555.192175-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/b-l475e-iot01a.c | 44 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index d862aa43fc..2b570b3e09 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -2,8 +2,8 @@
  * B-L475E-IOT01A Discovery Kit machine
  * (B-L475E-IOT01A IoT Node)
  *
- * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
- * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
@@ -32,33 +32,51 @@
=20
 /* B-L475E-IOT01A implementation is derived from netduinoplus2 */
=20
-static void b_l475e_iot01a_init(MachineState *machine)
+#define TYPE_B_L475E_IOT01A MACHINE_TYPE_NAME("b-l475e-iot01a")
+OBJECT_DECLARE_SIMPLE_TYPE(Bl475eMachineState, B_L475E_IOT01A)
+
+typedef struct Bl475eMachineState {
+    MachineState parent_obj;
+
+    Stm32l4x5SocState soc;
+} Bl475eMachineState;
+
+static void bl475e_init(MachineState *machine)
 {
+    Bl475eMachineState *s =3D B_L475E_IOT01A(machine);
     const Stm32l4x5SocClass *sc;
-    DeviceState *dev;
=20
-    dev =3D qdev_new(TYPE_STM32L4X5XG_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_STM32L4X5XG_SOC);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
=20
-    sc =3D STM32L4X5_SOC_GET_CLASS(dev);
+    sc =3D STM32L4X5_SOC_GET_CLASS(&s->soc);
     armv7m_load_kernel(ARM_CPU(first_cpu),
-                       machine->kernel_filename,
-                       0, sc->flash_size);
+        machine->kernel_filename, 0, sc->flash_size);
 }
=20
-static void b_l475e_iot01a_machine_init(MachineClass *mc)
+static void bl475e_machine_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc =3D MACHINE_CLASS(oc);
     static const char *machine_valid_cpu_types[] =3D {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
     };
     mc->desc =3D "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
-    mc->init =3D b_l475e_iot01a_init;
+    mc->init =3D bl475e_init;
     mc->valid_cpu_types =3D machine_valid_cpu_types;
=20
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size =3D 0;
 }
=20
-DEFINE_MACHINE("b-l475e-iot01a", b_l475e_iot01a_machine_init)
+static const TypeInfo bl475e_machine_type[] =3D {
+    {
+        .name           =3D TYPE_B_L475E_IOT01A,
+        .parent         =3D TYPE_MACHINE,
+        .instance_size  =3D sizeof(Bl475eMachineState),
+        .class_init     =3D bl475e_machine_init,
+    }
+};
+
+DEFINE_TYPES(bl475e_machine_type)
--=20
2.43.2


