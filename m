Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D04C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 21:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWjUm-0002M8-6e; Wed, 24 Jul 2024 17:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjUk-0002Ed-CD; Wed, 24 Jul 2024 17:25:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjUh-0003Pd-Ht; Wed, 24 Jul 2024 17:25:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OLPivL003944;
 Wed, 24 Jul 2024 21:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 84OFmMFbcFL8IsFjFgp3Z7NyYfbW/Ce3+M+A16I7nP8=; b=kmcyN6a3dWEpsSIs
 30pUmApiPZhV89vEunWHgJfe0ICudM7RAsR0blH2Fu0lSSGklBPR72KLYHVe+lJd
 IIuW4nqwkCTBqgDx5syOxZydfC2+T0iOQ4hVWmZIL4138DAA2O6hf0tGRjWrEhTl
 HFCQj4L2pVrBlN7NfiyuqQY2TlEnaAwCyp7T8N6Kj2FaL0uEbJ464mvaQqFCdiv7
 EevndtX6JKIaw7fUR/LSNgtTsSfJSWCfxmjpJUS5g/zy+pc8izdZRv3ArjFi6TWC
 8vq9vWqsKXFV0js1KcQ7FJDJJNBx3GN+4MgtNRtaytM2jkkhyQiDcEljovpzFq9M
 rDlEug==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40juxbj7s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:25:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OLPjL0004154;
 Wed, 24 Jul 2024 21:25:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40juxbj7nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:25:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46OJ6v09006741; Wed, 24 Jul 2024 21:21:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn7j42d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46OLLjMB50921854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 21:21:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4ADC2006E;
 Wed, 24 Jul 2024 21:21:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F1B52004F;
 Wed, 24 Jul 2024 21:21:44 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2024 21:21:44 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 05/11] pnv/xive2: Configure Virtualization Structure Tables
 through the PC
Date: Wed, 24 Jul 2024 16:21:24 -0500
Message-Id: <20240724212130.26811-6-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240724212130.26811-1-kowal@linux.ibm.com>
References: <20240724212130.26811-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V3orq4aeLj_mhLIykNP7vK_yrXrvQ0GM
X-Proofpoint-GUID: cp_cQyPpeQ4X58wa51AMTTwNVI9pmBZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_24,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
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


