Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B0ED609A9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWku-0006t6-Ue; Tue, 16 Dec 2025 10:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWkt-0006sL-3V; Tue, 16 Dec 2025 10:14:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWkq-000719-Fx; Tue, 16 Dec 2025 10:14:26 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG54Q19011903;
 Tue, 16 Dec 2025 15:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CwHtwHqF9QeIHgO8O
 lLt6uppBDL9NUgMv9GjjLAy+/o=; b=BzIGwXovIcfAEJykIDH00z63gef8KAuuc
 KhG2g1sCEkq/YYlN9fn2lguhQHxprdZ2o4dJ1Mw1tIX5RuKEcNVj0wCb4Cx96Vcz
 1FROT/S2HZFb9vlk5wwinpYT3OevzLBL6x8B+lkUGZqCivNotAWE1ymbuaKmJBLH
 WQg3Hzb//lVpHBOE6iZO7wBesCqiFmCkYY81cu5kOY6UcBMJbHaxx4PRrohF0UQ5
 qN88ijlurMoI930pwTpS1cUhUBnhcZZ3v2i7iNvSQSk7DPgGc+QQ1HW8n6AdJvkT
 eljs40UlatgQXuz7wejRDg7Fbq5Q4E974bdv1OAwfDKe6j+SA+bBw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8fvru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGF8q72011811;
 Tue, 16 Dec 2025 15:14:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8fvrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGDGxku012783;
 Tue, 16 Dec 2025 15:14:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juy4x6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGFEHQo33620592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 15:14:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE18058043;
 Tue, 16 Dec 2025 15:14:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB1CE58053;
 Tue, 16 Dec 2025 15:14:16 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 15:14:16 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v3 7/7] hw/ppc: Add VMSTATE information to PnvPsi
Date: Tue, 16 Dec 2025 09:13:59 -0600
Message-ID: <20251216151359.418708-8-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216151359.418708-1-calebs@linux.ibm.com>
References: <20251216151359.418708-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX8K2aFOWhnkoE
 I9Gkvjj3SioiDKNfZ+4RLa36FaHtwTrnmYu4Te6qR7Q7biZZFSK+3W1UB3VAn69y6k/AWL7fjZ7
 3XnMwqTxbPzwwrVHTSaExz1o60fvNQQqcSXED3y/TsgULZw3sXQKd3Q9wN/9YiwjaZrE24NUkmQ
 D3C6JCuaOerRQ47Q4kS5H5VNO7whBPn+7zgxNv7rDhBxuz5T4dkYtzuCmSzff8+Yt7BARsSH932
 BiCbvJRU0EsbIFv38zafy+lse2/OeRzd/0ceZEWdCw+KOr4cX4ZQZ0dV9lEk1ynaOF/uO3jbR1W
 YjBfSj3IqwAONg81++u0NoVUHAeqBYEyyerHXN3bys71ZghUytJVzpb0ewikTlcVAFpve39SUZT
 R4xtPlqej380O7rIf6lRzvYl5VJkmw==
X-Proofpoint-GUID: RwfimJuFqmEnWK5lYJh5aQp8Ae9jiPcA
X-Proofpoint-ORIG-GUID: lOvrLQ6UCrFPqLISahYGcMi71yNQ8U9l
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=6941774c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=oruG57yO5g4gZiaFByIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_psi.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5d947d8b52..67bc911e4b 100644
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


