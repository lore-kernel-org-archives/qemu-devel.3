Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02203CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCE4s-0005g1-JF; Fri, 24 Oct 2025 05:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4q-0005f3-84; Fri, 24 Oct 2025 05:27:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4n-0003pR-PI; Fri, 24 Oct 2025 05:27:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O12qMf027261;
 Fri, 24 Oct 2025 09:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SR1zW1pBXlR9t1mLV
 WmfKuxwzrs7+JWlEGt++9ky9sk=; b=hour9iNe2zjTh+pFG1/z+ZMhEIcjD+fVl
 GSP9OFk779icxgNERDWdU5d+IgaFkeyM94Xkty0dRIBWJImgbauSESTnQgVNgrlV
 QmbetvRh4FlgBmahEqJIIfMv7E0rAae5j2SDfZ2S6tmVJR2gNTOzsGZ4lSe9h2Rd
 epSAv5NS9/cKKDE0gnQZSFPMttlCIaI88JhjgcL59/qpaHzdCTcvjLFR2IWUWWyJ
 euw0nBRhwFVK3U77RurfyTv7h9myzj3wcR9ZnLl6I2cE3Uzyv5Uj+RkjfKVkxnR8
 bJXVDnJiD5qvW68EP55qEgddbg5ozQzv5SnDBm5529OJxGuSwmwkQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fpme2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O9N3Yq027561;
 Fri, 24 Oct 2025 09:27:08 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fpmdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O8kEdu014676;
 Fri, 24 Oct 2025 09:27:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sjmhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O9R3Wf52887956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 09:27:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77B8E20040;
 Fri, 24 Oct 2025 09:27:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE49720049;
 Fri, 24 Oct 2025 09:27:00 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 09:27:00 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com, hpoussin@reactos.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v9 6/6] ppc: Pass error_fatal to load_image_targphys()
Date: Fri, 24 Oct 2025 14:56:18 +0530
Message-ID: <20251024092616.1893092-9-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024092616.1893092-2-vishalc@linux.ibm.com>
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fb466c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=-Rt1QlvtLuBJMzJCn24A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: UkoVf-5cgkRoD2Qz3hny0NIFa61Ha4h-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5JsNowk3Mx1O
 uxEsQeY3KoicNw4OTHiOzv0NuDXCbmJ7kJ8Kx77Yx508yfl2ro7D5Xt87oPmzaNVgfOljQbEoYi
 AevQ14XJeOXY6RuGvMrsHsfqqQgZ0dMTQVDt3loxYZTXhhC0nhm54wzZmdeb4ds/xD8Z9zkgXtb
 S4ahuName5vaIECl+Dp3/7OwpIY7tEVqzlvPhmwxN8EC/+4W0fWtJMNEsWteFAF6vEa9qXoiaqO
 g7YYdAx1Q6+4BQNvlOp9XuMnTRQCBKwIN/GVz6nr+y1Dnc6BNQDNNxo7TS4gOZWyz/g5rALTwp4
 DF9d2YqQ8KbJ0LpMW6yM4ygIypZwQDJ583l4AF0pBS0UX0JyTIEVglsEqGfvBIiNjqK/6nEaNiq
 u5CBIdtjazBCP/bELrb+5Fjb7D6Acw==
X-Proofpoint-ORIG-GUID: k0lJ96LzJI1b_pbovVYhGREYQRPRKAFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
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

Pass error_fatal to load_image_targphys() calls in ppc machine initialization
to capture detailed error information when loading firmware, kernel,
and initrd images.

Passing error_fatal automatically reports detailed error messages and
exits immediately on failure. Eliminating redundant exit(1) calls, as
error_fatal handles termination

The behavior remains functionally identical, but error messages now
come directly from the loader function with more context about the
failure cause.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/ppc/amigaone.c      | 13 ++-----------
 hw/ppc/e500.c          | 19 +++----------------
 hw/ppc/mac_newworld.c  | 16 +++-------------
 hw/ppc/mac_oldworld.c  | 16 +++-------------
 hw/ppc/pegasos2.c      |  9 ++-------
 hw/ppc/pnv.c           | 28 +++++-----------------------
 hw/ppc/ppc440_bamboo.c |  8 +-------
 hw/ppc/prep.c          | 17 ++++-------------
 hw/ppc/sam460ex.c      |  7 +------
 hw/ppc/spapr.c         | 13 ++-----------
 hw/ppc/virtex_ml507.c  | 10 ++--------
 11 files changed, 28 insertions(+), 128 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 192474e0ae..74a1fa3b63 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -324,11 +324,7 @@ static void amigaone_init(MachineState *machine)
             error_report("Could not find firmware '%s'", machine->firmware);
             exit(1);
         }
-        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, NULL);
-        if (sz <= 0 || sz > PROM_SIZE) {
-            error_report("Could not load firmware '%s'", filename);
-            exit(1);
-        }
+        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, &error_fatal);
     }
 
     /* Articia S */
@@ -413,12 +409,7 @@ static void amigaone_init(MachineState *machine)
         loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
         loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, loadaddr,
-                                 bi->bd_info - loadaddr, NULL);
-        if (sz <= 0) {
-            error_report("Could not load initrd '%s'",
-                         machine->initrd_filename);
-            exit(1);
-        }
+                                 bi->bd_info - loadaddr, &error_fatal);
         bi->initrd_start = loadaddr;
         bi->initrd_end = loadaddr + sz;
     }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 418e1bb2fb..8842f7f6b8 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1226,14 +1226,8 @@ void ppce500_init(MachineState *machine)
     if (machine->kernel_filename && !kernel_as_payload) {
         kernel_base = cur_base;
         kernel_size = load_image_targphys(machine->kernel_filename,
-                                          cur_base,
-                                          machine->ram_size - cur_base, NULL);
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
-        }
-
+                                      cur_base, machine->ram_size - cur_base,
+                                      &error_fatal);
         cur_base += kernel_size;
     }
 
@@ -1242,14 +1236,7 @@ void ppce500_init(MachineState *machine)
         initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
         initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
                                           machine->ram_size - initrd_base,
-                                          NULL);
-
-        if (initrd_size < 0) {
-            error_report("could not load initial ram disk '%s'",
-                         machine->initrd_filename);
-            exit(1);
-        }
-
+                                          &error_fatal);
         cur_base = initrd_base + initrd_size;
     }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 004efc6b97..951de4bae4 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -189,7 +189,7 @@ static void ppc_core99_init(MachineState *machine)
         if (bios_size <= 0) {
             /* or load binary ROM image */
             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
-                                            NULL);
+                                            &error_fatal);
         }
         g_free(filename);
     }
@@ -212,12 +212,7 @@ static void ppc_core99_init(MachineState *machine)
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               machine->ram_size - kernel_base,
-                                              NULL);
-        }
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
+                                              &error_fatal);
         }
         /* load initrd */
         if (machine->initrd_filename) {
@@ -225,12 +220,7 @@ static void ppc_core99_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
-                exit(1);
-            }
+                                              &error_fatal);
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
         } else {
             cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index c7e44d49b0..cd2bb46442 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -144,7 +144,7 @@ static void ppc_heathrow_init(MachineState *machine)
         if (bios_size <= 0) {
             /* or if could not load ELF try loading a binary ROM image */
             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
-                                            NULL);
+                                            &error_fatal);
             bios_addr = PROM_BASE;
         }
         g_free(filename);
@@ -168,12 +168,7 @@ static void ppc_heathrow_init(MachineState *machine)
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               machine->ram_size - kernel_base,
-                                              NULL);
-        }
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
+                                              &error_fatal);
         }
         /* load initrd */
         if (machine->initrd_filename) {
@@ -182,12 +177,7 @@ static void ppc_heathrow_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
-                exit(1);
-            }
+                                              &error_fatal);
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
         } else {
             cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index a9e706644c..3c02c53c3a 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -198,7 +198,7 @@ static void pegasos_init(MachineState *machine)
                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (sz <= 0) {
         sz = load_image_targphys(filename, pm->vof ? 0 : prom_addr, PROM_SIZE,
-                                 NULL);
+                                 &error_fatal);
     }
     if (sz <= 0 || sz > PROM_SIZE) {
         error_report("Could not load firmware '%s'", filename);
@@ -302,12 +302,7 @@ static void pegasos_init(MachineState *machine)
         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
-                                 machine->ram_size - pm->initrd_addr, NULL);
-        if (sz <= 0) {
-            error_report("Could not load initrd '%s'",
-                         machine->initrd_filename);
-            exit(1);
-        }
+                            machine->ram_size - pm->initrd_addr, &error_fatal);
         pm->initrd_size = sz;
     }
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1c0dadda87..895132da91 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1009,7 +1009,6 @@ static void pnv_init(MachineState *machine)
     PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
     int max_smt_threads = pmc->max_smt_threads;
     char *fw_filename;
-    long fw_size;
     uint64_t chip_ram_start = 0;
     int i;
     char *chip_typename;
@@ -1068,26 +1067,14 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
-    fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
-                                  NULL);
-    if (fw_size < 0) {
-        error_report("Could not load OPAL firmware '%s'", fw_filename);
-        exit(1);
-    }
+    load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
+                        &error_fatal);
     g_free(fw_filename);
 
     /* load kernel */
     if (machine->kernel_filename) {
-        long kernel_size;
-
-        kernel_size = load_image_targphys(machine->kernel_filename,
-                                          KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
-                                          NULL);
-        if (kernel_size < 0) {
-            error_report("Could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
-        }
+        load_image_targphys(machine->kernel_filename,
+                            KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, &error_fatal);
     }
 
     /* load initrd */
@@ -1095,12 +1082,7 @@ static void pnv_init(MachineState *machine)
         pnv->initrd_base = INITRD_LOAD_ADDR;
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
                                                pnv->initrd_base,
-                                               INITRD_MAX_SIZE, NULL);
-        if (pnv->initrd_size < 0) {
-            error_report("Could not load initial ram disk '%s'",
-                         machine->initrd_filename);
-            exit(1);
-        }
+                                               INITRD_MAX_SIZE, &error_fatal);
     }
 
     /* load dtb if passed */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 7c66912c10..7e739a2114 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -243,13 +243,7 @@ static void bamboo_init(MachineState *machine)
     if (initrd_filename) {
         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
                                           machine->ram_size - RAMDISK_ADDR,
-                                          NULL);
-
-        if (initrd_size < 0) {
-            error_report("could not load ram disk '%s' at %x",
-                         initrd_filename, RAMDISK_ADDR);
-            exit(1);
-        }
+                                          &error_fatal);
     }
 
     /* If we're loading a kernel directly, we must load the device tree too. */
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 0759e95cb6..c2fe16e985 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -280,7 +280,8 @@ static void ibm_40p_init(MachineState *machine)
     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (bios_size < 0) {
-        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, NULL);
+        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE,
+                                        &error_fatal);
     }
     if (bios_size < 0 || bios_size > BIOS_SIZE) {
         error_report("Could not load bios image '%s'", filename);
@@ -380,12 +381,7 @@ static void ibm_40p_init(MachineState *machine)
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           kernel_base,
                                           machine->ram_size - kernel_base,
-                                          NULL);
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
-        }
+                                          &error_fatal);
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
         /* load initrd */
@@ -394,12 +390,7 @@ static void ibm_40p_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
-                exit(1);
-            }
+                                              &error_fatal);
             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
         }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 68d3eacbff..258d43f8d2 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -495,12 +495,7 @@ static void sam460ex_init(MachineState *machine)
         initrd_size = load_image_targphys(machine->initrd_filename,
                                           RAMDISK_ADDR,
                                           machine->ram_size - RAMDISK_ADDR,
-                                          NULL);
-        if (initrd_size < 0) {
-            error_report("could not load ram disk '%s' at %x",
-                    machine->initrd_filename, RAMDISK_ADDR);
-            exit(1);
-        }
+                                          &error_fatal);
     }
 
     /* If we're loading a kernel directly, we must load the device tree too. */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cdf2fdeadc..99b843ba2f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2854,11 +2854,7 @@ static void spapr_machine_init(MachineState *machine)
         error_report("Could not find LPAR firmware '%s'", bios_name);
         exit(1);
     }
-    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
-    if (fw_size <= 0) {
-        error_report("Could not load LPAR firmware '%s'", filename);
-        exit(1);
-    }
+    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, &error_fatal);
 
     /*
      * if Secure VM (PEF) support is configured, then initialize it
@@ -3117,12 +3113,7 @@ static void spapr_machine_init(MachineState *machine)
             spapr->initrd_size = load_image_targphys(initrd_filename,
                                                 spapr->initrd_base,
                                                 load_limit - spapr->initrd_base,
-                                                NULL);
-            if (spapr->initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             initrd_filename);
-                exit(1);
-            }
+                                                &error_fatal);
         }
     }
 
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 00d9ab7509..43a6d505a8 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -253,7 +253,7 @@ static void virtex_init(MachineState *machine)
             /* If we failed loading ELF's try a raw image.  */
             kernel_size = load_image_targphys(kernel_filename,
                                               boot_offset,
-                                              machine->ram_size, NULL);
+                                              machine->ram_size, &error_fatal);
             boot_info.bootstrap_pc = boot_offset;
             high = boot_info.bootstrap_pc + kernel_size + 8192;
         }
@@ -265,13 +265,7 @@ static void virtex_init(MachineState *machine)
             initrd_base = high = ROUND_UP(high, 4);
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               high, machine->ram_size - high,
-                                              NULL);
-
-            if (initrd_size < 0) {
-                error_report("couldn't load ram disk '%s'",
-                             machine->initrd_filename);
-                exit(1);
-            }
+                                              &error_fatal);
             high = ROUND_UP(high + initrd_size, 4);
         }
 
-- 
2.51.0


