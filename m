Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE7D3C912
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2KmW-0000Lg-1K; Sat, 19 Oct 2024 21:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Kly-0008TO-Sq; Sat, 19 Oct 2024 21:30:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klw-0005QR-Pa; Sat, 19 Oct 2024 21:30:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JFP8XE018361;
 Sun, 20 Oct 2024 01:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FE2kBH2KVAs0bEoEk
 eM9AWo8BWkBeyGKzMjsgfo91+E=; b=QotMy6EH/8NWZ1NZjVPo9eyhpuIKoX9FJ
 0b7Ubui+6P8sIfxXDM5QRGmgtwbOc77R6KO8exdza+amxCTvH8uFXlNjh+w2wsyE
 ln6Ugwfi/HWWLC7+FTFNN18aNfs//21ZMCQy9EIAmRo2ejF6tY9+H6iKRtajj6Oz
 0JBGdv7dV9pYovW67bLJ4PImTNHxHToJc5PFoyIz/p2MIecZXtCF5ut0OU3Lmvlk
 hBaMVGZKCr+0NG+5+ib4IIsps2L4YnvmUlvB/8tXwwuaW2xOewUQXGMtL3Fb5nkN
 x1eC28QSL76PzkQPFnqBNDTwNCHUeF0ZAErZeAn96tiZ0pntizwIA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5h2u6ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K0g08u005377;
 Sun, 20 Oct 2024 01:30:18 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njuc04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1UGeX27394646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:30:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A466C5805C;
 Sun, 20 Oct 2024 01:30:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F34DD58054;
 Sun, 20 Oct 2024 01:30:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:30:15 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 13/19] include/hw/s390x: Add include files for common IPL
 structs
Date: Sat, 19 Oct 2024 21:29:47 -0400
Message-ID: <20241020012953.1380075-14-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: byp2QnvmBLxt3Jeh93SUT0KPFujYE9Ih
X-Proofpoint-ORIG-GUID: byp2QnvmBLxt3Jeh93SUT0KPFujYE9Ih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410200009
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Currently, structures defined in both hw/s390x/ipl.h and pc-bios/s390-ccw/iplb.h
must be kept in sync, which is prone to error. Instead, create a new directory
at include/hw/s390x/ipl/ to contain the definitions that must be shared.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.h              | 104 +-----------------------------
 include/hw/s390x/ipl/qipl.h | 123 ++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/iplb.h     |  84 ++----------------------
 pc-bios/s390-ccw/Makefile   |   2 +-
 4 files changed, 130 insertions(+), 183 deletions(-)
 create mode 100644 include/hw/s390x/ipl/qipl.h

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index b2105b616a..fa394c339d 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -16,95 +16,11 @@
 #include "cpu.h"
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
+#include "hw/s390x/ipl/qipl.h"
 #include "qom/object.h"
 
-struct IPLBlockPVComp {
-    uint64_t tweak_pref;
-    uint64_t addr;
-    uint64_t size;
-} QEMU_PACKED;
-typedef struct IPLBlockPVComp IPLBlockPVComp;
-
-struct IPLBlockPV {
-    uint8_t  reserved18[87];    /* 0x18 */
-    uint8_t  version;           /* 0x6f */
-    uint32_t reserved70;        /* 0x70 */
-    uint32_t num_comp;          /* 0x74 */
-    uint64_t pv_header_addr;    /* 0x78 */
-    uint64_t pv_header_len;     /* 0x80 */
-    struct IPLBlockPVComp components[0];
-} QEMU_PACKED;
-typedef struct IPLBlockPV IPLBlockPV;
-
-struct IplBlockCcw {
-    uint8_t  reserved0[85];
-    uint8_t  ssid;
-    uint16_t devno;
-    uint8_t  vm_flags;
-    uint8_t  reserved3[3];
-    uint32_t vm_parm_len;
-    uint8_t  nss_name[8];
-    uint8_t  vm_parm[64];
-    uint8_t  reserved4[8];
-} QEMU_PACKED;
-typedef struct IplBlockCcw IplBlockCcw;
-
-struct IplBlockFcp {
-    uint8_t  reserved1[305 - 1];
-    uint8_t  opt;
-    uint8_t  reserved2[3];
-    uint16_t reserved3;
-    uint16_t devno;
-    uint8_t  reserved4[4];
-    uint64_t wwpn;
-    uint64_t lun;
-    uint32_t bootprog;
-    uint8_t  reserved5[12];
-    uint64_t br_lba;
-    uint32_t scp_data_len;
-    uint8_t  reserved6[260];
-    uint8_t  scp_data[0];
-} QEMU_PACKED;
-typedef struct IplBlockFcp IplBlockFcp;
-
-struct IplBlockQemuScsi {
-    uint32_t lun;
-    uint16_t target;
-    uint16_t channel;
-    uint8_t  reserved0[77];
-    uint8_t  ssid;
-    uint16_t devno;
-} QEMU_PACKED;
-typedef struct IplBlockQemuScsi IplBlockQemuScsi;
-
 #define DIAG308_FLAGS_LP_VALID 0x80
 
-union IplParameterBlock {
-    struct {
-        uint32_t len;
-        uint8_t  reserved0[3];
-        uint8_t  version;
-        uint32_t blk0_len;
-        uint8_t  pbt;
-        uint8_t  flags;
-        uint16_t reserved01;
-        uint8_t  loadparm[8];
-        union {
-            IplBlockCcw ccw;
-            IplBlockFcp fcp;
-            IPLBlockPV pv;
-            IplBlockQemuScsi scsi;
-        };
-    } QEMU_PACKED;
-    struct {
-        uint8_t  reserved1[110];
-        uint16_t devno;
-        uint8_t  reserved2[88];
-        uint8_t  reserved_ext[4096 - 200];
-    } QEMU_PACKED;
-} QEMU_PACKED;
-typedef union IplParameterBlock IplParameterBlock;
-
 int s390_ipl_set_loadparm(uint8_t *loadparm);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 int s390_ipl_prepare_pv_header(Error **errp);
@@ -131,24 +47,6 @@ void s390_ipl_clear_reset_request(void);
 #define QIPL_FLAG_BM_OPTS_CMD   0x80
 #define QIPL_FLAG_BM_OPTS_ZIPL  0x40
 
-/*
- * The QEMU IPL Parameters will be stored at absolute address
- * 204 (0xcc) which means it is 32-bit word aligned but not
- * double-word aligned. Placement of 64-bit data fields in this
- * area must account for their alignment needs.
- * The total size of the struct must never exceed 28 bytes.
- * This definition must be kept in sync with the definition
- * in pc-bios/s390-ccw/iplb.h.
- */
-struct QemuIplParameters {
-    uint8_t  qipl_flags;
-    uint8_t  reserved1[3];
-    uint64_t reserved2;
-    uint32_t boot_menu_timeout;
-    uint8_t  reserved3[12];
-} QEMU_PACKED;
-typedef struct QemuIplParameters QemuIplParameters;
-
 #define TYPE_S390_IPL "s390-ipl"
 OBJECT_DECLARE_SIMPLE_TYPE(S390IPLState, S390_IPL)
 
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
new file mode 100644
index 0000000000..0ef04af027
--- /dev/null
+++ b/include/hw/s390x/ipl/qipl.h
@@ -0,0 +1,123 @@
+/*
+ * S/390 boot structures
+ *
+ * Copyright 2024 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef S390X_QIPL_H
+#define S390X_QIPL_H
+
+/* Boot Menu flags */
+#define QIPL_FLAG_BM_OPTS_CMD   0x80
+#define QIPL_FLAG_BM_OPTS_ZIPL  0x40
+
+#define QIPL_ADDRESS  0xcc
+#define LOADPARM_LEN    8
+
+/*
+ * The QEMU IPL Parameters will be stored at absolute address
+ * 204 (0xcc) which means it is 32-bit word aligned but not
+ * double-word aligned. Placement of 64-bit data fields in this
+ * area must account for their alignment needs.
+ * The total size of the struct must never exceed 28 bytes.
+ */
+struct QemuIplParameters {
+    uint8_t  qipl_flags;
+    uint8_t  reserved1[3];
+    uint64_t reserved2;
+    uint32_t boot_menu_timeout;
+    uint8_t  reserved3[12];
+} QEMU_PACKED;
+typedef struct QemuIplParameters QemuIplParameters;
+
+struct IPLBlockPVComp {
+    uint64_t tweak_pref;
+    uint64_t addr;
+    uint64_t size;
+} QEMU_PACKED;
+typedef struct IPLBlockPVComp IPLBlockPVComp;
+
+struct IPLBlockPV {
+    uint8_t  reserved18[87];    /* 0x18 */
+    uint8_t  version;           /* 0x6f */
+    uint32_t reserved70;        /* 0x70 */
+    uint32_t num_comp;          /* 0x74 */
+    uint64_t pv_header_addr;    /* 0x78 */
+    uint64_t pv_header_len;     /* 0x80 */
+    struct IPLBlockPVComp components[0];
+} QEMU_PACKED;
+typedef struct IPLBlockPV IPLBlockPV;
+
+struct IplBlockCcw {
+    uint8_t  reserved0[85];
+    uint8_t  ssid;
+    uint16_t devno;
+    uint8_t  vm_flags;
+    uint8_t  reserved3[3];
+    uint32_t vm_parm_len;
+    uint8_t  nss_name[8];
+    uint8_t  vm_parm[64];
+    uint8_t  reserved4[8];
+} QEMU_PACKED;
+typedef struct IplBlockCcw IplBlockCcw;
+
+struct IplBlockFcp {
+    uint8_t  reserved1[305 - 1];
+    uint8_t  opt;
+    uint8_t  reserved2[3];
+    uint16_t reserved3;
+    uint16_t devno;
+    uint8_t  reserved4[4];
+    uint64_t wwpn;
+    uint64_t lun;
+    uint32_t bootprog;
+    uint8_t  reserved5[12];
+    uint64_t br_lba;
+    uint32_t scp_data_len;
+    uint8_t  reserved6[260];
+    uint8_t  scp_data[0];
+} QEMU_PACKED;
+typedef struct IplBlockFcp IplBlockFcp;
+
+struct IplBlockQemuScsi {
+    uint32_t lun;
+    uint16_t target;
+    uint16_t channel;
+    uint8_t  reserved0[77];
+    uint8_t  ssid;
+    uint16_t devno;
+} QEMU_PACKED;
+typedef struct IplBlockQemuScsi IplBlockQemuScsi;
+
+union IplParameterBlock {
+    struct {
+        uint32_t len;
+        uint8_t  reserved0[3];
+        uint8_t  version;
+        uint32_t blk0_len;
+        uint8_t  pbt;
+        uint8_t  flags;
+        uint16_t reserved01;
+        uint8_t  loadparm[LOADPARM_LEN];
+        union {
+            IplBlockCcw ccw;
+            IplBlockFcp fcp;
+            IPLBlockPV pv;
+            IplBlockQemuScsi scsi;
+        };
+    } QEMU_PACKED;
+    struct {
+        uint8_t  reserved1[110];
+        uint16_t devno;
+        uint8_t  reserved2[88];
+        uint8_t  reserved_ext[4096 - 200];
+    } QEMU_PACKED;
+} QEMU_PACKED;
+typedef union IplParameterBlock IplParameterBlock;
+
+#endif
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 3758698468..16643f5879 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -12,88 +12,14 @@
 #ifndef IPLB_H
 #define IPLB_H
 
-#define LOADPARM_LEN    8
+#ifndef QEMU_PACKED
+#define QEMU_PACKED __attribute__((packed))
+#endif
 
-struct IplBlockCcw {
-    uint8_t  reserved0[85];
-    uint8_t  ssid;
-    uint16_t devno;
-    uint8_t  vm_flags;
-    uint8_t  reserved3[3];
-    uint32_t vm_parm_len;
-    uint8_t  nss_name[8];
-    uint8_t  vm_parm[64];
-    uint8_t  reserved4[8];
-} __attribute__ ((packed));
-typedef struct IplBlockCcw IplBlockCcw;
-
-struct IplBlockFcp {
-    uint8_t  reserved1[305 - 1];
-    uint8_t  opt;
-    uint8_t  reserved2[3];
-    uint16_t reserved3;
-    uint16_t devno;
-    uint8_t  reserved4[4];
-    uint64_t wwpn;
-    uint64_t lun;
-    uint32_t bootprog;
-    uint8_t  reserved5[12];
-    uint64_t br_lba;
-    uint32_t scp_data_len;
-    uint8_t  reserved6[260];
-    uint8_t  scp_data[];
-} __attribute__ ((packed));
-typedef struct IplBlockFcp IplBlockFcp;
-
-struct IplBlockQemuScsi {
-    uint32_t lun;
-    uint16_t target;
-    uint16_t channel;
-    uint8_t  reserved0[77];
-    uint8_t  ssid;
-    uint16_t devno;
-} __attribute__ ((packed));
-typedef struct IplBlockQemuScsi IplBlockQemuScsi;
-
-struct IplParameterBlock {
-    uint32_t len;
-    uint8_t  reserved0[3];
-    uint8_t  version;
-    uint32_t blk0_len;
-    uint8_t  pbt;
-    uint8_t  flags;
-    uint16_t reserved01;
-    uint8_t  loadparm[LOADPARM_LEN];
-    union {
-        IplBlockCcw ccw;
-        IplBlockFcp fcp;
-        IplBlockQemuScsi scsi;
-    };
-} __attribute__ ((packed));
-typedef struct IplParameterBlock IplParameterBlock;
-
-extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
-
-#define QIPL_ADDRESS  0xcc
-
-/* Boot Menu flags */
-#define QIPL_FLAG_BM_OPTS_CMD   0x80
-#define QIPL_FLAG_BM_OPTS_ZIPL  0x40
-
-/*
- * This definition must be kept in sync with the definition
- * in hw/s390x/ipl.h
- */
-struct QemuIplParameters {
-    uint8_t  qipl_flags;
-    uint8_t  reserved1[3];
-    uint64_t reserved2;
-    uint32_t boot_menu_timeout;
-    uint8_t  reserved3[12];
-} __attribute__ ((packed));
-typedef struct QemuIplParameters QemuIplParameters;
+#include <qipl.h>
 
 extern QemuIplParameters qipl;
+extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 27cbb354af..db9e8f0892 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -3,7 +3,7 @@ all: build-all
 	@true
 
 include config-host.mak
-CFLAGS = -O2 -g
+CFLAGS = -O2 -g -I $(SRC_PATH)/../../include/hw/s390x/ipl
 MAKEFLAGS += -rR
 
 GIT_SUBMODULES = roms/SLOF
-- 
2.45.1


