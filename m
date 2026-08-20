Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA69C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3kl-0003PQ-8b; Thu, 20 Aug 2026 10:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3kX-000345-CF; Thu, 20 Aug 2026 10:28:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3kV-0002FF-SW; Thu, 20 Aug 2026 10:28:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K9Q4nE504067; Thu, 20 Aug 2026 14:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=R/vGzLrLJo0dvIvx1
 ZPSouvsyZobP/9Y0yzNw5HL3DQ=; b=UFpCb4y/tNdiTV9rKV/EUOe/lbCn7PU2n
 G/g6ulOf8yb8Q7WbQaUlDZdeKyNYapkKtpD5pd+DLZTQEpCUqRZ/vGXMgP5RslaB
 ym8DDRv+YSb87xrFbDncnQVU4LOZEhh/4ar1/JWjocj6fjPBwqOKk9how48uObS9
 bQKTCJTO20r5gSCQ49wiUShBqP5wPDlnz0xY1OHFkKUq/x6TsSC/jdUzcjqKoBkr
 FYYIk/j7cnZOYVKfaQ1fcFybvV29W4N0xQYebWUc7GRpLRfMnNzq0WIRAJ+kbFcA
 X44wf7wb4JA5vazOK4ULg9I3iW/A4KeY3WpvOqzXU+UgOT307JZvA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4aquh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:28:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEQX1M028010;
 Thu, 20 Aug 2026 14:28:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhf0kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:28:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KES1YA46006556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:28:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E5F420049;
 Thu, 20 Aug 2026 14:28:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 121A020040;
 Thu, 20 Aug 2026 14:27:58 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:27:57 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 6/7] target/ppc: Reorder PPC2 flags
Date: Thu, 20 Aug 2026 19:57:03 +0530
Message-ID: <20260820142717.337686-7-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820142717.337686-1-rathc@linux.ibm.com>
References: <20260820142717.337686-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a870ef6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=n9CTefPPWk96pEdnryYA:9
X-Proofpoint-ORIG-GUID: wIdMUlSgMky4h8Yxh5Io9kK8cpFoaFHQ
X-Proofpoint-GUID: Pb6-9C-FRwVqBqcQ5-UDjKmaKmjjHjon
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX+4bTHp+N9MUq
 xnl4kAmdlJ4ir0GCq467sDiI7KJ5AAiH/d4aLqDCu3/mCgv6EYbWiDODAMBombUjyW1+dfnDH8p
 7gIabqSuw1Q29g1f77qW6MJjBv796lg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX1DoofgwkPWR4
 Cp3hhraQc8QT0SQHgdLVXHEPedW5W2DwsWI4QvPgThtfsBCCGrDhe25AXaeKiZmO8EoojQbUY/n
 r5nQKYALiZlJxuP7/zBTGOhBN8kAV9NAfTFv04u2xK42FRZKxq/J9h2zF1/sddjZvhdK52k2iSt
 b9UlNvUqrIPOnP3T+GCT9Ff7EMEIfZGnpfQXN9jI3/T8LmX1O1VzI/H0F0AoFNHefrXCEtyKTCJ
 Z3hJAtSc3sgLEngBphC+gkNOSqY5XXetMue//3mAn6fHDJRUVck4PuoeQ7AJWHO7A58mtih8oLZ
 S+8idYn+c6I6N2VBozggugUWeb5ch3NXlDMy04YO3IMSKCf8ds2OUrHuVIlV75oDlB5KK4uxD9h
 +Qi3nYLtFhk6JLM+DAzwSblO8xOUjqbLvSAHHx7UYKsb9fTxLx5l1dGp2hu3m+MtLBR22U4JlTz
 lvaDf+rrxf0SDAETOWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200105
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

Consolidation of different variations of Power ISA 2.07 flags
into the PPC2_ISA207 flag has left gaps in the flag encoding.
This patch reorders them, restoring the expected incremental order
without any gaps, freeing up bits for future use.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/cpu.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4a77607f80..3fb51bbeb8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2578,25 +2578,25 @@ enum {
     /* ISA 2.06B floating point test instructions                            */
     PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
     /* Double precision floating point conversion for signed integer 64      */
-    PPC2_FP_CVT_S64    = 0x0000000000010000ULL,
+    PPC2_FP_CVT_S64    = 0x0000000000001000ULL,
     /* Transactional Memory (ISA 2.07, Book II)                              */
-    PPC2_TM            = 0x0000000000020000ULL,
+    PPC2_TM            = 0x0000000000002000ULL,
     /* Server PM instructgions (ISA 2.06, Book III)                          */
-    PPC2_PM_ISA206     = 0x0000000000040000ULL,
+    PPC2_PM_ISA206     = 0x0000000000004000ULL,
     /* POWER ISA 3.0                                                         */
-    PPC2_ISA300        = 0x0000000000080000ULL,
+    PPC2_ISA300        = 0x0000000000008000ULL,
     /* POWER ISA 3.1                                                         */
-    PPC2_ISA310        = 0x0000000000100000ULL,
+    PPC2_ISA310        = 0x0000000000010000ULL,
     /*   lwsync instruction                                                  */
-    PPC2_MEM_LWSYNC    = 0x0000000000200000ULL,
+    PPC2_MEM_LWSYNC    = 0x0000000000020000ULL,
     /* ISA 2.06 BCD assist instructions                                      */
-    PPC2_BCDA_ISA206   = 0x0000000000400000ULL,
+    PPC2_BCDA_ISA206   = 0x0000000000040000ULL,
     /* PPE42 instructions                                                    */
-    PPC2_PPE42         = 0x0000000000800000ULL,
+    PPC2_PPE42         = 0x0000000000080000ULL,
     /* PPE42X instructions                                                   */
-    PPC2_PPE42X        = 0x0000000001000000ULL,
+    PPC2_PPE42X        = 0x0000000000100000ULL,
     /* PPE42XM instructions                                                  */
-    PPC2_PPE42XM       = 0x0000000002000000ULL,
+    PPC2_PPE42XM       = 0x0000000000200000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
                         PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
-- 
2.55.0


