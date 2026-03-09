Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBD6EF36F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUun-0006Nd-V2; Mon, 09 Mar 2026 03:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUum-0006M7-IN; Mon, 09 Mar 2026 03:20:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUul-0006DZ-1t; Mon, 09 Mar 2026 03:20:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628Jj6581561657; Mon, 9 Mar 2026 07:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KDNKF3RXtxUcBaU1z
 EVwzfQj+RyanbyR+5WGtctHqT4=; b=UVeJ24/85/3kiLiGyfzrp2Dhri1Vx5iVN
 YkoD1rb4PID4iZkhta/UGORXWfeUAdBxvwWLJcba7Ua+iMpcKKvKTs6aymqVTdzy
 iD86j/4t6CuzqSv+CHNkKvucfKU3jZTyw5oYreM5KXRWDM8glqoZWUvzidGas7NL
 dMMLc0mMeuxRX1dOGhpAyyNpxMZd60Z0IpKPfuirsSc+O2OEoS8GP7S89ih3gfCa
 2iTO2JtLZ4REdmCZyvTfsJ3Yu5DkRHKI03XnUUyJKAC5rK6z0VnFOP7/mnGLT4RV
 bHxFvvDM0/lH2W+tSOHiRoRewzmGjigVAcamasozXse/OSzJzi3Dg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm5h2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6293JFfi029356;
 Mon, 9 Mar 2026 07:20:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6ugm1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6297KN7S29164042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 07:20:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCE9D20043;
 Mon,  9 Mar 2026 07:20:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7AA92004D;
 Mon,  9 Mar 2026 07:20:21 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 07:20:21 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v4 06/10] pnv/mpipl: Set thread entry size to be allocated by
 firmware
Date: Mon,  9 Mar 2026 12:49:55 +0530
Message-ID: <20260309072001.3136261-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309072001.3136261-1-adityag@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: jxz9SXy1z4zBWpK0pSRLxQnzJ6hHoDYk
X-Proofpoint-ORIG-GUID: Q5cD5FJI33rO8FyGklMFfjVRMQNaC7Or
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfXypbU+HiqHexA
 f1BhuyOS5LOs5e9qSvhNy+dBup1zDzlMzAVeQn4O664eRszVuvjUqjhUbrPez4yMjOcFL8uwByG
 uctAMYf879RTg7ZSlfity79LsTAcePAhp2rqX2Q6f0EycNQ/NJ79UXr+rfY3UCtuxuDwG/pOLVI
 XG5UMFGIP9RIVHyJk81sQZxLBvUrqoQG8FJoorFowuHBrLxkyZmuFF+/ynif+3nKk9Xcz/eizWR
 EDIU61dSZsI0pGHeLg7ljDJ4Z8DQ4E8BN04UXqLROEueF3WVFGI+5eHjbFhkQUfwzReVmfKFuyL
 YKA0LXtPduVxoW1tuSoaZHP9S+3qnvGyUsyCSqABDey5nEJZz+ZjhAEJhu5P3rTTriiWk+pT3z1
 fQDOzbeANaEkCkesqQc0hyRBqiZZrNICT4dQDUOEy+7RY1v7mrZ3Q6ilyApqHinP7QISBGHdr3z
 mlqk9ysfTb2s47f1P4g==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69ae74bd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=x2nWBmqi6rLqIJY0GGYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Set the "Thread Register State Entry Size" that is required by firmware
(OPAL), to know size of memory to allocate to capture CPU state, in the
event of a crash

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1513575b8f37..3038b1626c54 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -781,6 +781,30 @@ static void pnv_reset(MachineState *machine, ResetType type)
         _FDT((fdt_pack(fdt)));
     }
 
+    if (!pnv->mpipl_state.is_next_boot_mpipl) {
+        /*
+         * Set the "Thread Register State Entry Size", so that firmware can
+         * allocate enough memory to capture CPU state in the event of a
+         * crash
+         */
+
+        MpiplProcDumpArea proc_area;
+
+        proc_area.version = PROC_DUMP_AREA_VERSION_P9;
+        proc_area.thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
+
+        /* These are to be allocated & assigned by the firmware */
+        proc_area.alloc_addr = 0;
+        proc_area.alloc_size = 0;
+
+        /* These get assigned after crash, when QEMU preserves the registers */
+        proc_area.dest_addr = 0;
+        proc_area.act_size = 0;
+
+        cpu_physical_memory_write(PROC_DUMP_AREA_OFF, &proc_area,
+                sizeof(proc_area));
+    }
+
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 
     /* Update machine->fdt with latest fdt */
-- 
2.53.0


