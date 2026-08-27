Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D268EC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaFS-0001K0-D7; Thu, 27 Aug 2026 09:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaFP-0001Ah-QG; Thu, 27 Aug 2026 09:34:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaFO-0002Ge-1P; Thu, 27 Aug 2026 09:34:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVdPi2976154; Thu, 27 Aug 2026 13:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tnlQIZ+8F1awsQZgS
 BNauADfqrfN6SbSYPpUe51qZu0=; b=bbEUjrnrP7TNL8gCZeBpwnJbIxqKoGX/a
 fw+drW5LwtWQSH3XqzOZ5D9ox2WOtIIGnyd9UbOMJP/1bxnD4hHRPgjGi0s4v9Oq
 ZmxeK8E55Oi9URyXM54uS6uosgLLehCqEEbsSaXdopoHS2rs0g5Jg1UYxk+HwM2X
 kvIUTTagg2+sogSWfdJeNHkZu4ozsVI79Rg1zn4dmjnKF1TEEWDql9728liwKvpq
 e5XcM0BB3O2fUHuRcH2EsoD0SmyamoQO1aw0Zjb2uzGFyV/Ck91JAWApdGzH5j9t
 7+hpMgd4Z97eZclEgK1YcTc7MjadhBC8jFZ+xpLNbews0984woE7g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394dp64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:34:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQKA3024853;
 Thu, 27 Aug 2026 13:34:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragr4ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:34:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDYIbL41353498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:34:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B0602004D;
 Thu, 27 Aug 2026 13:34:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B178620040;
 Thu, 27 Aug 2026 13:34:12 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:34:12 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 35/37] target/ppc: Reorder PPC2 flags
Date: Thu, 27 Aug 2026 18:59:50 +0530
Message-ID: <20260827133010.278889-36-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: XYNaCYcPyJOlsdhvZFDxgmaQWWhq8bkO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX6GOVJRmB/m81
 SzwwpFPrWOibMtmPI0Nrz0CYT74kvzzBGrlZamtXL4v+aDLHzKDD399epULE26rCC9nvt5HMvc+
 F+cJmKy9NNg4ghEekPPCG3RBjMp2zt+RWzaOHalJ6LVggOMW8hRTeHIoeSylH7YveyI6z6qPavG
 KRsuCLyStZ61qbKnw8KGaGjbRtAPFA5nsBkoQ8Y/8Awo9A840MH0HtXRRaQSjeNlmmbKtOEtNbG
 K9cVbOT3f/9UTh9mm2cDHVoBpdRsOfJRurUo/vCNYEVVOAHciJnvaItZeXG93hI7Tvr3o3ES7O1
 Q8kZ4mMFS9ZK/GGmnBw3NcHZLRfeormczezg8TiZH890GG4msbAVwqIcAGtFIUiOWMBl9pmoRBW
 2ctfrlm7ccNMN9FdVbN3Q9PVHOSqvfq5nxssufohIpd2xjGOPKO80Ys9tltLY1q1iUndDyCtBvj
 YRc/nsx8DutpECMS7WQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a903cdf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=n9CTefPPWk96pEdnryYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX25mDbIG5doGT
 HEzakT/Wmy9EjwtrARSPFrEGfjHY47BDdCn1O+9kMkNILkREFrC8paRmbeF8d8+NxEsPyxxK+wF
 O8bF0LL4UrN9RypGHMnRH1uS/I1ywa0=
X-Proofpoint-ORIG-GUID: 1DKLOoWSk89AGykSpdNMfgi3gJLpw3N_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

Consolidation of different variations of Power ISA 2.07 flags
into the PPC2_ISA207 flag has left gaps in the flag encoding.
This patch reorders them, restoring the expected incremental order
without any gaps, freeing up bits for future use.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


