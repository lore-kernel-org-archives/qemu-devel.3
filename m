Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF43C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 21:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJJkL-0004bn-0D; Mon, 17 Jun 2024 17:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sJJDA-0002Of-7M; Mon, 17 Jun 2024 16:44:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sJJD8-0006Ve-Ci; Mon, 17 Jun 2024 16:44:19 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HJwRVD002923;
 Mon, 17 Jun 2024 20:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=bEbTlrY38kAac
 QBo3hDwmHBhAg4jhFSqJyVzZeGccik=; b=io8HY7zqoppLxcST1iN+597x/Ofxm
 YO2mkF3IOEc8F4bvqPSxZSK9oaFHJs721qGcr8n3dMOlwwpu+2Y429s2jT0PmQTK
 CU7BH51N5kUzPCLtZ3kX2l9zHY7qb8VoP/HQfqKmYKSJs2zQfxi9EVBkgmVAuoPC
 5KxBPbyKyNQ4LWTKtU/q0s1SiRTZ3EAlwOHTQaICNZKlqVUVID4z/RTAE5dNRwwV
 cWdUEHZGdPRclrlHVyi4rrC1JFxuy5FDjVCleOfTtkILsUy23hJGyJWhsXaelu6f
 LfLZ0WQKghM+rXSQEy4LjDO9rst08kdQouVv0I8AIvTh2XtFypJjDyI7g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytus2g3s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 20:43:46 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HKhk9q006244;
 Mon, 17 Jun 2024 20:43:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytus2g3s4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 20:43:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45HKWqCK023914; Mon, 17 Jun 2024 20:43:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9pw9ps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 20:43:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HKhd7D33489554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2024 20:43:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F0D72004B;
 Mon, 17 Jun 2024 20:43:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECB6D20043;
 Mon, 17 Jun 2024 20:43:37 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 20:43:37 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 2/5] pnv/xive2: Enable VST NVG and NVC index compression
Date: Mon, 17 Jun 2024 15:42:59 -0500
Message-Id: <20240617204302.12323-3-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240617204302.12323-1-kowal@linux.vnet.ibm.com>
References: <20240617204302.12323-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MgWRQu879uf1rLic9eQYZdqEKk01xljl
X-Proofpoint-GUID: r-y3gNw-pWEKxC9E94DvyiGRF0GSR6cY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=878
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170157
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jun 2024 17:18:34 -0400
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Enable NVG and NVC VST tables for index compression which indicates the number
of bits the address is shifted to the right for the table accesses.
The compression values are defined as:
   0000 - No compression
   0001 - 1 bit shift
   0010 - 2 bit shift
   ....
   1000 - 8 bit shift
   1001-1111 - No compression

Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2_regs.h |  2 ++
 hw/intc/pnv_xive2.c      | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index ca05255d20..e8b87b3d2c 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -427,6 +427,8 @@
 #define X_PC_NXC_PROC_CONFIG                    0x28A
 #define PC_NXC_PROC_CONFIG                      0x450
 #define   PC_NXC_PROC_CONFIG_WATCH_ASSIGN       PPC_BITMASK(0, 3)
+#define   PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS PPC_BITMASK(32, 35)
+#define   PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS PPC_BITMASK(36, 39)
 
 /* NxC Cache Watch 0 Specification */
 #define X_PC_NXC_WATCH0_SPEC                    0x2A0
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 2050ed5efd..ff3d2d9c7b 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -217,6 +217,20 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
     return pnv_xive2_vst_addr_direct(xive, type, vsd, (idx % vst_per_page));
 }
 
+static uint8_t nvc_table_compress_shift(PnvXive2 *xive)
+{
+    uint8_t shift =  GETFIELD(PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS,
+                              xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
+    return shift > 8 ? 0 : shift;
+}
+
+static uint8_t nvg_table_compress_shift(PnvXive2 *xive)
+{
+    uint8_t shift = GETFIELD(PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS,
+                             xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
+    return shift > 8 ? 0 : shift;
+}
+
 static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
                                    uint32_t idx)
 {
@@ -238,6 +252,12 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
         return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
     }
 
+    if (type == VST_NVG) {
+        idx >>= nvg_table_compress_shift(xive);
+    } else if (type == VST_NVC) {
+        idx >>= nvc_table_compress_shift(xive);
+    }
+
     if (VSD_INDIRECT & vsd) {
         return pnv_xive2_vst_addr_indirect(xive, type, vsd, idx);
     }
-- 
2.39.3


