Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF160D3ABF5
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 05:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRlJq-0004JT-T0; Sat, 06 Dec 2025 00:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJe-0004FB-K5; Sat, 06 Dec 2025 00:58:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJc-0005aI-LQ; Sat, 06 Dec 2025 00:58:46 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B60PALe027633;
 Sat, 6 Dec 2025 05:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VueZTIY2Ugd2O6URX
 Xd0/Ttdg8i3mKIQCFXlU+Qcp7o=; b=SwN51I5OhEnP4wI4weu5Qatx37rY4BD4H
 t79r1USju2BSe1B/PCWJNDoFOOeMPZfuoPHbZ+S/KFifWA483abRlmBFz9cDQ3g0
 T7yNjhC0QALToAsv2iB6geksjMnJuTXr1OOcNe+KabXm8RWeWL+Hvv3Q/WWiwlzl
 Hmk+YOnCN2HHKGkrIkNjcIIzRrdp75ffvo0NM9Tsd96cHwAscCMf9xRjVoryAR9V
 m5V7ApaWpWt4yJA/Rmr8S9uI+xy317ypi4qAf39MJJy0h92gDptSNb+nwjAzLDgl
 /I2EHfHDJbPuGDEmdOnU6bzBf8gjQiavvJedyn+L68EUmRS/jIRDg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wv8r2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B60sNwx024102;
 Sat, 6 Dec 2025 05:58:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5t152j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B65wcfe47514074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Dec 2025 05:58:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22C0F20040;
 Sat,  6 Dec 2025 05:58:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B940B20043;
 Sat,  6 Dec 2025 05:58:35 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.93]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Dec 2025 05:58:35 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 8/9] pnv/mpipl: Enable MPIPL support
Date: Sat,  6 Dec 2025 11:26:47 +0530
Message-ID: <20251206055648.1908734-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206055648.1908734-1-adityag@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fS367mCaadfYQEJ24MXdMU1qVTeK7CCK
X-Proofpoint-ORIG-GUID: fS367mCaadfYQEJ24MXdMU1qVTeK7CCK
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6933c612 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=dCvegdiEg4V6ml2xVIcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX8XfLabzYTbf3
 ZwlKkYdLpT9OpDkAzwM9cCyb04ermOBeY4kH9oidyz6x3tsfA7IBTnQUPLFSERTXS2Ncq6fiycP
 TNRK3DUM5dwq+0uX/JCvwUIWmR4gyM7wBiLnZTbYQ51Ch7tgrFOgRgTcewxMxVl+je/SLvyqN0W
 jQiEjUhJv3hd8jhnVZQIJoot9+rA/YfDFw+GsuqlNDaiir77nZrwy0vznGqA/wQd3CGOeVqPqpz
 Fw93/8WteXIznFSFK72nlqKqz81yBFLAwl+ESlutzbLU66g8tCRTvEH0h/24ipYvSYs5XlJSuxd
 WqbZ7gUK+5sHYwxEl3n0xrJ3h4853JlEAWX8lw4Albk4Xedfh427+JZXY8kl6VfPYDd0ThUY+K0
 2Orbj2YYISpsylK0f3iNxhC1qUQncg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

With all MPIPL support in place, export a "dump" node in device tree,
signifying that PowerNV QEMU platform supports MPIPL

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7c36f3a00e90..8a62b0ee1074 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -54,6 +54,7 @@
 #include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_pnor.h"
+#include "hw/ppc/pnv_mpipl.h"
 
 #include "hw/isa/isa.h"
 #include "hw/char/serial-isa.h"
@@ -671,6 +672,39 @@ static void pnv_dt_power_mgt(PnvMachineState *pnv, void *fdt)
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
@@ -733,6 +767,9 @@ static void *pnv_dt_create(MachineState *machine)
         pmc->dt_power_mgt(pnv, fdt);
     }
 
+    /* Advertise support for MPIPL */
+    pnv_dt_mpipl_dump(pnv, fdt);
+
     return fdt;
 }
 
-- 
2.52.0


