Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0C1CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAscn-0003k7-4s; Mon, 20 Oct 2025 12:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAsci-0003iZ-Jr; Mon, 20 Oct 2025 12:20:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAscg-0000su-88; Mon, 20 Oct 2025 12:20:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7Jg8m025774;
 Mon, 20 Oct 2025 16:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7dewvaRSqeMbVtAS3
 xQlODzV1Ib0tyTeVwjFS/WUHtI=; b=k6ZjThf2UCehHzvXwHkqEDItMspJtiEUi
 jl7SHOsNVawdFSJQmeieDHA6APedl8RC7ZOsLhprS4VPYX+EmYyLXXcOtMWSiEvk
 4AhdDCfrOhadDBHjJuSJTplYjmqWdkIGYk/IqdTeNPKPzsnRgbFH62ki6wAdQZ8X
 cHGuprI3S9hFRLaWroQwIjPK8GBBoaWJMADh630PRRtt11/i2+I4t0pwXcnWx7VM
 tNKYpucnCdu4DQS6zeaY41A8eubeelbpM1WbJewuNoVP5TjcCQbfvtG5fV2Mp8Xz
 nRt/H6jn0e+Kam/Ae7YVM0uBFg0/5f0udPVO9ba9m7cQQhyYecuAA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32h9b8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFKYQf002320;
 Mon, 20 Oct 2025 16:20:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej6bra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KGKXkC50004272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 16:20:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DE6C5806A;
 Mon, 20 Oct 2025 16:20:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0635E58065;
 Mon, 20 Oct 2025 16:20:33 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.78.141])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 16:20:32 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 4/7] pc-bios/s390-ccw: Introduce PCI device IPL format
Date: Mon, 20 Oct 2025 12:20:20 -0400
Message-ID: <20251020162023.3649165-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251020162023.3649165-1-jrossi@linux.ibm.com>
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1RUTUM/nsCIu
 kwfu7WtQtkxAJG+RfQe6nRUcKHufm4m3uMUI3mpJ0fVclYkh+jRYHj8QkJFpoLfgwXMi1/mhFgx
 YsUKF+28Urj1V13D26h5XRF1o3Ls+2Fb2mLP1pm9S88xjE0gORt65iiIkn5mPg/Yq9+Inn/rgdJ
 rLRjJ37tBvJub9APWNDit8CKppRtljAv0lDw7IAi3mPedXHU6WH8PuJrU92IzifpydxOf004igb
 I9VWAGRCuLUhwCxHGub4Zv69WrGWC2yYjrLEo6mnSTCNb4qZq+L246QfdTCcdvh5C5k7e3yUo/O
 ytCtZvcey6Hb3RTwqwPBdM+g99w00RtszsdhuM6+YPYfZ6NNabUkO2uN6vhPKTkEIvnycHQ1m88
 BadVQYmT9j+Uhgc657Sr9Jj2nCWkyg==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f66154 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=WVVyr85AwjsCaWk6uVoA:9
X-Proofpoint-GUID: 5gyt6_4q8d7toDRzPnYLcQbeSksvy5Eg
X-Proofpoint-ORIG-GUID: 5gyt6_4q8d7toDRzPnYLcQbeSksvy5Eg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Define selected s390x PCI instructions and extend IPLB to allow PCI devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 include/hw/s390x/ipl/qipl.h |   9 ++
 pc-bios/s390-ccw/pci.h      |  77 +++++++++++++++
 pc-bios/s390-ccw/pci.c      | 191 ++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/Makefile   |   2 +-
 4 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/pci.h
 create mode 100644 pc-bios/s390-ccw/pci.c

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index aadab87c2e..efd7b3797c 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -104,6 +104,14 @@ struct IplBlockQemuScsi {
 } QEMU_PACKED;
 typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
+struct IplBlockPci {
+    uint32_t reserved0[80];
+    uint8_t  opt;
+    uint8_t  reserved1[3];
+    uint32_t fid;
+} QEMU_PACKED;
+typedef struct IplBlockPci IplBlockPci;
+
 union IplParameterBlock {
     struct {
         uint32_t len;
@@ -119,6 +127,7 @@ union IplParameterBlock {
             IplBlockFcp fcp;
             IPLBlockPV pv;
             IplBlockQemuScsi scsi;
+            IplBlockPci pci;
         };
     } QEMU_PACKED;
     struct {
diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
new file mode 100644
index 0000000000..b5dc5bff35
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.h
@@ -0,0 +1,77 @@
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
+int pci_write(uint32_t fhandle, uint64_t offset, uint64_t data, uint8_t len);
+int pci_read(uint32_t fhandle, uint64_t offset, uint8_t picas, void *buf, uint8_t len);
+uint8_t find_cap_pos(uint32_t fhandle, uint64_t cfg_type);
+int pci_dev_enable(PciDevice *pcidev);
+int get_fib(PciFib *fib, uint32_t fhandle);
+int set_fib(PciFib *fib, uint32_t fhandle, uint8_t dma_as, uint8_t opcontrol);
+
+#endif
diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
new file mode 100644
index 0000000000..f776bc064c
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.c
@@ -0,0 +1,191 @@
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
+#include <stdio.h>
+
+/* PCI load */
+static inline int pcilg(uint64_t *data, uint64_t req, uint64_t offset, uint8_t *status)
+{
+    union register_pair req_off = {.even = req, .odd = offset};
+    int cc = -1;
+    uint64_t __data = 0x92;
+
+    asm volatile (
+        "     .insn   rre,0xb9d20000,%[data],%[req_off]\n"
+        "     ipm     %[cc]\n"
+        "     srl     %[cc],28\n"
+        : [cc] "+d" (cc), [data] "=d" (__data),
+          [req_off] "+&d" (req_off.pair) :: "cc");
+    *status = req_off.even >> 24 & 0xff;
+    *data = __data;
+    return cc;
+}
+
+/* PCI store */
+int pcistg(uint64_t data, uint64_t req, uint64_t offset, uint8_t *status)
+{
+    union register_pair req_off = {.even = req, .odd = offset};
+    int cc = -1;
+
+    asm volatile (
+        "     .insn   rre,0xb9d00000,%[data],%[req_off]\n"
+        "     ipm     %[cc]\n"
+        "     srl     %[cc],28\n"
+        : [cc] "+d" (cc), [req_off] "+&d" (req_off.pair)
+        : [data] "d" (data)
+        : "cc");
+    *status = req_off.even >> 24 & 0xff;
+    return cc;
+}
+
+/* store PCI function controls */
+int stpcifc(uint64_t req, PciFib *fib, uint8_t *status)
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
+int mpcifc(uint64_t req, PciFib *fib, uint8_t *status)
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
+int pci_write(uint32_t fhandle, uint64_t offset, uint64_t data, uint8_t len)
+{
+
+    uint64_t req = ZPCI_CREATE_REQ(fhandle, 4, len);
+    uint8_t status;
+    int rc;
+
+    rc = pcistg(data, req, offset, &status);
+    if (rc == 1) {
+        return status;
+    } else if (rc) {
+        return rc;
+    }
+
+    return 0;
+}
+
+int pci_read(uint32_t fhandle, uint64_t offset, uint8_t picas, void *buf, uint8_t len)
+{
+    uint64_t req;
+    uint64_t data;
+    uint8_t status;
+    int readlen;
+    int i = 0;
+    int rc = 0;
+
+    while (len > 0 && !rc) {
+        data = 0;
+        readlen = len > 8 ? 8 : len;
+        req = ZPCI_CREATE_REQ(fhandle, picas, readlen);
+        rc = pcilg(&data, req, offset + (i * 8), &status);
+        ((uint64_t *)buf)[i] = data;
+        len -= readlen;
+        i++;
+    }
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
+/*
+ * Find the position of the capability config within PCI configuration
+ * space for a given cfg type.  Return the position if found, otherwise 0.
+ */
+uint8_t find_cap_pos(uint32_t fhandle, uint64_t cfg_type) {
+    uint64_t req, next, cfg;
+    uint8_t status;
+    int rc;
+
+    req = ZPCI_CREATE_REQ(fhandle, 0xf, 1);
+    rc = pcilg(&next, req, PCI_CAPABILITY_LIST, &status);
+    rc = pcilg(&cfg, req, next + 3, &status);
+
+    while (!rc && (cfg != cfg_type) && next) {
+        rc = pcilg(&next, req, next + 1, &status);
+        rc = pcilg(&cfg, req, next + 3, &status);
+    }
+
+    return rc ? 0 : next;
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
+    return get_fib(&pcidev->fib, pcidev->fhandle);
+}
+
+int get_fib(PciFib *fib, uint32_t fhandle)
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
+int set_fib(PciFib *fib, uint32_t fhandle, uint8_t dma_as, uint8_t opcontrol)
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
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 89a42ae506..1f17f98fc1 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
       virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-      virtio-ccw.o clp.o
+      virtio-ccw.o clp.o pci.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.49.0


