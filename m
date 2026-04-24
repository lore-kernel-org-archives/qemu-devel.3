Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE631FAD41C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGC47-0004bZ-8R; Fri, 24 Apr 2026 04:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC45-0004b2-Of; Fri, 24 Apr 2026 04:39:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC43-0005IJ-Us; Fri, 24 Apr 2026 04:39:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O48OKU4175600; Fri, 24 Apr 2026 08:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TNaY7HfJGb/yvulA3
 TviyaKl4h5mz6iUXN2L9tU19Tc=; b=WXBXL8aFsDfVbJ/KTRwjR5oaAPuXIna8W
 G3/xuYVkmGIdfSY1oiIT2+rEnQoL1AjX1AxJdNuIm9iuR3Em1TPL+Y4LzLIYJJ19
 dTO6isaxNO+/GZmTltwm4xsBC3ml4YiFIzOgFm8fVNgEhatd6VccyTiMGeSBwcPc
 3Fq0bu70foh+JGurrpqSG6cySMMrtpPid+Ic7ZtZ9q4lw/WwKZzSakMQmkMfu8Bm
 TGUButhJNKdExdeSiEMkm4bynTqhhA9HCuL5fhU/HErWoPnRFEwXd2WeaUG/6r4t
 jfYbDBsg119zY9xOeopUSIidi8PIj8jFnYWaSOk6Pc9ua49aFaMRA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrm9x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O8ZV2b002414;
 Fri, 24 Apr 2026 08:39:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkya2c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O8cxkM56427004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 08:38:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56AB32004F;
 Fri, 24 Apr 2026 08:38:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 128232004E;
 Fri, 24 Apr 2026 08:38:56 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.230]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 08:38:55 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v6 01/10] ppc/pnv: Move SBE host doorbell function to top of
 file
Date: Fri, 24 Apr 2026 14:08:28 +0530
Message-ID: <20260424083837.214947-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424083837.214947-1-adityag@linux.ibm.com>
References: <20260424083837.214947-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: PfM-jKoopBW3BCRdcM9QKYJV1PmZ1hFS
X-Proofpoint-ORIG-GUID: X0svmqQRzOm0lF-QgIQwcQWG6pJsgpgt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfX0MaRBUmirzNN
 Zdzz+QJJVPCmq0vdVt8cPRRIEBd/wwOOK/gkHSN7Mg1epfBhHWJDPQHAPVhI+lsIEgfCZffR1tJ
 xOuoikbgn0qaCsIP9IZd9+8kd0l2o3PsbM6lC0AeF/zM7Ch/HTikUuDWGVNJEnr4mf3iPm79onS
 oUIidacYwHJttK+iCRj14V8hquBIh561ylfCqC/re36ezdScVIHrGKULhHJIRNQhScOTGTHl0AI
 dRBuXeL5G9xmprLPVVxQZ3Otjq9IATEDv9SEDagk23M8aqYlRMHux2xRu+Wd6yqHshMuuEZOD7+
 ppDIp9rQu2E58PLHUN3kTdLtMhVgxzDYpNbXxtPSaVSmt1+fWMBcNMnNwNiVbH7aY5MjjUbqVjN
 Y/e38fvln8pL80DkMbdFGk+hydnwltTUxKArow7b51TYek6yqf8+1u10MycUtjva0Ld866Gn1rR
 hC5b4tP4QwgtBPrMFJg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eb2c29 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=cAoldatroyQ9OnmYqHEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240076
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

Moved 'pnv_sbe_set_host_doorbell' as-it-is to above
'pnv_sbe_power9_xscom_ctrl_write'.

This is done since in a future patch, S0 interrupt implementation uses
'pnv_sbe_set_host_doorbell', hence the host doorbell function needs to
be declared/defined before 'pnv_sbe_power9_xscom_ctrl_write' where we
implement the S0 interrupt.

No functional change.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 27383ce6837e..247617338a0d 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -80,6 +80,15 @@
 #define SBE_CONTROL_REG_S0              PPC_BIT(14)
 #define SBE_CONTROL_REG_S1              PPC_BIT(15)
 
+static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
+{
+    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
+    sbe->host_doorbell = val;
+
+    trace_pnv_sbe_reg_set_host_doorbell(val);
+    qemu_set_irq(sbe->psi_irq, !!val);
+}
+
 struct sbe_msg {
     uint64_t reg[4];
 };
@@ -125,15 +134,6 @@ static const MemoryRegionOps pnv_sbe_power9_xscom_ctrl_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
-{
-    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
-    sbe->host_doorbell = val;
-
-    trace_pnv_sbe_reg_set_host_doorbell(val);
-    qemu_set_irq(sbe->psi_irq, !!val);
-}
-
 /* SBE Target Type */
 #define SBE_TARGET_TYPE_PROC            0x00
 #define SBE_TARGET_TYPE_EX              0x01
-- 
2.53.0


