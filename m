Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAECFCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq5Z-0000e1-Fi; Tue, 10 Mar 2026 01:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5Q-0000Vf-UN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5O-0006Ki-Pb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W49tLWZeK0fa6fnZpgeNI0/1hwcNlmoVnADl5S7pXy8=;
 b=OiCV7IGmVbEsURHik2kl0+N2qfw+q1fUgXGtxU06TFzURQO/WNd01xfknKjWFYONFZ6fvY
 IQNr7pQhqEJADqpO55jmWHciCSnP+6GFlLNMnN9GflSNpL+ESdqEf81nryAG+XPqAk5lwJ
 kL8aVT6l040N4B9+pYwaXI45IpN8xVY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-QhA4qYqrOByyRYXCDbTXtg-1; Tue,
 10 Mar 2026 01:56:52 -0400
X-MC-Unique: QhA4qYqrOByyRYXCDbTXtg-1
X-Mimecast-MFC-AGG-ID: QhA4qYqrOByyRYXCDbTXtg_1773122210
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABD8F18002D1; Tue, 10 Mar 2026 05:56:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 538E01956095; Tue, 10 Mar 2026 05:56:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 19/25] pc-bios/s390-ccw: Introduce virtio-pci functions
Date: Tue, 10 Mar 2026 06:55:24 +0100
Message-ID: <20260310055530.8893-20-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20260309003601.242634-12-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/virtio-pci.h |  80 ++++++++++++++++
 pc-bios/s390-ccw/virtio.h     |   3 +
 pc-bios/s390-ccw/virtio-pci.c | 167 ++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/Makefile     |   2 +-
 4 files changed, 251 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/virtio-pci.h
 create mode 100644 pc-bios/s390-ccw/virtio-pci.c

diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
new file mode 100644
index 00000000000..54c524f6986
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
index c3cb5a6ee3b..1ef64675f4a 100644
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
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
new file mode 100644
index 00000000000..f6ce7ec7661
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
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index a62fc9d7660..3e5dfb64d5d 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-	  virtio-ccw.o clp.o pci.o
+	  virtio-ccw.o clp.o pci.o virtio-pci.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.53.0


