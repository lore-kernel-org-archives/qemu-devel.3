Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D69AC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9Ku-0002nn-Po; Wed, 31 Jul 2024 09:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZ9Kr-0002la-VR; Wed, 31 Jul 2024 09:25:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZ9Kq-000582-47; Wed, 31 Jul 2024 09:25:45 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VBSxQu005250;
 Wed, 31 Jul 2024 13:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=ovus5UlPKAld5lkd56ks4IhzGK
 wS8+lccnIO2dZgV+Y=; b=jTVRxKfI2chSQcsLbCd90do7uSWCnHLBQECCpxNY8Z
 CezfHbLSWid5qP3sNWLzYtNzF7y6c8LkjoDQUXNI3tkIzA67OrQy1cKVx+dX68tG
 oc5tKvhtlQ3ZILXgXvePa30EnADbTnPBK6NePxQo3BM3dse3mYERapfUlBc1cKnA
 tlLn8Hs6r5cSFQScUH1QRY38xsD5Bari5xFO1YeXtA5XTmTzu5TjRT8WofYWXCr/
 9jpYtNcfzWlIpDnTyMu0FJcUElP71IwuUKmPrkRSrEY6Z8XBqNlWDRRcvbs/+rdp
 61v6uBnLtodzGe+++Dna590tpKF0OyVtX2dLPNyFVTgA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qme20bbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 13:25:34 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46VDPWlY022998;
 Wed, 31 Jul 2024 13:25:32 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qme20b80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 13:25:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46VBAcKo007470; Wed, 31 Jul 2024 13:22:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7ubwer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 13:22:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46VDMd0q50594150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 13:22:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 472452004B;
 Wed, 31 Jul 2024 13:22:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E3AD20043;
 Wed, 31 Jul 2024 13:22:37 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jul 2024 13:22:36 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH] hw/ppc: Implement -dtb support for PowerNV
Date: Wed, 31 Jul 2024 18:52:35 +0530
Message-ID: <20240731132235.887918-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X6_iEZ2rvcHQfJkDVF3mdy1cTOD3Iy1V
X-Proofpoint-GUID: wDCMDeeTJKyPmUQHQsliAGuZJcFEbvLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=427 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310098
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
This is an RFC patch, and hence might not be the final implementation,
though this current one is a solution which works
---
---
 hw/ppc/pnv.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3526852685b4..12cc909b9e26 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -714,6 +714,8 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
     PnvMachineState *pnv = PNV_MACHINE(machine);
     IPMIBmc *bmc;
     void *fdt;
+    FILE *fdt_file;
+    uint32_t fdt_size;
 
     qemu_devices_reset(reason);
 
@@ -736,10 +738,31 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
         }
     }
 
-    fdt = pnv_dt_create(machine);
+    if (machine->dtb) {
+        warn_report("with manually passed dtb, some options like '-append'"
+                " might ignored and the dtb passed will be used as-is");
 
-    /* Pack resulting tree */
-    _FDT((fdt_pack(fdt)));
+        fdt = g_malloc0(FDT_MAX_SIZE);
+
+        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
+        fdt_file = fopen(machine->dtb, "r");
+        if (fdt_file != NULL) {
+            fdt_size = fread(fdt, sizeof(char), FDT_MAX_SIZE, fdt_file);
+            if (ferror(fdt_file) != 0) {
+                error_report("Could not load dtb '%s'",
+                             machine->dtb);
+                exit(1);
+            }
+
+            /* mark end of the fdt buffer with '\0' */
+            ((char *)fdt)[fdt_size] = '\0';
+        }
+    } else {
+        fdt = pnv_dt_create(machine);
+
+        /* Pack resulting tree */
+        _FDT((fdt_pack(fdt)));
+    }
 
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
-- 
2.45.2


