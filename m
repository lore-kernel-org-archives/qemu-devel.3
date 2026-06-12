Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C37CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY53p-0007hG-T6; Fri, 12 Jun 2026 12:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4623e61353=eblot@meta.com>)
 id 1wY53o-0007gA-5l; Fri, 12 Jun 2026 12:48:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4623e61353=eblot@meta.com>)
 id 1wY53l-0007oF-3u; Fri, 12 Jun 2026 12:48:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C5xrd01867530; Fri, 12 Jun 2026 09:48:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=UW4lt0roWafYN8jzjK/PCUsJmmI/KdLUX3sywuexfl4=; b=hX6wcLsZtdVE
 MmW3TmOo489b2RqSDCervetCTG/4iZju83d8s3NYHxez2+Gjah1FhKDoM49vOLQY
 p5Gfk0DmB1lDt5TDv3y5vhZ7szmVbbVm4J/We+l/8Q2md0fQSdIUN0Vx8KIyyMKr
 g7Rewdul+NutIuBXFIs4tlrf012HVVg/fnrjdasldRwb7m1UHl7TRqkJLd+mH3tO
 eNkzbcVObvD0s99hZX/q6Wr314NhkWMxB5lu5rnSb2V0bDkOlJeZD4Cmx8djxvg/
 b6tm/T9rdt3W2cqSiw4z1oV1R/Q3fCtyNZUhFLbBQ0yqwAHe1Cex3xs28qnJKDcE
 N/HWn/A38Q==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ercf034r4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 12 Jun 2026 09:48:11 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Fri, 12 Jun
 2026 16:48:09 +0000
From: Emmanuel Blot <eblot@meta.com>
Date: Fri, 12 Jun 2026 18:47:02 +0200
Subject: [PATCH 3/4] hw/arm: anacapa: add ADC128D818 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-i2c-adc128d818-anacapa-v1-3-9e4640cd164b@meta.com>
References: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
In-Reply-To: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 "Jamin Lin" <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, <qemu-arm@nongnu.org>,
 Emmanuel Blot <eblot@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781282877; l=3453;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=5jm6W6C4SOyTwyd/zUTKKt1xHCZex8tImtbq4un/gkk=;
 b=O4fAfUNIbWFCpsMW3HuEhbxnssDu9kLTl/WTTlxz3NR11PwUMOapQd53UvFHHrwvAMxAdtTpJ
 sltrZ5d60MaBHNXXlINK670VWtIyJKA0Zaq6EmS+g3hPYjWUOO3ug8Y
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c085:208::f]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE1NSBTYWx0ZWRfX+FEYCYzTZnBs
 kUT8Bw8MCdv9WDe+f8LzKtDbRnZHlaPS0UDUvkcNooWyeOwiG1WbHBYQiF5BRNvK7IiUfaOCHDp
 IK+mqxDBq6aLlAoo0KYU2RK1dbGuRzI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE1NSBTYWx0ZWRfXyC1MxcqGVKSd
 ZQAOvWBa7gNEXE7fK7hCy2Rjkpc/Cad6Fy+BHd95Wl2djG0ckZ8h/TOsSI5J5MlAcs+GtmASfRu
 9nTa02pAs5YPYWaxQ/X1aOIxPxl1Q54ullBbxyiQzmJlz5iJ5ophe2Gamcb3O/QaykL8VBx3J3Y
 u1dxEIsqNkZ57Pa3Xnn14trAuSCZ4ACK5YTYNDAI2k2w4hm/CUL6LizNggD+1B3pp8c7psc1lmj
 +SKODtJHAFN8Xu4c0qflNKVzo9XdG63j4DkM8rN2yGgECtiw2i7eHXgh2YRDxgzczXl5C7H/8ko
 xxT27uo5sINFDCkA3cPmR+aPx4gapPte27YsCQbgk4Fd3llHWuuew0TSKjbSrEXOdooi49ULjup
 /rv7qZYYplq9FpdjzwrOe7xzAVOIHjzE4d3ADVX7Ze6qRBerpha/l3DhhsCSiCuDppXFxNRVdpD
 FXHSQfZuY8wolMa6lGQ==
X-Proofpoint-ORIG-GUID: xMqiPUPJJnPkWe3yaZ197HxmAjMUPhTa
X-Authority-Analysis: v=2.4 cv=QYhWeMbv c=1 sm=1 tr=0 ts=6a2c384b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8
 a=qgnhLYDG0d4QqU1ziEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: xMqiPUPJJnPkWe3yaZ197HxmAjMUPhTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=4623e61353=eblot@meta.com; helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wire up the two ADC128D818 instances that appear in the Anacapa DTS:
one on i2c8 mux channel 0 and one on i2c13 mux channel 3.

Signed-off-by: Emmanuel Blot <eblot@meta.com>
---
 hw/arm/Kconfig                  |  1 +
 hw/arm/aspeed_ast2600_anacapa.c | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fb798ccbee..04ecf5d473 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -553,6 +553,7 @@ config ASPEED_SOC
     select LED
     select PMBUS
     select MAX31785
+    select ADC128D818
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index a1c8111a93..7dc566d7fe 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/sensor/adc128d818.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
@@ -16,9 +17,11 @@
 #include "hw/nvram/eeprom_at24c.h"
 
 /* Anacapa hardware value */
+/* clang-format off */
 #define ANACAPA_BMC_HW_STRAP1 0x00002002
 #define ANACAPA_BMC_HW_STRAP2 0x00000000
 #define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+/* clang-format on */
 
 /*
  * "Anacapa HPM (MB)" FRU data. Generated with frugen.
@@ -221,6 +224,14 @@ static const uint8_t hpm_brd_id_eeprom[] = {
 };
 static const size_t hpm_brd_id_eeprom_len = sizeof(hpm_brd_id_eeprom);
 
+static void anacapa_add_adc128d818(I2CBus *bus, uint8_t addr,
+                                   const char *description)
+{
+    DeviceState *dev = DEVICE(i2c_slave_new(TYPE_ADC128D818, addr));
+    qdev_prop_set_string(dev, "description", description);
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
+}
+
 static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference: aspeed-bmc-facebook-anacapa.dts */
@@ -259,7 +270,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
 
     /* i2c8mux ch0 */
-    /* adc128d818@1f — no model */
+    /* adc128d818@1f — R-PDB ADC (mode 1: 8 voltage channels) */
+    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 0), 0x1f, "i2c8:0:1f");
     /* pca9555@22 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x22);
@@ -320,7 +332,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
 
     /* i2c13mux ch3 */
-    /* adc128d818@1f - no model */
+    /* adc128d818@1f — MB ADC (mode 1: 8 voltage channels) */
+    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 3), 0x1f, "i2c13:3:1f");
 
     /* i2c13mux ch4 */
     /* eeprom@51 */
@@ -350,6 +363,7 @@ static void aspeed_machine_anacapa_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
+/* clang-format off */
 static const TypeInfo aspeed_ast2600_anacapa_types[] = {
     {
         .name          = MACHINE_TYPE_NAME("anacapa-bmc"),
@@ -358,5 +372,6 @@ static const TypeInfo aspeed_ast2600_anacapa_types[] = {
         .interfaces    = arm_machine_interfaces,
     }
 };
+/* clang-format on */
 
 DEFINE_TYPES(aspeed_ast2600_anacapa_types)

-- 
2.50.1


