Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E7FC5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpX5S-0004SU-Bz; Thu, 30 Jul 2026 16:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX5R-0004Ri-24; Thu, 30 Jul 2026 16:10:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX5O-0001hy-M4; Thu, 30 Jul 2026 16:10:36 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJmH4L2081231; Thu, 30 Jul 2026 20:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FWH5fKEXgV1pyhFdq
 EV8/wNsqC10HjLI7+sxkBzqIC8=; b=LpH/8kojEHKnDEqZ3UDHpDV/hhbnEN0X2
 zQ8znmDfXpIr8kK6PgnqDocfeyR9lu3cilXJ1aNlgZ2i1ROdlTRlGgekpNM/VwLK
 sR5D4fae7YHbfph1xcBTirjIF0Ee4vAAio9kldcqPekpkKHeqHUySurYEX5zglRf
 a9fY6pQgnJ1PfZ6ZYgWuY6uNfuP17oANrhQGZrdrTc8qDoc5Cl9e731bl07y5jXG
 ky59ZAAhTuP8WRXN1xDAICy2AOjAxiP7ZTXzBqqaPHkd8IXsjTofAwqez6MdQN/u
 fNG8eiqbjKae/eVOEoP2emVnVPPNkdW4KMTM9PIDmWfhS8f6Wn1iQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycsmhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UJuFfK017022;
 Thu, 30 Jul 2026 20:09:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgmsm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UK9orw5964432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 20:09:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 143C158043;
 Thu, 30 Jul 2026 20:09:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE0BB58059;
 Thu, 30 Jul 2026 20:09:49 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 20:09:49 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] ufs/aspeed: Add AST2700 sysbus UFS frontend
Date: Thu, 30 Jul 2026 15:09:42 -0500
Message-ID: <20260730200945.1113936-8-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730200945.1113936-1-mikail.sadic@ibm.com>
References: <20260730200945.1113936-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YEVZtXDm-DSnWaz_85lEP0r0jnetkZSi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfX0WxJXGdwxGl2
 3LcIarXuILV4maGCeYZPYwLDYm8OQjRCOBm+AI+r8Sk+jnqIsLgh2Z9XybiK9QWayB23BJsq90F
 d0rTOsmAZyND2DSuQti2qsusDKBrjv6o2qiHA78GEj5ztieBijW0UC7vL0Wjxg21hFeyzHq2obF
 eSQ7l+gW9PdAb8jde2pPYiCVKqsyabtGklz7ZzCEL9fk9p813xUnbdmBC9rKYeAzUXRSQXWlxXD
 3DaZxfyHrCZt02ibMIdCoursYHn6QYcNouTz7dwES0qMMjzZW3iU6993eqAY7HxNr5PyMBENUrq
 +Wicz0G8tpONw29M8kJqhu6xKFnx6AKUspJ1KrspmhpdZNy4fDwn/LA6Qlua9zb72ypJoPFIiqu
 vCXN04iFPKQI8lqgAp1dWWwTdrhXvyFSC1nndCyZJS+vbVPm5y1B7DHruko1iv/m7eV8WBnPD0P
 u5IvE94mY1zhHFGwwGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfXzwrId/mPb1pB
 2CU8+116k4eY/OQw6IwcyJXBHbakk6IdqRJzOuc2qcRs+L0kwNHIy1fbczCe7ed23oG1k5QRHom
 iq9B3w9wiAyuWEZs1uDY4l8XQWabM3U=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6baf91 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8
 a=3Ht_1UATksvqfbOLzXUA:9
X-Proofpoint-GUID: C8vwfhOB7860XLOsy7cT3YYkMREV46q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300145
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

Add TYPE_ASPEED_UFS, a sysbus frontend around the common UFS core,
and wire it into the AST2700 SoC. The frontend reuses UfsHc
(instance_size = sizeof(UfsHc)), sets dma_as to address_space_memory,
and calls ufs_realize_core() before exposing its MMIO region and IRQ via
sysbus. It reports UFSHCI 2.0 (reg.ver = 0x0200) to match the AST2700
(aspeed,ufshc-m31-16nm).

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 MAINTAINERS                 |  1 +
 docs/specs/aspeed-ufs.rst   | 40 ++++++++++++++++++++
 docs/specs/index.rst        |  1 +
 include/hw/arm/aspeed.h     |  1 +
 include/hw/arm/aspeed_soc.h |  3 ++
 include/hw/ufs/aspeed_ufs.h | 16 ++++++++
 hw/arm/aspeed.c             | 25 +++++++++++++
 hw/arm/aspeed_ast27x0.c     | 13 +++++++
 hw/ufs/aspeed_ufs.c         | 75 +++++++++++++++++++++++++++++++++++++
 hw/ufs/meson.build          |  1 +
 10 files changed, 176 insertions(+)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/ufs/aspeed_ufs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ec415cb8e4..abebae2ff9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2700,6 +2700,7 @@ M: Jeuk Kim <jeuk20.kim@samsung.com>
 S: Supported
 F: hw/ufs/*
 F: include/block/ufs.h
+F: include/hw/ufs/aspeed_ufs.h
 F: tests/qtest/ufs-test.c
 
 megasas
diff --git a/docs/specs/aspeed-ufs.rst b/docs/specs/aspeed-ufs.rst
new file mode 100644
index 0000000000..596b5d2756
--- /dev/null
+++ b/docs/specs/aspeed-ufs.rst
@@ -0,0 +1,40 @@
+ASPEED AST2700 UFS Host Controller
+===================================
+
+The AST2700 SoC includes a UFS host controller identified in the device tree
+as ``aspeed,ufshc-m31-16nm``, mapped at ``0x12c08200`` (IRQ SPI 118). QEMU
+models it as a sysbus frontend on top of the shared UFS core that also backs
+the PCI UFS device (``hw/ufs/ufs.c`` and ``hw/ufs/lu.c``). The frontend only
+provides the sysbus MMIO region, the interrupt line and the DMA address
+space; all UFSHCI register behaviour, UTP transfer/task list processing,
+UPIU and query handling and the SCSI logical-unit logic are implemented by
+the core.
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
index 41dc04e293..56fab0a350 100644
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
+    UfsHc ufs;
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
index 0000000000..1ccd0b51c0
--- /dev/null
+++ b/include/hw/ufs/aspeed_ufs.h
@@ -0,0 +1,16 @@
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
+#include "hw/ufs/ufs.h"
+
+#define TYPE_ASPEED_UFS "aspeed-ufs"
+#define ASPEED_UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_ASPEED_UFS)
+
+#endif /* ASPEED_UFS_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a48c442058..5b9943a0e0 100644
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
+            qdev_realize_and_unref(ufs_lu, BUS(&bmc->soc->ufs.bus),
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
index 0000000000..d3e1a9a736
--- /dev/null
+++ b/hw/ufs/aspeed_ufs.c
@@ -0,0 +1,75 @@
+/*
+ * ASPEED AST2700 UFS Host Controller
+ *
+ * Sysbus frontend for the AST2700 UFS host controller
+ * (aspeed,ufshc-m31-16nm).  The UFSHCI register interface, UTRL/UTMRL
+ * processing, UPIU/query handling and the SCSI/logical-unit logic are all
+ * provided by the shared UFS core (hw/ufs/ufs.c, hw/ufs/lu.c); this file
+ * only supplies the sysbus-specific MMIO, IRQ and DMA plumbing.
+ *
+ * The ASPEED clock/reset wrapper at 0x12c08000 (aspeed,ast2700-ufscnr) is
+ * modelled elsewhere as an UnimplementedDevice.
+ *
+ * Copyright 2026 IBM Corp.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "system/address-spaces.h"
+#include "hw/ufs/aspeed_ufs.h"
+
+static void aspeed_ufs_realize(DeviceState *dev, Error **errp)
+{
+    UfsHc *u = ASPEED_UFS(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* AST2700 UFS masters DMA into system memory. */
+    u->dma_as = &address_space_memory;
+
+    if (!ufs_realize_core(u, errp)) {
+        return;
+    }
+
+    /*
+     * The AST2700 host controller (aspeed,ufshc-m31-16nm) reports UFSHCI
+     * version 2.0. The shared core defaults to 4.1, which makes the U-Boot
+     * and Linux aspeed-ufs drivers run 4.x-only probe steps that this model
+     * does not implement. Pin the controller version register to 2.0.
+     */
+    u->reg.ver = 0x00000200;
+
+    ufs_init_mmio(u);
+    sysbus_init_mmio(sbd, &u->iomem);
+    sysbus_init_irq(sbd, &u->irq);
+}
+
+static const Property aspeed_ufs_props[] = {
+    DEFINE_PROP_STRING("serial", UfsHc, params.serial),
+    DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
+    DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
+    DEFINE_PROP_UINT32("wb-max-size", UfsHc, params.wb_max_size, 0x400),
+    DEFINE_PROP_UINT32("wb-min-size", UfsHc, params.wb_min_size, 0x100),
+};
+
+static void aspeed_ufs_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = aspeed_ufs_realize;
+    dc->desc = "ASPEED UFS Host Controller";
+    device_class_set_props(dc, aspeed_ufs_props);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo aspeed_ufs_types[] = {
+    {
+        .name          = TYPE_ASPEED_UFS,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(UfsHc),
+        .class_init    = aspeed_ufs_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_ufs_types)
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
index 6e68328b93..86052e6fd2 100644
--- a/hw/ufs/meson.build
+++ b/hw/ufs/meson.build
@@ -1 +1,2 @@
 system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs.c', 'lu.c'))
+system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_ufs.c'))
-- 
2.53.0


