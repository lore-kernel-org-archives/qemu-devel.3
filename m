Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C77CD98CD
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEq2-0001i7-Ty; Wed, 10 Jun 2026 05:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEpz-0001ho-9W; Wed, 10 Jun 2026 05:03:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEpv-0005gu-FN; Wed, 10 Jun 2026 05:03:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A2RGio2909046; Wed, 10 Jun 2026 09:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0Wgnn7I2vRtHQ8O6x
 TF2PIC/mA1um5ByhIfqWw7eN7c=; b=rf3y8C/TvcxRF4WPuyjYul4AD6nVk4RtM
 sGsSDd+6d70L1tW5r8zfbKRvwc2z3/mqwidh1XAnMh8+82G0r4VQgGS3IN3xufgx
 9BtMqCd7d9xyqJF80W7FtJbZCLhWzV5L5NDqLNQDOsnnQ+GbwLOynTmvPaKYge9q
 uwh/8xsHEOHGNqF5QBsBwy+J1y7bO8MGeP67qhNB4Q3MQEl7CDu+FbDauv+ntHE5
 Zp19Wb7x8DyUPovwS2x7soE8WvWTVMGm2v3kwdUIYL7YnkhVJ+fWWjUDkdUkqXQX
 pWfhpohUEsajUYKQgo8NPsz+dQY7Y2h43nFTl40LsLYcLTP4O9LdA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb240ctb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:02:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8ndYu023972;
 Wed, 10 Jun 2026 09:02:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jydph1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:02:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65A92qTs31588650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 09:02:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED69220040;
 Wed, 10 Jun 2026 09:02:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F2A62004E;
 Wed, 10 Jun 2026 09:02:48 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.29.92]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 09:02:47 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 2/4] tests/qtest: Add Power11 chip & machine to qtests
Date: Wed, 10 Jun 2026 14:32:33 +0530
Message-ID: <20260610090235.3665904-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610090235.3665904-1-adityag@linux.ibm.com>
References: <20260610090235.3665904-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a292841 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=tRhVeYQ_LaMwSwJxkk8A:9
X-Proofpoint-ORIG-GUID: s4fF38dqxcfaWCGVi1JbSJEv1M4Bpv7N
X-Proofpoint-GUID: yjzpf5WNmK6nbc2gsw9OeZBrp0Soevwi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MSBTYWx0ZWRfX927A20BwW0AJ
 6HaTQS1GDoEe00+HjXy3jhXl3Ro/+H+cBViQAWe6QX9AUKDs+swk1fBrrttfDR5TmDAmAjCBBR7
 XIRoUbNCPIGBBFZcOT3ccQVB53CcdJWl6CmOlnnwfWsb8dRI7XOF4151DR33pJHYXOgLpjgWWDN
 NtG8y2yoK0OonJ14aTfdXts7RbzsejK2Hj4R/WieT7rsAWB35vknLG1pQZcDimTFIHfykGaFYND
 O5nZrThwJdnuVTDnayLaETFXbzcsTKt4C6CAN/DPWBhaq/x/RpyRrpP+W5hC4YXATFFTgXGnGig
 vr9VNhbxkrNe3Hpm9SqD9sgS7tG3ZJRk6kKZI3BktHcwHe1mkoiac4Oe99zaERnDBykJFZjXnVN
 pODObazGxPqWycvu1LSC1eXbwRwxVtRZW5UyD5q1nA111WieAgKOcVPZr+67i92ZmbILJ89+vaN
 odVOI6fOCwAiViHxd+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100081
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Previously the machines/chips tested by qtest was till Power10, update
the tests to also test PowerNV11 and Power11 PNV Chip

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/pnv-xscom-test.c |  7 ++++++-
 tests/qtest/pnv-xscom.h      | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index c814c0f4f5b1..b2bdf712d9a1 100644
--- a/tests/qtest/pnv-xscom-test.c
+++ b/tests/qtest/pnv-xscom-test.c
@@ -35,6 +35,8 @@ static void test_cfam_id(const void *data)
         machine = "powernv9";
     } else if (chip->chip_type == PNV_CHIP_POWER10) {
         machine = "powernv10";
+    } else if (chip->chip_type == PNV_CHIP_POWER11) {
+        machine = "powernv11";
     }
 
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
@@ -57,7 +59,8 @@ static void test_cfam_id(const void *data)
 
 static void test_xscom_core(QTestState *qts, const PnvChip *chip)
 {
-    if (chip->chip_type == PNV_CHIP_POWER10) {
+    if ((chip->chip_type == PNV_CHIP_POWER10) ||
+        (chip->chip_type == PNV_CHIP_POWER11)) {
         uint32_t first_core_thread_state =
                  PNV_XSCOM_P10_EC_BASE(chip->first_core) + 0x412;
         uint64_t thread_state;
@@ -91,6 +94,8 @@ static void test_core(const void *data)
         machine = "powernv9";
     } else if (chip->chip_type == PNV_CHIP_POWER10) {
         machine = "powernv10";
+    } else if (chip->chip_type == PNV_CHIP_POWER11) {
+        machine = "powernv11";
     }
 
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 5aa1701ea768..8d79d278ccd0 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -9,6 +9,8 @@
 #ifndef PNV_XSCOM_H
 #define PNV_XSCOM_H
 
+#include <stdint.h>
+
 #define SMT                     4 /* some tests will break if less than 4 */
 
 typedef enum PnvChipType {
@@ -17,6 +19,7 @@ typedef enum PnvChipType {
     PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
     PNV_CHIP_POWER10,
+    PNV_CHIP_POWER11,
 } PnvChipType;
 
 typedef struct PnvChip {
@@ -60,15 +63,23 @@ static const PnvChip pnv_chips[] = {
         .first_core = 0x0,
         .num_i2c    = 4,
     },
+    {
+        .chip_type  = PNV_CHIP_POWER11,
+        .cpu_model  = "Power11",
+        .xscom_base = 0x000603fc00000000ull,
+        .cfam_id    = 0x220da04980000000ull,
+        .first_core = 0x0,
+        .num_i2c    = 0,
+    },
 };
 
 static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
 {
     uint64_t addr = chip->xscom_base;
 
-    if (chip->chip_type == PNV_CHIP_POWER10) {
-        addr |= ((uint64_t) pcba << 3);
-    } else if (chip->chip_type == PNV_CHIP_POWER9) {
+    if ((chip->chip_type == PNV_CHIP_POWER11) ||
+        (chip->chip_type == PNV_CHIP_POWER10) ||
+        (chip->chip_type == PNV_CHIP_POWER9)) {
         addr |= ((uint64_t) pcba << 3);
     } else {
         addr |= (((uint64_t) pcba << 4) & ~0xffull) |
-- 
2.54.0


