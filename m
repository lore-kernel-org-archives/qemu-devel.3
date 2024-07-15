Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37276C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 18:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTQX1-00073F-9s; Mon, 15 Jul 2024 14:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQWz-0006ul-9r; Mon, 15 Jul 2024 14:34:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQWx-0007Fj-MQ; Mon, 15 Jul 2024 14:34:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FHwML0020055;
 Mon, 15 Jul 2024 18:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=S5bSfacgcEZ2n
 v5UNKn6/oktqE8d1NR7zqvvqwgJ3b0=; b=Rql0Xjblovyfd0UfxQ7Jko3rYrZV2
 9hMegJ6hP1KGjyQA4VQ7eo+iqWKb8IgRbS4rJHYlKsxU9YcsTapS7wE2LXjVUYOP
 sJvrmbFeAWouqVXSaQbWt3xd47VetFqnGvRZMDoacKciyVJvKHvYM5V8NMrQBaZO
 RvTucHN6M1UO4mabaQlXKw4nn7axRyGy6rlXdiYjuswsTIYjIpSw6urtdc5SZNIk
 1UlJB6weO4RPiE8y+dFcDRHhJbCsF5oXQdWXpPYJZEEJmkBxvrjR41sevmPqKC4q
 k4rYVGaS/o1yApZ+qtMoT6oVfJFIj1+ispXNssqK+/wsx4MhMAWnEC4FQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d86sr3r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FIYW0b008365;
 Mon, 15 Jul 2024 18:34:32 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d86sr3r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FG16PE017959; Mon, 15 Jul 2024 18:34:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c3wtrhr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FIYQi650987466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2024 18:34:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 605E520043;
 Mon, 15 Jul 2024 18:34:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FD3820040;
 Mon, 15 Jul 2024 18:34:25 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jul 2024 18:34:25 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 4/9] pnv/xive2: Add NVG and NVC to cache watch facility
Date: Mon, 15 Jul 2024 13:33:27 -0500
Message-Id: <20240715183332.27287-5-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CIM0HJIDy8hEMUjLya_ynjxxHRJawmDt
X-Proofpoint-GUID: QSzk5Bfpo53SQ6TjgsvIahPbNp1oFok7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=543 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150139
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

The cache watch facility uses the same register interface to handle
entries in the NVP, NVG and NVC tables. A bit-field in the 'watchX
specification' register tells the table type. So far, that bit-field
was not read and the code assumed a read/write to the NVP table.

This patch allows to read/write entries in the NVG and NVC table as
well.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2.c | 59 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index d62ac20d98..c72c66dd6a 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -462,46 +462,71 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
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
 
-    if (watch_engine > 3) {
-        return -1;
-    }
+    assert(watch_engine < ARRAY_SIZE(nxc_watch));
+
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
 
-    if (watch_engine > 3) {
-        return;
-    }
+    assert(watch_engine < ARRAY_SIZE(nxc_watch));
+
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
@@ -1431,7 +1456,7 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
         * SPEC register
         */
         watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
-        pnv_xive2_nvp_cache_load(xive, watch_engine);
+        pnv_xive2_nxc_cache_load(xive, watch_engine);
         val = xive->pc_regs[reg];
         break;
 
@@ -1505,7 +1530,7 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         /* writing to DATA0 triggers the cache write */
         watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
         xive->pc_regs[reg] = val;
-        pnv_xive2_nvp_update(xive, watch_engine);
+        pnv_xive2_nxc_update(xive, watch_engine);
         break;
 
    /* case PC_NXC_FLUSH_CTRL: */
-- 
2.43.0


