Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E16CC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 21:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4RTs-0007xu-P1; Mon, 14 Apr 2025 17:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u4RTl-0007un-S4; Mon, 14 Apr 2025 17:36:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u4RTj-0003Go-Ev; Mon, 14 Apr 2025 17:36:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIXlsv026521;
 Mon, 14 Apr 2025 21:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TvFELmmpf/sdEtzfj
 CrR1PgRLUIupH4ECKzApQitp2s=; b=aSwVEMgH+aY4R/t89/EwkV+d+dYijKrZw
 G01GUVdjWN72k4qJXZ64pWe0dJYDIbZjt/hYoBq3bTW+QsiUhqZZlNCaNQrjiNRi
 L27Hu/Q6Sx+EvtN2aJA5D85RiLMGwzWpHQuuzy0lJ/Q+5w+RzzZB5BmU1y/OKbWc
 8sqF7Oi5Ede3N1E5ssmpHMQunwwh7n6M4uflQEmrHTUGasWOIdP/pWfTMpcCwHbJ
 OfVB2zzHeDAqODL9guMY7mQkUCXNdU9+9E/DTUyr8rCKodBBOw6a8DWi26by5Ro8
 nENbMmTWm5ruuuPZWshwcPJwHD/UyqW9NUeXk0qQmuea6PM+4kdUA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46109f36db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 21:36:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ELBuic017170;
 Mon, 14 Apr 2025 21:36:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kqypd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 21:36:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53ELaNiD27853392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 21:36:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F7505804E;
 Mon, 14 Apr 2025 21:36:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20AE15803F;
 Mon, 14 Apr 2025 21:36:22 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.75])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Apr 2025 21:36:21 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, stefanha@redhat.com, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net,
 alex.williamson@redhat.com
Subject: [PATCH v4 2/3] include: Add a header to define host PCI MMIO functions
Date: Mon, 14 Apr 2025 14:36:15 -0700
Message-ID: <20250414213616.2675-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414213616.2675-1-alifm@linux.ibm.com>
References: <20250414213616.2675-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qF3nRASHSHWyMIfZCTXG-YHhPBtzWlqM
X-Proofpoint-ORIG-GUID: qF3nRASHSHWyMIfZCTXG-YHhPBtzWlqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=853 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140157
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
index 0000000000..de17d67e3a
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
+    ret = ldub_he_p(ioaddr);
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


