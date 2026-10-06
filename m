Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E0FCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMi8-0000EF-1M; Wed, 07 Oct 2026 04:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEGc9-0005Ia-9Z; Tue, 06 Oct 2026 21:38:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEGc1-00007j-5Q; Tue, 06 Oct 2026 21:38:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A634m3272649; Tue, 6 Oct 2026 10:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3Xh3jCQeDsByIDj3f
 T2Zq3hR9TEKRiaROILVWo4dYFc=; b=jUaIT0vzDMVLSsRxo+ljeAQ8mshFmYfe2
 +B+xbPyHbIZCDQWqQ4a5T4aiPCTeTiKbIXKuCOnMHdUMlRu3b4mL9GRMEJXQ0YM3
 Lngk06NgbCpSPmBVWMJJVz4yidZT2+cfwDAYdLpAEKTTaapRuHpiDJKxd1kwEKSY
 U89thY6pu9iyWJ7E38OjtxsO/i13p2WPbTw7DB3UefRaf1hOk8yeJJsGa3ONivwd
 79m9ro5Lvk8aTJyXB6f40Wd+7OiJFapiiZhDVCprDxkN0AJY/OR+B/yX205txOcj
 m3yLfDkNtUbknQgW6qK0dDZHZO7Cnhu00OPZ2v93jL2q8zvxpgL1Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jpyxm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6TmM108933; Tue, 6 Oct 2026 10:57:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jsjbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696AvBM656558044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BC0C2004D;
 Tue,  6 Oct 2026 10:57:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9420320040;
 Tue,  6 Oct 2026 10:57:08 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:08 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 1/8] target/ppc: Add flag for Power ISA 3.2
Date: Tue,  6 Oct 2026 16:26:12 +0530
Message-ID: <20261006105650.189752-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ZuvRDQfdA0EzxGlpNE3Z01VBnGuIuw93
X-Proofpoint-GUID: HfKLlDC1o5r-yGYnmAOwYnIZbDxRTrPT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX0motjKBNftPk
 tTvuf0u0fNa8XvS6e8+4SrJJ3tqRqj6fD7VjAiuD6F3VTtDMA282IGEFTlwLm8sGjXlG7FK/2bv
 Ua5WXFJP2DA22LtyT77oaEAVOwe0SCk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXwMmUXf0/Eb6P
 hetshnkj0K5NmCGRuKIs8OdnFq4Pll8Vso5uqq52Kw8Exaq85YlAKPqR3nMbVBPiTP8PJsSGlu4
 7RSBzMAC46tqhlIRrxvdkheKeqdEMKBbevxIvegModAmPnn0tn5cQHi1viyP0nzGxsubh8VLZ1c
 7PY3o6Fgu1UUazXKPNZV3fHyrmHsXJbmXKPNmSeJW0cZNAj5WRHykAkEc59fboFhmE+gwu8qaHS
 QCc4ZxIUduo21htUxuP1pwxj68/gDU8ZdVLHNb9plbPQB0a3QZy3gfUzHi/tGtXtbofNuyvO6jE
 azZcm9zH0ws1rogmfDW6DVThmNM/zzcq91AZnPLxyBzQNySlchqGttZl95uaJ4pM8bMr2KKA029
 3ddljObmOSbMJBuV3yVxRMhebofSWhFvWGLuH04P+LLXXWmEHvhwuK6X+Je8gZzAbqK2Lgi4OiW
 ryiAPY2R7gzL9qTBhWw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac4d40d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=v3d_LIi4FdR2poami0cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Adding flag for Power ISA 3.2.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/cpu.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb8..09b511030b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2597,6 +2597,8 @@ enum {
     PPC2_PPE42X        = 0x0000000000100000ULL,
     /* PPE42XM instructions                                                  */
     PPC2_PPE42XM       = 0x0000000000200000ULL,
+    /* Power ISA 3.2                                                         */
+    PPC2_ISA320        = 0x0000000000400000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
                         PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
@@ -2605,7 +2607,7 @@ enum {
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
                         PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
-                        PPC2_PPE42XM)
+                        PPC2_PPE42XM | PPC2_ISA320)
 };
 
 /*****************************************************************************/
-- 
2.55.0


