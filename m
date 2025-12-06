Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D36D374BD
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 05:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRlJg-0004Fo-Lu; Sat, 06 Dec 2025 00:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJX-0004Ba-Da; Sat, 06 Dec 2025 00:58:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJW-0005Yq-1x; Sat, 06 Dec 2025 00:58:39 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B60Oxhw027421;
 Sat, 6 Dec 2025 05:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wLctdVdz23RHi6EBM
 uEsjZPOv8PROCGZwAcs6GsBiBo=; b=mKH4fFSalPD38/9byyedRWhLRBVjCv178
 n49sV+8q52a4sr3os87ijBAQPKAEVtBfxtMoeW24bo3/P8BnZNW7uhr47A27eZy/
 e+jMEW5Z4qEDVyOIeJEqRFq0TvWMniL9dLni0RbFu5OWyrbUMhMYf8Tt+yb7YUeq
 NJKI5CnftjzvXXFrhiQDdEM8XnjmoPd7Q8EkUxHtOOoWBsp5KGWIBeb9oWUE95Cb
 rZ8HJ73EtCEpmiRg6BQBCvo9u//mffQ/lsIU5uZmeh9SKPYzj8HPvZnCpaC2D8wS
 ysMOTIVbkUPSV/gxPlqKR4pJxSx51GhivHXJ31zrCV4fU3qqG9/Hg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wv8r28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B619EL8024045;
 Sat, 6 Dec 2025 05:58:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5t152a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B65wWeF61407520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Dec 2025 05:58:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C82320043;
 Sat,  6 Dec 2025 05:58:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D200E20040;
 Sat,  6 Dec 2025 05:58:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.93]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Dec 2025 05:58:29 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 6/9] pnv/mpipl: Set thread entry size to be allocated by
 firmware
Date: Sat,  6 Dec 2025 11:26:45 +0530
Message-ID: <20251206055648.1908734-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206055648.1908734-1-adityag@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CLoV9n_qqLOzfu_IE6BxJJz5uglsFKyr
X-Proofpoint-ORIG-GUID: CLoV9n_qqLOzfu_IE6BxJJz5uglsFKyr
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6933c60c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=x2nWBmqi6rLqIJY0GGYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX6lNZa20VrzXu
 xmoysbwgM0QU59qi0XzSgtZC+P3LxIgqKtqNzGh0tnE3i3wATuQmkHZXdz8T1O6/lllYMRD2RQW
 Sx5CmQoypVsv3JnKHt9KCSqLMbRIQ8PrvLngZAX8lbZrZXQyxT0DzOSfngtGDr7WPXTUbWtGcOG
 5+hOK5mzBesaT7jJxbLYZOu9u0gtykeq3n1s7yY+x6mzTEKSSTKtmHP2ggHweCmq/C2vZzl1ZVQ
 PPNb5DHTxpBk+Gvw6FajolMc5tqcg2gt4nhqZTi0xKOeHSau1PsGpATYCfzjVbDqS/9zphkhvFS
 MAMppQnfOM7muGRbx3HPmDSdsLxzJINezY4Wjixj2MLvEwU9+Hu+FuSkLxkS01dl6PdBFhVJtod
 3RfOPpR0SoudxUhkpetcSmx0jvc3lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Set the "Thread Register State Entry Size" that is required by firmware
(OPAL), to know size of memory to allocate to capture CPU state, in the
event of a crash

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 895132da91bd..643558f374e9 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -780,6 +780,30 @@ static void pnv_reset(MachineState *machine, ResetType type)
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
2.52.0


