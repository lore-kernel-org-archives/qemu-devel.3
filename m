Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBE9C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvQF-00016U-0j; Mon, 17 Feb 2025 02:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQB-00014L-FL; Mon, 17 Feb 2025 02:20:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQ7-0002pZ-Tl; Mon, 17 Feb 2025 02:20:03 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H5OItP031818;
 Mon, 17 Feb 2025 07:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q9VJZ9RgtDrYNWKFC
 44lJWZUr97xxWcHOMX96rcJaw0=; b=Pfu2xQby0yNInZWdb4dYffh6wCDeqZHg6
 7lHesE5W+RZIyTzoy3OuTilRKg+7K9ZPv4XJ8r3dIIuvs4vTWpqvjVMg9SxkTqAD
 aqqsgjQ4sg1GAcgIvk/BZT54jr43LsdOQu2eLDa4ifaWv9Z0sEJYRWqF59c1cMNp
 OAc+9mX9CDeMVGAC9gebhM3tz52Oi8wd71n8OZwX6UdSfhSaWMCv52iCr8jCA+2M
 KpapRIwoJkyYZhZhBZ1Do2VqMXysC6/gXhzblkP6zuW3H9GDCQZoauaFx81qWNBj
 nssSdyZBQU8TzHly+y7cLO7Fsz/tj6cVQ8WjVJ+aLn/wLCUshl6jQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7rfec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:56 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7F5fF006121;
 Mon, 17 Feb 2025 07:19:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7rfe7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H4BCv4032435;
 Mon, 17 Feb 2025 07:19:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u6rkmvn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7JpSp59703656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:19:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27C072004D;
 Mon, 17 Feb 2025 07:19:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 489032004B;
 Mon, 17 Feb 2025 07:19:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:19:49 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 4/7] hw/ppc: Add MDST/MDDT/MDRT table structures and offsets
Date: Mon, 17 Feb 2025 12:49:31 +0530
Message-ID: <20250217071934.86131-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217071934.86131-1-adityag@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AAMw5POJWzgvuHWJueigvGTyHie0tNn-
X-Proofpoint-ORIG-GUID: J0RXqs7L38oA89wzl0eimTSQoLFKNbD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add the MDST, MDDT, MDRT tables offsets and structures as per current
skiboot upstream:

    commit bc7b85db1e7e ("opal-ci: Remove centos7")

These structures will be later populated when preserving memory regions
for MPIPL

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 79818177fc36..361a3854307d 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -84,6 +84,119 @@
 
 static uint64_t mpipl_skiboot_base = 0x30000000 /*default SKIBOOT_BASE*/;
 
+/* Following offsets are copied from Skiboot source code */
+/* Use 768 bytes for SPIRAH */
+#define SPIRAH_OFF      0x00010000
+#define SPIRAH_SIZE     0x300
+
+/* Use 256 bytes for processor dump area */
+#define PROC_DUMP_AREA_OFF  (SPIRAH_OFF + SPIRAH_SIZE)
+#define PROC_DUMP_AREA_SIZE 0x100
+
+#define PROCIN_OFF      (PROC_DUMP_AREA_OFF + PROC_DUMP_AREA_SIZE)
+#define PROCIN_SIZE     0x800
+
+/* Offsets of MDST and MDDT tables from skiboot base */
+#define MDST_TABLE_OFF      (PROCIN_OFF + PROCIN_SIZE)
+#define MDST_TABLE_SIZE     0x400
+
+#define MDDT_TABLE_OFF      (MDST_TABLE_OFF + MDST_TABLE_SIZE)
+#define MDDT_TABLE_SIZE     0x400
+
+#define CPU_CTL_OFF         (MDDT_TABLE_OFF + MDDT_TABLE_SIZE)
+#define CPU_CTL_SIZE        0x2000
+
+/* MPIPL reserved regions (offset by skiboot_base to access) */
+#define MDST_TABLE_BASE     (mpipl_skiboot_base + MDST_TABLE_OFF)
+#define MDDT_TABLE_BASE     (mpipl_skiboot_base + MDDT_TABLE_OFF)
+#define PROC_DUMP_AREA_BASE (mpipl_skiboot_base + PROC_DUMP_AREA_OFF)
+
+#define __packed             __attribute__((packed))
+
+/* Metadata to capture before triggering MPIPL */
+struct mpipl_metadata {
+    /* Crashing PIR is required to create OPAL dump */
+    uint32_t    crashing_pir;
+    /* Kernel expects OPAL to presrve tag and pass it back via OPAL API */
+    uint64_t    kernel_tag;
+    /* Post MPIPL kernel boot memory size */
+    uint64_t    boot_mem_size;
+} __packed;
+
+/* Structure version */
+#define OPAL_MPIPL_VERSION  0x01
+
+/* Preserved memory details */
+struct opal_mpipl_region {
+    __be64  src;
+    __be64  dest;
+    __be64  size;
+};
+
+struct opal_mpipl_fadump {
+    uint8_t version;
+    uint8_t reserved[7];
+    __be32  crashing_pir;    /* OPAL crashing CPU PIR */
+    __be32  cpu_data_version;
+    __be32  cpu_data_size;
+    __be32  region_cnt;
+    struct  opal_mpipl_region *region;
+};
+
+/*
+ * This is our dump result table after MPIPL. Hostboot will write to this
+ * memory after moving memory content from source to destination memory.
+ */
+#define MDRT_TABLE_BASE        (mpipl_skiboot_base + 0x01c00000)
+#define MDRT_TABLE_SIZE        0x00008000
+
+/*
+ * This is our dump metadata area. We will use this memory to save metadata
+ * (like crashing CPU details, payload tags) before triggering MPIPL.
+ */
+#define DUMP_METADATA_AREA_BASE    (mpipl_skiboot_base + 0x01c08000)
+#define DUMP_METADATA_AREA_SIZE    0x8000
+
+/*
+ *  Memory Dump Source Table
+ *
+ * Format of this table is same as Memory Dump Source Table (MDST)
+ * defined in HDAT spec.
+ */
+struct mdst_table {
+    __be64  addr;
+    uint8_t data_region;    /* DUMP_REGION_* */
+    uint8_t dump_type;    /* DUMP_TYPE_* */
+    __be16  reserved;
+    __be32  size;
+} __packed;
+
+/* Memory dump destination table (MDDT) */
+struct mddt_table {
+    __be64  addr;
+    uint8_t data_region;
+    uint8_t dump_type;
+    __be16  reserved;
+    __be32  size;
+} __packed;
+
+/*
+ * Memory dump result table (MDRT)
+ *
+ * List of the memory ranges that have been included in the dump. This table is
+ * filled by hostboot and passed to OPAL on second boot. OPAL/payload will use
+ * this table to extract the dump.
+ */
+struct mdrt_table {
+    __be64  src_addr;
+    __be64  dest_addr;
+    uint8_t data_region;
+    uint8_t dump_type;  /* unused */
+    __be16  reserved;   /* unused */
+    __be32  size;
+    __be64  padding;    /* unused */
+} __packed;
+
 static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
 {
     val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
-- 
2.48.1


