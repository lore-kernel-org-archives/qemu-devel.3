Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8F4CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxppK-0002Zl-8e; Mon, 07 Oct 2024 11:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxpp7-0002H6-Dc; Mon, 07 Oct 2024 11:39:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxpp3-0001V9-H5; Mon, 07 Oct 2024 11:39:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FODmV008020;
 Mon, 7 Oct 2024 15:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 bYzaPWE7kV9zinJRK6pZNT1jcer/jFPy3A+C5d4oNYA=; b=cy5gDqyifbHqcT26
 61dFaya9iu2TvaEh/yQ0PvvfGC02zeAkpwwvTqrJ7+KHbit/cusOnj1QkVATwhJb
 lmfr3JI2RNvHJ/mB/X8b2ywvFCTS7C1uedQgOQyADLEvVu7xovrqwHTgEJroNka6
 Q3muk/eje9O2UY88U7SIm/O6DPT61r5eCx6aJ1IwGExQ/3IUTxUGI31pv1OKUChy
 0hZPR2pzNZ9eW/ZbxBFdH+KRPWNlpQHFoxvw69AYuI0H/1N69nCkcKqtf4envVfm
 2wbRRY5VNgCpxkBurDY/XMOG+1768GtUWeX3sDkjLBJbzRaGj4xCbtK+zP/w/bIh
 +fS85A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424j8cg35b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:52 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497Fcqog011884;
 Mon, 7 Oct 2024 15:38:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424j8cg356-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497EaSt4022678;
 Mon, 7 Oct 2024 15:38:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9jqb27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 497FcmOW22544734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2024 15:38:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D88812004D;
 Mon,  7 Oct 2024 15:38:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF8CA20043;
 Mon,  7 Oct 2024 15:38:47 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2024 15:38:47 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v3 03/14] ppc/spapr: remove deprecated machine pseries-2.3
Date: Mon,  7 Oct 2024 21:08:27 +0530
Message-ID: <20241007153838.1085522-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007153838.1085522-1-harshpb@linux.ibm.com>
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O4tw8ZJHmI96kaiti5keJsf7IrEoThEv
X-Proofpoint-ORIG-GUID: ezRFPz1QF4_BB5OQx7u5TvIuQIAHXKwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 mlxlogscore=928 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.3 specific code with this patch for now.

While at it, also remove the dynamic-reconfiguration option which was
introduced to disable it by default for legacy machines until pseries-2.3.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/pci-host/spapr.h |  1 -
 hw/ppc/spapr.c              | 15 ---------------
 hw/ppc/spapr_pci.c          | 35 -----------------------------------
 3 files changed, 51 deletions(-)

diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 3778aac27b..79187e80fd 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -53,7 +53,6 @@ struct SpaprPhbState {
     uint32_t index;
     uint64_t buid;
     char *dtbusname;
-    bool dr_enabled;
 
     MemoryRegion memspace, iospace;
     hwaddr mem_win_addr, mem_win_size, mem64_win_addr, mem64_win_size;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 34d655d0b3..599a59910c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5349,21 +5349,6 @@ static void spapr_machine_2_4_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 4);
 
-/*
- * pseries-2.3
- */
-
-static void spapr_machine_2_3_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { "spapr-pci-host-bridge", "dynamic-reconfiguration", "off" },
-    };
-    spapr_machine_2_4_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-DEFINE_SPAPR_MACHINE(2, 3);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5c0024bef9..8f1964ce52 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1237,10 +1237,6 @@ static void add_drcs(SpaprPhbState *phb, PCIBus *bus)
     int i;
     uint8_t chassis;
 
-    if (!phb->dr_enabled) {
-        return;
-    }
-
     chassis = chassis_from_bus(bus);
 
     if (pci_bus_is_root(bus)) {
@@ -1260,10 +1256,6 @@ static void remove_drcs(SpaprPhbState *phb, PCIBus *bus)
     int i;
     uint8_t chassis;
 
-    if (!phb->dr_enabled) {
-        return;
-    }
-
     chassis = chassis_from_bus(bus);
 
     for (i = PCI_SLOT_MAX * PCI_FUNC_MAX - 1; i >= 0; i--) {
@@ -1548,17 +1540,6 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
     PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
-    if (!phb->dr_enabled) {
-        /* if this is a hotplug operation initiated by the user
-         * we need to let them know it's not enabled
-         */
-        if (plugged_dev->hotplugged) {
-            error_setg(errp, "Bus '%s' does not support hotplugging",
-                       phb->parent_obj.bus->qbus.name);
-            return;
-        }
-    }
-
     if (IS_PCI_BRIDGE(plugged_dev)) {
         if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
             return;
@@ -1591,14 +1572,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
-    /*
-     * If DR is disabled we don't need to do anything in the case of
-     * hotplug or coldplug callbacks.
-     */
-    if (!phb->dr_enabled) {
-        return;
-    }
-
     g_assert(drc);
 
     if (IS_PCI_BRIDGE(plugged_dev)) {
@@ -1673,12 +1646,6 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
     SpaprDrc *drc = drc_from_dev(phb, pdev);
 
-    if (!phb->dr_enabled) {
-        error_setg(errp, "Bus '%s' does not support hotplugging",
-                   phb->parent_obj.bus->qbus.name);
-        return;
-    }
-
     g_assert(drc);
     g_assert(drc->dev == plugged_dev);
 
@@ -2089,8 +2056,6 @@ static Property spapr_phb_properties[] = {
                        SPAPR_PCI_MEM64_WIN_SIZE),
     DEFINE_PROP_UINT64("io_win_size", SpaprPhbState, io_win_size,
                        SPAPR_PCI_IO_WIN_SIZE),
-    DEFINE_PROP_BOOL("dynamic-reconfiguration", SpaprPhbState, dr_enabled,
-                     true),
     /* Default DMA window is 0..1GB */
     DEFINE_PROP_UINT64("dma_win_addr", SpaprPhbState, dma_win_addr, 0),
     DEFINE_PROP_UINT64("dma_win_size", SpaprPhbState, dma_win_size, 0x40000000),
-- 
2.45.2


