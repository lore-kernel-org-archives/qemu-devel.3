Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE582D3B9AB
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTRDL-0004i1-3J; Wed, 10 Dec 2025 15:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDI-0004fy-Lu; Wed, 10 Dec 2025 15:55:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDG-0000hE-Fo; Wed, 10 Dec 2025 15:55:08 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJoxAX001890;
 Wed, 10 Dec 2025 20:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TL43jz2LUqtDoSE7s
 EIEmJxom27TbhcP7fyDxHQYIS0=; b=kNiaDA94hmI8GRlyqoh9zSyrOiOsJDKU/
 6lFf9y7JLst/ZNl0B58vj1/AP8J3AScGjM5/3VjgfxzxwwKp4hgP0A8yLXvvf2hd
 hiLjxU+iAxmbsJbIdburh5X9QnMILRo0aUD0g46YHMKOx1+SOSEkBUPbGH0nFn5h
 X8os3VKLR2LM9+1dkndgnl+Fw2jUQB+jxDBgFbWBDTNB3j54CxRI9+7BVv0MXjVr
 VTij/T7+uToypeOpnzQGV4nPXf5Y25L+pJKl1PGpJHyPU5AN0LLNhrnESBAjx5Ul
 5m104tpPmxuOUjsD1Ts5HYipldiYM8DOTQn3IcaLRZYxmwAvSjT7w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53kvsm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAKqAIQ026836;
 Wed, 10 Dec 2025 20:55:04 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h1ag0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BAKt2JT15663750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 20:55:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6140E58056;
 Wed, 10 Dec 2025 20:55:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA33758067;
 Wed, 10 Dec 2025 20:55:01 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.53.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Dec 2025 20:55:01 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 06/10] pc-bios/s390-ccw: Introduce PCI device
Date: Wed, 10 Dec 2025 15:54:45 -0500
Message-ID: <20251210205449.2783111-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210205449.2783111-1-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX6FnD6Bmj3Zb5
 +lP8oBqexIaS2lcf9utaLproxQjSZR0RijW+TZ1uLdMhQkwEKBLkbcLXNC65kcGuSitQErD4p7k
 F0yuBgdGSDdwxakRULFtZbVx9prx1+u4t47t4MxLi/ReDqLjP7gBcpt5+km3X9ZstW7DSkyPOAL
 zOlpoQqiqVMZxNgYh5sA3QautEEFngfvj9lsJBCMok4N/eyDUEziHmZS2R9jGB+JAXpSKKnABcZ
 W/77C18QgQMIpxCsUEv+0f6o89wSpBt+KBnitp9FKpio4oSuB/3W4Q75weiyTavR086GIPiHDyZ
 fySao9oKesN+je/3cutiDhbojh/qkHbJIShlf0TPlaz8dSxxyRybWWZDdOhuGdgCJJ25xj6Nqok
 pf96P0pESJwpOz68d/DjgVqjwsaNDg==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=6939de29 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ThZcmqG5OktQ-sC9OvEA:9
X-Proofpoint-ORIG-GUID: se64Rm6h1hS6rTu6ix9oXOyabLWdkbK2
X-Proofpoint-GUID: se64Rm6h1hS6rTu6ix9oXOyabLWdkbK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
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
 pc-bios/s390-ccw/pci.h    |  88 ++++++++++
 pc-bios/s390-ccw/pci.c    | 331 ++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/Makefile |   2 +-
 3 files changed, 420 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/pci.h
 create mode 100644 pc-bios/s390-ccw/pci.c

diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
new file mode 100644
index 0000000000..847cf3f194
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.h
@@ -0,0 +1,88 @@
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
+int pci_write_flex(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *data, int len);
+int pci_write_byte(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint8_t data);
+int pci_bswap16_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint16_t data);
+int pci_bswap32_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint32_t data);
+int pci_bswap64_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data);
+
+int pci_read_flex(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf, int len);
+int pci_read_bswap64(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t *buf);
+int pci_read_bswap32(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint32_t *buf);
+int pci_read_bswap16(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint16_t *buf);
+int pci_read_byte(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint8_t *buf);
+
+int pci_dev_enable(PciDevice *pcidev);
+int get_fib(PciFib *fib, uint32_t fhandle);
+int set_fib(PciFib *fib, uint32_t fhandle, uint8_t dma_as, uint8_t opcontrol);
+
+#endif
diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
new file mode 100644
index 0000000000..c149789386
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.c
@@ -0,0 +1,331 @@
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
+static inline int pcilg(uint64_t *data, uint64_t req, uint64_t offset, uint8_t *status)
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
+int pcistg(uint64_t data, uint64_t req, uint64_t offset, uint8_t *status)
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
+static int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias,
+                     uint64_t data, uint8_t len)
+{
+
+    uint64_t req = ZPCI_CREATE_REQ(fhandle, pcias, len);
+    uint8_t status;
+    int rc;
+
+    /* writes must be non-zero powers of 2 with a maximum of 8 bytes per read */
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
+/* Write an arbitrary length of data without byte swapping */
+int pci_write_flex(uint32_t fh, uint64_t offset, uint8_t pcias, void *data, int len)
+{
+    uint8_t writelen, tmp;
+    int rc;
+    int remaining = len;
+
+    /* write bytes in powers of 2, up to a maximum of 8 bytes per read */
+    while (remaining) {
+        if (remaining > 7) {
+            writelen = 8;
+        } else {
+            writelen = 1;
+            while (true) {
+                tmp = writelen * 2;
+                if (tmp > remaining) {
+                    break;
+                }
+
+                writelen = tmp;
+            }
+        }
+
+        /* Access next data based on write size */
+        switch (writelen) {
+        case 1:
+            rc = pci_write(fh, offset, pcias, ((uint8_t *)data)[0], 1);
+            break;
+        case 2:
+            rc = pci_write(fh, offset, pcias, ((uint16_t *)data)[0], 2);
+            break;
+        case 4:
+            rc = pci_write(fh, offset, pcias, ((uint32_t *)data)[0], 4);
+            break;
+        case 8:
+            rc = pci_write(fh, offset, pcias, ((uint64_t *)data)[0], 8);
+            break;
+        default:
+            rc = -1;
+        }
+
+        if (rc) {
+            return -1;
+        }
+
+        remaining -= writelen;
+        data += writelen;
+        offset += writelen;
+    }
+
+    return 0;
+}
+
+int pci_write_byte(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint8_t data)
+{
+    return pci_write(fhandle, offset, pcias, (uint64_t)data, 1);
+}
+
+/* Wrappers to byte swap common data sizes then write */
+int pci_bswap16_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint16_t data)
+{
+    uint64_t le_data = bswap16(data);
+    return pci_write(fhandle, offset, pcias, le_data, 2);
+}
+
+int pci_bswap32_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint32_t data)
+{
+    uint64_t le_data = bswap32(data);
+    return pci_write(fhandle, offset, pcias, le_data, 4);
+}
+
+int pci_bswap64_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data)
+{
+    uint64_t le_data = bswap64(data);
+    return pci_write(fhandle, offset, pcias, le_data, 8);
+}
+
+static int pci_read(uint32_t fh, uint64_t offset, uint8_t pcias, void *buf, uint8_t len)
+{
+    uint64_t req, data;
+    uint8_t status;
+    int rc;
+
+    req = ZPCI_CREATE_REQ(fh, pcias, len);
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
+/* Read to an arbitrary length buffer without byte swapping */
+int pci_read_flex(uint32_t fh, uint64_t offset, uint8_t pcias, void *buf, int len)
+{
+    uint8_t readlen, tmp;
+    int rc;
+    int remaining = len;
+
+    /* Read bytes in powers of 2, up to a maximum of 8 bytes per read */
+    while (remaining) {
+        if (remaining > 7) {
+            readlen = 8;
+        } else {
+            readlen = 1;
+            while (true) {
+                tmp = readlen * 2;
+                if (tmp > remaining) {
+                    break;
+                }
+
+                readlen = tmp;
+            }
+        }
+
+        rc = pci_read(fh, offset, pcias, buf, readlen);
+        if (rc) {
+            return -1;
+        }
+
+        remaining -= readlen;
+        buf += readlen;
+        offset += readlen;
+    }
+
+    return 0;
+}
+
+int pci_read_byte(uint32_t fh, uint64_t offset, uint8_t pcias, uint8_t *buf)
+{
+    return pci_read(fh, offset, pcias, buf, 1);
+}
+
+/* Wrappers to read common data sizes then byte swap */
+int pci_read_bswap16(uint32_t fh, uint64_t offset, uint8_t pcias, uint16_t *buf)
+{
+    int rc = pci_read(fh, offset, pcias, buf, 2);
+    *buf = bswap16(*buf);
+    return rc;
+}
+
+int pci_read_bswap32(uint32_t fh, uint64_t offset, uint8_t pcias, uint32_t *buf)
+{
+    int rc = pci_read(fh, offset, pcias, buf, 4);
+    *buf = bswap32(*buf);
+    return rc;
+}
+
+int pci_read_bswap64(uint32_t fh, uint64_t offset, uint8_t pcias, uint64_t *buf)
+{
+    int rc = pci_read(fh, offset, pcias, buf, 8);
+    *buf = bswap64(*buf);
+    return rc;
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
index 9c29548f84..a62fc9d766 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-	  virtio-ccw.o clp.o
+	  virtio-ccw.o clp.o pci.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.49.0


