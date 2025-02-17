Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BCFC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvQa-0001NU-FG; Mon, 17 Feb 2025 02:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQK-00018v-58; Mon, 17 Feb 2025 02:20:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQI-000331-96; Mon, 17 Feb 2025 02:20:11 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GHvKc7032695;
 Mon, 17 Feb 2025 07:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=adBYsQsQWRqFnYk0f
 +THBCOSWhZrn3RbPVoZE2cbUWA=; b=XoRA0lxeTPs2SBU0W3Ojxe8BGUJstQur/
 DLUyVF9d7wWwoqB3YgCj5DUHTnY4BTf8991SyoqdHQvReMOc209ET1s6x9NEuUwq
 VJ7c9s5cesk2XbPTfAmalKylvaffc+4AJr5j+8VdP07MbFeLdTRW9QbvgXnclFFP
 RT+iqot+eivz5UOl4XiHVoWZMCpTpZ5aREE+Xs+O9DBq3PCf5uqPi0vczQrKoo7x
 I3UsHpwpDW3LUKIo93V5ZC5hQvZuCiKjmxBjBAZEpPVSlt2FSfaoGmpMsGjva63P
 6czuOkEj4euTiZvbN4TvPXFgSbFdLRg7LZsxCH/A1R9kp3Nm8f78g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ujutjna1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:20:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7I2bk019775;
 Mon, 17 Feb 2025 07:20:08 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ujutjn9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:20:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H65iwf024844;
 Mon, 17 Feb 2025 07:20:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7y1cmrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:20:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7K36e47251900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:20:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D35D42004E;
 Mon, 17 Feb 2025 07:20:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77F052004B;
 Mon, 17 Feb 2025 07:19:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:19:51 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 5/7] hw/ppc: Preserve Memory Regions as per MDST/MDDT tables
Date: Mon, 17 Feb 2025 12:49:32 +0530
Message-ID: <20250217071934.86131-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217071934.86131-1-adityag@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MymzkJHbb2ogkKB_PGepZQCw6Q6YmNd7
X-Proofpoint-GUID: gpRa-Ee8ui76RuS_MDzVlmw-_faZEKXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=965
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170060
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

When MPIPL is used, OPAL/Linux registers memory regions to be preserved
on a Memory-Preserving boot ('crashkernel boot').

The regions are added to two tables: MDST and MDDT (source and
destination tables)

The MDST contains the start address of the region, and size of region

The MDDT contains the destination address where the region should be
copied (and size of region which will be same as in MDST entry)

Then after a crash, when hostboot (pnv_sbe.c in case of QEMU)
preserves the memory region, it adds the details of preserved regions to
MDRT (results table)

Copy memory regions mentioned in MDST to addresses mentioned in MDDT.
And accordingly update the copied region details in MDRT table.

Note: If we did not preserve the regions, and MDRT is empty then OPAL
simply logs "OPAL dump is not available", while kernel will assume that
firmware would have preserved the regions, and export /proc/vmcore, but
the vmcore won't have most basic kernel structures hence crash will be
unable to analyse the vmcore

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 361a3854307d..ee905df4e0a6 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -227,6 +227,60 @@ static uint64_t pnv_sbe_power9_xscom_ctrl_read(void *opaque, hwaddr addr,
     return val;
 }
 
+static void pnv_mpipl_preserve_mem(void)
+{
+    /* Get access to metadata */
+    struct mpipl_metadata *metadata = malloc(DUMP_METADATA_AREA_SIZE);
+    struct mdst_table *mdst = malloc(MDST_TABLE_SIZE);
+    struct mddt_table *mddt = malloc(MDDT_TABLE_SIZE);
+    struct mdrt_table *mdrt = malloc(MDRT_TABLE_SIZE);
+    __be64 source_addr, dest_addr, bytes_to_copy;
+    uint8_t *copy_buffer;
+
+    cpu_physical_memory_read(DUMP_METADATA_AREA_BASE, metadata, DUMP_METADATA_AREA_SIZE);
+    cpu_physical_memory_read(MDST_TABLE_BASE, mdst, MDST_TABLE_SIZE);
+    cpu_physical_memory_read(MDDT_TABLE_BASE, mddt, MDDT_TABLE_SIZE);
+
+    /* HRMOR_BIT copied from skiboot */
+    #define HRMOR_BIT (1ul << 63)
+
+    for (int i = 0;; ++i) {
+        /* NOTE: Assuming uninitialised will be all zeroes */
+        if ((mdst[i].addr == 0) && (mdst[i].size == 0)) {
+            break;
+        }
+
+        if (mdst[i].size != mddt[i].size) {
+            qemu_log_mask(LOG_TRACE,
+                    "Warning: Invalid entry, size mismatch in MDST & MDDT\n");
+            continue;
+        }
+
+        if (mdst[i].data_region != mddt[i].data_region) {
+            qemu_log_mask(LOG_TRACE,
+                    "Warning: Invalid entry, region mismatch in MDST & MDDT\n");
+            continue;
+        }
+
+        mdrt[i].src_addr = mdst[i].addr;
+        mdrt[i].dest_addr = mddt[i].addr;
+        mdrt[i].size = mdst[i].size;
+        mdrt[i].data_region = mdst[i].data_region;
+
+        source_addr = cpu_to_be64(mdst[i].addr) & ~HRMOR_BIT;
+        dest_addr = cpu_to_be64(mddt[i].addr) & ~HRMOR_BIT;
+        bytes_to_copy = cpu_to_be32(mddt[i].size);
+
+        /* XXX: Am i assuming we are in big endian mode ? */
+        copy_buffer = malloc(bytes_to_copy);
+        cpu_physical_memory_read(source_addr, copy_buffer, bytes_to_copy);
+        cpu_physical_memory_write(dest_addr,  copy_buffer, bytes_to_copy);
+        free(copy_buffer);
+    }
+
+    cpu_physical_memory_write(MDRT_TABLE_BASE, mdrt, MDRT_TABLE_SIZE);
+}
+
 static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
                                        uint64_t val, unsigned size)
 {
@@ -250,6 +304,9 @@ static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
              */
             pause_all_vcpus();
 
+            /* Preserve the memory locations registered for MPIPL */
+            pnv_mpipl_preserve_mem();
+
             /*
              * TODO: Pass `mpipl` node in device tree to signify next
              * boot is an MPIPL boot
-- 
2.48.1


