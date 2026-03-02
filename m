Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0D4D58E6B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwxAa-0008VV-62; Mon, 02 Mar 2026 01:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9Y-00083n-9B
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:53:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9T-00027s-OO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:53:13 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621NTPNw2526381
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 06:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WUoYGZm9XNgjLsMMj
 FnP48BXGy8iG+7lrSdLumsUB8w=; b=pDb/OJTtYKlxlcyK8hb4nC9b1T8CaMM7F
 ZXSgDZfZH+CPV0UShtiDuhoWd8/frIXbupUC4el/izx8Xf9fzve37XnUySgD7gjN
 CatMFjqil/q2CJsUZA0s8aJD2ItcZTJQacAT6+JRmahwkbRUzbGdz7JeQmRWQNSe
 HdOq7lrqQysibDKn1EODP7KJspyoGe3TQ/xCZ++HU22i0O02s7flsoUOc9vGtMEY
 gJ62h/k5lJYsjZ+9aWeJQDi3u1+yxKhF4yq0JlrpUfYujRtC+aJc8lbw+NZpz7Yg
 ioEVCmTaQFLF79D2xWoiTOLq9nxzSJ7atX2XgRN1l30mQ5sDdzINQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrhw984-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:53:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6224MvoK029748
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 06:53:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaprvu9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:53:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6226r5MD38076814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Mar 2026 06:53:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0242A20078;
 Mon,  2 Mar 2026 06:53:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8E6D20077;
 Mon,  2 Mar 2026 06:53:03 +0000 (GMT)
Received: from Mac.com (unknown [9.124.211.120])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Mar 2026 06:53:03 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 3/4] ppc/pnv: Add OCC FLAG registers
Date: Mon,  2 Mar 2026 12:22:16 +0530
Message-ID: <20260302065230.56220-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302065230.56220-1-harshpb@linux.ibm.com>
References: <20260302065230.56220-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a533d5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=C6aVSkDANSdmHkZ1WT0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA1NiBTYWx0ZWRfX+QoWoZA5h2bS
 /EJFbD+68BlUncKCXc5LUpjmKTe6ms2Z8UV0MejA5+4zY8CiE5wSAESzOhmTDVM6u9kcto2GzP/
 ATwvJxXX/667u2I0mBBldID7dTlr+lFhEzEbj/x4yOGgQzHWDBfWVZgQu+b5X5J9MGIXjK2RmVR
 28RqpbqsvRqw4QZwwKuU+6jEB5jGLoeIBqGbeSKPnYgIcc1REbFJkfTsCm6/BfFOz6IX2SzeY0Z
 peajgn4D+RLArp9Pm/Qf8JIe91P56ynuFqQTc+rhb+Pf80eKIT3X0r4LgH9AvTCsu9f8jJmjcSa
 OP12E94OPqJagG3LPh4vqG6iVNO8WG6xcbS0wYbpLJcYlFyXdC+d4wl4SZgSAkm6K/FZQofofz2
 11vUFEgUN8A8Aqj0hMwF7n7wql/oPVxfkgz//bnQ1CYoVpyHCf6jT0Ccislh1yLC7kND28BIK+T
 SYjLPbMgl7tljGqHfSg==
X-Proofpoint-GUID: dRR8AtUSA9GeQEVGsqV5u1A-v7WyhMnB
X-Proofpoint-ORIG-GUID: dRR8AtUSA9GeQEVGsqV5u1A-v7WyhMnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Caleb Schlossin <calebs@linux.ibm.com>

OCCFLG are scratch registers that can be shared with OCC firmware.
Log reads and writes to the registers as a reminder when we run
into more OCC code.

Add RW, WO_CLEAR and WO_OR SCOM Type enums in pnv_occ.c

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260210134647.2050821-4-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/pnv_occ.h |  4 +++
 hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 3 deletions(-)

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
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 64cab3e9dc..b9f69daffc 100644
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
-- 
2.52.0


