Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A54CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLM4b-0003Ef-7m; Fri, 08 May 2026 10:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wLM4X-0003Dt-Sn; Fri, 08 May 2026 10:20:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wLM4W-00037H-7k; Fri, 08 May 2026 10:20:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6488e1gc1392610; Fri, 8 May 2026 14:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=WRYuRjJquH987W2hOgjjAIIPMIN281P852kQ2RGLh
 2o=; b=riez6WekWs606HKt9liKE7rtufPnTw8jI6r7bIkogsqhmj3JrcU8sPmo8
 NhqRUotPa+WLHaj/H4jYG6ClMVOOeISfVMRnRPDDkcH75kp++NAibcp4tzRBA7XK
 EIMPFO1cT9XfATNCY0Snmi55CKmX8HRg+9BD8O78TgQDz132a/gc2xjKX6HLr3Li
 cDFnEORVGkIiCsI8cRntPNfF6U528BFbe4F2yq6WsMERyP/RUrYCQ5BjNscnnM8w
 JNo0g5gElfBhbMGf0PTpq8TiMLufvDNFylEwC9sUym5jPJaiG54mw8RPza+rCNt1
 vrnaPAx/emhI37Bu18yjqlrIhZXSA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1v1et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 14:20:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648EExK7020683;
 Fri, 8 May 2026 14:20:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgravr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 14:20:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648EKmoZ38535530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 14:20:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5018A20063;
 Fri,  8 May 2026 14:20:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E5182004D;
 Fri,  8 May 2026 14:20:45 +0000 (GMT)
Received: from shivang.com (unknown [9.39.23.51])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 14:20:44 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] ppc/pnv: Fix uninitialized MpiplProcDumpArea struct
Date: Fri,  8 May 2026 19:50:29 +0530
Message-ID: <20260508142029.624039-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x4_B5KGArQYShr4oUAK7_vt4DK3dDdFm
X-Proofpoint-GUID: x4_B5KGArQYShr4oUAK7_vt4DK3dDdFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0MSBTYWx0ZWRfX1ArrQhD6lmzi
 qjw8IR343ZgDuNx43TOyh1bFW6J9vS/EZQYbQtBnBmPd9+Yj1jy2ddwuANtPEaW6scc0yCWP/Lp
 1YuM/wny7meOKa+tXjdPLFyl9947WmrNSrIJ1rdpeAEvNoykmQbV3rW1EYJ8kmiqRdprJEPUdR1
 Ndb1AW50nKzh7tJyFNhqNbnj+WeAIHGpoeqbdDFN8X93nlG5YMn7pK/gjF+LkjIIXTFz0wIeNOa
 EMj0aeFLC138mOyg5ojjGgr9BqYocAYA0FoUXmGNWe5Z3+mjlY1hOTVIqoT0LGoRtzAORl2ZHno
 S+hDtH+lvO6yiVF/9US+uhSGP1CWX8KrIqfwPGYaHA466rTQUwWDltWsp2CwRvCEvcoj9pXqcCl
 XsajQmPe5DXte0YaZG4X2FiFvMZ5Uu70srDhmTf8C0mHmN8ex8MF7lcoPEW7v9Vep4BQ09gGRru
 mucDXC/sP9hDDQIy50A==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fdf144 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=oDcglGOjkXyJAjTAaEoA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080141
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Fix Coverity CID 1658041 by using designated initializers to prevent
uninitialized memory from being written to guest.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>"
---
 hw/ppc/pnv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9ed918fa6a..c0afef8197 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -838,18 +838,10 @@ static void pnv_reset(MachineState *machine, ResetType type)
          * crash
          */
 
-        MpiplProcDumpArea proc_area;
-
-        proc_area.version = PROC_DUMP_AREA_VERSION_P9;
-        proc_area.thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
-
-        /* These are to be allocated & assigned by the firmware */
-        proc_area.alloc_addr = 0;
-        proc_area.alloc_size = 0;
-
-        /* These get assigned after crash, when QEMU preserves the registers */
-        proc_area.dest_addr = 0;
-        proc_area.act_size = 0;
+        MpiplProcDumpArea proc_area = {
+            .version = PROC_DUMP_AREA_VERSION_P9,
+            .thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState)),
+        };
 
         cpu_physical_memory_write(PROC_DUMP_AREA_OFF, &proc_area,
                 sizeof(proc_area));
-- 
2.53.0


