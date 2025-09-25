Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE60CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ppl-0002RA-9r; Thu, 25 Sep 2025 13:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pow-0001tA-4B; Thu, 25 Sep 2025 13:31:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pop-0006Dq-7q; Thu, 25 Sep 2025 13:31:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHPScw030761;
 Thu, 25 Sep 2025 17:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1sWZTR
 7xobDj/nhjxrxBqa4K++hourJNEnjur3rscdA=; b=JvsABFonPL27OfNtwbLtZZ
 kyTqcVdgMIz/bB1EdU04g+huydP4jk+t4+1q8Z+h4OW8/KtIxalhZRUM4MqrcX0J
 AdqKiKxeHfPMoIYdis3R0cX6ld0Ax6q6n0Yj3yq63J/05HKjvDjAsR73QrFTourY
 jTKX7q4pz7G6ghkMEBA3oxA6wIRwrcEZ1qQOkDvqDLTKiiedm0nKXg++I9H5pk8r
 eImLpOqrQ153vCI62wf4Rvh2II/iHNg5CUMxJ4YNzgCsa8wQJomD7pXyd/vjLNdw
 c9nRfwjHbD9zQRKs3ECMQFxnro6yv/rd6JPRTbnrMY/V1ITsajIsnHTIRtQg/XSw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6fd16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PHTgwb005119;
 Thu, 25 Sep 2025 17:31:38 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6fd10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHUB5f030345;
 Thu, 25 Sep 2025 17:31:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1ey48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHVXed52035902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:31:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8930920043;
 Thu, 25 Sep 2025 17:31:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6DC020040;
 Thu, 25 Sep 2025 17:31:28 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.220.124])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:31:28 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v10 2/8] ppc/pnv: Introduce Power11 PowerNV machine
Date: Thu, 25 Sep 2025 23:00:43 +0530
Message-ID: <20250925173049.891406-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925173049.891406-1-adityag@linux.ibm.com>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e4EFr2kmTDv0qED0pF3yEqnIzm-tUKG_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX6WsSUi60chWZ
 bEjYQqGdlRYgHtqmWuRobUUbB3t5pMxb1MzIooA7fgEiLKtGHh5uZxo5AJp2prIoC6qmTn0U8vi
 Vg3yBXs56jb7CxXwc5bDILPprEJJzQVuTIWTJDGrea3bQP+U0QQ3Yb92F3/KRsJCK4D9cUOwFtf
 j+VQwCojsRgrwX51xKdQRn4KOCpsT7KuCnEunMkPimxM3sPDe/ufJNvpcIBwBem8SqsOn9WAGB7
 f0KMLM8lE5ocR63WUdbDrEvgSPEAUXjihgoROyUr87JRRRPMuy9EtgNDwD/nSzkrOF26optxu8k
 24/BxbdQArWq8qzXFkVx7asHAwz/RAIMk7CUDlD6g4IxfV4A9w0tKKEYbYAfOupD4id0qkBeDFx
 V78DQGe2
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d57c7a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=0il2isBTLgtUhG5GGzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ChcY01ioLO86cvIpe2rZ92Fl7riWlVLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The Powernv11 machine doesn't have XIVE & PHBs as of now

XIVE2 interface and PHB5 added in later patches to Powernv11 machine

Also add mention of Power11 to powernv documentation

Note: A difference from P10's and P11's machine_class_init is, in P11
different number of PHBs cannot be used on the command line, ie. the
following line does NOT exist in pnv_machine_power11_class_init, which
existed in case of Power10:

    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/system/ppc/powernv.rst |  9 +++++----
 hw/ppc/pnv.c                | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index f3ec2cc69c0d..5154794cc8cd 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -1,5 +1,5 @@
-PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``)
-==================================================================
+PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``, ``powernv11``)
+================================================================================
 
 PowerNV (as Non-Virtualized) is the "bare metal" platform using the
 OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can
@@ -15,11 +15,12 @@ beyond the scope of what QEMU addresses today.
 Supported devices
 -----------------
 
- * Multi processor support for POWER8, POWER8NVL and POWER9.
+ * Multi processor support for POWER8, POWER8NVL, POWER9, Power10 and Power11.
  * XSCOM, serial communication sideband bus to configure chiplets.
  * Simple LPC Controller.
  * Processor Service Interface (PSI) Controller.
- * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10).
+ * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10 &
+   Power11).
  * POWER8 PHB3 PCIe Host bridge and POWER9 PHB4 PCIe Host bridge.
  * Simple OCC is an on-chip micro-controller used for power management tasks.
  * iBT device to handle BMC communication, with the internal BMC simulator
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 77136091bbca..423954ba7e0c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3235,6 +3235,35 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc,
     pmc->i2c_init = pnv_rainier_i2c_init;
 }
 
+static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    static const char compat[] = "qemu,powernv11\0ibm,powernv";
+
+    pmc->compat = compat;
+    pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 4;
+    pmc->has_lpar_per_thread = true;
+    pmc->quirk_tb_big_core = true;
+    pmc->dt_power_mgt = pnv_dt_power_mgt;
+
+    mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
+
+    object_class_property_add_bool(oc, "big-core",
+                                   pnv_machine_get_big_core,
+                                   pnv_machine_set_big_core);
+    object_class_property_set_description(oc, "big-core",
+                              "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_lpar_per_core,
+                                   pnv_machine_set_lpar_per_core);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
+}
+
 static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     CPUPPCState *env = cpu_env(cs);
@@ -3348,6 +3377,11 @@ static void pnv_machine_class_init(ObjectClass *oc, const void *data)
     }
 
 static const TypeInfo types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("powernv11"),
+        .parent        = TYPE_PNV_MACHINE,
+        .class_init    = pnv_machine_power11_class_init,
+    },
     {
         .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
         .parent        = MACHINE_TYPE_NAME("powernv10"),
-- 
2.50.1


