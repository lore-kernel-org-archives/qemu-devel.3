Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11904D5B84D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCEb-0003lw-2W; Mon, 15 Dec 2025 12:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDX-0002HX-HG; Mon, 15 Dec 2025 12:18:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDT-0002jz-2x; Mon, 15 Dec 2025 12:18:39 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFCb12T008563;
 Mon, 15 Dec 2025 17:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nuTYvNasgluFn+71u
 0kQIdIJjL+OgfRbewQMJ5XdC+Q=; b=ZsnUW44X2fPtlzKxx4MPnIKXuFzpXBKCF
 l51BrUOyeDzmujEQ3bwY8LkfdeQMyhZfWQ1KiHMmXkyEix3FxC8pvRzmSdqmlC6r
 5VmodTFRlE2QKySYdBrZpB2eQ6ntYpusNp6xuYexVE+Ffbrofykr7NwgB1GkHd9t
 t9Zs3LLjAJEayzU1lv6NBEGcf8nN/CCflkRjrNM3yzzbQZaLrdgnvJxETECuM1XD
 +WLXT8XWNwXYPHlte7vBt2UqzQT+H/TT7eTAoQUThhYxCuVodP7LLkf2ZHFhtxn2
 5M9JHfChyqX067ZEr/oAw0TiQVXF4M5HDdw9Q6+TVz3uktKbRFInQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1ag66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFHEE5T012642;
 Mon, 15 Dec 2025 17:18:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1ag63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFER1dE012810;
 Mon, 15 Dec 2025 17:18:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juxytww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFHITNp33817248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 17:18:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0321258056;
 Mon, 15 Dec 2025 17:18:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80AFA5805A;
 Mon, 15 Dec 2025 17:18:28 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 17:18:28 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v2 7/7] hw/ppc: Add VMSTATE information to PnvPsi
Date: Mon, 15 Dec 2025 11:18:13 -0600
Message-ID: <20251215171813.1670241-8-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215171813.1670241-1-calebs@linux.ibm.com>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nothzA4TzTgWZdQmDQrfN70jBwuEccOz
X-Proofpoint-ORIG-GUID: 1TJ1XdbMhUaqY4MkAMfqA-qTRMJulZEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX4uQhwF+RtYYj
 UFh1gPCd8NYu7FBrYk5FB7x7LIRqdeWjiTNJd/V12v/jAtNIAafA1LpzUlXj700ib4Rz5Mx1qol
 HHRP6Ht6Ayvw3oVvuHg4I2NXMCMu82iDVbRx9jsuTDr4lRf+pDW11iwBZPU17UDP7GqJMVNAzxb
 J+3utA6DFjity4RF3DidnjFELn0ru5XxxJnSkbRe8h5qsxBjmX9ngenhTz3es0v7yszbyiFKwGR
 Yvja60MppmOkO+W0Tk7wiT2+0WUzj+Od4mXpDWotwq6mOQY1P499FzJyAkrUjnzcYV4SnH1qUH0
 KfS6GlnJSemTTMs3z6gDjP6gaSUPSHLEFTd1jL3KxLN2YmMDyRTV/U5NjtHhiSUVVCZdZxD9Czj
 /Ez69m23eLxGE42Cf8S+h48glLOUVQ==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=694042e7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=yvJQjjxT_zsGvj7SWxAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 hw/ppc/pnv_psi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5d947d8b52..88d5f1d45d 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "system/reset.h"
 #include "qapi/error.h"
+#include "migration/vmstate.h"
 
 
 #include "hw/ppc/fdt.h"
@@ -35,6 +36,8 @@
 
 #include <libfdt.h>
 
+#undef PSI_DEBUG
+
 #define PSIHB_XSCOM_FIR_RW      0x00
 #define PSIHB_XSCOM_FIR_AND     0x01
 #define PSIHB_XSCOM_FIR_OR      0x02
@@ -130,12 +133,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
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
 
@@ -975,6 +977,40 @@ static void pnv_psi_register_types(void)
 
 type_init(pnv_psi_register_types);
 
+#ifdef PSI_DEBUG
+static void psi_regs_pic_print_info(uint64_t *regs, uint32_t nr_regs,
+                                    GString *buf) {
+    uint i, prev_idx = -1;
+    uint64_t  reg1, prev_reg1 = -1;
+    uint64_t  reg2, prev_reg2 = -1;
+    uint64_t  reg3, prev_reg3 = -1;
+    uint64_t  reg4, prev_reg4 = -1;
+    for (i = 0; i < nr_regs; i = i + 4) {
+        /* Don't print if values do not change, but print last*/
+        reg1 = regs[i];
+        reg2 = regs[i + 1];
+        reg3 = regs[i + 2];
+        reg4 = regs[i + 3];
+        if (reg1 == prev_reg1 && reg2 == prev_reg2 &&
+            reg3 == prev_reg3 && reg4 == prev_reg4 &&
+            i < (nr_regs - 4)) {
+            if (i == (prev_idx + 4)) {
+                g_string_append_printf(buf, "        . . .\n");
+            }
+            continue;
+        }
+
+        g_string_append_printf(buf, "  [%03X] 0x%016lX %016lX %016lX %016lX\n",
+            i, reg1, reg2, reg3, reg4);
+        prev_idx = i;
+        prev_reg1 = reg1;
+        prev_reg2 = reg2;
+        prev_reg3 = reg3;
+        prev_reg4 = reg4;
+    }
+}
+#endif
+
 void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
 {
     PnvPsi *psi = PNV_PSI(psi9);
@@ -985,4 +1021,10 @@ void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
     g_string_append_printf(buf, "PSIHB Source %08x .. %08x\n",
                            offset, offset + psi9->source.nr_irqs - 1);
     xive_source_pic_print_info(&psi9->source, offset, buf);
+#ifdef PSI_DEBUG
+    /* Print PSI registers */
+    g_string_append_printf(buf, "\nPSI Regs[0x0..%X]\n",
+                           PSIHB_XSCOM_MAX);
+    psi_regs_pic_print_info(psi->regs, PSIHB_XSCOM_MAX, buf);
+#endif
 }
-- 
2.47.3


