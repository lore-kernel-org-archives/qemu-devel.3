Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723FCD16257
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KB2-00006O-AE; Mon, 14 Oct 2024 08:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KB0-00005q-Qd; Mon, 14 Oct 2024 08:27:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KAy-0002Np-JP; Mon, 14 Oct 2024 08:27:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAL0F0018921;
 Mon, 14 Oct 2024 12:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 c2qr8Nx7d7AOqFsqMMW9Lw/u+2HSKV2k8F7TGuKaBVo=; b=SXRAoNx11BjF6G9s
 IFB6vDWJNtDn2aLOYXECV+9LEFMCI7Y9Y7Q1G5ebIpppHVv9kaHa2NOpoaeAcLwd
 tjdSXuqga6YW+uv10y0VIuFKQbSerBI6npDQxssdOKzLajQum8PbXUYR9hZcoH+Y
 juig4bUVYQ9TWF+ly5LwkiWdfZ8Voqbv3a7Y6VgQY4fMpq7+82m6avM5bQoRiAXw
 utHmlqWJx+oORUfZn//pECS+QeScNT5DOK2yu7Tbra6mQ29y46ESRhFXV7AA6VAh
 n6GEcCBJtuwphpGnDjz5s7oytApuvamJb5hSdWVPxIfAvXpoqQdVHJvTsFhP+z/t
 Uft/XA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88k96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:49 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ECP9sE006500;
 Mon, 14 Oct 2024 12:27:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88k95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EB3f8K002408;
 Mon, 14 Oct 2024 12:27:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emefff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49ECRklm26411504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 12:27:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E4D220043;
 Mon, 14 Oct 2024 12:27:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 764DC20040;
 Mon, 14 Oct 2024 12:27:45 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 12:27:45 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v4 03/13] ppc/spapr: remove deprecated machine pseries-2.3
Date: Mon, 14 Oct 2024 17:57:19 +0530
Message-ID: <20241014122729.1136809-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014122729.1136809-1-harshpb@linux.ibm.com>
References: <20241014122729.1136809-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GTuIVZftzirmOI9aI0l6hxSaHA_c_O56
X-Proofpoint-ORIG-GUID: 6uUzA5TtwuSzNtSwBT7-G8Kwn0e2l5Bf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140089
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/boards.h         |  3 ---
 include/hw/pci-host/spapr.h |  1 -
 hw/core/machine.c           | 13 -------------
 hw/ppc/spapr.c              | 15 ---------------
 hw/ppc/spapr_pci.c          | 35 -----------------------------------
 5 files changed, 67 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7e849bb30d..eea592b720 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -822,7 +822,4 @@ extern const size_t hw_compat_2_5_len;
 extern GlobalProperty hw_compat_2_4[];
 extern const size_t hw_compat_2_4_len;
 
-extern GlobalProperty hw_compat_2_3[];
-extern const size_t hw_compat_2_3_len;
-
 #endif
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
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2bbfcd1ede..0f10b4f992 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -281,19 +281,6 @@ GlobalProperty hw_compat_2_4[] = {
 };
 const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
 
-GlobalProperty hw_compat_2_3[] = {
-    { "virtio-blk-pci", "any_layout", "off" },
-    { "virtio-balloon-pci", "any_layout", "off" },
-    { "virtio-serial-pci", "any_layout", "off" },
-    { "virtio-9p-pci", "any_layout", "off" },
-    { "virtio-rng-pci", "any_layout", "off" },
-    { TYPE_PCI_DEVICE, "x-pcie-lnksta-dllla", "off" },
-    { "migration", "send-configuration", "off" },
-    { "migration", "send-section-footer", "off" },
-    { "migration", "store-global-state", "off" },
-};
-const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
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


