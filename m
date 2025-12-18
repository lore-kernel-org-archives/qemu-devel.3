Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4C8D6E2DC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 20:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWKEP-0005Q5-UV; Thu, 18 Dec 2025 15:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEM-0005O5-Mg; Thu, 18 Dec 2025 15:04:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEL-00084m-3f; Thu, 18 Dec 2025 15:04:10 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJmTED013835;
 Thu, 18 Dec 2025 20:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MFD3WOaxWcOQcNyMi
 MydX6i0nQ0MTp12mG8yxLmezf0=; b=Mx0YuxQGokNpsM0tXVFd1wT1317sxVU2U
 r/3oFacgIjNcEHD2SPUbPkIa8eclwEKWKcLlh9uN6X+BlQ/WasahUp0fDlFy6EQO
 xhd+UCv5LWgEyqyP++Ez0ghIDVh9q3Tq6/cCoSL5fSMgomakNcdATqoCcMrck3fI
 LSSNOsPJWC1Adae8EI32r24yesBije8RRdYu/U3KEuYxLDWwD5zAbKuuwCRtNd1s
 oZh1mzALKgH4Aef6pfH9dhnmUYvwP7D4RVwgs6PWLG+UynYkVE4ByTQrEgUo4A9w
 fcGfOzzYXypsyAupeKOF6tdjQtyvCQ8K/4ZTCOsomAiY2iNufBuog==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d02tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIK468c013865;
 Thu, 18 Dec 2025 20:04:07 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d02tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJXtig029544;
 Thu, 18 Dec 2025 20:04:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b4qvqr4nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:05 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIK44xf18809464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 20:04:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17DC658055;
 Thu, 18 Dec 2025 20:04:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACE2758043;
 Thu, 18 Dec 2025 20:04:03 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 20:04:03 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH 4/4] ppc/pnv: Add OCC FLAG registers
Date: Thu, 18 Dec 2025 14:03:53 -0600
Message-ID: <20251218200353.301866-5-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218200353.301866-1-calebs@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WYkBqkhX c=1 sm=1 tr=0 ts=69445e37 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=C6aVSkDANSdmHkZ1WT0A:9
X-Proofpoint-GUID: uBhkv_ehkZOhH3M6BkNQTRDxduOu7sw7
X-Proofpoint-ORIG-GUID: 8L7A2eHLtH8hvvkYOBspBYGAX1LAcz0o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2NCBTYWx0ZWRfX7gvaX2o8Y76T
 /rci6LKvWokVF8Wgc2BY4UeZdvahDjfZhF7dkWgyjMOQd2OeFYqjFj2AE9Vu3irbIpKLwwRos1c
 hMG5Gf94bdsGZyaLis9p1hFZ5LutCuwsmlOEi1FJnsJoChsdzHTOYDeXiVFjD0KmZWd/pyGT4sZ
 UZwY9bZwMR1Ick5gx1ZN3jO6Zz0uxMlBxdLvHSyzNSIm9eozR3TCK0h1mG349qzRB0C+oaPNWIJ
 cyS/HxgKYQCefeXgnhshGax5YUNmgST7BHAiLSHmDIMTQD4Q4BiU76BNarE2LPluUk+KkBZ74vP
 +/4TtGSponEgnsNpMtVGI4lRzPE9818qsZsTiX7SrIjVs7jEyM25NLsHb6ASYXDRxkb/fOLMceC
 vg160qIFFfT0Q1BnvkxgnqiHzPNBmVjzd4oVOHq0sWAYJToqfPEiYIQ0PT7I1hwz4CAPr/xvhRS
 P6+/0ogXyOxQ2zdqfDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512180164
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

OCCFLG are scratch registers that can be shared with OCC firmware.
Log reads and writes to the registers as a reminder when we run
into more OCC code.

Add RW, WO_CLEAR and WO_OR SCOM Type enums in pnv_occ.c

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++++++++++++---
 include/hw/ppc/pnv_occ.h |  4 +++
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 24b789c191..e605ae0fbc 100644
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
+     * hence devide by 3 to get flag index and mod 3 to get SCOM type.
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
index 013ea2e53e..8c9f1416eb 100644
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


