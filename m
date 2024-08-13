Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609E9C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdrqr-0004hU-P8; Tue, 13 Aug 2024 09:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sdrqb-0004cD-T9; Tue, 13 Aug 2024 09:46:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sdrqZ-0006Pc-Nj; Tue, 13 Aug 2024 09:46:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DDWN7U007601;
 Tue, 13 Aug 2024 13:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=6cUN99qFFoEyE67A0YKQ6GOqro
 FJinCV3pY1jH9nHic=; b=jO5nfKIB95yLx+esh5FXvULxgFAe3X6cCiRSQBaKna
 DOf/Sn4wyn0goW1lMEfI/dTafFjZorHNR7tVK/q2EuRhyK2cwdnCwQnLVZXrJRPA
 HPl2bbjBGyNLmsuvubtl89SUQqBiav+T+aPt4G4jHOHsrhjt7P951qwNrjQL9cWC
 4+0oOs9dUPuNpvlFaJERgvxDsqIEPNMhYGvlpq7cZEP/IblJivZALdgroQLh0c0o
 nlMzPYKz+bsR10NW6eu/+hDGMnHV9JZB3o63X2GDYISaB9k8l6x3JXgCuudpD6n5
 N82W4+ZNdR1XBAes6EPQlLKxFdXMiLlJOK73HsHzGGvQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4108esr2ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Aug 2024 13:45:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47DDjlG7002141;
 Tue, 13 Aug 2024 13:45:47 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4108esr2an-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Aug 2024 13:45:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47DA4OK7020933; Tue, 13 Aug 2024 13:45:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn833dm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Aug 2024 13:45:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47DDjeUk53608744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 13:45:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB5BF2004E;
 Tue, 13 Aug 2024 13:45:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F35C620040;
 Tue, 13 Aug 2024 13:45:37 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.214.4]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Aug 2024 13:45:37 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v3] hw/ppc: Implement -dtb support for PowerNV
Date: Tue, 13 Aug 2024 19:15:36 +0530
Message-ID: <20240813134536.1204513-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9IlVv6FvSx5wZ-aecTVnCOI46sd0_ODz
X-Proofpoint-ORIG-GUID: 5Hn_LChX_K8WzFWVPaFa2uFlasEgc_Fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_05,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408130098
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
v3:
 + use 'load_device_tree' to read the device tree, instead of g_file_get_contents
 + tested that passed dtb does NOT get ignored on system_reset

v2:
 + move reading dtb and warning to pnv_init

v1:
 + use 'g_file_get_contents' and add check for -append & -dtb as suggested by Daniel
---
---
 hw/ppc/pnv.c         | 34 ++++++++++++++++++++++++++++++----
 include/hw/ppc/pnv.h |  2 ++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3526852685b4..14225f7e48af 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -736,10 +736,13 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
         }
     }
 
-    fdt = pnv_dt_create(machine);
-
-    /* Pack resulting tree */
-    _FDT((fdt_pack(fdt)));
+    if (pnv->fdt) {
+        fdt = pnv->fdt;
+    } else {
+        fdt = pnv_dt_create(machine);
+        /* Pack resulting tree */
+        _FDT((fdt_pack(fdt)));
+    }
 
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
@@ -1003,6 +1014,21 @@ static void pnv_init(MachineState *machine)
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
+        pnv->fdt = load_device_tree(machine->dtb, &fdt_size);
+        if (!pnv->fdt) {
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
2.46.0


