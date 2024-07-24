Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B2EC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 21:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWjR7-0000TH-Io; Wed, 24 Jul 2024 17:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjQz-0000EF-Jr; Wed, 24 Jul 2024 17:22:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjQv-0000WK-QO; Wed, 24 Jul 2024 17:22:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OKxNrp011169;
 Wed, 24 Jul 2024 21:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 EP9K24cipWy11m7z9NiSa0ek6G7SUUmuTQviXk6deJQ=; b=LGG6gcKShG+AFbOj
 PzGq8SzYeO2VgFJUAPL4J3GWCp3scqL83rzlM/Lt5uX14EvDK8LUYO06cb14vHJL
 xN28GtPoOa9veDe1WX2+quS16RBLyPm7WbsAdrUvVI5sWwJalNWYA2K/lDfeG1RD
 v3xKEtrAwW5WGPAUhyFyx8bR+pr9p4yIx0JIcWpy+iSAzop5/hpcksiw9fcuDnv7
 XeWslivLuhugMgnsDxhdUMvtaw/Zj0VR9pF+YPjvc0yRp1efd+Rv/W4apH0/T/8q
 oz/q6E1b3heUXgmtRdhD2mIFElvKNMuBgh/t+NRwjP5uW83ZsMu1Mu0a3lphpkMp
 E85sYQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k94e01d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OLLpwh017166;
 Wed, 24 Jul 2024 21:21:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k94e01d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46OJOu3R006625; Wed, 24 Jul 2024 21:21:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn7j42a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46OLLi6G54198586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 21:21:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BAC320040;
 Wed, 24 Jul 2024 21:21:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35CCD2004D;
 Wed, 24 Jul 2024 21:21:43 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2024 21:21:43 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 04/11] pnv/xive2: Add NVG and NVC to cache watch facility
Date: Wed, 24 Jul 2024 16:21:23 -0500
Message-Id: <20240724212130.26811-5-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240724212130.26811-1-kowal@linux.ibm.com>
References: <20240724212130.26811-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M7YuhcTZqkrul2YandeJou7ZSt5Xvv7I
X-Proofpoint-GUID: fS2YZybsi3UZNKmV5D-QhCYmf5WIWSbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_24,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=557 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240150
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

The cache watch facility uses the same register interface to handle
entries in the NVP, NVG and NVC tables. A bit-field in the 'watchX
specification' register tells the table type. So far, that bit-field
was not read and the code assumed a read/write to the NVP table.

This patch allows to read/write entries in the NVG and NVC table as
well.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive2.c | 49 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 3dbbfddacb..dfb0927fd3 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -465,10 +465,30 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
                               word_number);
 }
 
-static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
+static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
 {
-    uint8_t  blk;
-    uint32_t idx;
+    switch (nxc_type) {
+    case PC_NXC_WATCH_NXC_NVP:
+        *table_type = VST_NVP;
+        break;
+    case PC_NXC_WATCH_NXC_NVG:
+        *table_type = VST_NVG;
+        break;
+    case PC_NXC_WATCH_NXC_NVC:
+        *table_type = VST_NVC;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "XIVE: invalid table type for nxc operation\n");
+        return -1;
+    }
+    return 0;
+}
+
+static int pnv_xive2_nxc_update(PnvXive2 *xive, uint8_t watch_engine)
+{
+    uint8_t  blk, nxc_type;
+    uint32_t idx, table_type = -1;
     int i, spec_reg, data_reg;
     uint64_t nxc_watch[4];
 
@@ -476,21 +496,24 @@ static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
 
     spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
     data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
+    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]);
     blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
     idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
 
+    assert(pnv_xive2_nxc_to_table_type(nxc_type, &table_type));
+
     for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
         nxc_watch[i] = cpu_to_be64(xive->pc_regs[data_reg + i]);
     }
 
-    return pnv_xive2_vst_write(xive, VST_NVP, blk, idx, nxc_watch,
+    return pnv_xive2_vst_write(xive, table_type, blk, idx, nxc_watch,
                               XIVE_VST_WORD_ALL);
 }
 
-static void pnv_xive2_nvp_cache_load(PnvXive2 *xive, uint8_t watch_engine)
+static void pnv_xive2_nxc_cache_load(PnvXive2 *xive, uint8_t watch_engine)
 {
-    uint8_t  blk;
-    uint32_t idx;
+    uint8_t  blk, nxc_type;
+    uint32_t idx, table_type = -1;
     uint64_t nxc_watch[4] = { 0 };
     int i, spec_reg, data_reg;
 
@@ -498,11 +521,15 @@ static void pnv_xive2_nvp_cache_load(PnvXive2 *xive, uint8_t watch_engine)
 
     spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
     data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
+    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]);
     blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
     idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
 
-    if (pnv_xive2_vst_read(xive, VST_NVP, blk, idx, nxc_watch)) {
-        xive2_error(xive, "VST: no NVP entry %x/%x !?", blk, idx);
+    assert(pnv_xive2_nxc_to_table_type(nxc_type, &table_type));
+
+    if (pnv_xive2_vst_read(xive, table_type, blk, idx, nxc_watch)) {
+        xive2_error(xive, "VST: no NXC entry %x/%x in %s table!?",
+                    blk, idx, vst_infos[table_type].name);
     }
 
     for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
@@ -1432,7 +1459,7 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
         * SPEC register
         */
         watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
-        pnv_xive2_nvp_cache_load(xive, watch_engine);
+        pnv_xive2_nxc_cache_load(xive, watch_engine);
         val = xive->pc_regs[reg];
         break;
 
@@ -1506,7 +1533,7 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         /* writing to DATA0 triggers the cache write */
         watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
         xive->pc_regs[reg] = val;
-        pnv_xive2_nvp_update(xive, watch_engine);
+        pnv_xive2_nxc_update(xive, watch_engine);
         break;
 
    /* case PC_NXC_FLUSH_CTRL: */
-- 
2.43.0


