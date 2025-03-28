Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957FBC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 19:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyF2p-0006qZ-Rw; Fri, 28 Mar 2025 15:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tyF2W-0006kw-HF; Fri, 28 Mar 2025 15:06:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tyF2S-0008Ku-KN; Fri, 28 Mar 2025 15:06:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SE3Cwe017920;
 Fri, 28 Mar 2025 19:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=J0mwcD75hRL6j0S6B
 13UW9e3EdY89HRLmo8A7+2dqFo=; b=PCK9fiAC+J5jca3XKh5PC8bByyN8AYr8M
 gNkF5KeOGWm4077NbiGNVohjTjQBw3NJIb5OHTwqbr0Ee8lfVSFuUg3isNvzimSo
 un7b6XHoohotbTu1XM8kUOhLdsVjHF9x2DD3VZBGMxPoRV8Pd2EPnxA66uGlPxz2
 8E4NFHlXgBQcj8s2G5WdqLpjdqUON4aeo7mLiBOSB9ziDJZ0I3qpoZ6CmDoyc8TE
 ImlxP4F5k1t3xIfm5W196jvYeWsYUUpri1GSLN+bmatDnOfbRB94T27s7QrgawiL
 Laf+h5dzLXiNJu2Zzo3U1D7B/ZOl50lAw2q0dOxsWPYABNV2ey3+Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45nw6p9kkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 19:06:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52SGXprB030418;
 Fri, 28 Mar 2025 19:06:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htv31v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 19:06:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52SJ6W9625559576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Mar 2025 19:06:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBDF25805C;
 Fri, 28 Mar 2025 19:06:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD5965805A;
 Fri, 28 Mar 2025 19:06:32 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.227])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Mar 2025 19:06:32 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com
Subject: [PATCH v2 2/3] include: Add a header to define PCI MMIO functions
Date: Fri, 28 Mar 2025 12:06:26 -0700
Message-ID: <20250328190627.3025-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328190627.3025-1-alifm@linux.ibm.com>
References: <20250328190627.3025-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2mcVHPskHn3GEU9IBFL19nAaVkp1quhX
X-Proofpoint-GUID: 2mcVHPskHn3GEU9IBFL19nAaVkp1quhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=715
 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a generic QEMU API for PCI MMIO reads/writes.
The functions access little endian memory and returns
the result in host cpu endianness.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 include/qemu/pci-mmio.h | 116 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 include/qemu/pci-mmio.h

diff --git a/include/qemu/pci-mmio.h b/include/qemu/pci-mmio.h
new file mode 100644
index 0000000000..2ef92455b1
--- /dev/null
+++ b/include/qemu/pci-mmio.h
@@ -0,0 +1,116 @@
+/*
+ * QEMU PCI MMIO API
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Farhan Ali <alifm@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_PCI_MMIO_H
+#define QEMU_PCI_MMIO_H
+
+#ifdef __s390x__
+#include "s390x_pci_mmio.h"
+#endif
+
+static inline uint8_t qemu_pci_mmio_read_8(const void *ioaddr)
+{
+    uint8_t ret = 0;
+#ifdef __s390x__
+    ret = s390x_pci_mmio_read_8(ioaddr);
+#else
+    /* Prevent the compiler from optimizing away the load */
+    ret = *((volatile uint8_t *)ioaddr);
+#endif
+
+    return ret;
+}
+
+static inline uint16_t qemu_pci_mmio_read_16(const void *ioaddr)
+{
+    uint16_t ret = 0;
+#ifdef __s390x__
+    ret = s390x_pci_mmio_read_16(ioaddr);
+#else
+    /* Prevent the compiler from optimizing away the load */
+    ret = *((volatile uint16_t *)ioaddr);
+#endif
+
+    return le16_to_cpu(ret);
+}
+
+static inline uint32_t qemu_pci_mmio_read_32(const void *ioaddr)
+{
+    uint32_t ret = 0;
+#ifdef __s390x__
+    ret = s390x_pci_mmio_read_32(ioaddr);
+#else
+    /* Prevent the compiler from optimizing away the load */
+    ret = *((volatile uint32_t *)ioaddr);
+#endif
+
+    return le32_to_cpu(ret);
+}
+
+static inline uint64_t qemu_pci_mmio_read_64(const void *ioaddr)
+{
+    uint64_t ret = 0;
+#ifdef __s390x__
+    ret = s390x_pci_mmio_read_64(ioaddr);
+#else
+    /* Prevent the compiler from optimizing away the load */
+    ret = *((volatile uint64_t *)ioaddr);
+#endif
+
+    return le64_to_cpu(ret);
+}
+
+static inline void qemu_pci_mmio_write_8(void *ioaddr, uint8_t val)
+{
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_8(ioaddr, val);
+#else
+    /* Prevent the compiler from optimizing away the store */
+    *((volatile uint8_t *)ioaddr) = val;
+#endif
+}
+
+static inline void qemu_pci_mmio_write_16(void *ioaddr, uint16_t val)
+{
+    val = cpu_to_le16(val);
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_16(ioaddr, val);
+#else
+    /* Prevent the compiler from optimizing away the store */
+    *((volatile uint16_t *)ioaddr) = val;
+#endif
+}
+
+static inline void qemu_pci_mmio_write_32(void *ioaddr, uint32_t val)
+{
+    val = cpu_to_le32(val);
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_32(ioaddr, val);
+#else
+    /* Prevent the compiler from optimizing away the store */
+    *((volatile uint32_t *)ioaddr) = val;
+#endif
+}
+
+static inline void qemu_pci_mmio_write_64(void *ioaddr, uint64_t val)
+{
+    val = cpu_to_le64(val);
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_64(ioaddr, val);
+#else
+    /* Prevent the compiler from optimizing away the store */
+    *((volatile uint64_t *)ioaddr) = val;
+#endif
+}
+
+#endif
-- 
2.43.0


