Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E7AC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7b-0007rq-II; Wed, 26 Aug 2026 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7X-0007pA-46; Wed, 26 Aug 2026 08:52:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7U-0002h2-HK; Wed, 26 Aug 2026 08:52:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCVtRs2127719; Wed, 26 Aug 2026 12:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=semDCzLkOI8fXXMpM
 DeIaY6EI7Q7Ey9Hvyag8eei41s=; b=qjXgjTytqj8SoVJUd+vlWFV1woTaWNbMO
 aOJZsZ6ofxzjdGS2W1OYEAvUeNSO/KhRzWh6+K3J+PJDImN6/ta8Tkj4lpH2RqCL
 o9NwB3hW8ZiFMszn+w/8oBZqAEyv4UeUAKEMLaRkj0fh5GRYmSeTVC+yTI+Q+yya
 x3BWOvH7CBPJ8dcPSE++Yfi48kwav5fBH3A98kO8S3VbvoWZl4JyaGFaMVevkKR/
 w0TBRjXftLzXNIfCOGgFA4qYHBnAu/f0xPa0FheEP2oZZZtcwJ0q/QK/D8AUvHDe
 mPtPLWFeC/Kpxrtc5HznLczD7o24uGgbA6cudUm0oskLedOqFzsNA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqxm93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfGfQ002326;
 Wed, 26 Aug 2026 12:52:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k1xx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqeLJ18088546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED56358059;
 Wed, 26 Aug 2026 12:52:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7F145805C;
 Wed, 26 Aug 2026 12:52:38 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:38 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 19/37] hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
Date: Wed, 26 Aug 2026 08:51:54 -0400
Message-ID: <20260826125213.1901252-20-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ekrd5Lc0OmkRukDJ_cNx2IutIimhGRwt
X-Proofpoint-ORIG-GUID: ekrd5Lc0OmkRukDJ_cNx2IutIimhGRwt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX0MDsmFgjQDiV
 HThXpwLAHs+ZODGIaaAedCzRCQy+pjLF8/00OzgmyklW6Zd79sgyrVY918HkV3QCF0DDNfOm/Pj
 VCRpe+cZGSL67DCCYHM8VZe6NTCdB8Lm81ngJGYfIgU/kPUA7kVKTgf4wf51GdOWRNqtX9X0tEf
 Aoj85MCHp6us6Rlv7GlnCpsMw0UdphLSfLRoW8Y6IkI7s0P/a7bB573oN7atUj0GfTJZO3zaJGW
 3Q9GLlzZ3BKVKZVM8zamhI5oIkCkP5G19E+RuKc1FVJqkLqgV+G5XvXZ/KmIOSnr3CkK7ZT5Ock
 ioO0Rrw2zsUjgx6t3rj+sUmLXOzV1RVEGCkLbzW4MG+Fo0WgSKcaZQN4VnsZPhNychTrWWvpkkI
 nIKW1RJxpbvmXyu9NrrIAHADWiIEG9Rwni2F6RkbvhVC9englU6EoF61a6RBz2B1yOwZyE8FgVe
 M+Z6u241eu9fR3o533w==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8ee19a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=W_WZRTZ8rNWSny1drpEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX8SEma5/BIDjx
 1KBv/9Q52I81yLpzF4wsYnNFaLGKXXvx6veu3NP/K8YvrK3s9IVL06x2wirpTfx5WFaj16csNEF
 4Ew1htpQcB6vPDfRjnjHFEPtJ4WW5CI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Add IPIB flags to IPL Parameter Block to determine if IPL needs to
perform securely and if IPL Information Report Block (IIRB) exists.

Move DIAG308 flags to a separated header file and add flags for secure IPL.
Move IPLB length related definitions to include/hw/s390x/ipl/qipl.h and
add a maximum length constant to support secure IPL.

Secure boot in audit mode will perform if certificate(s) exist in the
key store. IIRB will exist and results of verification will be stored in
IIRB.

To ensure proper alignment of the IIRB and prevent overlap, set
iplb->len to the maximum length of the IPLB, allowing alignment
constraints to be determined based on its size.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-18-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/ipl.c                 | 36 ++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h                 | 24 -----------------------
 include/hw/s390x/ipl/diag308.h | 34 ++++++++++++++++++++++++++++++++
 include/hw/s390x/ipl/qipl.h    | 13 +++++++++++-
 4 files changed, 82 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/s390x/ipl/diag308.h

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 2cae089d98..627544b361 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -462,6 +462,34 @@ S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
     return &ipl->cert_store;
 }
 
+static bool s390_has_certificate(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    return ipl->cert_store.count > 0;
+}
+
+static void s390_set_secure_boot_flags(IplParameterBlock *iplb,
+                                       bool audit_mode)
+{
+    if (!audit_mode) {
+        return;
+    }
+
+    /*
+     * For audit mode, enable the IPL Information
+     * Report (IPLIR) flag so that the firmware generates an IPL
+     * Information Report Block (IIRB).
+     *
+     * Results of secure boot will be stored in IIRB.
+     *
+     * Extend the IPL parameter block to its maximum length to ensure
+     * sufficient space for the BIOS to populate the IIRB.
+     */
+    iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
+    iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
+}
+
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
@@ -518,6 +546,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
+        s390_set_secure_boot_flags(iplb, s390_has_certificate());
+
         return true;
     }
 
@@ -654,6 +684,12 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
     } else {
         ipl->iplb = *iplb;
         ipl->iplb_valid = true;
+
+        /*
+         * The kernel does not preserve secure boot flags across a reboot.
+         * Re-apply them here based on the current machine configuration.
+         */
+        s390_set_secure_boot_flags(&ipl->iplb, s390_has_certificate());
     }
 
     update_machine_ipl_properties(iplb);
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index ec8ab153dc..5d54827b52 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -23,7 +23,6 @@
 #include "qom/object.h"
 #include "target/s390x/kvm/pv.h"
 
-#define DIAG308_FLAGS_LP_VALID 0x80
 #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
@@ -90,29 +89,6 @@ struct S390IPLState {
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
-#define S390_IPLB_HEADER_LEN 8
-#define S390_IPLB_MIN_PV_LEN 148
-#define S390_IPLB_MIN_CCW_LEN 200
-#define S390_IPLB_MIN_FCP_LEN 384
-#define S390_IPLB_MIN_PCI_LEN 376
-#define S390_IPLB_MIN_QEMU_SCSI_LEN 200
-
 static inline bool iplb_valid_len(IplParameterBlock *iplb)
 {
     return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
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
index 39017fbba8..6dccc74a9e 100644
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
@@ -33,6 +35,14 @@ typedef enum S390IplType S390IplType;
 
 #define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW
 
+#define S390_IPLB_HEADER_LEN 8
+#define S390_IPLB_MIN_PV_LEN 148
+#define S390_IPLB_MIN_CCW_LEN 200
+#define S390_IPLB_MIN_FCP_LEN 384
+#define S390_IPLB_MIN_PCI_LEN 376
+#define S390_IPLB_MIN_QEMU_SCSI_LEN 200
+#define S390_IPLB_MAX_LEN 4096
+
 #define MAX_CERTIFICATES  64
 /* largest supported block size - same as VIRTIO_DASD_DEFAULT_BLOCK_SIZE */
 #define VIRTIO_MAX_BLOCK_SIZE   4096
@@ -127,7 +137,8 @@ typedef struct IplBlockPci IplBlockPci;
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
2.55.0


