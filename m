Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E6ACCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBA2o-0006HM-4b; Tue, 21 Oct 2025 06:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBA2l-0006AH-Cm; Tue, 21 Oct 2025 06:56:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBA2g-0001fs-GR; Tue, 21 Oct 2025 06:56:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L93Kq6023459;
 Tue, 21 Oct 2025 10:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BwMvmF6NBJ0BtcWUB
 BphKD/P2wkYLgQqRs8FoUD1GkA=; b=fbXfTg3X6BGd+VWHdP61LHJMS/mVrnHyc
 I6hvPxGnjpL1dPYH7/ECsIrg6o51zdp/JtHkqqQ6CxgruhTOcDXnlNkgG4rvbrnF
 DVrJPVGhtqBqivJoWOMWTvS1OY2whUTKHTmADGYVufKOyNI95VVqpkI0nsjQzmQb
 HBq5viHT49Q+qmY55B6gp970IwPZjLSPoCZnoK/hJrHXcc6WAaXAeDoOEXkqLvMS
 7ynXOLmVGFO+r5zpfPQyJtnIbdy6fuw3TjmmuqxEqJVKxYPRxwp/jk3g//rzjfJZ
 KkEaU18mKqwVI26oUdJjKGvbUOPja8zJDapbT+tcDR/u0OGPaxGxw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rxj9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:56:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LAjwBk029145;
 Tue, 21 Oct 2025 10:56:32 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rxj9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:56:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LAtbJE014663;
 Tue, 21 Oct 2025 10:56:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s2h9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:56:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LAuSrT49938784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 10:56:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27B6C2004E;
 Tue, 21 Oct 2025 10:56:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62DF620043;
 Tue, 21 Oct 2025 10:56:25 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.196])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 10:56:25 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com, hpoussin@reactos.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v5 6/6] hw/ppc: Pass errp to load_image_targphys() and report
 errors
Date: Tue, 21 Oct 2025 16:24:46 +0530
Message-ID: <20251021105442.1474602-11-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021105442.1474602-2-vishalc@linux.ibm.com>
References: <20251021105442.1474602-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: emSfr1n2UJ_-DHAtuaq-8fPiyRntpEYR
X-Proofpoint-GUID: fQA9mU5xbtg0EadTgldoRIp3LlTmbdhS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXySC8ocCSzjhu
 cv/fEUyHErW2vooawExo3JDy/QchW/SDmgvpD+M6ALa7gOXm0N3cEs7XfE8R3p0BSKQUcQpaLnv
 +mxAb1yo3C3gRS59vTr29t2aUNc0mDCL91JT3MTMi08VLvh9YYYD34rXokiAdbJ0I7emfHwxmaP
 E3HtaGqfbkQfOph8ViYsC4Rc6eyYNz687800KrM4piLALpI3OJoi9nYEwmL5z7TDUCbi+ToHI/I
 yWt+6BKxXt+BStMWMwEAtDDe1hpzu9EXBKXu2DRjX12HjICuHWRRGAA8M0+KjVEmpwvBApEu18T
 UqoFGij9V64riUm8t7rZHllI22IyzJclDntohPrGIhnCr9BQZcuR0jpAUOeuiu8u9SF24eSsiLi
 i8HxODIgtnIWh2xjxOWznr5c/EgpMA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f766e1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=0IoJLJlfn07CT3Vb23kA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
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

Use error_reportf_err() instead of error_report() to print the
underlying error details along with context about which image failed
to load.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/ppc/amigaone.c      | 15 ++++++++-------
 hw/ppc/e500.c          | 17 +++++++++--------
 hw/ppc/mac_newworld.c  | 25 +++++++++++++++----------
 hw/ppc/mac_oldworld.c  | 25 +++++++++++++++----------
 hw/ppc/pegasos2.c      | 17 +++++++++++------
 hw/ppc/pnv.c           | 31 ++++++++++++++-----------------
 hw/ppc/ppc440_bamboo.c |  9 +++++----
 hw/ppc/prep.c          | 25 +++++++++++++++----------
 hw/ppc/sam460ex.c      |  9 +++++----
 hw/ppc/spapr.c         | 15 ++++++++-------
 hw/ppc/virtex_ml507.c  | 17 +++++++++++------
 11 files changed, 116 insertions(+), 89 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 5c5acc9872..bd14bed243 100644
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
-        if (sz <= 0 || sz > PROM_SIZE) {
-            error_report("Could not load firmware '%s'", filename);
+        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, &errp);
+        if (errp) {
+            error_reportf_err(errp, "Could not load firmware '%s': ", filename);
             exit(1);
         }
     }
@@ -413,10 +414,10 @@ static void amigaone_init(MachineState *machine)
         loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
         loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, loadaddr,
-                                 bi->bd_info - loadaddr, NULL);
-        if (sz <= 0) {
-            error_report("Could not load initrd '%s'",
-                         machine->initrd_filename);
+                                 bi->bd_info - loadaddr, &errp);
+        if (errp) {
+            error_reportf_err(errp, "Could not load initrd '%s': ",
+                              machine->initrd_filename);
             exit(1);
         }
         bi->initrd_start = loadaddr;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 30937a4a92..48e238f3a4 100644
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
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
+                                          machine->ram_size - cur_base, &errp);
+        if (errp) {
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
 
-        if (initrd_size < 0) {
-            error_report("could not load initial ram disk '%s'",
-                         machine->initrd_filename);
+        if (errp) {
+            error_reportf_err(errp, "could not load initial ram disk '%s': ",
+                              machine->initrd_filename);
             exit(1);
         }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 004efc6b97..b95a394a8d 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -156,6 +156,7 @@ static void ppc_core99_init(MachineState *machine)
     DeviceState *uninorth_internal_dev = NULL, *uninorth_agp_dev = NULL;
     hwaddr nvram_addr = 0xFFF04000;
     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
+    Error *errp = NULL;
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
@@ -189,12 +190,16 @@ static void ppc_core99_init(MachineState *machine)
         if (bios_size <= 0) {
             /* or load binary ROM image */
             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
-                                            NULL);
+                                            &errp);
         }
         g_free(filename);
     }
     if (bios_size < 0 || bios_size > PROM_SIZE) {
-        error_report("could not load PowerPC bios '%s'", bios_name);
+        if (!errp) {
+            error_setg(&errp, ": exceeds maximum file size (%" PRIu64 " MiB)",
+                       PROM_SIZE / MiB);
+        }
+        error_reportf_err(errp, "could not load PowerPC bios '%s'", bios_name);
         exit(1);
     }
 
@@ -212,11 +217,11 @@ static void ppc_core99_init(MachineState *machine)
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               machine->ram_size - kernel_base,
-                                              NULL);
+                                              &errp);
         }
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
+        if (errp) {
+            error_reportf_err(errp, "could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
         /* load initrd */
@@ -225,10 +230,10 @@ static void ppc_core99_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
+                                              &errp);
+            if (errp) {
+                error_reportf_err(errp, "couldn't load initial ram disk '%s': ",
+                                  machine->initrd_filename);
                 exit(1);
             }
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index c7e44d49b0..f20497e949 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -108,6 +108,7 @@ static void ppc_heathrow_init(MachineState *machine)
     DriveInfo *dinfo, *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
+    Error *errp = NULL;
 
     /* init CPUs */
     for (i = 0; i < machine->smp.cpus; i++) {
@@ -144,13 +145,17 @@ static void ppc_heathrow_init(MachineState *machine)
         if (bios_size <= 0) {
             /* or if could not load ELF try loading a binary ROM image */
             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
-                                            NULL);
+                                            &errp);
             bios_addr = PROM_BASE;
         }
         g_free(filename);
     }
     if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
-        error_report("could not load PowerPC bios '%s'", bios_name);
+        if (!errp) {
+            error_setg(&errp, ": exceeds maximum file size (%" PRIu64 " MiB)",
+                       PROM_SIZE / MiB);
+        }
+        error_reportf_err(errp, "could not load PowerPC bios '%s'", bios_name);
         exit(1);
     }
 
@@ -168,11 +173,11 @@ static void ppc_heathrow_init(MachineState *machine)
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               machine->ram_size - kernel_base,
-                                              NULL);
+                                              &errp);
         }
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
+        if (errp) {
+            error_reportf_err(errp, "could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
         /* load initrd */
@@ -182,10 +187,10 @@ static void ppc_heathrow_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
+                                              &errp);
+            if (errp) {
+                error_reportf_err(errp, "couldn't load initial ram disk '%s': ",
+                                  machine->initrd_filename);
                 exit(1);
             }
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 1f754df0e2..f1b45c3b2c 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -129,6 +129,7 @@ static void pegasos2_init(MachineState *machine)
     int i;
     ssize_t sz;
     uint8_t *spd_data;
+    Error *errp = NULL;
 
     /* init CPU */
     pm->cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
@@ -164,10 +165,14 @@ static void pegasos2_init(MachineState *machine)
                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (sz <= 0) {
         sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE,
-                                 NULL);
+                                 &errp);
     }
     if (sz <= 0 || sz > PROM_SIZE) {
-        error_report("Could not load firmware '%s'", filename);
+        if (!errp) {
+            error_setg(&errp, ": exceeds maximum file size (%" PRIu64 " MiB)",
+                       PROM_SIZE / MiB);
+        }
+        error_reportf_err(errp, "Could not load firmware '%s'", filename);
         exit(1);
     }
     g_free(filename);
@@ -260,10 +265,10 @@ static void pegasos2_init(MachineState *machine)
         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
-                                 machine->ram_size - pm->initrd_addr, NULL);
-        if (sz <= 0) {
-            error_report("Could not load initrd '%s'",
-                         machine->initrd_filename);
+                                 machine->ram_size - pm->initrd_addr, &errp);
+        if (errp) {
+            error_reportf_err(errp, "Could not load initrd '%s': ",
+                              machine->initrd_filename);
             exit(1);
         }
         pm->initrd_size = sz;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1c0dadda87..f5224537d3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1009,12 +1009,12 @@ static void pnv_init(MachineState *machine)
     PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
     int max_smt_threads = pmc->max_smt_threads;
     char *fw_filename;
-    long fw_size;
     uint64_t chip_ram_start = 0;
     int i;
     char *chip_typename;
     DriveInfo *pnor;
     DeviceState *dev;
+    Error *errp = NULL;
 
     if (kvm_enabled()) {
         error_report("machine %s does not support the KVM accelerator",
@@ -1068,24 +1068,21 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
-    fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
-                                  NULL);
-    if (fw_size < 0) {
-        error_report("Could not load OPAL firmware '%s'", fw_filename);
+    if (load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
+                                  &errp) < 0) {
+        error_reportf_err(errp, "Could not load OPAL firmware '%s': ",
+                          fw_filename);
         exit(1);
     }
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
+        if (load_image_targphys(machine->kernel_filename,
+                                KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
+                                &errp) < 0) {
+            error_reportf_err(errp, "Could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
     }
@@ -1095,10 +1092,10 @@ static void pnv_init(MachineState *machine)
         pnv->initrd_base = INITRD_LOAD_ADDR;
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
                                                pnv->initrd_base,
-                                               INITRD_MAX_SIZE, NULL);
-        if (pnv->initrd_size < 0) {
-            error_report("Could not load initial ram disk '%s'",
-                         machine->initrd_filename);
+                                               INITRD_MAX_SIZE, &errp);
+        if (errp) {
+            error_reportf_err(errp, "Could not load initial ram disk '%s': ",
+                              machine->initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 7c66912c10..64b5d9a4c4 100644
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
 
-        if (initrd_size < 0) {
-            error_report("could not load ram disk '%s' at %x",
-                         initrd_filename, RAMDISK_ADDR);
+        if (errp) {
+            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
+                              initrd_filename, RAMDISK_ADDR);
             exit(1);
         }
     }
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index edd3da7102..d25a98dd2b 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -250,6 +250,7 @@ static void ibm_40p_init(MachineState *machine)
     uint32_t kernel_base = 0, initrd_base = 0;
     long kernel_size = 0, initrd_size = 0;
     char boot_device;
+    Error *errp = NULL;
 
     if (kvm_enabled()) {
         error_report("machine %s does not support the KVM accelerator",
@@ -280,10 +281,14 @@ static void ibm_40p_init(MachineState *machine)
     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (bios_size < 0) {
-        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, NULL);
+        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, &errp);
     }
     if (bios_size < 0 || bios_size > BIOS_SIZE) {
-        error_report("Could not load bios image '%s'", filename);
+        if (!errp) {
+            error_setg(&errp, ": exceeds maximum file size (%" PRIu64 " MiB)",
+                       BIOS_SIZE / MiB);
+        }
+        error_reportf_err(errp, "Could not load bios image '%s'", filename);
         return;
     }
     g_free(filename);
@@ -381,10 +386,10 @@ static void ibm_40p_init(MachineState *machine)
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           kernel_base,
                                           machine->ram_size - kernel_base,
-                                          NULL);
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
+                                          &errp);
+        if (errp) {
+            error_reportf_err(errp, "could not load kernel '%s': ",
+                              machine->kernel_filename);
             exit(1);
         }
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
@@ -395,10 +400,10 @@ static void ibm_40p_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
+                                              &errp);
+            if (errp) {
+                error_reportf_err(errp, "couldn't load initial ram disk '%s': ",
+                                  machine->initrd_filename);
                 exit(1);
             }
             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 68d3eacbff..9102bfb6d1 100644
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
-        if (initrd_size < 0) {
-            error_report("could not load ram disk '%s' at %x",
-                    machine->initrd_filename, RAMDISK_ADDR);
+                                          &errp);
+        if (errp) {
+            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
+                              machine->initrd_filename, RAMDISK_ADDR);
             exit(1);
         }
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e51540a5ad..18d73868ed 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2824,9 +2824,10 @@ static void spapr_machine_init(MachineState *machine)
         error_report("Could not find LPAR firmware '%s'", bios_name);
         exit(1);
     }
-    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
-    if (fw_size <= 0) {
-        error_report("Could not load LPAR firmware '%s'", filename);
+    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, &errp);
+    if (errp) {
+        error_reportf_err(errp, "Could not load LPAR firmware '%s': ",
+                          filename);
         exit(1);
     }
 
@@ -3089,10 +3090,10 @@ static void spapr_machine_init(MachineState *machine)
             spapr->initrd_size = load_image_targphys(initrd_filename,
                                                 spapr->initrd_base,
                                                 load_limit - spapr->initrd_base,
-                                                NULL);
-            if (spapr->initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             initrd_filename);
+                                                &errp);
+            if (errp) {
+                error_reportf_err(errp, "couldn't load initial ram disk '%s': ",
+                                  initrd_filename);
                 exit(1);
             }
         }
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 00d9ab7509..e1b658bcda 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -195,6 +195,7 @@ static void virtex_init(MachineState *machine)
     qemu_irq irq[32], cpu_irq;
     int kernel_size;
     int i;
+    Error *errp = NULL;
 
     /* init CPUs */
     cpu = ppc440_init_xilinx(machine->cpu_type, 400000000);
@@ -253,7 +254,12 @@ static void virtex_init(MachineState *machine)
             /* If we failed loading ELF's try a raw image.  */
             kernel_size = load_image_targphys(kernel_filename,
                                               boot_offset,
-                                              machine->ram_size, NULL);
+                                              machine->ram_size, &errp);
+            if (errp) {
+                error_reportf_err(errp, "couldn't load kernel '%s': ",
+                                  kernel_filename);
+                exit(1);
+            }
             boot_info.bootstrap_pc = boot_offset;
             high = boot_info.bootstrap_pc + kernel_size + 8192;
         }
@@ -265,11 +271,10 @@ static void virtex_init(MachineState *machine)
             initrd_base = high = ROUND_UP(high, 4);
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               high, machine->ram_size - high,
-                                              NULL);
-
-            if (initrd_size < 0) {
-                error_report("couldn't load ram disk '%s'",
-                             machine->initrd_filename);
+                                              &errp);
+            if (errp) {
+                error_reportf_err(errp, "couldn't load ram disk '%s': ",
+                                  machine->initrd_filename);
                 exit(1);
             }
             high = ROUND_UP(high + initrd_size, 4);
-- 
2.51.0


