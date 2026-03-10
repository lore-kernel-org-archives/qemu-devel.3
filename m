Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9C1FCC9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq5R-0000WF-5K; Tue, 10 Mar 2026 01:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5O-0000MU-5t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5L-0006KI-UI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OY51g9+eUvj1djQZBkWHLh3VByefHAuAYmIFtE21EwQ=;
 b=FaSmuhglm1EI0etBsw+GBCInFAqwbc7YA1z+MWvIWovQ/FoOmH4/1Mk8mYl7/qdDhkLGT7
 Ke2lNAi/xvHh/eHKe+ajB/Wr5i665dacDP25vfC8L2AfSvlc63Uc12vaieMA/8FPw07NUf
 /qkOy4rS1B+fj7WZeGNRFPT4nfWqFrk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-u_pXyqVnOra0kGGWHYgyjQ-1; Tue,
 10 Mar 2026 01:56:47 -0400
X-MC-Unique: u_pXyqVnOra0kGGWHYgyjQ-1
X-Mimecast-MFC-AGG-ID: u_pXyqVnOra0kGGWHYgyjQ_1773122206
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56A53195608E; Tue, 10 Mar 2026 05:56:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BA021956095; Tue, 10 Mar 2026 05:56:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Subject: [PULL 18/25] pc-bios/s390-ccw: Introduce PCI device
Date: Tue, 10 Mar 2026 06:55:23 +0100
Message-ID: <20260310055530.8893-19-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define selected s390x PCI instructions.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260309003601.242634-11-jrossi@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
[thuth: Remove unused defines as suggested by Farhan]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/pci.h    |  36 ++++++++++++
 pc-bios/s390-ccw/pci.c    | 118 ++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/Makefile |   2 +-
 3 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/pci.h
 create mode 100644 pc-bios/s390-ccw/pci.c

diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
new file mode 100644
index 00000000000..968635eff11
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.h
@@ -0,0 +1,36 @@
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
+#define PCI_CFGBAR             0xF  /* Base Address Register for config space */
+#define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list entry */
+
+int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data,
+              uint8_t len);
+int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf,
+             uint8_t len);
+
+#endif
diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
new file mode 100644
index 00000000000..247070e5f07
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
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 9c29548f849..a62fc9d7660 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-	  virtio-ccw.o clp.o
+	  virtio-ccw.o clp.o pci.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.53.0


