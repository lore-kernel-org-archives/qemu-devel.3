Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB2EA852F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzObp-0006Oo-Kf; Sun, 08 Mar 2026 20:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObm-0006Nn-Sm; Sun, 08 Mar 2026 20:36:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObl-0001fy-20; Sun, 08 Mar 2026 20:36:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628504Ij3809069; Mon, 9 Mar 2026 00:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YXYdv5k7wNRj1Ka9y
 slxKPKoDmRI9L+iSIxT2osA1Dc=; b=ppWVkgO5By8vkTqlwAHWm8TSyffzSlauS
 73kHDUMwL97ndaxD0EpbM8nd0EuAsSj+NMqQG0Bk0fS4wVpwE4V605BAEJ1ia0q8
 G3bairYnQWmSzMrq+vj35iheiRSMveG9UK2eXdWtdsQaaBl0BPU/Wub+c3cJI61p
 0MO+AexRDAN4u8d7Rg3ZaZmwmQRx0BUS7tUB7bOWwNUDwGwOGa368VOAqtTqdDmN
 A3uo2yJVvr1efJheUBAZpzjJGLOrur5L6GLyANuUtibQk/qNp80K8w0VG8/B/OSO
 Uu5kqAqlHrUH/W1C9ck+q5TREqhCSNivGYWi8g4/NuU/zSLs/fcaQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuy4kdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628LiijO023337;
 Mon, 9 Mar 2026 00:36:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cryukawfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290aOjC16450152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 965CB58045;
 Mon,  9 Mar 2026 00:36:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8099E58052;
 Mon,  9 Mar 2026 00:36:23 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:23 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 10/15] pc-bios/s390-ccw: Introduce PCI device
Date: Sun,  8 Mar 2026 20:35:56 -0400
Message-ID: <20260309003601.242634-11-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69ae160b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=p5Q4SJhZOU-7DgXL5goA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfX5NSt2mYq4KcE
 OOL1t/r5QLznkdprW5Ir2YbLY7ae9PayZkVd/3xo3vHRHksmPEKwq1DDOthOHJSp/oH0eRkTHia
 dXDSPfnvbQ5tMDM1obOvl40yquhBNiWaY+JJlIZQyTUxM389pFH+zgbJxahJNpyFEnZsHblneoD
 uP6RPt4J4voLPF28/RF9EFQuPti8LeQ9Dk1ullQwcusBqKTtWduBQfbmpCjV4+PVmIqZ+MJhcSw
 S1r5A9nMvkMabryvmfJxeo9GxHPUGEIRGIZSrpeZEL2cpGgRJESMgvKNivAmPiDNAzwyN+fhg98
 07/IISMT15i1raLyyxHPy+/d0aKzT1hjQXK6MSQfM04/J/V9qQXSQCrPuit/qFn3c8GdAd2mqMH
 MJJQSIlojBruqWbitrl/pzI321dqFlJ5AYrwJlVTSHW7Aixbf8SMKsiDy+I+iWL6z6xJvit8MsG
 Hfh40P06KGgER2b2BpA==
X-Proofpoint-GUID: P-61P7K82MmanN8WpJ9FJSS9E478M8JR
X-Proofpoint-ORIG-GUID: P-61P7K82MmanN8WpJ9FJSS9E478M8JR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Define selected s390x PCI instructions.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile |   2 +-
 pc-bios/s390-ccw/pci.c    | 118 ++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/pci.h    |  39 +++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/pci.c
 create mode 100644 pc-bios/s390-ccw/pci.h

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 9c29548f84..a62fc9d766 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-	  virtio-ccw.o clp.o
+	  virtio-ccw.o clp.o pci.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
new file mode 100644
index 0000000000..247070e5f0
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.c
@@ -0,0 +1,118 @@
+/*
+ * s390x PCI functionality
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "clp.h"
+#include "pci.h"
+#include "bswap.h"
+#include <stdio.h>
+#include <stdbool.h>
+
+/* PCI load */
+static inline int pcilg(uint64_t *data, uint64_t req, uint64_t offset,
+                        uint8_t *status)
+{
+    union register_pair req_off = {.even = req, .odd = offset};
+    int cc = -1;
+    uint64_t __data;
+
+    asm volatile (
+        "     .insn   rre,0xb9d20000,%[data],%[req_off]\n"
+        "     ipm     %[cc]\n"
+        "     srl     %[cc],28\n"
+        : [cc] "+d" (cc), [data] "=d" (__data),
+          [req_off] "+d" (req_off.pair) :: "cc");
+    *status = req_off.even >> 24 & 0xff;
+    *data = __data;
+    return cc;
+}
+
+/* PCI store */
+static inline int pcistg(uint64_t data, uint64_t req, uint64_t offset,
+                         uint8_t *status)
+{
+    union register_pair req_off = {.even = req, .odd = offset};
+    int cc = -1;
+
+    asm volatile (
+        "     .insn   rre,0xb9d00000,%[data],%[req_off]\n"
+        "     ipm     %[cc]\n"
+        "     srl     %[cc],28\n"
+        : [cc] "+d" (cc), [req_off] "+d" (req_off.pair)
+        : [data] "d" (data)
+        : "cc");
+    *status = req_off.even >> 24 & 0xff;
+    return cc;
+}
+
+int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data,
+              uint8_t len)
+{
+
+    uint64_t req = ZPCI_CREATE_REQ(fhandle, pcias, len);
+    uint8_t status;
+    int rc;
+
+    /* len must be non-zero power of 2 with a maximum of 8 bytes per write */
+    switch (len) {
+    case 1:
+    case 2:
+    case 4:
+    case 8:
+        rc = pcistg(data, req, offset, &status);
+        break;
+    default:
+        return -1;
+    }
+
+    /* Error condition detected */
+    if (rc != 0) {
+        printf("PCI store failed with status condition %d, return code %d\n",
+               status, rc);
+        return -1;
+    }
+
+    return 0;
+}
+
+int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf,
+             uint8_t len)
+{
+    uint64_t req, data;
+    uint8_t status;
+    int rc;
+
+    req = ZPCI_CREATE_REQ(fhandle, pcias, len);
+    rc = pcilg(&data, req, offset, &status);
+
+    /* Error condition detected */
+    if (rc != 0) {
+        printf("PCI load failed with status condition %d, return code %d\n",
+               status, rc);
+        return -1;
+    }
+
+    switch (len) {
+    case 1:
+        *(uint8_t *)buf = data;
+        break;
+    case 2:
+        *(uint16_t *)buf = data;
+        break;
+    case 4:
+        *(uint32_t *)buf = data;
+        break;
+    case 8:
+        *(uint64_t *)buf = data;
+        break;
+    default:
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
new file mode 100644
index 0000000000..40a0bf9dcb
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.h
@@ -0,0 +1,39 @@
+/*
+ * s390x PCI definitions
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PCI_H
+#define PCI_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include "clp.h"
+
+#define ZPCI_CREATE_REQ(handle, space, len)                    \
+    ((uint64_t) handle << 32 | space << 16 | len)
+
+union register_pair {
+    unsigned __int128 pair;
+    struct {
+        unsigned long even;
+        unsigned long odd;
+    };
+};
+
+#define PCIST_DISABLED         0x0
+#define PCIST_ENABLED          0x1
+
+#define PCI_CFGBAR             0xF  /* Base Address Register for config space */
+#define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list entry */
+
+int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data,
+              uint8_t len);
+int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf,
+             uint8_t len);
+
+#endif
-- 
2.52.0


