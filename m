Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287A5EA854A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzObs-0006R8-Vt; Sun, 08 Mar 2026 20:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObo-0006OF-7O; Sun, 08 Mar 2026 20:36:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObm-0001g8-DV; Sun, 08 Mar 2026 20:36:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628DjaTQ496716; Mon, 9 Mar 2026 00:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CzvGb6GS2vPoidwzC
 zGXELT63Hr7SucPd0x7GmsxkIs=; b=Nm9/mFVhkXanp/egtajUtXwwcCCdAme4U
 7KT9qqQPeU3I9HaCJp7Y/qGTuyQ5wRFPJvdTRP+BsI/zmv4Y3N+UOxKrEXG+valf
 h1EXbTxN+5lnUiI+ktd2a1vcMDhGIyekakkfQZhFKsPwCFwDEANbRDgCJGNaqsy4
 JRJBxhBC++KXO5yX5Edvgupcs122UIim9IfzhuzE6YFjvodVDTE40655HvkazjWE
 lFwRHoRFhCKFwPNyy6E7fqoA2G3GqArmLhpuzIXYkgD1OXiAezxvXID/UeyzLpdI
 RtrJXwBEjkVsP1Qx/o/oxrab+Z4267auA0bMOSYyBrlMFhpbVq5dg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mcd8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628KPQLe009467;
 Mon, 9 Mar 2026 00:36:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy32xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290aQkf20120078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD04958052;
 Mon,  9 Mar 2026 00:36:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D42358050;
 Mon,  9 Mar 2026 00:36:25 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:25 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 11/15] pc-bios/s390-ccw: Introduce virtio-pci functions
Date: Sun,  8 Mar 2026 20:35:57 -0400
Message-ID: <20260309003601.242634-12-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69ae160c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=lM7CEYtdp-gwZ96l5QAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfX17u5d+9lXlDY
 bxStoRj8mFFndeP91RS0dQEPhyllZacxvmBvDXFK2Giqp9uW/oTGvQV0Cb/zAqTkEKCtV6FoDEr
 pHMGLlA0Ri67LJ57NbaFq0pWVvlTPSvKrKeBQntBL2nlhYpdYdSVELRWdVf+eFAwdXTtJyNqB89
 55/3ocSWOTP8KD8vRO4aQSVmP72Iahmv00V12Tz0W5UxIDNOYuzXyNOVST9EJKPKsVWKGGGXvCH
 oeyA1hAEBFROnUtauoSAvoolhBUK5dLMEkSXfJb0FJ/I3jBsGisQkZybZyhHB26j1BR3Koe44EI
 aTU6eqVuuoWy/T7ESgfVfpJXxhcvuWnaF0FhY8RAkhN6uLYQH1MiOYG3BRU5QHpbtuIHQClwXPH
 aIwBAeb2U5y5PzpESMxthpnNMVwfmlUpyAoVpe5YQJexP7pX+DDbcd5ZjDXGy9iJzKmG0KN5/Yp
 y3sPajlD+c3DkzcGy4Q==
X-Proofpoint-GUID: uQWJte5cD3yaRHzn4JXFKKjaHl2ZahOs
X-Proofpoint-ORIG-GUID: uQWJte5cD3yaRHzn4JXFKKjaHl2ZahOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Define common functionality for interacting with virtio-pci devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile     |   2 +-
 pc-bios/s390-ccw/virtio-pci.c | 167 ++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h |  80 ++++++++++++++++
 pc-bios/s390-ccw/virtio.h     |   3 +
 4 files changed, 251 insertions(+), 1 deletion(-)
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
index 0000000000..f6ce7ec766
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -0,0 +1,167 @@
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
+    case 0x1042:
+    case 0x1001:
+        vdev->dev_type = VIRTIO_ID_BLOCK;
+        break;
+    default:
+        vdev->dev_type = 0;
+    }
+}
+
+int virtio_pci_reset(VDev *vdev)
+{
+    int rc;
+    uint8_t status = 0;
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
index 0000000000..54c524f698
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -0,0 +1,80 @@
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
+#define VIRTIO_F_VERSION_1          1   /* Feature bit 32 */
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
index c3cb5a6ee3..1ef64675f4 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -18,6 +18,8 @@
 #define VIRTIO_CONFIG_S_DRIVER          2
 /* Driver has used its parts of the config, and is happy */
 #define VIRTIO_CONFIG_S_DRIVER_OK       4
+/* Feature negotiation complete */
+#define VIRTIO_CONFIG_S_FEATURES_OK     8
 /* We've given up on this device. */
 #define VIRTIO_CONFIG_S_FAILED          0x80
 
@@ -255,6 +257,7 @@ struct VDev {
     uint8_t scsi_dev_heads;
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
+    uint32_t pci_fh;
     uint32_t max_transfer;
     uint32_t guest_features[2];
 };
-- 
2.52.0


