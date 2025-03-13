Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F1AC35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoAR-0002yT-R5; Thu, 13 Mar 2025 15:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsoAC-0002uJ-AG; Thu, 13 Mar 2025 15:24:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsoA9-0000uF-3O; Thu, 13 Mar 2025 15:24:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo4rp003361;
 Thu, 13 Mar 2025 19:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ejNpIrZXudvJ/RDzR
 YoZF3epKTAm/W/xoHHPZJvePiQ=; b=eIUZtyMXKMltj+O1K8UgZ4W8JdW/ykfI2
 7qQb2kvt5bM1yeaG9cMi0TxfC64kmIvXAZn2xNpp3utSw980SsKdhqceT7fDNsFb
 ntXZUB/vj6EQSPFaooV/trpRWEToHkrgTNO6y6nTonANaXo/XBprdT8daQZhW0Hc
 3isZZCtsbJXka3T5CBYthjDz+G5+kiHa9q2zH8Tl4YOju/i/hD5CPqcPCrHRbOuF
 6fpaC8lKJ7ZdQ4i+5EPpogJ748I4W+cDMtxOxfSIvkgt45w2EXW7pZpvA6OR5/1C
 ECElNFwVWcccwD3hiKz2PglQjHB6gNtKbS957ylgtMuhUYK/DrZGg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepnw73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:24:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DJM3tu029392;
 Thu, 13 Mar 2025 19:24:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepnw6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:24:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DIoInt026010;
 Thu, 13 Mar 2025 19:24:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspkg2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 19:24:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DJO6XL49414654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 19:24:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10C9220043;
 Thu, 13 Mar 2025 19:24:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A25C120040;
 Thu, 13 Mar 2025 19:24:03 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.223.53]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 19:24:03 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v2 6/8] hw/ppc: Pass dump-sizes property for fadump in device
 tree
Date: Fri, 14 Mar 2025 00:53:39 +0530
Message-ID: <20250313192341.132171-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313192341.132171-1-adityag@linux.ibm.com>
References: <20250313192341.132171-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YwoGyIVvTaOaKuqn2Eduz22GaLX1FxkD
X-Proofpoint-ORIG-GUID: H_6nwwzvtRwjSKdmIxIERN8bJZn5yPhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Platform (ie. QEMU) is expected to pass few device tree properties for
details for fadump:

  * "ibm,configure-kernel-dump-sizes": Space required to store dump data
    for firmware provided dump sections (ie. CPU & HPTE regions)
  * "ibm,configure-kernel-dump-version": Versions of fadump supported

Pass the above device tree nodes so that kernel can reserve sufficient
space for preserving the CPU state data

Note: As of this patch, the "kernel-dump" device tree entry is still not
added for the second boot, so after crash, the second kernel will boot
assuming fadump dump is "NOT" active, and try to register for fadump,
but since we already have fadump registered in QEMU internal state, the
register rtas call will fail with: "DUMP ACTIVE"

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a415e51d077a..dac9e4b3edaa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -900,6 +900,62 @@ static int spapr_dt_rng(void *fdt)
     return ret ? -1 : 0;
 }
 
+static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
+{
+    MachineState *ms = MACHINE(spapr);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    FadumpMemStruct *fdm = &spapr->registered_fdm;
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
+    fadump_cpu_state_size += sizeof(__be32);           /* num_cpus */
+    fadump_cpu_state_size += max_possible_cpus   *     /* reg entries */
+                             FADUMP_NUM_PER_CPU_REGS *
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
@@ -1012,6 +1068,8 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
+    spapr_dt_rtas_fadump(spapr, fdt, rtas);
+
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
-- 
2.48.1


