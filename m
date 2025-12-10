Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E572ED3B9AB
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTRDM-0004iY-Hb; Wed, 10 Dec 2025 15:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDH-0004eS-S5; Wed, 10 Dec 2025 15:55:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDG-0000gr-2g; Wed, 10 Dec 2025 15:55:07 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAK0EZl026189;
 Wed, 10 Dec 2025 20:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uSAqjqF+gJMVXccwz
 x+qNkuenaAbjiZEfc2myGVcWjE=; b=iVnPxq2YnnyhD/5gcdYw7BLZHJ2obFy+f
 BbmyItB2oDWgzXpKbQT+YRBU2+9roCKlPr7IZpE7hMpNZ2f7gx6HKY+SL2eos+Gp
 jblFS7hL9hngg0n6RMZVkmEg5KqlvAVSlA+HSutu2q0dmfUq+VoLkWENNi7pEgwK
 DXxpclQotDcki09HXJBg7Lf2BscptcH1adPatdc474A04eeG4mKydBoAnQ/mVPO6
 zcnYWwGY1Z90P3s/Aeuy7SBo0gExaxcVppxvWieIGakFZCGuqNs9Q73tiWya3mIt
 XNKNI+cbRC8uudaetZWMJuL72apT4SQkIABnFlMdh4svHRA8bul3Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0k4hxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJTlRH028141;
 Wed, 10 Dec 2025 20:55:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6y2wkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BAKt0Gb34079390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 20:55:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D80EB5805D;
 Wed, 10 Dec 2025 20:55:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E94258052;
 Wed, 10 Dec 2025 20:55:00 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.53.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Dec 2025 20:55:00 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 05/10] pc-bios/s390-ccw: Introduce CLP Architecture
Date: Wed, 10 Dec 2025 15:54:44 -0500
Message-ID: <20251210205449.2783111-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210205449.2783111-1-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=6939de27 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=B6FfjjnMrpp8agTJrekA:9
X-Proofpoint-ORIG-GUID: 8QvwgJ7Nyeq3Xmqm5jPbJg9egvsZtNlq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX91Dotx28xnR6
 rLxM2p9VFwv/JiSRf7XZzUOMpxjuqG8AMG//iS5sTS/kFBXqVSGejv2Dhys4GHhVcZDjwHyK/n4
 lY3A8OeIED+yyhHbo4ntpoiOKg2F7ARn0CL3uky3Uwu8F1AHQKHvr3ERrkuwmxHLnQq9io2oyLc
 NXFiXjr8Q7olt53NpK5BJA0KrPspo2wKTpYfFpPyc/79PNW+9uEDSK2DV0Se6WRZ15M2Bph6UPB
 Ynf1JaY2e/jFndZU0uAcuTxw2mVfPMFjlvI+joo1eVfDvaWrg94fWXiTOyLZ1q+fJGUZiuUalIX
 TiO+8TCorArlgllhsjaqiOZxFBQ80G+uCRzRgqUTb3FFBmFmbqdtPsVPz81bNQtoxCtHLoLsYxQ
 8Qi2wJQZk1r/DZX+c/3wWECK1R3+Xg==
X-Proofpoint-GUID: 8QvwgJ7Nyeq3Xmqm5jPbJg9egvsZtNlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/clp.h    | 24 ++++++++++
 pc-bios/s390-ccw/clp.c    | 96 +++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/Makefile |  2 +-
 3 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/clp.h
 create mode 100644 pc-bios/s390-ccw/clp.c

diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
new file mode 100644
index 0000000000..1ac2f8c177
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
index 0000000000..6dc72c685c
--- /dev/null
+++ b/pc-bios/s390-ccw/clp.c
@@ -0,0 +1,96 @@
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
+        if (clp_pci(&rrb) || (rrb.response.hdr.rsp != 0x0010)) {
+            puts("Failed to list PCI functions");
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
+    rrb.request.hdr.len = 32;
+    rrb.request.hdr.cmd = 0x05;
+    rrb.request.fh = *fhandle;
+    rrb.request.oc = 0;
+    rrb.request.ndas = 1;
+    rrb.response.hdr.len = 32;
+
+    if (clp_pci(&rrb) || (rrb.response.hdr.rsp != 0x0010)) {
+        puts("Failed to enable PCI function");
+        return -1;
+    }
+
+    *fhandle = rrb.response.fh;
+    return 0;
+}
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 259cff09db..9c29548f84 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-	  virtio-ccw.o
+	  virtio-ccw.o clp.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.49.0


