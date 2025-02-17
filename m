Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8873DC021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvNr-0004Wf-AV; Mon, 17 Feb 2025 02:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvNj-0004Th-IZ; Mon, 17 Feb 2025 02:17:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvNh-0002gI-Ob; Mon, 17 Feb 2025 02:17:31 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H6mxvV026227;
 Mon, 17 Feb 2025 07:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XeV7RlNha/bpAUkWb
 Lq2yw27k4/3R75BfeIhsPRUnqA=; b=IKm4pMfvflbgop0MqSSH/eFFNvEdNaWSZ
 7Qc5JNH3mBnKiGgQLLCp0r+b+NP1v+jRjaoh8de/S0M2EiccHaxef19BCa5Xpglm
 p3FJsvBLgiuHZuKFKjnpKLbdsljP5QksPzRwYFMHdau33SjcI/oTflCDVr77r7ii
 XXuFhyk6Qvmjtg6xvifOrP70IneHikgMmdMkvlRA5+iB7MA4ElyXofYCQsLuWifO
 47otF8sK9hY0XH+Vh8IioZA8JAHhEmXlyEu77Vl7S12KB4d7cm4K15j7McEIGn95
 Co4JeZXOvxC0EPCBhCIPslIekLZkICK8tZyIHqhNJODaX2rDD78WA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ubqnuy2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7FGcS023195;
 Mon, 17 Feb 2025 07:17:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ubqnuy2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H4ZJ5u032339;
 Mon, 17 Feb 2025 07:17:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u6rkmvby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7HNRI38928720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:17:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49B112004B;
 Mon, 17 Feb 2025 07:17:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B477520049;
 Mon, 17 Feb 2025 07:17:21 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:17:21 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 5/6] hw/ppc: Pass device tree properties for Fadump
Date: Mon, 17 Feb 2025 12:47:10 +0530
Message-ID: <20250217071711.83735-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217071711.83735-1-adityag@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IhqukYIsxD7AJhwYLZOTV0pfFK_YzlUx
X-Proofpoint-ORIG-GUID: sLpvYVD9XK-4KA7uY0aOyqCde1sPTD1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502170060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

  * "ibm,configure-kernel-dump": RTAS call for fadump
  * "ibm,configure-kernel-dump-sizes": Space required to store dump data
    for firmware provided dump sections (ie. CPU & HPTE regions)
  * "ibm,configure-kernel-dump-version": Versions of fadump supported
  * "ibm,kernel-dump": Contains the Fadump Memory Structure on a fadump
    boot

Implement passing configure-kernel-dump-sizes, and
configure-kernel-dump-version device tree properties, irrespective of
whether it's a fadump boot or not, so that kernel can reserve memory to
store the firmware provided dump sections in case of a crash

Also, in case of a fadump boot, pass the fadump memory structure to the
kernel in "ibm,kernel-dump" device tree property.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr.c         | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  2 ++
 2 files changed, 64 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f3a4b4235d43..3602e5b5d18d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -897,9 +897,27 @@ static int spapr_dt_rng(void *fdt)
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
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
     uint32_t lrdr_capacity[] = {
         0,
         0,
@@ -1006,6 +1024,50 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
+    /*
+     * CPU State Data contains multiple fields such as header, num_cpus and
+     * register entries
+     *
+     * Calculate the maximum CPU State Data size, according to maximum
+     * possible CPUs the QEMU VM can have
+     */
+    /* Reg save header */
+    fadump_cpu_state_size += sizeof(struct rtas_fadump_reg_save_area_header);
+
+    /* Num_cpus */
+    fadump_cpu_state_size += sizeof(__be32);
+
+    /* Register Entries */
+    fadump_cpu_state_size += max_possible_cpus   *
+                             FADUMP_NUM_PER_CPU_REGS *
+                             sizeof(struct rtas_fadump_reg_entry);
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
+
+    if (is_next_boot_fadump) {
+        struct rtas_fadump_mem_struct *fdm =
+            &fadump_metadata.registered_fdm;
+
+        uint64_t fdm_size =
+            sizeof(struct rtas_fadump_section_header) +
+            (be16_to_cpu(fdm->header.dump_num_sections) *
+            sizeof(struct rtas_fadump_section));
+
+        _FDT((fdt_setprop(fdt, rtas, "ibm,kernel-dump", fdm, fdm_size)));
+    }
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0e8002bad9e0..fa63008e57ec 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -928,6 +928,8 @@ static inline uint64_t fadump_gpr_id_to_u64(uint32_t gpr_id)
     return val;
 }
 
+extern bool is_next_boot_fadump;
+
 struct fadump_metadata {
     bool fadump_registered;
     bool fadump_dump_active;
-- 
2.48.1


