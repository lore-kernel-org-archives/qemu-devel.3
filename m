Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31BCC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACVz-0003KQ-PJ; Wed, 30 Apr 2025 14:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uACVx-0003Jw-V8
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uACVv-0008Gd-Uq
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:37 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHbhcl015317;
 Wed, 30 Apr 2025 18:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3aE2H3IQXiyOYxy2f
 tLDHYbQjnQLFQPe8YEnK2mDg+I=; b=CXGCZPGWDOnwR9wF8yC3LQDJ7TmhLw5xI
 FW+QyxK7OE9/zS90iIJyEFSI2YVzeKe+JI1c0gtkIXt+Jm7LMxiHllDc+6Fu/EaN
 te4niNSDA4xAsDpwy5sRqttMuekk4b1FZJdsdTuOhkQVuhB6xGYf6T4mJamvkOAV
 YzsGWSyn5JsyJml3kKl8FaVOB2rlimTkanC+wvtad2jyWrvqQIwCREffh3Uc5T+H
 hMZn/wORV2dxsW09cnPtPeMwxCJOOqfVItdF6gyEBWe7RjZwlGm0S6r8MFn3MSqJ
 QszpzyCkAp+gxyXvAIqjRnGEh1I24WnhDFGkIi+9k2KW00FBpudbQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6upn1gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 18:50:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UGKfea016112;
 Wed, 30 Apr 2025 18:50:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70he0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 18:50:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53UIoIqg30081644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 18:50:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C353A58063;
 Wed, 30 Apr 2025 18:50:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2114858059;
 Wed, 30 Apr 2025 18:50:18 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.230])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Apr 2025 18:50:17 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, alifm@linux.ibm.com,
 mjrosato@linux.ibm.com, schnelle@linux.ibm.com, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net
Subject: [PATCH v6 1/3] util: Add functions for s390x mmio read/write
Date: Wed, 30 Apr 2025 11:50:10 -0700
Message-ID: <20250430185012.2303-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430185012.2303-1-alifm@linux.ibm.com>
References: <20250430185012.2303-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqQecK/g c=1 sm=1 tr=0 ts=681270ef cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=-3YU2YgekH6Hxld7bwEA:9
X-Proofpoint-ORIG-GUID: ZWgmDWdud04G17Lp_sTerHpUWx1ZpJ0c
X-Proofpoint-GUID: ZWgmDWdud04G17Lp_sTerHpUWx1ZpJ0c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEzNiBTYWx0ZWRfX0fokE87rP3z4
 Tn/v+pEybqbSUtpczrt5MyDLutvqBB92V5J68ZvOoI+VtPetLJ5iCfjaymZhCHfIiFgPRNQsA2a
 i7JDzHfaN9sCPiLOAHXcn313OWgpqOymFkQyvdH5Flb9mcVo4NikaOFrPBh9erZSDBgfgxfhFF7
 svt8HmjyL/msxCBOy7WnOv75D3eqeRDJ2aFBNcJ26I3cop000f5ZftB4HvRG2Uq1K0Nys5CWrvF
 NkL/T6GYbN27/RfgOtIywpick4mmXRWrgT/79dHCujUGCPTZJRr1ZOxVbuXHrn6r4+mdzaJIUV4
 xTWUgnnwdRNX7UgTFUS8opT0GkNLNaGqf0Cu6Q1qjfH5Q6UOtcHkivXGMP5Tbzu7nXmHlta0oBA
 jGzXFmi861S3+nX/8yRDYmJHbUqPBJPmNymJGVGbFM0Y+xDqy6UoNKNX67sk6K5cp7PwAXjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=631 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300136
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
 util/s390x_pci_mmio.c         | 146 ++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
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
index 0000000000..5ab24fa474
--- /dev/null
+++ b/util/s390x_pci_mmio.c
@@ -0,0 +1,146 @@
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
+        [ioaddr_len] "+d"(ioaddr_len.pair) :: "cc");
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
+        : [ioaddr_len] "+d" (ioaddr_len.pair)
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
-- 
2.43.0


