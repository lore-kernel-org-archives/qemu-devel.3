Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDE3EDEC04
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcTK-0002pE-UX; Tue, 03 Mar 2026 22:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSc-0002Ol-Pa; Tue, 03 Mar 2026 21:59:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSb-0000Wo-4u; Tue, 03 Mar 2026 21:59:42 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623JQLLq2063698; Wed, 4 Mar 2026 02:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lbnPeV9TxY7e2LPBy
 8wN86BvjmhHud76tz6Fiup0iag=; b=eQ7h8FbpfUEivSqRkyfdmqsq7n8aI6H8w
 /mTOhwdN9b3BnK7B/BsYsNU4xRZvxhGVHchzXkcR7z83XYg2dlWOCyO7z8fg7EHd
 0tyl+4LD56Og/5FlDi7nCnoEqFP0VJ5+KbcWjclG3g9XL++yFWJWC8NVPfK8m92h
 FXuXHXUZCpdEAE9pRSanIRY3fskAQIvDQHxmhTsCDreIPpLKbRDrael4v03tpWro
 KGOOpW3LblvjD46MUGoW6mY6JkDOwtak1LXfKYcNFFbQwye+ugAom2xWRB1dHEuY
 bUWw0Ao80U0eTz+bGbagA1M1F5TXzKkVCVoG2lWVZ5NRis+vETPxg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3wc76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623Nwiak010335;
 Wed, 4 Mar 2026 02:59:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k4xer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xbnG32572066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB9E758061;
 Wed,  4 Mar 2026 02:59:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88EC058043;
 Wed,  4 Mar 2026 02:59:36 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:36 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 08/15] pc-bios/s390-ccw: Introduce CLP Architecture
Date: Tue,  3 Mar 2026 21:59:10 -0500
Message-ID: <20260304025917.2157032-9-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3YAYYcixNoYJCATSjk0udR5FY79FPMgL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfXzy1meh+8YDAg
 nSIeVSZwcOqmfMSUinVCaUvU8CuRftkCwck46X+FCPKvDb/XCtKHmGIauLXmGaDgOIhryDiAWw2
 Wm7ohfHoA9B9slLWUXLd8kQXA+hHjZr/hVJcCdRI0pRnYJmvrji7Y/aX8S5Fm3SJA4AXR/iEAAO
 ch9excMufD0NnQiuYz7e9OGydf78sPCycAciAOBlUjUQ5JXznFXMWb6ABhIYszh7lhuBKt/uULf
 T8qMYpKpZfAumvPfqgYnTZx3Eg7gXa2SK4REFg1sKPTk9e8vUflWP8sgoAMAhIYQBUtHhW5LB3s
 chwB8Xu8B47x7ZVRnky88MbxnB0nnQjV8NsYe2x9jevPpvGSR1hKOIzM3exRItyOGB8D3nLTKd0
 q9eOLqyTmS83pj8IV2vzXCFJhi8IAzwt7lPoyKLvL93ehVg0Fyr6T4SMVhDIgUnWcaKi1oaiIPt
 oA3FWD6v0mnmn+sxOkA==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a7a01b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=B6FfjjnMrpp8agTJrekA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: 3YAYYcixNoYJCATSjk0udR5FY79FPMgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

Call Logical Processor (CLP) Architecture is used for managing PCI functions on
s390x. Define and include the structures and routines needed to interact with
PCI devices during IPL.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile |  2 +-
 pc-bios/s390-ccw/clp.c    | 99 +++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/clp.h    | 24 ++++++++++
 3 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/clp.c
 create mode 100644 pc-bios/s390-ccw/clp.h

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
 
diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
new file mode 100644
index 0000000000..8c04738bbf
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
-- 
2.52.0


