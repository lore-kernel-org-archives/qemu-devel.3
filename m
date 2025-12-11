Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F29AD41D68
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 17:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTk1u-0002m7-H9; Thu, 11 Dec 2025 12:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTk1h-0002lN-Ge; Thu, 11 Dec 2025 12:00:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTk1f-0000ZJ-Mu; Thu, 11 Dec 2025 12:00:25 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBF7QdW025527;
 Thu, 11 Dec 2025 17:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=nuTYvNasgluFn+71u0kQIdIJjL+OgfRbewQMJ5XdC
 +Q=; b=beV3hfGGqw6ad4h2lO9dzqjTs0XmJr4XuWwdsWFIcCf/aoJcwg4Tx/i0z
 /YO/HizJBHhIrJCLFRWj/ebVc8neGTh/9MT1jdyK2DlcDyJdIAQ2oyBQI9qhsM/U
 lPUoj9mGEnedHkmpJRI3/xd6ntXGDpqCa+hfbfaFfyxzTHuN8DgQblK3rAVesBvP
 bc36/8nlL1bEQ27xoPBwX62gwwzXWwzhHY33c2ocGWaXr4Q+JI71yV9zjvAqCrno
 CQ47oDNGmboC6VwC+eHDsAdoOBzExnpSfqoV2K98MppM4bnmioZHLHefxJoJDkt5
 F5C68ycglLRtYBt5apLv74ZyOlybg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0k93be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 17:00:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BBH0JMd009370;
 Thu, 11 Dec 2025 17:00:19 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0k93ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 17:00:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBFkdD1002044;
 Thu, 11 Dec 2025 17:00:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jqb6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 17:00:18 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BBH0GQZ40108532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Dec 2025 17:00:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 895CF58051;
 Thu, 11 Dec 2025 17:00:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3175B58065;
 Thu, 11 Dec 2025 17:00:16 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Dec 2025 17:00:16 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, milesg@linux.ibm.com, adityag@linux.ibm.com,
 npiggin@gmail.com, kowal@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH] pnv/psi: Add VMSTATE information to PnvPsi
Date: Thu, 11 Dec 2025 11:00:12 -0600
Message-ID: <20251211170012.2220477-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693af8a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=yvJQjjxT_zsGvj7SWxAA:9
X-Proofpoint-ORIG-GUID: -TL1-np2hCZo0EMa8pz7ZSgY8cwftugS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX5UuFsME2LlGO
 +Ve0mWIuHX4eTduDDo+2LjJwgnj5ggN5BATIC4aUxZksDFcpKTk+q7iIr49u9nWYSdl1mi31aFl
 AAvPv1pZk922nTeZwEzoWdZGy1fumiHAEHwH0kD6sVv2TL5tGLFoSq5Mo+MfHw9cgRAtjswOkCm
 62UiZXyYIsux7aE2BeGglSzQq678Am70tfW80pYbDFCSRBaGfRF+E2mnewCi/qGTCjBq7iIZF7X
 NH7QcxoV+Yi71U7SHZR7eI00HobReQAMK6jCBHMLqbQLtw8NLCncY5W8i8jjHVtyKUkBxI4Ld/m
 6hGYAWpBDc/V6N+VKbk0kz8lrmAbHcEQ79SUMUXmpfLhxYf/vA/dGeCcmZ9IvyiQgeMNFulHkZ2
 udJ3mx5DwqA4ibTfA6tifX0+aJT+lg==
X-Proofpoint-GUID: W2vPdDw1jWuYeKa0L2Jp0h9ayu28QplC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


