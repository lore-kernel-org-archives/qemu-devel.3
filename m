Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AACAEF36E8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUus-0006QI-Vr; Mon, 09 Mar 2026 03:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUur-0006PI-6k; Mon, 09 Mar 2026 03:20:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUup-0006EO-J3; Mon, 09 Mar 2026 03:20:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628FG36o661980; Mon, 9 Mar 2026 07:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lYmPT+3wLn+2ZQzkp
 aDwZ+PUmlVFiWIzG3P57Hr4AYg=; b=a6mZKCmRN8h8gdEct2JxLxzwzSGTOlM9N
 VAkJr2pPbYcJH79mG/M8ftu2mdA4KJBBfKt+I4n365lRFYyQaY4g161Q5x36qMgZ
 N0FK55Qfs6xoZha2OsyIvDV0+oPaD4TtRkm1IFnuHv02iGSjivsPLRahZzQE4fZ8
 6pl3CPcFmbCokkl4qrowe017pv0OdKrnfv86w0/p9nGINUmKqFCPj5c+apk4lCE/
 dxVK2gkPFqqZqixTK8UPnnV+mS9AZJ6QU3rAo/wsZqw1ffvreOvcOh66pJqEHX3b
 YH0A4Vr6aIB1MWBbr61nyo0VGEqQ+3mlKwYf4Nkw/ecXUjeJxUlLQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1md8yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6293JFZt029360;
 Mon, 9 Mar 2026 07:20:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6ugm1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6297KTiv49414542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 07:20:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E807F2004B;
 Mon,  9 Mar 2026 07:20:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F4D520040;
 Mon,  9 Mar 2026 07:20:27 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 07:20:26 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v4 08/10] pnv/mpipl: Enable MPIPL support
Date: Mon,  9 Mar 2026 12:49:57 +0530
Message-ID: <20260309072001.3136261-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309072001.3136261-1-adityag@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69ae74c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=dCvegdiEg4V6ml2xVIcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfX3ipUrilegvg6
 +UIgSvHJ1fksrvZE7CSqELMhW4/r6ApZ6eRzza9Eg/VNozeP/3qLjCsG4/9z1hJi2G+EXd372JM
 N5jijrpQhIeoq8zALWfnobYNi1tsLACGpzLKJ8QGNxvWjWNq5dSUwouSQO4AQo0Q68k8qVWFbCN
 LgwZeWyZvkGJfT4k6fyCuLqUW2PuSblPbSFqYJa+6lyrYbjWrSuPve7MhednszUykfLpuLpcngC
 UkqUBQJ8Iq36be6zB+q5zVEGU8c0l7hNktGNZIaIm64wgKDq6W9Dtq0nrBqK3NC5uMWO9yJ4JVD
 9VNBYUnzznYnqNgyo+4zqEoIiAaGyzi7HOZtRbc7yBOBBlMJ/+f0293gJT+94fDgYSILsX+7fcz
 V918gnmbQD/EGwrQmo+Uqk7ezcnwzO237Oz2HQvNkGlGoBqrWJwdIHSMg5mx/V5b/CQIEX1XyvD
 sb0O7o14sGsZyVhjg0w==
X-Proofpoint-GUID: I4kXAlppvnslf1byRF8j5JvgcleLRCtA
X-Proofpoint-ORIG-GUID: ygQKKG5pvfhVXA3wJ7yYrHZpqHrT1iTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With all MPIPL support in place, export a "dump" node in device tree,
signifying that PowerNV QEMU platform supports MPIPL

Also, export fw-load-area dt node, which has details about where the
kernel & initrd were loaded, so that kernel can verify whether the
kernel/initrd images were loaded within the boot memory region. QEMU
just exports these details in fw-load-area, the check for boot memory
region is done in kernel.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0b94e0c7a19b..139a2037e5d6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -54,6 +54,7 @@
 #include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_pnor.h"
+#include "hw/ppc/pnv_mpipl.h"
 
 #include "hw/isa/isa.h"
 #include "hw/char/serial-isa.h"
@@ -672,6 +673,39 @@ static void pnv_dt_power_mgt(PnvMachineState *pnv, void *fdt)
     _FDT(fdt_setprop_cell(fdt, off, "ibm,enabled-stop-levels", 0xc0000000));
 }
 
+static void pnv_dt_mpipl_dump(PnvMachineState *pnv, void *fdt)
+{
+    int off;
+
+    /*
+     * Add "dump" node so kernel knows MPIPL (aka fadump) is supported
+     *
+     * Note: This is only needed to be done since we are passing device tree to
+     * opal
+     *
+     * In case HDAT is supported in future, then opal can add these nodes by
+     * itself based on system attribute having MPIPL_SUPPORTED bit set
+     */
+    off = fdt_add_subnode(fdt, 0, "ibm,opal");
+    if (off == -FDT_ERR_EXISTS) {
+        off = fdt_path_offset(fdt, "/ibm,opal");
+    }
+
+    _FDT(off);
+    off = fdt_add_subnode(fdt, off, "dump");
+    _FDT(off);
+    _FDT((fdt_setprop_string(fdt, off, "compatible", "ibm,opal-dump")));
+
+    /* Add kernel and initrd as fw-load-area */
+    uint64_t fw_load_area[4] = {
+        cpu_to_be64(KERNEL_LOAD_ADDR), cpu_to_be64(KERNEL_MAX_SIZE),
+        cpu_to_be64(INITRD_LOAD_ADDR), cpu_to_be64(INITRD_MAX_SIZE)
+    };
+
+    _FDT((fdt_setprop(fdt, off, "fw-load-area",
+                    fw_load_area, sizeof(fw_load_area))));
+}
+
 static void *pnv_dt_create(MachineState *machine)
 {
     PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
@@ -734,6 +768,9 @@ static void *pnv_dt_create(MachineState *machine)
         pmc->dt_power_mgt(pnv, fdt);
     }
 
+    /* Advertise support for MPIPL */
+    pnv_dt_mpipl_dump(pnv, fdt);
+
     return fdt;
 }
 
-- 
2.53.0


