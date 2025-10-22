Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3F8CCF9E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYre-0007MP-1U; Wed, 22 Oct 2025 09:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBYrb-0007LT-HQ; Wed, 22 Oct 2025 09:26:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBYrX-0006IQ-VU; Wed, 22 Oct 2025 09:26:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MATBlK015516;
 Wed, 22 Oct 2025 13:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3PHLXMYp9mhfRFwZ/
 aSLj69hUSAw5cQ+YkWg2urE+Cc=; b=Gz76cNpDICIkZPW+S8mBEnUPrK4s7lGJF
 ud/hg4PG5IaPpMqr/iETUIjs7WXCH3HfMFU2CuiPvzKhClnCupbOUwPdykxb2ZLt
 //H+ZwXajsRth17zWk97onfByODH00ZTQQ3btGBQcUpyDit9CijBhh7UVRuc8V0N
 DnZl3wM+QkfGpfGDdBo8bfjwd+G3xU6ym4zh87wXdMj2qxicjX9vof276AIZfQL/
 a7nSeWACMoWLhht+bvlyO9HH/NIq1izd3AissKCqK+zxUkvT0AnNLy6qE8qBRs1U
 Xw1W12yyKEOPc01QgPIzg7VowBKB4KrmkUgTZ2TvHm0ho75RyaYlw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326vw6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MDAuA9015129;
 Wed, 22 Oct 2025 13:26:42 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326vw6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MC1cuW011030;
 Wed, 22 Oct 2025 13:26:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx188hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MDQbXC47251736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 13:26:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 437B12004D;
 Wed, 22 Oct 2025 13:26:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C800C20040;
 Wed, 22 Oct 2025 13:26:34 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.25.31])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Oct 2025 13:26:34 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com, hpoussin@reactos.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v6 6/6] hw/ppc: Pass errp to load_image_targphys() and report
 errors
Date: Wed, 22 Oct 2025 18:55:11 +0530
Message-ID: <20251022132507.1597232-14-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022132507.1597232-2-vishalc@linux.ibm.com>
References: <20251022132507.1597232-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f8db92 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=-Rt1QlvtLuBJMzJCn24A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0t5XVem0qIpQ
 x01nDPF92+qYMrGDYBVET67tWY0kt+O1+zcO2/3uIuokb0NqSNbcPpWxH8oRs3Zvgev0aqVBoH4
 mExM1Wi8h3ZTNK1HOxF+6BynrRVLUxkwEX+rKILKO94Olp9waWqk0L/gOvEHKNVhAwkosRgFTqi
 IDz3rCwPFgShk5IptazylWAOlVU3Ym+I8v0iZzh2zhwmttz3uf9yzmA6vCIsyLVGu36ARDZSE0z
 v085gS72g5fnXG0XakgmQJs70Kt/JRSw5DLrct2yOqafJp8uRjEUzWhhuish4lC5jVLxZlwz41d
 9vAPhnTYJVeYYdvwuyi4ReRDwOHWaewmUI0o7kO2osC7+iEONGfW6IOcpxO1M4o98cb+X/7ZEHk
 O4rT3ur1HFNSR8BK1tKw1iYEpHw51Q==
X-Proofpoint-GUID: JakHOtoz26E9laiQPcqJ0UQ3AfTFa2VP
X-Proofpoint-ORIG-GUID: CxxZvqQC0HM02rM4UPFZgjsW8giSEybZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
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

Pass errp to load_image_targphys() calls in ppc machine initialization
to capture detailed error information when loading firmware, kernel,
and initrd images.

Pass error_fatal which automatically reports detailed error messages and
exits immediately on failure. Eliminating redundant exit(1) calls, as
error_fatal handles termination

The behavior remains functionally identical, but error messages now
come directly from the loader function with more context about the
failure cause.

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
index 5c5acc9872..fa4d3779e3 100644
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
index 30937a4a92..0c5e4c9f45 100644
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
index 1f754df0e2..1b3d1caa45 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -164,7 +164,7 @@ static void pegasos2_init(MachineState *machine)
                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (sz <= 0) {
         sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE,
-                                 NULL);
+                                 &error_fatal);
     }
     if (sz <= 0 || sz > PROM_SIZE) {
         error_report("Could not load firmware '%s'", filename);
@@ -260,12 +260,7 @@ static void pegasos2_init(MachineState *machine)
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
index edd3da7102..b1e382347e 100644
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
@@ -381,12 +382,7 @@ static void ibm_40p_init(MachineState *machine)
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
@@ -395,12 +391,7 @@ static void ibm_40p_init(MachineState *machine)
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
index e51540a5ad..fc1fd2fed9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2824,11 +2824,7 @@ static void spapr_machine_init(MachineState *machine)
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
@@ -3089,12 +3085,7 @@ static void spapr_machine_init(MachineState *machine)
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


