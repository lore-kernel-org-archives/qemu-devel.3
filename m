Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0825EC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD29L-00058l-87; Thu, 08 May 2025 10:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD29G-0004tp-Ha
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD298-0002Gf-Bd
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746714163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWXpDiYhh+lIkaQz1iYUyMQYhasMEW0aUGbr7IO3Np8=;
 b=LBzo2rSky6UeCMrNtJjyNCMO6SWXB2NRS15UC6S221LjWvGA9YKvygrF7a9uS1x1Xip89a
 rTC48H8rJf7xeVxLPm4TlOAQ+mMP4CtuiJHLuLRWzl8zo1J81V/nGYq1hpLlyVlWoVIxY8
 dx5Cd9KUlftYRlqFvnQ+3esnb5L6hGE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-6Fp3iZA_PymSfkmY72y2JQ-1; Thu,
 08 May 2025 10:22:39 -0400
X-MC-Unique: 6Fp3iZA_PymSfkmY72y2JQ-1
X-Mimecast-MFC-AGG-ID: 6Fp3iZA_PymSfkmY72y2JQ_1746714158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CE971955D62; Thu,  8 May 2025 14:22:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.129])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A489018003FC; Thu,  8 May 2025 14:22:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Farhan Ali <alifm@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PULL 1/3] util: Add functions for s390x mmio read/write
Date: Thu,  8 May 2025 10:22:32 -0400
Message-ID: <20250508142234.44974-2-stefanha@redhat.com>
In-Reply-To: <20250508142234.44974-1-stefanha@redhat.com>
References: <20250508142234.44974-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Farhan Ali <alifm@linux.ibm.com>

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
Acked-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250430185012.2303-2-alifm@linux.ibm.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/s390x_pci_mmio.h |  24 ++++++
 util/s390x_pci_mmio.c         | 146 ++++++++++++++++++++++++++++++++++
 util/meson.build              |   2 +
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
-- 
2.49.0


