Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05A1C5B567
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVCx-0001ZU-5C; Mon, 10 Aug 2026 14:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCv-0001Z2-K3; Mon, 10 Aug 2026 14:58:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCt-0003UV-9y; Mon, 10 Aug 2026 14:58:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGVtnv292855; Mon, 10 Aug 2026 18:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AqhPQ1Q9hfplNQ2nS
 zeEDUlFwpKQrrNt7URNcAzMZlI=; b=If2ZGqk7DO35SdZcz3t2SD4o5cEDiHNJ0
 OfEF3sYwaKBjcy1PRJ1l5YOnGyMmqihOgtFX89CUb5nORJB57sv6Pt0zFdJl3GwF
 ulwpo8gcsCWzud1Woa3mXc0Bt9DBSaRtckYe/jgdbohw/pjnl63bcSpQ601USXyc
 H4N1n30b2zRnI7qmJJjWbyRD4QL4+GyifY+1p5rGVwLwkKPVe9cif4KklFms0C7X
 ctDBMc2oifAqGCj7ksefB1UMvZT4XgWjzKRED8B9k9+My7YdxCL2yK1HkxUY5siN
 hAiypJ/UC3mOI5JHu9SfAip1SHqwcVtg47NKQnkw58B79cteiRckA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjysmke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIuLno031725;
 Mon, 10 Aug 2026 18:57:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g5wek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AIvupT30671558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 18:57:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3135358051;
 Mon, 10 Aug 2026 18:57:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9253E5805A;
 Mon, 10 Aug 2026 18:57:55 +0000 (GMT)
Received: from IBM-MFS.ibm.com (unknown [9.61.24.176])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 18:57:55 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] ufs/aspeed: Add AST2700 UFS host controller
Date: Mon, 10 Aug 2026 13:57:45 -0500
Message-ID: <20260810185748.1253-8-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810185748.1253-1-mikail.sadic@ibm.com>
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX3ZvfY4b9RI8q
 k5GCsFt/K1o259L5O6d2Ilw2lgCrafGNdQ0rTTbrwbib9QyQficD+qIdSYPiI0zFqGdBQg7hHlu
 p/ksuSLAAOtBgx7qKpUajN7Zf1tbXzmauq1xA9b9Kx/f9M4trdxb59Du/3xjIqasiJ/glrPuRuQ
 DrFpKFNrbgJ+41oEHih5DgjiH9FKMsdMxzz+Rsdy8F5qlKugZhD/82YFPkvyuMhXlUNgD23HYaF
 jKR6DKmJVKuJy2FVGtYn7tsMsqHqm4miOtptjy0aJZyWAEcXNF5d7f09Q6yhXCLX+ctUx3tmwzP
 tbD9G1g+Kbh2x82uwjQCzyodK3IUOhcq4k81n+Hu68o6Rdrwxhg/urzuLY3n8BwfS4IIN79ryHw
 PzPbLzt2T3k3xDWKkMi1Q7nznvy3Y1Q+2yyfmTj1fAAip8fCKTb+s74oXWHOx6IYVwJMzkPUWuF
 aZviWxlmv+05qU2Weug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfXwJ+PTvhoPexe
 klXwJO4FZeuq7Sf6B3JOlhclgkJyR/xR4TLURJcxfiMsuiB8dlVadv29C7wFuBzKI0GDRiR+oU0
 3E4L/U0sTXOYi/+YWB3vtPot2SpZNTM=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a1f36 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8
 a=ATOKqi0wAkDwqrHMCoMA:9
X-Proofpoint-GUID: u9OUWINL-Buua42nQFQh0N3VoybuUwRs
X-Proofpoint-ORIG-GUID: AoxkxqbdErwQZa0bkWVQT0vCexm0PqaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100158
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The AST2700 carries a UFS host controller (aspeed,ufshc-m31-16nm) at
0x12c08200 on IRQ 118, used by the OpenBMC image to reach its root
filesystem.

Add 'aspeed-ufs' as a subclass of the generic sysbus UFS controller. The
sysbus device supplies the MMIO region, the interrupt, the DMA address
space and the controller properties, so the only thing left to model is
the UFSHCI version: the AST2700 reports 2.0, while the core reports 4.1,
which makes the U-Boot and Linux drivers run 4.x-only probe steps this
model does not implement.

Wire the controller into the AST2700 SoC and select UFS_SYSBUS, so an
Aspeed target no longer depends on the PCI UFS device being configured
to get a UFS controller.

The UFS bus only exists once the controller is realized, so the board
creates the logical unit for the first backend drive after SoC realize
rather than through a controller drive property. AspeedMachineClass
gains a ufs_block_size field for machines whose image geometry differs
from the ufs-lu default; zero leaves the default in place.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 MAINTAINERS                 |  2 ++
 docs/specs/aspeed-ufs.rst   | 46 +++++++++++++++++++++++++
 docs/specs/index.rst        |  1 +
 include/hw/arm/aspeed.h     |  1 +
 include/hw/arm/aspeed_soc.h |  3 ++
 include/hw/ufs/aspeed_ufs.h | 15 +++++++++
 hw/arm/aspeed.c             | 25 ++++++++++++++
 hw/arm/aspeed_ast27x0.c     | 13 +++++++
 hw/ufs/aspeed_ufs.c         | 67 +++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig              |  1 +
 hw/ufs/meson.build          |  1 +
 11 files changed, 175 insertions(+)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/ufs/aspeed_ufs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ec415cb8e4..4b335c5dc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2700,6 +2700,8 @@ M: Jeuk Kim <jeuk20.kim@samsung.com>
 S: Supported
 F: hw/ufs/*
 F: include/block/ufs.h
+F: include/hw/ufs/aspeed_ufs.h
+F: docs/specs/aspeed-ufs.rst
 F: tests/qtest/ufs-test.c
 
 megasas
diff --git a/docs/specs/aspeed-ufs.rst b/docs/specs/aspeed-ufs.rst
new file mode 100644
index 0000000000..2ab7e7e771
--- /dev/null
+++ b/docs/specs/aspeed-ufs.rst
@@ -0,0 +1,46 @@
+ASPEED AST2700 UFS Host Controller
+===================================
+
+The AST2700 SoC includes a UFS host controller identified in the device tree
+as ``aspeed,ufshc-m31-16nm``, mapped at ``0x12c08200`` (IRQ SPI 118).
+
+QEMU models it as ``aspeed-ufs``, a subclass of the generic sysbus UFS
+controller ``sysbus-ufs`` (``hw/ufs/ufs-sysbus.c``), which in turn wraps the
+transport-independent UFS core (``hw/ufs/ufs.c`` and ``hw/ufs/lu.c``) that
+also backs the PCI UFS device. The sysbus device provides the MMIO region,
+the interrupt line, the DMA address space and the controller properties; the
+core implements the UFSHCI registers, the UTP transfer and task list
+processing, the UPIU and query handling and the SCSI logical-unit logic.
+
+The only AST2700-specific behaviour ``aspeed-ufs`` adds is the controller
+version register value ``0x00000200``, the UFSHCI 2.0 interface the hardware
+reports.
+
+The clock/reset wrapper at ``0x12c08000`` (``aspeed,ast2700-ufscnr``) is left
+as an ``UnimplementedDevice``.
+
+Logical units
+-------------
+
+Storage is attached through ``ufs-lu`` devices on the controller's UFS bus
+(``ufs-bus.0``), exactly as for the PCI UFS device. The Huygens OpenBMC image
+is laid out for 512-byte sectors, so its logical unit is created with
+``logical-block-size=512``.
+
+Usage
+-----
+
+Attach a UFS image as logical unit 0 of the controller's UFS bus:
+
+.. code-block:: console
+
+  qemu-system-aarch64 -M huygens-bmc \
+    -nodefaults \
+    -blockdev node-name=fmc0,driver=file,filename=image-bmc \
+    -device w25q01jvq,bus=ssi.0,cs=0,drive=fmc0 \
+    -blockdev node-name=ufs0,driver=file,filename=ufs.img \
+    -device ufs-lu,bus=ufs-bus.0,drive=ufs0,lun=0,logical-block-size=512 \
+    -display none -serial mon:stdio
+
+Please check :doc:`../../system/arm/aspeed` for more details on the
+``huygens-bmc`` machine.
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 4de65e2fdf..dd0cdec8d4 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -40,4 +40,5 @@ guest hardware that is specific to QEMU.
    riscv-aia
    aspeed-intc
    ucd90320
+   aspeed-ufs
    iommu-testdev
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index a00238ed74..dedc784926 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -62,6 +62,7 @@ struct AspeedMachineClass {
     uint32_t uart_default;
     bool sdhci_wp_inverted;
     bool vbootrom;
+    uint32_t ufs_block_size;
 };
 
 /*
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 41dc04e293..8a562d47ec 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -35,6 +35,7 @@
 #include "hw/gpio/aspeed_gpio.h"
 #include "hw/gpio/aspeed_sgpio.h"
 #include "hw/sd/aspeed_sdhci.h"
+#include "hw/ufs/aspeed_ufs.h"
 #include "hw/usb/hcd-ehci.h"
 #include "qom/object.h"
 #include "hw/misc/aspeed_lpc.h"
@@ -118,6 +119,7 @@ struct AspeedSoCState {
     AspeedAPB2OPBState fsi[2];
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
     AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
+    SysbusUfsState ufs;
 };
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -298,6 +300,7 @@ enum {
     ASPEED_DEV_PRIC0,
     ASPEED_DEV_PRIC1,
     ASPEED_DEV_OTP,
+    ASPEED_DEV_UFS,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
diff --git a/include/hw/ufs/aspeed_ufs.h b/include/hw/ufs/aspeed_ufs.h
new file mode 100644
index 0000000000..6b9f85498a
--- /dev/null
+++ b/include/hw/ufs/aspeed_ufs.h
@@ -0,0 +1,15 @@
+/*
+ * ASPEED AST2700 UFS Host Controller
+ *
+ * Copyright 2026 IBM Corp.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_UFS_H
+#define ASPEED_UFS_H
+
+#include "hw/ufs/ufs-sysbus.h"
+
+#define TYPE_ASPEED_UFS "aspeed-ufs"
+
+#endif /* ASPEED_UFS_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a48c442058..b70a1326a1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -187,6 +187,31 @@ static void aspeed_machine_init(MachineState *machine)
     aspeed_connect_serial_hds_to_uarts(bmc);
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
+    /*
+     * If the SoC instantiated a UFS host controller (AST2700), attach the
+     * first backend drive to it as logical unit 0.  The controller and its
+     * UFS bus only exist once the SoC has been realized, so the ufs-lu is
+     * created here rather than through a controller drive property.
+     */
+    if (object_resolve_path_component(OBJECT(bmc->soc), "ufs")) {
+        DriveInfo *ufs_dinfo = drive_get(IF_NONE, 0, 0);
+
+        if (ufs_dinfo) {
+            DeviceState *ufs_lu = qdev_new(TYPE_UFS_LU);
+
+            qdev_prop_set_uint8(ufs_lu, "lun", 0);
+            if (amc->ufs_block_size) {
+                qdev_prop_set_uint32(ufs_lu, "logical-block-size",
+                                     amc->ufs_block_size);
+            }
+            qdev_prop_set_drive_err(ufs_lu, "drive",
+                                    blk_by_legacy_dinfo(ufs_dinfo),
+                                    &error_fatal);
+            qdev_realize_and_unref(ufs_lu, BUS(&bmc->soc->ufs.ufs.bus),
+                                   &error_fatal);
+        }
+    }
+
     if (defaults_enabled()) {
         aspeed_board_init_flashes(&bmc->soc->fmc,
                               bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index b908d7d4ff..1ee8f3a210 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -46,6 +46,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_GIC_REDIST]    =  0x12280000,
     [ASPEED_DEV_SDMC]      =  0x12C00000,
     [ASPEED_DEV_SCU]       =  0x12C02000,
+    [ASPEED_DEV_UFS]       =  0x12c08200,
     [ASPEED_DEV_RTC]       =  0x12C0F000,
     [ASPEED_DEV_TIMER1]    =  0x12C10000,
     [ASPEED_DEV_PCIE_PHY0] =  0x12C15000,
@@ -129,6 +130,7 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_EHCI2]     = 37,
     [ASPEED_DEV_PCIE0]     = 56,
     [ASPEED_DEV_PCIE1]     = 57,
+    [ASPEED_DEV_UFS]       = 118,
     [ASPEED_DEV_LPC]       = 192,
     [ASPEED_DEV_IBT]       = 192,
     [ASPEED_DEV_KCS]       = 192,
@@ -533,6 +535,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
     object_initialize_child(obj, "emmc-controller.sdhci", &s->emmc.slots[0],
                             TYPE_SYSBUS_SDHCI);
 
+    object_initialize_child(obj, "ufs", &s->ufs, TYPE_ASPEED_UFS);
+
     snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
     object_initialize_child(obj, "timerctrl", &s->timerctrl, typename);
 
@@ -1039,6 +1043,15 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_EMMC));
 
+    /* UFS */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ufs), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ufs), 0,
+                    sc->memmap[ASPEED_DEV_UFS]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ufs), 0,
+                       aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_UFS));
+
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
                              &error_abort);
diff --git a/hw/ufs/aspeed_ufs.c b/hw/ufs/aspeed_ufs.c
new file mode 100644
index 0000000000..bfe540b929
--- /dev/null
+++ b/hw/ufs/aspeed_ufs.c
@@ -0,0 +1,67 @@
+/*
+ * ASPEED AST2700 UFS Host Controller
+ *
+ * The AST2700 host controller (aspeed,ufshc-m31-16nm) is the generic sysbus
+ * UFS controller, so this model only overrides the UFSHCI version.
+ *
+ * The clock/reset wrapper at 0x12c08000 (aspeed,ast2700-ufscnr) is modelled
+ * elsewhere as an UnimplementedDevice.
+ *
+ * Copyright 2026 IBM Corp.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/ufs/aspeed_ufs.h"
+
+/* UFSHCI 2.0, against the 4.1 the core reports */
+#define ASPEED_UFS_HCI_VERSION 0x00000200
+
+OBJECT_DECLARE_TYPE(AspeedUfsState, AspeedUfsClass, ASPEED_UFS)
+
+struct AspeedUfsState {
+    SysbusUfsState parent_obj;
+};
+
+struct AspeedUfsClass {
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
+static void aspeed_ufs_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    AspeedUfsClass *ac = ASPEED_UFS_GET_CLASS(dev);
+    SysbusUfsState *s = SYSBUS_UFS(dev);
+
+    ac->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    s->ufs.reg.ver = ASPEED_UFS_HCI_VERSION;
+}
+
+static void aspeed_ufs_class_init(ObjectClass *oc, const void *data)
+{
+    AspeedUfsClass *ac = ASPEED_UFS_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    device_class_set_parent_realize(dc, aspeed_ufs_realize,
+                                    &ac->parent_realize);
+    dc->desc = "ASPEED UFS Host Controller";
+}
+
+static const TypeInfo aspeed_ufs_types[] = {
+    {
+        .name          = TYPE_ASPEED_UFS,
+        .parent        = TYPE_SYSBUS_UFS,
+        .instance_size = sizeof(AspeedUfsState),
+        .class_size    = sizeof(AspeedUfsClass),
+        .class_init    = aspeed_ufs_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ufs_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ac44740547..14a076f4f9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -557,6 +557,7 @@ config ASPEED_SOC
     select MAX31785
     select UCD90320
     select FSI_APB2OPB_ASPEED
+    select UFS_SYSBUS
     select AT24C
     select PCI_EXPRESS
     select PCI_EXPRESS_ASPEED
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
index a84627b96a..9266a580f5 100644
--- a/hw/ufs/meson.build
+++ b/hw/ufs/meson.build
@@ -1,3 +1,4 @@
 system_ss.add(when: 'CONFIG_UFS', if_true: files('ufs.c', 'lu.c'))
 system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs-pci.c'))
 system_ss.add(when: 'CONFIG_UFS_SYSBUS', if_true: files('ufs-sysbus.c'))
+system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_ufs.c'))
-- 
2.53.0


