Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E5DC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2bA-0006u4-DM; Wed, 15 Jul 2026 12:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wk1tM-00008a-DN; Wed, 15 Jul 2026 11:51:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wk1tH-0004jg-Px; Wed, 15 Jul 2026 11:51:24 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FEC15Y2698944; Wed, 15 Jul 2026 15:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=O84bCrStLvfg/OyBG
 U0blaohEnHm4zFvCLFn6OF6QQc=; b=GRkIwFTTn6HflYYCwXvPKG3YCppV68X+K
 djROwX5FFyYEUrgvPsH6hM5S/+13JWpbakBtZp9wQ2dHyyPeOBqY/9FPWBr996sx
 U2Wj3CtDa4qwA3ChSqGZSZGHGbOwwhlb3vsYY0w7jGho7zTo0wtpJ7wsRJPwQLFG
 dzNGxaMnElQgE87OLuQNRUF67m7fYeaFxqQ+fVlgyS4Hb73oHkpRg9cWsqQ0Yvng
 A4WZVo+MteEXkERDaaB2AeZLTmhIrKTjhmDxzRQtSFqWR28p1KUzeWJXc4fN9MW8
 /gMXPA9HSGNPyeotgon94ja8POoNqHryvY6qgSpWfPm3Qkkest0fA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33cwt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:50:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FFnm63004316;
 Wed, 15 Jul 2026 15:50:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k0qtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:50:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FFomgs25494138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 15:50:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 337B758063;
 Wed, 15 Jul 2026 15:50:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3523058059;
 Wed, 15 Jul 2026 15:50:47 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.53.88])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 15:50:47 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@us.ibm.com,
 milesg@ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v1 4/5] ufs/aspeed: Add AST2700 UFS host controller
Date: Wed, 15 Jul 2026 10:50:35 -0500
Message-ID: <20260715155037.2237011-5-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715155037.2237011-1-mikail.sadic@ibm.com>
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX+hqsVK2q5xp1
 YAthkoOalaiiW57/4Gz+ypN9ZpQzrsQHeQ7btqCqqtk8aL+TDo2u+IIa2uuurFgNj8r4hVrAyij
 csegNXRYQiUBDXKYwSPWRjqyGGfPw04=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a57ac5c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8
 a=VEmIhVw1xF0jJ_ed_d0A:9
X-Proofpoint-GUID: LN8N4mIU84fRnSM1XhUwQybhzUTG6Eu8
X-Proofpoint-ORIG-GUID: dor0aQUUMa43eHAHkgG7fhXcNgf_BIwb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX3iOzJA7k/TN+
 1NK3Vh9lxGAw5hOoFBSIXGjbvhHEXPLUfMnjwIOjRxXxZ/GCOH3QOp0kLWRyaeY0WgafDH6Ndz+
 X5EQsXD32tWCw+Yg9KKagSecpc3eg/6Y+7mTx5BOtCnK3jwXZxPqMiMb4kMWnZj6OEb7tHv9Ba7
 7VlxiA6BRHWT3quwPN5CQnTfSQhLVIf7JiYnzMQjRX/+oQmRFwjm55GKC3gpTSMMpPcaxnZFFex
 WGLc5YfqV86JXLBLImqMaXJbpBcGrb5Fgs92HFFffz68grFZMzBGDTVPCy8Rv0ADs6AVRVVTMoq
 JuV3BtEpJKZZtDvS4vAJT17TQZcH/7UvRtyVm+MUagLQEF8WdMN3XOY6hWHtCRkXvtRRYTHpAy8
 LrZ5jSxN7FLAEOBiJQqjJUtj3a9jip81lDz9mo3wfEVtAfdNV2Ji2C8SJf5unqw8dDlSgcZIy50
 tXcZyKASIWjhiJmOHnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Jul 2026 12:36:14 -0400
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

Add an emulation of the AST2700 UFS host controller
(aspeed,ufshc-m31-16nm) and wire it into the AST2700 SoC.
Implement the functionality needed by U-Boot and Linux to enumerate the
device and access a BlockBackend using the UFS protocol, allowing the
AST2700 machine to boot from a UFS image.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 MAINTAINERS                 |    1 +
 docs/specs/aspeed-ufs.rst   |   69 +++
 docs/specs/index.rst        |    1 +
 include/hw/arm/aspeed_soc.h |    3 +
 include/hw/ufs/aspeed_ufs.h |   66 +++
 hw/arm/aspeed.c             |   12 +
 hw/arm/aspeed_ast27x0.c     |   13 +
 hw/ufs/aspeed_ufs.c         | 1095 +++++++++++++++++++++++++++++++++++
 hw/ufs/meson.build          |    1 +
 9 files changed, 1261 insertions(+)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/ufs/aspeed_ufs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b2861dfc79..d35c29c58d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2696,6 +2696,7 @@ M: Jeuk Kim <jeuk20.kim@samsung.com>
 S: Supported
 F: hw/ufs/*
 F: include/block/ufs.h
+F: include/hw/ufs/aspeed_ufs.h
 F: tests/qtest/ufs-test.c
 
 megasas
diff --git a/docs/specs/aspeed-ufs.rst b/docs/specs/aspeed-ufs.rst
new file mode 100644
index 0000000000..f4eb6f1ce6
--- /dev/null
+++ b/docs/specs/aspeed-ufs.rst
@@ -0,0 +1,69 @@
+ASPEED AST2700 UFS Host Controller
+===================================
+
+The AST2700 SoC includes a UFS host controller identified in the device tree
+as ``aspeed,ufshc-m31-16nm``, mapped at ``0x12c08200`` (IRQ SPI 118). QEMU
+models it as a sysbus device implementing the UFSHCI v2.0 register interface
+required by U-Boot and the Linux ``aspeed-ufshcd`` driver.
+
+The clock/reset wrapper at ``0x12c08000`` (``aspeed,ast2700-ufscnr``) is left
+as an ``UnimplementedDevice``.
+
+Implemented functionality
+--------------------------
+
+Host Controller Enable (HCE)
+  On a ``HCE=1`` write the register is cleared to 0 and a bottom-half is
+  scheduled to set it back to 1 with ``HCS`` ready bits. The read handler
+  returns 0 while in phase 1, so polling sees the 0 to 1 transition without 
+  a timeout. If the controller is already in the ready state (phase 2), a
+  subsequent ``HCE=1`` write is a no-op; the controller stays enabled for
+  Linux after U-Boot has left it running.
+
+UIC commands
+  ``DME_LINKSTARTUP``, ``DME_GET``, ``DME_PEER_GET``, ``DME_SET``, and
+  ``DME_PEER_SET`` all succeed immediately. ``DME_LINKSTARTUP`` sets
+  ``HCS.DP`` and raises ``IS.UIC_LINK_STARTUP`` (bit 8). ``DME_SET`` and
+  ``DME_PEER_SET`` set ``HCS[10:8] = PWR_LOCAL`` and raise
+  ``IS.UIC_POWER_MODE``.
+
+NOP OUT / NOP IN
+  Doorbell processing is synchronous (inline) rather than deferred, as
+  U-Boot's ``NOP_OUT_TIMEOUT`` is shorter than a deferred bottom-half can
+  fire in QEMU's event loop.
+
+SCSI block I/O
+  READ_10, READ_16, WRITE_10, WRITE_16, INQUIRY, READ_CAPACITY_10/16, and
+  REPORT_LUNS are forwarded to the attached ``BlockBackend``. When
+  ``prdtl = 0`` (no scatter-gather list), response data is placed in the
+  Response UPIU data segment; when ``prdtl > 0`` it is written into the PRDT
+  buffers.
+
+Query UPIU descriptors
+  Device, Geometry, Unit, Power (idn 8), and String (idn 5) descriptors are
+  returned, capped to the requested length.
+
+Well-Known LUNs
+  All four W-LUNs (0xD0 UFS Device, 0xC4 RPMB, 0xB0 Boot, 0x81 Report LUNs)
+  respond as present devices.
+
+Task management (UTMRL)
+  ``LOGICAL_UNIT_RESET`` commands are acknowledged immediately by writing
+  ``OCS_SUCCESS`` into the UTMRD slot, clearing the doorbell, and raising
+  ``IS.UTP_TASK_REQ_COMPL`` (bit 9).
+
+Usage
+-----
+
+The UFS controller picks up the first ``IF_NONE`` block device at index 0.
+Pass a UFS disk image with ``-drive if=none``:
+
+.. code-block:: console
+
+  qemu-system-aarch64 -M huygens-bmc \
+    -drive file=image-bmc,if=mtd,format=raw \
+    -drive file=ufs.img,if=none,format=raw \
+    -nographic
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
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 41dc04e293..28ca97d35c 100644
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
+    AspeedUFSState ufs;
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
index 0000000000..6d0aa345e9
--- /dev/null
+++ b/include/hw/ufs/aspeed_ufs.h
@@ -0,0 +1,66 @@
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
+#include "hw/core/sysbus.h"
+#include "block/ufs.h"
+#include "system/block-backend.h"
+
+#define TYPE_ASPEED_UFS "aspeed-ufs"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedUFSState, ASPEED_UFS)
+
+/* UFSHCI register space is 256 bytes (0x00-0xFF) */
+#define ASPEED_UFS_MMIO_SIZE  0x100
+#define ASPEED_UFS_NUM_REGS   (ASPEED_UFS_MMIO_SIZE / sizeof(uint32_t))
+
+/* Number of UTP Transfer Request slots advertised */
+#define ASPEED_UFS_NUTRS      32
+/* Number of UTP Task Management Request slots */
+#define ASPEED_UFS_NUTMRS     8
+
+/*
+ * Reset / power-on values.
+ *
+ * CAP: NUTRS=31 (0x1f, 5-bit), RTT=2, NUTMRS=7, 64AS=1
+ * VER: UFSHCI 2.0 (matches aspeed,ufshc-m31-16nm)
+ * HCS: DP|UTRLRDY|UTMRLRDY|UCRDY (bits 0-3)
+ */
+#define ASPEED_UFS_CAP_RESET  0x0702031f
+#define ASPEED_UFS_VER_RESET  0x00000200
+#define ASPEED_UFS_HCS_READY  0x0000000f
+
+struct AspeedUFSState {
+    SysBusDevice  parent_obj;
+
+    MemoryRegion  iomem;
+    qemu_irq      irq;
+
+    BlockBackend *blk;
+    uint64_t      num_sectors;
+
+    uint32_t      regs[ASPEED_UFS_NUM_REGS];
+
+    /*
+     * HCE state machine phase:
+     *   0 = idle (HCE=0)
+     *   1 = cleared (firmware wrote 1, we stored 0, BH pending)
+     *   2 = ready (BH fired, HCE=1, HCS ready bits set)
+     */
+    int           hce_phase;
+    QEMUBH       *hce_bh;
+
+    uint32_t      utrldbr;       /* pending doorbell bits */
+    uint64_t      utrl_base;     /* 64-bit physical base of UTRL */
+    uint64_t      utmrl_base;    /* 64-bit physical base of UTMRL */
+
+    /* Unit Descriptor; capacity filled at realize time */
+    uint8_t       unit_desc[0x23];
+};
+
+#endif /* ASPEED_UFS_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a48c442058..1f57f32ad4 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -184,6 +184,18 @@ static void aspeed_machine_init(MachineState *machine)
         object_property_set_int(OBJECT(bmc->soc), "hw-prot-key",
                                 ASPEED_SCU_PROT_KEY, &error_abort);
     }
+    /*
+     * Attach the UFS backing drive before realizing the SoC so that
+     * the UFS controller can read the drive size during realization.
+     */
+    {
+        DriveInfo *ufs_dinfo = drive_get(IF_NONE, 0, 0);
+        if (ufs_dinfo) {
+            qdev_prop_set_drive_err(DEVICE(&bmc->soc->ufs), "drive",
+                                    blk_by_legacy_dinfo(ufs_dinfo),
+                                    &error_fatal);
+        }
+    }
     aspeed_connect_serial_hds_to_uarts(bmc);
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index b908d7d4ff..04aa4e15a5 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -39,6 +39,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_EHCI2]     =  0x12063000,
     [ASPEED_DEV_HACE]      =  0x12070000,
     [ASPEED_DEV_EMMC]      =  0x12090000,
+    [ASPEED_DEV_UFS]       =  0x12c08200,
     [ASPEED_DEV_PCIE0]     =  0x120E0000,
     [ASPEED_DEV_PCIE1]     =  0x120F0000,
     [ASPEED_DEV_INTC]      =  0x12100000,
@@ -116,6 +117,7 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_SCU]       = 12,
     [ASPEED_DEV_RTC]       = 13,
     [ASPEED_DEV_EMMC]      = 15,
+    [ASPEED_DEV_UFS]       = 118,
     [ASPEED_DEV_TIMER1]    = 16,
     [ASPEED_DEV_TIMER2]    = 17,
     [ASPEED_DEV_TIMER3]    = 18,
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
index 0000000000..673aced63b
--- /dev/null
+++ b/hw/ufs/aspeed_ufs.c
@@ -0,0 +1,1095 @@
+/*
+ * ASPEED AST2700 UFS Host Controller
+ *
+ * Sysbus device mapped at 0x12c08200 (256 bytes).  Implements the UFSHCI
+ * register interface required by U-Boot ufshcd_probe() and Linux
+ * aspeed-ufshcd, including UIC command handling, NOP OUT/IN, SCSI block I/O,
+ * Query UPIU descriptor reads, W-LUN support, and UTMRL task management.
+ *
+ * Register offsets follow JEDEC UFSHCI spec v2.0, matching the REG_*
+ * definitions in include/block/ufs.h.
+ *
+ * The ASPEED clock/reset wrapper at 0x12c08000 (aspeed,ast2700-ufscnr) is
+ * left as an UnimplementedDevice; writes to MPHY registers there require no
+ * readback.
+ *
+ * Copyright 2026 IBM Corp.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "system/block-backend.h"
+#include "system/block-backend-io.h"
+#include "system/dma.h"
+#include "system/address-spaces.h"
+#include "hw/ufs/aspeed_ufs.h"
+
+/* UFSHCI register offsets (JEDEC UFSHCI spec v2.0) */
+#define REG_CAP          0x00
+#define REG_VER          0x08
+#define REG_HCPID        0x10
+#define REG_HCMID        0x14
+#define REG_AHIT         0x18
+#define REG_IS           0x20
+#define REG_IE           0x24
+#define REG_HCS          0x30
+#define REG_HCE          0x34
+#define REG_UECPA        0x38
+#define REG_UECDL        0x3c
+#define REG_UECN         0x40
+#define REG_UECT         0x44
+#define REG_UECDME       0x48
+#define REG_UTRLBA       0x50
+#define REG_UTRLBAU      0x54
+#define REG_UTRLDBR      0x58
+#define REG_UTRLCLR      0x5c
+#define REG_UTRLRSR      0x60
+#define REG_UTMRLBA      0x70
+#define REG_UTMRLBAU     0x74
+#define REG_UTMRLDBR     0x78
+#define REG_UTMRLCLR     0x7c
+#define REG_UTMRLRSR     0x80
+#define REG_UICCMD       0x90
+#define REG_UCMDARG1     0x94
+#define REG_UCMDARG2     0x98
+#define REG_UCMDARG3     0x9c
+
+/* HCE / HCS bits */
+#define HCE_ENABLE       BIT(0)
+#define HCS_DP           BIT(0)
+#define HCS_UTRLRDY      BIT(1)
+#define HCS_UTMRLRDY     BIT(2)
+#define HCS_UCRDY        BIT(3)
+
+/* IS bits (UFSHCI spec sec. 5.3) */
+#define IS_UTRCS            BIT(0)    /* UTP Transfer Request Completion */
+#define IS_UIC_POWER_MODE   BIT(4)    /* UIC Power Mode Status */
+#define IS_UIC_LINK_STARTUP BIT(8)    /* UIC Link Startup Status */
+#define IS_UTMRCS           BIT(9)    /* UTP Task Mgmt Request Completion */
+#define IS_UCCS             BIT(10)   /* UIC Command Completion Status */
+
+/* UIC command opcodes */
+#define DME_LINKSTARTUP     0x16
+#define DME_GET             0x01
+#define DME_SET             0x02
+#define DME_PEER_GET        0x03
+#define DME_PEER_SET        0x04
+
+/* UIC command result (success) in UCMDARG2[7:0] */
+#define UIC_CMD_RESULT_OK   0x00
+
+/* HCS power-mode state field bits [10:8]: PWR_LOCAL = 1 */
+#define HCS_PWR_LOCAL       (1 << 8)
+
+/* Register array index helper */
+#define R(off)  ((off) / sizeof(uint32_t))
+
+/*
+ * UTP Transfer Request Descriptor (UFSHCI spec sec. 7.2.1).
+ */
+#define UTRD_SIZE 32 /* bytes per UTRL slot */
+
+/*
+ * UTMRL slot size (UTP Task Management Request List):
+ *  - header   : 16 bytes
+ *  - upiu_req : 32 bytes
+ *  - upiu_rsp : 32 bytes
+ */
+#define UTMRD_SIZE 80
+
+/* byte offset of OCS within request_desc_header */
+#define UTMRD_OCS_OFFSET 8
+
+/* Command Type in UTRD DW0[29:28] */
+#define CT_UFS_STORAGE   0x1
+
+/* Data Direction in UTRD DW0[25:24] */
+#define DD_NO_DATA       0x0
+#define DD_HOST_TO_DEV   0x2
+#define DD_DEV_TO_HOST   0x4
+
+/* OCS in UTRD DW2[7:0] */
+#define OCS_SUCCESS      0x0
+
+/* UPIU transaction types */
+#define UPIU_TYPE_NOP_OUT     0x00
+#define UPIU_TYPE_CMD         0x01
+#define UPIU_TYPE_QUERY_REQ   0x16
+#define UPIU_TYPE_NOP_IN      0x20
+#define UPIU_TYPE_RESPONSE    0x21
+#define UPIU_TYPE_QUERY_RSP   0x36
+
+/* Query opcodes */
+#define QUERY_OP_READ_DESC    0x01
+#define QUERY_OP_WRITE_DESC   0x02
+#define QUERY_OP_READ_ATTR    0x03
+#define QUERY_OP_WRITE_ATTR   0x04
+#define QUERY_OP_READ_FLAG    0x05
+#define QUERY_OP_SET_FLAG     0x06
+#define QUERY_OP_CLEAR_FLAG   0x07
+
+/* Descriptor idn */
+#define DESC_IDN_DEVICE       0x00
+#define DESC_IDN_CONFIGURATION 0x01
+#define DESC_IDN_UNIT         0x02
+#define DESC_IDN_GEOMETRY     0x07
+#define DESC_IDN_POWER        0x08
+#define DESC_IDN_STRING       0x05
+
+/* SCSI commands */
+#define SCSI_TEST_UNIT_READY  0x00
+#define SCSI_INQUIRY          0x12
+#define SCSI_READ_CAPACITY_10 0x25
+#define SCSI_READ_10          0x28
+#define SCSI_WRITE_10         0x2a
+#define SCSI_READ_16          0x88
+#define SCSI_WRITE_16         0x8a
+#define SCSI_READ_CAPACITY_16 0x9e   /* service action 0x10 */
+#define SCSI_REPORT_LUNS      0xa0
+
+/*
+ * Well-Known LUN addresses probed by ufshcd_scsi_add_wlus().
+ * All four must appear as present devices or async_scan fails.
+ */
+#define WLUN_REPORT_LUNS 0x81
+#define WLUN_UFS_DEVICE  0xd0
+#define WLUN_BOOT        0xb0
+#define WLUN_RPMB        0xc4
+
+static bool aspeed_ufs_is_wlun(uint8_t lun)
+{
+    return lun == WLUN_UFS_DEVICE || lun == WLUN_RPMB ||
+           lun == WLUN_BOOT       || lun == WLUN_REPORT_LUNS;
+}
+
+static void ufs_dma_read(hwaddr paddr, void *buf, size_t len)
+{
+    dma_memory_read(&address_space_memory, paddr, buf, len,
+                    MEMTXATTRS_UNSPECIFIED);
+}
+
+static void ufs_dma_write(hwaddr paddr, const void *buf, size_t len)
+{
+    dma_memory_write(&address_space_memory, paddr, buf, len,
+                     MEMTXATTRS_UNSPECIFIED);
+}
+
+static void aspeed_ufs_update_irq(AspeedUFSState *s)
+{
+    uint32_t is  = s->regs[R(REG_IS)];
+    uint32_t ie  = s->regs[R(REG_IE)];
+
+    qemu_set_irq(s->irq, !!(is & ie));
+}
+
+/*
+ * HCE bottom-half: completes the 1->0->1 toggle that the host driver polls.
+ *
+ * On any HCE=1 write the write handler clears HCE to 0 and schedules this
+ * BH.  Once it fires the controller is considered ready.
+ */
+static void aspeed_ufs_hce_bh(void *opaque)
+{
+    AspeedUFSState *s = opaque;
+
+    s->regs[R(REG_HCE)] = HCE_ENABLE;
+    s->regs[R(REG_HCS)] = ASPEED_UFS_HCS_READY;
+    s->hce_phase = 2;
+}
+
+/* 12-byte UPIU header (big-endian per UFSHCI spec) */
+typedef struct {
+    uint8_t  trans_type;
+    uint8_t  flags;
+    uint8_t  lun;
+    uint8_t  task_tag;
+    uint8_t  iid_cmd_set;
+    uint8_t  query_func;
+    uint8_t  response;
+    uint8_t  status;
+    uint8_t  ehs_len;
+    uint8_t  device_info;
+    uint16_t data_seg_len_be;
+} UpiuHeader;
+
+/* 32-byte UPIU (header + TSF + reserved dword) */
+typedef struct {
+    UpiuHeader hdr;
+    uint8_t    tsf[16];
+    uint32_t   reserved;
+} Upiu32;
+
+/* UTP Transfer Request Descriptor (UFSHCI spec sec. 7.2.1, 32 bytes) */
+typedef struct {
+    uint32_t dw0;
+    uint32_t dw1;
+    uint32_t dw2;   /* OCS[7:0] */
+    uint32_t dw3;
+    uint32_t dw4;   /* UCDBA: Command UPIU base, lower 32 bits */
+    uint32_t dw5;   /* UCDBAU: upper 32 bits */
+    uint32_t dw6;   /* RUL[31:16] | RUO[15:0] in DWORDs */
+    uint32_t dw7;   /* PRDTO[31:16] | PRDTL[15:0] */
+} Utrd;
+
+/* Physical Region Descriptor Table entry */
+typedef struct {
+    uint32_t dba;       /* Data Buffer Address (lower) */
+    uint32_t dbau;      /* Data Buffer Address (upper) */
+    uint32_t reserved;
+    uint32_t size;      /* byte count - 1, bits [17:0] */
+} PrdtEntry;
+
+/*
+ * Minimal UFS Device Descriptor (64 bytes).
+ * Values follow UFS 2.1 spec defaults; only fields checked by Linux and
+ * U-Boot ufshcd are set to non-zero.
+ */
+static const uint8_t ufs_device_desc[] = {
+    0x40,                /* bLength = 64 */
+    DESC_IDN_DEVICE,     /* bDescriptorIDN */
+    0x00,                /* bDevice */
+    0x00,                /* bDeviceClass */
+    0x00,                /* bDeviceSubClass */
+    0x01,                /* bProtocol */
+    0x01,                /* bNumberLU */
+    0x00,                /* bNumberWLU */
+    0x00,                /* bBootEnable */
+    0x00,                /* bDescrAccessEn */
+    0x00,                /* bInitPowerMode */
+    0x01,                /* bHighPriorityLUN */
+    0x00,                /* bSecureRemovalType */
+    0x00,                /* bSecurityLU */
+    0x00,                /* bBackgroundOpsTermLat */
+    0x01,                /* bInitActiveICCLevel */
+    0x02, 0x10,          /* wSpecVersion = 0x0210 (UFS 2.1) */
+    0x00, 0x00,          /* wManufactureDate */
+    0x00,                /* iManufacturerName */
+    0x02,                /* iProductName (string index 2) */
+    0x00,                /* iSerialNumber */
+    0x00,                /* iOemID */
+    0x00, 0x00,          /* wManufacturerID */
+    0x00,                /* bUD0BaseOffset */
+    0x00,                /* bUDConfigPlength */
+    0x00,                /* bDeviceRTTCap */
+    0x00, 0x00,          /* wPeriodicRTCUpdate */
+    0x00,                /* bUFSFeaturesSupport */
+    0x00,                /* bFFUTimeout */
+    0x00,                /* bQueueDepth */
+    0x00, 0x00,          /* wDeviceVersion */
+    0x00,                /* bNumSecureWPArea */
+    0x00, 0x00, 0x00, 0x00, /* dPSAMaxDataSize */
+    0x00,                /* bPSAStateTimeout */
+    0x00,                /* iProductRevisionLevel */
+    /* pad to 0x40 */
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* Minimal Geometry Descriptor (0x48 bytes) */
+static const uint8_t ufs_geometry_desc[] = {
+    0x48,                /* bLength */
+    DESC_IDN_GEOMETRY,   /* bDescriptorIDN */
+    0x00,                /* bMediaTechnology */
+    0x00,                /* reserved */
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, /* qTotalRawDeviceCapacity (8 bytes, big-endian) */
+    0x00,                /* bMaxNumberLU */
+    0x00, 0x10, 0x00, 0x00, /* dSegmentSize = 4096 sectors */
+    0x08,                /* bAllocationUnitSize */
+    0x01,                /* bMinAddrBlockSize */
+    0x00,                /* bOptimalReadBlockSize */
+    0x00,                /* bOptimalWriteBlockSize */
+    0x00,                /* bMaxInBufferSize */
+    0x00,                /* bMaxOutBufferSize */
+    0x00,                /* bRPMB_ReadWriteSize */
+    0x00,                /* bDynamicCapacityResourcePolicy */
+    0x00,                /* bDataOrdering */
+    0x00,                /* bMaxContexIDNumber */
+    0x00,                /* bSysDataTagUnitSize */
+    0x00,                /* bSysDataTagResSize */
+    0x01,                /* bSupportedSecRTypes */
+    0x00, 0x03,          /* wSupportedMemoryTypes */
+    0x00, 0x00, 0x00, 0x00, /* dSystemCodeMaxNAllocU */
+    0x00, 0x00,          /* wSystemCodeCapAdjFac */
+    0x00, 0x00, 0x00, 0x00, /* dNonPersistMaxNAllocU */
+    0x00, 0x00,          /* wNonPersistCapAdjFac */
+    0x00, 0x00, 0x00, 0x00, /* dEnhanced1MaxNAllocU */
+    0x00, 0x00,          /* wEnhanced1CapAdjFac */
+    0x00, 0x00, 0x00, 0x00, /* dEnhanced2MaxNAllocU */
+    0x00, 0x00,          /* wEnhanced2CapAdjFac */
+    0x00, 0x00, 0x00, 0x00, /* dEnhanced3MaxNAllocU */
+    0x00, 0x00,          /* wEnhanced3CapAdjFac */
+    0x00, 0x00, 0x00, 0x00, /* dEnhanced4MaxNAllocU */
+    0x00, 0x00,          /* wEnhanced4CapAdjFac */
+    /* pad to 0x48 */
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00,
+};
+
+/*
+ * Power Descriptor (idn 8, bLength 0x62).
+ * Linux ufshcd_probe() reads this; a zero-filled body of the right length
+ * satisfies the length check.
+ */
+static const uint8_t ufs_power_desc[0x62] = {
+    0x62,                /* bLength */
+    DESC_IDN_POWER,      /* bDescriptorIDN */
+    /* remaining bytes zero-initialized */
+};
+
+/*
+ * String Descriptor (idn 5).
+ * iProductName points to string index 2 in the device descriptor.  A
+ * minimal well-formed header (type + zero length) keeps ufshcd happy.
+ */
+static const uint8_t ufs_string_desc[] = {
+    0x02,                /* bLength = 2 (header only, no string data) */
+    DESC_IDN_STRING,     /* bDescriptorIDN */
+};
+
+/* Unit Descriptor (0x23 bytes) - capacity filled at realize time */
+
+static void aspeed_ufs_init_unit_desc(AspeedUFSState *s)
+{
+    uint64_t lbc;
+
+    memset(s->unit_desc, 0, sizeof(s->unit_desc));
+    s->unit_desc[0x00] = 0x23;          /* bLength */
+    s->unit_desc[0x01] = DESC_IDN_UNIT; /* bDescriptorIDN */
+    s->unit_desc[0x02] = 0x00;          /* bUnitIndex */
+    s->unit_desc[0x03] = 0x01;          /* bLUEnable */
+    s->unit_desc[0x08] = 0x02;          /* bMemoryType */
+    s->unit_desc[0x0a] = 0x0c;          /* bLogicalBlockSize: 1 << 12 = 4096 */
+
+    lbc = cpu_to_be64(s->num_sectors);
+    memcpy(&s->unit_desc[0x0b], &lbc, 8); /* qLogicalBlockCount */
+}
+
+/* Build a 36-byte SCSI INQUIRY response */
+static void scsi_build_inquiry(uint8_t *buf, uint8_t lun)
+{
+    memset(buf, 0, 36);
+    /*
+     * W-LUNs use device_type 0x1e (well known LU); LUN 0 is a direct-access
+     * block device (0x00).
+     */
+    buf[0] = aspeed_ufs_is_wlun(lun) ? 0x1e : 0x00;
+    buf[1] = 0x00;   /* not removable */
+    buf[2] = 0x05;   /* SPC-3 */
+    buf[3] = 0x12;   /* response data format = 2, HiSup */
+    buf[4] = 0x1f;   /* additional length = 31 */
+    memcpy(&buf[8],  "ASPEED  ", 8);
+    memcpy(&buf[16], "UFS QEMU        ", 16);
+    memcpy(&buf[32], "1.00", 4);
+}
+
+/* Build an 8-byte READ_CAPACITY(10) response */
+static void scsi_build_read_cap10(uint8_t *buf, uint64_t sectors)
+{
+    uint32_t last_lba = (sectors > 0xffffffff) ? 0xffffffff
+                                               : (uint32_t)(sectors - 1);
+    uint32_t block_size = cpu_to_be32(512);
+
+    last_lba = cpu_to_be32(last_lba);
+    memcpy(buf,     &last_lba,   4);
+    memcpy(buf + 4, &block_size, 4);
+}
+
+/* Build a 32-byte READ_CAPACITY(16) response */
+static void scsi_build_read_cap16(uint8_t *buf, uint64_t sectors)
+{
+    uint64_t last_lba = cpu_to_be64(sectors - 1);
+    uint32_t block_size = cpu_to_be32(512);
+    memcpy(buf,     &last_lba,   8);
+    memcpy(buf + 8, &block_size, 4);
+}
+
+/* Process one UTRL slot */
+static void aspeed_ufs_process_slot(AspeedUFSState *s, int slot)
+{
+    uint64_t utrd_addr = s->utrl_base + (uint64_t)slot * UTRD_SIZE;
+    Utrd utrd;
+    uint64_t upiu_base, resp_base, prdt_base;
+    uint32_t dw6, dw7, ruo, prdtl, prdto;
+    UpiuHeader req_hdr;
+    uint8_t trans_type, task_tag;
+
+    ufs_dma_read(utrd_addr, &utrd, sizeof(utrd));
+
+    upiu_base = (uint64_t)le32_to_cpu(utrd.dw4) |
+                ((uint64_t)le32_to_cpu(utrd.dw5) << 32);
+
+    /*
+     * DW6 holds the Response UPIU offset (RUO) and length (RUL), both in
+     * DWORDs.  The response UPIU follows the request UPIU in the same
+     * guest buffer.
+     */
+    dw6  = le32_to_cpu(utrd.dw6);
+    ruo  = dw6 & 0xffff;
+    resp_base = upiu_base + (uint64_t)ruo * 4;
+
+    /* DW7: PRDTL (entry count) and PRDTO (offset in DWORDs) */
+    dw7   = le32_to_cpu(utrd.dw7);
+    prdtl = dw7 & 0xffff;
+    prdto = (dw7 >> 16) & 0xffff;
+    prdt_base = upiu_base + (uint64_t)prdto * 4;
+
+    ufs_dma_read(upiu_base, &req_hdr, sizeof(req_hdr));
+    trans_type = req_hdr.trans_type & 0x3f;
+    task_tag   = req_hdr.task_tag;
+
+    /* NOP OUT -> NOP IN */
+    if (trans_type == UPIU_TYPE_NOP_OUT) {
+        uint8_t rsp[32];
+        memset(rsp, 0, sizeof(rsp));
+        rsp[0] = UPIU_TYPE_NOP_IN;
+        rsp[3] = task_tag;
+        ufs_dma_write(resp_base, rsp, 32);
+        goto done;
+    }
+
+    /* Query Request -> Query Response */
+    if (trans_type == UPIU_TYPE_QUERY_REQ) {
+        uint8_t req_buf[32];
+        uint8_t rsp[32];
+        uint8_t opcode, idn;
+
+        ufs_dma_read(upiu_base, req_buf, 32);
+        opcode = req_buf[12];
+        idn    = req_buf[13];
+
+        memset(rsp, 0, sizeof(rsp));
+        rsp[0] = UPIU_TYPE_QUERY_RSP;
+        rsp[3] = task_tag;
+        memcpy(&rsp[12], &req_buf[12], 16);  /* echo TSF */
+
+        if (opcode == QUERY_OP_READ_DESC) {
+            const uint8_t *desc = NULL;
+            uint16_t desc_len = 0;
+            uint16_t req_len;
+
+            switch (idn) {
+            case DESC_IDN_DEVICE:
+                desc     = ufs_device_desc;
+                desc_len = sizeof(ufs_device_desc);
+                break;
+            case DESC_IDN_GEOMETRY:
+                desc     = ufs_geometry_desc;
+                desc_len = sizeof(ufs_geometry_desc);
+                break;
+            case DESC_IDN_UNIT:
+                desc     = s->unit_desc;
+                desc_len = sizeof(s->unit_desc);
+                break;
+            case DESC_IDN_POWER:
+                desc     = ufs_power_desc;
+                desc_len = sizeof(ufs_power_desc);
+                break;
+            case DESC_IDN_STRING:
+                desc     = ufs_string_desc;
+                desc_len = sizeof(ufs_string_desc);
+                break;
+            default:
+                break;
+            }
+
+            /*
+             * Cap the returned length to what the host requested (TSF
+             * bytes 6-7 hold the allocation length).  Returning more than
+             * asked causes the driver to reject the response with -EINVAL.
+             */
+            req_len = ((uint16_t)req_buf[18] << 8) | req_buf[19];
+            if (desc_len > req_len) {
+                desc_len = req_len;
+            }
+
+            rsp[10] = (desc_len >> 8) & 0xff;
+            rsp[11] =  desc_len       & 0xff;
+            rsp[18] = rsp[10];
+            rsp[19] = rsp[11];
+
+            ufs_dma_write(resp_base, rsp, 32);
+            if (desc && desc_len) {
+                ufs_dma_write(resp_base + 32, desc, desc_len);
+            }
+        } else {
+            /* READ_ATTR, READ_FLAG, SET_FLAG, etc. - echo TSF, success */
+            ufs_dma_write(resp_base, rsp, 32);
+        }
+        goto done;
+    }
+
+    /* SCSI Command UPIU */
+    if (trans_type == UPIU_TYPE_CMD) {
+        uint8_t req_buf[32];
+        uint8_t *cdb;
+        uint8_t scsi_cmd;
+        bool ok = true;
+        uint8_t sense[18];
+        uint8_t *xfer_buf = NULL;
+        uint32_t xfer_len = 0;
+
+        ufs_dma_read(upiu_base, req_buf, 32);
+        cdb      = &req_buf[16];
+        scsi_cmd = cdb[0];
+
+        memset(sense, 0, sizeof(sense));
+
+        /* Non-zero LUNs that are not W-LUNs have no device. */
+        if (req_hdr.lun != 0 && !aspeed_ufs_is_wlun(req_hdr.lun)) {
+            ok = false;
+            sense[0] = 0x70;
+            sense[2] = 0x05;   /* ILLEGAL REQUEST */
+            sense[7] = 0x0a;
+            goto scsi_done;
+        }
+
+        if (prdtl > 0) {
+            uint32_t i;
+
+            for (i = 0; i < prdtl; i++) {
+                PrdtEntry pe;
+                ufs_dma_read(prdt_base + i * sizeof(PrdtEntry),
+                             &pe, sizeof(pe));
+                xfer_len += (le32_to_cpu(pe.size) & 0x3ffff) + 1;
+            }
+            xfer_buf = g_malloc0(xfer_len);
+        }
+
+        switch (scsi_cmd) {
+
+        case SCSI_TEST_UNIT_READY:
+            break;
+
+        case SCSI_INQUIRY: {
+            uint8_t inq[36];
+            uint32_t alloc, send;
+
+            /*
+             * EVPD queries (cdb[1] & 0x01) return an empty VPD page list
+             * for W-LUNs.  This stops the driver from iterating all 256
+             * possible VPD pages after it finds zero supported ones.
+             */
+            if ((cdb[1] & 0x01) && aspeed_ufs_is_wlun(req_hdr.lun)) {
+                uint8_t evpd[4];
+                memset(evpd, 0, sizeof(evpd));
+                evpd[0] = 0x1e;   /* device_type: well known LU */
+                /* page_length = 0: no VPD pages supported */
+                alloc = ((uint16_t)cdb[3] << 8) | cdb[4];
+                send  = MIN(alloc, sizeof(evpd));
+                if (prdtl > 0 && xfer_buf) {
+                    memcpy(xfer_buf, evpd, send);
+                } else {
+                    ufs_dma_write(resp_base + 32, evpd, send);
+                }
+                xfer_len = send;
+                break;
+            }
+
+            scsi_build_inquiry(inq, req_hdr.lun);
+            alloc = ((uint16_t)cdb[3] << 8) | cdb[4];
+            send  = MIN(alloc, 36);
+            if (prdtl > 0 && xfer_buf) {
+                memcpy(xfer_buf, inq, send);
+            } else {
+                ufs_dma_write(resp_base + 32, inq, send);
+            }
+            xfer_len = send;
+            break;
+        }
+
+        case SCSI_READ_CAPACITY_10: {
+            uint8_t cap[8];
+            scsi_build_read_cap10(cap, s->num_sectors);
+            if (prdtl > 0 && xfer_buf) {
+                memcpy(xfer_buf, cap, 8);
+            } else {
+                ufs_dma_write(resp_base + 32, cap, 8);
+            }
+            xfer_len = 8;
+            break;
+        }
+
+        case SCSI_READ_CAPACITY_16:
+            /* service action must be 0x10 */
+            if ((cdb[1] & 0x1f) == 0x10) {
+                uint8_t cap[32];
+                memset(cap, 0, sizeof(cap));
+                scsi_build_read_cap16(cap, s->num_sectors);
+                if (prdtl > 0 && xfer_buf) {
+                    memcpy(xfer_buf, cap, 32);
+                } else {
+                    ufs_dma_write(resp_base + 32, cap, 32);
+                }
+                xfer_len = 32;
+            }
+            break;
+
+        case SCSI_READ_10:
+        case SCSI_READ_16: {
+            uint64_t lba;
+            uint32_t num_blocks, byte_count;
+
+            if (scsi_cmd == SCSI_READ_10) {
+                lba = (uint64_t)cdb[2] << 24 | (uint64_t)cdb[3] << 16 |
+                      (uint64_t)cdb[4] <<  8 | cdb[5];
+                num_blocks = (uint16_t)cdb[7] << 8 | cdb[8];
+            } else {
+                lba = (uint64_t)cdb[2] << 56 | (uint64_t)cdb[3] << 48 |
+                      (uint64_t)cdb[4] << 40 | (uint64_t)cdb[5] << 32 |
+                      (uint64_t)cdb[6] << 24 | (uint64_t)cdb[7] << 16 |
+                      (uint64_t)cdb[8] <<  8 | cdb[9];
+                num_blocks = (uint32_t)cdb[10] << 24 |
+                             (uint32_t)cdb[11] << 16 |
+                             (uint32_t)cdb[12] <<  8 | cdb[13];
+            }
+            byte_count = num_blocks * 512;
+            if (s->blk && byte_count > 0) {
+                uint8_t *rbuf = g_malloc(byte_count);
+                if (blk_pread(s->blk, lba * 512, byte_count, rbuf, 0) < 0) {
+                    ok = false;
+                } else if (prdtl > 0 && xfer_buf) {
+                    memcpy(xfer_buf, rbuf,
+                           MIN(byte_count, xfer_len));
+                } else {
+                    ufs_dma_write(resp_base + 32, rbuf, byte_count);
+                }
+                g_free(rbuf);
+            }
+            xfer_len = byte_count;
+            break;
+        }
+
+        case SCSI_WRITE_10:
+        case SCSI_WRITE_16: {
+            uint64_t lba;
+            uint32_t num_blocks, byte_count;
+
+            if (scsi_cmd == SCSI_WRITE_10) {
+                lba = (uint64_t)cdb[2] << 24 | (uint64_t)cdb[3] << 16 |
+                      (uint64_t)cdb[4] <<  8 | cdb[5];
+                num_blocks = (uint16_t)cdb[7] << 8 | cdb[8];
+            } else {
+                lba = (uint64_t)cdb[2] << 56 | (uint64_t)cdb[3] << 48 |
+                      (uint64_t)cdb[4] << 40 | (uint64_t)cdb[5] << 32 |
+                      (uint64_t)cdb[6] << 24 | (uint64_t)cdb[7] << 16 |
+                      (uint64_t)cdb[8] <<  8 | cdb[9];
+                num_blocks = (uint32_t)cdb[10] << 24 |
+                             (uint32_t)cdb[11] << 16 |
+                             (uint32_t)cdb[12] <<  8 | cdb[13];
+            }
+            byte_count = num_blocks * 512;
+            if (s->blk && byte_count > 0 && prdtl > 0 && xfer_buf) {
+                uint32_t copied = 0, i;
+                for (i = 0; i < prdtl && copied < byte_count; i++) {
+                    PrdtEntry pe;
+                    uint64_t dba;
+                    uint32_t chunk;
+                    ufs_dma_read(prdt_base + i * sizeof(PrdtEntry),
+                                 &pe, sizeof(pe));
+                    dba   = (uint64_t)le32_to_cpu(pe.dba) |
+                            ((uint64_t)le32_to_cpu(pe.dbau) << 32);
+                    chunk = (le32_to_cpu(pe.size) & 0x3ffff) + 1;
+                    chunk = MIN(chunk, byte_count - copied);
+                    ufs_dma_read(dba, xfer_buf + copied, chunk);
+                    copied += chunk;
+                }
+                if (blk_pwrite(s->blk, lba * 512, byte_count,
+                               xfer_buf, 0) < 0) {
+                    ok = false;
+                }
+            }
+            xfer_len = 0;
+            break;
+        }
+
+        case SCSI_REPORT_LUNS: {
+            uint8_t rl[16];
+            memset(rl, 0, sizeof(rl));
+            rl[3] = 8;   /* list length = 8 (one LUN entry) */
+            if (prdtl > 0 && xfer_buf) {
+                memcpy(xfer_buf, rl, 16);
+            } else {
+                ufs_dma_write(resp_base + 32, rl, 16);
+            }
+            xfer_len = 16;
+            break;
+        }
+
+        default:
+            ok = false;
+            sense[0] = 0x70;
+            sense[2] = 0x05;   /* ILLEGAL REQUEST */
+            sense[7] = 0x0a;
+            xfer_len = 0;
+            break;
+        }
+
+        /* Scatter read data back into guest PRDT buffers */
+        if (ok && prdtl > 0 && xfer_buf && xfer_len > 0) {
+            uint32_t copied = 0, i;
+            for (i = 0; i < prdtl && copied < xfer_len; i++) {
+                PrdtEntry pe;
+                uint64_t dba;
+                uint32_t chunk;
+                ufs_dma_read(prdt_base + i * sizeof(PrdtEntry),
+                             &pe, sizeof(pe));
+                dba   = (uint64_t)le32_to_cpu(pe.dba) |
+                        ((uint64_t)le32_to_cpu(pe.dbau) << 32);
+                chunk = (le32_to_cpu(pe.size) & 0x3ffff) + 1;
+                chunk = MIN(chunk, xfer_len - copied);
+                ufs_dma_write(dba, xfer_buf + copied, chunk);
+                copied += chunk;
+            }
+        }
+
+        g_free(xfer_buf);
+
+scsi_done:
+        /* Build SCSI Response UPIU */
+        {
+            uint8_t rsp[32];
+            uint16_t seg_len = 0;
+
+            memset(rsp, 0, sizeof(rsp));
+            rsp[0] = UPIU_TYPE_RESPONSE;
+            rsp[3] = task_tag;
+            rsp[7] = ok ? 0x00 : 0x02;   /* SCSI status */
+
+            /*
+             * If prdtl=0 (no scatter-gather list), the data was written
+             * directly to the response UPIU data segment; report its length
+             * in data_seg_len so the host driver knows where to find it.
+             */
+            if (ok && prdtl == 0 && xfer_len > 0) {
+                seg_len = (uint16_t)xfer_len;
+            } else if (!ok) {
+                seg_len = sizeof(sense);
+            }
+            rsp[10] = (seg_len >> 8) & 0xff;
+            rsp[11] =  seg_len       & 0xff;
+
+            ufs_dma_write(resp_base, rsp, 32);
+            if (!ok) {
+                ufs_dma_write(resp_base + 32, sense, sizeof(sense));
+            }
+        }
+        goto done;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "aspeed-ufs: unhandled UPIU type 0x%02x slot %d\n",
+                  trans_type, slot);
+
+done:
+    /* Mark OCS=SUCCESS in UTRD DW2 and write back */
+    utrd.dw2 = cpu_to_le32(OCS_SUCCESS);
+    ufs_dma_write(utrd_addr, &utrd, sizeof(utrd));
+
+    s->utrldbr &= ~BIT(slot);
+    s->regs[R(REG_UTRLDBR)] = s->utrldbr;
+
+    s->regs[R(REG_IS)] |= IS_UTRCS;
+    aspeed_ufs_update_irq(s);
+}
+
+/*
+ * Process all pending UTRL doorbell slots.  Called synchronously from the
+ * write handler to complete requests before the host driver's timeout fires.
+ *
+ * Note: despite the _bh suffix this is not a QEMU BH callback.  It is
+ * called inline so that U-Boot's 30 ms NOP_OUT_TIMEOUT cannot expire before
+ * a deferred callback would run.
+ */
+static void aspeed_ufs_doorbell_bh(AspeedUFSState *s)
+{
+    while (s->utrldbr) {
+        int slot = ctz32(s->utrldbr);
+        aspeed_ufs_process_slot(s, slot);
+    }
+}
+
+static uint64_t aspeed_ufs_read(void *opaque, hwaddr addr, unsigned size)
+{
+    AspeedUFSState *s = opaque;
+
+    if (addr + size > ASPEED_UFS_MMIO_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "aspeed-ufs: read out of range 0x%" HWADDR_PRIx "\n",
+                      addr);
+        return 0;
+    }
+
+    /*
+     * HCE state machine: after a HCE=1 write the register is cleared to 0
+     * (phase 1) so the first read returns 0; the BH then sets it back to 1
+     * (phase 2) and subsequent reads return 1.
+     */
+    if (addr == REG_HCE && s->hce_phase == 1) {
+        return 0;
+    }
+
+    return s->regs[R(addr)];
+}
+
+static void aspeed_ufs_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    AspeedUFSState *s = opaque;
+
+    if (addr + size > ASPEED_UFS_MMIO_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "aspeed-ufs: write out of range 0x%" HWADDR_PRIx "\n",
+                      addr);
+        return;
+    }
+
+    s->regs[R(addr)] = (uint32_t)val;
+
+    switch (addr) {
+
+    case REG_HCE:
+        if (val & HCE_ENABLE) {
+            /*
+             * Restart the 1->0->1 toggle on every HCE=1 write, including
+             * when Linux re-enables the controller after U-Boot.
+             */
+            if (s->hce_phase != 2) {
+                s->regs[R(REG_HCE)] = 0;
+                s->hce_phase = 1;
+                qemu_bh_schedule(s->hce_bh);
+            }
+        } else {
+            s->regs[R(REG_HCE)] = 0;
+            s->regs[R(REG_HCS)] = 0;
+            s->hce_phase = 0;
+        }
+        break;
+
+    case REG_UICCMD: {
+        uint8_t opcode = (uint8_t)(val & 0xff);
+
+        s->regs[R(REG_UCMDARG2)] = UIC_CMD_RESULT_OK;
+        s->regs[R(REG_IS)] |= IS_UCCS;
+
+        if (opcode == DME_LINKSTARTUP) {
+            s->regs[R(REG_IS)]  |= IS_UIC_LINK_STARTUP;
+            s->regs[R(REG_HCS)]  = ASPEED_UFS_HCS_READY;
+        }
+
+        /*
+         * Power mode changes (DME_SET / DME_PEER_SET): set HCS[10:8] to
+         * PWR_LOCAL and raise IS_UIC_POWER_MODE so ufshcd_uic_pwr_ctrl()
+         * does not time out waiting for the completion interrupt.
+         */
+        if (opcode == DME_SET || opcode == DME_PEER_SET) {
+            s->regs[R(REG_HCS)] |= HCS_PWR_LOCAL;
+            s->regs[R(REG_IS)]  |= IS_UIC_POWER_MODE;
+        }
+
+        /*
+         * DME_GET / DME_PEER_GET: return plausible gear/lane values so
+         * ufshcd_get_max_pwr_mode() does not fail with rx=0, tx=0.
+         */
+        if (opcode == DME_GET || opcode == DME_PEER_GET) {
+            s->regs[R(REG_UCMDARG3)] = 0x00000003;
+        }
+
+        aspeed_ufs_update_irq(s);
+        break;
+    }
+
+    case REG_IS:
+        /* W1C: write-1-to-clear */
+        s->regs[R(REG_IS)] &= ~(uint32_t)val;
+        aspeed_ufs_update_irq(s);
+        break;
+
+    case REG_IE:
+        aspeed_ufs_update_irq(s);
+        break;
+
+    case REG_UTRLBA:
+        s->utrl_base = (s->utrl_base & 0xffffffff00000000ULL) |
+                       ((uint64_t)(val & 0xfffffc00));
+        break;
+
+    case REG_UTRLBAU:
+        s->utrl_base = (s->utrl_base & 0x00000000ffffffffULL) |
+                       ((uint64_t)val << 32);
+        break;
+
+    case REG_UTMRLBA:
+        s->utmrl_base = (s->utmrl_base & 0xffffffff00000000ULL) |
+                        ((uint64_t)(val & 0xfffffc00));
+        break;
+
+    case REG_UTMRLBAU:
+        s->utmrl_base = (s->utmrl_base & 0x00000000ffffffffULL) |
+                        ((uint64_t)val << 32);
+        break;
+
+    case REG_UTRLRSR:
+    case REG_UTMRLRSR:
+        break;
+
+    case REG_UTRLDBR:
+        s->utrldbr |= (uint32_t)val;
+        s->regs[R(REG_UTRLDBR)] = s->utrldbr;
+        aspeed_ufs_doorbell_bh(s);
+        break;
+
+    case REG_UTRLCLR:
+        s->utrldbr &= (uint32_t)val;
+        s->regs[R(REG_UTRLDBR)] = s->utrldbr;
+        break;
+
+    case REG_UTMRLDBR: {
+        /*
+         * Task management doorbell.  Write OCS=SUCCESS into each requested
+         * UTMRD so ufshcd_issue_tm_cmd() reads back success, clear the
+         * doorbell, then raise IS_UTMRCS so ufshcd_tmc_handler() fires
+         * complete() on the waiting thread.
+         *
+         * UTMRD slot stride is 80 bytes (request_desc_header:16 +
+         * upiu_req:32 + upiu_rsp:32); OCS is at byte 8 of the header.
+         */
+        uint32_t dbr = (uint32_t)val;
+        while (dbr) {
+            int slot = ctz32(dbr);
+            uint64_t ocs_addr = s->utmrl_base +
+                                (uint64_t)slot * UTMRD_SIZE +
+                                UTMRD_OCS_OFFSET;
+            uint8_t ocs = OCS_SUCCESS;
+            ufs_dma_write(ocs_addr, &ocs, sizeof(ocs));
+            dbr &= ~(1u << slot);
+        }
+        s->regs[R(REG_UTMRLDBR)] = 0;
+        s->regs[R(REG_IS)] |= IS_UTMRCS;
+        aspeed_ufs_update_irq(s);
+        break;
+    }
+
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_ufs_ops = {
+    .read       = aspeed_ufs_read,
+    .write      = aspeed_ufs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_ufs_reset(DeviceState *dev)
+{
+    AspeedUFSState *s = ASPEED_UFS(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    s->regs[R(REG_CAP)]   = ASPEED_UFS_CAP_RESET;
+    s->regs[R(REG_VER)]   = ASPEED_UFS_VER_RESET;
+    s->regs[R(REG_HCPID)] = 0x41535045;   /* "ASPE" in ASCII */
+    s->regs[R(REG_HCMID)] = 0x45440000;   /* "ED\0\0" in ASCII */
+
+    s->regs[R(REG_HCE)] = 0;
+    s->regs[R(REG_HCS)] = 0;
+
+    s->hce_phase  = 0;
+    s->utrldbr    = 0;
+    s->utrl_base  = 0;
+    s->utmrl_base = 0;
+
+    qemu_set_irq(s->irq, 0);
+}
+
+static void aspeed_ufs_realize(DeviceState *dev, Error **errp)
+{
+    AspeedUFSState *s = ASPEED_UFS(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_ufs_ops, s,
+                          TYPE_ASPEED_UFS, ASPEED_UFS_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->hce_bh = qemu_bh_new(aspeed_ufs_hce_bh, s);
+
+    if (s->blk) {
+        int64_t sz = blk_getlength(s->blk);
+        if (sz <= 0) {
+            error_setg(errp, "aspeed-ufs: cannot determine drive size");
+            return;
+        }
+        s->num_sectors = (uint64_t)sz / 512;
+        blk_set_dev_ops(s->blk, NULL, NULL);
+        if (blk_set_perm(s->blk,
+                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                         BLK_PERM_ALL, errp) < 0) {
+            return;
+        }
+    } else {
+        /* No drive attached; expose a minimal read-only stub. */
+        s->num_sectors = 2048;
+    }
+
+    aspeed_ufs_init_unit_desc(s);
+    aspeed_ufs_reset(dev);
+}
+
+static const VMStateDescription vmstate_aspeed_ufs = {
+    .name               = TYPE_ASPEED_UFS,
+    .version_id         = 1,
+    .minimum_version_id = 1,
+    .fields             = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedUFSState, ASPEED_UFS_NUM_REGS),
+        VMSTATE_INT32(hce_phase, AspeedUFSState),
+        VMSTATE_UINT32(utrldbr, AspeedUFSState),
+        VMSTATE_UINT64(utrl_base, AspeedUFSState),
+        VMSTATE_UINT64(utmrl_base, AspeedUFSState),
+        VMSTATE_UINT64(num_sectors, AspeedUFSState),
+        VMSTATE_UINT8_ARRAY(unit_desc, AspeedUFSState, 0x23),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property aspeed_ufs_properties[] = {
+    DEFINE_PROP_DRIVE("drive", AspeedUFSState, blk),
+};
+
+static void aspeed_ufs_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize  = aspeed_ufs_realize;
+    device_class_set_legacy_reset(dc, aspeed_ufs_reset);
+    dc->vmsd     = &vmstate_aspeed_ufs;
+    dc->desc     = "ASPEED AST2700 UFS Host Controller";
+    device_class_set_props(dc, aspeed_ufs_properties);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo aspeed_ufs_info = {
+    .name          = TYPE_ASPEED_UFS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedUFSState),
+    .class_init    = aspeed_ufs_class_init,
+};
+
+static void aspeed_ufs_register_types(void)
+{
+    type_register_static(&aspeed_ufs_info);
+}
+
+type_init(aspeed_ufs_register_types)
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
index 6e68328b93..86052e6fd2 100644
--- a/hw/ufs/meson.build
+++ b/hw/ufs/meson.build
@@ -1 +1,2 @@
 system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs.c', 'lu.c'))
+system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_ufs.c'))
-- 
2.53.0


