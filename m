Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFA2CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnW0-000517-Ho; Wed, 17 Jun 2026 06:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4628a4021f=eblot@meta.com>)
 id 1wZnUl-0004Av-Hf; Wed, 17 Jun 2026 06:27:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4628a4021f=eblot@meta.com>)
 id 1wZnUG-00080Y-9j; Wed, 17 Jun 2026 06:27:43 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H92DRm3616862; Wed, 17 Jun 2026 03:26:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=Ft9B13DmtIZN3rSeHDUU//9lFFJnQLAjLhD4LQNLrrs=; b=irwvAaSjmLSk
 ODaesUHus57tttnBGo/yeEpwMJM8oXRC0Uauw7pOsuE/ABeye3gjKPfwLuHQPwMB
 KMCsUH/zfjYgHj9UGJOzTFgBYflb+wu3S/+5tjmNu1d/okEUADj+LbVSb2p4YtN+
 Z5oLOOqLcNXByx7tV01KysJOTYakw4RRp7uhdfOt+v4/soa8nNPyP3n2hKMD8reh
 TeuSlyCIR2nbdDUl8q4m42w/obmoI1/pE/fOlXlstcxTkwDfRku1lJ8sTKU73Yos
 k817FeAzkNhBo3nWyGje0DX4IFqENJ6RC+2+MwBma55DWGvDJymh49UxJvLVbtdq
 A4FZGyv8tw==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueh13gbw-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 17 Jun 2026 03:26:38 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 17 Jun
 2026 10:26:36 +0000
From: Emmanuel Blot <eblot@meta.com>
Date: Wed, 17 Jun 2026 12:26:02 +0200
Subject: [PATCH v2 3/4] hw/arm: anacapa: add ADC128D818 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260617-i2c-adc128d818-anacapa-v2-3-fd38764f0465@meta.com>
References: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
In-Reply-To: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781691985; l=2857;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=ba+SGL39DSQnp4XkhtND2+kjLa/+DABvQWlL9O6paiE=;
 b=OI1uXMGrCsRIgD7TEmRM1vtbNDjxZ9bFNQNpxr05IwyjcLTU7woIW/uzwGYgaSlNrArNTvuf/
 /tIFPE9Ycm/CQVDEZVNlJQRW0HL2UCo6OM9Dn2+DJcOOHSuDPECdIE9
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c0a8:1c::1b]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5OCBTYWx0ZWRfX52/rCPq8I60I
 UVsZghEqgkEa55QhekYuDKBnyJ7EtOXmmzeV+oWX/aXtiDQTecElf+Dk4ko0XxrgzKcBpdzJJW1
 v98fnm4kEcAjtoG69jhYAEnfqWHXdYE=
X-Proofpoint-GUID: GjmwVHEtuW19TcW8Es9NBvyoB_gzGJGV
X-Authority-Analysis: v=2.4 cv=O6cJeh9W c=1 sm=1 tr=0 ts=6a32765e cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=VabnemYjAAAA:8
 a=29MC50mZdBDcY4WmDOIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: GjmwVHEtuW19TcW8Es9NBvyoB_gzGJGV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5OCBTYWx0ZWRfX3MnLUelZrZya
 ATKlI+euEDTcfKBRH6djjQu7Of5b8fJgzlMb2O0jxZEjAIZ/mWpff4YI/CU3jaEYY5ulH8XUHDL
 ySa3k4sGho+4yNKVroBiUbTU9Zux0mkQuc4F9bOwhmsiJKeSaE1zv+/MMUe55HNXmFd6J+r7/PQ
 bb4raV46Z2JNJNkJhRsDeVKNwNxbo9S2ba/kdiD1BHfYBIOY11ls+T+nvV72xr8E2C3ltFEssFN
 eh756gBdX/9eT2zbRSAfJJCi/ogGaRZ1VfAVmUCJvqUnw91c7vHWNx8MjwyoEG+cUFHviI7iZha
 WSEghInV18I5XpNFuGh0emLS+i8U94MvUFtsEUN6mT9lnYKQlVQN2o40JlT+AgfotOpQSPjgiON
 l2QbSXEcUpSE2Fs533cdiKAx6+B2jbq6nTKcioGtnuFJSJjMRZ+Xge8QLERz35oXwZ8GXiRM+6Q
 Se16nvInZ0Gb7HxnoVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=4628a4021f=eblot@meta.com; helo=mx0a-00082601.pphosted.com
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
 hw/arm/aspeed_ast2600_anacapa.c | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

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
index a1c8111a93..8f94a830e5 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/sensor/adc128d818.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
@@ -15,7 +16,6 @@
 #include "hw/gpio/pca9552.h"
 #include "hw/nvram/eeprom_at24c.h"
 
-/* Anacapa hardware value */
 #define ANACAPA_BMC_HW_STRAP1 0x00002002
 #define ANACAPA_BMC_HW_STRAP2 0x00000000
 #define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
@@ -221,6 +221,14 @@ static const uint8_t hpm_brd_id_eeprom[] = {
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
@@ -259,7 +267,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
 
     /* i2c8mux ch0 */
-    /* adc128d818@1f — no model */
+    /* adc128d818@1f — R-PDB ADC (mode 1: 8 voltage channels) */
+    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 0), 0x1f, "i2c8:0:1f");
     /* pca9555@22 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x22);
@@ -320,7 +329,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
 
     /* i2c13mux ch3 */
-    /* adc128d818@1f - no model */
+    /* adc128d818@1f — MB ADC (mode 1: 8 voltage channels) */
+    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 3), 0x1f, "i2c13:3:1f");
 
     /* i2c13mux ch4 */
     /* eeprom@51 */

-- 
2.50.1


