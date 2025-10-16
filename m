Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFD3CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Rw8-0006LX-Aq; Thu, 16 Oct 2025 13:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9Rvy-0006H9-CF; Thu, 16 Oct 2025 13:38:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9Rvk-0007b9-60; Thu, 16 Oct 2025 13:38:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDrJ84023883;
 Thu, 16 Oct 2025 17:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=40nRQJQTo789o6tDq
 5Ga0TXaDH7I8WO+1LCp/UG8M/Q=; b=TyRqUgLuFth/BCHfAxowB7AuHEcb+H/RG
 QLonZMq5rmVU5hBMiaX8PyEsom2P081OQ1qxPNrX7LBxt/iT8pu5N391g9gqJuM3
 dDP2FmoW6lsydK30kEVHo+MRn8r/M/A08vbLvaWA8A59ajtB8offdXfk1yYic6mB
 f4SGFScon5SBPKxis6+aips890h6VWjbCuyigaKImXPewKNBTotOqBRfd3HZxGdp
 uXg+V5J9k66zNtLaZIe2uw5sU8iQnPFirik/kmrmSaYDtYllcu1EeKz03GgzMWr8
 ZUxcCpvKnUQgXKIpphRFYS+Mcg4ABxJIybcWb2FyjiGBbbGmcVAQg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpny9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:38:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59GHRngu002741;
 Thu, 16 Oct 2025 17:38:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpny9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:38:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GGF79g003709;
 Thu, 16 Oct 2025 17:38:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy74da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:38:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GHcCTr35914000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 17:38:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84CB9200E0;
 Thu, 16 Oct 2025 17:38:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36ADA200DA;
 Thu, 16 Oct 2025 17:38:10 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.26.252])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 17:37:59 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 5/5] hw/ppc: Pass errp to load_image_targphys() and report
 errors
Date: Thu, 16 Oct 2025 23:05:03 +0530
Message-ID: <20251016173502.1261674-8-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016173502.1261674-1-vishalc@linux.ibm.com>
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1bc6Y79wh3TQfmRGdGLdvVksG5fD4OlG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfXxgDAgLFMQ1Ud
 k6dlC3D8gJW69aig4AVoD4srSW2jFvHbeZS0y5lrATvsvyjEAqnsEz5B2JYyPuul0dTXHuBiJoP
 Drn+dqJcgcRcNRl4as6RWw/lGS1BgLUtGLV+w6d9fQWhZmEDz+IE9h9uXIAVKVlMfErKEy9rBTK
 wzm9g4hrR/5Cq7TuQ7ADTAjGGhKd0faWXbKUdcw/T5lrReQ711sLgllU8H3V9schSsqm4XTMYiT
 iWVrsRrLQkAoxR7MULvV6gkCFM7z7wQ9GbyBbGtS6/rAOtR+TmmZ9B0JPhm+3SjkDyWQpDdutpS
 vd0k46NkNZngHbQrch8oZjBc8kFCACYhQviBeQ5JcJOzy9ldv4JLoN3sjw6GRfTfBO81FOhoQuE
 vIl/niBYcvO62icPzqeofa5NRojxtw==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f12d89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=epcxUv981NhcBCS7hEEA:9
X-Proofpoint-ORIG-GUID: BAtmlsKMqTF7Kn9ad17fQWS8xMG56g2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use error_reportf_err() instead of error_report() to print the
underlying error details along with context about which image failed
to load.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/ppc/amigaone.c      | 11 ++++++-----
 hw/ppc/e500.c          | 13 +++++++------
 hw/ppc/mac_newworld.c  | 17 +++++++++--------
 hw/ppc/mac_oldworld.c  | 17 +++++++++--------
 hw/ppc/pegasos2.c      | 11 ++++++-----
 hw/ppc/pnv.c           | 18 ++++++++++--------
 hw/ppc/ppc440_bamboo.c |  7 ++++---
 hw/ppc/prep.c          | 17 +++++++++--------
 hw/ppc/sam460ex.c      |  7 ++++---
 hw/ppc/spapr.c         | 11 ++++++-----
 hw/ppc/virtex_ml507.c  |  9 +++++----
 11 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 5c5acc9872..33a4066fa0 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -276,6 +276,7 @@ static void amigaone_init(MachineState *machine)
     DriveInfo *di;
     hwaddr loadaddr;
     struct boot_info *bi = NULL;
+    Error *errp = NULL;
 
     /* init CPU */
     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
@@ -324,9 +325,9 @@ static void amigaone_init(MachineState *machine)
             error_report("Could not find firmware '%s'", machine->firmware);
             exit(1);
         }
-        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, NULL);
+        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, &errp);
         if (sz <= 0 || sz > PROM_SIZE) {
-            error_report("Could not load firmware '%s'", filename);
+            error_reportf_err(errp, "Could not load firmware '%s': ", filename);
             exit(1);
         }
     }
@@ -413,10 +414,10 @@ static void amigaone_init(MachineState *machine)
         loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
         loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, loadaddr,
-                                 bi->bd_info - loadaddr, NULL);
+                                 bi->bd_info - loadaddr, &errp);
         if (sz <= 0) {
-            error_report("Could not load initrd '%s'",
-                         machine->initrd_filename);
+            error_reportf_err(errp, "Could not load initrd '%s': ",
+                              machine->initrd_filename);
             exit(1);
         }
         bi->initrd_start = loadaddr;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 30937a4a92..009d80da39 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -932,6 +932,7 @@ void ppce500_init(MachineState *machine)
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
     I2CBus *i2c;
+    Error *errp = NULL;
 
     irqs = g_new0(IrqLines, smp_cpus);
     for (i = 0; i < smp_cpus; i++) {
@@ -1227,10 +1228,10 @@ void ppce500_init(MachineState *machine)
         kernel_base = cur_base;
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           cur_base,
-                                          machine->ram_size - cur_base, NULL);
+                                          machine->ram_size - cur_base, &errp);
         if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
+            error_reportf_err(errp, "could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
 
@@ -1242,11 +1243,11 @@ void ppce500_init(MachineState *machine)
         initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
         initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
                                           machine->ram_size - initrd_base,
-                                          NULL);
+                                          &errp);
 
         if (initrd_size < 0) {
-            error_report("could not load initial ram disk '%s'",
-                         machine->initrd_filename);
+            error_reportf_err(errp, "could not load initial ram disk '%s': ",
+                              machine->initrd_filename);
             exit(1);
         }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 728525759c..d26cbcb0df 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -156,6 +156,7 @@ static void ppc_core99_init(MachineState *machine)
     DeviceState *uninorth_internal_dev = NULL, *uninorth_agp_dev = NULL;
     hwaddr nvram_addr = 0xFFF04000;
     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
+    Error *errp = NULL;
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
@@ -189,12 +190,12 @@ static void ppc_core99_init(MachineState *machine)
         if (bios_size <= 0) {
             /* or load binary ROM image */
             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
-                    NULL);
+                                            &errp);
         }
         g_free(filename);
     }
     if (bios_size < 0 || bios_size > PROM_SIZE) {
-        error_report("could not load PowerPC bios '%s'", bios_name);
+        error_reportf_err(errp, "could not load PowerPC bios '%s': ", bios_name);
         exit(1);
     }
 
@@ -212,11 +213,11 @@ static void ppc_core99_init(MachineState *machine)
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               machine->ram_size - kernel_base,
-                                              NULL);
+                                              &errp);
         }
         if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
+            error_reportf_err(errp, "could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
         /* load initrd */
@@ -225,10 +226,10 @@ static void ppc_core99_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
+                                              &errp);
             if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
+                error_reportf_err(errp, "could not load initial ram disk '%s': ",
+                                  machine->initrd_filename);
                 exit(1);
             }
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index a067a191cd..4dbe74bfd2 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -108,6 +108,7 @@ static void ppc_heathrow_init(MachineState *machine)
     DriveInfo *dinfo, *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
+    Error *errp = NULL;
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
@@ -144,13 +145,13 @@ static void ppc_heathrow_init(MachineState *machine)
         if (bios_size <= 0) {
             /* or if could not load ELF try loading a binary ROM image */
             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
-                    NULL);
+                                            &errp);
             bios_addr = PROM_BASE;
         }
         g_free(filename);
     }
     if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
-        error_report("could not load PowerPC bios '%s'", bios_name);
+        error_reportf_err(errp, "could not load PowerPC bios '%s': ", bios_name);
         exit(1);
     }
 
@@ -168,11 +169,11 @@ static void ppc_heathrow_init(MachineState *machine)
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               machine->ram_size - kernel_base,
-                                              NULL);
+                                              &errp);
         }
         if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
+            error_reportf_err(errp, "could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
         /* load initrd */
@@ -182,10 +183,10 @@ static void ppc_heathrow_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
+                                              &errp);
             if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
+                error_reportf_err(errp, "could not load initial ram disk '%s': ",
+                                  machine->initrd_filename);
                 exit(1);
             }
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 7fa14fd0e6..d4703f79da 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -129,6 +129,7 @@ static void pegasos2_init(MachineState *machine)
     int i;
     ssize_t sz;
     uint8_t *spd_data;
+    Error *errp = NULL;
 
     /* init CPU */
     pm->cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
@@ -164,10 +165,10 @@ static void pegasos2_init(MachineState *machine)
                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (sz <= 0) {
         sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE,
-                NULL);
+                                 &errp);
     }
     if (sz <= 0 || sz > PROM_SIZE) {
-        error_report("Could not load firmware '%s'", filename);
+        error_reportf_err(errp, "Could not load firmware '%s': ", filename);
         exit(1);
     }
     g_free(filename);
@@ -260,10 +261,10 @@ static void pegasos2_init(MachineState *machine)
         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
-                                 machine->ram_size - pm->initrd_addr, NULL);
+                                 machine->ram_size - pm->initrd_addr, &errp);
         if (sz <= 0) {
-            error_report("Could not load initrd '%s'",
-                         machine->initrd_filename);
+            error_reportf_err(errp, "Could not load initrd '%s': ",
+                              machine->initrd_filename);
             exit(1);
         }
         pm->initrd_size = sz;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a3e5203970..88668a700e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1015,6 +1015,7 @@ static void pnv_init(MachineState *machine)
     char *chip_typename;
     DriveInfo *pnor;
     DeviceState *dev;
+    Error *errp = NULL;
 
     if (kvm_enabled()) {
         error_report("machine %s does not support the KVM accelerator",
@@ -1069,9 +1070,10 @@ static void pnv_init(MachineState *machine)
     }
 
     fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
-                                    NULL);
+                                    &errp);
     if (fw_size < 0) {
-        error_report("Could not load OPAL firmware '%s'", fw_filename);
+        error_reportf_err(errp, "Could not load OPAL firmware '%s': ",
+                          fw_filename);
         exit(1);
     }
     g_free(fw_filename);
@@ -1082,10 +1084,10 @@ static void pnv_init(MachineState *machine)
 
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
-                                          NULL);
+                                          &errp);
         if (kernel_size < 0) {
-            error_report("Could not load kernel '%s'",
-                         machine->kernel_filename);
+            error_reportf_err(errp, "Could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
     }
@@ -1094,10 +1096,10 @@ static void pnv_init(MachineState *machine)
     if (machine->initrd_filename) {
         pnv->initrd_base = INITRD_LOAD_ADDR;
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
-                                  pnv->initrd_base, INITRD_MAX_SIZE, NULL);
+                                  pnv->initrd_base, INITRD_MAX_SIZE, &errp);
         if (pnv->initrd_size < 0) {
-            error_report("Could not load initial ram disk '%s'",
-                         machine->initrd_filename);
+            error_reportf_err(errp, "Could not load initial ram disk '%s': ",
+                              machine->initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 7c66912c10..9e55e56ee0 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -141,6 +141,7 @@ static void bamboo_init(MachineState *machine)
     DeviceState *uicdev;
     SysBusDevice *uicsbd;
     int success;
+    Error *errp = NULL;
 
     if (kvm_enabled()) {
         error_report("machine %s does not support the KVM accelerator",
@@ -243,11 +244,11 @@ static void bamboo_init(MachineState *machine)
     if (initrd_filename) {
         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
                                           machine->ram_size - RAMDISK_ADDR,
-                                          NULL);
+                                          &errp);
 
         if (initrd_size < 0) {
-            error_report("could not load ram disk '%s' at %x",
-                         initrd_filename, RAMDISK_ADDR);
+            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
+                              initrd_filename, RAMDISK_ADDR);
             exit(1);
         }
     }
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index edd3da7102..f8cf6dc16e 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -250,6 +250,7 @@ static void ibm_40p_init(MachineState *machine)
     uint32_t kernel_base = 0, initrd_base = 0;
     long kernel_size = 0, initrd_size = 0;
     char boot_device;
+    Error *errp = NULL;
 
     if (kvm_enabled()) {
         error_report("machine %s does not support the KVM accelerator",
@@ -280,10 +281,10 @@ static void ibm_40p_init(MachineState *machine)
     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (bios_size < 0) {
-        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, NULL);
+        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, &errp);
     }
     if (bios_size < 0 || bios_size > BIOS_SIZE) {
-        error_report("Could not load bios image '%s'", filename);
+        error_reportf_err(errp, "Could not load bios image '%s': ", filename);
         return;
     }
     g_free(filename);
@@ -381,10 +382,10 @@ static void ibm_40p_init(MachineState *machine)
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           kernel_base,
                                           machine->ram_size - kernel_base,
-                                          NULL);
+                                          &errp);
         if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
+            error_reportf_err(errp, "could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
@@ -395,10 +396,10 @@ static void ibm_40p_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
+                                              &errp);
             if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
+                error_reportf_err(errp, "could not load initial ram disk '%s': ",
+                                  machine->initrd_filename);
                 exit(1);
             }
             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 68d3eacbff..a5cb8e0738 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -262,6 +262,7 @@ static void sam460ex_init(MachineState *machine)
     struct boot_info *boot_info;
     uint8_t *spd_data;
     int success;
+    Error *errp = NULL;
 
     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
@@ -495,10 +496,10 @@ static void sam460ex_init(MachineState *machine)
         initrd_size = load_image_targphys(machine->initrd_filename,
                                           RAMDISK_ADDR,
                                           machine->ram_size - RAMDISK_ADDR,
-                                          NULL);
+                                          &errp);
         if (initrd_size < 0) {
-            error_report("could not load ram disk '%s' at %x",
-                    machine->initrd_filename, RAMDISK_ADDR);
+            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
+                              machine->initrd_filename, RAMDISK_ADDR);
             exit(1);
         }
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9e17b5a31d..0be542c888 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2824,9 +2824,10 @@ static void spapr_machine_init(MachineState *machine)
         error_report("Could not find LPAR firmware '%s'", bios_name);
         exit(1);
     }
-    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
+    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, &errp);
     if (fw_size <= 0) {
-        error_report("Could not load LPAR firmware '%s'", filename);
+        error_reportf_err(errp, "Could not load LPAR firmware '%s': ",
+                          filename);
         exit(1);
     }
 
@@ -3090,10 +3091,10 @@ static void spapr_machine_init(MachineState *machine)
                                                      spapr->initrd_base,
                                                      load_limit
                                                      - spapr->initrd_base,
-                                                     NULL);
+                                                     &errp);
             if (spapr->initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             initrd_filename);
+                error_reportf_err(errp, "could not load initial ram disk '%s': ",
+                                  initrd_filename);
                 exit(1);
             }
         }
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 00d9ab7509..a7d3de62fa 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -195,6 +195,7 @@ static void virtex_init(MachineState *machine)
     qemu_irq irq[32], cpu_irq;
     int kernel_size;
     int i;
+    Error *errp = NULL;
 
     /* init CPUs */
     cpu = ppc440_init_xilinx(machine->cpu_type, 400000000);
@@ -253,7 +254,7 @@ static void virtex_init(MachineState *machine)
             /* If we failed loading ELF's try a raw image.  */
             kernel_size = load_image_targphys(kernel_filename,
                                               boot_offset,
-                                              machine->ram_size, NULL);
+                                              machine->ram_size, &errp);
             boot_info.bootstrap_pc = boot_offset;
             high = boot_info.bootstrap_pc + kernel_size + 8192;
         }
@@ -265,11 +266,11 @@ static void virtex_init(MachineState *machine)
             initrd_base = high = ROUND_UP(high, 4);
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               high, machine->ram_size - high,
-                                              NULL);
+                                              &errp);
 
             if (initrd_size < 0) {
-                error_report("couldn't load ram disk '%s'",
-                             machine->initrd_filename);
+                error_reportf_err(errp, "couldn't load ram disk '%s': ",
+                                  machine->initrd_filename);
                 exit(1);
             }
             high = ROUND_UP(high + initrd_size, 4);
-- 
2.51.0


