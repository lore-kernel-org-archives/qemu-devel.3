Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A131EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgM8F-0004nK-Cx; Tue, 20 Aug 2024 06:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sgM8C-0004mO-Eg; Tue, 20 Aug 2024 06:30:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sgM87-0004XP-VP; Tue, 20 Aug 2024 06:30:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K2ZRmA005873;
 Tue, 20 Aug 2024 10:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=LUGU6pU4TargIaEueQj+vtEdUW
 uKwWjHYtDvQp3eb6E=; b=X8a4F46iKxDIXGDIUoC2yXdNFj9SU0bu05dqBoEouf
 VxVWrv+RW3xGymdvX0QHKthlagEBhcan4XwfuVAKaDTjraJWtHoOWb4aEB39NW+U
 YJ7b3VwFqdoDofBWKoeke5zNyFdKPAwAkmaMdC75jZXg8uOWwAdMW50+487/nKcb
 p3qQ7valGqwiQfbkhPQP8F7r2lh3R3dw98m7jdWj7gAN5w5fYrIBLUjiuorEyX1+
 tu4kUvDCMUznwQEtN3FX9qJRmVaN1ov3fZAzosR5bHW6mlVzQqMVhIE9bGJud0H2
 I9iHCHDD7RoGPJDzvHG/i//47GlEdMjK1b/e9SnFDX6Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc4mqhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Aug 2024 10:30:13 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47KAUDXF009811;
 Tue, 20 Aug 2024 10:30:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc4mqht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Aug 2024 10:30:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K6HmQU002244;
 Tue, 20 Aug 2024 10:30:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0jjr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Aug 2024 10:30:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47KAU6Bu55771488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2024 10:30:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B51BA2005A;
 Tue, 20 Aug 2024 10:30:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D9D820043;
 Tue, 20 Aug 2024 10:30:04 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.38]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Aug 2024 10:30:04 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v4] hw/ppc: Implement -dtb support for PowerNV
Date: Tue, 20 Aug 2024 16:00:03 +0530
Message-ID: <20240820103003.550735-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EbXSeYLnytKQXKsH750uSB5UrDeMGJmx
X-Proofpoint-GUID: P-_78KHdz1QvTBNZNZvoCGTisAPzCshV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=904 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently any device tree passed with -dtb option in QEMU, was ignored
by the PowerNV code.

Read and pass the passed -dtb to the kernel, thus enabling easier
debugging with custom DTBs.

The existing behaviour when -dtb is 'not' passed, is preserved as-is.

But when a '-dtb' is passed, it completely overrides any dtb nodes or
changes QEMU might have done, such as '-append' arguments to the kernel
(which are mentioned in /chosen/bootargs in the dtb), hence add warning
when -dtb is being used

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
Changelog
===========
v4:
 + use 'MachineState::fdt' instead of 'PnvMachineState::fdt'
 + added an 'if' check at end of pnv_reset, so we don't free the fdt we
   are using
v3:
 + use 'load_device_tree' to read the device tree, instead of g_file_get_contents
 + tested that passed dtb does NOT get ignored on system_reset

v2:
 + move reading dtb and warning to pnv_init

v1:
 + use 'g_file_get_contents' and add check for -append & -dtb as suggested by Daniel
---
---
 hw/ppc/pnv.c | 51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3526852685b4..5be15f748e45 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -736,21 +736,27 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
         }
     }
 
-    fdt = pnv_dt_create(machine);
-
-    /* Pack resulting tree */
-    _FDT((fdt_pack(fdt)));
+    if (machine->fdt) {
+        fdt = machine->fdt;
+    } else {
+        fdt = pnv_dt_create(machine);
+        /* Pack resulting tree */
+        _FDT((fdt_pack(fdt)));
+    }
 
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 
-    /*
-     * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
-     * the existing machine->fdt to avoid leaking it during
-     * a reset.
-     */
-    g_free(machine->fdt);
-    machine->fdt = fdt;
+    /* Update machine->fdt with latest fdt */
+    if (machine->fdt != fdt) {
+        /*
+         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
+         * the existing machine->fdt to avoid leaking it during
+         * a reset.
+         */
+        g_free(machine->fdt);
+        machine->fdt = fdt;
+    }
 }
 
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
@@ -952,6 +958,14 @@ static void pnv_init(MachineState *machine)
         g_free(sz);
         exit(EXIT_FAILURE);
     }
+
+    /* checks for invalid option combinations */
+    if (machine->dtb && (strlen(machine->kernel_cmdline) != 0)) {
+        error_report("-append and -dtb cannot be used together, as passed"
+                " command line is ignored in case of custom dtb");
+        exit(EXIT_FAILURE);
+    }
+
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     /*
@@ -1003,6 +1017,21 @@ static void pnv_init(MachineState *machine)
         }
     }
 
+    /* load dtb if passed */
+    if (machine->dtb) {
+        int fdt_size;
+
+        warn_report("with manually passed dtb, some options like '-append'"
+                " will get ignored and the dtb passed will be used as-is");
+
+        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
+        machine->fdt = load_device_tree(machine->dtb, &fdt_size);
+        if (!machine->fdt) {
+            error_report("Could not load dtb '%s'", machine->dtb);
+            exit(1);
+        }
+    }
+
     /* MSIs are supported on this platform */
     msi_nonbroken = true;
 
-- 
2.46.0


