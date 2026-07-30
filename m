Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B4BC55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYav-0001w0-SX; Thu, 30 Jul 2026 17:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYat-0001sn-QG; Thu, 30 Jul 2026 17:47:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYas-0002OY-1V; Thu, 30 Jul 2026 17:47:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJloki3976271; Thu, 30 Jul 2026 21:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cZfIDOApUhrzitfqk
 6Qy0anM8pQS+HmNaqOitiXAwOI=; b=Lqstoohgs156cytBO3w+7UW32+JV8JYYq
 HdTQZurgn1OTlfWzevEgCJUK9uilnkTfkr0o2x5EXhEJUZZ8ak0xS8JyA+hXNqJs
 mNRcKaC4WNrXTemdEm6Xt03yZWTQtqe+pQYcdcwoNZkkWnZFW1RoZY8F4O0Uxf7H
 OiWOtblFpTbbncVLKPk7ZvFrtUx0gX5roz9Ei5h8Owy7AvikCYkREekfginFOxG5
 3o3LvXawCqp73+aJvlUHiDG7M/EneTXhtlbDvsHDKFpeqJoV5N1mfEfDArEDLiPW
 uSClXvThxZzqkjOosQG+JxW+1im65eDnbNUGadAVkwxnFmhvU9jPQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y23g4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfGWl005881;
 Thu, 30 Jul 2026 21:47:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqnf7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULl4ON28246630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:47:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF3358059;
 Thu, 30 Jul 2026 21:47:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04AD758043;
 Thu, 30 Jul 2026 21:47:02 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:47:01 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 17/34] hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
Date: Thu, 30 Jul 2026 17:46:06 -0400
Message-ID: <20260730214624.2328883-18-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cd6lx-3eH6dxJZmSdLhFj8-_2mf30ewM
X-Proofpoint-ORIG-GUID: Cd6lx-3eH6dxJZmSdLhFj8-_2mf30ewM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfX1ZQadQPhuxsL
 r0IQE4AugbR1XoNxzwUbwfoIgPKJdtDbFTI//WUv7cKeTQ9pfdr9qHpbpR172vlOglZVqTTPRfi
 HKR6myyJpA+pZkXbrtzxcgAYwnQYYfI=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6bc65a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=ZDXLRS20C3ackK2NFGcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfXzau6Y2HNJPEe
 PTsPr5rPq6PYmRL2hQriphH7KH4Sr6DdUE7Ei2GCBY+26fCQt7yxBiwV20cG+bpQ/CSoRs0N7pf
 nGlnuWY586EBYz5O5iU+gk/BPvAATe6EU7LWRtiA54ffxCUmcNrGIBMP+xBKcHt9AGtFyKoMExA
 QGBo5ZwOeun/+Rj+bAXLtIHiAXa9nERVAY85+O+lS9uTR3CsijCqGXGCqvhi0an94q7EGyk1ntW
 l5WYQkmuABqU4VEFlUI6mRgD7OIm+BYAE697EpDt5cpMdq9OmAWAsKqo+X4ki8dbUIm14Q3TKxf
 55N27vuc5woTVf8BHdakx7ZS7G5bd0H8Ne1rLGKFfS2f7CjLM6VxVUKiN4chuJusCfj6uAhQ0KS
 6uWYAxzGE/4aBjJ309cs5vf9xgE/bFxnerHe96rJo2W/+26zQIkv6bJPPikAg0VDS1xTmDrOEom
 eSOE17LNSZn3gr1MxSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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
index f5a49a4431..9807ef18f2 100644
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
index 9940f1457c..a2180719b1 100644
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
@@ -31,6 +33,14 @@ typedef enum S390IplType S390IplType;
 
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
@@ -125,7 +135,8 @@ typedef struct IplBlockPci IplBlockPci;
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


