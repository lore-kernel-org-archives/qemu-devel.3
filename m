Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60909CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCjT-000299-T8; Tue, 21 Oct 2025 09:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBCjR-00027d-TY; Tue, 21 Oct 2025 09:48:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBCjP-0006ph-OM; Tue, 21 Oct 2025 09:48:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8ZNxQ030688;
 Tue, 21 Oct 2025 13:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ulOpTvTsBjLYGJDHU
 aXtWnx4/7REEYR7kCTY5v+4j2w=; b=UbMqPucB4aGpQHm4REeWouFZvuG1tc4Eh
 IeqoqNTC5sfKNWHwCLbsS6/UOFGbXey0C6BE4ulcZ/4Idy4kzmii9TkQOy7/FlMJ
 RUxnuVtwb7u2gcyA+s4k1fM2Zbkiy4+tJPh0m7U/BwcFi5v2TM+Nb0Br4TTVWnk8
 ClxlZEL/b3TMrBdBQyAjNxtFlYzTbdLkra/EptjDpHeHl18EOwPHlGwkEaulGr/0
 ZF/O++vlbvMVi613pCwlD3KUtLV7LheSb2Tk24K5EegBwRNbO0nCzMbfFOsbfv1K
 ftbZ3W+bMnC0ebvZjWbtVxe3CP0uftAtYcKx9ZKDBhPi9tIjCtl8Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31ryar0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LDmqFG022534;
 Tue, 21 Oct 2025 13:48:52 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31ryaqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LBOY9J014676;
 Tue, 21 Oct 2025 13:48:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s3767-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LDmmND51184048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 13:48:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DE152004E;
 Tue, 21 Oct 2025 13:48:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DB4320043;
 Tue, 21 Oct 2025 13:48:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.222.96]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 13:48:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 5/8] hw/ppc: Pass dump-sizes property for fadump in device
 tree
Date: Tue, 21 Oct 2025 19:18:15 +0530
Message-ID: <20251021134823.1861675-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021134823.1861675-1-adityag@linux.ibm.com>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cuKwMAZ758wLr7fxo6QlGiaICqGWcOWS
X-Proofpoint-GUID: oh1zgMwsP4b8qFbZuH8kKTTnfqcg4KgC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7hUvcvOfQ4P4
 XT11pNa9ZfMDEYOoXQtnaDfygZtnYVAFjlstiB1leNMwWtCQFoY4SNg4Min1PrRgkVBk4fcEhwS
 vxc8FT51O4+8wkI3S0ZQUzJOYFc0EWP5CI8EQsbZVD/EpPKWtxmSf/PQXQYc4A+g7i4Nm1NyI1g
 eHX8FKyK+IJe3RrOK3bWMzzdVMeYNnCZ0oT2cpWnhE8HJzrGoi6qgo8xDmaRiPhN6pkmwVJQa6D
 7SzVYz9snzQa+e7W9hLQA48brvEtBQyTK6D2IM2cQt0EX9bNIAaDKqUirjbfQPVXKXwplejklIN
 BW0TuDepp94bLKmX1psrqsDgayD81E4/2A8k5ZVcydxz71rajrqnswxo3SG1VVuv47UwDOZNBRW
 gEVizDYrLs0PSGYNsU236meSpNEmXw==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f78f45 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=fff_gh8wo2OfEAVniKgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Platform (ie. QEMU) is expected to pass few device tree properties for
details for fadump:

  * "ibm,configure-kernel-dump-sizes": Space required to store dump data
    for firmware provided dump sections (ie. CPU & HPTE regions)
  * "ibm,configure-kernel-dump-version": Versions of fadump supported

Pass the above device tree nodes so that kernel can reserve sufficient
space for preserving the CPU state data

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr.c        | 57 +++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_fadump.c |  6 ++---
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97ab6bebd25c..d40d5a9dcde5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -900,6 +900,61 @@ static int spapr_dt_rng(void *fdt)
     return ret ? -1 : 0;
 }
 
+static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
+{
+    MachineState *ms = MACHINE(spapr);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    uint32_t max_possible_cpus = mc->possible_cpu_arch_ids(ms)->len;
+    uint64_t fadump_cpu_state_size = 0;
+    uint16_t fadump_versions[2] = {
+        FADUMP_VERSION /* min supported version */,
+        FADUMP_VERSION /* max supported version */
+    };
+    uint32_t fadump_rgn_sizes[2][3] = {
+        {
+            cpu_to_be32(FADUMP_CPU_STATE_DATA),
+            0, 0 /* Calculated later */
+        },
+        {
+            cpu_to_be32(FADUMP_HPTE_REGION),
+            0, 0 /* HPTE region not implemented */
+        }
+    };
+
+    /*
+     * CPU State Data contains multiple fields such as header, num_cpus and
+     * register entries
+     *
+     * Calculate the maximum CPU State Data size, according to maximum
+     * possible CPUs the QEMU VM can have
+     *
+     * This calculation must match the 'cpu_state_len' calculation done in
+     * 'populate_cpu_state_data' in spapr_fadump.c
+     */
+    fadump_cpu_state_size += sizeof(struct FadumpRegSaveAreaHeader);
+    fadump_cpu_state_size += 0xc;                      /* padding as in PAPR */
+    fadump_cpu_state_size += sizeof(uint32_t);         /* num_cpus */
+    fadump_cpu_state_size += max_possible_cpus   *     /* reg entries */
+                             FADUMP_PER_CPU_REG_ENTRIES *
+                             sizeof(struct FadumpRegEntry);
+
+    /* Set maximum size for CPU state data region */
+    assert(fadump_rgn_sizes[0][0] == cpu_to_be32(FADUMP_CPU_STATE_DATA));
+
+    /* Upper 32 bits of size, usually 0 */
+    fadump_rgn_sizes[0][1] = cpu_to_be32(fadump_cpu_state_size >> 32);
+
+    /* Lower 32 bits of size */
+    fadump_rgn_sizes[0][2] = cpu_to_be32(fadump_cpu_state_size & 0xffffffff);
+
+    /* Add device tree properties required from platform for fadump */
+    _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-version",
+                    fadump_versions, sizeof(fadump_versions))));
+    _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
+                    fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
+}
+
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
@@ -1015,6 +1070,8 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
+    spapr_dt_rtas_fadump(spapr, fdt, rtas);
+
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index fdd49291483e..fa3aeac94cb7 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -492,7 +492,7 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
     *cpu_state_len = 0;
     *cpu_state_len += sizeof(reg_save_hdr);     /* reg save header */
     *cpu_state_len += 0xc;                      /* padding as in PAPR */
-    *cpu_state_len += sizeof(__be32);           /* num_cpus */
+    *cpu_state_len += sizeof(num_cpus);         /* num_cpus */
     *cpu_state_len += reg_entries_size;         /* reg entries */
 
     cpu_state_buffer = g_malloc(*cpu_state_len);
@@ -503,8 +503,8 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
 
     /* Write num_cpus */
     num_cpus = cpu_to_be32(num_cpus);
-    memcpy(cpu_state_buffer + offset, &num_cpus, sizeof(__be32));
-    offset += sizeof(__be32);
+    memcpy(cpu_state_buffer + offset, &num_cpus, sizeof(num_cpus));
+    offset += sizeof(num_cpus);
 
     /* Write the register entries */
     memcpy(cpu_state_buffer + offset, reg_entries, reg_entries_size);
-- 
2.51.0


