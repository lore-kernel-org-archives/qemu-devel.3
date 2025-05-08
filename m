Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57925C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5t-0004d1-Mo; Thu, 08 May 2025 18:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5e-0004C2-Bv; Thu, 08 May 2025 18:51:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5c-0006VL-IR; Thu, 08 May 2025 18:51:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548KFp4H006956;
 Thu, 8 May 2025 22:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GYGJR0L6Fd1s8K6yX
 CxTTpHLE+v8+O5x8YkA1MZ0TM4=; b=lfYj++1VBFeY7VJo7Y/TFdcHM2wOJSSQz
 2ihelUAD4IRarz2sDLYuLzPUvfISV/th7wLj6ayU19Z9cDHNdv6P+xmjj9rxCbbA
 /qNKzIWmJPM9NdOKZKkDVHJw3dPwx4MezIKHSeVryT1HLVJm2AqIDOjVvAB1b/8X
 Ya4GF2cVaA/J+gyqhy594bYofpSlaw80RYP67BTFuF0+2Pd9sMo5NybVHc9einpi
 1CsVf6vTB8b/kPLspq+H6+tVxM2IcouAKmwYAg0Hu9NSHSnoAeZCNFEF3T0j2189
 J20rlh8vUX7kut0wh2BbcQA/KAuQ/xbLLTZCN+qQuRCsEIR4AdUdA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ghg2drgy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548MoVuF013880;
 Thu, 8 May 2025 22:51:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062qrge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mpaif25624974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C9E758055;
 Thu,  8 May 2025 22:51:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C6575804B;
 Thu,  8 May 2025 22:51:35 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:35 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 12/25] hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
Date: Thu,  8 May 2025 18:50:28 -0400
Message-ID: <20250508225042.313672-13-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: inZc7tsffj9LsFC6rT2KNC4diyOM3G_C
X-Authority-Analysis: v=2.4 cv=VJLdn8PX c=1 sm=1 tr=0 ts=681d357a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pRDxXoIMCsLN3o0rcVsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX3ScDeJLkkUhb
 tm1Lf7AxjytHwRKoPqMmkZERQXniKIyyEDcRsjdaRRCPjq2e1tACsDMXdKR6IfnLUM5Nz6xhgms
 d//jI6gZupnBeVEOOkOwd639NWL+jjUlGFv/spSv9/n0wtY7QnMmeA9yT0tM31PRLYcr1TxSeiu
 DWbz1Vf1XDgctX0iaYhSbKCFwW0EBr7a6sz9/GQFikr1mDtDkFeP4FHT03aQTzu9cP1O6vp9C5s
 NkFH1qJY2gXNg9vleIRz7N3h/SWsGqK0zqYMCUqNv81iidJDsnUza8zMnzNdWby3SKc0C9HmcK2
 HLpV1iwbQy2I1Wu02esxTOzlaQ43ioSV2ZrVmCJh+1TSI9hil4s4/TM9q4lXzKuENqU1/KDM8dv
 +MdYgsWZKL91Fhw4FaNN4SE+9hZ8qHVPNtzogED3sxzWv+wFpjsFw1VtB7vf16vYQNP+n2Td
X-Proofpoint-ORIG-GUID: inZc7tsffj9LsFC6rT2KNC4diyOM3G_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add IPIB flags to IPL Parameter Block to determine if IPL needs to
perform securely and if IPL Information Report Block (IIRB) exists.

Move DIAG308 flags to a separated header file and add flags for secure IPL.

Secure boot in audit mode will perform if certificate(s) exist in the
key store. IIRB will exist and results of verification will be stored in
IIRB.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c                 | 20 ++++++++++++++++++++
 hw/s390x/ipl.h                 | 17 -----------------
 include/hw/s390x/ipl/diag308.h | 34 ++++++++++++++++++++++++++++++++++
 include/hw/s390x/ipl/qipl.h    |  5 ++++-
 4 files changed, 58 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/s390x/ipl/diag308.h

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 186be923d7..8ac0cee73d 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -430,6 +430,13 @@ S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
     return &ipl->cert_store;
 }
 
+static bool s390_has_certificate(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    return ipl->cert_store.count > 0;
+}
+
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
@@ -487,6 +494,19 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
+        /*
+         * Secure boot in audit mode will perform
+         * if certificate(s) exist in the key store.
+         *
+         * IPL Information Report Block (IIRB) will exist
+         * for secure boot in audit mode.
+         *
+         * Results of secure boot will be stored in IIRB.
+         */
+        if (s390_has_certificate()) {
+            iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
+        }
+
         return true;
     }
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index b4d4566293..3e7190c7d8 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -25,7 +25,6 @@
 #include "qom/object.h"
 #include "target/s390x/kvm/pv.h"
 
-#define DIAG308_FLAGS_LP_VALID 0x80
 #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
@@ -92,22 +91,6 @@ struct S390IPLState {
 };
 QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 
-#define DIAG_308_RC_OK              0x0001
-#define DIAG_308_RC_NO_CONF         0x0102
-#define DIAG_308_RC_INVALID         0x0402
-#define DIAG_308_RC_NO_PV_CONF      0x0902
-#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
-
-#define DIAG308_RESET_MOD_CLR       0
-#define DIAG308_RESET_LOAD_NORM     1
-#define DIAG308_LOAD_CLEAR          3
-#define DIAG308_LOAD_NORMAL_DUMP    4
-#define DIAG308_SET                 5
-#define DIAG308_STORE               6
-#define DIAG308_PV_SET              8
-#define DIAG308_PV_STORE            9
-#define DIAG308_PV_START            10
-
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_PV 0x05
diff --git a/include/hw/s390x/ipl/diag308.h b/include/hw/s390x/ipl/diag308.h
new file mode 100644
index 0000000000..6e62f29215
--- /dev/null
+++ b/include/hw/s390x/ipl/diag308.h
@@ -0,0 +1,34 @@
+/*
+ * S/390 DIAGNOSE 308 definitions and structures
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef S390X_DIAG308_H
+#define S390X_DIAG308_H
+
+#define DIAG_308_RC_OK              0x0001
+#define DIAG_308_RC_NO_CONF         0x0102
+#define DIAG_308_RC_INVALID         0x0402
+#define DIAG_308_RC_NO_PV_CONF      0x0902
+#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
+
+#define DIAG308_RESET_MOD_CLR       0
+#define DIAG308_RESET_LOAD_NORM     1
+#define DIAG308_LOAD_CLEAR          3
+#define DIAG308_LOAD_NORMAL_DUMP    4
+#define DIAG308_SET                 5
+#define DIAG308_STORE               6
+#define DIAG308_PV_SET              8
+#define DIAG308_PV_STORE            9
+#define DIAG308_PV_START            10
+
+#define DIAG308_FLAGS_LP_VALID 0x80
+
+#define DIAG308_IPIB_FLAGS_SIPL 0x40
+#define DIAG308_IPIB_FLAGS_IPLIR 0x20
+
+#endif
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index b8e7d1da71..7126ec2a21 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -12,6 +12,8 @@
 #ifndef S390X_QIPL_H
 #define S390X_QIPL_H
 
+#include "diag308.h"
+
 /* Boot Menu flags */
 #define QIPL_FLAG_BM_OPTS_CMD   0x80
 #define QIPL_FLAG_BM_OPTS_ZIPL  0x40
@@ -104,7 +106,8 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 union IplParameterBlock {
     struct {
         uint32_t len;
-        uint8_t  reserved0[3];
+        uint8_t  hdr_flags;
+        uint8_t  reserved0[2];
         uint8_t  version;
         uint32_t blk0_len;
         uint8_t  pbt;
-- 
2.49.0


