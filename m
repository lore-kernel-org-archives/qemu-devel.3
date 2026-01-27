Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551F5D3409E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkU-00049X-GH; Tue, 27 Jan 2026 11:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljo-0003fm-6q; Tue, 27 Jan 2026 11:16:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljl-0000nj-7j; Tue, 27 Jan 2026 11:16:19 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R3VstG009492;
 Tue, 27 Jan 2026 16:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=A1JB/jtjMkfapq8S+
 kBsbTtkmegghdKycN75iVASnfQ=; b=Jecl3LFmsWNJ0pN5hZpNvoOuclQPVqFGT
 gp4FcAhj3R9Vwqk8rj2mMOEyJuB7IYJTT7gqloqMSA2vhLN8+8/94WU8PyioJTPq
 GWEnEKqZyzotzTp+GMwBRXYYihkoRSt1ff+Imw5vtZ1GuFmafRRF///ntyJ6bYAt
 k7AiezQb/bk1d9XDUH8GkbkheYTbMKk6xGbOMlGGPoQG/iEdHSRK/cv/dxrpAq//
 65SlWhQrgcNzBEc5ToG84FsIHINYsgFvY3ZHWXYuBXfONZQJjAfDjdWaeAZ6tuyb
 Atj5zb+plz2CThvryONhGApmBxzZVtg9ccdOvmP0x/4NVrDF0NMYQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrteayd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDWo52019844;
 Tue, 27 Jan 2026 16:16:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dn1b4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:11 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGGANv18088454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:16:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F9775805F;
 Tue, 27 Jan 2026 16:16:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0421058054;
 Tue, 27 Jan 2026 16:16:09 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:16:08 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 09/14] pc-bios/s390-ccw: Introduce PCI device
Date: Tue, 27 Jan 2026 11:15:42 -0500
Message-ID: <20260127161547.459443-10-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SesBfaicXX7GwfL48weSTneqBbX3rRVB
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978e4cc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=0elTIrir9omESqS3aDoA:9
X-Proofpoint-ORIG-GUID: SesBfaicXX7GwfL48weSTneqBbX3rRVB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX8I5ckkWoFiIp
 Bdn32UaifF3qymqkJpE9mB1GGzwpg4Y4A0Sm3/Izf5N8Ew3Xz2RSvMgg55LCxY1HEP6UbU12m78
 2F3kfbWgYJAEJpVwexHbYUEPLFXxjL0rBQlnmgTX3cza1mH7YREm2ypEP9bziISMyWlSevfAcL4
 jAmZPvv2gTxqKLttbVEzsFk83iC1cjIf9HH79dgCuvbL9SWUvu4r1BTkWb6kCrfLfO3TYe2JGQu
 4aMdv+HGjTvq7pNQFBLfWk1C+AyeE25sHwo51bobv8W3IoowzRzGX/s44N0+sBU0crzSKoem0cC
 cdXWDc1r9YieidTQaJGNHgXvzMlC4l2QqmQqqsJ1EJtoH/DCLbC9JtZye3GHN7z37kvrVeCWwwf
 enlGNuYGlP/TCerJBkVn2e/jeSkeVolxGBwvoRmzksjcTiEgZlY2hcuoU+CW8DVVcJIVT9uHaZA
 u61uSjeWSWPX+ycdbZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Define selected s390x PCI instructions.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile |   2 +-
 pc-bios/s390-ccw/pci.c    | 194 ++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/pci.h    |  80 ++++++++++++++++
 3 files changed, 275 insertions(+), 1 deletion(-)
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
index 0000000000..9656be45ca
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.c
@@ -0,0 +1,194 @@
+/*
+ * s390x PCI funcionality
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
+/* store PCI function controls */
+static inline int stpcifc(uint64_t req, PciFib *fib, uint8_t *status)
+{
+    uint8_t cc;
+
+    asm volatile (
+        "     .insn   rxy,0xe300000000d4,%[req],%[fib]\n"
+        "     ipm     %[cc]\n"
+        "     srl     %[cc],28\n"
+        : [cc] "=d" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
+        : : "cc");
+    *status = req >> 24 & 0xff;
+    return cc;
+}
+
+/* modify PCI function controls */
+static inline int mpcifc(uint64_t req, PciFib *fib, uint8_t *status)
+{
+    uint8_t cc;
+
+    asm volatile (
+        "     .insn   rxy,0xe300000000d0,%[req],%[fib]\n"
+        "     ipm     %[cc]\n"
+        "     srl     %[cc],28\n"
+        : [cc] "=d" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
+        : : "cc");
+    *status = req >> 24 & 0xff;
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
+        rc = -1;
+    }
+
+    /* Error condition detected */
+    if (rc == 1) {
+        printf("PCI store failed with status condition %d\n", status);
+        return -1;
+    }
+
+    return rc ? -1 : 0;
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
+    if (rc == 1) {
+        printf("PCI load failed with status condition %d\n", status);
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
+    return rc ? -1 : 0;
+}
+
+int pci_dev_enable(PciDevice *pcidev)
+{
+    int rc;
+
+    rc = enable_pci_function(&pcidev->fhandle);
+    if (rc) {
+        return rc;
+    }
+
+    pcidev->status = PCIST_ENABLED;
+
+    return pci_get_fib(&pcidev->fib, pcidev->fhandle);
+}
+
+int pci_get_fib(PciFib *fib, uint32_t fhandle)
+{
+    uint64_t req = ZPCI_CREATE_REQ(fhandle, 0, 0);
+    uint8_t status;
+    int rc;
+
+    rc = stpcifc(req, fib, &status);
+
+    if (rc == 1) {
+        return status;
+    } else if (rc) {
+        return rc;
+    }
+
+    return 0;
+}
+
+int pci_set_fib(PciFib *fib, uint32_t fhandle, uint8_t dma_as, uint8_t opcontrol)
+{
+    uint64_t req = ZPCI_CREATE_REQ(fhandle, dma_as, opcontrol);
+    uint8_t status;
+    int rc;
+
+    rc = mpcifc(req, fib, &status);
+
+    if (rc == 1) {
+        return status;
+    } else if (rc) {
+        return rc;
+    }
+
+    return 0;
+}
diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
new file mode 100644
index 0000000000..ff8d5687f4
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.h
@@ -0,0 +1,80 @@
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
+#define PCIFIB_FC_ENABLED      0x80
+#define PCIFIB_FC_ERROR        0x40
+#define PCIFIB_FC_BLOCKED      0x20
+#define PCIFIB_FC_DMAREG       0x10
+
+#define PCIST_DISABLED         0x0
+#define PCIST_ENABLED          0x1
+
+#define PCI_CFGBAR             0xF  /* Base Address Register for config space */
+#define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list entry */
+
+struct PciFib {
+    uint32_t reserved0[2];
+    uint8_t fcflags;
+    uint8_t reserved1[3];
+    uint32_t reserved2;
+    uint64_t pba;
+    uint64_t pal;
+    uint64_t iota;
+    uint16_t isc:4;
+    uint16_t noi:12;
+    uint8_t reserved3:2;
+    uint8_t aibvo:6;
+    uint8_t s:1;
+    uint8_t reserved4:1;
+    uint8_t aisbo:6;
+    uint32_t reserved5;
+    uint64_t aibv;
+    uint64_t aisb;
+    uint64_t fmba;
+    uint32_t reserved6[2];
+};
+typedef struct PciFib PciFib;
+
+struct PciDevice {
+    uint16_t device_id;
+    uint16_t vendor_id;
+    uint32_t fid;
+    uint32_t fhandle;
+    uint8_t status;
+    PciFib fib;
+};
+typedef struct PciDevice PciDevice;
+
+int pci_dev_enable(PciDevice *pcidev);
+int pci_get_fib(PciFib *fib, uint32_t fhandle);
+int pci_set_fib(PciFib *fib, uint32_t fhandle, uint8_t dma_as, uint8_t opcontrol);
+int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data,
+              uint8_t len);
+int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf,
+             uint8_t len);
+
+#endif
-- 
2.52.0


