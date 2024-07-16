Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B12AC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 19:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToIb-00055S-Bf; Tue, 16 Jul 2024 15:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIR-0004V8-6c; Tue, 16 Jul 2024 15:57:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIP-00069K-D5; Tue, 16 Jul 2024 15:57:10 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GIQjpk023615;
 Tue, 16 Jul 2024 19:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=K+UGX+Rwnlt+K
 FvOGKn/arKmRSPe+c9tqeqyu85jMSY=; b=AIpwf67fua7+qrGBUNamKr4ke+14w
 yWg5F44iNNNHPKma8JGL/G494NQed+pSVV1tVkZgNhbXzc+kOUdN6jpcvjLrJu4C
 DV9DBLHx79oTz/3jXh+18J/Cr1czstwVDFGVAf1W4gJ0SjPH0L0pQPy2wCV1wMwb
 PiWwteamjvkfPFNE1kRniVB1Xe20nCUtpKtg6U4SyY+8L50vaUBbvufjl1c20wP2
 ACNR0kKlc4dZZal2BgZrTlGa8cHtnx0KnyiadAWuqEtykBRQq8tqQQLcriB2BnPC
 ruglutgIoC1noV1mj2wc9774swwgwALv4iqP0uJhzBiAmrJMbZNjrZhhQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dwnv87xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:57:01 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46GJv0xO021357;
 Tue, 16 Jul 2024 19:57:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dwnv87xm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:57:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46GHmwUt029227; Tue, 16 Jul 2024 19:57:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkj0gh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:56:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46GJusYJ54657432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 19:56:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F08CD20043;
 Tue, 16 Jul 2024 19:56:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1A5220040;
 Tue, 16 Jul 2024 19:56:52 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2024 19:56:52 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 5/9] pnv/xive2: Configure Virtualization Structure Tables
 through the PC
Date: Tue, 16 Jul 2024 14:56:29 -0500
Message-Id: <20240716195633.12679-6-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8HBQo6WUWmp2EngjqPf8cGqsv-x-tJgz
X-Proofpoint-ORIG-GUID: o_cNLEm7bN7bYvhQLP7uvs_RwKq4ivIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160144
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Both the virtualization layer (VC) and presentation layer (PC) need to
be configured to access the VSTs. Since the information is redundant,
the xive model combines both into one set of tables and only the
definitions going through the VC are kept. The definitions through the
PC are ignored. That works well as long as firmware calls the VC for
all the tables.

For the NVG and NVC tables, it can make sense to only configure them
with the PC, since they are only used by the presenter. So this patch
allows firmware to configure the VST tables through the PC as well.
The definitions are still shared, since the VST tables can be set
through both the VC and/or PC, they are dynamically re-mapped in
memory by first deleting the memory subregion.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2.c | 47 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index dfb0927fd3..d4ee104300 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -762,6 +762,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
          * entries provisioned by FW (such as skiboot) and resize the
          * ESB window accordingly.
          */
+        if (memory_region_is_mapped(&xsrc->esb_mmio)) {
+            memory_region_del_subregion(&xive->esb_mmio, &xsrc->esb_mmio);
+        }
         if (!(VSD_INDIRECT & vsd)) {
             memory_region_set_size(&xsrc->esb_mmio, vst_tsize * SBE_PER_BYTE
                                    * (1ull << xsrc->esb_shift));
@@ -777,6 +780,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
         /*
          * Backing store pages for the END.
          */
+        if (memory_region_is_mapped(&end_xsrc->esb_mmio)) {
+            memory_region_del_subregion(&xive->end_mmio, &end_xsrc->esb_mmio);
+        }
         if (!(VSD_INDIRECT & vsd)) {
             memory_region_set_size(&end_xsrc->esb_mmio, (vst_tsize / info->size)
                                    * (1ull << end_xsrc->esb_shift));
@@ -801,13 +807,10 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
  * Both PC and VC sub-engines are configured as each use the Virtual
  * Structure Tables
  */
-static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd,
+                                   uint8_t type, uint8_t blk)
 {
     uint8_t mode = GETFIELD(VSD_MODE, vsd);
-    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
-                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
-    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
-                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
     uint64_t vst_addr = vsd & VSD_ADDRESS_MASK;
 
     if (type > VST_ERQ) {
@@ -842,6 +845,16 @@ static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
     }
 }
 
+static void pnv_xive2_vc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+{
+    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
+                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
+    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
+                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
+
+    pnv_xive2_vst_set_data(xive, vsd, type, blk);
+}
+
 /*
  * MMIO handlers
  */
@@ -1271,7 +1284,7 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
     case VC_VSD_TABLE_ADDR:
        break;
     case VC_VSD_TABLE_DATA:
-        pnv_xive2_vst_set_data(xive, val);
+        pnv_xive2_vc_vst_set_data(xive, val);
         break;
 
     /*
@@ -1490,6 +1503,16 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
     return val;
 }
 
+static void pnv_xive2_pc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+{
+    uint8_t type = GETFIELD(PC_VSD_TABLE_SELECT,
+                            xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
+    uint8_t blk = GETFIELD(PC_VSD_TABLE_ADDRESS,
+                           xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
+
+    pnv_xive2_vst_set_data(xive, vsd, type, blk);
+}
+
 static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
                                   uint64_t val, unsigned size)
 {
@@ -1500,12 +1523,18 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
     switch (offset) {
 
     /*
-     * VSD table settings. Only taken into account in the VC
-     * sub-engine because the Xive2Router model combines both VC and PC
-     * sub-engines
+     * VSD table settings.
+     * The Xive2Router model combines both VC and PC sub-engines. We
+     * allow to configure the tables through both, for the rare cases
+     * where a table only really needs to be configured for one of
+     * them (e.g. the NVG table for the presenter). It assumes that
+     * firmware passes the same address to the VC and PC when tables
+     * are defined for both, which seems acceptable.
      */
     case PC_VSD_TABLE_ADDR:
+        break;
     case PC_VSD_TABLE_DATA:
+        pnv_xive2_pc_vst_set_data(xive, val);
         break;
 
     case PC_NXC_PROC_CONFIG:
-- 
2.43.0


