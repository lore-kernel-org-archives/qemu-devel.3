Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9769CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuJc-0004WR-GP; Thu, 23 Oct 2025 08:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFw-000161-QX
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFs-0006Og-Fj
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:24 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N51Oat017546;
 Thu, 23 Oct 2025 12:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dcACo3
 S87IyV+ig7TtWdbS+8ojMBsIUe/dLyrFg9j/U=; b=Ig0SZea0erytRHKqA2lBWO
 WjtUQ5q/2aUpxVZTmfDaTDgQB6Go8vebXks0v9dysdUly1sxvUNC+VO6RNmrWuNg
 o+cTaa37fpZCeCtWnbMi2rJWs78IsvYDFStTnaJUoD5tucQL+UBoHnvMYt0QSO+3
 2L0KbNZqLw2S2usTrTKJBVI859ZBn7WAspkYPC3k6hMWL6RMGeR28uivWXLGzniZ
 yMXSRy2x9Gqx43O0EI2xn01SGv8KTI0vrT8WRevVLbyHT1lAYdfN5DhBwkzGUFhl
 b2uiVLFkgSRIuhS20AwiRTGmyQ+DTAcuODSL2+m0He2u1v1wG3cLmBpYg8b8guxA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fj25h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9FJ6Z014848;
 Thu, 23 Oct 2025 12:17:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdtt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHDbh41156898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5664520043;
 Thu, 23 Oct 2025 12:17:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75BB620040;
 Thu, 23 Oct 2025 12:17:12 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:12 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 09/32] hw/ppc/spapr: Remove SpaprMachineClass::phb_placement
 callback
Date: Thu, 23 Oct 2025 17:46:28 +0530
Message-ID: <20251023121653.3686015-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa1ccd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=l7mRzedawI2mqaqXN0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: AekCClPHkTvHBmXUPepPevIfa8V10eIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7bOzFa66ly1/
 291TOPKcPKGczE5oTQW8Ishq4oCWeFk0QBFcSDtSLNkXAIC0DZ30ZT17GsDDkCO2YvoDKfS6fWQ
 E+wJqnSGuhUPhn1vFhY8HQAVAhf6DQfznTmDDfELw37Su3wETYbCTGPQkOksajKBKY3D7e8plmd
 SqNZfy2k3JMYPzPx5Ld/7jogppZp63X1A6ECUxmC1uzK5lyfb79Hh/sUN2NNCvDmLWTW21qUvPI
 AxXUI79vtvvLr1oMaiCfJxPeuMaQRnw8IcvUvPz0DxgLWuwWjFF7qU9dtgxymU8DVLPl+LAwAhQ
 4xewE3Yg4nMr7Pkp+ojpTqz7vNByoJNj87X5gbnAoA5UIqAP21xSbMPTjxJ9X8o6cIWWuBTrby7
 nNujIGaPDHN+4dxi1PH+oPEOEv1FRQ==
X-Proofpoint-ORIG-GUID: AekCClPHkTvHBmXUPepPevIfa8V10eIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The SpaprMachineClass::phb_placement callback was only used by
the pseries-4.0 machine, which got removed. Remove it as now
unused, directly calling spapr_phb_placement().
Move spapr_phb_placement() definition to avoid forward declaration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-10-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |   5 --
 hw/ppc/spapr.c         | 114 ++++++++++++++++++++---------------------
 2 files changed, 55 insertions(+), 64 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 58d31b096c..bd783e92e1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -147,11 +147,6 @@ struct SpaprMachineClass {
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
     bool pre_6_2_numa_affinity;
-
-    bool (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
-                          uint64_t *buid, hwaddr *pio,
-                          hwaddr *mmio32, hwaddr *mmio64,
-                          unsigned n_dma, uint32_t *liobns, Error **errp);
     SpaprResizeHpt resize_hpt_default;
     SpaprCapabilities default_caps;
     SpaprIrq *irq;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ea7d2a03aa..371593d0b5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4068,12 +4068,62 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
     return 0;
 }
 
+static bool spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
+                                uint64_t *buid, hwaddr *pio,
+                                hwaddr *mmio32, hwaddr *mmio64,
+                                unsigned n_dma, uint32_t *liobns, Error **errp)
+{
+    /*
+     * New-style PHB window placement.
+     *
+     * Goals: Gives large (1TiB), naturally aligned 64-bit MMIO window
+     * for each PHB, in addition to 2GiB 32-bit MMIO and 64kiB PIO
+     * windows.
+     *
+     * Some guest kernels can't work with MMIO windows above 1<<46
+     * (64TiB), so we place up to 31 PHBs in the area 32TiB..64TiB
+     *
+     * 32TiB..(33TiB+1984kiB) contains the 64kiB PIO windows for each
+     * PHB stacked together.  (32TiB+2GiB)..(32TiB+64GiB) contains the
+     * 2GiB 32-bit MMIO windows for each PHB.  Then 33..64TiB has the
+     * 1TiB 64-bit MMIO windows for each PHB.
+     */
+    const uint64_t base_buid = 0x800000020000000ULL;
+    int i;
+
+    /* Sanity check natural alignments */
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_BASE % SPAPR_PCI_MEM64_WIN_SIZE) != 0);
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_LIMIT % SPAPR_PCI_MEM64_WIN_SIZE) != 0);
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WIN_SIZE) != 0);
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_SIZE) != 0);
+    /* Sanity check bounds */
+    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
+                      SPAPR_PCI_MEM32_WIN_SIZE);
+    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
+                      SPAPR_PCI_MEM64_WIN_SIZE);
+
+    if (index >= SPAPR_MAX_PHBS) {
+        error_setg(errp, "\"index\" for PAPR PHB is too large (max %llu)",
+                   SPAPR_MAX_PHBS - 1);
+        return false;
+    }
+
+    *buid = base_buid + index;
+    for (i = 0; i < n_dma; ++i) {
+        liobns[i] = SPAPR_PCI_LIOBN(index, i);
+    }
+
+    *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
+    *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
+    *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
+    return true;
+}
+
 static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     const unsigned windows_supported = spapr_phb_windows_supported(sphb);
     SpaprDrc *drc;
 
@@ -4092,12 +4142,10 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      * This will check that sphb->index doesn't exceed the maximum number of
      * PHBs for the current machine type.
      */
-    return
-        smc->phb_placement(spapr, sphb->index,
-                           &sphb->buid, &sphb->io_win_addr,
-                           &sphb->mem_win_addr, &sphb->mem64_win_addr,
-                           windows_supported, sphb->dma_liobn,
-                           errp);
+    return spapr_phb_placement(spapr, sphb->index,
+                               &sphb->buid, &sphb->io_win_addr,
+                               &sphb->mem_win_addr, &sphb->mem64_win_addr,
+                               windows_supported, sphb->dma_liobn, errp);
 }
 
 static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
@@ -4345,57 +4393,6 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
     return machine->possible_cpus;
 }
 
-static bool spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
-                                uint64_t *buid, hwaddr *pio,
-                                hwaddr *mmio32, hwaddr *mmio64,
-                                unsigned n_dma, uint32_t *liobns, Error **errp)
-{
-    /*
-     * New-style PHB window placement.
-     *
-     * Goals: Gives large (1TiB), naturally aligned 64-bit MMIO window
-     * for each PHB, in addition to 2GiB 32-bit MMIO and 64kiB PIO
-     * windows.
-     *
-     * Some guest kernels can't work with MMIO windows above 1<<46
-     * (64TiB), so we place up to 31 PHBs in the area 32TiB..64TiB
-     *
-     * 32TiB..(33TiB+1984kiB) contains the 64kiB PIO windows for each
-     * PHB stacked together.  (32TiB+2GiB)..(32TiB+64GiB) contains the
-     * 2GiB 32-bit MMIO windows for each PHB.  Then 33..64TiB has the
-     * 1TiB 64-bit MMIO windows for each PHB.
-     */
-    const uint64_t base_buid = 0x800000020000000ULL;
-    int i;
-
-    /* Sanity check natural alignments */
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_BASE % SPAPR_PCI_MEM64_WIN_SIZE) != 0);
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_LIMIT % SPAPR_PCI_MEM64_WIN_SIZE) != 0);
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WIN_SIZE) != 0);
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_SIZE) != 0);
-    /* Sanity check bounds */
-    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
-                      SPAPR_PCI_MEM32_WIN_SIZE);
-    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
-                      SPAPR_PCI_MEM64_WIN_SIZE);
-
-    if (index >= SPAPR_MAX_PHBS) {
-        error_setg(errp, "\"index\" for PAPR PHB is too large (max %llu)",
-                   SPAPR_MAX_PHBS - 1);
-        return false;
-    }
-
-    *buid = base_buid + index;
-    for (i = 0; i < n_dma; ++i) {
-        liobns[i] = SPAPR_PCI_LIOBN(index, i);
-    }
-
-    *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
-    *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
-    *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
-    return true;
-}
-
 static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(dev);
@@ -4606,7 +4603,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
-    smc->phb_placement = spapr_phb_placement;
     vhc->cpu_in_nested = spapr_cpu_in_nested;
     vhc->deliver_hv_excp = spapr_exit_nested;
     vhc->hypercall = emulate_spapr_hypercall;
-- 
2.43.5


