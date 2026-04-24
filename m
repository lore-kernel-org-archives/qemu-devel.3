Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E75F589DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGC4y-0005F4-3l; Fri, 24 Apr 2026 04:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4X-0004o7-0v; Fri, 24 Apr 2026 04:39:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4V-0005Yo-HI; Fri, 24 Apr 2026 04:39:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NIBl353107467; Fri, 24 Apr 2026 08:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3yctLBVUr5itl+sQ2
 ufET2Z+aaKC+3gGfuhINJvRrkQ=; b=cYdnyTrdrkkD/JBynCZ3AdyFqA3BWDofe
 /+PXAahueJgwvXpZJ4V0zKnTgs/4Ts2Bs8ywCpqv3WwpJ+pzTTp2raqQ7gxZb8hY
 HeAPsUeSFOjuXc47gg2PNaLMqPmhj3gvD6s0iLuk96JBk1n0nZa2D0SzTBZQiXPS
 lJJoCAKO4I1itwYbMZyoDKFOPbDInIojzSZ2itYA30L48/7vmdNkIwEh3qH7yOEV
 SbJyUFniZ9lhdNh1re2+bnU3IJ8nCnMSx3pnjglDAFaNZntTVypo5gvImq8j+wck
 8uTcQmvoM76++vVTOtiYSaJCmmyBpA2s5KyKUiCBsDFNc7kG/aRIw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6m4rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O8ZR5H010746;
 Fri, 24 Apr 2026 08:39:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky22f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O8dTM347120768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 08:39:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63AD520040;
 Fri, 24 Apr 2026 08:39:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12BEF20049;
 Fri, 24 Apr 2026 08:39:26 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.230]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 08:39:25 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v6 08/10] pnv/mpipl: Enable MPIPL support
Date: Fri, 24 Apr 2026 14:08:35 +0530
Message-ID: <20260424083837.214947-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424083837.214947-1-adityag@linux.ibm.com>
References: <20260424083837.214947-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfX1H55Vscbolhb
 fD1stkPwLzePXfbxZF2Kn/NvsWwfpOS8Fn+jA0Ng/8AI/7expYfTIk1hRM0qAbpKafMy96VVL6f
 SaNZSSrMUaK/XOv8pfvh7a6G0cE7dmhd2SFgY8RvG1xW0mGnYQ3gU+NuBoI5xKjxhjtHfWGYILB
 HBaPQs7e3VUvoIG9253dZg5CLe/tgGs1+ztc9FjhOGPWgcJkYDs0cW5ejSqMaiKt88OTyBZbnne
 JwvPqH/C4sl1q6wAECpSzQaJ7UJjEpq3VEOmhR+QxiLXenmLHpcK9zupeIeOiTUs7U4eYq88hSC
 W6FS0E7jjfp3VIz9Dmal7M80s0Fq0+5T9GnlSCbzPwlSaX4jRPho7okwZ5pivyhyU6em5bGlV/t
 dYRtoFi/lmngrrQ4pRWHsKw2GyZ+hcFYWCl9WAqzwF4s7RV3A5r5yjC1Vwwi44/3yUply1WMIn9
 fg0xnoeuu53T/3Vij1Q==
X-Proofpoint-ORIG-GUID: _bZuyExylvwh2yakrnZ0AifGgGjQb0iB
X-Proofpoint-GUID: k8MiutsbCT9Zv7CdHqqvbhiSSAAFldVV
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69eb2c46 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=e4BzM2Stjwk3Es--iV8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

With all MPIPL support in place, export a "dump" node in device tree,
signifying that PowerNV QEMU platform supports MPIPL

Also, export fw-load-area dt node, which has details about where the
kernel & initrd were loaded, so that kernel can verify whether the
kernel/initrd images were loaded within the boot memory region. QEMU
just exports these details in fw-load-area, the check for boot memory
region is done in kernel.

Since now device tree can change at pnv_reset, hence regenerate device
tree during pnv_reset

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 48f49bef8251..89096f9a8431 100644
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
 
@@ -765,6 +802,10 @@ static void pnv_reset(MachineState *machine, ResetType type)
         mpipl_write_succeeded = do_mpipl_write(pnv);
     }
 
+    /* Regenerate device tree */
+    fdt = pnv_dt_create(machine);
+    _FDT((fdt_pack(fdt)));
+
     /*
      * If it's a MPIPL boot, add the "mpipl-boot" property, and reset the
      * boolean for MPIPL boot for next boot
@@ -814,8 +855,11 @@ static void pnv_reset(MachineState *machine, ResetType type)
                 sizeof(proc_area));
     }
 
-    fdt = machine->fdt;
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
+
+    /* Free previous device tree set by pnv_init/reset/machine_init_done */
+    g_free(machine->fdt);
+    machine->fdt = fdt;
 }
 
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
-- 
2.53.0


