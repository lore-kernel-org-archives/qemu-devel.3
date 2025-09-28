Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFC2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3b-00033i-Um; Sun, 28 Sep 2025 15:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3Y-00032C-Ob
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3I-00047G-9F
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SIlIOe032112
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=O6w2275zp6vCl7hRW
 dMteVvnMr1AljSQGuFkvAaUCvs=; b=m8x3VJGfuULKVyYdrWRmfRmmRtqQKTnH/
 Un3FG/R8iQqzd7KBU7GmQi6UWhmzIj+6dPgjOFPXjb9hmJA7cU2EhOnfopah58YK
 O6bZtoNWc5zaK5wm9NN2A6RdPmFIopiwAYnAHHN0HgprxwCrLTrcA/KHSyKJ31ks
 WombhxoDT+hcRmYrhln3qdS4UoAiAOqb3qiSZqyq406AboX4LTiCrys56Q8BjJBH
 j/AF+fQoT2qQxVI+28f/OrpDisSuGfCL5AtsrSNV7/5kk8khoN4K3ettxgFAyVyF
 7MfRnB/WUvGK94Hu2uOS3xlY9cUIvOU0Eelcc7XaN7q6r+RKR/QMg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jw6ev9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SIXE09007331
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurjjsbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJR6Xm26018118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9E0720049;
 Sun, 28 Sep 2025 19:27:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B329920040;
 Sun, 28 Sep 2025 19:27:04 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:27:04 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Batra <gbatra@us.ibm.com>, David Christensen <drc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: [PULL 19/27] ppc/spapr: init lrdr-capapcity phys with ram size if
 maxmem not provided
Date: Mon, 29 Sep 2025 00:56:21 +0530
Message-ID: <20250928192629.139822-20-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXw8JlCVHkbbTO
 QIgNwHFNOmtDMQbMgg9p7XMg1Z/dq81zQBdU6u29xlM5tFS5MUfqiQws3KJH9+EQ6mhe6hWZKKg
 Um/lnIJhj41FD+zkdrMCbjP/H9j4LquwCbTj5AgYLBKgOGqKVbruLBc5TPT+wczDNgZL7BM1cyn
 Ff+qEbSIF7JKPWbrlJ3t9ApMDa0eIPZkmWNo+n8bUyB4WvrWQ+Vy+XV55JUOn/304PTj35o3myS
 v2sBZ/VTf6Xy1b5I928VbJjQgSDOxPEMB73fwlChdFjKS8VMVEWBv6XHL/3+SDf0GCeKHiFnZTd
 C8vDlkvG8aEtoiWBLdkM6psoCYcTcjAZw8jnfygJzemtjKbbb1Fbd1L0NBGdVtMW7B0jONkg5GK
 bh7swKs9uVvry3FGMRlJhhOm2hpUXw==
X-Proofpoint-ORIG-GUID: f9DqrlbqZcGEBsPPPAPEg6uN4K8bDQj8
X-Proofpoint-GUID: f9DqrlbqZcGEBsPPPAPEg6uN4K8bDQj8
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68d98c0f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=lvduwxc082U5sw0zugYA:9 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

lrdr-capacity contains phys field which communicates the maximum address
in bytes and therefore, the most memory that can be allocated to this
partition. This is usually populated when maxmem is provided alongwith
memory size on qemu command line. However since maxmem is an optional
param, this leads to bits being set to 0 in absence of maxmem param.
Fix this by initializing the respective bits as per total mem size in
such case.

Reported-by: Gaurav Batra <gbatra@us.ibm.com>
Tested-by: David Christensen <drc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Link: https://lore.kernel.org/r/20250506042903.76250-1-harshpb@linux.ibm.com
Message-ID: <20250506042903.76250-1-harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index eb22333404..82fb23beaa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -907,6 +907,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
+    uint64_t max_device_addr = 0;
     uint32_t lrdr_capacity[] = {
         0,
         0,
@@ -917,13 +918,15 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 
     /* Do we have device memory? */
     if (MACHINE(spapr)->device_memory) {
-        uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
+        max_device_addr = MACHINE(spapr)->device_memory->base +
             memory_region_size(&MACHINE(spapr)->device_memory->mr);
-
-        lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
-        lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
+    } else if (ms->ram_size == ms->maxram_size) {
+        max_device_addr = ms->ram_size;
     }
 
+    lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
+    lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
+
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
     /* hypertas */
-- 
2.43.5


