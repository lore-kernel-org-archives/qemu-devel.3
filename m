Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5303C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reylh-0007mN-Aq; Tue, 27 Feb 2024 09:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.vnet.ibm.com>)
 id 1reyle-0007SX-LU; Tue, 27 Feb 2024 09:49:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.vnet.ibm.com>)
 id 1reylc-0003rF-56; Tue, 27 Feb 2024 09:49:14 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41REhH0M000974; Tue, 27 Feb 2024 14:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2/QSb0OdJNwMPRn7P7cahTL5KAjIljSb5JFVHYcYULM=;
 b=m6UpFZL7RVnkt81njpYVy8C6cz25M2ARYxtJPxSCtKJHs+zhvLGmbetv6ZLwOG7CimJo
 mc+6cb+oA4solMeK0cMNf1Eh2wuWLQjXx8Ui50fSg/8qTcgfm4sai9uFFWEPs8quZTeU
 97OBgqm2L33yH9Jkw4RLoCQ5mpWGW3GwYuEIOqiMGiod4G+jslkCaaIfONdGhsqm826w
 UXI7ceznmHRbFwc5uU9Y9kgi6Lka4k1Og18+uATc+OcJCsRBXp6L7pVyPBNIpvZfCW8A
 c04IqLqd0vJSv/RyKSbj1WCUI99X5FOzaOi8lKjpLPjmY5Zt77D1TGkDJ42yvS/ivD3j zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whh7y1a8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 14:49:01 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RElpkF021355;
 Tue, 27 Feb 2024 14:49:01 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whh7y1a8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 14:49:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RDtObq024154; Tue, 27 Feb 2024 14:49:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0k7wtn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 14:49:00 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41REmwiP18809480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 14:49:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75B8858066;
 Tue, 27 Feb 2024 14:48:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AD2D58052;
 Tue, 27 Feb 2024 14:48:58 +0000 (GMT)
Received: from gfwr540.rchland.ibm.com (unknown [9.10.239.160])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Feb 2024 14:48:58 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, calebs@linux.vnet.ibm.com
Subject: [PATCH 2/2] ppc/pnv: Fix pervasive topology calculation for P10
Date: Tue, 27 Feb 2024 08:48:44 -0600
Message-Id: <20240227144844.23606-1-calebs@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ytxbxp4nw854qVrdJzJBv2AqKZFeb_bS
X-Proofpoint-ORIG-GUID: pGb7aqNeVmH9Aw5HPe96hB_mLXEz4OKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270113
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=calebs@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pervasive topology(PIR) calculation for core, thread ID was
wrong for big cores (SMT8). Fixing for P10.

Based on: <20240123195005.8965-1-calebs@linux.vnet.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
---
 hw/ppc/pnv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2f53883916..aa5aba60b4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1068,12 +1068,23 @@ static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
     }
 }
 
+/*
+ *    0:48  Reserved - Read as zeroes
+ *   49:52  Node ID
+ *   53:55  Chip ID
+ *   56     Reserved - Read as zero
+ *   57:59  Quad ID
+ *   60     Core Chiplet Pair ID
+ *   61:63  Thread/Core Chiplet ID t0-t2
+ *
+ * We only care about the lower bits. uint32_t is fine for the moment.
+ */
 static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
                                  uint32_t thread_id)
 {
     if (chip->nr_threads == 8) {
-        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
-               (thread_id >> 1);
+        return (chip->chip_id << 8) | ((core_id / 4) << 4) |
+               ((core_id % 2) << 3) | thread_id;
     } else {
         return (chip->chip_id << 8) | (core_id << 2) | thread_id;
     }
-- 
2.31.8


