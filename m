Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F06BCD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9jT-0007hk-B2; Wed, 29 Apr 2026 14:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jR-0007gp-JA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jP-0007Ar-Qf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TGMIh71648936
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mwEBmMLzFUJkI1AGT
 d3tZhrWqb7aAsSGvCaaV+1PZSY=; b=L+kjMuLafCT2m8mHZkVRbk1GeTmmmADUK
 nEVoI/UAYj2XuIfZdfVsLGriSUxFHKbANuJkPDYkuRTbvlCsPrlnlPTzoFjJKT+b
 PIws3hh7JKwesWCY9948Bm8zTgVxM+R7osz9zlXXPDzhHGImckWcbFfRXoE5dw47
 WdMH/SSpxHwUvunKV1kk3HCXgpPWqSBb6WovEW2OM/b+F7d4VTpZ+qe7TCIfF2Y5
 3YwxoTyLvhD6nIezDbLeCD1ScxEgi1uU+KlrNfdlKm8xBQZpc9qjc9p8ysLLP7Ip
 9pDwgq3/Wa3XhrWMv48Fg0IauCECvOWgrNL8mkIUA9ALIDPpXyyqQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rc235-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINwpI005092
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehfgq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIXnxd52625786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 18:33:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E1A220049;
 Wed, 29 Apr 2026 18:33:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 507C720040;
 Wed, 29 Apr 2026 18:33:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 18:33:46 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 08/13] pnv/mpipl: Enable MPIPL support
Date: Thu, 30 Apr 2026 00:02:58 +0530
Message-ID: <20260429183310.12455-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W_1Qy9WYk5HVke7cwG61ldIwWokepXbR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfX9tKYAQGDX6Il
 FWN90vVpYdRF0X5VukBdiwOwCgiacZeRxqiP63HGNiis6EdFV/RKJwyxulpmuPnOpl9a2xCW6/O
 CvYOPlAkI+6A35/Z/pei+5e0LfYEWS6BW8a/s454aGvncdYkh/D9nhWDM1QkLW9XHZokrVJuVeI
 YJr4hBNuUrpFUhwXH1WgrgQt3kyXm2V4Kvxk60ytncJoJ7y+XIqjbfKNgKhEDtuv7w0tRC+ekEh
 slAkr4gfdr6LpLCuZTJYTGV00sKPVn9ugqkLnAGyHVpMwGbGw61r9ngf7D0ibrkkN2x6aNnXc8m
 QXU85mUx7WGGS2zbYtIRxO9FmYkzNMTwc0vCRR3cU1+4WAGhZbEp3mWG1GzO6yLKOY7xJ2yuK/j
 gKp+dt4DhvHmdGkmeB1ndXBqdZaDS9ceA4+BGMOmLQQeLsPZJ+AaNlejxXT/ku2gfKrchdDiMBS
 1LcAJYKurML/V/MW5tQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f24f12 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ot5QZ2y7QXi8G_WxSMwA:9
X-Proofpoint-ORIG-GUID: W_1Qy9WYk5HVke7cwG61ldIwWokepXbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Aditya Gupta <adityag@linux.ibm.com>

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
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260424083837.214947-9-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 48f49bef82..89096f9a84 100644
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
2.52.0


