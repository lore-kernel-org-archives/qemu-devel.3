Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE62DC36005
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPKa-0003M1-Pc; Sun, 23 Mar 2025 13:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twPJR-0001Kg-4H; Sun, 23 Mar 2025 13:41:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twPJN-0003Sm-24; Sun, 23 Mar 2025 13:40:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N6SiPt028528;
 Sun, 23 Mar 2025 17:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=l02B5MjK75VXtjsJL
 qTHQo7PWJBgjAd0Gxe5ncSkc1A=; b=FONfRPip8Yea+ZOnfOSoJQBJ7uks3+AbC
 yE0JtjHRwBI7zGNeIl1Jz1ljFh+YOdCIgOCOwC6tTgg0am091gUur/iSPBqPDDib
 T5nANmsNg5cBId4svy81d9L6KxDuttg8oQZUi5FeC0bweOtTdZKxT3C9td0xUgZ7
 PnstADKgWifsCg0bUoJlcl6BbBQaSzKrUhuQW7kdopxXMzBnitQrEvrwZ+1fGyl5
 9QeqyVGxRlJoCt5y3Zba0T80zJMnPL8FPt1vPIMxULpuSR+drw152dPRYp5PWEF4
 0DBJeaIghclFQUu8zLrQClX6H9aa4ckiRTjFp2f8jSnkzkKDdjotw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jap9j6qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52NHeYRH014278;
 Sun, 23 Mar 2025 17:40:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jap9j6qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52NHLU0h020001;
 Sun, 23 Mar 2025 17:40:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnjp0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52NHeSKO41157072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Mar 2025 17:40:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD09C20043;
 Sun, 23 Mar 2025 17:40:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 786BF20040;
 Sun, 23 Mar 2025 17:40:26 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.214.162])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Mar 2025 17:40:26 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v4 6/8] hw/ppc: Pass dump-sizes property for fadump in device
 tree
Date: Sun, 23 Mar 2025 23:10:05 +0530
Message-ID: <20250323174007.221116-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323174007.221116-1-adityag@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6hiyLFqKmfmRLJ_we3RM17Fmis32Uq3b
X-Proofpoint-ORIG-GUID: eJM9hhNJW4OKXlZmMORVow9zW-nLJr4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_08,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503230119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 hw/ppc/spapr.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a415e51d077a..3cbc6a7409b7 100644
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
@@ -1012,6 +1067,8 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
+    spapr_dt_rtas_fadump(spapr, fdt, rtas);
+
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
-- 
2.49.0


