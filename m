Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43451CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCVpI-00007u-8D; Fri, 02 Oct 2026 01:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVoL-0008Ge-0h; Fri, 02 Oct 2026 01:28:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVoH-00081e-JQ; Fri, 02 Oct 2026 01:27:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922ZhiQ3344813; Fri, 2 Oct 2026 05:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rGFDGchg20xlJgXEM
 i6LAfLwxo4549rcy0LzhG9ApYM=; b=FcZjwUQZ6haf1P+VFsfIqRvX83ISDaSqh
 zsgVaKo49gRt7llAez/poyzO4eoUIS7TShpV2fIBBuKcCcU5cP70AcG34CM13EvA
 OuT7kGi1KZNdUAJuXbHOh79ojneP0SDJfdWhBLcij9rcCyAhIR4zYOGTFpL7pW8e
 UUgSNEzbOgEEaIP8LYQzRtKvbNT1ttbfTYx0E+OIYHdjqZMYOqplJWHO4I8Bmoz7
 N0qC+Zh44m5zTSbddcUzKLRvRuMlpaCf3axFSqND3mKdnEsCSRDs9Ng3SdVGnIE1
 HGOFpsAviY1k6ls5E5JrL7ACmMtHpXXXwC0T0yS7Mkr2EACqzSNPg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkpp0n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:27:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922K7SU1834166; Fri, 2 Oct 2026 05:27:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dhfhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:27:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6925Rgbg60424554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 05:27:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEF9358063;
 Fri,  2 Oct 2026 05:27:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21D7D5805A;
 Fri,  2 Oct 2026 05:27:34 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.111.176]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 05:27:33 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@linaro.org, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH v2 3/8] ppc/spapr: add baseline VOF disk boot support
Date: Fri,  2 Oct 2026 10:55:42 +0530
Message-ID: <20261002052605.605858-4-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002052605.605858-1-uverma@linux.ibm.com>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JYRb0Dz7TFlzUWqCWQOUHAgVCbKgR-Q2
X-Proofpoint-GUID: F5iRt29pWE1USwN0TfBB5vXK74FtcCvi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfXyeN20Gv1A03g
 wdwEKvIqi5RmKHTP7vdhbupS+mzZdyJUM2esOVqDLdyBWf/00xrkKPhnK60PgnBRerdUA/NV+bY
 /KdarxtnNZN1LuST+z4POEXDRXi9PfA=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abf40d1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Ei6tgeEkNT0KFwxEUYUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfXwwzKLJQ8EdxR
 DTaHM6vuOhfq2psFkfo2ofWryfkPfMd0xaGtz82AafPvrE4XEO8YTEEifefyEy05vCtfAf3EGym
 pQfLrfBgLKHgwzvmL8UJvfgwrGDpQcTXGcfAMK4pdCQliPcqq6zbfr+A+oMRbpRXPHy4lyypetf
 bokLw3ben/dgSI3MXg8oaKAJu66Q2MCV6Nf4E1pvHMOEDfkaJwQIptaT+sBbfZk2rhs7sV61L7o
 zhNE0lV8saa1y/oxl65BF5mRgpFAdMmtSA6JlIJZl5QIYlS4o5bW+fh6dIk/Ktlmzg6PUfGFDRK
 /ezRw5lGdwlmttPDEyTtl6s2rdWu0foByIv6kdE2fj52uQiW7ZV/q6o+nVkyeTQI1Rnmg01EWLe
 /R2tMAhEV8c2RRvGaySNHRPVvvqIqu11smiLSjz5ePtQ2nQxlLinjOvJ5nXZ8kWwuGtNU8/9IdK
 xJIGKVh66PWZJQ+66nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Chaneglog:
v2:
- Added bounds checking for partition size before doing g_malloc.
- Added a roll back logic for cleaning the memory map FDT for paritial
  claims.
---
 hw/ppc/spapr_vof.c   | 162 ++++++++++++++++++++++++++++++++++++++++---
 hw/ppc/vof.c         |   3 +
 include/hw/ppc/vof.h |   2 +
 3 files changed, 159 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
index 46d78756e6..78d5b7d5b5 100644
--- a/hw/ppc/spapr_vof.c
+++ b/hw/ppc/spapr_vof.c
@@ -10,10 +10,19 @@
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
 
+#define SPAPR_VOF_PREP_MAX_SIZE (10 * 1024 * 1024)
+
 target_ulong spapr_h_vof_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                 target_ulong opcode, target_ulong *_args)
 {
@@ -32,10 +41,10 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
 
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
@@ -43,6 +52,22 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
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
@@ -54,11 +79,116 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
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
+    int64_t blk_len;
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
+        blk_len = blk_getlength(blk);
+        if (blk_len < 0 ||
+            partition_size == 0 ||
+            partition_size > SPAPR_VOF_PREP_MAX_SIZE ||
+            partition_offset > (uint64_t)blk_len ||
+            partition_size > (uint64_t)blk_len - partition_offset) {
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
+        guint saved_claimed_len = vof->claimed->len;
+        uint64_t saved_claimed_base = vof->claimed_base;
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
+            /* Roll back any partial claims made during the failed load. */
+            g_array_set_size(vof->claimed, saved_claimed_len);
+            vof->claimed_base = saved_claimed_base;
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
 
@@ -70,7 +200,7 @@ void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp)
     /* Stack grows downwards plus reserve space for the minimum stack frame */
     stack_ptr += VOF_STACK_SIZE - 0x20;
 
-    if (spapr->kernel_size &&
+    if (machine->kernel_filename && spapr->kernel_size &&
         vof_claim(vof, spapr->kernel_addr, spapr->kernel_size, 0) == -1) {
         error_setg(errp, "Memory for kernel is in use");
         return;
@@ -82,6 +212,14 @@ void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp)
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
@@ -91,10 +229,18 @@ void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp)
     /*
      * At this point the expected allocation map is:
      *
-     * 0..c38 - the initial firmware
-     * 8000..10000 - stack
-     * 400000.. - kernel
-     * 3ea0000.. - initramdisk
+     * Kernel + initrd boot:
+     *   0..d80       - the initial firmware
+     *   8000..10000  - stack
+     *   10000..20000 - vscsi-report-luns table (up to 64 KB, if needed)
+     *   400000..     - kernel
+     *   3ea0000..    - initramdisk
+     *
+     * Disk (GRUB) boot:
+     *   0..d80       - the initial firmware
+     *   8000..10000  - stack
+     *   10000..20000 - vscsi-report-luns table (up to 64 KB, if needed)
+     *   400000..     - GRUB (loaded from PReP partition)
      *
      * We skip writing FDT as nothing expects it; OF client interface is
      * going to be used for reading the device tree.
diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 873e967f1e..9ad1aa7626 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -1042,6 +1042,9 @@ void vof_cleanup(Vof *vof)
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
2.55.0


