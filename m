Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC76C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuaM-0000tI-CA; Mon, 17 Aug 2026 06:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuaK-0000sH-DQ; Mon, 17 Aug 2026 06:28:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuaI-0008Fh-Bv; Mon, 17 Aug 2026 06:28:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVvh83728213; Mon, 17 Aug 2026 10:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CRTaUiq7JoVPeOGmo
 DV9JbH0rGth/RU+DZO69hETByI=; b=TTuIU7ROSofGPqeZLY524ruB4E9LrjBar
 3LY3SHOjvAi+lDXNfJI+vyuP6u2zeJM3wN9x2872GHcxBUo2HUTJLsGVD3l4p2VR
 jyouJJfOC97jRvg+acVSvdi1wQAY/KfKdzk2a17ApPgpleekjzi4RmPh1MNrjG0+
 loTIanXKFjmM5PjgXQXpKaTgc3cXcDDTxAfwN+BTbV3xiPRUV3CO6A3KyZ7Z56P/
 LiFfHgJ6sqnb3D/oWdaNYByMhy9tYB0TUvJfMy5i5cgD4EeI9GIVs+t7XiOrGHUm
 Bnt+x3XxQR083QjmABg1iqi0LDua0ZYw7kNHYVh1MEFgnV2aCVthg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4hrba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:28:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQcLE028915;
 Mon, 17 Aug 2026 10:28:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y5c13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:28:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HASg3P64094610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:28:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB5FA5805B;
 Mon, 17 Aug 2026 10:28:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9E3B58058;
 Mon, 17 Aug 2026 10:28:35 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:28:35 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH 3/8] ppc/spapr: add baseline VOF disk boot support
Date: Mon, 17 Aug 2026 15:57:20 +0530
Message-ID: <20260817102733.605346-4-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
References: <20260817102733.605346-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ClMxmkE3bbVtsSF2DxYZcDBQ_gFqU3eA
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82e25d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=b1KftT2tXQuajxTQ1ugA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX2lpTNLx/+bSU
 KGkX0Eu6zX9pGSTqAJEQkfStewEaGuUPIsJO5NzqqtH1yUJGoF3b1tSMDXpmfRSst2k8dBKwFS0
 ZLquEf1VHcqwGFDpgjiALORmnvZoBhE=
X-Proofpoint-ORIG-GUID: wV7Ow5lT5XtqEXfvF27BVMByDR4DC8cV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX68ySgzezaGCe
 pfnrn588EGMv0y/gG7oO3lV0vfoNprss99Jn2efEVr7rnYO4BcCyzsmQtQdYFNsd06pitYYsOW8
 K01UHsChcHMivB0SoJmlzYc1g0NjNHOyaf5LQANJYlBFMugWDIZc4GK/QZqvBP17meMOx/eFBW7
 QkIDYTRh07ngcv9UDuSYkPOrZfKE30TRiggVurcbPX68akpYbNaBbE8X7siazEF2vEY+0PcdknO
 abh4F2+4sKkd4i9d6L11WYV7PHBrsybINR5OrsutJqpPrTvGPzhUSPQUzRn1bo/cCaDuFp9WACn
 iMGMHQJN4ZhxYSn626nr7lZ9i3wfuVQoC5crQh3aWKE41+789L+vrqtWhj0JkdZUnxPUJBR5J2P
 zmJm+wZUeUCWgdtf6FqetufdjrSKk2NXOzNn839vcHakINUTsclpE4RZcGCg7/Q/uaAOIiK+npM
 SY1BVa5IleiNOc7r+vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

From: Utkarsh Verma <uverma@linux.ibm.com>

Add initial support for disk boot via VOF.
Scan all the block devices, and for each device search for PReP partition,
load the ELF payload (GRUB), and set the '/chosen' node in FDT with boot kernel
and bootpath properties.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/ppc/spapr_vof.c   | 142 ++++++++++++++++++++++++++++++++++++++++---
 hw/ppc/vof.c         |   3 +
 include/hw/ppc/vof.h |   2 +
 3 files changed, 139 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
index 46d78756e6..5bf9613005 100644
--- a/hw/ppc/spapr_vof.c
+++ b/hw/ppc/spapr_vof.c
@@ -10,8 +10,15 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/vof.h"
+#include "hw/ppc/spapr_vof.h"
+#include "hw/core/qdev.h"
+#include "hw/core/loader.h"
 #include "system/system.h"
+#include "system/block-backend.h"
+#include "system/block-backend-global-state.h"
 #include "qom/qom-qobject.h"
+#include "target/ppc/cpu.h"
+#include "elf.h"
 #include "trace.h"
 
 target_ulong spapr_h_vof_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
@@ -32,10 +39,10 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
 
     vof_build_dt(fdt, spapr->vof);
 
-    if (spapr->vof->bootargs) {
-        int chosen;
+    int chosen;
+    _FDT(chosen = fdt_path_offset(fdt, "/chosen"));
 
-        _FDT(chosen = fdt_path_offset(fdt, "/chosen"));
+    if (spapr->vof->bootargs) {
         /*
          * If the client did not change "bootargs", spapr_dt_chosen() must have
          * stored machine->kernel_cmdline in it before getting here.
@@ -43,6 +50,22 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "bootargs", spapr->vof->bootargs));
     }
 
+    if (spapr->vof->disk_boot) {
+        /*
+         * If disk boot is detected change the "qemu,boot-kernel" to hold
+         * kernel_addr/kernel_size which contain the GRUB entry point and size
+         */
+        uint64_t kern[2];
+        kern[0] = cpu_to_be64(spapr->kernel_addr);
+        kern[1] = cpu_to_be64(spapr->kernel_size);
+        _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel", &kern, sizeof(kern)));
+
+        if (spapr->vof->bootpath) {
+            _FDT(fdt_setprop_string(fdt, chosen, "bootpath",
+                                    spapr->vof->bootpath));
+        }
+    }
+
     /*
      * SLOF-less setup requires an open instance of stdout for early
      * kernel printk. By now all phandles are settled so we can open
@@ -54,11 +77,100 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
     }
 }
 
+static bool vof_elf_segment_cb(void *opaque,
+                                uint64_t paddr, uint64_t vaddr,
+                                uint64_t filesz, uint64_t memsz)
+{
+    Vof *vof = opaque;
+
+    if (memsz == 0) {
+        return true;
+    }
+
+    if (paddr != vaddr) {
+        error_report("spapr_vof_load_elf: segment paddr/vaddr mismatch "
+                     "(paddr=0x%" PRIx64 " vaddr=0x%" PRIx64 ")",
+                     paddr, vaddr);
+        return false;
+    }
+
+    if (vof_claim(vof, paddr, memsz, 0) == -1) {
+        error_report("spapr_vof_load_elf: vof_claim failed for "
+                     "paddr=0x%" PRIx64 " size=0x%" PRIx64, paddr, memsz);
+        return false;
+    }
+
+    return true;
+}
+
+static bool spapr_vof_try_prep_boot(SpaprMachineState *spapr, Vof *vof)
+{
+    BlockBackend *blk;
+    DeviceState *dev;
+    uint64_t partition_offset;
+    uint64_t partition_size;
+    uint8_t *prep_data;
+    uint64_t entry_point;
+    uint64_t load_size;
+
+    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+
+        if (!blk_is_inserted(blk)) {
+            continue;
+        }
+
+        partition_offset = 0;
+        partition_size   = 0;
+
+        if (!spapr_vof_find_prep_partition(blk, &partition_offset,
+                                           &partition_size)) {
+            continue;
+        }
+
+        prep_data = g_malloc(partition_size);
+        if (blk_pread(blk, partition_offset, partition_size,
+                      prep_data, 0) < 0) {
+            g_free(prep_data);
+            continue;
+        }
+
+        uint64_t lowaddr = UINT64_MAX, highaddr = 0;
+        entry_point = 0;
+        ssize_t ret = load_elf_ram_sym_buf(prep_data, partition_size,
+                                           NULL, NULL, NULL,
+                                           &entry_point, &lowaddr, &highaddr,
+                                           NULL, ELFDATA2MSB,
+                                           PPC_ELF_MACHINE, 0, 0,
+                                           NULL, false, NULL,
+                                           vof_elf_segment_cb, vof);
+        if (ret <= 0) {
+            error_report("spapr_vof_try_prep_boot: %s", load_elf_strerror(ret));
+            g_free(prep_data);
+            continue;
+        }
+        load_size = highaddr - lowaddr;
+
+        g_free(prep_data);
+
+        spapr->kernel_addr = entry_point;
+        spapr->kernel_size = load_size;
+
+        vof->disk_boot = true;
+        dev = blk_get_attached_dev(blk);
+        if (dev) {
+            vof->bootpath = qdev_get_fw_dev_path(dev);
+        }
+        return true;
+    }
+    return false;
+}
+
 void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp)
 {
     target_ulong stack_ptr;
     Vof *vof = spapr->vof;
     PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
+    MachineState *machine = MACHINE(spapr);
 
     vof_init(vof, spapr->rma_size, errp);
 
@@ -70,7 +182,7 @@ void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp)
     /* Stack grows downwards plus reserve space for the minimum stack frame */
     stack_ptr += VOF_STACK_SIZE - 0x20;
 
-    if (spapr->kernel_size &&
+    if (machine->kernel_filename && spapr->kernel_size &&
         vof_claim(vof, spapr->kernel_addr, spapr->kernel_size, 0) == -1) {
         error_setg(errp, "Memory for kernel is in use");
         return;
@@ -82,6 +194,14 @@ void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp)
         return;
     }
 
+    /*
+     * Disk boot: load GRUB from the PReP boot partition on the block device, if
+     * no kernel/initrd are provided
+     */
+    if (!machine->kernel_filename) {
+        spapr_vof_try_prep_boot(spapr, vof);
+    }
+
     spapr_vof_client_dt_finalize(spapr, fdt);
 
     spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
@@ -91,10 +211,16 @@ void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp)
     /*
      * At this point the expected allocation map is:
      *
-     * 0..c38 - the initial firmware
-     * 8000..10000 - stack
-     * 400000.. - kernel
-     * 3ea0000.. - initramdisk
+     * Kernel + initrd boot:
+     *   0..c38      - the initial firmware
+     *   8000..10000 - stack
+     *   400000..    - kernel
+     *   3ea0000..   - initramdisk
+     *
+     * Disk (GRUB) boot:
+     *   0..c38      - the initial firmware
+     *   8000..10000 - stack
+     *   400000..    - GRUB (loaded from PReP partition)
      *
      * We skip writing FDT as nothing expects it; OF client interface is
      * going to be used for reading the device tree.
diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index fa7b73159a..a78bb1f116 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -1041,6 +1041,9 @@ void vof_cleanup(Vof *vof)
     vof->of_instances = NULL;
     vof->of_instance_last = 0;
     vof->claimed_base = 0;
+    g_free(vof->bootpath);
+    vof->bootpath = NULL;
+    vof->disk_boot = false;
 }
 
 void vof_build_dt(void *fdt, Vof *vof)
diff --git a/include/hw/ppc/vof.h b/include/hw/ppc/vof.h
index 3a0fbffe54..e17779ee8a 100644
--- a/include/hw/ppc/vof.h
+++ b/include/hw/ppc/vof.h
@@ -18,6 +18,8 @@ typedef struct Vof {
     GHashTable *of_instances; /* ihandle -> SpaprOfInstance */
     uint32_t of_instance_last;
     char *bootargs;
+    char *bootpath;
+    bool disk_boot;
     long fw_size;
 } Vof;
 
-- 
2.54.0


