Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78121C79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcn3N-0005d7-At; Mon, 05 Jan 2026 11:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcn2A-00052I-1i; Mon, 05 Jan 2026 11:02:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcn22-0001J0-Iu; Mon, 05 Jan 2026 11:02:13 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605AKFRF028393;
 Mon, 5 Jan 2026 16:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dTwAjVCkao+L39Fcb
 Vg2fbqRAyzRacYVBrRk6AFr7ac=; b=K0BufWhMtO5wJYDvAUdK821x5Tb5X4UNK
 ek+Gf93cfE/s+qNZc3ReF8OjIpScfAIKLzhSrk1vK6ujXGG8WVID3+r5LyxKlqVw
 cwSkl+FvnsYq7o1CWUbKJ8T1skvLuoewRgy7P0xJAZLiTxWbORAr5YKGu2NVruED
 rOll9Q2cDZTaDckKL/kClAplkIa0ZNbfR40YyoPE6K0QAnmA2GWaKjUNHRie+a+K
 U7jsuctaqBsKfryofIiONWUDLaWPpeyEkc5J8aHzC9hU5KKXGnEEyxiveCIdP1/V
 YjUbNVfohzDhdKqrBUTTE2pK6jEZflRDp6SmAb6GFMutA/6yz5nNg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtfdbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:02:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605G22oo021369;
 Mon, 5 Jan 2026 16:02:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtfdbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:02:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605EJsg9005216;
 Mon, 5 Jan 2026 16:02:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexjxm7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:02:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 605G20Le9306706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 16:02:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8772D58054;
 Mon,  5 Jan 2026 16:02:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A88AE5805D;
 Mon,  5 Jan 2026 16:01:59 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 16:01:59 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, kowal@linux.ibm.com, angeloj@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v4 7/7] hw/ppc: Add VMSTATE information to PnvPsi
Date: Mon,  5 Jan 2026 10:01:38 -0600
Message-ID: <20260105160138.3242709-8-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105160138.3242709-1-calebs@linux.ibm.com>
References: <20260105160138.3242709-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695be07b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=oruG57yO5g4gZiaFByIA:9
X-Proofpoint-GUID: 8r9n8DMYhPBtgFGTWI2hOlPoi0CqurzK
X-Proofpoint-ORIG-GUID: Y_cMpYYQ6QSaJpAKI0f92GK82ljgK3oD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzOCBTYWx0ZWRfX1judwAC2+rSX
 dxqmUzjan6ADYNID4nIeBGlmbtAeCs+CGq/nuL/5/JPrJU3SeaAM3FYNUBc7FuZrAvTSXC6d1gv
 9ZzskPorgH9UYgcsgppQGLn2j9YQOIegb6jk3rVrXwwGYytOtlpy91kat81OibjkAuAPWDsqodt
 McBSlrHmVHKotA5NsTguZK/1drFji2fOVNYzAq9NQDXzgw9ChXllcwLzap0iSI03hoVIr2nO92d
 p2MW7wWeamAXYABQMUfsw+GpOIko0pg6/Rhg2x91+lHIBfUZ8Btdwdzv1p71n+Ufn7zwLesnkSh
 TJ6D4vT5nIaQtG2mJldzOCcWVSfEHy02IATW6YwBkRerZakOPQcypo1tV0aNneMx7TnaysV7zWH
 qPru/jCijPTuZDkOQkQxKjXl8iclfgPZwMBfb22rMh1YnvmKfKxRl6WlxCyPCdYZkK1NjjKd9uj
 UveX+dXHP6QaeJgyQnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PnvPsi needs to be able to save/load snapshots.  Add VMSTATE information
to the device class and a post_load() method to restore dynamic data items and
memory region mappings.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_psi.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 264568cdfb..e8701c6100 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "system/reset.h"
 #include "qapi/error.h"
+#include "migration/vmstate.h"
 
 
 #include "hw/ppc/fdt.h"
@@ -130,12 +131,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
 {
     PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
     MemoryRegion *sysmem = get_system_memory();
-    uint64_t old = psi->regs[PSIHB_XSCOM_BAR];
 
     psi->regs[PSIHB_XSCOM_BAR] = bar & (ppc->bar_mask | PSIHB_BAR_EN);
 
     /* Update MR, always remove it first */
-    if (old & PSIHB_BAR_EN) {
+    if (memory_region_is_mapped(&psi->regs_mr)) {
         memory_region_del_subregion(sysmem, &psi->regs_mr);
     }
 
@@ -919,6 +919,37 @@ static const TypeInfo pnv_psi_power9_info = {
     },
 };
 
+static int vmstate_pnv_psi_post_load(void *opaque, int version_id)
+{
+    PnvPsi *psi = PNV_PSI(opaque);
+    Pnv9Psi *psi9 = PNV9_PSI(psi);
+    MemoryRegion   *sysmem = get_system_memory();
+    uint64_t esb_bar;
+    hwaddr esb_addr;
+
+    /* Set the ESB MMIO mapping */
+    esb_bar = psi->regs[PSIHB_REG(PSIHB9_ESB_CI_BASE)];
+
+    if (esb_bar & PSIHB9_ESB_CI_VALID) {
+        esb_addr = esb_bar & PSIHB9_ESB_CI_ADDR_MASK;
+        memory_region_add_subregion(sysmem, esb_addr,
+                                    &psi9->source.esb_mmio);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_pnv_psi = {
+    .name = TYPE_PNV_PSI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmstate_pnv_psi_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(regs, PnvPsi, PSIHB_XSCOM_MAX),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -926,6 +957,7 @@ static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
     static const char compat[] = "ibm,power10-psihb-x\0ibm,psihb-x";
 
     dc->desc    = "PowerNV PSI Controller POWER10";
+    dc->vmsd = &vmstate_pnv_psi;
 
     ppc->xscom_pcba = PNV10_XSCOM_PSIHB_BASE;
     ppc->xscom_size = PNV10_XSCOM_PSIHB_SIZE;
-- 
2.47.3


