Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA403112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Kfe-0002Qv-S7; Wed, 11 Mar 2026 10:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w0Kfc-0002QL-HO; Wed, 11 Mar 2026 10:36:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w0KfZ-0005a9-Mv; Wed, 11 Mar 2026 10:36:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BDllxg1278613; Wed, 11 Mar 2026 14:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+ikecbBlDzjkHpOTUJk9pHX4nWlJUfWsO9zaA38o3
 kQ=; b=iJFLphMR9qyHKBnK0evP/e4t/mSv1QoB6wrnjKcHvdzcbt+Gju37Lib38
 qnE18i9LqCN31J3URJaOn1VKFgRsHwGkmHjPuGtXwN9cwbr6K++FLUbDkocRdQsn
 Lsv2vRD8dNodQL2Rqf5gVGDoGrRfGZNAUz5SHfpXZbxEH8h+dPXNg4j9SztH4RBq
 VZeHWvT+m2q8lox0PmuunZbj+C+qc4OkbcyRb6LleBKVci1UpFUYTyfKFYMkNZSC
 gYV/TAYGZQKon41hWSi64QVZi8Usvoca0IZ56Hz0tozGhlKkkHRxhuBJ7xZ12n9S
 RXNV4xgPrOIMkfSL4FnTX+F1fjg9g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunfuch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 14:36:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BBUBeB015653;
 Wed, 11 Mar 2026 14:36:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybndty1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 14:36:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62BEa7cu35062142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 14:36:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 575DF2004D;
 Wed, 11 Mar 2026 14:36:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33CC12004B;
 Wed, 11 Mar 2026 14:36:05 +0000 (GMT)
Received: from shivang.com (unknown [9.39.21.199])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Mar 2026 14:36:04 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Subject: [PATCH v2] ppc/pnv: fix dumpdtb option
Date: Wed, 11 Mar 2026 20:05:49 +0530
Message-ID: <20260311143549.118720-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ClNy8cQFDK3Ep3JD8btJD5IzDwiiOVe9
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b17ddc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=QjnmHpCl0YB2qDOJ94UA:9 a=cvBusfyB2V15izCimMoJ:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyMyBTYWx0ZWRfX0o4h/6wrIHpw
 f4ezdORMeProc7wlmkR4D5na44eldaVJEvCk+xUx0PO3IP2NlltkBhFrvimkYccSTa+F4QWKTqJ
 rWP09DIO3bh8WQF8H7IWwm7uSw0zlEIgOrA2x63vhC0QxgE+jII2IRA9sBJyVCE90OZEQcYHayz
 CDaAN2AtjrsfvepKy0dkoLc9nA3+1GV/La+UU4PRA3t36OJNv/Il1lAT0MpoELXdWDqSb7z99kR
 ymvRpwPHIZx0/RJ4uN5sHKQ3Mj4YYVxKh0mlkwNR52+9v0fURRinPMOHIypcfXGry+tr27Br1VF
 nxhwUmiZmT9gzdNqiaVy+saEb/OtyqHSPWXPNmrsfqczNU59Y719bG2c8wgnYPSCpypySfR+Rap
 gacVFPYAgKSnceEcCt0/UGr9yYGJAWZJa75gS0EB3fy+ZJCk4HNpNzA80pTtKEpxjei5MaUzWlu
 FUQcASVBvz9EhpptYvg==
X-Proofpoint-ORIG-GUID: n9j1c27V22nZ7QiBClrtwirKqApeBahc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110123
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The '-machine dumpdtb' command line option stopped working on
PowerPC/pnv systems after recent design change [1].

Fixing this by generating fdt blob in `pnv_init`.

[1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-stable@nongnu.org
Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>

---
Changes

V2:
    * added fdt_pack to newly generated fdt in pnv_init
    * cleared the fdt generation code from pnv_reset

V1:
    * https://lore.kernel.org/all/20260225081037.21990-1-shivangu@linux.ibm.com/
---
 hw/ppc/pnv.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1513575b8f..7e54b6bc60 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -773,26 +773,8 @@ static void pnv_reset(MachineState *machine, ResetType type)
         }
     }
 
-    if (machine->fdt) {
-        fdt = machine->fdt;
-    } else {
-        fdt = pnv_dt_create(machine);
-        /* Pack resulting tree */
-        _FDT((fdt_pack(fdt)));
-    }
-
+    fdt = machine->fdt;
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
-
-    /* Update machine->fdt with latest fdt */
-    if (machine->fdt != fdt) {
-        /*
-         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
-         * the existing machine->fdt to avoid leaking it during
-         * a reset.
-         */
-        g_free(machine->fdt);
-        machine->fdt = fdt;
-    }
 }
 
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
@@ -1261,6 +1243,11 @@ static void pnv_init(MachineState *machine)
     if (pmc->i2c_init) {
         pmc->i2c_init(pnv);
     }
+
+    if (!machine->fdt) {
+        machine->fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(machine->fdt)));
+    }
 }
 
 /*
-- 
2.53.0


