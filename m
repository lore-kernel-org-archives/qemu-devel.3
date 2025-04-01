Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0B4C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 17:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzfKZ-0004j3-5h; Tue, 01 Apr 2025 13:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzfKG-0004fv-Br; Tue, 01 Apr 2025 13:23:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzfKD-0005v5-FM; Tue, 01 Apr 2025 13:23:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531Gf3gm021141;
 Tue, 1 Apr 2025 17:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XbxOmOxaCGJ2wrgJR
 qkKjhBcMBVejLmaBs+JzNXKqsI=; b=JkNWaIJGidtrhmdMF5EjeNtC4IuEJE/AG
 S7BFCez9mZ91wuwo9hTnX4+OHCp0LOwyIYVJh1vbCqJZUOtjOdcX53xD6a5c8usK
 IXY44qdq++vz/txXljoKl7dbgohqpOfSX/k1a/16Ums75pHQI4T4Hyf6IFkZN1r5
 I1zxpdwNUsxON+/PNMXnu4ykAIt/iAvcynwi8eGKQfaA34bI3+CqG7sIw6AFB7sA
 clYldpsT3RhVxH0+xMwh086f4BaRessvMxfZLdXPFpZ5JnUjxPJOg35Olal39Q70
 eC0yx2dbaU0OnL4iopimDBVGi8wSQYDzcox6a+3ZrlzbBSWXZlkIQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rhjps1q9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 17:22:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531GailC004788;
 Tue, 1 Apr 2025 17:22:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujyundk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 17:22:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 531HMmh515008436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Apr 2025 17:22:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5C5A58059;
 Tue,  1 Apr 2025 17:22:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8526158061;
 Tue,  1 Apr 2025 17:22:47 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.127])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Apr 2025 17:22:47 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com
Subject: [PATCH v3 1/3] util: Add functions for s390x mmio read/write
Date: Tue,  1 Apr 2025 10:22:44 -0700
Message-ID: <20250401172246.2688-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172246.2688-1-alifm@linux.ibm.com>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wF1sj1XXzUVJei_bkVFhr-UEzVek6GyB
X-Proofpoint-ORIG-GUID: wF1sj1XXzUVJei_bkVFhr-UEzVek6GyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=629 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010104
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

Starting with z15 (or newer) we can execute mmio
instructions from userspace. On older platforms
where we don't have these instructions available
we can fallback to using system calls to access
the PCI mapped resources.

This patch adds helper functions for mmio reads
and writes for s390x.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 include/qemu/s390x_pci_mmio.h |  24 ++++++
 util/meson.build              |   2 +
 util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 include/qemu/s390x_pci_mmio.h
 create mode 100644 util/s390x_pci_mmio.c

diff --git a/include/qemu/s390x_pci_mmio.h b/include/qemu/s390x_pci_mmio.h
new file mode 100644
index 0000000000..c5f63ecefa
--- /dev/null
+++ b/include/qemu/s390x_pci_mmio.h
@@ -0,0 +1,24 @@
+/*
+ * s390x PCI MMIO definitions
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Farhan Ali <alifm@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef S390X_PCI_MMIO_H
+#define S390X_PCI_MMIO_H
+
+#ifdef __s390x__
+uint8_t s390x_pci_mmio_read_8(const void *ioaddr);
+uint16_t s390x_pci_mmio_read_16(const void *ioaddr);
+uint32_t s390x_pci_mmio_read_32(const void *ioaddr);
+uint64_t s390x_pci_mmio_read_64(const void *ioaddr);
+
+void s390x_pci_mmio_write_8(void *ioaddr, uint8_t val);
+void s390x_pci_mmio_write_16(void *ioaddr, uint16_t val);
+void s390x_pci_mmio_write_32(void *ioaddr, uint32_t val);
+void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val);
+#endif /* __s390x__ */
+
+#endif /* S390X_PCI_MMIO_H */
diff --git a/util/meson.build b/util/meson.build
index 780b5977a8..acb21592f9 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -131,4 +131,6 @@ elif cpu in ['ppc', 'ppc64']
   util_ss.add(files('cpuinfo-ppc.c'))
 elif cpu in ['riscv32', 'riscv64']
   util_ss.add(files('cpuinfo-riscv.c'))
+elif cpu == 's390x'
+  util_ss.add(files('s390x_pci_mmio.c'))
 endif
diff --git a/util/s390x_pci_mmio.c b/util/s390x_pci_mmio.c
new file mode 100644
index 0000000000..820458a026
--- /dev/null
+++ b/util/s390x_pci_mmio.c
@@ -0,0 +1,148 @@
+/*
+ * s390x PCI MMIO definitions
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Farhan Ali <alifm@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <unistd.h>
+#include <sys/syscall.h>
+#include "qemu/s390x_pci_mmio.h"
+#include "elf.h"
+
+union register_pair {
+    unsigned __int128 pair;
+    struct {
+        uint64_t even;
+        uint64_t odd;
+    };
+};
+
+static bool is_mio_supported;
+
+static __attribute__((constructor)) void check_is_mio_supported(void)
+{
+    is_mio_supported = !!(qemu_getauxval(AT_HWCAP) & HWCAP_S390_PCI_MIO);
+}
+
+static uint64_t s390x_pcilgi(const void *ioaddr, size_t len)
+{
+    union register_pair ioaddr_len = { .even = (uint64_t)ioaddr,
+                                       .odd = len };
+    uint64_t val;
+    int cc;
+
+    asm volatile(
+        /* pcilgi */
+        ".insn   rre,0xb9d60000,%[val],%[ioaddr_len]\n"
+        "ipm     %[cc]\n"
+        "srl     %[cc],28\n"
+        : [cc] "=d"(cc), [val] "=d"(val),
+        [ioaddr_len] "+&d"(ioaddr_len.pair) :: "cc");
+
+    if (cc) {
+        val = -1ULL;
+    }
+
+    return val;
+}
+
+static void s390x_pcistgi(void *ioaddr, uint64_t val, size_t len)
+{
+    union register_pair ioaddr_len = {.even = (uint64_t)ioaddr, .odd = len};
+
+    asm volatile (
+        /* pcistgi */
+        ".insn   rre,0xb9d40000,%[val],%[ioaddr_len]\n"
+        : [ioaddr_len] "+&d" (ioaddr_len.pair)
+        : [val] "d" (val)
+        : "cc", "memory");
+}
+
+uint8_t s390x_pci_mmio_read_8(const void *ioaddr)
+{
+    uint8_t val = 0;
+
+    if (is_mio_supported) {
+        val = s390x_pcilgi(ioaddr, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
+    }
+    return val;
+}
+
+uint16_t s390x_pci_mmio_read_16(const void *ioaddr)
+{
+    uint16_t val = 0;
+
+    if (is_mio_supported) {
+        val = s390x_pcilgi(ioaddr, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
+    }
+    return val;
+}
+
+uint32_t s390x_pci_mmio_read_32(const void *ioaddr)
+{
+    uint32_t val = 0;
+
+    if (is_mio_supported) {
+        val = s390x_pcilgi(ioaddr, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
+    }
+    return val;
+}
+
+uint64_t s390x_pci_mmio_read_64(const void *ioaddr)
+{
+    uint64_t val = 0;
+
+    if (is_mio_supported) {
+        val = s390x_pcilgi(ioaddr, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
+    }
+    return val;
+}
+
+void s390x_pci_mmio_write_8(void *ioaddr, uint8_t val)
+{
+    if (is_mio_supported) {
+        s390x_pcistgi(ioaddr, val, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
+    }
+}
+
+void s390x_pci_mmio_write_16(void *ioaddr, uint16_t val)
+{
+    if (is_mio_supported) {
+        s390x_pcistgi(ioaddr, val, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
+    }
+}
+
+void s390x_pci_mmio_write_32(void *ioaddr, uint32_t val)
+{
+    if (is_mio_supported) {
+        s390x_pcistgi(ioaddr, val, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
+    }
+}
+
+void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val)
+{
+    if (is_mio_supported) {
+        s390x_pcistgi(ioaddr, val, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
+    }
+}
+
-- 
2.43.0


