Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75341EA8115
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo57-0007VX-Pq; Tue, 10 Feb 2026 08:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpo52-0007TI-Na; Tue, 10 Feb 2026 08:47:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpo51-00052r-3w; Tue, 10 Feb 2026 08:47:04 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61ACpZIb693544; Tue, 10 Feb 2026 13:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cdBVwGCxSnxrDjWE2
 y41YmM3oFnGfVhqTyW79zwjnm4=; b=UR6kNHqtXJnnPz1DZ6gHzFOI9EXOA9GEP
 wIoXRfUAmgfbOzk3Hmwx7udbIkxdIOzsFb1elDndCnL2Xq6YdeKcqgBWTwCa5UnV
 GapyHAThL+bNsfmYRwEYFEVa31hItUU5LjQVUuSoSgPBfjS9ZBVe6ly1gbE+4iF3
 PhEntCL+b0xENCNvhEl/OuHwKx/Pr/qg1qVpsQx4RSbz0GPRoLi87+nxzWrXqsOG
 rWZ6NN9lNTBICfKjKbeSUBm5/c4ArhRuhGI7Dqy4EuuRBFx8LYzZ70GwQk37qv/F
 UkP+150X8Y3vLkedHkPuptV6KNhQCoW63Bt9ihlqe9ixlL43KRlnA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w4fdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:47:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61ADag0g002570;
 Tue, 10 Feb 2026 13:46:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqshp6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:46:59 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADkbUC17105582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:46:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8592458050;
 Tue, 10 Feb 2026 13:46:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78F7858052;
 Tue, 10 Feb 2026 13:46:56 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:46:56 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2 3/3] ppc/pnv: Add OCC FLAG registers
Date: Tue, 10 Feb 2026 07:46:47 -0600
Message-ID: <20260210134647.2050821-4-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210134647.2050821-1-calebs@linux.ibm.com>
References: <20260210134647.2050821-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698b36d4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=C6aVSkDANSdmHkZ1WT0A:9
X-Proofpoint-GUID: WbqG-GKoTm8N6qVWTnXr2swSj6EnplAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNiBTYWx0ZWRfX77ZSgSLBPct/
 p017PCMlqiiqGUXAu/007QIW+JHIAQAX2WwPJXMM92F3R7698UeidPFfSkXN7lAqv16M3QFlAdW
 uLn6md63+J30xrb1Aqknc/yMnlTJtkGoa15OCDaBWqgPbbQJwMtN+1QacRGTExJwCCnekk9/Hg1
 qZODfrQ4CBVfsDnz5wlLHoGNX4gKL0PWHFMSjF8nceZgp6w5Sp60qRRtwZLP5pTN4NweoOcHNzs
 iqRYD2uQCbVKlvo7vCvfhmuzm744c7A3HdNPDKGBid4VsvMuw+cBamI0ynihkxK308d6qWIJeLg
 zS5nj0tASxHRcs8ThHprIeoo+R0OMNg3XegYpRFsyMCTX3OCerPAbzxjo9PerQZwXD3nx8dx8Tc
 9CT/ilD3oEd+YtvgTBiXcB3xDl7gQt4B4QttZJ5tmCjOL0Htg2so8dbIPciGvJBI2PEJWq02p4y
 sEGT8+kF8Jz+rQN5bow==
X-Proofpoint-ORIG-GUID: sroMu-xwT8OnZWEbNmlvzqi4x4n-a1_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100116
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


