Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F1C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 04:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq3xL-0005bV-BZ; Fri, 29 Mar 2024 00:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rq3xJ-0005bC-6k; Fri, 29 Mar 2024 00:35:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rq3xH-0007AV-6P; Fri, 29 Mar 2024 00:35:04 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42T4SVrk006043; Fri, 29 Mar 2024 04:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2WtjiPlA9oLJx5SyJWYCm7c1Hw4nIjBqj4XZwX0PV00=;
 b=VbXsgp2CMlGGnULmEI4pK/tGKpvUy0TmkyygRKXMp+B3V89Fczxf+hBn5E29wpvS68Qg
 UIe9jAfcGyCZ+vTFX1r9cGFtjTXwE/gZgyARQ90tDnzqLSYtLyvzdQgwQAuc6cTZZNUq
 vugRpTF/R1WMyN1NvVXQubiNuZR4Yb+UOHTymp5Ij4IsYBOtcEw1r1IOVjJH+Ct1w6kY
 4mqvhmJXmtn2J/up+P4+sO3QcfR0akcL8AH3exgcTC1dDgXw7IVfVnITbYmSOjlpqOOq
 V58xK4QPB9tCr7uSIgBkvv6CRNY4OwHco+mOauuqSFULV/NfCKH6nlgH5k317ao7qxIY hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5pmj00bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 04:34:56 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42T4Ss4j006771;
 Fri, 29 Mar 2024 04:34:56 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5pmj00bc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 04:34:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42T3fUOx011358; Fri, 29 Mar 2024 04:34:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmmhjtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 04:34:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42T4Yp1K8061228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Mar 2024 04:34:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2A9E20043;
 Fri, 29 Mar 2024 04:34:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B3C820040;
 Fri, 29 Mar 2024 04:34:49 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.44.150]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 29 Mar 2024 04:34:49 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: mikey@neuling.org, danielhb413@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Subject: [PATCH] spapr: nested: use bitwise NOT operator for flags check
Date: Fri, 29 Mar 2024 10:04:36 +0530
Message-Id: <20240329043436.2857533-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oO18ojOJt_I1W8Z0-1N3aAL2owpBXh8G
X-Proofpoint-ORIG-GUID: 9WFO-zTtgOTHZvt3S6nqkHRG0zk3RmK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_03,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=797 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290034
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Check for flag bit in H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE need to use
bitwise NOT operator to ensure no other flag bits are set.
Reported by Coverity as CID 1540008, 1540009.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 936659b4c0..c02785756c 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1511,7 +1511,7 @@ static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
     if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
         gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
     }
-    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+    if (flags & ~H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
         return H_PARAMETER; /* flag not supported yet */
     }
 
-- 
2.39.3


