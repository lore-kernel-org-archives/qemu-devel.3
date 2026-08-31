Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31141C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11AA-0003Yn-25; Mon, 31 Aug 2026 08:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x11A7-0003XZ-0X; Mon, 31 Aug 2026 08:30:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x11A4-00068E-VN; Mon, 31 Aug 2026 08:30:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBVi3O2088746; Mon, 31 Aug 2026 12:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=obmode
 y2I72xdcPEd0v8bW4WisFO20+pjit4PqMCrsc=; b=R0PMA93tTuAQoZ8sgfR6aA
 S5qJiObFJaUYh8lWHLUFgR1UrvMnmA3W/eAGRQtRh0MsypxUJumpR4wlfx4IZZkT
 8vwkWCnD3XFQ5FnTK7cuG/3vDTt3qdJocqv4skPBzXtOHrWcndh1f+ZJ6ipZ1yla
 pVH45QyjmhUA6vjdFMS9rIbLxValTbOay7h0LL8M1GGwTlCdhsiswVMAl7yabc+t
 ii5BsYaI5JkKUx2jPo3ZekVlCc77MO0NAnIsV+LxKIHU7haXwU+LI4aHNMLWTftM
 H6ZGOgLjh/btVoP/Qj+fd+egNSroqKbPVWdk8Cpd0TEjk4wEE5Fa+zm3VU7xd4wg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx597e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VCQKRT003129;
 Mon, 31 Aug 2026 12:30:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vwvu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VCUNBH30212798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 12:30:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51DBB58058;
 Mon, 31 Aug 2026 12:30:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 570F55805D;
 Mon, 31 Aug 2026 12:30:22 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 12:30:22 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 7/9] pnv/phb5: Set link speed and width in the DLP training
 control register
Date: Mon, 31 Aug 2026 07:30:03 -0500
Message-ID: <20260831123005.1485518-8-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9573e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=-b7IsxyX4n235a3dhHEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: mo1BZ2dX34Jh_76AqL6YAkKo6ytGx62E
X-Proofpoint-ORIG-GUID: uCZQDJcG40p0kWUZV_MO_52MEkHhShNc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX7zVZHbPoLDJs
 H9iZ/m02k4W/kv9vrr9PLpJEXw0i946tAEK+fId5NwHsHhzIKH7mb0i+WQxEl8XSNygcCqYLyrP
 b4nEmXQ6w29dENKNBiNZ8NkVZftxFes=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX4L7pxQz9OdAO
 Bjhxc2jbU2gPLLaugvuTrPUjNPIO+YdtTGmKqaOuPuigGj+VD4ER9r+17yPbMN73c8JCRuRRo5a
 0dwTlGBzrUKtEWV8oGwwa5nYAnKQyifQl16V07FOIsvQcCXTn9rLvToXie1KXtYV8wWdk7vBqPp
 1u2pX+ij6DKL54DCMaWzZutU1qYDPcw7AovIXLDgkGNi7qmQqkRlyuoNC3/bhjvDHUzV9+iawHx
 rWUpAP3RJzyHWtDqFgcRy5VGSGVBBAfTgCIGnU+OWchVSm2HvSl8+koZHdOfLGeuLfTuvlFjOKJ
 SUz1ynyVvuRggSinqWMOFDNoJtOC0FnFN7aAeWTgEIzPM8CkBmWkSH2eTSePKWZmi7cIgIU7RT+
 9hzJmAf+3wvJzBkFwYjPgCFqmHkxRDzCg0Z98DNmVqvTf44rnkciNGldXWGmrCK1Ttdy27POfp5
 8hc8v4Kb9yVqfsNTaHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310104
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Get the current link-status from PCIE macro.
Extract link-speed and link-width from the link-status
and set in the DLP training control (PCIE_DLP_TCR) register.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 87446aedc8..56952a6200 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -518,7 +518,7 @@ static uint32_t is_link_active(PnvPHB4 *phb)
     PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
     uint32_t exp_offset = get_exp_offset(pdev);
 
-    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
+    return (be32_to_cpu(pnv_phb4_rc_config_read(phb,
                         exp_offset + PCI_EXP_LNKSTA, 4)) &
                         PCI_EXP_LNKSTA_DLLLA);
 }
@@ -865,6 +865,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
     uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
+    uint32_t v, lnkstatus;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
         return pnv_phb4_config_read(phb, off & 0x3, size);
@@ -926,10 +927,27 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
         break;
 
-    /* Link training always appears trained */
     case PHB_PCIE_DLP_TRAIN_CTL:
-        /* TODO: Do something sensible with speed ? */
+        /* Get the current link-status from PCIE */
+        lnkstatus = be32_to_cpu(pnv_phb4_rc_config_read(phb,
+                                exp_base + PCI_EXP_LNKSTA, 4));
+
+        /* Extract link-speed from the link-status */
+        v = lnkstatus & PCI_EXP_LNKSTA_CLS;
+
+        /* Link training always appears trained */
         val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
+
+        /* Set the current link-speed at the LINK_SPEED position */
+        val = SETFIELD(PHB_PCIE_DLP_LINK_SPEED, val, v);
+
+        /*
+         * Extract link-width from the link-status,
+         * after shifting the required bitfields.
+         */
+        v = (lnkstatus & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
+        /* Set the current link-width at the LINK_WIDTH position */
+        val = SETFIELD(PHB_PCIE_DLP_LINK_WIDTH, val, v);
         return val;
 
     /*
@@ -952,7 +970,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
          * convert the value back to host format.
          * Clear the Presence-status active low bit.
          */
-        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
+        if (be32_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
                                                 4))
                     & PCI_EXP_SLTSTA_PDS) {
             val &= ~PHB_PCIE_HPSTAT_PRESENCE;
-- 
2.52.0


