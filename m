Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D05FCC9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq5K-0008IX-58; Tue, 10 Mar 2026 01:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5F-0007r3-7J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5C-0006In-8x
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Yktb1u31mYLs3o8YNegAd+y8GFLdK0i/ysiRwsBnDw=;
 b=I5L5b5WTPRuQ4pr9yNRjH/AHYKj7FM1uujC1kXohqcoWQ5gf4zU1+BQf7oIOy+N8UWwtt+
 doOAgIAxS8e2L62YJ8QFL1NGgu6A2Hzv2fKaot0KDha9ymW8hw4ptD10B1YDxK7B7hv3BA
 v1rqb/AFoO6Lv6vB5Hu67SHOoJi3Ngk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-GoBdcmQ-MGilJYPueumVYA-1; Tue,
 10 Mar 2026 01:56:39 -0400
X-MC-Unique: GoBdcmQ-MGilJYPueumVYA-1
X-Mimecast-MFC-AGG-ID: GoBdcmQ-MGilJYPueumVYA_1773122198
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2460F19560A7; Tue, 10 Mar 2026 05:56:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4752E1956095; Tue, 10 Mar 2026 05:56:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Subject: [PULL 16/25] pc-bios/s390-ccw: Introduce CLP Architecture
Date: Tue, 10 Mar 2026 06:55:21 +0100
Message-ID: <20260310055530.8893-17-thuth@redhat.com>
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

Call Logical Processor (CLP) Architecture is used for managing PCI functions on
s390x. Define and include the structures and routines needed to interact with
PCI devices during IPL.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <20260309003601.242634-9-jrossi@linux.ibm.com>
[thuth: fix a typo in one of the comments]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/clp.h    | 24 ++++++++++
 pc-bios/s390-ccw/clp.c    | 99 +++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/Makefile |  2 +-
 3 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/clp.h
 create mode 100644 pc-bios/s390-ccw/clp.c

diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
new file mode 100644
index 00000000000..1ac2f8c177f
--- /dev/null
+++ b/pc-bios/s390-ccw/clp.h
@@ -0,0 +1,24 @@
+/*
+ * Call Logical Processor (CLP) architecture definitions
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef CLP_H
+#define CLP_H
+
+#ifndef QEMU_PACKED
+#define QEMU_PACKED __attribute__((packed))
+#endif
+
+#include <stdint.h>
+#include <s390-pci-clp.h>
+
+int clp_pci(void *data);
+int find_pci_function(uint32_t fid, ClpFhListEntry *entry);
+int enable_pci_function(uint32_t *fhandle);
+
+#endif
diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
new file mode 100644
index 00000000000..ca9565d8ded
--- /dev/null
+++ b/pc-bios/s390-ccw/clp.c
@@ -0,0 +1,99 @@
+/*
+ * Call Logical Processor (CLP) architecture
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "clp.h"
+#include <stdio.h>
+#include <string.h>
+
+int clp_pci(void *data)
+{
+    struct { uint8_t _[CLP_BLK_SIZE]; } *req = data;
+    int cc = 3;
+
+    asm volatile (
+        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
+        "     ipm     %[cc]\n"
+        "     srl     %[cc],28\n"
+        : [cc] "+d" (cc), "+m" (*req)
+        : [req] "a" (req)
+        : "cc");
+    if (cc) {
+        printf("CLP returned with non-zero condition code %d\n", cc);
+    }
+    return cc;
+}
+
+/*
+ * Get the PCI function entry for a given function ID
+ * Return 0 on success, 1 if the FID is not found, or a negative RC on error
+ */
+int find_pci_function(uint32_t fid, ClpFhListEntry *entry)
+{
+    int count = 0;
+    int limit = PCI_MAX_FUNCTIONS;
+    ClpReqRspListPci rrb;
+
+    rrb.request.hdr.len = sizeof(ClpReqListPci);
+    rrb.request.hdr.cmd = 0x02;
+    rrb.request.resume_token = 0;
+    rrb.response.hdr.len = sizeof(ClpRspListPci);
+
+    do {
+        if (clp_pci(&rrb) || rrb.response.hdr.rsp != 0x0010) {
+            puts("Failed to list PCI functions");
+            return -1;
+        }
+
+        /* Resume token set when max entries are returned */
+        if (rrb.response.resume_token) {
+            count = CLP_FH_LIST_NR_ENTRIES;
+            rrb.request.resume_token = rrb.response.resume_token;
+        } else {
+            count = (rrb.response.hdr.len - 32) / sizeof(ClpFhListEntry);
+        }
+
+        limit -= count;
+
+        for (int i = 0; i < count; i++) {
+            if (rrb.response.fh_list[i].fid == fid) {
+                memcpy(entry, &rrb.response.fh_list[i], sizeof(ClpFhListEntry));
+                return 0;
+            }
+        }
+
+    } while (rrb.request.resume_token && limit > 0);
+
+    puts("No function entry found for FID!");
+
+    return 1;
+}
+
+/*
+ * Enable the PCI function associated with a given handle
+ * Return 0 on success or a negative RC on error
+ */
+int enable_pci_function(uint32_t *fhandle)
+{
+    ClpReqRspSetPci rrb;
+
+    rrb.request.hdr.len = sizeof(ClpReqSetPci);
+    rrb.request.hdr.cmd = 0x05;
+    rrb.request.fh = *fhandle;
+    rrb.request.oc = 0;
+    rrb.request.ndas = 1;
+    rrb.response.hdr.len = sizeof(ClpRspSetPci);
+
+    if (clp_pci(&rrb) || rrb.response.hdr.rsp != 0x0010) {
+        puts("Failed to enable PCI function");
+        return -1;
+    }
+
+    *fhandle = rrb.response.fh;
+    return 0;
+}
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 259cff09db6..9c29548f849 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-	  virtio-ccw.o
+	  virtio-ccw.o clp.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.53.0


