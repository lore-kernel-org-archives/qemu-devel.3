Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9969D34097
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkG-0003yl-PY; Tue, 27 Jan 2026 11:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljo-0003fl-6o; Tue, 27 Jan 2026 11:16:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljl-0000ny-7Q; Tue, 27 Jan 2026 11:16:19 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R819BR021671;
 Tue, 27 Jan 2026 16:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4GbQI2fwtY4GakBFj
 1Aq5nqCEnz2ItJtHIErAhRmkKA=; b=QEQ2ALqtPSUIo5BNidIagNMtFEbiiuKYq
 1BgqlfHEii8nWJqT/c8Attqx0khqhTD9zNDrW+iZAgcnDV885w2c3Iki26ul+Wj5
 pZOORF9IwdhuovKv6FAzWB8Xczg+YJ0ZdFZ4sKQpGCo18AoVLvlmKZ53fbCJjT1Z
 eYBDPyCVm8ATaHHOx787mzIVA1/xsjSNe7TbBU61esXESCr+ac1B/czXj0aoVtSa
 GcqwtG4OWxm61ENNDpfAdDzcfJjwMCR0UWeF17Q0ES7S6Bs3IWhkXE/TuvtFpRia
 1zhg1kbrZLA69jF7d5XMV2+ghT3w1wuzDCv87DdXeV6pK2okIHYSw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6xeqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD4EZo031030;
 Tue, 27 Jan 2026 16:16:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dshdsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGGCtA66257372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:16:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 175AA5805C;
 Tue, 27 Jan 2026 16:16:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED6F058054;
 Tue, 27 Jan 2026 16:16:10 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:16:10 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 10/14] pc-bios/s390-ccw: Introduce virtio-pci functions
Date: Tue, 27 Jan 2026 11:15:43 -0500
Message-ID: <20260127161547.459443-11-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v2-kjARuqpkLTXRrjCL56r2fmVKnIfLW
X-Proofpoint-ORIG-GUID: v2-kjARuqpkLTXRrjCL56r2fmVKnIfLW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfXzXmDC/8JfYTJ
 QQH0Qp0qrVUJWyEiWedZP6mChS8d8ftKLp5od1g39X7igSnkBIs49GJRg2YSIZ8Ou1bf91mvatn
 HDoGv40VZz2dYm8UBhpUhnHOWO7hp6mCEGVATxDQB6WvRwtB8SDuVj1SFpJZbrYfZhHutRYXK4Y
 DA/EHE/zalccmzUdw+TPKVJI/1+6OPTJrfctliu3nbsDmtxRzszLYlaWzSXk1tEHD3pIfsabRDz
 HQRHeoeSx0LgKzD5YIC3MVbei9N3948SD6SXO9SmcQ5L5z2E9PwzPnYA7MDxqtvAlhSJnNPKfQ4
 nHon1GCFuwFervkIxIIlzmEuLjsFqFfF6fdPTtr6DMiSdSQodNEeWKrI7m/DMWYs/cWMSo8+5cu
 sA3N5+gY5kmHkYpIlod4bjY+q1/VYmPC8y1BId/wj0cWtvsVnR6jg1by1Ny5IG8DBrFoJj0wCYd
 3y2pbJGgVcIBr65L8gQ==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978e4ce cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=lM7CEYtdp-gwZ96l5QAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Define common functionality for interacting with virtio-pci devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile     |   2 +-
 pc-bios/s390-ccw/virtio-pci.c | 168 ++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h |  86 +++++++++++++++++
 pc-bios/s390-ccw/virtio.h     |   1 +
 4 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/virtio-pci.c
 create mode 100644 pc-bios/s390-ccw/virtio-pci.h

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index a62fc9d766..3e5dfb64d5 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-	  virtio-ccw.o clp.o pci.o
+	  virtio-ccw.o clp.o pci.o virtio-pci.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
new file mode 100644
index 0000000000..70abac0256
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -0,0 +1,168 @@
+/*
+ * Functionality for virtio-pci
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "clp.h"
+#include "pci.h"
+#include "helper.h"
+#include "virtio.h"
+#include "bswap.h"
+#include "virtio-pci.h"
+#include "s390-time.h"
+#include <stdio.h>
+
+/* Variable offsets used for reads/writes to modern memory regions */
+VirtioPciCap c_cap; /* Common capabilities  */
+VirtioPciCap d_cap; /* Device capabilities  */
+VirtioPciCap n_cap; /* Notify capabilities  */
+uint32_t notify_mult;
+uint16_t q_notify_offset;
+
+static int virtio_pci_set_status(uint8_t status)
+{
+    int rc = vpci_write_byte(c_cap.off + VPCI_C_OFFSET_STATUS, c_cap.bar, status);
+    if (rc) {
+        puts("Failed to write virtio-pci status");
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static int virtio_pci_get_status(uint8_t *status)
+{
+    int rc = vpci_read_byte(c_cap.off + VPCI_C_OFFSET_STATUS, c_cap.bar, status);
+    if (rc) {
+        puts("Failed to read virtio-pci status");
+        return -EIO;
+    }
+
+    return 0;
+}
+
+/* virtio spec v1.3 section 4.1.2.1 */
+void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
+{
+    switch (device_id) {
+    case 0x1001:
+        vdev->dev_type = VIRTIO_ID_BLOCK;
+        break;
+    case 0x1000: /* Other valid but currently unsupported virtio device types */
+    case 0x1004:
+    default:
+        vdev->dev_type = 0;
+    }
+}
+
+int virtio_pci_reset(VDev *vdev)
+{
+    int rc;
+    uint8_t status = VPCI_S_RESET;
+
+    rc = virtio_pci_set_status(status);
+    rc |= virtio_pci_get_status(&status);
+
+    if (rc || status) {
+        puts("Failed to reset virtio-pci device");
+        return 1;
+    }
+
+    return 0;
+}
+
+long virtio_pci_notify(int vq_id)
+{
+    uint32_t offset = n_cap.off + notify_mult * q_notify_offset;
+    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vq_id);
+}
+
+/*
+ * Wrappers to byte swap common data sizes then write
+ */
+int vpci_write_byte(uint64_t offset, uint8_t pcias, uint8_t data)
+{
+    return pci_write(virtio_get_device()->pci_fh, offset, pcias, (uint64_t) data, 1);
+}
+
+int vpci_bswap16_write(uint64_t offset, uint8_t pcias, uint16_t data)
+{
+    uint64_t le_data = bswap16(data);
+    return pci_write(virtio_get_device()->pci_fh, offset, pcias, le_data, 2);
+}
+
+int vpci_bswap32_write(uint64_t offset, uint8_t pcias, uint32_t data)
+{
+    uint64_t le_data = bswap32(data);
+    return pci_write(virtio_get_device()->pci_fh, offset, pcias, le_data, 4);
+}
+
+int vpci_bswap64_write(uint64_t offset, uint8_t pcias, uint64_t data)
+{
+    uint64_t le_data = bswap64(data);
+    return pci_write(virtio_get_device()->pci_fh, offset, pcias, le_data, 8);
+}
+
+/*
+ * Wrappers to read common data sizes then byte swap
+ */
+int vpci_read_byte(uint64_t offset, uint8_t pcias, uint8_t *buf)
+{
+    return pci_read(virtio_get_device()->pci_fh, offset, pcias, buf, 1);
+}
+
+int vpci_read_bswap16(uint64_t offset, uint8_t pcias, uint16_t *buf)
+{
+    int rc = pci_read(virtio_get_device()->pci_fh, offset, pcias, buf, 2);
+    *buf = bswap16(*buf);
+    return rc;
+}
+
+int vpci_read_bswap32(uint64_t offset, uint8_t pcias, uint32_t *buf)
+{
+    int rc = pci_read(virtio_get_device()->pci_fh, offset, pcias, buf, 4);
+    *buf = bswap32(*buf);
+    return rc;
+}
+
+int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf)
+{
+    int rc = pci_read(virtio_get_device()->pci_fh, offset, pcias, buf, 8);
+    *buf = bswap64(*buf);
+    return rc;
+}
+
+/*
+ * Read to an arbitrary length buffer without byte swapping
+ */
+int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len)
+{
+    uint8_t readlen;
+    int rc;
+    int remaining = len;
+
+    /* Read bytes in powers of 2, up to a maximum of 8 bytes per read */
+    while (remaining) {
+        for (int i = 3; i >= 0; i--) {
+            readlen = 1 << i;
+            if (remaining >= readlen) {
+                break;
+            }
+        }
+
+        rc = pci_read(virtio_get_device()->pci_fh, offset, pcias, buf, readlen);
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
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
new file mode 100644
index 0000000000..96c17ac3c7
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -0,0 +1,86 @@
+/*
+ * Definitions for virtio-pci
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef VIRTIO_PCI_H
+#define VIRTIO_PCI_H
+
+/* Common configuration */
+#define VPCI_CAP_COMMON_CFG          1
+/* Notifications */
+#define VPCI_CAP_NOTIFY_CFG          2
+/* ISR access */
+#define VPCI_CAP_ISR_CFG             3
+/* Device specific configuration */
+#define VPCI_CAP_DEVICE_CFG          4
+/* PCI configuration access */
+#define VPCI_CAP_PCI_CFG             5
+/* Additional shared memory capability */
+#define VPCI_CAP_SHARED_MEMORY_CFG   8
+/* PCI vendor data configuration */
+#define VPCI_CAP_VENDOR_CFG          9
+
+/* Offsets within capability header */
+#define VPCI_CAP_VNDR        0
+#define VPCI_CAP_NEXT        1
+#define VPCI_CAP_LEN         2
+#define VPCI_CAP_CFG_TYPE    3
+#define VPCI_CAP_BAR         4
+#define VPCI_CAP_OFFSET      8
+#define VPCI_CAP_LENGTH      12
+
+#define VPCI_N_CAP_MULT 16 /* Notify multiplier, VPCI_CAP_NOTIFY_CFG only */
+
+/* Common Area Offsets for virtio-pci queue */
+#define VPCI_C_OFFSET_DFSELECT      0
+#define VPCI_C_OFFSET_DF            4
+#define VPCI_C_OFFSET_GFSELECT      8
+#define VPCI_C_OFFSET_GF            12
+#define VPCI_C_COMMON_NUMQ          18
+#define VPCI_C_OFFSET_STATUS        20
+#define VPCI_C_OFFSET_Q_SELECT      22
+#define VPCI_C_OFFSET_Q_SIZE        24
+#define VPCI_C_OFFSET_Q_ENABLE      28
+#define VPCI_C_OFFSET_Q_NOFF        30
+#define VPCI_C_OFFSET_Q_DESCLO      32
+#define VPCI_C_OFFSET_Q_DESCHI      36
+#define VPCI_C_OFFSET_Q_AVAILLO     40
+#define VPCI_C_OFFSET_Q_AVAILHI     44
+#define VPCI_C_OFFSET_Q_USEDLO      48
+#define VPCI_C_OFFSET_Q_USEDHI      52
+
+#define VPCI_S_RESET            0
+#define VPCI_S_ACKNOWLEDGE      1
+#define VPCI_S_DRIVER           2
+#define VPCI_S_DRIVER_OK        4
+#define VPCI_S_FEATURES_OK      8
+
+#define VIRTIO_F_VERSION_1      (1 << (32 - 32)) /* Feature bit 32 */
+
+struct VirtioPciCap {
+    uint8_t bar;     /* Which PCIAS it's in */
+    uint32_t off;    /* Offset within bar */
+};
+typedef struct VirtioPciCap  VirtioPciCap;
+
+void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
+int virtio_pci_reset(VDev *vdev);
+long virtio_pci_notify(int vq_id);
+
+int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
+int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
+int vpci_read_bswap32(uint64_t offset, uint8_t pcias, uint32_t *buf);
+int vpci_read_bswap16(uint64_t offset, uint8_t pcias, uint16_t *buf);
+int vpci_read_byte(uint64_t offset, uint8_t pcias, uint8_t *buf);
+
+int vpci_bswap64_write(uint64_t offset, uint8_t pcias, uint64_t data);
+int vpci_bswap32_write(uint64_t offset, uint8_t pcias, uint32_t data);
+int vpci_bswap16_write(uint64_t offset, uint8_t pcias, uint16_t data);
+int vpci_write_byte(uint64_t offset, uint8_t pcias, uint8_t data);
+
+#endif
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 0fdee8468c..0c34d59be2 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -255,6 +255,7 @@ struct VDev {
     uint8_t scsi_dev_heads;
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
+    uint32_t pci_fh;
     uint32_t max_transfer;
     uint32_t guest_features[2];
 };
-- 
2.52.0


