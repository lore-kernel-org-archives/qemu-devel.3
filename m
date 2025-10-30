Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A50FCCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOMP-0007oW-4E; Thu, 30 Oct 2025 04:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOML-0007n5-JD
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOM7-0007Ln-EB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TMTmRK003320;
 Thu, 30 Oct 2025 08:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LXk7mJyyLJ9BwI2/U
 /O3iylvCFbvetP3IPwzpzLcv/Y=; b=VX9oN59AYh9kOrPPZzC3ORSk2kT7sUwN+
 cfgjwMPZI5S6B+OKSxC/nDRSc3QdfLiwVEo7HutK+bgBnWioITgq8BjZqHdufbA4
 CLA5xej380DpOwXLvnQuJbcl3q4SqYq3uaqt+LlYtzma7Qpc/CVejBHxSpDlm1h9
 90hbjvmeL0Qm377hlG7L9xyn3n8JN5QsMV6mLLbjIiYrQhQbYdP41KuKHsRmypll
 cy6ptdmHbf6ar50RkAUaw7k9WclaB+1gteAKAxgIvQmjw2+nJJqAQgc/Tb38nKTJ
 OUAjLKx5X0iack7lovfID8Ym8cRQvY/g/70N0J57Gc+jjPmzYwE3w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8qfun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:50:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U62LaL023869;
 Thu, 30 Oct 2025 08:49:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx7qxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:49:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8ntVu20185794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:49:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3509D2004B;
 Thu, 30 Oct 2025 08:49:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4939620040;
 Thu, 30 Oct 2025 08:49:54 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:49:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/10] hw/ppc: Fix missing return on allocation failure
Date: Thu, 30 Oct 2025 14:19:32 +0530
Message-ID: <20251030084936.1132417-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251030084936.1132417-1-harshpb@linux.ibm.com>
References: <20251030084936.1132417-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=690326b8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=0l1uXLPVePXNSSnF3h4A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: VXfYoR7ktmtl8f0tnROw7WhdRjtrnP8a
X-Proofpoint-ORIG-GUID: VXfYoR7ktmtl8f0tnROw7WhdRjtrnP8a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXyiA/o7mHD50W
 m0TmpkQBaTt8A1j99WNRnpClKpujMBBBU3qmjVjZEQqbVlD8raUMRf5D1Uunq9CTQxh7+8WgAoA
 3aVxisMflMe0bD0yWPbGF1trrdXIu2ATEmxYV7vRSRY6VvoAb5S4TYpoLqLpV0nH3lCCb6kPb0R
 bUEIBhJBP7BlPU4iCiANQX8w+fQyY4Ht6M5Gh2LTeO3aE4BrMcB9OLK/Oeo3XKpcUfVUMMnmB7k
 kYuQ8KqrWSlwPr20KEMPWBS1yJR+5N/lKDfvExWbZWBPHPi2vykGKrcWVQ7lAnU+KuYeMWo32z2
 QF7WEVdLkR67QGBvUAEeGsNu7jZwLIkAhPooiHHeLuJhcsfJkk/734xY8CfY8DZ6y3NKUDsQbQc
 HEOBoURrsaq0Q3qtrIt8LqlgSNoGYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Fixes coverity (CID 1642026)

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20251028080551.92722-2-shivangu@linux.ibm.com
Message-ID: <20251028080551.92722-2-shivangu@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index fa3aeac94c..883a60cdcf 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -234,6 +234,7 @@ static bool do_preserve_region(FadumpSection *region)
         qemu_log_mask(LOG_GUEST_ERROR,
             "FADump: Failed allocating memory (size: %zu) for copying"
             " reserved memory regions\n", FADUMP_CHUNK_SIZE);
+        return false;
     }
 
     num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);
-- 
2.43.5


