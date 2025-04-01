Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A31C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 17:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzfKX-0004iZ-7C; Tue, 01 Apr 2025 13:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzfKF-0004fn-Si; Tue, 01 Apr 2025 13:23:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzfKD-0005vH-5s; Tue, 01 Apr 2025 13:22:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531Gf4G4002444;
 Tue, 1 Apr 2025 17:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bCFobd
 StZf3H/XWan64B1rnOwW39hOKaIS5l8IoldU0=; b=s0PCyytgMbZ1K71h59q4V9
 jKNTud1KeGRqqlJRMdsKMr0r49qS8WYoE3Zgj5sGjbcCNQzzK+A/pvmYvAxXppUF
 fk6JvEB++9daWvdBSsnfgr8aMSt3kBjA1eg9+HOcTX8AFVdKoHggQS2IPkMP4+nJ
 MUGKB36dvYOiUAcws+Fs4PRAPC/m5K9p02DHwX27lImFEy/4GVayibEAlSN/M2Cy
 cFuSEqbUBSVhRdr5uV74dljt3S1z6XIcubfSnoY8ZMHT4px6eiqX6FWhszYz2bwh
 mkvtLET2bAgP3SE0iBbVLyXgOr66ijpaL3eQGkXg9O5RI9B8+sx5lE4cSFfh/wIg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r290n2ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 17:22:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531DJqAo009999;
 Tue, 1 Apr 2025 17:22:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6nug9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 17:22:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 531HMnAB30016014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Apr 2025 17:22:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3ACC58058;
 Tue,  1 Apr 2025 17:22:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9BAB5805D;
 Tue,  1 Apr 2025 17:22:48 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.127])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Apr 2025 17:22:48 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com
Subject: [PATCH v3 2/3] include: Add a header to define host PCI MMIO functions
Date: Tue,  1 Apr 2025 10:22:45 -0700
Message-ID: <20250401172246.2688-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172246.2688-1-alifm@linux.ibm.com>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UFtx_qgfqYEixo8eeXe9DJywsySy5gTp
X-Proofpoint-GUID: UFtx_qgfqYEixo8eeXe9DJywsySy5gTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=823
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add a generic API for host PCI MMIO reads/writes
(e.g. Linux VFIO BAR accesses). The functions access
little endian memory and returns the result in
host cpu endianness.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 include/qemu/host-pci-mmio.h | 116 +++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 include/qemu/host-pci-mmio.h

diff --git a/include/qemu/host-pci-mmio.h b/include/qemu/host-pci-mmio.h
new file mode 100644
index 0000000000..c26426524f
--- /dev/null
+++ b/include/qemu/host-pci-mmio.h
@@ -0,0 +1,116 @@
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
+static inline uint8_t host_pci_mmio_read_8(const void *ioaddr)
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
+static inline uint16_t host_pci_mmio_read_16(const void *ioaddr)
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
+static inline uint32_t host_pci_mmio_read_32(const void *ioaddr)
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
+static inline uint64_t host_pci_mmio_read_64(const void *ioaddr)
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
+static inline void host_pci_mmio_write_8(void *ioaddr, uint8_t val)
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
+static inline void host_pci_mmio_write_16(void *ioaddr, uint16_t val)
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
+static inline void host_pci_mmio_write_32(void *ioaddr, uint32_t val)
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
+static inline void host_pci_mmio_write_64(void *ioaddr, uint64_t val)
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


