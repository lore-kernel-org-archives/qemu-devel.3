Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C1AC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TCf-0001oI-0e; Thu, 17 Apr 2025 13:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u5TCR-0001WL-Tc
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:38:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u5TCQ-0002Sh-2D
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:38:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H9eJdK017979;
 Thu, 17 Apr 2025 17:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ki3ELcws0F/6yVPK5
 F7GwBlDjRgCuqWwKRM00RO615Y=; b=mk6Q5lzMtLtq2RvmFoI7SVxFrUdVUT/Z9
 vHCFM6sXBfboo9vt0bjhsEhBMzbk0L9ZizMRHyD7+0imsqnx+qE7MTcXE0VZLKYW
 03Bv5xZz5Xw01yI57+HisWo9UPhxFlMHibea6prVUFN8lsr0IrYXBQOfPSaI2yg1
 jN8UgXRGgT/cRYsKl5fEfrJt+wChbiBLsTkAir25/ql2eAsLuR7NeuPYOlI9uwfI
 fO+7uoZWcozvI3nwHWtkRhw5V0ssfluFRPHaFb4y5LNAOo0AQ/VtVG032TZv+Vfz
 DwyUhVwZyKLQSY5locHqK7HKKfHkECXvQHuGgLTh6Lo9s7yyjNwgQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu54qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 17:38:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HG1mnt016407;
 Thu, 17 Apr 2025 17:38:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460572ef83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 17:38:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HHc7iW25952806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 17:38:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C22758060;
 Thu, 17 Apr 2025 17:38:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD23758063;
 Thu, 17 Apr 2025 17:38:05 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.65])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Apr 2025 17:38:05 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, alifm@linux.ibm.com,
 mjrosato@linux.ibm.com, schnelle@linux.ibm.com, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net
Subject: [PATCH v5 2/3] include: Add a header to define host PCI MMIO functions
Date: Thu, 17 Apr 2025 10:38:00 -0700
Message-ID: <20250417173801.827-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417173801.827-1-alifm@linux.ibm.com>
References: <20250417173801.827-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=68013c81 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=0NFZlXjHx2QF6stEu-oA:9
X-Proofpoint-ORIG-GUID: QGcu-5ZsXtmdiTvUDqGJoy23W-ALdLR7
X-Proofpoint-GUID: QGcu-5ZsXtmdiTvUDqGJoy23W-ALdLR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=853 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add a generic API for host PCI MMIO reads/writes
(e.g. Linux VFIO BAR accesses). The functions access
little endian memory and returns the result in
host cpu endianness.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 include/qemu/host-pci-mmio.h | 141 +++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 include/qemu/host-pci-mmio.h

diff --git a/include/qemu/host-pci-mmio.h b/include/qemu/host-pci-mmio.h
new file mode 100644
index 0000000000..c93f77dcd4
--- /dev/null
+++ b/include/qemu/host-pci-mmio.h
@@ -0,0 +1,141 @@
+/*
+ * API for host PCI MMIO accesses (e.g. Linux VFIO BARs)
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Farhan Ali <alifm@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HOST_PCI_MMIO_H
+#define HOST_PCI_MMIO_H
+
+#include "qemu/bswap.h"
+#include "qemu/s390x_pci_mmio.h"
+
+
+static inline uint8_t host_pci_ldub_p(const void *ioaddr)
+{
+    uint8_t ret = 0;
+#ifdef __s390x__
+    ret = s390x_pci_mmio_read_8(ioaddr);
+#else
+    ret = ldub_p(ioaddr);
+#endif
+
+    return ret;
+}
+
+static inline uint16_t host_pci_lduw_le_p(const void *ioaddr)
+{
+    uint16_t ret = 0;
+#ifdef __s390x__
+    ret = le16_to_cpu(s390x_pci_mmio_read_16(ioaddr));
+#else
+    ret = lduw_le_p(ioaddr);
+#endif
+
+    return ret;
+}
+
+static inline uint32_t host_pci_ldl_le_p(const void *ioaddr)
+{
+    uint32_t ret = 0;
+#ifdef __s390x__
+    ret = le32_to_cpu(s390x_pci_mmio_read_32(ioaddr));
+#else
+    ret = (uint32_t)ldl_le_p(ioaddr);
+#endif
+
+    return ret;
+}
+
+static inline uint64_t host_pci_ldq_le_p(const void *ioaddr)
+{
+    uint64_t ret = 0;
+#ifdef __s390x__
+    ret = le64_to_cpu(s390x_pci_mmio_read_64(ioaddr));
+#else
+    ret = ldq_le_p(ioaddr);
+#endif
+
+    return ret;
+}
+
+static inline void host_pci_stb_le_p(void *ioaddr, uint8_t val)
+{
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_8(ioaddr, val);
+#else
+    stb_p(ioaddr, val);
+#endif
+}
+
+static inline void host_pci_stw_le_p(void *ioaddr, uint16_t val)
+{
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_16(ioaddr, cpu_to_le16(val));
+#else
+    stw_le_p(ioaddr, val);
+#endif
+}
+
+static inline void host_pci_stl_le_p(void *ioaddr, uint32_t val)
+{
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_32(ioaddr, cpu_to_le32(val));
+#else
+    stl_le_p(ioaddr, val);
+#endif
+}
+
+static inline void host_pci_stq_le_p(void *ioaddr, uint64_t val)
+{
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_64(ioaddr, cpu_to_le64(val));
+#else
+    stq_le_p(ioaddr, val);
+#endif
+}
+
+static inline uint64_t host_pci_ldn_le_p(const void *ioaddr, int sz)
+{
+    switch (sz) {
+    case 1:
+        return host_pci_ldub_p(ioaddr);
+    case 2:
+        return host_pci_lduw_le_p(ioaddr);
+    case 4:
+        return host_pci_ldl_le_p(ioaddr);
+    case 8:
+        return host_pci_ldq_le_p(ioaddr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static inline void host_pci_stn_le_p(void *ioaddr, int sz, uint64_t v)
+{
+    switch (sz) {
+    case 1:
+        host_pci_stb_le_p(ioaddr, v);
+        break;
+    case 2:
+        host_pci_stw_le_p(ioaddr, v);
+        break;
+    case 4:
+        host_pci_stl_le_p(ioaddr, v);
+        break;
+    case 8:
+        host_pci_stq_le_p(ioaddr, v);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+#endif
-- 
2.43.0


