Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1859CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD29J-00055D-Mf; Thu, 08 May 2025 10:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD29E-0004sJ-JT
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD298-0002GY-EE
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746714163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGJm6jPYLXz5Gut3ETODzxTwVGF3ZoA9TR9XjHv6WuQ=;
 b=Ljxpjq4NivatmjnXDK2oXJcfDPLoflVEuxpg8DR0t5bm/95XozFkLYGsh5KKO+rePx706d
 DO2GdLjhHrI+OR9cS24fP7shMG3wTa9eEvK/R0gfwCQWjNLch9B8g4rUMotKUINQZl/tYm
 t8zippjcY353/cG0CwEiPGmx0K/RqkA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-mE-jhDPqPbCnyo0y0FM3yA-1; Thu,
 08 May 2025 10:22:42 -0400
X-MC-Unique: mE-jhDPqPbCnyo0y0FM3yA-1
X-Mimecast-MFC-AGG-ID: mE-jhDPqPbCnyo0y0FM3yA_1746714161
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE0B19560AF; Thu,  8 May 2025 14:22:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.129])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3C6B18004A7; Thu,  8 May 2025 14:22:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Farhan Ali <alifm@linux.ibm.com>
Subject: [PULL 2/3] include: Add a header to define host PCI MMIO functions
Date: Thu,  8 May 2025 10:22:33 -0400
Message-ID: <20250508142234.44974-3-stefanha@redhat.com>
In-Reply-To: <20250508142234.44974-1-stefanha@redhat.com>
References: <20250508142234.44974-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Farhan Ali <alifm@linux.ibm.com>

Add a generic API for host PCI MMIO reads/writes
(e.g. Linux VFIO BAR accesses). The functions access
little endian memory and returns the result in
host cpu endianness.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250430185012.2303-3-alifm@linux.ibm.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/host-pci-mmio.h | 136 +++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 include/qemu/host-pci-mmio.h

diff --git a/include/qemu/host-pci-mmio.h b/include/qemu/host-pci-mmio.h
new file mode 100644
index 0000000000..a8ed9938ac
--- /dev/null
+++ b/include/qemu/host-pci-mmio.h
@@ -0,0 +1,136 @@
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
+    ret = ldl_le_p(ioaddr);
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
+static inline void host_pci_stb_p(void *ioaddr, uint8_t val)
+{
+#ifdef __s390x__
+    s390x_pci_mmio_write_8(ioaddr, val);
+#else
+    stb_p(ioaddr, val);
+#endif
+}
+
+static inline void host_pci_stw_le_p(void *ioaddr, uint16_t val)
+{
+#ifdef __s390x__
+    s390x_pci_mmio_write_16(ioaddr, cpu_to_le16(val));
+#else
+    stw_le_p(ioaddr, val);
+#endif
+}
+
+static inline void host_pci_stl_le_p(void *ioaddr, uint32_t val)
+{
+#ifdef __s390x__
+    s390x_pci_mmio_write_32(ioaddr, cpu_to_le32(val));
+#else
+    stl_le_p(ioaddr, val);
+#endif
+}
+
+static inline void host_pci_stq_le_p(void *ioaddr, uint64_t val)
+{
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
+        host_pci_stb_p(ioaddr, v);
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
2.49.0


