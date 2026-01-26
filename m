Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5D9D13C0F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 13:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkN4B-0002Vm-QA; Mon, 26 Jan 2026 08:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vkN3u-0002Ie-CG; Mon, 26 Jan 2026 08:55:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vkN3s-0004vg-IP; Mon, 26 Jan 2026 08:55:26 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QCCmco004679;
 Mon, 26 Jan 2026 13:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=B9nbKM03l+YsBmkg6
 yzSH3HekNyWZvvRFMDmwlEZtkw=; b=CJFmzR+Egdpq6yVqiJu517pFeW/3MACMd
 nsOxT/G0PyxU9UoksIHHQoOsyoBizOG+MGLswnBG4bftVfPTiQX7TNC8QLgUANM9
 S711WmfUZqmnxaiGQrx/4bK5O4r2Ds6/N2Lt5F8C5pZtjbnGLcnFYtmYUwDoOVeM
 MfI9KcQZexgjQb2wBnEIC+GhAVVbQ7iu/IxiVML2t9C0pIQpX1BWYia0RUF1b+ek
 9DvVvXMNnMCMIp4kBVLbu5lKWjamaxQ4muoAc2jFHc/8I8TMxjoudsVdWP/DMNp9
 T2N2eJ0VYXUKXHiaC28uBHG1MLl3jQHLokE6tuGtyEyM4lwoE/NGg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt87hj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QDt7b0019493;
 Mon, 26 Jan 2026 13:55:22 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt87hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QAlgUo031044;
 Mon, 26 Jan 2026 13:55:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dscvxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60QDtJ9028181192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jan 2026 13:55:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 615FF58055;
 Mon, 26 Jan 2026 13:55:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED3EE58043;
 Mon, 26 Jan 2026 13:55:18 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jan 2026 13:55:18 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2 3/3] ppc/pnv: Add OCC FLAG registers
Date: Mon, 26 Jan 2026 07:55:07 -0600
Message-ID: <20260126135507.771552-4-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126135507.771552-1-calebs@linux.ibm.com>
References: <20260126135507.771552-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: smgEytLI3UeaBVTjnfNOdpuSxlU8ts9f
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6977724a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=C6aVSkDANSdmHkZ1WT0A:9
X-Proofpoint-ORIG-GUID: H6UXT7KzmjhG-ovr7Xm1eotoSl0pOBtO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExNyBTYWx0ZWRfX8cZfBWEu6Nl3
 nJdngi4af50QC3h5kStS5SGh/DaxtbZwPO2UKv0/KzhW4llUd6hvkAsvXNWOyj5Ml+z0W6bank6
 zrXfEiclJt7Cyt7EZ+UssPuWSPR+7tHPIxjrcV1y9FJYU4Mjno4Q+WvBOjDLb8lzk/apXLlpBX6
 QtF+eZEnIPcOCINoNcKo202uCJ98No7lpYrH3qz9ki2gCHToKUCcCh3LJkOcNEDBjITclFOqfAA
 fff6sLBe8wBeeGJ48BPjy6eD3Bk1xCjI8LPoDkzmioAbxTtafocJhgLzoFkYOnn4ma9Fjf/QIoo
 gxzwUXylcCL815XsdiluCD/vPmILrm6pa01hmJExhx+1tpqHknGc3KjjzZZmWF4Qnlf0PQ9Zmt+
 yIwRILpDiZRQ6eAPYz54fvi5/0CcYHfhOFQk2Biv4MOxbhAIe7cyy9jjKCSd3+pbg56F2+e7dyx
 F87REZYsi7tY4gUM3Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

OCCFLG are scratch registers that can be shared with OCC firmware.
Log reads and writes to the registers as a reminder when we run
into more OCC code.

Add RW, WO_CLEAR and WO_OR SCOM Type enums in pnv_occ.c

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++++++++++++---
 include/hw/ppc/pnv_occ.h |  4 +++
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 64cab3e9dc..81dd5cfd1b 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -195,6 +195,49 @@ static const TypeInfo pnv_occ_power8_type_info = {
 #define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
 #define P9_OCB_OCI_OCCMISC_OR           0x6082
 
+/* OCC scratch registers for flag setting */
+#define P9_OCCFLG0                      0x60ac
+#define P9_OCCFLG7_OR                   0x60c3
+
+enum ScomType {
+    SCOM_TYPE_RW          = 0,
+    SCOM_TYPE_WO_CLEAR    = 1,
+    SCOM_TYPE_WO_OR       = 2,
+};
+
+static void rw_occ_flag_regs(PnvOCC *occ, uint32_t offset, bool read,
+        uint64_t *val)
+{
+    int flag_num;
+    int flag_type;
+
+    /*
+     * Each OCCFLG register has SCOM0 - RW, SCOM1 - WO_CLEAR, SCOM2 - WO_OR
+     * hence divide by 3 to get flag index and mod 3 to get SCOM type.
+     */
+    flag_num = (offset - P9_OCCFLG0) / 3;
+    flag_type = (offset - P9_OCCFLG0) % 3;
+
+    if (read) {
+        if (flag_type) {
+            qemu_log_mask(LOG_GUEST_ERROR, "OCC: Write only register: Ox%"
+                      PRIx32 "\n", offset);
+            return;
+        }
+        *val = occ->occflags[flag_num];
+    } else {
+        switch (flag_type) {
+        case SCOM_TYPE_RW:
+            occ->occflags[flag_num] = *val;
+            break;
+        case SCOM_TYPE_WO_CLEAR:
+            occ->occflags[flag_num] &= ~(*val);
+            break;
+        case SCOM_TYPE_WO_OR:
+            occ->occflags[flag_num] |= *val;
+        }
+    }
+}
 
 static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
                                           unsigned size)
@@ -207,8 +250,11 @@ static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
     case P9_OCB_OCI_OCCMISC:
         val = occ->occmisc;
         break;
+    case P9_OCCFLG0 ... P9_OCCFLG7_OR:
+        rw_occ_flag_regs(occ, offset, 1, &val);
+        break;
     default:
-        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
+        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register read: Ox%"
                       HWADDR_PRIx "\n", addr >> 3);
     }
     return val;
@@ -229,9 +275,12 @@ static void pnv_occ_power9_xscom_write(void *opaque, hwaddr addr,
         break;
     case P9_OCB_OCI_OCCMISC:
         pnv_occ_set_misc(occ, val);
-       break;
+        break;
+    case P9_OCCFLG0 ... P9_OCCFLG7_OR:
+        rw_occ_flag_regs(occ, offset, 0, &val);
+        break;
     default:
-        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
+        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register write: Ox%"
                       HWADDR_PRIx "\n", addr >> 3);
     }
 }
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 84bdf5004d..92a4dbf1a0 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -47,6 +47,10 @@ struct PnvOCC {
     /* OCC Misc interrupt */
     uint64_t occmisc;
 
+    /* OCC Flags */
+#define NR_FLAG_REGS 8
+    uint32_t occflags[NR_FLAG_REGS];
+
     qemu_irq psi_irq;
 
     /* OCCs operate on regions of HOMER memory */
-- 
2.47.3


