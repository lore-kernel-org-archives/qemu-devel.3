Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65697FD3758
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEIF-0007KY-P4; Wed, 25 Feb 2026 07:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEIE-0007Jy-9k; Wed, 25 Feb 2026 07:47:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEIC-0002Gv-Nh; Wed, 25 Feb 2026 07:47:05 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61P4QA4n3340480; Wed, 25 Feb 2026 12:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HI2RUMXHyfPDdx3b4
 vtQ4icfs2E5dIlCYD5CULjIdUk=; b=jCGcv5k/zvCDZ5WRotZgTf0lM78BKaAcp
 hIRgpASqUZi3RVVnhWjCXgud1LtHy12vahgu3RMI7NkGYRq/TVbSCH07RbSsjHAx
 KcwzFLYMxXfjorgvI/hBS64lwMOqaGWNAOaBqnd0Gz5UtSzd8Bvr4r5M8ZZxyBhB
 pp80/hL5j1ba/JPS5BDE0UjcMxtPxrhNVJh1d/y/O4GXkX2fWFKuqA0HFeiDUAyl
 EQVed1LrmLKS5pSugtGawzbyAIM2QmvA3PLKyYviaimDGRPkeqff7DfShU6qhY69
 cS0s3kyHEIP+8Kx4p1tlTB9csRlVvt56JS5XWneMPId1ucO4TrwdQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c7gq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:47:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PCF9xJ013419;
 Wed, 25 Feb 2026 12:47:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy5d58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:47:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61PCkwp943254254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 12:46:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ECBA20043;
 Wed, 25 Feb 2026 12:46:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2281520040;
 Wed, 25 Feb 2026 12:46:55 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.235])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 12:46:54 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v3 06/10] pnv/mpipl: Set thread entry size to be allocated by
 firmware
Date: Wed, 25 Feb 2026 18:16:28 +0530
Message-ID: <20260225124633.1841222-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225124633.1841222-1-adityag@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX7O0+GzUlP7gx
 gJE6+BN0eePX0p8aYSpUskyCrmPXQQeLqCcZs/Ms5q0XcMRpchLuc96692IvIL4Z9LiJef9SPZT
 BUrDc7RqDb7q4YO4E6RkVI7E2a6K4Q7fSYw/0l29FOb5lGEYzGhZ+JSoSHa2RJuNLAlUjV63zV3
 gl8ZsB208naH0C54w+EumILYZ49yUQrnWyZu6pS278lBJb/oVaYTuXjwtmUmEpE+7tOir1szCFH
 TTFZtwu9hAX6h2WrGoXnPmJsc1DsCqbLUNMlPHDRXZN7iVYm8TJbHz4T01PYW9OXIS3/LbXLHrf
 cqrkDXtvbH94U6Fsz3jvHIfFQGI9VNZ+Ckj2aiiDZDuRJPHXaM66unoFfLQbR9OVVenx6TvLE/x
 MyrV2w8NGoPFyUGvYX1MPSqX5pZHSl159lajAO97DrJoMf7i23+vAkbk6UJQ/VuP31yYc2SL+Ps
 0dEqlouravXaX2GIG6A==
X-Proofpoint-ORIG-GUID: EuU_yIlstYf0dygmR2XaiEBt8SqVKykL
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699eef47 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=x2nWBmqi6rLqIJY0GGYA:9
X-Proofpoint-GUID: j9YPiLn_gY8J4Z7KMrycGGturH9l61pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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


