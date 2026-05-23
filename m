Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BBECD5BB8
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 16:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQpCW-0007Zs-Ft; Sat, 23 May 2026 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCV-0007Xt-Ed
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCT-0001S2-2K
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NFtDYA2359358; Sat, 23 May 2026 16:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vhkYytgRdiywd75vR
 Uh23erAQgaAokMnOUSIKthfAcE=; b=Un6xzXTp853cOkck7kwg8aapLWI3eCCp9
 wDbOjcB08hnv6PufU4Dm8Or665jt8tKFFic7dI+rWAcA2D7IN+JqbhH+eG9s0D/s
 GGvVtgZ5FFFm3UVnG2N3jcxGJgMzEfXvUCwufVpevgNbT0chrVy7vM6tUlOA/NA9
 TLYLge6OIR12gNKhim9yxaS5wBYsbqylHLhqLMJ/VNK7ehOSgy1LZJJZQGjIQ6Pa
 yOMEM98gMr/UWLrft/aRhuBP1WZDnbT6Q5Ohn5s68uV+l5kPhtBlgTd4PoL0anfX
 fyQxi0ObmhArkRFqaWdMiitvwski0mfxPoJpqBNvgQk5R0lP9W0QQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s21gu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 May 2026 16:27:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NG9FEJ001376;
 Sat, 23 May 2026 16:27:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eb46bsr44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 May 2026 16:27:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64NGRcMl54133214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 May 2026 16:27:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69C1B20043;
 Sat, 23 May 2026 16:27:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1138D20040;
 Sat, 23 May 2026 16:27:37 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 23 May 2026 16:27:36 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/5] ppc/pnv: Fix uninitialized MpiplProcDumpArea struct
Date: Sat, 23 May 2026 21:57:21 +0530
Message-ID: <20260523162724.95229-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523162724.95229-1-harshpb@linux.ibm.com>
References: <20260523162724.95229-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wWv0ijXGon0za1QPsZfm1zZPN4NdyZ9d
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a11d57e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=2nFqyGsmG02ODFuZbPAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE2NSBTYWx0ZWRfXybkib6h23i/K
 G2dmpDf/NEHwIITzg27S+PirVB+SeLMKvGG+hxerviSW5OVZGdIOQu79cqiceQQg8lRHlPbP+jT
 5i2uTHzfWVgLeCyLkKVYkdIycGwhP6SlUr9G1Ecv/3OTD+6qTxwD9Q/ykanQJcnOdrC7nJKD8LM
 JF6IhLF7z04c6GYNpnF6UjBvgPfsBp6MXlNMQ7kdHnV/fQLyrpah4bEJAjFFk/Ir1RJNzbx9jdx
 Q16CRSK6DWJ4ybGSuWoJ59iWNvrbvblbPAdJEvRxBQyYT0zU+M9AL8IIwWAxvwsw+1i5edpolpn
 1h/nSfHMq92T1I1LbgYTpWspvmJA2ZpvjdZXLhXfn2orF109M6Jyt0pzxzq3C/iTCQIjyQeWvgw
 GMgIWTcScykW0d7zZcJN94gcSzyprKcPjD1ZC86DXHa0UymWaxaAMAj2XXzlPCmRORAL2cRPOb9
 kPy5DH8NTkRRfm/HFHg==
X-Proofpoint-ORIG-GUID: wWv0ijXGon0za1QPsZfm1zZPN4NdyZ9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Fix Coverity CID 1658041 by using designated initializers to prevent
uninitialized memory from being written to guest.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>"
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260508142029.624039-1-shivangu@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8306754d9a..6a45852174 100644
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
2.52.0


