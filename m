Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F991C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpmM-0001Qj-MF; Fri, 28 Aug 2026 02:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpmK-0001J1-MN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:09:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpmI-00013Y-Ts
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:09:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S225bN596414; Fri, 28 Aug 2026 06:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ebFzdhOHIeg/L+KHY
 NbNsDTAWodqmNQcU9yqNDNZEaM=; b=EvIaXvIu/iBE7rWKDuFu9xwgBltcds188
 I4zus/DYFLPsL8IU+GhfZpIeGXXZ1AKy45b8qt1UlWsFbyLmLin+VDlGbEwLQjH1
 clSEJPuTuNNOKKxJYACyMLc4FOHBF/h3XdLRn+9te0TqtfAJ9ey4oVhtd7rKBaTB
 Ck0/NYfGqvdnXHJvdFj0kqOjsPnhlNbjMFNHRmn36utXDbsKCsJnglxSbQwiwhdN
 +t32rexHE+/kFRgT5/62X8D5Idc05a23ThVjOAPIa4Jjqd6VjlexAJN0y1l59F2/
 uHw2TV39PsC0hY8935QPM9AxijnrQ6P0KjMHvefPJ7a3+TdcURZWA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394jeag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:09:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uEsV025163;
 Fri, 28 Aug 2026 06:09:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragvgg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:09:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S69AYA47120752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:09:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D4AE20043;
 Fri, 28 Aug 2026 06:09:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50E1D20040;
 Fri, 28 Aug 2026 06:09:08 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:09:08 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 39/41] target/ppc: Reorder PPC2 flags
Date: Fri, 28 Aug 2026 11:37:14 +0530
Message-ID: <20260828060716.91672-40-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7ma61gf6ZNXWK9I4pyMbmWd4qHATUXuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX7V6TD44b4L0R
 wF+jcZKN2p7U91bwxDn84YKpEZJL6ZvK4kGc4SLdaAejGm+vI3OZKsVYnSJIdTi7iKqqIOzkUea
 xiUU1Vs5BZ2nrTs2QcqMpUHt/AN5hP30EXjuW4/bAXGjqRePIC+1Yzuk/u7/1kWNOwvgY573VsR
 y4S4j+t2XDoSJn10DkP5hZT4ICp2a7YMn6wxuVIupUNxmPFV+2KopiCSbJLqnAFjGf+Gdixp+1C
 Tn1JPYZAieHjaglGftsgi0LD3UJX1ZvdCkOk/wxlfmHyVtWy4tNULrKvUef3S89AV3Qt9EOb1sy
 Qsjsdc1YYAg0lZiPJNlu3iNKBGDalvGF//rdaVodNUxianGojkBrgWqhD3YKmQSXExyTw168cZM
 aIgRg9UbYL9l7AFujurySxA6j/a7ExLIRxqZD1kDYLzvfB0KZusKJ9FlXz5Pv2v1ByadFlNpUBd
 q2t0799/vH+FH1LIIaQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a91260a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=fk2NG-Jcr9xy3FZPRKoA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX19IUoH9BR4h4
 3YrjrRTEahWuBIyRvRrH80zn2G0j1A2CdKDTeal3A9ToekE2A+JnJrom0CPjCLlrCM9Xnif9XMT
 KxT/TAWEXZsdk7J5Fdz5K+zlkmr1Uok=
X-Proofpoint-ORIG-GUID: 7ma61gf6ZNXWK9I4pyMbmWd4qHATUXuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
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

From: Chinmay Rath <rathc@linux.ibm.com>

Consolidation of different variations of Power ISA 2.07 flags
into the PPC2_ISA207 flag has left gaps in the flag encoding.
This patch reorders them, restoring the expected incremental order
without any gaps, freeing up bits for future use.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-36-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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
2.52.0


