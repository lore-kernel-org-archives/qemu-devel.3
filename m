Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D88C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 20:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZFfG-0003am-0x; Wed, 31 Jul 2024 16:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZFf2-0003ZS-GY; Wed, 31 Jul 2024 16:11:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZFez-00043t-0U; Wed, 31 Jul 2024 16:10:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VISXda000878;
 Wed, 31 Jul 2024 20:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=VJg2ON4OoRSFTx5cP1Ms0Ha1sJ
 vSsCoJCuOQts5+dvc=; b=jx294oGflb9hGKGs6UcTVpU7cITqg0ROhznidRJcv2
 lZc/NZEr4o7i6ZUvn6LeLzdynCQiNxw5T1BSNq5j6oDUqlqFi0BYF31cT8RoVnFB
 LEPTmF77AmikS/h79xvHRZVm07C6hxT1/5VCHHgWij6Zyh/3NeH+EZ9thNgbJ7mi
 tCdQ1RLgJWZFKYhjDL2VCPO3A24FScXE08tlkdEeRK7jBdldMRvI+R9PpRHX4fe3
 4UnkXZqknm55Itdp9iacsKxg1kGBIFbNG/EsLv9tK6dp6G6eRALlvUA2Yqo9Nbjb
 J1htupHqGB7T/qk/kQ+u0fuRETYkewdiBBxGtoAPsveg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qtjvrcrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 20:10:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46VKAoCG024525;
 Wed, 31 Jul 2024 20:10:50 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qtjvrcrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 20:10:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46VJd6lg007462; Wed, 31 Jul 2024 20:10:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7ue2t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 20:10:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46VKAhtW29884946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 20:10:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9507620043;
 Wed, 31 Jul 2024 20:10:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2410C20040;
 Wed, 31 Jul 2024 20:10:41 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.222.219])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jul 2024 20:10:40 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH] hw/ppc: Implement -dtb support for PowerNV
Date: Thu,  1 Aug 2024 01:40:39 +0530
Message-ID: <20240731201039.1011028-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ymTmt-txA6aEQR00T32X0zJV662qrluB
X-Proofpoint-GUID: XQZjZFLfVi8mVEn0_RAQLmt72x432vQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=912 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407310136
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
v1:
+ use 'g_file_get_contents' and add check for -append & -dtb as suggested by Daniel
---
---
 hw/ppc/pnv.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3526852685b4..03600fa62cbd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -736,10 +736,21 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
         }
     }
 
-    fdt = pnv_dt_create(machine);
+    if (machine->dtb) {
+        warn_report("with manually passed dtb, some options like '-append'"
+                " will get ignored and the dtb passed will be used as-is");
 
-    /* Pack resulting tree */
-    _FDT((fdt_pack(fdt)));
+        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
+        if (!g_file_get_contents(machine->dtb, (gchar **)&fdt, NULL, NULL)) {
+            error_report("Could not load dtb '%s'", machine->dtb);
+            exit(1);
+        }
+    } else {
+        fdt = pnv_dt_create(machine);
+
+        /* Pack resulting tree */
+        _FDT((fdt_pack(fdt)));
+    }
 
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
@@ -952,6 +963,14 @@ static void pnv_init(MachineState *machine)
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
-- 
2.45.2


