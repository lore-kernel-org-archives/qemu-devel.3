Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3E3CAC5AA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1Ta-0005dB-LC; Wed, 17 Sep 2025 19:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1TI-0005WI-0s; Wed, 17 Sep 2025 19:21:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1TG-0002Qc-5w; Wed, 17 Sep 2025 19:21:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHLYA8023594;
 Wed, 17 Sep 2025 23:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XP4LzJPHEb3JNWAJ7
 amQFcKcrUJ+fXHWWBo51JDQIUs=; b=i3Lh9v2ApROGBfVB39wKL6WAiFi4oN8IC
 B+7pFvPahddzAeRrkcyzTP3TcR5ze7kOkYyldAPCFhFTvFQ8vbjj5Gnl7QN/YB/7
 28S98KdZWwrcd1UMqM44uIQ0s4z55ET/AyQWKgYEysKd6Oar6Kh5KVoHaLiZaqHM
 V3/Bl9eo358yUjcDXRaUPElLLTnLlN1YnvFl8pKHdIcNvwh2vKY43F5q7fMeDJrg
 E1da3wFNtZabn45SxNTZCfhdHAD1jaV1voeAZs8OGdNv0dzfvuK0iPyt2K6nmau4
 0ZhtniUKRQyXYuTdaZTZX/vA+pzOiNvf7cnZ1WlSUWY+GqOBP/gHg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qpf1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HKGCRk006385;
 Wed, 17 Sep 2025 23:21:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxuc1mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:51 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNLoki32047660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:21:50 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A95705805C;
 Wed, 17 Sep 2025 23:21:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9924458051;
 Wed, 17 Sep 2025 23:21:49 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:21:49 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 15/28] hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
Date: Wed, 17 Sep 2025 19:21:17 -0400
Message-ID: <20250917232131.495848-16-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SwPENUtDeyTM77VlpPaTw--RyfUOtc78
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX4TcdhNN27XNf
 IXk6qgx6HxGEFCUiq6UmyFSxv8f2kf4Wi/4EwByvty7Z39RRRzxVFYTzrlfObPC8CagEVG4iz47
 ZGMAPN3v2ibxWnK0H7MaOlzLIWr8Xndw5jh1o+XG6gHt29MkqRCb01KCpyaMGaMSemznQEl5wng
 0LHTdUhr5YGnslwfxFRPIL1Eb0rCijAqLk78Mo0nH54khrcQEphVlKTcOFJMEC98nZXoXP8xjBZ
 l4dwf8YeGBdl55uKLnr/9H/yNHjO/rnV/+zzAtX+XNgnzKcrspKmekg4L1VXDPSB0UEKNXjT914
 la8vAU6ZyBVTjEYV4kDQXVJydHQLalgPdB6m03ShrZxFuEbY51Ig7L09hCwP8jHv5zHRu4i1rwl
 us9v8yPA
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cb4290 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=0RU0I6ilb4cTaI3NU4AA:9
X-Proofpoint-GUID: SwPENUtDeyTM77VlpPaTw--RyfUOtc78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add IPIB flags to IPL Parameter Block to determine if IPL needs to
perform securely and if IPL Information Report Block (IIRB) exists.

Move DIAG308 flags to a separated header file and add flags for secure IPL.

Secure boot in audit mode will perform if certificate(s) exist in the
key store. IIRB will exist and results of verification will be stored in
IIRB.

To ensure proper alignment of the IIRB and prevent overlap, set
iplb->len to the maximum length of the IPLB, allowing alignment
constraints to be determined based on its size.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c                 | 17 +++++++++++++++++
 hw/s390x/ipl.h                 | 18 +-----------------
 include/hw/s390x/ipl/diag308.h | 34 ++++++++++++++++++++++++++++++++++
 include/hw/s390x/ipl/qipl.h    |  5 ++++-
 4 files changed, 56 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/s390x/ipl/diag308.h

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 917166ba31..c1360905c4 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -494,6 +494,23 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
+        if (iplb->hdr_flags & DIAG308_IPIB_FLAGS_IPLIR) {
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
+        }
+
         return true;
     }
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index e26fc1cd6a..01922d80c4 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -23,7 +23,6 @@
 #include "qom/object.h"
 #include "target/s390x/kvm/pv.h"
 
-#define DIAG308_FLAGS_LP_VALID 0x80
 #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
@@ -91,22 +90,6 @@ struct S390IPLState {
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
@@ -117,6 +100,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
+#define S390_IPLB_MAX_LEN 4096
 
 static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
 {
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
index e505f44020..5c2bf3051c 100644
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
@@ -103,7 +105,8 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
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
2.50.1


