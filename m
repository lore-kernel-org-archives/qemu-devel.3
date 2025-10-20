Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3308FCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAscj-0003j6-DF; Mon, 20 Oct 2025 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAscf-0003gy-VP; Mon, 20 Oct 2025 12:20:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAscd-0000sP-JU; Mon, 20 Oct 2025 12:20:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFNawE013009;
 Mon, 20 Oct 2025 16:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fuuANGqPQMbYTgFcN
 f4ybcycvExWfEtGEzuckzyU/xo=; b=G+4Qi4IB0nMElkZnxkRHtg6SbPnA4LjnK
 xOp/fImA1MUgWb+G3wS30wLNG8tKV9BDGFa5eSEgZq2JSAV7Il1Zpp8z5cP7YTxk
 kJTgHY2oA2wufWkToIWbfok/KOJITDE6WjXHWCd3p+C89DbYD2esbQPq32fQWA2Y
 yz28M08OOF0Q58JQrYV6uP50H/vyhDLn+WvI9F72+qQ7BebagE3EWdoBkB5gbQPn
 b1oc/DglBX/FNE6pCy3GmYKB2KGc4lo8gZfEVn7VvKcyHKH2vQHI97SLS/t3vEAe
 caltaVO8xTIcIOKsGYToysjU7hK88oYZWBZk1Pv5LOyM++DCfcC+A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c1e30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KE09Gg014685;
 Mon, 20 Oct 2025 16:20:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7rxrqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KGKWOh6685296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 16:20:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19DB758067;
 Mon, 20 Oct 2025 16:20:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4694E58065;
 Mon, 20 Oct 2025 16:20:31 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.78.141])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 16:20:31 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 3/7] pc-bios/s390-ccw: Introduce CLP Architecture
Date: Mon, 20 Oct 2025 12:20:19 -0400
Message-ID: <20251020162023.3649165-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251020162023.3649165-1-jrossi@linux.ibm.com>
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OQPkbTRD8irdY8VpwRP8berbbGQGncZ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/jkiGFz4wmI1
 VwYjNgWyrHih7RXNQSNpjHes4vNyRj4wC5dwcaOZM9qkUGN3lK2L6rwfoRLc3MYX3bs9ahb/M8a
 g43E5waYUTixGE8xD5TGXNfoo496Nkko3TlnMUrJi8MBzV8Y+YkA4FGbKZO9sGJIjStTTnCU5m/
 RoPeX3ceIWOPgySLBW8ZDISe7UuSpnNSxNiFD4X7x8ICoEfdkF1JRz/SHy8IfbKjt/zW0N0i7Fo
 g8S7qeQZyOHlKjJ2ZH1W/UdqVKEjtkZ+7bS2XGPJNBTNmlVaGD4q/dOsRf9448DnR89uP4dlZuk
 oPIF42wgPFoy8fGS4h0jGbZNbE+YVfB9pgoQJ/I/ZpsXjeRBKhZT5jubmmLFAUKN9T3Vni8nBuC
 WqLuDJenmekHXiYN0rPPsD1r8zVGbQ==
X-Proofpoint-GUID: OQPkbTRD8irdY8VpwRP8berbbGQGncZ6
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f66151 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=B6FfjjnMrpp8agTJrekA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
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

Call Logical Processor (CLP) Architecture is used for managing PCI functions on
s390x. Define and include the structures and routines needed to interact with
PCI devices during IPL.

Headers in ~/qemu/include/hw are not normally visible and must be included
using a relative path.  Due to this, the QEMU_PACKED macro must also be defined
here.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/clp.h    |  24 +++++++++
 pc-bios/s390-ccw/clp.c    | 106 ++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/Makefile |   2 +-
 3 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/clp.h
 create mode 100644 pc-bios/s390-ccw/clp.c

diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
new file mode 100644
index 0000000000..cb130e5e90
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
+#include "../../include/hw/s390x/s390-pci-clp.h"
+
+int clp_pci(void *data);
+int enable_pci_function(uint32_t *fhandle);
+int enumerate_pci_functions(void);
+
+#endif
diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
new file mode 100644
index 0000000000..45d496fc18
--- /dev/null
+++ b/pc-bios/s390-ccw/clp.c
@@ -0,0 +1,106 @@
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
+    struct { uint8_t _[2048]; } *req = data;
+    int cc = 3;
+
+    asm volatile (
+        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
+        "     ipm     %[cc]\n"
+        "     srl     %[cc],28\n"
+        : [cc] "+d" (cc), "+m" (*req)
+        : [req] "a" (req)
+        : "cc");
+    return cc;
+}
+
+/*
+ * Get the PCI function entry for a given function ID
+ * Return 0 on success, 1 if the FID is not found, or a negative RC on error
+ */
+int find_pci_function(uint32_t fid, ClpFhListEntry *entry)
+{
+    int rc;
+    int count = 0;
+    int limit = PCI_MAX_FUNCTIONS;
+    ClpReqRspListPci rrb;
+
+    rrb.request.hdr.len = 32;
+    rrb.request.hdr.cmd = 0x02;
+    rrb.request.resume_token = 0;
+    rrb.response.hdr.len = sizeof(ClpRspListPci);
+
+    do {
+        rc = clp_pci(&rrb);
+        if (rc) {
+            return -rc;
+        }
+
+        if (rrb.response.hdr.rsp != 0x0010) {
+            printf("Failed to list PCI functions: %x", rrb.response.hdr.rsp);
+            return -1;
+        }
+
+        /* Resume token set when max enteries are returned */
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
+    } while (rrb.request.resume_token && limit);
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
+    int rc;
+
+    rrb.request.hdr.len = 32;
+    rrb.request.hdr.cmd = 0x05;
+    rrb.request.fh = *fhandle;
+    rrb.request.oc = 0;
+    rrb.request.ndas = 1;
+    rrb.response.hdr.len = 32;
+
+    rc = clp_pci(&rrb);
+    if (rc) {
+        return -rc;
+    }
+
+    if (rrb.response.hdr.rsp != 0x0010) {
+        printf("Failed to enable PCI function: %x", rrb.response.hdr.rsp);
+        return -1;
+    }
+
+    *fhandle = rrb.response.fh;
+    return 0;
+}
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 3577ac381a..89a42ae506 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
       virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-      virtio-ccw.o
+      virtio-ccw.o clp.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.49.0


