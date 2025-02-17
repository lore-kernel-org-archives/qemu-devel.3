Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA31C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvQb-0001TZ-NJ; Mon, 17 Feb 2025 02:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQM-0001B5-GV; Mon, 17 Feb 2025 02:20:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQK-00033F-PI; Mon, 17 Feb 2025 02:20:14 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H20t2C012681;
 Mon, 17 Feb 2025 07:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JwbzxxR8TcOzCT6Rg
 IdjCizMgloMk2G9W/oXK+A7Qx8=; b=ld2G4ECN4z7O1f+EaJBPYax/MZX/IJ1AA
 YIJkRqlgvWRHSKWt4gAAZamNnIYNp+/o3z/dxGJ5NeGDaCZkLgNSp3etjSjWAGhO
 zaOand0NVUFTe+BFAgUyQeNndVBUkRV2uUdl3DFOHCHgvxlyEIYa8NzdiL1ernYm
 OUm7U3M1jYS+CyfExHbvL8fSjJyDAaNlHoZzoo5oAjrBTeteHY0GlY6sudx3H022
 2Y9tdY9EolQ3jJCQ6nfk9ZPAq6JiHJ/+44nuuA903bAmJPTgyCbGL9j+Q0sAIF9D
 Ma8zuSLPqlNpXZITV+CFMlY/42EaD7cGz2iHdzpw6dEluXnQU+syw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uuy013fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:20:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7KA6G001337;
 Mon, 17 Feb 2025 07:20:10 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uuy013fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:20:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H355da008164;
 Mon, 17 Feb 2025 07:20:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u58td564-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:20:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7K62n18153734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:20:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84C412004B;
 Mon, 17 Feb 2025 07:20:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23B4920049;
 Mon, 17 Feb 2025 07:20:04 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:20:03 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 6/7] hw/ppc: [WIP] Add Processor Dump Area offsets in Pnv SBE
Date: Mon, 17 Feb 2025 12:49:33 +0530
Message-ID: <20250217071934.86131-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217071934.86131-1-adityag@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9VEKD1YGXvX1zODFPLCBCMytXUpCuLTH
X-Proofpoint-ORIG-GUID: tdd1AkAS_i-Y-oHqldm4T1IMMD3LPk8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=922 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add offsets for the processor state captured during MPIPL dump.

This is incomplete. And might be implemented in future if the effort to
implement MPIPL is resumed again.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index ee905df4e0a6..3b50667226b5 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -197,6 +197,25 @@ struct mdrt_table {
     __be64  padding;    /* unused */
 } __packed;
 
+/*
+ * Processor Dump Area
+ *
+ * This contains the information needed for having processor
+ * state captured during a platform dump.
+ */
+struct proc_dump_area {
+    __be32  thread_size;    /* Size of each thread register entry */
+#define PROC_DUMP_AREA_FORMAT_P9    0x1    /* P9 format */
+    uint8_t version;
+    uint8_t reserved[11];
+    __be64  alloc_addr;    /* Destination memory to place register data */
+    __be32  reserved2;
+    __be32  alloc_size;    /* Allocated size */
+    __be64  dest_addr;     /* Destination address */
+    __be32  reserved3;
+    __be32  act_size;      /* Actual data size */
+} __packed;
+
 static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
 {
     val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
@@ -281,6 +300,11 @@ static void pnv_mpipl_preserve_mem(void)
     cpu_physical_memory_write(MDRT_TABLE_BASE, mdrt, MDRT_TABLE_SIZE);
 }
 
+static void pnv_mpipl_save_proc_regs(void)
+{
+    /* TODO: modify PROC_DUMP_AREA_BASE */
+}
+
 static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
                                        uint64_t val, unsigned size)
 {
@@ -307,6 +331,9 @@ static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
             /* Preserve the memory locations registered for MPIPL */
             pnv_mpipl_preserve_mem();
 
+            /* Save processor state */
+            pnv_mpipl_save_proc_regs();
+
             /*
              * TODO: Pass `mpipl` node in device tree to signify next
              * boot is an MPIPL boot
-- 
2.48.1


