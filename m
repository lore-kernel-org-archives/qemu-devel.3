Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF3EC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 22:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT8X5-000777-1O; Thu, 25 Jan 2024 17:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rT8X1-00076A-6K; Thu, 25 Jan 2024 17:49:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rT8Wz-0000TN-GZ; Thu, 25 Jan 2024 17:49:10 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PMguiP010224; Thu, 25 Jan 2024 22:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=RZo93cgIGYRMl8zo8ce2BHDmVaowU2spY3Tyaynf2AQ=;
 b=MSVtpNN2ywWk2Rj+3CUxN2P5zv3Nef64cl6DKhPMR8XxX2g1AS285M3VcZvFLuy98q0b
 zzWR8/aJ002kIRNrLJp6F9PZZagFMgPQv3CTSxZh+pfk2FccCPLGeADgA/INPyNpQvFJ
 4zfRqFZtiyfME+StZs5iBNwBeH27KjxpE1rcG7Ce/8RsqrsCe9O5FCRGrnAGbjR5R/iE
 0U39GiAlE93GBSblBUCP65h/WEQZ5dQ2BS7WS6odLFi3kPcwrMvrXWISC7dAo5VfG+gn
 QCPG8iTXDKNCIxLOO0yhD3xn1o4u1sc1BXqiuMrExQ7pbEP7Muk90icNUDEWivu2Woyv kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv0p7r4e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 22:49:00 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PMjejB018685;
 Thu, 25 Jan 2024 22:49:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv0p7r4dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 22:49:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PL2iOB026505; Thu, 25 Jan 2024 22:48:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtqdvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 22:48:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40PMmw2118416226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 22:48:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFD7058058;
 Thu, 25 Jan 2024 22:48:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 951EF58057;
 Thu, 25 Jan 2024 22:48:58 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 22:48:58 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Subject: [PATCH v7 4/9] ppc/pnv: Add pca9552 to powernv10-rainier for PCIe
 hotplug power control
Date: Thu, 25 Jan 2024 16:48:13 -0600
Message-Id: <20240125224818.146499-5-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240125224818.146499-1-milesg@linux.vnet.ibm.com>
References: <20240125224818.146499-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GxcKWQGRNn-Mru-K1mFlT-ciKyaLX3gZ
X-Proofpoint-GUID: DFq16PGK8vYpwQT5uiSkeCeYqLxH_pPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250164
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Power Hypervisor code expects to see a pca9552 device connected
to the 3rd PNV I2C engine on port 1 at I2C address 0x63 (or left-
justified address of 0xC6).  This is used by hypervisor code to
control PCIe slot power during hotplug events.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

No changes from previous version

 hw/ppc/Kconfig       |  1 +
 hw/ppc/pnv.c         | 25 +++++++++++++++++++++++++
 include/hw/ppc/pnv.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 44263a58c4..8e592e4307 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -32,6 +32,7 @@ config POWERNV
     select XIVE
     select FDT_PPC
     select PCI_POWERNV
+    select PCA9552
 
 config PPC405
     bool
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 08704ce695..d8d19fb065 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -790,6 +790,7 @@ static void pnv_init(MachineState *machine)
     const char *bios_name = machine->firmware ?: FW_FILE_NAME;
     PnvMachineState *pnv = PNV_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
     char *fw_filename;
     long fw_size;
     uint64_t chip_ram_start = 0;
@@ -979,6 +980,13 @@ static void pnv_init(MachineState *machine)
      */
     pnv->powerdown_notifier.notify = pnv_powerdown_notify;
     qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
+
+    /*
+     * Create/Connect any machine-specific I2C devices
+     */
+    if (pmc->i2c_init) {
+        pmc->i2c_init(pnv);
+    }
 }
 
 /*
@@ -1879,6 +1887,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
                                                PSIHB9_IRQ_SBE_I2C));
     }
+
+}
+
+static void pnv_rainier_i2c_init(PnvMachineState *pnv)
+{
+    int i;
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
+
+        /*
+         * Add a PCA9552 I2C device for PCIe hotplug control
+         * to engine 2, bus 1, address 0x63
+         */
+        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552", 0x63);
+    }
 }
 
 static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
@@ -2286,9 +2309,11 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
 
     pnv_machine_p10_common_class_init(oc, data);
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
+    pmc->i2c_init = pnv_rainier_i2c_init;
 }
 
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 7e5fef7c43..110ac9aace 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -76,6 +76,7 @@ struct PnvMachineClass {
     int compat_size;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
+    void (*i2c_init)(PnvMachineState *pnv);
 };
 
 struct PnvMachineState {
-- 
2.31.1


