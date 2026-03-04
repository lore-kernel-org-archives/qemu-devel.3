Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45E7EDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcTL-0002pb-LC; Tue, 03 Mar 2026 22:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSj-0002Qm-0h; Tue, 03 Mar 2026 21:59:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSh-0000Xx-An; Tue, 03 Mar 2026 21:59:48 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623JFJpA1996000; Wed, 4 Mar 2026 02:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tjFBUSGGGGMUfAtbS
 xZDSvhNFdg0g4My7DJNwfecPy4=; b=qv7ONai+1eYqo4NoOworN0kYrIWU/Li6A
 G+24hV/nFy99mfyRTFhgDBuR4VSIVzv71uutvNc/j06kQN7YTh4IFnY2lN2iBmKW
 H6pDW32BKxKagtP3mivBAcQKQXYiHgqWcjCrUfDDNYCcnNOhFmk5FZFlIVMVRwZd
 j1Zf9FeKWgVHSE8XhpaoP8UOvhZS5Holy+jKytEz1I9cmskM7BjjEJVfUtoJhyP+
 nxY0bCaNs3ZUToci6xFog4ikoakw3QrEIfDp1eobORjEAFMHw/cp6FVg9jmvIO4S
 hwRwa1pSOGVX6ca8P/lq9GZw3gD4fs2YWgrga3OLO28QtKUwRpOOg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcwpm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62405cE7027704;
 Wed, 4 Mar 2026 02:59:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjcr94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xJLg30016020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 989F558059;
 Wed,  4 Mar 2026 02:59:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75E4358043;
 Wed,  4 Mar 2026 02:59:40 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:40 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 10/15] pc-bios/s390-ccw: Introduce PCI device
Date: Tue,  3 Mar 2026 21:59:12 -0500
Message-ID: <20260304025917.2157032-11-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RViLyPv1418g4KP2XU6TterBp4hMRC2o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX9+2hsdfY6NGS
 sa9jHHn9t7nqtM2pLI+4ltGEj5blwIYAUbYrNUP7ttmgqbB/Y8cG010NOc0uCsdDdPxFJDTPDzr
 C5gXKbK6xWpjwZnp6MG+ric3Xn1drd8S3pU9DY33FBZANumyGxt1TFf1yAqFjuBiLDAYMnoKgCe
 Dl4i3rcbElMncLCkvUHMBvPYh9UlaKIpc/2rGpqazF5JeXKS37LuRBxx191m3vRjMsWnO/GVs1c
 aCHOyRda7DPcXFjVMRWHZXA6Pyda+xzQDwRokXhI4zla7SCCP5tkBraNs1LVg2jffBZbZBZos49
 pXpFDUaDjLapCw4AfmnZX7YxGwF10Na3jndwDlPF9/DsTKhWuR8HpzjSLDKevz/qc06Zo6rMNaD
 KKU+KuYyFursZzcsjIeviIuvwF+1aKQND0Kttp726uW6y+IBEqMoBYwV5frnV6jVSr4gLE2fHpb
 5fmKDzT/+5F153D5BmQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a7a020 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=p5Q4SJhZOU-7DgXL5goA:9
X-Proofpoint-ORIG-GUID: RViLyPv1418g4KP2XU6TterBp4hMRC2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Define selected s390x PCI instructions.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile |   2 +-
 pc-bios/s390-ccw/pci.c    | 118 ++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/pci.h    |  39 +++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/pci.c
 create mode 100644 pc-bios/s390-ccw/pci.h

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
 
diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
new file mode 100644
index 0000000000..36e86fcc71
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
+    return rc ? -1 : 0;
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
+    return rc ? -1 : 0;
+}
diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
new file mode 100644
index 0000000000..40a0bf9dcb
--- /dev/null
+++ b/pc-bios/s390-ccw/pci.h
@@ -0,0 +1,39 @@
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
+#define PCIST_DISABLED         0x0
+#define PCIST_ENABLED          0x1
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
-- 
2.52.0


