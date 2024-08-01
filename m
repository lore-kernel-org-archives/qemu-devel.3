Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648CBC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZRXQ-00047r-OM; Thu, 01 Aug 2024 04:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZRXP-00040n-0J; Thu, 01 Aug 2024 04:51:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZRXN-0002Jb-CT; Thu, 01 Aug 2024 04:51:54 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4716U9Qu026309;
 Thu, 1 Aug 2024 08:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=sIqfwYKB9e6lQ5Q/AwUwYZDUoW
 suf6vDH8gGGSxRJ5k=; b=o/c/VlER43DqJdZF/uFrDcYNl7RkPFKpCV1VShERtY
 Gx40fL7MrPkb5+b1xq6FWJeajydqAluNOwW0tZa8Y/eC2nB4BMTJ34IJBhuzzkne
 TmqXoU4jhzTtnTND1+hpWrsaUsniFBpTpvVR92HYgBklF5yRhU1TBJrEzti12I25
 lfPONZJCHY1MYdYPa/+LI2HUbgT0Dz14n8Y4wtFfhdfiINPibGbnW6SLYxzukjSK
 Z0SOpoAjLPAKtQRV1SuowVpuuBUAnR2MWjzuZJRILke2s/Le9zmjE9+KuBGiRpvV
 fAEFlJ4m8Gxtn0ShEbwhQamjsWyoSO51CPuHy8rwgkYA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r54u09ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 08:51:43 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4718phbl009029;
 Thu, 1 Aug 2024 08:51:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r54u09h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 08:51:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4715GpI7011295; Thu, 1 Aug 2024 08:51:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn0pvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 08:51:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4718pa4856885696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 08:51:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD48B20043;
 Thu,  1 Aug 2024 08:51:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D30320040;
 Thu,  1 Aug 2024 08:51:34 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 08:51:34 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v2] hw/ppc: Implement -dtb support for PowerNV
Date: Thu,  1 Aug 2024 14:21:33 +0530
Message-ID: <20240801085133.59781-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZpRMU5Dd2fTcusA6MT1YATBlOPwJ-I-u
X-Proofpoint-ORIG-GUID: PrDWOrns1dzZGgb5YTZmaUCwDkFIJBPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_05,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
v2:
 + move reading dtb and warning to pnv_init

v1:
 + use 'g_file_get_contents' and add check for -append & -dtb as suggested by Daniel
---
---
 hw/ppc/pnv.c         | 29 ++++++++++++++++++++++++++---
 include/hw/ppc/pnv.h |  2 ++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3526852685b4..047725bd97fc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -736,11 +736,14 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
         }
     }
 
-    fdt = pnv_dt_create(machine);
+    if (!pnv->fdt) {
+        pnv->fdt = pnv_dt_create(machine);
 
-    /* Pack resulting tree */
-    _FDT((fdt_pack(fdt)));
+        /* Pack resulting tree */
+        _FDT((fdt_pack(pnv->fdt)));
+    }
 
+    fdt = pnv->fdt;
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 
@@ -952,6 +955,14 @@ static void pnv_init(MachineState *machine)
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
@@ -1003,6 +1014,18 @@ static void pnv_init(MachineState *machine)
         }
     }
 
+    /* load dtb if passed */
+    if (machine->dtb) {
+        warn_report("with manually passed dtb, some options like '-append'"
+                " will get ignored and the dtb passed will be used as-is");
+
+        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
+        if (!g_file_get_contents(machine->dtb, (gchar **)&pnv->fdt, NULL, NULL)) {
+            error_report("Could not load dtb '%s'", machine->dtb);
+            exit(1);
+        }
+    }
+
     /* MSIs are supported on this platform */
     msi_nonbroken = true;
 
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fcb6699150c8..20b68fd9264e 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -91,6 +91,8 @@ struct PnvMachineState {
     uint32_t     initrd_base;
     long         initrd_size;
 
+    void         *fdt;
+
     uint32_t     num_chips;
     PnvChip      **chips;
 
-- 
2.45.2


